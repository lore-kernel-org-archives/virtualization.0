Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B48EB64D7
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 23:23:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC3B76114F;
	Mon, 26 Jun 2023 23:23:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CC3B76114F
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=hm+FOR74;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=X+xg5363
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kmpx4Pgw7B8J; Mon, 26 Jun 2023 23:23:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B1F2C60F83;
	Mon, 26 Jun 2023 23:23:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B1F2C60F83
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6757FC0095;
	Mon, 26 Jun 2023 23:23:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F404C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 66D694173B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 66D694173B
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=hm+FOR74; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=X+xg5363
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id um8aD4D-S-Qb
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 04E774086C
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 04E774086C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:28 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35QMi6e4023163; Mon, 26 Jun 2023 23:23:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=shYjIswIyCm/fw2zeudX0S9xFlFC6/scns5x9kEUhRc=;
 b=hm+FOR74CD+LunjA2Mpo4dICihlObY1NgKfyEhk1nReKQrZbMRL9ziDWEKUGPwgYelaE
 yYAXsOvslq/7VxZtk7BVRco1wzk+DpJPiGmRTe+PogYBEuVcnsxBmbbAX9ffEu9Pu8Ch
 6qjuCRf82jloP7nDscD9NC1iNZ7LmTiB3qOKfuBb0cAX8u1qnA9y0uquk3NfQ6IO1h5i
 KkisgNLe0xWOEhxVHnhNU9lgJL2eOZPNEn1Ktfb/5cFwssxEsPtY/3sxIKn9Wdkj58PM
 xUUFWbnxY30ssdsuep6dBwNs7Ks1YEbRgojv0VbTNoHkq7fcd42fDEIIBlm1FyQ3huQK Mw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq933uf5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 23:23:27 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35QMPqbD026369; Mon, 26 Jun 2023 23:23:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpxa88df-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 23:23:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrCZwztFoQjaQ/nfSkJKqFVPOsNkrzuBg13YB36SPP0rv1oQ3Q79JyH5teTgs6Et/uqjDagOpW+aofyu6IN1ss/uOqxUXc4YY9mPIF4FouCHGIf2GDxooxSTqfOY+KtA6cPTpBQXLGLbWK8D0Cfa2/lpzEGeS1B5knd8EgClGKZf7e9PpNujVpThPj/4KTwXu6kdlyO/HCz7yBCMMDMNEpoe4xO3ELWcx1vmOcLNSCtird0guiVAaJ9enKdPznOF5C+ufBzjUMqXUBppa8/q3hxjKyb5E2wrKzugS9uS18dCoirLePujAIzJxkuH0T2/TSZhOdSdP9gu+l6mlZgeZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shYjIswIyCm/fw2zeudX0S9xFlFC6/scns5x9kEUhRc=;
 b=Jm+OvLZVIDfJGZc/+O8fTn1ebCt4cC9fLFcWfIzwu8wfx9g8pL6uE+xXHdVFwvCtMY4+E741K+Ik0g6saSjiJwmOZMDoPTzqDlcnQUMmIyxQqrdml2NtO0g6gBxOYtdIx9HPI9oSksgIogWc8GC0A/4sZIpIbJAeoG5a20IoJiPW/+Xj3W7dVsc/LGdgMF7pRA4Wyy2lmuxinFIhOgSrkEavetaszUnmWX8YhFoFv8b5GTKekGmwCxaxz37jyx3zJgx1/5AbsniAQkeksu5DroeynlVMrjt//G3X2zTeX2fKbgAAkJn3uFNmW8Hrw178crs8+775a2pbsY/C/YYYTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shYjIswIyCm/fw2zeudX0S9xFlFC6/scns5x9kEUhRc=;
 b=X+xg5363Oe+Jmk0FBU0VdyEE+cgGs4NjtArGP3iXEXFGmcm9eGI2mxakhZKnEjkTfq/ho6u8O2JyrljxCNINfNIO4l4evpPMSxwijlOVVZwOHULUggku38LycKTl0tdoIZAb/utytp1xzGYIfT9fWOJYn/c3AZ/iucrPepno1rs=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CY8PR10MB7377.namprd10.prod.outlook.com (2603:10b6:930:94::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 23:23:24 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa%4]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 23:23:24 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v9 09/17] vhost_scsi: make SCSI cmd completion per vq
Date: Mon, 26 Jun 2023 18:22:59 -0500
Message-Id: <20230626232307.97930-10-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230626232307.97930-1-michael.christie@oracle.com>
References: <20230626232307.97930-1-michael.christie@oracle.com>
X-ClientProxiedBy: DS7PR03CA0322.namprd03.prod.outlook.com
 (2603:10b6:8:2b::29) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CY8PR10MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: dfa849d2-ac52-4359-c1f7-08db769c56d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yq9NAHghxsYMdQPLtjUJTbaOyjc6jITVoqb0I0tDlQIYWkWwTbUoIJeUT8+CJ1TNc7KUL1OdPae43oI2zku2VXg+TXKaS8jq51tg3l9WCRddwAYfEvmanuaGUlbcoebazyMDS67fo+6+PC848XSLSHkOV6rKFtsG6HMdANa4UxoQGUPLKwfJvUF7cKjnLeLN18OEk/5UZVQyCNvZADHWQOEvHXJvBfuPmqTIz3fEIFBypySB5RDnEdsRJj6jveOCFIy1sPmkGktWJl+6+Mu9Yfq3ksehXfUDiEQdR2wCNSB0WzDyRmjIzfVPWw5YF01hdnqL8AtrPu6VWvx/kEp9VFW9GAEGWHo8UMezsqpMMqm3ZXS3+HiV9sWJan2oFJf0aHDf1HD7egKLqbM59sh3dKJfGlZCEirjzqiZK8siHzeGbbH9XslzlDSbftdYQ+gRVbBf2saV9Ie84YC7crjN0P6WTyh8TxlUJJ5FA/ZuKGd8qNcHlrZjamYqryjyuDdgG5syrwg5YKhjkhUzohAfubQnv4lxx/KYHaQF0Tt6hP3Sk08ylJmU09qYU3jCT4AW1TYNC1gv3fY+aYMX23DZuIJFZn49NEcKjycP7M6SWS0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199021)(5660300002)(66946007)(66556008)(4326008)(66476007)(478600001)(36756003)(316002)(8676002)(8936002)(2906002)(86362001)(41300700001)(6486002)(186003)(6512007)(6506007)(1076003)(26005)(38100700002)(2616005)(107886003)(83380400001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NRiiNs+5hxOEUMnAAK1dA6QxVEKLG/auBv9TxHrY3W27QqSiU0M7ZeA/H0bU?=
 =?us-ascii?Q?ebOpeo0kXhiIihe+UVH/HpWjer7R1h++E7W2OfRd+jNb7Y1p9kPpFFGga0Zz?=
 =?us-ascii?Q?xdASAS1k6eXe+SqlFHe6HqTGBCrLNw/MlQHr8XQX5dpDtq0M1fwsj7PhgQWH?=
 =?us-ascii?Q?s4VzLIPq8duIKLzWpjl5TAB/hskz1BQng1r0hsf6ExlEdTrUiJYlffwSlOuD?=
 =?us-ascii?Q?0AcTX+4P2dFidVd5LR611odK5pK3Oreu3YY2EEh5fuctt4p7U1JB9CKCRnMF?=
 =?us-ascii?Q?ThTlXow9EDSsPXvOv303gmhogwXx5/zDJijJVt72LD55nljaIQdg5m6JpQVY?=
 =?us-ascii?Q?nN6tA18SL6HxUt+lw8wFBmpdLbebGXIrhMVfwTVsJZsuNirkRAgr0DJgjrO/?=
 =?us-ascii?Q?8MsHHGMLNYuh6CZ3CokzE5pzCAp6JbaZR2YI5Gbm0nWk2Or79YZh/tpcj6Fn?=
 =?us-ascii?Q?5kheL4iXCJU07VX7P3kUGcEIw7NPXY5tpHwkuJ5U2jNDOFhj10WaFFFilOvl?=
 =?us-ascii?Q?MDJUYH0d9jQwJS4tzgM2CFg0HT1ADlsi/azJfSs3mgiI8kMNVIZwCwsbA2vP?=
 =?us-ascii?Q?1DktwRNdYTWjXby7GfkwmlIUvlWqFZdQArSVaMaVoxWdH/uq1AT9tiOCfJLK?=
 =?us-ascii?Q?MqOzl18l+Oj1zwXIyr90Aa6/2ZtfznAhe7q0wIH2u0vFrqvNzn8uxxXj22E7?=
 =?us-ascii?Q?MoUqSH3f8RURUmqAvk1KaBUzrfKd1ClYlRK0NuDiUQH0fcfP5Tho6y4ZbyQi?=
 =?us-ascii?Q?bxO+6a0C9KGEGHjctxfXfmbqx850zemiFVCh83bldyoMNxiTWXbED31D1XBV?=
 =?us-ascii?Q?T6pdtbofqu/l/SbMlZwv88LQdvwukKPjCzbKWm256lgaCWtZRFgiL+fOSAg9?=
 =?us-ascii?Q?6pg1IVPTjg6fGTYrTV+UTQXFelz6fiZZgAk/LHTcMfBq17yyxV94ZBErZxPw?=
 =?us-ascii?Q?lpQyA1hTZnYQT3GbtPu1coJSuo2qmjj/ZB8ub9IHb2MNGBwTAphRT8TP1W6m?=
 =?us-ascii?Q?3p9/3gAM7s6abZghvg/3HySQjrwabG1Xa7tQVa25R5ODQgbOkuei1bWiqGso?=
 =?us-ascii?Q?f2PYFTPG8J4mjQvspr2AzZDjTYRRMeZQvECnRKBsphkFPt5ehOhd1DcqqvEl?=
 =?us-ascii?Q?vD31S0Dr6ChEm0gY2LbkNJnvcZJe/1TTKde9YU2V/aEecJFq9EeW/w1lyyCn?=
 =?us-ascii?Q?9xD1M1ISqg93Tkw5146Y1D2FR5HXFnXFhDvbzU1LqctkqCAuP0ahfAJHv+jy?=
 =?us-ascii?Q?CnenBFacY5RLCLH1329IBoVamYObZ3ogrVM/sOLh9s8FILpOaWKbuY7B/4m1?=
 =?us-ascii?Q?z6A/wlhlgsTeK+UITp6ZxYiuKd9U61nD5vknixsRwga4aUy7S389GEK74Ogb?=
 =?us-ascii?Q?LA6YNUHf0IduBjLYppuIsvbx6LgSFdg+v9flZVFEU/bVuhIdiTxclykfMwQw?=
 =?us-ascii?Q?30mP0wc57/XrBB/IncNgNmCs9i89yY7tZj67tRxutoJnZ0U8ikOXgxIdAK1S?=
 =?us-ascii?Q?gcnWAkA98pMT1ouc1G86RxXhxp5+SpnPPJPbmyC2z1u38cSdQErgTPaSeexo?=
 =?us-ascii?Q?fX7ge7qC0CZcVLkCcmBcLK30X/moytQd4UoBmXL3k38QnSBvjNZXOW0NyWaU?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pUYT652iJwuvSIZ2BEskufDFfN3x9cfCiLstu2c2oVZhOdNBB9oXGzX+K2OxqoYexUJ056cVpxG9KFeKwmHlFqxRZ0SWsuwCylIR0DagJ9rNmIzI6u8HfP5TkEMzxl0aW5a1XlE4oBGEQK9iEOq4ksS3x5trCfD+irjdxbzcFsThTz/x2PmzjzhQcnaNFH+ocRLi9F4E/1uQcUJ5FDsYvuzRlGY2bZJKVrHbJhAshtYzAnWIf5Pm4uM+6xTK00WV4Gvxmuen/XoNBQgUcLPdmqmSclWRPWDNLgq/AAoWDtqXL/XLY14u/an32e225bjOKoskJ3vvZHEiepqP7SxNppIfxbWWpxDszsWDVY6dhpp9DLV1OSv1pq8B1TM7l5jwg5p9eTPNu/4GMU/yIXWYJqjuYhFXRcDo7W6j7Gl/IgIy1FjSCDcgt+BUBg0yv2YFWvUm0oL1Bt9lQ+jt/xtmfE/gwgspmRMzHFAVSnOlqZOX2F7oNvKDYT9V2BSi/Nojy3GVPTmMz1ay9U9ygkyXcucVlWrsfSDF1tdT7DMf5fKWEvQmxGGSV8OuZMIj8JsZEsfaG/Rx3OGr2aPEFcTGvfeGzfMOW+9RWSPBRRdlTjDwg5dgBPjB4iAqOp69YazSWrUCdJ4gZeFxVD/SwK5ficfVsr6yPJyfjaxaXK3crzFz6mB6On9D/M4aIa7ksFU4qKXwxio3c0PzmxM2bj3Iuq04ab9F+SuUnWvTlCdq0CZ0fe5ci5Qwki/c06K8iExN71jH1eoikaGOLqlgRiyE98fvbL2JAJXYYT6FWA91BlqKmXHnzfbnyKKkiAIsh4QE
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa849d2-ac52-4359-c1f7-08db769c56d3
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 23:23:24.7803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQRWSKDBaI96duFTsCdakyjYdKVHo8GBp5H4H0VITVYfhuZCQmciZR62Qkl0MhI46toA5AddFei2kd1PAxLNc0z38gSpc9pzAfv6xtKiPXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7377
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_18,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306260218
X-Proofpoint-ORIG-GUID: xsxcimwc5VEol8ZwWYqPywcH78QsELIj
X-Proofpoint-GUID: xsxcimwc5VEol8ZwWYqPywcH78QsELIj
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

This patch separates the scsi cmd completion code paths so we can complete
cmds based on their vq instead of having all cmds complete on the same
worker/CPU. This will be useful with the next patches that allow us to
create mulitple worker threads and bind them to different vqs, and we can
have completions running on different threads/CPUs.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 drivers/vhost/scsi.c | 56 ++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 30 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index bb10fa4bb4f6..a77c53bb035a 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -167,6 +167,7 @@ MODULE_PARM_DESC(max_io_vqs, "Set the max number of IO virtqueues a vhost scsi d
 
 struct vhost_scsi_virtqueue {
 	struct vhost_virtqueue vq;
+	struct vhost_scsi *vs;
 	/*
 	 * Reference counting for inflight reqs, used for flush operation. At
 	 * each time, one reference tracks new commands submitted, while we
@@ -181,6 +182,9 @@ struct vhost_scsi_virtqueue {
 	struct vhost_scsi_cmd *scsi_cmds;
 	struct sbitmap scsi_tags;
 	int max_cmds;
+
+	struct vhost_work completion_work;
+	struct llist_head completion_list;
 };
 
 struct vhost_scsi {
@@ -190,12 +194,8 @@ struct vhost_scsi {
 
 	struct vhost_dev dev;
 	struct vhost_scsi_virtqueue *vqs;
-	unsigned long *compl_bitmap;
 	struct vhost_scsi_inflight **old_inflight;
 
-	struct vhost_work vs_completion_work; /* cmd completion work item */
-	struct llist_head vs_completion_list; /* cmd completion queue */
-
 	struct vhost_work vs_event_work; /* evt injection work item */
 	struct llist_head vs_event_list; /* evt injection queue */
 
@@ -358,10 +358,11 @@ static void vhost_scsi_release_cmd(struct se_cmd *se_cmd)
 	} else {
 		struct vhost_scsi_cmd *cmd = container_of(se_cmd,
 					struct vhost_scsi_cmd, tvc_se_cmd);
-		struct vhost_scsi *vs = cmd->tvc_vhost;
+		struct vhost_scsi_virtqueue *svq =  container_of(cmd->tvc_vq,
+					struct vhost_scsi_virtqueue, vq);
 
-		llist_add(&cmd->tvc_completion_list, &vs->vs_completion_list);
-		vhost_work_queue(&vs->dev, &vs->vs_completion_work);
+		llist_add(&cmd->tvc_completion_list, &svq->completion_list);
+		vhost_vq_work_queue(&svq->vq, &svq->completion_work);
 	}
 }
 
@@ -509,17 +510,17 @@ static void vhost_scsi_evt_work(struct vhost_work *work)
  */
 static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
 {
-	struct vhost_scsi *vs = container_of(work, struct vhost_scsi,
-					vs_completion_work);
+	struct vhost_scsi_virtqueue *svq = container_of(work,
+				struct vhost_scsi_virtqueue, completion_work);
 	struct virtio_scsi_cmd_resp v_rsp;
 	struct vhost_scsi_cmd *cmd, *t;
 	struct llist_node *llnode;
 	struct se_cmd *se_cmd;
 	struct iov_iter iov_iter;
-	int ret, vq;
+	bool signal = false;
+	int ret;
 
-	bitmap_zero(vs->compl_bitmap, vs->dev.nvqs);
-	llnode = llist_del_all(&vs->vs_completion_list);
+	llnode = llist_del_all(&svq->completion_list);
 	llist_for_each_entry_safe(cmd, t, llnode, tvc_completion_list) {
 		se_cmd = &cmd->tvc_se_cmd;
 
@@ -539,21 +540,17 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
 			      cmd->tvc_in_iovs, sizeof(v_rsp));
 		ret = copy_to_iter(&v_rsp, sizeof(v_rsp), &iov_iter);
 		if (likely(ret == sizeof(v_rsp))) {
-			struct vhost_scsi_virtqueue *q;
+			signal = true;
+
 			vhost_add_used(cmd->tvc_vq, cmd->tvc_vq_desc, 0);
-			q = container_of(cmd->tvc_vq, struct vhost_scsi_virtqueue, vq);
-			vq = q - vs->vqs;
-			__set_bit(vq, vs->compl_bitmap);
 		} else
 			pr_err("Faulted on virtio_scsi_cmd_resp\n");
 
 		vhost_scsi_release_cmd_res(se_cmd);
 	}
 
-	vq = -1;
-	while ((vq = find_next_bit(vs->compl_bitmap, vs->dev.nvqs, vq + 1))
-		< vs->dev.nvqs)
-		vhost_signal(&vs->dev, &vs->vqs[vq].vq);
+	if (signal)
+		vhost_signal(&svq->vs->dev, &svq->vq);
 }
 
 static struct vhost_scsi_cmd *
@@ -1770,6 +1767,7 @@ static int vhost_scsi_set_features(struct vhost_scsi *vs, u64 features)
 
 static int vhost_scsi_open(struct inode *inode, struct file *f)
 {
+	struct vhost_scsi_virtqueue *svq;
 	struct vhost_scsi *vs;
 	struct vhost_virtqueue **vqs;
 	int r = -ENOMEM, i, nvqs = vhost_scsi_max_io_vqs;
@@ -1788,10 +1786,6 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
 	}
 	nvqs += VHOST_SCSI_VQ_IO;
 
-	vs->compl_bitmap = bitmap_alloc(nvqs, GFP_KERNEL);
-	if (!vs->compl_bitmap)
-		goto err_compl_bitmap;
-
 	vs->old_inflight = kmalloc_array(nvqs, sizeof(*vs->old_inflight),
 					 GFP_KERNEL | __GFP_ZERO);
 	if (!vs->old_inflight)
@@ -1806,7 +1800,6 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
 	if (!vqs)
 		goto err_local_vqs;
 
-	vhost_work_init(&vs->vs_completion_work, vhost_scsi_complete_cmd_work);
 	vhost_work_init(&vs->vs_event_work, vhost_scsi_evt_work);
 
 	vs->vs_events_nr = 0;
@@ -1817,8 +1810,14 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
 	vs->vqs[VHOST_SCSI_VQ_CTL].vq.handle_kick = vhost_scsi_ctl_handle_kick;
 	vs->vqs[VHOST_SCSI_VQ_EVT].vq.handle_kick = vhost_scsi_evt_handle_kick;
 	for (i = VHOST_SCSI_VQ_IO; i < nvqs; i++) {
-		vqs[i] = &vs->vqs[i].vq;
-		vs->vqs[i].vq.handle_kick = vhost_scsi_handle_kick;
+		svq = &vs->vqs[i];
+
+		vqs[i] = &svq->vq;
+		svq->vs = vs;
+		init_llist_head(&svq->completion_list);
+		vhost_work_init(&svq->completion_work,
+				vhost_scsi_complete_cmd_work);
+		svq->vq.handle_kick = vhost_scsi_handle_kick;
 	}
 	vhost_dev_init(&vs->dev, vqs, nvqs, UIO_MAXIOV,
 		       VHOST_SCSI_WEIGHT, 0, true, NULL);
@@ -1833,8 +1832,6 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
 err_vqs:
 	kfree(vs->old_inflight);
 err_inflight:
-	bitmap_free(vs->compl_bitmap);
-err_compl_bitmap:
 	kvfree(vs);
 err_vs:
 	return r;
@@ -1854,7 +1851,6 @@ static int vhost_scsi_release(struct inode *inode, struct file *f)
 	kfree(vs->dev.vqs);
 	kfree(vs->vqs);
 	kfree(vs->old_inflight);
-	bitmap_free(vs->compl_bitmap);
 	kvfree(vs);
 	return 0;
 }
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
