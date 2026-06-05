Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE7B36A013
	for <virtualization@lists.linux.dev>; Fri,  5 Jun 2026 16:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780675437; cv=fail; b=cksmceyQKzD2dE087jlqqPwkUKqcEz46wKZYqUnWy+LO6xSSKleJYCMcgLdr6RvjrcFmQsQl68PDaXAg1dy0D1XRKLi6LpJEnY2113bDeE5mltqQxutEIgIBDAl5l9dLt4KGisCslTT5Wg3mghzxueuXYyDUD9DldOMyNjTGPN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780675437; c=relaxed/simple;
	bh=z8zXXYePmdDJX51lPNluAWMN8tp1te8xVROHok9RFng=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HHsO8YTuZQLvTFFoyUjGbeZ6dOlmVL/JqwtBWqLTx3wu7hA57Ql8VgG7CvomfCEVY6OH7Dy4MBUnp9HuU2JTNZM7+m3hDSNryJBKLosq79RG5WzzgcZQQ7EFusHPnZdJ+2ER0Ok0Ak8CQPIRCUE/iCP9zaLitbkqLij9my29Wfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ceGefV8O; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wPu2rRwJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ceGefV8O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wPu2rRwJ"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 655EtW6P427234;
	Fri, 5 Jun 2026 16:03:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3AfYVuRHqfBTbOvK6JyfD/eM61L8joP0WOTRnxhjUr4=; b=
	ceGefV8ODtfxmApirFemCNMmx9/Qo6Sia5UYMaNTBUyU1shX50zLXurF8DZkblEV
	na/H6rtTFlpDkNIcT4D+pqrxzA5IVRxcHcC4WIyNGtuyahwrmp50zDfsRDIhYO4J
	R4la4SqVojFUqeVK9BmIjWvbWlfqx7+zJVHgvFBgXUb1FQSz6Y5+Q0yTa4j1etUW
	szIt41uIaAEu0xgN1lbPZbPyzZPlwEvXjJAgAivjrc+qfjJJbM92DIKejpeW0x9n
	H09uJ2a8fc0BLJE1d/fTsSEogvlpzsESkQRrf+7KrJ4auao21dLr9PK/F6tlczZA
	McB8w04J+vGtli8fz+ENdw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4efpfy2fk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jun 2026 16:03:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 655FtSG0006654;
	Fri, 5 Jun 2026 16:03:45 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012050.outbound.protection.outlook.com [40.107.200.50])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ejfwet56p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jun 2026 16:03:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ImEoO4Dr7YFUo3Vgzfl2JWwtR/cZTLgDgVlIoC5yeO5jayajWj/5s0iKQ2Ei6webHitSKjbKiTefdTqt4ZBl2NuwZM/ARWWcFMm9Qca9A+FOPXlu/tEGGE2HXlSnz027Ig9HCQHuMwnS7VHmp+vveE/IA07FQncSHHwPbRNcLhc7zCturSDk7UNW/SeCH7lQ/h+EL/ukjMbnyAiX27aAHE2l1eZwx3S6jGQSB0qdyim2H/PnNN7g45Ssx8Ocqm9vFXZUoPDFr9Gm20e0kQ96uDcTv3+Rsu/IW8ExcnElo0y6NFzx5gSYOAiNh6UeusieQ27++fWOY/4I6zVPK45v6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AfYVuRHqfBTbOvK6JyfD/eM61L8joP0WOTRnxhjUr4=;
 b=MD/sp0oPZe3L6LAQkDWKOPrxs7f3L8nLmS9GUoXPSrq7wAHq24LZ5JxH4LzXnQmpcFRUtRTg8SpIrzPYyyPdxUdpGVJY+4/eU5Ccqng9XaPhJOc2jiHjQHcfrDOSzkF5iZurr4Zp2SSIp5gnVM/1u0R1vuJK6bmMCfYQFzVqNBdtHgoeGTXjMJvQvBorhHOcg2VsCLaC3qv7IXed2DO3mTN2OIVI3hLr9QlCQEjKYFXsuw1CQF2Bia3HOfbzu0RUcOx3eXY7UDBji7dBzrMMhjjndIQTqY7xXWxL9OIP5kPM4wFrUouu+YVPHjVrLagtoDHy6TA41YBpddwjG6Q3Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AfYVuRHqfBTbOvK6JyfD/eM61L8joP0WOTRnxhjUr4=;
 b=wPu2rRwJOyAfSnZd8XEoeVT6Y+TPS+jYTFlH5jUVXyHsLp4j9cGRPElnrHcLch9USfo0dSw9oCBsOPBMz01hxloYEGr0BFTpJQTiM1ESfbXrPx7kYRgdKxieiokxHlqKJvgXNVLBk+8f7c+PE1IUKDsrU1P2dk1Qpe8grLl/wPc=
Received: from DS4PPF18D5A7206.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d0d) by PH0PR10MB5660.namprd10.prod.outlook.com
 (2603:10b6:510:ff::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 16:03:39 +0000
Received: from DS4PPF18D5A7206.namprd10.prod.outlook.com
 ([fe80::1708:e053:84f:d75f]) by DS4PPF18D5A7206.namprd10.prod.outlook.com
 ([fe80::1708:e053:84f:d75f%7]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 16:03:39 +0000
Message-ID: <6035a8f3-e225-45b0-9f48-55de953bff15@oracle.com>
Date: Fri, 5 Jun 2026 09:03:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] VIRTIO: Update the desc 'flag' fied last in packed ring.
To: Eugenio Perez Martin <eperezma@redhat.com>,
        yangjiale <yangjiale133@163.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org, Andrew.Boyer@amd.com
References: <20260602043123.10207-1-yangjiale133@163.com>
 <CAJaqyWfugEttrQuR5_LrbQaivAqCaixsprUOjEVtdiz_sexFpA@mail.gmail.com>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWfugEttrQuR5_LrbQaivAqCaixsprUOjEVtdiz_sexFpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P220CA0144.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::6) To DS4PPF18D5A7206.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d0d)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF18D5A7206:EE_|PH0PR10MB5660:EE_
X-MS-Office365-Filtering-Correlation-Id: d08edb71-e6f4-425e-03a9-08dec31c01f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|42112799006|366016|1800799024|376014|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	81h7Kd9H2FWTgAvWDL/WJcNwnetbtZQyo4kFal5SwlWvdADWtyqwAuwTpxQyDhJcCYpGDEc5TJYDJoaooETEz+XO1rz6ImMNE3wWOj4pmgRlif+xoDc/Nroj6+rADDxAv0dYBxDgXtYfJGfg4VL3ICtRyfkHH3WrkJWy45dF/hMfmgFENCnt50bn8iSsEXVPjp/yluaNv/S9xFQ+ok2EA5ibtWa5ljKVWzUtpbDmFYi4w88Ap+ZeKWPoot64LR9DqbM+BZDnyWjEgqRv6YzS6XyuBIv90snHR3hHRMFxFKKWyp80YpSUY1Q146fXtmCOO/onIQReBD+MgTDdVvH/XuoMBekdCYmvNmpTwvtZYd3GpoTfS8Xh1JbC7gsXKj0Y7xtsFhnJskUYjMCNT7jpxI3WGlrwfnD+Fme2DDniI5nVjD7Ar8pQK3RM63ZWS068ASPLGgdaMAnNpelA7UzTqzadkdgcc0lhLEgsyhJLP+7bj15prQYp0YYS7CuD8qwUtfTW/X3WFjBwCWqUdUyZ7QAs8RxplOSVkNqxeEtlDUxjZZF2BfO90M7WfeZ4CDHXi5zOST0xdykDHh2Z5p9oJftahKJpYh+014zUnvKsMaX7rtu8YGl7wyMhkZPStCHMrcsSnn1zswl2ZoIS9ixMofIB3sDPL2kCXQKPFyHKUQDryVVYAi0OSRpW8bZa5KGM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF18D5A7206.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(366016)(1800799024)(376014)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUhTM3R0dFVjKzIyTExDc2JEeExNUUFaYklHSGR0WVFTZUNIemxhWFVzR3Ev?=
 =?utf-8?B?TWN2bHdyTzA2aWtySTdJWnN6ektXOTQzTnpZbFAzTUo1TnNCdUFVd1FybGta?=
 =?utf-8?B?dWtaSDV2U09aNS9uTGpWZ2FtSTFxZlEybEhmN2hJTm4vcXNKNmk0bG0xZG5m?=
 =?utf-8?B?aXhqNHUycEJzVjhRT2FibkZOUmluWHFWcnZTeGluNFJOanRBSUJFRTE2UTVC?=
 =?utf-8?B?TmZNRXgxTlQvNmREVDdsdlRoMXdyamlYd2tVZTMrWEpXVVdZLy8xOGNpSHZl?=
 =?utf-8?B?ZDFHWkNhNHMrZTFPazNCY290QVRkWmJyOTFlSXdSYmd4WHJvSkpmRy9lUitI?=
 =?utf-8?B?VUFJVmtLVnFmTmRQUXIyR016a0hsZm0yV1NQdEZZM2crY1pBMXhKOUZTOU16?=
 =?utf-8?B?amQ1aDdVZDFlR1F1bnZtQUJwM2dmTTlZOGMxS1BRQmRNekthUUtGU0hiNzVw?=
 =?utf-8?B?QWpnaExDR3U0Lzg4UzFaQlZGUmI4WkJOSmlGanVIb0VzeU55dTdvMjJNVDAx?=
 =?utf-8?B?dnhkd2tjbEs3K2RPcVdIcW1HaXI2STloWkNKcWRJR29ua3VOMXdsaDlaTTJK?=
 =?utf-8?B?Q2VwanowV0E1YkI0UnNMNXNXMnFvTjhpS0R2NndqZkJWdjk1eXZPWFphYTUv?=
 =?utf-8?B?NGlGa3pYSEJSYW13RWw0Z3AyWEVUNm5ONnEyNjVOZlVIQi9oZzFSRmpBc3Vq?=
 =?utf-8?B?UTRETE1vMlRpNnNHMjExVTZySGYxZXgvMVdZc2Z5TGV5RnZ3dUJKL3V5ZEdI?=
 =?utf-8?B?ZGhGdVZ3c3R0R3ZRNTkxdE5UNU82OVljajF0QVYrV2NtRjlncjRjSTRtWkx0?=
 =?utf-8?B?V1Uyb05rL056STBEYndvcXM4dnRZdG5PWno5WmF1TUtieGl2ZW9venladDVF?=
 =?utf-8?B?MnB4dlpxZGJvTHZFcGJDOVpySkFRNmJxZStPK05UREFYd1ZkUnphSjR5STVm?=
 =?utf-8?B?Qnl2eWpJY0JxMmJmeTR5N1kyWTRYbUZ3WHgvSHhaeW5aOUdqSmY5LzFUZnpO?=
 =?utf-8?B?RHpPUTl6bk1NaVlCclhKeVdJanpyMVBqWWtmQ1M5R0crNFZ4aXQ2NGZVWG5B?=
 =?utf-8?B?VVgxSVUrRUtvS3gxRnZNMFpUMWg2S1ZaTVB2NC9QTzF6Wk9lc0ZQUDMyajRz?=
 =?utf-8?B?Z0VIenRQRTd3RktHSGhvK0ZnUlVCR1d1V2JuSjNIVWdReUQ5allJQnIxQjY4?=
 =?utf-8?B?d01uVXpPbjdBK2RGMEJPeVhOb0tNOGNqOUJBSEM0NHU5Z3VzSnVENjRLcGZM?=
 =?utf-8?B?SUJXeVFJWjVLV2hJaUx0Tlc0QjlBcVh2am9UUVlUMkdUb1dzTmI0TTZSU0xw?=
 =?utf-8?B?Z0xTOEh5emY2UUpoUms1ZHlqSS9FYU5qWXpxSUhldVZMN2tnUUcyS1FTM1Nt?=
 =?utf-8?B?S2RlMmZ6dHJjYllPVEtNTVpHbU91MWNUd3FLRFhzZ0p1RVptUHg5RFZaMitW?=
 =?utf-8?B?bjJZWXg5QTN3SEh3K0l5UlNOZGtoVll2WVVtNitJa3lwRXFLdzhIWXI5blhJ?=
 =?utf-8?B?UHpoNUJkY29TaEFhTi9NU0VxMExiZ0ZRVlBiaGF4NnAxanBua0ZEbnlQeVFs?=
 =?utf-8?B?WW1CSC9yL1l3SGFVOG9BY3h2WGJKWkcxSzdLa1pjVlAxYThtSkkzUzRrSjhL?=
 =?utf-8?B?VzB1RFpqY1NMRFczUzUyZ0RpMnprYW96eFJIZUxhRlFiQVJ1UnNaTUpucmlP?=
 =?utf-8?B?OXNUM0d1amVobTloMFJBRnExVjRXYVVxWGRoSEFHL2hzMUpTdkdkMXN1aWNL?=
 =?utf-8?B?dmRxRVVOeHpUVStKR21ocnRWQjl5akVHSThCNnJtUWU3ZWt4R3BFdVRJTC9s?=
 =?utf-8?B?QXJtVFZxMHN4Vkg0RjlxbmxSWVZDRjYydUxJWVpuVzBQRG91eUovMkhPaWFK?=
 =?utf-8?B?aHk4Yy9BZFRoK0hLYjhNckVtNGRnVUh6SklsSEFhTENXaW42VDNQUWdNL0I5?=
 =?utf-8?B?TTVVRjNNRVNsemk4VzdPZlNEdjA2YmJxaVBWYTZKZlEwMFhZekk3aFFaS1ZI?=
 =?utf-8?B?QXEvSlpJcjh0RGZJdU0xOU95UW8xY2FYRTlGUDQweWR2N0xFTDZ0YlRpWWN4?=
 =?utf-8?B?bVJrSnpHdXh0a1NCNXdia1FGQmwzZm1KNVQxTTlIRjBwWGh2MU9peTBKbURX?=
 =?utf-8?B?STZCYUhtTXZDUHhFSWdBc1owbVhVRDBJckh4TGcycE5KSUpMMHNDZVJGV0tF?=
 =?utf-8?B?eWw0ZGdDYjZRTGdWRnI1S3JFTVpHRTVMSXdkZy9iMkRnVDQ5WFFFQjBSSFI1?=
 =?utf-8?B?NGU0R1h6L21uZGVPV3Fub2NZSE5FcWhXeTd3eUN6QlhxanBpc1Y4QTI1Rnhp?=
 =?utf-8?B?TDlyM2sxa1dwNWlWRkg5bFhnVTc2b3owMGxpOC80ZnpuQ0NMczZldz09?=
X-Exchange-RoutingPolicyChecked:
	dN5ehlS5JR5pyUtV7qI1ZV8A5qnja87Lo1LDJ4+qRJCBDzYAYh3eHs9oN1arCzk8Y1jK7/WTe9QRXfbKRahL18OtNMC441fDO9HJEjwEzzWstMTsodbXKccno2U2XF9jdbRYnCZ8oNFhwsI3vG9+znAhR2tCmnZ2LcxoegeZn/MWrp8qvczY5NYhdjwZ+mMik7EpE9CCYv5g5PDwUmXGscoA811F7nT5goOVUmGzlkzbaX06unVmcybJ9axh9QKTFavNM2z+xrgrvNWQ+u6w/gI2K4JGvmEom4WsnRYnqCrOwvL1VjfuRBZvZbynCKYdDZm1RPFpalGA9XeU4omjxQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LR73hGzn2jE7NBGlYIJsUGM3FOky44d5MAOglst7mQ8hoJPBZzvZwOu12mZvkZotejGyryYvSukYKXMEGX3lRDu+wA70U+i/0KxycAeNA9gh7FVyHBLw3berVOU+sh2BCG4tMjfOJjvvIw4eD46Smvw/mJTlk8lRj1XSMO0vkqwElJe2bTuiad6ItwXnIxUUVWaJn+H02E31uwgje+T1l05N9WLEPb3UWlHHH27g6IigpIsXVkmKJtt+cieT8lIDQo7eNPAzBn0uAapLuQw2Xbu9rjGFFWGHouSe+KkaKLQ1Ra4d1psS0tvnvK6VDwUttNO+txYhnQTOKmlSD26Y2gvDLunf89aqHiXSFfTYSFRmw8nD6tzWwBQPAUU4OAq0dJ17eI62/wTuhvpBAm2u3uC1kT6GCbN+jW5EL227a0KqQPMYqINaQMnuKapCvoBI8QftkVyhVm59vxWgXj5LJ5zcafb3cBMvEERs8sp3EFfNXJeqgBsYPgrh7gkMPjqU/zPNKSMF62XcVHp5V7BTBk5yatxRJCCna+5+IAf50lwiiz4QXOnSe228QsedXwqyb0PEKq/yCJj9wVuwiTf9nPJixzACw2oVuEgGKPiwj9s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d08edb71-e6f4-425e-03a9-08dec31c01f6
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF18D5A7206.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 16:03:39.4642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1DZ+sH9RCMQ5BTdFJBYmNIkZQ2/9BjH7CR6DkRb3iWg8GUtKFVc1mB9jUjavfarIxZVwHWOlCk40J8aZx55SfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5660
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2606050157
X-Authority-Analysis: v=2.4 cv=FOMrAeos c=1 sm=1 tr=0 ts=6a22f362 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=Byx-y9mGAAAA:8
 a=eYE0Ry0HgYzRr-JctEcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12312
X-Proofpoint-GUID: 9OO92gjaOQE5n36ellRjIMyIFljZsUG_
X-Proofpoint-ORIG-GUID: 9OO92gjaOQE5n36ellRjIMyIFljZsUG_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDE1OCBTYWx0ZWRfX+AhXoziElsKT
 hyfTnftM0/kQCmP0m62+Z2Wi3xiWAT2rvC7cjsT2vxWqPoepxTnoimfQPFiFt5aWvXku+DpFAIM
 RrtsduEw7JjZSmG94vCincARJ9Y6VPvGQoLcqUVvgGYRHu3CwjA8IVpozA+EmINRo2mIDDgLin3
 /BF5VIGmw5K3D1gNWeSd+TuLrVeWFWh/cda860GR+Ozmp95BspcXj+2BVpZ0oOd/fgrB2tNeFTx
 O0aoX9s0tYcidwJnhE/ApAoX6bzg+wrxjf9Ej+5rfJ02jBDPwguApDT4BR8BezcTjYbR3hLSiqZ
 aYXp2/mshO9flE7g9DxIMfRQqXVzPzMFxGE2jJOOapqCy7wb1am19+PMERfpvFoTfLZUz/+YxtJ
 +5h+c5Fsyn5i3bfoIdEMNUrAjIU1TZ+eu91TE0KD/27EwjCBGXPGuRKtWz6lAtE8aQzrcizRVZ2
 UaU1O0NTl0QUlhtg8GLjcGq8FMLgMygwArRIhMVU=



On 6/1/2026 11:04 PM, Eugenio Perez Martin wrote:
> On Tue, Jun 2, 2026 at 6:34 AM yangjiale <yangjiale133@163.com> wrote:
>> When a descriptor list spans across cache lines,
>> updating the flag first can lead to a scenario where the device side
>> perceives the flag as valid, yet the corresponding address and length
>> fields remain unupdated—resulting in invalid values.
>> Therefore, the flag field must be updated last.
>>
>> Signed-off-by: yangjiale <yangjiale133@163.com>
>> ---
>>   drivers/virtio/virtio_ring.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>> index fbca7ce1c6bf..036b4f90d30f 100644
>> --- a/drivers/virtio/virtio_ring.c
>> +++ b/drivers/virtio/virtio_ring.c
>> @@ -1688,6 +1688,10 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
>>                                               &addr, &len, premapped, attr))
>>                                  goto unmap_release;
>>
>> +                       desc[i].addr = cpu_to_le64(addr);
>> +                       desc[i].len = cpu_to_le32(len);
>> +                       desc[i].id = cpu_to_le16(id);
>> +
>>                          flags = cpu_to_le16(vq->packed.avail_used_flags |
>>                                      (++c == total_sg ? 0 : VRING_DESC_F_NEXT) |
>>                                      (n < out_sgs ? 0 : VRING_DESC_F_WRITE));
>> @@ -1696,10 +1700,6 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
>>                          else
>>                                  desc[i].flags = flags;
>>
>> -                       desc[i].addr = cpu_to_le64(addr);
>> -                       desc[i].len = cpu_to_le32(len);
>> -                       desc[i].id = cpu_to_le16(id);
>> -
>>                          if (unlikely(vq->use_map_api)) {
>>                                  vq->packed.desc_extra[curr].addr = premapped ?
>>                                          DMA_MAPPING_ERROR : addr;
> These flags are updated before the flags of the head descriptor at the
> end of the function, at "vq->packed.vring.desc[head].flags =
> head_flags", so the device should not see these. Because of that, the
> relative order between the rest of the fields of the same descriptor
> or other descriptors' fields, except for the head descriptor's flags,
> should not matter. There is a write memory barrier just before
> updating the head's flags.
The above analysis is absolutely correct. Though one hardware vendor 
told me that this driver implementation kinda stops them from reading 
ahead of descriptors already posted beyond the available index., ending 
up with suboptimal performance that is hard to make up by other means. 
Would it be a bad idea to go with this change and add write barrier in a 
gentle way for a small flit in the batch, e.g. commit to memory after 
every cache line size worth of descriptors are posted? Would the memory 
barrier have negative performance overhead to other backend 
implementation variants than real hardware PCI device?

-Siwei
>
> Also, I don't get why the cache line matters here. Can you expand? Am
> I missing something?


