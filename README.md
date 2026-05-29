# Parametric Smart Switch Wall Plates

A collection of parametric 3D-printable wall plates and brackets designed in OpenSCAD to integrate smart home controllers (like the Philips Hue Tap Dial) with standard North American light switches (Decora, Lutron Aurora, etc.).

These models solve the common problem of mounting smart switch controllers directly over existing electrical boxes, or combining smart buttons with traditional switches in a clean, unified multi-gang faceplate. 

These models allow smart switches to be mounted directly over existing faceplates without removing them for an easy, renter-friendly solution. 
*Note: All plates will require longer standard mounting screws to secure them to the electrical box.*

**Lutron Aurora Bracket:** Securing the Lutron Aurora bracket requires an **M3 screw** and an **M3 hex nut**.

---

## 🛠️ Files & Designs

### 1. [Universal Multi-Gang Faceplate & Bracket System (Primary File)](file:///Users/brian/.gemini/antigravity-ide/scratch/openscad-designs/Gemini%20parametric%20hue%20lightswitch%20faceplate%20cover.scad)
* **File:** `Gemini parametric hue lightswitch faceplate cover.scad`
* **Description:** This is the primary file. It is a highly flexible, customizer-ready parametric model supporting combinations of up to 6 gangs.
* **How to use:** 
  1. Open the file in OpenSCAD.
  2. Open the **Customizer** pane (`Window` -> `Customizer`).
  3. Use the dropdowns to select the type of insert for each gang (e.g., `Tap_Dial`, `Decora`, `Lutron`, `Blank`, `None`).
  4. Adjust parameters like the number of gangs and cavity depth.
  5. Render and export your custom STL!
* **Supported Inserts:**
  * **Philips Hue Tap Dial:** Cutout with a precise rear recess and alignment pegs for the standard metal mounting plate.
  * **Decora:** Standard rectangular cutout for Decora-style switches or smart dimmers.
  * **Lutron Aurora/Switch Bracket:** Cutout that fits custom brackets.
  * **Blank:** Fills the gang space completely.
* **Custom Bracket:** Use the `part_to_print` dropdown in the Customizer to switch between printing the `Faceplate` or the `Lutron_Bracket`.

### 2. [Custom Asymmetric 3-Gang Decora/Decora/TapDial](file:///Users/brian/.gemini/antigravity-ide/scratch/openscad-designs/custom%20asymmetric%203gang%20decora-decora-tapdial.scad)
* **File:** `custom asymmetric 3gang decora-decora-tapdial.scad`
* **Description:** A specialized 3-gang faceplate layout: `[Tap Dial (Shifted Left)] - [Decora] - [Decora]`. 
* **Key Feature:** This model was specifically designed to be extra wide to accommodate the Decora switches next to the Tap Dial. The Tap Dial position is shifted horizontally by a customizable distance (`tap_dial_shift` mm) to clear adjacent trim or provide extra hand room, with the faceplate body dynamically expanding to cover the gap.

---

## 🖨️ 3D Printing Recommendations

* **Orientation:** Print face-down on a textured print bed. This yields a premium finish for the front face.
* **Supports:** **Not needed.** Due to the face-down printing orientation, supports are not needed.
* **Material:** These models have been successfully printed using **PLA Tough+**, but other materials (like standard PLA, PETG, or ASA) may also work well depending on your environment.
