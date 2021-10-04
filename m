Return-Path: <SRS0=QelU=OY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A73C433F5
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 19:22:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2657061166
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 19:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2657061166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E8DD2405AB;
	Mon,  4 Oct 2021 19:22:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O2tWcDECKfim; Mon,  4 Oct 2021 19:22:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 89AE3405B3;
	Mon,  4 Oct 2021 19:22:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6FA5BC0021;
	Mon,  4 Oct 2021 19:22:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B69FC001B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8BBB583955
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="ZlXq7R5b";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="j2MARcsl"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nPp6BVAJVYrr
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9E35C83938
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:14 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 194IR8iL004481; 
 Mon, 4 Oct 2021 19:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=nAeNGpdqNwknXbpBvtyf9vLnlg0oE/2TsaWbrLzTS88=;
 b=ZlXq7R5bU+0Xp6dsGOLH+n6oAWA8KWCx4MxcSEsaVx6vBow9gY3O+GrhoSX1fRgIbqj/
 PFuT+3YzlWTeH9yvGsfs4RYWjBv9DdaJsInYMPK9XDK8NQvOrD6I70d8oAZzrHiPq0yz
 SNz+jRXcZlvuFOccbMBqArzG1SxHIwi91jKLsjvN9ikIW2lw/slONV04V30GghPWV5Ou
 3nO21AMJ7eBY7YmRk5IEfpcLMratMGMweEjQ3uel6HIxUxAR4OIm9u0F/D0djhaa3Jfr
 BLfK/HRf5oNY5pFTa45YyJ7iktysgk+qMgB11Dxk6n7yYCWwdCVU8sIV/JFNyknmzjXP kg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3bg43dst5h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Oct 2021 19:21:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 194JAbko095280;
 Mon, 4 Oct 2021 19:21:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
 by userp3030.oracle.com with ESMTP id 3bf0s5c7jr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Oct 2021 19:21:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kr5QYT5+T2Lj6NjH2rbMACtl5UxOQJAuMO3wM+KqyrEJGYzIgyIybripQe/rSxUsUL27GnRaz0ALokiIL4KDcdcSq9zLVNvvNKlxv/4mAEo0jBBhx4aGJA9xAFF+6+QWd1th1STpRL1n8gVl9NdPjAoXDGV6bz0di0OfcYARMAaaRHrUGYoR1yhHdGl+qiaAU9tRsNM6CHVXhfNd7TSpeIjYLEO9MssWO1Y9i3PX82zU2SY4IHtr1ANxbIeDCLPTYGObyGylWEbpbHVdgppQbrv8r0NC/W84/bmEKgdGJQDXWP5KoUCoMOB+dCLTXgFPXeQR1AtFlOaohvRJT/BbaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAeNGpdqNwknXbpBvtyf9vLnlg0oE/2TsaWbrLzTS88=;
 b=OTrmhum38GK8aQ8g/Wy9cwQkZeruGHhWTYXnSv0G3Tf/5mQ3WHwKPQI/fHDxY7a9L537kwn+BUidmAJ2uDvKnVsddkkQaXQQdRe9Ap/P4kPcZ90xdJFuZJyfgScku0i2MAGJ0RlVwkRpOIW4DjvA3j0F/EO8/ygsVwUXLWrEg3Lxjk10Vdr/19BKFeb0Wqc2Y4ZC3dCopSUDTDrTvB36sOgmbMc0dhnArE1I7RZABcSybqraEy/5NC+xAk57RrLsTqNpBkLJpwDLuBpREFRACBK+63t6b323INIV8aGwNMWp6m5pT4mXbhbXuI1VzOLSk8tBtrTGwuJRZOAIwzfn9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAeNGpdqNwknXbpBvtyf9vLnlg0oE/2TsaWbrLzTS88=;
 b=j2MARcsl5XsNlklqi9AIwKTqzXFDc2RHxqUq2vrH8rcQGtVDNTu3hR3HdZTwJwkrjlZUkafWd9CsySegueZUIWmnGfXm3dm/AJoMlmbxlxBtOOxliT2zYGCIdRdlLqnPveeEYyct4CbG7ITXhLL0kh2lxXJbVc323WP8jtdvXzY=
Authentication-Results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM5PR10MB1548.namprd10.prod.outlook.com (2603:10b6:3:13::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14; Mon, 4 Oct 2021 19:21:40 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531%5]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 19:21:40 +0000
From: Mike Christie <michael.christie@oracle.com>
To: geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
 hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH V3 4/9] fork: add option to not clone or dup files
Date: Mon,  4 Oct 2021 14:21:23 -0500
Message-Id: <20211004192128.381453-5-michael.christie@oracle.com>
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
 15.20.4566.15 via Frontend Transport; Mon, 4 Oct 2021 19:21:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33eecfd0-629f-49ee-34c2-08d9876c30f4
X-MS-TrafficTypeDiagnostic: DM5PR10MB1548:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR10MB154897F065A0013DC705A614F1AE9@DM5PR10MB1548.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dQVzzACmChzTGSmLCjYYQbNkF5FPVHuVSgHuRGmvAoUqiDE/oZ1fFhs2ZW14lFugUfOqk1YvSwVsYSrahsi4wWXQBWWkAf5h7ScxFtDbletthAeukEip3L6WFTc4L8VbfQGIN3stwL6yDABUw207haRsKvlJ7xDximaTauojpTWrGGQqV5kxwUUXmUZXiiC4FzceNqZ4B4PXT6t27UV8LyT7FddgqF1V48AkKqIq8h0H3wQrpPTiJd0ahTuhCgjQluO1zrePecuW5j4QzjI7ADiGP8gnFoYoEyjr49Sk3W8Ly3/OAilTx0g9ZHUsrz0+V3lmFRPTI9En/eZ+w9+WgcqgBn9XBR/6xqbJuSVnLQdw5MmVdIcXg6vtVhmLOpsxHNfr2c4n8WQisyVkIbgk7TeWsTZtvdPObwmcdB86by7UULKZjZQu643Ew+UHBJ3EZSQsZ4yPdHfBQhvWGlI+FXNhqhURawOUwrbBZCtFeFMPMhPw2hYDkcm6yvTN3BqwhiidXlYNpEa/l7iV6Bw5NpW61mKrE02USNycotFW0IxLP+Nomb/BLY6Cm7JZGEu8we0+ZCekF/5/QoD9YuU7sFJzO7aDRujxRt3TOezCItau10ycIrQ3AokMl1JpoWRPKtgofXodSkqsF6OkhrCx5PFvpxQO8+2loYXC7+5lBKvcuc/vCzp6igVOMN8bzjP0ZRZ+bZekXR+gejwJNZkJcTr3qe3iJgEPBn3kHzQqD78=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(83380400001)(8676002)(921005)(7416002)(186003)(38100700002)(38350700002)(6506007)(8936002)(4326008)(26005)(508600001)(2906002)(6512007)(6666004)(86362001)(316002)(52116002)(1076003)(36756003)(66476007)(66556008)(66946007)(107886003)(2616005)(956004)(6486002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hBddA39DV5kxT2Dw/in2mtYbqpOP6QO1o7uDw8eTqyKhHOzwLnq8rSohQujb?=
 =?us-ascii?Q?FkzBjDhokfg/K8lqfAuzLJlzwHgNLdGHvixCl1Pwlw3c+YSKtUvcwwxnblk0?=
 =?us-ascii?Q?B8HtNCfqUCcb805W/Bshhj+KbgV61tJUjBoUfMjveBOwoAbVwhfcKL5Md2nF?=
 =?us-ascii?Q?v6c08RibOBww0KyI2oJ/s5Pt5rFZnP9CcOURgWJcUpV3XSwy0fhnpQhojDi+?=
 =?us-ascii?Q?EBwBMbKAOAJWyLXRvQf/Y3kjlMcun42BASZjESqQk72nBJfqZMWA5Qdu2mkp?=
 =?us-ascii?Q?y7MNCjRIdlWmHoVfNj/+2AjYVf4zMi+k/BzsC20qgksc/TJuSe/iZguesq2e?=
 =?us-ascii?Q?/uTtXEb59G8B3J8D+p2BwtgUEnB2sTn6nbl4bWPY29kFPNlkhKs5tkBoyUI+?=
 =?us-ascii?Q?3tpX2YPCwkkAyHzCLfjLDvD8rW/j1fRRNfREqhbqhWb+kV4Z8C8DvNTPy+Iz?=
 =?us-ascii?Q?NXmoOf3cKOutAtEjNstiIo5DL3iH0tSvOMTH0AeEwveKKmd5cRs+l4Tu4EWS?=
 =?us-ascii?Q?BVqkh6RrgYSNky+xA3pphITI1x3xmjqcUFVYWkshGGtr/9k/5ZYMHpeRV7WZ?=
 =?us-ascii?Q?bqe+UhCiWY9+MNeyJtIKHe0CTKHhVPIxGxFGOD0tRuu1S1WfgkQCd/zRkC38?=
 =?us-ascii?Q?3ivyP1SgGXA+pz6/dLKB0bbdQPo+F7v5vf+1iFJ8C286gWcoDJKJ+RPweAfW?=
 =?us-ascii?Q?GTE35lqhaENbzK7ohWKtr4bIb31RK7dN8WXniKM5EV60LEHfuopi5HDuJMGH?=
 =?us-ascii?Q?/Yj6w3mU9Wx1r7ubza+O5e1xcgV/2pw+QjiwmI/oLSzU7quJkMXfb7NKtGXd?=
 =?us-ascii?Q?yf3eNbQHP78DIMIOXE/zgYj1r1ekP3ZduHbTLGm8iUPZwv3H9e5yQDqSn7OR?=
 =?us-ascii?Q?BJ9ndY3T+BC9wVNksPPHgPghe7YVkhLtecxsLD0+DHHCHc0ntT1F65yePwSj?=
 =?us-ascii?Q?YVPCtTqcKzt2+EZIduTB5SdMjHxKKJguMlskiCZIrYZvVCv3XkiVTktugh9H?=
 =?us-ascii?Q?yNhc31sNeI3TdF9Jb7lDWNWEdBwVIfKZvEycn28NVsP4EQiaC3XGEAeKzB2I?=
 =?us-ascii?Q?mwkD3wcUmgKg6MHna3CKojGC+sW5sn7SyE3hTd9kEBcoE22SZCS230trop3M?=
 =?us-ascii?Q?skZptTZm+QBdZ6X0DqVgYfxgDaxKZPjANs/Pg5oP5XA3C/tTz0zsiEIRISzj?=
 =?us-ascii?Q?rValpKr0dJ1/K+SVAFr3MxP98DWhNnEmsQrhDIRxl1zhvyQZyFPI2FTQaYXD?=
 =?us-ascii?Q?Hxliz8bsddZ7H1LXunrdiFPpbcJjP7UtIP+r57CgjCkc4eyoGFN/+I1pTu8v?=
 =?us-ascii?Q?paNfudA7SWJ3V91m6NYFcUbD?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33eecfd0-629f-49ee-34c2-08d9876c30f4
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 19:21:39.9513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUxQccJktKcaTYq2YoJ6X6cSZU7/ggYoM/1gEyjIwfJMMiAIpRhnQIT0vGlYveUbLnKMW6Si+aP1Jzr0J9ppW4iMBaoSx+/jveJbcxf9hWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1548
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110040131
X-Proofpoint-GUID: tTaJp9WeRUNuDrkxcwix7o1PLY9Es-g2
X-Proofpoint-ORIG-GUID: tTaJp9WeRUNuDrkxcwix7o1PLY9Es-g2
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

Each vhost device gets a thread that is used to perform IO and management
operations. Instead of a thread that is accessing a device, the thread is
part of the device, so when it calls the kernel_worker() function added in
the next patch we can't dup or clone the parent's files/FDS because it
would do an extra increment on ourself.

Later, when we do:

Qemu process exits:
        do_exit -> exit_files -> put_files_struct -> close_files

we would leak the device's resources because of that extra refcount
on the fd or file_struct.

This patch adds a no_files option so these worker threads can prevent
taking an extra refcount on themselves.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 include/linux/sched/task.h |  1 +
 kernel/fork.c              | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index cf7c9fffc839..e165cc67fd3c 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -20,6 +20,7 @@ struct css_set;
 
 #define KERN_WORKER_IO		BIT(0)
 #define KERN_WORKER_USER	BIT(1)
+#define KERN_WORKER_NO_FILES	BIT(2)
 
 struct kernel_clone_args {
 	u64 flags;
diff --git a/kernel/fork.c b/kernel/fork.c
index 4b0e8257993b..98264cf1d6a6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1532,7 +1532,8 @@ static int copy_fs(unsigned long clone_flags, struct task_struct *tsk)
 	return 0;
 }
 
-static int copy_files(unsigned long clone_flags, struct task_struct *tsk)
+static int copy_files(unsigned long clone_flags, struct task_struct *tsk,
+		      int no_files)
 {
 	struct files_struct *oldf, *newf;
 	int error = 0;
@@ -1544,6 +1545,11 @@ static int copy_files(unsigned long clone_flags, struct task_struct *tsk)
 	if (!oldf)
 		goto out;
 
+	if (no_files) {
+		tsk->files = NULL;
+		goto out;
+	}
+
 	if (clone_flags & CLONE_FILES) {
 		atomic_inc(&oldf->count);
 		goto out;
@@ -2179,7 +2185,8 @@ static __latent_entropy struct task_struct *copy_process(
 	retval = copy_semundo(clone_flags, p);
 	if (retval)
 		goto bad_fork_cleanup_security;
-	retval = copy_files(clone_flags, p);
+	retval = copy_files(clone_flags, p,
+			    args->worker_flags & KERN_WORKER_NO_FILES);
 	if (retval)
 		goto bad_fork_cleanup_semundo;
 	retval = copy_fs(clone_flags, p);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
