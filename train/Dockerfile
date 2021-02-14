# Use base stacking image
FROM carismoses/stacking:latest

# run training
COPY train.sh .
RUN chmod +x train.sh
CMD ./train.sh