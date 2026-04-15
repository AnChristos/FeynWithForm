import numpy as np
import sympy as sp


def XS_2To2_CM(Msq, s, t, u, theta, m1, m2, m3, m4):
    """
    Converts a Matrix Element (Msq) into
    a differential cross-section dSigma/dOmega
    in the Center-of-Mass frame.
    Parameters:
    Msq     : SymPy expression (contains s, t, u)
    s,t,u, theta  : SumPy symbols
    m1, m2 : Masses of incoming particles
    m3, m4 : Masses of outgoing particles
    """
    # These must match the names used in FORM output
    t_sym = sp.Symbol("t")
    u_sym = sp.Symbol("u")

    # Källén lambda function
    # la(a, b, c) = a^2 + b^2 + c^2 - 2ab - 2bc - 2ca
    def la(a, b, c):
        return a**2 + b**2 + c**2 - 2 * a * b - 2 * b * c - 2 * c * a

    pi_mag = sp.sqrt(la(s, m1**2, m2**2)) / (2 * sp.sqrt(s))
    pf_mag = sp.sqrt(la(s, m3**2, m4**2)) / (2 * sp.sqrt(s))

    E1 = (s + m1**2 - m2**2) / (2 * sp.sqrt(s))
    E3 = (s + m3**2 - m4**2) / (2 * sp.sqrt(s))

    t_phys = m1**2 + m3**2 - 2 * E1 * E3 + 2 * pi_mag * pf_mag * sp.cos(theta)
    u_phys = (
        m1**2 + m4**2 - 2 * E1 * (sp.sqrt(s) - E3) - 2 * pi_mag * pf_mag * sp.cos(theta)
    )
    ps_factor = (1 / (64 * sp.pi**2 * s)) * (pf_mag / pi_mag)

    Msq = Msq.subs(
        {
            t: t_phys,
            u: u_phys,
        }
    )
    return sp.simplify(ps_factor * Msq)


def dGamma_dOmega(Msq, M, m2, m3):
    """
    Converts a Matrix Element (Msq) into
    a differential decay rate dSigma/dOmega
    in the Center-of-Mass frame.
    Parameters:
    Msq    : SymPy expression
    M  : SumPy symbol for decaying particle
    m2, m3 : SumPy symbols  Masses of products
    """
    la = M**4 + m2**4 + m3**4 - 2 * (M**2 * m2**2 + m2**2 * m3**2 + m3**2 * M**2)
    pf_mag = sp.sqrt(la) / (2 * M)
    dps_factor = pf_mag / (32 * sp.pi**2 * M**2)
    return sp.simplify(dps_factor * Msq)


def XS_Compton_Lab(Msq, s, t, u, theta, E1, me):
    """
    Specific Lab frame cross-section for Compton (m_photon = 0).
    E1 : Incoming photon energy (scalar or symbol)
    me : Electron mass (scalar or symbol)
    """
    E3 = sp.Symbol("E3", positive=True)

    # Lab frame Mandelstam
    s_phys = me**2 + 2 * me * E1
    t_phys = -2 * me * (E1 - E3)
    u_phys = 2 * me**2 - s_phys - t_phys

    # Phase Space Lab Frame
    ps_factor_const = 1 / (64 * sp.pi**2 * me**2)
    # Intermediate Simplification
    Msq_sub = Msq.subs({s: s_phys, t: t_phys, u: u_phys})
    core = sp.simplify(Msq_sub * ps_factor_const)
    intermediate = core * (E3 / E1) ** 2

    E3_phys = E1 / (1 + (E1 / me) * (1 - sp.cos(theta)))
    result = sp.simplify(intermediate.subs(E3, E3_phys))

    return result
