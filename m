Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BA61391
	for <virtualization@lists.linux-foundation.org>; Sat, 16 Mar 2024 00:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710550046; cv=fail; b=el0K8axKFWvG/HwCXqxhC9VMOM7GmSLDbUU+q0AePuqlQo9Cv9JCOs/z4BsbtIDntbqgmEhVJGfy943oxNLo2RlU1RwcN/VVkZyFJ4O5QyESD0f/moDdNu4iqcuNKb+TKKlIIXdiRms1QN3VT5cP4pODgK8tZcGCHyeM3EwQ4nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710550046; c=relaxed/simple;
	bh=0YNOJ4AtqGUrmwhzQ6mXPdKdYAYdZB63vl9GMOealpM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PyxVXIh8fFjl1cqAz3ze98s2HPwGAgrCZWwrB72GewbhnCyKMDYvJgLOPl0GcZADEZp29tbgF0VqonEGpLCBezrkjXJWKMaz83fVN5sziTRwslXE9FVeZr7ax98WaBVRZFG1fP3yXqi/kNoj2CQCWSCFLCxWZz3+f5osyuyN6zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MKP0puQZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d8ulBb40; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MKP0puQZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d8ulBb40"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6D32C40487
	for <virtualization@lists.linux-foundation.org>; Sat, 16 Mar 2024 00:47:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.098
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3lhyx-H_szZz
	for <virtualization@lists.linux-foundation.org>;
	Sat, 16 Mar 2024 00:47:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=michael.christie@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5FE2440207
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5FE2440207
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=MKP0puQZ;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=d8ulBb40
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5FE2440207
	for <virtualization@lists.linux-foundation.org>; Sat, 16 Mar 2024 00:47:23 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42FH9Rkh008461;
	Sat, 16 Mar 2024 00:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=AmsIiulmMCvJxNbzmWZ3NwSKfE4twPs+liSfO9JEGd0=;
 b=MKP0puQZ8v4EZuzsgzmZ5+fqGYWAuFGjHu5ZK+dfF2Beuf0U4PzyL1DAoS8UDQd19qaw
 oiS29RqwGxEkPsW/SXhW6hacWmOeW7CwICUFMcjgOAgjHaak9XtYgUGOgBHgl5gHIvYZ
 dnRGuIwUQ8gN1iiv7Nmy4T0Varflf8iVno1A1XBZkPp7eBtjbMbzA6480LdIz5u4sBbA
 IER7QWYnjsrzqMezZhzRyb/rThJxR9KaVbzvqgX9oBj36w1qIAQD5dH3IzUxNo50C5pG
 RwGX5tH/JVdSlEVx1Wj8y/XzH31fNIilZAXTpzKiitw+A6c+1DBJNL6qYaP1OlIP9+ti cg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wvsxh8s79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Mar 2024 00:47:15 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42FNAvi6037704;
	Sat, 16 Mar 2024 00:47:14 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wvtmmy3ub-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Mar 2024 00:47:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKOYX8QrjticXGj99P0VCLELkfKcxhHVNA0c3A5+sDfQwPTmHro4rvJaHbg5EoMI18c2G11ZyKxfvpb+BuUGGnIdeNNNHMjp1DIBJHiiSnHQ0mZE2yDggwCPlCdemmRqhxhGafpxkGEoulYEurn+/XpKd9F+CM6r3Rlvi/28nyC7g1/464rX+1reE49XyCtLyCBWTZiqPGlSOECEIC8h0C66R7ByhFQM+GZGgoAoq8re7DCtmU8XMT0sqjAb8eJszQrCbdEO+zyVWTMJir/hNpfRQyFrVrHjbvEIwsFoyRiwIdjZGNqh5xbRZgA/jnLLzcOQuRABow/CLH7Rt/Ux6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmsIiulmMCvJxNbzmWZ3NwSKfE4twPs+liSfO9JEGd0=;
 b=YOk9EZN3R1oBupwJVBPwoS6vja1XKFlATni27H/bk1xG8lHqf0fKYEBNbcLuwBQQMGVW25w+PoefGzgDZrvus7YHNxbuGPUKey9hC2PhIOBFja22AMQ3b88y2GzTozq7wWyMceLXf5R1PyyY44ByeCWa6SnNnT6lxQuUuCTPMDWFuW6eJIKa5PDuC6oE14/5tprhX9SB2csSpwck+u+T+WB1PnvNJ5JaOsuQ/2+5nQYgTqe1cFlNQ8iOmoKApWTq6EvBst+yF5TYkXZLqfEaDPPWDylSdTrFXWgsmBcu2xQ1acPUesegXnA0x7LCwB5QE/2VYelc5tbcwPvARzc43Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmsIiulmMCvJxNbzmWZ3NwSKfE4twPs+liSfO9JEGd0=;
 b=d8ulBb40JJ06qJ6EaEOMXl0bIXm/LjPkVhz9gozhWfg4SHR6dn1gNjGCc1f4Krof++73G7uQ0m1qUmfPtD4XwvbIwc8H2jokoldIOt1CZdBHq4U7t7xJf49RdS/V1zBOWye3SedSQ7G/kWQVI/Z5KErdk/PY4G8ZqY+42hzXfDQ=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CH3PR10MB7120.namprd10.prod.outlook.com (2603:10b6:610:127::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Sat, 16 Mar
 2024 00:47:13 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2246:144f:3bb9:60d]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2246:144f:3bb9:60d%3]) with mapi id 15.20.7362.035; Sat, 16 Mar 2024
 00:47:13 +0000
From: Mike Christie <michael.christie@oracle.com>
To: oleg@redhat.com, ebiederm@xmission.com,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Cc: Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 2/9] vhost-scsi: Handle vhost_vq_work_queue failures for cmds
Date: Fri, 15 Mar 2024 19:47:00 -0500
Message-Id: <20240316004707.45557-3-michael.christie@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240316004707.45557-1-michael.christie@oracle.com>
References: <20240316004707.45557-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0144.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::29) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CH3PR10MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: b34e2c94-f8e2-4795-4811-08dc45529e9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jTG3vfdHXsEefPr/qHjAArDChRpqDOBGSymCezZmqdbG7ZyeVKJf+1WT6Tw42FKtxZR/hF6nKt4pBCUPVreXbosCC3VC+ac9MBB1oCSYGNmqL784Ph6Bzh2k7hEQa39vdi/3EmTa+LfULVM7i6IYzpEyUEuPHjrIhvnGbLhtE2EXdjIadWaXZU95Hqwhp02neicwm7vA7rYf2vn4VayErfev3iOydez2+0BZHkJws3i05K/UoO4S+wFnL/XYK49FMYZ26YudyRPKS2myD/Ke8yXwYShtjUlWdS9YFIwBzX2lDwHCEW100cb+ZU+A1OOurzH2IWCGfw2rfKdr8tbj5V/qnvmRK2+SqE0oAuk36Cf/1c8s5Hiz82pU0VgxAtdcDmmW4krSOzv4BjCApWXGOgORDSXryCz10bQYhP2MVpyjtbbFVxHSnh9UVIyO66jpMD7xJXY5l/T4SdNYSqxEt0wNvFPk1l8dUZVuDySBptC6NxU9uQsi0q5TsyzJF6sZ40nFpBKV+LSHsKxE5li4PKq68nn/YrSIaMYNKt0uu/JXt6sIiRbytTCMs5USWHMkp38dCo75nJE7po/b7gbXJvv7sflGj0hr0GjCbnjuilwDEr2G3Nadu38NfivqZ+c5XoJ+HQsr24jijF55tX1eBw6ghAW+rVj0hsG7e3cGLXg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hy2J4XXOz+v9JKS0SLcyE1Sz8KfdaV4MNwuixk7U2nyFjXikZ6oc0sgxjn9D?=
 =?us-ascii?Q?VxY62UbiyBjDWmGiMlsKeb5txYHbJ6susrwdhqlAbpwfeYrXpz0bgYaM+V4x?=
 =?us-ascii?Q?713mjb3nAkeLrvQQ1QQwMnutWCHpiPJ2ifUD/K/tXU26l1EY7XXCkUO3CqE4?=
 =?us-ascii?Q?3ewapjoNnXZvaodXmiVmSeP9E8Mgj9SatUD56YkXoI8vp9c80j3yc5oeoadq?=
 =?us-ascii?Q?mCJoIiLdeLzpZ5IlzdFKs4Jyr/EtvdGKLde95Oe2o6jwhoOmRxnDYf5Cxf/a?=
 =?us-ascii?Q?IMOWvgWsBOBclAGN3AizDqaSIF96wPKot3SW1TOx5JRufqqVnUkl58W7qI84?=
 =?us-ascii?Q?LqygSgSnJnHAz073OCZMr1+aISDD8eHBb/s0jSd0zmC1JU+7SMP8VEDfXwZq?=
 =?us-ascii?Q?NbfGsZ7WlyAE4BYStf9btJUpqYND0JUHUcCven7UPiIQGfO9UUqDJbaOm+KQ?=
 =?us-ascii?Q?hz4Yn7yEcTJ+WtErJYWJYZbNsb2VC8avZVjMwisc57mHCkJlbH5U6ACIQgej?=
 =?us-ascii?Q?3UQiKrw+qq2J4R1e94lRs9LkFO8nhuk2GfOSiHu8zU9VObHwwlaIm1Jy2Dtq?=
 =?us-ascii?Q?zFNTaNvtjp6ix5uy2xiphyIzAoqdmLEKhi2CBqgSDAvoE8azn8rMzNxIucnN?=
 =?us-ascii?Q?2BXUPEDNNpHaf39+toZsFAmhDKwxDRviQ9GHAVjCgkmkzgrH570OL+0Wvxhf?=
 =?us-ascii?Q?pF5AF+jxr9tDoTrzFvMM7JC40CdN7psBmM0NELs6cblhvKJEjClewWLgjPTa?=
 =?us-ascii?Q?RinVsLKxuTvcEUYoWTkhp6K8YORH/G3RoCMMk/PQ8uWKJfrAeQ0vfqMaDMHS?=
 =?us-ascii?Q?yosEGCfBO4oup8jzvo1vM1IaaoWTWekL3LyU8aInHEK9ssCYRG8A5wBIY6Dj?=
 =?us-ascii?Q?/qgCanbE4oCUXSA8GzPlRk7qwWs4dRQ03C1xG5m5H4PMgpKWncqtRT0uOW9/?=
 =?us-ascii?Q?qv+UtbFVjtSMYEE1FdAzlF5k4XazsCVKbS4z7temv0XtR61N9o7/JbmW4OJQ?=
 =?us-ascii?Q?Nq4tytDVX9Avxnb4ZCHplDgBwVLHWtzgEqNHAmw+HY1UgYHVY0lx04d3AdVA?=
 =?us-ascii?Q?BP+HP4ezwQV+UhDbUdhmi4CA/ZOrGo1tv4dliYwTXwkiA1AD+cyVTvf+evFb?=
 =?us-ascii?Q?33EljPU9QiX0SjA41SRNc35FLNl8gwdbPIJX6UFVITCUPngrjpUO64h+qTaa?=
 =?us-ascii?Q?hYDZde7PcDuwrc/XZesU8MWqNhnKEzP76ZkBb3qiZb+KgyXM2u+gmCcMl6A9?=
 =?us-ascii?Q?SQfDWeu8PZqBxnZutNM2TYG/GcEYHHXllBm3uXz0jxQXgEVv5ym0bG4OX04U?=
 =?us-ascii?Q?LM1LqrH8cj513A4dqpiDSHko32y2bjZWq0r7wAsz49+xpl1JTlHSqxR8NVZM?=
 =?us-ascii?Q?BH+yI3h1DeNoP2Hm7CL5T26C/EKZOSW3LBvX5IeMugwgIIsX/TKaT1jR1O09?=
 =?us-ascii?Q?VjZeHLmSrdohLhfZ3eKQ+duzydNckhSW0E1+apc123C6gdxpKIOeTeJUMGqD?=
 =?us-ascii?Q?1TqwchyBCPGgNVHH6+krRMoYedD63TsaEdVA6E+6Tn/FSeOU/fuNerzDYQuF?=
 =?us-ascii?Q?JiIzIZfZlFdQ5gAbE+0RrKPSGFIgJFFO99hTXfkQB0Nmz0SNnYZt/a1lpjaI?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mr2IQlyEb7RFYWZKBj6mSWdxM1W55/datSTmvBGACzOcDVZ5ybh6jt9nJPO/DzRAKiRUmswDX/cL44uefqvoXhuLDDqZekPjhZHARbpQARQJI+zDJUgMUs7LuSeMbRA1cFuGqIkzXCGYgKbaGXglquC43MJPqGsFht/S5xaB+RqiAv0P7FWMNHZRnFN8gFqDJ3c3frMW1X2Nmf3GnmIrCVKVLF6kX+d41siCqLd7bX4s/C35utP9zzN5GRBuNmRcDYZ3HTY6UUvsraC0ZoT4WDeE7LlTXbAVIvh6G8w7HhQDpvP6JyWQVScpm/qbqCLHzDMO8Gv/QW64zz8hnREVVQYEj3GyRHYzToz0dRdXqXHgBZ1eQv5ttGVtvVjNknqfPacnB/HhC+zsbjqz7QelDO32yhTSUJJUqOFkZJutuw9LHXnhAt45nbANExjvLn38jiK63DzD99I6mAp3WekkU7GxQgidYWfyYCna5Psw/8rEVvs75UKKB7s2KFljwnI6gsJONvlFMah5k6BB6TLrFbXBKduJf7OHj9hAa7yEQvPEtMVTrzDVBIkMDVzKyIkD0o/9V1ZhfdYekDik0wBs+U1FAV8KGssQPEDB8etiACQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b34e2c94-f8e2-4795-4811-08dc45529e9d
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2024 00:47:13.1337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ReYaaz1qkbk3P7/bKZd1jX94t0zzi9JRWRsHYJCbOcNu7lC+tL/9D5KEvu4sItcpfgmNvxTJn5ptob8njXK8u3febHk5/HhvaBTocxvaA1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7120
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-15_08,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403160003
X-Proofpoint-ORIG-GUID: 0e5Yy3DDK9KbpiJQ61DVF2yytdo3UXiO
X-Proofpoint-GUID: 0e5Yy3DDK9KbpiJQ61DVF2yytdo3UXiO

In the next patches we will support the vhost_task being killed while in
use. The problem for vhost-scsi is that we can't free some structs until
we get responses for commands we have submitted to the target layer and
we currently process the responses from the vhost_task.

This has just drop the responses and free the command's resources. When
all commands have completed then operations like flush will be woken up
and we can complete device release and endpoint cleanup.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/scsi.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index f34f9895b898..6ec1abe7364f 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -358,6 +358,16 @@ static void vhost_scsi_release_tmf_res(struct vhost_scsi_tmf *tmf)
 	vhost_scsi_put_inflight(inflight);
 }
 
+static void vhost_scsi_drop_cmds(struct vhost_scsi_virtqueue *svq)
+{
+	struct vhost_scsi_cmd *cmd, *t;
+	struct llist_node *llnode;
+
+	llnode = llist_del_all(&svq->completion_list);
+	llist_for_each_entry_safe(cmd, t, llnode, tvc_completion_list)
+		vhost_scsi_release_cmd_res(&cmd->tvc_se_cmd);
+}
+
 static void vhost_scsi_release_cmd(struct se_cmd *se_cmd)
 {
 	if (se_cmd->se_cmd_flags & SCF_SCSI_TMR_CDB) {
@@ -373,7 +383,8 @@ static void vhost_scsi_release_cmd(struct se_cmd *se_cmd)
 					struct vhost_scsi_virtqueue, vq);
 
 		llist_add(&cmd->tvc_completion_list, &svq->completion_list);
-		vhost_vq_work_queue(&svq->vq, &svq->completion_work);
+		if (!vhost_vq_work_queue(&svq->vq, &svq->completion_work))
+			vhost_scsi_drop_cmds(svq);
 	}
 }
 
-- 
2.34.1

