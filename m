Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B819A1A6815
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 18:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786041059; cv=fail; b=ck8vu9IYTXg+LdZAN4VLWX2mFbizUbJ3wiRxHAsS4r5jlSWuSU+tDSMc45T0nTa1ZyknNInO4hBXDe8JGtZHQbEqLdZpwvOqZFZ1YPV2uHeVw9upAGCMN0FUNuW7JwKxuqkajNM5V73UcfX/zhqWJrGlbbxC3EfWaH2TsaBIpwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786041059; c=relaxed/simple;
	bh=UoLZZEE70PqJJmysOK6tyxKiihZi+YJuuE23h7MHMoc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SG1NRsJuKutfxWkMQg6yMtCBBXG2uQmrCFsViwPgHTzWVlJYJQHPaIOAZJU8LfsnnT3KOQz6j9uUCv/aec0uvQ8zbbKhQ2ma8+7rztR0ft6faNcn+ZIBdozO1xpsBX6TEy7ynmf8CSUB/kR9xMtcmh/eS+D/g1KlU9LV69foKtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UVE2GynE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lzYY1BBP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UVE2GynE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lzYY1BBP"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676Ftjha3283031;
	Thu, 6 Aug 2026 18:30:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ptypq3M/d9DnjnZlIJ4WU+NjSHuAYH4SjBNidS0fXkk=; b=
	UVE2GynEyC8ymf7M42u3Z4QFMKDjvWMna+ZRDSZzPblUAMMQ4Q7sROikikGOHNGN
	a+yil7aX5VyRVjr1gNGarZrTt2kcc93fW5cI4GBK8EsRc7XAeMaAyYn/UMKuprZv
	vaiqNWAHr03UZNn5p/AbzcDZRYZ2nhx6JzOl3kF7LrEvs8XdONBndJpJoOq70qki
	7kI6HqjAQyYfJUXHdwsaAohA/qls+PIKlxMR/3sElewiyEO6s3fSTVsjT3dmLp4D
	T8QzWiiSoFm1A9rsbRpwy6uZhm48+Qe/UVgwtGnBNZAxPd2u3x3l80eeUagEyoW9
	nn1FfocIbX8R+hnFX+FFcg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fs8p9e806-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Aug 2026 18:30:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 676IUmR4008047;
	Thu, 6 Aug 2026 18:30:54 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013030.outbound.protection.outlook.com [40.93.196.30])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fs78wuw9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 06 Aug 2026 18:30:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=urcxkaGx92GahJPI0npoY006Ei92vdrlDNYC0KWzI/6GUHcrh4IZQI/oXPHi1Lj0I3iQqEEt1Wnl88v0ND7SyhaQcsTtGRUvsMd7R0qlKEEXrwoGEAgtcGrM/M4UOkchRqMeYn5AS9JpLnAfAlrVL6oxk3Aa5GztarjuBelIs5jXpCSuV6adpxm4GCgX1QOP8XND6i0NjHkXjJGZM5OALQBe01TQmyAelsQbRFXJVW2bil/PeCY43UKrSemY36VHn8+pzGKV2iKVNTqdt1Ujw0jyc3HjIuiJG058IdqcH1bjLdx/NhZFxbxOTDcB95OPKeZ7hoGkC4oMlVW10wlbFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptypq3M/d9DnjnZlIJ4WU+NjSHuAYH4SjBNidS0fXkk=;
 b=c+NGUJoLNoKnJYd1VWCkc/VAZ+wTtf8dvpKU+Ezjkbhg6qMIVKaSkyuNouwLmwxJeQaNS8MyI3kz1bk4IGqM0jOmsb6LDx8y2hae2HU+upH3fqxpqrMiQ5pzAlNYZ8Cj3ZwxDK8Cqx60r/BzaXT+oGGOd2a7qOsbV0xnm3Hr1RlQJ1lZ1bOd/4G1jR+ZD53VKwoMflD2G3nJpfLXFNRaOn1KCQXuDdII/aNpjlAQ8HEJD67Mlna1KJ0SdmARtx+U7LIkCYVRk/LP6SfbFY9tY7uYQ1mkMGUREDoZuxZk1M24pav+2elaoeWKOZ4i2lQWvfTFIe1923fLktDceRu9aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptypq3M/d9DnjnZlIJ4WU+NjSHuAYH4SjBNidS0fXkk=;
 b=lzYY1BBPuB22zqc0l4aDIErUpZ5TM4pvHDwnbNPcWBnLU2Am0LpJnb5V20ycEPkJ8BjTReNA/QIh/5G/D8UEqWZJ7kL26PAVH5zMqe4sXP8t8eWIO9DKtFtpIdggAXEULpGVukay3/c8njjF3JvnKhs2aYotARvLenoh2Vym64o=
Received: from DM3PPF905D77450.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c37) by PH7PR10MB6249.namprd10.prod.outlook.com
 (2603:10b6:510:213::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Thu, 6 Aug
 2026 18:30:06 +0000
Received: from DM3PPF905D77450.namprd10.prod.outlook.com
 ([fe80::c70e:bb7e:7d68:be8f]) by DM3PPF905D77450.namprd10.prod.outlook.com
 ([fe80::c70e:bb7e:7d68:be8f%6]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 18:30:06 +0000
Message-ID: <ea4a8894-c4af-453e-8949-033ecf4443c1@oracle.com>
Date: Thu, 6 Aug 2026 13:30:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] vhost-scsi: use kvzalloc for vq array allocation
To: Dongli Zhang <dongli.zhang@oracle.com>, virtualization@lists.linux.dev
Cc: mst@redhat.com, jasowangio@gmail.com, pbonzini@redhat.com,
        stefanha@redhat.com, eperezma@redhat.com, kvm@vger.kernel.org,
        joe.jin@oracle.com
References: <20260802172534.260047-1-dongli.zhang@oracle.com>
 <20260802172534.260047-2-dongli.zhang@oracle.com>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20260802172534.260047-2-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS1P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:44c::6)
 To DM3PPF905D77450.namprd10.prod.outlook.com (2603:10b6:f:fc00::c37)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PPF905D77450:EE_|PH7PR10MB6249:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d57c4a9-5adf-466a-f62a-08def3e8bcd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|22082099003|18002099003|4143699003|10067099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	hCNmrci7hKyCHF3QSy88KrXWcBWwZCpXYBoOovYVJwpb6klxMhpneJX6lSlk+vy/pDAaLYwECrUesRkK29y1sOALlo8m6mXA6+EojG+8YOaLJRA48vmPZm3w9//7RlLVwXs6J2CjcXpf2caJHU/OgVVhboQclwXm0PQ3VsGl0Nw3ToaGVNMmAIHXKb5HsCSUpU4uLpX/92kFzswNGcQaWsg3j5H8FQxFle5+CyOB2RWrN0TIO7u18kcG+Oer0UOElYkorK37pyCX5aPPInuocfvR1lPMmKWAgHR+PKdGfxUvBz3UhaI2MmZfeqZQTBdE6MslJUw1OG4XOoZl+esfDAT1thpXCx/WAVZXKxuSxaR2YLT0DyF37VG/RqrmJOvO7pZnPHt0q0SXZO+SdFzJEP/T4h2zr1hJxdJ4+0njWCEohAXZKyrmjeatYn3G3Aghd6LnO9XBP3yJZ60ifz9w8akGJ6hk5s0ML6lOpxUl9Vm6VCmGwuLwRUdNzGT383IsgPOSY13KBRkcXUPxp3cSkikcYQtWtZ/QPcUzLLjF2B6smcYmuEMUQZBeff49dsHGLINtkozP12TnbYA0kvZHk8mnXZCNr8guc0tw7tIfuBuoILtdTdru2IzaNWiMQMSkcozO5uahag06XraZxnB7LtKAblFI9IWZ3nmL0PS41wE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF905D77450.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(4143699003)(10067099003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXFPaXRvazR3SldOYU94WWJCSXhRbXgvbUE4OFoxTytWblBRY0NDNnozRGJU?=
 =?utf-8?B?cXJ3S00xaWhYa2c0d2F2Rm9SMFU2OEpuM3JmSnJnWnBUT0hpVXZVLzhaN2NS?=
 =?utf-8?B?cThONTJ2alB1bzlHSzhRWWNSYWZWTXp2dnVpZW9xVDVQZjRSTVJRK0Fiakxi?=
 =?utf-8?B?eDg4aUd5dlBIU0VYb1Zyclp2SGJEUENlazNPa0R2bHpmMzkzM2dPZGcyQnRo?=
 =?utf-8?B?TWtIWEVveWpESE5rcXZpYTVsaU8yYzlpVGhZbUM3U2xOcmsxa2taV3d1a1Vy?=
 =?utf-8?B?U2x5UCtEb0FqTDJVZ0hiTWF6Q3pxUC82SUE3QWRJOFFaYUJqOHlHTjB5b0c2?=
 =?utf-8?B?UjZEdW81L3V0S0JEWTluRUQva2RHS1hCOTRZVHZCMU1tRi9ZVUlBcm16Y1M4?=
 =?utf-8?B?VXp5cU9VaXpNRy9yNGl6MlBmT3FkQ1JVYWFEWjd4YmNrWWt6YUcwTDZoYlhP?=
 =?utf-8?B?Z0c1QURpZC9DYURMSTI2VVF4N1R4b2E5NFhGV1RtTjF1Ky9LdXNFbkt4VG9B?=
 =?utf-8?B?L0NkUVZzYXNQREdZb3dEbm95SUxDS01DcWRYcHR0enJqTStad0owb3UrM3kr?=
 =?utf-8?B?dndQbThMUENQRG95TU40K2ZVNkhhTjA2RkJFNW5QWHg1dFdDMzNodGtkQ2c4?=
 =?utf-8?B?NmxZa2pPelo0Rk1hNUk1eGVKdG93UUNVZVVCd3N2WTc0b2pXQ1h6MHpzV1hV?=
 =?utf-8?B?VTRXa05aSmRsTUxCNE9JU1pRRVlyaDI0ZE8yb0h4U1djaHZzcjFiSUQ5YStH?=
 =?utf-8?B?NFVDcndlNDZBRXV0SGt2WjBaZ1UvUjlJbzB2NXVlU0d6bTAzUEYxY2RHQ1FG?=
 =?utf-8?B?ZDZlZFNadWtVRjYrQWlNRVl1Z1J2T0VoYVRmY2YxNWVrd1ZrOEdydno2WStu?=
 =?utf-8?B?L1JCSmU1ekNMRWhjMTFoZUJ1SGZ1UXZWYkN5NWFyUVVGeHJXNGdhbzVNL280?=
 =?utf-8?B?ZVQxcHlNWVZzQUd1ckc2cUxlTUR2SVFUdmFNcjFSSUVIU2YwR3hldFl0ckND?=
 =?utf-8?B?dnNlWnFzd201VWNucXBhOTh5dmkrWGVMTk5UNmVscFY5ZFlXbWU1UjVsY3Bz?=
 =?utf-8?B?YmR4SC9pYURZdlEwdFhpbndDSlVNRTRBUFRyaWV5RG55a0FDYkdObmlQenRY?=
 =?utf-8?B?UTFrbTM5ako3TVp0NlBPUWFnTE83eE1GWVVrN2E0dGY4S1hQdWtWUW9jM0l1?=
 =?utf-8?B?cGZmeFFXWUc3SXF1Yk5odTFydVdwSG5GdE5yQlUxMTVtRkFDaExLczYwM3Fv?=
 =?utf-8?B?aUI0bFZzREtkWUpSdytNVnEvbWVjNzlQcklXdTFrY2VwUVp5U0J1SXpTcFZ0?=
 =?utf-8?B?SWpxc3NKRUNoeWJPRk1aYkZ3L2VXMVlFdS9EeUNiWS9iNlZNMmQ1NkVuVW1G?=
 =?utf-8?B?Q1NGYXFkdWFCd2N1ZGp6a2wrUENvNWJ6Zk9Mc1NGbHVXU1diNmFvaUhtV2tx?=
 =?utf-8?B?dHNidjZRdWQ3YlZHazVmMXMxRG5LSnprcVU3aHlZUm5JQjNVSTZYK1VYKzhw?=
 =?utf-8?B?Q2dNdllqeDlFdXZIWi9zVTBVbHZKYXN1Qk54UVJsQkVDZG90MzBGUTJSM2Jh?=
 =?utf-8?B?UnFFN2F2M1huMHVOUTVSbTlMVGIzS1dTZDk3ZXFvc3c3RGJ5Z3ZoWFhFY01m?=
 =?utf-8?B?N1prVjFjcC9Wb05NbHNtcllIUUdpbEowTHhweGlST0l3THZGSlVZTFJOeVJD?=
 =?utf-8?B?aUhhRnptdm5JeVlPbzBROGRBNmY4Y3o1RnFBL0h3M1NWM0J5YlRPZzdoUmZZ?=
 =?utf-8?B?WkFPUmR4RFpmZGFBa2VpVUFxM2QzUlh5V0MvYnk2NTdlVWNPTzR0UW1zZmFZ?=
 =?utf-8?B?aUVEYTNiYXBoWjFzL2N1dXF0Wk4rWUFHMnZYeFh2aFhIclpoNDBSSUNRSUc3?=
 =?utf-8?B?WTJpb1dJYVgyOWVKN3BST2FtSGNyd2kvcFlvYVVSM0dCdnJZejhGQjY3Zlhn?=
 =?utf-8?B?L2p4aEJqVW1DbWlHU2Z0emlNQmZtQ2huTHFoNHpHYXoxcmdrdjNIUnNNNTZO?=
 =?utf-8?B?ekhBUk5jQm1DUnF5UlBBendJM3VYTU9iN3dlS1RtTFFGeHZJa3hMaDNGUi8r?=
 =?utf-8?B?dlBTUW5oZE41Q1hTMkVjR0lwVDBWNE1wZzJidHlFTVdaQStUWTlFUkVzU1RS?=
 =?utf-8?B?akdMNWxrUzlkRitCVHcyZDFQRCtBMVE3ci9MSHYwQmxydkdJV0syZWpJNmkx?=
 =?utf-8?B?WHNDV2M3dVFZdkZsc1FEUmtYT3l6WG9uVThrcndvY1hXQkpWakdLVzE2bE9a?=
 =?utf-8?B?aUY5cy9YLzVNNGMwdGkzYmEzaTgrSExnczlHYTM2dHZvSUkwc2l1ZFdRN1Ny?=
 =?utf-8?B?WitpTmhyRmhPcURGaVlBNkVMOW45cERNMGFWdmIxcTRtNmVVL1pUK1BzQWx5?=
 =?utf-8?Q?RbOk4N/LrcowApn0=3D?=
X-Exchange-RoutingPolicyChecked:
	rfLpnGJN+SZgTv4/QqlqshBwb034lt50/X+u4YSal3aX3lbm7sgPpe8sHJotS3RsW6Gm3lje82HnbkpKVOo41LP4yXcKsky16jbqni9fk8nqLkOFIBR/C6ql2ydKwgPDrhWBPsOqVxrHBLr797x1ns6XLnnYnbCfBbNbg6Q32BM+SHZDA+E/U9vCS4Iwx6F1Z2Z2eIrG/OJYOJPXc2Fdi+Hk8opPeQoBJyihKJVC9RG5LhvJTFIstCSl/mRk8i7SLgZQJqf8ohcvm/v4oz6sh/Cb6dMRqoGEpJMp3nBHLeQyjjLQe/z+pGBdbxsMEbtFBVAenoV7T9I3SeRqxDtYLg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iW/MCeFQdmC0X83Xid1EYygDCpIykpeAEmeeQhvq4HQ8Uhrf09dz940iyqKOSzpBWC6qQCPviA/s62kehQOt3r+6XNgJcAnIRf9L3avs5IzutUNmCh6bOTD4WX77WKe53e5UXQCto4qD2Mq4aFnj1S+BghqWC1CALn42RgDFMaZX201SV2KKZ5/8lyQ9/0n8dsKKgzbPZpZEqwFZ3ezKiqO4RxUF1tfl7N52m44eScGarstY+P5DOP31VmOWboLWmyTJnEPDNn+sFRZrZ8CFqx/pnKCuQh5Lzky7Jce+mEF1B7QVcPA3vcs1iWpHHSabzTgzD/32RDJreLHB99ipYaDtDT3aQ5gsNfLqo2EadtTSgcsyUwzTOw8zuPEP8MBjOapjx7YxfqPY4W0h3PF6ldXdn8DVb9PiJEojbXkKOt35ECbDMJ9ueA7tVHxfNY5SqTIYkoDunyhC2OVa89LgTQsg3doSn2fNYq/sK1AEYwMlKx4uCWIRAbAAKirPcqClpbGdF7lISUoxMwSs0zIU97OGAcvWdSxOi07siAiWeK01UA1ZQkYPxEUfs8vyBr46MQ9I8dsXkshXdoG1BuASyH1G3R6znD7TOM3xbKjykp4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d57c4a9-5adf-466a-f62a-08def3e8bcd3
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF905D77450.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 18:30:06.1464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJUFKxtahQGcDnU4PtTCAGRgbcreuOtzD1DmKl12ApHhtENct9zkN5viLaZ2nkVyf2tVajt9DH6ohyHPgtO58enqWeVsKLnEjDc+WWScQqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6249
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608060145
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE0NSBTYWx0ZWRfX5epztrIyC56N
 sFx/C9PA+djr+PdvZPRksLFZ1rCv9VD/Vq1zz4IfmILMEg/VXITzXn1jUKyaBD++RgN1bsFOXct
 SkttwnyJS1nvO5D0FEiegEheu+V7YhpXYE7EPrnLgrrpasqlK2Qs
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=6a74d2df b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8
 a=Vr8piCVtD0z7_d6nFjEA:9 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12100
X-Proofpoint-GUID: KSVdZXRmP0OqyOsg5-jdyzF4R1fRkRQa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE0NSBTYWx0ZWRfXzmV6LjPosSV9
 S94Cadvbj6VLjY8c1MPr5fMzFP+RWY3YLh1qHztmBoY0lR1EMI2Zz1FGtO5tssPIa5lai+8tgri
 rUZejQWHuqk/VjuPZMmLUbcMjzaCDq1HJUgkr2/Z1e8QMZjTS6lFgs8WRgc5qZ2JFN9jByl8nbP
 QViSTRJoxjXeMXpqawi7hgzwJfWD0jdZ71soaiKb0JB9jt/aMHj7QmPgrJY9J1fVIxlxQzCyOyv
 Bu0gZTjfkplveZRy/B5JS53Stfs12RUmQlHxDEw9e60E/D6nhsINjqliHO9nx/eopCnhtC/YTq+
 MIoutoH1MLjhkCQFdCEcgJMmm23LogIWUCZY5mLjLg0WdFr5SkRPFOY5HjA2dOP1+WDhQiorODj
 ouodSr76ZtUeDA8gPn3xCGRyIzdHuhWIRzA4Xj6TirOzs6uiTlYR4nTiS/NrBdsbsMCP3o7rj+9
 2p/zh3BWRRsvdJkPxvdkzUbg1F4j2y0M2iiytk8k=
X-Proofpoint-ORIG-GUID: KSVdZXRmP0OqyOsg5-jdyzF4R1fRkRQa

On 8/2/26 12:24 PM, Dongli Zhang wrote:
> vhost_scsi_open() allocates one "struct vhost_scsi_virtqueue" for each
> virtqueue. With large max_io_vqs values, this array can require a
> high-order contiguous allocation and trigger a page allocator warning.
> 
> hv# cat /sys/module/vhost_scsi/parameters/max_io_vqs
> 256
> 
> [  766.075787] ------------[ cut here ]------------
> [  766.077030] WARNING: mm/page_alloc.c:5280 at __alloc_frozen_pages_noprof+0x32c/0x15c0, CPU#23: qemu-system-x86/5964
> ... ...
> [  766.080351] RIP: 0010:__alloc_frozen_pages_noprof+0x32c/0x15c0
> ... ...
> [  766.085813] Call Trace:
> [  766.085969]  <TASK>
> [  766.086098]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  766.086365]  ? context_struct_compute_av+0x38a/0x4b0
> [  766.086652]  alloc_pages_mpol+0x9f/0x170
> [  766.086883]  ___kmalloc_large_node+0xb6/0xd0
> [  766.087124]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  766.087389]  __kmalloc_large_node_noprof+0x18/0xa0
> [  766.087655]  __kmalloc_noprof+0x3a0/0x440
> [  766.087877]  ? vhost_scsi_open+0xcb/0x2d0 [vhost_scsi]
> [  766.088162]  vhost_scsi_open+0xcb/0x2d0 [vhost_scsi]
> [  766.088449]  misc_open+0x123/0x160
> [  766.088679]  chrdev_open+0xb1/0x230
> [  766.088885]  ? __pfx_chrdev_open+0x10/0x10
> [  766.089157]  do_dentry_open+0x11a/0x470
> [  766.089389]  vfs_open+0x29/0xf0
> [  766.089596]  path_openat+0x7c0/0x1100
> [  766.089821]  do_file_open+0xdd/0x190
> [  766.090032]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  766.090332]  do_sys_openat2+0x7e/0x100
> [  766.090601]  __x64_sys_openat+0x51/0xa0
> [  766.090857]  do_syscall_64+0xfe/0x590
> [  766.091087]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [  766.091411] RIP: 0033:0x7f9525a11fa6
> 
> The array does not require physical contiguity, so allocate it with
> kvzalloc_objs() and free it with kvfree().
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Mike Christie <michael.christie@oracle.com>
