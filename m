Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E5CC433EF
	for <virtualization@archiver.kernel.org>; Sun, 21 Nov 2021 17:50:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E8E9B4045D;
	Sun, 21 Nov 2021 17:50:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P4hqZ7wmzoRm; Sun, 21 Nov 2021 17:49:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E358D40448;
	Sun, 21 Nov 2021 17:49:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9670C0041;
	Sun, 21 Nov 2021 17:49:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 137BEC0012
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:49:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 005C5401B9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:49:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="RXExGBDp";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="mPgvJpoj"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2ULfz97gxL7U
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:49:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 08F7440172
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:49:54 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ALFtrOG000555; 
 Sun, 21 Nov 2021 17:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=GSeZ6ATpvB948h9atlAGs7mOeLrWoiPBkgyfAE8Gf6s=;
 b=RXExGBDpfyXmhBvYcgbUpzPJz+4D0fnEb5hb4d6W9XwvUhaMKGWf069/QdJgztF4spew
 ZunDQiBMBpAIJIeU5lwlHwk6h5FWbUfR0bTYsewmCpRvx/J/qKMzZ4bnLvcHwyJHrHL+
 pMoa7HDXMJmihNtMyW3cqQGz/xibf0oh1SjssOfAE1YbI2vBBFwSnxscxehhESZl5FIM
 Bq1cPTBskzqugzIKv/j+uC1lVWDdQj6UvWVTkJG5b1vdLIXlNrDTwY28rnOKhsatQNMO
 fOxpaCk4eKxi9Nl5v0DHB9YemQ55IFjoxyQsuaG6v/2aiL/Hi5q1rLoF5dRBOcoOJKkS +w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3cermsmgfw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 21 Nov 2021 17:49:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ALHkUY1015043;
 Sun, 21 Nov 2021 17:49:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by userp3030.oracle.com with ESMTP id 3cep4vp60k-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 21 Nov 2021 17:49:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwOxsUrgIAB9leH61ot3Y2NC3up7Gsh5hiyA0Vy5bVYD+tcQpQLDdyv9hMvkYpJzC/picOtSPpzLUjExArPhtui8Ckd5xeisVyg1vQo/g9q7/yKaEaGxJm2eBFQ5omPlEdtgMZiZRyv8vUjgFK44GzZFJJlDdYSsQ76yCxz6lQYWlWRoS0UQN6+SffzhVRl34TxqUjJBwEDD0ipwQGsOo2ne/jfkd0giZH7O/MxwPbwm50NBrqxWXQj0wGE+HZucc8w8BT6z3gJx976k3dU8/4pGfLCwXjzxqrS8n2pCeXaGMT/3BQmBvNXSW22L/m/+1MXxZUpn9YNh37W5EGcmRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSeZ6ATpvB948h9atlAGs7mOeLrWoiPBkgyfAE8Gf6s=;
 b=eXGJUk52ln0Dy1aGdGjqPh54NtfalwbC+6xkiAM/tgGdeCc4tUCVu1h1tXRfUHWliWVG2RCIFJjzjmKPPbT/GAj5zqVleUaZqROZg4iTrW0/Z8atwcj0F+/PQR+wCIrEjLNKAxTVZ1ZPPWmUiEsF0RnG4esp/A0HurKdNBGWgsommwxnSf2gtr91wfM9aFWdRhzSjIW7VpOZnBBhUTbZ8ax/z+eSDiH5pmvu1btfGVqgt4F7VQSGYgr9xFHFpNlwbErctctg4RmVt29rEvO3nbtWqpfGZHQm+bB8irFZ99PR80SEt6ogk7zq6quwacJr+jF50tds4mZ0SiiEjGcVZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSeZ6ATpvB948h9atlAGs7mOeLrWoiPBkgyfAE8Gf6s=;
 b=mPgvJpojLNaoTsAT4BXEymz298i6+rgaIXX0AXJNtyu1+aP4UbGvbjtBDjR8+5Ma6m8Ye4y9B6ztm8k5D2PfTgawFplny4rpXk66ZxsqaBIOnYjDj/XdCV+RYMxl3LCwNIVS3UxaC2QlZeKtQVhdMF+aXP5FnOoQlrCoYtGLIlU=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DS7PR10MB5055.namprd10.prod.outlook.com (2603:10b6:5:3a9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19; Sun, 21 Nov 2021 17:49:47 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041%11]) with mapi id 15.20.4713.024; Sun, 21 Nov
 2021 17:49:47 +0000
From: Mike Christie <michael.christie@oracle.com>
To: geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
 hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH V5 05/10] signal: Perfom autoreap for PF_USER_WORKER
Date: Sun, 21 Nov 2021 11:49:25 -0600
Message-Id: <20211121174930.6690-6-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211121174930.6690-1-michael.christie@oracle.com>
References: <20211121174930.6690-1-michael.christie@oracle.com>
X-ClientProxiedBy: CH0PR03CA0217.namprd03.prod.outlook.com
 (2603:10b6:610:e7::12) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by
 CH0PR03CA0217.namprd03.prod.outlook.com (2603:10b6:610:e7::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19 via Frontend Transport; Sun, 21 Nov 2021 17:49:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99bba90a-b05e-4703-ac58-08d9ad174f3b
X-MS-TrafficTypeDiagnostic: DS7PR10MB5055:
X-Microsoft-Antispam-PRVS: <DS7PR10MB50552CE597EF0F286C486B24F19E9@DS7PR10MB5055.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6pW5urDU0QagNPrEObTfOH+af8et3QrjQXflMbLpRSY0iXSf1OybFZyhfE2JREG1aXttHWJncuF7bLTjzStTa/wSW/IjtOm8PFSAzx7Dcw0d4z2hAIB57wGOfeW2DrTy/1r9sqlfB7WWxu1Mj+9yL70XhSXuTbb+VSlBhx0yGIrx16uvv6QJ1eKMq8BNHHsSOlmI3TDprQf0qbHY3388GVSGu2TcdxwSskaybhAFR3wfWaAeMGenf48tChpKMy0DXSA4zMR3iuVcxdVsyKvrIkV3Otw33vYpXznewVMmxukCq/LYw9Rp3FE6+Tp0FPct8SLEzpdWLLRwsKvbCZMI70xpisqhcG6Qmz2SBmFjo7LvIaYmqpwo6DHJbtdbpmDQzxos/TvlI4qnADXjmDgPe1Td4YuNT/GdPjQ1fywX+Ymc/hyqdJ9OdZqw+6eVJY47VTgfoGXUAYR4pjyzRtP9RZFIPlWAM6It1H9gVzfifXK1NArZ9CiXgjZ8B3jFuyI4go7YcCjq3QSZ3OvgoYug+s3tkZzC6JyUGOxmkIiU636K5vgcoXtqNdQph8+2gWqEQOb5ZSx0YTdTi674oq89unntGmYMZeOsX82hOay7+KLDpYusro8wQEhjP/d6wXWGMx5Ux9yeIGH6Js+Uf0Kloq6E4xUs7ouI0HfE8OI11Og3J2t4JjZcdMIP724FLm3vm7KfdvIypmzU1N4Qf1jddnCqBx1cuvRcKl/DYBm54SI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(8676002)(66476007)(52116002)(38350700002)(5660300002)(8936002)(1076003)(2616005)(6512007)(6666004)(6506007)(7416002)(66556008)(4326008)(2906002)(316002)(86362001)(107886003)(921005)(508600001)(38100700002)(6486002)(83380400001)(26005)(36756003)(66946007)(186003)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CL4pDmgBK8yVNRcfZh03L2AA9I/QsdmvJTYapZwqmN9wSFcT91tPqp2PMI0+?=
 =?us-ascii?Q?uD8hYNJGQE5jkDApWwj8ahaJFMLo45j7AxbvWXuAsdLwcFXiqbZvVsMjrZBj?=
 =?us-ascii?Q?AcwRcVTB5MgYVuiQTBennV2kyXjP9e4lMDFBOlgW35A3E9m/73Vf3aZt6ADH?=
 =?us-ascii?Q?KRiV+OjsP7cQS6Zg/rOZeG7KLXgRsij0HykFN6BJIbu2J8ER88b/QqGUw8lA?=
 =?us-ascii?Q?Nj78bsmqj8kxk3sIdiv11YE8HCqp/KriPpvVikzK16wxpUQQ3rng7gh2mRv5?=
 =?us-ascii?Q?38nqdZKBqamSIO1xoFMZBzDuHQf4s8sC+G7c+k5sVrMTbTygxt+oU1rYc34u?=
 =?us-ascii?Q?Q+TQg3tEqXN/NnGFQA8+kvHpPi1MXBInuXLx2nPFcav3GzvaAFXTJ1ucwaxv?=
 =?us-ascii?Q?0ry8W/0lT8P8XE9gQLkq0LFZY1LP5vbOxgv26epTEx4O6zCEr5mo0EUvAG0y?=
 =?us-ascii?Q?EN1ibXOIjIVN342Us9W4KSGEi+liGv4w/yMn0XaOIUm2TBd3Shl3FOMxwi5G?=
 =?us-ascii?Q?SueOuU0vTikXwJj42LlY0g7sZpS4196f0rf6boj2RsL1gXpJEWf2BlKep5DW?=
 =?us-ascii?Q?aWwrbJ3PJO6KB5lUSOeMpJJzZPxVu+m4CGVA2hlps5TLlSQYDxt2l/O2atfJ?=
 =?us-ascii?Q?dMG+ZKsqpA9AXJNinnQFjKNPU1e/i4NZlrx6fmWg4RkMTdPMnJLdtaMT41zb?=
 =?us-ascii?Q?5hz9EQnoEmDbHX7QG80avRXosU4QMTtbemhGsGKppMrgfLJg/v1pLKOFz24T?=
 =?us-ascii?Q?gNtXJLSDyT8D0TiFX6anBI8dIgbUQYkbFpjJ8yosVmuFoYUs/JUWkZpYWd9/?=
 =?us-ascii?Q?T2NU6Ulu/+w19hJ/6EmRsB3Jds03IHeXpy6/hB2WD6pEzZXMFeztQAL6ZVvX?=
 =?us-ascii?Q?8rNh9zXt5t6Z27ZoiWrZjEq0bMpxu1BMwt7u9fTM5JrcUv9oKLt5uYIHncAo?=
 =?us-ascii?Q?/RsLNRmiAxdQmsxmM929aJ3naBVPPf8XOz4epJ16bnR+OBOb85Ofk8zsrzHK?=
 =?us-ascii?Q?r7dfl1C1crD6N3uddEF0+m8p0E2HTaMd/llJd3Xvz3o7nSdCV1ubI50ufPB0?=
 =?us-ascii?Q?hzCDKo6HyZ5VFb5qhZbcHBqLISIk0tk5u03S9tQGegLDzh3cKyCMbvkqcFuP?=
 =?us-ascii?Q?J2pVcDNbeIbKfMq5U0GDQB+ewlew+xx4Z2NvomFjG1DRRfSoOQyFaVTC9Lib?=
 =?us-ascii?Q?NN9U/aEc7QBbUSti1Tfxgb4GNH3VHNZ4CRV0ZB4LpDFtDicWoVQQ+3A6i1os?=
 =?us-ascii?Q?o3VQEDDAJucZNsT1t9mSQnTaD5d2Xa0xsNunJfx7J0tqpNUhDfaz1Jiy5Zrg?=
 =?us-ascii?Q?4l0QokngXh/+gmJ/gG1tqWCi9z9JBx5yw1/VOnuo9Mksr6cY5l17yHUD+qO3?=
 =?us-ascii?Q?i6NSAmaheyGC1eJqeiVOcXwSJ0q4LK7g1AwOWq7m55ojw3RNWIcPCd69Z0l8?=
 =?us-ascii?Q?JeW1UMa+cN/Vw1gIu3R4eqnZ69gCxY4wzMVB0GHkQOy+LHjXfA9MC+kPNO5b?=
 =?us-ascii?Q?RKKdfwYK4YENl2KF+QvrqlgYJGnxIk2lXrjO3c1I+xjVoc/0e3HGActJfs9D?=
 =?us-ascii?Q?k+h67avN9fbpmOOhLdDxaLzoCKXthiGC2EABkOFhwyqKIckZ+KE0hFFY78qD?=
 =?us-ascii?Q?TL9vmk3pS9TP0OjmpGTgussTBJggoM3aI4fPTSvVoVIDz7vwBSB29Jl/ursL?=
 =?us-ascii?Q?fdG04A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99bba90a-b05e-4703-ac58-08d9ad174f3b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2021 17:49:47.6748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vMWasI+/bRbf/ylBgL8IQGBsL0mB1SqDLvWWiHOViVZtTpn10WWt61ztCyWWzk7ZwtS42PXLE9yibaPWMuMC1XlIUvhU4dANJ0le9s4VOWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5055
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10175
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111210110
X-Proofpoint-GUID: xhFuvTncqvemhGhsyJXyYQycIquCA1rm
X-Proofpoint-ORIG-GUID: xhFuvTncqvemhGhsyJXyYQycIquCA1rm
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

Userspace doesn't know about PF_USER_WORKER threads, so it can't do wait
to clean them up. For cases like where qemu will do dynamic/hot add/remove
of vhost devices, then we need to auto reap the thread like was done for
the kthread case, because qemu does not know what API the kernel/vhost
layer is using.

This has us do autoreaping for these threads similar to when the parent
ignores SIGCHLD and for kthreads.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 kernel/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 7c4b7ae714d4..07e7d6f9bf66 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2049,9 +2049,9 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
 
 	psig = tsk->parent->sighand;
 	spin_lock_irqsave(&psig->siglock, flags);
-	if (!tsk->ptrace && sig == SIGCHLD &&
+	if (!tsk->ptrace && (tsk->flags & PF_USER_WORKER || (sig == SIGCHLD &&
 	    (psig->action[SIGCHLD-1].sa.sa_handler == SIG_IGN ||
-	     (psig->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDWAIT))) {
+	     (psig->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDWAIT))))) {
 		/*
 		 * We are exiting and our parent doesn't care.  POSIX.1
 		 * defines special semantics for setting SIGCHLD to SIG_IGN
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
