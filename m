Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785B57AE5D
	for <virtualization@lists.linux.dev>; Wed, 22 May 2024 21:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716414313; cv=fail; b=JxWG2or3MR3kjAWMooGlhIeJK9boEt8IEWIsOlbVRUtq9yU4eNIkaEz8/m3NTRkpWzEDqFKwBaM4LGYkkHEkgyRaJvzGsbQnELRfzBL8WjsDn6ePWLsOMMGPcQwViZf5x4xpoGVJR9imjWrNixlKwo40W841rJaWKW82k9CeD/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716414313; c=relaxed/simple;
	bh=81W+2PO/JyFGzN4I7/pM3k4AwXXNIwpyR3mAr4J8w8Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PMaE+rEt165OvQv8H8iIIawc48Q24R7Np/yhwPxdagFJAMUUQDUg/G8qBxgfqOru7IBBVK0fmLrIGETiaaUdL0zMbvskzbzClUVAUZNl/AiSLz6T87Zcbbs6BMTlcj92CxFW/+PbZFYha/vrnnEiPRgCZJ72RSk0rgXE7GUcsOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UQHB6zJe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Qa8c9yCH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UQHB6zJe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Qa8c9yCH"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44MLawx4004699;
	Wed, 22 May 2024 21:44:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=uTht2xriqou4gUeoNVWdfdYZ2Aytd3hAhaaGCaC6k+k=;
 b=UQHB6zJebz0Uho4xgrWRRPiu7SHxR1VmH7HrexzK9R2zteRAQkXraTX0CIEGCs3pFcOP
 jrNwy2h42L2oRVOl36/L954mbNbgrKUsXqBFciEixQFlCk5hNTlAcrx7gfmPnKqbShMa
 SsuGSr0GHBD09k1B6HlhsVYKcgCibcygC80zWTz8ihBOUqmvx3cnSw5cpt4WTgQeInbi
 02g2nq9HpzOEIWjYieLhKNYcelxUnDgF5NyN1RGpNjNko533QOaD9FtoEunC69Eb2kK3
 AR+vJBXEiAVVigGko0XqvhkGaDZHstdVfF43whI5QNo5YWqUQI1PiACFMK8yCkJLtDyY Sw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6jrerq0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 21:44:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44MKgGk0005063;
	Wed, 22 May 2024 21:44:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y6jsa3mn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 21:44:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZghFpjfoOQsaEOZenhgmRcP9UBN2e7/9G72Pf55m6fZkRi3GyJKMrocX5ScJk/zLgPaEyAA27+zcw6GnkAqOnD/K4o/xUOS/0OO+jovId3BwMrMP5L3M2UyOKNBWm8aPtkzVDeqNdSfoEtgnYj/fvK6DlnlwoOSYkIOkR2ncaql5rKKF2t2JDTEXwmWNo3tEUIhtZH7WcGhhwH0h0fTiy+VaGTPv/qKBLmzAT+CAIYXBUru60vPO/vw/KkQIe4ATCAAeaMy+480dcJpu2h+B6hkrLm9MJOU7tc8isuTsiPaaYwmtvPyfVa8NHwG1oNeLVqz+iUyL80uVYgyHnA+GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTht2xriqou4gUeoNVWdfdYZ2Aytd3hAhaaGCaC6k+k=;
 b=GVsSrg3hDFFxXNrxUa6KO0SdRQZ3gDAoQJWwGs0erpR692v97j3OkBHGl5PbNaahUzfI61/EoBC7TTcvNlFTiC3+SMJZMjm7UQ1yI2ctQfAe7Ltdh+UWH2VRDTjqkf1UPLurG3ZAWNR6qkld4Cm4FF64h45HV+GdRxmZTlhHkKLCGXaROTNH26mXwiDFBHvTR0nb48hGgDeKJirth+2BGMRwGTRn87oMa8TtXIFryMa0n8G2ogpDsnI4mvuvKMfjteVpDo2OfyNNrr6Vf/UxPEh3CL4Hr33N3tOk+AG8y3MHw4npc8dYTZcGxJ/B1eWLTVGRMUVsC5hLMRWnO59dTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTht2xriqou4gUeoNVWdfdYZ2Aytd3hAhaaGCaC6k+k=;
 b=Qa8c9yCHIVjkDiQUVYehR0jB0zhatg1HdMgSQlCmem3X2lel4MN/U/2DWZDCgFTeq0AGOmQEd8to9D8zZ0vKTZjXiSN3Ep/NGN7q1va6HxZk882yJpP4BT6UZlR30QxtfUUAtgK1Y0CZI8W5+YCbPXxrvCemqLCqkb44qbLjoYE=
Received: from SA0PR10MB6425.namprd10.prod.outlook.com (2603:10b6:806:2c0::8)
 by DS7PR10MB5168.namprd10.prod.outlook.com (2603:10b6:5:3a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 22 May
 2024 21:44:39 +0000
Received: from SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::447b:4d38:1f8b:28f1]) by SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::447b:4d38:1f8b:28f1%4]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 21:44:39 +0000
Message-ID: <2c5fed84-bd3f-4f57-893d-59434e64b9c3@oracle.com>
Date: Wed, 22 May 2024 14:44:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] x86/vector: Fix vector leak during CPU offline
To: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc: mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        joe.jin@oracle.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, Borislav Petkov <bp@alien8.de>
References: <875xv7idcb.ffs@tglx>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <875xv7idcb.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0156.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::11) To SA0PR10MB6425.namprd10.prod.outlook.com
 (2603:10b6:806:2c0::8)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR10MB6425:EE_|DS7PR10MB5168:EE_
X-MS-Office365-Filtering-Correlation-Id: ca2d8310-d204-4c47-c12a-08dc7aa861aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?djVKSllBRG5vU0R3UGMrdzFpTFQybnd1UGw4cStxdTJ2UFg5dWtCemFZQ0JG?=
 =?utf-8?B?WUxVZXRxejcrV1J5WThybGdJa0hkZTV0bE1rMWxxKzRjMlplWHZVRktxa2xK?=
 =?utf-8?B?dWJMM2Q4TUJSa2FJcHoxQWR1MXZ6cmFMc0Y5UllqdmxmUFh1Q01JbUp2ejRh?=
 =?utf-8?B?OVA1SHQvWHc2YU81UkJwdVdGbFV1ckZyTE1yYkFIM2Y2WUpHekw3S080M0lv?=
 =?utf-8?B?WWN1TWFLUGlVbEtiTi9OSW9ZVzR4aEV5Um9XcmFJN25jaXlPQ0hpeWdieUhv?=
 =?utf-8?B?M1gwUFZKS3gwRzgrbGFYZ2xOaWF0VTdnczRRU1ZNcTFmZWpPdE1yNndQMUVt?=
 =?utf-8?B?TTZkeVBCOGtuOFBLZGIvVm9XdzV6T3paQ1JmNkJzK2w0dFlLNjJNVlR3d3dP?=
 =?utf-8?B?ZS8xckJ5NGV1UTFOajgrRWg4ZE45VWlmZWZtNmVLTU02T3ZIOFJCR1hwbHlF?=
 =?utf-8?B?K0NBcWxIZjNicFY5TURqSDRVYVViYlVxVU1NVDJBaW1ZWWZjZW5tMUNaVjJZ?=
 =?utf-8?B?c3BDeFZFVzBRbDVQMzVkNXNiTWdoL2tYemZIS1NDY29FbmdhTTdUSzVpUkJq?=
 =?utf-8?B?eVV2VzRScUxtNE9udVBPSzFRMXJKMEJxdll0dkMrUmh3WEF4U1pMNnBJaCtQ?=
 =?utf-8?B?VGREaGFudFJSOUhPS0gvVW1NZngvTmpjaUNlSGdleFJCWUE4N0ZyVE05SSsr?=
 =?utf-8?B?NkZWbGpadDBXeGFrQmt0ejVPZHhuaHBPRmtkMHp4MW9JVUZyYm1DQXdJNytx?=
 =?utf-8?B?Ri91UmdpS21PRGRzbU1ENmd6MHlUcElPaUlORzBvd2laVFBiUHdmakhrVjFi?=
 =?utf-8?B?blRRVlZEUFJWTnQ1bTlXTjVyV3lRbnhZRmVhdkRabjcyQllWaWpOOG1ZaGQ5?=
 =?utf-8?B?VzdkZkE1U1pOT0ZYaWdIWDhkMXNmb1Z1OWcwcktrQ24vcll6OG9NWnJnNDA5?=
 =?utf-8?B?OXFLLzg4OXpnMzFlWXF2NnZKeXdUaWxBT2ZQVWVwMTFwRE9TQ0VLY0cydVJn?=
 =?utf-8?B?NzhIMzZJN2VBY01GeG1PZ0p3NGg5QkVsWWU2Y2QyWkdkZDBLMHcwTGE3Y1N5?=
 =?utf-8?B?Wk1XMTh1SVdwVFNiU2JFSStHWkN6RWRacVFJT3k5aHRlY3NUZW1PbmpYb09P?=
 =?utf-8?B?TCt4NkJNQzdMNlM1TUxyaWUwbE1HOE0vYVU5Q3RaMjZQeWNmNEoydFNVSUZZ?=
 =?utf-8?B?ai95cWc3eEFxSkxiUm1BSmxPR0NwcU8rUm85WDhHQk91b2ZOSURNQUo5UmN4?=
 =?utf-8?B?dHRTSis0U3RkajNQVWt0ZTJVOUhyVktyblpidmpKZTFXZkZBMWJ4Z1R3Tmpi?=
 =?utf-8?B?dmxId2NHYTZETUVZZ0QyNXpzbUVITkFZNmViZDd6UDI3Q2dhb0RkWnk0UC9s?=
 =?utf-8?B?MDJybFk0Y3YyTlFkbjIvcDE4eVdWanZZOTVNZ1JUQVo0VU95ZDkvWTFBR1Bk?=
 =?utf-8?B?MFhLWEc3NzdMQnArQjFQbytWS1Jsajg5WkVsRGZHelI5Smt1dklQSzlwcXlw?=
 =?utf-8?B?Yys3TDc3Tyt2S1BTbFFaYVVpZEZZZ09aV3MxSEJYNVNtZkRsUS8xNkY5LzRp?=
 =?utf-8?B?TnJiWVoxeGhQL1BWcGs3NXJtS0FIYUdyOFVUZGVHKyt1SDFkbzg1UVNFam9T?=
 =?utf-8?Q?Xqo0mxVPaocQnCVXT07jsZFhaiNWje1H3ql4Cv0xHusw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR10MB6425.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dURiQVBDTUJ6ZjNPL2xzamlJMkZYNWhhV1luMDhRYi8rN1FRM0JPUUYvYXV4?=
 =?utf-8?B?OTllZFlSdHRmMmxjTDRLeTFkT3I4SzhUWkhKZkU2YjJkeUZvV3BYeFBrMVoz?=
 =?utf-8?B?TG5RTTgzMnpMcDhhaEIwTmNCL0FrdVRIaldVTU90SUNDUDZSVjhla2FkWEh1?=
 =?utf-8?B?aU40UDY0SmZpUUxvNFk1S1N1RjlMc1dVbTlZTTNaMkcwY2h3emYzZ2FaVHd1?=
 =?utf-8?B?eUE1ZmZxWkt0K01ldXFhK0ZzZlA5dURya1Q5SXFIM09HN1VKWjBPSUVzdlBD?=
 =?utf-8?B?MElPZHVTVHdXOEczT05IUkZLTFBrMUZSVFBEdVk4aGxRZXFmZ1ppWW1aVlZW?=
 =?utf-8?B?Ump5c2hlNDZ1SkN0QXlIUVhGS1hhRC9seElZS0FyL3lSangwVGpYT1JyVU1t?=
 =?utf-8?B?Y3V5TkVjTmRlc2d6UnVCenpBcGg0NWRiNWtXTzR5T09hMXVXd21aeVdGSmxC?=
 =?utf-8?B?K0NWYTJ6eUVnN0w5SjNuL3FDZFg2dE5rV1VkeDY5ODdOcWlLZGh5ejh0dXZt?=
 =?utf-8?B?Zm8vdEwvVFhnVGprelBIVncxUmlNYlZ4cEszamp6Z1JaU3dHMkxzdStSVDJP?=
 =?utf-8?B?dWNsUW1IOWEzQ0phR2NHMWlQVUJTa2tDSzQ5TGV5cW1aRGQ5ZmVjUVY5Qjds?=
 =?utf-8?B?R01nOXBMd0JBQjJ0ZHA4dmI2SVpkR25ycUJqdkxsMEJXMEJITEpwRlhTNyt6?=
 =?utf-8?B?aURkbmkvVkdhU1NpckdsZnZSei9YejhnbSs2Z0lkbkpqUjRPd0dvSnJ2ck9Y?=
 =?utf-8?B?N25JdUt3ZWRmZHR4ZURCT0hPaTJvVzBoZXpGb0VpTEFTNUY1YmhwVy9ZVGJF?=
 =?utf-8?B?ZWJWb1NDR2Y5ZG44dFBDTGdmNlVJdW9YaW1HSjFHNVhUTkc2QmxUamlaQy9P?=
 =?utf-8?B?MEU4cEFLTVdISzNjT0R3TEp5c0J5ZExaN2x3eUpYbXJValFoeFByQzZJMVZE?=
 =?utf-8?B?SVZ5akRicm1PNXl6ZDZuRW1GTnZkTkZVZE14OFRLTkRqLzVUTU5BcDJFSW96?=
 =?utf-8?B?SER1WkZoa0I1M200UlJOSjNPY3VWQjlXV2o3SVY5aXhweDRMVDNtYnFwdkpS?=
 =?utf-8?B?bjc0RmJtL0NBMXUyMXJWd1JxbGN4c2dsa2cwamtXZTFmWmllUExxSGNOa3hi?=
 =?utf-8?B?RWdlWUtiVnlzdlMzSVZoN0NEM0J1QmFldHJRTHFDbXN2WTNjTytkTmtEVGZw?=
 =?utf-8?B?MXNOV2Z1aml6UFpVWHhGQzYxckYvODM3NXNVZzRBNkUwdkZubnF1VUF5ZmJm?=
 =?utf-8?B?WGlQd2M5d2JVdm5mb2NzZzBZMitFTm5LMUJKVGx4Mm55LzNRY1QrUERSUFhU?=
 =?utf-8?B?c1BidTlaMjgxRWhmdDFKV2VLVFF0elIyczRYRXhyZzBrdjdTYzVON2lSWlVF?=
 =?utf-8?B?dEJSSlVjTlNZMXNnL2xyZTVzajBCR1Zjb0ZFNktRU1BDU3ZoTWFPWDB0ZGcz?=
 =?utf-8?B?RVBFVVJNL2dGVHRJQmNra3U0SlFrSnE2SUZ3aVJzaVhKcVIyWGdIcXNpYW9E?=
 =?utf-8?B?eVRDVmJSbTRuelUwYWNYaU5Pbmk5VlRlZUVzWWlNNGIzNjlyL3BPY05aeFYw?=
 =?utf-8?B?ZzFwMlkveEI1dTVxV0Y3MlI2ZDlXMldrMkdHdXcxam5ZYk54am1rUlZwenFr?=
 =?utf-8?B?Z3FCSWVLcUFjV1F1WVlqNkF5ZWxhTTFWdUc0ZC9PbUlPc0h2dGx1WkY4aDRv?=
 =?utf-8?B?a2x6K0ZMYVRxbk1aZHk3bzNxbVIxNmYvNEZ0ZmdUR0NZakRpaGlqblBCWFFp?=
 =?utf-8?B?SVlsaDV5ZG1kRkkrU0FiNlFpcjh5aEtaQlVmWUNteVhqVXZOUUZCWm1nMnUv?=
 =?utf-8?B?dnE3bm8xVFRzRGpRTDdCSjg4NVJvUTFqTUVaaXpPbWxRbkl1dkNrSmNkWk9u?=
 =?utf-8?B?Z1FpVU95TkVMSlQ2ZEVITmUraEUwWFhRc2xja3pBamExQ0YwNkJGb3RoQzdF?=
 =?utf-8?B?L1JUck5hb1d4UTZ1ZmhIYmtxTjFYN3E3YmhPUzFXSlQ3RTJkWXh6YzdLYXFB?=
 =?utf-8?B?aXg2RWVOM1YxbktzZng5c3A0MFZuQ21RdTdSWVd5MWhSOWpuTXl1YXk4em85?=
 =?utf-8?B?ZzdIbXZpOCs0Vjc5U1NKZ0RlbFdoS0ZHNHowWFloVEMzU1k3Z3J3Q3U3YzVB?=
 =?utf-8?Q?Al2Aj0H/LuwWFVccHt4C3Dr6J?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GNo1VcfCvqXBNi8zVBQsqBdvSSGP3Hc3zEgF995cEU/s2Hquk8nfP5citWglYecQkEBpYaAO5WmB+IdmVJpZYE+f/km9PnOnPN11OmvGt1Y83U6WwrlpGkLvORd37SY7we5tZkwZmeTg84OGMhcpPccwhmV9uw1ujkqeT7f9UJI/nMGbatyIi83AnHrDBsvbJ+XkrYZ1t7/DsvTUiuiVynukr/3MM0zOlIz9ML9H/BkKcFdFSC3BKNXiWsikhSmUmY4nzysU9dhs3/dszgtEeiEN+UXmgjEVl5wHUi3T8yUm9Ra8ncyYNzWakcVMX4OHyqKyUYi4tfudt2CieXHZ/KOKv5ow1jXpTsiz6xCi67yOsWDC3CR3ik6bpDy8gPnBmObF2NYsXtFJmYTGQTTQxCjWxlVT92R+XPsUA6lK8zLCDu/RRtsss2VRUMhJW3CYiaR2tClteLu1iHtUH4RWJODBT8nIG/E01+WW2+kW1XMkmd44yBetg3JqI6B0h1dlh7iH60TisXLHPo3ulb7enHqTRuY4gNvvkLDG2YacANaBF4Fk+dNUQp5b3AV1XClGIMwWCLNPKLHovbqBWMH6gs7d1ec+suOBh0peaguqeSo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca2d8310-d204-4c47-c12a-08dc7aa861aa
X-MS-Exchange-CrossTenant-AuthSource: SA0PR10MB6425.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 21:44:39.2703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BGIgyW0q3pCSU5Z4nNRYNIuUtkxyu948imup/uRB05ZRGDfN3FGel5q9fDm9b3cTU5kqzxaPV91B6JqQdfPqYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5168
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_12,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405220151
X-Proofpoint-GUID: S5vy20evSU-cilwqJ4dNRp6-_sLEXg6v
X-Proofpoint-ORIG-GUID: S5vy20evSU-cilwqJ4dNRp6-_sLEXg6v



On 5/21/24 5:00 AM, Thomas Gleixner wrote:
> On Wed, May 15 2024 at 12:51, Dongli Zhang wrote:
>> On 5/13/24 3:46 PM, Thomas Gleixner wrote:
>>> So yes, moving the invocation of irq_force_complete_move() before the
>>> irq_needs_fixup() call makes sense, but it wants this to actually work
>>> correctly:
>>> @@ -1097,10 +1098,11 @@ void irq_force_complete_move(struct irq_
>>>  		goto unlock;
>>>  
>>>  	/*
>>> -	 * If prev_vector is empty, no action required.
>>> +	 * If prev_vector is empty or the descriptor was previously
>>> +	 * not on the outgoing CPU no action required.
>>>  	 */
>>>  	vector = apicd->prev_vector;
>>> -	if (!vector)
>>> +	if (!vector || apicd->prev_cpu != smp_processor_id())
>>>  		goto unlock;
>>>  
>>
>> The above may not work. migrate_one_irq() relies on irq_force_complete_move() to
>> always reclaim the apicd->prev_vector. Otherwise, the call of
>> irq_do_set_affinity() later may return -EBUSY.
> 
> You're right. But that still can be handled in irq_force_complete_move()
> with a single unconditional invocation in migrate_one_irq():
> 
> 	cpu = smp_processor_id();
> 	if (!vector || (apicd->cur_cpu != cpu && apicd->prev_cpu != cpu))
> 		goto unlock;

The current affine is apicd->cpu :)

Thank you very much for the suggestion!

> 
> because there are only two cases when a cleanup is required:
> 
>    1) The outgoing CPU is the current target
> 
>    2) The outgoing CPU was the previous target
> 
> No?

I agree with this statement.

My only concern is: while we use "apicd->cpu", the irq_needs_fixup() uses a
different way. It uses d->common->effective_affinity or d->common->affinity to
decide whether to move forward to migrate the interrupt.

I have spent some time reading about the discussion that happened in the year
2017 (below link). According to my understanding,
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK always relies on CONFIG_SMP, and we do not
have the chance to encounter the issue for x86.

https://lore.kernel.org/all/alpine.DEB.2.20.1710042208400.2406@nanos/T/#u

I have tested the new patch for a while and never encountered any issue.

Therefore, I will send v2.

Thank you very much for all suggestions!

Dongli Zhang
