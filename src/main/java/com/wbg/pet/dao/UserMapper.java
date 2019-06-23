package com.wbg.pet.dao;

import com.wbg.pet.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);

    //add
    List<User> selectAll();
    List<User> selectByUserName(String username);
    int updateByUserName(String username);
    User Login(@Param("username") String username , @Param("password") String password);
    int deleteByUserId(@Param("userId") int userId);
    int updatePwdByid(User record);
}