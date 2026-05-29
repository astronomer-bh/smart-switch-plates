# Parametric Smart Switch Wall Plates

A collection of parametric 3D-printable wall plates and brackets designed in OpenSCAD to integrate smart home controllers (like the Philips Hue Tap Dial) with standard North American light switches (Decora, Lutron Aurora, etc.).

These models solve the common problem of mounting smart switch controllers directly over existing electrical boxes, or combining smart buttons with traditional switches in a clean, unified multi-gang faceplate.

---

## 🛠️ Files & Designs

### 1. [Universal Multi-Gang Faceplate & Bracket System](file:///Users/brian/.gemini/antigravity-ide/scratch/openscad-designs/Gemini%20parametric%20hue%20lightswitch%20faceplate%20cover.scad)
* **File:** `Gemini parametric hue lightswitch faceplate cover.scad`
* **Description:** A highly flexible, customizer-ready parametric model supporting combinations of up to 6 gangs.
* **Supported Inserts:**
  * **Philips Hue Tap Dial:** Cutout with a precise rear recess and alignment pegs for the standard metal mounting plate.
  * **Decora:** Standard rectangular cutout for Decora-style switches or smart dimmers.
  * **Lutron Aurora/Switch Bracket:** Cutout that fits custom brackets.
  * **Blank:** Fills the gang space completely.
* **Custom Bracket:** Includes a helper module to print the `Lutron_Bracket` adapter for securing brackets.

### 2. [Asymmetric Master Bathroom Plate (3-Gang)](file:///Users/brian/.gemini/antigravity-ide/scratch/openscad-designs/Custom%20master%20bathroom%20tap%20dial%20with%202%20decora.scad)
* **File:** `Custom master bathroom tap dial with 2 decora.scad`
* **Description:** A specialized 3-gang faceplate layout: `[Tap Dial (Shifted Left)] - [Decora] - [Decora]`.
* **Key Feature:** The Tap Dial position is shifted horizontally by a customizable distance (`tap_dial_shift` mm) to clear adjacent trim or provide extra hand room, with the faceplate body dynamically expanding to cover the gap.

### 3. [Parametric Tap Dial Cover (Multi-Gang)](file:///Users/brian/.gemini/antigravity-ide/scratch/openscad-designs/Gemini%20Tapdial%20Parametric.scad)
* **File:** `Gemini Tapdial Parametric.scad`
* **Description:** A parametric wall plate tailored for the Hue Tap Dial with custom corner rounding (`corner_radius`) and premium chamfered edges (`front_chamfer`).
* **Inside Clearance:** Generates a squared-off back cavity to maximize space for clearing existing switch boxes and wiring.

### 4. [Base 2-Gang / 3-Gang Tap Dial Plate](file:///Users/brian/.gemini/antigravity-ide/scratch/openscad-designs/Gemini%202gang.scad)
* **File:** `Gemini 2gang.scad`
* **Description:** An early parametric version designed to generate basic multi-gang plates with centered dial cutouts and screw countersinks for a flush wall fit.

---

## 📐 Key Parameters & Dimensions

When customizing these designs in OpenSCAD's **Customizer** panel, you will find these key parameters:

| Parameter | Default Value | Description |
| :--- | :--- | :--- |
| `number_of_gangs` | `3` | Total width multiplier (standard 46mm spacing per gang). |
| `cavity_depth` | `6mm` | Depth of the hollow backside to clear switches underneath. |
| `dial_cutout_dia` | `60.5mm` | Diameter of the hole for the Hue Tap Dial (includes clearance). |
| `plate_recess_sq` | `66.8mm` | Recess depth and width for flush-mounting the metal bracket. |
| `peg_spacing` | `52.0mm` | Center-to-center spacing of the alignment pegs for the metal plate. |
| `front_chamfer` | `1.5mm` | Smooth sloping edge along the front face of the plate. |

---

## 🖨️ 3D Printing Recommendations

* **Material:** **PETG** or **ASA** is recommended for durability and UV resistance (prevents yellowing over time), but **PLA** works fine for indoor use away from direct sunlight.
* **Layer Height:** `0.2mm` or `0.15mm` for clean chamfers.
* **Orientation:** Print face-down on a textured print bed for a premium, textured finish without needing support material for the front face.
* **Supports:** Build plate supports may be needed for the inner cavity overhangs depending on your printer's bridging capability.
