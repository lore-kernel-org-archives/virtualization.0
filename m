Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5344EC433FE
	for <virtualization@archiver.kernel.org>; Tue, 17 May 2022 18:09:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C0F18405D;
	Tue, 17 May 2022 18:09:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ae8q_mjS9gpw; Tue, 17 May 2022 18:09:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 942D68404C;
	Tue, 17 May 2022 18:09:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63C76C0087;
	Tue, 17 May 2022 18:09:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A62FC0084
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 18:09:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 19D1660D6C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 18:09:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="p38pL/J3";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="c81+jzTZ"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iYXlkenM-QQc
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 18:09:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 59E5260B6A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 18:09:10 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HHSn6E019084;
 Tue, 17 May 2022 18:09:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=gq+aNeKhAQw+rlxUTnoktsmr9qMd0VpYfv1tivS/1Zc=;
 b=p38pL/J3iUjIUCDkuQ9+bbOIK0ym4VtQNhRU8MbxaRbwK77nnAsn31HIpALZzGLvqNUV
 i2ilijO0VGUG72kh0i0jmu+m5Hs3hfTU3kwUONEbKdoddhZohovwg7+Di9XJRaep79Sk
 KmBXdR+44cYyBLCJuU9kik1nbq5aUQo7MxHRivAbjK2eILjdHvW80oX7AfimoHSIRJmi
 RkvyZJJJCxkVqF8jf88BNYTaqfPpeiVm28F+YnsGu/HbNpB3CzitmgUIEB0rb+3S5Vjo
 eIaj/b9qleijIvdvctp9VniWo3i/r+ABrPLSfi+kXeSSnfWgSZjemy7ogm2/Sr36IspB xw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2371y735-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 May 2022 18:09:09 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24HI5VfT017126; Tue, 17 May 2022 18:09:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3g22v359nm-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 May 2022 18:09:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8sVFfrQoHNZAIt2SHkbMNErmW3f1+KqUlLyiLHm17dbMzGUJrO9hjKLRJ6/tEPl5h1e/sStV9oPxroBolRCyfumhdcNaQdP7Ac0fitUeWiJ/tB/kq8VTBGSNaw02DlyQbrs566cNKovKhb1nnzuNx58ofnOXSuxfB7ohsNIir1FUKOGFc9fo6FNIsHGBJb2XGtE0e8ZUTWIU3Fan+Qwt6J70GpnD5Xt6jxeRnHVIjFdEpLdQL3xQnh8pdQMjJrB72fDMDQnw0DTqCmz1aRQ+c0hwXmWk+txgfbYpTDvl+sZ6w64L7rMb37GPDmq130RqWOE4mW4qHWQ+tdtGKxDPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gq+aNeKhAQw+rlxUTnoktsmr9qMd0VpYfv1tivS/1Zc=;
 b=JIJIbcV0vBbaPimhbF0MCPiRFXzGgigXm6IwF7ySTT8EID+BI15lLrSyOA664kfVotmSEoimdWZmO6yTOfcNOwB7QT+TZqzu/sQGvAO0nwnc0i4LlRvrthu2tB1gUuR/QuJ6v6Ot5llYKR4lz2xCccvQhIykjV3hqF6GVVekePFUdOO497ZC4kPESkCMm1N5BlRUEu2lEsLwrXbP6m7GY1jAQDaXiHnY3JP69ZOPeIUj15n+K8miqN/TsmjyZAx3xUPcqUr95bWciUYbejmw7NJqVJLbG6UOtFrfHIi1rEZcpeDu1A/3Gf0Fa2J2eL6gERnFzP0NJKLF8ZAofZ0GJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gq+aNeKhAQw+rlxUTnoktsmr9qMd0VpYfv1tivS/1Zc=;
 b=c81+jzTZ2fu4XjVOWqVxa54lQXD4fxWRlHJQcP7bPipUtz0E84zC9s/3Q131OfbMu7UUSC6HonEM+EUhfsgx8AqeUJXwGDeEzNjOOYhhbWJn2rJsfyBR+2cgPOSjcGKYoUN45iEK7gXPR/JO4C5iguQisi3IcWpKngzkWdXMrXk=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM6PR10MB2873.namprd10.prod.outlook.com (2603:10b6:5:63::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.18; Tue, 17 May 2022 18:09:01 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 18:09:01 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 arbn@yandex-team.com
Subject: [PATCH V3 7/8] vhost-test: drop flush after vhost_dev_cleanup
Date: Tue, 17 May 2022 13:08:49 -0500
Message-Id: <20220517180850.198915-8-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220517180850.198915-1-michael.christie@oracle.com>
References: <20220517180850.198915-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM6PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:5:60::36) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42d21d7a-f714-4e34-7bf0-08da3830524a
X-MS-TrafficTypeDiagnostic: DM6PR10MB2873:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB2873E6F0A623CEA1AD0C61E0F1CE9@DM6PR10MB2873.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fx9prrL7/K8rEeS4sHypO1Ozlg9wbJK8FsQqTEv+NncMJcZwqghUv9p04XcAxMh8D3drvkpr+apkUYPLNNDtWM1TURGwioxK5d/d2AINfHCRDCZEMQ3YSd8otFOQJkNQHbt3U9MbzldX+T7thbIlyxZ1ozdiMb/TQihBTUkRKuVDxmi4zuA+saFQhQIli1BMOpuZutqmGXY7cK3ThUxtWCtgrHOFG9keFHGPwqAsSRB6JnQcILd3wA5ydAXO0EMI48z9p6LFwvQGGIdSjE8R6wZ11trq5f0Tih9kD+RN8AwYKfjML9UmKJwmYjCh71VK2scnzY8Nve2WF7dO9K5OXyJ1kzviwzCdiLcGlRv8lkGNzd3XvWxPJ6/9F3CQU3tUmJA0Sa3+6lDwMqZKitMp7AInF4klweaBPff1UKMJiKJl6q4gRKCQkbeK/FQrb2ITjllfWuof6/4F5bQkCU6zMoioJKyt3o9t/gH+anymsehc7jmEjX58YwZImalzqkE4WnEBZlwDgGZrCSuC+0AAscdvjMqyxYchNCrZzzXz2qr1bESWGVEdTCll6YDSeucdZNhSR4xewxtYed7wVv4jc9F9eZ3/MXMCpD5ebskftFnbO8p5mMC5gxXhKH01v/X5sZyu3I0CmEokonvuogB7UZPbbPG5DLqXPR4exQ3qkAv+nNAnrwQn2/arHsNCUI8Nlzb1s7OKMhsllHFdLjcfcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(186003)(36756003)(5660300002)(83380400001)(6486002)(316002)(1076003)(107886003)(38100700002)(6512007)(6666004)(2906002)(6506007)(26005)(86362001)(2616005)(8676002)(66476007)(66946007)(66556008)(4326008)(8936002)(508600001)(38350700002)(52116002)(4744005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xoj2g12M70B0IeMKiqUl6JHi9+e0zsX+PmlaYtYisDbWaK6mlEPWZ7pN/EWd?=
 =?us-ascii?Q?CzAeYB36p3u/UBNrbJ6ww+5wwPkIP45RfGD5y8o358hJxJTUbxBKGEqeQTAV?=
 =?us-ascii?Q?KKaty9vyV1/oZUcThzLnizPSRWb5fsIuKkAjO9M8pImZKxxxcq6wqlX5fUtz?=
 =?us-ascii?Q?/DdlU6JusZ2LZjjMT8tTYyNOBR6jqOrWdUzDaDrFYFcGY8NzhlRaW/7YKUqU?=
 =?us-ascii?Q?Cq3XJRVGTfvh1qAIIy/D0MIieU+25tPhJLtbEFFBOK1GSILfK3ofQT0XbMoT?=
 =?us-ascii?Q?efe4balEThNkd1yY0F+EfjZrh9kIn7SrFavzuHRNU6exu+kyKVxVc0T1tSYb?=
 =?us-ascii?Q?e1VMwXEgOcxeb8stEGhzNjtSXUtFeF74gH7luqlpCxjOx3XbMr3g1Q9kQdgd?=
 =?us-ascii?Q?zq0bP3ZOY7pL8/Uz6cK1POVqh1qEq5oku1gaqOBAynfG066yME5Ytr9IzxuQ?=
 =?us-ascii?Q?vyuekXAtiU722XYG+qqErEjDyNupWqI0qO7eqglE8tZbApqbeaaH/Kso20Il?=
 =?us-ascii?Q?09Hp2EIQO2UTfommMhELfGdtu0ENaAIzlVbae7WzhXkP0JshJ1dmxGCMwcmW?=
 =?us-ascii?Q?VfChs88Mz/nG+kSthIyuHZRrBjnIDa6jfp+3pA3xJrAwIuX0eANqPLMPLKf2?=
 =?us-ascii?Q?kmEaBz/c3HwlW5giTqCev10BMs0NCWd21kHtUbP+VAlnxztbKtj8wKwowf3u?=
 =?us-ascii?Q?od5HBMchbbtygtfmNBK8IMpsb83zOsU+pbXm7+wOykpLvZFHxyiMjnJ/S3KC?=
 =?us-ascii?Q?VAwfcEfHQINeYrVCSzFAKRrE+W5ZBGq97Y2CWiYlvBqBTfvd0I2QHxsfAaIs?=
 =?us-ascii?Q?R8+39SV9cl+UrIv7IJMKIxWQvyqC9tXxO4iCJDpwP9/oDX3/IbuPRq6Okleb?=
 =?us-ascii?Q?M/7+4aXESlibh6VQtj1iYEcVz2QDLhum8Q4ErJQGI89rS/U1NMBDToiWJJOs?=
 =?us-ascii?Q?U08brK089DJsZalt+XqakJdeBKR9KnFxRBx+4cN4sw5BQ/hrhCyot1mBjqJD?=
 =?us-ascii?Q?AlwA+/2rgStsWlJf4X/vWyDYdxVHleuaKzTi5Z7eLuBZwbEi2O2lebVYPwsl?=
 =?us-ascii?Q?AI0uIUtpGHHY6q0HU0hNhww/VXzdX6ajE3RnSgUl3/KGW+loU2y6o8PK26RN?=
 =?us-ascii?Q?Y8ECP3fQJeis9P126oPgs9uw4e8YUxnFy42LtRpYNkU6MAQVQKmrLf9u4V81?=
 =?us-ascii?Q?9shBXiGowKOUAoTz1TNffZq8j+/vazGhzVFpo2xoaYpUyHZPY+GIW+Y1LJdQ?=
 =?us-ascii?Q?5X3WAsX7bONIJJ9gkrYz3kNvV4hZRKxifPDE0dGUTZKtwu5UwJ4CjzMZ2gcm?=
 =?us-ascii?Q?Pofd4lBBlnvK2wfugQ8YPIAxX+HWr+RaGa/W0T001TgrdivOa8YGOsNsAHOU?=
 =?us-ascii?Q?FMnKu+1ReIlirySC7ZjrHGPDTAh4dtEUgpyjbar5rcilH75dzOeL8NI0OqJG?=
 =?us-ascii?Q?v1PxPmqToSSgecszqMQhIahucE2SHmpQujkasgUMhY3oG5a7V6znuiEphwYr?=
 =?us-ascii?Q?d4lkiDrP0MMppBa3jt0thLCbk1lXtBFIG6rqJdkEqt/xItbyJaho2sTG+WoQ?=
 =?us-ascii?Q?bpmXSdU+Uv99o7wYOOelTDfZQdMwmY5upFY00tMDHkSSzip+xKnmyL/t35Hy?=
 =?us-ascii?Q?v6xCvIlF8ZgDuqXYUVhJDl9n9A8z3ZKH6/Eqzo1Nb2B2xKZt5uiAjApjbgx1?=
 =?us-ascii?Q?weRCNojREsanSiZQw3HXlg+n8LSbbUcKjNFNa7bRof1r5HFvnJiAVnN2VDHA?=
 =?us-ascii?Q?z8fuM4PDbGhwh242mzv0jDXD36eaUB0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d21d7a-f714-4e34-7bf0-08da3830524a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 18:09:01.8107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IaS/aGk+BErEjDg+vdq0osqJ2OaC+slxFT4QNKHGfwouYOcm4E0K48prfIRYxT66TnbErmR4z2FSGlQ9G+7YE23PiMqNLjBHlpSAC6ET1iw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2873
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.874
 definitions=2022-05-17_03:2022-05-17,
 2022-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205170107
X-Proofpoint-GUID: rTPr7NRX-Z0mC6JjvjLYTeG8MaxFHUW3
X-Proofpoint-ORIG-GUID: rTPr7NRX-Z0mC6JjvjLYTeG8MaxFHUW3
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

The flush after vhost_dev_cleanup is not needed because:

1. It doesn't do anything. vhost_dev_cleanup will stop the worker thread
so the flush call will just return since the worker has not device.

2. It's not needed. The comment about jobs re-queueing themselves does
not look correct because handle_vq does not requeue work.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/test.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index de39151366c5..6c139f18bc54 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -158,9 +158,6 @@ static int vhost_test_release(struct inode *inode, struct file *f)
 	vhost_test_flush(n);
 	vhost_dev_stop(&n->dev);
 	vhost_dev_cleanup(&n->dev);
-	/* We do an extra flush before freeing memory,
-	 * since jobs can re-queue themselves. */
-	vhost_test_flush(n);
 	kfree(n->dev.vqs);
 	kfree(n);
 	return 0;
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
