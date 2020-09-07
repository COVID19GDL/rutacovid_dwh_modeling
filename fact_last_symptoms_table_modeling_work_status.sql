CREATE OR REPLACE VIEW dwh.fact_last_symptoms_work_status AS
with
    last_symptom as (
select
*
from (
select
*,
row_number() over (partition by correo_electronico order by timestamp desc) as row_num
from dwh.fact_symptoms
) as ordered_symptoms
where row_num = 1
    )

select
dwh.dim_user.correo_electronico,
dwh.dim_user.edad,
dwh.dim_user.departamento_de_trabajo,
dwh.dim_user.empresa,
dwh.dim_user.forma_de_trabajo,
dwh.dim_user.nombre,
last_symptom.puntaje_riesgo,
last_symptom.tomado_para_tos,
last_symptom.timestamp,
dias_con_fiebre,
calificacion_riesgo,
status,
last_symptom.dias_iniciaste_con_sintomas,
tiempo,
    correo_enviado,
    doctor_email,
       last_symptom.tenido_covid,
       last_symptom.prueba_covid_realizada,
       last_symptom.tipo_prueba_covid,
       doctor_recomendacion,
       dias_con_tos,
       status_respuesta_doctor,
       flemas,
       tomado_temperatura,
       temperatura_termometro,
       fiebre,
       dolor_en_pecho,
       moco_como_agua,
       duele_garganta,
       terminar_frases_sin_tomar_aire,
       enfermedad_corazon,
       diarrea,
       dias_con_diarrea,
       sientes_muy_agitado,
       asma,
       otra_enfermedad,
       completado_cuestionario_previamente,
       dolor_musculos,
       conocido_con_covid,
       perdido_gusto_comida,
       diabetes,
       embarazada,
       tos,
       perdida_del_olfato,
       fumas,
       dolor_de_panza,
       dolor_articulaciones,
       sobrepeso_obesidad,
       sientes_muy_cansado,
       ojos_rojos,
       hipertension,
       cuesta_trabajo_respirar,
       cancer
from last_symptom
inner join dwh.dim_user on dwh.dim_user.correo_electronico = last_symptom.correo_electronico;