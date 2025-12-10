Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B472EE608
	for <virtualization@lists.linux.dev>; Wed, 10 Dec 2025 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765393824; cv=fail; b=nQB8u57OYrjizpW6Anc98iC1nDO2nJxAqGSIfODXA4PPlyj6HsJ+VQRnNroVX7RPJlOugbznMPtGO1w15vLxrqgURiTFvlazkD0NNAJW1KClLdvnkRHLAz9gzlKDRC4ecZwJ+Mx3ZtDHKOOzVeh6dzSxTzP1akkl8GriYhkqtP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765393824; c=relaxed/simple;
	bh=ksKEEKKJ+wF3jy3D+6YY0rz3FxWeWqM+SvXeWN3deuQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qb2TQP7hFMAxVstkYVSva4xBehmQWmeMonZS0n6p4LCxUd4GoDuAU98fPMIT6KO46LlbisSrZDPPhzxjGThQmPb2hjzPKHra6Jz8B+hfeFgr0OP5MSHlG0Us2rnGPhYY4hwM53WyPYiQWVeV9aVwxUKPaVokPplHuNV7HhQV1jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=q17p6tAD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t1bQF9pi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q17p6tAD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t1bQF9pi"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BAIY7DN3758034;
	Wed, 10 Dec 2025 19:10:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1HVg0An5ooidimsNIVvbJNu8CHcKwFwIGz71p57bb1I=; b=
	q17p6tAD81rmzVlPXx5TFTepY0k9DOCNtttZ/9Bq1y4t7PGvCm2Rwl/l/33SBC4F
	xZ/o0jP1h4dyfR98qud2ZqibCWVbVMzShIZIcQLGLPPGS8ljVMcbf1uFNScY5N3+
	WkYnGsUtmkR2KCmCXUGKdAslTQYFPWYr6+DCvzoX3iFcq6wdKFMcG1rNHyEwvFRl
	wNotDuB3cCdtBO5dFHgTN6V5xxNplvSA4zT90qXWLHnJQdik+iuCvui8DUvizA9J
	GgY3/V+bGt+Cj5jW6S+gQTIJm2G1D5yiZ+5bvYYKgWZS/55/kEh7DQzC0QhivUqD
	De8PH2vd5lsZsnXvD8OPgQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aybqv0bw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 19:10:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAJ7WU1038504;
	Wed, 10 Dec 2025 19:10:08 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4avaxaw5vr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 19:10:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHmMtWCYI5TiocMDqkDcF5qVf7vK/uhDIG1PdktlKoxwjD+kk5Y8iJgi4Nk4b32F4Ffgjx4fS/BR7s+Oreu3gmebwHBFLQGThtiuN0jcW0rX71/5KkQRULTpResEp9qD/+GqBPwL8kwVMvTN4vY+z0iHE8q+aRakqsaKSzuy7mHx50Rr9xXI3Sw6+p0c8YKfvJTK0FdH6RwKNc+3gdiuGfXFJ1xZEGzY/zaxRmDBGUEbHrIrCho8/JSEzndzJU5K54Ys1SBpEe7fbRfuZ1ItaWrd0W5aUjiJO7wxPIGbjkVLIqIAiivbFrrhNjXUHnUNkFXl+Kg51FZHE24XCxIWhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HVg0An5ooidimsNIVvbJNu8CHcKwFwIGz71p57bb1I=;
 b=wEBexUTMc7WGkEDogkmvbig6Wbq65BcqTF3Quvui5HKp3AlJBj0hH7UUAYHHPBsdOrh2sA1XjH8X7wFHrigFGQDHMXxgDdpJPj858zA7hzwOZJGG8vaCpVRkskEU7kBnn1zw3Jir0puAWBGzvN3fMO3A3WgSJ+PnWP5ZE75lJZRY+0f+63HMSsMIaFHJts2cHuOC/SN1S/CLjCB7HBfV9I3XPOSAHrLzc7TDsKfTgHOsNgN63qM7UP2uPeG0E3j2oVsz9nEBn12PVBvMwf+KnUhb62+Rs4w8t56spmuet3nR08S5X8NhHmuIZkOuUAWbZk04C3ZALFAdro5hl7h5gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HVg0An5ooidimsNIVvbJNu8CHcKwFwIGz71p57bb1I=;
 b=t1bQF9piLCKL1Xb6O5sHeAfbb7tN4qxxfFATKYUsWHO2JKIe1Eb5ef3Xb9pqE1ejh8XDphQL2gGBXbi0UOMT1esdfaF9DWdRvJ2QImxYXgnR3t2RRtNcVMSVvDIhT6r7VpPZcP1pz2t1M9aorj2Nvyif0erS6CzerMR3QW7TvAI=
Received: from DS7PR10MB7129.namprd10.prod.outlook.com (2603:10b6:8:e6::5) by
 PH7PR10MB6083.namprd10.prod.outlook.com (2603:10b6:510:1f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Wed, 10 Dec
 2025 19:10:05 +0000
Received: from DS7PR10MB7129.namprd10.prod.outlook.com
 ([fe80::721c:7e49:d8c5:799c]) by DS7PR10MB7129.namprd10.prod.outlook.com
 ([fe80::721c:7e49:d8c5:799c%3]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 19:10:05 +0000
Message-ID: <38ef7c75-195a-4145-bf35-3955aea8dd0d@oracle.com>
Date: Wed, 10 Dec 2025 11:10:02 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] virtio_balloon: do not set pr_dev_info.report
 unconditionally
To: "David Hildenbrand (Red Hat)" <david@kernel.org>,
        virtualization@lists.linux.dev
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
        linux-kernel@vger.kernel.org
References: <20251209212311.64885-1-dongli.zhang@oracle.com>
 <0d9f302a-301c-4335-9c78-bcccab824a9f@kernel.org>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <0d9f302a-301c-4335-9c78-bcccab824a9f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0362.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::7) To DS7PR10MB7129.namprd10.prod.outlook.com
 (2603:10b6:8:e6::5)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB7129:EE_|PH7PR10MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: 63c9a2c6-86f8-49cc-d2a9-08de381fba46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVFmV09jV3l1OThTeUp1VFl6eFNqbzlsWVlaNE9kZXZ6N25sdjBnZUhHUXdT?=
 =?utf-8?B?WHZCQUpaaG9DY3NXdkYxVTNXVHBuT2k4MitvVDlFWGJMZy95S3pBbmJNNU0x?=
 =?utf-8?B?ZWcxZ1MrVWJYRzg3YU1DZDVOOGYzWjY5VVNFN2NZY1lVenpta0lncTJna1I3?=
 =?utf-8?B?NERScCtGYTJLV0VnMVdYaWFqSGxhdjhrWC81a0QwR2FuQzFVdzZVSEtET1Vj?=
 =?utf-8?B?bDloSlFqdlptZnQrTm9aZ1pwSDdneVNhcjZUN0pZVUZoMFZQOUdSSG1kbThj?=
 =?utf-8?B?QVNWcm9hcmp4a0VycVdROERPSWttMmpVNjZuN3NTY3MzQkgrRFQ3R21HR25o?=
 =?utf-8?B?Wkh1cnovSTNZQjA3b05sRHRiMXR2K2h6R3g5ZTdjdDluemNiUHVtRlF5bkVV?=
 =?utf-8?B?cHp1aUdITG0rQ2FsdHY4dHN1SWNQTFBSQVpUeU5uQ2RFODZSTVlhblJjQnpi?=
 =?utf-8?B?ZHR5a1dJYmd6MHBES1RwenFzZWtDTHNnUk12ZHI5QzZBd0VhbmtEWjJLMThH?=
 =?utf-8?B?T1JQN0NDeTFFcWRORzVPU0t4OEF3b21nKzNoa3dPQU1wOFBieDRsenhmRUxN?=
 =?utf-8?B?bkh6NlpOWDNaVktQOExkT2lEZzlqbm84SVkvb0x6YWtmNVpib0FMbGU3ZlVW?=
 =?utf-8?B?NFhRanpKdE1uc2ErOEt4WE4xUWZ6K01sdUo3c04xT0Q2aGNIWU5HZHF6b0Fs?=
 =?utf-8?B?cVFObVBxNlErN2YraC9OYllEdVpscmxtSjNLSG1WSU5jbldjaThDblkzYTVI?=
 =?utf-8?B?YU9oZ0oxMXhlZnBHUUlKV0R0VzVOZldDSFMxVS9CdTB1SHFEblhBb0lOakls?=
 =?utf-8?B?QnNiR0RPS043YjRjRHZGMlQ3T0JNS1lCd2c3Y3l5bGhzY0oycndDNEJraXdr?=
 =?utf-8?B?SkNxRElHdTY0Rk5JSTZVY1dOK25XbVprRHAram5BeGhVRGZxaXpoQ0xlb2d6?=
 =?utf-8?B?eVQrRWFFbnpLNWZLSnJkM1ZoNTFhT1o5V0lPd3RYS3NaNEY3MGNQU3phL3Rk?=
 =?utf-8?B?TUhISFhHRWR4ZWF4ekI2M3c0dEEwUFpURXl2UVIvclJwQWJiZGpuVXFHVkFn?=
 =?utf-8?B?cEt4bkRReXhHRzI5T3ZKMDRxRlpuNldod0FzQXh0S3VraFhjVTFja1Z1Z2lJ?=
 =?utf-8?B?K0JSNkYyS2dhZGJ5SUNBckdjYWgvLzFXK2lTSTBzdDhTcUk1ZEp6dkUwZmVo?=
 =?utf-8?B?ODVPZ2JYOGk5ZEl6dE9TdlRoM2UrMHJlSHIyem1MNGFJNFYwZHFDcDl6MFVk?=
 =?utf-8?B?clliakUwTCtTNmZjRk9xWUdsV1B0RU9kUFhoOGhPQTRrSHhuR3FwTGloL0Nz?=
 =?utf-8?B?ZFBkR2xJMTRJMDc2YTVFaW1yNjMzS3pVQTF6NGZza2lWQTk4b0toQWsvZTNC?=
 =?utf-8?B?ci9BWVQ5OW91a0d4VDlEWjc2ZWpKRjkxZmxNLzBVNVI1ZHJ4TUFQUjNUUVdu?=
 =?utf-8?B?ek1UTUVZdzI5Qlc4ckhTamhnSHZLWWFXNGJjNUZ4SVJOYUthOHpZS0Jqc0xJ?=
 =?utf-8?B?d2d1bVBvZVBQR1p3Q3N0V2FzY0cxVzgzZnpkdUNlTm5KRXdyMyszR01uTlkv?=
 =?utf-8?B?Z3lOTjJqaVZ0WFNsNjExNlRhdXhoSkJsZnM5cTVCVjBJUnh0VUw3cHlra0RS?=
 =?utf-8?B?b1JSUzFCQXBpcTJRc1E2WXFJKzE1TklhUTMxcGZEelo0cDR5ZFlwczkxMHlO?=
 =?utf-8?B?NWtHd083cVBqUjdkbmdGRzRBZjdDMTYvekJPdnZUcmlFZW90ZHdNMk1nQXlT?=
 =?utf-8?B?cFcrcm1zREkyOWVxamQybDIyLys2L1h6NjN2VlpvTnM2YUxrZkU2RjJVSGZT?=
 =?utf-8?B?YzlJV1QwNW5nUlpDc2doYjhqekpGVmpPd1BPRFBReko3SmRzQlFkamt5THNn?=
 =?utf-8?B?ZXpYWk1ZNDhPUHZ2MkhNQTNLNFBSTC91NmJsS1Ewdm9saCt1WGhZRFdicGs1?=
 =?utf-8?Q?5vL9In3I3O7FEOKUziglWLgH0iae6ngW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB7129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUdlVEZiaUlvTVBlWUx5QmhnSWhXZVk3N1pkUGhLaVhYV2IxY29XOTlxMG8y?=
 =?utf-8?B?bk5Hd0gwVkFybXRKREZpQnhwQ1dGdGIwajV4V3AzcmZrT0lSdHc0bWtVZjZz?=
 =?utf-8?B?ckM4dU5MMXdDZmg4NVZRR3FoWVZJOG9DdjBMQ2t3UFpZa0JtQUJoaGNVWTd5?=
 =?utf-8?B?dVo2ZXZidDV2RXppQWl1NFU4L2tMdk5XeVBFTEVHb0FPMlNpTWppYjVneGVD?=
 =?utf-8?B?Vmhwc29BSXQwZk9nakExN3dkeDR0ZC84TUtPZUdEVmVxNitrOGNpSXFCNERD?=
 =?utf-8?B?aVZNMk9KdFB0ZTFyclloRzdGUWZiSUQzamVGQ01UM1lYLzdrUzJaa05wQzBC?=
 =?utf-8?B?akFEQmtPSkJJak1LdGtJQzE1OExxdGlUZThQS0Z4UEZKQ3o1a0ZlY1ZsSUNn?=
 =?utf-8?B?Wm55cFhhYnh5N0pxYVFZcmJYdlJNWGZ3TmVJSnozYk5IRFBSMElFaVF3alFx?=
 =?utf-8?B?L1lBRFdPTHJLREdpcHIwMForMnVlL2p6MmhaOUwyUUNNUHgzUFBLR2tBVDBi?=
 =?utf-8?B?VjMwWnhlK2J5SzBmRTVQRVUvOExhM0xpN2k4bm9FeUE4Z2FLV2NZYXV0WnNw?=
 =?utf-8?B?OCsrL1FOVlUxNGhUNWpvbG1VeHVtUnIvd0RZajdhc0hSWFM5VmtqZ2ZLNGVq?=
 =?utf-8?B?NTRIU3RwK2d0L0pxZXE1ZUlFbjBsRDIvZFM2UWFNVng4VDdOKzdXRkN1ZDln?=
 =?utf-8?B?VEhSR1N0cFNwQlFIV0ZOcjRMalNwQWdoTE5FUlYxK25LNkJtVjRIRDJoTldW?=
 =?utf-8?B?TVVkQ0kvVjdONnVkZTRCNUVOUkRLdDRGZDhqMTJWd3N6amxYSTdtR0FzQVBi?=
 =?utf-8?B?MENaZXpFM0FaL3hMVzNFa0k1ditMbjE1UzV1RkhOdGpKVDE2YlphQk5JLzVo?=
 =?utf-8?B?QXhYa3FQaVpVSzRMZWdhQjJpcDl6R2s1eVVrQWEwT0ZHVjYyTUlYajBCbmlE?=
 =?utf-8?B?SjV3UzQvQTRLOTdYRnhlZjVLeHp1alE1S1l2RFY2WVd2NFlLeTVyVkgxaDVn?=
 =?utf-8?B?c3FGU1hzN2c5LzJSazQrWkRSd0lIUmJPdDFzUEZtLzVHc2NzMW1TVFlxMG5q?=
 =?utf-8?B?bmYwLzRyU2NiVmNUaWZnd2J1bmVaMDBLZm5EeUVjYUg1Z2Vldm1vQnJOelBM?=
 =?utf-8?B?bWQ5TkhreEhDVkpqSXpqbXVxazF2Y2xyNmdQL2ZiSWJnUUI4RU1tdVNBMG5L?=
 =?utf-8?B?RDNydVBNZ0xrMnhBclVZT0NSTDlvcUp5dGlEV0dXSFlhekdGU3hndUhwWllK?=
 =?utf-8?B?Z0VyRHY1eVVBS0NWQnB1QXN3QWVTZFI3WVJwMERYTm03SiswWmR1YmlUOWs1?=
 =?utf-8?B?M2tqZlN2OUNZbnRWMnJUWjNMZTlWKzdNZUE3Q2xzWGxxTDBoSFNTR1FXcVh6?=
 =?utf-8?B?eEJxZzhPc0Rma3l6ZFF3dVB2ZzlPdFA5ODRrcnAwTlhXNXdZeG9nWXhjY2Iv?=
 =?utf-8?B?czdKbXVqNWZXVjUvUU5lOHBJM3VvNVdvTWRJL2g0KzRlbDNXdVpwalFuRGM4?=
 =?utf-8?B?RUx0dmNROTRkeEN4NTluSUwzWTllc3EyVzZyU2JJa3dWZGtOdmtKZy9kZXFi?=
 =?utf-8?B?YnhZMFBPNnpOSTBjNlYyMXorcDRvVHBjekVMY2pHcmRWdWd1aW1Fb3Y3blZJ?=
 =?utf-8?B?SjVGRWFvcVNIS2E1bm9FZmVRMzVhYkdaTURXSXZXZjlpc1lBYXp2eEkxbkoz?=
 =?utf-8?B?T1JRL3J2Rjk3ZXBHM0F1UmxUQVpUR0Rqei8wbDhiZEhubHhkN2lCdnFUdU1p?=
 =?utf-8?B?NmZFdG13R0xZdklrbXpSa3RvQ2VhdDRyWVMzUTVEYUhCM2xTSEUyek83VmVV?=
 =?utf-8?B?bUlPSDhPOElwV2RBU0FEeStha2VwL3c0OWdsWVBHMWcvOWx3elp2bzNoWG10?=
 =?utf-8?B?aHpIb21oL3ZFbWNUaTA4ZU50OUtvUXlyUExqT09kWDErOU9iUXFUUCtGMHJ4?=
 =?utf-8?B?WWJnNFNYWDdrUGx3WVRETTY3S1B5R1MxK0ZwbmFVaCt3d3FhYnI4ZUlHakdH?=
 =?utf-8?B?V2RZK0lweTVHUVBzVlJ1QUtaYWlkeFZXUDhFc29obmhnbThzaFVwSmw5Q2Mz?=
 =?utf-8?B?dE9XdDZjVjBXTXFhNmI1Z0pqRGtOYy9IVlhPZ29PVGR3dHJQbzUyNE9tczB5?=
 =?utf-8?B?SGxYaWhwWWYxSTV5R1JwM3NoYnFMRitJOHZDcUVuRGpzUkRCb1JmV1BmVFp0?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oI8oT+ZWlKpALP78bFhFk5FIxBuU0+eXaDfHJPrOCkL/HQjY4OF1wkVfglcItTEpuwbPHwfoHtJOBtzSkt0rzgQL9zLOayqXwyNtOxPDRf8xN9Bycc+z1v7avWp5cdfuxIi7NklRUR7sISbkIl1mjTAR3XIUEgOmBDoKykF+1qMvNN7u6c6WyQYFIzorsJgzJ0sX2hk7jUldvj4gsJDwHddH6YRwFqtk5xi3Oih3Gcvp0GfHLFf9KmgGAPrL2fhE/EBnAirNlcrt+MX/f0wzs06q9Rf4YPFvjJC2AfXn7K+hYVl9pSMgqRtVb0l6JRLeUHBZcL+aKi1WfHdk/mDPO5zmtWJ6H1AyWV/KoUsqbgm/7FVCJRYbJy8NJuIV7PqXzkDhBm9clHSImpehM7FpC5IyNj6ymj07dtXXdxJqBsbfeWV98JD8xtP2Dm8LiQrXPRfZTENiY/IRFgA2H4s2wbSGM+Wivhpm3YmGnMCk/CG8o5O+uTi1HmLkZ5YnFWMR+WE3cm7mhS/Tv5mVh21coazJ1Cg5T/J3RAxcXs8yqRAygaAZXO/1WEFMsEbSWfaYcS2vQ4yLyU/PmDF3Q0hGlev/Hg+EpbvBxztfMYlBKLQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c9a2c6-86f8-49cc-d2a9-08de381fba46
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB7129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 19:10:05.6033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/b1+UFJvAPCQK5Zcf/sC0gvZm7rAonqBUCYmSri8lAdi8nXyaxIBvxh9ydkDANw5CvgIeoGm1AEkmpzlr6abg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6083
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_02,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2512100157
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDE1NiBTYWx0ZWRfX/XWhv9wKQDJE
 5uE4u2wZ8LydYFaecxapk65iD97ZP7vhUv6VKjvgf4hyL7UG3IkcdL1O8kgSKGIv9aIB8QbLiAR
 /8exMa5rc/62usdsWhComT2izyBuyj+h3ZVEs7hRcX2pD0EbxcdDUAGiI0pMT8n4awffuYpy+hE
 TNe4vKnomcvssKOaLxuUDqtBBxEMPsgy5pGXXpOdhncvfS3Gi8YK7yrs3y3BDqxei0dNzlbI+XZ
 R9HeboXMtQeVOpdkhB+H7hoFjfy88VJGpOJR01iCj+9SOvO0TuXgc2pZcb6+zz4efyAjsAD7RJd
 Rii+RLfcsvflaSPjznmyN/vqvO3PWLcLCRZ4L6nbgS61gq+NG+vz+IZXyUYqpY4K/+qamX6AYf8
 x2FFgCAPGZrs+8qeFzAAqKnrN9ypVg==
X-Proofpoint-ORIG-GUID: I6bFAuYW8LsiZX6q0dM5nbrjW-VbxSdm
X-Authority-Analysis: v=2.4 cv=OLAqHCaB c=1 sm=1 tr=0 ts=6939c591 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=WA5vYvTca1fqxx5Gyl4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: I6bFAuYW8LsiZX6q0dM5nbrjW-VbxSdm

Hi David,

On 12/10/25 12:09 AM, David Hildenbrand (Red Hat) wrote:
> On 12/9/25 22:23, Dongli Zhang wrote:
>> Do not set vb->pr_dev_info.report unconditionally if
>> VIRTIO_BALLOON_F_REPORTING is not available.
> 
> Can you share with us why you think that should be done? Please document the
> "why" and not only the "what".
> 
> Without VIRTIO_BALLOON_F_REPORTING, we'll never call page_reporting_register(),
> so it will never be used.
> 
> But the compiler cannot optimize it out. It only happens during driver loading,
> so I am not sure it is worth the churn?

When I was reading about the free-page reporting feature in virtio-balloon, I
was confused as to why pr_dev_info.report was always configured unconditionally.

Later, I looked at the implementation in the Hyper-V balloon driver and noticed
that it even resets pr_dev_info.report back to NULL if page_reporting_register()
fails (see line 1669).

1651 static void enable_page_reporting(void)
1652 {
1653         int ret;
1654
1655         if (!hv_query_ext_cap(HV_EXT_CAPABILITY_MEMORY_COLD_DISCARD_HINT)) {
1656                 pr_debug("Cold memory discard hint not supported by
Hyper-V\n");
1657                 return;
1658         }
1659
1660         BUILD_BUG_ON(PAGE_REPORTING_CAPACITY >
HV_MEMORY_HINT_MAX_GPA_PAGE_RANGES);
1661         dm_device.pr_dev_info.report = hv_free_page_report;
1662         /*
1663          * We let the page_reporting_order parameter decide the order
1664          * in the page_reporting code
1665          */
1666         dm_device.pr_dev_info.order = 0;
1667         ret = page_reporting_register(&dm_device.pr_dev_info);
1668         if (ret < 0) {
1669                 dm_device.pr_dev_info.report = NULL;
1670                 pr_err("Failed to enable cold memory discard: %d\n", ret);
1671         } else {
1672                 pr_info("Cold memory discard hint enabled with order %d\n",
1673                         page_reporting_order);
1674         }
1675 }

That's why I'd like to move the configuration of pr_dev_info.report inside the
if statement.

It's a purely non-functional change, intended only to make the initialization
look cleaner.

Apologies - I should have mentioned that this is a non-functional change in the
commit message.

Thank you very much!

Dongli Zhang



> 
>>
>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>> ---
>>   drivers/virtio/virtio_balloon.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
>> index 74fe59f5a78c..0c39f2415324 100644
>> --- a/drivers/virtio/virtio_balloon.c
>> +++ b/drivers/virtio/virtio_balloon.c
>> @@ -1034,7 +1034,6 @@ static int virtballoon_probe(struct virtio_device *vdev)
>>                    poison_val, &poison_val);
>>       }
>>   -    vb->pr_dev_info.report = virtballoon_free_page_report;
>>       if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
>>           unsigned int capacity;
>>   @@ -1044,6 +1043,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
>>               goto out_unregister_oom;
>>           }
>>   +        vb->pr_dev_info.report = virtballoon_free_page_report;
>> +
>>           /*
>>            * The default page reporting order is @pageblock_order, which
>>            * corresponds to 512MB in size on ARM64 when 64KB base page
> 
> 

