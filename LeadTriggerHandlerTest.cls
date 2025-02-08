@isTest
public class LeadTriggerHandlerTest {
    
    @isTest
    static void testAfterInsert() {
        // Criação de um Lead de teste
        Lead testLead = new Lead(
            FirstName = 'João',
            LastName = 'Silva',
            Email = 'joao.silva@example.com',
            Phone = '123456789',
            Company = 'JS Company',
            Status = 'Open - Not Contacted'
        );
        
        //System.debug('Criando Lead de teste: ' + testLead.FirstName + ' ' + testLead.LastName);
        
        // Inserindo o Lead de teste
        Test.startTest();
        insert testLead;
        Test.stopTest();
        
        //System.debug('Lead de teste inserido com sucesso: ' + testLead.Id);
        
        // Verificando se uma tarefa foi criada
        List<Task> tasks = [SELECT Id, Subject, WhoId, Status FROM Task WHERE WhoId = :testLead.Id];
        
        //System.debug('Número de tarefas criadas para o Lead: ' + tasks.size());
        
        // Verificação se a tarefa foi criada corretamente
        System.assertEquals(1, tasks.size(), 'Deve ser criada uma tarefa para o Lead');
        //System.debug('Assunto da tarefa: ' + tasks[0].Subject);
        System.assertEquals('O novo lead João Silva foi criado no sistema', tasks[0].Subject, 'O assunto da tarefa deve ser correto');
        System.assertEquals('Not Started', tasks[0].Status, 'O status da tarefa deve ser "Not Started"');
        
        // Verificando os detalhes da tarefa
        Task createdTask = tasks[0];
        //System.debug('Descrição da tarefa: ' + createdTask);
        System.assertEquals('O novo lead João Silva foi criado no sistema', createdTask.Subject, 'O assunto da tarefa deve estar correto');
        System.assertEquals('Not Started', createdTask.Status, 'O status da tarefa deve ser "Not Started"');
        
        // Log para indicar o fim do teste
        //System.debug('Teste concluído com sucesso para o Lead: ' + testLead.Id);
    }
}
