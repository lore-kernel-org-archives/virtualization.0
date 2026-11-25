Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795593637;
	b=dcSHE5W1GLzeNt+usKgudI1yKkSzEC9E/yUU3BklEeeAt5BSHiSuc+DWfPVNnL+0afXH
	 xjHUaZhwPduBR0o6vx9g0jBZt+vX6HqOLNDxFmCGICqqXu3/OVVyUJTdIKzKpDEbsDTEr
	 P3WjATAbz3ujzaee39LuhicRdBSktMCD/NaGCBn/+RdFoA5dwzwspovyrk1OWWmvCBbtH
	 VONAcXhg/NBQzpjJFLsec9aAC2nGFwG/pKp7xCee2W36gogvQfwf/4Ovz6hCOFvrN1eno
	 wafw/QjbCBQpaCj/kGxPMPASga/fwijZbb9ihQ8+2gVORidtRzzuWArEvqs/oTcmUtQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795593637;
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
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID;
	bh=DJAjuR9Ddptq1yv110AU5Zl7qzAx0bswcFmdZSdgH+4=;
	b=wE0Nzu6ahZRqTxV/uc6BsLrNLKeKb1wvYoCvwb7mQlEAM3HsbP6XTbsDhIYjwDT7paDQ
	 7b5C89bHmpe9F9mRIo2inzpxbHdD05gmImGS/4QtDKgLX3XhGdXvnwpObojH1vhodP3hR
	 pfB2aXnpVWj6cN6Pthz1A9jDAJFzTbS8BJLcd1s0ILNYqhwjsEu6KQUvSg56ZliiJ8j1E
	 NChkRi/t1xLT8hYByvTO0E++CLg7fxgPSu2P9nI28rXxq0CgfK0IDay72aefh5dfVHWsG
	 XzWKRBgthiqLW4523sj/89OMsskMZAbAymF2+gDF6FVqlSnxroe6PTQhEg6Vs/FPAhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2026-11-19 header.b=Mm7BfpIr;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=GWAe6Hic;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DD8606A31E
	for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 08:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74DD8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2026-11-19 header.b=Mm7BfpIr;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=GWAe6Hic
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP5utNB1050111;
	Wed, 25 Nov 2026 08:00:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2026-11-19; bh=DJAjuR9Ddptq1yv110AU5Zl7qzAx0bswcFmdZSdgH+4=; b=
	Mm7BfpIrw7JSkcKlc6fInzH0c+6f6T8Tb6TQgBPdgQkuZ4NqSv/nmmSapMOSRz7Q
	4I6j3fUOlVTeQyIKlSYyhyX+7nTTzWgNQKp8J/+t9MzMlp5Xp12fCxGoDG8OA2Yj
	7wgR7VL76ka0en0omKteH5qHM0wBpRv3v2eWQJVk8OEG/fAMj/Vbz6MLsedaBlnL
	3LTqTgAaIJrYxDaA3kLEMejxG9rEEznFGhXQyH5FvtxaI1PFCrZQ1P+PiyLa0qA7
	3iA4ZyXhg4+0QIYVdyizMwCTSdzp/bULIz8f92y2YcDH2fEPBnqRcjhG+XW/oAXC
	m9ScyngJyiAnveEo4G3oqg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4j34r6wfe7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Wed, 25 Nov 2026 08:00:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP6943h1753891;
	Wed, 25 Nov 2026 08:00:27 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010001.outbound.protection.outlook.com [52.101.46.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4j5ss2mamc-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Wed, 25 Nov 2026 08:00:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzyFzgiYx8KWA4QXTZhkjh6Dthmz04IiLshDlu0VKusnAr7r+knivpXfrDCIGFY8m93ef2lEUXdD1GcV3u9t8DXPvfUjCWWgSPOObIDD5rFfypVIHkmlDxBmw1YY8b575Yn6ORrnhnw9oSHISPiNTttt0cVa3kfeJ/Z1IGhrNaZlC9CKaukAuMGt609WQpwHVPkwhMxV2ixDziBEugjf7lthXM9sJmeQLGbhBaEfkfI0biypr5Lre7Pq5l8IbY5wHfM+FzX4E8OUnDVgVfPiuAHRHIS1PHoX/+bbGNQilAlP9fmMRUNatIRWRwpntxuQnJsJZS7Yb/CPqOQha6y4Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJAjuR9Ddptq1yv110AU5Zl7qzAx0bswcFmdZSdgH+4=;
 b=uiQXWt1R1G/77SAPFIs7j7jfNbvgbvYQwZfZ/0kzRVoRUAQnNteXiqo/plW7de6FNEPQZElnsa4MTkw3ZhOY6zokBGX+B6bmceQadDZy181c4h8L2zfg3YjQ9XrYvvqHJHoQtrxK/EGYTgDOEhva0yoPOMa9yKVcvBee7wKF2qC80q+WEHUisTvvySLdKKpMNxg4HIbtHcW2cJjaZsN1DgP9BJEOF4lAKCIcdvn0J/zeum6ZcdGSrJlJEBqmASYycXzY+HK4DoIluf2z4q+gNmV/ZDzCkQn0eHDYfcE+Piqpdr4xyVz/W1A1iWaZuXVGM1XhCV9cbyFXPbLjFnDPcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJAjuR9Ddptq1yv110AU5Zl7qzAx0bswcFmdZSdgH+4=;
 b=GWAe6HiclVuTh73Jh9WFHSRju8bzYOMI994GYwfz4v4Y/nU/hWstlnZOG1BH0mWgyYRxsreP1j0APaVPtMmn+72Yvy9tOJVv9tloYAa3f4xhwNm1XirVOsQFIMabU6kVsbnpwW5uVKqVjT2+OEhhdwW0vHvmamQyHXbiOWDX61o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4261.namprd10.prod.outlook.com (2603:10b6:610:7d::23)
 by DM3PPF9E376D9DC.namprd10.prod.outlook.com (2603:10b6:f:fc00::c3a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Wed, 25 Nov
 2026 08:00:24 +0000
Received: from CH2PR10MB4261.namprd10.prod.outlook.com
 ([fe80::fd17:1c07:31b4:a8aa]) by CH2PR10MB4261.namprd10.prod.outlook.com
 ([fe80::fd17:1c07:31b4:a8aa%6]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 08:00:23 +0000
Message-ID: <8dd10839-ea0d-4db8-b1b7-e033ee8fc675@oracle.com>
Date: Wed, 25 Nov 2026 00:00:21 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_pci: limit Oracle DSC2-200 virtio-net to 48-bit
 DMA
To: Vlad Poenaru <vlad.wing@gmail.com>,
        "Michael S . Tsirkin"
 <mst@redhat.com>,
        Jonah Palmer <jonah.palmer@oracle.com>
Cc: Jason Wang <jasowangio@gmail.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Brett Creeley <brett.creeley@amd.com>, Kyle McMartin <jkkm@meta.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
References: <20261109184253.531677-1-vlad.wing@gmail.com>
 <20261119200654.1048266-1-vlad.wing@gmail.com>
 <20261119181557-mutt-send-email-mst@kernel.org>
 <20261120171435.83458-1-jonah.palmer@oracle.com>
 <20261120123500-mutt-send-email-mst@kernel.org>
 <b8ff5bab-d08f-42b8-9c88-e4665ea3078c@oracle.com>
 <20261121063742-mutt-send-email-mst@kernel.org>
 <20261124121030.38490-1-vlad.wing@gmail.com>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20261124121030.38490-1-vlad.wing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::17) To CH2PR10MB4261.namprd10.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CH2PR10MB4261:EE_|DM3PPF9E376D9DC:EE_
X-MS-Office365-Filtering-Correlation-Id: a23a0d4b-bb0f-44d7-1ce3-08df4aca2872
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|42112799006|261026140227099003|10067099003|4143699003|56012099006|261021121427099003|261102123227099003|261028144727099003|261022105027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 Mhwf3pOJKc6f9r9mqLbzgQbqD1eQokJ2XeH2maBL5HK3/eLQKVSXWQapalJeXZ95lL9xcDF6Ty2Cc130Z298LOjW7db8tRnRvMIeH9iva6pfNLnvROEpLVxL8gLgyyGZWEbQ+vagBD3jCyeYIRkimEHm8aeMD8EhramXCgQkLrzaE4R5SUzTFKX/1y7D9HH0CCMVJ93Aig4w5yqIaxlqxv8L534l1mPEWhIsJt9xyW5GPNteQOKbLIRjvVGmA/V8mYOEycMjZTfshGS/LDZXdYOuym++UD0Tu6i7KjXrpXt+qP3A0xNVX9J6FDExerW49yLQFNRIP0H/nCum+Em8DNOzBHO30hkrF1Upk1zRZ9Nrq70Hh/VS32z1hjlBd1q49+FwkCCUkFI+0VvEYmCghiM2gQnbaOXJn6ElKjsRhRjHArBZCH6HTQ2sHXp/INtrGl/8cHQYB3AoWEDSOP/1JTtkA1gGFzCC2yp6U7dwZtHepfh13g7G8CtV1ahNX5LRDyqAP+KBDz49hGB4G/lIipRScsAF6SzFtq1oY4drgmXuHxDPvbHEX8hfTkrqSX69z/ofy/2Fif4kSpkXNIyl9MvGu1wWlYjUYDL90Ld4zllb2WXPBcR1zJ62c0ASQKa81RS/ncel2AUxvel/EM2sqtoNaR3giNZ9RRAFt3ttop0=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4261.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(42112799006)(261026140227099003)(10067099003)(4143699003)(56012099006)(261021121427099003)(261102123227099003)(261028144727099003)(261022105027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aDdiNVFicDRtc3JPOVNMSjhqSHRXSVQ5RVhWS0I5Nm0rQzJEQWlKaGM4Q0I1?=
 =?utf-8?B?M2dGeUhReDlaN2ZzNGhVbFFYai95ZTNueGJac2gramQ3Y3pkZzlSQldRRTVa?=
 =?utf-8?B?VUUwSDc1TE5KNFVQcFdYZXhwdE5iNTE4YUw5cXVjY01TRjFmeEVvRktuU0la?=
 =?utf-8?B?eC9ObnhGdWowWCtoQ2t3dXNkRVAwK0p5NnFxZ3Z0RHNwREVrSVRnUmVxNHZx?=
 =?utf-8?B?SmxvNTAwODdoM0pxRzdieHdCcUhqaWdDSE1PM2tVUHFIa0tpZTJ3cXRra1F4?=
 =?utf-8?B?UVZpVnNqelNVd2Mya1VnR1UybmVIM3hSNWkyUUlWWG9GNlUyeE1MZFBGWk96?=
 =?utf-8?B?SkIrOTVMTS9ZRjRCVER2cnY3WEtHZ3Rta2ZhNlFrNEg4WUR0MzNwaCttQXli?=
 =?utf-8?B?ODNYczBzQi9UR2gwVDFlV1V1NTc3eE5Wa1lGWDc4VWhUWjlTTDIvazVKOWJK?=
 =?utf-8?B?UEZ3bzRmUjhJZXpzNkUzcXBOTnp3Q0M5ek41bnR6TS9UcGlrODF6Q0tNMnpr?=
 =?utf-8?B?QWVsMlNJNk10cER3VlBqVFFFOXNYMEtoRlV1L0VOME81bEkzdmVsMUY0SjBH?=
 =?utf-8?B?dlJPaHp0RGFGa1JqdkxUS3pFWWE1Z1ZJa0dwb3IyS3lBOThnZGJXNU9tbXlk?=
 =?utf-8?B?elF1R3piQ3U3MHFYZkJsQTJ3bFd1UTBUckdyWnNZeDNHaWlNcnFwNFdJamtE?=
 =?utf-8?B?Q2s3dWpLdmJYS0hycXdoRHpsbHpldVFmOXFDa0VmTkFMUnRHdkJOMmI2ZE5j?=
 =?utf-8?B?YUp3VDN2aTJldGE5L1A1emt0Mi9Lc3locEFpUEVqQjl5dy9udWg5TFRRSWZv?=
 =?utf-8?B?b1VnOVpIMnBZbVpneURHSDNlTjJ4ditKdXhXekRscXdUbGlXK0p4L0trL0Uy?=
 =?utf-8?B?MDZNMnBtWDVjMnZkQkQ0bE16S3A4VTNrcUhZVitPNDdxSGk0dGdBMVlTMGxy?=
 =?utf-8?B?L0pUTUVIMDhlMVZ5eUU2Nk5EdGN1ZkhRWnZSbTlYd0RmN3BlMjNTbk9VSm9z?=
 =?utf-8?B?aG93WkVhQkIxMVhLMy8xaURvdW1LTlpHdUpweUc3dFBmZ1lKRXZmeFRnbHpX?=
 =?utf-8?B?VXFKdWI3aWR6TFB4WlRQYkVFVVJUckVIUEcxNGpmMVVPSWlOZUpzRTR6eFZr?=
 =?utf-8?B?TG5QdE1hMFozQit4REVlUjBHMDgyblN0MkpIa2dqbmNsVU1ETEhHQWVZZ0Zl?=
 =?utf-8?B?NXNhbHZGdFpVM0FQd2FiQzV5dDBvOWM1ZnJjMWZReTFkWHNySkVCQUdGMGlS?=
 =?utf-8?B?aW9DUjJsZm50bW1MZ04vL0tIK0ZKS3JCSXk4cUNUaU1UT1BoKzBBZ0VZQ210?=
 =?utf-8?B?eHFvc2RzcHR1MTlxbSs2SklVNVhONHlEcHNQT2VWcGNZcENGN3NSRytaYUhx?=
 =?utf-8?B?Y0cvbGlILzF0TkN0NndGSks3bXJBTFFRYVFzbnhXQUJ5R0kyeUg0VzRkTTNn?=
 =?utf-8?B?TXZMLzZ3VmR1ZHBEb2lhSU5FUjVsN1lMTWpEbDdKMFRFYXNrR2dnYUtvVmx6?=
 =?utf-8?B?bDVUbHdoeENKUmxDdVl4akpZVHI2OGNwQnM0bEQ3WDIzcmRMZ3NERVhaellG?=
 =?utf-8?B?NS9MZTBOZjUrZE5OVkYwQkRJenZJd0hvOHQvSzA4Sk4veVA4OFBLYjFaS08r?=
 =?utf-8?B?SGEvQTI0N3JlQUpJQUo2OTZwNm1yb1V5L3pzaVZkUUhtZCtzWTdCMkowNTgv?=
 =?utf-8?B?SVdDdUhlOHB4SVpNeVFoYkkxTW1KWUFnY3VXRlNORDNMd2xYL2huVlZwVks2?=
 =?utf-8?B?Sm44ZTZoVFBqUW5KOXRqZVdSWEZKYzdDS3c0cTRSbjFCcVhqNGlvS0JXeXNF?=
 =?utf-8?B?ZG5VQU1hRWtad2wySVN4bUtqQVI1ZzhyOVd0cmk0elJBeklLempYTzlOQnM5?=
 =?utf-8?B?ZFEvdkkvMEtpSTNvaHFSOVFoVTNLcXBVTjBFT0ozeGZEOFNaRElJN3hEa3Br?=
 =?utf-8?B?djd2d0wrZ3lKMWdWNWpURXk1S0tKV0JJVzc3dnhMa3NMVDNTQ0pPRE40V2pu?=
 =?utf-8?B?Q2VOSVdJcjlLaWRtMS9wakNMMCthM3JjZ0orQTNrNC96Q0F6bVhvR2Ftd2dG?=
 =?utf-8?B?dHhFM25IdzVKYjRJa1k3SDRjQmR6eGpUVlh4bEduaDAzWGp0STJ3L2I5aWI5?=
 =?utf-8?B?bVNSYldVdHRoc1VKcW1VbjJQY0ErMCtFZTZMR2RLeVNyQ0Z6eVFJcDdEV1Bk?=
 =?utf-8?B?WjJrc3VHWHlZckJLdTROVzFXR1dNakR5Ym5Mc1V2NUZMTHE1OVAzWkdBblBO?=
 =?utf-8?B?VytYZWV4K2JmcUJ1WVNGZ3NuNjdZV3lUVjA4OUQrYUErejFpUm8xUis2OHU4?=
 =?utf-8?B?SU8xRFprL1Q0R1dIV3hnMWFycDZSMmRWTnJ4MHE1and1RTQvUStQZz09?=
X-Exchange-RoutingPolicyChecked:
	Uf6CkBTkfIKgj1PUIgxB3Hcqn6tUxOY3Kb+zrGDq9EOa3WZtazEdyB2NVObJ+22EoROYamIlv54C+TF7UJ5SAQUXE6E2TXZncfP8ckaJUcy3oxOw4W/8XIRtxsWDEuMRjfdaaKyMzuA656EliN5w3jAuCeI6sXuHHh3V0N3FiSGBU2P84Weu8Doy0qgHG5fZbVLVqdLCCJXy3fwfhgYyoB4G/Sd+WEZOp9TYUS9HtafLbtngCyZp1PcsRcTOQXyI9moIJTW6ktvlbu4KT/+tm4vV41vx7gKt8i5WUYRQm3zl8OV6IctqQLPlVAAuYsajEJ/rFMXL15qFdMZ0iGTLMA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qh2YjaMW8LV08qRbwz1nURoxUcHCkEuPWdE/BAfQ9dQvGMjm2R7rS2DfSPA5e8smEhI+cdfPh7PI3r/+z1Lpw424eam64FpIMqAsTCvzBKAh8w5QOWEltEEBWw7d37I7jSZlyt9Qc7/stUXtDeEmn3KVljyBwxh7Stv3PSd4Xekez7FMMzErc5PtYI1C6xPVlzEnUjz+4P9jEO77PPWPTLTl/PAg6XWVWEtkBopyDLquySZjDYqrcGLOGQoKyzqCkrD4RIGQZFrK4INrQpYD7dZiYLi01bxWQCBRSaqQ0C3DMOrh426aj5zLFcXCCwWG2BseTwnIHELMH0/8fplTA+5cwRrJp0Qv4wNRGFwczoXsqMaZdtXM8YMKXt0Zd+a3g30Ff2LNeM6PHkE09kCK78DieW6tfFjpLBiaflnbSCbiDc/NWXtxHcFhOdkbgA3IjMtwd5P2PM7jWGh9Sq5u3rUce75ggEWxljeuIZo2PI+lRtBBE8uyWiXJPv0mSCz2LrG4kEBLOvDLCoK2SBfTdZ+hafmFTN3u2ui6jQNsb4iTZ9XUNMhjpO/7pAcumVl8KIDA8X8c1T4CGKjC+hDvaKMV+st1MvtjT9Q0POICz/4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a23a0d4b-bb0f-44d7-1ce3-08df4aca2872
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4261.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 08:00:23.6881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRY6AC7Wh6m5M5USV5Jb6zUlPEZ3Eewq57mdw+zWGGJrc387UZxaSq+klSfTSa6YVHsOSFuxtanKB9g0sOJWHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF9E376D9DC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250031
X-Authority-Analysis: v=2.4 cv=M5bYuCws c=1 sm=1 tr=0 ts=6b06959c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=6SfCAxDf1x9aMzmd3kwA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12101
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAzMSBTYWx0ZWRfXxggnBlEsJfZK
 chsJbjx/W98X8vBFUI6iNBcXbsoxaztjbrC8AW87501sxrWxroHMkelmMEgMEWxEMvTo649Lv6T
 kRbJJDVfV10Hg5tJfEsYazi7+Xk1siaZ9k9utXFv1OOkJq0qI7dYg0qc/KHu10jNVMW9GATRVgO
 kuSY0knuUXysO7MS9ybYG5eZZbROwCXgsQiA93inFfScaViWlB1DXYooK+pTcJ3cuH/dDGwPPU9
 Yb0mxPq/oGzr6sTjcWxBDXzMzg5vHb8kiQB8fKQcY8uw4sTBUG/XJS3QR6UIEHf+yeEUqWPSZFp
 G3MdIxlVVabpNKtToZxvRe/T4XN+HkD6ZKDOPU9Du5VImhjIf5SLqu1RW9KcUvo6gfH37jIOvot
 odHaUl2TzRPPZHrTo0Opvdv3ckETXJ8Wg7HjzL+IKeIvU7DvDE0YWL1zgh5xZ3/3ubdtUA1yPBd
 BxS4LROy+jzh8XkZn1tZZrtPe0sDRtaMSvGY5fCg=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAzMSBTYWx0ZWRfXx03bRVwUuNRH
 Yw3Agvw7rMg8lyKSZ6TaQaWjZW2ogwivOa1LiN/FAAaU6rKo61rkHJEc2WiGmxVsXQoHMA6JEHS
 fZHqF55n4vUDo/rLtVjhCUuwxZvOGE3dsZ32LNqoIrW58ROwZ5mQ
X-Proofpoint-ORIG-GUID: D-_9EJ3KHbr9l2ziMu7HNce-rxJGvdss
X-Proofpoint-GUID: D-_9EJ3KHbr9l2ziMu7HNce-rxJGvdss



On 11/24/2026 4:10 AM, Vlad Poenaru wrote:
> Jonah, Si-Wei: will the fixed firmware be visible from the PCI side,
> for example as a new revision ID or subsystem device ID?
Nope, the fix will remain on the same revision ID or subsystem device 
ID. It was purely a firmware (software) bug that prevented the full 
52bit access, which the hardware device should allow.

Regards,
-Siwei


> If so, a
> follow-up can limit the quirk to the old firmware and give fixed
> devices the full mask.
>
> Thanks,
> Vlad

