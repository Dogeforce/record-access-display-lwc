@SuppressWarnings('PMD.ApexCRUDViolation')
public without sharing class RecordAccessDisplayController {

    @AuraEnabled
    public static List<User> searchUsers(String searchTerm) {
        if (searchTerm == null || searchTerm.length() < 3) {
            return new List<User>();
        }
        searchTerm = '%' + searchTerm + '%';
        return [
            SELECT Id, Name
            FROM User
            WHERE Email LIKE :searchTerm
            OR UserName LIKE :searchTerm
            OR Name LIKE :searchTerm
        ];
    }

    @AuraEnabled
    public static List<UserRecordAccess> getCurrentUserRecordAccess(Id recordId) {
        return getUserMaxAccessLevelForRecord(recordId, UserInfo.getUserId());
    }

    @AuraEnabled
    public static List<UserRecordAccess> getUserMaxAccessLevelForRecord(Id recordId, Id userId) {
        if (recordId == null || userId == null) {
            throw new RecordAccessDisplayException('Invalid record ID or user ID.');
        }
        return [
            SELECT
            RecordId,
            MaxAccessLevel
            FROM UserRecordAccess
            WHERE RecordId = :recordId
            AND UserId = :userId
        ];
    }

    public class RecordAccessDisplayException extends Exception {}
}
