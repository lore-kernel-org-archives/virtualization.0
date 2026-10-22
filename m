Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792631262;
	b=UiOQVnFQ4z+nKukaZNILxdiMj/l0NeyqHRuBxyRvQH4NCSCTVKR30KS+E15/P7kJTsgt
	 hzqa84GgsaZopTm5zEYJ+OkYaBQbD+HAI88mQjHDL4i1QXJ5O56iohRFGYtH9+kxqqhdJ
	 0UDacQvpEQZJBySFb0VJbKYFkljvy1zbf+QQ0yktE/23tIcEk58VGeCeVPrwHKMsWnA4O
	 pA9x4LiqfRYvVt77xJimQL5ND5hi7tJJLrOIfey8HBxvLCidEoEmkJ3IMVjQdgCY1ZUhx
	 +Vri3M/WD99cWH2uIkIqS6ANE3+t2lZHSnGHqbyv2fJeMSAlrQo2IFZYz+Ch5Z4w+xQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792631262;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis;
	bh=c7B5PEaWncEqpnn7NRxL0RpIaAlOV39VLFMxXLhrHfk=;
	b=UWgIzY2wL//eIqlohk5y1yS87ym51H0Sl7bLZRViR4wkQup9m4399pFsuiR9Gz6X3i4D
	 F7uG9dkgX7E1vjOU2LXJDM99daJx+DzIDOmjNy/UrOaevXzsoFTEvrYcjQstSQYrRn0Db
	 ct7bZSrPTqAOgJAuFdGLRQdQGx9h2Ryp98hGKy7G89tPuGvDrw11fo4FqmAG4Z+gaccBp
	 xx9tSyLg6IDc9W+rQKuukd7m6bt+rf4LQiBkBWV2q94PWxSeQTz/3epy/twan4jHU2SAI
	 f63dCQ49pUPQIxIAn6PQqj5jRLJ1+yBgByQm8QtrQheDFFgTNjGSv0Fy7DBVFGN+FAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=JhPF99G4;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=C7vNXrCY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13C6606A319
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 01:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B13C6606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=JhPF99G4;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=C7vNXrCY
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LLGe7D2544770;
	Thu, 22 Oct 2026 01:07:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=c7B5PEaWncEqpnn7NRxL0RpIaAlOV39VLFMxXLhrHfk=; b=
	JhPF99G4WjYQIvBJW4D3QslOzIZXNS3WpuzKi/cHNZeqZrlt3SPWVc392CWZ0q8n
	djPiiPVQdrI2bM+k7YUPJ/ktCAcR3/ZfHT0SZhWKlifItDs3yMZQf0N060hQmtjO
	9GX7u5FsyX8ArUArmkwzinPAquT1oBZwhTpbJphzAPSU1aYjJIlOAopIubcj/rCb
	AlFEYEBnEkx4ciIxyd/v4TdrQMNeKE3C+w9BXSgk+tLfD4YrbMB9haVp6utKiX9u
	K6MRVtKAnGAhNhnS/fnlpLOlX5/IbVDJbsVyo3xerF4wu9r4QA+jcUKt78WVyaul
	BRo1oxEJVB64SJzXomvUMQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hdw4gbjfp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 22 Oct 2026 01:07:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 69M0hbZl810455;
	Thu, 22 Oct 2026 01:07:39 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012048.outbound.protection.outlook.com [52.101.43.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4hf4rddx0b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Thu, 22 Oct 2026 01:07:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZuyWzFRTW78JX7OlLEj/fzw/r/9TLTdemFzv2cabl4lbTeW6YCmTF0GEOGv6qtS7mrIgev6liZiTeKHfrC6l6rdQ9atWTrhX1NB3mo+UNYAWbHbJqloKrQVLke3yA3+RLmn7afUDbUHcXxF7uBUPEXRQ3LaSWuFBwunPiMLN4TZoML61aaY1Is6OK5S4sMj/r+gVbfKjW9OsqxZySRA37sbXmjDC+cel/gOIEhVVIFagvtdEb79CxtyX3wedDiAn43PPzDy2xh2HS0KD8JWl4kUOW0rHP74kiIpazeT/UUKIrV4ICeUJw7wECV/EAaOF7WhSDc7mWOmYvn3QBxQFOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7B5PEaWncEqpnn7NRxL0RpIaAlOV39VLFMxXLhrHfk=;
 b=LLKxd7OECEQ9JygqOD/AEz5LDGmHDP93avM6vIvcQ/7z/Je8RaiighTXsKYiEuBXJqm2J0WsfckA55YlNG4LqQ7goj2uD+EZazNBmvwLsf38csrNt/jXK4eACY/wSaAZg30zAlirQwwoTqUNszQfAyjgjtT6hpee3TyS+zUCUnN4tLAGveqyC2KDDcunvMN7BPbIYFQdy7dqGqeiVC3b5oCDfgyzB8mDiK8i8D5AOQ9wJm45Pv49uiodymUaj/+JsB6SmH9N0mPsht+ZOdisimqdqI8WVbum/pu6qXUfYe02FdlFX7O4RlKUp1+qxrpiawSRYQcVraRrZI9+BuH5Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7B5PEaWncEqpnn7NRxL0RpIaAlOV39VLFMxXLhrHfk=;
 b=C7vNXrCYOrjLkbGE4v3PWLwHEOyx/Adsq0F+B3FrPjXrOf3XpW3kjzzpxfUD9f7ZvDNPmTKsv3Yq74jeuD/Md9p30yVHiI+C49doTZ3Tb8RIabo1peQpSYORzh9FZCrB6IVuOgKgwWbjPPj9wREASIDqnKyL2EAs3JvTI+UKppA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM3PPF905D77450.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c37) by DS0PR10MB8128.namprd10.prod.outlook.com
 (2603:10b6:8:204::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Thu, 22 Oct
 2026 01:07:36 +0000
Received: from DM3PPF905D77450.namprd10.prod.outlook.com
 ([fe80::d1ce:85e9:74e4:3120]) by DM3PPF905D77450.namprd10.prod.outlook.com
 ([fe80::d1ce:85e9:74e4:3120%8]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 01:07:36 +0000
Message-ID: <d58ea6de-e17c-4426-afd1-0b67ead16b7c@oracle.com>
Date: Wed, 21 Oct 2026 20:07:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost-scsi: fix page reference leak in misaligned I/O
 fallback
To: Jia Jia <physicalmtea@gmail.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowangio@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,
        virtualization@lists.linux.dev, kvm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261021085458.196742-1-physicalmtea@gmail.com>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20261021085458.196742-1-physicalmtea@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P221CA0012.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::29) To DM3PPF905D77450.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c37)
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
X-MS-TrafficTypeDiagnostic: DM3PPF905D77450:EE_|DS0PR10MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: 876e6156-137f-4ca6-6486-08df2fd8dc18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|7416014|366016|56012099006|18002099003|10067099003|22082099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	MUbcT2paf88qi9ZS6ZXM4Wo5AmWp6eUJSsL6O2yVG8MLxyl44ZiT0+DUuaWBigVm/+RCvUH875UAueF8hptRwppmTztbGZ1Y7lb+Td2NJ1jih/CFZhX8v+5FQeHAE7eARqiW3CzjiVauK5tRF1EDj0jG/KPveuIhuqPhlfJwBIh3YzpCAYH0ZeN6443jQacJEZBZiG+qMUdiRCKbhoN3suEFN9L4S2fmswtuvQLQVUB6M9NRCjB58pa1OnBBmTKieIgMIZxgip1ftL4q7i82KsYsknJFtxkgFD6YwplZZ4hANHszecbWeSRTy0b4c2XccgitFo2k9RQY8NgPfY20iURHBVjFHDxVvc35+uLkjzd8rsOsXJ7HIUR6JREP9QIuwmFSuySJsifxvhsSTroM9i4//uWmFitzrTy8h419/sQj8d5m3Q/CM4lELmFApVaL4865BhruY5ZgOLioRS7cGJ1Ljq9mkfvLBx76ATH6Ww7YOOgqUDJ7f5Yj6TnUTrxaZPNSTKfIJG+EQ9au8dRNGK7fyQ8vup1jNOtuf4zSGyjuKqRORwjWYTAkyXu8YWUWjL77nxITbHktvDf7YnyJIo4zPdZvtkN2eKDT5G554zH9S6oNzuzTQQcn1q3HL+o3NUB/4B3rszWJt16JbUD+17K53C0jBDaNxVtYZFg1HeA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF905D77450.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(7416014)(366016)(56012099006)(18002099003)(10067099003)(22082099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2NQeXdaVEx6NEtITkQwTzlpYS9CWktkQlo0THFjTkdydS9qeHV1TEpKWC9J?=
 =?utf-8?B?eFVYS0VGMjFXaTB4WWZIMG0wMkIvdDBIS3Q1T2lETkNDNTI1K1VsUmtVZCtp?=
 =?utf-8?B?UnVHbGxoQ0JYVW1sSy90L01hVlR4ckhVVHF2elhEREZ0UWw3Mjk0czZWRXhm?=
 =?utf-8?B?MUtRSHRzMmZwM3hxeE5BVktndWxDamZyNGtCMDFYUUg0bHkwOW8wZExva3BM?=
 =?utf-8?B?OFh5ZGJzMmE4R1Zsdi9qTm50OFM4aEIxQzJVSks0NDgrTW0wSWY4QkYvMW9B?=
 =?utf-8?B?NFJYTk1LOWRzbjdtdzJkL1o3Tm15ZU04czlpVUZZWjNTb0pGdGxidkNRTGpL?=
 =?utf-8?B?QXhXNHd3Mlc5RURBQVVwVm1ZZUlOZDVBSkJVYmhSTkFiYmhZQ3pkRittS0Uy?=
 =?utf-8?B?ZUM2VEJxYjNCYUducm1YNC9YbDJyeTlMS1pQMlo5RVRUbE9sMUR2Z0lQTWYv?=
 =?utf-8?B?VFA5OU1QVkZxL1hoZmdKOUYxdHd4WENIMjB1cVdmQTZkUEtaRTVBOU1XUVNr?=
 =?utf-8?B?NjVEV3ljMkVTd0tKblJOSll0OWhrWVFOUmI4TngwQXpCejMrRmpRN3llNHpE?=
 =?utf-8?B?YkVSaDVGRi9IbEZVN2s4eGpVYTJoWTJwME0wY0NSeTk1czJyRkhXaHFadk9L?=
 =?utf-8?B?UlRQMDhyVDlpeW5vSnVlbFE1QlFvMnlZOG1zTU9udnF0cDE2dFlmTS9KbTVT?=
 =?utf-8?B?S1liM3FXL3ZFakpIY0JUVkIyZmhoaE5ud2doTG1rYTVjRkQxY3ZYRm0zOVp4?=
 =?utf-8?B?OVFDSXJHcm9XR2pMY0VaYy8yV01rYWw0dWlQbWNMMFFnaVYyY3MrUDMxajE1?=
 =?utf-8?B?Wmh5WnpFOEczcTloZFoxTWNDYk9oUkdJZ1c2bWZrdTY3NHpsTExCemYxdnNi?=
 =?utf-8?B?SmRlNjlqbFAvdGtmVHB4c2F5Z3RiZUVWSmEwQkpUU3cxN1lhZGZadTAvbkFy?=
 =?utf-8?B?OW9VL2hKamRTUVZPN21JR1FxSkE2WmVkakZQa01RWGlsalZwSW5YNjZMQ0dC?=
 =?utf-8?B?dW9lamovaDZMbGIxMGVEMU14dHNlQXBMd2pOU2pLQklyYk15RnVjUnQ3MWlv?=
 =?utf-8?B?bG9aOGJWaXJ2S25HbkY0VWllelRDV1hkL0Y0U0tRc3JvM29IQ0xnaE01U0xi?=
 =?utf-8?B?Tnc2WVpEMGl4ck8yL0gzZzRGVG80R1JMZ2k0RVp1a0NjR2lBUno3YjgwVGpv?=
 =?utf-8?B?WUZMcytIbU1TcVkwOTNyV1BrdE1HbElWR3R0SWV1U1pvcGpiYWZyM05KS3h2?=
 =?utf-8?B?czQyQ3A3UFYydi9zTnZrT2pMOG9hZHJrZWRJYVBUUkc3eXJ6anhob2szdUdS?=
 =?utf-8?B?bTJPRUR3aGE5cnd4U2FKb3cwR1p3MUl0L2paTUZsYXBmK3dyejM5MEtlNmd6?=
 =?utf-8?B?V1hXZnpPYkJkOFpDZUhYUTkrMHk4dDdabU1RQWsxVklVbzJSWFR2QzhsSTVW?=
 =?utf-8?B?UGRzSC95bzRaWXR0Z3ZKVHVaOTZjcnhiN0dPRmpiNVl4N2Fsdnl4c3B2aDVq?=
 =?utf-8?B?L3FrWEx4SUJJS2g2ZDhOc3NlTjRFbVkwQTZrTDl4dFg3REpGQnF3Q09mTXNC?=
 =?utf-8?B?UUh5eHRpc09KeEd6dnAvdjJZUnZ1Y252dUFjK1BNeXpQcTBncFM2Ym1zS1J6?=
 =?utf-8?B?M3dkSXl3NnZRalBJYytOdFZ3cm43RGQ4MEU3aXBONEpKY3dTNTk5Y3I1OHZR?=
 =?utf-8?B?UENGKzVya29lL2xhMmRaZEh0dFRsUktyemwwMzRxRWQvaGdQVVRzK2lmZEIx?=
 =?utf-8?B?Wm9ROUtMRUxXSkcrbjIyb21HQXZ5TGV5dFl1R0diTmhGK1UyYk1SSUFLY3lo?=
 =?utf-8?B?VmNNbjRHL2o2d29IOFRpYXBYRk9pSHFGVGtOODB3eXhyNjhpUlN1dElKbmk3?=
 =?utf-8?B?Rm5VeDhCaTF2aDl0NkxZVS9DeVMveU1oRE5MaHdXTWV4RW5kUjdBK092dkdu?=
 =?utf-8?B?SXFXQjJIVEdJTWQ2Snoyb0I3UFA4OHZGa3FoYXFidjExZ241eXZFTTJOMmF2?=
 =?utf-8?B?L2RMVHMzRm1kWXQ5MHdvdnNPa2hxcjE4ZHRjM3Z1c2RsTmZadVZ0cDJ0SlRS?=
 =?utf-8?B?VXgweWhDelFjV1FpWXRPS09yb3IrWlNLSkNHR2ZaaGNqZFdyVmpnV0phalZJ?=
 =?utf-8?B?OXpnM1NKTU5weWJ1QkZaNGFBQ1A4TkFWcHZ2R24zNU1aOHI0d2djM0M4OWFE?=
 =?utf-8?B?dWI2M2l4QndpUFoweWg4Q0ZEWndleFBvT3YySWlVU1J5N0FnOE9YZ2RJYi9Z?=
 =?utf-8?B?bkNuWjJNc1JlZWtJSzVkZEZ0Zkx6Skc1S2xzMElkUXk3RTR6eUxDL21sbWZD?=
 =?utf-8?B?TllYSTNvcGZiRnc0Uno0Lyt2QXBqWWJkNm5HUVpNbm5NclUxckJSeEx6c3Ix?=
 =?utf-8?Q?DXn0z3AmUZD55HlQ=3D?=
X-Exchange-RoutingPolicyChecked:
	uhPuAl3tlJRKYivkfjJvcqfDn4VSUbHSC0sF//6sis0jMSIXf8NJN/Xabx1CAgSLHLPVbUra5cPXdR3f8mANHu8CtyHac9Iy1tH/h0YoaiXoEp9NV4vBUNaFD1djdA8Axf7m3N2W0dJRGaOq7rp8bcryLDoHngGkgceQBLcUVHL7S7r5vqlZP5QHHc52CaOfJwXgNMuiwVijtzQN0C8UlpBl9DkqEE26xWe1ddz1ommmLXyTPI8qxmDoRyi+AEzWh8ngaCipCjfj7U8seeufCnrvzeSdjK1olclJ5N/K0hMiduf+abOwlRwsm3ycBmN3Onxkn5Xc3mjTrr3GzxwQkQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UY1B3Rg231jQ1yCrHm9Q/1wTcwelgSQ1IQETq3XVrOzGaorlbF4zmZQKEeMHJ6Dzef98+fJYKsmeXWguKEkxucFwAjaAMoqyD8XGNrEwp/zvyui1zlpS+odxa+6Zaj17/Kz2XfrTdYHFBJkK2pJ/3NJyIq4XnE39t4SdhTfgTIzguf97nqzQhYyblRanrReJzZsH9SZrIUOc43znfuigcVl0h5poEYu7FdcQyLLNrI45jCdEFQygQD+uiUTwkE9YLb6aIB6IAXREAktu5fOUUuzZjNw5XWDlKkvdYsGL5Zz8/keEFRUpqpYDIDg2mwL7er8UQAbGCdcYVnMH5L6D8yfZsEW5i3UOZWREu7bq3WsabnDted74vY2j6BeskMRfzBXK6sqescBoU1EHmGdTzXu+gLeOYxdK9CIlBvmg9Hl6dY7unVsmdnBRTyQMrXnc5u5CuwN8PPWr+iJOlvnaatUnynSJmLY73BP6lekAC7klkrr1aDqD8QiL6MBmO4TWkm7OErtGMxw9BEZFOnV2x5C+VGPvxbWEywgFtHiQtZQhTMMlWhfBHcPxxi11ybGmxThUJn6umMVNRLtE64rrXCBMvdnQv8NRiToe1s2RZEg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 876e6156-137f-4ca6-6486-08df2fd8dc18
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF905D77450.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 01:07:36.3443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 69lT5tJHD5lBtyVH7N6RP6w/PUVgKFC8bMMLW9ybCXd5xnZCrC6BOx1iy76TpvQMVJK3L1gNGKwiKqYZHYu/OQD5r/5pH8cgoOQgdTblWDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8128
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220003
X-Proofpoint-ORIG-GUID: 2jymWeHCmK10GN4V8gdhjn9gHLZ84thq
X-Proofpoint-GUID: 2jymWeHCmK10GN4V8gdhjn9gHLZ84thq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAwNCBTYWx0ZWRfX9xacZgBUj6W2
 THcdHO5hfT80AVwKWLW2JeliNOQ/CzAPpmEA8LZThmesrAd3b0m7X13oipZhzuTM8OGKGvqn4iG
 i5BxJ/m0x2oDrVMc2NOy2mDoNodqk5jnQfqwVuz9JeESREm4ae7W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAwNCBTYWx0ZWRfX5VkTdZtEjEpC
 ms0FIuhJtBwgUr1HQIHVZG/2zni1MtCZF+oYQhO/ZwVgFwxHiFIIycVEEaRvz2UXsO9tNUAjxTi
 HV5XaPm0dLrYA1YImakpzjsT6XlWryjIzwoaU3Id1DrJ2x3AvFA4XuUdr19jzL5AfFHilzsJ6Ic
 CIHzwK3y6Vu830GMNzVelSjF1MHPbi5iGu1hwczJx0Y+mV3z5SDaVpG0A+6WN2jfrc3CNqVU7lC
 07vO0M2gGFz3M4E5kaoJnnGyaF3VmEJVd3q4SUsGmshrrDoGmXxMbNDU7L96yL0/HDJew5mk5Y8
 H3B1+SXHiIyr/NHsnqLpyWPScJ3luqsElatAPYO/tq6EQWXxeYpXeCLxgz+B1xzCQFn3HTfzeSg
 MjGntJhfJFxuwRcZiCkCW8xBlBJ+3INnyEEGgCxviTPYzPUGZSBXU3kxMBkkFh15VquuCzI5g83
 BYKZqHXgvCf5GYlBTfA==
X-Authority-Analysis: v=2.4 cv=f+/dl+yM c=1 sm=1 tr=0 ts=6ad961dc cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8
 a=xx7t0CJ7OoASFWEEgV8A:9 a=QEXdDO2ut3YA:10

On 10/21/26 3:54 AM, Jia Jia wrote:
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 4f8c0260bc9e..b7e41c0a91d4 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -883,11 +883,16 @@ vhost_scsi_map_to_sgl(struct vhost_scsi_cmd *cmd,
>   	vhost_scsi_revert_map_iov_to_sgl(iter, *sgl, sg);
>   
>   	iov_iter_revert(iter, bytes);
> +	/*
> +	 * pages[npages] is the first page not added to the SG list.  The

Just a minor nit. There's an extra space before "The" in the comment.

Patch looks ok otherwise. Thanks.

Reviewed-by: Mike Christie <michael.christie@oracle.com>


> +	 * remaining data starts at offset in that page.
> +	 */
>   	while (bytes) {
> -		n = min_t(unsigned int, PAGE_SIZE, bytes);
> +		n = min_t(unsigned int, PAGE_SIZE - offset, bytes);
>   
>   		put_page(pages[npages++]);
>   		bytes -= n;
> +		offset = 0;
>   	}
>   
>   	return -EINVAL;
> -- 
> 2.47.0
> 

