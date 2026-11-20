Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795194896;
	b=c2C2LBJHZ4Oui9PP8mklkwf5KMYFpe01zXqMCJ9ysc55EKIguD+GrzieLzM3eEUVas9j
	 eQG98xxVWdM++4fmexDSWYUqhK7m4VYwq4m0VtGTT3IrWKZz0C6m/5fq95Wr6pkUAHnmJ
	 n8vHbma0aSwGYvhoLAOYkhSFM58TrOj0zOcWZM6L2WYoYLvPpNiM8mg9MMzblNAOSAt5V
	 N/OED7AW1N/fSWE4Ipiy2TJPQWOX95ROC82LMB11Z/vWht+Aa3Z2KEkdGs85yrR4H9KOe
	 iwiu8eQ5cOLaI983yPEntQK5WRJfNJbQwpe6BtB8zMQ6U9qB5nGxeseLsT5j4tx1hrg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795194896;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis;
	bh=UwNBMn5xWkWtImugCqkMw9wKAf1K0twXjbxpeRDSmJ8=;
	b=wLEHNwDanOLPlgYXbHnyZohfKxC5wVncAgoG93MOPr7qs0KKxFZma0B2kIqJEbZO0LDj
	 2XSwNfLWTqhxro8lIZXMyd9+1bbQR+Yk445UCSbl6SibqzatR9ytIhge2yc5bxyNNO2bt
	 UnL2isgzpEPdmax0NURZ3/u819XXy7q8hLv1UMVFde8NyWBKXGCN8WhmTQq20HXP9cZmK
	 f41RmF3GkQt/rswspYvZzVSUAv3AjyBU/2ceggO716GmUuqXfoCkb5cZ/kFK792msOmnl
	 D0Tg5lAuSyz75KRtaeM6Vrnzl3oyEei0+GgB5YtakNT8NFWR54AE8BmVPq2ayAtRhcA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=bTeDGz6D;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=c4rb8TPI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3604D60A261C
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 17:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3604D60A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=bTeDGz6D;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=c4rb8TPI
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKGkdj0036929;
	Fri, 20 Nov 2026 17:14:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=UwNBMn5xWkWtImugCqkMw9wKAf1K0twXjbxpeRDSmJ8=; b=
	bTeDGz6Da5vGkiAuVGfp08o4LY1r5HgVGw/r21oLx+GafeaviuJnSfJtigbXt92h
	ZkM5IFqIY2GC9ay5sPLZuaXStihtzTrnIJSUSUP1CsRMO/2lImZvhA91GgLgvGgj
	q+tD2GZt31TbYFycMgh1myZFuT8KT2R3+muG9OnmwK/slD56SpYtCZw3trgBBUoj
	OdNfFZ89PerzYy9/9P4XirRucIY3D4ybVhXQEaOqyFj6cpNgJZwhxdLQtDmrv91e
	oQEY6iOWXkJKSuZiqx9Br5S7UVRoA7p1/ws0xX3/JIi/LPOoH+JKEt0jU63NgTKK
	/Phbevy0UYFkcTCi+hrwyA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4j0ytq515t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Fri, 20 Nov 2026 17:14:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKGqjaE525238;
	Fri, 20 Nov 2026 17:14:49 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010025.outbound.protection.outlook.com [40.93.198.25])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4j2r4qnp0w-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Fri, 20 Nov 2026 17:14:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCTTvlFh7SXmAK2utxDXzC51B5jV676TSLFPDeZQjp0lRvA1vbmj684t00xo3LbEprSNTBgaR2HpigxvEEydA9BdA0enrivKncozI7tvoIwu3mbBaf3lSMfLgxopka6flz8W+DjIFTxtEJkGu5Gtm5g4HX/0ap2sEyQQ/3MZOht6MWzTYVse0F3Sx7XnhUkn0d8gYkOHATnawdlUgKug/Tdffk1AGyoZZ7jChG+ePK1a/b9ozbz5XZUouNfIRE8cmgBR+n1SGU5TYrMH90NQhICx1Uqb/d8TJRF6fwllhuaaqmpNOMMewxi4criphtb9Ssz26N6K5on0U+kz/4wdHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwNBMn5xWkWtImugCqkMw9wKAf1K0twXjbxpeRDSmJ8=;
 b=yB8A6jY/zh4LZfNvOr7YUTNnBnZtAG7Qnzl4SXp5OQSL2f2tMFoYEpo3Mkbzng/mCjgrOXaQ5hL7Fr+boju2x/J7Yb32kTMFVvsAUy/AocNkTotmMyyFQFI5Xcj7TTzcmBtqoSvPGniayuxK7dwDVfVIpVXIaPNJvatJGbkK4U5ljLS4oSOlTO3T0vPrpnBXbKfLsjHSDGmhBteB9XymcpdNhMd+zQWZbI/Q68oL2D8EZSotELcqe9zwBAc7dHfYfJIkedhAZx/cJnrHDaEzxWuIon8wvTVTkiwccFmeZtmP/STeqKeurdUDTcuOxtiuvhpFcAzFnwHmBF6pL8kXdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwNBMn5xWkWtImugCqkMw9wKAf1K0twXjbxpeRDSmJ8=;
 b=c4rb8TPItw6hWxw2QPe6yfk6UuJUwiLH4qFB+zxv1Qx7zBX9IkZ7hge1IJ/AdC9GBa5eaWCckmniN7FXqBuO2MDiBnhcreSQ2mlc8grKuRscoGYz9lDBecRT1S3cA4QXd/mX+qVdOFIGORzVHiPOpcv3PWkUvpRc1cSqWWl866o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM6PR10MB4363.namprd10.prod.outlook.com (2603:10b6:5:21e::21)
 by CY5PR10MB6264.namprd10.prod.outlook.com (2603:10b6:930:40::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 17:14:45 +0000
Received: from DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::90f9:3960:8442:de85]) by DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::90f9:3960:8442:de85%4]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 17:14:45 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: mst@redhat.com, vlad.wing@gmail.com
Cc: brett.creeley@amd.com, eperezma@redhat.com, jasowangio@gmail.com,
        jkkm@meta.com, kernel-team@meta.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com,
        joao.m.martins@oracle.com, si-wei.liu@oracle.com
Subject: Re: [PATCH] virtio_pci: limit Oracle DSC2-200 virtio-net to 48-bit DMA
Date: Fri, 20 Nov 2026 12:14:35 -0500
Message-ID: <20261120171435.83458-1-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261119181557-mutt-send-email-mst@kernel.org>
References: <20261109184253.531677-1-vlad.wing@gmail.com> <20261119200654.1048266-1-vlad.wing@gmail.com> <20261119181557-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR21CA0004.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::11) To DM6PR10MB4363.namprd10.prod.outlook.com
 (2603:10b6:5:21e::21)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4363:EE_|CY5PR10MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: 7896c036-edbc-4b8e-9fab-08df4729c62d
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|4143699003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 BDGkmia2oLP/s6Wp61aCbftXhOmiU/wqN9Ptc7XT5lUI2gTZaa4zLQjnQuv2AeY0CKtm9Z0JWYnun9JXt0k4hPsWbFoWfJVNTPcWwm/Pf5shPFNSXhDfIwXGDfWUvD6XaqgT4j2fTDZjH4KHKkT+kt5B+cmG9p1JnkbIxcfMTRAeNNAd9vX8o488x8yPDRGS5Wc9RKbgoEVVZn9naOUQPukM3jZy/nVe/9UY4ESDD6uvF0oCE/H4IG8JOqN+tZSMdWBnfK1p0WdmMkTdu2DVlsyZOrmyrb9RtO5QXcpDYhhGw1WqaR1fFoIWLe4BzGJh5ia3p2OM5HXvCzx0QAJeoEPbIBQNB58mA33prtBmz0Bz04d5EA+CJk9a+i8MK9umnc+DQJbnlw53R4Tdykz8hZI2ajb4Xb6PU7Km03JIRt3+bK7z3cRux9RWI8NxOwLaMagAnQpqH/fLPFW3b6uvUufEWLmo4LWubtf1p94yapIiLI8imQFVCSR4LY9jijczWT2rlLxWzntf5Tv2eTBA1WefhsbjXFAEsOq2eFfG+4sZmwiHjJPlX7G6hM7N/LN/Vc8FISFNqSc5G7PmX7ZOzyIby9Lo0NC7UO8EOsK1K1H93XYBgIuoOnVyBehXf9dDOEZ7ZUZVKxCQzPRcW3jwniM6xsMlKEIjjfbIF1dIl00=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4363.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?uidegBdEYV1Bc/OG89/Pv+kJrBfPTT7LDJnhKSZInr2RfqeDSXA3y7VRxsr5?=
 =?us-ascii?Q?d4/ND7JEBVx8OYJ05LUcx17fzpIbT2x+FD++S/2ItSm7gmyND3foRONvYKwl?=
 =?us-ascii?Q?b++9TjlfpJc8cEEoR5DF14b23e5UlczWC5XGjDgt2FTHCwTHohQ1MhyH4fEn?=
 =?us-ascii?Q?Pi5+qrBWU6uVt9Pdbd3xMDRq66LFZWgEc9XpPuiKdcvfghU16aR2nM60GT2l?=
 =?us-ascii?Q?wADpiBxS5GKpHuKNImQ113Mdd+DrUIHMndjK4EHSM7QotljkM1AV3YPvBmiO?=
 =?us-ascii?Q?QW2ESy9/+6WdxWNgFUCqdKl1Tuk88DzEQ/6AyQbs/oKATVKxk+wyYEN8VYBh?=
 =?us-ascii?Q?fLjG4aSeJAk1zz3teKraGjTMkM10jtHWZSZc/fslIk/4JyAYCOFzcG8Blcnc?=
 =?us-ascii?Q?cBx3RAr4/Mf04mGyJK9IEjYCOwD77TPFjy4WgMEH7IEvC8/M3jUKRbBXcucN?=
 =?us-ascii?Q?5jh1dcYVhfS67BtqY6XDqtB1KS0T0eoiKiJMoxRtkQPJ1k9labdnbMENnLOU?=
 =?us-ascii?Q?WhY+1d5MP5GgeJ/1eHLdH4OYpWe5DM6dgVQyT92+QgMJ2T3tNIjvhB+VyVNj?=
 =?us-ascii?Q?NRq2VWLDvNfNL6MNPASOWgYSjfx65eUB0ps3NI3QmkpeQAUeCKG1v68P7Mip?=
 =?us-ascii?Q?sg92KfKxTOc9SSDKWSRczPPtJVU6gr0y/mJoImRJ04F+bfuRAqSVUMSKyoWk?=
 =?us-ascii?Q?BhTQqKF7uQ8Ol7CutPTdbzjSVO9U7vXfbJCTBkak+OtY6gPuMniJ5G8Tb5Zy?=
 =?us-ascii?Q?aj/gV3C2RYjwf6NJNxSBOJqWiNhG0ro5/M0XdNT0X7nIxTcqOeVDsAtNeM50?=
 =?us-ascii?Q?UZAYfyDM7rLQc1u1hWqGHNjaYddQSTUM1rRqlnsKUGQri0W3K5hMEl73wcxO?=
 =?us-ascii?Q?IqZjnDHDf4OVhI8+S9ZngWbc87VFHYWczqWNnOkBMg/wiqOtqDXbpwkPHscm?=
 =?us-ascii?Q?BVmWLpbXa84ZbwNjqRkUmSc6YvUgyXCAxryE4Rv7yVnV0G86gidbTN/7dXRQ?=
 =?us-ascii?Q?yfFKt82TL4iN1w+BDoX6gZKza78abYQ3MZrzwFu70QmglQbNZtJEKJlWeRR9?=
 =?us-ascii?Q?ttODXyzvXDnoT4siqBZOdQzKTggsIE+OSFIt1jacfvHwipJSu+5uLwfZW0ul?=
 =?us-ascii?Q?yFEpvdr+nvJKof+06pzAW4d/2dx/nvxRC6JA6d3gy5UsAdra8MAe00COahyR?=
 =?us-ascii?Q?G9yKYOGzVnVUMccH8xsS1bUoy4uLh7YTgaLZflv9uw6OaeWImUzp+IZpsGn8?=
 =?us-ascii?Q?QAIV3kvWBJkMIro6oQCUJ7H32dhZnNHoQ3Afjy0zCwZK0BMqd9Jq8tCcdd9S?=
 =?us-ascii?Q?Un7SdjVMal/eJZnfZVm5GBPLnz/K/phuzMbjspuY4eDk9+4Ppd+XN+EbkezH?=
 =?us-ascii?Q?0pBiP6ziQLSN5Jb5ouyB5thoUKj9noljCGvygTYn5Y8YzB2o9X57ERCgTine?=
 =?us-ascii?Q?peoonoXMPx5maKadtTRWb1KCJKSl7hyMi2FLzv+Oap/8gB8cewGn5GDDZvlv?=
 =?us-ascii?Q?ExDPQMg++niccvK8xenSDA+eu/VY95w5Hr5Xqs3brXW7+yT/dLTZGaZdelHp?=
 =?us-ascii?Q?L0piWDhlFi0pNARRIj7mhH14PR6h54bH0CwW9xIt88e31cXSG1mvKqfkbsy4?=
 =?us-ascii?Q?Pu0hb5emHrePuKCfgQ9gyjI5wluMTy7Dzdkj1asCzWZY+i89XewgDa2i1H3O?=
 =?us-ascii?Q?659GlWG1wNJiZZVKyg4WzuUvOOu6Yz94FrTf2MSJCesJJMa32sR1zpY61CQu?=
 =?us-ascii?Q?8QZARlMbeg=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	KbANtAuBNY+0/+c5TG0441WuRSkFMtrlP+29IBLEir7Dr63K//yn/OdJWd6nByHhskcoNPVV7j10JwvJvsnRgp0ZL8h/cZ5gOYCtDZBKYzFgpST4Hky4CDsAKnjlekt/XBKOOg89n4fHim5MmjUB09kMprvP1frBmf4/jMrc8mhn6bMzkhYyknBchgp9jS1oZ+rAuXnftUmQ9HLg2EkLJI1bCd5c8R4i6m9qJPSxNQ2xBP2JAT5sVg49lHSLG0xAu5DGpl1hXhJLOCf8W1rowIAXuxxTevNFI8o8PR46x269Qqg6f6yQwyo8OIBTU6A52oTVpIXVJFOrSEXWghRmUQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5lW2a+3lJAmhuo+DJzjdZ9YRqwbuSp/JclKZRWY2lOqQszRkVFLsc1WhzY92Kqowrxz83nTwsOWbn+Iah9z8DapSi96MpuG5RPiQy5ZhEtK2TsNf8oqXppEZK57BTJIzRFaG7Ncm1h6bnQJnepIeGDOqbADvnmPGUCbmffpPKKoVMSCLb7mKC3SSrr0AZTJ+Av1+caKE9zaZi5dxPGcd3qJTCJ/OpnOhRWZdj4dzT+NbEJ/bNngdTYJhFAp5bwSQGd6XQ7nmjxZUlrPW6U8zCmMrOXKbY5EP0eeRiSRtnw7TwiUyV+2s58P/g/wW4tvbtuk2kgEIt9M2Y9IIfx7DOuuHL32gl8e/LbCrRyRBWXd6ks/WOmQOdA2rAoEPx7AaZPaF0HwBb/ZX3f5dvDUur8+P0pCdRVYa37BM2gDDGY/tMSABPw67M7gpjfXj0c/craztRr8NXzmERuvInfmBWid+FY7d+Oy3cNZF0deQ8RkVuGvDdxM4hqT3ie/iR65ssHGdGX/XAM4oHZMsD8hM3AwOzlIe5kvgviLxRX/Xo8lQaKYsQ8jxsXlOEDrl8vEqE8cGp04V3olXVRIqi4gu8baS/YhzZE8wwL9ukrm26Ac=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7896c036-edbc-4b8e-9fab-08df4729c62d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4363.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 17:14:45.5909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDUFMTgFhQXCqPytYIQfmWby5DlNSlI5wDwzEz7xlD2SdyDUWSzFJ2S91zzyARkIGj11C0lNUqRIhJiWoGuRDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6264
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2611040001 definitions=main-2611200068
X-Proofpoint-ORIG-GUID: n64MFIfu1P1OTU-yL4xLjT0BUfOEOC0g
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA2OCBTYWx0ZWRfX0oeyJPPpDSqY
 WdWsDtlglWLZHvI0SIBz8DyA7hwWhFT6nUmORAMC7MDKm5VN2JXPWdT5T+g1XuxovXbtVihCdLX
 XQfYFNJo1/E8LXAgBg9O5G2472ornUjiSdG3sA6GRsLcT6rbz9AW
X-Proofpoint-GUID: n64MFIfu1P1OTU-yL4xLjT0BUfOEOC0g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA2OCBTYWx0ZWRfX+19GVMaRYMYE
 +hjkeCRDIKuxfl2U3lm+3q6RmiP4rg/qaMW40YUKLEq+/WX2N+xetsarR79iLKFXOfffr9w0gR1
 mDnCo47JH2aUN17tc3yQjML3pa5cSp89l6kT4jLDB/DooibO7ZDxUKSxCLkPNqpwt9IAzia1aI2
 /bzJu6WTLJmGIEfvSQTFTEIWTIqtuvN/e9tH8i4HclmEbYJ0HNDRPGTEYU2QVtKYax/DIhQagdr
 smF+NtM3bRuBxsB9WsToF0LeVhRvb8s30byjOSy1+M+Q74mUlYSE04Ala8T4zz7ZI2ZWBwOg3j/
 c1A/7ld2lCfSX3Vu9pCswywfqNXKSQuQjotTnTJcN4Xiht2QvRnuqjDf+DersXrfvQeQ85pMv2+
 QCaZi6FYRIWpZyVR7Xo3b9gvvwWGJA6+8qW9dUbXDrMTgzUTBMpL0A/xF3hTVhYousJeIuZ1ycu
 YGZWAyjMggge/nfAJAfIIunLLB1ORcFZDYKo+6wY=
X-Authority-Analysis: v=2.4 cv=I+vw19gg c=1 sm=1 tr=0 ts=6b00800a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=FdvImDmwLtFTMEY2mt0A:9
 a=CjuIK1q_8ugA:10 a=7jBqKnKQzRwA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13532

On November 19, 2026 at 6:16 PM EST, Michael S. Tsirkin wrote:
> it's in my tree.

Hi Vlad, Michael.

I've been looking into this issue extensively. The proposed 48-bit limit
is a suitable conservative workaround. My virtio-net testing for this
issue shows that a 51-bit DMA mask also avoids the mentioned issue.

Full 52-bit DMA mask support is planned. We will revisit the driver's
DMA mask once the firmware has been updated.

Thanks,
Jonah
