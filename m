Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B381C88CB4
	for <virtualization@archiver.kernel.org>; Tue, 13 Jun 2023 01:33:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 40A2D40AA1;
	Tue, 13 Jun 2023 01:33:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 40A2D40AA1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=XDecMMrO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=MGNQhNqb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A1UoIdisj1u8; Tue, 13 Jun 2023 01:33:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 81CC440990;
	Tue, 13 Jun 2023 01:33:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 81CC440990
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19CFEC0094;
	Tue, 13 Jun 2023 01:33:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4DBF5C0093
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1D367408B4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1D367408B4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TUWchreaPi_2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6A59640607
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6A59640607
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:20 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35CKOQn4003980; Tue, 13 Jun 2023 01:33:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=yLTUNzLnMV9lnAWZ7IjnybsdX1v7R3psKVfY0G1cBP4=;
 b=XDecMMrOF3WhbYSl36tSNvYpxBWw+u0MdjN+ouc3Ch+Z0P/KzUPR5wIDGVEGYbTodMtt
 lupU4jpTfCCsV3QI9TkWY0XqvMGMQbS4tIY1QyzN6VZ2oNKuIJku9R5n5N7GfwjgplMN
 95UnW9pBVOyWaoaXcBqIQdlDmYvoWEne8fjE+px2ZppSuirq1DCClmz3bKw6wzPw/53p
 ZCrxqYyk8XqOZdtEHWJRW+OGSfR46rArG2xL97oprcr2zuTq4JuoxdvGBDsTjWKRdvaI
 IA7Ob/HuZKu7QzD/HAsn8EI4m5V4p55TW1+kttNMxZI5tHxXN5KoxomJ7QXS5LEMvCLg zw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fs1v81w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jun 2023 01:33:19 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35D16qfn016231; Tue, 13 Jun 2023 01:33:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3r4fm3hhyq-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jun 2023 01:33:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROxd4wFO+CMIibBYJzRr8CF8u7a34yVPzMMTVv1kooUWiu8BaIuIagl1y4D6QFSdzX5WPJ+2wjtCsFPNuN5ueOVAIBObrly312BWr6KyQieDeAClOaQaqT+EmyUzL4FRHe6xULV+gkvCnsWFSdf4Lj2IHwHrVVQ2j3wqi2pCfu9Ya2YwxqdDb+0U+QhOQ4vO9d9+9U6/VOsO59tJuR9VqzN3QN7VC+3ay+gpTVUXt4G3pwoMSOfmLACAkbLyb+1BuIebiq4y9cAkl2UA7yxNelccLdgqjm5AXnVcdmQh7h0X4W10H0kRT21vtD/aJTxEHywbDoLDLEE4eUOI+8iMBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLTUNzLnMV9lnAWZ7IjnybsdX1v7R3psKVfY0G1cBP4=;
 b=IcmyIj6AAuvfngedE25IwPRhqw9snS++BhItMEy/Jb71iIKNpjfjqiAt7OgHIiv1gLWZNdNtWrx8WzxrzPHH4o8SNKI2LVgedv6CpJX2EuoUyX3eA7X7JalCTBZdzY8ovHuCFo+Io5JH6pqJGMHYTQj1Rvip//1iiIvcX+GhFII6GEFR8xicJsoVcqTrhy72Bn1N9uR5bUspRKkixk8xMPhRD9zooViSeyEXoyZAEOUsCLdWHN88uEfzvS5zN5eCm/rX+jzxtXU8MXKG7ozw30pyn0nxRoC9GRYcLzTMlmbM77JOjjnX8eTAK9vir5yzGutBuM7qs3wWcv02PGZc6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLTUNzLnMV9lnAWZ7IjnybsdX1v7R3psKVfY0G1cBP4=;
 b=MGNQhNqb3g49642H7L5cI/hTs+c2ADaA7gpyixJmkIL5mgahQuSSZcUy1jCZNBEm5A79XF3QH6hTJtYTKQXUv+CHRLxocon2TXYctf7I+RMSIvkM5O4Sbc+MaRn6bciVDGdZVpR1RcwIphou2j7BHVEysD6tizzVyMsEvhUQkA8=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by SA2PR10MB4507.namprd10.prod.outlook.com (2603:10b6:806:119::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 01:33:02 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 01:33:02 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v8 07/17] vhost: convert poll work to be vq based
Date: Mon, 12 Jun 2023 20:32:38 -0500
Message-Id: <20230613013248.12196-8-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613013248.12196-1-michael.christie@oracle.com>
References: <20230613013248.12196-1-michael.christie@oracle.com>
X-ClientProxiedBy: DS7PR03CA0103.namprd03.prod.outlook.com
 (2603:10b6:5:3b7::18) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|SA2PR10MB4507:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bdb10e1-c090-419b-4280-08db6bae20d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JseQw47lQW7XCK3D2DlHVzAnkcy3/1m9J9qmZwlFY9TiS06jT25mdpPN6uYEkwez8xzzcmKCUcLuovpwpubMmTr1hP8d3SXHdpVi6S2kqtJ6pxWx99Yx9L6eqLHslL/jdMap79aoUMu4TBAWWSBcrNDoWS1y9WBqeor9Z+XbuFrT4Gq3eUUCE/UMxzoYJHxXxMGcL/SKrkJQ5b2CUxdGF4BnSy/fnnBGys0OjeBsNrSZgs+IYYbxDXoF+Hwr6+wgH00+Ko5zWKVgGnWBpmRynWMdMefPFNOn4d8doxF8t/RkuV07QhAr6EyGk8vTW2epHDcQidAm4HkK2KO8s13Liw+TUB3RRIpkhoSNy0NKcIxWq8wl2DQRRr7revfIUJoyO0TNyqgCyeIWjYDFNRI3Y4w1OusoATDLd4RbFYaplfkwaymaqVJlA74NQ0Jkgf7N3Nfy5mf3anXSdx7q4HdAMh5bZH7tLMwDAeervagj2EpSjjMC72sM6xhzfUrir1d7kCflouQmc/vaDqoPc94vkSZGT3kfxNQ74WOJHbXdSa9ggz3UiId7qgu4Le1zMe8D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199021)(36756003)(86362001)(66556008)(4326008)(478600001)(66476007)(66946007)(6666004)(316002)(107886003)(6486002)(8936002)(5660300002)(2906002)(8676002)(41300700001)(38100700002)(2616005)(6512007)(6506007)(1076003)(26005)(186003)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/EQQGGuGT1L552j/kY89GJ8vzD38dc5cqtVnQ/D2ENZVoCqDkSC65m9W1okl?=
 =?us-ascii?Q?g8i6E9SzqrRdGMGfKgwjwo1RQ56VykSSbv8pkiiG1BMm5eS6/jePKgxs9NU8?=
 =?us-ascii?Q?KX00l9pyjw7xDiKTO6Ygh1/fXIqquQaxZnE0ezh06C1kr0mNAIOm0+3VF9ts?=
 =?us-ascii?Q?ecVNgkoBGZpqjnnIZLvGjdzhGtzSWoBZCIythfaf1zf6zqtagXnmn+xXfKzB?=
 =?us-ascii?Q?mDxa3byI6CX3+QvzLjE3VJOtC3nq5pchjfqsr0HENz59OGNkpFS2OA5j09Jc?=
 =?us-ascii?Q?ce17Nlxhy6bjuFEaSSbFXeqrnSCemAscr7XR1G4oUIpg1MjEKoTRo4lsP76v?=
 =?us-ascii?Q?9pRkNJkNN0CxdeHYGyARIJb3jiO7P3RZvfuZXTz0Z3a0imaDP3/bBaAYMoSR?=
 =?us-ascii?Q?pDXZDM2y7MjkpN9cKGxE8CqOtjuXCPxNzhStOh5pzC7Y7qaCvCWNPLarR8bm?=
 =?us-ascii?Q?mHFsk5h7Vz1iLIn5AADP5f5VUCwxj8pUCWEJ1Q+gfg+48C17vl9WQpz2hX5g?=
 =?us-ascii?Q?zSOKUBSPF7Q599CdcKQvNdDLxuVGL6f2JSaZzRxYPTc/o3USVgkL/t2Mpk9o?=
 =?us-ascii?Q?SNkfzGZbZHw5egPfdPzV4wUUSOmZHO2hkPjvngTnJGiyvbyqls4xyF+MGCa6?=
 =?us-ascii?Q?B1Mi+FEuFozIh0qH0+cwTwdSZPI7bgNKWh+vpiWuzUzZqVvVDOy9r2uIuVDn?=
 =?us-ascii?Q?LsCFfgaWMWnaMpwhEo02uM8F7xrSVTguJWdaI1a5YOCz4wo0V4RCmDD6VYOF?=
 =?us-ascii?Q?xvPyZl/7NCSMH+Lzx+htHoNMDbAbBijxtmUcxCibXTFkxpzobvfDl7tEKNm1?=
 =?us-ascii?Q?mWwrSbstcjl8eG+ncc0WMhR2/11rM5Zsf1Gkki8HKnN+J9F3QXeuou7VZaXq?=
 =?us-ascii?Q?YRzaVR5ygCHUckS1bzRbsVsew27a+3yxK4EMu9Vs+WDQp0ctgPnuWYf7OeUB?=
 =?us-ascii?Q?1voBjvQXgKJFRoC76akqriOdgR1U4FG3KZNuDrvepo05eYByKls5IgusYhC9?=
 =?us-ascii?Q?3H2qbigpnZMxrBIK3UdNnifVpUAC//l76afLbtsaSX8YfhQQxDZt7zTo+DQQ?=
 =?us-ascii?Q?aDPb9MMPVzgAAKBowEPUGnVvTdZU6CDf7msmkOYgL/kkZWdxvX/FzPupUXkL?=
 =?us-ascii?Q?5SGZO52Gjw6O0VdtBCrJFQD7VBhQfZu3gxVIPkq9KCRnFagN0Z7EAf+xb3os?=
 =?us-ascii?Q?bJWNOX6cvJ4LC9ge60XPn7nM66ZbDzx+7R2Lq4qxeX5Bhr/HgTNxE5a81gNn?=
 =?us-ascii?Q?CjmAvs7gU7P7aaOfXFv2mV73cVXkOicWsZdHabV/9tcHLFFSchaJOkpLk1J+?=
 =?us-ascii?Q?0uowuMRMsP45qEx29z3IZ0ZcLNJXzjAxU2A8A26c/NE1ew43YxU66Qh3qybV?=
 =?us-ascii?Q?VfnQQOrGBVXmpEXOe9L8fzMoK83cxUgY+Xp53p6mxpu6w3ggu6Ozh/KZQN3q?=
 =?us-ascii?Q?mCURpvJvK8663OwpGgvXDXNbNtumdTanIS3w4tVpCH/2EWoFFUxF1GcPrLrp?=
 =?us-ascii?Q?QFx+olZajFU+5VE5CHTBJcK1n25+YM1ckbAD+I3aeALEfNElsRg//jLmzI9/?=
 =?us-ascii?Q?HHxXWWG4s/bIOwwRASyD2bo7iGA4V8vmNx+0qQO/gpvROpyaQLDPtmllu+j3?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CF1wtUwZBKdPqW9q5fXczX42weoT4krr3ZvMed0F8S5hn4Tqis/UNeAx6aEwCeGm4YoE6rYbv6ycaUx9ZSvYXkqVW02hPdD7aP0EHs8Siq/v/nVm6fQ6yv90dMSvv/QLODQ6fQuik4IPMp/6IUZb/k3jNWZz6e+/bmxe2jMjFgX0XZP1xEEpP1LNHaGp2kM+FI9vtZH9ohCeMwDQqHM9EBK57uwCiPZIIoM928hBKWWZra6z8Mvh6ZzDYrkmoY7/MSPRKdYnV5B9oyeeOE54YEM9a7KOiDQpDzbqERmO1dZW0Q4rh/AW/f/kRp7GyrzSQjz9bAloWkb/B+uMmxb91LMSVpjzk1y7yiQOMmFhoc0cU9ZO5qfgS48nYpq/QbzKfbm6JC182WrIv7gTGjKBaAqtMf7gh8Sl40GtpPPMjABKHIkw+ArfHQWpjefsZ97i3L3fOv9MvEdVXoHzBbDMLO8QliQsiCr38Y0b/M/9qR5ktZBqyZUYYHJ4NqACEzDYO4GNCK0QhxN/okmSOGTIb5hmWeFCy0NomjQ92vMie78YBTYNTVgzzeRjD27eqg69ZoKaPnTF2rWBOqBUwhP0w6sr7KU3aiEl+63txZYjJ0ahWqFbqLdvsmhQVQQoL92giLK5QXhscAdfQcBLDhgl94B/5Kr2XG/Agmj0VxThHCN4YyRKoSuURcU1ADySPcKypOwyRPC89fEQ7fr94CRCt9LhtADm1uBK0kTyLI6IMBqE+ypX4an1s9f1PeYo93OvZTnn4KEll48vatZxImnWrGkoPz+GAbTcYEAd2oR7xEa+NDciV0PNMb1ezIh6LfSM
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bdb10e1-c090-419b-4280-08db6bae20d9
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 01:33:02.4194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: znnF7ngFpREcWSr/0AcTBNv1cS6JrpjDBdosEG3QwbtV/1pgJaMfDU2dg1DLycq/aKYIcKMCJnuzmDdVr49YtBiAjwqY6uaP36EDwqyqTw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_18,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306130012
X-Proofpoint-GUID: G7LYgniM_rUIsWbIcAUEdbiB8PGSSJw2
X-Proofpoint-ORIG-GUID: G7LYgniM_rUIsWbIcAUEdbiB8PGSSJw2
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

This has the drivers pass in their poll to vq mapping and then converts
the core poll code to use the vq based helpers. In the next patches we
will allow vqs to be handled by different workers, so to allow drivers
to execute operations like queue, stop, flush, etc on specific polls/vqs
we need to know the mappings.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/net.c   | 6 ++++--
 drivers/vhost/vhost.c | 8 +++++---
 drivers/vhost/vhost.h | 4 +++-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 98bb957eb3b9..f2ed7167c848 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1347,8 +1347,10 @@ static int vhost_net_open(struct inode *inode, struct file *f)
 		       VHOST_NET_PKT_WEIGHT, VHOST_NET_WEIGHT, true,
 		       NULL);
 
-	vhost_poll_init(n->poll + VHOST_NET_VQ_TX, handle_tx_net, EPOLLOUT, dev);
-	vhost_poll_init(n->poll + VHOST_NET_VQ_RX, handle_rx_net, EPOLLIN, dev);
+	vhost_poll_init(n->poll + VHOST_NET_VQ_TX, handle_tx_net, EPOLLOUT, dev,
+			vqs[VHOST_NET_VQ_TX]);
+	vhost_poll_init(n->poll + VHOST_NET_VQ_RX, handle_rx_net, EPOLLIN, dev,
+			vqs[VHOST_NET_VQ_RX]);
 
 	f->private_data = n;
 	n->page_frag.page = NULL;
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index d212cee064d6..9623264bb3a7 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -187,13 +187,15 @@ EXPORT_SYMBOL_GPL(vhost_work_init);
 
 /* Init poll structure */
 void vhost_poll_init(struct vhost_poll *poll, vhost_work_fn_t fn,
-		     __poll_t mask, struct vhost_dev *dev)
+		     __poll_t mask, struct vhost_dev *dev,
+		     struct vhost_virtqueue *vq)
 {
 	init_waitqueue_func_entry(&poll->wait, vhost_poll_wakeup);
 	init_poll_funcptr(&poll->table, vhost_poll_func);
 	poll->mask = mask;
 	poll->dev = dev;
 	poll->wqh = NULL;
+	poll->vq = vq;
 
 	vhost_work_init(&poll->work, fn);
 }
@@ -297,7 +299,7 @@ EXPORT_SYMBOL_GPL(vhost_vq_has_work);
 
 void vhost_poll_queue(struct vhost_poll *poll)
 {
-	vhost_work_queue(poll->dev, &poll->work);
+	vhost_vq_work_queue(poll->vq, &poll->work);
 }
 EXPORT_SYMBOL_GPL(vhost_poll_queue);
 
@@ -508,7 +510,7 @@ void vhost_dev_init(struct vhost_dev *dev,
 		vhost_vq_reset(dev, vq);
 		if (vq->handle_kick)
 			vhost_poll_init(&vq->poll, vq->handle_kick,
-					EPOLLIN, dev);
+					EPOLLIN, dev, vq);
 	}
 }
 EXPORT_SYMBOL_GPL(vhost_dev_init);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index ac1f4924e548..f44eecd4fcf9 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -41,13 +41,15 @@ struct vhost_poll {
 	struct vhost_work	work;
 	__poll_t		mask;
 	struct vhost_dev	*dev;
+	struct vhost_virtqueue	*vq;
 };
 
 void vhost_work_init(struct vhost_work *work, vhost_work_fn_t fn);
 bool vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work);
 
 void vhost_poll_init(struct vhost_poll *poll, vhost_work_fn_t fn,
-		     __poll_t mask, struct vhost_dev *dev);
+		     __poll_t mask, struct vhost_dev *dev,
+		     struct vhost_virtqueue *vq);
 int vhost_poll_start(struct vhost_poll *poll, struct file *file);
 void vhost_poll_stop(struct vhost_poll *poll);
 void vhost_poll_queue(struct vhost_poll *poll);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
