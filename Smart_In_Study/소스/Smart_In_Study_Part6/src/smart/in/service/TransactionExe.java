package smart.in.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Component;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

@Component
public class TransactionExe {
	// 상속시 사용을 위해 protected 접근제한자로 선언
	
	@Autowired
	protected DataSourceTransactionManager transactionManager;
	
	protected TransactionStatus status;
	
 //Transaction Definition
	protected void setTransactionConf(int PropagationBehavior, int IsolationLevel, boolean ReadOnly) {
		// Transaction의 Propagation과 Isolation 지정
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		
		// propagationBehavior : propagation의 상수값 입력
		def.setPropagationBehavior(PropagationBehavior);
		
		// isolationLevel : isolation의 상수값 입력
		def.setIsolationLevel(IsolationLevel);
		
		// readOnly : 읽기 전용에 대한 boolean 값
		def.setReadOnly(ReadOnly);
		
		status = transactionManager.getTransaction(def);
	}
	
// Transaction Result
	protected void setTransactionResult(boolean isResult) {
		if(isResult) {
			transactionManager.commit(status);
		}else {
			transactionManager.rollback(status);
		}
	}
}
