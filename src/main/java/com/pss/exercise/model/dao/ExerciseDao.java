package com.pss.exercise.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;

import com.pss.exercise.model.vo.Exercise;

public class ExerciseDao {

	public ArrayList<Exercise> selectExerciseList(SqlSession sqlSession) {
		return (ArrayList)sqlSession.selectList("exerciseMapper.selectExerciseList");

	}

	public int insertWorkoutRecord(SqlSession sqlSession, String exName, String bodyPart, int exSet, int exWeight,
			int exCount) {
		return 0;
		
	}

}
