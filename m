Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC7EC433F5
	for <virtualization@archiver.kernel.org>; Tue,  7 Dec 2021 02:45:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1307E403B7;
	Tue,  7 Dec 2021 02:45:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XgjVRCYKri7C; Tue,  7 Dec 2021 02:45:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 40A6F40538;
	Tue,  7 Dec 2021 02:45:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19DFBC0072;
	Tue,  7 Dec 2021 02:45:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73B92C007A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:45:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BEC79400BA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:45:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BsR7SxLpWpLs
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:45:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 09AB54011A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:45:24 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6M5TL0004022; 
 Tue, 7 Dec 2021 02:45:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=cvdR3HtsYLHvjWhmgga/2d0JO2zD6VWnZ9xu9BHRNCk=;
 b=K4e7ja+hggZI9cGMLc8ZctclVOdyrhjoRMLJQsh0H58pXCjuKJ+29HwhJCc7d7XEn+gm
 Rfsb/9xARZjZ+ybyEcw1r9m2lat2rUFAzFJf9v6z/vfzSNfwwY4sYMbeQNynvsh7qr/J
 FnGLypipZfkcnJTs9bHF4cSW7jEsmS1S5lqQzUqDNk0W3I+fMFpzqIq59LcFPjdRKqoL
 o3sz5M00QCHZ8m/nlRNNtb+ozZm5rdmHie/Ek655B3M1tYiBo0MGont3Ar1CxHW8E9gp
 y6MhDj4lASeqG+Z36uAJiXEbxQTK/eTrIg83y5BftrCTDxZakjiHlqFfqSD7Ui2xwNNf gg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3cscwcc7py-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Dec 2021 02:45:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B72bJeo124653;
 Tue, 7 Dec 2021 02:45:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
 by aserp3030.oracle.com with ESMTP id 3csc4snh1a-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Dec 2021 02:45:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5up3Q7JvZ9zLTpnIzx5nyL0KjiBqs6AlZGB6ZBa3ukHHi5JHD+N8GAqaqLbxMc7CMgG+eIHMVWRcLUXS8ObFYjLZP04Hhw4dkw3OBhQkX9qjEojdB/JjsHB544ALoHbvH8BnibFbWu9IVH8gJmhfDwESsaOcaOe186biufRoXLgGbP5NzCvNB4IBAi4KuwoiukTH85FMoHNW18scIBeFUwBc24Ph0t7GTmhNx+q3m8B9W2L+mgYSzkWvPSUI4Tvl0U6XwRtydxkZnMUhvTTi/ncImTuQMUqn1U30W4zZWcjJbUEb9QixaHCEf3NzWqdwImvzoxI5wiB+TsSBBO1Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvdR3HtsYLHvjWhmgga/2d0JO2zD6VWnZ9xu9BHRNCk=;
 b=iTf0vGFy+DbI3fBGBbT0A3TsCm+eW+eCL4VHGpJb+eDFnz/sMIN2etiKELOBbR/w3XDCHqm2z86+ISumi/HQOTCJf+OMuUlH1Bm/BaRDcEugouzwQLNDTNmqZQHfHQMky3Qw+x8p/JjkZa8XIcV8zCPPmbyJJnIslycuViCGBGxKHPxZKsrQayrj0eJyFidwjaX6stpVSgfYBRR/6VH8BO8MjmlZ8e8jpuc+tVQMST5fa06A3srupPzSi/ibXPMXYOBJmpRiy68YNURDs3ivpbwKmMwDPtPxGd8JK27OG7YRdSxDG4TEskXBcSm+yaO5Z9UdnkwHoPxV1vcvuai14A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvdR3HtsYLHvjWhmgga/2d0JO2zD6VWnZ9xu9BHRNCk=;
 b=dHZPFcq3DknKcqv5ttznU9e5OZ66TWzx7yDQ4eJaYoM78Q8+eatKfE45DRr9/V9W4kBW5DGjLQZS6WmYrYkxNs0F34Ev30Atu3AAEFqPFXhXqaWeniVQhWQGJKTWi0ietNbX8f5iJceTPySR1vKq0kMNLfzuGzvn8Bf+vvxek/4=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Tue, 7 Dec 2021 02:45:20 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041%11]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 02:45:20 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 arbn@yandex-team.com
Subject: [PATCH 4/7] vhost_test: remove vhost_test_flush_vq()
Date: Mon,  6 Dec 2021 20:45:07 -0600
Message-Id: <20211207024510.23292-5-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211207024510.23292-1-michael.christie@oracle.com>
References: <20211207024510.23292-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM6PR17CA0026.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::39) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by
 DM6PR17CA0026.namprd17.prod.outlook.com (2603:10b6:5:1b3::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.11 via Frontend Transport; Tue, 7 Dec 2021 02:45:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2354ff2d-c0d3-405c-c3a4-08d9b92b9c01
X-MS-TrafficTypeDiagnostic: DM6PR10MB4347:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB434700B4EDA1B9C8FBB706CBF16E9@DM6PR10MB4347.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KvQJIjKCTgPeXtZ1tY7YRR9brn5nhL+lytRzA25XlhlKwHBNxM9KVr5LIN1/QqcipDoHR6me0BiUdTBU9AODf++zd8z15QJRj2byIePf/5tdxlJkM+SigJTkH9GFDqA5MxBZo3kFQ8aBN+01FA/bYl8pPEm49OqfqhNK0q8ErXWoRM6YZnsqPTefaGDt+rr0nhksUIC7aQ2Eyy66ghFLha+OklvMXGc+OZU5RNO+GvobcfUWOGEOAmMucp4gvHPdI1DdHyPh8uc2LxcoaBf6iyyjx8VTiOUfiokhY62qg8VeciyM4Ff1kIiQYcBB0zXB3QeDYzoTb+XuTQ8vEE9DJdycflYPy2Ktb/zU16MyYqiRThDT4c5H0d+2ds3lWHmU1Qq0/s/rtUQgPL3nvVFkw/KcCwemcFBLvUwir402LtEj2QdXovx8w+1wqx5Lbt6f6yYn3C2LnlcQiBSWaqT8dkoy1Mo+9bRcV53WYJ22bxlzqewhG03tw71Y9ChuwDmBnOfVW2IM/S0YYU7Oc+qJ7PZm8CVWW8eY/+BsWhuMfTJuAlcBj48wvTZV4rr2mOkeZjT4GdyaTSYevKBsIHLkKqqbqv11DtrasaittIX/7WSlBL7z45bYjOqYENlBhycnLESE8axHpXtvwljPz11CAO0MtqWbQzL20PrldqporbU8eqoRgWGBAI3hindWBff29NPvqJz1XrxqthrEMEILVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6506007)(316002)(36756003)(8936002)(38350700002)(38100700002)(26005)(8676002)(186003)(6666004)(66476007)(66556008)(66946007)(83380400001)(4326008)(1076003)(2616005)(6486002)(956004)(52116002)(107886003)(5660300002)(6512007)(86362001)(508600001)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jt6RNrkrqosustCmHnZRmrvyvZCv8SXRw0fgHDzzRldd6SBB4PmIi8wRR0bw?=
 =?us-ascii?Q?jZr9dwQuJ2MrqSv4zgQAwWybUuhJtZMKG6/h9l23lmabJim2IokBHblGhcUc?=
 =?us-ascii?Q?w4xmuqESlAWDEwZvTne+cPnUQARPR/VBczd2l3TIqzDjbj+WaaKp4OFtmzQ0?=
 =?us-ascii?Q?jTKgmISm1WE473YmhD2ieB2zG/sEEo8TsuMIXt2X90Ey3YE9+VcKilixO8Bq?=
 =?us-ascii?Q?5h/uNpsp+zfeRDDnAohELhvd8lYRPwcEO7sDzb4n/tVs0PLyITn7NeZ7leOJ?=
 =?us-ascii?Q?QrDncL4FNggZwcxGqkwC8EkyZfGT8tfMCLVC7z8fh3JkS65HND2RsGcKM0rd?=
 =?us-ascii?Q?fBo0Y+OKZYG9m1wVEMUMAw/5RhyKtYR7MmjYlbIPOPZ1/iQkeIoHekxlCs0T?=
 =?us-ascii?Q?PW8MZb+gYGjk2QQIqqf5eMYZhxiwLe3uLP77OayM3ETd/Q9gt9Q1GOg4B7Bp?=
 =?us-ascii?Q?JGhOdLi8/PXJXNJtKVIXMAiH6kkdoWd6bS2jdYT2KHuiJ/7MVVEl5LOmO0F+?=
 =?us-ascii?Q?SZ6DpNIIHYVdsxlw8j2wKUVw4McjOFjsy1Yq9WTIwt5hqFAUONcK7+1O76kv?=
 =?us-ascii?Q?ZVSaiHuw3cqnH+drzmVL9SrWxjYJic/GuqgEuqxbsOJMfP5RTUK/axPRDExU?=
 =?us-ascii?Q?kGEVSrA9taC7+JcNtg55GJnZ61mLcAmWsdjQGF3MyQs5aok6+lHkXlVkYLvm?=
 =?us-ascii?Q?lN6TbO3c/osNhpzpb2Z0XuAm4Cyiu/i1yThxZT4bM7oKNJdinz0pKZU47bGr?=
 =?us-ascii?Q?v5OtzUw7ZmsoHbWYU0x2ha/t5JS6/OQYo/sRy2okbPbmm1cXuAUyyK7AAas5?=
 =?us-ascii?Q?29n+ACMIk3OfEjLBsbLYq+gLTrSqUvQajB+4PDuiTJ8wKQxP//ajgfywng/i?=
 =?us-ascii?Q?m0iohXPmWCALSm52YIoa734z483cPXVHqaZM3suDDmzvboV8uDMUWEQ2OLmd?=
 =?us-ascii?Q?ZiSHCZUFBc60V5QoZNi+FNs+rwLePQNPqHsGM4gBzzxDLUN7OGU6RxYYF10Y?=
 =?us-ascii?Q?v3Q9BwiHkgYqnP0DlygtFLtOdZaTyqUn0mrsOzR5h/9jpLT+cnRDJ+VEJO58?=
 =?us-ascii?Q?oAwFwd6ct6qFthJ6BKdBUcJs6v94pBlSa0Q7yBLQx5T/vV/Wq4d6K1Cs9EU8?=
 =?us-ascii?Q?ve9E6YVUMwEaHhfTh0vfjE1P0+5YQh44sOP3HqcOHdHtkFi7bnBLT6GTD9U1?=
 =?us-ascii?Q?X74kltbfFlegM4sFfSDiCF3TRK265yvihnODOLmb7ll4dMARGvIebgLql1ui?=
 =?us-ascii?Q?yxQhYWqr+yezYNoAMsqVTATACpz5mg3KcvfZ7sJxCpdv0N6GRdIdqUtDiokH?=
 =?us-ascii?Q?CozDojsiet+NJVguDyskJXKj6a3fOAnZbh8r0jgFnIkUmk5MRRAnuvC7/GgX?=
 =?us-ascii?Q?Ntohz+oRh7npEmtJTrx01f55L2rG4moqMQXKh1OKJUT6HKUiEVP45FE99zIJ?=
 =?us-ascii?Q?4e9z5In8enFoDdGvn7eozrFAz7aVu/BDIgjuk3AGHjlKUW3U/j+Y0OU/866s?=
 =?us-ascii?Q?nV+3fNYt+JkTuX+OB6XyYLXIeeoLvMTdWwynRsAjoZs7Z9DxxuwuqOpE1fEY?=
 =?us-ascii?Q?xnZ5lgnIszH3oajKB6vVBRLiuX2uE4tVwk8oZw10vFderQ9wDVt+5V+ujWRL?=
 =?us-ascii?Q?NmeRbx9894iGKLFc7un1UR3fnGjoPl6sVDmN/HrZVTNEwwKUoRbjb1oklV1t?=
 =?us-ascii?Q?JUXAkw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2354ff2d-c0d3-405c-c3a4-08d9b92b9c01
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 02:45:20.3208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UWMk1gjSCLpHZnQqBLx8YczOrrQLlt1CsbN2oWo9hWBSurpsEDgaAuRUG3y7K/n6blPru/o2aimxBRvCaeDe3E9CBG7x+zRJl6p3HsNKl08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4347
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112070015
X-Proofpoint-ORIG-GUID: RsOpGx5TjluMD36tZG_2LpxVNniFSLrp
X-Proofpoint-GUID: RsOpGx5TjluMD36tZG_2LpxVNniFSLrp
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

vhost_test_flush_vq() just a simple wrapper around vhost_work_dev_flush()
which seems have no value. It's just easier to call vhost_work_dev_flush()
directly. Besides there is no point in obtaining vhost_dev pointer
via 'n->vqs[index].poll.dev' while we can just use &n->dev.
It's the same pointers, see vhost_test_open()/vhost_dev_init().

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/test.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index 1a8ab1d8cb1c..d4f63068d762 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -144,14 +144,9 @@ static void vhost_test_stop(struct vhost_test *n, void **privatep)
 	*privatep = vhost_test_stop_vq(n, n->vqs + VHOST_TEST_VQ);
 }
 
-static void vhost_test_flush_vq(struct vhost_test *n, int index)
-{
-	vhost_work_dev_flush(n->vqs[index].poll.dev);
-}
-
 static void vhost_test_flush(struct vhost_test *n)
 {
-	vhost_test_flush_vq(n, VHOST_TEST_VQ);
+	vhost_work_dev_flush(&n->dev);
 }
 
 static int vhost_test_release(struct inode *inode, struct file *f)
@@ -209,7 +204,7 @@ static long vhost_test_run(struct vhost_test *n, int test)
 			goto err;
 
 		if (oldpriv) {
-			vhost_test_flush_vq(n, index);
+			vhost_test_flush(n, index);
 		}
 	}
 
@@ -302,7 +297,7 @@ static long vhost_test_set_backend(struct vhost_test *n, unsigned index, int fd)
 	mutex_unlock(&vq->mutex);
 
 	if (enable) {
-		vhost_test_flush_vq(n, index);
+		vhost_test_flush(n);
 	}
 
 	mutex_unlock(&n->dev.mutex);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
