const sql = require('mssql');
const sqlConfig = require('../config/sql.config');

exports.getStudentInfo = async (userId) => {
	try {
		const pool = await sql.connect(sqlConfig);
		const queryStr = `EXEC dbo.SP_GET_STUDENT_INFO @studentId = '${userId}'`;

		const result = await pool.request().query(queryStr);
		pool.close();

		return result?.recordset[0];
	} catch (error) {
		throw error;
	}
};

exports.getLearningResult = async (userId) => {
	try {
		const pool = await sql.connect(sqlConfig);
		const queryStr = `EXEC dbo.SP_GET_LEARNING_RESULT @studentId = '${userId}'`;

		const result = await pool.request().query(queryStr);
		pool.close();

		return result?.recordset;
	} catch (error) {
		throw error;
	}
};

exports.getStudentTimetable = async (userId) => {
	try {
		const pool = await sql.connect(sqlConfig);
		const queryStr = `EXEC dbo.SP_GET_STUDENT_TIMETABLE @studentId = '${userId}'`;

		const result = await pool.request().query(queryStr);
		pool.close();

		return result?.recordset;
	} catch (error) {
		throw error;
	}
};

exports.getStuExamCalendar = async (userId) => {
	try {
		const pool = await sql.connect(sqlConfig);
		const queryStr = `EXEC dbo.SP_GET_EXAM_CALENDAR @studentId = '${userId}'`;

		const result = await pool.request().query(queryStr);
		pool.close();

		return result?.recordset;
	} catch (error) {
		throw error;
	}
};

exports.getExamInfo = async (courseId) => {
	try {
		const pool = await sql.connect(sqlConfig);
		const queryStr = `EXEC dbo.SP_GET_EXAM_INFO @courseId = '${courseId}'`;
		const result = await pool.request().query(queryStr);
		pool.close();
		return result?.recordset[0];
	} catch (error) {
		throw error;
	}
};

exports.getQuestionExam = async (examId) => {
	try {
		const pool = await sql.connect(sqlConfig);
		const queryStr = `EXEC SP_GET_QUESTIONS @examId= '${examId}'`;
		const result = await pool.request().query(queryStr);
		pool.close();
		return result?.recordset;
	} catch (error) {
		throw error;
	}
};
