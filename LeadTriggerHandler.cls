public class LeadTriggerHandler {
    public static void handleTrigger(
        List<Lead> newRecords,
        Map<Id, Lead> oldRecordsMap,
        Boolean isBefore,
        Boolean isAfter,
        System.TriggerOperation operation
    ) {
        switch on operation {
            when BEFORE_INSERT {
                beforeInsert(newRecords);
            }
            when AFTER_INSERT {
                afterInsert(newRecords);
            }
            when BEFORE_UPDATE {
                beforeUpdate(newRecords, oldRecordsMap);
            }
            when AFTER_UPDATE {
                afterUpdate(newRecords, oldRecordsMap);
            }
        }
    }

    // Método para after insert
    private static void afterInsert(List<Lead> newRecords) {
        createTasksForLeads(newRecords); // Chamando o método para criar tarefas
    }

    private static void beforeInsert(List<Lead> newRecords) {
        // Lógica para before insert
    }

    private static void beforeUpdate(List<Lead> newRecords, Map<Id, Lead> oldRecordsMap) {
        // Lógica para before update
    }

    private static void afterUpdate(List<Lead> newRecords, Map<Id, Lead> oldRecordsMap) {
        // Lógica para after update
    }

    // Adicionando o método createTasksForLeads
    public static void createTasksForLeads(List<Lead> newLeads) {
        List<Task> tasks = new List<Task>();

        for (Lead lead : newLeads) {
            // Verifica se já existe uma tarefa pendente para este Lead
            List<Task> existingTasks = [SELECT Id FROM Task WHERE WhoId = :lead.Id AND Status != 'Completed'];

            if (existingTasks.isEmpty()) {
                Task newTask = new Task(
                    Subject = 'O novo lead ' + lead.FirstName +' '+ lead.LastName + ' foi criado no sistema',
                    Description = 'Verifique as informações fornecidas:\n' +
                                 '• Nome do Lead: ' + lead.FirstName +' '+ lead.LastName + '\n' +
                                 '• Email: ' + (lead.Email != null ? lead.Email : 'Não informado') + '\n' +
                                 '• Telefone: ' + (lead.Phone != null ? lead.Phone : 'Não informado') + '',
                    OwnerId = lead.OwnerId,
                    WhoId = lead.Id,
                    ActivityDate = Date.today().addDays(2),
                    Status = 'Not Started',
                    Priority = 'Normal'
                );
                tasks.add(newTask);
            }
        }

        if (!tasks.isEmpty()) {
            insert tasks;
        }
    }
}
