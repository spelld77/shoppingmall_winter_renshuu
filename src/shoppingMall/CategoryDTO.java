package shoppingMall;

public class CategoryDTO {
	private String cnum;
	private String code;
	private String cname;
	
	//기본 생성자
	public CategoryDTO() {
		
	}
	//인자 생성자
	public CategoryDTO(String cnum, String code, String cname) {
		super();
		this.cnum = cnum;
		this.code = code;
		this.cname = cname;
	}
	
	public String getCnum() {
		return cnum;
	}
	public void setCnum(String cnum) {
		this.cnum = cnum;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}
	
	
}
