package ibs.com.domain;

import java.util.List;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
public class WbsVO {
   private String name;
   private int id;
   private int row_index;
   private String start_date;
   private String end_date;
   private float total_one_md;
   private float plan_one_md;
   private float plan_date;
   private float total_date;
   private float plan_progress;
   private float total_real_progress;
   private String order_id;
   private int deep;
   private String report;
   private int project_id;
}