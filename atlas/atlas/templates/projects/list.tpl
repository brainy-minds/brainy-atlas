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
          <ul class="collection with-header">
            <li class="collection-header">
              {% url 'details' project.id as the_url %}
              <h2><a href="{{ the_url }}">{{ project.name }}</a></h2>
              <p><strong>Location:</strong> {{ project.path }}</p>
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
