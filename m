Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9231C1FA4
	for <virtualization@lists.linux-foundation.org>; Sat, 16 Mar 2024 00:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710550048; cv=fail; b=XxcO1XLaXFE7yduWbNYWgSEPz9Boi90OajNLY9GAcO/1ln98QBDVSHElzPKKP5dhVVlwTCqA8rHYWo7IUbEhapVT+f9ANLjF1Zy0mhxDFMqCLWQrr8POHdrFfIqK11CxLs7Kv1ts5cKHELVBEvy86rDXyxE6IhKzVvhywpQA/Gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710550048; c=relaxed/simple;
	bh=1DXORBlNX4MWQGm9QtpMY5VxQ/YOaz8Bn4/x+IzAO+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bY/v/HO6F3ufcwLKCgj6XP2tphz0FBnlJjDkiZQrsnmE6o7opxEtCweoto6SY3qAeEb25Cqgu46hTfWkEjPvbyFz48LoLA3E27Cq6NVYTClZWQ2LNlU6alTkQGR39O9z2RDZEU7CtnXWqRSDQnKaySMziN2XnKlYuxsQ/Tgi0IU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B/GABUWD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SEJFGtbo; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B/GABUWD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SEJFGtbo"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1164040497
	for <virtualization@lists.linux-foundation.org>; Sat, 16 Mar 2024 00:47:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.098
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gkttj6_CwoKD
	for <virtualization@lists.linux-foundation.org>;
	Sat, 16 Mar 2024 00:47:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=michael.christie@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C57D24036E
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C57D24036E
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=B/GABUWD;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=SEJFGtbo
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C57D24036E
	for <virtualization@lists.linux-foundation.org>; Sat, 16 Mar 2024 00:47:23 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42FH9DQf014740;
	Sat, 16 Mar 2024 00:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=ImkIMLPYoWyAKtQ9I+X36WCM3N5yWp1M2Uxomr7Dbw4=;
 b=B/GABUWDPJG1isuBfXlaTS6iapZ2T6UKGkPyl84uAjsEDq09N7tMt9wSu9iZFeFCLT4j
 SXjy84NwL4AYvZBom1pPOhP+SaCuLJEjYr+ABUjT0rZBKuGtwe5UtSvSzM/dXoxCIXWW
 qSKILFTnlhNaRPGsZVrP52Es4BzT2o02gwAr6XgvUk+Lxa9XluZMygmbU7GpsTBhwg2f
 FH36iEz7rnCaZs0/msed7eCcWC32xKRFmIuC3+Pp6UY9Cq80k0AQpZOCva1mfB4YJCrY
 v+s1uJLL2jvlAXIAQKeMKSFBWUG+tJZNq1Toeo2FBrbHpS1OUvy/U45EzYAv0lFHpsT4 KQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wvsxk0sg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Mar 2024 00:47:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42FNAvi5037704;
	Sat, 16 Mar 2024 00:47:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wvtmmy3ub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Mar 2024 00:47:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdewA/kJOCSMpWkudusM0VAQSJCbYsKdJRsgeb3V+XTE3UproPtaXFoqAmBtJCFDIVMARaVzZ99/jmaSuz2dAvLBP+cwMFkud/xGNOazjwwtr6jlyklprqV0LNEjGB4mBy45XGhrVMU/fyLVMHI6LjIGclUBgoipJkaQ2lK6BCSru55Hh+B0Q8VP1tIvi38rTUPGbCYPHGH5dkTcvXNQeBUu3KYPvOGCoYcsBzuFQVOqsDhgtLGssl5aQ56bxa7ar4Dceebc0KRufBKG0ra3kjeHkm4r606SdiIuRIg3VRF3N7gsYxwwABoAca8nXLTUXIiKKX72RnjksTxRVgfF+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImkIMLPYoWyAKtQ9I+X36WCM3N5yWp1M2Uxomr7Dbw4=;
 b=mZbaZLvdRfJX49CNnhSO0rdc1j7qcc65Wrpt4QQf2ltxDYVHXnaqZ/PDDtmVZVI7pbnQqCwh0kgDrFi8NrUmJV6PALBPG34l8nra20k+kVPRRqqIXE7rcJ4tBrVg5JjzYRUQCa9H9ogS7mHe8iaqXgSxx5ylyQ/mMDzdCKJMwyAAZSOHY0twZZcDXAUcVD55hibdWLMCcbrrWRuR6RW1KKJ6kQU6wGrLl34z1oSOSgPZC+zqnApxc8irPz6i0sNnIf73XUGWFOaeSUYoUNIdo7laPxTHUbcH9QXgNqJfWqP5znpZ82YMHADBTmn/PHwpu99K+9/YJ1y862mhcdfndg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImkIMLPYoWyAKtQ9I+X36WCM3N5yWp1M2Uxomr7Dbw4=;
 b=SEJFGtboCqTrV1cZSpF9GEGp6kz7o7+3E0vPNk/r0wZhN0xV8rYYHC+ipaRgn8cYs8hAMTKy21MrqzZhKHUfxJig1iIqWUSWG/OrJUBdphHfA9dQMOxihLKe4Rl1h2HtQnUqwsALe5l4+G4vULDFWXQsuUzR7Zgq1S2v3FyoDdY=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CH3PR10MB7120.namprd10.prod.outlook.com (2603:10b6:610:127::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Sat, 16 Mar
 2024 00:47:11 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2246:144f:3bb9:60d]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2246:144f:3bb9:60d%3]) with mapi id 15.20.7362.035; Sat, 16 Mar 2024
 00:47:11 +0000
From: Mike Christie <michael.christie@oracle.com>
To: oleg@redhat.com, ebiederm@xmission.com,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Cc: Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 1/9] vhost-scsi: Handle vhost_vq_work_queue failures for events
Date: Fri, 15 Mar 2024 19:46:59 -0500
Message-Id: <20240316004707.45557-2-michael.christie@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240316004707.45557-1-michael.christie@oracle.com>
References: <20240316004707.45557-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR05CA0064.namprd05.prod.outlook.com
 (2603:10b6:8:57::26) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CH3PR10MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: b01608f4-99a2-4243-6977-08dc45529dbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	BXsMpx9RTRWsUpe8i8zpv0Cj4fhRTh8Hcjk3rYiH+2qN93BDS3rJt8c0tQeLQmWO/0VjNdoImewaMc2haL9hsuGnGt5EYfSZMqBO9cnTncG/xoSh7yzaymv8qzw0xByrgLlDWRmLOj7C0u/WiU40NQsrUYyTxQsladckWa2XNZGoOq0ZsTGPcr0JpqxcziVkR5E58ly/yU316Tp94mXYaCqIohPccTC8PVBKJs03amImFto5XjLEhOEWvRKSpffABwzMyM+Dt8G47F/UqVyjqO5CJav5hSdbhB5AoD0Bfu3E4IPu8eiZEEmynWdLj5uswwo0RnBuWa2Aq67BqftRbR93MuKrpNeB6hYfgu9vA7yOefjPiOyt1U3zUA8bCeAMTKO5ri8Ttj+74rWK0yzc/BseqGKtYirC4ae1x9CywtPNfPEcEiOfcdKfGMWcYU0nSn6RnVSE4r/nVadyyKPcds74zxidMPRVz69VnN6qkVNN2lgJRQCEN0qOlDoJn/UaxMi1TamlLqOfM+aWYuUxUQ586Of+ph0A8rLq05oSdaKDJdBXgDSnSFg6KoY+zothp3u5rpkJK3kmIBl9Sl+AhidnRRbyZIhm9oHTgyWQKX+L+hVGcUVndYYiPUzvpHBRsN4bgYAeBZIgaM0cBZ8C/pIOEPsNB+7j5MnFPbwSPXA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?SMrkATnOgk1SFQNOtX7uj48nFPb60POo24Npni4BsyHEvalOf9H/sm/U8vdt?=
 =?us-ascii?Q?0lCDposLRX77KtVG3lBNhIYhhCSROdqDqgdNjD5tolWYGJuCZqWhWalkE4ZA?=
 =?us-ascii?Q?SfqdGPZYPccH7/4/0ncF/w9w9kj/PLneCLg43bR7ujPGCqpDJ9wmR1ZbCZIf?=
 =?us-ascii?Q?sEJfyNMKxr+M7VWzqbXT25xM8GcisJdZicgILp/Iey/dPuwgcAOehxr6SBVO?=
 =?us-ascii?Q?l3PI9tVNGvuE73eRDjjhhGj40KZCfb6yTSfONKvHvlZ0EjARMxBn3VE9LVBK?=
 =?us-ascii?Q?oeWoo+ViC0TU7xYTxZQRbTrkQaP2rwcxy93s4QA4VByP3TDL2jOJaV0HFlaq?=
 =?us-ascii?Q?8Mes84TBjYzd4Le2+M0O3Vg+xhxbPhZu8GQ+Yp0EKKR1NPP9qlTf0xh5i8NJ?=
 =?us-ascii?Q?/7JARDniLGuuh+kbXxtcHZSa1NkMA+12Eg9HaV1wnveYGWd3VJdNSaLCOk2L?=
 =?us-ascii?Q?z6yvn8Z0JARIpLsY3NvWVJNbxVeWMWze0uzRK9bo37pcTetP9agtZKY22hXp?=
 =?us-ascii?Q?PxIl7EREJ7z4J0spGqUvVREejn0AYG6gTS3W5nIyy4lHqcMFPCnsIr5k87JQ?=
 =?us-ascii?Q?Ji2QGYfOF+nKPy/4Tq49Ve6PwHcxlXpWVq+O9Kc1kA5qOFn1R660YeYthWqX?=
 =?us-ascii?Q?2J3tyrFHj8BGXI9Yf0136NXLTzgjV+Ej9m41CAULcTZKww1iV/RjS5gb5KP4?=
 =?us-ascii?Q?lSYImFbdltj0WvjsT/MTYleyTtXZbrXgn6i0H9/AYUyIXs48qDvhQ1H2JbO0?=
 =?us-ascii?Q?IwWSmrR673pBhRLQkY+6lBALAqGcR0KGhGq0kd0Skam7vaV6W/DqYk5c1Fd3?=
 =?us-ascii?Q?0a0iemdrmOE/bbLSBOIZqlLzjQgvY/D1RxEysHlZ5MxuSSnK3fN7KesoHkRZ?=
 =?us-ascii?Q?xy5SYY85+GUC8xHUWsDkClbgGeqrFTzIDFk3IEeM563jNVGHj5OP2EcmGM5N?=
 =?us-ascii?Q?s6fMThptzVnvwo4OIg3hOjCz75c9We5GP7mYCRCyMDfzq+GbeIdR2SFvwBIU?=
 =?us-ascii?Q?wYCqJHpGrfMUDRcY6YX6u8hQ8Xltg18OOuQvZTqSZaFt4aEZxkD6hp/N0T0D?=
 =?us-ascii?Q?b5ZrTTKSPatbmlZTYQrcFEZ0W/hfDjx+dLwjIcHhJFEcKvhI5T5XhKkEzGQp?=
 =?us-ascii?Q?3W/bqGrLoysqJnEtDpj2xMtTmhjjzptZ7RT+sgdEAI+NhDGHTrxKxO90ik3L?=
 =?us-ascii?Q?QlkXk8ae/x1KtguyavR9AdR1Amc3cG/vfpUXbC9xAYPm6ktYmjRVcZzKMeZZ?=
 =?us-ascii?Q?5Aw4qeiL2YMOh/vEXfwlSf1kUbIi8jaUwkVtaGz+jV/CGTuHSnlffXKTzkvj?=
 =?us-ascii?Q?Mgt5c0AcBuKj+fHFBAjPsxLD4GA6IAhQs2iHkVilURIREyAK6cJ+CDZTWbEe?=
 =?us-ascii?Q?tifaVzKFbpf7h3mBY7UTxoOb/JMUokT4JDagUf5rWspGG7lnkvKiqZ59oMji?=
 =?us-ascii?Q?HfjRjx9SzM8CIFrvLnRQ1VFACZUMrTPaBp2ytboX1uk5oOcdhVcVV0IV91x2?=
 =?us-ascii?Q?b4mlAWurzOZ8pbcvltwZkiGK4iFWPq4TzM+oVGDQvWMaeVPCZcYLpusBOTFY?=
 =?us-ascii?Q?orrWKLINBIROPQPIs+6+VwtDbdcFw0stvoz8BOtahhloWmKEeGZhJ2BTXMER?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fqUhaa2P49eb3sYS6/OEmljMIGJlkyIFBZcSG1J0Z4Ynve2i/FVFgj7E69AODjzxfw8WmK/gkD7JR97YM3LSc1JX1/K5MvSqqqJLm0KNTRN9JIUnRgSdhKWNX72Z4BQE8ucaX0371vybNVqveg7xfQL8293vrOmym/w5HJMtcdwGTP/+oABniV7VyJxKsmC/0J9yjjd2XvYmQoLVnIINsjhlqgJbdg4aA6QJK67CkWlrKi7RFAIlYFq77yZ9VA5sPcASyVAVQDSX2ULY1lBnv6YQmsRpxT7relqiAHCByxZ06b7Fp3XaJ0mCTMW5Uw7d2lRXC/DVXwjPY/heBWTWMuAtLx93IdiAyTeq/mCOHIUlBXQrtW0JJKCCvjodBjCRR7NMWbUSvV4meJTu+b2+ebYEM4wzFyG9K8ZsFIn5N341tzXn0/LpbSd3IlPXKuG/CNc6tVSQG76ABAr44kl8qxUCOhdgKDWlVUwhbDhGi9XRW1sGOat65MTDH7O9GiOkormFsKRfT8xb8j9fbRhWUy28TUsZ1DR/Lghha9qpSwXLcYrTLPGzW5U2XXwriaUKzRsvAwnXJaAL4TiFOEWGR/Bw9XpkTrWkQ6dCd2A75Jk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b01608f4-99a2-4243-6977-08dc45529dbf
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2024 00:47:11.7077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xBWhSm6ZwJ76N6yFWkEFHvn70FsqWOU6ALyJGgwze8iiJwWOvkGMVOeqpk8DnkI1r7w5voukGDyJCpQvIP3aFGg7ohu1ud80BI5T4blynyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7120
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-15_08,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403160003
X-Proofpoint-GUID: 5wTM9HRmT9WfK2wt6S0yjpZl_MLoT_bc
X-Proofpoint-ORIG-GUID: 5wTM9HRmT9WfK2wt6S0yjpZl_MLoT_bc

Currently, we can try to queue an event's work before the vhost_task is
created. When this happens we just drop it in vhost_scsi_do_plug before
even calling vhost_vq_work_queue. During a device shutdown we do the
same thing after vhost_scsi_clear_endpoint has cleared the backends.

In the next patches we will be able to kill the vhost_task before we
have cleared the endpoint. In that case, vhost_vq_work_queue can fail
and we will leak the event's memory. This has handle the failure by
just freeing the event. This is safe to do, because
vhost_vq_work_queue will only return failure for us when the vhost_task
is killed and so userspace will not be able to handle events if we
sent them.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/scsi.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 282aac45c690..f34f9895b898 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -497,10 +497,8 @@ vhost_scsi_do_evt_work(struct vhost_scsi *vs, struct vhost_scsi_evt *evt)
 		vq_err(vq, "Faulted on vhost_scsi_send_event\n");
 }
 
-static void vhost_scsi_evt_work(struct vhost_work *work)
+static void vhost_scsi_complete_events(struct vhost_scsi *vs, bool drop)
 {
-	struct vhost_scsi *vs = container_of(work, struct vhost_scsi,
-					vs_event_work);
 	struct vhost_virtqueue *vq = &vs->vqs[VHOST_SCSI_VQ_EVT].vq;
 	struct vhost_scsi_evt *evt, *t;
 	struct llist_node *llnode;
@@ -508,12 +506,20 @@ static void vhost_scsi_evt_work(struct vhost_work *work)
 	mutex_lock(&vq->mutex);
 	llnode = llist_del_all(&vs->vs_event_list);
 	llist_for_each_entry_safe(evt, t, llnode, list) {
-		vhost_scsi_do_evt_work(vs, evt);
+		if (!drop)
+			vhost_scsi_do_evt_work(vs, evt);
 		vhost_scsi_free_evt(vs, evt);
 	}
 	mutex_unlock(&vq->mutex);
 }
 
+static void vhost_scsi_evt_work(struct vhost_work *work)
+{
+	struct vhost_scsi *vs = container_of(work, struct vhost_scsi,
+					     vs_event_work);
+	vhost_scsi_complete_events(vs, false);
+}
+
 static int vhost_scsi_copy_sgl_to_iov(struct vhost_scsi_cmd *cmd)
 {
 	struct iov_iter *iter = &cmd->saved_iter;
@@ -1509,7 +1515,8 @@ vhost_scsi_send_evt(struct vhost_scsi *vs, struct vhost_virtqueue *vq,
 	}
 
 	llist_add(&evt->list, &vs->vs_event_list);
-	vhost_vq_work_queue(vq, &vs->vs_event_work);
+	if (!vhost_vq_work_queue(vq, &vs->vs_event_work))
+		vhost_scsi_complete_events(vs, true);
 }
 
 static void vhost_scsi_evt_handle_kick(struct vhost_work *work)
-- 
2.34.1

