package com.wbg.pet.dao;

import com.wbg.pet.entity.Apiresponse;

public interface ApiresponseMapper {
    int deleteByPrimaryKey(Integer code);

    int insert(Apiresponse record);

    int insertSelective(Apiresponse record);

    Apiresponse selectByPrimaryKey(Integer code);

    int updateByPrimaryKeySelective(Apiresponse record);

    int updateByPrimaryKey(Apiresponse record);
}