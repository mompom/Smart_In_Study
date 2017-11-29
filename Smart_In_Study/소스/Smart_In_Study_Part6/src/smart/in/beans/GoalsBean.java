package smart.in.beans;

import java.util.Date;

import org.apache.ibatis.type.Alias;

@Alias("goalsBean")
public class GoalsBean {

	

	private String goalsHir;
	private String goalsRfid;
	
	
	public String getGoalsHir() {
		return goalsHir;
	}
	public void setGoalsHir(String goalsHir) {
		this.goalsHir = goalsHir;
	}
	public String getGoalsRfid() {
		return goalsRfid;
	}
	public void setGoalsRfid(String goalsRfid) {
		this.goalsRfid = goalsRfid;
	}
	
	
	
	
	
	
	
}
