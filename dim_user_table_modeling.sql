--DROP view dwh.dim_user CASCADE;

CREATE OR REPLACE VIEW dwh.dim_user AS

    with user_data as (
    SELECT
    fecha_de_inicio::timestamp as created_at,
    email as correo_electronico,
    nombre,
    estado,
    ciudad,
    telefono,
    codigo_postal,
    empresa,
    area_departamento_de_trabajo as departamento_de_trabajo
    FROM catalogousuarios as ml
    ),

work_status as (
    SELECT
    timestamp::timestamp as timestamp,
    CASE WHEN email_registro is null then lower(correo_electronico)
        else lower(email_registro) end as correo_electronico,
    trabajo_casa_o_presencial as forma_de_trabajo,
    duracion_jornada_laboral,
    edad,
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
or cambio_condiciones_laborales = 'Sí') ,

last_work_status as (
    select *
    from (
select
    *,
    row_number() over (partition by correo_electronico order by timestamp desc) as row_num
from work_status) as ordered_work_status
    where row_num = 1
        )

select
created_at,
user_data.correo_electronico,
nombre,
    edad,
    estado,
    ciudad,
    telefono,
    codigo_postal,
    empresa,
    departamento_de_trabajo,
    timestamp as last_response_at,
    forma_de_trabajo,
    duracion_jornada_laboral,
    personas_contacto_diario,
    tipo_espacio_trabajo,
    distancia_entre_empleados,
    cantidad_personas_en_area,
    tipo_transporte,
    tipo_de_transporte_publico,
    frecuencia_uso_transporte_publico,
    transbordos_diarios,
    horario_transporte_ida,
    horario_transporte_vuelta,
    ciudado_persona_mayor,
    tenido_covid,
    prueba_covid_realizada,
    dias_iniciaste_con_sintomas,
    tipo_prueba_covid,
    no_trabajo_presencial,
    razon_no_trabajo_presencial
from user_data
inner join last_work_status on last_work_status.correo_electronico = user_data.correo_electronico;