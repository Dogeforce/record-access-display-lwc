@IsTest
private class RecordAccessDisplayControllerTest {

    @IsTest
    static void testQueryUser() {
        Test.startTest();
        List<User> results = RecordAccessDisplayController.searchUsers(UserInfo.getUserEmail());
        Test.stopTest();

        System.assertNotEquals(0, results.size(), 'Should have got at least one result (the current user).');
    }

    @IsTest
    static void testQueryEmptyTerm() {
        Test.startTest();
        List<User> results = RecordAccessDisplayController.searchUsers('');
        Test.stopTest();

        System.assertEquals(0, Limits.getQueries(), 'Should not have run any query.');
        System.assertEquals(0, results.size(), 'Should have got at least one result (the current user).');
    }

    @IsTest
    static void testGetCurrentUserRecordAccess() {
        Test.startTest();
        List<UserRecordAccess> result = RecordAccessDisplayController.getCurrentUserRecordAccess(UserInfo.getUserId());
        Test.stopTest();

        System.assertNotEquals(0, result.size(), 'Should have returned at least the record access for the user record.');
    }

    @IsTest
    static void testGetUserMaxAccessLevelForRecord() {
        Test.startTest();
        try {
            List<UserRecordAccess> result = RecordAccessDisplayController.getUserMaxAccessLevelForRecord(null, null);
            System.assert(false, '');
        } catch (RecordAccessDisplayController.RecordAccessDisplayException e) {
            System.assert(true, '');
        }
        List<UserRecordAccess> result = RecordAccessDisplayController.getUserMaxAccessLevelForRecord(UserInfo.getUserId(), UserInfo.getUserId());
        Test.stopTest();

        System.assertNotEquals(0, result.size(), 'Should have returned at least the record access for the user record.');
    }
}
