Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A03EB64D9
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 23:23:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B292D60625;
	Mon, 26 Jun 2023 23:23:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B292D60625
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=2H6zaTOw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=JNCGd82e
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JR2d4kMlopzm; Mon, 26 Jun 2023 23:23:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8B59161174;
	Mon, 26 Jun 2023 23:23:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8B59161174
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CAEB2C0093;
	Mon, 26 Jun 2023 23:23:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C25AFC0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9A2358196E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9A2358196E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=2H6zaTOw; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=JNCGd82e
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 45YkhxLJX-Mu
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9BA0A81773
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9BA0A81773
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:34 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35QMx1ht020739; Mon, 26 Jun 2023 23:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=+gu4ba6vgjHDbbw2g/ZcQK3dagv49GNTH6EALOJeZsY=;
 b=2H6zaTOwmTIywhPtG8IApQ5xJU1TEomLBB7MEqFaaJ60kq0Ywkj2JAOeIi5ngxGcRBro
 O6JTnmz5g3fQDcUUKtjrRiMCUyM5C0XLK7fmrP8tNtKkQ1Dh4mfkKlCecf0qGjYOCKg5
 Ps/4GcsO+wWylnpCEyjO5jTR1sbet/NfNXWHgke9IhywiREx7e7ruuclHzTq+cSimT+6
 15XLgA0L5tQABrujb2inB1KkJFDR1lAP4IF8vmSSnGk0yf3Q7PkFemjLAaJHZiD5gHX3
 MSnovHdf0QoGQpSsV1iDVALmIHxnaICA0L3ZjbsefAPbOvh8ydYlfe4qqGY4IifmMvP3 Hg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdrca3p1d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 23:23:33 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35QMRJZ5026359; Mon, 26 Jun 2023 23:23:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpxa88fr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 23:23:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0iyCjswxNLmJ0K7Oy1SV+yO+yTOEv6GcMKmNDQg0FGfG8TniqaeGVL8zVVTAiNnjhKGfmjrU2XV0XxACBb+wIhJKTraB9MCIWl0kN5ducZW7fKCHM3uELciP6BnRyBFNp62ccM5LStci4EmjFoEpS9uNEqcoQ3+ezX8ezihioLH0nnS29LwsZPRkNnRicrNT1I83Bb1VIWTwqUI9B26DToaASKqy5kuZSVRp9rNZL+/N8bmsVtbAU9Wcy6xjVfYOJM1mcAqs7rKX4u1V9uLMC1N/923jtVsUNSC6wZzbFzdyLt8/oAKXfczuxIqWKugGOWMCy9puVzQpx/frH7nig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+gu4ba6vgjHDbbw2g/ZcQK3dagv49GNTH6EALOJeZsY=;
 b=d5nz48woZKRyNUMcsyYC3rO3UWLLkwqm/DmMW3Jh0j/ozAGAQ/0QSD1iUncgn7CFISEem6NJJmq2W6YpxOWz/Y58qWcrdKvOuk+LBqesXnOFz15VYuxmfONJYGpfvIp+tEf9nj6ETv6xpsEwsVbZGIGIyTIywpX7M0S5t2M9Hfiv19tDFJ5MBT61vCe7fIFE5kR8FmnR7JJAJLXa4zR2jQFmSikleaG4Yccppz91gV/3XV57r8KRyoj3gA1biHZhOO/HKhkXO1IFKK6VIdx9rC/FPwFvA0JXtDNTR56NPJF9hOdK60LoOxfPkdk9GuaREQJ393VKAoeqlxT3ROxkug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+gu4ba6vgjHDbbw2g/ZcQK3dagv49GNTH6EALOJeZsY=;
 b=JNCGd82eEOePb4LiP1IHgDTGy8jMId3AHxaRf9KtlJwCyvdK/OsmazVMgfXl5n9mwnLeCvhJKJko6e7eMfyBlnYdPPoHYxI/5OvnFZembRyh5eIKnL9Tos15aodF29aqbkm7w8nyD4X88n2OV3LgdFjXpaSubCxDbqKurEOBJLk=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CY8PR10MB7377.namprd10.prod.outlook.com (2603:10b6:930:94::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 23:23:30 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa%4]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 23:23:30 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v9 13/17] vhost: add helper to parse userspace vring state/file
Date: Mon, 26 Jun 2023 18:23:03 -0500
Message-Id: <20230626232307.97930-14-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230626232307.97930-1-michael.christie@oracle.com>
References: <20230626232307.97930-1-michael.christie@oracle.com>
X-ClientProxiedBy: DS7PR03CA0305.namprd03.prod.outlook.com
 (2603:10b6:8:2b::25) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CY8PR10MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: b44d0d66-2540-48fe-020b-08db769c5a46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fx5jKYwsNU+rAqZABeiSMIbscRs6vt+Cc+mVBLortoq+lcIMk/x0yzSCjlZ1wgQeLXqzGVRR1ERzVqDTkCUQRNVXnKVsju76hXWJTxEQHfEaKt1imnoVdwytEHJxv8L8AgnHvBegTUpbMbERk0ieE8+tLXKvf4UhmeRXHFkX7M4CKcA1f2V7iBhTVkOC2slUw8ZiLI0k4/dDy83nTwliIFv8QbdX3A0A/V3uu7LILbeJ+mBP4E4WA1nFcCoz13yV6wQ3fdCgcb1uQuxdo0XQO1WGzuzhziYdIGDbLC24tU4SOdjcAAENpEH6Qq8yxYV9LgaxCSDVUz1v3yPNDagzwuV6cnczEF0/P5aNLBeI/9n7GU20zOOk9rMcuHngxz+5BswUJ+SVezIWPJSdc8oBQj3gXajkO8LuiTl5DDgEiXiLfjDfBAQ8NCZbtXT5UJ4jw78O/a3YPufrKxrOFnFuO6H3yEoQ4syond+tfstLJRx+6VwOcYhlOkkCAJptR4tYM7z+ll2qxAm3A+nrYhDVie7H6LVkFRfkZOK7GSdjmoNgHiMNhcf1Z7YoUd45FNpbEq33sx7tXDnKZo7O+IADFu75NGi6MNe7UmNULF16bfI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199021)(5660300002)(66946007)(66556008)(4326008)(66476007)(478600001)(36756003)(316002)(8676002)(8936002)(2906002)(86362001)(41300700001)(6486002)(186003)(6512007)(6506007)(1076003)(26005)(38100700002)(2616005)(107886003)(83380400001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?plMmyPq+0o/sYLGS5M4svvQB+EF/3OdiE/sRjXrO3Be3kdw96DXL7AcUTOxJ?=
 =?us-ascii?Q?uRPDpt0t1SRskTO5MLxEce3VVq0rEkGBr1q7wrZUEQC/zV7rvfD7PIDjHNpJ?=
 =?us-ascii?Q?ckgnEa/CUv8gEyTpmSGgfJVnkULzqDTlsBlmNGdxCpHTddOD+eGizoW4lw2x?=
 =?us-ascii?Q?CbTGi5Rj7iLuZBigVqTs8Htt0y5uC/ZmrbEEpA6+GdbiPFvrRyGxnu5Nawtu?=
 =?us-ascii?Q?K8Vo7Okga1jbffMFtlArW7gQfXrxYmtpGKJ6w65nkTSsozcBP2cc5ttpI5Dp?=
 =?us-ascii?Q?bwRC6UEmwiDavFZU2xr/IPMgRkfozyjDVBq2zQlWkpr3MLU4AlPLbzJDLccF?=
 =?us-ascii?Q?iCzlTsD/fpiv5+ylHmU3p1GhXYf3kGwcjF5ePR4gH7gPh/nHmPiG7Nb3rCVV?=
 =?us-ascii?Q?DIaPceUYMjBtW+3LtGsoRIJkGSkSrjLwj8HutXCVULZlr7k7r/2dqYHOMms0?=
 =?us-ascii?Q?sT5un78dFG7efkHshxdmD0c7cNX533ArUlMPjoHnHO5HqlVIec3dWqHycnKX?=
 =?us-ascii?Q?ZaOrjOn8cJDkav4WZEHi5QVVDemyFCwAiMgUN3Buaa+EiHdFJejawWG8096D?=
 =?us-ascii?Q?6nspku5/Rhmg5eG9sHs4ZWax+cnCQ8JtoUD54+az0tad3u7UAen4JM+xSNfZ?=
 =?us-ascii?Q?Tix9+9vfAFjjcjU/210o5pRvQKtezOALTBzfczwFems8LfOfYOPOFTG96mhV?=
 =?us-ascii?Q?tIHQq3TJzRX7pDQAMlEGgLM94NWWddV8XOxywyw6ld8+KwR5b2v/405KmhST?=
 =?us-ascii?Q?r7a8XVPUHotVNOwb0MwlLJR0hD8xf8ZeO5zg6lvISzcysUOxjniw9dn7CWjA?=
 =?us-ascii?Q?wOobz72lqz6nXYgbFhWJgY5ingjzDYyqijtObITqvSQE+hvaxYOFXaGKmCQQ?=
 =?us-ascii?Q?oRvuLB5QJkLDUaCGw/rU5K4i/G8ZMo9tpWPuLYMkexghNyiazVQkyasilfue?=
 =?us-ascii?Q?u0O3nMg5toJHnxxSDQryocCHXuv8i2kft0LAF8FY02WggUJyWGIt1zt/SZ4r?=
 =?us-ascii?Q?CK7X28DPMg2DA/GeM0LMzPvg6mzJlWAw8YRXoxCHos4YBauEjC3eRg0iYaJ7?=
 =?us-ascii?Q?wSS8Zs2d7IQxFxNUcMzOWq/wz2AcdZ9IogoNL+KSkFw7W2vJ6y0XSwfVsu3w?=
 =?us-ascii?Q?GWPmJK4ftaGEbDL9Y0DHFYCQTe9PbQYDQWIKWe0pkshFa3EfGfu/dAn/1MCi?=
 =?us-ascii?Q?RrfKi2QcIQTbTq0vFO7LIlDpoKCKRLhZpmsqp4xxrEHxurfyjuOcpGeu/r6U?=
 =?us-ascii?Q?I07u88wgYq1N5k3nvLRappGf9bcS6TYdJMxLqJeTzEhv2tRDxv29j2E71In5?=
 =?us-ascii?Q?Z95/rVyldIaaD1xjn996Iog2kvfVmm1T1FdUjFTY6fexUdRnqNcppqvg1SMf?=
 =?us-ascii?Q?4Bc62N1z4VRr9rgPpVd4bpvwZl8dZenkyD50dNzxeUZEVpJgk3fDAs73m9OG?=
 =?us-ascii?Q?d3Ld0RPJXYeT5uxx0/kGkPsJmawl0eQsR8vZFH6vO6kCZjmN0F9YEB2bHsZD?=
 =?us-ascii?Q?VwHH/XLAwZU31W9bAgnF5nBLa8D/D+wDFf9iqbxCZz7t9BqT/3MX+VU5Ps24?=
 =?us-ascii?Q?XO08YedYg9sYrqOlpH8PMB28VyU8SpKsXo4KSXzRPEW6iG6POELqm/DxUh3G?=
 =?us-ascii?Q?+A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7/oRHpJ5HXbN8HFS8XiV8BpX/eNOerZstToaWWcGn2xt4CyT3Jl77KHvcwAGojMNreZ4puN2JCl1uqYrgEsUEtNO3EKfo/aJnzA8rwGh3F6yuZb3SiUZQ4vHlr4tETYzl8XF9xjTjaLDmJVqnzOHrmKu/ieQusSTL2i2wB3v7MN8QYE6b5oGdJJHEAQO/HwPAQMPmoaVkmCh2qPEZ6GIuW0FURYtskSdlYAowrc+Vpm8k/gp6cAEUd+zas2tC3HSlvGaVS4obx5t7wEUojqS0qenb/yvZDsz3S4CL80m7A8IM7Ja27gfkT66I5nhzsxTO/lgByDsGUBud5SAjiG8e22Hk6Z5q48Ufff8acHjM3ILZgXWtPT/lsB0bA1XQSXLh0+Xlc3QyicwyzgvFb3JVpaUc5F5U0k2c/s4fto4FxYJZixH+EtuM8WvJtcXnXvCGa59cQ5vQJB7Quo0dQ9N44Ffnri3nU3hYF3+YxzHAUomCk4069WHuSGJ+iqttAReaMF4pObKVrFDttMs3nTWNTXcK6tbSMtiYwjjK2L/epccpG5KPuqtMqLkRTAI5A8AIzqeceANxzWOgFs+/Qfz/PHkzor/oUQfKAVt5hoh4Sw3PeoLvSCkJJt/B2ud7XDLCPooE7IPml4FNSYjB8+5M82bsssxY933odJ6CQcteuBr78mu2+KsRlrmF3TiQpl4HVdB0V9T1AO1tbif4FOHNzl0k+O6GqneGQa3RmY04nvWq2QhAhhjGMviFgbUYoAO1LaDuhJs17wvIaz1l0AokB+bWVRffOjHz7dgKsO0VI3C+DXsk2WaMSjzaqKJBag1
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b44d0d66-2540-48fe-020b-08db769c5a46
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 23:23:30.5307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WgGSx0kscY53iHueuedFpn3EOQZG+TyXE3Mp1Hvtsf4/vHdpZWUcDa8/kYWWL6DNTROgbmGiiC2DtQdJji4BSEMFzw8+8Xa7rWMJKkdvnic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7377
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_18,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306260218
X-Proofpoint-ORIG-GUID: 3fLCzEclFbkKfX333Yp0cCpVPA8E5Z1W
X-Proofpoint-GUID: 3fLCzEclFbkKfX333Yp0cCpVPA8E5Z1W
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

The next patches add new vhost worker ioctls which will need to get a
vhost_virtqueue from a userspace struct which specifies the vq's index.
This moves the vhost_vring_ioctl code to do this to a helper so it can
be shared.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 6cadbc6e6d11..12203d3893c5 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -599,6 +599,27 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 	return NULL;
 }
 
+static int vhost_get_vq_from_user(struct vhost_dev *dev, void __user *argp,
+				  struct vhost_virtqueue **vq, u32 *id)
+{
+	u32 __user *idxp = argp;
+	u32 idx;
+	long r;
+
+	r = get_user(idx, idxp);
+	if (r < 0)
+		return r;
+
+	if (idx >= dev->nvqs)
+		return -ENOBUFS;
+
+	idx = array_index_nospec(idx, dev->nvqs);
+
+	*vq = dev->vqs[idx];
+	*id = idx;
+	return 0;
+}
+
 /* Caller should have device mutex */
 long vhost_dev_set_owner(struct vhost_dev *dev)
 {
@@ -1618,21 +1639,15 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 	struct file *eventfp, *filep = NULL;
 	bool pollstart = false, pollstop = false;
 	struct eventfd_ctx *ctx = NULL;
-	u32 __user *idxp = argp;
 	struct vhost_virtqueue *vq;
 	struct vhost_vring_state s;
 	struct vhost_vring_file f;
 	u32 idx;
 	long r;
 
-	r = get_user(idx, idxp);
+	r = vhost_get_vq_from_user(d, argp, &vq, &idx);
 	if (r < 0)
 		return r;
-	if (idx >= d->nvqs)
-		return -ENOBUFS;
-
-	idx = array_index_nospec(idx, d->nvqs);
-	vq = d->vqs[idx];
 
 	if (ioctl == VHOST_SET_VRING_NUM ||
 	    ioctl == VHOST_SET_VRING_ADDR) {
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
