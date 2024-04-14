<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>PhysicalS - 운동 추가</title>

  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <!-- jQuery library -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <!-- Popper JS -->
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <!-- Latest compiled JavaScript -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <link rel="stylesheet" href="resources/css/workoutenroll.css?after">
</head>

<body>
  <c:import url="../../views/common/menubar.jsp" />
  <div class="workoutenroll-area">

    <h2 align="center" style="font-size: 50px; margin: 20px;">운동을 선택해주세요</h2>

    <div id="workout-list-area">
      <c:choose>
        <c:when test="${not empty exList}">
          <c:forEach var="ex" items="${exList }">
            <div class="workout-list-item">
              <div class="w_name">${ex.exerciseName }</div>
              <div class="w_bodypart">${ex.bodyPart }</div>
              <div class="w_checkbox">
                <input type="checkbox" name="workout" class="workout_chkbox" style="zoom: 2.0;">
              </div>
            </div>
          </c:forEach>
        </c:when>
        <c:otherwise>
          <div>
            등록된 운동이 없습니다.
          </div>
        </c:otherwise>

      </c:choose>

    </div>

    <div id="btn-area">
      <button id="enroll-btn" data-toggle="modal" data-target="#myModal">입력</button>
    </div>
  </div>


  <!-- The Modal -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">

        <!-- Modal Header -->
        <div class="modal-header">
          <h2 class="modal-title">운동 추가</h2>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>

        <!-- Modal body -->
        <div class="modal-body">
          <div id="checked_workout">

          </div>
        </div>

        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" id="btn-enroll-workout">등록</button>
        </div>
      </div>
    </div>
  </div>

  <script>
    $(function () {
     
      $('#enroll-btn').off('click').on('click', function () {
        let str = ``;
        $('.workout-list-item').each(function () {
          if ($(this).find('input[type=checkbox]').prop('checked')) {
            let exercise = $(this).find('.w_name').text();
            let bodyPart = $(this).find('.w_bodypart').text();
            let setCount = 1;
            str += `<table class="check_workout_list">
				                  <thead>
				                    <tr>
				                      <th class="td-50 txt-center exercise">`+ exercise + `</th>
				                      <th class="td-25 txt-center bodyPart">`+ bodyPart + `</th>
				                      <th class="td-25 txt-center" colspan="2">
				                        <button class="btn btn-primary add-set-button">세트 추가</button>
				                      </th>
				                    </tr>
				                  </thead>
				    
				                  <tbody>
				                    <tr>
				                      <td class="txt-center txt-center">세트</td>
				                      <td class="td-25 txt-center">중량</td>
				                      <td class="td-25 txt-center">횟수</td>
				                    </tr>
				                    <tr>
				                      <td class="txt-center exSet">`+setCount+`</td>
				                      <td class="td-25 txt-center">
				                        <input class="bottom-border exWeight" type="text" style="width: 50px;"> kg
				                      </td>
				                      <td class="td-25 txt-center">
				                        <input class="bottom-border exCount" type="text" style="width: 50px;"> 개
				                      </td>
				                      <td class="td-25 txt-center">
				                        <button class="btn btn-danger delete-set-button">삭제</button>
				                      </td>
				                    </tr>
                          		  </tbody>
				                </table>`;

          }
        });


        $('#checked_workout').html(str);
        bindSetButtons();


      });
      function bindSetButtons() {
        $(document).off('click', '.add-set-button').on('click', '.add-set-button', function () {
          let prevCount = parseInt($(this).closest('table').find('.exSet').last().text()); // 이전 세트의 수 가져오기
          let currentCount = prevCount + 1; // 현재 세트의 수 계산
          let tbody = $(this).closest('table').find('tbody');
          tbody.append(`<tr>
                              <td class="txt-center exSet">`+currentCount+`</td>
                              <td class="td-25 txt-center">
                                <input class="bottom-border exWeight" type="text" style="width: 50px;"> kg
                              </td>
                              <td class="td-25 txt-center">
                                <input class="bottom-border exCount" type="text" style="width: 50px;"> 개
                              </td>
                              <td class="td-25 txt-center">
                                <button class="btn btn-danger delete-set-button">삭제</button>
                              </td>
                            </tr>`);

        });

        $(document).off('click', '.delete-set-button').on('click', '.delete-set-button', function () {
          $(this).closest('tr').remove();
        });
      }

      $('#btn-enroll-workout').on('click', function () {
        let workoutRecord = [];

        $(".check_workout_list").each(function() {
          let exercise = $(this).find(".exercise").text();
          let bodyPart = $(this).find(".bodyPart").text();
          let exInfos = [];

          $(this).find('tbody tr:gt(0)').each(function() {
            let exSet = $(this).find('.exSet').text(); // exSet 추가
            let exWeight = $(this).find('.exWeight').val();
            let exCount = $(this).find('.exCount').val();
        
            let exInfo = {
                exSet: exSet,
                exWeight: exWeight,
                exCount: exCount
            };
            exInfos.push(exInfo);
          });

          // console.log("exercise = " + exercise);
          // console.log("bodyPart = " + bodyPart);
          // console.log("exInfos =", JSON.stringify(exInfos));

          workoutRecord.push({
            exercise: exercise,
            bodyPart: bodyPart,
            exInfos: exInfos
          });
        });
        // console.log(JSON.stringify(workoutRecord));
        sendData(workoutRecord);
      });

      function sendData(workoutRecord) {
        $.ajax({
          url: 'insert.wo',
          type: 'POST',
          contentType: 'application/json',
          data: JSON.stringify(workoutRecord),
          success: function(res) {

          },

          error: function(res) {

          }
          
        });
      };
    });




  </script>

</body>

</html>