Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679461E131C
	for <virtualization@lists.linux.dev>; Wed,  4 Sep 2024 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725472133; cv=fail; b=T7x+R06+lLLH8U9WfCoxr8nwUg0bbOUrmDk5RWKimOC+UxAdLPPgXFOyL/oPJ6r/HQPyYIfjqFr4j4p4PiDb4VCUc8tEirryBjgLA/LI52Ttpxr0H0TO1IiSsXz/MAB0PwDrx+94rn6R2ILfst7g/0XHwG00+yzn6JLnnsE+k3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725472133; c=relaxed/simple;
	bh=r8gPil1w2Pt8uJcdbqhO0m4lb7/UuoaSVivgHQaijaY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EhMt3fbfZzwKWu1I3gSxafm0n2gZwqNJR9RFkwcVNyshHKrWngBt44YldOame0vnxRfIj2KU0xt+Z/aNSlRo/RcOz1pWnExKM+G4+S5QN1ZOX6wWvJVEC43ohMXtbWIvC5/CuR5Ikq46Yp/3XZI/3Chc2OKOte4X2YufyBpKciU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NsqWqNa9; arc=fail smtp.client-ip=40.107.237.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NsqWqNa9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1Ug8Ov4E7oxwv7XlX5MVkTHjzCe01REl5FRuyWUXDscjEwV2QyIdgFEE58LtWT5TObJF6b2L8CYr0Uj3GUtriuepZVzaLID4Ye4n22Bb6aPpgy72ycuTLpJNX2Bw6+N+nOhItExbhvoxkz0EeFCOfWMAN5FEyjp2xqaAYZ633A7J6kDC0qVvGyKenWe320XR+8UsFwu33ltAmGxxcr9kOYONvFXu0nYDuWZ7LTDT5aIGnhLVAf2gKQHlTOP4w9iE4WZrp1Cer9M0Rg/trw2xNPVvfSHmpIoc9D49txck3XD4yF2aHF9Go4Mwhnm0K2UN0IBedP87z0BdvBRMI0D3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlw9kj0rYRWH2OVXLkp9KtXFoj30xQD5Cm1Zctme3Lo=;
 b=XwWQVMrRcBmXOHWTganLnMTxbf6a0OCo19nQkF/3miAoy1cosmXRAtGU75eKnUmVUS0o3aJkeEWxcZtZahGvv+IDnBuEc39d04gWkDFxspEg2G4jnQiPaKvJrhaoFSlNJR/4PnJiLdOT9DJ2gE3Ahc9E27bLqFlfqNplxnAGDlNrdT9+i+FW4D/1j5M73ogRhrzfv+/Wbfk9bmBDPeyVRd4oGubGKXJjG1MKSl6Iln+fBhsyWWxuP6XvBLxg07y1OF0tQkTXG62MYZqRTLmPFg4gFbik1s4hTF50kvBdo+vwK+a5tn2rXRH+nTalqJVfSGNlxThuLYBLtmaHZnno+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlw9kj0rYRWH2OVXLkp9KtXFoj30xQD5Cm1Zctme3Lo=;
 b=NsqWqNa9KQjC4qjSnZgbhy5KWD/6XoTN37cMReo7474+Gjfidz4zrAWlNU84YNPUY7vg5BzhWNavQMyEK+IcxA46pyv+tCDWvzhlnQFVIiAhLtLtwp25tld5i4yzPolwjthaoYf/IU+S82C6NaiW/lp9Ii++56tXfylqeYswtZyhUg+z/gQZ9bVKBeHkfNB38asl6tVXR3zTcyvopMERprKDTInGr8eVxLs8Gf3g2fMJT2WRO2eLSN5ik+0NpvI+zriokv2Lh0ViaAO/wvlOXCxQWHeeD3dez+TokBUPKHu+9QGpjptPdycguONE0HGFsQkXzI5bXIKNfYVoqRJWJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18)
 by DS7PR12MB8082.namprd12.prod.outlook.com (2603:10b6:8:e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 17:48:46 +0000
Received: from CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4]) by CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4%5]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 17:48:43 +0000
Message-ID: <ea0010cc-1028-4fe6-9f95-26677142fe42@nvidia.com>
Date: Wed, 4 Sep 2024 19:48:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] vdpa: Remove ioctl VHOST_VDPA_SET_CONFIG per spec
 compliance
To: Jason Wang <jasowang@redhat.com>
Cc: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, mst@redhat.com,
 shannon.nelson@amd.com, sashal@kernel.org, alvaro.karsz@solid-run.com,
 christophe.jaillet@wanadoo.fr, steven.sistare@oracle.com, bilbao@vt.edu,
 xuanzhuo@linux.alibaba.com, johnah.palmer@oracle.com, eperezma@redhat.com,
 cratiu@nvidia.com, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Carlos Bilbao <cbilbao@digitalocean.com>
References: <20240903171514.201569-1-carlos.bilbao.osdev@gmail.com>
 <20240903171514.201569-3-carlos.bilbao.osdev@gmail.com>
 <CACGkMEvHU0VnOEZbVnEr1SvmOF5PhMtKk=M2o7Wwq-DUO9p7Uw@mail.gmail.com>
 <faafc28a-23a9-4dff-8223-1c72acb42443@nvidia.com>
 <CACGkMEtZHnkBj2JKaEp=7xURtkUFy=vFQEO8LZ7z7hoFafDMVg@mail.gmail.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <CACGkMEtZHnkBj2JKaEp=7xURtkUFy=vFQEO8LZ7z7hoFafDMVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::14) To CY8PR12MB8297.namprd12.prod.outlook.com
 (2603:10b6:930:79::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8297:EE_|DS7PR12MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: 1819e0f6-6dc5-45b7-0b8b-08dccd09d0ea
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?RWZJYzdNdjRIdUg2UGczRFQ5b0dreHI5K2R1TkdseWk4MmFUaGZSbVA1NHVx?=
 =?utf-8?B?RXNxUTVNL2UvQkthMjVVeXEwcGQ0RVFpSWF1cGV2UUtBVDRWeEEreUt0aHZi?=
 =?utf-8?B?Nm9JM2NOMEQ5cFBxSmxBSHV2ckYxcmE2WkdGVyt6SFV6M3VWSHFqQk81VmlH?=
 =?utf-8?B?Y2t3OGlBaUJDei9ud09QQWhxd25YOGNqRkV5REw3VStiRzBPRHh4QjB6M0JE?=
 =?utf-8?B?MmNBVStTeC9laUwrVUtxZXlRTHFiaEZEMWdZY1lMSXZLdVhHYngvNkZzU0pS?=
 =?utf-8?B?dW5mMkNSZWNuVjdJdU5ac2k5L0NWbktmTlBvcHBZdHhJYStENnI4ZTlGaFhp?=
 =?utf-8?B?S0FKV09BTnRVQ1VsV2FSaUhJaTJXY3JIQzdQMHZsa05wazljMGUvdVo0VnNK?=
 =?utf-8?B?dDNWTnUwQnlxcVBEZ0ZmTjA3UXZUWFdCcG14aURsdkNlRUk4UjNZUVdFWVQy?=
 =?utf-8?B?RkQ2aTJ6dVpPOGU1QmlGdk55QXQ4ZU4xVmE4UVV2a1lSVEM4TVlLOGpVQ0V5?=
 =?utf-8?B?bmRUcFlhcndtZ3lsSEhBZVcwajFicUZUVURmNnBMMGhPQ01HM0ZwcUhyRlJM?=
 =?utf-8?B?T1lkQTNkN3QyT2dRMUpGMG9JUGdJYzVlR3A4MUUrREF0YWZPTWZLbW9JREtE?=
 =?utf-8?B?dWZ0UEpOc2xqSjJqUHJtL2ZlWklRQWRoMGN3SEZaU2dBd1FLU0ZxUEppbG9s?=
 =?utf-8?B?RE9UZHJ6SnZDczE4RHNWQytKeTdqMFh6ZzVRZ2orYWhyRmFjUG90V09qK2tx?=
 =?utf-8?B?elpkcjNGcHg1Ui9BRitxNStiM05iRmlWdHlxcWFSZGF4ZGJWYUc3WmRlTjRs?=
 =?utf-8?B?Nzg4S1E2UVVHazJBYUd3RzE3OVNVWG82OEhIdGl0ZzNBWUZrai9NbWpDZ3M0?=
 =?utf-8?B?a0xpZHRvUkM3aStBZWdOcWV4bHlkcXhHRkFIRzVRQ2xXNk1ld2xaUjJKb2Rv?=
 =?utf-8?B?b2FnTjlEcUViU1UwemUwVVB1YWFEd08vdUdQTnpOZWdyYXltVDd0NXlMQWU0?=
 =?utf-8?B?SWtGTkNkL25ld2dtVDhtMU9GOU9sYml4K01wbithN2dMMjJ3a09HUjFEYXhi?=
 =?utf-8?B?UGpVdTJHSC9uRkNUcUw2L3hDYkJTaXBTVUVPMnpXcGxLN04rNGZJZnlQaFdy?=
 =?utf-8?B?QlhZOHJRYVZtWFAvQjV5NTVwMGlPdmd6a2RBQlFRWWpnd25jUUw2WjA2ejV0?=
 =?utf-8?B?Q3RiZFRFVUNaRy85OW1wejVNQVc0MElTbU9SVjU2bjJHMzFCSStTYlVDS3Yw?=
 =?utf-8?B?MUV0Mk8yeWVEcW15dFV1K3U0VkVLbFZoaUsyRlJrRUk0SnNpRnR2TE1uNENO?=
 =?utf-8?B?UHZORG1teDVvb1VHRnRUSTlZU2t5U0xzT3JmbmttMGdDYXFzdFB6THFEVXVY?=
 =?utf-8?B?VUZ0a1llQSt0WDBBMWxqR3lGMUFKUDhtaFFhR0FDRm53c20vUHBiYXk3QzVL?=
 =?utf-8?B?ZHlzeE1vMjBzeUlTeE91NTk2QnNpc3I1c1gxMVh6SVo5UElXSE14d1BZZHhW?=
 =?utf-8?B?cURkVFl3bXEvY3NIS2Zxd0VnbStBRlhZaHZVQkowUDdCTVJJMFN0MmNXdDBm?=
 =?utf-8?B?cEpuQU50dFoxenY0cU1sWHkvc01qaFcwYWdqM0IzeTVjczcvTWZKNFM4Ymlk?=
 =?utf-8?B?V29jQXhwNytBWnJuSkxzVnA2SUt3YWZyTmtuRmloRFhqcDhtRmVRaG5LMU54?=
 =?utf-8?B?UWdRNFZJSUprNUNvSFY2NGJyY2Yzcnd2NEpmeCt5T3lRYUYwdTJDdEhyRkJX?=
 =?utf-8?B?WmEyRDdQWCtRM1ZLVzJoRWR6UFdlMU42ZnFDNW9QSDcvN3MxWHJTdTdqZGNU?=
 =?utf-8?B?cm5jcVhHQWtiVTJ2VlFVdz09?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8297.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cmZ1RkhmdVZSdGNXVU1NaDNXdzR0OVpadVVYVXFjYm9ZcGRwcDJZWHVZSUNt?=
 =?utf-8?B?eGJZRXlXQ2x4NmYrWkNlYW1BZGZ3QVlVdmNLTERwVUpjZFZlQTA0S3p3c3Qr?=
 =?utf-8?B?S05pOWhHdkhoNWF0Lzd6QU5GbWRNaTdtWWprOFgxVys1ZWl5M2prdDMrMXlp?=
 =?utf-8?B?UUJYYUJza3pzVWdOQ2hWMXYwdk54bU5FNXhZNW5WQ3I0c0tsVjRSdk1qTTFq?=
 =?utf-8?B?R0J4M0tGRytIeGpQNHNpU0I1Q0FWMExhQ1pHSVZRL3UrZ3V1bnp4WEhFbGdx?=
 =?utf-8?B?eFA0TG9ISkcrRjM0UXBjWXhibEdDWVVmU25NRUoxSnpmbXlFaExYWVlvVWlI?=
 =?utf-8?B?NkYrbE5tRnVrYlA1YjduT0JCekN1eGFPU0I1cDhOSTFBRUFXR0d4b1JpRzFP?=
 =?utf-8?B?c0loaVhqWVRzTzRpZldLRUw2MDJHd1B6NUpvVjBhSkVsaklQVUVhS2pYTm1i?=
 =?utf-8?B?TGhxUVJ6TkFBdWhpeS9lOG5FdDdNbFhkbyttRk5HQXhsNzc0UzNCcWQ5NUIv?=
 =?utf-8?B?SUV1Q05FRzVJVGt5NnNVZ0FhdWVEZzYwM3VLTFJGdVdiMDZJcVF6bDJBdzlY?=
 =?utf-8?B?TzUyNCtNdG9zc1cxWlhwdVJtV0x1dFBMY3YzMWNCR1B5V0JsbHJNVVZmMW5J?=
 =?utf-8?B?V2tMVk02ZHBRVHBNbWVwa09MUElkemZXQ3FKNThGcXdLOW9XaGZ3aXhkK2VR?=
 =?utf-8?B?QXJ3b3JuUnVxbFNCWXAyeC83VlBHbGMva3VMWks5ZGtoQ2w1UnRVK2lzRUZU?=
 =?utf-8?B?d1JnbzNpU24vMVY4MlhveU9McGd0MnE4QTFITUNmUGdqdmE1cW5MUjJXNmZ4?=
 =?utf-8?B?OXRLN0o0MXNtVi8zU042NVhpK3lMc1hZNVhzdStwd0N6NnRTVGhKMXBDbFRa?=
 =?utf-8?B?TUdvUW1sc1pqOXZFd2UwUU1vRnhmRW9QdHcwM1VFUXNxMmtrcWhOZHIyYzRp?=
 =?utf-8?B?akpla3lkaGVsb2l3TXFOeFlRYXczcG1HZk9OeFc5Y1dPMnNyeDNMb1lkeUor?=
 =?utf-8?B?SWlnK1FFOC8wWHJMYlFnYlQ1SzVlTGRId2xDYXNMQ29RWW9BVXhWZmJYUWMv?=
 =?utf-8?B?aHU0NXpreEJGNXJkU09yc2JvTDhqZUZ1UkF0dWxJTkp4ZVA1R3A2ZnBOU1JC?=
 =?utf-8?B?UmZJUitKY1ROVlFxMXhNRzBjSTlnbVZySE8weGE2MlRMRHl4MUZ2RWttL1hW?=
 =?utf-8?B?RjRGZjdYaHJIUU9PWTIxeVcxdnd4TDJ6aWdaZ0pnL09iV1ZOT3JvdjJoWGlT?=
 =?utf-8?B?bU1PaG1UM25FU0lIaVZCM05oanFDS1hCaWZhVDFWYTFIc3QwYU9SMjMvOWdy?=
 =?utf-8?B?WmxoVmV6bDF1OGxyOU1qZGYyR1RHU3hGVUV0czlycTkzNGJDV25IL2NHOUZ2?=
 =?utf-8?B?eHJIN09xRTRQWTZjajdKOFE3OVc3eHV2NmluVkRRbVk2V3dKWXRiVU1CM2kx?=
 =?utf-8?B?MW9CcXdRRXJNUEVZdDE1ZEZFSEdtcmV1N1ZIek1TdEFPSDRLMXRNTFcwcVAr?=
 =?utf-8?B?bnFKNlJPdUR6ZEs3S0lEeEVkRURqVEFtYithdGc0SlRlb01Ca2RnVGJ5aDZ4?=
 =?utf-8?B?ZjErY2d3UWsyMEgwV0hWYm9EaWZOTWdMa0lZT0NyTi9KR2hYMWZMMXNCZnpS?=
 =?utf-8?B?MGs1eDFEWTBUV1g5TnZNRVliTXhDdkRQY25wSk94RWk2b3Vlb1NnUzBITDNs?=
 =?utf-8?B?V28xb3lINTQwUXZDbHBOYTdrMVVZY3BXZ3dMTE1yOXVCbWxubW54dTZQNVVT?=
 =?utf-8?B?cXVFd0tOcURoN1luUHNPS1NuQXppSUp2WHJoZ2NjeVB6K2ppV3BaVzlQT0NR?=
 =?utf-8?B?N1EwdnAycXpPWG8zeDZKRTl4OXc0disyWkRFbkNwcEFxRFdSd1FMK1NlWk90?=
 =?utf-8?B?YmpLNjFRYWI4RjZuTjR5Mnp4RlF5cUFqWlkweU54Z3ZrcDJaZWVZVDRScVNR?=
 =?utf-8?B?cDM1Nk50MlUxQ1JBb2htOW1XVzM2VEN1RVFIcEJnVUtRVDFydmxqYURHbjhi?=
 =?utf-8?B?MWRRUFBETkt5TEltZHZ3SUlrZnc5NmNzdXdzYXV2WXFVSVhSajlUYzA1RGtI?=
 =?utf-8?B?U3hrWFM5VUpQWkpWM2xMbWtEQWdVMGRIOFY1UFJNaW1FSlVLZFl1d0NVbkFn?=
 =?utf-8?Q?4Dzoox8gZW84nVVTbFHJuoSkv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1819e0f6-6dc5-45b7-0b8b-08dccd09d0ea
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8297.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 17:48:42.6509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DIaG6IBbLVTi0HVg4HerhUnbiZHIkL+SxzpscPNxlz06HILE7MpC3TmqYteLCT0MfhtAGFlby7MLppePbYEhZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8082



On 04.09.24 08:34, Jason Wang wrote:
> On Wed, Sep 4, 2024 at 1:59 PM Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>
>>
>>
>> On 04.09.24 05:38, Jason Wang wrote:
>>> On Wed, Sep 4, 2024 at 1:15 AM Carlos Bilbao
>>> <carlos.bilbao.osdev@gmail.com> wrote:
>>>>
>>>> From: Carlos Bilbao <cbilbao@digitalocean.com>
>>>>
>>>> Remove invalid ioctl VHOST_VDPA_SET_CONFIG and all its implementations
>>>> with vdpa_config_ops->set_config(). This is needed per virtio spec
>>>> requirements; virtio-spec v3.1 Sec 5.1.4 states that "All of the device
>>>> configuration fields are read-only for the driver."
>>>>
>>>> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
>>>
>>> Note that only the config space of the modern device is read only. So
>>> it should be fine to remove vp_vdpa which only works for modern
>>> devices.
>> Just out of curiosity: how will this work for devices that are not
>> v1.3 compliant but are v1.2 compliant?
> 
> Devices don't know the version of the spec, it works with features.
> For example, most devices mandate ACCESS_PLATFORM which implies a
> mandatory VERSION_1. So they are modern devices.
> 
And modern devices should not write to the device config space. This
was discouraged in v1.x until v1.3 which now prohibits it. Did I get
this right?

Thanks,
Dragos

>> Or is this true of all devices
>> except eni?
> 
> ENI depends on the virtio-pci legacy library, so we know it's a legacy
> device implementation which allows mac address setting via config
> space.
> 
> Thanks
> 
>>
>> Thanks,
>> Dragos
>>>
>>> And for eni, it is a legacy only device, so we should not move the
>>> set_config there.
>>>
>>> For the rest, we need the acks for those maintainers.
>>>
>>> Thanks
>>>
>>
> 

