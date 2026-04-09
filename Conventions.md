# Conventions for Amplitude Calculations

This document outlines the symbolic notation and computational logic used in FORM scripts.
---

## References 

* **FORM**: J.A.M. Vermaseren, *"New features of FORM"* (math-ph/0010025)
* The symbolic manipulation in this project is handled by the `squareamplitude` procedure. 
  Original by Jos Vermaseren (NIKHEF)


## Textbooks
* *Quarks & Leptons: An Introductory Course to Modern Particle Physics* by Halzen & Martin
* *Diagrammatica: The Path to Feynman Diagrams* by Martinus Veltman

---

## Gamma Matrix and Identity Notation

See also Traces.ipynb 

| Term                     | FORM Notation        | Mathematical Equivalent    |
| :----------------------- | :------------------- | :------------------------- |
| **Identity Matrix**      | `g(i1, i2)`          | $\delta_{ab}$              |
| **Gamma Matrix**         | `g(i1, i2, mu)`      | $(\gamma^\mu)_{ab}$        |
| **Slash Momentum**       | `g(i1, i2, p1)`      | $(\not{p})_{ab}$           |
| **Gamma 5 ($\gamma^5$)** | `g(i1, i2, k5)`      | $(\gamma^5)_{ab}$          |
| **Closed Trace**         | `g(i1, i1, p1, ...)` | $\text{Tr}(\not{p} \dots)$ |

* **Chirality**: The indices `k5`, `k6`, and `k7` are reserved for special gamma structures.
* `k5` specifically represents $\gamma^5$ and receives a minus sign during the conjugation process.

---

## Spinors and External Lines

Spinors convention:
```
Spinor(index, momentum, mass)
```

* **Adjoint Lepton/Quark ($\bar{u}$)**: `UB(i1, p, m)` → $\bar{u}_a(p, m)$
* **Lepton/Quark ($u$)**: `U(i1, p, m)` → $u_a(p, m)$
* **Anti-Lepton ($v$)**: `V(i1, p, m)` → $v_a(p, m)$
* **Adjoint Anti-Lepton ($\bar{v}$)**: `VB(i1, p, m)` → $\bar{v}_a(p, m)$
* **Vector Polarization ($\epsilon$)**: `eps(mu1, p)` → $\epsilon_\mu(p)$

---

## Propagator Conventions

Propagators include both the numerator structure and the scalar denominator factor.

### Fermion Propagator

```
fprop(i1, i2, p, m) = (g(i1, i2, p) + g(i1, i2) * m) * prop(p.p - m^2)
```

### Photon Propagator

```
phprop(mu1, mu2, q) = -d_(mu1, mu2) * prop(q.q)
```

---

## Index and Momentum Mapping

To translate a handwritten Feynman rule:

1. **Index Direction**: Write indices in the direction of fermion flow (matrix multiplication order).
2. **Spinor Indices**: Use `i1, i2, i3...` for fermion lines (up to `i40`).
3. **Lorentz Indices**: Use `mu1, mu2, mu3...` for vector indices (up to `mu20`).


Then call
   ```
   squareamplitude(Amp, Mat)
   ```
