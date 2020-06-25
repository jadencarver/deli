<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:param name="time" select="current-time()" />
  <xsl:template match="/menus">
    <html>
      <head>
        <title>ALI 2023 DELI GROCERY - BREAKFAST</title>
        <meta http-equiv="refresh" content="30" />
        <style>
          html, body, svg {
            width: 100%; height: 100%; position: relative;
            margin: 0; padding: 0;
            font-family: "Futura", Helvetica, sans-serif;
            font-size: 25pt;
          }
          svg text {
            text-shadow: 2pt 2pt #000;
            fill: white;
          }
          svg text.h1 {
            font-family: "Gill Sans", Helvetica, sans-serif;
            font-size: 2em;
            font-weight: 200;
          }
          svg image.fade {
            opacity: 0;
            transform-origin: top left;
            transform: scale(2.5) translate(0, -100%) rotate(90deg);
            transition: transform-origin 1s ease-in, opacity 1s ease-in, transform 1s ease-in-out;
          }
          svg image.fade:last-child {
            transition: opacity 1s ease-in;
          }
          svg image.fade.in {
            transform-origin: center center;
            transform: scale(1) translate(0, 0) rotate(0deg);
            opacity: 1;
          }
          svg g.menu {
            opacity: 0;
            transition: opacity 3s;
          }
          svg g.menu.foreskin {
            opacity: 1;
          }
        </style>
        <script>
          (function() {
            var i = 1;
            function transitionFn() {
              var foreskin = document.querySelectorAll("svg g.active.foreskin");
              for(var j=0; j &lt; foreskin.length; j++) {
                foreskin[j].classList.remove("foreskin");
              };
              var images = document.querySelectorAll("svg g.active image.fade");
              function activate(image) {
                image.classList.add("in");
                image.closest("g.active").classList.add("foreskin");
              }
              if (i &lt; images.length) {
                activate(images[i]); i++;
              } else {
                images.forEach(function(e,i) { if (i>0) { e.classList.remove("in"); }});
                i = 1;
                activate(images[i]);
              }
            };
            window.addEventListener('DOMContentLoaded', function() {
              transitionFn();
              setInterval(transitionFn, 5000);
            });
          }())
        </script>
      </head>
      <body>
        <svg viewbox="0 0 960 600">
          <defs>
            <!--
              <mask id="mask-breakfast">
              <path d="M 0 0 C 900 50 900 50 950 700 L 0 700 Z" fill="white" stroke="white" stroke-width="200" stroke-dasharray="4 4"></path>
              </mask>
            -->
            <!--
              <filter id="filter-breakfast" x="0" y="0">
              <feGaussianBlur in="SourceGraphic" stdDeviation="1" />
              </filter>
            -->
            <!--
              <mask id="mask-lunch">
              <path d="M 0 0 C 900 50 900 50 950 700 L 0 700 Z" fill="white" stroke="white" stroke-width="200" stroke-dasharray="4 4"></path>
              </mask>
            -->
            <linearGradient id="fill-beverage" x1="0%" y1="0%" x2="100%" y2="100%">
              <stop offset="25%" style="stop-color:rgba(0,0,0,0.3)" />
              <stop offset="50%" style="stop-color:rgba(0,0,0,0)" />
              <stop offset="90%" style="stop-color:rgba(0,0,0,1.0)" />
            </linearGradient>
            <linearGradient id="fill-breakfast" x1="0%" y1="0%" x2="100%" y2="100%">
              <stop offset="25%" style="stop-color:rgba(255,255,255,0.3)" />
              <stop offset="50%" style="stop-color:rgba(0,0,0,0)" />
              <stop offset="90%" style="stop-color:rgba(0,0,0,1.0)" />
            </linearGradient>
            <linearGradient id="fill-halal" x1="0%" y1="0%" x2="100%" y2="100%">
              <stop offset="25%" style="stop-color:rgba(0,0,0,0.3)" />
              <stop offset="50%" style="stop-color:rgba(0,0,0,0)" />
              <stop offset="90%" style="stop-color:rgba(0,0,0,0.7)" />
            </linearGradient>

          </defs>

          <xsl:apply-templates />

        </svg>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="/menus/menu">
    <g class="menu">
      <xsl:attribute name="id">menu-<xsl:value-of select="@meal" /></xsl:attribute>
      <xsl:if test="not(@disabled) and $time &gt;= @start and $time &lt; @end">
        <xsl:attribute name="class">menu active</xsl:attribute>
      </xsl:if>
      <g><xsl:apply-templates select="image" /></g>

      <rect x="0" y="0" width="100%" height="100%">
        <xsl:attribute name="fill">url(#fill-<xsl:value-of select="@meal" />)</xsl:attribute>
        <xsl:attribute name="filter">url(#filter-<xsl:value-of select="@meal" />)</xsl:attribute>
        <xsl:attribute name="mask">url(#mask-<xsl:value-of select="@meal" />)</xsl:attribute>
      </rect>

      <g style="transform: translate(1em, 1em);">
        <text class="h1" y="1em">
          <xsl:value-of select="title" />
        </text>
        <xsl:if test="item/roll">
          <text class="h2" x="20em" y="3em">Roll</text>
        </xsl:if>
        <xsl:if test="item/hero">
          <text class="h2" x="24em" y="3em">Hero</text>
        </xsl:if>
        <xsl:if test="item/small">
          <text class="h2" x="20em" y="3em">Small</text>
        </xsl:if>
        <xsl:if test="item/large">
          <text class="h2" x="24em" y="3em">Large</text>
        </xsl:if>
        <xsl:if test="item/plain">
          <text class="h2" x="20em" y="3em">Plain</text>
        </xsl:if>
        <xsl:if test="item/platter">
          <text class="h2" x="24em" y="3em">Platter</text>
        </xsl:if>
        <xsl:apply-templates select="item" />
      </g>
    </g>
  </xsl:template>

  <xsl:template match="/menus/menu/item">
    <g>
      <xsl:attribute name="style">transform: translate(0, <xsl:value-of select="position() * 2 + 1" />rem);</xsl:attribute>
      <text y="1rem"><xsl:value-of select="@name" /></text>
      <text y="1.6rem" style="font-size: 0.6em;"><xsl:value-of select="desc" /></text>
      <xsl:choose>
        <xsl:when test="roll or hero">
          <text y="1.3rem" x="20rem"><xsl:value-of select="roll" /></text>
          <text y="1.3rem" x="24rem"><xsl:value-of select="hero" /></text>
        </xsl:when>
        <xsl:when test="small or large">
          <text y="1.3rem" x="20rem"><xsl:value-of select="small" /></text>
          <text y="1.3rem" x="24rem"><xsl:value-of select="large" /></text>
        </xsl:when>
        <xsl:when test="plain or platter">
          <text y="1.3rem" x="20rem"><xsl:value-of select="plain" /></text>
          <text y="1.3rem" x="24rem"><xsl:value-of select="platter" /></text>
        </xsl:when>
      </xsl:choose>

    </g>
  </xsl:template>

  <xsl:template match="/menus/menu/image">
    <image class="fade" width="100%">
      <xsl:attribute name="class">
        fade<xsl:if test="position() = 1"> in</xsl:if>
      </xsl:attribute>
      <xsl:attribute name="href">images/<xsl:value-of select="@src" /></xsl:attribute>
    </image>
  </xsl:template>

</xsl:stylesheet>
