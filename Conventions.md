# Conventions for Amplitude Calculations

This document outlines the symbolic notation and computational logic used in FORM scripts.
---

## References 

* **FORM**: J.A.M. Vermaseren, *"New features of FORM"* (math-ph/0010025)
* **Textbook**: *Diagrammatica: The Path to Feynman Diagrams* by Martinus Veltman
* The symbolic manipulation in this project is handled by the `squareamplitude` procedure. Mondified the original by Jos Vermaseren (NIKHEF)

---

## Gamma Matrix and Identity Notation

The procedure uses a custom commuting function `g` to represent Dirac matrices with explicit spinor indices. 

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

Spinors are treated as commuting functions (CF) with the convention:

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
fprop(i1, i2, p, m)
```

Implementation:

```
(g(i1, i2, p) + g(i1, i2) * m) * prop(p.p - m^2)
```

### Photon Propagator

```
phprop(mu1, mu2, q)
```

Implementation:

```
-d_(mu1, mu2) * prop(q.q)
```

---

## Index and Momentum Mapping

To translate a handwritten Feynman rule into a FORM script:

1. **Index Direction**: Write indices in the direction of fermion flow (matrix multiplication order).
2. **Spinor Indices**: Use `i1, i2, i3...` for fermion lines (up to `i40`).
3. **Lorentz Indices**: Use `mu1, mu2, mu3...` for vector indices (up to `mu20`).
4. **Automatic Squaring**:

   ```
   squareamplitude(Amp, Mat)
   ```

   This automatically generates conjugate indices for $M^\dagger$ by shifting indices based on the highest index found.

---

## Trace Evaluation Logic

The procedure evaluates traces by stringing all `g` functions together using a `repeat` block.

### Chain Joining

```
g(i1, i2, ?a) * g(i2, i3, ?b) = g(i1, i3, ?a, ?b)
```

### Identity Absorption

```
g(i1, i2) * g(i2, i3, ?a) = g(i1, i3, ?a)
```

### Loop Closure

If an identity matrix closes a chain:

```
g(i1, i1, ?a)
```

### Identity Trace

```
g(i1, i1) = 4
```

### Final Evaluation

Closed loops are converted to FORM's `g_` symbols and evaluated using:

```
Trace4
```

