Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5D1C678D4
	for <virtualization@archiver.kernel.org>; Tue,  7 Mar 2023 09:14:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EDF0381947;
	Tue,  7 Mar 2023 09:14:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EDF0381947
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=jBkLBPts;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=Hdr3degJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V7nLPdWlsx0N; Tue,  7 Mar 2023 09:14:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 421AC80EA1;
	Tue,  7 Mar 2023 09:14:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 421AC80EA1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20B09C0071;
	Tue,  7 Mar 2023 09:14:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A941DC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 09:14:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7AEF460F20
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 09:14:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7AEF460F20
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=jBkLBPts; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=Hdr3degJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M00s724Lu_-F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 09:14:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3FCAA60E8B
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3FCAA60E8B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 09:14:16 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 32783kfn010503; Tue, 7 Mar 2023 09:14:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=9xU3t07MDcFCYcZqpLuRN8qEjb6yFuxV3girLB2vig4=;
 b=jBkLBPtsbiCX7J6OYakVPL1Fbhx7u/sGr10Wbuk5uBDksTRxEa7aFHeCwvNZZ83vjbxi
 VgluFiCWeUTuGAcyaVG3v7xa+rXVbStEb1mV9+SFwuCOLY0z7xlAEBX2L2w8+G7nPvsP
 neYVik4os8DZkcV8GRVIUNR1PrSYYBINXtWHYoZE+dDDS318t/aD0L/8TT7FJvNp+Y8N
 NkarljqbllNOj0o4VQA5E1CJUhl63YqYSdzVSSO49KH4Ma7CPcew6azagEza9ahfppcJ
 rTpDbJyY2gVMQI1+0KzG2CuPJjIXqV5RXRCJsL7I1ua3fH/5Pb42rrR7whFxMkzdregs +w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p4180vy7m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Mar 2023 09:14:15 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 32784E4Z023251; Tue, 7 Mar 2023 09:14:14 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3p4u05y2c6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Mar 2023 09:14:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVlK94ZsQ/lmGWxfkgfVuEjtJkWOMWrKYhgQj1l0+CM1S7nL8Nv6MgxrL+wuCZgpmM3H5ck6rYZgtzuY+RorDT/3FvUUpB9lvFyBFNzU2EykLRWPeGu4Hg8VHoPLeuOQZ8G3xwLMCoPA4qmtvQn7EpXkab0qmol+iSHkC7o0bD+2EG65IbxSRX4sF9Q0KWuIGhm5zG8tODC5leRP9cPF1lCALbFGL3nG+IKtzaxZPXFh9UFzxyFVko4dUIwmAf4g14IWpSGKzCT7MBObKEc3DBv8l0Eq+n3sSbpkMYw8ue8uNRd7/TDJrizFCoHDO+B5vQO+PvtXHF8g9vTPg+tE6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xU3t07MDcFCYcZqpLuRN8qEjb6yFuxV3girLB2vig4=;
 b=BP0VgrzDy0DeIrB8WsmYHewwd15UT4JkfldfYUa37HZhzNZib1Txza40VCow5KNzqNQcRMEkovspD8WbvQDZmYNWrur5hqRDfKaSwafhdJZEcCFRydzUzvwYuYINybCVIivGhUUHdNeRiPASArfzBkPwx5JaR/2nzUrjanwjUJ8v4T+C0VuK2sAJjL7XGqksps3FCh5pNlkyZ1fjOBhJ41F2z5Ke9aNEED/pdMP7h8QTJJ9xyXyPc7iPIleAtwn2nIh7Cbcpl+BG9kA9D7nJgtg4+7x3GEWHM0vbyY673W0HRCH8kQsznC/zDZRVI8jHyvbcF/lw8yhUZFn/9FQoMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xU3t07MDcFCYcZqpLuRN8qEjb6yFuxV3girLB2vig4=;
 b=Hdr3degJmZW5AlMjqi+yhRjf1XaLaDHxHDRGpI0JYJEj9y88T4K2GtYKALUoVlvBdUOR/+8sf4SpucOxXLIp+Id4JZZA7YAhQ/f09Hj6qEOY1GpvHwEB2/NX2ep5OwXhmtk8YABGSjPECQyitNn4kESF3JgM0aF0EEhLRMtQ2lM=
Received: from DS7PR10MB4926.namprd10.prod.outlook.com (2603:10b6:5:3ac::20)
 by SJ0PR10MB6431.namprd10.prod.outlook.com (2603:10b6:a03:486::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 09:14:11 +0000
Received: from DS7PR10MB4926.namprd10.prod.outlook.com
 ([fe80::9ee4:1e8a:76b6:959b]) by DS7PR10MB4926.namprd10.prod.outlook.com
 ([fe80::9ee4:1e8a:76b6:959b%2]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 09:14:11 +0000
From: David Edmondson <david.edmondson@oracle.com>
To: Feng Liu <feliu@nvidia.com>, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 3/3] virtio_ring: Use const to annotate read-only
 pointer params
In-Reply-To: <20230307035705.4479-4-feliu@nvidia.com>
References: <20230307035705.4479-1-feliu@nvidia.com>
 <20230307035705.4479-4-feliu@nvidia.com>
Date: Tue, 07 Mar 2023 09:14:06 +0000
Message-ID: <m2ttywzzxd.fsf@oracle.com>
X-ClientProxiedBy: LO4P123CA0677.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::20) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|SJ0PR10MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b076c1a-1140-4117-261e-08db1eec5073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hPCeN/j27QmMFPFmJ5UxRsipeRecd7KY1/ubey1+Erp9coLdFO80Ucc9NZ5vTbialFVise0Zqpuwb98E3ZfOInfdZSbtHljT+3snopail7tZ/tGwRZM4whFnIB6GzJp9J2Ka2woJJv50xM8OWP88iypOlTtmF9LfMH7ofc9cnFWpqhQ3tpERP5As2Gp4Ge9f9wfZWYT+7XM8icI3m1TOPlmFbUfJDxkn8KXSzXeg0PDzO3Ez+vebXPkASTmVxuREBtKdPre5nlsBGwdF9LWQniRHfu4dzrIP0buwKxH5zkiQyPjgz9ld4VFLsXM3OT8i669pwp37rUiLWgJghacF50r/b3UmdpyUUWEURmq0Q53ieqXcCCwIMf2qSoAyqGM9cL/JOn2HyOQFfsTpDX81lIGUSgWDEIc6Ej7a+wFU6oucc3FsWq2AJ/tXGU7wFlqBVq+mMKKh6axdGfrfmR3sJugudNAj5ZMd8R9dW5VH1CQmtE5e6THBGj/ES0eh4tNAzkgy4LGSfotY4JaeaWn6lgWj+yYKMF13erIfZqXvOwuDT4N6izVBGUA0vMiwVmIuql+zbVARbnGK7weRYiqfIA5OpvmSoaRhONWKsq/kWkLuQSO5vmF8PlDcaYJKunAB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB4926.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199018)(36756003)(4326008)(8936002)(41300700001)(66556008)(66476007)(66946007)(8676002)(44832011)(5660300002)(2906002)(86362001)(38100700002)(6666004)(6512007)(6506007)(966005)(6486002)(54906003)(316002)(478600001)(83380400001)(2616005)(186003)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5kSGT/FK1YLwo6PsEDUC6d6TK3LtBn+v2oolwrxI356EiYKsgqKiSYOGUn+C?=
 =?us-ascii?Q?OaGZGdR8huxh4oJhIkb9z2wp87tZ+NaCfjHkThR7dALyU/X8ysGMDMg3gThA?=
 =?us-ascii?Q?+QWXL3D3NEO8YMHJHXOeuCbj8bCiQH1/ncrsj4TFS+K60YyuvLjBXgr7q01S?=
 =?us-ascii?Q?ApHuIC5K3VUgv8SFiweCCSlJHubCFOO/WCTSzVk3Q6TDtY6czjvsTZdiMIkz?=
 =?us-ascii?Q?yoM9Dp9j2Sl817sLol4ScJZmxXk2pQkLqEO44W2O5QIEGcCaS6dFssO1S5c/?=
 =?us-ascii?Q?y84/q6/TQOWAixdRn/q+kRBF2datbf3ZYcKIlagDSB6/x0Bu0NuIkmc31jrZ?=
 =?us-ascii?Q?H0QKZiOMWZZXFoQKwLq69ohRPLslBGf3QLfJmjl2WOmIhSvv4i7zmHFG47dY?=
 =?us-ascii?Q?qOwlkoW83IGakhvJgDkNXu+60ksEOAE3ezNycHJ66nHKZPrho0sAfNxVRpWP?=
 =?us-ascii?Q?TUseXEhUUSQPGCDZq+PKyyHJi0Pdhjr7PRFKIjwtxDJSqu3vlCTOBekqPFTe?=
 =?us-ascii?Q?KRcTGy9rGUdFJv8B9fMY8zRFp1CpJHqY6O1b8wkPR9a2S2iIe42gm0wQnyG7?=
 =?us-ascii?Q?9ByP+ZDxrWtJWqco0JOdp0CbrvtORvMtxhEFFgC2iuzXwIIorXCYCjVVCQVk?=
 =?us-ascii?Q?QmtdnL1RawFMQWsaE56hiBipAEnAJgiqVkjmYmdBfEvg/7DGxLFEcukh7lKm?=
 =?us-ascii?Q?RrznpYx7suxrAYewKkveoA+QdJiWLWmocRwTtj9+4YVG12PyPGUQre1QWo+b?=
 =?us-ascii?Q?kWJ+FEdMmUItgt5YJkAIXyUvb15fIF+OXkPdbcnmKvtIXnAic4BITse1CBJP?=
 =?us-ascii?Q?zHJDcXIQIV1yUYzFGF+lWpA8ZYjXqKfWWwgE5uxPcDntjdV5hQn0/wA48OGP?=
 =?us-ascii?Q?wHMkisbV+zJLTEOySU+sor0oszBadgcUMIbjlcjAShXe/TZoHVpfCMmHzP0y?=
 =?us-ascii?Q?TZmwMaC0hAhbBoo44BicopqGkvgV4igUOxlwhAAHjCbvWLrSNTmmz5L9p3zW?=
 =?us-ascii?Q?LEZ5pNNXaWEmTWrulk5RwZveaCh8+gzv41nQlMUpKkFO+7IxAu2bWNK1bDQE?=
 =?us-ascii?Q?DauBLb3DzMTaReX5SUV2VpautNgrmk0U3aM3tPPBKTOkHzWcRDb66B4f3VXe?=
 =?us-ascii?Q?3F9+8MCu3daO82+Z4p5XzQGYhgvXGBcs8/tJD0LFNUICIKGWcVrBNec8FfGY?=
 =?us-ascii?Q?3YUHKTXNyDQr7mjzpJOqTsh2tGdC+gXw0eA82cSwmtWGDxROB+yPa6xTsdqo?=
 =?us-ascii?Q?xdKjqxSy5PgamVcZwjpYKsEO3f8r6IbvkbH5l10R3h6CTXA1ngZ6HcYex+32?=
 =?us-ascii?Q?m+yWUwDFZYeBIt9UJhvGS6+LEERhhFeqKZvby3iR3dc7yvR5SgNL49bTmvAY?=
 =?us-ascii?Q?UGTuuMeCnDcuZ/uufiNbiM88En2wMhhw1NdpuR4V9bIqJC4zQj+QLg9OB+M6?=
 =?us-ascii?Q?Qcxe93zj5nkalOw/cZA3FwKg/r/d8GzaWCikKkiZTcg5L+pFr626UCFKI5OY?=
 =?us-ascii?Q?yDHGOUObugrZadLvzLJyS7vZaJDBb17nWzDJqAoSQuz58FATWoTkIHr8ouB2?=
 =?us-ascii?Q?kQ5i2ks969nteavEFy1v2eKVvYzc7HZ68MMqPe5AZ7JzGCaGGgq5f3OErj/n?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BOFhThoe0rBPHPxpD3JAyjaWcAAg+Rv5csF/jagk81pK9jPNVEOVErSoUc5U7l+mBWvHIfhoydnYLb93qmY531flTk8kt0qIKeCuM4NTTGmc9SyxTBDX8TZISuglR/IRcro70TyCN6sFN/aNaccR7jlCsVPI2RUBowWokqljqJTa10JAUD+i7/WgrjDZItLh+u3hKhCiVOJxMFeR0bxj8yRgyBBCCvQ8lxdJ/dKgpPLxElU0rY5lftI+oYI2an1DbCbEl71f1WGRAXey9pQ0hyDxwCpE7gB+ux0W7gQQAmL2mP87c/66sw6uVBnqDXkxJZq0E5kfcepzdm1x/lQOUnjAZfNS4CzR+X7LdXdJLN5sj9lSgxBsZLsX0Zyly52E2ZNh3gNP/f+8wffAot/FEbgZjktVtjOLh7+vEnmoqoPyPLgUrm+SOtwSVs1pCP6fzMIB0nutJDfSaol0psSVfrLVHEex9QBwJLAjRKm6O1us/H7neyKwcC3r7PIsIYBOtzR06SyM/eOOFD3vmN3u3lOnIez+razYjhH/z1quZBa4wdFS5c0ZhzK8GX94ZlGeQfj9dA5T2pBU90HsD83c+uHp8K2cQ2wHbDBY9RPy8kGmc1qsWTXDEEqdvD3Q7i7CWN/K9aK9wYTJi9IPoOhUXdwCu76MZDZJjZi6p51T/XNoX3QkCHJOAz5AluIK3/Jmg8H7CM1T2kvvmUwnQ32XWaAx8v2u8tZwC7mBf/EFsvCMdcrwOF1/X0yGBiTOPTOGlsTA5m/z1BHbSTdgQBQ/IlT2pPkfklNSxRc3VOeM3ztPumbOA70fGrb6L7OX3899PYGY5V3FzXk4t4FEnZfuFI64eZv7dp67ajwEtPeAuS8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b076c1a-1140-4117-261e-08db1eec5073
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 09:14:11.5614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bgZ882E/r562oB/ocbIskf4RxU8Q3P3F7M5ForU51Mj6AUqQDIYnTQRXmNmXJTS/Xebl888tK+HMtVLY4a+CCaE4UaIhEbd4Rfq6IHhkAdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6431
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_03,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070083
X-Proofpoint-ORIG-GUID: CDPJ5GaZgiHMMW08lbqwOczb3P0f7xD0
X-Proofpoint-GUID: CDPJ5GaZgiHMMW08lbqwOczb3P0f7xD0
Cc: Bodong Wang <bodong@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
 Gavin Li <gavinl@nvidia.com>, "Michael S . Tsirkin" <mst@redhat.com>
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

Feng Liu via Virtualization <virtualization@lists.linux-foundation.org>
writes:

> Add const to make the read-only pointer parameters clear, similar to
> many existing functions.

In many of the modified functions the local variable that is a cast of
the argument could also be const. Is there a reason not to do both at
the same time?

> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Gavin Li <gavinl@nvidia.com>
> Reviewed-by: Bodong Wang <bodong@nvidia.com>
> ---
>  drivers/virtio/virtio_ring.c | 25 ++++++++++++-------------
>  include/linux/virtio.h       | 12 ++++++------
>  2 files changed, 18 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 806cc44eae64..8010fd1d2047 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -233,7 +233,7 @@ static void vring_free(struct virtqueue *_vq);
>  
>  #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
>  
> -static bool virtqueue_use_indirect(struct vring_virtqueue *vq,
> +static bool virtqueue_use_indirect(const struct vring_virtqueue *vq,
>  					  unsigned int total_sg)
>  {
>  	/*
> @@ -269,7 +269,7 @@ static bool virtqueue_use_indirect(struct vring_virtqueue *vq,
>   * unconditionally on data path.
>   */
>  
> -static bool vring_use_dma_api(struct virtio_device *vdev)
> +static bool vring_use_dma_api(const struct virtio_device *vdev)
>  {
>  	if (!virtio_has_dma_quirk(vdev))
>  		return true;
> @@ -289,7 +289,7 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
>  	return false;
>  }
>  
> -size_t virtio_max_dma_size(struct virtio_device *vdev)
> +size_t virtio_max_dma_size(const struct virtio_device *vdev)
>  {
>  	size_t max_segment_size = SIZE_MAX;
>  
> @@ -423,7 +423,7 @@ static void virtqueue_init(struct vring_virtqueue *vq, u32 num)
>   */
>  
>  static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
> -					   struct vring_desc *desc)
> +					   const struct vring_desc *desc)
>  {
>  	u16 flags;
>  
> @@ -1183,7 +1183,7 @@ static u16 packed_last_used(u16 last_used_idx)
>  }
>  
>  static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
> -				     struct vring_desc_extra *extra)
> +				     const struct vring_desc_extra *extra)
>  {
>  	u16 flags;
>  
> @@ -1206,7 +1206,7 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
>  }
>  
>  static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
> -				   struct vring_packed_desc *desc)
> +				    const struct vring_packed_desc *desc)
>  {
>  	u16 flags;
>  
> @@ -2786,7 +2786,7 @@ EXPORT_SYMBOL_GPL(vring_transport_features);
>   * Returns the size of the vring.  This is mainly used for boasting to
>   * userspace.  Unlike other operations, this need not be serialized.
>   */
> -unsigned int virtqueue_get_vring_size(struct virtqueue *_vq)
> +unsigned int virtqueue_get_vring_size(const struct virtqueue *_vq)
>  {
>  
>  	struct vring_virtqueue *vq = to_vvq(_vq);
> @@ -2819,7 +2819,7 @@ void __virtqueue_unbreak(struct virtqueue *_vq)
>  }
>  EXPORT_SYMBOL_GPL(__virtqueue_unbreak);
>  
> -bool virtqueue_is_broken(struct virtqueue *_vq)
> +bool virtqueue_is_broken(const struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> @@ -2827,8 +2827,7 @@ bool virtqueue_is_broken(struct virtqueue *_vq)
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_is_broken);
>  
> -/*
> - * This should prevent the device from being used, allowing drivers to
> +/ This should prevent the device from being used, allowing drivers to
>   * recover.  You may need to grab appropriate locks to flush.
>   */
>  void virtio_break_device(struct virtio_device *dev)
> @@ -2881,7 +2880,7 @@ dma_addr_t virtqueue_get_desc_addr(struct virtqueue *_vq)
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_desc_addr);
>  
> -dma_addr_t virtqueue_get_avail_addr(struct virtqueue *_vq)
> +dma_addr_t virtqueue_get_avail_addr(const struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> @@ -2895,7 +2894,7 @@ dma_addr_t virtqueue_get_avail_addr(struct virtqueue *_vq)
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_avail_addr);
>  
> -dma_addr_t virtqueue_get_used_addr(struct virtqueue *_vq)
> +dma_addr_t virtqueue_get_used_addr(const struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> @@ -2910,7 +2909,7 @@ dma_addr_t virtqueue_get_used_addr(struct virtqueue *_vq)
>  EXPORT_SYMBOL_GPL(virtqueue_get_used_addr);
>  
>  /* Only available for split ring */
> -const struct vring *virtqueue_get_vring(struct virtqueue *vq)
> +const struct vring *virtqueue_get_vring(const struct virtqueue *vq)
>  {
>  	return &to_vvq(vq)->split.vring;
>  }
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 2b472514c49b..36a79374e735 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -84,14 +84,14 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *vq);
>  
>  void *virtqueue_detach_unused_buf(struct virtqueue *vq);
>  
> -unsigned int virtqueue_get_vring_size(struct virtqueue *vq);
> +unsigned int virtqueue_get_vring_size(const struct virtqueue *vq);
>  
> -bool virtqueue_is_broken(struct virtqueue *vq);
> +bool virtqueue_is_broken(const struct virtqueue *vq);
>  
> -const struct vring *virtqueue_get_vring(struct virtqueue *vq);
> -dma_addr_t virtqueue_get_desc_addr(struct virtqueue *vq);
> -dma_addr_t virtqueue_get_avail_addr(struct virtqueue *vq);
> -dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
> +const struct vring *virtqueue_get_vring(const struct virtqueue *vq);
> +dma_addr_t virtqueue_get_desc_addr(const struct virtqueue *vq);
> +dma_addr_t virtqueue_get_avail_addr(const struct virtqueue *vq);
> +dma_addr_t virtqueue_get_used_addr(const struct virtqueue *vq);
>  
>  int virtqueue_resize(struct virtqueue *vq, u32 num,
>  		     void (*recycle)(struct virtqueue *vq, void *buf));
> -- 
> 2.34.1
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
-- 
Woke up in my clothes again this morning, don't know exactly where I am.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
