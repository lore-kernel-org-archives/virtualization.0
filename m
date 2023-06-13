Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4122BC7EE2E
	for <virtualization@archiver.kernel.org>; Tue, 13 Jun 2023 01:33:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BF4FD40C18;
	Tue, 13 Jun 2023 01:33:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BF4FD40C18
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=v3PkKXKI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=0S4ojfE/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aQKOYcwkTUSx; Tue, 13 Jun 2023 01:33:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E2B71405F5;
	Tue, 13 Jun 2023 01:33:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E2B71405F5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9DF4C0091;
	Tue, 13 Jun 2023 01:33:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C629C007A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9BCCA402D6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9BCCA402D6
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=v3PkKXKI; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=0S4ojfE/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WQJv4wYW1_JC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9FE06402B7
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9FE06402B7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:19 +0000 (UTC)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35CKNjBC020914; Tue, 13 Jun 2023 01:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=k9uUZB8kBxVHNzW+GZH/y8lvxR4Byhyzeg+JrnLzpYc=;
 b=v3PkKXKIj7crXAwDgEH94tG7v8cMPQEoqMWDCx1F2y7ulzM1cO+xepH+88siTBeXWx0W
 MSPf8rhiYA/JreBNhrXIFTtLpBbBV2S6LIfRAoVmQ/neM9tocCW2q/kBAbb+kCE6heTp
 kM59cPv3hYbNO9vwuaFT8FrNlNltFXI9n7sCVjMiSwkzF3UPWWfy3MqzOJJJoVhIqoXU
 1TrvBbSaLYmJrkolSpdhiepec+NoXqiPjPvmUslp0nVMoE6fodOoo97LAUDcUvaLlYIh
 sSbXw+vo71oZJ6VuP/HiN1IfYXP+FcADvkVYhTivDNtLB0a9zKo4tPrT7I0DyAAYXust aQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h7d451h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jun 2023 01:33:18 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35D1CJRG021613; Tue, 13 Jun 2023 01:33:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r4fm3hg44-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jun 2023 01:33:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENY5LKu7S8c+bMGj5vIb2DiOLma6fK3Zo8O79xsLvh5i8wvgIsGDfXJyTImzhJdIZavYHgFstS7HPoJpz4wDfvqIhAHjNAfkvlLHd7EjCjywc5L5Yq3DUCv3SkiqL5ZEVMNNbahiXiBiFnoi7QBKq69TFVyIovGxPIuuorHZUU33u0+iEvLg1kUk/I/2DYJNlPYlThK8YeVtLuNzIaGpvUuot+YtEXbt3xAB6/5iYZRlN/UB1RW1mrllYaPYO3OhjjDawvUY49Rnw9U8V2Ybi3Ntt+6W98tyAgqwp11WDET44Vx/RFDupJN8uKaZdtFPI39aQOv+Kz+RkbtwTYtIcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9uUZB8kBxVHNzW+GZH/y8lvxR4Byhyzeg+JrnLzpYc=;
 b=AkzGza4szHVRdLnepnT7lRdiJVi8mx/a9QSUstFNRbBEfDVwXrHUS/vJVCwDA65tr2CCAs2OBx2SkVAXQnCTKtYWykB7dASlam44v5rz6qh+BgReeuMKyg/Ql7eU5gXjJPEkq4InIh12yy2IegCuU9iQaPZYHFGX/Q0cBXaw6KnO8S2iBLyzOgvpT36jTdcKYZIVZtNlOOxGY7EthtHd6w8xiYHTve3gQieRohLuE/I4OZsRjkbzvHIK+2f5hm/mwqFtadHklEuQmsP+j+NM1DT26GIFI9ppfSDl7xlQg0LOXaJjfic1YGnJm4djOlINyfyRAi109zrW7d1Lnub9cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9uUZB8kBxVHNzW+GZH/y8lvxR4Byhyzeg+JrnLzpYc=;
 b=0S4ojfE/SWDE6FzIgtLitSCb2RdGGvNip5kkFOymh31cogIiGyowvWCqSUOqpTh2AlBBJUlTJOzWsVFlF6bRsJ4ywb0RrZDreCAFqIXmU10sw3MZjzEhweuIcWRjVsj57CjSH9xezYr4AMXvoJV8EFCnUNfks6rE9sXS9dYIIo4=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by SA2PR10MB4507.namprd10.prod.outlook.com (2603:10b6:806:119::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 01:33:01 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 01:33:00 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v8 06/17] vhost: take worker or vq for flushing
Date: Mon, 12 Jun 2023 20:32:37 -0500
Message-Id: <20230613013248.12196-7-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613013248.12196-1-michael.christie@oracle.com>
References: <20230613013248.12196-1-michael.christie@oracle.com>
X-ClientProxiedBy: DS7PR03CA0120.namprd03.prod.outlook.com
 (2603:10b6:5:3b7::35) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|SA2PR10MB4507:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b18b148-473e-40e5-4615-08db6bae2000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XsUHpFTQyPH757nSUjY8gGcGwdFY1HmVg5Sr83EpB1JahfOP+GoYNctEq5CjglIgk7M5f3uOfaZgqrdxhlLu0YGf9O8GVvO2QrWcRdhARHx9DTu4jGIDxjildZq4cTtSmn7jg/kE/NsZvQiu0+kQ08qYKpd6E3bOZSUzcdxcRIYM33mRax9BziPMR4DvaqLdSpCZtkoX4ENvnK1bAXdXoOzBgZX37zqfvopmzwjEqENX+NlNU7HvIYkPq0fcoxDg9d6GSKGHs8qrMyOfFyK78X4e97UeJ7iwjjEFULTXgNXOHqVKNYPpNeURfIJsLcrW3oJm7z85YBdrhDiVJWwdMJuTR0o20t/iYcCAi7SVjw9P5Zj2gp8LMBbalb8S3+ml8nmHc4bW7FTrkb2E56E8MwoylqYJuOdRN/vqTh3yhS06tdrdw/1mgPAl8bq3oAVfyRCdECwYV6ABkB9Jh4+zgeo7UBunoSuTW0YQ74hShd9cdEkZs+MLIL3kce1X7UtkLhfZ0o7r4SFB2o4ikXtvbgGihAKDVA3vVnPNYlGEknBrcJ64PjB8S3QHx6JpwS2h
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199021)(36756003)(86362001)(66556008)(4326008)(478600001)(66476007)(66946007)(6666004)(316002)(107886003)(6486002)(8936002)(5660300002)(2906002)(8676002)(41300700001)(38100700002)(2616005)(6512007)(6506007)(1076003)(26005)(186003)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VCnuN9rGTjfAyyTFuEbb1I6CWxLGPsQeYj15VcoSTOgqX01D98e6t3GyhkKG?=
 =?us-ascii?Q?bFGeTepMuDlerr9JEpz8UfhVggb/n6LlhvsVUw2pR+nMHlnXFCowYoZg8waO?=
 =?us-ascii?Q?WHM95Fg6SYjG1kaNv6lPg6l0Z+1XD44XoD3Q3oVh+JpsHUFS3Ia/35HXPObP?=
 =?us-ascii?Q?uWZlPt7LmPfmcOUc4SL25bxsaTOJPnLVuqPes86lvhQ1YZ9bKVn6CtiOJZ9r?=
 =?us-ascii?Q?AEcaCSK27fyKRz5gFyLtDAz+BP6UbSi6rfBNZ6DfvDzCEDKdjKGjYw7sB7q9?=
 =?us-ascii?Q?WcVl1lR7+K7VaJF12pghXP8duJGkF068zqoRIHUsoaPun/TmuprGFU7ym+uz?=
 =?us-ascii?Q?LOpVVgR1TGc+/+LlMCH4btWRzn9FviedNuzZSMtaMbTDhhi7JRU6fUJisuH+?=
 =?us-ascii?Q?Dcagwc1RJQOYXBR541HhDg4ZJrXy4y27KpirjL1SDJAfPy9vV1CXtrpYN82H?=
 =?us-ascii?Q?0ZkklP5aZagKHvASPkCiso+lWDIc92YpezC76Dzjw82d93AcIvlbQT/EXeAS?=
 =?us-ascii?Q?rs6rpvlhgEyvVyFASjsmTVq//n1RCw2P5F+jC73dTBo7ewBLeK0K8GBye5uq?=
 =?us-ascii?Q?4rfEnxFEMKzB+aW86erl1zPNXdMkzzB9+zO2G/68WnXZj5NjHnPHWy00vWVw?=
 =?us-ascii?Q?IP/JI6Cnt44U+nC9rzHnsDGS2jMGimxNI72hl3Yp14qzn8ietWJ6BsBlMu//?=
 =?us-ascii?Q?4oP/sk7Aul41ozVvJ7HupWHMRlTCZZoD35ndCPSC3ieGvcJuswOeWaoNs3wO?=
 =?us-ascii?Q?m4YDIcKf+Sux4c35zmCu20HwQuOTGACt8slzdWo4g8OCR7Lgv3BQ/+paISmd?=
 =?us-ascii?Q?nkMv4yDzu1pe4siQWtErdN/V41jCSUtJmUx46tNv19yR8aWkUp3n36pqymmo?=
 =?us-ascii?Q?UgE6BgBC2Vz2JG95UZYFG+WdwpP9ov+WDQ2IitETaqFQpgE8fw+4oO5o+iiQ?=
 =?us-ascii?Q?gEIBTCG67Ut1uHpSDzvfyJwAkevHo8np9rReAvuVpQbQVQ14UzJUxGUobTi8?=
 =?us-ascii?Q?olDjv4qR6yRM5XlQqASU3VSwpZWpK7KnUpwDivYZ0a2AfyRwyf4ARXxIv1No?=
 =?us-ascii?Q?u4I+f8q4y2NAAU54iUtCR/rrK44d8Vra1xdMHyzGxbEMOmuqvG/i62Qp4iRn?=
 =?us-ascii?Q?+CrgOSrOCmyq103ZFJKHrt7src99kNL2feJ33ykQgWSmoC2G2BQmAnERKUhq?=
 =?us-ascii?Q?HrjsWfZrDkt8EVXSa+3VoNhcoaMUvM2nDZ9Dol2mLGwtmUzIa6yRCQpuMuXa?=
 =?us-ascii?Q?Ow+CFIfVXuTxwG9qFlopOG+CDcsxjpgxPlc1E0d1EU2jhM4UF6pZl0Kq3aFG?=
 =?us-ascii?Q?tIoLm4T95xPvGbZmVlqrUgE0NQQJkk9jxAOR4zyXwaOYud3DZqEWxTnW5Jpi?=
 =?us-ascii?Q?cdsjkoxtlvUwdpet7JyYpUQNKmtLjLVFdJjTDCZFkVUWqjbIHvvX4yhVMEto?=
 =?us-ascii?Q?rxm1XXX3sIBGDm679hGaws6bnErGr/7/IWi2wuo39b1PBJN657pYJwUwVCHL?=
 =?us-ascii?Q?SgQBd6A+P9cFPQjwoXn9muHK4ME7/HCloG2Yglwde2X36/HEEXb+TrMrtND6?=
 =?us-ascii?Q?07OkqU6EgDgbs50m0HRUnXum+xv9KOpf/kccfkZJmz6UtApWVjm7qlNgbRKW?=
 =?us-ascii?Q?xA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pb437oDvzmeNnXMFyYjcfsjHAtz9j1hy9tCMgl7Pr93E8zzBP47+VHW8goQj7B2sO86DHXaOzulYpsMMgT3imCLJDrmiyuFmK3qJmLR8Zj6SUrx+uBVGhK2rFoo+wo20+u2EIT469Tr9ftXNKJk1j95OWY+tDMe9SOkKFI7Bwd/L8o07/WMPhWIBk58hirJpfjSFIo/j34N3jSmaa6RmYY4b6P09TjRzl7OIFh1CVmndcgvaPoZ1kkLQJduh+zoclmqyvzTIZOUsZFvtrpxcLngSKgGg2k4Q4Cf6PL14H6xIqFDwo2gjgmBc7x5Q+KXuGDdVBkmNzE5mHvEVjqOeoycmtkDfnkL2yoGfaH/GgaieB1rzw10LX7hPPbAZshqRZ3GEyeOHAw8jQ0uUrO8MAowGKv8UOVZ5KNlR3ANceo1RHcq26NMXhhO9SRNnn6P9H5mMM2p8+nJ2TK5S8Z4WS6eQAy5xYVHqgX0MbDEc/sG+Mhin02sPkYAq5GuJbhKOOj6avPYUSPLeE4Xvt8cnYwJqdnft8QHCC3X6vCBiVQeMDq+lkpANAs8tKFPBOZAf9bp0DuPwbfZwpxiZvHTanDczw4u6OkdP9zAvxsdX2rpbGy4px/BXEvgBjHaMACuMH96nyk97BDTSoQHdRutCGO/zcZVzRHWPNQY9heh8uhuAGmpQIbkk1UV8KbzdO0H9c65Nn6RSnGzDnE0KzvV5LEobKopVKm/VW6df94HcjXN4IE4GjQlWuDhSdhtU+maUHYfkU/h6PG1h7jFnfEuwl3n6XkLzjhuIlWxxqNcZDRBZLj27q/uN/OSaN5t0ra9M
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b18b148-473e-40e5-4615-08db6bae2000
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 01:33:00.9592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4e+LNduHhDtxz+62aE/S8tZbZpmX/bUt+0/M770xPtrjjPTehECcjZjUyfiDbnkbcwcEbMGIRcJ4YMQ7vbIZoj+Y/tnoZ9w6Xb4tv50zyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_18,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306130012
X-Proofpoint-ORIG-GUID: eANTBA3iZY34u9Pe4ZVdd_D_cZdGRLW2
X-Proofpoint-GUID: eANTBA3iZY34u9Pe4ZVdd_D_cZdGRLW2
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

This patch has the core work flush function take a worker. When we
support multiple workers we can then flush each worker during device
removal, stoppage, etc. It also adds a helper to flush specific
virtqueues, so vhost-scsi can flush IO vqs from it's ctl vq.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c | 15 +++++++++++++--
 drivers/vhost/vhost.h |  1 +
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 16630c19bcc2..d212cee064d6 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -265,16 +265,27 @@ bool vhost_vq_work_queue(struct vhost_virtqueue *vq, struct vhost_work *work)
 }
 EXPORT_SYMBOL_GPL(vhost_vq_work_queue);
 
-void vhost_dev_flush(struct vhost_dev *dev)
+static void vhost_worker_flush(struct vhost_worker *worker)
 {
 	struct vhost_flush_struct flush;
 
 	init_completion(&flush.wait_event);
 	vhost_work_init(&flush.work, vhost_flush_work);
 
-	if (vhost_work_queue(dev, &flush.work))
+	if (vhost_worker_queue(worker, &flush.work))
 		wait_for_completion(&flush.wait_event);
 }
+
+void vhost_vq_flush(struct vhost_virtqueue *vq)
+{
+	vhost_worker_flush(vq->worker);
+}
+EXPORT_SYMBOL_GPL(vhost_vq_flush);
+
+void vhost_dev_flush(struct vhost_dev *dev)
+{
+	vhost_worker_flush(dev->worker);
+}
 EXPORT_SYMBOL_GPL(vhost_dev_flush);
 
 /* A lockless hint for busy polling code to exit the loop */
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 6a1ae8ae9c7d..ac1f4924e548 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -198,6 +198,7 @@ int vhost_get_vq_desc(struct vhost_virtqueue *,
 		      struct vhost_log *log, unsigned int *log_num);
 void vhost_discard_vq_desc(struct vhost_virtqueue *, int n);
 
+void vhost_vq_flush(struct vhost_virtqueue *vq);
 bool vhost_vq_work_queue(struct vhost_virtqueue *vq, struct vhost_work *work);
 bool vhost_vq_has_work(struct vhost_virtqueue *vq);
 bool vhost_vq_is_setup(struct vhost_virtqueue *vq);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
