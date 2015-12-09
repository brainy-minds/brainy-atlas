{% extends "layout.tpl" %}
{% load staticfiles %}

{% block title %}project list{% endblock %}

{% block content %}
  <div class="container">
    
    <div class="section">

      <div class="row">        
        <div class="col s12">

          <nav>
            <div class="nav-wrapper brown lighten-4">
              <div class="col">
                <a href="#!" class="breadcrumb">Projects</a>
                <a href="#!" class="breadcrumb">Active</a>
              </div>
            </div>
          </nav>
        
        </div>
      </div>  
      
      <div class="row">        
      {% for project in project_list %}
            
        <div class="col s12 m6 l3">
          <ul class="collection with-header">
            <li class="collection-header">
              <h2>{{ project.name }}</h2>
              <p>{{ project.path }}</p>
            </li>
            {% for task in project.tasks %}
            <li class="collection-item">{{ task.jobname }}</li>
            {% endfor %}                
          </ul>
        </div>

      {% endfor %}    
      </div>

    </div> <!-- end of section -->


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

  </div>
{% endblock %}
