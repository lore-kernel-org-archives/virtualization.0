Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A2227056E
	for <virtualization@lists.linux.dev>; Tue, 27 May 2025 19:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748373757; cv=fail; b=JFMpd6lJ2f0tkVOnWyY8oGEuB8CLK/CFGDDwwFN/PYucip+ABIAmGhzbPERYhzRtGdbvOjMYigm1/kzJk9dMiuQ+T0xEU5Gsmka28WlEactkU3cBLM7BK78ewoLINhrdurJ/2PLWYK1tK7LRR8n7XRHsxf5/xIdtK0XVqHUOI3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748373757; c=relaxed/simple;
	bh=qe+qCbbNsScDZSQW633ZrLz3wsT7SZGsarFVEuaztx8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WyLpZAJpgxCaVB6WwbCi36AIQoyMLoms3Rleq8QVAgcYeLj2CTikvisKV0UkNM0nrIKAEyyf2UUxdaJKGt0r0kgcTWF0y0l/XsUe7fOJPIQ2KpQSxTTDub0kxYV0A66cxQsvfD7SoSl3e5iWu9ktRpAlZKi5mrayEHoHYoE/ZcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ninGLXEq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Hz9BxlEl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ninGLXEq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Hz9BxlEl"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RFu3e8024646;
	Tue, 27 May 2025 19:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=uOLWN9T2hDtQp2mRPMNDefIcqGKfPguXs09SabMb9C8=; b=
	ninGLXEqlamWOxiXzqe55skfrSrmcfSqz5+UliEKlZrHeLHP/86G9dbgJBl4YW+j
	qMOLTyi94yHftOtwRrqBrX9AUhKQXYYXvTDXvGETGPyJfXvgkYIpHVS3r46fr0Kn
	SrD+qWXrwVAitl+HqLbzh9k8q7+jFyth4XhCILC7+IZVf2dwfXVXS5VKk8YAIz3p
	+Kbsd0QCj/T4H8ukyumtB9PTKA/ybUDPhnNDJQNT4jVNP9Z6DgQ729HddDCsIikS
	n5SRu/Di791NqShIlabCmgZKw4fb6FbSQ0ZxRBbKZ3oSvsw/GFjtytgUls6/Q4sk
	k5XMTHlqfMj5Ebr8dWcjZA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v3pd41bk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 19:22:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54RIQv2A023120;
	Tue, 27 May 2025 19:22:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4j9cmsr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 19:22:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xWF9KCTcwhacxK+JhD12IuzKejQgJ2F6814JF+/qlCL6lIC9ctdS9NQ/swMWvdpnfYg0yNdNWNBslX0thpFFG2Vr3LscGxFsl9gDQmfDwdMMw8hn5qIQGLTCRlgc8K3aJ/U6vZDw9AHBCipCuumGSzVI8Z4G5+oC9J18ENxTIFn3MoPevjGs00uW/mjz3Rxg8djYW8tnQAPjkXzBEFt3VEdwlyvtb2C7zIkMwLUgcTNMXHLWfPshcmia31ST0HPibToarwHWyWF6CXnNIiB4KK7k5BC4PBtNIrGat8VSHUtX7i1bzbKIMZcB0bR/7xNEjUHq52QQH6S9UlgILVe0KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOLWN9T2hDtQp2mRPMNDefIcqGKfPguXs09SabMb9C8=;
 b=f7buCSKEnQFhqhVcJNf0KP0nWUIT0cyjSAw7ZdPX99zd4Yf1yX7zAQIEKWbuz0VK+r2tfu1n+4WkAY3AABm3zx5OdkGZjEm53uNHExb+H2T1UAl7R+cXa4L2bGdSruq1W3oG4xkvhX9a6oEKieQ76yJevZK1R+I3wDXMFgYhK+RHEAo2pR1nY/9tTgUa7a6sNKFH1r2/hHS2RABooPRuXwjQSqTSECCz3G18WNy37kOPDg48Io1yJ4ySGsqRkFYdjB1aKpzPV5U9mKPvP2Ehfa/sUEQaacODUh7CP5tmxy8kPOih2GB1oHwEOpDADw1wkG2t7E7Ms9G7dmQmN6Lemw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOLWN9T2hDtQp2mRPMNDefIcqGKfPguXs09SabMb9C8=;
 b=Hz9BxlElR0ce8+1rc5BGzUP3pEK1DfWhPy0uQLUNCjDMeZKk/2hs7P2YKDZLT7shtWYySB6VD60KcdkRyVm6iKXvCNoW1ERVacDIbLloiudiWW+agc4zhV7cqq3ml7bFOK91wo4GAkih6ueO8oEngf8brQEg5JNgYI2RHWpNN2g=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by CO6PR10MB5650.namprd10.prod.outlook.com (2603:10b6:303:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Tue, 27 May
 2025 19:22:26 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8746.035; Tue, 27 May 2025
 19:22:26 +0000
Message-ID: <482052fb-1642-4853-9100-37510ec66452@oracle.com>
Date: Wed, 28 May 2025 00:52:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [PATCH 2/3] virtio-mem: fix multiple typos in
 struct comments and function docs
To: David Hildenbrand <david@redhat.com>, mst@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
        virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, darren.kenny@oracle.com
References: <20250527183407.2093374-1-alok.a.tiwari@oracle.com>
 <20250527183407.2093374-2-alok.a.tiwari@oracle.com>
 <ad77ace7-89e6-4b26-bd11-9b7ce176dde9@redhat.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <ad77ace7-89e6-4b26-bd11-9b7ce176dde9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0198.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::7) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|CO6PR10MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: 40df6917-4078-4433-97dd-08dd9d53d096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0JPVURvbFlwM3F6em1Pa2dtdk84OUJhMEFGWU1IR01PeTNVNWJWUExBR1FS?=
 =?utf-8?B?U1ZDK2FLdU4yK09kUWlDYzMwbkRXeENPUThkUDFPSzVEZ3cvWGNOM1JVS3BW?=
 =?utf-8?B?aGI3WHZrd3VKaFNVQ1RQL1c5ell2ZitoVWFiVW5Qd05iZHlmMmx4d29ZVDBF?=
 =?utf-8?B?KzNidG9nS0UrQ3BVcFN5ZWdnbDh0VG1WMDVSeFhHSlNDZzVUVURROUJLaVF1?=
 =?utf-8?B?a01wWHlwc3NXTXRnRStIUGRSd09PSlRPODNrS0dSZmNBOWpNaFNIUW9Mcjk3?=
 =?utf-8?B?VU9WcjZrMkpFdFpKbHdjOE5RU2FRVHBnSzBua3EvTFdjeW5mS0lBbUtYWWJ4?=
 =?utf-8?B?MWMveThUWlJGQUhqMndML2VvVEg0RTd5T21MZExlMnRvMnp4WmEwNkNNM0gy?=
 =?utf-8?B?M2RoOWs3MGorb2Yvc0VtcHRWQ091clpncHI4Z2hTRVZZRHpvNjhBTTZ5VDFJ?=
 =?utf-8?B?L3g5cnNZL0t3WWhsZy9pRWdxMVd5NmVGSkdhUEFqQ3RwK3k2aHhRcEJKQmRY?=
 =?utf-8?B?NXBxZ1E5YWNaQ25NN2Y0d0FhL0w0dmRzS2pWK0Y0Z0YvQ3pJSjJCbUtHalZo?=
 =?utf-8?B?NDVTUTMyaHhCa01CMWF2eGxjWlQwazFxSmQyc0x1U3l2ekQ3NEkvY0s5WlNw?=
 =?utf-8?B?bS96ODlsWFVnSHJQL1JnamphYmVXanZMbGxQdkYyZXgyS2x0TkJ2MFczOC9I?=
 =?utf-8?B?TWxOOFVUTTVCa29SWWFtVEdIbXZqdVVCcGZEK3IycU90OU1Ua3BOZWpQUE0r?=
 =?utf-8?B?bTJhbkE4cGJ5T2tMcmFMUXpaQ3FKSkVHTEw3S0l6MkFwWVltUzhYdTNNRHoz?=
 =?utf-8?B?ekxRWkJSdkQ4L1JzWnVieUYrd0JxZ0RmK2RPNitDVzB1UktRbVNvaisxSUNN?=
 =?utf-8?B?b1AydVQ4Z2RFNEovazlSYUdpWG5Nd3lkeHAwY3ZpMW9TTXljZ0o5VjZHNGFR?=
 =?utf-8?B?bEk5N3JRa2VGVkNncFdzWUk2M213YUt4cTU1YUpXMFVqRGZqcE04TkdFM3VJ?=
 =?utf-8?B?dHR0dm43eCtTRmZNRFhxMUsxdGZEYks5WWV2dWFhZ05kYWJrTFBHYStzdWR3?=
 =?utf-8?B?ZWdsTUdwUERySFhXa2tzVHZVam1YRkRrbjBFOEk0Z1pJSjczMUlVbnhSTW9P?=
 =?utf-8?B?SndhOGRVNDB2K1duTHVNZW5Kck5hNytqOWZaY1JmaExhZ0o2ZktITFplT3JB?=
 =?utf-8?B?YU90bVEwUi9lNVBNY2gwL0ZqMkhFcmh1OXhhSTJPbkIwUGhhY3FYQUprcjBB?=
 =?utf-8?B?MXllRkp3bys3aUJvL1BHYjFZaVIwSWJwTlFvSWNRWkt1SFgxRzJ3M1pDVjZv?=
 =?utf-8?B?bmJncndHNy9YbG00eGtsQlJ1US9aZW41TFQ3SmJhME5NRERxM1FKZEhjOHdZ?=
 =?utf-8?B?cENXL2dWVlpBdWRVTURueU40YmpsOEw5TXZ2SEthSmNXZnVrV2RnTHJiRGRr?=
 =?utf-8?B?a3RRWVoxVGFpVkZ2NFNvalpuVUwzVXY3aVFDR2lPU0FYSHgvbndaUmN4VFBT?=
 =?utf-8?B?NHpSMDhmSjdvNERQVTNSMjlwbXFIOTlVZ255UDlRUnBYUHNXVWdSSllRR09C?=
 =?utf-8?B?b0dveGF1OU5zRThuTXNTMjN6N0pSVFZON0ptYU10YzJFWGZXNzhrTzJsY0tt?=
 =?utf-8?B?ZHFqNzBiMzQ1dnl5ZTZLRzZHR1VnaS9oOC8rREJYeDQzQWdSc2RqQnVQalZS?=
 =?utf-8?B?QlhzVTRsSWtBbk1oc05EM3R4aVRDYXhqS0NDMktnMCtFNVJSUWU2WTk1RGd2?=
 =?utf-8?B?OE82N1B5V0J4cDBBMWU3UGhMR1FWZjNFUExrZlNWa3A4QjBiTGlnbG00cTZq?=
 =?utf-8?B?WTVoS1ZZUXBJMk9nNDR4MzJNQnVkVk43NzlNdXVaUmhYZVNMS0xiWnQ5ZFR5?=
 =?utf-8?B?OFpJdEFUbjJQL0NmMmRGdUNEUFg0eUQ0K3I2VTIraWh1YU5EbGh6Q1RVR3Zo?=
 =?utf-8?Q?CRmDWSYR6PY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2FjQzdGcU5kYVBBYXFRaGFOSFdQZldGOE0wTXgrbjd1K3YwWnkzUTdHbkRW?=
 =?utf-8?B?K2s4R0l2LzRhdVBlREYwYk13VjBhc3BVcG1INjAzK0tVU2lxN1YzcFdJN1I3?=
 =?utf-8?B?Y3N5TUM1UmJUY0lKa2NPZ2hidEdHMW80Y0IzMXhkUVlubUoxb3NISTJUTnE4?=
 =?utf-8?B?aFVqVS95bGc4OEJHLzE4S1lPTFdXc2dtWDJzbmNiWVdvQ3d6L2NpVE5NRUw1?=
 =?utf-8?B?T3A2c0FWaUs0d2VjRE1MU1RQakZQalp4Rm5wVCtVays1KzNMaDFoV0hqM0pJ?=
 =?utf-8?B?SU4vckxDQTR5eU5lemlKZU5PVmtaR3JTMkJ1cXFTMitoQldJL2F2R0pXaVFO?=
 =?utf-8?B?ZzlvMjFZWlNvd2dvd3hrRXI4MTRZZTR2YVpBaUtxU3R4RGRlYmNYOEtKNkNk?=
 =?utf-8?B?QVpUQnh5bkwzUW5yeTlhaE5LdUpFTzR1MzhQR0haaEJqcVlQQlpucTNseURl?=
 =?utf-8?B?bTJCakZwUmVXS3dmWnV3eU9jS0FTWjJlcUJHN3dSUHlubVUzbWRyTXQ5TWZw?=
 =?utf-8?B?RUVhOHpUOUVESnNGdUtYVGNqU2JQVHFMeTlCVnlUUG8wZWRNdFYrZU5YanY3?=
 =?utf-8?B?dW55djNWZldCaGQ1WWJ1dUVTeFUxYmI4L0JBZ0o3QzhjUkJ0Zk14WWRwaEhw?=
 =?utf-8?B?YUUvS0EvSHM4dWJFNkplSDdVb3IzQW1qYUVuT1YrT1BzM1l5MWgvNGdOdFhX?=
 =?utf-8?B?eGZFdVVVSDVzb1pBZXBOaTY2RGRFTlFGY3dxQjNvc0M3NFZuQzgxdVZZZmJJ?=
 =?utf-8?B?aDVXclpiblMzd1VSS0VvQlFQVzFMb2txeWNhOFZtMWk4OGJDZmRHQ3JDc3Fu?=
 =?utf-8?B?a1g4NDI1clhMVDBhdmlyZHJoMWR1NlZMR2ErOUNXYkdPMUNRRTVaYmY3S2ha?=
 =?utf-8?B?LzlvVzFqVUNsaVovN29iMCtWNjducWdjSjQyc0pnQ0VVRlF6cjZZYXJ4VldF?=
 =?utf-8?B?aGZrR1NiR0NGNFdJbDVUNldTanZwWG9BbVF6S0lOWWpGcjFYT201T09ZTWt2?=
 =?utf-8?B?OXFNakVSUVJqOHZOWUhOaVBzd2NMVVdZaHJxMFJON0pXblc0djZ4SUZMNkUx?=
 =?utf-8?B?dmpvMEd0a0RSbEsxQmtVbUtzTGdYL0FrVk9HSjVLV2VzbDFuQTVOUUZlbTRE?=
 =?utf-8?B?REI3QmxaWFVzKzI0UlFiSTI0OXg3ZW1Ta3NkUkVvM2RtU1ZtY3BBL3cxbXlw?=
 =?utf-8?B?VU1LSkhPaEdsd2NnNzM0c1NEcGFLd2dnWk5kK1dhaG5NdnFCZENJSFVwcE1F?=
 =?utf-8?B?SUFTdTdPZldKd0dsMFI2T1NVVG1oaTN4T2lmZzlIMWlKZzArME9XTXZ3S3JR?=
 =?utf-8?B?VTdSbUFYaEJVUXNjRUdHcWp3ZVdadWhVcHBvcWxZb3MrZ281bUhLZnpESEVm?=
 =?utf-8?B?ZC9yV3ZvcUxpdCtuNTFuWXl5Z0ZLOTVRNDlrcFRaWFFJSS9pbDVTSlZmWUl4?=
 =?utf-8?B?b3MzYTlpZDZXTE0yeUdrandnRmRLV25IVXZZV09wdkdYWEx3OTkrTTV5T3lM?=
 =?utf-8?B?SDZtS00vdk1zOEZpMldFVTYwdzBqSGQ0MUVzbVpGY0VoY0dsQzAxbTJxb2RF?=
 =?utf-8?B?VnlYYlJKakRBRTFCZEpnZTU0M2VXUmEzVXdqUlJ0VnF3YnJKcGszSkFUeXZj?=
 =?utf-8?B?dm5FOVdZdHJ5Qlg1ZGhlWDRhQmV4K3I2UU5vQmhhUFB0R1crMVlqYzk4eFVL?=
 =?utf-8?B?aU9EbzZUUmY4dWxTSFkvK3YxMitKazN3WTl6T0ZWTGFuU2lST0tIcEdKMXNT?=
 =?utf-8?B?WFoyOFBKR0Q1YTVvZzhkeCtYKysxVjVoRDJSNUluWExWRENHL1I2K1VaVGs4?=
 =?utf-8?B?eWVhQklXRlRQSVptQUcybkhabWY2ZXk4NHF6OGRzSVdDMXhLaFZIWXp3RnpI?=
 =?utf-8?B?MEg3UnVFWW12YWZTMktjOXN5NHhlbFhJd2pKK1hkY2dPMUVySGs5dVdIVFFi?=
 =?utf-8?B?NW9ZR2FlYnFwZjlySkg0cy80S1BMRGY4RFpjbTUrRTJSWTRQQzBvZ1ordDBT?=
 =?utf-8?B?ZW5Db2tZSjJJNGI2MnduNzV1ViszYlNGOTZvR1VTdTVtTjN3SHlMNHdkYy8v?=
 =?utf-8?B?UnFmek9mZTN3ektsZGhQUGxFcmwydXhXRFhnUEhHT1V3cVNjb3d4VTBmbGtx?=
 =?utf-8?B?U1VLSVR4ci80K2U3WVNid2hzd3hHeHducmJpdGo4RVBtMUFvVDBPRldCczMv?=
 =?utf-8?B?L1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	P22SCe9/71QxJ6tK4PatbKT/7N8XvEWzO2emXW/oShBKYuGbNZRWV0Cr2BdpgANMJT+CF4JD6SYmlYW1a5WQy2xx4i4UUrrsuDKQ3x/Efqi7GaQMxQzH/9TSe+z4JoSOG/mlHQB/yLOanGkxU23SSM1OFtFJAk+4PPTOF1nGYRDFxyuD6Go4/zxDHY1osKLJMxA0d9FI1yFDWYurM0v5RqNav3s3ExZrKIBf/Q84tDgz9FFCcyWYtWi/rUF/q149R+tZQCKNWf9SA/hOSwIW18k5BgHRBCJBLZrwaji7vtMH9xdzwltGIlzCA4dz6b7CcoajJgo+Qi5tB4x1ATueNANJvx+i39zvG6pZ684KJUGd5VfngmmnAnVb4AdeVnAAGIdIeWk8quvupMpAOsY/yCjbyj372h0UXHzly4x4js0N+2M2/aFY3B1kUo8doQcNlSYHfGzZAyEJqs8PXLhyA+GwC8KaFFA59K0go3+FnLCbnHm8cWHVpCHHIOfCWEK9rtWIAQKhcvIAyGn6n1IBfBXzc/yFjj+UBgBaOW97ySm+VbyvZA3lgAMx4eWZHg03hsdxO3D/hSxYvLEa6UrqQgAlIT02/rQVmvu0OteLzps=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40df6917-4078-4433-97dd-08dd9d53d096
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 19:22:26.5366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b5XmoTYIHgA6XIQTf8AkvmN2538pnrf0hCEnHxkOQehdqPLUVBeefWvqcyqAaM/bQ6PaWg1To9WpXHsQbYh48hdBCvdosj9bLTUVCewlzZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5650
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_09,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505270161
X-Proofpoint-ORIG-GUID: ptMxL7ZDNYWn2T97_tmTjHY0-Fp-G81v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDE2MSBTYWx0ZWRfX3aFSCq+q3b2F n32cislOGv7zJQOG7gmB0DNHlpoXVhTnf5VKjL7OiaqbZIp6diK9N8mmy3yLJyg7VHK6U8zuS4n u2r+PdzvQxg8XHecm71Tf5xnHAhIXpcI7jIE50+r1YmBiZSnf3ndiOy3m6YM8lP70h2JktSx6b2
 KODnh9FCkm1XV+dJxHUZ0vqu+1/IHXZAXcylaON90uo2bEOhfuH7cfg552JRIjLr7ojIKesdzhO /VpaissnMk28DDFFls5nMfstx8UT7sn/4QQ9A9H30DQdo77aw9eE8/sGBSqKdWg5RpM1RKq7MyX UBwyFnoSGtkJEDPRR+t655g+gq0zjucEwiCAVusSrLCOe1KvVCtS4VqYOxuvpLKWfPiUS2a9Sgs
 7lvwGEcR/j8h4KvwujPkKMfQCjprGe3MYG5Yd65GN71Gbhq82F3MfPVfAxj5X5+/KxT4qdF6
X-Authority-Analysis: v=2.4 cv=UZNRSLSN c=1 sm=1 tr=0 ts=683610f7 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=rqC2BfB5JvzBrcP_kD8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 cc=ntf awl=host:14714
X-Proofpoint-GUID: ptMxL7ZDNYWn2T97_tmTjHY0-Fp-G81v



On 28-05-2025 00:42, David Hildenbrand wrote:
> 
>>   /*
>>    * Test if we could add memory without creating too much offline 
>> memory -
>> - * to avoid running OOM if memory is getting onlined deferred.
>> + * to avoid running OOM if memory is getting online deferred.
> 
> The system/user is onlining the memory, so the memory is getting "onlined"?
> 
> If it would be "getting online", wouldn't the memory start using the 
> internet or sth. like that? :D
> 
>>    */
>>   static bool virtio_mem_could_add_memory(struct virtio_mem *vm, 
>> uint64_t size)
>>   {
> 
> 

Thanks for the clarification—makes sense. I'll keep the original.

Thanks,
Alok
