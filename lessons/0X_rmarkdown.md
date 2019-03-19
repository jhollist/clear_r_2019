

# R Markdown

R Markdown provides the ability for us to combine code and text.  The "Markdown" part of this references the [`markdown`](https://daringfireball.net/projects/markdown/) mark-up language that provides relatively simple text mark-up to format text.  The R part allows us to mix in code chunks with that text.  Together they provide the foundation of reproducible documents that allow us to blend code with explanation. 

After this lesson, you will:

- Gain familiarity with Markdown, `rmarkdown` and `knitr`
- Work with and render an R Markdown document with RStudio

## Lesson Outline
- [YAML](#yaml)
- [Markdown](#markdown)
- [Code chunks](#code-chunks)
- [Rendering](#rendering)

## Exercises
- [Exercise 3.1](#exercise-31)

## YAML

    ---
    title: "My First Reproducible Document"
    author: "Jeff W. Hollister"
    date: "1/6/2015"
    output: pdf_document
    ---

This is what the YAML(YAML Ain't Markup Language) header or front-matter looks like.  It is metadata about the document that can be very useful.  There is a lot more we can do with the YAML.  There are additional fields available for us to you, or we can even create our own.  For our purposes these basic ones are good, but we can also look at the additional built in ones.  The [`rmarkdown` cheatsheet](http://www.rstudio.com/wp-content/uploads/2016/03/rmarkdown-cheatsheet-2.0.pdf) is a good place to look as is the [online documentation for `rmarkdown`](http://rmarkdown.rstudio.com/lesson-1.html).  A lot of the optional ones I use are part of the [output format](http://rmarkdown.rstudio.com/lesson-9.html) 

In our document, `region2_nla_analysis.Rmd` we can see our `YAML` header on lines 1-11.

## Markdown
Markdown isn't R, but it has become an important tool in the R ecosystem as it can be used to create package vignettes, can be used on [GitHub](http://github.com), and forms the basis for several reproducible research tools in RStudio.  Markdown is a tool that allows you to write simply formatted text that is converted to HTML/XHTML.  The primary goal of markdown is readability of the raw file.  Over the last couple of years, Markdown has emerged as a key way to write up reproducible documents, create websites, write documentation (all of these lessons are written in Markdown), and make presentations.  For the basics of markdown and general information look at [Daring Fireball](http://daringfireball.net/projects/markdown/basics).

To get you started, here is some of that same information on the most common markdown you will use: text, headers, lists, links, images, and tables.

### Text

So, for basic text... Just type it!

### Headers

In markdown, there are two ways to do headers but for most of what you need, you can use the following for headers:


    # Header 1
    ## Header 2
    ...
    ###### Header 6
  

### List

Lists can be done many ways in markdown. An unordered list is simply done with a `-`, `+`, or `*`.  For example

- this list
- is produced with
- the following 
- markdown.
    - nested

<pre>    
- this list
- is produced with
- the following 
- markdown
    - nested
</pre> 
    
Notice the space after the `-`.  

To create an ordered list, simply use numbers.  So to produce:

1. this list
2. is produced with
3. the following
4. markdown.
    - nested

<pre>
1. this list
2. is produced with
3. the following
4. markdown.
    - nested
</pre>

### Links and Images

Last type of formatting that you will likely want to accomplish with R markdown is including links and images.  While these two might seem dissimilar, I am including them together as their syntax is nearly identical.

So, to create a link you would use the following:

```
[EPA Region 2](https://www.epa.gov/aboutepa/epa-region-2)
```

Which looks like: [EPA Region 2](https://www.epa.gov/aboutepa/epa-region-2).

The text you want linked goes in the `[]` and the link itself goes in the `()`.  That's it! Now to show an image, you do this:

```
![Lower Manhattan](https://www.epa.gov/sites/production/files/styles/large/public/2015-10/1280px-lower_manhattan_from_jersey_city_november_2014_panorama_41.jpg)
```

And renders like: ![Lower Manhattan](https://www.epa.gov/sites/production/files/styles/large/public/2015-10/1280px-lower_manhattan_from_jersey_city_november_2014_panorama_41.jpg)

The only difference is the use of the `!` at the beginning.  When parsed, the image itself will be included, and not linked text.  As these will be on the web, the images need to also be available via the web.  You can link to local files, but will need to use a path relative to the root of the document you are working on.  Let's not worry about that as it is a bit beyond the scope of this tutorial.

And with this, we can have some real fun.  

![matt foley](https://media.giphy.com/media/n7Nwr10hWzROE/giphy.gif)

### Tables

Markdown has the ability to structure tables as well.  So to get a table like this:

|First Name|Last Name|Favorite Color|
|----------|---------|--------------|
|Cookie    |Monster  |Blue          |
|Big       |Bird     |Yellow        |
|Elmo      |Monster  |Red           |

We use Markdown that looks like this:

<pre>
|First Name|Last Name|Favorite Color|
|----------|---------|--------------|
|Cookie    |Monster  |Blue          |
|Big       |Bird     |Yellow        |
|Elmo      |Monster  |Red           |
</pre>

Coding these tables up by hand only makes sense for the simplest cases, but luckily we have many options for generating tables with R functions.  In our example `region2_nla_analysis.Rmd` we've seen the use of the `DT` package, although since this uses the [DataTables `javascript` library](https://datatables.net/) it will only work for documents with HTML as the output type.  For static non interactive tables there is the `kable()` function from the `knitr` package, there's the [`kableExtra` package](https://cran.r-project.org/web/packages/kableExtra/vignettes/awesome_table_in_html.html) which provides tools for enhanced tables.  There are others as well and a good overview can be seen in [this rOpenSci discussion](https://github.com/ropensci/unconf17/issues/69).  

The nice thing about using R functions to create these is that all of the data we have in R can be output as a table.  For instance:


```r
knitr::kable(iris[sample(nrow(iris),10),],row.names = FALSE)
```



| Sepal.Length| Sepal.Width| Petal.Length| Petal.Width|Species    |
|------------:|-----------:|------------:|-----------:|:----------|
|          6.3|         2.7|          4.9|         1.8|virginica  |
|          5.7|         2.5|          5.0|         2.0|virginica  |
|          6.0|         3.4|          4.5|         1.6|versicolor |
|          7.4|         2.8|          6.1|         1.9|virginica  |
|          5.5|         4.2|          1.4|         0.2|setosa     |
|          5.7|         3.8|          1.7|         0.3|setosa     |
|          5.1|         3.8|          1.6|         0.2|setosa     |
|          6.4|         2.8|          5.6|         2.2|virginica  |
|          4.6|         3.2|          1.4|         0.2|setosa     |
|          6.3|         2.3|          4.4|         1.3|versicolor |

Once we cover data frames, the utility of doing this will hopefully become more clear.

So, now that we know YAML controls the document build process, and we can structure our text with Markdown, we need to add the last step: incorportaing code.

## Code Chunks

As we have mentioned, our documents will all be R Markdown documents (i.e. .Rmd).  To include R Code in your `.Rmd` you would do something like:

<pre>```{r}
x<-rnorm(100)
x<br>```</pre>

This identifies what is known as a code chunk.  When written like it is above, it will echo the code to your final document, evalute the code with R and echo the results to the final document.  There are some cases where you might not want all of this to happen.  You may want just the code returned and not have it evalutated by R.  This is accomplished with:

<pre>```{r eval=FALSE}
x<-rnorm(100)<br>```</pre>

Alternatively, you might just want the output returned, as would be the case when using R Markdown to produce a figure in a presentation or paper:

<pre>```{r echo=FALSE}
x<-rnorm(100)
y<-jitter(x,1000)
plot(x,y)<br>```</pre>
    
Lastly, each of your code chunks can have a label.  That would be accomplished with something like:
    
<pre>```{r myFigure, echo=FALSE}
x<-rnorm(100)
y<-jitter(x,1000)
plot(x,y)<br>```</pre>

Which returns:

![plot of chunk myFigure](figures/myFigure-1.png)

## Rendering

If you look near the top of the editor window you will see:

![knit it](figures/knit.jpg)

Alternatively, we can use the console to do this.


```r
rmarkdown::render("my_rmd.Rmd")
```

## Exercise 3.1 

We now have some tools at our disposal that we can use to start to add information to our `region2_nla_analysis.Rmd` document.  For this exercise add the following at the bottom:

1. Add a new first level header with "Playing around with Markdown" as the text
2. Add three second level headers underneath with the following text: "A bulleted list", "A link", "An animated GIF"
3. Underneath "A bulleted list", add a bulleted list with three items that have your three favorite foods/
4. Underneath "A link" add in a link to the website of your choosing. 
5. Underneath "An animated GIF" add an image using the URL of an animated GIF of your choosing.  You can search for "Animated GIF" at <https://images.google.com>.
6. If you have time, add in a small markdown table.
