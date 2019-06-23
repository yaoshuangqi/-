package com.wbg.pet.dao;

import com.wbg.pet.entity.Pet;

import java.util.List;

public interface PetMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Pet record);

    int insertSelective(Pet record);

    Pet selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Pet record);

    int updateByPrimaryKey(Pet record);

    //add
    List<Pet> selectAll();
    List<Pet> findByStatus(String Status);
    int updateNameStatus(Pet pet);
    int updateStatusById(Pet pet);
}