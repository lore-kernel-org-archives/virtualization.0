Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893CAC678D4
	for <virtualization@archiver.kernel.org>; Tue,  7 Mar 2023 09:10:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EED2360D52;
	Tue,  7 Mar 2023 09:10:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EED2360D52
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=PcM9RWRS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=Wx3aJSL4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RIMUHbueuHZp; Tue,  7 Mar 2023 09:10:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 63BDC60E22;
	Tue,  7 Mar 2023 09:10:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 63BDC60E22
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B63FC0035;
	Tue,  7 Mar 2023 09:10:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5DA9DC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 09:10:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3D7128198A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 09:10:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3D7128198A
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=PcM9RWRS; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=Wx3aJSL4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 55ExP9yk0CyJ
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 09:10:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C656C81334
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C656C81334
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 09:10:22 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 32783rAf002140; Tue, 7 Mar 2023 09:10:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=yxDq9vqBvFDUXhXSr7x1jUj1MmCwaaV9Ky2OiWqbmWw=;
 b=PcM9RWRSNz3KnjkfYmZscq+xnUNbZSOH8JknqTuvsAXmu1AtBrhUJyj1aPpH3oWgjIR7
 ybJUIBgp4hD2L3QnSwi+afJh5KGmxUIlnhwF9TrH0ZaXHA/Axbi0KPiEGuNB0MsIEur2
 CFMJN4ieiUBEoC1as2Oatsa3YihCaV9L7/bZOLpwk27qfM09wwzPeKbFJqj/fWANEsy6
 KnUZPML18RZ1q6VUQ1oDO/PTe6RXAQ7WoqItSfZzEPeCn/MBVjJslrX4REOJUxjdCKYE
 4v4agpK8CfhexXTNhTs2lrnzd1Gs67BmgTlfCBC4dWlYyf0WkjmsfSlHQNd8qq7zKUVk pw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p4161vx9v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Mar 2023 09:10:21 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 3277bFY3026637; Tue, 7 Mar 2023 09:10:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3p4u1eqn4k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Mar 2023 09:10:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8QeZs8LJ+IcPPZ7VR7SrMc0MoY3qmnSg7ileCNtoW32pyKv0/sv9lkeuhjgl8M9/GL8cNbYpsXbtn+eMb3L4E+99nyx94fypTHh2ub5lZ8Ej64iwBiZlV+yw1PbomZrfTGBGrp72r7FM1T99PTpCwOjs62uxxUwFuuIrvd+sXqIwmGw2wjX2u6PohFCjPgDpak6/yx+K6yM5+z8vvG+6IFPyydtjHbGWbbF86b+PSgo7h9Bx0xVWWs3Rrpm99jGRkVmTsihVSiq0XfKQk03BvAPdQWJpEbQKpWjFgMOfwSATxztf8sXvzhHUD4SHo+kAyVhocJhODhli5MYXJQHpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxDq9vqBvFDUXhXSr7x1jUj1MmCwaaV9Ky2OiWqbmWw=;
 b=LjU6yFXVooZczQS+wLTtNjneBCPN0KqiveGkh3y8XhFe4BwNaOeG9t0XW9czP38dgeL4ygrzdwbneHwCow3AT/RjAaRT5KknLnRSBS+iKB3mVyoCxr6iILcjqjgKTr4/xo1LwdyYE+0aukZFf0D31XL1djRPs/iS0J4CzwWt5D5vDcNqkwf2ae8qhH1ltFr/IKLCQjklO3vNI+/r/L1rSGo0RfpDQVuW0KrrBZ/AuM/TVL+4WVFbUJSqLeJ3Ttbyu7S6soVa5nQ7D6/LEaK43K769zz1U16Ehz8AF5KoqyJjk9skH5y7OYrZBcWzriIieEPxgH159DeUHpCoWrkVRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxDq9vqBvFDUXhXSr7x1jUj1MmCwaaV9Ky2OiWqbmWw=;
 b=Wx3aJSL4tsbNC5DbGlMUPLBkcARL1RD7jdWdmUWJgRXDqTN7lXQ99pg6s+7H2hT4qcZW12TXmM9S6mUXPxghhpGriyvlPDHnfBwAP/441Q74JCTfwLKdntkUZlqUrMMhGTXaeCF4a1f8E3pG6ze/EYBPzxL0B9kX74n58QAhwZk=
Received: from DS7PR10MB4926.namprd10.prod.outlook.com (2603:10b6:5:3ac::20)
 by BY5PR10MB4130.namprd10.prod.outlook.com (2603:10b6:a03:201::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 09:10:17 +0000
Received: from DS7PR10MB4926.namprd10.prod.outlook.com
 ([fe80::9ee4:1e8a:76b6:959b]) by DS7PR10MB4926.namprd10.prod.outlook.com
 ([fe80::9ee4:1e8a:76b6:959b%2]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 09:10:17 +0000
From: David Edmondson <david.edmondson@oracle.com>
To: Feng Liu <feliu@nvidia.com>, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 1/3] virtio_pci_modern: Remove unnecessary num zero check
In-Reply-To: <20230307035705.4479-2-feliu@nvidia.com>
References: <20230307035705.4479-1-feliu@nvidia.com>
 <20230307035705.4479-2-feliu@nvidia.com>
Date: Tue, 07 Mar 2023 09:10:12 +0000
Message-ID: <m2zg8pyljf.fsf@oracle.com>
X-ClientProxiedBy: AM8P191CA0010.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::15) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|BY5PR10MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: 178abaa2-b25e-4a8d-ff64-08db1eebc51d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nyrkPu0bkkl26V7OzXkpb9KUwd87Z2wkXVfqJPj/EC/50ASGtam5tnGs4yl6kHqEg5AHha3NB+pm0JUlVitKbDiVuKJBqzlJ0s34GUyVckNYe9wLqL0nDR0yATGJhBQF8EeH4mzih+FpXd2QkzTT6Xc2hB1snjXUW31poGyTKQ2tQZgT8hxcSBkRdSmjIamFU/0C0M3H0KZR22FhsIIpMDKAy6SLzHVKtCygNXxxAW5Fgv8jrfEQDB/blQFxF5HFi99g07KRyKrX6UNH9yA4rFidkiAdAszs+R/Kw0ve8ahMOHEKbgG5CD8QCQB9+OPqmwMaPRp7Jz4aSrVFbvZuN3rCJHFsAyhx0y/57Nk38gjDD8zDLkHatxeqafMktrm8pMc/pRjWX3FrOuSDQpHrBHPHN7GsUir3274bmo05DTToLLT9zyzpVP1uXAV/v1bSwmKJI1CWnYUm7DTVlTG/6WWWEo//uJ569sAhx7vFmE43ObL/1Az0UEtM6u/WNam1tuoTzSoVlVZdg2E5NjJYV69EnndLn+bclylzrc71toltE5Y7Bo1CEffB8F9pA9RdVQYTU3sux8nEE2onrVXB7dKHkMpmp3Tl6pN8eQnTyrCOrtqsyTY4i+ubVzxrhZJL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB4926.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(396003)(39860400002)(136003)(376002)(346002)(366004)(451199018)(36756003)(86362001)(66946007)(66556008)(66476007)(44832011)(5660300002)(41300700001)(4326008)(6486002)(478600001)(54906003)(316002)(966005)(8676002)(2906002)(8936002)(38100700002)(6666004)(6512007)(6506007)(186003)(26005)(2616005)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ehqC6ZgOKm+MajFA5jtddkSMx3ml3tbZGp8zThKb76dhdl3QvIXv+wXofI3d?=
 =?us-ascii?Q?ETmNZXZgSZvDfTKRyaU2V0mXAMmkDcmWSW7X0FTgy4O1B7FIymV1pEE1rj2l?=
 =?us-ascii?Q?NmTYrHE3NLvqML9pbKkcMIhUrJ75OYgftOF/ZlZ48HrsBLSl6O0UBqN22DjK?=
 =?us-ascii?Q?fe0munZjpgikJXqPDOPDN7BdH41AzDqXVi0cUpaz58cNdRnvoxxRF22/HcGP?=
 =?us-ascii?Q?+TVV/IkjOrNhdwzYoT+JAesUWHSA2BmB7rP2TH3L6MKWIlIAJ/glhWeFvBVR?=
 =?us-ascii?Q?HaUI5OnzJeCFEKGy0roX6TmcztCzmq5xhaDqILutTRzMUs/UHsQ4CMBtH4AC?=
 =?us-ascii?Q?CjjGKSTeqDkHKf261ci2RAXSgwinC5estS0nj+Esa3RDf0SBRzNeCMV6S5DA?=
 =?us-ascii?Q?tBLTUt7Jb4VjBRHzSn0fexGUvFh2CG0Te1iYPRMTkIFApOYhTQHTrNSEH56V?=
 =?us-ascii?Q?MSxi9mHqS0dTgfk/tevzYcqpHfy9Ain4ctIbfpNVPxWXgQfHw59TBuFmLNuY?=
 =?us-ascii?Q?VcV5uxJP+cEB416Oh0KOCdhK3v4EjKYzlBfbsrjd7JyS95l8Suzqfpj0OfRf?=
 =?us-ascii?Q?0MIOknQQAAiL9CCGpke/BKysNAtR0QLKcabOMj29D9CDwnWZmo9fKRJRx1RA?=
 =?us-ascii?Q?bREJTHkKqkYFBq+DGYz7R8S8wQ6cGCJo+2TRfQGJQo7XZ7+izTi7aYAzvp0j?=
 =?us-ascii?Q?FnmIS0UaYnFBKSIeLxgveUTwbbWKtFLKABcQkZkAN4XVuscShFbsiDdkKL3B?=
 =?us-ascii?Q?Rp89tFSG8YWbUGV+C7aK9DVveoE5DcEYAWqbNGIsvJ6AerhliCXDwf6BE8Ri?=
 =?us-ascii?Q?DhoRQCVYDrEd58lWgRl1d2MTQ2B5x3zROrwIunIGkPeWgTMp2WnDzY2WY62F?=
 =?us-ascii?Q?uPv3+uqD8k6zUOXCqVKF3dQRIbkz/XyP+kpAfsLKRMYmKV0dK4KJDjGxfll9?=
 =?us-ascii?Q?qWuqKABm00uW6YWBfwAzOjvCV6kejuDCsYtHohSRGkl2d+qeliFP5NvZbe2p?=
 =?us-ascii?Q?+IeW07FRJfQtKLnz8Hi0O73esL9r8jFugemAMetvlGsNJeh7xYRbNU7aWAUD?=
 =?us-ascii?Q?d+DLs9grmnvmF1Dfchv9hcT1Id3dQXtI4bL6IJtGInZSHGOornhCHr9nMU5l?=
 =?us-ascii?Q?WaAPL6XuZRiqMbhbnLNgXmonIMZuenM+cpOrQcuOFtfW96/bwkYOEysWGFB4?=
 =?us-ascii?Q?yB3qXowXk9/lqiyXQfDOOUPsw2PHI4NyYxnnAoZwl0ZLIv0Qp18JfE6riLAg?=
 =?us-ascii?Q?rddHN4ndVTDFDVcoLNisLHgxlP7XoNPcpA3h+fv4djj20JRNe1Mr2mLliXDK?=
 =?us-ascii?Q?+j7yk1Voy7ojRHH+QnL7pOjqXGbxmMINCIcssU7lYDHWW4LXRd01e/u8Sm4o?=
 =?us-ascii?Q?AwY/SZpdLTFPeTILu17t1GACr9ONUfEXal0OQAxOkbuwya4tvPksjPta+wuf?=
 =?us-ascii?Q?2ReCAsozYF+tSYp11qP9OYNoQ5Ss+ZhJe2R3paSQQ94W4IOmfQtxmEpt4cpy?=
 =?us-ascii?Q?wckyWAAT5utDrFqSKSMUL09D8Grg3CvjsueuGufDoiAiaa1Lqk+udhTtyNaS?=
 =?us-ascii?Q?nppIPGmG5WF7oaYJ78CAzp7/GIMnaOVv6Gmp8+n19wXATSMagLApN3oMp9iw?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aXhf/sjad7dy9w/TD9ou5w/6IADovRXIzh/D0AXP1Q9zNRMPSVGuWQuU2iisVQVnvnf99nKd+uyvadLDVr3wIeB3K0+a52pk/rsnvgj8IoDvGneWKh4weCEryHDa2sav4PmW/gcy9jFnjfnU8M2myb6hyV7P96EWmaAlxN70DTAzBiMDsG8v9//0CoaTMuShoNIjxis+Urr7CGd8wC1gUnjdsUctVmyFLYYexKEPYudljX89z9R87qgszH8e5x6QiNg+scWh62kVovuOKRTdTrEnki9MffTZdXbBbwxtxbZ934p7mwcw5uvJMpz7ZW6vtOMlCa6nfPFGZWFTalT66Cw5EIuQPxVY1CUYWiNykPE499SHAcLUFsZPBSY6BR3K1Efb66ymXEBPG/RdJ+dPp7FgOI61nnV7K4IK/2oQJgjzW1s25oU9VtkuYhnhN9FO2po9c76Ohs2KLysIKvYK4yKTUjtTnQaZf5putjhFdjP+s/SEQqjoqops4Ptm7ZqHL9/7MeFlCFEfYsW8inx3sZPx1T1Rym1qSdYmkeePyIFKZsWNpCopp9poHGbiRj7t0je4fQ8uU2oVcSg/AWx0JLdikFtjCOc9No0B6POIVm41Dn/LcRL5DC5YUHfQ8pZrF3Ynye2nQTI6ZZxF+cigkMTxNVik9/czuIdME/YpkPUFgyFARugUD5QNahknImXRPG+W/QfCBfMFD9obtPX42wwg+ESJsi3nNiS66jsQbhlfGu/lDv2QQssxp9kXG0E7Amp+COvuldCwEHwnvD6R3pp50Cm/dSzg9qHCPMDZMO1Wm0Q5K4zeQDiYtjx9O+2EJTq42wh7lJ+YfVR/0/m5QVnmdD3CSABGHes9IrPBbNQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 178abaa2-b25e-4a8d-ff64-08db1eebc51d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 09:10:17.7375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vyWyBdQUM1H87fmcu0B8Rh//sWoofZkFIshMAAymGZ96rJRnmtzt/V8KcmOEZVpUTKIKj1ojxTQda3Li7MznWVgBEJyi9pD6RtgmhFXTHqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4130
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_03,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303070083
X-Proofpoint-GUID: 7dQhs5_Ce9bYAMD5Av1uP3Ae0XtcJS_I
X-Proofpoint-ORIG-GUID: 7dQhs5_Ce9bYAMD5Av1uP3Ae0XtcJS_I
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

> is_power_of_2() already performs the zero check. Hence avoid duplicate
> check. While at it, move the query of size check also adjacent to where
> its used for the disabled vq.
>
> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Gavin Li <gavinl@nvidia.com>
> Reviewed-by: Bodong Wang <bodong@nvidia.com>

Reviewed-by: David Edmondson <david.edmondson@oracle.com>

> ---
>  drivers/virtio/virtio_pci_modern.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 9e496e288cfa..3d7144f8f959 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -306,10 +306,10 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>  		return ERR_PTR(-EINVAL);
>  
>  	/* Check if queue is either not available or already active. */
> -	num = vp_modern_get_queue_size(mdev, index);
> -	if (!num || vp_modern_get_queue_enable(mdev, index))
> +	if (vp_modern_get_queue_enable(mdev, index))
>  		return ERR_PTR(-ENOENT);
>  
> +	num = vp_modern_get_queue_size(mdev, index);
>  	if (!is_power_of_2(num)) {
>  		dev_warn(&vp_dev->pci_dev->dev, "bad queue size %u", num);
>  		return ERR_PTR(-EINVAL);
> -- 
> 2.34.1
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
-- 
It's funny, I spent my whole life wanting to be talked about.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
