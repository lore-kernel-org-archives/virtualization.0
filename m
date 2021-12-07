Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8B7C4332F
	for <virtualization@archiver.kernel.org>; Tue,  7 Dec 2021 02:45:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9CBA241C73;
	Tue,  7 Dec 2021 02:45:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0uCZPCIG7DW7; Tue,  7 Dec 2021 02:45:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 348AF41C71;
	Tue,  7 Dec 2021 02:45:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0394FC0073;
	Tue,  7 Dec 2021 02:45:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BC97C0071
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:45:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4F8E460799
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:45:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="RP2SGa2E";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="lQ0x6P9H"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2nHCc8N-qQBM
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:45:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7A77D6072A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:45:24 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6M5VSH007611; 
 Tue, 7 Dec 2021 02:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=tJZMBBOQL2nmuOwz9ZWByXKz2fW0B3ys0r84xM037Eg=;
 b=RP2SGa2E7+fCofXkLnj02tf/y1HR59/4+g98A0Fd6MYoEGPHrzc1jeARdp4pPsRKmOxy
 DH4gukPF6fBV56FnHZ2zOZzxUCQ177vMgmGrAH8/T1Gx7Hnkenfq/MATYrvviWTyL/uM
 RqGnTxfszr7OpXcn0t6tomLz793uu6LnrBoDYbr/Xb84vJCjFDZlzgqXrvwOMwA0+XsX
 GVBrb2R1tPsIDXYKD/0yvMdZoZW56PXPdHyQ926t48Pv4XehrkfTQ7n1qhTISOYmgQZG
 GAosGja+QoFGmkB8ATRqp8IoMoE6XCaPENS1JX9SRH78UnO/WeWNx9lI6Kpz45D3ytzR fA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3csd2ybuvy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Dec 2021 02:45:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B72bJel124653;
 Tue, 7 Dec 2021 02:45:21 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
 by aserp3030.oracle.com with ESMTP id 3csc4snh1a-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Dec 2021 02:45:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lt43JbRWSzHj8qRY1FMcmDziRcDTnJ47Psp8/OeCjdWyuu+Ja55+BfL8FlUda20KApPtqN8L67fErBiRzDinFqeBZvajMmwAkodk7dUt8vn8iuxSLhFAnrUtQ+N5RTiOANZ5BGEM8Fx+8fMcyGF7C29yXo1CabX9cDsfIaSsiFRFDgzwZ0FFkkF0cWWoPnOAxE5X0BOMqLSr7OwIgKT9+n6WLmn7GLEhM6QbdxOk+57XNT45201EzdWzHsAbR3QVVcLROtRdjxeXHqbZUppGHjzRf24lbSSlvVu4qBSQF13kbSODTWVklLEeUQ/ME6KHf4jONQQE553m7YvG0SVkYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJZMBBOQL2nmuOwz9ZWByXKz2fW0B3ys0r84xM037Eg=;
 b=jX/5V90FVc38QMQDVqVlEPNdr+6cTmXKkYn14e94SNgF6E2HVRksJHDoGTqcAq9H5s4t/hQW2285uclBT9u3faTi5WlsY38sbSfpMqj7TYuk3fsPwTfU8QC7zbIHquHVS9NgsSJDk1WHlAyf7SkmpEQlv8zAh/+qHZGsVYbCu5S9GJjepR+5JICpMLeO06HqGRcojjLI/ZSrxEk7OoeEt5OXbu/0VOvDBhDxofZ+CVWun8sIM7hFVb2bJVuf5PJ/eTBH8KIn/sjgiuE4LxBmEDgwqR4vhyjxSWirQBZjh+t3YBNi7ZRh+zK+DSVzs/efiPxbRhMl+UZrSNlmzsRWFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJZMBBOQL2nmuOwz9ZWByXKz2fW0B3ys0r84xM037Eg=;
 b=lQ0x6P9HrgyPFELNEgwjnCgAuTdkyqEfw87kHGX9GIHCrxkJ8oW/zmaxkIp6OicJNitx3F8xHL9HgFOhwFxHW+8KUeSfJKp8ZLoQ3E722sWmjsEM5ZKHQBMItAUCpZdGNCmVwM13kt6iTloNK+uWNdicvE+miPiKcS6tXe/LvFQ=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Tue, 7 Dec 2021 02:45:19 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041%11]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 02:45:19 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 arbn@yandex-team.com
Subject: [PATCH 1/7] vhost: get rid of vhost_poll_flush() wrapper
Date: Mon,  6 Dec 2021 20:45:04 -0600
Message-Id: <20211207024510.23292-2-michael.christie@oracle.com>
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
 15.20.4755.11 via Frontend Transport; Tue, 7 Dec 2021 02:45:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdf83465-da9b-4d3d-7014-08d9b92b9b41
X-MS-TrafficTypeDiagnostic: DM6PR10MB4347:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB43473D73B09A0739677FD4B1F16E9@DM6PR10MB4347.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CC3qdtNsinvm0tvP/bdLhtRlOmuesZKBoarQpO1kkDO3N664Nl8fSqM3HqMQhUArdpGFXUPC/R/wRBgDvIOeXUBsjkXGlmrffCva0J1F7did5d8CSal87o3yCfcj5ezK4rN+mpJkNkTyyWyGoy2CaR1aUDWyMOByNfJDlv9OuxVxjjtQsKVSmdkG3NutWBP2glEYLqaE04NU7F4txeksW/5lU0S1P+tBqBhIBiCO6PV0M+x1PQ8yYcZcb0NblKNxwwunjSdAU6PeZbkoacKme1w915PH8guF60lo9doDfa6iDrstK26EVHsvlYqQ612i4SI1FPHpDhSgkvKXPmcBjFMPQE5GQRBFiN7lRXphqMkhFhP2E0gehDyatYoEfxhAMWAyTk5ekEo8z5SvyJuuKZJO5N7qXtYo3AGY3EPuQ1NnG/sLhCOi67aFmVJrZie4Sxqh25nE5phgIaDN8k2JWeF5hyAL1kl958sDxbPZuQ8zKNNkFZIXpVe4u1BsS5dadODD8eqA78+bLCwR/tgMnD/i8j1/cRVyF9LRjaolKo890Tt9Go97iRd0GKIXDCmHlJQ/7nrsQwRnhJ8iS9LDZI0X6AcSfxV0tzPymHXdRNBivj84qeW4O4tqnUNwB+y8zyq/ec0/UOO1kRLFz+YzIlFddGLN2OFjxCBw6BuEZl9+iqjBk5AyXZAHEl5al9DU8Dwx5MMGJQRpitHDgwIKCRWkx15LuZL1UEcjJA1LDeg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6506007)(316002)(36756003)(8936002)(38350700002)(38100700002)(26005)(8676002)(186003)(6666004)(66476007)(66556008)(66946007)(83380400001)(4326008)(1076003)(2616005)(6486002)(956004)(52116002)(107886003)(5660300002)(6512007)(86362001)(508600001)(2906002)(26583001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c3J4j8tYZkdTC0xcyAyc8kF5gYJM/6BmZJNddFjPVEqOg43yBgO6UFEDoilX?=
 =?us-ascii?Q?DrHxEQY06OOM073OthXbeLOwr9mgYaDswxSODX4NgstG6k/y6IRRdZkWZjlk?=
 =?us-ascii?Q?u9NQ22D3FGGXuQXXCmeFurp4MJMSTOf2u8HWR6sM5iJW0ZyR6ZugqZxqHd2Q?=
 =?us-ascii?Q?fLlUvrgL412Z+24MuK/nCqTNsFbPou6AaneEbTET9jA/QT66c6dH8PKUCcWk?=
 =?us-ascii?Q?Wh5lpoK3MVU8/ZF+nAb7sd4lBbHNIiF/cbFpDIK6vd2yTPq1F1fJJH9a00dh?=
 =?us-ascii?Q?2J4w8W70Peqp2wsqH1ms8T0E6V0CS9aI/W/bEh5yHAqA+QOJ2U41/oWwtYGh?=
 =?us-ascii?Q?s9ZgWPMjT0vRGSvPsRHR4qjuNdAsNmshHBJKW0Ad09db08UUOU8ci2SvWAvE?=
 =?us-ascii?Q?l06EwPJfIw6Pj7GEJmTzRhZeaYj94/vLzUoL0sBKkGclry21vo+QDvfHj8k0?=
 =?us-ascii?Q?0mdxALgCbywZyf9506F5O31XoOT71EXvc8EnV/MBbfMBCo/ZvjttbjNOEidd?=
 =?us-ascii?Q?CxWsVJfYXDNjlfY4gmXvNV3BTP7tM/C7JHJ/UDWSY6+dJraOf9tQgdqwXdnD?=
 =?us-ascii?Q?+X3sdpHtONWn7adjuJyElfxneNjfwuo5pYm219ySBc3b0iW1O9VfDseAu841?=
 =?us-ascii?Q?28jDGLpcGbk/dd7FNl541MUXdmIT2UACiE6jDRqFVhxZJvMwzbfwjIg26SYf?=
 =?us-ascii?Q?qvVtmaLv5HuqmD7lAoTw/Tg+/Wi65FJLtihjB/5fuB6aWyjrbDX2aAozcwSj?=
 =?us-ascii?Q?SWM3Sahlhc9V6ZnWhhPRtAVfaS8iuFRCfgb0jCAOjOMjNOJcAVhqEEe/nwyp?=
 =?us-ascii?Q?RiRYELfwbdAIt+ubGbEHKhX71vlCdBIQ19Ba6dGtT1avzonnQTzGrnWgz4KL?=
 =?us-ascii?Q?Oszj+VvQ9L9wlJB9kxnP0A7jrjh6COnrcUDB9cQmnoXxXqfha2b8QSJBb2N/?=
 =?us-ascii?Q?+8lq4O0m5QLDriGAI6Ca4PV9uT1jXQc/6tcAXdaBuxkOIS5nfiu8LESNmJoY?=
 =?us-ascii?Q?Ou4LfcxgcL+pRpDFVaESvV1QdKWvffFge97xx9vhEFgb2JsBSGeBGCmEcBXD?=
 =?us-ascii?Q?ktp9AXFWufv89nxxX3tMseUf1M4XjSQSu7HtvyznwXBg9Va0p2duszg+JTrp?=
 =?us-ascii?Q?wAb9IX36OgbbzKhphyZMeLlQOWWpIhUvLEWhSKye5B/bNKCbxy2nU9kNP5h7?=
 =?us-ascii?Q?QLnDduull/zDpzIqQ00NMEmjFz7zM8uzRpRNVXY3rD7CenTTzWjoHfglQago?=
 =?us-ascii?Q?zYrRAwhfI0+Mur1RDv2UeCUwE9msRhZmAe7YCJj1d3WW5gv2Ud8ljfJeYl7Z?=
 =?us-ascii?Q?Rs9HQ4jPE7beu1N1rW52e1Jk0SobzizbUElw3GfcNXz4X8WAoYJpC7smynJ0?=
 =?us-ascii?Q?hx6IXelKOc/CQ1iLhM5x6sLtoLdYEz69JM7ZrTS7lJnGFZiqkBK3BWZiMDnD?=
 =?us-ascii?Q?VAMl/BMfxDmIPvWECpSV9mNye3PC73VcCh0wMGh3Hi9zNjXCdK8zPgZDiADL?=
 =?us-ascii?Q?PBalyPa51l0XcWbi+qZDDqTajnGxJ07fUmjkGRw1G1IWR26sXkhquQiaxOsU?=
 =?us-ascii?Q?BO+pRODpw3UL0R7ISqaEKr3bb5P0hyCB+vHyWfNIpNfLx0KuJg9dAwvIDpVd?=
 =?us-ascii?Q?S8HB3l5Y+jz/3MKNqfaiKDZe8TMJkoZBjc92vS+sdtp4HJS8qiRmL4IMSm7C?=
 =?us-ascii?Q?hSqGXQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf83465-da9b-4d3d-7014-08d9b92b9b41
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 02:45:19.0374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8SYGhKDG8t6fn+KhUcFdtnP1EZqWtkH6MRVG/W2HANUNgHeDUpORqoD3C7ZqDhjZff6vaj9vEn/UV1OF1OMrU7weIBke3KvCVCnR3MVXrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4347
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112070015
X-Proofpoint-GUID: S6oukc8CMvnglpkwY_A38ua_KbsjDC4q
X-Proofpoint-ORIG-GUID: S6oukc8CMvnglpkwY_A38ua_KbsjDC4q
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

vhost_poll_flush() is a simple wrapper around vhost_work_dev_flush().
It gives wrong impression that we are doing some work over vhost_poll,
while in fact it flushes vhost_poll->dev.
It only complicate understanding of the code and leads to mistakes
like flushing the same vhost_dev several times in a row.

Just remove vhost_poll_flush() and call vhost_work_dev_flush() directly.

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
[merge vhost_poll_flush removal from Stefano Garzarella]
Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/net.c   |  4 ++--
 drivers/vhost/test.c  |  2 +-
 drivers/vhost/vhost.c | 12 ++----------
 drivers/vhost/vhost.h |  1 -
 drivers/vhost/vsock.c |  2 +-
 5 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 28ef323882fb..11221f6d11b8 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1375,8 +1375,8 @@ static void vhost_net_stop(struct vhost_net *n, struct socket **tx_sock,
 
 static void vhost_net_flush_vq(struct vhost_net *n, int index)
 {
-	vhost_poll_flush(n->poll + index);
-	vhost_poll_flush(&n->vqs[index].vq.poll);
+	vhost_work_dev_flush(n->poll[index].dev);
+	vhost_work_dev_flush(n->vqs[index].vq.poll.dev);
 }
 
 static void vhost_net_flush(struct vhost_net *n)
diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index a09dedc79f68..1a8ab1d8cb1c 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -146,7 +146,7 @@ static void vhost_test_stop(struct vhost_test *n, void **privatep)
 
 static void vhost_test_flush_vq(struct vhost_test *n, int index)
 {
-	vhost_poll_flush(&n->vqs[index].poll);
+	vhost_work_dev_flush(n->vqs[index].poll.dev);
 }
 
 static void vhost_test_flush(struct vhost_test *n)
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 8cf259d798c0..7346fa519eb6 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -244,14 +244,6 @@ void vhost_work_dev_flush(struct vhost_dev *dev)
 }
 EXPORT_SYMBOL_GPL(vhost_work_dev_flush);
 
-/* Flush any work that has been scheduled. When calling this, don't hold any
- * locks that are also used by the callback. */
-void vhost_poll_flush(struct vhost_poll *poll)
-{
-	vhost_work_dev_flush(poll->dev);
-}
-EXPORT_SYMBOL_GPL(vhost_poll_flush);
-
 void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
 {
 	if (!dev->worker)
@@ -677,7 +669,7 @@ void vhost_dev_stop(struct vhost_dev *dev)
 	for (i = 0; i < dev->nvqs; ++i) {
 		if (dev->vqs[i]->kick && dev->vqs[i]->handle_kick) {
 			vhost_poll_stop(&dev->vqs[i]->poll);
-			vhost_poll_flush(&dev->vqs[i]->poll);
+			vhost_work_dev_flush(dev->vqs[i]->poll.dev);
 		}
 	}
 }
@@ -1721,7 +1713,7 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 	mutex_unlock(&vq->mutex);
 
 	if (pollstop && vq->handle_kick)
-		vhost_poll_flush(&vq->poll);
+		vhost_work_dev_flush(vq->poll.dev);
 	return r;
 }
 EXPORT_SYMBOL_GPL(vhost_vring_ioctl);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 09748694cb66..67b23e178812 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -56,7 +56,6 @@ void vhost_poll_init(struct vhost_poll *poll, vhost_work_fn_t fn,
 		     __poll_t mask, struct vhost_dev *dev);
 int vhost_poll_start(struct vhost_poll *poll, struct file *file);
 void vhost_poll_stop(struct vhost_poll *poll);
-void vhost_poll_flush(struct vhost_poll *poll);
 void vhost_poll_queue(struct vhost_poll *poll);
 void vhost_work_dev_flush(struct vhost_dev *dev);
 
diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index d6ca1c7ad513..2339587bcd31 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -707,7 +707,7 @@ static void vhost_vsock_flush(struct vhost_vsock *vsock)
 
 	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++)
 		if (vsock->vqs[i].handle_kick)
-			vhost_poll_flush(&vsock->vqs[i].poll);
+			vhost_work_dev_flush(vsock->vqs[i].poll.dev);
 	vhost_work_dev_flush(&vsock->dev);
 }
 
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
