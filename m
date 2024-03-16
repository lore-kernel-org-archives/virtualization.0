Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112FB17E9
	for <virtualization@lists.linux-foundation.org>; Sat, 16 Mar 2024 00:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710550047; cv=fail; b=IlX4z/m8YISLRUQrLgg8w94hIPsVzXhN+QaFXVyorx8d5DhHAzEOEddm3iTdooYD67Bh3BlLBml0in++Ii1VDBKm/ZqFXPUJYnHpnbRIUiIbPouFYNb8QfOj03Re6w/GIPjdSX1tGwa56NLkbHjiCIm0jy4wCz4mUfn5X3aFXw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710550047; c=relaxed/simple;
	bh=jRrMIoroKOz2b4eAHI9913nGZIMZoandRrkiA9UyD6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cRifqZ5GFrpL0GXwC0InctOAI29Ok+7Z8WrI/UEvuC9mdYKGxmv54ziCh7IDtEuS4w+Do/ALvFMPwIWHYRzrplIvWaZrK5ZiVaAs9cHQkjPeY1+nPw2LYLPgyrDKyWLXrOsEOxcBU0cp2c5WT3yYlDek4RAfn4ph/1RPRZuBLWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HGbeQrTF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hMpvJK5h; arc=fail smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HGbeQrTF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hMpvJK5h"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB74E8278F
	for <virtualization@lists.linux-foundation.org>; Sat, 16 Mar 2024 00:47:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.798
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Br3FtLRxRlPx
	for <virtualization@lists.linux-foundation.org>;
	Sat, 16 Mar 2024 00:47:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=michael.christie@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2DCC18277E
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2DCC18277E
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=HGbeQrTF;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=hMpvJK5h
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2DCC18277E
	for <virtualization@lists.linux-foundation.org>; Sat, 16 Mar 2024 00:47:23 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42FH8xKL030186;
	Sat, 16 Mar 2024 00:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=79tnHem65/9eFniiCeQgG5qMiXuli/gPs5t0Wn1nnmE=;
 b=HGbeQrTFNYDuU+fdR9uem4lSTunJbZBwp2FExblSkTj1oF+0StQTdaObHw2hrpIPCfnk
 xxcVAkcFGepxllqJk8JS5oobS+o4s19HxdFmE55qloHNzCxifD2oiazcLGtDLy7dCLoi
 qgCOCmumEFwncRQhF9xGdmE2JCjHbppOYbmEfB8ZLLgExRn5fl2Y28jH7zcRyCWNveHZ
 ngYposa+TaDYMr3F0HgXaHk/jjtYcn57g3IMtQbJc0y8nCVhlguNAezasU1L1SxnjBX8
 SSADgGq32cNJvFPlPMkYf29zjAezmcUTQb4dWMvNwE/6iAAacGtNWq9/Dmc0WfPX/gZA Bw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wvt340t37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Mar 2024 00:47:20 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42FNPcrf035921;
	Sat, 16 Mar 2024 00:47:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wvtk0790m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Mar 2024 00:47:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGHbpTdEfQK6sQ4mPvx5jaPzXNDMr8PV3xPvBEzcIcCO9gJ0iTD1M0vSX5/TK8EkbIIB1vGu+MjUFPisDfBgV+XlOEjOaNpDIbuLV7kEyxD+HicyxFxDmtuajxT2EynHAliNi3eBmql1/aZ/o2vFrbVKwDZ1o2XsVN4XcPQ5wTFY3NNNjN9FtGtnf5EcdwqPuaLF29Acngc3rz6dYJSTV12vED5ko7lO27SHLyk1ryVslBk8LuQLyZqSe+Ljhc2ypWcR3W8sRsl2PfXQn6aYXcrXPiA6nRk/fJUAuoW3MEA8DABuNlc0b/R/KIOQZsExaCJd9uIzXVIVoOE7vC3wfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79tnHem65/9eFniiCeQgG5qMiXuli/gPs5t0Wn1nnmE=;
 b=A1s5iXrRarXDNr3/0DahJNO7hcUZGrTx/ouD22ZZiDUdgvlTvkkv75ZcgtVgkrz9IWwMyGyXMBYw+id+P6HlT7oPraPsgsAZuM/U8Yw2aU4+wAWGxUA3G1PdCUyH/wzCl0H2ULzTcq3NR1b2DdJoL7UBheX2P2iUedJHefboFD3k2c+xiFh5YE4J3os4vIDRx4CDSE1QNHwXb8svuzLAQz8YcfanwY5vjO66n0jJcn05f8Qz2AOowshcXS58+eWHZu1iMNlX6axlpEeXlC/P5qMCDWASOBGBjYsGKTDwzqYZIOJF8fDsUTqpyPMOq+K9tnqnRAkh6CSqD5OCD0j5aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79tnHem65/9eFniiCeQgG5qMiXuli/gPs5t0Wn1nnmE=;
 b=hMpvJK5hqtULVteIn04vN5+ve9RCmeyHAeAa7wwXzSx7ns6SdK2kUBSbCID3rQWzycRyLItT/D5WNddPWtikZ8dmqSfYsEBCmoaJhJz+qDX29wtJwbVr7VNJFuwJn0OYpfQwUKZfFH7+BYbNgbYy7jZH/XpzXRfqg62AooBs/l0=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CH3PR10MB7120.namprd10.prod.outlook.com (2603:10b6:610:127::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Sat, 16 Mar
 2024 00:47:18 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2246:144f:3bb9:60d]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2246:144f:3bb9:60d%3]) with mapi id 15.20.7362.035; Sat, 16 Mar 2024
 00:47:18 +0000
From: Mike Christie <michael.christie@oracle.com>
To: oleg@redhat.com, ebiederm@xmission.com,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Cc: Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 6/9] vhost: Use virtqueue mutex for swapping worker
Date: Fri, 15 Mar 2024 19:47:04 -0500
Message-Id: <20240316004707.45557-7-michael.christie@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240316004707.45557-1-michael.christie@oracle.com>
References: <20240316004707.45557-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR18CA0028.namprd18.prod.outlook.com
 (2603:10b6:5:15b::41) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CH3PR10MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: cd396da4-e2f6-442d-e890-08dc4552a19f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8mPrnNsvS/qw22ehylh0zdR+slXP1fxt1+K8RN1UoD92NFeRliJ/cnK8ECjnYSXUjF3cdBKql1OGyv1DVxmKyEy0O5iKb5MhgXQrxJR5NZHyd2JakwiYpS+pQVUwxyvM41+ZfK9RhE52RcheN4UL3bvmw3wz20t18Vz7PgyquaYCtvKbSiwgp2xCrZY3NjJiGc8QCTb2oyOzbOky5CMnA66e0Pix7IHfPI6O/twj0eLggZAGG8fuIGJvKinLw1xS5m9bGWnngxOb9Q6cqQUIcOaBQ+aSI5KDfQK2X6i5POg9jx6hSo8xK17Nv0nM+wCEE4YSx6mzXK3qgMOPDCdGchcbo7VK2NApjzcc+1No8PMYKwspTKs3i4nwtSK6uR324VeW+xiCwGGsRvro2IEd/BaxI/7Zwgdr6e9jLZVEciO/e78fI+j/8VCZxUefsv/fvLogtB79IsBOGxf2pfr4mya5B3cJsRiTFko6d0S6uxu1Lf2W0QZvBpMVkJOYlyVNdBclwOoLcrzD2RMCCGYiS8YWlnliHHSJQdAmLANIxPy5gqUIUYXnvkdRk+j7PUxGuUPFlwfqhRfA+ZbrK3GK8Y4Sf0eY6r25otHKn4sNIPfAx+d2FlYAJFmygKC6nXqpH4OZOrEywJeOkX6JxBOkMFcipDBsfK94dZioAJaDvzA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WFVYUyNoaJHz7qClsbnninRcdqb+rfeYvQoHJSyr+iYjoKKYdHvmJhs8a6Zg?=
 =?us-ascii?Q?+Z5hgMxc0weREU7EFDZGJLd8LBmIHQjSXQJe6eOXKU+Kb6jW5DzgHia3yt8D?=
 =?us-ascii?Q?vMiaWvk6kWbarQ70tEQNcUeotL28yPFsyNQ8PU4Zfa7sGB5nJ9XpVODkAk9A?=
 =?us-ascii?Q?DFgxqd8T840AnXlmtNceKynaFq2Ex5MWtZjaOht1f9fP9fF6mJ23MUkxTHrr?=
 =?us-ascii?Q?Nqv23Jb4t3+1FRJt6kwPY3n1KyUGZsv8C9lTOwcnBK05eetry4oukusuxbPl?=
 =?us-ascii?Q?aDSMS4XvTG9I7GP821HlxOg5xl7xoHeMRnJ/gZuyYfy0I66bowj6a6lSH4h1?=
 =?us-ascii?Q?mUzDnYQ9LkoDvh7r0eN6TCMrNXK+4O0p4o4ezyC6bDbSFC5y8w81BEn/pnjz?=
 =?us-ascii?Q?vE87IvrbmY5FY5FVyjqpzx71Zh2yYoenvEgMfhezEP6vK5Wcj9OminnmKA/a?=
 =?us-ascii?Q?5Ch6I9bPEBQYNWnWsbxt70bfBceULZX4Ya5J2A6brpZM+vpijOUpe8+AD4hT?=
 =?us-ascii?Q?CMW69QXnHaFN0KoU3+lQvQLVR1eez8bEYid6LN7fu5OwqGGm+6gKmhVBBiLV?=
 =?us-ascii?Q?o0LDnZnWhUHEeJZzRUTfoJxMx4e0oCKjjVZUU4ZYGrdF1v56bX6CZPZwem0f?=
 =?us-ascii?Q?bqeTdZ451o4cpbc3SWNkzHm8JZ40PE1jLrOtHeeuiyCShfoQaZfVDqIxF6Ag?=
 =?us-ascii?Q?wYus+MgIWCifuZ6RZFobjWFVco8H2hQ1osD/jcPzt4Kxt2plMzKW1AtP3mub?=
 =?us-ascii?Q?lX3uKx595Ce9Wa45fcL2FnCyX2Q1AIqxZZbScgS22n12jn8iwWz6WXkolYtO?=
 =?us-ascii?Q?0sVxnfwEySgz8iBMxC8pWA8d4E2PeT3kG196eRymorgrhThfkOlY25/QAefL?=
 =?us-ascii?Q?I389o3Ja0uPHCqbAt8h57Ir3oh22E5SQiPeZFN59XE8NWA83oa7N+iL59ZA1?=
 =?us-ascii?Q?TwI7dAKpznflfhenU7jiU9v7PfeVLLGLnpKE5uO8H4x1VadWN8Nmb424iwN/?=
 =?us-ascii?Q?7tORqg8k06pe7lQtO5n+7M/yEep17/cNkOemrZ1k6cFCXSbMDL7YNGqPhk/l?=
 =?us-ascii?Q?Rw/RjWy6TReY0Yy4XcWaX1E5JuLXTRUcyPxeMipz2BekdOQs5wzfnSC4JRVA?=
 =?us-ascii?Q?YXteXHM5SuMQWn1idoIfMc9qrmjgSjb4PafSipctZHPeAQ+o4BBrI4MU0YBD?=
 =?us-ascii?Q?O95RCE0IjLtm9hEJeIxACQOoXmxDcpXNJmM6YLYvUYaduF2qccamrCb06yDr?=
 =?us-ascii?Q?TyYLlU1eaGcq4ege0SX/iZ6dHb0Jmurwd3l5TCI7RplJsB6uc6iMPw2C1SCd?=
 =?us-ascii?Q?esDKfmNew+5Ch7beEoVT+nDjTk7zD0ydiSWV3T14PZgwVsnsFh8U9+qYEJrU?=
 =?us-ascii?Q?VXTRg/x4sa4i3LC/bChWwIBKM8nBXBBerS8a3RV/W5/BwjoyC6TG7+Yl6QHT?=
 =?us-ascii?Q?2BCpMMnZHPHfD1ShnN+gwoRrjf5qXsiIGEdqM4UuqWnAHmxIg8kME3Rakcdp?=
 =?us-ascii?Q?eMjCwOAIyLEuaMxr3HSCx+afJmMZWCwJmcKu1kVLtQRq9b8xekCnc2yGM/60?=
 =?us-ascii?Q?xhCCV8Tz0rN3zG737WnFYe8lxKpbUYNt2A7iHCFjWexmRsG3FbhkdEgNZ0TU?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UpIuDKVacNXFdLhAQ5cKSuAWNR7VSJhBsPHjnBnmnaRlZhvRTBhu0raMVpaG/SxYoQq2Wns+RqpOujoWyCARMN/xongATAQSD7w08EooaRyPYLvqJk+UlZYNaWeghSoefWY6IZy+hw/25DHoIDZ0+i254in5YmVSPgwIgBJT+bFYdtPe1DZNnvE6SkZGwyNKM0erhHFGKeWmAx53POTfpIMY73C6eqxoNRT0rgrbmNciKTfCUDYoq8VUQnbVlXiJ+Ep3v9EUf7K03v7yI48UNeH8osFOYngn5x1PgPhHapJovZseIREbBqMOKCnILtmsBVMToMS+pihzxwfHUpBjT5eNlHyctMueq4PN9DoEaHvNX9/eC9bQs6k7vIxMplXNoIqDQ6ZBKDwgkMXcyPhCHiOBLCOxmFLVcV4Dd9rpIk4Oows7fpYP0kjEpfI58AwIhyx14vFWmGz3A/JVAaQujIF5y8/IUqjbSBGOge0wHykL31Tw7ijTcG/bTahENIZjKqs/0YEXMlQIcpHFMU4AUlGyDVYi39JUU1cJnlk/MTMVGuiZuqDmXYLG8yTAsi+C6YJmpLZarLiEwWssFr+KGakt/dRXjk0I/5eGsFW+YSo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd396da4-e2f6-442d-e890-08dc4552a19f
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2024 00:47:18.2057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RhMTEqps8MhHRvXsEfTg7t8e6AbZKHmwAmecWa/UaHZxaj9iYF6t2VCiUbU11d2ZJW9bStXW93XcQGCEg+UIp5rX2FjwHj+wLkUq8W82NiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7120
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-15_08,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403160003
X-Proofpoint-GUID: Q5HLp-cV1Xcx35z9i5Y2bhbAWWSLsw3n
X-Proofpoint-ORIG-GUID: Q5HLp-cV1Xcx35z9i5Y2bhbAWWSLsw3n

__vhost_vq_attach_worker uses the vhost_dev mutex to serialize the
swapping of a virtqueue's worker. This was done for simplicity because
we are already holding that mutex.

In the next patches where the worker can be killed while in use, we need
finer grained locking because some drivers will hold the vhost_dev mutex
while flushing. However in the SIGKILL handler in the next patches, we
will need to be able to swap workers (set current one to NULL), kill
queued works and stop new flushes while flushes are in progress.

To prepare us, this has us use the virtqueue mutex for swapping workers
instead of the vhost_dev one.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index cd79075da294..4252c3b827ca 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -652,16 +652,22 @@ static void __vhost_vq_attach_worker(struct vhost_virtqueue *vq,
 {
 	struct vhost_worker *old_worker;
 
-	old_worker = rcu_dereference_check(vq->worker,
-					   lockdep_is_held(&vq->dev->mutex));
-
 	mutex_lock(&worker->mutex);
-	worker->attachment_cnt++;
-	mutex_unlock(&worker->mutex);
+	mutex_lock(&vq->mutex);
+
+	old_worker = rcu_dereference_check(vq->worker,
+					   lockdep_is_held(&vq->mutex));
 	rcu_assign_pointer(vq->worker, worker);
+	worker->attachment_cnt++;
 
-	if (!old_worker)
+	if (!old_worker) {
+		mutex_unlock(&vq->mutex);
+		mutex_unlock(&worker->mutex);
 		return;
+	}
+	mutex_unlock(&vq->mutex);
+	mutex_unlock(&worker->mutex);
+
 	/*
 	 * Take the worker mutex to make sure we see the work queued from
 	 * device wide flushes which doesn't use RCU for execution.
-- 
2.34.1

