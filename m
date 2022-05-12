Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A97C433F5
	for <virtualization@archiver.kernel.org>; Thu, 12 May 2022 21:47:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 987AC82998;
	Thu, 12 May 2022 21:47:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8tP-zxyhRymS; Thu, 12 May 2022 21:47:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3060782CA3;
	Thu, 12 May 2022 21:47:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EFAE0C0039;
	Thu, 12 May 2022 21:47:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2BEE0C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 21:47:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 16E0B4167F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 21:47:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="LHF3Iaym";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="OeOHU493"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ah1UT6RrIezH
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 21:47:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 22CA1409BA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 21:47:33 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CLIV1V024581;
 Thu, 12 May 2022 21:47:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=+tS2e9WqIUvSewiodMZ3iqCHlaaxfYp0IJgi/05g2hs=;
 b=LHF3IaympdsHhgdIIMzKh6BxrXLUfy2oiizwUsPMJIiibG7WCS1tqMbCvrgeiLo5uj3J
 HRVw24k2cMKe9IdkTlXpIXxCSatmKtWKw+yksmTPjveWSIQy7jFBnZ041SnztauVNsqZ
 ErK4QUWygC/66+igaVIUSfgOuaz2QlzgUAvB8mEl4PggyM8TAGhtu9YlGo7fxQXYCdFk
 +q0OspF07Xv1kI9kiQwNStXr431D6zyow8qaIyIhqXs2jv4J/406IEyZii/78I/lboe6
 yKmg+5h0cezI94iuOYnoMTNSAa1bbzsSXspcSv6Junye3wcJhvcQp2C/Mf7QehaBkJsC jA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwfc0x0da-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 May 2022 21:47:17 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24CLgIkN004728; Thu, 12 May 2022 21:47:15 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3fwf7c98s9-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 May 2022 21:47:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVVnRxNR+961pxOxFiA7eYWomt7EFy8uLp4cjDyk95P4YZc9F1R3LKzOURhSgwicaGt6Bwe/2P3l5IMESDBdrYwnEM9WDAGLGeYkZ6jh50cu2inW/SernUODQ54V7AtucO+IORAwry+lGYNTQxxieeYsNiI1M03mhHAoES6R7NfGAnkJOYz9TBxyPxx5HiHVJgTpNzqJU2RK0mwXNfFloSnWRAeo2Ly8F/UZUzPj/nuYDzCB5l14261BxDHYDvjNW+8qRyTo0TA8Ku1GjwAJ/+lrx7dtrf7vPe8248dPQQw3Bi2ulZGWCpeJn3Kupm+HghfDhDmF7YOmv5uXz2OtKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tS2e9WqIUvSewiodMZ3iqCHlaaxfYp0IJgi/05g2hs=;
 b=RsE5hmyHmOuOATylCgfUlqg75j43ifNh2UDDf1FnexRL0XuPsGUHDt2ggOEe6tZjBWGcrF9TLvGrRpIeA6h6jRCZXdqnwVleYuFoEDgwVytDrO5RSC+4mizNfua74W7XIvSbeGiqG6KPMgGxAuId4JJ3yoFNlnjLaR2BBvMXqDQ/U3aCoQf6gK+DA3kD72TPhOKwyGzM7dUD7R4jgCPY6gdVitLBatkg7kdJE+miRt40VdqhPpNAUKWfoMAyEcKWYGWrKulnT/NrS1kZX6GwfTr5hJt3DQaj7shPEiYm4MJ1QKbFnAVLCzImxyX9fTGOmURuTmyp8vEURWGi5HVBKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tS2e9WqIUvSewiodMZ3iqCHlaaxfYp0IJgi/05g2hs=;
 b=OeOHU493OmSULHrH+PZpJVFlJHa0ZxWbKSEGWZi1JJ4i0tR1cgUVYjWZIn7VRWemjw3ertgRj0mOYqCS6I5GdvfU2vslU2oNnsKygwA7l+PR1aWm8uGK0O8l8SREkES0xF3fy4g7ytf2JswK06zbmNOwuQCVD5kV2bZGFwINVAo=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 MN2PR10MB3311.namprd10.prod.outlook.com (2603:10b6:208:121::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 21:47:14 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 21:47:14 +0000
From: Mike Christie <michael.christie@oracle.com>
To: hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org, brauner@kernel.org,
 ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: [PATCH V9 4/8] fork: Add USER_WORKER flag to ignore signals
Date: Thu, 12 May 2022 16:47:00 -0500
Message-Id: <20220512214704.104472-5-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220512214704.104472-1-michael.christie@oracle.com>
References: <20220512214704.104472-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM5PR07CA0089.namprd07.prod.outlook.com
 (2603:10b6:4:ae::18) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e8ce216-ca7e-4539-45ad-08da3460f9bc
X-MS-TrafficTypeDiagnostic: MN2PR10MB3311:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB33117BD4720B795CA24B2502F1CB9@MN2PR10MB3311.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YT3GQ4/ksPmjMPlIrgtpIubkhd7o4+hhroLUQ9D7nZLIRVQ16n664rl/0FzPCoUEEUQkCFocJAjzhVkZ4oRABu4pl45amkjkc25bfteaJB9ULjv04TQLJCi7SEStyA554J855PC99SA4SIsbQbPvDMQMgSxLLXs7Pe4xr6zssBrn5XuL/1rFMiKoljwLUIMiVe4v58Ne5qvsIYLMHRU6DccqAngIJVTn5Kjv9KE3Awizun2AzNjSqTPBYGDRcU4VjZ7JzF0MicKNvBP4Gw8BT8z5opJYTsatd2AbqJ6/lh/YFSgH3kgAzxBazgMoblWBQid6bGgq+RcC68qUZUOeaEeP4/zChH5vidBYZCjIau/IlJ9EP/M7IHtVNfrLAk3ViyeAXEL0y4zeGWVzZsYHQvtHE2Um/NS4yemyawMrFK8HxZJcby4BN8+2vAaGOCRpojvhm2fnO58+/5pNSy60rkBg21du67SH5pfcAAw5ZGNDkdNJx24CM4MXsiFyFKKRlng3W0zVXHvZMuzEVZjmEfxA8bNHcig1J7EbGLJR9Gpm1Qp3PLBUkWx7ModueSgKCw/81+IlZBTigCTFSH5llv3ZlrXcvGklkZzpxr4NsC5UAjYZpKArw8e9/+1sAsv8bGZuAyc5vUKk64G1priORjOeOzBydM54EeCmwrPrhFvimv2r394U53UGfIK6e8jXYSRW/53PiipytcIJ2Hmcew==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(5660300002)(7416002)(2906002)(66556008)(66476007)(316002)(66946007)(508600001)(36756003)(6486002)(26005)(6512007)(4326008)(8676002)(6666004)(6506007)(186003)(38350700002)(54906003)(38100700002)(83380400001)(8936002)(2616005)(1076003)(52116002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/uzbiaMbe7WXbhT2T7b5TEhljHapy1QV9U+ZEnef9njEaytGFgzqH++T4lk4?=
 =?us-ascii?Q?6IM+6AgjAs/Bga+bpBFUYozujH1yy8gs62FhyIsyvvtscLjR49GY2RpqeFea?=
 =?us-ascii?Q?x/KtyK9WX0XzMvMOIfODbgKwaiu9m5HEpqvBnmC5GjMPfZQ1Yl6Lf9GfYbdz?=
 =?us-ascii?Q?Kx6GANMLJ0byZICcglD//snta+C8NXRJUamZgmhiIrTibLYuI7olo0DwElFT?=
 =?us-ascii?Q?66xD1iURY1TzC5ps/9On+58EyD/jrPE1B5MopHRYg0VBMLBPFE2koh6/KF75?=
 =?us-ascii?Q?L8UAS3BD7BPIevcmzK8ytIdgIur3pMmKXJNEBjI8d2lWzbUKPg3ezLbA7usF?=
 =?us-ascii?Q?Y1AWnFM6rqXCCmIUxERLnWZxT4KrcuGXBDrs11L2vbFR37xvPWYYe4MpVK3b?=
 =?us-ascii?Q?Pjy2eyLiWaFKdVarpfxb9nax3AHG0HtXmxlepcs3CG8w8kZuAPu6higc4qLk?=
 =?us-ascii?Q?rTnA+cO4RoOb41WnzQsPUu3BJJl5yPZwFr9wSL6P6o6VpDzJImCBmXbeprhs?=
 =?us-ascii?Q?p9vpaOQOsmiqMNOCvyAKS+XjdaXJJRNYBJely721cLcG67QIhtg11NfiQuDk?=
 =?us-ascii?Q?owAtL6uMIV5fJp53WZhlpwlZ2hU0bGpQ3Fx03brtQddEI1SgLuN6ay36En5l?=
 =?us-ascii?Q?g37gsGb+1JhzYJB0sOZd64sgPGAE3zJoX+cQKsSuIr8ijA4n59hllzocCvJJ?=
 =?us-ascii?Q?LyKS2NhwR+QjdwvNDNdwmfQ94EMViMvAtfcCoCo0EB4xEQdEgKqI9WLx5OlD?=
 =?us-ascii?Q?mLnlh0P9OKhXkEgz6JQngEkfSZBdldSSShbm/c9NNVjiz2qLik5CZ/Ux5+b/?=
 =?us-ascii?Q?Le0CYUucJKNnlzrWkf+z9mwZNBbrnspAlcU2fpf1YTbN29J5wP/4v/Mr0/qR?=
 =?us-ascii?Q?c0zogy//iiPo1eCfrI9zmRPxoKwZOERCrDAmXDA/yRN5X25c9WpyTN9aTtBd?=
 =?us-ascii?Q?4WqxXlYO/SgxAgvebUuVhHRPcIFByS+OdFQc5XMRdr/CTsMJFAPptGN7FJFx?=
 =?us-ascii?Q?GIRBFsW+kkbdAPzhuIvAFuR/EoXjXKqShHQDg/iiuMecwT9hMxEhw2DrzaeR?=
 =?us-ascii?Q?VzWoPz17G3jfp78liW1x9ra/JVplv2S8veMwRZxodvTAP8051HwJJNhI1/LT?=
 =?us-ascii?Q?jmF3RCl+zilI9sFc5Gi2guYzLsnVQl4vVaSl9HECM2314VUTdCVOQh04Wvoc?=
 =?us-ascii?Q?U1yKNoftc8bjUYfBwiKh36PbWM91T8+/fu59+3yiXq8B2BeRTtfZPCMVklVD?=
 =?us-ascii?Q?/Z41/PhzCnhaH5VwMGkrFxlovZhF2wVwAx6aaJFjFxYc6C5CEESPgstFiXVe?=
 =?us-ascii?Q?olKyxsvAW6BOhx5BE58uvz/sCx6oK2W/oRWe8kWIVWR6whWAxTKDssjimWT5?=
 =?us-ascii?Q?LDT4HGaE/g1JnURwcLqYXDGsCc1eFFWv29lv7m78Q9VXuY+lRw9/FM+6AAkD?=
 =?us-ascii?Q?TuRHegYil6aXXLDIqGv/IoQF8piqC5qsUVRjzny+3n/GuS83lVuFmqAfv265?=
 =?us-ascii?Q?XUySqXhxNWXnFe1KtjJTz84h5cF4AR134L863b33Z/aTZfFFLaYBUJuFLr2o?=
 =?us-ascii?Q?lpwKP9aNG8gQBeDz86Tf9nF3vHer5wglCFnfJCq6SGInSW585plQM4MCLqF6?=
 =?us-ascii?Q?Wmy03KkhhqMerz5GEOMLOt+sRwyFlO2A4FFfE5zuSqVtyhX+E54T1pj/BECt?=
 =?us-ascii?Q?+9tQdeZRUWdL1MMw++czbo1+ibQBzfn2VyQxbLGoXgO1HNMo+wgMGxNM15/3?=
 =?us-ascii?Q?KafpLqGykoZGr2T8B3gPQGowPiJbBuU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8ce216-ca7e-4539-45ad-08da3460f9bc
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 21:47:13.9122 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o6AcULeS/RHWFp6eQJj+lYXIU469NhzMuZswV/ivOL1lDZGQ4YC2f/9v/GYbLLH7TIi1jGdeRJpt4lxzcjXJZnB6GbNSD1i7WDiza293dMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3311
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.858
 definitions=2022-05-12_13:2022-05-12,
 2022-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120091
X-Proofpoint-ORIG-GUID: HwtyrMXhyJmy8mAqG9_7gsOGKnPEvjdA
X-Proofpoint-GUID: HwtyrMXhyJmy8mAqG9_7gsOGKnPEvjdA
Cc: Christoph Hellwig <hch@lst.de>
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

From: Christian Brauner <brauner@kernel.org>

Since:

commit 10ab825bdef8 ("change kernel threads to ignore signals instead of
blocking them")

kthreads have been ignoring signals by default, and the vhost layer has
never had a need to change that. This patch adds an option flag,
USER_WORKER_SIG_IGN, handled in copy_process() after copy_sighand()
and copy_signals() so vhost_tasks added in the next patches can continue
to ignore singals.

Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/sched/task.h | 1 +
 kernel/fork.c              | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 7f6364e5aa1a..9fbb489b2512 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -21,6 +21,7 @@ struct css_set;
 #define USER_WORKER		BIT(0)
 #define USER_WORKER_IO		BIT(1)
 #define USER_WORKER_NO_FILES	BIT(2)
+#define USER_WORKER_SIG_IGN	BIT(3)
 
 struct kernel_clone_args {
 	u64 flags;
diff --git a/kernel/fork.c b/kernel/fork.c
index 43213bc926c6..84346fa6232e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2258,6 +2258,9 @@ static __latent_entropy struct task_struct *copy_process(
 	if (retval)
 		goto bad_fork_cleanup_io;
 
+	if (args->worker_flags & USER_WORKER_SIG_IGN)
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
