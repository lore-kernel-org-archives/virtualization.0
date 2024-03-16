Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8173D71
	for <virtualization@lists.linux-foundation.org>; Sat, 16 Mar 2024 00:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710550051; cv=fail; b=BnJtbJ1CpwF7Y5yXND16HJV8VRTvRSLDn73nvbJKKSvvQD7jHbNc5NSQiPcxUqDA4et2R1pdTONRr2bPjwZLZRhMS09URWKC86uKrm1RSu83+W3Kh578hnADPfbJffn8HpvjMIzUI7VvXmacRamtR8heRz0VLphzScHpa8IJ/Ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710550051; c=relaxed/simple;
	bh=lfUL4JKh6+0shrQ4K0i/6NHs//gi9Qt8wp3IH1d6LR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RNUf7VHWRLX4VDAHKhFVzBAHLf5L0HPPos0thxD8iBVo5qYF1cnn1THnbtLpYKX2zzA6VbjIV8qa5arQ376JtpG6G1B0BFSoUy379vXg2CK/VtWvXRa3AJewJcSxyrY/uA01jK5aOenZFMPReOWIz59yOiyJS+PMeoz/TLAh8AY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZQL7SvHD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z1VAfdL+; arc=fail smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZQL7SvHD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z1VAfdL+"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 06F9041812
	for <virtualization@lists.linux-foundation.org>; Sat, 16 Mar 2024 00:47:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.798
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gcozf-EM2sv4
	for <virtualization@lists.linux-foundation.org>;
	Sat, 16 Mar 2024 00:47:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=michael.christie@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D81F241821
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D81F241821
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=ZQL7SvHD;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=z1VAfdL+
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D81F241821
	for <virtualization@lists.linux-foundation.org>; Sat, 16 Mar 2024 00:47:25 +0000 (UTC)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42G0bkRv005127;
	Sat, 16 Mar 2024 00:47:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=Hur0iqrIjRV5WniJOBe7uZWrqcycJghGbiH3PgdazP8=;
 b=ZQL7SvHD/9AgOofpa1XxV0wm9HsmuQIz5eHtHIJCPxNeAZWaoWyociv/uXGbfTZTJoBG
 Zhs4YkyuRST115S+0RIzLDbcze+JD2LnuS2vGI0geSZVQlJ0xe1xIgwv0f+K7cKNY+de
 4lEj0/g3kXRXNROb1VAAdymXuReiaB95IL4U+Xyc37+VWVu8OXlysqHq0lJ/cVjhQsEl
 C+baHtrUfLcwCQvPrkxgF6kQSttDha1weYqzVYRvRoqLquEWH4dA9tX9iXKvxyp9plwL
 HTjezgdHPxBKwjkxvcSBtUAw0kujI4ETO7zBqDHwuQwsEGSLzKdVdaea9j7gxZyRSEKx GQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wvsxc0tue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Mar 2024 00:47:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42FNEOIq035859;
	Sat, 16 Mar 2024 00:47:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wvtk07913-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Mar 2024 00:47:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYkxLQjm1+wqLQNl8JRKo0uUS4whV2Ylq20NLSHP67gW53QAaXYaTn86jqt3jmRH+kUsaP8qw/xFW3VFNQ4e8HcNzg6bvm+b2AgGx8pd0Eg57m9QwDPHg4bredI/jTUOvyd7gyKDVX9iGtkQT5iWWzPG0ds0My7jsa0I/ja1gTDV2X3xVk8eqosf/+m0kS+XGi59RltKXwa32tqDBC+9m3ALO08cDhxmiZ5su0DmT3nTh/N/qyoelwC5RJV1cqOlWNN41zgBrDfzfsf5Lx4AH2x64G2r4HbStOj1f9MVHtw+GhNLlKf5eUXSLfiksgUrVRBe3vOhv2XumeV8hMu8vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hur0iqrIjRV5WniJOBe7uZWrqcycJghGbiH3PgdazP8=;
 b=fcjxHEm2r30r1uzdLOATO4QyIUG3THB9Vs+LeZKXe2qFbSY6Hac6iE0mGgllM/QHDMMU5l/thSCOYM0UUGmx8hLcADK9kUAGv6E6LKVVDjdYaPmuOcRJCcFUpYaap6xpGaix8qeOg9nENKu9TaLaTewl8HHjFG+p2IM4SEJ9boOliUAc3nBecRT6CReF/AOGzhjYv6xM1hxAnkw/hFb1pa8i+u2nMTbn2HrU1JeFWSzF1joxCadgXIMID+OjCiVtM4vzhP54kbB2IPuymeus6yMPQIGZj8aELmXu0z14TbJgeoxR7ddtIxhJ2D+wAMisiJKNSg3CaiBMWfSFF4Kv1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hur0iqrIjRV5WniJOBe7uZWrqcycJghGbiH3PgdazP8=;
 b=z1VAfdL+vlPk+GkdYy0sqO1v98O2884yycynBevpigUMx2FutH9Q7J9gWv6zitE1KWP8Xf2X2bOG62sz+TQr9pLTsVCQMoJNtvaLUorg+Kit621AKDazVx3B1OjxxcXIOp5nuBQ1ur/P1hsF878wj+WSk8KU7/pV3iJVmu/WTzo=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CH3PR10MB7120.namprd10.prod.outlook.com (2603:10b6:610:127::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Sat, 16 Mar
 2024 00:47:19 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2246:144f:3bb9:60d]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2246:144f:3bb9:60d%3]) with mapi id 15.20.7362.035; Sat, 16 Mar 2024
 00:47:19 +0000
From: Mike Christie <michael.christie@oracle.com>
To: oleg@redhat.com, ebiederm@xmission.com,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Cc: Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 7/9] vhost: Release worker mutex during flushes
Date: Fri, 15 Mar 2024 19:47:05 -0500
Message-Id: <20240316004707.45557-8-michael.christie@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240316004707.45557-1-michael.christie@oracle.com>
References: <20240316004707.45557-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0135.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::20) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CH3PR10MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: b438ba33-6902-4c6b-fbfb-08dc4552a24c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hvJaK7H1+A9XHQuausvft4xz6qKOPQ4912pqKvcIe9jyyWuDtdDNvPioqVnRBdNahaEJjcXHQSZeX9SSDOovcQRs/zSeSf//6gA0noW+A2v+bznyuDotnoexR4dUr0+l0GWY2yaQaKpA7O36fGdp3aCJraY0fF1ipv2+LGELLlq64w7NXmtbbguM5zpMKoYrZrxtvCliipisJ/QLtn2mUImy4ksgJJBEx7BxIYOIVzI462kIc33TzfL7NE9O3Jqxjxm9QiIzpvzVYmb1pal+9tLJfYzyR2cNmHJFRweQ2ztpXTqp/LmxJTbVMr7xImSo818M0ZeuS/Jk944g5xYoJBYhhPpgXmP2guJ8ETdxYToiSFk8wK9UTnLt3ZwaxdcLkWeRGTWDxRgApK2gE5vk7yixYWfOubZIUYs/StunTGJ12BpGoxJAzIHUXdcIhB0fl7npcCVop36XrnZIH9XkZgPVES1EEZMwAPB4/XCEgC+F0VVmfBO9LSHQeCV8r65td69QJNJBZhctvw11ri0UzO4g7Ut0ZO/5cQpu4t/xduZLWb2iDjzUPhX+d5DZp/44ctbqH2W+ahZ6W2KoveUaxd2502WhnFHpw1uN/0JkKLoMrJcH28GHogSnqf2vVlYWE7kQXu/Jn5AshfGh7ohLACCYCG/EjUoMlBN5psr9dtw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?OfMlfwJ8elO+XTfQpCCIvYQe/JoiQDVGpSr1b2LD9fhbwLq7lzgr3zUaxehP?=
 =?us-ascii?Q?KYftCxL+S7bFzG+vEmveico7qyDVgznt2AroJxBNLRVYjJDb4o/FqRqq5V/9?=
 =?us-ascii?Q?1NUIoWV0tFc+lrWBGN5o8vL1ADPTbRmLAKl1DphXp42V+Zk51/FQPatUaQSG?=
 =?us-ascii?Q?qZIunUdZkJRuNBY2k8CFZa70saTqEUupyp68S1y9I2/Zr2he1FKozLJmj6HF?=
 =?us-ascii?Q?ZdTKZd2J6n2S1zolrhXl9oGwauPcvMHRkfryAGy0IMItZu4yeuuNMqKOX0m5?=
 =?us-ascii?Q?bioUgo16ob85FLmdRex9GlPEA0IqWxhcZ5jB3mc855LH27O8HZsGpY0MnrB9?=
 =?us-ascii?Q?ijdLim5NA2VOkG9m//xmtgSHLryHPv+A+goWNKvoFiCqi5uEJlXdGzCG3jJc?=
 =?us-ascii?Q?pwvFdm9+3Ik/0CH+Libn22Suov2W2hyyflETf3nNjrQgQrX5ZUt4nw79MQc3?=
 =?us-ascii?Q?bDmt4j4jRqLJfWLZ/5AgQyj7BoSFl+JZtxZngoVcd7ZiJ1WDW9b2kPm41Na3?=
 =?us-ascii?Q?ysMuuxtO36AyfGd3OIPBvy189JGyM2R1YrX0NuvRS7zTddRIoA5h9FghhdRH?=
 =?us-ascii?Q?sj7puvNYPwMAA0lkGhTmzR69lftPyw3uZyS8INzPkJR4U/AyX4AGqTLwAme8?=
 =?us-ascii?Q?dtXotazn0rVtVN+1biAH/DWXT0htJr7kyPtOVnqFwAIoDUdwKnz9N94IFcM3?=
 =?us-ascii?Q?wKzJAdMikL/TiWtgIjm54WJnh04BzDVCUyae08aZPNgVO9r3Be7Cl/ChFmSy?=
 =?us-ascii?Q?MAEzo9jrGkB1BoMiRZxY7Ct9RPA4BYeoguFET0jCTLerhiX5pEGNNPYpzZt7?=
 =?us-ascii?Q?7DgM6EcOIREorXTKTnPaLROga4FgWBOk7JNfb8gwAdPPSYzEcpsRDIphkI2j?=
 =?us-ascii?Q?LVaZTFq09FjkqSItquy9wjUKdfreVe7fsc+EPvDbaJ0UYeQxpG1hbThiVKN9?=
 =?us-ascii?Q?NjGVYJhxNtQHSGBoyNgrwpy+8P8U9JG7gP8t5jdaeRscNWcBQwvdJS0kGOAE?=
 =?us-ascii?Q?Q8/W/YyJ0wPDaTotgKmMYWfXsJ5Ys+rkSu57RO82LMnd6DV3Ad8xjCijodUd?=
 =?us-ascii?Q?GU/GzXju2ZgoiopH/AYctSl1nAidBZArrx/JFNOWVDpxsCWb5CirVe40RWsS?=
 =?us-ascii?Q?4jWyCKsc/nLatJ3ly56z982xrNOw9PVxXXf4czVFr57Y1f6k4VreTX3gUvjb?=
 =?us-ascii?Q?pqp25AonA/oU6PITvlqtfyCoMVppapC2Ocqgaw7ApAitCZr4jwjEuTn49ThS?=
 =?us-ascii?Q?Xt00Vys8H3sbWAu9OhwKV5wlR8WXEvsTLqZMYpAYYTO1lR8N4vYAADrJf3m4?=
 =?us-ascii?Q?qOpVqyGRLijnppIgvil8ZIHE/Zv/BfAtT25muIZiwbqqEOOgHdBYv2JDvEf0?=
 =?us-ascii?Q?JKiYLYy/85Db36NRu76SzpSHPo4n9tZXOTvYzrP0BEpGRmlihALpjx2mE5q3?=
 =?us-ascii?Q?VFrzwqE+pRJeVERowtzYa2dq5VOB+9f2A7tAwT5U1LgUnPLJfpRVgmNX266r?=
 =?us-ascii?Q?oNW0UHoerxVDQG6LbieUNVnufM6aoByaTrKt26YY/I2HUnmXVM5VCZa03E1x?=
 =?us-ascii?Q?ZeEfRSom7u7El9ZajXOXczHa610NqNU/LdpHey1GvoI8PpIslpY8EsQNY/sW?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+40HegayxDV4kzZr/7DupWfMm7o5zX8nXHTVvDaXNz/OezXN8An/gY9fpcHJzwm+zk6MBAGR0L9Go/BmoTDIoRbWkAooZG4L8QjfQLkIgjfwB61wN6M6dEDLea+Gcq/cVK0TefjnMCXYLzyqi5uMjkn41f4nzQWYgiD5vlB9anZb/VMzpaReYlw+eBgdSYTfJVc4Bq56I6zmYfMgvqxxO6PFKBroHyIzi0FWTuNt0AA+/uHYtbuFcGSrhcVGdRnVE3zcaL2GU/gg6eiCfdlLcSvBQeZKiCsSJoxTP/RgPw+OLHVqzTj4xDyK1AyO1PamS3yo9dOhhKP6eVMGaDdbi3kXqjDAYgFVHu/oxOFDpoHiyS0K9M+os5QHr1M2IAczgSruC+2wJRgSok+ztZZbCTvMYIVioMkgdqUM6K5x+xjTN6JXc2N+mybl4RO7808G6nih/yVKycse+cH46sSpKe8U6fqjxTq24LWJAAYE+ZmJ1jsprhhG9ObH3FeqOSlgEqoqm2Qt5/hSeTsJxj0JRsm4BuIuaVTOQMmUBrb0m30yhQYINXV8OUemnVYlSRgDbZ3aucfMZtXMUzwGj+k26LgSyjRhZYFHFpsMEwkgJHw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b438ba33-6902-4c6b-fbfb-08dc4552a24c
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2024 00:47:19.3376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJ50z7Pg6eYVBEMQMe22sHlzAYVilgSlnRAU6N/z0J9IV3jTbIFTOuHhXZT8XueaF0WKC2iRryYQ1T70YNLUJFiCvkMVaVerWumAGFv6efY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7120
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-15_08,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403160003
X-Proofpoint-ORIG-GUID: lsN5AB85PPPWN5bO9cPplgpQtXVwNov5
X-Proofpoint-GUID: lsN5AB85PPPWN5bO9cPplgpQtXVwNov5

In the next patches where the worker can be killed while in use, we
need to be able to take the worker mutex and kill queued works for
new IO and flushes, and set some new flags to prevent new
__vhost_vq_attach_worker calls from swapping in/out killed workers.

If we are holding the worker mutex during a flush and the flush's work
is still in the queue, the worker code that will handle the SIGKILL
cleanup won't be able to take the mutex and perform it's cleanup. So
this patch has us drop the worker mutex while waiting for the flush
to complete.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c | 44 +++++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 4252c3b827ca..b2012993e9fa 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -264,21 +264,36 @@ bool vhost_vq_work_queue(struct vhost_virtqueue *vq, struct vhost_work *work)
 EXPORT_SYMBOL_GPL(vhost_vq_work_queue);
 
 /**
- * vhost_worker_flush - flush a worker
+ * __vhost_worker_flush - flush a worker
  * @worker: worker to flush
  *
- * This does not use RCU to protect the worker, so the device or worker
- * mutex must be held.
+ * The worker's flush_mutex must be held.
  */
-static void vhost_worker_flush(struct vhost_worker *worker)
+static void __vhost_worker_flush(struct vhost_worker *worker)
 {
 	struct vhost_flush_struct flush;
 
+	if (!worker->attachment_cnt)
+		return;
+
 	init_completion(&flush.wait_event);
 	vhost_work_init(&flush.work, vhost_flush_work);
 
 	vhost_worker_queue(worker, &flush.work);
+	/*
+	 * Drop mutex in case our worker is killed and it needs to take the
+	 * mutex to force cleanup.
+	 */
+	mutex_unlock(&worker->mutex);
 	wait_for_completion(&flush.wait_event);
+	mutex_lock(&worker->mutex);
+}
+
+static void vhost_worker_flush(struct vhost_worker *worker)
+{
+	mutex_lock(&worker->mutex);
+	__vhost_worker_flush(worker);
+	mutex_unlock(&worker->mutex);
 }
 
 void vhost_dev_flush(struct vhost_dev *dev)
@@ -286,15 +301,8 @@ void vhost_dev_flush(struct vhost_dev *dev)
 	struct vhost_worker *worker;
 	unsigned long i;
 
-	xa_for_each(&dev->worker_xa, i, worker) {
-		mutex_lock(&worker->mutex);
-		if (!worker->attachment_cnt) {
-			mutex_unlock(&worker->mutex);
-			continue;
-		}
+	xa_for_each(&dev->worker_xa, i, worker)
 		vhost_worker_flush(worker);
-		mutex_unlock(&worker->mutex);
-	}
 }
 EXPORT_SYMBOL_GPL(vhost_dev_flush);
 
@@ -673,7 +681,6 @@ static void __vhost_vq_attach_worker(struct vhost_virtqueue *vq,
 	 * device wide flushes which doesn't use RCU for execution.
 	 */
 	mutex_lock(&old_worker->mutex);
-	old_worker->attachment_cnt--;
 	/*
 	 * We don't want to call synchronize_rcu for every vq during setup
 	 * because it will slow down VM startup. If we haven't done
@@ -684,6 +691,8 @@ static void __vhost_vq_attach_worker(struct vhost_virtqueue *vq,
 	mutex_lock(&vq->mutex);
 	if (!vhost_vq_get_backend(vq) && !vq->kick) {
 		mutex_unlock(&vq->mutex);
+
+		old_worker->attachment_cnt--;
 		mutex_unlock(&old_worker->mutex);
 		/*
 		 * vsock can queue anytime after VHOST_VSOCK_SET_GUEST_CID.
@@ -699,7 +708,8 @@ static void __vhost_vq_attach_worker(struct vhost_virtqueue *vq,
 	/* Make sure new vq queue/flush/poll calls see the new worker */
 	synchronize_rcu();
 	/* Make sure whatever was queued gets run */
-	vhost_worker_flush(old_worker);
+	__vhost_worker_flush(old_worker);
+	old_worker->attachment_cnt--;
 	mutex_unlock(&old_worker->mutex);
 }
 
@@ -752,6 +762,12 @@ static int vhost_free_worker(struct vhost_dev *dev,
 		mutex_unlock(&worker->mutex);
 		return -EBUSY;
 	}
+	/*
+	 * A flush might have raced and snuck in before attachment_cnt was set
+	 * to zero. Make sure flushes are flushed from the queue before
+	 * freeing.
+	 */
+	__vhost_worker_flush(worker);
 	mutex_unlock(&worker->mutex);
 
 	vhost_worker_destroy(dev, worker);
-- 
2.34.1

