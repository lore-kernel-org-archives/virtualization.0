Return-Path: <SRS0=rv7y=OL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEA5C433EF
	for <virtualization@archiver.kernel.org>; Tue, 21 Sep 2021 21:53:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D39E660FDA
	for <virtualization@archiver.kernel.org>; Tue, 21 Sep 2021 21:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D39E660FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A29F0406FB;
	Tue, 21 Sep 2021 21:53:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LGoYZdT0uQK8; Tue, 21 Sep 2021 21:53:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 28100406FC;
	Tue, 21 Sep 2021 21:53:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04C30C0011;
	Tue, 21 Sep 2021 21:53:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F9D1C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 21:52:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7E9E660839
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 21:52:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="COZOWB4h";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="ynk86QpR"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ozp_OAvrWDE0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 21:52:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D066D60832
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 21:52:58 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LLEBfm028880; 
 Tue, 21 Sep 2021 21:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=toCzKEen1yhLwmxZK4qS9okwRVeTlVH5iIlAkGRYP/A=;
 b=COZOWB4hlkAVtL8CmX7RkXpwv+OYAXPlpp2yH0LMPoXkBX+kMxIKCJGjLux7eHRHdhU4
 EKyPbnvIWGiixY5nhrNwBJM7S12MPfW5TBl3cwY9L432LAE7IvxpInT5upJfROgkQNoI
 LXAKsxdNP6TcHKOHwebBFo2I/2vWtq93M1L18nZ38tdx/rfXZ88cdVT6qOk6d1FHzhRO
 agEW5dFK6jkfyGWN6TFhBfo0ASzHddetU4Y3hsldsTEENrzAeyYu5MTg3MROY6/ADf+a
 qA6I7tE8NOpRbshR3rYiGYh5Jqfk0DFTepc27CwKq/rPRgPbOvSeYxzKwnTYXKZaG7pt yw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3b7q4r85f6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Sep 2021 21:52:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18LLnv9e106589;
 Tue, 21 Sep 2021 21:52:31 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
 by userp3020.oracle.com with ESMTP id 3b7q5v97j1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Sep 2021 21:52:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8lHxn389Z6QYp6yKjWVErVJjw2iVnqpqlJS79eStiO6U3oxvzKfEXI2/6rkjlNTxrK2ESNgsfdfS+HbUarF3NvGcliU2xLQU3EEgSwiLwrs/ct7Cgjj2AmL7QK+Gz5x/RBkPgkn6ef+a/Z23EpwPepN4/K7/HKq9oxSOIbysSmHGhRxOvhFVXhwvpVWNVmGXgWOiMSgZXaEomgUbyWwpOofzcSZJAKgatGPJbl56QOiohvXVACwcmxxyCL86iQroNnXMPCnjZWUnY7Oz6nsDr9exOedJOFXO4b55pmP2/BBplr6nnDMz/H0f/JI75KDCDm+Qlh2+jT5Mnv/e0Rw1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=toCzKEen1yhLwmxZK4qS9okwRVeTlVH5iIlAkGRYP/A=;
 b=IYcMqVvGL3QWVTbHYgN63QkKdc8VC1wx30TWfr1AM8texZ3rFbayFnF0wW9opG6CSPFR4mnlxT6HjA9fcGjC8eESHgi11OjANecEcu7CyASKx5sS8sg+UWcxeWC93uhrAxvYv+/zp6Aq1M6rrbDpyE2ztB14wzn16z5OMwFh8FhfvQ1rtNe0AxD4XcW6q4qubV0ONsOWOiwN+G8S7a0CQwrKMd/ykfNG4HDfdvMLMOCB4TJ9FWg4YH8I6QsOY/jQDmCBITI/DBQaA2RMe4/ZgmAyqbzFBearz9BSREhE5kKUMFd28Ez7NQZa6ClRKYOab2Jd04b6kjskB1zUupjCAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toCzKEen1yhLwmxZK4qS9okwRVeTlVH5iIlAkGRYP/A=;
 b=ynk86QpRpsM0fgkBJSItBc0ZwdnPld9VDwPpYW2LPBVvdrPB7kJx2A6Z48fm522q3Yu3JE9Ip5E9MTcCbBb+pso6tj9NK5FNSG1W7VDq/JrPerbePVajdf4FMCPqbd6xOga7PtmSNdacrHymKfXSFwYBy3p+kw95lHkZ+oq9qnQ=
Authentication-Results: sina.com; dkim=none (message not signed)
 header.d=none;sina.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BY5PR10MB3892.namprd10.prod.outlook.com (2603:10b6:a03:1fb::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 21:52:29 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701%6]) with mapi id 15.20.4523.018; Tue, 21 Sep 2021
 21:52:29 +0000
From: Mike Christie <michael.christie@oracle.com>
To: hdanton@sina.com, hch@infradead.org, stefanha@redhat.com,
 jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/9] fork: Make IO worker options flag based
Date: Tue, 21 Sep 2021 16:52:10 -0500
Message-Id: <20210921215218.89844-2-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210921215218.89844-1-michael.christie@oracle.com>
References: <20210921215218.89844-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM5PR1101CA0021.namprd11.prod.outlook.com
 (2603:10b6:4:4c::31) To BYAPR10MB3573.namprd10.prod.outlook.com
 (2603:10b6:a03:11e::32)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by
 DM5PR1101CA0021.namprd11.prod.outlook.com (2603:10b6:4:4c::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 21:52:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3386eb0e-25fe-4751-356b-08d97d4a1b50
X-MS-TrafficTypeDiagnostic: BY5PR10MB3892:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB38920292FC8DA90DE483673BF1A19@BY5PR10MB3892.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2STzV1V20Dn1ftbT5xcPYtFt7cj1q/Ujubkxm4nUQK4phzhGa9h54Jzv74LIosJOeS6fGv9nJVRXl7VVLzY/PVVqmdSpyZpcmeMVY15tfUSvKfRhlyggnVhqHlDDa51XvTk3lB3KdV2oCPXxc9wz11pIYnF6tdWL5F1AatXPilJBt8d1pB+P3i63Hf/uDWsRy/lRo8VjTLKGISysoNznFv+dVXWHhFeMuCquU9UCbHFmp4rRvTrJFH+C/oJXyJc8CTdoJwPeyK0LCDzKl2tpf+GFWeGFqWRiAoqqYAC2c7RxQXBXKUPxMWEN1ICO7XURubN5ap3C9ZGZ/BmttcC8nII0MB2tU2Ux+j74EMuYnJ9KwR0BAudWoiecUlQpuPczfB7AwCrBFqZkExdgd/4XC4x0S10n5BsN+DSEa0U4gkIjsfky9pCgHIDH088xDEUe9b+usX8UXgqJxixKG2N45dxTEczSXIUPmmFI0B4flSWIF78iFGNLEJaagbSNa+I6vl8vaz8scIozkbEG0VHUjBXIRU1Ld/bP87uHSiswvwTE4RNeLTUxpNLnEqD7uf/mvdY3opyLHkaWLYZa7fbtGVQT4awqB83YiRacacdyE9t562gxFeiXdpZGyfWkCDeeY5KiL0B10GvMxW1UWgOETkCtTyEpia1cEQfY/p5WYsuiEGaAnbVxMdt/pb+KihiCBO7QKv9HGfPkNoH3Guf927l6T6aorq/VxShdswuU/fU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6506007)(52116002)(107886003)(956004)(66946007)(26005)(4326008)(7416002)(66556008)(2616005)(66476007)(86362001)(6486002)(8676002)(6666004)(508600001)(316002)(2906002)(6512007)(8936002)(38100700002)(1076003)(5660300002)(83380400001)(186003)(38350700002)(921005)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vku12V85ByJkeWKGznS847hiua2irk/Vsu3hlDUJxYq3QV+ippmQgLklR2aJ?=
 =?us-ascii?Q?0K7e8AcHorGvEABerLnKRIGIYqm6ULHDX+pP99OjYK5Mt99FdDUMgoN/0NJ0?=
 =?us-ascii?Q?tCTqYglqZ7TPhqinAKmWsLXIkEUuq5bKTQQoluGocxyjD5QZt0jN6cMOUNwr?=
 =?us-ascii?Q?TtxdnCZs2zs1qqvGuKEx4c2V1h0BLxnNnoOU6keUD2G2BU77m9LOdrrJ3oBb?=
 =?us-ascii?Q?Ch9Si6csn+icrXtrG0LQkbxUXuPDAST7BqGy8BSvYDiBfirIp00tWsp4vAgO?=
 =?us-ascii?Q?kx8glUYWOLxFJySrckkQYVtUbeEnk4HVB5I8fnDZtwkETifW+lzVojWfjp1v?=
 =?us-ascii?Q?7GjkFBQoxwEBIcb91gNAH9dxqstc7PyAgVg9AmQDLNL3oWORPWAUAeTUo3IQ?=
 =?us-ascii?Q?57VeWxJ02bxF2zojrQ9XyQ+a53M5//ZUnzIAJ8r0uAojDzmdNuH4cAyaie/2?=
 =?us-ascii?Q?Q9XhOeys89jDYih5sAbgCONIV+d7C8FuKd0o4TbCfEypugLL+5NZ+SZivF+6?=
 =?us-ascii?Q?Qx/nIqq8zHS16NsGCr7F5rC9MrKoci28tdVUNqUelmDj2hn8uU3TiPgVRC40?=
 =?us-ascii?Q?bzCSHbvfl/mA84pK5ytsjXCLfI8ckfHuJ3cSZBvJGMN4sOcB/Ko2DRMku+UA?=
 =?us-ascii?Q?G8z+6Gdvqr4//mh0uIDlugkPGEtkK6oDzka3qDe+VvO31ajMpHHZi4I/lvUf?=
 =?us-ascii?Q?TRJfYd5fH0gK3GidhQYjvAp+c9CrrS5MnWoXtOL/fIW1sKUXiSfKa5yeOfyA?=
 =?us-ascii?Q?iOwhUcryqWpRIR1mh3sZzFF/B0lsZ/QLczksc4kKHUlGV4A6+Sm17m5yoPfu?=
 =?us-ascii?Q?J2T0VniY6FxG4Q4fbvrKrzg0nO4PGihuGHkqJc3XPC+AWQmXgSCLgryxEBcR?=
 =?us-ascii?Q?gg9hg9ksQUNJ50Yl/3hBttQUTp4ZgGdn4xSmJvts7KdFGVetiIdehEq72sq8?=
 =?us-ascii?Q?z4tYS+bmBqspL4YrN5n0O2rTVzxNou6Q/3gDpW+pXzH02i1Be8+qubtXrwCj?=
 =?us-ascii?Q?6xG2c/+pUKI/721UnmySpOCPykTyb15WlUw+P5em4TCaGJlngf3g7rJxUXBp?=
 =?us-ascii?Q?eaP6PNFyCjnGnLelaRc9Tzp8BaR+XLKc16A2sXlGInyhl4jLEPTsWNL4jwRK?=
 =?us-ascii?Q?fpsXX5jKh7mvJtcKy8Aa7+2We0niA8S/dJaZmld+5rZwcIDuMnLEpCvwFbKN?=
 =?us-ascii?Q?04xmFkYW4UktKj0t6FAYPVOE1tE1lawXKGBQWgrmsye2Y7D7N/1pzQPcVlAN?=
 =?us-ascii?Q?yEqqe7F0GlFb9ttrPDzCFWQhBRrGW2rgs8yOQGn3dtWkXnptsgE78iRc76qX?=
 =?us-ascii?Q?+WjQjh2EfKl6AZeBgyx2zDbF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3386eb0e-25fe-4751-356b-08d97d4a1b50
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 21:52:29.0588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2NCnvgOPPHx/A9dKo7jxjbKDiT6Hr2hTD6sxV8C3UOG+L/IBQj/adcY+PpivIKa0Ak2doxI32PGQ8a9nyGKMrD39R+cWAZi2bfUuzgQrqgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3892
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10114
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109200000
 definitions=main-2109210130
X-Proofpoint-GUID: 8rx1MRaBaw87HP3IRpF08xZOLcTlVLzc
X-Proofpoint-ORIG-GUID: 8rx1MRaBaw87HP3IRpF08xZOLcTlVLzc
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
