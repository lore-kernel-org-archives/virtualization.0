Return-Path: <SRS0=OSH5=O3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8D7C433F5
	for <virtualization@archiver.kernel.org>; Thu,  7 Oct 2021 21:45:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC70A60F23
	for <virtualization@archiver.kernel.org>; Thu,  7 Oct 2021 21:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CC70A60F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 965FC8428F;
	Thu,  7 Oct 2021 21:45:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xydUqFBgi3Lj; Thu,  7 Oct 2021 21:45:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CF06584137;
	Thu,  7 Oct 2021 21:45:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5DA5CC0026;
	Thu,  7 Oct 2021 21:45:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47E60C000F
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 21:45:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3AB2884094
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 21:45:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XxWYT30HIguq
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 21:45:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 79F3F84035
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 21:45:31 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 197KYYFs007643; 
 Thu, 7 Oct 2021 21:45:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=MFHga1tLW8x69y5rLxdCmPpzPHiabQgoAawWQYe5SvM=;
 b=ekQg185joLmBrewRw7Hmn/fFGwAGowXDVzWCnAnflqx90FZWqm4Uw8pcLTxijDoz1VGU
 NLYv94w812zJ4nzo6yJh/3cZgHI8kDxBQC0DzjQ1rHHzarZdiR0jZrAThpj0m8ZJ7R82
 Wp8S7w/YFUi6E4V98O8v+EBOt3vdHRhqloYte40rd1Nz2UDa0FBHg/jeMqyjTEu1Lt88
 /5XRgLmq/9dpxWQb+9CSvCFuqs32BEHKZm7dmT1dNy2G6bc1OfRZUogqCs535YK08LCm
 HSTXSWrqJ5NkJEERqKwbZ5R50+d0E4CudX5fjib5Di88AWvmQXX7TQrO2h9ZimeSpZeC HQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3bj0pw475a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Oct 2021 21:45:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 197Le7IP113075;
 Thu, 7 Oct 2021 21:45:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by aserp3030.oracle.com with ESMTP id 3bev7x4uju-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Oct 2021 21:45:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U02PpirQT9riAGyp5ej961xScVcN8Js/iWbTnxp4RbQe4gkEEfSo+kwAtvBm7EQhzMDmOv8HRSBvOwr0OjJ7JEcI1fWDl/eWPLxRV6OOL0Y/xpvmMgpskY+BIVL1jHhxLLQFI1r4+kyS1Iuz6VsSMmdh03sJKrRplaY4a2KEHIRvtCapluzBpViKllFmcXRrkSN3fe8hKp1lxZlexLSZ+vl6hB5oSsaAdxtSavSIQUzRHn5lsy/9e9KRdxBV656OWCVizei+w5PYSOxfFNQJsvOULii7ONRlRgE/Sa7IhJcPnVpq2FzTG3wbefxoF1O8jAdGzcx2BltqQ2S5n70Caw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFHga1tLW8x69y5rLxdCmPpzPHiabQgoAawWQYe5SvM=;
 b=Dr4mhFUWmhd5/LioTeuDTKdjqZgcz95xnUSshN+fB8M9H3ZNOgTMAFhL7nUqh2s6Q2NIv6Reb0BleFFUGHjvMfJYV8/ZydYCSSu/x/RXEurVqnpQ7Yg+5P5C8y09KL5f8Fn5W0l9sdoKKXaj1cghjKBVrhJFZ2sH6admbLGgpHWKQvmtFRsvUIPuZuGN2LvOEDK3IRc7vpTKQur23EmzlgtXyWFUKDniqDojQcksGGAABJrkg0YFOSX2F4NVDl7yBblVyOUaBb5OvwlBppY52V/TMPfFYlWN0gDZMQsdFjsqeLAFiXsS1iQElxOBdCE7RTSHFT06n5oxfO+XUUjQ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFHga1tLW8x69y5rLxdCmPpzPHiabQgoAawWQYe5SvM=;
 b=hF4MxpPMSCIQ5WmjhdoT65t/1yq442rLXlwQhYk94f1NIypj912PFWYT2Bk3okJqoM393xIbKIXDCYz1yGbBxOOaXhale2HhpkQ0cwxcUZwERKvka58GJ+oxCzpYlWFGFtvf0XEpv01XHc6sQrcnXdFt5jJQj4AwKP/AaJesq3U=
Authentication-Results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM5PR10MB1612.namprd10.prod.outlook.com (2603:10b6:4:5::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.19; Thu, 7 Oct 2021 21:44:58 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531%5]) with mapi id 15.20.4587.021; Thu, 7 Oct 2021
 21:44:58 +0000
From: Mike Christie <michael.christie@oracle.com>
To: geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
 hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH V4 4/8] fork: Add KERNEL_WORKER flag to ignore signals
Date: Thu,  7 Oct 2021 16:44:44 -0500
Message-Id: <20211007214448.6282-5-michael.christie@oracle.com>
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
 15.20.4587.18 via Frontend Transport; Thu, 7 Oct 2021 21:44:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d5429ac-56f8-4a5e-223c-08d989dbb568
X-MS-TrafficTypeDiagnostic: DM5PR10MB1612:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR10MB16127BBCC53E9886688CC57FF1B19@DM5PR10MB1612.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: of57Z9XRCfwKVrswFvxuxPNXYugjeL+8cBspUbw/ba1gnXPs3Wg6gteeS0U8bPaSf2m9fmDL9jalqDU3KwQx3KM0x6WXauSTJwBeRShH7MRjTOs1Tb26afKjFX/K2daEGBSzN0Ifg5lvF3Yc4z4ts+peD88+8++PyCQYZcpX1yxE0zpf6aKwP2a39+FAJExPixYHSROq+peS8B9Wa1Wc5uOeUAUoKZ0AWyq3m1ACcuUd+kqSgJWQWKBveP8snKKW4DRhDMRHxFe6pJSpVqPda/uD3c7Vi2/EhsU956TYa/sopAkKp26SX/0/UzG99zTC3Q4+5pNoeH5+SK7Bro90bPhTw9GNo/UQmJ5Fw67m5rVY5nWc6O4jxSJqX68b6Km5Az9nkg2YAPTGaSRqyqfVb5m4KWqXeXk6awNRXfYmmaXg08PMwZ/7T/xyEijpL48s44UFv5JykE4YGD0XoQJX+JrGJ8QMv75HC2FZ40WnW24eT2Lk5WSiAbGQjVX3035IEa7XlJMa4Ct0O9ql4S9zvB84kSFpPj2ot1DHPXK5/LVOJ6RuGm3A4h0u6Gm1WNB6+tHTjunCq6a6aD222bejrlSosJzyxxK1MPbOsfR/Bc3TCkm3IQcnfSZaIMIFmeTn1DEGdpH85jMqBGcSyFfgZLE79fXl4H41+bbR3xi0loFJTmpDqTu9JCj1MgxF4s3wFRG/7a5AwIQ5z90U25lY28Q6dz5ptmrF+D691wIHncc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(316002)(36756003)(2906002)(66556008)(1076003)(66476007)(86362001)(186003)(6506007)(83380400001)(508600001)(7416002)(52116002)(66946007)(6512007)(8936002)(921005)(107886003)(26005)(4326008)(8676002)(2616005)(956004)(6666004)(6486002)(5660300002)(38100700002)(38350700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7Dk0TGjVJwdcNzwnZiJ8o25nYBLWg4q5xTyzC4kokWm3SuD3xbCot58PH5Jl?=
 =?us-ascii?Q?rg4915jSdHaYTTOkQRBjeTNqReNRf05R0d651yXv7bCk51Ym1OaL0pc7f/a9?=
 =?us-ascii?Q?XVACGjeWgUQyUe+P5LkK9VQJfhDfTF8omvl5mTxPw+/zfbS0WrRf6pK1XaBD?=
 =?us-ascii?Q?KG4jD+45ecpwrpijkDTtWNEnM93EMP7pi0//r2jZBBYZE88tqR6Z7ovAJC0G?=
 =?us-ascii?Q?LyCmdtfw8YsIMYKEjpm4LdhJ9WsYmW7FL+zGN5/GC3E0rxRj9qNyiANoAAcB?=
 =?us-ascii?Q?7vVChhVSalzvzNrQvi04x962nknwla9q4eaZxEnXdYY1mHqvCaCTkbSejuys?=
 =?us-ascii?Q?qyKPHun7tJwVs+KGsG7e3xrA4CmOHa4a6Rxm2wgkv7mU27yCgut03aZTALEc?=
 =?us-ascii?Q?KVbj6xdYwqlvGCgvF0ppbBiEM4UlczO86JLKrySdF1J95ieQylig3rvBIBI5?=
 =?us-ascii?Q?2uwU10IWy2Z8RxChMZrEI29QogHexXuBIQIFGTKhBBEhA165cqkmwDThM3C/?=
 =?us-ascii?Q?B7HtWyvtED/oOzn6LegUf4VhXCa94+wx1F8BpHK49VMzjgo2dABQyZxMgWYG?=
 =?us-ascii?Q?26DIT5wehqtZwxwmyvmN1kdc7KnO6H/9WD4xuPF0cxUhKM8UT63xOoNbX7hK?=
 =?us-ascii?Q?4ema2eK6nnIPgIOdzsxcmiTqOCLWu46MkwC59bL7rMtg/InFViggB/Nhln17?=
 =?us-ascii?Q?jHW0D9FqYkmJ8I9CuOd3/PQirrxIrWHNvpF4XGqFX50+3l1kwl3Q9zN4GnXu?=
 =?us-ascii?Q?vq6gNzkjhB4BKGVzdMrfguDFHZOMM4/FVuPd7p40z96lar1EPNvnaRT+7c5e?=
 =?us-ascii?Q?kKAJ4OV6hgggjMQ3BsyZyLDsoJguZO9iw4cImo4q0EgDFaiW3Ui4jVt1cs2k?=
 =?us-ascii?Q?y3vvNqgRMJy1KF1FuJp2tiVvzpOfT72fJJlgpI7T/vdwmAdsCu732WYOXthL?=
 =?us-ascii?Q?QyEfozGoNnFHJvzyeWBkFo5+TT6Aus/PK3y7PqWbqdykxnvIBo4dEm/4LHSg?=
 =?us-ascii?Q?k3nbAoFXmEtiKrRZ0M4MO6JVVVBuVW7DbcU43PpgND+jiFX2O4U7EDBENXE7?=
 =?us-ascii?Q?LXfpYYpS84CuBYQ+2jDz7yDtQRN4xoZQpAbkzODshWcDuXAaVxTCYs0sf1/r?=
 =?us-ascii?Q?lWoPgo+54GTmEcIFRSOr5Ymn6+b9rUdh/Tli3mdXLPWOpQGEIHVP2ELETlGi?=
 =?us-ascii?Q?IjoEOdHCwOr34tAh6WwzMWrZ+U8ODRdhlH1vpxbogQ10BMgqTHHFAd9nfe8l?=
 =?us-ascii?Q?4/d/BAz4Gi6BgJCWXjzx2JepfnITNF01v7MJ2J+gs4AyCjocD9hzFtdXkE28?=
 =?us-ascii?Q?XmmF9Fx3Sei6eNv2E0A4oltp?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d5429ac-56f8-4a5e-223c-08d989dbb568
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 21:44:58.5638 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hdLKcW8oEY6snkmZkKTYNlezwfYFvadjAJNExogUG/pFCSw/KQ4I1SKQ+ENt9o4rjbp/chEba+/BVXg/jTk+dIlnT9EEH+r0Q7UUvkdm4hU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1612
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10130
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110070137
X-Proofpoint-ORIG-GUID: VfJrye7DazUZyPwBq7uLrCn_aZEZrcDx
X-Proofpoint-GUID: VfJrye7DazUZyPwBq7uLrCn_aZEZrcDx
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

From: Christian Brauner <christian.brauner@ubuntu.com>

Since this is mirroring kthread's sig ignore api introduced in

commit 10ab825bdef8 ("change kernel threads to ignore signals instead of
blocking them")

this patch adds an option flag, KERNEL_WORKER_SIG_IGN, handled in
copy_process() after copy_sighand() and copy_signals() to ease the
transition from kthreads to this new api.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 include/linux/sched/task.h | 1 +
 kernel/fork.c              | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 1153f9e5d10e..5f3928fe0544 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -21,6 +21,7 @@ struct css_set;
 #define KERN_WORKER_IO		BIT(0)
 #define KERN_WORKER_USER	BIT(1)
 #define KERN_WORKER_NO_FILES	BIT(2)
+#define KERN_WORKER_SIG_IGN	BIT(3)
 
 struct kernel_clone_args {
 	u64 flags;
diff --git a/kernel/fork.c b/kernel/fork.c
index 3161edac1236..07f9e410fb64 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2213,6 +2213,9 @@ static __latent_entropy struct task_struct *copy_process(
 	if (retval)
 		goto bad_fork_cleanup_io;
 
+	if (args->worker_flags & KERN_WORKER_SIG_IGN)
+		ignore_signals(p);
+
 	stackleak_task_init(p);
 
 	if (pid != &init_struct_pid) {
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
