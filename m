Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9926D7F47F
	for <virtualization@lists.linux.dev>; Wed, 22 May 2024 22:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716415793; cv=fail; b=pQOXSIcfIfsymfPxgYldnKbX8bZhSrPuS78R9AmTUzl89R5qwhtx1S96g0CF52WJvKDsFL5tZr853iHE7Td2dJZO/rtk1FFU/TxyahgjRYUhiVp9VBRPsnNseW31L8F4WzOS5LGIbzIySi7rWhY1kNL1bwK5O6LRN20xbdrcLUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716415793; c=relaxed/simple;
	bh=F6aSWjuatX8DARvbJS11RiV8apYmk7S8SPIi1mVEZH8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dJ5d/4hHxM54aaI0LS2XYJoY7cetwHmu0oTYKP0PnblIaSNN10pwEQDvjiRQKzgAHg4t0fw1kMX4PsgPrlhUuNiiY6lcr91SaImtRaiBA3fzetSae6MNV3DZsZhk8SQ+VmlarrjhZinG4IM0JoK6VidFbh6gaDo5IQ8dpb+5SJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FLD35LrV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XMYvLpHN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FLD35LrV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XMYvLpHN"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44MKnNbJ004264;
	Wed, 22 May 2024 22:09:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=w1gTrUrZiuTMOvCWSz2/9CXuYtFSpOczVjU2+S8GRDk=;
 b=FLD35LrVXEpq2fd1khHzt53FB3eICcELm3z54qITDGvTjg97ozW+jUYkx3nkkiqhw06+
 PyBzf0KSv1xvHpYhoqEcUpMoQgjnt4puKBdCusIX2ISVCDR0uFzXOtdyWklZynVqQG7Q
 zd5h6QlqsTtVlzWLE40efkKpgFmxZ5nAmarfu+agFD61ab5tn9Kxmh3gU+BE+VrREPRb
 G+1ENfS3LynrT5lOAQC+63NxKyJN2jp1JF7Zq5jaWLBDqpANaptE58Jitcbj/S/MKqj5
 oNS3NjvnOliiZ/YXD8oKjqIhxO/IfaCnH6V8igmeBdFAGzLNjSTRc1jvqteE2a/lBUCv BA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6kxv8ve6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 22:09:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44MM1rhX038382;
	Wed, 22 May 2024 22:09:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6jsftpjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 22:09:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0XhCn1q6buzCfRbGJ9TYNId5Tg56utwt7sdjURnitt+F03l8o2ark2+wM+qtZRMYvJd1WCaYFJMz6WX4lH0Iq15p+GEoZOzXYmWoOCpWIoIe7NZ/8c7o1VYR+gcOrF7vXS2ASuuOWl0hzh20LDVI/PKGrmLbWDbbCD0FWKtKzNAbthZy++uiQw8XGUi9BdNA86ENhEM6JXHJMhmVkX2rkCx84l++0pc6f9c5T9Cjthcj5m08EjD6glm+pscbGkuclxg+UwQdrnYmoyKo8y65GKi6LF2cl0eLZbAbMuxDmZ8x/FOfHPnndXcrJfu3AUpDFMTuhp6Ez+4PYNduUwSDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1gTrUrZiuTMOvCWSz2/9CXuYtFSpOczVjU2+S8GRDk=;
 b=Br9IaT2hlS5BHs9jrhKz2wFhTKtsiJzMyGk6WasH2hnqx7fB3Kro6TocM12ERd8W4Cwjw8S0xFXyh8eda246zfsSZw2Fe+RPGCGh4Oz6hH7DKOsTmg4K9823bBUeqBy9idTcmiQ3li01DOurev7ghw/QuzRvFZK/gdP/Z79TTXCFfhQ3cqvKR4ljU/ypILlG4hLWcXoQAOmbc9ZYYAReGSo1ECDfie6QoHIRSrSGG/CDt8J4v4BZa2SMvorcvgf8Fh/u82dP91uhzSGu1yGbf8rkDgo7oNFsnrliNR7jp//3U46m9BdJ3NANVJv1kVgBpTJhmVNOU8c4WfNNMmlHpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1gTrUrZiuTMOvCWSz2/9CXuYtFSpOczVjU2+S8GRDk=;
 b=XMYvLpHNjd4m1PBFL+gQCXfZRMfDo8wpwqWoO0W4dDCM2l3GQKjakDs5e2MEDuiBWTXSxPd7rl3JkxendnUKGAW9qDyxZM3d5avgg4KrbsDXYLBGuukDCj69E/6FCu3A7LWWcrqg7KhQY9cyh62Py8Fuj3QpR0cXqAaBCXP+rbw=
Received: from SA0PR10MB6425.namprd10.prod.outlook.com (2603:10b6:806:2c0::8)
 by CYYPR10MB7606.namprd10.prod.outlook.com (2603:10b6:930:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 22:09:04 +0000
Received: from SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::447b:4d38:1f8b:28f1]) by SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::447b:4d38:1f8b:28f1%4]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 22:09:04 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, joe.jin@oracle.com,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
Subject: [PATCH v2 1/1] x86/vector: Fix vector leak during CPU offline
Date: Wed, 22 May 2024 15:02:18 -0700
Message-Id: <20240522220218.162423-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:a03:331::31) To SA0PR10MB6425.namprd10.prod.outlook.com
 (2603:10b6:806:2c0::8)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR10MB6425:EE_|CYYPR10MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: ee0c8521-8267-48cb-12e2-08dc7aabcb0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?EizVEuHEbr3wIlSducTWZZEroJW0kz/S+3+zT4JJYMpCVb2dgWwf6Kv2PSaa?=
 =?us-ascii?Q?2B/g2fBxpJRYbqEIQNuD0Uqmf8nXYpHM9cDa+hP48Ke/cyi2I57ok4qsiqX1?=
 =?us-ascii?Q?s3I1tzFu8tjcX/l45GahgE7ebF6DZer3sTJx5bO8z85EK6zySvsysOyl0JEU?=
 =?us-ascii?Q?JoU0cFon3UmbScSrAxSwK4gGD/XEPrcj+AjsYS+FaZB3eVUNUOenuQrVOAPL?=
 =?us-ascii?Q?2uOKYcGEzsvQLS18ThMzOlgskGTuwAWaPifjhZda5Ozj48HgpanpG/FF9AlB?=
 =?us-ascii?Q?RP+9mF9V5x+59BMk5ng3/vpz6FpNV6iVVhFDVP4phPCc5hO4iQw19LF5Lsph?=
 =?us-ascii?Q?KVE5TNqI1sOTX/L3lGj0NE1Bj+d9wJMSi3ffL99K2V56c3gsbL/cTvdXSog6?=
 =?us-ascii?Q?is5EowzJ2Jhv2XMw/R1Cn53LAk0B88Yr0ZXG7xjX+v8/5O9FrLeYTNSBobPp?=
 =?us-ascii?Q?EI5SeVNdMkhGLOgmdPeSzPziZaik+zHoJFm1/pDW9awYLQrpj3qLimn3zWqm?=
 =?us-ascii?Q?4cxVWcv1LKdtelCSmQS/z2zyuLYdsNVHhs5CaJX4DIW6dBayGJKtleh6DcYo?=
 =?us-ascii?Q?ZK9XmGv9iXKPrzYW64jnJiz1IbQsCtkOzdedhjOAG8Dltda1iXSQHsPQj0OR?=
 =?us-ascii?Q?27oqWFQONbwHvE3w250Qq9EoHIPLDUIvmyZgfrRDarsLa2H2c2cAVVsVfrdY?=
 =?us-ascii?Q?xnJS8q7RTjpDkMKr4mJ/TN8DMGzq2VvfODmVAgVHlFoRygkpa+VwZR2/DPO1?=
 =?us-ascii?Q?Z9cpwBAZeh9rbqqiFMwTJ+flFRkneCb0NAcdwpHSHu7Hpuii5V7oeEMUVTd+?=
 =?us-ascii?Q?TIsWLTzlibGT7MsgI7AoOw10ZVikewAEFZPLc7zBO1ozjfBardv0fjkvvlqZ?=
 =?us-ascii?Q?9hR+1q3TFZ8Ccg1ES6tJzGj4jt5/Wqub5TOCgWP607ZrC7lUBUIN7rmZWc7i?=
 =?us-ascii?Q?LXNdFFiChZmRuG1JPXKt0zHlWMujmEAK4i/F2p+yk5elOAcvDy/Dtj9TXvAf?=
 =?us-ascii?Q?u6SYi9mLVqUGrGuzEY7dIgmbIFbf234+2FiY1287ooh+0JrQlzgzMXq73uzF?=
 =?us-ascii?Q?Je9zDjqw48crxj1JIdRdw8wZ/GNobd9yGokeHrVj45pcQY6fD2EEXd7KrYIq?=
 =?us-ascii?Q?nLQXWxTT/Aiuml6iUMdHBWvV1O+6UWuteuoH0jU1WO1L3oRf1qOJh33hKjWz?=
 =?us-ascii?Q?jPBt1s1zmdgpoWQM2R+sYCsB7d+Dl/THte+2EDNGS5LXHhxZUtPxbuz7d6uo?=
 =?us-ascii?Q?tWSb9sBVv+HGoGwlEqrvdb25nLKdg2qVh8rsBRh6TA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR10MB6425.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YomU4+3Mm6RmiayJ5AKftol56QHYpt+yw6z9Gcd2PV4srFlOTadqIZK2rZO0?=
 =?us-ascii?Q?Z5oHw2OBbgQa+44bzAjJVdZFEuwzJQWSmLlKOyxbvykAsWV0D6rzcB2FKeoV?=
 =?us-ascii?Q?GI86u8F7NxNzgiqxJWPyLi3sBGjTuI9ZwixCR4nMxacS6qzwOp4JHbFD4O8v?=
 =?us-ascii?Q?++qXV4Ljr/VDGvjVaApzW/HR4EZauZasvipka4i8GSIwCgu4kgaimrOgApSl?=
 =?us-ascii?Q?/tWoNWNzIUXLIWnQSsdohVOz5p+BjrniM+l9BXtaDVF/09CLv6+BPwIxzd14?=
 =?us-ascii?Q?+khdd0ZxRKOTMfToXDUFryaI3YINrk0OSpWSDU2jgOpG167kM0++LrppGdxU?=
 =?us-ascii?Q?shpjb7w8UN/nddwUVPtRdra+fyhwdqKLqu4C1asNZy55hH+bWyItM8QFp/dF?=
 =?us-ascii?Q?/mylaprnYj2gXFD5RgG0paXD1zou7/iJMvbIgIqv1SQg0/qw87dnGRNeN1X7?=
 =?us-ascii?Q?9fAP78F/Lmtmj8gFSLmK9dNW9bGY34XPUMLt0EiYRcpBXzl+w1vJ5mIeetNO?=
 =?us-ascii?Q?V407EvgVCcYJqSlHvpR3y86BA2pM/OA+5iEl9AhbKOUYEgcOahkIPqjP24Z4?=
 =?us-ascii?Q?vuFGW3EXlj9nPA6dEQYa8DYIypR4P6qsNanwlV/8fZ1n56CXxn3hd0oDnrc8?=
 =?us-ascii?Q?aKuwrj6988yyAa/83vye7eMBpF9GjK1FJVz4BMWlglHden0XcWVAePD654xP?=
 =?us-ascii?Q?LZZ9Uvnfn/KB0T9p1iljutl0X3XOlASS/DlMyph+dn8tL2L7aJ0Uy/c9vrOG?=
 =?us-ascii?Q?Eb9pLRwQ90FwBLFECNSVlFOeRE8r8fc1FUYXxL2BmskzgbB86JYyBd9/MsnX?=
 =?us-ascii?Q?jq9xbtUMIIpjtoBTs6MnEmAd/gWcVOfIcJQUAZyk4eZLEGmJpeJ7Myk5nORD?=
 =?us-ascii?Q?+M43OQj5pkNbsC8d4d7NY5BFMH9O5u+wrdJwlAKhbEawN/khrXNO752i5yt3?=
 =?us-ascii?Q?vG4O32KKafp/c4y5GwjZ1Bd9CHXZ9nOELYWom56WD2VksJ6Hcqy3PXJ2Xvlo?=
 =?us-ascii?Q?opZPMOwexX5oWI5dINZgOIZEbKLezbVfatGoPbtqggrYMbpuKEijrbBHu9i2?=
 =?us-ascii?Q?7ChnNe9pXMkeogPEMiNIZTYz/JTWZA3+t0W9s3sr81auWhNoGPgbfsAdINwM?=
 =?us-ascii?Q?nxALx7CiOpszU3BYeFrKsq5aaC8Z+DTUubvutS9YOn4nhaO0PT51/3Xcycox?=
 =?us-ascii?Q?fV6NvibxKgeWeevr9CaHMQ2HTslEYMOgvvb+nl5sBjpNZucmI/fu+7SiKa0+?=
 =?us-ascii?Q?ab4DvKzaf9zwwKWBPawNrEXcYr5yCJo8DVAUXK4IsXVs2nLRG6o3coaeQtX7?=
 =?us-ascii?Q?ruPrjuFkad7tMdvqxjN/BXKEvBJAajlHJT2c6nPn1iySrSf90cAE0Gfy+SPl?=
 =?us-ascii?Q?3R8yMyrJIC7SdGDxkLBmrfgsKQUDvbv3fg0iAI0A21wRtPT8MOTcEnEknnM3?=
 =?us-ascii?Q?2PTso5Fu290AZMefswEcBwh/fpFj9KGobR1kyNvexHGUg6Ecu3AW9m9KqM9/?=
 =?us-ascii?Q?x83vDslN+jfRRULvbWOrW6jFpkvY4jI0348KrVlp1rDkVWZwEM4TzQxViumb?=
 =?us-ascii?Q?99q0MKD8kNFppCT10u3zg4SdkTHxMvvZQ5KG2u+3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	NbSbcIh45nZpeDKR2/I3nZz5BCYvcWt3HZwJobtci51StoyThAWRuNT87C5FonrakQJGBrb7tb74sPHP4BbG6dfpBjvjBRhNT4gxxZv+iqX7n5r5AMMjcagd632yijOGW0AtmZXTRlA58+VJouHpGNHF3mj0YQV2Uc0RXxqsLYNbgK5o9FXzeJgQa8GtA0EKjisLGiHnQRs4sx8yGkfQYi0hyoMpJW4wvv9Q9u8oNQpxMHeOqMyNzidkYSfQtKkAUVUrKsA2d+J08kKyV6YC4cLqZhiucBBreBsHaz3sPyKU6aHgiS2rVcN34AZFsyOEw58YM5kinp6QnHfVHzB0gZlinVbCifwsUvMH2VclnFZbIFwn7XdsqlDQ6iLFg0xscnfEn/IZe/lftJyZY+cYXrF8N6PZ2cTV7A2wRK2PUj/+mLngrJ7bZfh4DI7dJdCbeh/M1SvRtI4eOPCbuuwgKt38cI5LDAKsXizHMGFeQde56goifs4NeGQ9Lqw9d6Q0y4nOubUmA7Qg3NUO8rJ7Or8hQxwJCPKSu5x6QnHacJg5a6kiFhk795jFWl0AQWtIUdc7zR4dK5EWdTzbz1oNEEAkwLB1XLnr2HaQc6Hp6q8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0c8521-8267-48cb-12e2-08dc7aabcb0e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR10MB6425.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 22:09:04.5369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/tOAH5WDkKJygzYK8/t6Ilqqfbs9N44rbABAOxX806nvgibFK9ZlY9GYiVrqlc7qNsfRz4KB/Qww1GcmCEsPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7606
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_12,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405220154
X-Proofpoint-GUID: GasqZyo_VXz_rDC3SyYber6xPhF9HkKD
X-Proofpoint-ORIG-GUID: GasqZyo_VXz_rDC3SyYber6xPhF9HkKD

The absence of IRQD_MOVE_PCNTXT prevents immediate effectiveness of
interrupt affinity reconfiguration via procfs. Instead, the change is
deferred until the next instance of the interrupt being triggered on the
original CPU.

When the interrupt next triggers on the original CPU, the new affinity is
enforced within __irq_move_irq(). A vector is allocated from the new CPU,
but if the old vector on the original CPU remains online, it is not
immediately reclaimed. Instead, apicd->move_in_progress is flagged, and the
reclaiming process is delayed until the next trigger of the interrupt on
the new CPU.

Upon the subsequent triggering of the interrupt on the new CPU,
irq_complete_move() adds a task to the old CPU's vector_cleanup list if it
remains online. Subsequently, the timer on the old CPU iterates over its
vector_cleanup list, reclaiming old vectors.

However, a rare scenario arises if the old CPU is outgoing before the
interrupt triggers again on the new CPU. The irq_force_complete_move() may
not have the chance to be invoked on the outgoing CPU to reclaim the old
apicd->prev_vector. This is because the interrupt isn't currently affine to
the outgoing CPU, and irq_needs_fixup() returns false. Even though
__vector_schedule_cleanup() is later called on the new CPU, it doesn't
reclaim apicd->prev_vector; instead, it simply resets both
apicd->move_in_progress and apicd->prev_vector to 0.

As a result, the vector remains unreclaimed in vector_matrix, leading to a
CPU vector leak.

To address this issue, move the invocation of irq_force_complete_move()
before the irq_needs_fixup() call to reclaim apicd->prev_vector, if the
interrupt is currently or used to affine to the outgoing CPU. Additionally,
reclaim the vector in __vector_schedule_cleanup() as well, following a
warning message, although theoretically it should never see
apicd->move_in_progress with apicd->prev_cpu pointing to an offline CPU.

Fixes: f0383c24b485 ("genirq/cpuhotplug: Add support for cleaning up move in progress")
Cc: Joe Jin <joe.jin@oracle.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
Changed since v1:
- Add Fixes (suggested by Thomas)
- Add warning to __vector_schedule_cleanup() (suggested by Thomas)
- Use free_moved_vector() not irq_matrix_free() (suggested by Thomas)
- Move irq_force_complete_move() to early migrate_one_irq()
- Add more conditions in irq_force_complete_move() (suggested by Thomas)

 arch/x86/kernel/apic/vector.c |  9 ++++++---
 kernel/irq/cpuhotplug.c       | 16 ++++++++--------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 9eec52925fa3..b385bb5eac10 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -1035,7 +1035,8 @@ static void __vector_schedule_cleanup(struct apic_chip_data *apicd)
 			add_timer_on(&cl->timer, cpu);
 		}
 	} else {
-		apicd->prev_vector = 0;
+		pr_warn("IRQ %u schedule cleanup for offline CPU %u\n", apicd->irq, cpu);
+		free_moved_vector(apicd);
 	}
 	raw_spin_unlock(&vector_lock);
 }
@@ -1072,6 +1073,7 @@ void irq_complete_move(struct irq_cfg *cfg)
  */
 void irq_force_complete_move(struct irq_desc *desc)
 {
+	unsigned int cpu = smp_processor_id();
 	struct apic_chip_data *apicd;
 	struct irq_data *irqd;
 	unsigned int vector;
@@ -1096,10 +1098,11 @@ void irq_force_complete_move(struct irq_desc *desc)
 		goto unlock;
 
 	/*
-	 * If prev_vector is empty, no action required.
+	 * If prev_vector is empty or the descriptor is neither currently
+	 * nor previously on the outgoing CPU no action required.
 	 */
 	vector = apicd->prev_vector;
-	if (!vector)
+	if (!vector || (apicd->cpu != cpu && apicd->prev_cpu != cpu))
 		goto unlock;
 
 	/*
diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 75cadbc3c232..eb8628390156 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -69,6 +69,14 @@ static bool migrate_one_irq(struct irq_desc *desc)
 		return false;
 	}
 
+	/*
+	 * Complete an eventually pending irq move cleanup. If this
+	 * interrupt was moved in hard irq context, then the vectors need
+	 * to be cleaned up. It can't wait until this interrupt actually
+	 * happens and this CPU was involved.
+	 */
+	irq_force_complete_move(desc);
+
 	/*
 	 * No move required, if:
 	 * - Interrupt is per cpu
@@ -87,14 +95,6 @@ static bool migrate_one_irq(struct irq_desc *desc)
 		return false;
 	}
 
-	/*
-	 * Complete an eventually pending irq move cleanup. If this
-	 * interrupt was moved in hard irq context, then the vectors need
-	 * to be cleaned up. It can't wait until this interrupt actually
-	 * happens and this CPU was involved.
-	 */
-	irq_force_complete_move(desc);
-
 	/*
 	 * If there is a setaffinity pending, then try to reuse the pending
 	 * mask, so the last change of the affinity does not get lost. If
-- 
2.34.1

