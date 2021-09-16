Return-Path: <SRS0=0+SM=OG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549FAC4332F
	for <virtualization@archiver.kernel.org>; Thu, 16 Sep 2021 21:21:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F86360FC0
	for <virtualization@archiver.kernel.org>; Thu, 16 Sep 2021 21:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1F86360FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 328DB600B4;
	Thu, 16 Sep 2021 21:21:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IeGBzdyJ4OYj; Thu, 16 Sep 2021 21:21:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A7CE161548;
	Thu, 16 Sep 2021 21:21:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82DE4C0028;
	Thu, 16 Sep 2021 21:21:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C15AC001C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 21:21:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F060383F45
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 21:21:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="qHunrknc";
 dkim=pass (2048-bit key) header.d=oracle.com header.b="H9zBYQi0";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="ctZXPujX"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e5yXiwq0YsiS
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 21:21:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C8C5B83F20
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 21:21:14 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GK8wtA010775; 
 Thu, 16 Sep 2021 21:21:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=vFh7OVQ1Yym1dhKx0HLBXjDllr30elJVzWOmY/cvTe8=;
 b=qHunrkncYrlNFYDf9yVMA9nVQjG4RzevY1fvKHIeSns7Jc8ppFhh2Ny7zjLgBt9L7lAd
 exOdtVmeUxrrjLNkMo0B5EHrX5+K8g1N+zR1LzAsIUmG52OIkitTPCGSerJtemL907WQ
 4tX6SKmuCdmCYvHoxjfWjW7/zms9/Lp40diA0md28vhC/HzpSf2ee/jl33bY403tfi2o
 yK64PBgAe/4YNEbIP5RrOlmgk+FBmyF7/4S23VoMz5uZo4DeJBHb5fZPsQf4dMN/JTVi
 NX5fyIX7stasylcBDZOnkytqYPnv2rvYa2JTip/Eux+OoG9bSkpXnjOkuzel2L5dgCgA 0Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=vFh7OVQ1Yym1dhKx0HLBXjDllr30elJVzWOmY/cvTe8=;
 b=H9zBYQi08xD4vU6C2HCaSLx6n8y0n5nE8AbdG+1xYPk7aJIiFK+iWPeSAFyMBDmG8VB9
 +YbHbKifWhnmICqTQlEEWqMPcvbgpzj17nI9CLr/Kjmc+8gogrQ9W2WpBAAmKjAEYkDr
 gvsSZ4EyOYoC0qnS9QhIRoqTSWv62hy3KhwL8EGSb52STt0lwa+tCivvwZeq3aOTZ7BW
 ntp2b3ZD7cyeIanLRKBlokXsooQtmk6Ol3esvOcwYAfSLJFeTXIZ37d3EiIxJgP7zyGf
 MY4ZVMCKcN9GD2n8xcEY37FvWp1Ws1SDtu2xoTHUTcx6Zf5AAl5E03M5MmE098Rv4Emd zg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3b3tnhv277-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Sep 2021 21:21:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18GL5Y3u011322;
 Thu, 16 Sep 2021 21:21:12 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam07lp2040.outbound.protection.outlook.com [104.47.51.40])
 by userp3030.oracle.com with ESMTP id 3b0hjyuvwg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Sep 2021 21:21:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMyddd87gUMOXobkLMTG/ggNRZhSHpwUdcOiKOc2KcamD2OXeE5qX61FqbQ11KqgZKV2zvNIWWR+YuGuQhgq3JVohB0GaFg1FQjx7R5/+cgdmmDdD4I7MKrXLvSLcS/tc9Ij/tcD12q64gPZqA01RJZo1US7vNZbivIXmdiTBGZMAvgm5IkiSrpgCoSS+f6cVw6fXISC7rtyYKl6jFXJzkbDhbzFsyaX4PeErcIeOJhJH+X3wzL4jYHR5HlCBruP9IAdlMuP4PfIEvDpycX1s3UoCg1PMh8/EQ4Fq/zXcwWP/C9d58iAUXPki1DzTN/5R/ZdNptJWOi5ATM0z40E2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=vFh7OVQ1Yym1dhKx0HLBXjDllr30elJVzWOmY/cvTe8=;
 b=EjfuZgUb6fn+r/VqfTm/aVBTsfyXjVD9wuBaCW1uMATMRi22DMcl0YFnK8a4fMpUlD3Ku7LF8Pr82d3eSsPqflSSz2XuJ68lF6UvtfYZHE75AXsBq4XPCJerEyMtMKcQa3TTR2haZRR9eNjgmws71gYFfKR0cBQJ7x/VzsbCuIMxV+/11X0Ue4pAWOHZKey32oOsL761GRWfFT7ACuRbbRGtqqgPRPHFX3dZTeRtajoLPBwOkRS76hn7n0uizEJuQ/YMgp7jFAdQnLpUEklGZUPrNM/jXut4f8Uu/XzAlnGgCX0SUk16X6wjFI/gNRrBxjNFRAyMszokiRXeBnVE4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFh7OVQ1Yym1dhKx0HLBXjDllr30elJVzWOmY/cvTe8=;
 b=ctZXPujXcSLebdECABi+7WOoBC+JGfqrU2W8Va7Ux3+nc4Qu8D73M1zXZU1OpwUThrRUX2YuFzisqbNVQGo2V3FTV5XehAoOTA0AF+mfXxPiTCdVbUoZLB2qgOcJJWHx5V9E/zau/4kGuwM2QWeTvLho7zHn/fqVxHZ4nCIto1w=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BYAPR10MB2935.namprd10.prod.outlook.com (2603:10b6:a03:8e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Thu, 16 Sep
 2021 21:21:09 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701%6]) with mapi id 15.20.4523.014; Thu, 16 Sep 2021
 21:21:09 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] vhost: use kernel_copy_process to check RLIMITs and
 inherit cgroups
Date: Thu, 16 Sep 2021 16:20:50 -0500
Message-Id: <20210916212051.6918-8-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916212051.6918-1-michael.christie@oracle.com>
References: <20210916212051.6918-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM5PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:3:12b::13) To BYAPR10MB3573.namprd10.prod.outlook.com
 (2603:10b6:a03:11e::32)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by
 DM5PR04CA0027.namprd04.prod.outlook.com (2603:10b6:3:12b::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 21:21:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7dcff968-f5f4-477c-31e2-08d97957e6f9
X-MS-TrafficTypeDiagnostic: BYAPR10MB2935:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB293541AD2F4CC32F645E5605F1DC9@BYAPR10MB2935.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9gngiYc8bWqcbsojJ9V1ejmJrc0FzzqXa2zUx+mhvvnjTU9kcSunzN5hMCKycBfRzqCfIuPjaxeAGFnvG1m0QCva/ayS0BjYAr/C3d6lo3VIrN37iZ4k4rAm4SrSpqMKDNWDiW7bJuY59OTx8M9TpMshh0HfJuDlNXghttinkZB06I5Q2laBKeLG8u/3vMGatdpueCchaOpiBABaCeo+oKEYMowTIKeEAKaQgnf2WboMQtYByjVceBdMykbGgVuL3OauMcZD5Gd+YyV8cVOnbF7L1Lz+MUaLuzwYbhMd6X6unJqcHCqDhXFl4IRtNXErWcWZAdePXWS030G/3joDhrqhUGcF4yr63bw2jqUIcC/LEeHOwtPb3uh1XFqNs6RjRY0FIHMGrVhNEYVFXsygikqw+0B59I47Vl7se5+cscsLSiHpaRmU/UFJwdLXtX8R6ZXbkJzfFMOQ/yvrz+O/c7Gh8azmaemJPmXRqrtAAJ96AnRMrJkecETfz67/N9FTV76qO42Wuhb/PuZvcDowCp+dyl4DBh8kDsI59tOuNL6AJtJW5063rUlT5B306w9OA81hf6AQ85wQEqBR4wiCo6rSrY3frhG6/uYX6Oyaxwxo/EHb3fqjASAZk8vHGqbnPWJsOGlmOHzg1HI+WYLmAw9g46I8eoIw998JCvJxD751B/C/n7/t1/YCW1uDDdGz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(316002)(86362001)(36756003)(26005)(107886003)(508600001)(8676002)(8936002)(66556008)(83380400001)(66946007)(5660300002)(6506007)(66476007)(4326008)(6486002)(2906002)(38100700002)(38350700002)(1076003)(52116002)(2616005)(6512007)(956004)(6666004)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WY2G7GAz5cSnnWf7aGedyryYjBJOXNSpDm7tJ9PX9YFQKObpwRmiBBIVnw5q?=
 =?us-ascii?Q?ZsWjbsdPxM6h/LXqeU6m5E8MgiXbqDAr+n/+PZfdbJee876G+6vFOTJz/Tsb?=
 =?us-ascii?Q?ZqEvd3A9wU8MnmUPdVsgI1YXNIIJcZHXEvTafFUtIoopWzep6d+cbwCuf1nV?=
 =?us-ascii?Q?OeDMGNOFZC+HVgh1ctJLOAFuUzwOyW8JKn09NdYpSLKWYSMGetsOOl4Ylogx?=
 =?us-ascii?Q?fTqLir+nGUpDO5rtcy2yvMo35GQ3/Jg/kf2A20Ff1gH95KL8L8cYBRYVgDc5?=
 =?us-ascii?Q?3FSJ9pSjUroKv6Za2uNR4r2bsJWglx3rHWLiuJPI18sPph8BMH1c0HyBV6Yx?=
 =?us-ascii?Q?GgRVl3eW114viAN6guFXmH8daSYimg1v9fNoW8avURhrdAzLmtqNM/B9ad3Q?=
 =?us-ascii?Q?W/1Wdsgdb0X46lYgcmLi/+jSvjNgyw521FdUTco+QCKPpPvxm1LIAUXOLpjN?=
 =?us-ascii?Q?xH4+f0u6a1V/VxUSbm1bi7FCBH8UFY95wtjk02/g1ECjzime422T9N+QQk0N?=
 =?us-ascii?Q?srjF4e1hIOfqgCouvDzFcUo+A4qSVHvZj/GwIQdAGnRmChRaSg3dURzOmE+j?=
 =?us-ascii?Q?jnGjlfpfAvxT5SqJ8rYRkYNM/eIgOgbnsQLN0PD2+dcicpb1guVZcsfgNXyM?=
 =?us-ascii?Q?JHlR0lpqt5teTFe+6tRLaB8v93CVvxXlUkU/Ae98wpA+mLDXbXd7UmHppJuM?=
 =?us-ascii?Q?4KYU1/48wMPzVKb6h5/IgpZb2Q4xMNN55S0JhpMG1apbPh4AxqFQT0wSEfrn?=
 =?us-ascii?Q?09bKNw+2vYd0Oycr6kBpeaw4iKs1lHQtEXq68lfEjWVzPOLXpsAzUQsADiwK?=
 =?us-ascii?Q?zKyc8tnlAuSmzjpVkpVGE1rOJELT+Y3bvH4Zq+c5ZAczChm0yOdHwNOskah5?=
 =?us-ascii?Q?XDLpihzVwM6F81qFdyC5R1mwtzhrW+M+K+m1xi8Sk4mat2Jul+cuT7pTga44?=
 =?us-ascii?Q?jTvHWEfl52MxFMKCcNZFWlJp/pZxQudamChQk2qT3Wtf7cSxmw3k4HZpxNK1?=
 =?us-ascii?Q?I6K91sfg/fAuVryuh2YzUzhYBMIp6ZF7J/cgxiYcQjzv2meARAbNv8qZymaF?=
 =?us-ascii?Q?Ms8K+8Ek7noXxob/eIqFvfHo6/Gg/nAzjJJ5HIGKZ909d6wPcwaZnrkzn0wS?=
 =?us-ascii?Q?P0NyyR6zi27tCDfZHhpU8OCPjiSfUO7ap7OMY3oCaodBkdxFaNf0aVQaHh6k?=
 =?us-ascii?Q?oyxLbtvHq8g4qm7aSQsNK9BLCwVwv3erW6X/ScmU2CsYAsQuSNum4xhJrT51?=
 =?us-ascii?Q?g7oNWoTgwIBLUoCxN9yxgzSDwzjRHOTd5Vhzkoz0CsGlAsGm7yVdk+yKXOnP?=
 =?us-ascii?Q?+rVUIjXfure/IBCJPg+xDInH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dcff968-f5f4-477c-31e2-08d97957e6f9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 21:21:09.7370 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7o1GAQobSH6WkMcm0R95s3fVwAvTLhSbK0tWD5iAdbd9VoU0iyuKOnBwfiGkQdX0t+JRvB7lVYcVlJypqMnZ2f1ZsnnuWVbEWOjXNXgwScM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2935
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10109
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109160122
X-Proofpoint-GUID: ToCXx3IM1C9QwO4wlMgkY7hWgsea6WZu
X-Proofpoint-ORIG-GUID: ToCXx3IM1C9QwO4wlMgkY7hWgsea6WZu
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

For vhost workers we use the kthread API which inherit's its values from
and checks against the kthreadd thread. This results in cgroups v2 not
working and the wrong RLIMITs being checked. This patch has us use the
kernel_copy_process function which will inherit its values/checks from the
thread that owns the device.

Note this patch converts us. The next patch will remove the code that is
no longer needed.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c | 49 +++++++++++++++++++++++++++----------------
 drivers/vhost/vhost.h |  7 ++++++-
 2 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index c9a1f706989c..6e58417b13fc 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -344,17 +344,14 @@ static void vhost_vq_reset(struct vhost_dev *dev,
 static int vhost_worker(void *data)
 {
 	struct vhost_worker *worker = data;
-	struct vhost_dev *dev = worker->dev;
 	struct vhost_work *work, *work_next;
 	struct llist_node *node;
 
-	kthread_use_mm(dev->mm);
-
 	for (;;) {
 		/* mb paired w/ kthread_stop */
 		set_current_state(TASK_INTERRUPTIBLE);
 
-		if (kthread_should_stop()) {
+		if (test_bit(VHOST_WORKER_FLAG_STOP, &worker->flags)) {
 			__set_current_state(TASK_RUNNING);
 			break;
 		}
@@ -376,8 +373,9 @@ static int vhost_worker(void *data)
 				schedule();
 		}
 	}
-	kthread_unuse_mm(dev->mm);
-	return 0;
+
+	complete(worker->exit_done);
+	do_exit(0);
 }
 
 static void vhost_vq_free_iovecs(struct vhost_virtqueue *vq)
@@ -579,6 +577,16 @@ static void vhost_detach_mm(struct vhost_dev *dev)
 	dev->mm = NULL;
 }
 
+static void vhost_worker_stop(struct vhost_worker *worker)
+{
+	DECLARE_COMPLETION_ONSTACK(exit_done);
+
+	worker->exit_done = &exit_done;
+	set_bit(VHOST_WORKER_FLAG_STOP, &worker->flags);
+	wake_up_process(worker->task);
+	wait_for_completion(worker->exit_done);
+}
+
 static void vhost_worker_free(struct vhost_dev *dev)
 {
 	struct vhost_worker *worker = dev->worker;
@@ -588,14 +596,16 @@ static void vhost_worker_free(struct vhost_dev *dev)
 
 	dev->worker = NULL;
 	WARN_ON(!llist_empty(&worker->work_list));
-	kthread_stop(worker->task);
+	vhost_worker_stop(worker);
 	kfree(worker);
 }
 
 static int vhost_worker_create(struct vhost_dev *dev)
 {
+	DECLARE_COMPLETION_ONSTACK(start_done);
 	struct vhost_worker *worker;
 	struct task_struct *task;
+	char buf[TASK_COMM_LEN];
 	int ret;
 
 	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
@@ -603,27 +613,30 @@ static int vhost_worker_create(struct vhost_dev *dev)
 		return -ENOMEM;
 
 	dev->worker = worker;
-	worker->dev = dev;
 	worker->kcov_handle = kcov_common_handle();
 	init_llist_head(&worker->work_list);
 
-	task = kthread_create(vhost_worker, worker, "vhost-%d", current->pid);
-	if (IS_ERR(task)) {
-		ret = PTR_ERR(task);
+	/*
+	 * vhost used to use the kthread API which ignores all signals by
+	 * default and the drivers expect this behavior. So we do not want to
+	 * ineherit the parent's signal handlers and set our worker to ignore
+	 * everything below.
+	 */
+	task = kernel_copy_process(vhost_worker, worker, NUMA_NO_NODE,
+				   CLONE_FS|CLONE_CLEAR_SIGHAND, 0, 1);
+	if (IS_ERR(task))
 		goto free_worker;
-	}
 
 	worker->task = task;
-	wake_up_process(task); /* avoid contributing to loadavg */
 
-	ret = vhost_attach_cgroups(dev);
-	if (ret)
-		goto stop_worker;
+	snprintf(buf, sizeof(buf), "vhost-%d", current->pid);
+	set_task_comm(task, buf);
+
+	ignore_signals(task);
 
+	wake_up_new_task(task);
 	return 0;
 
-stop_worker:
-	kthread_stop(worker->task);
 free_worker:
 	kfree(worker);
 	dev->worker = NULL;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 102ce25e4e13..09748694cb66 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -25,11 +25,16 @@ struct vhost_work {
 	unsigned long		flags;
 };
 
+enum {
+	VHOST_WORKER_FLAG_STOP,
+};
+
 struct vhost_worker {
 	struct task_struct	*task;
+	struct completion	*exit_done;
 	struct llist_head	work_list;
-	struct vhost_dev	*dev;
 	u64			kcov_handle;
+	unsigned long		flags;
 };
 
 /* Poll a file (eventfd or socket) */
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
