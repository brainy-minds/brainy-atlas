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
                {% include 'breadcrumb/projects.tpl' %}
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
              {% for node in project.task_tree %}
              <li class="collection-item avatar">
                <i class="material-icons circle">folder</i>
                <span class="title">{{ node.task.jobname }}</span>
                <p>
                {% for subnode in node.tree %}
                  &nbsp;&nbsp;{{ subnode.task.jobname }}<span class="badge">{{ subnode.state }}</span><br>
                {% endfor %}
                </p>
                <a href="#!" class="secondary-content"><i class="material-icons">insert_chart</i></a>
              </li>
              {% endfor %}
            </ul>
        </div>
      </div>
      {% endif %}

    </div> <!-- end of section -->
   
  </div>
{% endblock %}
