# HEP-FORM: Particle Physics Derivations

An interactive repository for calculating Feynman amplitudes using **FORM 5.0**.

Click here to browse all interactive examples:
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/AnChristos/FORM_Examples/tree/main/Notebooks/main)

### Specific Examples
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/AnChristos/FORM_Examples/tree/main/Notebooks/main?urlpath=%2Fdoc%2Ftree%2Fee_to_mumu.ipynb)

## Diagrammatica (Veltman) Conventions

1. **Metric:** Euclidean $\delta_{\mu\nu} = (+,+,+,+)$.
2. **Imaginary Energy:** $p_4 = iE$, such that $p^2 = \vec{p}^2 - E^2 = -m^2$.
3. **Mandelstam Variables:** - $s = -(p_1 + p_2)^2$
   - $t = -(p_1 - p_3)^2$
   - $u = -(p_1 - p_4)^2$
4. **Dirac Matrices:** $\{\gamma_\mu, \gamma_\nu\} = 2\delta_{\mu\nu}$.
5. **Propagators:** - Photon: $-d_{\mu\nu}/q^2$
   - Fermion: $(i\cancel{p} + m)/(p^2 + m^2)$

## Structure
- `/notebooks`: Interactive Jupyter environments.
- `/scripts`: Raw FORM 5.0 files generated from notebooks.
- `/docs`: HTML documentation (MathJax enabled).

## How to use
Click the **Launch Binder** button above to open the interactive lab. You can modify the FORM code in the notebook cells and re-run them to see how the trace results change.
