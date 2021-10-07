Return-Path: <SRS0=OSH5=O3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11E5C433EF
	for <virtualization@archiver.kernel.org>; Thu,  7 Oct 2021 21:45:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CBFE60F23
	for <virtualization@archiver.kernel.org>; Thu,  7 Oct 2021 21:45:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7CBFE60F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 38C26402B1;
	Thu,  7 Oct 2021 21:45:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p9mQVf5wUSyG; Thu,  7 Oct 2021 21:45:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 62444401C3;
	Thu,  7 Oct 2021 21:45:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49EDFC000F;
	Thu,  7 Oct 2021 21:45:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6F8CC000D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 21:45:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CA0FD40A02
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 21:45:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="vipNvufS";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="ZTx7BvEY"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pz2jTaZ_1lwn
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 21:45:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1AD00409DA
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 21:45:25 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 197KYYKT007651; 
 Thu, 7 Oct 2021 21:45:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=5W4ziSqooVtD/2GrxiD8RqOzuuK6GS2woUlCxi7bDZs=;
 b=vipNvufS5XM0YcSOGv5yUbDIXuK5GO1Qmkn+ymkpJXdXFTZvkwKq2RdBKJge+T4b3Kfr
 tOTFHpa/13XGTr+FuWgoTu0dbGmuXvv+9Q45ksddL3kwDNtWKA3ucA4HeQeEhh7hVxuB
 9ZzGfhhmuOVzOYuc/Dm7fpa8Xkmu5E2qHRDGK8aoMzdofpmfY1hYIdnjMmPgn/V135JO
 jI8AVPtdJ98W3yZv8hhXjaCJ9gX24cAQOXEh7kHjzuJLJy4I/LjuyMwLS29NkJFb7z9l
 POnmlNtVh6qjL8WbEAPCRqet36A6ZvpUv2nVFwOi54pJpvvTLfb8t2NkKX+OUj3G0rmE kA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3bj0pw474j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Oct 2021 21:44:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 197Le8aQ113346;
 Thu, 7 Oct 2021 21:44:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
 by aserp3030.oracle.com with ESMTP id 3bev7x4uhn-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Oct 2021 21:44:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9r2s/3vC0ioLnfvPF4y3E//qLuf1RttrKr+jBDU8dCn5jZ1AJgVRujwWZFiRUI1VmtmgDNxkgAUVoCy67hxgchMe9fgO0Wbm6P05TGL4zVZvVLsu2MupSdXOdDoXUBCxAbA3mEWvCTHsSpksoFWBIG5OXBIC0CLM5csk+85uD7+fIPSxrgCJUR/lYoof3K6TiaE9HhUTLUYbZlJliE4SbiX74CEvtxvTmQsunUGnA/vlPS9UkbevV3DpR2ymFQoc2+sZNv8PvPcBOjGNduSHxjJQX9/Q7VuvL9NhQWoQ5vbXa44qmd5BJHUeztPeqsWwQePXVQenZipcmbKMBt3qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5W4ziSqooVtD/2GrxiD8RqOzuuK6GS2woUlCxi7bDZs=;
 b=O2AvqIVgpMiGi95Cwse2zfr3hRHPjPw0FWyBeD3oSsil2vQ6vo7+5fEMIVSH8H8zNYW2QJXaXhKn20/D1LM443GDE22U4+yK+MlsmN1llkiP0oD48kR0hj6WYGdMcokLNk4ZiPbFrb3uHx2Vw9MyfWntH2NvcGp7WdrXxBS+F1Iamn6DPCepfp95FrzJQ42asbLDF5TQOUx5FshFtJuJ5iSs0h+3NrNTGyQKM10o1xXm9cQJSnq7um6kR+WZhbR80n9Af17FVUh7qa9Njc+liBvNw/YQegwt2U7XREBot+0d8foq+qhOTwMlisjxor/YZiO3AsF3m0RQi7Mr6Wxbtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5W4ziSqooVtD/2GrxiD8RqOzuuK6GS2woUlCxi7bDZs=;
 b=ZTx7BvEYgCALFf6Iw9SbLMcgzdL6ovrmWHEnZXhNZyot2nPP3lKWAvjK/KcdBO9GWz59JqX6vrgLWQOektUavzXu1jtVWbU8bXtB5X1Ncs2+fewqGkKKrpvv5rIlGQUvZgte7iIKL0qnD9x4cmCO45Hts9Xi/gsq86kMiWi+LJI=
Authentication-Results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM5PR10MB1884.namprd10.prod.outlook.com (2603:10b6:3:106::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.19; Thu, 7 Oct 2021 21:44:56 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531%5]) with mapi id 15.20.4587.021; Thu, 7 Oct 2021
 21:44:56 +0000
From: Mike Christie <michael.christie@oracle.com>
To: geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
 hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH V4 1/8] fork: Make IO worker options flag based
Date: Thu,  7 Oct 2021 16:44:41 -0500
Message-Id: <20211007214448.6282-2-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211007214448.6282-1-michael.christie@oracle.com>
References: <20211007214448.6282-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM5PR20CA0008.namprd20.prod.outlook.com
 (2603:10b6:3:93::18) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by
 DM5PR20CA0008.namprd20.prod.outlook.com (2603:10b6:3:93::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.18 via Frontend Transport; Thu, 7 Oct 2021 21:44:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ca67b54-30b8-481e-619d-08d989dbb442
X-MS-TrafficTypeDiagnostic: DM5PR10MB1884:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR10MB18849A0B3D1DB64F425625D8F1B19@DM5PR10MB1884.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PWAdLtrmXzo/aqW/2FzM/4MZy4bkXyF88AGIz4GtFi6iy4urbU3E1NhVrXvYWPlIkXWz35ZKGzyPvm9fUevLAPIP6Tn5E1va7Ay7umuj2MTSg/YXj4xDuMgJ2y8pQ5hItsH1w09VgN25piyHMKoT3UHc+qIEG239IrGl6tbV7UWPlBsrv/uFbSU0gViRwx0qHFKHMmzFdCqQ4egdwu7tSjA4mlSVFrkKxF+s2Ez4fRE3xrNs1FN1of6fque32EGiu4ogN48cn1WmlTSF+CD5ZudiBSYohe1cSma2lsyQIQMt71MYrmwpNzdtGvxz1lmqEITsuqUpxFLhneSonOFrE9wWtOG3BsRWbk3brnvL6IjfFcAiNcdSfPEdDRP+wHkbmWwCW1K32AHnfUmAGTUkZ5zctE9Vvi8FZLJ2KQUj7fXO8rS5ScEvzj9gFQTWtq50R7qr675HFhYeKHuY9+g56sjUb9xttyNFzjtdv87mNQ4k0/apSPoUB2mKo262YcaG4tbTVsC9dRD9rCmxRKEeA+OcLSue2NHBJbHOO3pfOEooM/W5Ft7ynaDMgsrah0o1efww0hptFfV9QEiFyB8fvn6MsYD/3fOnX49ZMjmye55B34rLtTU3b8QiSbcEjNAOHT8hllgcTtTdRg76nKYrvCxlBY2Wawrh7vvTlcw7a/nCQkkl1kVAbCjoSzpUFif7rbfmSnfP/YZ7arHgJciHqThNhLBW7RxK1I6s4ZqSdvI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(52116002)(508600001)(6506007)(66556008)(26005)(6512007)(2906002)(83380400001)(4326008)(921005)(1076003)(107886003)(66946007)(956004)(2616005)(186003)(6666004)(8676002)(38100700002)(8936002)(86362001)(36756003)(6486002)(5660300002)(7416002)(38350700002)(66476007)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aZ0wh2DLIPHrdCcDVlIsy8wslJuSHwt+tSyRTpKmVnNg8/XNE80PPg7qE2m6?=
 =?us-ascii?Q?wfQhknvv3A//CJ0XFK8FaWitVT2C9EcXrm4DWsNh59j8qpmbz0qIunO8N7w8?=
 =?us-ascii?Q?fzcQj50l3UQ8g+02lxVDhQNRct0oXHsHyY3icm3GQtIPW27ELEdpbZu14aK7?=
 =?us-ascii?Q?RV9ppdEt+aLTms4YNLXvS6Io7d3SB3d1Pt5qdXP3ZUKxmmGHFCHtioTTHXfe?=
 =?us-ascii?Q?omJxtQJF3P+fF6k7rx5q75ntiA9xeWI3kCZMCv5NR6fyjRjtvYZrG862IJ72?=
 =?us-ascii?Q?jaZtBrNgFUgD9Un8LlABWJv+8YXyoMwF8FriULEfLeoVWIoYZt/sVFeyD4p/?=
 =?us-ascii?Q?wZCg9jOoRtw81IDoUB1I0U70HIYCOqa2Po37xFJ0IecKrPTVT62+EVXHjvAP?=
 =?us-ascii?Q?iWJSwlG1zFUtCcJLaHC8aXpu9K/Ev4Gx48ceHIvObn2dJWnzFJ/U8NAEXsE6?=
 =?us-ascii?Q?v2vsWM2CtkOthKNuPRsunf8bD4F9tBoRj3CgKwi3Vt8Ec8JN9zra6U4JLlTl?=
 =?us-ascii?Q?ZjuKJPTkHoS6wnVEd6piei6WKon+5L//W4NbhwjeitTAOyMZIVgtXASVOWTP?=
 =?us-ascii?Q?Y6gVLkCssL6RScNf5BZKvQEbRrUwosw1ro8sO8yjORH5Vp0K8borsoyKXCyA?=
 =?us-ascii?Q?yEUtHH4t77L7i9E5ZcJM2AyfDSnRDjxEAiPQhqyoDpqUd0CXIkdZ0yZ7BMay?=
 =?us-ascii?Q?AN/TVKG2VyKOeOCV6WfI+X6BVdLefLqbJXuBqY8btrykiMm+K3tx1v0WWTJD?=
 =?us-ascii?Q?LWyaOAmg/C2TfdsaOTr/CLs4pFvQc0I0pQcj1I6/5Hap0e7oK+hqPxgTob59?=
 =?us-ascii?Q?lZ597YgBQjHlyLSiu46DGITHHEBny2C/i2wqiI+cnjBCZ4GA23iR3+kCa71Z?=
 =?us-ascii?Q?GHdcSz97P0hlsld6crpeO4sSArAjzQBuiWqAotWr1CiYLGIuuCU7ANdVRqXE?=
 =?us-ascii?Q?2KsqgYdzhrHR1iBUIuj+rYcJXUT4jqiL2jUUD/rRgKTBmrEHvWAahbPRj/cu?=
 =?us-ascii?Q?n256t6VLufpPKL3eV+gpSMqtSLIx3xUVnSGfb+6iq4EpJ/9B7tAbdoIKjoBq?=
 =?us-ascii?Q?+IXnfIF1IQ4GExBo6me7flVfjGPWnMz4KdTmgLs4sxrRuLtQXlUK3wJbQGeq?=
 =?us-ascii?Q?1l9Z1NyFJuk5uv3PAI/AvxBhCXcLNpHMutNNDPCLtUBoHTncrQsmn1PlOXhI?=
 =?us-ascii?Q?R5MWuob0vRSBb51Ec1UBosgmSb53ZWQKCEwRo2vEwDdVa1iOQUxbApX0PwbM?=
 =?us-ascii?Q?Dm640dpbLZoE3hfd3pdNpDCCznJEH8sHrjoNohNqZ3OSXS5kqN4rClWpKs7M?=
 =?us-ascii?Q?232NhyVc/S0fEpbQJZOzsR/k?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca67b54-30b8-481e-619d-08d989dbb442
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 21:44:56.5957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dJ6/sMtDLpD4H05Ez42f3HM+Y2nX78BCYwpG3TuF9ggjiCe1a0dtt33ey63y8xOlRHoo3NeUmkq7JywukarPMl4NWqLFmcZ4EgpMRgh0blM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1884
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10130
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110070137
X-Proofpoint-ORIG-GUID: wGMWDJWFo7x54cwUMCs0F4M0pOGW6fl1
X-Proofpoint-GUID: wGMWDJWFo7x54cwUMCs0F4M0pOGW6fl1
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
