Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC555C433EF
	for <virtualization@archiver.kernel.org>; Sun, 15 May 2022 20:29:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4F027416F3;
	Sun, 15 May 2022 20:29:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zREKEPDf2qmJ; Sun, 15 May 2022 20:29:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 66379416AD;
	Sun, 15 May 2022 20:29:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7819C0080;
	Sun, 15 May 2022 20:29:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0EC1EC007F
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 May 2022 20:29:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F1FEF4161E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 May 2022 20:29:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5eDxXpJ_RV5c
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 May 2022 20:29:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2D9D141606
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 May 2022 20:29:41 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24FEihuI016834;
 Sun, 15 May 2022 20:29:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=GD01IxMOnNfuWM1iNmhPssot0bsfiyS3KWcrhW9vkEY=;
 b=IPnbqkupzenkyicdZswTtTk1YaLOpkWCgCuKQkou2Kb3xskXvsdVZxEN4lpPjgtWq/sF
 vCPgAJ5AWoAPqTDVXIur0883vHYwvcHFDh+jGkTdYnMeu2k05bCmbjnVOetbA0+Pzsa9
 4zxI28k9Wj+80A3htHZiy1k13Ps/MkpBRGGv8wOpQ5GHOGdztM376o8wNNoO1V2h7+38
 2YZiAT1fhkSqCRvhgMTTQRCPGv8TQFClnwBUksTt2Ou0elKiKUsCnCpI2gLIY4JGh/bC
 2kL2cJDidLZQd0ntF9ACuq7XnC9e9ls+tic4SPu7MENcuTl3fzJUcQ6CTaZ5CQE+84H/ Xw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24aa9tej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 15 May 2022 20:29:40 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24FKPP2I007035; Sun, 15 May 2022 20:29:38 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3g22v0ycf9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 15 May 2022 20:29:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j75Zp3RLZ1hNya6J3whbaAaPLzoatw+SgYV9UDNKAgjdgNfaCOPSwOAqKjnOd2cNFI63EMEGqLEi5a+8jdnkMjmK24cf9L8GaxeBjQ00V5MVvk58msTzGXS0yZXY8xh4wk5B29WILid5DmR9YZ7nLVpIsPKj4jJRcPv0MVvyAAafYFi6roOacsl9eZnRj9Q8DxagmAWVkbmeCnOFdWCUr8sgcq0fcmiizpyB7EUsRdO/RYpq/JW58ZwNML5eFZSmAVi9t+OsaJWGWnUgWXgxYI5xC23Q06kmQer3xq7m+zsi4hiYryfYoQpfG8joJILHK1waiugS3g5YWxIiR+WOgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GD01IxMOnNfuWM1iNmhPssot0bsfiyS3KWcrhW9vkEY=;
 b=PoNTxcDRuMv4P6bHHU7NrqKGP77yi1t7TbH1RqL35WCdCDnjKffkL7/gsjp4UmQvn8YuwumA8/ELM6sbwxFatpGcwMS4xFyX7jduKvqm0fhcJkQsTQZh816lZ8I3YRvRZf7fxPq/5DnaGXxEfgEsI6/5nlaow5R596io6eYKvPiwSH3WOvbwbSbtQ+YaiUe3aujCR9f89r0BQBjYaRdPSF4F4be2wk3WrYQ0BKBU0/Sh4UyXovQn14ljrmdJmPGrpnTIsKNMItZtnvSx9isaGR8Wm3dzZc1OAyAR7I9afS83sW2vOXxGUZq+S8Tv4rtNCyQAVY3QUpGOoRVPrVGTyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GD01IxMOnNfuWM1iNmhPssot0bsfiyS3KWcrhW9vkEY=;
 b=gChbTPaST3ug05uWVyRfde9Yp1SnwrlqWfPQ+OeI9QdPMaZJ87Ab2BW20cKHJCl3bApX0XVZA/73+lhfqBM1tENwcgAYseGa6WOMQKNXNNfKK0xSL0oFoefTPLfEvJ0giXDbuwW/pBFd/lGbq7m+vF36lFZu0BCRwOVz2aU7st0=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 BN7PR10MB2707.namprd10.prod.outlook.com (2603:10b6:406:c9::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13; Sun, 15 May 2022 20:29:32 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5250.018; Sun, 15 May 2022
 20:29:32 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 arbn@yandex-team.com
Subject: [PATCH V2 5/8] vhost_vsock: simplify vhost_vsock_flush()
Date: Sun, 15 May 2022 15:29:19 -0500
Message-Id: <20220515202922.174066-6-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220515202922.174066-1-michael.christie@oracle.com>
References: <20220515202922.174066-1-michael.christie@oracle.com>
X-ClientProxiedBy: DS7PR05CA0074.namprd05.prod.outlook.com
 (2603:10b6:8:57::22) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd4f1704-725c-409a-7c8e-08da36b19e5e
X-MS-TrafficTypeDiagnostic: BN7PR10MB2707:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB2707F2BB0FA912CEDD8DC1B5F1CC9@BN7PR10MB2707.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OX+uFn5EmZDk/KMKdknmocaIov0yJac9AQF452pHkjlUnpwivHPdGISFdNewBono1HS5+W/SnIT1uFYWNkFNC3rKJ/638aaBvWOl+a8ieJrLbdROEFLEV9pjKwnDaeYcXqq5sk8l9kHI8W2JfYIomGEO6JyBQQ+Q2C9N75y6jZetpUyYHrKQ8ABlxppa0UpYueJg0sLcyL6Vsw5JKRx9jemsZ8kd9Pgwf8FAB0nsNz7YpHJYQZ5IsYHW7+dATxuP8pu9jltzW5EAUhU6zonYgLT/56SrKUXw/Gdr+hQNc+8evHXYLuTLmZgcGOxk5hXshegmcINvA0puw8FH+stPzpqiMqw/WlCLHdstLzv3Y3wwcJiEspidrdYyV1UWpg/0tcvWpL6Q/ShWw8cgQjwAQ47CM1rxF9m46VxUIdUHpcN0ASXUCbnaRGX1Kj0hp7ssNaYyNke4JfkGSvJCzI2Ys4pirFpHwzQVa3SKpaupmp6KunBkTwSjvTsh0SvkZ9KgB+ozdB7AaW+px57698QlMsHBg39cPgUdr4srxPEdXDUh0gHCAtLti6/YVuhZq41Q30mCbgD/fOBNOZdYlQcX3igcMRAyxsQ5yW9RAyMBmtOggFXbUSjf0irvJDMGXmREz8qsWLB8Awa02EdPny4UKmx+EFDLvjkHUhEWL9sPVKNePqYgY5L99Ok33Ffpu6P2KxPj3F0v0iKRAFcnM4PS3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(1076003)(8676002)(107886003)(38350700002)(8936002)(36756003)(316002)(26005)(6512007)(2616005)(186003)(5660300002)(6506007)(6486002)(2906002)(38100700002)(86362001)(4326008)(6666004)(66946007)(66476007)(52116002)(83380400001)(66556008)(508600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S7GP4OKfr63hMvjCyfqCpJvtXWkRPZWgOqYGzqBdTj5OTgw2sDXY6ekWQTTD?=
 =?us-ascii?Q?FZ/Xd/pwhfy5rAAR33SNy0qIaMEM68JFBdI6mUX1n1HUAr/OfWqoTHJC13SW?=
 =?us-ascii?Q?p50hxA9njMaIKBajm7+xYaycEnUpxrnAuzE5ns6syzLP0A9d00F9TKVMTMRq?=
 =?us-ascii?Q?iqjofANT5qwET+3fyEX04Yp/igYAqxLT16Ek1HDA4l7I3WIYorp/PbxZT4a1?=
 =?us-ascii?Q?bLhJAHEtV7LudgljyiMAUtWodzbgABzaCV/IArkKhiz8UF5d0BFfYH65qXQ9?=
 =?us-ascii?Q?kTnitj7zPAIMmdDAf3amWZxoLoiPqEjsCdoBviN0yTnTJ7WxKI0T4hOxPfMh?=
 =?us-ascii?Q?Tr0Ju4Vrw8CkMcjm1A0AA4CiOdd/Fqp1Iz4QXGyJBDyTIkiusubgp0WR6nNB?=
 =?us-ascii?Q?7WuR5uxOkqtd2IH2yjowd/aJw/JrgrldMBdF2g0waxW4kSJRH9BfQ54qRblA?=
 =?us-ascii?Q?aqsit4/6jd2hMVXvqdh2+1hVkQ54GIbbJalwoX+rnaosavqOPv1Pkow88ulH?=
 =?us-ascii?Q?chxMEUM3i9/uXxTZ7i7FwBpQVgysmv5ED34+H2V5Bf7rHT4AkePpLW4ABzcX?=
 =?us-ascii?Q?3trJxVIdGiXkJQVsy+fN5u3f765uvPIHY7ANBZKi37K5MU/pcXQIddebV5oP?=
 =?us-ascii?Q?2m2whGCW8RgqC9cEHoA5Q4cBJta6C4PuYGx27vKHWBU0jGtWIbWBrPp+vKS5?=
 =?us-ascii?Q?WMzU5xPQVaMTOdj1+RMcI1X9rwHYRQvK0mWrfthbJyiB68ouxOpCNDnrIfkM?=
 =?us-ascii?Q?JKeh/3cQFfE7blMJxh+dT/t71vlIQJh6XSYgqmyzzGS59aCOcFwhARyrfjWG?=
 =?us-ascii?Q?paKLHCthsfgfWauz/t5I0mXqxXT5zO95IW5Y47c56MhcNWP4rEicHsyY21mn?=
 =?us-ascii?Q?DL7ZK32qNH4wMBPfvk+79CBstViVs7qrAABU70H4kK/xe5+4GaWhdv4KhFom?=
 =?us-ascii?Q?LD0W1A7+KiqpAGp2Q7HMEV8VBzdVyIQIeOKiblLgyL00njJW3C3t3lTBfRxg?=
 =?us-ascii?Q?kGBpctJLGjlLEx78DTZgcgKkVygdxngNb/Mqf3t4jb3ahpSu3fOlqr10abOn?=
 =?us-ascii?Q?XGnWkNJRvs4ZepwdyDOR2vBtKAyabUdYcKgjQ2P9F8mUr5zQsZcRs/g7pNoq?=
 =?us-ascii?Q?a6G1duSJSg+bcbgb/NnCpCs/xXbsciY+DJ8so/lktg/55P4TDRFtcDcLO4PV?=
 =?us-ascii?Q?UoT0TskUDNnGa1RQ79UDkekG5j0OpkDvlEw8UAWhS9EaM4g8y2L9eozFhUBo?=
 =?us-ascii?Q?eftLn602egOSbPJYlyuEyvx5FY1VEHyb2xsL3yq1UBBgluWONRvLshQu6cQw?=
 =?us-ascii?Q?Tdq52AtukDI7WY29n6gNAgmogkeXulRFr7H4bqwoZ0uJlo85kX481VEXPZfm?=
 =?us-ascii?Q?jHveDwU6AYAfqWwBrmtz3SFMvVa0fs5TklBGakyigRJfcQ4rr/MfBans9+sc?=
 =?us-ascii?Q?Bt1jLKMKLXSyk6o6xh9SuEWJIv9iKo4d+rX5Yds5fWFgD8zf4hPsODDssi6W?=
 =?us-ascii?Q?KT+4RYksc8XTPiRpq2C0ETaeIiNuRL6lEW3goP+w2h2gD/mluevIUkTQtsto?=
 =?us-ascii?Q?ors2L5zd73MPsNvo4INLi0r5SDC1POSmO6zVR0ZejE6SGn8LQqs58hIcJaxT?=
 =?us-ascii?Q?oITsyKgfs+NE5OgagYtwwiywAyEdHlndm/n4Ptkc/s3RaIoM4d4FSvZv4UDw?=
 =?us-ascii?Q?WoXg3iIYRyUg1mfvrKKFiM6TAmqBgZL6St8x5fzhWnnhoXHmYgJkk71EzTyu?=
 =?us-ascii?Q?Al0UDMT3+HbfcXv3CAvYJomHzWq4WgU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4f1704-725c-409a-7c8e-08da36b19e5e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2022 20:29:32.2325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YyqTG4mNL26h3kextV9wsWhVNS0RXIv77cV5IJEPieZ7YrgMZOM1mOJdfid2Y9+XOGU0BDl2KuX1bUnWRY42P6JvY6cNiboVpSil1Id9e6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2707
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.858
 definitions=2022-05-15_11:2022-05-13,
 2022-05-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205150120
X-Proofpoint-ORIG-GUID: hmHhGlpbhHi7NWHpAMzTt0E3Vuq51gMQ
X-Proofpoint-GUID: hmHhGlpbhHi7NWHpAMzTt0E3Vuq51gMQ
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

From: Andrey Ryabinin <arbn@yandex-team.com>

vhost_vsock_flush() calls vhost_work_dev_flush(vsock->vqs[i].poll.dev)
before vhost_work_dev_flush(&vsock->dev). This seems pointless
as vsock->vqs[i].poll.dev is the same as &vsock->dev and several flushes
in a row doesn't do anything useful, one is just enough.

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vsock.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index a4c8ae92a0fb..96be63697117 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -705,11 +705,6 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 
 static void vhost_vsock_flush(struct vhost_vsock *vsock)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++)
-		if (vsock->vqs[i].handle_kick)
-			vhost_work_dev_flush(vsock->vqs[i].poll.dev);
 	vhost_work_dev_flush(&vsock->dev);
 }
 
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
