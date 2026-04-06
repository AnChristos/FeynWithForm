import numpy as np

def kinematics2To2(sqrt_s, theta, m1=0, m2=0, m3=0, m4=0):
    """
    Calculates s, t, u and the phase space ratio pf/pi 
    for a general 2 -> 2 process in the CM frame.
    """
    s = sqrt_s**2

    # Källen lambda function (already vectorized by standard math ops)
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

