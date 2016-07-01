package com.zzc.commons;

import java.util.Arrays;
import java.util.List;


/**
 * 存放各种常量
 * 
 * @author : ZhengKe
 * @date : 2014-11-14 下午6:01:28
 */
public class Constants {
	
	/**
	 * 项目名
	 * @author zk
	 * @date 2016年1月29日 下午4:05:27
	 */
	public static enum Project {
		/** 小白项目 */
		XB {
			@Override
			public String toString() {
				return "xb";
			}
		}, 
		/** 小小白项目 */
		XXB {
			@Override
			public String toString() {
				return "xxb";
			}
		},
		/** xplan项目 */
		XPLAN {
			@Override
			public String toString() {
				return "xplan";
			}
		};
		
		public boolean contains(String key) {
			List<Project> list = Arrays.asList(Project.values());
			for (Project project : list) {
				if (project.toString().equals(key)) {
					return true;
				}
			}
			return false;
		}
	}
	
	/**
	 * 设备类型
	 * @author zk
	 * @date 2016年1月29日 下午4:05:27
	 */
	public static enum DeviceType {
		/** 苹果 */
		IOS {
			@Override
			public String toString() {
				return "IOS";
			}
		}, 
		/** 机器人 */
		Robot {
			@Override
			public String toString() {
				return "Robot";
			}
		},
		/** 安卓 */
		Android {
			@Override
			public String toString() {
				return "Android";
			}
		};
		
		public boolean contains(String key) {
			List<DeviceType> list = Arrays.asList(DeviceType.values());
			for (DeviceType deviceType : list) {
				if (deviceType.toString().equals(key)) {
					return true;
				}
			}
			return list.contains(key);
		}
	}
	
	/**
	 * 游戏货币
	 * @author zk
	 * @date 2016年2月25日 下午2:22:33
	 */
	public static enum Currency {
		/** 钻石 */
		DIAMOND {
			@Override
			public String toString() {
				return "diamond";
			}
		}, 
		/** 金币 */
		COIN {
			@Override
			public String toString() {
				return "coin";
			}
		}
	}
	
	/**
	 * 商品类别
	 * @author zk
	 * @date 2016年2月25日 下午3:27:59
	 */
	public static enum CommodityType {
		/** 充值类商品（钻石、金币） */
		TOPUP {
			@Override
			public String toString() {
				return "topup";
			}
		}, 
		/** 体力 */
		STRENGTH {
			@Override
			public String toString() {
				return "strength";
			}
		}, 
		/** 场景 */
		SCENE {
			@Override
			public String toString() {
				return "scene";
			}
		}, 
		/** 服装 */
		CLOTHING {
			@Override
			public String toString() {
				return "clothing";
			}
		}
	}
	
}
