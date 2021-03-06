doctype 5
html ->
  head ->
    partial "shared/meta"
  
  body role: "application", ->
    nav id: "navigation", role: "navigation", ->
      ul ->
        li ->
          a href: "/", "Overview"
        li ->
          a href: "/guides", "Guides"
        li ->
          a href: "/", "Screencasts"
        li ->
          a href: "https://github.com/viatropos/towerjs.org", "Examples"
        li ->
          a class: "forkme", href: "http://github.com/viatropos/tower.js", ->
            img src: "https://a248.e.akamai.net/assets.github.com/img/4c7dc970b89fd04b81c8e221ba88ff99a06c6b61/687474703a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f77686974655f6666666666662e706e67", alt: "Fork me on GitHub"      
        
    header id: "header", role: "banner", ->
      h1 t("title")
        
    section id: "body", role: "main", ->
      yields "body"
      div id: "content", ->
        if @request.url.match("guides")
          text """
          <h1>Querying</h1>

          <p>The following are a list of chainable query methods in Tower.  Shown alongside each example are the generated query parameters and options which are passed to the <code>store</code> object.  The stores then convert these normalized criteria into the database-specific format.</p>

          <p>Please note that criteria are lazy evaluated, and with each chained method it will be cloned and return a new criteria copy.</p>

          <h2>Query Methods</h2>

          <ul>
          <li><code>Model.allIn</code></li>
          <li><code>Model.allOf</code></li>
          <li><code>Model.alsoIn</code></li>
          <li><code>Model.anyIn</code></li>
          <li><code>Model.anyOf</code></li>
          <li><code>Model.asc</code></li>
          <li><code>Model.desc</code></li>
          <li><code>Model.distinct</code></li>
          <li><code>Model.excludes</code></li>
          <li><code>Model.includes</code></li>
          <li><code>Model.limit</code></li>
          <li><code>Model.near</code></li>
          <li><code>Model.notIn</code></li>
          <li><code>Model.only</code></li>
          <li><code>Model.order</code></li>
          <li><code>Model.paginate</code></li>
          <li><code>Model.offset</code></li>
          <li><code>Model.where</code></li>
          <li><code>Model.without</code></li>
          </ul><h2><code>Model.allIn</code></h2>

          <p>Adds a criterion that specifies values that must all match in order to return results.</p>

          <h3>Model</h3>

          <p></p><div class="highlight">
          <pre><span class="c1"># Match all people with Bond and 007 as aliases.</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">allIn</span><span class="p">(</span><span class="nv">aliases: </span><span class="p">[</span><span class="s">"Bond"</span><span class="p">,</span> <span class="s">"007"</span><span class="p">])</span>
          </pre>
          </div>


          <h3>Criteria</h3>

          <p></p><div class="highlight">
          <pre><span class="p">{</span> <span class="s">"aliases"</span> <span class="o">:</span> <span class="p">{</span> <span class="s">"$all"</span> <span class="o">:</span> <span class="p">[</span> <span class="s">"Bond"</span><span class="p">,</span> <span class="s">"007"</span> <span class="p">]</span> <span class="p">}}</span>
          </pre>
          </div>


          <h2><code>Model.allOf</code></h2>

          <p>Adds a criterion that specifies expressions that must all match in order to return results.</p>

          <h3>Model</h3>

          <p></p><div class="highlight">
          <pre><span class="c1"># Match all crazy old people.</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">allOf</span><span class="p">(</span><span class="nv">age: </span><span class="p">{</span><span class="s">"&gt;="</span><span class="o">:</span> <span class="mi">60</span> <span class="p">},</span> <span class="nv">mentalState: </span><span class="s">"crazy mofos"</span><span class="p">)</span>
          </pre>
          </div>


          <h3>Criteria</h3>

          <p></p><div class="highlight">
          <pre><span class="p">{</span> <span class="s">"$and"</span> <span class="o">:</span> <span class="p">[{</span> <span class="s">"age"</span> <span class="o">:</span> <span class="p">{</span> <span class="s">"$gt"</span> <span class="o">:</span> <span class="mi">60</span> <span class="p">}},</span> <span class="p">{</span> <span class="s">"mentalState"</span> <span class="o">:</span> <span class="s">"crazy mofos"</span> <span class="p">}]</span> <span class="p">}</span>
          </pre>
          </div>


          <h2><code>Model.alsoIn</code></h2>

          <p>Adds a criterion that specifies values where any value can be matched in order to return results. This is similar to Criteria#anyIn with the exception here that if if it chained with values for the same field it performs a union of the values where anyIn perform an intersection.</p>

          <h3>Model</h3>

          <p></p><div class="highlight">
          <pre><span class="c1"># Match all people with either Bond or 007 as aliases.</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">alsoIn</span><span class="p">(</span><span class="nv">aliases: </span><span class="p">[</span> <span class="s">"Bond"</span><span class="p">,</span> <span class="s">"007"</span> <span class="p">])</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">anyIn</span><span class="p">(</span><span class="nv">aliases: </span><span class="p">[</span> <span class="s">"Bond"</span> <span class="p">]).</span><span class="nx">alsoIn</span><span class="p">(</span><span class="nv">aliases: </span><span class="p">[</span> <span class="s">"007"</span> <span class="p">])</span>
          </pre>
          </div>


          <h3>Criteria</h3>

          <p></p><div class="highlight">
          <pre><span class="p">{</span> <span class="s">"aliases"</span> <span class="o">:</span> <span class="p">{</span> <span class="s">"$in"</span> <span class="o">:</span> <span class="p">[</span> <span class="s">"Bond"</span><span class="p">,</span> <span class="s">"007"</span> <span class="p">]</span> <span class="p">}}</span>
          </pre>
          </div>


          <h2><code>Model.anyIn</code></h2>

          <p>Adds a criterion that specifies values where any value can be matched in order to return results. This is similar to Criteria#alsoIn with the exception here that if if it chained with values for the same field it performs an intersection of the values where alsoIn perform a union.</p>

          <h3>Model</h3>

          <p></p><div class="highlight">
          <pre><span class="c1"># Match all people with either Bond or 007 as aliases.</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">anyIn</span><span class="p">(</span><span class="nv">aliases: </span><span class="p">[</span> <span class="s">"Bond"</span><span class="p">,</span> <span class="s">"007"</span> <span class="p">])</span>
          <span class="nx">Person</span>
            <span class="p">.</span><span class="nx">anyIn</span><span class="p">(</span><span class="nv">aliases: </span><span class="p">[</span> <span class="s">"Bond"</span><span class="p">,</span> <span class="s">"007"</span><span class="p">,</span> <span class="s">"James"</span> <span class="p">])</span>
            <span class="p">.</span><span class="nx">anyIn</span><span class="p">(</span><span class="nv">aliases: </span><span class="p">[</span> <span class="s">"Bond"</span><span class="p">,</span> <span class="s">"007"</span> <span class="p">])</span>
          </pre>
          </div>


          <h3>Criteria</h3>

          <p></p><div class="highlight">
          <pre><span class="p">{</span> <span class="s">"aliases"</span> <span class="o">:</span> <span class="p">{</span> <span class="s">"$in"</span> <span class="o">:</span> <span class="p">[</span> <span class="s">"Bond"</span><span class="p">,</span> <span class="s">"007"</span> <span class="p">]</span> <span class="p">}}</span>
          </pre>
          </div>


          <h2><code>Model.anyOf</code></h2>

          <p>Adds a criterion that specifies a set of expressions that any can match in order to return results. The underlying MongoDB expression is $or.</p>

          <h3>Model</h3>

          <p></p><div class="highlight">
          <pre><span class="c1"># Match all people with either last name Penn or Teller</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">anyOf</span><span class="p">({</span> <span class="nv">lastName: </span><span class="s">"Penn"</span> <span class="p">},</span> <span class="p">{</span> <span class="nv">lastName: </span><span class="s">"Teller"</span> <span class="p">})</span>
          </pre>
          </div>


          <h3>Criteria</h3>

          <p></p><div class="highlight">
          <pre><span class="p">{</span> <span class="s">"lastName"</span> <span class="o">:</span>
            <span class="p">{</span> <span class="s">"$or"</span> <span class="o">:</span>
              <span class="p">[</span> <span class="p">{</span> <span class="s">"lastName"</span> <span class="o">:</span> <span class="s">"Penn"</span> <span class="p">},</span> <span class="p">{</span> <span class="s">"lastName"</span> <span class="o">:</span> <span class="s">"Teller"</span> <span class="p">}</span> <span class="p">]</span>
            <span class="p">}</span>
          <span class="p">}</span>
          </pre>
          </div>


          <h2><code>Model.asc</code></h2>

          <p>Adds ascending sort options for the provided fields.</p>

          <h3>Model</h3>

          <p></p><div class="highlight">
          <pre><span class="c1"># Sort people by first and last name ascending.</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">asc</span><span class="p">(</span><span class="s">"firstName"</span><span class="p">,</span> <span class="s">"lastName"</span><span class="p">)</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">ascending</span><span class="p">(</span><span class="s">"firstName"</span><span class="p">,</span> <span class="s">"lastName"</span><span class="p">)</span>
          </pre>
          </div>


          <h3>Criteria</h3>

          <p></p><div class="highlight">
          <pre><span class="p">{</span> <span class="s">"sort"</span> <span class="o">:</span>
              <span class="p">{[</span> <span class="p">[</span> <span class="s">"firstName"</span><span class="p">,</span> <span class="s">"asc"</span> <span class="p">],</span>
                <span class="p">[</span> <span class="s">"lastName"</span><span class="p">,</span> <span class="s">"asc"</span> <span class="p">]</span> <span class="p">]}</span> <span class="p">}</span>
          </pre>
          </div>


          <h2><code>Model.desc</code></h2>

          <p>Adds descending sort options for the provided fields.</p>

          <h3>Model</h3>

          <p></p><div class="highlight">
          <pre><span class="c1"># Sort people by first and last name descending.</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">desc</span><span class="p">(</span><span class="s">"firstName"</span><span class="p">,</span> <span class="s">"lastName"</span><span class="p">)</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">descending</span><span class="p">(</span><span class="s">"firstName"</span><span class="p">,</span> <span class="s">"lastName"</span><span class="p">)</span>
          </pre>
          </div>


          <h3>Criteria</h3>

          <p></p><div class="highlight">
          <pre><span class="p">{</span> <span class="s">"sort"</span> <span class="o">:</span>
              <span class="p">{[</span> <span class="p">[</span> <span class="s">"firstName"</span><span class="p">,</span> <span class="s">"desc"</span> <span class="p">],</span>
                <span class="p">[</span> <span class="s">"lastName"</span><span class="p">,</span> <span class="s">"desc"</span> <span class="p">]</span> <span class="p">]}</span> <span class="p">}</span>
          </pre>
          </div>


          <h2><code>Model.distinct(name)</code></h2>

          <p>Get the distinct values for the provided field.</p>

          <h3>Model</h3>

          <p></p><div class="highlight">
          <pre><span class="c1"># Get the distinct values for last names</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">distinct</span><span class="p">(</span><span class="s">"lastName"</span><span class="p">)</span>
          </pre>
          </div>


          <h3>Criteria</h3>

          <p></p><div class="highlight">
          <pre><span class="p">{</span> <span class="s">"distinct"</span> <span class="o">:</span> <span class="s">"lastName"</span> <span class="p">}</span>
          </pre>
          </div>


          <h2><code>Model.excludes</code></h2>

          <p>Adds a criterion that specifies a set of expressions that cannot match in order to return results. The underlying MongoDB expression is $ne.</p>

          <h3>Model</h3>

          <p></p><div class="highlight">
          <pre><span class="c1"># Match all people without either last name Teller and first name Bob.</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">excludes</span><span class="p">(</span><span class="nv">lastName: </span><span class="s">"Teller"</span><span class="p">,</span> <span class="nv">firstName: </span><span class="s">"Bob"</span><span class="p">)</span>
          </pre>
          </div>


          <h3>Criteria</h3>

          <p></p><div class="highlight">
          <pre><span class="p">{{</span> <span class="s">"lastName"</span> <span class="o">:</span> <span class="p">{</span> <span class="s">"$ne"</span> <span class="o">:</span> <span class="s">"Teller"</span> <span class="p">}</span> <span class="p">},</span> <span class="p">{</span> <span class="s">"firstName"</span> <span class="o">:</span> <span class="p">{</span> <span class="s">"$ne"</span> <span class="o">:</span> <span class="s">"Bob"</span> <span class="p">}</span> <span class="p">}}</span>
          </pre>
          </div>


          <h2><code>Model.includes</code></h2>

          <p>Adds a criterion that specifies a list of relational associations to eager load when executing the query. This is to prevent the n+1 issue when iterating over documents that access their relations during the iteration.</p>

          <p>This only works with <code>hasMany</code>, <code>hasOne</code>, and <code>belongsTo</code> relations and only 1 level deep at the current moment. If you try to eager load a many to many an exception will get raised. Many to many is not supported due to the performance actually being slower despite lowering the number of database calls.</p>

          <h3>Model</h3>

          <p></p><div class="highlight">
          <pre><span class="c1"># Eager load the posts and games when retrieving the people.</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">includes</span><span class="p">(</span><span class="s">"posts"</span><span class="p">,</span> <span class="s">"comments"</span><span class="p">)</span>
          </pre>
          </div>


          <h3>Criteria</h3>

          <p></p><div class="highlight">
          <pre><span class="nv">peopleIds = </span><span class="nx">people</span><span class="p">.</span><span class="nx">find</span><span class="p">({},</span> <span class="p">{</span> <span class="s">"fields"</span> <span class="o">:</span> <span class="p">{</span> <span class="s">"_id"</span> <span class="o">:</span> <span class="mi">1</span> <span class="p">}})</span>
          <span class="nx">posts</span><span class="p">.</span><span class="nx">find</span><span class="p">({</span> <span class="s">"personId"</span> <span class="o">:</span> <span class="p">{</span> <span class="s">"$in"</span> <span class="o">:</span> <span class="nx">peopleIds</span> <span class="p">}})</span>
          <span class="nx">comments</span><span class="p">.</span><span class="nx">find</span><span class="p">({</span> <span class="s">"personId"</span> <span class="o">:</span> <span class="p">{</span> <span class="s">"$in"</span> <span class="o">:</span> <span class="nx">peopleIds</span> <span class="p">}})</span>
          </pre>
          </div>


          <h2><code>Model.limit</code></h2>

          <p>Limits the number of returned results by the provided value.</p>

          <h3>Model</h3>

          <p></p><div class="highlight">
          <pre><span class="c1"># Only return 20 documents.</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">limit</span><span class="p">(</span><span class="mi">20</span><span class="p">)</span>
          </pre>
          </div>


          <h3>Criteria</h3>

          <p></p><div class="highlight">
          <pre><span class="p">{</span> <span class="s">"limit"</span> <span class="o">:</span> <span class="mi">20</span> <span class="p">}</span>
          </pre>
          </div>


          <h2><code>Model.near</code></h2>

          <p>Adds a criterion to find locations that are near the supplied coordinates. This performs a MongoDB $near selection and requires a 2d index to be on the provided field.</p>

          <h3>Model</h3>

          <p></p><div class="highlight">
          <pre><span class="c1"># Match all bars near Berlin</span>
          <span class="nx">Bar</span><span class="p">.</span><span class="nx">near</span><span class="p">(</span><span class="nv">location: </span><span class="p">[</span> <span class="mf">52.30</span><span class="p">,</span> <span class="mf">13.25</span> <span class="p">])</span>
          </pre>
          </div>


          <h3>Criteria</h3>

          <p></p><div class="highlight">
          <pre><span class="p">{</span> <span class="s">"location"</span> <span class="o">:</span> <span class="p">{</span> <span class="s">"$near"</span> <span class="o">:</span> <span class="p">[</span> <span class="mf">52.30</span><span class="p">,</span> <span class="mf">13.25</span> <span class="p">]</span> <span class="p">}}</span>
          </pre>
          </div>


          <h2><code>Model.notIn</code></h2>

          <p>Adds a criterion that specifies a set of expressions that cannot match in order to return results. The underlying MongoDB expression is $nin.</p>

          <h3>Model</h3>

          <p></p><div class="highlight">
          <pre><span class="c1"># Match all people without last names Zorg and Dallas</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">notIn</span><span class="p">(</span><span class="nv">lastName: </span><span class="p">[</span> <span class="s">"Zorg"</span><span class="p">,</span> <span class="s">"Dallas"</span> <span class="p">])</span>
          </pre>
          </div>


          <h3>Criteria</h3>

          <p></p><div class="highlight">
          <pre><span class="p">{{</span> <span class="s">"lastName"</span> <span class="o">:</span> <span class="p">{</span> <span class="s">"$nin"</span> <span class="o">:</span> <span class="p">[</span> <span class="s">"Zorg"</span><span class="p">,</span> <span class="s">"Dallas"</span> <span class="p">]</span> <span class="p">}</span> <span class="p">}}</span>
          </pre>
          </div>


          <h2><code>Model.only</code></h2>

          <p>Limits the fields returned from the database to those supplied to the method. Extremely useful for list views where the entire documents are not needed. Cannot be used in conjunction with <code>#without</code>.</p>

          <h3>Model</h3>

          <p></p><div class="highlight">
          <pre><span class="c1"># Return only the first and last names of each person.</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">only</span><span class="p">(</span><span class="s">"firstName"</span><span class="p">,</span> <span class="s">"lastName"</span><span class="p">)</span>
          </pre>
          </div>


          <h3>Criteria</h3>

          <p></p><div class="highlight">
          <pre><span class="nv">options: </span><span class="p">{</span> <span class="s">"fields"</span> <span class="o">:</span> <span class="p">{</span> <span class="s">"firstName"</span> <span class="o">:</span> <span class="mi">1</span><span class="p">,</span> <span class="s">"lastName"</span> <span class="o">:</span> <span class="mi">1</span> <span class="p">}}</span>
          </pre>
          </div>


          <h2><code>Model.order</code></h2>

          <p>Sorts the results given the arguments that must match the MongoDB driver sorting syntax (key/value pairs of field and direction).</p>

          <h3>Model</h3>

          <p></p><div class="highlight">
          <pre><span class="c1"># Provide the sorting options.</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">order</span><span class="p">(</span><span class="s">"firstName"</span><span class="p">,</span> <span class="s">"asc"</span><span class="p">).</span><span class="nx">order</span><span class="p">(</span><span class="s">"lastName"</span><span class="p">,</span> <span class="s">"desc"</span><span class="p">)</span>
          </pre>
          </div>


          <h3>Criteria</h3>

          <p></p><div class="highlight">
          <pre><span class="p">{</span> <span class="s">"sort"</span> <span class="o">:</span>
              <span class="p">{[</span> <span class="p">[</span> <span class="s">"firstName"</span><span class="p">,</span> <span class="s">"asc"</span> <span class="p">],</span>
                <span class="p">[</span> <span class="s">"lastName"</span><span class="p">,</span> <span class="s">"desc"</span> <span class="p">]</span> <span class="p">]}</span> <span class="p">}</span>
          </pre>
          </div>


          <h2><code>Model.skip</code></h2>

          <p>Skips the number of the results given the provided value, similar to a SQL "offset".</p>

          <h3>Model</h3>

          <p></p><div class="highlight">
          <pre><span class="c1"># Skip 20 documents.</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">skip</span><span class="p">(</span><span class="mi">20</span><span class="p">)</span>
          </pre>
          </div>


          <h3>Criteria</h3>

          <p></p><div class="highlight">
          <pre><span class="p">{</span> <span class="s">"skip"</span> <span class="o">:</span> <span class="mi">20</span> <span class="p">}</span>
          </pre>
          </div>


          <h2><code>Model.where</code></h2>

          <p>Adds a criterion that must match in order to return results. If provided a string it interperets it as a javascript function and converts it to the proper $where clause. Tower also provides convenience h4s on Symbol to make advanced queries simpler to write.</p>

          <h3>Model</h3>

          <p></p><div class="highlight">
          <pre><span class="c1"># Match all people with first name Emmanuel</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">where</span><span class="p">(</span><span class="nv">firstName: </span><span class="s">"Emmanuel"</span><span class="p">)</span>

          <span class="c1"># Match all people who live in Berlin, where address is embedded.</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">where</span><span class="p">(</span><span class="s">"addresses.city"</span><span class="o">:</span> <span class="s">"Berlin"</span><span class="p">)</span>

          <span class="c1"># Same as above but with a hash.</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">where</span><span class="p">(</span><span class="nv">addresses: city: </span><span class="s">"Berlin"</span><span class="p">)</span>

          <span class="c1"># Match all people who live at an address in Berlin or</span>
          <span class="c1"># Munich where address is embedded.</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">where</span><span class="p">(</span><span class="s">"addresses.city"</span><span class="o">:</span> <span class="p">{</span><span class="s">"$in"</span><span class="o">:</span> <span class="p">[</span><span class="s">"Berlin"</span><span class="p">,</span> <span class="s">"Munich"</span><span class="p">]})</span>

          <span class="c1"># Example complex queries</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">where</span><span class="p">(</span><span class="nv">age: </span><span class="s">"&gt;"</span><span class="o">:</span> <span class="mi">21</span><span class="p">)</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">where</span><span class="p">(</span><span class="nv">age: $gt: </span><span class="mi">21</span><span class="p">)</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">where</span><span class="p">(</span><span class="nv">age: </span><span class="s">"&gt;="</span><span class="o">:</span> <span class="mi">21</span><span class="p">)</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">where</span><span class="p">(</span><span class="nv">age: $gte: </span><span class="mi">21</span><span class="p">)</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">where</span><span class="p">(</span><span class="nv">title: $in: </span><span class="p">[</span><span class="s">"Sir"</span><span class="p">,</span> <span class="s">"Madam"</span><span class="p">])</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">where</span><span class="p">(</span><span class="nv">age: </span><span class="s">"&lt;"</span><span class="o">:</span> <span class="mi">55</span><span class="p">)</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">where</span><span class="p">(</span><span class="nv">age: $lt: </span><span class="mi">55</span><span class="p">)</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">where</span><span class="p">(</span><span class="nv">age: </span><span class="s">"&lt;="</span><span class="o">:</span> <span class="mi">55</span><span class="p">)</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">where</span><span class="p">(</span><span class="nv">age: $lte: </span><span class="mi">55</span><span class="p">)</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">where</span><span class="p">(</span><span class="nv">title: $ne: </span><span class="s">"Mr"</span><span class="p">)</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">where</span><span class="p">(</span><span class="nv">title: $nin: </span><span class="p">[</span><span class="s">"Esquire"</span><span class="p">])</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">where</span><span class="p">(</span><span class="nv">age: </span><span class="s">"&gt;="</span><span class="o">:</span> <span class="mi">18</span><span class="p">,</span> <span class="s">"&lt;="</span><span class="o">:</span> <span class="mi">55</span><span class="p">)</span>
          </pre>
          </div>


          <h3>Criteria</h3>

          <p></p><div class="highlight">
          <pre><span class="c1"># Match all people with first name Emmanuel</span>
          <span class="p">{</span> <span class="s">"firstName"</span> <span class="o">:</span> <span class="s">"Emmanuel"</span> <span class="p">}</span>

          <span class="c1"># Match all people who live in Berlin, where address is embedded.</span>
          <span class="p">{</span> <span class="s">"addresses.city"</span> <span class="o">:</span> <span class="s">"Berlin"</span> <span class="p">}</span>

          <span class="c1"># Example queries using symbol h4s to perform more complex criteria.</span>
          <span class="p">{</span> <span class="s">"age"</span> <span class="o">:</span> <span class="p">{</span> <span class="s">"$gt"</span> <span class="o">:</span> <span class="mi">18</span> <span class="p">}}</span>
          <span class="p">{</span> <span class="s">"age"</span> <span class="o">:</span> <span class="p">{</span> <span class="s">"$gt"</span> <span class="o">:</span> <span class="mi">18</span> <span class="p">}}</span>
          <span class="p">{</span> <span class="s">"age"</span> <span class="o">:</span> <span class="p">{</span> <span class="s">"$gte"</span> <span class="o">:</span> <span class="mi">18</span> <span class="p">}}</span>
          <span class="p">{</span> <span class="s">"age"</span> <span class="o">:</span> <span class="p">{</span> <span class="s">"$gte"</span> <span class="o">:</span> <span class="mi">18</span> <span class="p">}}</span>
          <span class="p">{</span> <span class="s">"title"</span> <span class="o">:</span> <span class="p">{</span> <span class="s">"$in"</span> <span class="o">:</span> <span class="p">[</span> <span class="s">"Sir"</span><span class="p">,</span> <span class="s">"Madam"</span> <span class="p">]</span> <span class="p">}}</span>
          <span class="p">{</span> <span class="s">"age"</span> <span class="o">:</span> <span class="p">{</span> <span class="s">"$lt"</span> <span class="o">:</span> <span class="mi">55</span> <span class="p">}}</span>
          <span class="p">{</span> <span class="s">"age"</span> <span class="o">:</span> <span class="p">{</span> <span class="s">"$lt"</span> <span class="o">:</span> <span class="mi">55</span> <span class="p">}}</span>
          <span class="p">{</span> <span class="s">"age"</span> <span class="o">:</span> <span class="p">{</span> <span class="s">"$lte"</span> <span class="o">:</span> <span class="mi">55</span> <span class="p">}}</span>
          <span class="p">{</span> <span class="s">"age"</span> <span class="o">:</span> <span class="p">{</span> <span class="s">"$lte"</span> <span class="o">:</span> <span class="mi">55</span> <span class="p">}}</span>
          <span class="p">{</span> <span class="s">"title"</span> <span class="o">:</span> <span class="p">{</span> <span class="s">"$ne"</span> <span class="o">:</span> <span class="s">"Mr"</span> <span class="p">}}</span>
          <span class="p">{</span> <span class="s">"title"</span> <span class="o">:</span> <span class="p">{</span> <span class="s">"$nin"</span> <span class="o">:</span> <span class="p">[</span> <span class="s">"Esquire"</span> <span class="p">]</span> <span class="p">}}</span>
          <span class="p">{</span> <span class="s">"age"</span> <span class="o">:</span> <span class="p">{</span> <span class="s">"$gte"</span> <span class="o">:</span> <span class="mi">18</span><span class="p">,</span> <span class="s">"$lte"</span> <span class="o">:</span> <span class="mi">55</span> <span class="p">}}</span>
          </pre>
          </div>


          <h2><code>Model.without</code></h2>

          <p>Limits the fields returned from the database to those NOT supplied to the method. Extremely useful for list views where the entire documents are not needed. Cannot be used in conjunction with <code>#only</code>.</p>

          <h3>Model</h3>

          <p></p><div class="highlight">
          <pre><span class="c1"># Return all fields except first name and last name</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">without</span><span class="p">(</span><span class="s">"firstName"</span><span class="p">,</span> <span class="s">"lastName"</span><span class="p">)</span>
          </pre>
          </div>


          <h3>Criteria</h3>

          <p></p><div class="highlight">
          <pre><span class="p">{</span> <span class="s">"fields"</span> <span class="o">:</span> <span class="p">{</span> <span class="s">"firstName"</span> <span class="o">:</span> <span class="mi">0</span><span class="p">,</span> <span class="s">"lastName"</span> <span class="o">:</span> <span class="mi">0</span> <span class="p">}}</span>
          </pre>
          </div>
          
          <h1>Persistence</h1>

          <p>Tower's standard persistence methods come in the form of common methods you would find in other mapping frameworks.</p>

          <ul>
          <li><code>Model.create</code></li>
          <li><code>Model.delete</code></li>
          <li><code>Model.destroy</code></li>
          <li><code>Model#save</code></li>
          <li><code>Model#updateAttributes</code></li>
          <li><code>Model#updateAttribute</code></li>
          <li><code>Model#delete</code></li>
          <li><code>Model#destroy</code></li>
          </ul><h2><code>Model.create</code></h2>

          <p>Inserts a new document into the database given the provided attributes. This will run validations and will return the document whether it was persisted or not. You can check Model#persisted? to see if it was successful.</p>

          <h3>Model</h3>

          <p></p><div class="highlight">
          <pre><span class="c1"># Insert a new German poet to the db.</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">create</span><span class="p">(</span><span class="nv">firstName: </span><span class="s">"Heinrich"</span><span class="p">,</span> <span class="nv">lastName: </span><span class="s">"Heine"</span><span class="p">)</span>
          </pre>
          </div>
          
          <h3>Store</h3>

          <p></p><div class="highlight">
          <pre><span class="nx">store</span><span class="p">.</span><span class="nx">create</span> <span class="p">{</span> <span class="s">"firstName"</span> <span class="o">:</span> <span class="s">"Heinrich"</span><span class="p">,</span> <span class="s">"lastName"</span> <span class="o">:</span> <span class="s">"Heine"</span> <span class="p">}</span>
          </pre>
          </div>


          <h2><code>Model#save</code></h2>

          <p>Saves the document to the database. If the document is new then the entire document will be inserted. If the document is already saved then only changes to the document will the persisted. This runs validations by default, however they can be switched off by providing an option to the method. Returns true if validation passed and false if not.</p>

          <h3>Model</h3>

          <p></p><div class="highlight">
          <pre><span class="c1"># Insert a new German poet to the db.</span>
          <span class="nv">person = </span><span class="nx">Person</span><span class="p">.</span><span class="k">new</span><span class="p">(</span><span class="nv">firstName: </span><span class="s">"Heinrich"</span><span class="p">,</span> <span class="nv">lastName: </span><span class="s">"Heine"</span><span class="p">)</span>
          <span class="nx">person</span><span class="p">.</span><span class="nx">save</span><span class="p">()</span>

          <span class="c1"># Save without running validations.</span>
          <span class="nx">person</span><span class="p">.</span><span class="nx">save</span><span class="p">(</span><span class="nv">validate: </span><span class="kc">false</span><span class="p">)</span>

          <span class="c1"># Save an existing document's changed fields.</span>
          <span class="nv">person.firstName = </span><span class="s">"Christian Johan"</span>
          <span class="nx">person</span><span class="p">.</span><span class="nx">save</span><span class="p">()</span>
          </pre>
          </div>


          <h3>Store</h3>

          <p></p><div class="highlight">
          <pre><span class="c1"># Insert command for the new document.</span>
          <span class="nx">collections</span><span class="p">[</span><span class="s">"people"</span><span class="p">].</span><span class="nx">insert</span><span class="p">({</span>
            <span class="s">"_id"</span> <span class="o">:</span> <span class="p">...,</span> <span class="s">"firstName"</span> <span class="o">:</span> <span class="s">"Heinrich"</span><span class="p">,</span> <span class="s">"lastName"</span> <span class="o">:</span> <span class="s">"Heine"</span>
          <span class="p">})</span>

          <span class="c1"># Update command for the changed document.</span>
          <span class="nx">collections</span><span class="p">[</span><span class="s">"people"</span><span class="p">].</span><span class="nx">update</span><span class="p">({</span>
            <span class="p">{</span> <span class="s">"_id"</span> <span class="o">:</span> <span class="p">...</span> <span class="p">},</span>
            <span class="p">{</span> <span class="s">"$set"</span> <span class="o">:</span> <span class="p">{</span> <span class="s">"firstName"</span> <span class="o">:</span> <span class="s">"Christian Johan"</span> <span class="p">}</span> <span class="p">}</span>
          <span class="p">})</span>
          </pre>
          </div>


          <h2><code>Model#updateAttributes</code></h2>

          <p>Modifies the provided attributes to new values and persists them in a single call. This runs validations and will return true if they passed, false if not.</p>

          <h3>Model</h3>

          <p></p><div class="highlight">
          <pre><span class="c1"># Update the provided attributes.</span>
          <span class="nx">person</span><span class="p">.</span><span class="nx">updateAttributes</span><span class="p">(</span><span class="nv">firstName: </span><span class="s">"Jean"</span><span class="p">,</span> <span class="nv">lastName: </span><span class="s">"Zorg"</span><span class="p">)</span>
          </pre>
          </div>


          <h3>Store</h3>

          <p></p><div class="highlight">
          <pre><span class="c1"># Update command for the changed document.</span>
          <span class="nx">collections</span><span class="p">[</span><span class="s">"people"</span><span class="p">].</span><span class="nx">update</span><span class="p">({</span>
            <span class="p">{</span> <span class="s">"_id"</span> <span class="o">:</span> <span class="p">...</span> <span class="p">},</span>
            <span class="p">{</span> <span class="s">"$set"</span> <span class="o">:</span> <span class="p">{</span> <span class="s">"firstName"</span> <span class="o">:</span> <span class="s">"Jean"</span><span class="p">,</span> <span class="s">"lastName"</span> <span class="o">:</span> <span class="s">"Zorg"</span> <span class="p">}</span> <span class="p">}</span>
          <span class="p">})</span>
          </pre>
          </div>


          <h2><code>Model#updateAttribute</code></h2>

          <p>Updates a single attribute in the database without going through the normal validation procedure, but does fire callbacks. Returns true if save was successful, false if not.</p>

          <h3>Model</h3>

          <p></p><div class="highlight">
          <pre><span class="c1"># Update the provided attribute.</span>
          <span class="nx">person</span><span class="p">.</span><span class="nx">updateAttribute</span><span class="p">(</span><span class="o">:</span><span class="nx">firstName</span><span class="p">,</span> <span class="s">"Jean"</span><span class="p">)</span>
          </pre>
          </div>


          <h3>Store</h3>

          <p></p><div class="highlight">
          <pre><span class="c1"># Update command for the changed document.</span>
          <span class="nx">collections</span><span class="p">[</span><span class="s">"people"</span><span class="p">].</span><span class="nx">update</span><span class="p">({</span>
            <span class="p">{</span> <span class="s">"_id"</span> <span class="o">:</span> <span class="p">...</span> <span class="p">},</span>
            <span class="p">{</span> <span class="s">"$set"</span> <span class="o">:</span> <span class="p">{</span> <span class="s">"firstName"</span> <span class="o">:</span> <span class="s">"Jean"</span> <span class="p">}</span> <span class="p">}</span>
          <span class="p">})</span>
          </pre>
          </div>


          <h2><code>Model#delete</code></h2>

          <p>Deletes the document from the database without running callbacks.</p>

          <h3>Model</h3>

          <p></p><div class="highlight">
          <pre><span class="nx">person</span><span class="p">.</span><span class="k">delete</span><span class="p">()</span>
          </pre>
          </div>


          <h3>Store</h3>

          <p></p><div class="highlight">
          <pre><span class="nx">collections</span><span class="p">[</span><span class="s">"people"</span><span class="p">].</span><span class="nx">remove</span><span class="p">(</span><span class="s">"_id"</span> <span class="o">:</span> <span class="p">...</span> <span class="p">)</span>
          </pre>
          </div>


          <h2><code>Model#destroy</code></h2>

          <p>Deletes the document from the database while running destroy callbacks.</p>

          <h3>Model</h3>

          <p></p><div class="highlight">
          <pre><span class="nx">person</span><span class="p">.</span><span class="nx">destroy</span><span class="p">()</span>
          </pre>
          </div>


          <h3>Store</h3>

          <p></p><div class="highlight">
          <pre><span class="nx">collections</span><span class="p">[</span><span class="s">"people"</span><span class="p">].</span><span class="nx">remove</span><span class="p">(</span><span class="s">"_id"</span> <span class="o">:</span> <span class="p">...</span> <span class="p">)</span>
          </pre>
          </div>


          <h2><code>Model.delete</code></h2>

          <p>Deletes all matching documents in the database given the supplied conditions. See the criteria section on deletion for preferred ways to perform these actions. This does not run any callbacks on the matching documents.</p>

          <h3>Model</h3>

          <p></p><div class="highlight">
          <pre><span class="c1"># Delete all the documents from the collection.</span>
          <span class="nx">Person</span><span class="p">.</span><span class="k">delete</span><span class="p">()</span>

          <span class="c1"># Delete all matching documents.</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">where</span><span class="p">(</span><span class="nv">firstName: </span><span class="s">"Heinrich"</span><span class="p">).</span><span class="k">delete</span><span class="p">()</span>
          </pre>
          </div>


          <h3>Store</h3>

          <p></p><div class="highlight">
          <pre><span class="c1"># Delete all command.</span>
          <span class="nx">collections</span><span class="p">[</span><span class="s">"people"</span><span class="p">].</span><span class="nx">remove</span>

          <span class="c1"># Delete all matching command.</span>
          <span class="nx">collections</span><span class="p">[</span><span class="s">"people"</span><span class="p">].</span><span class="nx">remove</span><span class="p">(</span><span class="s">"firstName"</span> <span class="o">:</span> <span class="s">"Heinrich"</span><span class="p">)</span>
          </pre>
          </div>


          <h2><code>Model.destroy</code></h2>

          <p>Deletes all matching documents in the database given the supplied conditions. See the criteria section on deletion for preferred ways to perform these actions. This runs destroy callbacks on all matching documents.</p>

          <h3>Model</h3>

          <p></p><div class="highlight">
          <pre><span class="c1"># Destroy all the documents from the collection.</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">destroy</span><span class="p">()</span>

          <span class="c1"># Destroy all matching documents.</span>
          <span class="nx">Person</span><span class="p">.</span><span class="nx">where</span><span class="p">(</span><span class="nv">firstName: </span><span class="s">"Heinrich"</span><span class="p">).</span><span class="nx">destroy</span><span class="p">()</span>
          </pre>
          </div>


          <h3>Store</h3>

          <p></p><div class="highlight">
          <pre><span class="c1"># Destroy all command.</span>
          <span class="nx">collections</span><span class="p">[</span><span class="s">"people"</span><span class="p">].</span><span class="nx">remove</span>

          <span class="c1"># Destroy all matching command.</span>
          <span class="nx">collections</span><span class="p">[</span><span class="s">"people"</span><span class="p">].</span><span class="nx">remove</span><span class="p">(</span><span class="s">"firstName"</span> <span class="o">:</span> <span class="s">"Heinrich"</span><span class="p">)</span>
          </pre>
          </div>


          <h2><code>Model.update</code></h2>

          <p></p><div class="highlight">
          <pre><span class="nx">User</span><span class="p">.</span><span class="nx">update</span> <span class="mi">1</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="mi">3</span><span class="p">,</span> <span class="nv">name: </span><span class="s">"John"</span><span class="p">,</span> <span class="p">(</span><span class="nx">error</span><span class="p">,</span> <span class="nx">records</span><span class="p">)</span>
          <span class="nx">User</span><span class="p">.</span><span class="nx">update</span> <span class="mi">1</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="mi">3</span><span class="p">,</span> <span class="nv">name: </span><span class="s">"John"</span><span class="p">,</span> <span class="p">(</span><span class="nx">error</span><span class="p">)</span>
          <span class="nx">User</span><span class="p">.</span><span class="nx">update</span> <span class="p">[</span><span class="mi">1</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="mi">3</span><span class="p">],</span> <span class="nv">name: </span><span class="s">"John"</span><span class="p">,</span> <span class="p">(</span><span class="nx">error</span><span class="p">,</span> <span class="nx">records</span><span class="p">)</span>
          <span class="nx">User</span><span class="p">.</span><span class="nx">update</span> <span class="p">[</span><span class="mi">1</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="mi">3</span><span class="p">],</span> <span class="nv">name: </span><span class="s">"John"</span><span class="p">,</span> <span class="p">(</span><span class="nx">error</span><span class="p">)</span>
          <span class="nx">User</span><span class="p">.</span><span class="nx">update</span> <span class="nv">name: </span><span class="s">"John"</span><span class="p">,</span> <span class="p">(</span><span class="nx">error</span><span class="p">,</span> <span class="nx">records</span><span class="p">)</span>
          <span class="nx">User</span><span class="p">.</span><span class="nx">update</span> <span class="nv">name: </span><span class="s">"John"</span><span class="p">,</span> <span class="p">(</span><span class="nx">error</span><span class="p">)</span>
          <span class="nx">User</span><span class="p">.</span><span class="nx">update</span> <span class="mi">1</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="mi">3</span><span class="p">,</span> <span class="p">{</span><span class="nv">name: </span><span class="s">"John"</span><span class="p">},</span> <span class="p">{</span><span class="nv">instantiate: </span><span class="kc">false</span><span class="p">,</span> <span class="nv">validate: </span><span class="kc">false</span><span class="p">},</span> <span class="p">(</span><span class="nx">error</span><span class="p">)</span>
          <span class="nx">User</span><span class="p">.</span><span class="nx">update</span> <span class="p">{</span><span class="nv">name: </span><span class="s">"John"</span><span class="p">},</span> <span class="p">{</span><span class="nv">instantiate: </span><span class="kc">false</span><span class="p">,</span> <span class="nv">validate: </span><span class="kc">false</span><span class="p">},</span> <span class="p">(</span><span class="nx">error</span><span class="p">)</span>
          </pre>
          </div>
          """
        else
          text """
          <blockquote>
          <p>Full Stack Web Framework for Node.js and the Browser.</p>
          </blockquote>
          <p>Built on top of Node's Connect and Express, modeled after Ruby on Rails.  Built for the client and server from the ground up.</p>

          <p>Includes a database-agnostic ORM with browser (memory) and MongoDB support, modeled after ActiveRecord and Mongoid for Ruby.  Includes a controller architecture that works the same on both the client and server, modeled after Rails.  The routing API is pretty much exactly like Rails 3's.  Templates work on client and server as well (and you can swap in any template engine no problem).  Includes asset pipeline that works just like Rails 3's - minifies and gzips assets with an md5-hashed name for optimal browser caching, only if you so desire.  And it includes a watcher that automatically injects javascripts and stylesheets into the browser as you develop.  It solves a lot of our problems, hope it solves yours too.  If not, let me know!</p>

          <p>More docs in the docs section on <a href="http://towerjs.org">towerjs.org</a>.  Docs are a work in progress.</p>

          <h2>Install</h2>

          <div class="highlight">
          <pre>npm install tower -g
          </pre>
          </div>


          <h2>Generator</h2>

          <div class="highlight">
          <pre>tower new app
          <span class="nb">cd </span>app
          tower generate scaffold Post title:string body:text belongsTo:user
          tower generate scaffold User email:string firstName:string lastName:string hasMany:posts
          </pre>
          </div>


          <h2>Structure</h2>

          <p>Here's how you might organize a blog:</p>

          <div class="highlight">
          <pre>.
          |-- app
          |   |-- controllers
          |   |   |-- admin
          |   |   |   |-- postsController.coffee
          |   |   |   <span class="sb">`</span>-- usersController.coffee
          |   |   |-- commentsController.coffee
          |   |   |-- postsController.coffee
          |   |   |-- sessionsController.coffee
          |   |   <span class="sb">`</span>-- usersController.coffee
          |   |-- models
          |   |   |-- post.coffee
          |   |   <span class="sb">`</span>-- user.coffee
          |   |-- views
          |   |   |-- admin
          |   |   |   <span class="sb">`</span>-- posts
          |   |   |       |-- _form.coffee
          |   |   |       |-- edit.coffee
          |   |   |       |-- index.coffee
          |   |   |       |-- new.coffee
          |   |   |       |-- show.coffee
          |   |   |-- layouts
          |   |   |   <span class="sb">`</span>-- application.coffee
          |   |   |-- shared
          |   |   <span class="sb">`</span>-- posts
          |   |       |-- index.coffee
          |   |       <span class="sb">`</span>-- show.coffee
          |   <span class="sb">`</span>-- helpers
          |       |-- admin
          |       |   |-- postsHelper.coffee
          |       |   <span class="sb">`</span>-- tagsHelper.coffee
          |       <span class="sb">`</span>-- postsHelper.coffee
          <span class="sb">`</span>-- config
          |    |-- application.coffee
          |    |-- locale
          |        <span class="sb">`</span>-- en.coffee
          |    |-- routes.coffee
          <span class="sb">`</span>-- spec
          |    |-- helper.coffee
          |    |-- models
          |    |   |-- postSpec.coffee
          |    |   |-- userSpec.coffee
          |    <span class="sb">`</span>-- acceptance
          |        |-- login.coffee
          |        |-- signup.coffee
          |        <span class="sb">`</span>-- posts.coffee
          </pre>
          </div>


          <h2>Application</h2>

          <div class="highlight">
          <pre><span class="c1"># config/application.coffee</span>
          <span class="k">class</span> <span class="nx">App</span> <span class="k">extends</span> <span class="nx">Tower</span><span class="p">.</span><span class="nx">Application</span>
            <span class="nx">@configure</span> <span class="o">-&gt;</span>
              <span class="nx">@use</span> <span class="s">"favicon"</span><span class="p">,</span> <span class="nx">Tower</span><span class="p">.</span><span class="nx">publicPath</span> <span class="o">+</span> <span class="s">"/favicon.ico"</span>
              <span class="nx">@use</span> <span class="s">"static"</span><span class="p">,</span>  <span class="nx">Tower</span><span class="p">.</span><span class="nx">publicPath</span><span class="p">,</span> <span class="nv">maxAge: </span><span class="nx">Tower</span><span class="p">.</span><span class="nx">publicCacheDuration</span>
              <span class="nx">@use</span> <span class="s">"profiler"</span> <span class="k">if</span> <span class="nx">Tower</span><span class="p">.</span><span class="nx">env</span> <span class="o">!=</span> <span class="s">"production"</span>
              <span class="nx">@use</span> <span class="s">"logger"</span>
              <span class="nx">@use</span> <span class="s">"query"</span>
              <span class="nx">@use</span> <span class="s">"cookieParser"</span><span class="p">,</span> <span class="nx">Tower</span><span class="p">.</span><span class="nx">session</span><span class="p">.</span><span class="nx">secret</span>
              <span class="nx">@use</span> <span class="s">"session"</span><span class="p">,</span> <span class="nx">Tower</span><span class="p">.</span><span class="nx">session</span><span class="p">.</span><span class="nx">key</span>
              <span class="nx">@use</span> <span class="s">"bodyParser"</span>
              <span class="nx">@use</span> <span class="s">"csrf"</span>
              <span class="nx">@use</span> <span class="s">"methodOverride"</span><span class="p">,</span> <span class="s">"_method"</span>
              <span class="nx">@use</span> <span class="nx">Tower</span><span class="p">.</span><span class="nx">Middleware</span><span class="p">.</span><span class="nx">Agent</span>
              <span class="nx">@use</span> <span class="nx">Tower</span><span class="p">.</span><span class="nx">Middleware</span><span class="p">.</span><span class="nx">Location</span>
              <span class="nx">@use</span> <span class="nx">Tower</span><span class="p">.</span><span class="nx">Middleware</span><span class="p">.</span><span class="nx">Router</span>

          <span class="nv">module.exports = global.App = </span><span class="nx">App</span>
          </pre>
          </div>


          <h2>Models</h2>

          <div class="highlight">
          <pre><span class="k">class</span> <span class="nx">App</span><span class="p">.</span><span class="nx">Post</span> <span class="k">extends</span> <span class="nx">Tower</span><span class="p">.</span><span class="nx">Model</span>
            <span class="nx">@field</span> <span class="s">"title"</span>
            <span class="nx">@field</span> <span class="s">"body"</span>
            <span class="nx">@field</span> <span class="s">"tags"</span><span class="p">,</span> <span class="nv">type: </span><span class="p">[</span><span class="s">"String"</span><span class="p">],</span> <span class="nv">default: </span><span class="p">[]</span>
            <span class="nx">@field</span> <span class="s">"slug"</span>

            <span class="nx">@key</span> <span class="s">"slug"</span>

            <span class="nx">@belongsTo</span> <span class="s">"author"</span><span class="p">,</span> <span class="nv">type: </span><span class="s">"User"</span>

            <span class="nx">@hasMany</span> <span class="s">"comments"</span><span class="p">,</span> <span class="nv">as: </span><span class="s">"commentable"</span>
            <span class="nx">@hasMany</span> <span class="s">"commenters"</span><span class="p">,</span> <span class="nv">through: </span><span class="s">"comments"</span><span class="p">,</span> <span class="nv">source: </span><span class="s">"author"</span>

            <span class="nx">@before</span> <span class="s">"validate"</span><span class="p">,</span> <span class="s">"slugify"</span>

            <span class="nv">slugify: </span><span class="o">-&gt;</span>
              <span class="vi">@slug = </span><span class="nx">@title</span><span class="p">.</span><span class="nx">replace</span><span class="p">(</span><span class="sr">/^[a-z0-9]+/g</span><span class="p">,</span> <span class="s">"-"</span><span class="p">).</span><span class="nx">toLowerCase</span><span class="p">()</span>

          <span class="k">class</span> <span class="nx">App</span><span class="p">.</span><span class="nx">Comment</span> <span class="k">extends</span> <span class="nx">Tower</span><span class="p">.</span><span class="nx">Model</span>
            <span class="nx">@field</span> <span class="s">"message"</span>

            <span class="nx">@belongsTo</span> <span class="s">"author"</span><span class="p">,</span> <span class="nv">type: </span><span class="s">"User"</span>
            <span class="nx">@belongsTo</span> <span class="s">"commentable"</span><span class="p">,</span> <span class="nv">polymorphic: </span><span class="kc">true</span>

          <span class="k">class</span> <span class="nx">App</span><span class="p">.</span><span class="nx">User</span> <span class="k">extends</span> <span class="nx">Tower</span><span class="p">.</span><span class="nx">Model</span>
            <span class="nx">@field</span> <span class="s">"firstName"</span>
            <span class="nx">@field</span> <span class="s">"lastName"</span>
            <span class="nx">@field</span> <span class="s">"email"</span>
            <span class="nx">@field</span> <span class="s">"activatedAt"</span><span class="p">,</span> <span class="nv">type: </span><span class="s">"Date"</span><span class="p">,</span> <span class="nv">default: </span><span class="o">-&gt;</span> <span class="k">new</span> <span class="nb">Date</span><span class="p">()</span>

            <span class="nx">@hasOne</span> <span class="s">"address"</span><span class="p">,</span> <span class="nv">embed: </span><span class="kc">true</span>

            <span class="nx">@hasMany</span> <span class="s">"posts"</span>
            <span class="nx">@hasmany</span> <span class="s">"comments"</span><span class="p">,</span> <span class="nv">through: </span><span class="s">"posts"</span>

            <span class="nx">@scope</span> <span class="s">"thisWeek"</span><span class="p">,</span> <span class="o">-&gt;</span> <span class="nx">@where</span><span class="p">(</span><span class="nv">createdAt: </span><span class="s">"&gt;="</span><span class="o">:</span> <span class="o">-&gt;</span> <span class="nx">require</span><span class="p">(</span><span class="s">'moment'</span><span class="p">)().</span><span class="nx">subtract</span><span class="p">(</span><span class="s">'days'</span><span class="p">,</span> <span class="mi">7</span><span class="p">))</span>

            <span class="nx">@validate</span> <span class="s">"firstName"</span><span class="p">,</span> <span class="nv">presence: </span><span class="kc">true</span>

            <span class="nx">@after</span> <span class="s">"create"</span><span class="p">,</span> <span class="s">"welcome"</span>

            <span class="nv">welcome: </span><span class="o">-&gt;</span>
              <span class="nx">Tower</span><span class="p">.</span><span class="nx">Mailer</span><span class="p">.</span><span class="nx">welcome</span><span class="p">(</span><span class="nx">@</span><span class="p">).</span><span class="nx">deliver</span><span class="p">()</span>

          <span class="k">class</span> <span class="nx">App</span><span class="p">.</span><span class="nx">Address</span> <span class="k">extends</span> <span class="nx">Tower</span><span class="p">.</span><span class="nx">Model</span>
            <span class="nx">@field</span> <span class="s">"street"</span>
            <span class="nx">@field</span> <span class="s">"city"</span>
            <span class="nx">@field</span> <span class="s">"state"</span>
            <span class="nx">@field</span> <span class="s">"zip"</span>
            <span class="nx">@field</span> <span class="s">"coordinates"</span><span class="p">,</span> <span class="nv">type: </span><span class="s">"Geo"</span>

            <span class="nx">@belongsTo</span> <span class="s">"user"</span><span class="p">,</span> <span class="nv">embed: </span><span class="kc">true</span>
          </pre>
          </div>


          <h3>Chainable Scopes, Queries, and Pagination</h3>

          <div class="highlight">
          <pre><span class="nx">User</span>
            <span class="p">.</span><span class="nx">where</span><span class="p">(</span><span class="nv">createdAt: </span><span class="s">"&gt;="</span><span class="o">:</span> <span class="nx">_</span><span class="p">(</span><span class="mi">2</span><span class="p">).</span><span class="nx">days</span><span class="p">().</span><span class="nx">ago</span><span class="p">(),</span> <span class="s">"&lt;="</span><span class="o">:</span> <span class="k">new</span> <span class="nb">Date</span><span class="p">())</span>
            <span class="p">.</span><span class="nx">within</span><span class="p">(</span><span class="nv">radius: </span><span class="mi">2</span><span class="p">)</span>
            <span class="p">.</span><span class="nx">desc</span><span class="p">(</span><span class="s">"createdAt"</span><span class="p">)</span>
            <span class="p">.</span><span class="nx">asc</span><span class="p">(</span><span class="s">"firstName"</span><span class="p">)</span>
            <span class="p">.</span><span class="nx">paginate</span><span class="p">(</span><span class="nv">page: </span><span class="mi">5</span><span class="p">)</span>
            <span class="p">.</span><span class="nx">all</span><span class="p">()</span>
          </pre>
          </div>


          <h3>Associations</h3>

          <div class="highlight">
          <pre><span class="nv">user = </span><span class="nx">User</span><span class="p">.</span><span class="nx">first</span><span class="p">()</span>

          <span class="c1"># hasMany "posts"</span>
          <span class="nv">posts = </span><span class="nx">user</span><span class="p">.</span><span class="nx">posts</span><span class="p">().</span><span class="nx">where</span><span class="p">(</span><span class="nv">title: </span><span class="s">"First Post"</span><span class="p">).</span><span class="nx">first</span><span class="p">()</span>
          <span class="nv">post  = </span><span class="nx">user</span><span class="p">.</span><span class="nx">posts</span><span class="p">().</span><span class="nx">build</span><span class="p">(</span><span class="nv">title: </span><span class="s">"A Post!"</span><span class="p">)</span>
          <span class="nv">post  = </span><span class="nx">user</span><span class="p">.</span><span class="nx">posts</span><span class="p">().</span><span class="nx">create</span><span class="p">(</span><span class="nv">title: </span><span class="s">"A Saved Post!"</span><span class="p">)</span>
          <span class="nv">posts = </span><span class="nx">user</span><span class="p">.</span><span class="nx">posts</span><span class="p">().</span><span class="nx">all</span><span class="p">()</span>

          <span class="c1"># hasMany "comments", through: "posts"</span>
          <span class="nv">comments  = </span><span class="nx">user</span><span class="p">.</span><span class="nx">comments</span><span class="p">().</span><span class="nx">where</span><span class="p">(</span><span class="nv">message: </span><span class="sr">/(javascript)/</span><span class="p">).</span><span class="nx">limit</span><span class="p">(</span><span class="mi">10</span><span class="p">).</span><span class="nx">all</span><span class="p">()</span>

          <span class="c1"># eager load associations</span>
          <span class="nx">Post</span><span class="p">.</span><span class="nx">includes</span><span class="p">(</span><span class="s">"author"</span><span class="p">).</span><span class="nx">where</span><span class="p">(</span><span class="nv">author: firstName: </span><span class="s">"=~"</span><span class="o">:</span> <span class="s">"Baldwin"</span><span class="p">).</span><span class="nx">all</span><span class="p">()</span>
          <span class="nx">Post</span><span class="p">.</span><span class="nx">includes</span><span class="p">(</span><span class="s">"author"</span><span class="p">).</span><span class="nx">where</span><span class="p">(</span><span class="s">"author.firstName"</span><span class="o">:</span> <span class="s">"=~"</span><span class="o">:</span> <span class="s">"Baldwin"</span><span class="p">).</span><span class="nx">all</span><span class="p">()</span>
          <span class="nx">User</span><span class="p">.</span><span class="nx">includes</span><span class="p">(</span><span class="s">"posts"</span><span class="p">).</span><span class="nx">where</span><span class="p">(</span><span class="s">"posts.title"</span><span class="o">:</span> <span class="s">"Welcome"</span><span class="p">).</span><span class="nx">all</span><span class="p">()</span>
          </pre>
          </div>


          <h3>Validations</h3>

          <div class="highlight">
          <pre><span class="nv">user = </span><span class="k">new</span> <span class="nx">User</span>
          <span class="nx">user</span><span class="p">.</span><span class="nx">save</span><span class="p">()</span> <span class="c1">#=&gt; false</span>
          <span class="nx">user</span><span class="p">.</span><span class="nx">errors</span> <span class="c1">#=&gt; {"email": ["Email must be present"]}</span>
          <span class="nv">user.email  = </span><span class="s">"me@gmail.com"</span>
          <span class="nx">user</span><span class="p">.</span><span class="nx">save</span><span class="p">()</span> <span class="c1">#=&gt; true</span>
          <span class="nx">user</span><span class="p">.</span><span class="nx">errors</span> <span class="c1">#=&gt; {}</span>
          </pre>
          </div>


          <h2>Routes</h2>

          <div class="highlight">
          <pre><span class="c1"># config/routes.coffee</span>
          <span class="nx">Tower</span><span class="p">.</span><span class="nx">Route</span><span class="p">.</span><span class="nx">draw</span> <span class="o">-&gt;</span>
            <span class="nx">@match</span> <span class="s">"/login"</span><span class="p">,</span> <span class="s">"sessions</span><span class="err">#</span><span class="s">new"</span><span class="p">,</span> <span class="nv">via: </span><span class="s">"get"</span><span class="p">,</span> <span class="nv">as: </span><span class="s">"login"</span>
            <span class="nx">@match</span> <span class="s">"/logout"</span><span class="p">,</span> <span class="s">"sessions</span><span class="err">#</span><span class="s">destroy"</span><span class="p">,</span> <span class="nv">via: </span><span class="s">"get"</span><span class="p">,</span> <span class="nv">as: </span><span class="s">"logout"</span>

            <span class="nx">@resources</span> <span class="s">"posts"</span><span class="p">,</span> <span class="o">-&gt;</span>
              <span class="nx">@resources</span> <span class="s">"comments"</span>

            <span class="nx">@namespace</span> <span class="s">"admin"</span><span class="p">,</span> <span class="o">-&gt;</span>
              <span class="nx">@resources</span> <span class="s">"users"</span>
              <span class="nx">@resources</span> <span class="s">"posts"</span><span class="p">,</span> <span class="o">-&gt;</span>
                <span class="nx">@resources</span> <span class="s">"comments"</span>

            <span class="nx">@constraints</span> <span class="nv">subdomain: </span><span class="sr">/^api$/</span><span class="p">,</span> <span class="o">-&gt;</span>
              <span class="nx">@resources</span> <span class="s">"posts"</span><span class="p">,</span> <span class="o">-&gt;</span>
                <span class="nx">@resources</span> <span class="s">"comments"</span>

            <span class="nx">@match</span> <span class="s">"(/*path)"</span><span class="p">,</span> <span class="nv">to: </span><span class="s">"application</span><span class="err">#</span><span class="s">index"</span><span class="p">,</span> <span class="nv">via: </span><span class="s">"get"</span>
          </pre>
          </div>


          <p>Routes are really just models, <code>Tower.Route</code>.  You can add and remove and search them however you like:</p>

          <div class="highlight">
          <pre><span class="nx">Tower</span><span class="p">.</span><span class="nx">Route</span><span class="p">.</span><span class="nx">where</span><span class="p">(</span><span class="nv">pattern: </span><span class="s">"=~"</span><span class="o">:</span> <span class="s">"/posts"</span><span class="p">).</span><span class="nx">first</span><span class="p">()</span>
          </pre>
          </div>


          <h2>Views</h2>

          <h3>Forms</h3>

          <div class="highlight">
          <pre><span class="c1"># app/views/posts/new.coffee</span>
          <span class="nx">formFor</span> <span class="s">"post"</span><span class="p">,</span> <span class="nf">(f) -&gt;</span>
            <span class="nx">f</span><span class="p">.</span><span class="nx">fieldset</span> <span class="nf">(fields) -&gt;</span>
              <span class="nx">fields</span><span class="p">.</span><span class="nx">field</span> <span class="s">"title"</span><span class="p">,</span> <span class="nv">as: </span><span class="s">"string"</span>
              <span class="nx">fields</span><span class="p">.</span><span class="nx">field</span> <span class="s">"body"</span><span class="p">,</span> <span class="nv">as: </span><span class="s">"text"</span>

            <span class="nx">f</span><span class="p">.</span><span class="nx">fieldset</span> <span class="nf">(fields) -&gt;</span>
              <span class="nx">fields</span><span class="p">.</span><span class="nx">submit</span> <span class="s">"Submit"</span>
          </pre>
          </div>


          <h3>Tables</h3>

          <div class="highlight">
          <pre><span class="c1"># app/views/posts/index.coffee</span>
          <span class="nx">tableFor</span> <span class="s">"posts"</span><span class="p">,</span> <span class="nf">(t) -&gt;</span>
            <span class="nx">t</span><span class="p">.</span><span class="nx">head</span> <span class="o">-&gt;</span>
              <span class="nx">t</span><span class="p">.</span><span class="nx">row</span> <span class="o">-&gt;</span>
                <span class="nx">t</span><span class="p">.</span><span class="nx">cell</span> <span class="s">"title"</span><span class="p">,</span> <span class="nv">sort: </span><span class="kc">true</span>
                <span class="nx">t</span><span class="p">.</span><span class="nx">cell</span> <span class="s">"body"</span><span class="p">,</span> <span class="nv">sort: </span><span class="kc">true</span>
                <span class="nx">t</span><span class="p">.</span><span class="nx">cell</span><span class="p">()</span>
                <span class="nx">t</span><span class="p">.</span><span class="nx">cell</span><span class="p">()</span>
                <span class="nx">t</span><span class="p">.</span><span class="nx">cell</span><span class="p">()</span>
            <span class="nx">t</span><span class="p">.</span><span class="nx">body</span> <span class="o">-&gt;</span>
              <span class="k">for</span> <span class="nx">post</span> <span class="k">in</span> <span class="nx">@posts</span>
                <span class="nx">t</span><span class="p">.</span><span class="nx">row</span> <span class="o">-&gt;</span>
                  <span class="nx">t</span><span class="p">.</span><span class="nx">cell</span> <span class="nx">post</span><span class="p">.</span><span class="nx">get</span><span class="p">(</span><span class="s">"title"</span><span class="p">)</span>
                  <span class="nx">t</span><span class="p">.</span><span class="nx">cell</span> <span class="nx">post</span><span class="p">.</span><span class="nx">get</span><span class="p">(</span><span class="s">"body"</span><span class="p">)</span>
                  <span class="nx">t</span><span class="p">.</span><span class="nx">cell</span> <span class="nx">linkTo</span> <span class="s">'Show'</span><span class="p">,</span> <span class="nx">post</span>
                  <span class="nx">t</span><span class="p">.</span><span class="nx">cell</span> <span class="nx">linkTo</span> <span class="s">'Edit'</span><span class="p">,</span> <span class="nx">editPostPath</span><span class="p">(</span><span class="nx">post</span><span class="p">)</span>
                  <span class="nx">t</span><span class="p">.</span><span class="nx">cell</span> <span class="nx">linkTo</span> <span class="s">'Destroy'</span><span class="p">,</span> <span class="nx">post</span><span class="p">,</span> <span class="nv">method: </span><span class="s">"delete"</span>
            <span class="nx">linkTo</span> <span class="s">'New Post'</span><span class="p">,</span> <span class="nx">newPostPath</span><span class="p">()</span>
          </pre>
          </div>


          <h3>Layouts</h3>

          <div class="highlight">
          <pre><span class="c1"># app/views/layouts/application.coffee</span>
          <span class="nx">doctype</span> <span class="mi">5</span>
          <span class="nx">html</span> <span class="o">-&gt;</span>
            <span class="nx">head</span> <span class="o">-&gt;</span>
              <span class="nx">meta</span> <span class="nv">charset: </span><span class="s">"utf-8"</span>

              <span class="nx">title</span> <span class="nx">t</span><span class="p">(</span><span class="s">"title"</span><span class="p">)</span>

              <span class="nx">meta</span> <span class="nv">name: </span><span class="s">"description"</span><span class="p">,</span> <span class="nv">content: </span><span class="nx">t</span><span class="p">(</span><span class="s">"description"</span><span class="p">)</span>
              <span class="nx">meta</span> <span class="nv">name: </span><span class="s">"keywords"</span><span class="p">,</span> <span class="nv">content: </span><span class="nx">t</span><span class="p">(</span><span class="s">"keywords"</span><span class="p">)</span>
              <span class="nx">meta</span> <span class="nv">name: </span><span class="s">"robots"</span><span class="p">,</span> <span class="nv">content: </span><span class="nx">t</span><span class="p">(</span><span class="s">"robots"</span><span class="p">)</span>
              <span class="nx">meta</span> <span class="nv">name: </span><span class="s">"author"</span><span class="p">,</span> <span class="nv">content: </span><span class="nx">t</span><span class="p">(</span><span class="s">"author"</span><span class="p">)</span>

              <span class="nx">csrfMetaTag</span><span class="p">()</span>

              <span class="nx">appleViewportMetaTag</span> <span class="nv">width: </span><span class="s">"device-width"</span><span class="p">,</span> <span class="nv">max: </span><span class="mi">1</span><span class="p">,</span> <span class="nv">scalable: </span><span class="kc">false</span>

              <span class="nx">stylesheets</span> <span class="s">"lib"</span><span class="p">,</span> <span class="s">"vendor"</span><span class="p">,</span> <span class="s">"application"</span>

              <span class="nx">javascriptTag</span> <span class="s">"https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"</span>
              <span class="nx">javascripts</span> <span class="s">"vendor"</span><span class="p">,</span> <span class="s">"lib"</span><span class="p">,</span> <span class="s">"application"</span>

            <span class="nx">body</span> <span class="nv">role: </span><span class="s">"application"</span><span class="p">,</span> <span class="o">-&gt;</span>
              <span class="k">if</span> <span class="nx">hasContentFor</span> <span class="s">"templates"</span>
                <span class="nx">yield</span> <span class="s">"templates"</span>

              <span class="nx">nav</span> <span class="nv">id: </span><span class="s">"navigation"</span><span class="p">,</span> <span class="nv">role: </span><span class="s">"navigation"</span><span class="p">,</span> <span class="o">-&gt;</span>
                <span class="nx">div</span> <span class="k">class</span><span class="o">:</span> <span class="s">"frame"</span><span class="p">,</span> <span class="o">-&gt;</span>
                  <span class="nx">partial</span> <span class="s">"shared/navigation"</span>

              <span class="nx">header</span> <span class="nv">id: </span><span class="s">"header"</span><span class="p">,</span> <span class="nv">role: </span><span class="s">"banner"</span><span class="p">,</span> <span class="o">-&gt;</span>
                <span class="nx">div</span> <span class="k">class</span><span class="o">:</span> <span class="s">"frame"</span><span class="p">,</span> <span class="o">-&gt;</span>
                  <span class="nx">partial</span> <span class="s">"shared/header"</span>

              <span class="nx">section</span> <span class="nv">id: </span><span class="s">"body"</span><span class="p">,</span> <span class="nv">role: </span><span class="s">"main"</span><span class="p">,</span> <span class="o">-&gt;</span>
                <span class="nx">div</span> <span class="k">class</span><span class="o">:</span> <span class="s">"frame"</span><span class="p">,</span> <span class="o">-&gt;</span>
                  <span class="nx">yields</span> <span class="s">"body"</span>
                  <span class="nx">aside</span> <span class="nv">id: </span><span class="s">"sidebar"</span><span class="p">,</span> <span class="nv">role: </span><span class="s">"complementary"</span><span class="p">,</span> <span class="o">-&gt;</span>
                    <span class="k">if</span> <span class="nx">hasContentFor</span> <span class="s">"sidebar"</span>
                      <span class="nx">yields</span> <span class="s">"sidebar"</span>

              <span class="nx">footer</span> <span class="nv">id: </span><span class="s">"footer"</span><span class="p">,</span> <span class="nv">role: </span><span class="s">"contentinfo"</span><span class="p">,</span> <span class="o">-&gt;</span>
                <span class="nx">div</span> <span class="k">class</span><span class="o">:</span> <span class="s">"frame"</span><span class="p">,</span> <span class="o">-&gt;</span>
                  <span class="nx">partial</span> <span class="s">"shared/footer"</span>

            <span class="k">if</span> <span class="nx">hasContentFor</span> <span class="s">"popups"</span>
              <span class="nx">aside</span> <span class="nv">id: </span><span class="s">"popups"</span><span class="p">,</span> <span class="o">-&gt;</span>
                <span class="nx">yields</span> <span class="s">"popups"</span>

            <span class="k">if</span> <span class="nx">hasContentFor</span> <span class="s">"bottom"</span>
              <span class="nx">yields</span> <span class="s">"bottom"</span>
          </pre>
          </div>


          <p>The default templating engine is <a href="http://coffeekup.org/">CoffeeKup</a>, which is pure coffeescript.  It's much more powerful than Jade, and it's just as performant if not more so.  You can set Jade or any other templating engine as the default by setting <code>Tower.View.engine = "jade"</code> in <code>config/application</code>.  Tower uses <a href="http://github.com/viatropos/shift.js">Shift.js</a>, which is a normalized interface to most of the Node.js templating languages.</p>

          <h2>Controllers</h2>

          <div class="highlight">
          <pre><span class="k">class</span> <span class="nx">PostsController</span> <span class="k">extends</span> <span class="nx">Tower</span><span class="p">.</span><span class="nx">Controller</span>
            <span class="nv">index: </span><span class="o">-&gt;</span>
              <span class="vi">@posts = </span><span class="nx">Post</span><span class="p">.</span><span class="nx">all</span><span class="p">()</span>

            <span class="k">new</span><span class="o">:</span> <span class="o">-&gt;</span>
              <span class="vi">@post = </span><span class="k">new</span> <span class="nx">Post</span>

            <span class="nv">create: </span><span class="o">-&gt;</span>
              <span class="vi">@post = </span><span class="k">new</span> <span class="nx">Post</span><span class="p">(</span><span class="nx">@params</span><span class="p">.</span><span class="nx">post</span><span class="p">)</span>

              <span class="k">super</span> <span class="nf">(success, failure) -&gt;</span>
                <span class="nx">@success</span><span class="p">.</span><span class="nx">html</span> <span class="o">-&gt;</span> <span class="nx">@render</span> <span class="s">"posts/edit"</span>
                <span class="nx">@success</span><span class="p">.</span><span class="nx">json</span> <span class="o">-&gt;</span> <span class="nx">@render</span> <span class="nv">text: </span><span class="s">"success!"</span>
                <span class="nx">@failure</span><span class="p">.</span><span class="nx">html</span> <span class="o">-&gt;</span> <span class="nx">@render</span> <span class="nv">text: </span><span class="s">"Error"</span><span class="p">,</span> <span class="nv">status: </span><span class="mi">404</span>
                <span class="nx">@failure</span><span class="p">.</span><span class="nx">json</span> <span class="o">-&gt;</span> <span class="nx">@render</span> <span class="nv">text: </span><span class="s">"Error"</span><span class="p">,</span> <span class="nv">status: </span><span class="mi">404</span>

            <span class="nv">show: </span><span class="o">-&gt;</span>
              <span class="vi">@post = </span><span class="nx">Post</span><span class="p">.</span><span class="nx">find</span><span class="p">(</span><span class="nx">@params</span><span class="p">.</span><span class="nx">id</span><span class="p">)</span>

            <span class="nv">edit: </span><span class="o">-&gt;</span>
              <span class="vi">@post = </span><span class="nx">Post</span><span class="p">.</span><span class="nx">find</span><span class="p">(</span><span class="nx">@params</span><span class="p">.</span><span class="nx">id</span><span class="p">)</span>

            <span class="nv">update: </span><span class="o">-&gt;</span>
              <span class="vi">@post = </span><span class="nx">Post</span><span class="p">.</span><span class="nx">find</span><span class="p">(</span><span class="nx">@params</span><span class="p">.</span><span class="nx">id</span><span class="p">)</span>

            <span class="nv">destroy: </span><span class="o">-&gt;</span>
              <span class="vi">@post = </span><span class="nx">Post</span><span class="p">.</span><span class="nx">find</span><span class="p">(</span><span class="nx">@params</span><span class="p">.</span><span class="nx">id</span><span class="p">)</span>
          </pre>
          </div>


          <p>Actually, all that's built in!  So for the simple case you don't even need to write anything in your controllers (skinny controllers, fat models).</p>

          <h2>Databases</h2>

          <div class="highlight">
          <pre><span class="c1"># config/databases.coffee</span>
          <span class="nv">module.exports =</span>
            <span class="nv">mongodb:</span>
              <span class="nv">development:</span>
                <span class="nv">name: </span><span class="s">"app-development"</span>
                <span class="nv">port: </span><span class="mi">27017</span>
                <span class="nv">host: </span><span class="s">"127.0.0.1"</span>
              <span class="nv">test:</span>
                <span class="nv">name: </span><span class="s">"app-test"</span>
                <span class="nv">port: </span><span class="mi">27017</span>
                <span class="nv">host: </span><span class="s">"127.0.0.1"</span>
              <span class="nv">staging:</span>
                <span class="nv">name: </span><span class="s">"app-staging"</span>
                <span class="nv">port: </span><span class="mi">27017</span>
                <span class="nv">host: </span><span class="s">"127.0.0.1"</span>
              <span class="nv">production:</span>
                <span class="nv">name: </span><span class="s">"app-production"</span>
                <span class="nv">port: </span><span class="mi">27017</span>
                <span class="nv">host: </span><span class="s">"127.0.0.1"</span>
          </pre>
          </div>


          <h2>Mailers</h2>

          <div class="highlight">
          <pre><span class="k">class</span> <span class="nx">App</span><span class="p">.</span><span class="nx">Notification</span> <span class="k">extends</span> <span class="nx">Tower</span><span class="p">.</span><span class="nx">Mailer</span>
            <span class="c1"># app/views/mailers/welcome.coffee template</span>
            <span class="vi">@welcome: </span><span class="nf">(user) -&gt;</span>
              <span class="nx">@mail</span> <span class="nv">to: </span><span class="nx">user</span><span class="p">.</span><span class="nx">email</span><span class="p">,</span> <span class="nv">from: </span><span class="s">"me@gmail.com"</span>
          </pre>
          </div>


          <h2>Internationalization</h2>

          <div class="highlight">
          <pre><span class="c1"># config/locales/en.coffee</span>
          <span class="nv">module.exports =</span>
            <span class="nv">hello: </span><span class="s">"world"</span>
            <span class="nv">forms:</span>
              <span class="nv">titles:</span>
                <span class="nv">signup: </span><span class="s">"Signup"</span>
            <span class="nv">pages:</span>
              <span class="nv">titles:</span>
                <span class="nv">home: </span><span class="s">"Welcome to %{site}"</span>
            <span class="nv">posts:</span>
              <span class="nv">comments:</span>
                <span class="nv">none: </span><span class="s">"No comments"</span>
                <span class="nv">one: </span><span class="s">"1 comment"</span>
                <span class="nv">other: </span><span class="s">"%{count} comments"</span>
            <span class="nv">messages:</span>
              <span class="nv">past:</span>
                <span class="nv">none: </span><span class="s">"You never had any messages"</span>
                <span class="nv">one: </span><span class="s">"You had 1 message"</span>
                <span class="nv">other: </span><span class="s">"You had %{count} messages"</span>
              <span class="nv">present:</span>
                <span class="nv">one: </span><span class="s">"You have 1 message"</span>
              <span class="nv">future:</span>
                <span class="nv">one: </span><span class="s">"You might have 1 message"</span>
          </pre>
          </div>


          <h2>Helpers</h2>

          <p>Since all of the controller/routing code is available on the client, you can go directly through that system just like you would the server.</p>

          <div class="highlight">
          <pre><span class="c1"># Just request the url, and let it do it's thing</span>
          <span class="nx">Tower</span><span class="p">.</span><span class="nx">get</span> <span class="s">'/posts'</span>

          <span class="c1"># Same thing, this time passing parameters</span>
          <span class="nx">Tower</span><span class="p">.</span><span class="nx">get</span> <span class="s">'/posts'</span><span class="p">,</span> <span class="nv">createdAt: </span><span class="s">"2011-10-26..2011-10-31"</span>

          <span class="c1"># Dynamic</span>
          <span class="nx">Tower</span><span class="p">.</span><span class="nx">urlFor</span><span class="p">(</span><span class="nx">Post</span><span class="p">.</span><span class="nx">first</span><span class="p">())</span> <span class="c1">#=&gt; "/posts/the-id"</span>
          <span class="nx">Tower</span><span class="p">.</span><span class="nx">navigate</span> <span class="nx">Tower</span><span class="p">.</span><span class="nx">urlFor</span><span class="p">(</span><span class="nx">post</span><span class="p">)</span>
          </pre>
          </div>


          <p>Those methods pass through the router and client-side middleware so you have access to <code>request</code> and <code>response</code> objects like you would on the server.</p>

          <h2>Middleware</h2>

          <p>It's built on <a href="http://github.com/sencha/connect">connect</a>, so you can use any of the middleware libs out there.</p>

          <h2>Assets</h2>

          <div class="highlight">
          <pre><span class="c1"># config/assets.coffee</span>
          <span class="nv">module.exports =</span>
            <span class="nv">javascripts:</span>
              <span class="nv">vendor: </span><span class="p">[</span>
                <span class="s">"/vendor/javascripts/jquery.js"</span>
                <span class="s">"/vendor/javascripts/underscore.js"</span>
                <span class="s">"/vendor/javascripts/socket.io"</span>
                <span class="s">"/vendor/javascripts/tower.js"</span>
              <span class="p">]</span>

              <span class="nv">lib: </span><span class="p">[</span>
                <span class="s">"/lib/grid.js"</span>
                <span class="s">"/lib/profiler.js"</span>
              <span class="p">]</span>

              <span class="nv">application: </span><span class="p">[</span>
                <span class="s">"/app/models/post.js"</span>
                <span class="s">"/app/models/comment.js"</span>
              <span class="p">]</span>

            <span class="nv">stylesheets:</span>
              <span class="nv">vendor: </span><span class="p">[</span>
                <span class="s">"/vendor/stylesheets/reset.css"</span>
              <span class="p">]</span>
              <span class="nv">application: </span><span class="p">[</span>
                <span class="s">"/app/assets/stylesheets/application.css"</span>
                <span class="s">"/app/assets/stylesheets/theme.css"</span>
              <span class="p">]</span>
          </pre>
          </div>


          <p>All assets are read from <code>/public</code>, which is the compiled output of everything in <code>/app</code>, <code>/lib</code>, <code>/vendor</code>, and wherever else you might put things.  The default is to use stylus for css in <code>/app/assets/stylesheets</code>.</p>

          <h3>Minify and Gzip</h3>

          <div class="highlight">
          <pre>cake assets:compile
          </pre>
          </div>


          <h3>Push to S3</h3>

          <div class="highlight">
          <pre>cake assets:publish
          </pre>
          </div>


          <h2>Test, Develop, Minify</h2>

          <div class="highlight">
          <pre>cake spec
          cake coffee
          cake minify
          </pre>
          </div>


          <h2>Examples</h2>

          <ul>
          <li><a href="https://github.com/viatropos/towerjs.org">towerjs.org (project site)</a></li>
          </ul><h2>License</h2>

          <p>(The MIT License)</p>

          <p>Copyright © 2012 <a href="http://twitter.com/viatropos">Lance Pollard</a> &lt;<a href="mailto:lancejpollard@gmail.com">lancejpollard@gmail.com</a>&gt;</p>

          <p>Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:</p>

          <p>The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.</p>

          <p>THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.</p>
          """
        
    footer id: "footer", role: "contentinfo", ->
