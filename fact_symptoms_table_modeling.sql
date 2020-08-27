DROP VIEW dwh.fact_symptoms;

CREATE OR REPLACE VIEW dwh.fact_symptoms AS
SELECT ml.timestamp::timestamp as timestamp,
       case
           when ml.empresa is null then lower(ml.empresa_laboras)
           else lower(ml.empresa) end                                             as empresa,
       ml.estado,
       ml.ciudad,
       case
           when ml.email_registro is null then lower(ml.correo_electronico)
           else lower(ml.email_registro) end                                      as correo_electronico,
       ml.edad,
       ml.nombre,
       ml.puntaje                                                                 as puntaje_riesgo,
       ml.tomado_para_fiebre,
       ml.tomado_para_tos,
       ml.dias_con_fiebre,
       ml.calificacion_riesgo,
       ml.status,
       ml.dias_iniciaste_con_sintomas,
       ml.tiempo,
       ml.enviar                                                                  as correo_enviado,
       ml.dias_con_diarrea,
       ml.cp,
       ml.doctor_email,
       CASE WHEN ml.tenido_covid = 'Sí' then TRUE END                             as tenido_covid,
       CASE WHEN te_realizaron_prueba = 'Sí' then TRUE end                        as prueba_covid_realizada,
       prueba_realizaron                                                          as tipo_prueba_covid,
       ml.doctor_recomendacion,
       ml.dias_con_tos,
       ml.contestado                                                              as status_respuesta_doctor,
       CASE WHEN ml.flemas = 'Sí' then TRUE end                                   as flemas,
       CASE WHEN ml.tomado_temperatura = 'Sí' then TRUE END                       as tomado_temperatura,
       ml.marco_el_termometro                                                     as temperatura_termometro,
       CASE WHEN ml.fiebre = 'Sí' then TRUE END                                   as fiebre,
       CASE WHEN ml.dolor_en_tu_pecho = 'Sí' then TRUE END                        as dolor_en_pecho,
       CASE WHEN ml.moco_como_agua = 'Sí' then TRUE END                           as moco_como_agua,
       CASE WHEN ml.duele_garganta = 'Sí' then TRUE END                           as duele_garganta,
       CASE WHEN ml.terminar_frases_sin_detenerte_tomar_aire = 'Sí' then TRUE END as terminar_frases_sin_tomar_aire,
       CASE WHEN ml.enfermedad_corazon = 'Sí' then TRUE END                       as enfermedad_corazon,
       CASE WHEN ml.diarrea = 'Sí' then TRUE END                                  as diarrea,
       CASE WHEN ml.muy_agitado = 'Sí' then TRUE END                              as sientes_muy_agitado,
       CASE WHEN ml.asma = 'Sí' then TRUE END                                     as asma,
       CASE WHEN ml.otra_enfermedad = 'Sí' then TRUE END                          as otra_enfermedad,
       CASE WHEN ml.completado_cuestionario_previamente = 'Sí' then TRUE END     as completado_cuestionario_previamente,
       CASE WHEN ml.dolor_musculos = 'Sí' then TRUE END                           as dolor_musculos,
       CASE WHEN ml.conoces_a_alguien_con_covid = 'Sí' then TRUE END              as conocido_con_covid,
       CASE WHEN ml.perdido_gusto_por_la_comida = 'Sí' then TRUE END              as perdido_gusto_comida,
       CASE WHEN ml.diabetes = 'Sí' then TRUE END                                 as diabetes,
       CASE WHEN ml.embarazada = 'Sí' then TRUE END                               as embarazada,
       CASE WHEN ml.tos = 'Sí' then TRUE END                                      as tos,
       CASE WHEN ml.perdido_el_olfato = 'Sí' then TRUE END                        as perdida_del_olfato,
       CASE WHEN ml.fumas = 'Sí' then TRUE END                                    as fumas,
       CASE WHEN ml.dolor_de_panza = 'Sí' then TRUE END                           as dolor_de_panza,
       CASE WHEN ml.te_duelen_articulaciones = 'Sí' then TRUE END                 as dolor_articulaciones,
       CASE WHEN ml.obesidad_sobrepeso = 'Sí' then TRUE END                       as sobrepeso_obesidad,
       CASE WHEN ml.sientes_muy_cansado = 'Sí' then TRUE END                      as sientes_muy_cansado,
       CASE WHEN ml.ojos_rojos = 'Sí' then TRUE END                               as ojos_rojos,
       CASE WHEN ml.hipertension = 'Sí' then TRUE END                             as hipertension,
       CASE WHEN ml.cuesta_trabajo_respirar = 'Sí' then TRUE END                  as cuesta_trabajo_respirar,
       CASE WHEN ml.cancer = 'Sí' then TRUE END                                   as cancer
FROM public.monitoreo_laboral as ml;