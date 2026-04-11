import numpy as np
import sympy as sp

def kinematics2To2(sqrt_s, theta, m1=0, m2=0, m3=0, m4=0):
    """
    Calculates s, t, u and the phase space ratio pf/pi 
    for a  2 -> 2 process in the CM frame.
    """
    s = sqrt_s**2

    # Källen lambda function
    def la(a, b, c): 
        return a**2 + b**2 + c**2 - 2*a*b - 2*b*c - 2*c*a

     # Magnitudes of 3-momenta
    pi_mag = np.where(sqrt_s > 0, np.sqrt(np.maximum(0, la(s, m1**2, m2**2))) / (2 * sqrt_s), 0)
    pf_mag = np.where(sqrt_s > 0, np.sqrt(np.maximum(0, la(s, m3**2, m4**2))) / (2 * sqrt_s), 0)

    # Energies in CM
    E1 = np.where(sqrt_s > 0, (s + m1**2 - m2**2) / (2 * sqrt_s), 0)
    E3 = np.where(sqrt_s > 0, (s + m3**2 - m4**2) / (2 * sqrt_s), 0)

    # Mandelstam variables
    t = m1**2 + m3**2 - 2*E1*E3 + 2*pi_mag*pf_mag*np.cos(theta)
    u = m1**2 + m4**2 - 2*E1*(sqrt_s - E3) - 2*pi_mag*pf_mag*np.cos(theta)

    ratio = np.where(pi_mag > 0, pf_mag / pi_mag, 0)

    return s, t, u, ratio

def kinematics2To2Lab (E1, theta, m):
    """
    E1,theta: Incoming particle assumed massless
    m : target particle mass 
    """
    E3 = E1 / (1 + (E1 /m) * (1 - np.cos(theta)))
    
    s = m**2 + 2 * m * E1
    t = -2 * E1 * E3 * (1 - np.cos(theta))
    u = 2 * m**2 - s - t
    
    E3E1ratioSq = (E3 / E1)**2
    
    return s, t, u, E3E1ratioSq

def XS_2To2_CM(Msq, s,t,u, theta,  m1, m2, m3, m4):
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
    t_sym = sp.Symbol('t')
    u_sym = sp.Symbol('u')
    
    # 2. Symbolic Källén lambda function
    # la(a, b, c) = a^2 + b^2 + c^2 - 2ab - 2bc - 2ca
    def la(a, b, c): 
        return a**2 + b**2 + c**2 - 2*a*b - 2*b*c - 2*c*a

    # 3. Magnitudes of 3-momenta in CM frame
    # pi = initial state momentum, pf = final state momentum
    pi_mag = sp.sqrt(la(s, m1**2, m2**2)) / (2 * sp.sqrt(s))
    pf_mag = sp.sqrt(la(s, m3**2, m4**2)) / (2 * sp.sqrt(s))

    # 4. Energies of particles 1 and 3
    E1 = (s + m1**2 - m2**2) / (2 * sp.sqrt(s))
    E3 = (s + m3**2 - m4**2) / (2 * sp.sqrt(s))

    t_phys = m1**2 + m3**2 - 2*E1*E3 + 2*pi_mag*pf_mag*sp.cos(theta)
    u_phys = m1**2 + m4**2 - 2*E1*(sp.sqrt(s) - E3) - 2*pi_mag*pf_mag*sp.cos(theta)
    ps_factor = (1 / (64 * sp.pi**2 * s)) * (pf_mag / pi_mag)
    
    Msq = Msq.subs({
        t: t_phys, 
        u: u_phys,})
    return sp.simplify(ps_factor * Msq)


