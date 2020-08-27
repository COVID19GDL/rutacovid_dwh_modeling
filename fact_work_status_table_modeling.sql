--DROP view dwh.fact_work_status;
​
CREATE OR REPLACE VIEW dwh.fact_work_status AS
SELECT
    row_number() over (order by timestamp asc) as index,
    timestamp::timestamp as timestamp,
    CASE WHEN email_registro is null then lower(correo_electronico)
        else lower(email_registro) end as correo_electronico,
    nombre,
    edad,
    estado,
    ciudad,
    --telefono,
    cp,
    case when empresa is null then lower(empresa_laboras)
        else  lower(empresa) end as empresa,
    case when departamento_de_trabajo is null then lower(departamento_de_trabajo_nousar)
        else lower(departamento_de_trabajo) end as departamento_de_trabajo,
    trabajo_casa_o_presencial as forma_de_trabajo,
    duracion_jornada_laboral,
    personas_contacto_cada_dia as personas_contacto_diario,
    tipo_espacio_trabajas as tipo_espacio_trabajo,
    distancia_cowork_mas_cercano as distancia_entre_empleados,
    cantidad_personas_en_area,
    tipo_de_transporte_utilizan as tipo_transporte,
    tipo_de_transporte_publico,
    frecuencia_uso_transporte_publico,
    transbordos_diarios,
    horario_transporte_ir as horario_transporte_ida,
    horario_transporte_regresar as horario_transporte_vuelta,
    CASE WHEN ciudado_alguna_persona = 'Sí' then TRUE end as ciudado_persona_mayor,
    tenido_covid,
    CASE WHEN te_realizaron_prueba= 'Sí' then TRUE end as prueba_covid_realizada,
    dias_iniciaste_con_sintomas,
    prueba_realizaron as tipo_prueba_covid,
    CASE WHEN tienes_alguna_razon_para_no_trabajar='Sí' then TRUE end as no_trabajo_presencial,
    mayor_razon_para_no_trabajar as razon_no_trabajo_presencial
FROM monitoreo_laboral as ml
where completado_cuestionario_previamente = 'No'
or cambio_condiciones_laborales = 'Sí';