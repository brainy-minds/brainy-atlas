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
                {% include 'breadcrumb/projects.tpl' %}
                <a href="#!" class="breadcrumb">Active</a>
              </div>
            </div>
          </nav>
        
        </div>
      </div>  

      {% if error_list %}
      <div class="row">        
        {% for error in error_list %}                  
        <h4>Error in: {{ error.project.name }}</h4>
        <blockquote>{{ error.msg }}</blockquote>
        {% endfor %}
      </div>
      {% endif %}
      
      <div class="row">
      {% for project in project_list %}
        <div class="col s12 m6 l3">
          <div class="card">
            <div class="card-content">
              <span class="card-title">
                {% url 'details' project.id as the_url %}
                <h3><a href="{{ the_url }}" class="{{ project.status_cls}} ">{{ project.name }}</a></h3>
              </span>
            </div>
            <ul class="collection">
                <li class="collection-item">
                  <strong>Location</strong><span class="badge">{{ project.location }}</span><br>
                </li>
                <li class="collection-item">
                  <strong>Workflow</strong><span class="badge">{{ project.workflow }}</span>
                </li>
                <li class="collection-item">
                  <strong>Status</strong><span class="badge">{{ project.status }}</span>
                </li>
            </ul>
            <nav class="light-blue lighten-1 text-white">
              <div class="nav-wrapper">                
                <ul class="right hide-on-med-and-down">
                  <li><a href="{{ the_url }}"><i class="material-icons">view_module</i></a></li>
                  <li><a href="#"><i class="material-icons">refresh</i></a></li>
                  <li><a href="#"><i class="material-icons">more_vert</i></a></li>
                </ul>
              </div>
            </nav>            
          </div>
        </div>
      {% empty %}
        <p class="flow-text">Sorry, no active registered projects found.</p>
      {% endfor %}
      </div>

    </div> <!-- end of section -->


  </div>
{% endblock %}
