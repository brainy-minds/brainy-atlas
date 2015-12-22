{% extends "layout.tpl" %}
{% load staticfiles %}

{% block title %}project list{% endblock %}

{% block content %}
  <div class="container">
    
    <div class="section">

      {% if error_list %}
      <div class="row">        
        {% for error in error_list %}                  
        <h4>Error in: {{ error.project.name }}</h4>
        <blockquote>{{ error.msg }}</blockquote>
        {% endfor %}
      </div>
      {% endif %}

      {% if project %}
      <div class="row">        
        <div class="col s12">

          <nav>
            <div class="nav-wrapper brown lighten-4">
              <div class="col">
                <a href="#!" class="breadcrumb">Projects</a>
                <a href="#!" class="breadcrumb">Details</a>
                <a href="#!" class="breadcrumb">{{ project.name }}</a>
              </div>
            </div>
          </nav>
        
        </div>
      </div>  

      <div class="row">        
        <div class="col s12">
          <h2>Project: {{ project.name }}</h2>
            <ul class="collection">
              <li class="collection-item avatar">
                <img src="images/yuna.jpg" alt="" class="circle">
                <span class="title">Title</span>
                <p>First Line <br>
                   Second Line
                </p>
                <a href="#!" class="secondary-content"><i class="material-icons">grade</i></a>
              </li>
              <li class="collection-item avatar">
                <i class="material-icons circle">folder</i>
                <span class="title">Title</span>
                <p>First Line <br>
                   Second Line
                </p>
                <a href="#!" class="secondary-content"><i class="material-icons">grade</i></a>
              </li>
              <li class="collection-item avatar">
                <i class="material-icons circle green">insert_chart</i>
                <span class="title">Title</span>
                <p>First Line <br>
                   Second Line
                </p>
                <a href="#!" class="secondary-content"><i class="material-icons">grade</i></a>
              </li>
              <li class="collection-item avatar">
                <i class="material-icons circle red">play_arrow</i>
                <span class="title">Title</span>
                <p>First Line <br>
                   Second Line
                </p>
                <a href="#!" class="secondary-content"><i class="material-icons">grade</i></a>
              </li>
            </ul>            
        </div>
      </div>
      {% endif %}

    </div> <!-- end of section -->
   
  </div>
{% endblock %}
