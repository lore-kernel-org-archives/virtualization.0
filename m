Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795235729;
	b=Zm1ngO4XPGNxg2wqvR71mN2aWH5J1VpQC35TQ5BELtfDMcCNoHE6Q1R289/jpTSYBCXj
	 g0mOIEKgmdnY7WkPGrMFZuyvvBoPbNFGpwAI47yigiEOoYq8i1yE0uNbG+Or23UIWdW4Q
	 DL8OqVI68+pQMgj+uzvwzF0uZswGQR+jjgM6YE97d+ZcEMBP7Ff0Zinid89tW4oGljJM9
	 aHpKh4lGUSeoqCDLu2XAhBxRvnHtU0r6223SJgxUNPeClU9ZCfBNBCFbtE310QpQp8VmE
	 AdOZH6e9xsVDfIAexIeBOR8AXYl4R7BIzQaDkhLsk0yMEtFG5A3KKm5YfJ9+609/7Bg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795235729;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info;
	bh=w8nlCLUtrRZIoIcTAhiKS/UeWv1sVjHcuveF6CZtGBw=;
	b=vs30qRYdq45AZxGai1rMnKNy71WDoUn36OP3wgD6sYtsTKcZmZjXYbLoz387uysc594L
	 NIiwiwziJNrd3mL9JESecO97yAu2ktA4WoDILJxuPMP79uFETKsQ9ZuHYCVuCG0HiW6dM
	 vFKeH9/iXXJaPDMhqNTz8tZ0Kjiq7BzmfxyOTSO0NJgHvA81G4aIkLEUtV1SwW/vify9y
	 EX1RkKx/wSOjtpncvl64Nr7XW33iSiHJh7SDgwWWJx+iD+mfrTmM4buw+LDJ+1Np+fyTh
	 LlncUPMXOzbyjy7R3ngT3QoxNXB841/wBR3gqd1AFiNFU3YIAuvivJemlOVHfVXZ/vw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=rCEjZkFP;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b="H/g5gR8z";
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCB7606A688
	for <virtualization@lists.linux.dev>; Sat, 21 Nov 2026 04:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CCB7606A688
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=rCEjZkFP;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=H/g5gR8z
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AL1i3EY034371;
	Sat, 21 Nov 2026 04:35:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=w8nlCLUtrRZIoIcTAhiKS/UeWv1sVjHcuveF6CZtGBw=; b=
	rCEjZkFP1z/oo11ORXActrRRR9Ru5ALWoN9Yd+kceAL3WF6TnLVg8XwVX3R8SJgt
	NTQaS41gtPHswQTWHuJeOKevXWMkLBpGprFMEcQkvdPvHm4R6R5j+bhcJjvIrKkc
	8MHXnBjA6CefPA0F+HYkJqbLn55XXjLJ43QPAGSCILxC9YLvGKEc+6oQuSGQcn19
	X2U98llNZAqKY/E3I3NEKgtRGEKeVyIKJct1jajneRcrEoCUfgt0/ALi4D/UTfQB
	1ZR5qN1h211Z4KiLLsveT+iy7RjT+POFIGpdzW74gxf3BxQ7UOLbJ4xyDUATh8/T
	2UInTLji7Or9MR7Vmh8d4g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4j31v6g32p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sat, 21 Nov 2026 04:35:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6AL4Cr7B3596028;
	Sat, 21 Nov 2026 04:35:19 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010019.outbound.protection.outlook.com [52.101.193.19])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4j31r9b9rd-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Sat, 21 Nov 2026 04:35:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mw2ajqbMjER9r+tqSp58HeW1rV6Y8GSQMfi2KcHgoOW8LzQae1VMC0wlCW2WLwSgOxPYpiG6gzPakYVwyZo8TKfhzvYCdl6ZZAD8hdV+ku1gwChqwXIc5Q4AluGLPDVom+Bc/9Syd+jLiZzbBWHzsvOP7tcC8lFv4yZ57ahuzdubxydcZWhpezliekQHsBPmjhF+9jxcCdSM3Ut9zzEgnGa1NzY4cBKRWd2gJA6lh1WJeUsdlqqhGr3Fg0J/4KtNpEZ8VTNzTncKp252+mSNCjHMzvRNuclBF9sAQHQ7MWt4W/JxCbWqxbDabRxkgjfcSuQmj/6oSgXim5LzYPUgWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8nlCLUtrRZIoIcTAhiKS/UeWv1sVjHcuveF6CZtGBw=;
 b=Xgp8bQ+2oT/mn6N1JQEAfUnqdNd+/x0+CX+wwYUUhp9nLm+v6A6aV/d5qE7gY7A5/IA4TmchaqjQIpYGKIvIsXxP8b/A8QAsSSzVqZR6mH9oMZx+oLdueViGHDZ/NUBgf8uTbhfewmGmhXfhp6yGIydk6lWG7V3jv7guLz5GK2NTeasEMTJbUkfwr3YPWB/6CivvvFNsRVd+CmG4yzr72x2QQwxvbb0wULfUjrKAg3LemvG6t8mymUlKAyuD338dpWL48v9N/t3VC1NW/dUvfobRmi9mIV1Qwo53baDoJjT7R6XK6V8UgjJc9mSh8AO3c9icJuQCsogju1yzjRu/tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8nlCLUtrRZIoIcTAhiKS/UeWv1sVjHcuveF6CZtGBw=;
 b=H/g5gR8zUHR3vaaYpbJqrwWCmkPSFhUtPa33Pm8kccDA/XgFM1y+tqIjcCycurGoU7akn/0LlscBuo38aPUd03C2izHkRZGEz3l0ZS5VjHBVd3o46KVKnx/wdOj5yQw3LTUlf7DvGCTdPmqJj4wtrU2fTLp3HDi9uc945zrvuPY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4261.namprd10.prod.outlook.com (2603:10b6:610:7d::23)
 by IA1PR10MB6832.namprd10.prod.outlook.com (2603:10b6:208:424::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Sat, 21 Nov
 2026 04:35:15 +0000
Received: from CH2PR10MB4261.namprd10.prod.outlook.com
 ([fe80::fd17:1c07:31b4:a8aa]) by CH2PR10MB4261.namprd10.prod.outlook.com
 ([fe80::fd17:1c07:31b4:a8aa%6]) with mapi id 15.21.0639.011; Sat, 21 Nov 2026
 04:35:15 +0000
Message-ID: <b8ff5bab-d08f-42b8-9c88-e4665ea3078c@oracle.com>
Date: Fri, 20 Nov 2026 20:35:12 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_pci: limit Oracle DSC2-200 virtio-net to 48-bit
 DMA
To: "Michael S. Tsirkin" <mst@redhat.com>,
        Jonah Palmer <jonah.palmer@oracle.com>
Cc: vlad.wing@gmail.com, brett.creeley@amd.com, eperezma@redhat.com,
        jasowangio@gmail.com, jkkm@meta.com, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        xuanzhuo@linux.alibaba.com, joao.m.martins@oracle.com
References: <20261109184253.531677-1-vlad.wing@gmail.com>
 <20261119200654.1048266-1-vlad.wing@gmail.com>
 <20261119181557-mutt-send-email-mst@kernel.org>
 <20261120171435.83458-1-jonah.palmer@oracle.com>
 <20261120123500-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20261120123500-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:a03:180::42) To CH2PR10MB4261.namprd10.prod.outlook.com
 (2603:10b6:610:7d::23)
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
X-MS-TrafficTypeDiagnostic: CH2PR10MB4261:EE_|IA1PR10MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: 12d486cc-dd46-476e-1dac-08df4788d6a3
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|366016|42112799006|1800799024|56012099006|10067099003|261028144727099003|261026121527099003|4143699003|5023799004|261026140227099003|261102123227099003|261021121427099003|261022105027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 ymPfBZXgr7/P3WVKFkt3yv/n5kKltnqJ+NoQLH8M4W42XcYXb0K37CKT/W85prJWzgoEBcuVgYIr7K+99nbu/F/LVissgNocoLunBrbUfQ34/++TNKNB38ir8/YmdWMRnEuOU7scb2jkDBB8DMZZYDBgOq9QyG704FuzT7yyOYkgTJ90TyzAFsR90LEEYxgQj3q/1APDgep5oOX+lQeqdaZA50EalegDkfPOyWbFXxvMYWvo7UmcaT4lgT1MmdV9b6Icqo4u1jR/1k3966MP+qW8ubeU2ZgCg1n5jaGpaw8MgXk9VvWfkQ0pyb8lzQy4i2brjBI0xZ/2Llqw1yJSWkWZkFRxQVS8PYIp7HYi2NxgwfAvlFD2vqDGBKFxhUSvuP4jTa2P12POphYgT/62YoS4m3o26qzM5tQiGvggNwUIqjaVaSNlH+aptW6mNMDG0nOagXF9ahbYjyBx5k/PQs6kwXnexu2xXARwxsTevBwfLLIggmT4Q/CYAVe2wJNAj3h/xcPEobKCeyLzxnNfOmrk2r74BL7QUpbfDBXiea+XV+faDl5G0aOf+c1I2k9srInPzZHblRFdVAsb7OrmrMy3B99qwIS6r86wAi8Ohxz+gNw9JVgifPA7pabeXrYuBdHocSMAi1UFYH3FsCUS3FY64fpM7Vtq40f2zxoPyBo=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4261.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(42112799006)(1800799024)(56012099006)(10067099003)(261028144727099003)(261026121527099003)(4143699003)(5023799004)(261026140227099003)(261102123227099003)(261021121427099003)(261022105027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?T1VwL2lrclB3dDY2eHBMNzVKZDU2Q3lwT0crUXlXRGxJZmgra1RyN1Vpa0dk?=
 =?utf-8?B?L21lZUs3NFNweHVWcnhaU2I0NlN1eGZGUzZsMWZRd1JBZjhtSnNkUHpndHQ1?=
 =?utf-8?B?QjBMNkhQVThEWWNwamFOendacHUzbWRFQWdQV3NjUU52b1BKakVGK0VRSytO?=
 =?utf-8?B?ZGVoVzJtNU50SE5sTGhQOHVydldhMUVBUnZ2dWNFTjRvUVUxWm9XcFdobnNa?=
 =?utf-8?B?ano0RG5KSDk3SGtmdFhtazl1S25ZbjdVNUJ2YVY3bEZxWjZhQVBMenFRVVda?=
 =?utf-8?B?R1hoSFJlVEF6aHNuZkRUWGc1UVJpQTd0R3FPRW40MFFhRG9EakRqbmxUd21E?=
 =?utf-8?B?N01WRDFqQ2F3NnhpWTlCdzdsTTB0azUyTkpsd0t1c2Y5WjRwOXNTaWJvTEh0?=
 =?utf-8?B?TExRWXp1amRyZjNGb01uU3UrOHNvWG55UG5DOUhsU05nbWFQT0JwNXY3c09R?=
 =?utf-8?B?b1l2V0RRSExMTDdrQmJPMVZsYytKQUhMVFJxRkJGa0JobzUzWUo2NHQ1RVVW?=
 =?utf-8?B?QUhNSTdDQUF1TXYvWmt5bkhrTlY3dmVjRlVjTjlNbTVGVWxHeGo2TlJXbUNK?=
 =?utf-8?B?TTgzcHZkU244bStSNkR0VFZYYk5KR09RSTdtYW45alBxMFRtdVRZaFEwUWpv?=
 =?utf-8?B?eGVQUUo1b25BSVpHcWVBQS9mM0F3WVk5WWFRRjdKTXpZbE5MWnNSRlRlSU1q?=
 =?utf-8?B?SHNPclZEZzlVVEZJV3pMZTdyWFM4encwcHQwZU1CanNHVmRSMXYyUUdHNy83?=
 =?utf-8?B?UkVaSUpYRmdrUU0rVzZDT1REUU5LcktJTmZYZkRiR0l5cUFLbURNSXoveGww?=
 =?utf-8?B?dXRnbzU3YzFxZXlHdW1KbkR0dmV5WHY5TlNnVmhwa0ZwYUVNQ2lMTGNhMkVE?=
 =?utf-8?B?VXJIQ1VseXhhOU04RUp2bDdFLzVUWGdHMFdSSHI5SWRQbWljaEhjOWhDbmpr?=
 =?utf-8?B?YUlib3hUVnVvODhUSHZFZUNjV2MycjNhVERHMUY2YmdoNWlCWU9mdkhpaWEy?=
 =?utf-8?B?N3drVU9pNWh1OWluMDNZTnF5aDB5anM3OHpRVTVuZ1dackVUVjg0T3hBaTFU?=
 =?utf-8?B?Vm96cWZReVBTOENFbWdxK2ZNcGd6elpwVkc2b0tmTlBXSVNxaEhBOTFZTWNH?=
 =?utf-8?B?ZHU0cFVJSURzTXZvRWkwNzBDRnNsVWkwKzl2UllYYU5ock1JVHJZNTloMzQ0?=
 =?utf-8?B?czJtcVVKeXFLbFM1U0tScVBic3NmMWVUellweFlwNHA2L25oajVycjdqRWlh?=
 =?utf-8?B?b1hnTHdJMjVMSFpJZzJNYWlVS2NjZklUeFF4SWRxalFBRzVGR2ZRM0dwa2RZ?=
 =?utf-8?B?a2p5Y21ja29jVmgvZFBHTk5KbnRXdTY1NzRvZ2c1RnFQWGQ1ZlVXdkVsWU13?=
 =?utf-8?B?ZzNCZS8wUWlnbktYWTlSaWVTUzVVMkF1VjYyb1pDaXMwbmxHYlFyUmJCdUdS?=
 =?utf-8?B?Q1ZQQWplbVc2dFprUzJ2b3dGT2hHTmMxenJXeDB6UjNVYk9QRE1NWFJpUXpR?=
 =?utf-8?B?S2doMDlaWU1SYmFMQUxRcUxyZVg4VWV1MWRoOW5tdDl2Yjh5RWlNcnVrLzBB?=
 =?utf-8?B?SUpENHBkM29ETDNjZDZCK1drSy9ZN1pEaVYybEdRMGUrSXNGbDB2SGliaWsz?=
 =?utf-8?B?TWNpUTMxbzFEME8vWlhJQW5nRStIVSt3Z1M1R1oyM3RjdjF4Rnhzak5HdkhX?=
 =?utf-8?B?aU8wcnZMR3VjNUJRazRpcFBxWHhtdEt3dFY1SVFwamNiSnlQR0U0REp6amMy?=
 =?utf-8?B?Qm1TaUh6aW52TnRuay9XUERPZ0dOeUxnc3BiTTZ3VnRoYmw4N250R1BNdk4y?=
 =?utf-8?B?QjlPY3RxOEhlRTBtcjJnV0hSVG14eGxSZEd1Ynk4WEFNTUhtd2xIQWZJSTZR?=
 =?utf-8?B?dEpNL09ieXd2SUUrVDJsUmhEWWN2NWM1dXhOdDNjNmUwNXJxRnhneUlRT3Qr?=
 =?utf-8?B?TkttSWl6WnV0ZGttYjArT0dVaDQrUW5nVlZuNlR1b0lueXhsdWQrNFEyNFlK?=
 =?utf-8?B?ZWNDbjA4ZytKcVA1MlU4bXNJNU5JcWMxcVljbWFvN21lMHhxV2ZvRU9UNSty?=
 =?utf-8?B?TFpJZ2d3WHpjUEZEUGxuNDdhZUlMc1NUNEtuYUpaNm1Mekd3NmF5bng3SWox?=
 =?utf-8?B?YUc1ZVJlOGVlLzN6TG5iT1Badzh6UG1VeVBHL1hHam4wd05mMkRjNEFHQ2R3?=
 =?utf-8?B?T2JSdjI5eUVSc05PV0RnN0VFS0JrY2VTOGpqUlhNWmxjcFVSTHBxaXhQTkpG?=
 =?utf-8?B?b2xzUktSYkk5YXBDS3ErakJ0dUEzOEV1aEFRQXI2OUNXMGFqUDc2SU04dGxW?=
 =?utf-8?B?ZnYyK2laRUVBTXVRZjI3cDdBcGZ0Szh0dlhONjhjbDNnSzZSWEJNZz09?=
X-Exchange-RoutingPolicyChecked:
	kviHi6n/emkjDZ/DDw3TPrcU4UPs5OJ3WsDKNLN4Y9JjKiSQAFFruimSNRaLpiVOPXKPID8dNkiHec9LxeHixy1s5o7i4zEUgEt3s4twx8zlmJ3PYW2wdsoMhqAS/tg8nE761Mp36L61MPDXVwgbN5nKKrjHqeEEFuhQSiMH9bJvei2hkTpeYzlcic84dYB/BTYwDXcY6DuXULLGMwqRArwlDvUYMxK+qfePTsRuWYiRyeJhcpbdZL5gasjt7+8w1XeF7ZdXU/qwU9QSL9BiTmm4mUngBRfSnnPG7aqTIWeursrKuIXlLUjfKOF5huvQt6uDiQvOTAkHvtV3ZvHWqA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4x4vctCXZ/etzI+7p0h/7mFhzDgSsI7ddhaWGhftoSpaQeZFOUWMisje6UeE/0c4Sfjvl5MCaSpgVuA9/yPlBnDNDx83/ncdRLzLN8RT0cpPFx55+VbnGptT2Y4KDEyDwaNEaJ1hk0h1lukUJ6JKM02mZrghb+OIB7GhF/1mVtE/mSesxzug46UueBb6owyvLZEbCSl/WMB88L72ztaKu++FVY4w91HyvHkcHDHPAc87KuCtn/eTkB3x/zIyd2/z8ZibqdhM8Dch9MTpxeaL1Kpvj451xZGY1o/6KfBh7eV79VbesvY8LHrgD3dEtDjj3LNRDYnygQMFdZ95oJaceICNw3Yis38BSfSIJm8tMctQilKHaliyJxcZuXnVf4d4FQIHJ7E75AN4AWrIkc8a441NkB5rmwWxDYw3VBSpC1jE4qnq2FpC+ZZh45ZSb2E9pzW9J+rOUsiiblJLCIaXpYeFfROVZMqaCJfLpldbS6+R5vD3zW3QfBL+wI98wlhncaFrXgYNaME8FwuAW7gKOr5e1EWebXSdKRVmHpEkjhzFrl0bLXR5EGvFbH+s3KK4LuJ95PLFIvL+csm8siYxHIEj/RJbU/DALyl+hVicT+o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d486cc-dd46-476e-1dac-08df4788d6a3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4261.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2026 04:35:15.4896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bzAIHoVM9yhqprsssbxWoDfqpqiKgAoYfQP75Rfu8jJXUQX5MfZ5V97MnIpAnZnLVQ0Z04wh0G9RifT6pDujkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6832
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-21_01,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611210017
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIxMDAxNyBTYWx0ZWRfX+Jni81UiKMo1
 sRH4U0oz4xnZur9hkFhIVDmRyiIBrEg5lKAQtAmMNTusvHPr7yVPyZlNLAKYCzhM63Q9su2ccYu
 8fd6FLrzFE9o1vdhdVXZujEDFSz4ObR7pGXm2xs6lKiLvhbNOYKYycdxe2AWGchbxZQb60Pzcej
 r8/dZUIheBkE4oJzdWbEj4H3foMKVJlLOuxEzXoq+hUObuksJMmMM52zrDv57cfAdexFbEna9TJ
 mYKrLAtsroHe13R9bYgkdLfxy3ibVns3psRHiaSXGgON3P3Gd9/OJEH4rY4J3QG1AcBD8uKWM2Q
 kXj6c54U/ruwqGjqZ+d4KFwujIKUJ/obj1E/0NPokYCgrnn5WfV4Bc2rNoBTJXxfFjCT9SEnwYW
 1cSjgbyvGVXNDApFNWvGRi4apkTqNqXzi47Sg6gxkzSMs6IhNuLlXHCdIweUqcmG6pm1vm6BigP
 ftCYQiVMDrmaMzzO5CA==
X-Authority-Analysis: v=2.4 cv=UbzE26SN c=1 sm=1 tr=0 ts=6b011f88 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=EYVZ4-Xard7KyOttcPIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Ozm68FY_46VresgLSvaQWwC33cmiCX0v
X-Proofpoint-GUID: Ozm68FY_46VresgLSvaQWwC33cmiCX0v
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIxMDAxNyBTYWx0ZWRfX4YKSoy/22omY
 Iay9CsQxZj38h/K5vCIAruAQ3OqquamjKMRJ3ikobBNnSx+NLtaZDVIsLUuo3bGKmHAxJwklTFq
 nRCSb0SJm4NeM6j7MM4vTRyPQYh8ZBoiZ5dhy/MDcIPeNpi4m+S9



On 11/20/2026 9:35 AM, Michael S. Tsirkin wrote:
> ZjQcmQRYFpfptBannerEnd
> On Fri, Nov 20, 2026 at 12:14:35PM -0500, Jonah Palmer wrote:
> > On November 19, 2026 at 6:16 PM EST, Michael S. Tsirkin wrote:
> > > it's in my tree.
> > 
> > Hi Vlad, Michael.
> > 
> > I've been looking into this issue extensively. The proposed 48-bit limit
> > is a suitable conservative workaround. My virtio-net testing for this
> > issue shows that a 51-bit DMA mask also avoids the mentioned issue.
>
> Do u want 51 bit then maybe? x8 memory with no BB?

51 should be fine for now, but it's not the final expected limit. We 
just wanted to inform you that this is subject to change, once we have 
firmware issue fixed. Maybe you could wait until the FW fix is cooked? 
It'll be a short while but we will let you know asap.

-Siwei
>
> > Full 52-bit DMA mask support is planned. We will revisit the driver's
> > DMA mask once the firmware has been updated.
> > 
> > Thanks,
> > Jonah
>

