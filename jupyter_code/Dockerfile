# Group 4 : DataIntegration
# Distributed under the terms of the Modified BSD License.
ARG BASE_CONTAINER=jupyter/scipy-notebook
FROM $BASE_CONTAINER

# Set when building on Travis so that certain long-running build steps can
# be skipped to shorten build time.
# ARG TEST_ONLY_BUILD
USER $NB_UID
RUN conda install --quiet --yes \
    'psycopg2'

COPY ./code /home/jovyan/work