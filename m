Return-Path: <SRS0=YcCX=LS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE31C49EA6
	for <virtualization@archiver.kernel.org>; Thu, 24 Jun 2021 03:08:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7A55613B4
	for <virtualization@archiver.kernel.org>; Thu, 24 Jun 2021 03:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A55613B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5B858400DE;
	Thu, 24 Jun 2021 03:08:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IPHkYz-aIJe7; Thu, 24 Jun 2021 03:08:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8D69C400DC;
	Thu, 24 Jun 2021 03:08:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 509BFC001A;
	Thu, 24 Jun 2021 03:08:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2789C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 03:08:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C83BD606C9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 03:08:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="g7M+6awG";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="GClWq83f"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KyomNhoDzYJ1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 03:08:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A2DA6606ED
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 03:08:28 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15O36LQc027553; Thu, 24 Jun 2021 03:08:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=+5pf712eDs/LVXP3jsOVTOPjxuVMYBxMmA020f8K7Jk=;
 b=g7M+6awGnFh7Nh/ypTSnTIq+j3Me4tyKPxi+5Sk/9ZtFHM4U9wHJFDNE38W6FFmVtA7S
 F3TrToRv1mWJi0zJHcm4QRObm+0tYan3tKLUoJKiDYInJN20I/mAf9PLnq8EHn8wJN31
 wGVl2M3j/RVCaXRebxpV+Qi5hw3WPStoTkYo3RrOd6lVDOOSZxg6yGoGHNz6O4lSXi2d
 vm/81pm0DkLtnBqDUT/zc/GJzrPsiLvyPlSpHNw/doWFPJZf7wFCEJ9nVDXLDKh2jAUr
 YTcQukww9QrvLuqERwIEop077x5KGGs8jBXpnNY+QqBC5+LSQfhxXtcnjUdFU9roT2Pf mw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 39cd2krb3y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Jun 2021 03:08:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15O31J1s094310;
 Thu, 24 Jun 2021 03:08:21 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
 by userp3030.oracle.com with ESMTP id 3995q0571v-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Jun 2021 03:08:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3c5GPyri9K3YYggXO2zKS9fdbsxWSKBy+FFF6SoWudTEAixKmKsb0GKKu2cmdvJhZE2n8QM6gdKyuQXduKvhWDl+q63B7kS0mwVj+iSqZyzPnEnVq2izLZd3Sl54aOl63p9ejQn7gu4+KXDuwXBnZqpARrEzANYCvll/c0YsE10HiOhH1aWV+qjxTI5ggqmdhjJRmYlba2hBnflmskv8Gsj2zz/pbWPXzQ42J+6PYdwtEem7tqFvR2Yr0ygHaAmA3OWL9iXyRBYhRRD3YEnUBNxR++6XYIbcZ1j7DfF5Q7+vTApUxLxH0xTsmQ5W6Ykd6mg0Ab8KeQLWMvOCgT0nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5pf712eDs/LVXP3jsOVTOPjxuVMYBxMmA020f8K7Jk=;
 b=ncL9Lx2PR+sp1pyf3P4Y5d7q9/xU4bGv1ZiUgFoD0vgOlqdwtJwyyLhifT8wzlRWICGLfnpL3AZlY+bx6fr8b4XAUTLs5Q+4MzTnUBo2fsSNPjKRCL14brXTn+88ThZhNQ/3H+F9R43q9Fupj68eb02kWZFSPATManZz+F9/Dz7KkLFeN4hLr+yUWCHoj+6+SXVM1aMxg8nGAaSxDS5j3BPBNOnOOejwRjcVBLih2cX7q/jm3BpXSLzyz7BBjnU/Vs29lzqz6w33UbQ23OcGJZMFFrQ99i5ZJdRLvJW/iMer/x95ao5nnzVZN0z30STi+CLNpyFy/rHXMBn0XBnI3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5pf712eDs/LVXP3jsOVTOPjxuVMYBxMmA020f8K7Jk=;
 b=GClWq83f5ZCgB/JECQtiruaUytxMeH9M1Kz+ciYD7SLix0dfB8pvo0MeEXoqOkabnUSf+vo6GjNETdBcOMlU6Mwby46JK9MBeWRMt9y0u4TqHT8bYYvVU4k8+yEYxnVBUSk78e7/hML8HTvBcYxO1PIzwX6IS9K/6138j+wdrbY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none; vger.kernel.org; dmarc=none action=none header.from=oracle.com; 
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BYAPR10MB2837.namprd10.prod.outlook.com (2603:10b6:a03:81::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Thu, 24 Jun
 2021 03:08:20 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::b09d:e36a:4258:d3d0]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::b09d:e36a:4258:d3d0%7]) with mapi id 15.20.4242.025; Thu, 24 Jun 2021
 03:08:20 +0000
From: Mike Christie <michael.christie@oracle.com>
To: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 mst@redhat.com, sgarzare@redhat.com, jasowang@redhat.com,
 stefanha@redhat.com, christian@brauner.io, akpm@linux-foundation.org,
 peterz@infradead.org, christian.brauner@ubuntu.com
Subject: [PATCH 3/3] vhost: pass kthread user to check RLIMIT_NPROC
Date: Wed, 23 Jun 2021 22:08:04 -0500
Message-Id: <20210624030804.4932-4-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210624030804.4932-1-michael.christie@oracle.com>
References: <20210624030804.4932-1-michael.christie@oracle.com>
X-Originating-IP: [73.88.28.6]
X-ClientProxiedBy: DM5PR2001CA0008.namprd20.prod.outlook.com
 (2603:10b6:4:16::18) To BYAPR10MB3573.namprd10.prod.outlook.com
 (2603:10b6:a03:11e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (73.88.28.6) by
 DM5PR2001CA0008.namprd20.prod.outlook.com (2603:10b6:4:16::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Thu, 24 Jun 2021 03:08:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3aed8617-8173-4202-0fe6-08d936bd51fb
X-MS-TrafficTypeDiagnostic: BYAPR10MB2837:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB2837D7023BBA979DAE193E85F1079@BYAPR10MB2837.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Pd7DLe7i4q0k7yYrM8MfFg6IVar4z9i3VyrYuhQqyR5wH+eH3pYd8WPSrX1i1I+AVYJGebibcLw/8RZ2G8tpP/BJtU7yEgcuFu5fj+VLkAhP8d03thCSZNkAb5zmErp6lpVY3mDW/mrcVkdOy1WTA5HBzvtv2xUsy0jOEeU6dSTDdosenj1mwH6TC9ECL0LCnNdsmb/rhtfWYIiyuWNszCehpnsAvHqfyAsizpaEd9HiGDEfXvxVzEqlf3hSo4YETrCl6cCdWtgyf/a65eyNWH8tbSnmw7+5C05UKITutuPwU0MBRyMP5PhWSiFU5zk2Z5eqMqZac9gcjZKa+odLsjWMzzKBNtkNdHBnP3Nlrk0IL9SrlBjv85pC0yhHRSuEeqYMAHz/jPG25nBLSbtkLdBHUUw9q78GQ6kJ6Vp+R4/I4tx/8aSbFgVaXiksxt86mSeb18fTtTf1bupmrnc3xnYsWpQWaiRkjpGl+ZTlqE3mqTZfdFOyv6YMV9GMN+Ltjc1qHVPuyoP6c5+JUI0ZdALryQdlvd4jYZBOABg4D1GVWhcjBxTrnpcFpdvnG+BdXPyea8RcWjItr3+O6Tx9fRD12vrnN4v+26shJ28IbyTLIp4Cvps6rnfUWJHIbcAlBrrQiSOba9yYnU0xMCS0XsqFbzfMF5L1VQl+y8RsU78w/z4sA6c7FXYD+SmlmcV0o4MbksA1lnjFhqXXRX2Rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(396003)(136003)(346002)(376002)(39860400002)(66946007)(66476007)(66556008)(5660300002)(4744005)(2906002)(2616005)(6512007)(4326008)(26005)(6506007)(316002)(186003)(52116002)(16526019)(956004)(1076003)(7416002)(8676002)(478600001)(38350700002)(38100700002)(921005)(83380400001)(6666004)(8936002)(6486002)(107886003)(36756003)(86362001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rgFvD4oduyr9BnR50pZTX7QL0zYOWZO+oK+g14/5VfqayHjzSrN8sT2l8FsU?=
 =?us-ascii?Q?UAI7ynsy0cfKxn5k9Bs2LYtUmGg5dWdjdgfSmPqet2D2OoVGYEivZB8T/eSd?=
 =?us-ascii?Q?8Z2YSYfE/IdWDLTVm5hCEddk4iYSzJ7Sg+eGJKfjB0UQ2vZL8aYbgE9CVMbs?=
 =?us-ascii?Q?ictowocguRrtXVFH+VNtC+iTZl+351jSzWBwZNsKVCG3vDPH4KE0++DYD21g?=
 =?us-ascii?Q?tI7ZpoyMzj50Bkah2gHe14I8hl4bwhGkvd+LI4Y+BMOZlmEyHIr+M6gpXTyd?=
 =?us-ascii?Q?Cp6YOvJ5p6ulFCNHy4+n8fFVlwhn5DERvfutr/IzRJ9SAObFGfvMzLFKsyk8?=
 =?us-ascii?Q?QCFEb3kvcA4CdYfGAd3YyXM0pk2NWxjg0NhrzldqEDDnrTeop9NZd4oJfOod?=
 =?us-ascii?Q?rcSJirdEormDg5cRvX+Ndn2XY69Wpf9sqF6ZdujKMTVYwKHWQXXWVVNDzVxh?=
 =?us-ascii?Q?AbHheL4N6zBroxg5TzIsPMKeqcAVP+0GpdAbNe9T25AG78Hx5ysas+sqdUf2?=
 =?us-ascii?Q?ChNvUxt6HmxzSrJrhwHohsRcqnUvTG/aD3yljrPCBiV9+Pn4BUIzExPv4I2/?=
 =?us-ascii?Q?qbG/oToXMwq7CaM9hjkZ/zyEvGgiZouqlG3fV9QoMPWU6sSgSXD3Yx82LatG?=
 =?us-ascii?Q?e52YU0kWX2d7G/NT+q7Fxbsq1s6ecsYtgRMKX7upgcxFEUewi3Ge5mQen7gD?=
 =?us-ascii?Q?4GzuEm85gsEcaJF3XbYEGL20ZsWNDppV0364B+v3DYZR0mSosxivcQ32Xpkd?=
 =?us-ascii?Q?1l5MRW6zgxcGk7agRgCNSXn0yHQT7A7MfUce720oRg2sSoLaa9pphyRvwIEr?=
 =?us-ascii?Q?btd7MFsU4eolNu86LIyDSc4sP7XR2g2ba9WRe11bcV+6Tv3c0CQKt8OxNyex?=
 =?us-ascii?Q?SgMR+6NIq1r3d9J+JrE5YHB/eIagu8Rswy3vJOYC8FmrIXaGsGSAXuh1KMvA?=
 =?us-ascii?Q?hxOf4bZR9KmCvjvD4VNfy0aQHzqSbrPO9Xc8EoreNZvYuP5GJas6nFVM4xO4?=
 =?us-ascii?Q?/zVmfXsuHLT2YfdjeIL9TDAx0fpG4oyNP+6GmG9fuinDw+7YHJ30SC8vHoRW?=
 =?us-ascii?Q?Dou9oJzJnr/dvvKl1nUGHeK4ck+dawEDE4nLmI2jb0kgz5gLYQOPSruh/FbB?=
 =?us-ascii?Q?X2sRHuprUfXvHNoirgJiA970yAPm2JR2sZHhmbQ4kY0XRYaeiskfUxch3bid?=
 =?us-ascii?Q?/MRn668SMRDLuve4JvhZnCmhQbILswRVPVuXZBQiiox5lJFm/1Rfjy4ZeuNi?=
 =?us-ascii?Q?ouG0U9IA6yk3GdrtReQQkjXzGkd9HheN8Yh7N11yNBTj+qC1QNzsKfy6TUsv?=
 =?us-ascii?Q?w9eLyFWsuOKQZ6RqZgHbThqV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aed8617-8173-4202-0fe6-08d936bd51fb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 03:08:20.3701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vc2NTQI620WnJNGR2x44roCDsFOTIsLOqxYW1fgf4UXT6qnKZlIBichNHZ02A0zmZCQiBHDMEyWC0A4kTO/PCUGlH5xmQoCzTHo7x3iOFJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2837
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10024
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106240016
X-Proofpoint-GUID: 0yQOwICY1MVL53I_QJtRRG66iOUZfK2b
X-Proofpoint-ORIG-GUID: 0yQOwICY1MVL53I_QJtRRG66iOUZfK2b
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

This has vhost pass in the user to the kthread API, so the process doing
the ioctl has its RLIMIT_NPROC checked and its processes count
incremented.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 5ccb0705beae..141cca6fd50a 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -595,8 +595,9 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 
 	dev->kcov_handle = kcov_common_handle();
 	if (dev->use_worker) {
-		worker = kthread_create(vhost_worker, dev,
-					"vhost-%d", current->pid);
+		worker = kthread_create_for_user(vhost_worker, dev,
+						 current->real_cred->user,
+						 "vhost-%d", current->pid);
 		if (IS_ERR(worker)) {
 			err = PTR_ERR(worker);
 			goto err_worker;
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
