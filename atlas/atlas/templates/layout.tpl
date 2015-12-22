<!DOCTYPE html>{% load staticfiles %}
<html lang="en">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no"/>
  <title>brainy {% block title %}{% endblock %}</title>
  <!-- CSS  -->
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link href="{% static "css/materialize.css" %}" type="text/css" rel="stylesheet" media="screen,projection"/>
  <link href="{% static "css/style.css" %}" type="text/css" rel="stylesheet" media="screen,projection"/>
</head>
<body>

  {% include "header.tpl" %}

  {% block content %}
  {% endblock %}

  <!-- dial menu -->
  <div class="section">

    <div class="row">        
      <div class="col s12">
    
        <div class="fixed-action-btn horizontal" style="bottom: 45px; right: 24px;">

          <a class="btn-floating btn-large red">
            <i class="large mdi-navigation-menu"></i>
          </a>
          <ul>
            <li><a class="btn-floating blue"><i class="material-icons">add</i></a></li>
            <li><a class="btn-floating red"><i class="material-icons">grade</i></a></li>
            <li><a class="btn-floating yellow darken-1"><i class="material-icons">contacts</i></a></li>
            <!-- <li><a class="btn-floating green"><i class="material-icons">publish</i></a></li> -->
          </ul>

        </div>
      
      </div>
    </div>

  </div>  <!-- end of section --> 

  <!--  Scripts-->
  <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
  <script src="{% static "js/materialize.js" %}"></script>
  <script src="{% static "js/init.js" %}"></script>
  {% block bottomjs %}
  {% endblock %}

  <!-- Footer -->
  <div class="section push-container">&nbsp;</div>
  <footer class="block page-footer blue lighten-2">
    <div class="container">
      <div class="row">
        <div class="col l6 s12">
          <h5 class="white-text">brainy</h5>
          <p class="grey-text text-lighten-4">brainy is a nimble workflow managing tool, at the core of iBRAIN. It allows creation of projects according to the expected framework layout. It also oversees the execution of the projects and provides monitoring of any relevant progress of the conducted computation.</p>


        </div>
        <div class="col l3 s12">
          <h5 class="white-text">Feedback</h5>
          <ul>
            <li><a class="white-text" href="#!">How to get started</a></li>
            <li><a class="white-text" href="#!">Video tutorials</a></li>
            <li><a class="white-text" href="#!">Read documentation</a></li>
            <li><a class="white-text" href="#!">Report a bug</a></li>
          </ul>
        </div>
        <div class="col l3 s12">
          <h5 class="white-text">Pelkmanslab</h5>
          <p class="grey-text text-lighten-4">iBRAIN and many more inspiring tools are developed by scientists and engineers at <a class="white-text" href="https://www.pelkmanslab.org/">pelkmans lab</a>, University of Zurich.
        </div>
      </div>
    </div>
    <div class="footer-copyright">
      <div class="container">
      Powered by <a class="brown-text text-lighten-3" href="#">brainy-atlas</a>
      </div>
    </div>
  </footer>

  </body>
</html>
