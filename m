Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47577EB64DD
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 23:23:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C136360B68;
	Mon, 26 Jun 2023 23:23:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C136360B68
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=jzxR5Gc5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=aXMH+85k
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fknDC5Sh6j04; Mon, 26 Jun 2023 23:23:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2DA1C60FD0;
	Mon, 26 Jun 2023 23:23:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2DA1C60FD0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9CD2CC0099;
	Mon, 26 Jun 2023 23:23:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2FDAC0037
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8A92B4056B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8A92B4056B
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=jzxR5Gc5; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=aXMH+85k
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id upOxImpl6uze
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8414940143
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8414940143
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:29 +0000 (UTC)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35QN4kXC018419; Mon, 26 Jun 2023 23:23:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=W2dW9tK65GrFEgs/7IoC5fXWRRAYfxsskKScAWGktyw=;
 b=jzxR5Gc5gvkBEYJXkmL6a29ac+RjLtLK4WVrDDcE8ny9giIyyTnCWWZw2danHoXyjtlM
 PvC0eIOJyV6hlFxjU2ljGpmKCg8TAg3tktFwrh7FfnLDcojfyjdgHyQoYkbRY1B3zVmX
 35Rc5uczTZUZmg5p0JKXc2aboWJl2+4rWTsDAhcCb8M0jfIKPZ0DQTY+2CZzFU1+BCLm
 rLsrvJ9jReIKxWIBNPuxHL3H3cBZm2kKVL68vdLDaMhteIUhbrffXCxVF9wkFkonF6mc
 2fju68l7z/1R9zmyQUrN++mR8ADkuTHBibBj7eVXLA+XHmrYl9TV+VfnA/qOyEmtXmsz Ng== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdrhckvtp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 23:23:28 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35QMPqbE026369; Mon, 26 Jun 2023 23:23:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpxa88df-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 23:23:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKTSLrLW/SUOcMWECDQjxbV57FTtlqU7sFy5oYXxFKVbJJ1m7Zgh7IsIXuTaNiiKJH3GVhSXvqHK0l8HLIKGuSBdroNW8scxJrKnKC9xgXSJCxHZIhjmXNm26ykW/akta8EGAbIyToaSB/OgDECpHwxelOCJnsP4qch1aXV9FnrN1eJvMigKkOTGrFU6d5LnAL1KAagzQZ1+DU/m+z5DOK9aGFforDkjFvkDvLJSgb0fp/6sNdbmT35JpmGboDRsAuRm5Cy/M/RDjmlEJXJX7k6RLhgIgY8Uu9F6y0vJf+xk9IEPI0De45ErWVD/rVtYUSSihWUFncnH+bNkYPw+vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2dW9tK65GrFEgs/7IoC5fXWRRAYfxsskKScAWGktyw=;
 b=BeTcAWUh9w7eYK6Ul6RHaS0tjc3ot6cRT9nv9M0ZVBbwvbSKJGk5hm2p6yra4LC+ywUkjkdWz5T15l39jH++/70l+XTaNkOfrRGUtSFVTi3idJ/ncndr+eR4BdM4mk6FjalihqsAYyr6kgVx0brvmSACPbjMA+KnGH+7gybh5p6Qpu+LwmtkiK6IJI9JMJhugmccu14NM4SlwFJJ58MDj/zXOFgZBLevfwd7ZMTZViX5PcWupiXpZqMIKxXItH3meLMAo3+Fk2NgmCSveyFA8C6mT4cn0P9xFiDVCjuVCVyzNGQ6BDs629mt5eoi9jghtGlcOChw3uGSKqQmwXatrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2dW9tK65GrFEgs/7IoC5fXWRRAYfxsskKScAWGktyw=;
 b=aXMH+85keVmi2ADKqatCvfQf/KXokYfmC1ezUa2if2QTXTGw7K+emxWwu9jYMV9EecKMGQe8xbVoCRIu0mLgoTyryaoo8zlRodp72Au9eQamqDY4TzWfFgGCtOzW9SprDPbR5j3AYtBAm6MyRL0f+6Dg+leO1EmPEhm1SXm0s6I=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CY8PR10MB7377.namprd10.prod.outlook.com (2603:10b6:930:94::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 23:23:26 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa%4]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 23:23:26 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v9 10/17] vhost_scsi: convert to vhost_vq_work_queue
Date: Mon, 26 Jun 2023 18:23:00 -0500
Message-Id: <20230626232307.97930-11-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230626232307.97930-1-michael.christie@oracle.com>
References: <20230626232307.97930-1-michael.christie@oracle.com>
X-ClientProxiedBy: DS7PR03CA0314.namprd03.prod.outlook.com
 (2603:10b6:8:2b::26) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CY8PR10MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a21d15f-04b2-4b56-208e-08db769c57af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TjybfUvOrsX3GpusorcbMZdRJauxFnu4w6GGzSIcW3/Pg8Fl54eLR8wBeb00p1e9XnJFsLzS5BKLigJtQnuTtqFCdWElmksoHU5I1XNTYtph1TyajgT7JW/gJwqIVDi2CaTHoJV6Vju6OepWHa3bgAaPyMo3mroC/VTzxW6YC9ziPLA3yjx6YDpgvPv4US+2sJx9MyVmEc6j1Ma46qPTqkW8iFs70BU28fQ6rd7tDLn+SablZtVhfQpJ4jct85jAF0ye9F2nTJ1baLQG6geeYJeqcda+ZGYYAFny8at5v9Uihx/6+cjUVwPbvXaZRVe+ZfgFWTgu0KZV5DxsTw1LADbvy6ktqllGMbxhn5sajpcMSgslQmbLSCSUpXnHR9fLWSfh1pPIBa6OZrz3V6RMnJ1qKivM9+EgmjgA9bT8MRKixiLrmCb5LpuapVCRB4+zp07Dk73s7RTCaj1IOxMjSmywNh6LEi7YHONLjogY5MeHxjPOaq1F1yuoNLEqQ25zpNjqDXDU2uBxX0mZuF7H30vRdKZFP13UulCF5L2e9dCBpJe6ZQjSfb+Eft56raeSJuMJShRy2fmQt56KCzMCkfAehC07Wp+ZR+8WgDalt98=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199021)(5660300002)(66946007)(66556008)(4326008)(66476007)(478600001)(36756003)(316002)(8676002)(8936002)(2906002)(86362001)(41300700001)(6486002)(186003)(6512007)(6506007)(1076003)(26005)(38100700002)(2616005)(107886003)(83380400001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m0t8/dEA0TQrytz+aGuxyWQsBVXJbgN6joOaV0UgAQvwcSuoVJKEvkuFybKX?=
 =?us-ascii?Q?WTulZ3/ItgEsqGzwqfJW5PNlcnUeAnR4DcAQ0tUiHA9yajkCEi3J5PHdf0sP?=
 =?us-ascii?Q?6BCgtMjUs2iyeRWtChGe3Lm7vC9svF/OtQka9QTQzXFVPC0RgN4opWPJjAaQ?=
 =?us-ascii?Q?M87mQ9xeULobUWxfn2wu3NLgcD1JXWYDPzQWba+Lj8p0X8Jt8fr3kpRJv2W8?=
 =?us-ascii?Q?b+9F7PAveXg+1j3pdRN6V00xPNYI26Exd5pSWFk3ISDviq27vqBC1vWKD+lF?=
 =?us-ascii?Q?MdeBA3hMC+StunUFRdxoJ1gUnSHgkqJVwTj5GO6/EiRXuTyxIDKUJYaSXW8P?=
 =?us-ascii?Q?HMEVH5p9Ae2XQacZtujF/ZFYVkN46+GqLupNOmQHSwBSu7TmIs1weLi3lQmw?=
 =?us-ascii?Q?Rdu7zma9Jkj3ebNFnPkQXqfh9p/12mfXOlU8u87B6gdBz+hMFfvteW5CnfCJ?=
 =?us-ascii?Q?k2Bm6Og5uYTlNMw41BpwrOVL1lwUkueI3HwkDVwlMAxPckQvVtarL2+B08N4?=
 =?us-ascii?Q?n41HS5gTEH/k3K5/EjBOLSTS+X3OYY/cbNzoCrvPdwzWnXrtOnMQRjmC93ll?=
 =?us-ascii?Q?t6ajm/vJZ0rAOV9EK5xn+yo0lMiNIZzz3xAuy9tN+FCxR8GiqTWpEIqfd0aB?=
 =?us-ascii?Q?X7XMiuj/ff/m6T2bdKjqA+2g4CWh+whIf2s6TK+2mUC6W4gc3MTMpB2Hfr2z?=
 =?us-ascii?Q?pL4aKMUE+L63h8Rwz/dGiGV49E3Is/PMAL7MNqaD2HZ8ozlJIlPI9kGYyCOy?=
 =?us-ascii?Q?UZcw/Bn9eT7qi+Ij+gheSNxu8ndO4HqrypGvsFMify+4fR0QKuDC219X83B7?=
 =?us-ascii?Q?ba8m1EtTlC54shLBhWYcjiHptaGPQgqfnZ7FaEKU1jszJVnP5YcHUZvDs0qD?=
 =?us-ascii?Q?pRXdqBpUCCprsJ6qj7m/Y+MYXH+sMyOHLSNSJTZ1ntOic39orQPgtEnJ0ENW?=
 =?us-ascii?Q?kGmnu9XjLNmbVAOwLLgeSinbZCmdvwtCL7XfyI3PWO1kIXCS9+f/FiHB1Iae?=
 =?us-ascii?Q?fm5Wqmzitk7fsm7pLXAJJtURtxgT8lae2Mjd160rNavUJDjKtfSCGUnFSO4/?=
 =?us-ascii?Q?7s6Ajg4uebaypqMzBCt8bwikkeCJoBF1jJ5EJU3CdVjTsdq2F9L885u3JMQA?=
 =?us-ascii?Q?fbeeozetFzXwZ6T2Auo4ofRGLtKV9FQ/mqN02CwXT/xuBgONLH0nkhutCKZr?=
 =?us-ascii?Q?k+yeyw8yUHSVwC6/B7eRfsq1rJgHL04GLC+DTgC7g/0/a7iKzVgC3eEhGMaG?=
 =?us-ascii?Q?f5LKa0p6k6Jq+GVZigNWc1GIU+DGy39VzoCKWDtPwoNWrL9oKc8JMxWuGEh/?=
 =?us-ascii?Q?j+2IWXq7jxuRFdAQl8rBT2PhR85BIjJC5dar0Y5VJSW/PjXhgE/OkU9tS+VO?=
 =?us-ascii?Q?1t/HnTMqYb8C85/szWfyoShMoH527u4ED13bhVCcc5GMNdN3Jof78YNr83vE?=
 =?us-ascii?Q?ac+7hyp7bwhBUEzZAqjGoClKxxzIYqRkyU5D8W+S2u/fDKbJo6SbBw6mu4Dl?=
 =?us-ascii?Q?IMNySCgdnMXNZ4OcLnewSyDZimqy7/t1/WP1qpwKbhepUFAdvdSGthxGzW1k?=
 =?us-ascii?Q?RQeKVkkcsWQSrrTh8SGQZ4XPoFMQ7gm4ZY4LtJSbRS0lEAKrE0lspSWdnzz1?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qu/I4ukkNa9MdIQkyeTC7eX6Ec8dVWzR48I2dPS2DrUR3eZn/ObvBPsrib6i+5Xg2/s9XWMfA1kMqkqgH5KGkqtfq3PH80JPWz6WlqwpCe7P3yb3sB5ht2PiR6HvJNIKKd0TcebPfu+SG9SaXjE8fl1t9aT1tfkkc5O0Ymv/840cpiYxToaD2jamqCEk7gTYYDCyDkXRuzVX6a1PAansTABKpjxMh/zMzuAlNJbRZUQjxrnoQIPInqsHgChIieHEEJorKprl4H2SUwIK+KLTAO/cODlueh5a1xY/NGQjtpi8NqVF7Xe9WuDf78PmMrd4uaN9EE79hmcenLdliKwl74zHljT3ABcZqF4UNuWqQ1zpi8brDlzGWvusFfWnzBsp5DFWSo5Vt4XKUd/acjUoObDy0AhSzh0VWeObc5F8kaJMMNbMoUCCBekkEKUvKihqYZ2Xl9/trp96+Nl1lci1XXJhHEdRtbdXrSYLn5QyJZNtqS1rsfEppdSpfLwIerxP1jX0+gWcqUSfnQeNtrAopxo+cGr8U+Pf0bxolYVpm/cRt/5wOuX2Z3r3P3j/eoMt0C0Kl38vUEv6qHa4is8BG+6H8iY5uSizH409TnisRoQb4vck+fQLvVgoB5PFiTO3hw5zUiaBjg8O1P08UNyZqhZ1HbBzvci7l4IELIK/zcQaCC8ynyFLtVsDF6HmbgeC059IzA2TnECjQkm/tuqL28jCGy7O9Cr6+oHTdjBgC0ULVn49SFOnPYydZ+bRYRNpzcaropgquxhzpdwyk5KBkThPXlgIbqcrX1o00X6vqRZf0eY5v4EICwxn90L7aw/P
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a21d15f-04b2-4b56-208e-08db769c57af
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 23:23:26.2124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sy3yrje13JK+sAYw9QZej6QA0pWQL/vkZ7AS3n4wTeNuw5qVrG0uX9ZLp+icax6y7VPaRaV050mpZAbXZwRhqDTU9l16DHmF0amR+VUZ10s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7377
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_18,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306260218
X-Proofpoint-GUID: cdATxR4YeKcZItMQf3O2qy_sNEwKm28q
X-Proofpoint-ORIG-GUID: cdATxR4YeKcZItMQf3O2qy_sNEwKm28q
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

Convert from vhost_work_queue to vhost_vq_work_queue so we can
remove vhost_work_queue.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/scsi.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index a77c53bb035a..1668009bd489 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -353,8 +353,9 @@ static void vhost_scsi_release_cmd(struct se_cmd *se_cmd)
 	if (se_cmd->se_cmd_flags & SCF_SCSI_TMR_CDB) {
 		struct vhost_scsi_tmf *tmf = container_of(se_cmd,
 					struct vhost_scsi_tmf, se_cmd);
+		struct vhost_virtqueue *vq = &tmf->svq->vq;
 
-		vhost_work_queue(&tmf->vhost->dev, &tmf->vwork);
+		vhost_vq_work_queue(vq, &tmf->vwork);
 	} else {
 		struct vhost_scsi_cmd *cmd = container_of(se_cmd,
 					struct vhost_scsi_cmd, tvc_se_cmd);
@@ -1332,11 +1333,9 @@ static void vhost_scsi_ctl_handle_kick(struct vhost_work *work)
 }
 
 static void
-vhost_scsi_send_evt(struct vhost_scsi *vs,
-		   struct vhost_scsi_tpg *tpg,
-		   struct se_lun *lun,
-		   u32 event,
-		   u32 reason)
+vhost_scsi_send_evt(struct vhost_scsi *vs, struct vhost_virtqueue *vq,
+		    struct vhost_scsi_tpg *tpg, struct se_lun *lun,
+		    u32 event, u32 reason)
 {
 	struct vhost_scsi_evt *evt;
 
@@ -1358,7 +1357,7 @@ vhost_scsi_send_evt(struct vhost_scsi *vs,
 	}
 
 	llist_add(&evt->list, &vs->vs_event_list);
-	vhost_work_queue(&vs->dev, &vs->vs_event_work);
+	vhost_vq_work_queue(vq, &vs->vs_event_work);
 }
 
 static void vhost_scsi_evt_handle_kick(struct vhost_work *work)
@@ -1372,7 +1371,8 @@ static void vhost_scsi_evt_handle_kick(struct vhost_work *work)
 		goto out;
 
 	if (vs->vs_events_missed)
-		vhost_scsi_send_evt(vs, NULL, NULL, VIRTIO_SCSI_T_NO_EVENT, 0);
+		vhost_scsi_send_evt(vs, vq, NULL, NULL, VIRTIO_SCSI_T_NO_EVENT,
+				    0);
 out:
 	mutex_unlock(&vq->mutex);
 }
@@ -1991,7 +1991,7 @@ vhost_scsi_do_plug(struct vhost_scsi_tpg *tpg,
 		goto unlock;
 
 	if (vhost_has_feature(vq, VIRTIO_SCSI_F_HOTPLUG))
-		vhost_scsi_send_evt(vs, tpg, lun,
+		vhost_scsi_send_evt(vs, vq, tpg, lun,
 				   VIRTIO_SCSI_T_TRANSPORT_RESET, reason);
 unlock:
 	mutex_unlock(&vq->mutex);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
