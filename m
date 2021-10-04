Return-Path: <SRS0=QelU=OY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD5FC433F5
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 19:22:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04B7C61166
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 19:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 04B7C61166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B88AF606A9;
	Mon,  4 Oct 2021 19:22:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jNtWGvwj0Upg; Mon,  4 Oct 2021 19:22:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9D3E560669;
	Mon,  4 Oct 2021 19:22:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75CC2C0011;
	Mon,  4 Oct 2021 19:22:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8D79C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A8B79400BA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="cnYC/IBr";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="bd7eC0RP"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z-tK0J9w5VTk
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 76D9E40015
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:06 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 194JJB9Y019448; 
 Mon, 4 Oct 2021 19:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=5W4ziSqooVtD/2GrxiD8RqOzuuK6GS2woUlCxi7bDZs=;
 b=cnYC/IBrINbxjoCaUtLr1zEhh2m++A2haGUff6CpDwEekB7YJP9R/vKehQmztJWOQPG1
 NlI7SY8r+r90mn9l3ptyeAe+/XVH/ypH/lIx1L6pUWrRzMCTxsOuu/PcE0ajNpYbp7hp
 RZ5nF3crAZ4T8VDZH5WjGs02k9VG4qjfYlpEhkFYXNZ0bL7b0twcuQYcBeiKI/1rnhc6
 gX5FyNeUU4aWuFTmB7EzFcRsHH4RSr9E93xBSwQdb80Y/L3VSRO15AHfoOJts2ed84Mb
 80Z2KnI63zuONA6c+fMmmkpVWYjD7ck00oS7pqd0Z0loptPpeuBqSU+FkLVaY5MvUClY Hg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3bg3p5aat6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Oct 2021 19:21:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 194JAcLu132330;
 Mon, 4 Oct 2021 19:21:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
 by userp3020.oracle.com with ESMTP id 3bf16rwfhc-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Oct 2021 19:21:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AU4Ic0oahdTXDXJuoDV0cjlf2o2mnyLf6Rdfpx/oSmvcgxPyL9Lbwh7nFz8/Frvi4FlG8dniUhR17GO1Enx+QM01bAircDX11XQDvbKsxJcmv4r3hsXD6spl1a8s2vXINIDXHx5W2KTZHG2rYsIgXwg7WZ2ExpCQNzB5tgg5woI93bCDB+6ObxjeyOU4omqYhG5RcjZ9baLhw5CmWj80ad5RX0IKH4HKiFV1aeTW4y/lurBKTiMRg/ilzYbP+qON15Jsezt7LOS4K/MGn+jvWyfDXCuwHXOd9OH91gysE66AiodXSx/rsCyVTdcPSAaKOe+AQB+uZJiw2oqUsADh2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5W4ziSqooVtD/2GrxiD8RqOzuuK6GS2woUlCxi7bDZs=;
 b=l+vciudpu4ZUe3IPDy5G14PSzyRfCdEIiI5veZXBEE87zTEjeZfBVm9v/H3LFTCzGT+ntCk2yoGIQ5thAbVfDtWgEZrUswaO+7qQqgFR7SX38dxNAO7htNA0Wrv+/8Y7JHtpJ3u63zmdjMEFIALkzoSMdMBKmemmRekIwqklOiIK8sSdtQZzg5H6vWSDZrcz0jMiNlO2SOVX9p238EaOhDMN0cwyo/F4gdhunnZQ3KkOSg4ATBlyxIzEpk1Ks3RmK09dVwKiNiXp/Q/SjvbjcADmVQg5HBLeLWJk1LwajqNkmgpA7sKyBnv4O5rlqLHG71pdS6DOcvUtQvsVH8VkDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5W4ziSqooVtD/2GrxiD8RqOzuuK6GS2woUlCxi7bDZs=;
 b=bd7eC0RPACzx7MJyHtZa2IdpA6jLTb8rIxKJfv5UWtnPT7JrSQvJeZsr7aB3f0lGUSQoxaVFpSGUPIvRQLXnBqVRuqhIhs0XnQRcpw+rzUiOvqAu8EwUlcShpOnbjUYxCkgU9zLJjG3r+cmLJGc6yZTF0OBiKEcgms14VtST5Wg=
Authentication-Results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM6PR10MB3307.namprd10.prod.outlook.com (2603:10b6:5:1a1::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.15; Mon, 4 Oct 2021 19:21:37 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531%5]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 19:21:37 +0000
From: Mike Christie <michael.christie@oracle.com>
To: geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
 hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/9] fork: Make IO worker options flag based
Date: Mon,  4 Oct 2021 14:21:20 -0500
Message-Id: <20211004192128.381453-2-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211004192128.381453-1-michael.christie@oracle.com>
References: <20211004192128.381453-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM5PR15CA0034.namprd15.prod.outlook.com
 (2603:10b6:4:4b::20) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by
 DM5PR15CA0034.namprd15.prod.outlook.com (2603:10b6:4:4b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.15 via Frontend Transport; Mon, 4 Oct 2021 19:21:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fda70891-5f5f-460e-1a18-08d9876c2fb0
X-MS-TrafficTypeDiagnostic: DM6PR10MB3307:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR10MB3307E3A52AAB8B660F46C78EF1AE9@DM6PR10MB3307.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DuCQds3QDCttxgamHRfIIZ1Agt9Y8dhf5gRNyTSPmJyENvsduzx0nnUsviqGfCOEKhcNHIQ/PBbdcocXD0ki/YPxbSOTgScauB10pq6t+9M6JkLIl46woS4lPLVwq3KcM+qn8m0tRcLstggsspNC8miYJn88gbG44AAYqO13ZbrXV46Mr/k/RylFR7jbukiYHrCQJdP3V40nBmRA4mdoNxcXXAEPJDPitbEqnPj/ZTTMjmWC9KWeb210kWMTzfGwcQ9Xh2Mqnkvv+pFzUZEmOQMl0ic/LAoVd/KcuTRcakf1rwJj99Iu/6NydczzcZUSbAaSWY3ODW9b6baPMLefdZkXxFIp25/fzCNtOga+0cIT9RLs5lBB57Xz+0GctNEQgl1XM90U8vUnsAvP8O1eKmengQycW93B1znMr+kqsyL0DsHemsbo+FbvhqcqN49HFaGK2991v4zKS17dWNsElVIKqxRyEJCqiGAk7cKUgfv7irUosECnBHWED0E5I/cagLSfWpGASsk0V7HBANlmS9UdyXY+opPjqlsMeu8xK5e7VZpNFG4B9VSl97sQsdoZx5nooWn69dYws9AmhRv1q2VYGfW2LnZv6B2T6Z7E8Ow+Ph5jra2zucpPi9NIkEF4kMpILfwnBO448y/7jXbkYadEpv8fjUoVdass2UpH+w5213G/y7GbiRJ8yxoCTqM858BUXdbuR8+FDBovKVzYMTkjkGdfujaSOo3PNf9wqN8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(66946007)(66476007)(66556008)(36756003)(1076003)(107886003)(6512007)(52116002)(6506007)(83380400001)(2906002)(8676002)(8936002)(6486002)(26005)(6666004)(186003)(5660300002)(4326008)(2616005)(7416002)(921005)(508600001)(316002)(956004)(86362001)(38350700002)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/t8UQSLObxl/kpVyFj3Hl6WiEAMGLHgS7T7IiKpKGh66GUuHCKdG2NJk4Vei?=
 =?us-ascii?Q?sxQK/kTwMJb5SeyfiefX/7h0JReNYiNuUAb01ya09BbtIsTrYY3gmGzp17+c?=
 =?us-ascii?Q?6i+Ng3Il4kd3LeTIeKOzaqwAog/Pk4SB7YNWITI9qm9er+trXvGiZX/YvcbP?=
 =?us-ascii?Q?ruJA/bi4lygGGsP/LQHEro5jzkYwNt5xP3u1xAQouUW8VxUEQNicjJPJVEkV?=
 =?us-ascii?Q?i69qTBmocdWXFBm+RUHRnbfBXI+3db1YS2sGooovTot6bSulPpP1dQ/o2cIL?=
 =?us-ascii?Q?fm73HGJGCO1KbMsBPLoUqeGd7fiRfpKrGb2OrwFZZLERZXYILBYWXhkwTI2l?=
 =?us-ascii?Q?eZ9LGsOz1BLKAcB57rL6hC5gpK/+DKtz2c+OZ50t0X54t5LHv238Awls0dOR?=
 =?us-ascii?Q?o9Ke2Q5ji61/wiG60IGWMy12G0XGJusYqdegWhG3dhgUS3YRb9ZdqEnnuVF5?=
 =?us-ascii?Q?fx+EW41YWsj4NfGQebcU1iduRmF3NI9u0xF1K+SF05+crMQRi93aFj9Gv4W2?=
 =?us-ascii?Q?pg6o59GprvtXoGgggVQEWvGiMIuMVN2yHOdDfBT87U7MHfi920gp+bLAFKD5?=
 =?us-ascii?Q?5Eqti4f7oPg/R8Xwx40R0JN2G0ddloj5tUhx+D9zLlyv5Q9ZWJbwN1r1jYW4?=
 =?us-ascii?Q?KQ8h7pBPmKIkcVdykhskB/bs9OxOGp4OwHKcI9cloP5ZdoFEAwleOeMfCr5T?=
 =?us-ascii?Q?r3BBtv1bk/SI9XafgWnYw5fckLhngvBD4EaENv3JqSVFR5TB9VH71ZbBWCgL?=
 =?us-ascii?Q?Gd/nBJXStrRTsxpN+sGAfM7MlO5PQJeLcXrGnXrL7u7MPBSru76z1r6CH0nt?=
 =?us-ascii?Q?pjADfxdQPxe5IciNN9ySkaNYaa+m6bVKF2PVCINuMoeAntgcp+Odj9JOOS1s?=
 =?us-ascii?Q?7qsMbMa4l7dx15XHTO6Az1nmJr7hJduO+ZOy7IULJDtfEfWLoiIBNzytnPcs?=
 =?us-ascii?Q?rlwCQhtc0Wy8Wl7KpCAE+yGXF3kkNpG+QLmF3RptB2uFkWiN7w5fEs7F8VfU?=
 =?us-ascii?Q?0mQtY8HSrzuWJoZYPswTKFoxTByGkvkfNhllajoL5PimPU47azkRrsfmhJQs?=
 =?us-ascii?Q?k86VV7XTfDKvfcrHsPTIp/pi7GsfwVY1uCUrdgr2u2gBo2kAFfQjr/9HHLIV?=
 =?us-ascii?Q?70KeJ/t7Cf2/9hhECkLDZZKFsHgrfzNFq3HUlO66J6Kfm35ZEliAxthTsG11?=
 =?us-ascii?Q?2b2LjRN9XpTi8KuaRRDXzdDegkWoVCVWL8nKuiqWifvvpzuEHIyJosaaypal?=
 =?us-ascii?Q?HzvOjLhSVM0UJ//vbesYEkBc34lAlY7TdEuoNKhRLyi3ggDZeg+VOBO3tI0Q?=
 =?us-ascii?Q?n7TNKY7hC9eLOmr/pjRLr6SN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fda70891-5f5f-460e-1a18-08d9876c2fb0
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 19:21:37.6993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PWKvrraaxrVFcMr7PaS9sbN5fY4lW41tY6VF3q7BXRT7dYo6vMGUlCGI0bRQtpzi+8sKaWaiwPu57pumeLj/x+hzIm4lDd/Q5wXVwvpkNTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3307
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110040131
X-Proofpoint-ORIG-GUID: WyqqyN5Ohm1VJkAWqvs9hpcKWrfV7H5K
X-Proofpoint-GUID: WyqqyN5Ohm1VJkAWqvs9hpcKWrfV7H5K
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

This patchset adds a couple new options to kernel_clone_args for IO thread
like/related users. Instead of adding new fields to kernel_clone_args for
each option, this moves us to a flags based approach by first converting
io_thread.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Suggested-by: Christian Brauner <christian.brauner@ubuntu.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 include/linux/sched/task.h | 4 +++-
 kernel/fork.c              | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index ef02be869cf2..48417c735438 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -18,8 +18,11 @@ struct css_set;
 /* All the bits taken by the old clone syscall. */
 #define CLONE_LEGACY_FLAGS 0xffffffffULL
 
+#define KERN_WORKER_IO		BIT(0)
+
 struct kernel_clone_args {
 	u64 flags;
+	u32 worker_flags;
 	int __user *pidfd;
 	int __user *child_tid;
 	int __user *parent_tid;
@@ -31,7 +34,6 @@ struct kernel_clone_args {
 	/* Number of elements in *set_tid */
 	size_t set_tid_size;
 	int cgroup;
-	int io_thread;
 	struct cgroup *cgrp;
 	struct css_set *cset;
 };
diff --git a/kernel/fork.c b/kernel/fork.c
index 38681ad44c76..3988106e9609 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2026,7 +2026,7 @@ static __latent_entropy struct task_struct *copy_process(
 	p = dup_task_struct(current, node);
 	if (!p)
 		goto fork_out;
-	if (args->io_thread) {
+	if (args->worker_flags & KERN_WORKER_IO) {
 		/*
 		 * Mark us an IO worker, and block any signal that isn't
 		 * fatal or STOP
@@ -2526,7 +2526,7 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 		.exit_signal	= (lower_32_bits(flags) & CSIGNAL),
 		.stack		= (unsigned long)fn,
 		.stack_size	= (unsigned long)arg,
-		.io_thread	= 1,
+		.worker_flags	= KERN_WORKER_IO,
 	};
 
 	return copy_process(NULL, 0, node, &args);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
