Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3FC256A
	for <virtualization@lists.linux-foundation.org>; Sat, 16 Mar 2024 00:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710550050; cv=fail; b=PiUMjfneI6aXaZG1FM8pTF4ugCgSVbUu16S3QoB/dxtj1cqP0N/d+aM090U/6YykPLvkXYPuvyDKd2sfMw7hIGiOBnDDFieaAvSIb2aRpNqIdykBXgPRNCX/Zi/y86kwNca6plbehk+0stG7MXHbuUiVzfxvi8XwZoH74Sz0dFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710550050; c=relaxed/simple;
	bh=bmAiKRnqkYfqd9FNJ/Kl68Uit6KP0Bo9eLuzbozsZtE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tmdt0LsMUfHe/pLnJDiBENc0Ztd54Yqa4KCuAti0yxbw91r2VbA8xC5L0ZxnhpWgu0egMoTE2yXIvLsNJWWfgEt+Kw5Mc/Pv+LAgX84roenVYPJI5prdiLRTtl+OXp8LGcNgct+cijUbh44DnZOMH5zBsBKT93ngryLSP4n5Etk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WX6V7y4F; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xxhuBXnY; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WX6V7y4F";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xxhuBXnY"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9086060ED5
	for <virtualization@lists.linux-foundation.org>; Sat, 16 Mar 2024 00:47:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.098
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ovW6HJv7SjP3
	for <virtualization@lists.linux-foundation.org>;
	Sat, 16 Mar 2024 00:47:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=michael.christie@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0D21960608
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0D21960608
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=WX6V7y4F;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=xxhuBXnY
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0D21960608
	for <virtualization@lists.linux-foundation.org>; Sat, 16 Mar 2024 00:47:25 +0000 (UTC)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42FH9Xtx016067;
	Sat, 16 Mar 2024 00:47:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=mWN0s4Uf80vEi9CzCr2GBo1tfoQoVxio8AaG1ZWqa7k=;
 b=WX6V7y4FgXNggRjr3IkwPJRODGIJHKbMkPq4Sb18d+U2tHi5Sq8uCQZM3uR31MCoYQ44
 SuzZstV8OTVzqTp3W5x99N2BldHsQuILNhTYi2N3bxB4KsPoy6+6h39GHB1598bG2iNb
 gMi/g5jvKeBH5oQM1XMsTu9wgxCv+Vt4HtpxA/QPdF9N8R/TH2afsRnu1UvZQa8+/06i
 8PQYSXkGrEu8elFsNTi4YYxXXun4s14TA+OAb1jSwZWGOkN+hak23l/pWVa8vk9HU8ls
 K7cpH1fEodKVSk6w/lsNO+6ZF0xQ6zheZ3c2n1jm8HNN3IKSaZuKhYc69ooAP7DVvEgI fw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wvsyggs98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Mar 2024 00:47:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42FMwJT7037808;
	Sat, 16 Mar 2024 00:47:22 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wvtmmy3w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Mar 2024 00:47:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4mG2il7YZMSzpNT+WznzPnB5NW8BvRjepQWXzIbcfaEQF5r9BCccS6BTxaosoLkdQdAJ1bhGmbeL8xNySaRzOJvYCvzOnyCiC/T8DXzN5W3FNhiiGXRNGUeAEU7bjGHeYt5xTd3wNxCAHb7U8hP7PfRJINVlyYYj8QDTYw85EnOhsKIn3GcodtnYSSijRVzJBhL2TFBdOwPS/oWk2zKp9CqKvEoAY0DNNcGhoyo4rRtGzfT7jTi0S+OcApUL4s14iqdtHe1F+BUXxt0X+PoI4tShz7EEpxW+bmsC322jW4VSlOgEWMRqrT+LSmo2gbkPIpG2Scd0jMdMBr1VgK5NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWN0s4Uf80vEi9CzCr2GBo1tfoQoVxio8AaG1ZWqa7k=;
 b=lmkg5zTBxM9Cah9ikDl0cc5Vrd9Drds88r1t4aHa5UaghBGG8OGmgwyaUYeMOTAaI7867bOyQ2pm6sjJG4wpdgZ0OcH87m/9KVEO/3UKJq2cnP6k5f7NUIUzGVbza2SCzdCeBu7V2r71F1Ecj7/tqdR4fWI3OQJMj6btloi4aLBthcytfv7ndex0KQEReq+moQzpKt6nGN7LO7Hy3Wb8lVcOl2wH82beBKRS+gdMTr0DwgZ4vLOiF+Zac0kEyWEyFnYebDfYhAuHuf9ysEfT73GRdZwRSkjAvfbE6b3zUuXjbLUt1qUg9P+X+9sMzr5DX2MC//KHanz9VdUFs/mzoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWN0s4Uf80vEi9CzCr2GBo1tfoQoVxio8AaG1ZWqa7k=;
 b=xxhuBXnY5jPxKOfVQieufBNvO2BErraMQ3S0eNi9pGcNmCBBrhMNECdANj6Cl7PxHiWHCSVPeN/BJHA1tof+hQG6XupUeYLuV1akplWhqNstKqcGbKSo0TkPaGmJGwN3az/la+XFpnwSRRQVGNstMVqBG7+KnxzI/PvFWjF9Pdg=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CH3PR10MB7120.namprd10.prod.outlook.com (2603:10b6:610:127::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Sat, 16 Mar
 2024 00:47:20 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2246:144f:3bb9:60d]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2246:144f:3bb9:60d%3]) with mapi id 15.20.7362.035; Sat, 16 Mar 2024
 00:47:20 +0000
From: Mike Christie <michael.christie@oracle.com>
To: oleg@redhat.com, ebiederm@xmission.com,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Cc: Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 8/9] vhost_task: Handle SIGKILL by flushing work and exiting
Date: Fri, 15 Mar 2024 19:47:06 -0500
Message-Id: <20240316004707.45557-9-michael.christie@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240316004707.45557-1-michael.christie@oracle.com>
References: <20240316004707.45557-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0237.namprd03.prod.outlook.com
 (2603:10b6:5:3ba::32) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CH3PR10MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: 86a20b86-462c-4cf6-193c-08dc4552a31c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7BVuYd94abzwXUNPHiZ4RXfFIkmTyvWfTh8CZoL8LDy6Yq+l8OKklNPdu2FEMF4uLzrjzYtU7G6GuWyz/P5Fz9cCsIUmQtawkJK+c8a0f4neX3rAuIOnVFskvN4q6z3fQc0SY6X85jrPoasTYj7yGpCFvt09sPIBNBS8lGrz7O3auYMjwMNBzzzZaYqnsZ3fJts9SmMRU0X5ElG0RNHwWTWuKjlvzGVUzRToDB2CQYErJbIL8gKYxbupNtmTWVqaegTPdSew9oNJf8nOcG1Fs5212aU10m21lSQ9pD21HyQQTjIZVYKFbJe64uxKsNXujpmvgYWViEjXQ66RkcVh52T8fWY8i3DF79c21heeUudPhPpma7gjJYP+KnrJrfAM1pBeOD+ecJz9QHVFFiynxDu93N2y+mmQDOHp8pFKVsQkqkyXpUIcSYTEwDxmnrEH2xdu/yjX6MVNH+oJV7G1J2lZo+7noXpdh2VR98szKY5PRCpPNcrf5bkgU8cDAOQ2sNuO2qQsZwSPPjg/pobotRNtydUyxzxFetXT4uKydnECkAMlXxlm2kK+t3crwhl1/48BTs0O4pm+ZxgsEj1v7oShSeN25mL70ZzkRjjGlv66NwlkmdJvgFpqQYIOpZyWNo04T9eG2hFOjy4qfYHtr6iMvhmL1MYsccHZf8gBJdg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6rWpj0D34hmTkl5MDh6o32KWatcj30uh+aqBs1DyTvoqXoRwdxZwkKhwNI9B?=
 =?us-ascii?Q?pvV/1Dikd+eCrdPbcL78SOwurkwxxfmIGCVpxlywqQVaTLYi5fsZ6qbJfTeD?=
 =?us-ascii?Q?TTdfZsmpHK3FOsHySUVqQxILIjzIxcTyLTdbG63grH6ofgx/BmRHMoiX8iD8?=
 =?us-ascii?Q?2m8ha5XNLRal4lym13jYqKWNsIIktqMwdM2mxNLw13p5MlRQW5HW/4I+xmGm?=
 =?us-ascii?Q?BbE4zEKMfd4l0EvNvhk/lAjs57UsLg2QjZNkM22m8t2mg5NlnDms96CzPQmz?=
 =?us-ascii?Q?PxPgI5XeQxCyxjz3He+dbcxbqnQFdjC/Db2Twsn9H3jJGuvZLVxR3oE9vuFz?=
 =?us-ascii?Q?lppIwXItIxOJ51wIampDptANccMbnVS0g/i7QKarlx/gU8iR8uPGJBLem9NT?=
 =?us-ascii?Q?73f8nRquYBAGfCuxWuvksDRuuSPQdHtcPf8S7EShTjIl/fvkmVdUo2cBpC9c?=
 =?us-ascii?Q?ltaGHOPUSYRMA1zbrs12wpWYTi0QoBqiitQvjXoIQnN/AQsEAEvJ9KgwMphA?=
 =?us-ascii?Q?sZ9e2Nr6/7APlUcn+FyoWU3LzQwQMDigp30/FGPqq/pDwYwwwlBd4MxQIK1h?=
 =?us-ascii?Q?j6Cdo8rj9GLk+6wNsXgNfSc/s4l4EaL6VCcMRHpD8NWCogBNKTuMd3pV+gq6?=
 =?us-ascii?Q?YFkHgEGFJtkcU+2ifbw2MOgTKLVUJBmlh9UJFLKtlquYnUhHIJZ5UdvZuejT?=
 =?us-ascii?Q?vzIGDZ1BKzD8agnglvxbgSSVxiI1Cu1th9OXg8D7ebGQIAx81GZQwLxISVyX?=
 =?us-ascii?Q?NGpzcC335VMxk08yTRfMxp0VP5DVGZXlVEMlb2hoHnMqikWMVi3GDps7Vg/I?=
 =?us-ascii?Q?ruvtxc6vEvxJvkzpvnJzVIVuq5hjP+v9iyRWM8FUUQSMBo45kYX6inW7dUT/?=
 =?us-ascii?Q?TFDDz95YgPKuR/QW25DzlRBxv+wmiCgoulq8gpZRjOtLpjNIp74qgDPVNsk3?=
 =?us-ascii?Q?+Y9+zjT/6ox7fGhGixeNdw6rXDoKQofBz0zHf6/OQoAMVf8GaWB9P/NjQmNa?=
 =?us-ascii?Q?jVDJmAiOmDhQGGQ8c7edeXIO1uDED+cH0o1M8ok/7B3CsfmgFWeaRk7l6zBp?=
 =?us-ascii?Q?uLaN5w1OtOqTXsYt3kiwp1tmRGKQWkzxY4uQQvarldmmqfdMsnvolWN397Z5?=
 =?us-ascii?Q?tN9hduJzyvsVMHHkXFl1917AZGiuELwR9hbMuMvbR5dX0G9zyg5x7Mmkmv/W?=
 =?us-ascii?Q?57bO9End4Gqjyb1WAfmfhL8SfVMdR7UQbUN3zzfAQcXSxir0SZC3rZLmtGfB?=
 =?us-ascii?Q?Z76fho7RQLR6lR28u83wF8x0eVbYb3otJAlEcZtTnnVBZekFj2T4sUG5AGJW?=
 =?us-ascii?Q?lg4yRQDjs1qbjTrAxHqcw4LSydF8himRCcQqmgr27RlPFNWdtUsF0gIiUseg?=
 =?us-ascii?Q?rb2h4pU3Do5MlWicxqtoUpK3cGf+zZjVSaPjfQxS0tDAN8qmTPgyh5rFuQ44?=
 =?us-ascii?Q?sYR1z6MlCYBaQiJeC/KIu73J9k3+uIC938fBzPilMVAYB8se1Ttwzl3KqbHP?=
 =?us-ascii?Q?eVWbeexeo1UGRKcOTNb6qolczyEC08qZ7QYmHDJeEx/7OWt9AuLc82BbEG5L?=
 =?us-ascii?Q?tEgv45qfgcb840D+MZVFg5uf/N9AIgqkynlIuPw++xps3ehnEoBRNIbXrjTS?=
 =?us-ascii?Q?Lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	K2Yh31wvxTW+DdGBLXrGlSrHEslW4todp2FYyU/piLJ2z3MAduKLNwu/gC/yYjnptFDgOwOLnIvXukyBoUQPUguC5TDQ0AshCgmTSpEro3F3bJ9ZlSyIejuMAtfzuUKuRsoenuYKEkJ7qRiDx6TbD1hkqmX1eHJnxaNAp0oI7CZh7ppXhbxKOiHQGWxt5J3WPvxALMi7ryxbLM6kreHb+0q9aLHPGGRTQ9AuqgeaYkd91RxMGXBreXMS/W+UVtZpEP0QxkuP1/D2DV01uycoLvGwheu/ngWpSpL0d+DkZgjMoi/Leux46pCenSvBwb61Nbjk5FyApx/nN45icyq6ledHXa8ozUZU5emJDaYqLXolFe+cict0TEPEROcr8fmYYTy04HOAobEzCZHSkt5PkncT6cK8ic1iaCh9CpSp4aQcuF2qaFHKwEEteYiGrf15E733tWw2JpP/X7pCb7UyOM3i9zImciHoXzsHNspV3WrTWqYQR5i1vdM8tld82TCpPRjOCQdOVmCmKdO991hVt1ShjKBOYY0cdihDKLD80PlaUZ88LbOlADjRCZto6EfGVcq0UNWbfUbkGg9dynsmAu2r5fH72asf5x2CjJWjLzg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a20b86-462c-4cf6-193c-08dc4552a31c
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2024 00:47:20.6982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pm3kN4LtzKDc5I7oaxcbRp7TuOcMaylxD/VysOVAJ0tOuz3QouI5cVZokvl3QizBHVCnJuLmJBZmoXff+ip6nybzfaYzif/gG1DPpDzbWPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7120
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-15_08,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403160003
X-Proofpoint-ORIG-GUID: YUjBpKoiwtNfmoyN_kfm-KgeRNR238mi
X-Proofpoint-GUID: YUjBpKoiwtNfmoyN_kfm-KgeRNR238mi

Instead of lingering until the device is closed, this has us handle
SIGKILL by:

1. marking the worker as killed so we no longer try to use it with
new virtqueues and new flush operations.
2. setting the virtqueue to worker mapping so no new works are queued.
3. running all the exiting works.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c            | 54 +++++++++++++++++++++++++++++---
 drivers/vhost/vhost.h            |  2 ++
 include/linux/sched/vhost_task.h |  3 +-
 kernel/vhost_task.c              | 53 ++++++++++++++++++++-----------
 4 files changed, 88 insertions(+), 24 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index b2012993e9fa..d64f2526c6ac 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -273,7 +273,7 @@ static void __vhost_worker_flush(struct vhost_worker *worker)
 {
 	struct vhost_flush_struct flush;
 
-	if (!worker->attachment_cnt)
+	if (!worker->attachment_cnt || worker->killed)
 		return;
 
 	init_completion(&flush.wait_event);
@@ -388,7 +388,7 @@ static void vhost_vq_reset(struct vhost_dev *dev,
 	__vhost_vq_meta_reset(vq);
 }
 
-static bool vhost_worker(void *data)
+static bool vhost_run_work_list(void *data)
 {
 	struct vhost_worker *worker = data;
 	struct vhost_work *work, *work_next;
@@ -413,6 +413,40 @@ static bool vhost_worker(void *data)
 	return !!node;
 }
 
+static void vhost_worker_killed(void *data)
+{
+	struct vhost_worker *worker = data;
+	struct vhost_dev *dev = worker->dev;
+	struct vhost_virtqueue *vq;
+	int i, attach_cnt = 0;
+
+	mutex_lock(&worker->mutex);
+	worker->killed = true;
+
+	for (i = 0; i < dev->nvqs; i++) {
+		vq = dev->vqs[i];
+
+		mutex_lock(&vq->mutex);
+		if (worker ==
+		    rcu_dereference_check(vq->worker,
+					  lockdep_is_held(&vq->mutex))) {
+			rcu_assign_pointer(vq->worker, NULL);
+			attach_cnt++;
+		}
+		mutex_unlock(&vq->mutex);
+	}
+
+	worker->attachment_cnt -= attach_cnt;
+	if (attach_cnt)
+		synchronize_rcu();
+	/*
+	 * Finish vhost_worker_flush calls and any other works that snuck in
+	 * before the synchronize_rcu.
+	 */
+	vhost_run_work_list(worker);
+	mutex_unlock(&worker->mutex);
+}
+
 static void vhost_vq_free_iovecs(struct vhost_virtqueue *vq)
 {
 	kfree(vq->indirect);
@@ -627,9 +661,11 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 	if (!worker)
 		return NULL;
 
+	worker->dev = dev;
 	snprintf(name, sizeof(name), "vhost-%d", current->pid);
 
-	vtsk = vhost_task_create(vhost_worker, worker, name);
+	vtsk = vhost_task_create(vhost_run_work_list, vhost_worker_killed,
+				 worker, name);
 	if (!vtsk)
 		goto free_worker;
 
@@ -661,6 +697,11 @@ static void __vhost_vq_attach_worker(struct vhost_virtqueue *vq,
 	struct vhost_worker *old_worker;
 
 	mutex_lock(&worker->mutex);
+	if (worker->killed) {
+		mutex_unlock(&worker->mutex);
+		return;
+	}
+
 	mutex_lock(&vq->mutex);
 
 	old_worker = rcu_dereference_check(vq->worker,
@@ -681,6 +722,11 @@ static void __vhost_vq_attach_worker(struct vhost_virtqueue *vq,
 	 * device wide flushes which doesn't use RCU for execution.
 	 */
 	mutex_lock(&old_worker->mutex);
+	if (old_worker->killed) {
+		mutex_unlock(&old_worker->mutex);
+		return;
+	}
+
 	/*
 	 * We don't want to call synchronize_rcu for every vq during setup
 	 * because it will slow down VM startup. If we haven't done
@@ -758,7 +804,7 @@ static int vhost_free_worker(struct vhost_dev *dev,
 		return -ENODEV;
 
 	mutex_lock(&worker->mutex);
-	if (worker->attachment_cnt) {
+	if (worker->attachment_cnt || worker->killed) {
 		mutex_unlock(&worker->mutex);
 		return -EBUSY;
 	}
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 91ade037f08e..bb75a292d50c 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -28,12 +28,14 @@ struct vhost_work {
 
 struct vhost_worker {
 	struct vhost_task	*vtsk;
+	struct vhost_dev	*dev;
 	/* Used to serialize device wide flushing with worker swapping. */
 	struct mutex		mutex;
 	struct llist_head	work_list;
 	u64			kcov_handle;
 	u32			id;
 	int			attachment_cnt;
+	bool			killed;
 };
 
 /* Poll a file (eventfd or socket) */
diff --git a/include/linux/sched/vhost_task.h b/include/linux/sched/vhost_task.h
index bc60243d43b3..25446c5d3508 100644
--- a/include/linux/sched/vhost_task.h
+++ b/include/linux/sched/vhost_task.h
@@ -4,7 +4,8 @@
 
 struct vhost_task;
 
-struct vhost_task *vhost_task_create(bool (*fn)(void *), void *arg,
+struct vhost_task *vhost_task_create(bool (*fn)(void *),
+				     void (*handle_kill)(void *), void *arg,
 				     const char *name);
 void vhost_task_start(struct vhost_task *vtsk);
 void vhost_task_stop(struct vhost_task *vtsk);
diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index da35e5b7f047..48c289947b99 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -10,38 +10,32 @@
 
 enum vhost_task_flags {
 	VHOST_TASK_FLAGS_STOP,
+	VHOST_TASK_FLAGS_KILLED,
 };
 
 struct vhost_task {
 	bool (*fn)(void *data);
+	void (*handle_sigkill)(void *data);
 	void *data;
 	struct completion exited;
 	unsigned long flags;
 	struct task_struct *task;
+	/* serialize SIGKILL and vhost_task_stop calls */
+	struct mutex exit_mutex;
 };
 
 static int vhost_task_fn(void *data)
 {
 	struct vhost_task *vtsk = data;
-	bool dead = false;
 
 	for (;;) {
 		bool did_work;
 
-		if (!dead && signal_pending(current)) {
+		if (signal_pending(current)) {
 			struct ksignal ksig;
-			/*
-			 * Calling get_signal will block in SIGSTOP,
-			 * or clear fatal_signal_pending, but remember
-			 * what was set.
-			 *
-			 * This thread won't actually exit until all
-			 * of the file descriptors are closed, and
-			 * the release function is called.
-			 */
-			dead = get_signal(&ksig);
-			if (dead)
-				clear_thread_flag(TIF_SIGPENDING);
+
+			if (get_signal(&ksig))
+				break;
 		}
 
 		/* mb paired w/ vhost_task_stop */
@@ -57,7 +51,19 @@ static int vhost_task_fn(void *data)
 			schedule();
 	}
 
+	mutex_lock(&vtsk->exit_mutex);
+	/*
+	 * If a vhost_task_stop and SIGKILL race, we can ignore the SIGKILL.
+	 * When the vhost layer has called vhost_task_stop it's already stopped
+	 * new work and flushed.
+	 */
+	if (!test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)) {
+		set_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags);
+		vtsk->handle_sigkill(vtsk->data);
+	}
 	complete(&vtsk->exited);
+	mutex_unlock(&vtsk->exit_mutex);
+
 	do_exit(0);
 }
 
@@ -78,12 +84,17 @@ EXPORT_SYMBOL_GPL(vhost_task_wake);
  * @vtsk: vhost_task to stop
  *
  * vhost_task_fn ensures the worker thread exits after
- * VHOST_TASK_FLAGS_SOP becomes true.
+ * VHOST_TASK_FLAGS_STOP becomes true.
  */
 void vhost_task_stop(struct vhost_task *vtsk)
 {
-	set_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags);
-	vhost_task_wake(vtsk);
+	mutex_lock(&vtsk->exit_mutex);
+	if (!test_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags)) {
+		set_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags);
+		vhost_task_wake(vtsk);
+	}
+	mutex_unlock(&vtsk->exit_mutex);
+
 	/*
 	 * Make sure vhost_task_fn is no longer accessing the vhost_task before
 	 * freeing it below.
@@ -96,14 +107,16 @@ EXPORT_SYMBOL_GPL(vhost_task_stop);
 /**
  * vhost_task_create - create a copy of a task to be used by the kernel
  * @fn: vhost worker function
- * @arg: data to be passed to fn
+ * @handle_sigkill: vhost function to handle when we are killed
+ * @arg: data to be passed to fn and handled_kill
  * @name: the thread's name
  *
  * This returns a specialized task for use by the vhost layer or NULL on
  * failure. The returned task is inactive, and the caller must fire it up
  * through vhost_task_start().
  */
-struct vhost_task *vhost_task_create(bool (*fn)(void *), void *arg,
+struct vhost_task *vhost_task_create(bool (*fn)(void *),
+				     void (*handle_sigkill)(void *), void *arg,
 				     const char *name)
 {
 	struct kernel_clone_args args = {
@@ -122,8 +135,10 @@ struct vhost_task *vhost_task_create(bool (*fn)(void *), void *arg,
 	if (!vtsk)
 		return NULL;
 	init_completion(&vtsk->exited);
+	mutex_init(&vtsk->exit_mutex);
 	vtsk->data = arg;
 	vtsk->fn = fn;
+	vtsk->handle_sigkill = handle_sigkill;
 
 	args.fn_arg = vtsk;
 
-- 
2.34.1

