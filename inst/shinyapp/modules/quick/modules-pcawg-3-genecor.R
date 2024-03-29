ui.modules_pcawg_gene_cor <- function(id) {
  ns <- NS(id)
  fluidPage(
    fluidRow(
      column(
        3,
        wellPanel(
          h4("1. Data", align = "center"),
          div(actionButton(ns("toggleBtn"), "Modify datasets[opt]",icon = icon("folder-open")),
              style = "margin-bottom: 5px;"),
          conditionalPanel(
            ns = ns,
            condition = "input.toggleBtn % 2 == 1",
            mol_origin_UI(ns("mol_origin2quick"), database = "pcawg")
          ),
          shinyWidgets::prettyRadioButtons(
            inputId = ns("profile1"), label = "Select a genomic profile:",
            choiceValues = c(
              "mRNA", "miRNA",
              "promoter", "fusion", "APOBEC"
            ),
            choiceNames = c(
              "mRNA Expression", "miRNA Expression",
              "Promoter Activity", "Gene Fusion",
              "APOBEC mutagenesis"
            ),
            animation = "jelly"
          ),
          virtualSelectInput(
            inputId = ns("Pancan_search1"),
            label = "Input a gene or formula (as signature)",
            choices = NULL,
            width = "100%",
            search = TRUE,
            allowNewOption = TRUE,
            dropboxWidth = "200%"
          ),
          shinyWidgets::prettyRadioButtons(
            inputId = ns("profile2"), label = "Select a genomic profile:",
            choiceValues = c(
              "mRNA", "miRNA",
              "promoter", "fusion", "APOBEC"
            ),
            choiceNames = c(
              "mRNA Expression", "miRNA Expression",
              "Promoter Activity", "Gene Fusion",
              "APOBEC mutagenesis"
            ),
            animation = "jelly"
          ),
          virtualSelectInput(
            inputId = ns("Pancan_search2"),
            label = "Input a gene or formula (as signature)",
            choices = NULL,
            width = "100%",
            search = TRUE,
            allowNewOption = TRUE,
            dropboxWidth = "200%"
          ),
      )),
      column(
        3,
        wellPanel(
          h4("2. Parameters", align = "center"),
          materialSwitch(ns("purity_adj"), "Adjust Purity", inline = TRUE),
          selectInput(inputId = ns("use_all"), label = "Use All Cancer Types", choices = c("TRUE", "FALSE"), selected = "FALSE"),
          selectInput(
            inputId = ns("dcc_project_code_choose"), label = "Filter Project",
            choices = dcc_project_code_choices,
            selected = "BLCA-US", multiple = TRUE
          ),
          materialSwitch(ns("use_regline"), "Use regression line", inline = TRUE),
          materialSwitch(ns("filter_tumor"), "Use tumor sample only", inline = TRUE),
          selectInput(
            inputId = ns("cor_method"),
            label = "Select Correlation method",
            choices = c("spearman", "pearson"),
            selected = "spearman"
          ),
          sliderTextInput(
            inputId = ns("alpha"),
            label = "Choose a transparent value",
            choices = seq(
              from = 0,
              to = 1,
              by = 0.1
            ),
            selected = "0.5",
            grid = TRUE
          ),
          colourpicker::colourInput(inputId = ns("color"), "Point color", "#000000"),
          tags$hr(style = "border:none; border-top:2px solid #5E81AC;"),
          shinyWidgets::actionBttn(
            inputId = ns("search_bttn"),
            label = "Go!",
            style = "gradient",
            icon = icon("search"),
            color = "primary",
            block = TRUE,
            size = "sm"
          )
        ),
        wellPanel(
          h4("3. Download", align = "center"),
          numericInput(inputId = ns("height"), label = "Height", value = 8),
          numericInput(inputId = ns("width"), label = "Width", value = 8),
          prettyRadioButtons(
            inputId = ns("device"),
            label = "Choose plot format",
            choices = c("pdf", "png"),
            selected = "pdf",
            inline = TRUE,
            icon = icon("check"),
            animation = "jelly",
            fill = TRUE
          ),
          tags$hr(style = "border:none; border-top:2px solid #5E81AC;"),
          downloadBttn(
            outputId = ns("download"),
            style = "gradient",
            color = "primary",
            block = TRUE,
            size = "sm"
          )
        )
      ),
      column(
        6,
        plotOutput(ns("gene_cor"), height = "600px"),
        hr(),
        h5("NOTEs:"),
        p("1. The data query may take some time based on your network. Wait until a plot shows"),
        p("2. You could choose correlation method or whether adjust tumor purity when calculating"),
        p("3. ", tags$a(href = "https://xenabrowser.net/datapages/?cohort=PCAWG%20(specimen%20centric)&removeHub=https%3A%2F%2Fxena.treehouse.gi.ucsc.edu%3A443&removeHub=https%3A%2F%2Fatacseq.xenahubs.net", "Genomic profile data source")),
        tags$br(),
        DT::DTOutput(outputId = ns("tbl")),
        shinyjs::hidden(
          wellPanel(
            id = ns("save_csv"),
            downloadButton(ns("downloadTable"), "Save as csv")
          )
        )
      )
    )
  )
}

server.modules_pcawg_gene_cor <- function(input, output, session) {
  ns <- session$ns

  profile_choices1 <- reactive({
    switch(input$profile1,
      mRNA = list(all = pancan_identifiers$gene, default = "TP53"),
      miRNA = list(all = pancan_identifiers$miRNA, default = "hsa-miR-769-3p"),
      promoter = list(all = names(load_data("pcawg_promoter_id")), default = "1:169863093:SCYL3"),
      fusion = list(all = pancan_identifiers$gene, default = "DPM1"),
      APOBEC = list(all = c(
        "tCa_MutLoad_MinEstimate", "APOBECtCa_enrich",
        "A3A_or_A3B", "APOBEC_tCa_enrich_quartile", "APOBECrtCa_enrich",
        "APOBECytCa_enrich", "APOBECytCa_enrich-APOBECrtCa_enrich",
        "BH_Fisher_p-value_tCa", "ntca+tgan", "rtCa_to_G+rtCa_to_T",
        "rtca+tgay", "tCa_to_G+tCa_to_T",
        "ytCa_rtCa_BH_Fisher_p-value", "ytCa_rtCa_Fisher_p-value", "ytCa_to_G+ytCa_to_T",
        "ytca+tgar"
      ), default = "APOBECtCa_enrich"),
      list(all = "NONE", default = "NONE")
    )
  })

  observe({
    updateVirtualSelect(
      "Pancan_search1",
      choices = profile_choices1()$all,
      selected = profile_choices1()$default
    )
  })

  profile_choices2 <- reactive({
    switch(input$profile2,
      mRNA = list(all = pancan_identifiers$gene, default = "TP53"),
      miRNA = list(all = pancan_identifiers$miRNA, default = "hsa-miR-769-3p"),
      promoter = list(all = names(load_data("pcawg_promoter_id")), default = "1:169863093:SCYL3"),
      fusion = list(all = pancan_identifiers$gene, default = "DPM1"),
      APOBEC = list(all = c(
        "tCa_MutLoad_MinEstimate", "APOBECtCa_enrich",
        "A3A_or_A3B", "APOBEC_tCa_enrich_quartile", "APOBECrtCa_enrich",
        "APOBECytCa_enrich", "APOBECytCa_enrich-APOBECrtCa_enrich",
        "BH_Fisher_p-value_tCa", "ntca+tgan", "rtCa_to_G+rtCa_to_T",
        "rtca+tgay", "tCa_to_G+tCa_to_T",
        "ytCa_rtCa_BH_Fisher_p-value", "ytCa_rtCa_Fisher_p-value", "ytCa_to_G+ytCa_to_T",
        "ytca+tgar"
      ), default = "APOBECtCa_enrich"),
      list(all = "NONE", default = "NONE")
    )
  })

  observe({
    updateVirtualSelect(
      "Pancan_search2",
      choices = profile_choices2()$all,
      selected = profile_choices2()$default
    )
  })

  opt_pancan = callModule(mol_origin_Server, "mol_origin2quick", database = "pcawg")

  # Show waiter for plot
  w <- waiter::Waiter$new(id = ns("gene_cor"), html = waiter::spin_hexdots(), color = "white")

  plot_func <- eventReactive(input$search_bttn, {
    if (nchar(input$Pancan_search1) >= 1 & nchar(input$Pancan_search2) >= 1) {
      p <- vis_pcawg_gene_cor(
        Gene1 = input$Pancan_search1,
        Gene2 = input$Pancan_search2,
        data_type1 = input$profile1,
        data_type2 = input$profile2,
        purity_adj = input$purity_adj,
        dcc_project_code_choose = input$dcc_project_code_choose,
        cor_method = input$cor_method,
        use_regline = input$use_regline,
        color = input$color,
        alpha = input$alpha,
        filter_tumor = input$filter_tumor,
        use_all = as.logical(input$use_all),
        opt_pancan = opt_pancan()
      )
    }
    p <- p + theme_classic(base_size = 20) +
      ggplot2::theme(legend.position = "none")

    return(p)
  })

  ## downloadTable
  output$downloadTable <- downloadHandler(
    filename = function() {
      paste0(input$Pancan_search1, "_", input$profile1, "_", input$Pancan_search2, "_", input$profile2, "_pcawg_gene_cor.csv")
    },
    content = function(file) {
      data = plot_func()$data %>%
        dplyr::rename('Project'='dcc_project_code','Sample'='icgc_specimen_id', 'Group'='type2',
          'Purity'='purity','Molecule1'='gene1', 'Molecule2'='gene2') %>%
        dplyr::select(Project, Sample, Group, Molecule1, Molecule2, Purity)
      write.csv(data, file, row.names = FALSE)
    }
  )

  output$gene_cor <- renderPlot({
    w$show() # Waiter add-ins
    plot_func()
  })

  # download module
  output$download <- downloadHandler(
    filename = function() {
      paste0(input$Pancan_search1, "_", input$profile1, "_", input$Pancan_search2, "_", input$profile2, "_pcawg_gene_cor.", input$device)
    },
    content = function(file) {
      p <- plot_func()
      if (input$device == "pdf") {
        pdf(file, width = input$width, height = input$height)
        print(p)
        dev.off()
      } else {
        png(file, width = input$width, height = input$height, res = 600, units = "in")
        print(p)
        dev.off()
      }
    }
  )

  ## return data
  observeEvent(input$search_bttn, {
    if (nchar(input$Pancan_search1) >= 1 & nchar(input$Pancan_search2) >= 1) {
      shinyjs::show(id = "save_csv")
    } else {
      shinyjs::hide(id = "save_csv")
    }
  })


  output$tbl <- renderDT(
    plot_func()$data %>%
      dplyr::rename('Project'='dcc_project_code','Sample'='icgc_specimen_id', 'Group'='type2',
        'Purity'='purity','Molecule1'='gene1', 'Molecule2'='gene2') %>%
      dplyr::select(Project, Sample, Group, Molecule1, Molecule2, Purity),
    options = list(lengthChange = FALSE)
  )
}
