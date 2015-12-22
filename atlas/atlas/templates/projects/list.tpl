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
        {% for error in error_list %}                  
        <h4>Error in: {{ error.project.name }}</h4>
        <blockquote>{{ error.msg }}</blockquote>
      {% endfor %}
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
      {% empty %}
        <p class="flow-text">Sorry, no active registered projects found.</p>
      {% endfor %}    
      </div>

    </div> <!-- end of section -->


        

  </div>
{% endblock %}
