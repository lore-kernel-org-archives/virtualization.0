Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C30EB64D9
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 23:23:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 53CFC81FD8;
	Mon, 26 Jun 2023 23:23:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 53CFC81FD8
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=qUhTZ8kr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=j9797MO7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EkZCsRdO-j5i; Mon, 26 Jun 2023 23:23:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 810548138C;
	Mon, 26 Jun 2023 23:23:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 810548138C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A24EC008E;
	Mon, 26 Jun 2023 23:23:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B3C2C008C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 27929405A6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 27929405A6
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=qUhTZ8kr; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=j9797MO7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qsh2LfCoMZnO
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C5D8E408EA
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C5D8E408EA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:31 +0000 (UTC)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35QN4l6F018431; Mon, 26 Jun 2023 23:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=ymTxFAy96gmQ1Rg8fdITb5vFfY4ciD+tLMWaTUW1Jhc=;
 b=qUhTZ8krjrBNMzmBtfo+j4Gct5XyStVyr1jolkOHoC1KMfbfjGWCkOmDhy0uL5EfydpV
 Lr+98Gj8YqTkr+tfZWuaX1Xt8dpxEFqo8HqGpLCKrqEnjbn5RMgpyQYdms7eBfprq1Mv
 EOqMNmLBF5ICLvNFFjQu7Mu0xHK+rQnoV0LxLdcV4byzncNTnZv4qHY38Z024NbYqHfe
 H8e9lLj6HQ+uJVnsESznn8cqofQbDXXnBgg5XrwTanMz/DtbfaCeYPia8teQMx2BIApv
 9f2LlRRi3kpjugr04rKV3v2oTeJELKGBatf5a6BnI1H4o3K9AAkIZtqqjNiYmnSvDERZ 0Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdrhckvts-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 23:23:30 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35QMFOj4026326; Mon, 26 Jun 2023 23:23:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpxa88ep-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 23:23:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbFQ9gy5MGbGi9Hojx9gh8Hl6ctz3sbp+XiYPpNsuy3u7z/QNHoCauC0Xb/zC1RO0PUMxqmDEU2MYz93fKOuuyW74CcTICRXY88qnenqHqOs0kFDMgUqaDKxIuEEdIQbvfxAe610amsqZ1J+j8Uc6DpHyNhvJdOgXd++DPiPLuYvpzAtEX5h+niyQD4WjnYMQE7caTEnadMex7YFspe5PVihnNLQIhOdTysZ8gvZH8kik5fIT3ZnQBt/6y7vTAkNAmC30wlkhCevH2HwGLZBOtYUqBL0mLt+PvZ7Vri9BpVRaNz9COHrlfPHPF5UuX/oF8ePdEjGC6tZPrDtcN9kcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymTxFAy96gmQ1Rg8fdITb5vFfY4ciD+tLMWaTUW1Jhc=;
 b=e/0q1wndChfzJCoLrFHfnTmGLDu8ZAxeyfPdGNQOLT5TCTFia3V/GLkntlMGQ/+NIutEiPeaat+th/MShQjFxLYElXS2id1K5euKMvMmRAHlHpxce+wY2I0+MrtYGYWqw0eBLtRdBaSsVV5vkV/xMDVZyxgHt94z8wX0167zhyBS621OlCOcKRX6U3WADQDJatGt3DDy6wLeYbCHbDot7iS36WZ9qFj72QMoZPpaFlTiQAzZTtRSL42jPKZB5CUymM+NRe2r07DajpQFEQ97kl5KzuaeI3/E0bfp9fmzbYYmTDzY8NLqz/O4B/Jf/9hiLnzzKLuV+2Unm8rhTjY7Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymTxFAy96gmQ1Rg8fdITb5vFfY4ciD+tLMWaTUW1Jhc=;
 b=j9797MO7HnF4IAz8/QYmppAONKpMN9Ayox9Epk0MG6k2cz4StOm+JsNiTOhhsGDSj8J2EQao4E2bMRVf9pL8GC3FUwhRoQivkhNG1zTutV8rBLyLoWW+szzr6+DqekN7v/iegcPGQpZN5d+fgyR8fP7ZI1ZTYB4FOUey4m2/lJM=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CY8PR10MB7377.namprd10.prod.outlook.com (2603:10b6:930:94::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 23:23:27 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa%4]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 23:23:27 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v9 11/17] vhost_scsi: flush IO vqs then send TMF rsp
Date: Mon, 26 Jun 2023 18:23:01 -0500
Message-Id: <20230626232307.97930-12-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230626232307.97930-1-michael.christie@oracle.com>
References: <20230626232307.97930-1-michael.christie@oracle.com>
X-ClientProxiedBy: DS7PR03CA0311.namprd03.prod.outlook.com
 (2603:10b6:8:2b::23) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CY8PR10MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 190482a0-5059-4e11-ce74-08db769c5879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ru+Ard4CMJwggoMUJNrwekeTQgtvIDrXBtrjutk2198No8hfVsMZJbZ4+zKgU0r4aeWTlZUNtK+wbu/CeIiidgDWjjzduR7vY+Uo0Nfs1/j6BvOhesKHC/lVMflIz4TGhVJTnmTDcFdgKi01LrJ0F2WNbQQjdU4rbKoNng2UFEzGhOEjm6PzpIsl5QDOirrlVdP9abpu+0Tp06lAuz3XKgO43wUGxMwojR3se6RvSqJaqP6MhJRKUI4yfPdQa+ENa2VZymJG1+lu4rEUy4V0ePnZrcGFWLwmFKuKrkSTWjhrqNbQ6wMbt31FntBGFCWHyK2+G9ieqZpkHQR67J/AtJxHn2VM7mCPDVRR0PGbGVwSx8WhoQ8IUfVeNblIPZ5z0hAnePPJc0M/0IHhKL9RQT1GkFqHk3CfDht1BH/VM1vqNk2RBL0rck80x1IO3cUKMy5wOxy871SJTss72wh5Xdrm/TaCra6l+LmgagTJqLNSpQJBvHGnIzr/Ngpju722LcFv7NTIiMAyG7R8IK9ejoyXFO4BC5MFbcFSVELsCqEvOdOCzi+Ce8LnCARzaunIQBh0LS4EZ/ldgGEjObq6okO8SDF+AetqDGYB2igJoTs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199021)(5660300002)(66946007)(66556008)(4326008)(66476007)(478600001)(36756003)(316002)(8676002)(8936002)(2906002)(86362001)(41300700001)(6486002)(186003)(6512007)(6506007)(1076003)(26005)(38100700002)(2616005)(107886003)(83380400001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YxsYjgvhFkstLF1lxNAt5o39r6eU4WriPMao6BhUJYBgQpoi3JpvtwuK5xXI?=
 =?us-ascii?Q?6YW/DocSMGz16VpXTWv2em3+znqfOAlf73jEM77z4c0piG04yDgiCvLHPHgY?=
 =?us-ascii?Q?WgY+PrVDSIpPp0EljYAqqERrasRLNFIwmoKwpvocgg8/Lc4yjQ94dBVeTzSR?=
 =?us-ascii?Q?gdSLSc7+yKCIMxs3XFkqyjNrujl3/zdADx/0xtBzNZdBVWuNbwMQqS7/O15d?=
 =?us-ascii?Q?B6Z9JJC+h2Jd6lCTfSwQPViGcJffOp/jGdwdSv2FevMqDWEYbO67BFfdAbJA?=
 =?us-ascii?Q?xUQF1Bj0Ngk+Zs7vevPWKK0eN05T2VnQ1Vihrt3I+DWyRwh3P/Rae/wPU3OB?=
 =?us-ascii?Q?GVqqQbarwSKh1MgsU3wL/tusB9zqIlf+SeCYCvJUxYug9jMZcfVMlk4ZnqVL?=
 =?us-ascii?Q?y9GyA/qxkWVqcwx7QzYVC8jFvvH8l3LytgwNc1zveQbL60Hgy4bUCWPG02It?=
 =?us-ascii?Q?xQLKitHgdFA3WC5AM9MUZooPR9jKIlPMQAj2qse8sQred1w/s65UXQStgSHh?=
 =?us-ascii?Q?VAMH5/jrxVwXrr9MhEr3Pnm9rwh1O83NkjhjilRWcHbuL9KoSpxP95qjCqxA?=
 =?us-ascii?Q?xMlGzWwm/lPLKiDTFiUmpUjSQ+VtvqsKqBBPHOkyOMHbApvN0Qe4gUSKe65H?=
 =?us-ascii?Q?zI5nvMKsS/PoBMo6ZhbUwM2F0hRGOQNDGOGLiqV0No0E22htFSVVJRKkaAM4?=
 =?us-ascii?Q?NqmY4rFyc3K5JvfhHipUzLmeFq89xMepTD5OKAjUv9IIgOBtLXu7qX6HoX2r?=
 =?us-ascii?Q?3wfgR5e1FI6Y7SWbQTZhIdaXNAdJHVSfc1HzTVw43McDNQoNjLvL+5UXpy/v?=
 =?us-ascii?Q?mFddDr6brQbEqcd7LEhM/+3hZB1Sxi82WWd3ucoSvSItELPnwTKTPEyQGBlG?=
 =?us-ascii?Q?wIWRWj4CFBANgIDFkwMjk/DVEiscWvc5yDhoQ+6LfrQ2tiGjGUmGFxaWB0wn?=
 =?us-ascii?Q?/TE27KP5jW1wUhV8hqo/deGyWK79EXB7Al4tZz0pXZPtcarG3m6zDKGq7VXI?=
 =?us-ascii?Q?vqV54GvLFLksyabcqkW4TgtRtL1PsQy1/YlNsvGDB4A3I75+hPu1gLSJhivM?=
 =?us-ascii?Q?1U+wbT3e2FjlTO8IbSycINpC84g6jY8n67lnXSbS+5r15zl+rAGAikpKiGAs?=
 =?us-ascii?Q?NmdrrpRRIIbX0DSCCJ2lh8r/XnvCjGv6DciI0xuR57mTCW0BLnRdD6Kx7j4C?=
 =?us-ascii?Q?JSrBw5kUjV3bwXXAsip7kLj/TyqOQjz0LCjcxdxdflo920CmS+c04YXcq79e?=
 =?us-ascii?Q?4Y4LQ6B93VaI85EjLx9H47gAQgE6HBVTficVyeZ7UHGG7Z2LOTn1PHY2i5me?=
 =?us-ascii?Q?dv6PKdjxZoooPrQ06meH1IvXubzp1litIz5l8ALgJkw3TGqC/cmGjNdiYrIB?=
 =?us-ascii?Q?ESK89w5OrlhTVbCpTMpxgoJTqaQeUd08FP9sEFLzmGnUg/oPhc8jXRW9tsZK?=
 =?us-ascii?Q?0I0Mjge0raW+tsDq+UTyWFx9bQqFEqoxgWcFLHZ3YyrZs+BRzAqe7E5a2/Ct?=
 =?us-ascii?Q?mZCe6WvGBh5OqCA03byByiobfp/QuG+P2yUG8oAs8K659n6SMEnZk19c5yLW?=
 =?us-ascii?Q?SMBzSyHAVCX58QeY9B6JlmpaPzfeTt7dKzu4G/dzeuVnyFetxzB4BXSocFES?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: axNRh5dlZ703sIe8TiOcy2igSs4LpntsrTUBufanvHQg0l1JWxI12k0NABFXMfCEWwYAGf7kNF98J8HAXsRG+2axwXUqGUbostPkPOsBszqtz8YBcXaNtyxc9Mo2bUwxtVVHBu5M5PDBiN3DRCSvP5PD9yErW1Uz6XY6H3zpCHIo2enR5ZgmZgcSDLMPiLC5YyeXcKuS8+foqAaiH+P+1OiXNcj693P/xpS3/Ijd6p8CMnaOK0sG3eILwe/hi8V7Dvkynp+Jcje+SPAdaIO5rJw9w3eFwW+9qDJ8luQ9Pj7GMKmJ8RzB6O5cDC6HZvvJvLY8cYof9L+7t+cI5sZ9IH5FNS5snBnUv7u7Rns/5PFFvLo9UyRTfCWlTxc4BZwLjtCk2j7ZIkOBmwem3CCVevWxenVeC9u+HfJtbRMr8djTgJ1HojuSMb7DwfZEkkZ7VxYXZF99JKjG2KN7JBMBlz8X6OwXwn3/mxXyffNG57GeyMTDROXD1XHJIsjabTtlDDtMUfgATKzM3rhwq6cSZxVK7DxghQ2c2Ls9fmsGaaCGNRfXs6vub4net/+cJoUNkXaOP5yNrTsGEtsEHebVasz7fMMbLTVcUNXjs+MXvafp84iwehyJy0GznnuuB6RSn3kfvl6ibslJ1uMmXK7s6jW7uJgGHag7vTS7pNFbby+kliivPN7NNmSWnpZ8U+tFtyrXKwv/wkkTjOX5GF2qLP8eWjfhwPZ9jo5U7i4jkzkgQEKXsmGV3ISb7FolK4ba/5OlCZUjhtBW0UCzDPziVT3LXExQRiFiKJAubLANtG/wMKtbV6s9rn0q9yIOfM9N
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 190482a0-5059-4e11-ce74-08db769c5879
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 23:23:27.5430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6iyLQsKsYIA9+pdxfy4D0pSFqEJ1AjhzmNGw1OtX1Fp+rzhdX3JHkLk7QUKVmvGzPAqzDpsS+GvapF2ketoEfv2cKuU3CAEKFVQ1+b3PQqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7377
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_18,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306260218
X-Proofpoint-GUID: l5f1Osa4NQGKNpE_M3EZ7y4U1B4jaxKB
X-Proofpoint-ORIG-GUID: l5f1Osa4NQGKNpE_M3EZ7y4U1B4jaxKB
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

With one worker we will always send the scsi cmd responses then send the
TMF rsp, because LIO will always complete the scsi cmds first then call
into us to send the TMF response.

With multiple workers, the IO vq workers could be running while the
TMF/ctl vq worker is running so this has us do a flush before completing
the TMF to make sure cmds are completed when it's work is later queued
and run.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/scsi.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 1668009bd489..2c3cf487cc71 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1133,12 +1133,27 @@ static void vhost_scsi_tmf_resp_work(struct vhost_work *work)
 {
 	struct vhost_scsi_tmf *tmf = container_of(work, struct vhost_scsi_tmf,
 						  vwork);
-	int resp_code;
+	struct vhost_virtqueue *ctl_vq, *vq;
+	int resp_code, i;
+
+	if (tmf->scsi_resp == TMR_FUNCTION_COMPLETE) {
+		/*
+		 * Flush IO vqs that don't share a worker with the ctl to make
+		 * sure they have sent their responses before us.
+		 */
+		ctl_vq = &tmf->vhost->vqs[VHOST_SCSI_VQ_CTL].vq;
+		for (i = VHOST_SCSI_VQ_IO; i < tmf->vhost->dev.nvqs; i++) {
+			vq = &tmf->vhost->vqs[i].vq;
+
+			if (vhost_vq_is_setup(vq) &&
+			    vq->worker != ctl_vq->worker)
+				vhost_vq_flush(vq);
+		}
 
-	if (tmf->scsi_resp == TMR_FUNCTION_COMPLETE)
 		resp_code = VIRTIO_SCSI_S_FUNCTION_SUCCEEDED;
-	else
+	} else {
 		resp_code = VIRTIO_SCSI_S_FUNCTION_REJECTED;
+	}
 
 	vhost_scsi_send_tmf_resp(tmf->vhost, &tmf->svq->vq, tmf->in_iovs,
 				 tmf->vq_desc, &tmf->resp_iov, resp_code);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
