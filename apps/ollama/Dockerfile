FROM ollama/ollama:latest

# Copy entrypoint script (as root, then switch back)
USER root
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
USER ollama

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["serve"]