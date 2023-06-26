Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A65EB64D7
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 23:23:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 52E9D80A4A;
	Mon, 26 Jun 2023 23:23:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 52E9D80A4A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=NaIbDZwT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=Dp2smPpf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zmTYyXXk1nJY; Mon, 26 Jun 2023 23:23:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F3F8E813DE;
	Mon, 26 Jun 2023 23:23:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F3F8E813DE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA390C0037;
	Mon, 26 Jun 2023 23:23:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B38FEC0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7FE22408AF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7FE22408AF
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=NaIbDZwT; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=Dp2smPpf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id amPJUhUnKhFF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D1F1B41816
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D1F1B41816
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:43 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35QMiQNP001846; Mon, 26 Jun 2023 23:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=vPdTECY9uP3svzwXs8hyrvy4+1eNV5Dq+ekDQb9pflc=;
 b=NaIbDZwTfIY6Z6dKjCW27HwtUQYApkMR+baOZ3GKnRgyNGYuM8DZMtlxbKesX+E49q0A
 GFeEC+xVjn4kwsAUBlne2TUFNmOGDbxUw1AT0i5otVXJ/iKS9wpYy5CdOBd2dnRihIyd
 WLPunICrKJjGSZeKFmTtaSQdWR4+cZj+Kzb27lu4YSML6+T8jikSxL5bWgVsCAVM7frn
 oMMm5vSu7mhEr90w3bc41fS9hrh54jGlqHTHj++he+G6B/HdAYsjnYiHyYiAxdJGDp0i
 vEakZiBFYrW7j1Q004+refCUzH4MoFIkkAcoFaV+SkNyHDfjW+4PET+jijmxPE/sQxVA FQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdrca3p1k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 23:23:42 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35QMFuhJ005110; Mon, 26 Jun 2023 23:23:40 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx9rj55-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 23:23:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0fOg6NlcmSUzaAMO2TLGHdJWasMflfYY9M3pEkjrsaPgDo2X9i3V3kpEduIhrHgP+BwsY1y+c9Fx17yBa2E5vs1IqIA0nTfCgCUXV7HQYUPukq15cT0UaUU1vySH6GersG7CgiUW6Aqirdx+pA04+oQM9zkoTV3z2RrSmJX9QXcvlOatqCnvOXukwaApNVfvq2xgq07db4Fqgd9zPEAcBVZTdhc8XabkdB+aWK+bTlyCug4zswi4ovAyiWTa3wtp9sbnV+3qXUqBpAtxypg5boDRHiuDo6hK+bzbhrJbIkSWdguOZpK4IRqCSN6z2fzjqqxWYvcxLjk7R4pG2umkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPdTECY9uP3svzwXs8hyrvy4+1eNV5Dq+ekDQb9pflc=;
 b=g5nxMpDnIxUZlopjkoVveUg32ApLtwU2Z1QICvd/X1WgTQjk2RU4wYCIsiFfa2D7SLJYU0T7yF0WalD9J/st8SBT+s/2qkF2RPfvEI4VvoEOnJah+/17mTNGmDEWuQmqsThbHf2o38Y+5EDthwzJwc5BmIg34SLrshNHUVqskDSAWlTcyPUh3FXgm1KROtdblZ6S8zVMdIQ72cXkjDDLNAUwkPk63ENdk2D/xWEp4n6I66/F0CMmVs2zl9bg3frNe/ZoJxDnQx1omOgzt/7NuZTAl4ITi1YklF9jUZo845bIb6nJosXwdmEVYbz/9aGOM7tB9qS7HI2aM117iAO05g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPdTECY9uP3svzwXs8hyrvy4+1eNV5Dq+ekDQb9pflc=;
 b=Dp2smPpfxpkkkfXBdhED8aPscIgxx+dSRE0+/5bnrkmhGILSFTLpwShnCE5iSX498m7wBDDVzOeMunp/j7BD4VgIGFNuW1G36yVUDCxn0vO93gCwenq+vG7AFvdKzEMfr4lmjIIDH4wVlv3w6ZCUVj6AHwpvMw9P/3eLQfv1BVM=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by SJ2PR10MB7037.namprd10.prod.outlook.com (2603:10b6:a03:4c5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Mon, 26 Jun
 2023 23:23:37 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa%4]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 23:23:37 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v9 17/17] vhost: Allow worker switching while work is queueing
Date: Mon, 26 Jun 2023 18:23:07 -0500
Message-Id: <20230626232307.97930-18-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230626232307.97930-1-michael.christie@oracle.com>
References: <20230626232307.97930-1-michael.christie@oracle.com>
X-ClientProxiedBy: DS7PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:5:3b8::14) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|SJ2PR10MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: affbd275-3933-440b-67ab-08db769c5e1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IPvLdTiK/xjY2jEvCWhPbLP0sUy02bIGYNB/q4WNih34l1uItKZfa9RMX9NYW+LBP1JkwQIBVPDD0h1eqJmOxg+ikx4DKjBkdvexXc+ciPkUYfFiu5bmc8GAKI2LullL0qx0k9RwaxqEL/pd1zQjmk4MSUlRM/mlov7XSgEWOKYqIRiV6Zur9hoQcDjKgdJvXNM6lSuROyTURv4afGDtt/9zOOPDjWAtg+XDls54OuBRD7Pe83lYQb7IAuoDIhEb+8pIj8HbuqIAZErVDDW9CFAN49SJFlhEomHvi0Xu/FRikr1Iro3Y8Q7a9tuo8n8motby7ri4BdM1YDdox+aiVM6fj8q/jTThvwGHwmOnF4/7RyCcJrdajObZg/LbRcS9xaDeL/xrHUfHJkGmauGxh/yDrO1dZAd7QlXpJivQA0j7yfPMdtbbSDK0BRM2kMRInJ66qh7MfgNe1sDOaYGdBQ9RHGXoyNFil/JtMNJTlATmzPzja2/g5bVfrxnlf3eh6w6B9IphGdwTiBz5689VES+V/T3MWGYw4XiaGuA68LJzIdg2YYBHd0eRE2GA4jTR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199021)(5660300002)(66946007)(66556008)(4326008)(66476007)(478600001)(36756003)(316002)(8676002)(8936002)(2906002)(30864003)(86362001)(41300700001)(6486002)(186003)(6512007)(6506007)(1076003)(26005)(38100700002)(2616005)(107886003)(83380400001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XQUcO2V01GKQbqbuq7Avd5r9bIsvHXydLSJ22dmYaAmJG8agXkdtVElvajSK?=
 =?us-ascii?Q?yTf43mrZcx9fy3DYKb4Egp9TH9nu3DtqBYs82fM+PFD3KtDMdV+GVebIaceJ?=
 =?us-ascii?Q?UtBSqnJF+U6CK4VnnKJtReMa3GVFbnIUfFGFKOnW7dQGrcQpZr/83q7caCK1?=
 =?us-ascii?Q?z4gphV8msWkQe/ImyOi3N+PbXwybbwQ8kZ+GOfF3MWHK3O4YwwRqOai4/P3M?=
 =?us-ascii?Q?CNxlpWu9wZNg935M6k4Gv7NFlozHnIhAj44mA2jVRfw/HyU6O3QhRb8mThgf?=
 =?us-ascii?Q?S6JG+ho4vsaUmV/ZFBr/Sv7OasXEYaff+4+JRUGoP5byAUsFgVi5T5Jy66gp?=
 =?us-ascii?Q?JXqMn1fnzViuC0aOrAcPleYfSzE8/c2rSIkKWVyvE69bd3biiAXWGaoCKtep?=
 =?us-ascii?Q?8ys1cjYI34Ezc5FAoCTUjhaVMPAUWwvbhYJNeROotXjmj/kKfGN51k9TMWfc?=
 =?us-ascii?Q?DeWogK+g9DXp//x8noowy9WeE3IONyOmpiHVmu1WjuWzsO+AXvE+9MYGEEV2?=
 =?us-ascii?Q?2kTOk8PiaRjw6ZIo5KL2SebQ41cP/AazF8YIou5rHp2afC8up2WGX2FIEOvP?=
 =?us-ascii?Q?9uhmII5h80QNQT/kN+UjiNMH3QqmiQN6egKmM2gro6SWhAuI+qVE6X0VbuZD?=
 =?us-ascii?Q?5+CxSL1N4265JxpSjl/qdeviNeiln0Wl3obLlIzwnp3bZ9nmW1HaSSQF9gz6?=
 =?us-ascii?Q?cluQKUdFifm+vSeIhCPjdu6d+QcMTqifjYSKWih1tpFLPyF5iRxfiM6ToHff?=
 =?us-ascii?Q?llz1usDIVjRiQbX93Xs5rVynTR6tWg0x5Lwv5ted0BsLhPxikgm7zCWNHeQq?=
 =?us-ascii?Q?WhduJ00BtSJ82HlrzUjd45gcEnDejwBnDqZF9nz+BhADYLX6GD/kFGAQMPK2?=
 =?us-ascii?Q?aEpKb37rp0wCreYhhKi+gc59wMuGHFh57cgiiyKR4/Erhs6Kdwjoa1U1+wsP?=
 =?us-ascii?Q?YdoChHldOlltKRNx0RFGTXI9CzE9XDvZX36Xqtzm0b1XqbNcMSDKpHHGFku6?=
 =?us-ascii?Q?qhfR/PisaKL9Ft5SV4pj5MzWG7fSzsVnKWpePJvgXPkRJ432xCUMbvrTbNdi?=
 =?us-ascii?Q?hBNiYPfJeVWNbeksODfQhcOwdeZTcEsjyhXo7+99xU6CKI0/Dqg5LYa4zeEH?=
 =?us-ascii?Q?6u6qzMFwfEYYrgvA4p2g8O+7O9Hf7kpUqAYDbNBDWAtZDCsgNibr51XwJJxY?=
 =?us-ascii?Q?EPR8JIJtlVevYlqkTHEdYDzcB1FkyuPcpL1FwIKn1vwTIoK90NzsUKT/7PYF?=
 =?us-ascii?Q?Y0zasJcM7VGyrdoJhuJZXiyuM20Xj2M0vYRYE3eyNiVH/xvp05H0MMF86tMg?=
 =?us-ascii?Q?10vaEnGmOU5sZxOLSfqCfnLQAzBcrrQRY4+N4pVMedzVwVyAt6Dh5c88lsYr?=
 =?us-ascii?Q?isQzrkkMJbWe3+Rdc7cg71PCZ8C/BY2yhqMkbmeBNiPknQ+ax5LYLmHUpTXo?=
 =?us-ascii?Q?JjEyY6SFXbfCQtu1TlV1dUn2yrWdv+JRlqiFx2U8u78JhvrsDHLqVMPM1xAh?=
 =?us-ascii?Q?2UfKIPdZOELY4xKpPzblaSclVgM9tkNOzvDtiDCn7++Gi5hF0GRFYCGVP2bt?=
 =?us-ascii?Q?iH0Nxc7D3Lvk5NrCwWRI2ufcpZjXtkMORvK0alGlHXJLiycM/Z7TqtfLUduf?=
 =?us-ascii?Q?TA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Iicnnnbi+7B0i2kqjWfppLk9Ze7Tty/9KQOH5yGdp2DPqrmkcTv8iucQm2OKBChloENr/KCutINXuVNN5r8nhinqWJpeE6hA6mXEMwW2tl1W/Q1qpl1ZYPw4chjsIXp3LHTyFFDOFzZ4jolR0HgRSR/ulsLZLxRGf5IR4inmuYpCo+gWHNzv5tODHdiAMIEiKTq77dMxYDubjj0zSGwmRd+VmOMeLTez9cf10AbQqfZO9DGc/hhg1JB60NNywLm5kG19qyKYkRXrnB74rYq0LtZCEA8ZiLnDCpIF7p3K0q0R4Hg4d+afBvl1EZPPnPhxKf64m5QOb4ZjsTCN2c1aBq9Cno6HppSFsIz5/T1UBiV6MMuaklzSmtvRBKZc2bM7bMxzB1UuIGK9D0SNHclkvPi7/+Yj6c6eJQmoJ+puzCNNDunId+u05iEB1ZLcV44VjwSPcFhBKWwmEG5ywXJrozn4Eiqbhr7VL2KwJPjEo7COKno++eK0vuqxWbjJzSHPYgu3WiT44rvIcrQEEXywo30M4U9gprnXrPKZqGEZd9MRSg0reZ0MijX8vlFRHzL3juyMeuhFKdVOoVrlHhoruohpXW9PK72fEpxLJKHMQhEbUOxJsxFjOXOoJB+TeFpxdL2TrT1u/rZTUL+kbVy5ZLkgX60Lpfk/A4JCHhXiGtDtkzR4iIEr9bH5L8UtciSxbZV6nGAWIYztfQSO0hT5gDgLoEw0DvtUkR6WEl/1LUcxZFDvjTtTRUsMI2brGJ4ICqCKrkeZMGE4Iye8B5ppmj008rBC8auj3ZZy0PP/QBpPNDDrzw/cd6WT9MwGXEbA
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: affbd275-3933-440b-67ab-08db769c5e1c
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 23:23:36.9856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ul4Cddps1sbgl2aWzzMrcy9yHoKy4fdTYpDH/DjP0yDSVse3fJCOpgPQ3PPYSUbbvpdoNAVK4oc1nr99MED7tNNS7KoSzaXcJ8nBLnEajD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7037
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_18,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306260218
X-Proofpoint-ORIG-GUID: EfJAY01kJvitTb_27NWFaWJG3CgBPyGU
X-Proofpoint-GUID: EfJAY01kJvitTb_27NWFaWJG3CgBPyGU
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

This patch drops the requirement that we can only switch workers if work
has not been queued by using RCU for the vq based queueing paths and a
mutex for the device wide flush.

We can also use this to support SIGKILL properly in the future where we
should exit almost immediately after getting that signal. With this
patch, when get_signal returns true, we can set the vq->worker to NULL
and do a synchronize_rcu to prevent new work from being queued to the
vhost_task that has been killed.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c      | 153 +++++++++++++++++++++++++++----------
 drivers/vhost/vhost.h      |   4 +-
 include/uapi/linux/vhost.h |   4 +-
 3 files changed, 115 insertions(+), 46 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index bfba91ecbd0a..c71d573f1c94 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -233,16 +233,9 @@ void vhost_poll_stop(struct vhost_poll *poll)
 }
 EXPORT_SYMBOL_GPL(vhost_poll_stop);
 
-static bool vhost_worker_queue(struct vhost_worker *worker,
+static void vhost_worker_queue(struct vhost_worker *worker,
 			       struct vhost_work *work)
 {
-	if (!worker)
-		return false;
-	/*
-	 * vsock can queue while we do a VHOST_SET_OWNER, so we have a smp_wmb
-	 * when setting up the worker. We don't have a smp_rmb here because
-	 * test_and_set_bit gives us a mb already.
-	 */
 	if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
 		/* We can only add the work to the list after we're
 		 * sure it was not in the list.
@@ -251,47 +244,85 @@ static bool vhost_worker_queue(struct vhost_worker *worker,
 		llist_add(&work->node, &worker->work_list);
 		vhost_task_wake(worker->vtsk);
 	}
-
-	return true;
 }
 
 bool vhost_vq_work_queue(struct vhost_virtqueue *vq, struct vhost_work *work)
 {
-	return vhost_worker_queue(vq->worker, work);
+	struct vhost_worker *worker;
+	bool queued = false;
+
+	rcu_read_lock();
+	worker = rcu_dereference(vq->worker);
+	if (worker) {
+		queued = true;
+		vhost_worker_queue(worker, work);
+	}
+	rcu_read_unlock();
+
+	return queued;
 }
 EXPORT_SYMBOL_GPL(vhost_vq_work_queue);
 
-static void vhost_worker_flush(struct vhost_worker *worker)
+void vhost_vq_flush(struct vhost_virtqueue *vq)
 {
 	struct vhost_flush_struct flush;
 
 	init_completion(&flush.wait_event);
 	vhost_work_init(&flush.work, vhost_flush_work);
 
-	if (vhost_worker_queue(worker, &flush.work))
+	if (vhost_vq_work_queue(vq, &flush.work))
 		wait_for_completion(&flush.wait_event);
 }
+EXPORT_SYMBOL_GPL(vhost_vq_flush);
 
-void vhost_vq_flush(struct vhost_virtqueue *vq)
+/**
+ * vhost_worker_flush - flush a worker
+ * @worker: worker to flush
+ *
+ * This does not use RCU to protect the worker, so the device or worker
+ * mutex must be held.
+ */
+static void vhost_worker_flush(struct vhost_worker *worker)
 {
-	vhost_worker_flush(vq->worker);
+	struct vhost_flush_struct flush;
+
+	init_completion(&flush.wait_event);
+	vhost_work_init(&flush.work, vhost_flush_work);
+
+	vhost_worker_queue(worker, &flush.work);
+	wait_for_completion(&flush.wait_event);
 }
-EXPORT_SYMBOL_GPL(vhost_vq_flush);
 
 void vhost_dev_flush(struct vhost_dev *dev)
 {
 	struct vhost_worker *worker;
 	unsigned long i;
 
-	xa_for_each(&dev->worker_xa, i, worker)
+	xa_for_each(&dev->worker_xa, i, worker) {
+		mutex_lock(&worker->mutex);
+		if (!worker->attachment_cnt) {
+			mutex_unlock(&worker->mutex);
+			continue;
+		}
 		vhost_worker_flush(worker);
+		mutex_unlock(&worker->mutex);
+	}
 }
 EXPORT_SYMBOL_GPL(vhost_dev_flush);
 
 /* A lockless hint for busy polling code to exit the loop */
 bool vhost_vq_has_work(struct vhost_virtqueue *vq)
 {
-	return !llist_empty(&vq->worker->work_list);
+	struct vhost_worker *worker;
+	bool has_work = false;
+
+	rcu_read_lock();
+	worker = rcu_dereference(vq->worker);
+	if (worker && !llist_empty(&worker->work_list))
+		has_work = true;
+	rcu_read_unlock();
+
+	return has_work;
 }
 EXPORT_SYMBOL_GPL(vhost_vq_has_work);
 
@@ -356,7 +387,7 @@ static void vhost_vq_reset(struct vhost_dev *dev,
 	vq->busyloop_timeout = 0;
 	vq->umem = NULL;
 	vq->iotlb = NULL;
-	vq->worker = NULL;
+	rcu_assign_pointer(vq->worker, NULL);
 	vhost_vring_call_reset(&vq->call_ctx);
 	__vhost_vq_meta_reset(vq);
 }
@@ -578,7 +609,7 @@ static void vhost_workers_free(struct vhost_dev *dev)
 		return;
 
 	for (i = 0; i < dev->nvqs; i++)
-		dev->vqs[i]->worker = NULL;
+		rcu_assign_pointer(dev->vqs[i]->worker, NULL);
 	/*
 	 * Free the default worker we created and cleanup workers userspace
 	 * created but couldn't clean up (it forgot or crashed).
@@ -606,6 +637,7 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 	if (!vtsk)
 		goto free_worker;
 
+	mutex_init(&worker->mutex);
 	init_llist_head(&worker->work_list);
 	worker->kcov_handle = kcov_common_handle();
 	worker->vtsk = vtsk;
@@ -630,13 +662,54 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 static void __vhost_vq_attach_worker(struct vhost_virtqueue *vq,
 				     struct vhost_worker *worker)
 {
-	if (vq->worker)
-		vq->worker->attachment_cnt--;
+	struct vhost_worker *old_worker;
+
+	old_worker = rcu_dereference_check(vq->worker,
+					   lockdep_is_held(&vq->dev->mutex));
+
+	mutex_lock(&worker->mutex);
 	worker->attachment_cnt++;
-	vq->worker = worker;
+	mutex_unlock(&worker->mutex);
+	rcu_assign_pointer(vq->worker, worker);
+
+	if (!old_worker)
+		return;
+	/*
+	 * Take the worker mutex to make sure we see the work queued from
+	 * device wide flushes which doesn't use RCU for execution.
+	 */
+	mutex_lock(&old_worker->mutex);
+	old_worker->attachment_cnt--;
+	/*
+	 * We don't want to call synchronize_rcu for every vq during setup
+	 * because it will slow down VM startup. If we haven't done
+	 * VHOST_SET_VRING_KICK and not done the driver specific
+	 * SET_ENDPOINT/RUNNUNG then we can skip the sync since there will
+	 * not be any works queued for scsi and net.
+	 */
+	mutex_lock(&vq->mutex);
+	if (!vhost_vq_get_backend(vq) && !vq->kick) {
+		mutex_unlock(&vq->mutex);
+		mutex_unlock(&old_worker->mutex);
+		/*
+		 * vsock can queue anytime after VHOST_VSOCK_SET_GUEST_CID.
+		 * Warn if it adds support for multiple workers but forgets to
+		 * handle the early queueing case.
+		 */
+		WARN_ON(!old_worker->attachment_cnt &&
+			!llist_empty(&old_worker->work_list));
+		return;
+	}
+	mutex_unlock(&vq->mutex);
+
+	/* Make sure new vq queue/flush/poll calls see the new worker */
+	synchronize_rcu();
+	/* Make sure whatever was queued gets run */
+	vhost_worker_flush(old_worker);
+	mutex_unlock(&old_worker->mutex);
 }
 
- /* Caller must have device and virtqueue mutex */
+ /* Caller must have device mutex */
 static int vhost_vq_attach_worker(struct vhost_virtqueue *vq,
 				  struct vhost_vring_worker *info)
 {
@@ -647,15 +720,6 @@ static int vhost_vq_attach_worker(struct vhost_virtqueue *vq,
 	if (!dev->use_worker)
 		return -EINVAL;
 
-	/*
-	 * We only allow userspace to set a virtqueue's worker if it's not
-	 * active and polling is not enabled. We also assume drivers
-	 * supporting this will not be internally queueing works directly or
-	 * via calls like vhost_dev_flush at this time.
-	 */
-	if (vhost_vq_get_backend(vq) || vq->kick)
-		return -EBUSY;
-
 	worker = xa_find(&dev->worker_xa, &index, UINT_MAX, XA_PRESENT);
 	if (!worker || worker->id != info->worker_id)
 		return -ENODEV;
@@ -689,8 +753,12 @@ static int vhost_free_worker(struct vhost_dev *dev,
 	if (!worker || worker->id != info->worker_id)
 		return -ENODEV;
 
-	if (worker->attachment_cnt)
+	mutex_lock(&worker->mutex);
+	if (worker->attachment_cnt) {
+		mutex_unlock(&worker->mutex);
 		return -EBUSY;
+	}
+	mutex_unlock(&worker->mutex);
 
 	vhost_worker_destroy(dev, worker);
 	return 0;
@@ -723,6 +791,7 @@ long vhost_worker_ioctl(struct vhost_dev *dev, unsigned int ioctl,
 {
 	struct vhost_vring_worker ring_worker;
 	struct vhost_worker_state state;
+	struct vhost_worker *worker;
 	struct vhost_virtqueue *vq;
 	long ret;
 	u32 idx;
@@ -760,7 +829,6 @@ long vhost_worker_ioctl(struct vhost_dev *dev, unsigned int ioctl,
 	if (ret)
 		return ret;
 
-	mutex_lock(&vq->mutex);
 	switch (ioctl) {
 	case VHOST_ATTACH_VRING_WORKER:
 		if (copy_from_user(&ring_worker, argp, sizeof(ring_worker))) {
@@ -771,8 +839,15 @@ long vhost_worker_ioctl(struct vhost_dev *dev, unsigned int ioctl,
 		ret = vhost_vq_attach_worker(vq, &ring_worker);
 		break;
 	case VHOST_GET_VRING_WORKER:
+		worker = rcu_dereference_check(vq->worker,
+					       lockdep_is_held(&dev->mutex));
+		if (!worker) {
+			ret = -EINVAL;
+			break;
+		}
+
 		ring_worker.index = idx;
-		ring_worker.worker_id = vq->worker->id;
+		ring_worker.worker_id = worker->id;
 
 		if (copy_to_user(argp, &ring_worker, sizeof(ring_worker)))
 			ret = -EFAULT;
@@ -782,7 +857,6 @@ long vhost_worker_ioctl(struct vhost_dev *dev, unsigned int ioctl,
 		break;
 	}
 
-	mutex_unlock(&vq->mutex);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(vhost_worker_ioctl);
@@ -817,11 +891,6 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 			err = -ENOMEM;
 			goto err_worker;
 		}
-		/*
-		 * vsock can already try to queue so make sure the worker
-		 * is setup before vhost_vq_work_queue sees vq->worker is set.
-		 */
-		smp_wmb();
 
 		for (i = 0; i < dev->nvqs; i++)
 			__vhost_vq_attach_worker(dev->vqs[i], worker);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 039be5d56867..f60d5f7bef94 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -28,6 +28,8 @@ struct vhost_work {
 
 struct vhost_worker {
 	struct vhost_task	*vtsk;
+	/* Used to serialize device wide flushing with worker swapping. */
+	struct mutex		mutex;
 	struct llist_head	work_list;
 	u64			kcov_handle;
 	u32			id;
@@ -76,7 +78,7 @@ struct vhost_vring_call {
 /* The virtqueue structure describes a queue attached to a device. */
 struct vhost_virtqueue {
 	struct vhost_dev *dev;
-	struct vhost_worker *worker;
+	struct vhost_worker __rcu *worker;
 
 	/* The actual ring of buffers. */
 	struct mutex mutex;
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index 96dc146c2d15..f5c48b61ab62 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -90,9 +90,7 @@
 #define VHOST_SET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x13, struct vhost_vring_state)
 #define VHOST_GET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x14, struct vhost_vring_state)
 /* Attach a vhost_worker created with VHOST_NEW_WORKER to one of the device's
- * virtqueues. This must be done before VHOST_SET_VRING_KICK and the driver
- * specific ioctl to activate the virtqueue (VHOST_SCSI_SET_ENDPOINT,
- * VHOST_NET_SET_BACKEND, VHOST_VSOCK_SET_RUNNING) has been run.
+ * virtqueues.
  *
  * This will replace the virtqueue's existing worker. If the replaced worker
  * is no longer attached to any virtqueues, it can be freed with
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
