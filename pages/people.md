---
layout              : page-extrawide
permalink           : "/people/"
---

<style>
    .peoplewrapper {
        display: grid;
        grid-template-columns: 1fr 2fr;
        align-items: center;
        grid-gap: 1em;
        row-gap: 1em;
        padding-bottom: 1em;
    }
    .peoplephoto {
        float:right;
        marginleft:auto;
        padding-left:1em;
    }

    /* Photo Gallery Styles */
    .photo-gallery {
        margin-top: 2rem;
    }

    .photo-gallery h3 {
        margin-top: 2rem;
        margin-bottom: 1rem;
        color: #333;
        border-bottom: 2px solid #eee;
        padding-bottom: 0.5rem;
    }

    .photo-item.featured {
        margin-bottom: 2rem;
    }

    .photo-item.featured img {
        width: 100%;
        height: auto;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }

    .photo-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 1rem;
        margin-bottom: 2rem;
    }

    .photo-item img {
        width: 100%;
        height: 200px;
        object-fit: cover;
        border-radius: 6px;
        transition: transform 0.2s ease;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }

    .photo-item img:hover {
        transform: scale(1.02);
        box-shadow: 0 4px 12px rgba(0,0,0,0.2);
    }

    /* Two-column wide photos */
    .photo-item.photo-wide {
        grid-column: span 2;
    }

    .photo-item.photo-wide img {
        height: 250px;
    }

    /* Mobile responsive */
    @media (max-width: 600px) {
        .photo-grid {
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 0.5rem;
        }

        .photo-item img {
            height: 150px;
        }
    }
</style>

<div class="row"> <!-- This should contain everything on this page content: both people and fun photos-->
    <div class="columns small-12 medium-12 large-6"> <!-- Column to contain all people content -->
        <div class="row">
            <div class="columns small-12">
                <h1>PEOPLE</h1>
            </div>
        </div>
        <div class="row align-middle">
            <div class="peoplewrapper">
                <div><img class="peoplephoto" src="{{ site.urlimg }}photojun.jpg" width="192"></div>
                <div><b>Jun Allard</b><br>
                Professor, 
                Department of Mathematics, 
                Department of Physics and Astronomy<br>
                <a href="{{ site.urlfiles }}allard-cv_2024.pdf">Curriculum Vitae</a></div>
            </div>
            <div class="peoplewrapper">
                <div><img class="peoplephoto" src="{{ site.urlimg }}brady_192px.jpg" width="192"></div>
                <div><b>Brady Berg</b><br>
                MSCB PhD student</div>
            </div>
            <div class="peoplewrapper">
                <div><img class="peoplephoto" src="{{ site.urlimg }}Afavicon-192x192.png" width="192"></div>
                <div><b>Katie Bogue</b><br>
                Research scientist<br>
                co-advised with <a href="https://quinlanlab.wordpress.com/">Margot Quinlan</a><br></div>
            </div>
            <div class="peoplewrapper">
                <div><img class="peoplephoto" src="{{ site.urlimg }}jack_image0_192px.jpeg" width="192"></div>
                <div><b>Jack Corrette</b><br>
                MSCB PhD student</div>
            </div>
            <div class="peoplewrapper">
                <div><img class="peoplephoto" src="{{ site.urlimg }}austin_192px.jpg" width="192"></div>
                <div><b>Austin Marcus</b><br>
                MSCB PhD student<br>
                co-advised with <a href="https://www.math.uci.edu/~cemiles/">Chris Miles</a><br></div>
            </div>
            <!-- <div class="peoplewrapper">
                <div><img class="peoplephoto" src="{{ site.urlimg }}Afavicon-192x192.png" width="192"></div>
                <div><b>Ke Xu</b><br>
                UCI Physics/CS undergraduate</div>
            </div> -->
        </div> <!-- Done row with current people -->
        <div class="row"> <!-- past members section -->
            <div class="columns small-12">
                <h1>PAST MEMBERS</h1>
            </div>
        </div>
        <div class="row align-middle"> <!-- Row with all past people -->
            <div class="peoplewrapper">
                <div><img class="peoplephoto" src="{{ site.urlimg }}SohyeonPark_192px.jpeg" width="192"></div>
                <div><b>Sohyeon Park</b><br>
                PhD in MCSB 2024<br>
                co-advised with <a href="https://xyushi.wixsite.com/xshi">Xaoyu Shi</a><br>
                <a href="https://sites.google.com/uci.edu/sohyeonpark/about-me">website</a>
                Subsequent position: <a href="https://www.signalingsystems.ucla.edu/">Hoffman Lab, UCLA</a></div>
            </div>
            <div class="peoplewrapper">
                <div><img class="peoplephoto" src="{{ site.urlimg }}Afavicon-192x192.png" width="192"></div>
                <div><b>Jonathan Rodriguez</b><br>
                PhD in MCSB, 2024<br>
                Primary advisor <a href="https://ccbs.uci.edu/team/john-lowengrub/">John Lowengrub</a></div>
            </div>
            <div class="peoplewrapper">
                <div><img class="peoplephoto" src="{{ site.urlimg }}Afavicon-192x192.png" width="192"></div>
                <div><b>Rob Taylor</b><br>
                PhD in Physics<br>
                co-advised with <a href="https://readlab.eng.uci.edu/">Elizabeth Read</a><br>
                Subsequent position: Merck</div>
            </div>
            <div class="peoplewrapper">
                <div><img class="peoplephoto" src="{{ site.urlimg }}Afavicon-192x192.png" width="192"></div>
                <div><b>Trini Nguyen</b><br>
                MSCB PhD student</div>
            </div>
            <div class="peoplewrapper">
                <div><img class="peoplephoto" src="{{ site.urlimg }}Afavicon-192x192.png" width="192"></div>
                <div><b>Matt Bovyn</b>, PhD 2021<br>
                Subsequent position: Max Planck Institute for Cell Biology and Genetics</div>
            </div>
            <div class="peoplewrapper">
                <div><img class="peoplephoto" src="{{ site.urlimg }}Afavicon-192x192.png" width="192"></div>
                <div><b>Lara Clemens</b>, PhD 2020<br>
                Subsequent position: Quantitative Systems Pharmacology at Simulations Plus</div>
            </div>
            <div class="peoplewrapper">
                <div><img class="peoplephoto" src="{{ site.urlimg }}Afavicon-192x192.png" width="192"></div>
                <div><b>Kathryn Manakova,</b> PhD 2017</div>
            </div>
            <div class="peoplewrapper">
                <div><img class="peoplephoto" src="{{ site.urlimg }}Afavicon-192x192.png" width="192"></div>
                <div><b>Derek Bryant</b>, PhD 2016</div>
            </div>
            <div> <!-- OTHER PAST -->
                <ul style="padding-left: 1rem">
                    <li>Post-doctoral researchers
                    <ul>
                        <li>Kai Liu (joint with John Lowengrub)</li>
                    </ul>
                    </li>
                    <li>Rotation students
                    <ul>
                        <li>Maryam Amran, MCBU</li>
                        <li>Jihye Choi, MCBU</li>
                        <li>Natalie Congdon, MCBU</li>
                        <li>Joanna Fan, MathExplr</li>
                        <li>Claire Goul</li>
                        <li>Nayeon Kim, MCBU</li>
                        <li>Mary Jane O'Neill, MCBU</li>
                        <li>Rochelle Radzyminski, MCBU</li>
                        <li>Daniel Ramirez, MCSB</li>
                        <li>Patrick Webb, Math undergrad researcher/MCBU</li>
                        <li>Jie (Nicole) Zhang, MCBU</li>
                        <li>Katie Lynch, MathBioU</li>
                        <li>Poorvi Rao, MathBioU</li>
                        <li>Lorenzo Alesiani, MathBioU</li>
                        <li>Ke Xu, UCI Physics undergrad</li>
                        <li>Shannon McFadden, MathExplr</li>
                        <li>Emily Liu, MathExplr</li>
                        <li>Aidan Zhang, MathExplr</li>
                        <li>Evan Park, MathExplr</li>
                    </ul>
                    </li>
                </ul>
                <hr>
            </div>
        </div> <!-- Done row with all past people -->
    </div> <!-- Done column that contains all people content-->
    <!-- Photos Gallery Section -->
    <div class="columns small-12 medium-12 large-6">
        <!-- <h1>LAB PHOTOS</h1> -->

        <!-- Photo Grid Container -->
        <div class="photo-gallery">
            <!-- Featured/Hero Photos (larger) -->
            <div class="photo-item featured">
                <img src="{{ site.urlimg }}allardlab_and_friends2024.jpg" alt="Allard Lab and Friends 2024">
            </div>

            <!-- Recent Photos Grid -->
            <h3>2024</h3>
            <div class="photo-grid">
                <div class="photo-item   photo-wide">
                    <img src="{{ site.urlimg }}PXL_20241217_034619594.jpg" alt="Lab Photo Dec 2024">
                </div>
                <div class="photo-item">
                    <img src="{{ site.urlimg }}PXL_20241217_192739990~2.jpg" alt="Lab Photo Dec 2024">
                </div>
                <div class="photo-item">
                    <img src="{{ site.urlimg }}PXL_20241217_192946754.PORTRAIT~2.jpg" alt="Lab Photo Dec 2024">
                </div>
                <div class="photo-item">
                    <img src="{{ site.urlimg }}PXL_20241218_060911193.NIGHT~2.jpg" alt="Lab Photo Dec 2024">
                </div>
                <div class="photo-item">
                    <img src="{{ site.urlimg }}PXL_20240723_020232726.jpg" alt="Lab Photo Jul 2024">
                </div>
            </div>

            <h3>2023</h3>
            <div class="photo-grid">
                <div class="photo-item photo-wide">
                    <img src="{{ site.urlimg }}PXL_20231118_212151696.jpg" alt="Lab Photo 2023">
                </div>
            </div>

            <h3>2022</h3>
            <div class="photo-grid">
                <div class="photo-item  photo-wide">
                    <img src="{{ site.urlimg }}PXL_20221212_171623459.jpg" alt="Lab Photo Dec 2022">
                </div>
                <div class="photo-item  photo-wide">
                    <img src="{{ site.urlimg }}PXL_20221212_180556588.jpg" alt="Lab Photo Dec 2022">
                </div>
                <div class="photo-item">
                    <img src="{{ site.urlimg }}PXL_20221212_195546518.jpg" alt="Lab Photo Dec 2022">
                </div>
                <div class="photo-item">
                    <img src="{{ site.urlimg }}PXL_20221213_002818574~2.jpg" alt="Lab Photo Dec 2022">
                </div>
                <div class="photo-item">
                    <img src="{{ site.urlimg }}PXL_20220220_232140407.jpg" alt="Lab Photo Feb 2022">
                </div>
                <div class="photo-item">
                    <img src="{{ site.urlimg }}PXL_20220220_184131302.PORTRAIT.jpg" alt="Lab Photo Feb 2022">
                </div>
                <div class="photo-item">
                    <img src="{{ site.urlimg }}PXL_20220223_052932459.NIGHT.jpg" alt="Lab Photo Feb 2022">
                </div>
                <div class="photo-item">
                    <img src="{{ site.urlimg }}PXL_20220223_022415323.NIGHT_2.jpg" alt="Lab Photo Feb 2022">
                </div>
            </div>

            <h3>2019</h3>
            <div class="photo-grid">
                <div class="photo-item photo-wide">
                    <img src="{{ site.urlimg }}group19su.jpg" alt="Group Photo Summer 2019">
                </div>
                <div class="photo-item">
                    <img src="{{ site.urlimg }}group19f.jpg" alt="Group Photo Fall 2019">
                </div>
                <div class="photo-item">
                    <img src="{{ site.urlimg }}matt2019.jpg" alt="Matt 2019">
                </div>
                <div class="photo-item   photo-wide">
                    <img src="{{ site.urlimg }}img_20191126_114741.jpg" alt="Lab Photo Nov 2019">
                </div>

                <div class="photo-item">
                    <img src="{{ site.urlimg }}sohyeon2019.jpg" alt="Sohyeon 2019">
                </div>
                <div class="photo-item">
                    <img src="{{ site.urlimg }}IMG_4706.jpg" alt="Lab Photo 2019">
                </div>
            </div>

            <h3>Earlier Years</h3>
            <div class="photo-grid">
                <div class="photo-item">
                    <img src="{{ site.urlimg }}20180330allardgroupphoto.jpeg" alt="Group Photo 2018">
                </div>
                <div class="photo-item">
                    <img src="{{ site.urlimg }}39273544_10156593333079694_8710688989096443904_n.jpg" alt="Lab Photo 2018">
                </div>
                <div class="photo-item">
                    <img src="{{ site.urlimg }}img_20170422_153511.jpg" alt="Lab Photo 2017">
                </div>
                <div class="photo-item">
                    <img src="{{ site.urlimg }}img_0064.jpg" alt="Lab Photo 2016">
                </div>
                <div class="photo-item photo-wide">
                    <img src="{{ site.urlimg }}allardlab2015largecropped512.jpeg" alt="Allard Lab 2015">
                </div>
            </div>
        </div>
    </div>

</div>


