# Simple Feynman Diagram Calculation Examples

A collection of simple textbook-based examples.

The trace formalism is widely used when teaching courses in particle physics.  
At the same time, like many formalisms, it can become tedious, especially 
when dealing with longer expressions or multiple diagrams.

This project provides a simple workflow that integrates Jupyter notebooks and Python for further processing.  
The algebraic manipulations are handled using **FORM**. 
FORM is open source and can be seen as the modern successor to Schoonschip, one 
of the earliest programs designed for high-energy physics calculations.

## Textbooks

- *Quarks & Leptons: An Introductory Course to Modern Particle Physics* — Halzen & Martin  
- *Diagrammatica: The Path to Feynman Diagrams* — Martinus Veltman  

---

## About FORM

- **FORM**: J.A.M. Vermaseren, *"New features of FORM"* (math-ph/0010025)
- Repository: https://github.com/form-dev/form  
- Releases: https://github.com/form-dev/form/releases  
- Manual: https://form-dev.github.io/form-docs/stable/manual/  

---

## Structure

- `/Notebooks` — Interactive Jupyter Notebook environments that run FORM  
- `/Notebooks/scripts` — `.h` files containing FORM code, along with `.frm` and `.txt` files generated from the notebooks  

---

## Requirements

- **FORM** installed (command `form` must be available)  
- Python  
  - jupyterlab  
  - numpy  
  - matplotlib  
  - sympy

---

## Pipeline Overview

- We aim to run `form` directly from within Jupyter notebooks  
- Assume a notebook `name.ipynb`:

  1. Import utilities in the first cell  
  2. Start the second cell with:
     ```python
     %%pyForm name
     ```
  3. Write the FORM code in that cell  
  4. On execution:
     - A file `scripts/name.frm` is generated  
     - The FORM script is executed  
     - Output is written using Format C in `.txt` files.  
  5. Python then parses the output file for further manipulation  

---

## Conventions for Amplitude Calculations

### Gamma Matrix Notation
| Term                       | Internal Notation                    | Mathematical Equivalent                          |
| :------------------------- | :------------------------------- | :----------------------------------------------- |
| **Unit Matrix**            | `gamma(i1, i2)`                                               | $(I)^{i_1}{}_{i_2}$ |
| **Gamma Matrix**           | `gamma(i1, i2, mu)`                                  | $(\gamma^\mu)^{i_1}{}_{i_2}$ |
| **Slash Momentum**         | `gamma(i1, i2, p_i)`                              | $(\slashed{p}_i)^{i_1}{}_{i_2}$ |
| **Gamma 5 ($\gamma^5$)**   | `gamma(i1, i2, k5)`                                    | $(\gamma^5)^{i_1}{}_{i_2}$ |
| **Left-Handed Projector**  | `1/2 * gamma(i1, i2, k7)`     | $\left(\frac{1 - \gamma^5}{2}\right)^{i_1}{}_{i_2}$ |
| **Right-Handed Projector** | `1/2 * gamma(i1, i2, k6)`            | $\left(\frac{1 + \gamma^5}{2}\right)^{i_1}{}_{i_2}$ |
| **V−A Coupling**           | `1/2 * ((cv+ca)*g(i1,i2,k7) + (cv-ca)*g(i1,i2,k6))` | $(c_V - c_A \gamma^5)^{i_1}{}_{i_2}$ |

### External Lines

- **Outgoing fermion ($\bar{u}$)**: `UB(i1, p1, m)` → $\bar{u}_a(p_1, m)$  
- **Incoming fermion ($u$)**: `U(i1, p1, m)` → $u_a(p_1, m)$  
- **Outgoing anti-fermion ($v$)**: `V(i1, p1, m)` → $v_a(p_1, m)$  
- **Incoming anti-fermion ($\bar{v}$)**: `VB(i1, p1, m)` → $\bar{v}_a(p_1, m)$  
- **Massless Vector polarization ($\epsilon$)**: `esum(mu1, p1)` → $\epsilon_\mu(p_1)$  
- **Massive Vector polarization ($\epsilon$)**: `esumM(mu1, p1 , m)` → $\epsilon_\mu(p_1, m)$  



### Polarization sums
```
U(i1?,p?,m?) * UB(i2?,p?,m?) =  gamma(i1,i2,p) + gamma(i1,i2)*m;
```

```
V(i1?,p?,m?) * VB(i2?,p?,m?) =  gamma(i1,i2,p) - gamma(i1,i2)*m;
```

```
esum(mu1?,p?) * esum(mu2?,p?) = -d_(mu1,mu2);
```

```
esumM(mu1?, p?, m?) * esumM(mu2?, p?, m?) = -d_(mu1,mu2) + p(mu1)*p(mu2)/(m^2);

```
### Propagators

```
fprop(i1?,i2?,p?,m?) = (g(i1,i2,p) +  g(i1,i2)*m)  * prop(p.p - m^2)
```

```
phprop(mu1?,mu2?,q?) = -d_(mu1,mu2) * prop(q.q);
```

```
Zprop(mu1?,mu2?,q?,m?) = (-d_(mu1,mu2) + q(mu1) * q(mu2)/(m^2)) * prop(q.q - m^2);
```

```
Wprop(mu1?,mu2?,q?,m?) = (-d_(mu1,mu2) + q(mu1) * q(mu2)/(m^2)) * prop(q.q - m^2);
```

The `prop` function is kept symbolic in intermediate expressions  
It must be resolved using kinematics and momentum conservation.  

For example:
```
* Momentum conservation
id q = p1 + p2;
.sort

* Propagator handling
id prop(x?) = (x)^-1;
.sort

id (q.q)^-1 = (s)^-1;
id (-mZ^2 + q.q)^-1 = (s - mZ^2)^-1;
.sort
```


### Index and Momentum Mapping

To translate a handwritten Feynman rule:

1. **Index direction**: Follow fermion flow (matrix multiplication order)  
2. **Spinor indices**: `i1, i2, i3, ...` (up to `i40`)  
3. **Lorentz indices**: `mu1, mu2, mu3, ...` (up to `mu20`)  


### Squared Amplitudes

After defining the amplitude:

```
squareamplitude(Amp, Mat)
```

### Kinematics 

All calculations are performed using the Minkowski metric  

$g^{\mu\nu} = \mathrm{diag}(1, -1, -1, -1)$

**On-shell condition:** 

$p_i^2 = m_i^2$

**Mandelstam variables:**  
  
  $s = (p_1 + p_2)^2$,  
  
  $t = (p_1 - p_3)^2$,  
  
  $u = (p_1 - p_4)^2$

---