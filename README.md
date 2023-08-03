<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a name="readme-top"></a>
<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Don't forget to give the project a star!
*** Thanks again! Now go create something AMAZING! :D
-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]



<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/othneildrew/Best-README-Template">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">SPIF-A_v2</h3>

  <p align="center">
  It consists of the development of an incremental stamping machine   
  <br />
    <a href="https://github.com/TatianaResend/SPIFA-e-v2.0"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/TatianaResend/SPIFA-e-v2.0/blob/main/README.md">View Demo</a>
    ·
    <a href="https://github.com/TatianaResend/SPIFA-e-v2.0/issues">Report Bug</a>
    ·
    <a href="https://github.com/TatianaResend/SPIFA-e-v2.0/issues">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#about-the-project">About The Project</a></li>
    <li><a href="#machine-structure-design">Machine structure design</a>
      <ul>
        <li><a href="#base-requirements">Base requirements</a></li>
        <li><a href="#architecture">Architecture</a></li>
        <li><a href="#direct-and-indirect-kinematic-analysis">Direct and indirect kinematic analysis</a></li>
      </ul>
    </li>
    <li><a href="#mechanical-project">Mechanical project</a></li>
    <li><a href="#automation-project">Automation project</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
# About The Project
The project serves as the focal point of the master's thesis in mechanical engineering. The primary goal of this project is to develop a compact incremental forming machine. The machine will be electric, ensuring a silent operation and compact size to facilitate coexistence with 3D printers. To effectively cover all aspects of machine construction, the project has been divided into three key areas: machine structure design, mechanical project, and automation project.

<!-- GETTING STARTED -->
# Machine structure design

## Base requirements:

|  |  |
| --- | --- |
| Number of axels | 3 |
| Working area  | 200 x 200 mm  |
| Vertical stroke  | 100 mm  |
| Sheet thickness  | 0,5 to 3 mm |
| Sheet material   | aluminum |
| Conformation forces | 3 kN (vert.) 1 kN (hor.) |
| Motors           | Nema 34 |



## Architecture:

The study of possible configurations is demonstrated in issues [#1](/../../issues/1) to [#4](/../../issues/4). After the analysis it is concluded that the best configuration is case 1.1.1..
To choose the best configuration, the lowest possible torque was taken into account.

- 2 arms in parallel (delta 2)
- Distance between motors: 50 mm
- L1 = 120;
- L2 = 150;
- y _ work area = -320 mm
- Maximum torque: 665 Nm 

## Direct and indirect kinematic analysis:
The direct and indirect kinematics are represented in the issue [#16](/../../issues/16) and in chapter 3.3 of the [thesis](https://github.com/TatianaResend/SPIF-A_v2/blob/main/Master's%20thesis.pdf) document.
<img src="https://github.com/TatianaResend/SPIF-A_v2/assets/101273005/9365f7bd-44d3-4ec3-9fc7-720f329987b6.png" width=30% height=30%>


# Mechanical project
Mechanical projects steps:
- Arm design
- Support system for the forming punch
- Selection and sizing of the motor-reducer set
- Selection and sizing of the linear motor-autorator set
- Structural configuration

<img src="https://github.com/TatianaResend/SPIF-A_v2/assets/101273005/3638eda4-46c4-4937-a888-debe48217e3f" width=20% height=20%>
<img src="https://github.com/TatianaResend/SPIF-A_v2/assets/101273005/d7db7155-1815-445b-a1a0-db607d34304b" width=20% height=20%>
<img src="https://github.com/TatianaResend/SPIF-A_v2/assets/101273005/c62adb34-54c9-4bbd-81ea-67fe2a8f1001" width=19% height=19%>
<img src="https://github.com/TatianaResend/SPIF-A_v2/assets/101273005/c984a72b-4d1d-488c-af39-7cf8f59d6c0e" width=20% height=20%>
<img src="https://github.com/TatianaResend/SPIF-A_v2/assets/101273005/8d5751aa-e6f6-4083-bc22-956f0d9e8603" width=19% height=19%>

### Simulation:
Two types of simulations were carried out using Solidworks: **with motion analysis** and **static** . Both analyzes are described in section 4.6.1 and 4.6.2, respectively, in the [thesis](https://github.com/TatianaResend/SPIF-A_v2/blob/main/Master's%20thesis.pdf) document. Some steps for carrying out the simulations are described in the issue [#5](/../../issues/5).


# Automation project
Automation projects steps:
- Wiring Diagram and Main Components
- Power Circuit
- Controller (**Controllino MEGA**)
- Drive (**CL86T Closed-loop Stepper Drive**)
- Security Elements
- Switchboard
- Motion Control: Implementation of Kinematics, Determination of the Number of Pulses, Incremental Positioning
- Graphic User Interface: Manual Mode, Automatic Mode, Information Page

<p align="center">
  <img src="https://github.com/TatianaResend/SPIF-A_v2/assets/101273005/43c28ed0-4fef-4016-a01a-b9f64436339f" width=60% height=60%>
</p>

All steps of the automation project as well as its implementation are described in chapters 5 and 6.2 of the [thesis](https://github.com/TatianaResend/SPIF-A_v2/blob/main/Master's%20thesis.pdf) document. It is also possible to find some information in the issues [#15](/../../issues/15), [#17](/../../issues/17) - [#20](/../../issues/20), [#22](/../../issues/22) e [#23](/../../issues/23). The developed code can be found [here](https://github.com/TatianaResend/SPIF-A_v2/tree/main/CODE). The controller program was carried out in the **Arduino IDE** platform and the code for the GUI in **MATLAB.**



<!-- CONTRIBUTING -->
# Contributing

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- LICENSE -->
# License

Distributed under the GPL License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTACT -->
# Contact

Tatiana Resende - tatianaresende@ua.pt

Project Link: [SPIF-A_v2](https://github.com/TatianaResend/SPIFA-e-v2.0)

 <!-- <p align="right">(<a href="#readme-top">back to top</a>)</p> -->



<!-- ACKNOWLEDGEMENTS -->
### Acknowledgements
- Professor Ricardo Sousa - rsousa@ua.pt
- Professor Daniel Afonso - dan@ua.pt


<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/TatianaResend/SPIF-A_v2.svg?style=for-the-badge
[contributors-url]: https://github.com/TatianaResend/SPIF-A_v2/contributors
[forks-shield]: https://img.shields.io/github/forks/TatianaResend/SPIF-A_v2.svg?style=for-the-badge
[forks-url]: https://github.com/TatianaResend/SPIF-A_v2/network/members
[stars-shield]: https://img.shields.io/github/stars/TatianaResend/SPIF-A_v2.svg?style=for-the-badge
[stars-url]: https://github.com/TatianaResend/SPIF-A_v2/stargazers
[issues-shield]: https://img.shields.io/github/issues/TatianaResend/SPIF-A_v2.svg?style=for-the-badge
[issues-url]: https://github.com/TatianaResend/SPIF-A_v2/issues
[license-shield]: https://img.shields.io/github/license/TatianaResend/SPIF-A_v2.svg?style=for-the-badge
[license-url]: https://github.com/TatianaResend/SPIF-A_v2/blob/master/LICENSE.txt
