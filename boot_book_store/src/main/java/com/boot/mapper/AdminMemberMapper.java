package com.boot.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface AdminMemberMapper {
    List<Map<String, Object>> selectAllUsers();
    Map<String, Object> selectUserById(@Param("user_id") String userId);
    int updateUser(Map<String, Object> param);
    int deleteUser(@Param("user_id") String userId);
    int updateRole(Map<String, Object> param);
    List<Map<String, Object>> selectAdmins();


}

