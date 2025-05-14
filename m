Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2047.outbound.protection.outlook.com [40.107.96.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EE822615
	for <virtualization@lists.linux.dev>; Wed, 14 May 2025 13:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747230362; cv=fail; b=Olldt4BMPDF8IrFHWqiSdoIq5iCnZnuVu04ZglTor0skAafHYRtYwZKl8u0PPy2/qRdmyAuzMPObpi4rngYolB+zyo0rV7U2cM7kNIfPFRKr6cqcWbhDB53Uo8D8aS2X43y682DKAaoiGvihfP2C1Q8MdT1TZOvvWIH6DT6KD40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747230362; c=relaxed/simple;
	bh=FWgj0xEFpFsjIrTiE0lQJXq/D7/somvK0MEJ2ek06z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h0k/ADD/iVEH4KvCo4txIs0I1vXCOKjRGxbq7FuzAZWT7iW9RQQ5NLKhLzNdSfzttjcRFeLvYPnONviCMuF/k3DWmDCYMW1h5QRs/me+Z3FdphmbtwBrMw+JpTl3myWkb0cwuDM8rYeRAQYYEnywOUkJQyev3XM0KjeIHohupAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qYNcgkMH; arc=fail smtp.client-ip=40.107.96.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qYNcgkMH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMjMVKWmoax9Cr+jOyc60LsgTDUaw8crOhQaYieAamd9Az0t08nz58jBCO3GW6mcvecvFUCCLRVFmyobNpdSDOgrM6LVIHn6b8XoM4fnfhbnQ++ZHIzBT3OKaaktS2sA0Jmi42lrjsCNGTYG5M5dZD5LXVveOvEZ8Q7Tv6s5U71THa04YX1qG5k9oEBsHNUWQ49k4dUiQfTN5NyP3uRnKi5j4W+Fewd2jcVh9rHfyu2VdgLwRudWuQECQM2p0Dk7SBw91flceVt38Hb4CVIKIudLg75Sj3pzesNj5ye7Jw9tCFdUiuya9j3QTJOfonQJipEkXTtIfAcZOfyZzr481w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DBqlMwLT/KdOAEkK8hZ9lDGAyo0esv/+q08SIWsWYw=;
 b=MnOUAYn1/Y+VKW70exEG2fJ+PbHcXvAb02HjYN7t8emgv55m8Rao+KC8hMjWAS9MwzdtA3zrMh4H0kYEeTFvXbRvpc3IHXP9HqtrBfQ51d9yIXp3v1k4Wr9CqBN7Ofu+S2WK7ORfRcOpVvnrDkn1fO5q8yj9QCxrD0m6QVH3QzCs+p+60zN9oF1OaDGWJ82LLCUpZw67X1gmWF1B6BKBXuG7CD3zgrZDI7AbGhQlxVo7NZB2yv8NKDHG6EtPqaFRVktkEBIkbk8A2ReqNktbI8f+VAReLzmgAetZBp1bReT5hHw7sCHGeKIRwr7rguwH36Lq/SsaHs64tC+WRkpnSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DBqlMwLT/KdOAEkK8hZ9lDGAyo0esv/+q08SIWsWYw=;
 b=qYNcgkMHkmANJ/GCR78gJPmJdyP1KeTNjuUDjx3rDsEIPdbslb6BOdXi9ZXLppRFY8T0NI4DsUcheY9pEcH5oRw5UI+sfekPclaIRjBwCcs+sAE3iDCSRDzisZEL5GqloB8SUzQOdKc0lnyVRHqXmmwLEAs/pdktcq1eUpUa/Pt6pNZi4aCy2FH9wve2M61N0xhhqrAPhGx5SOVUAkNWU49/NDQkaG3qHbD/q3SmUnO6jva/snaa4A6APsYoJpIz2xkQiTfVLVQVvw4Lk635eU8zaljsHOIsEUiQCUxbRMwnfOVlLdXuxAtqqrG0/X2S1N0465KAwHYDaZFe2JBiXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA1PR12MB8555.namprd12.prod.outlook.com (2603:10b6:208:44f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Wed, 14 May
 2025 13:45:54 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 13:45:54 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH v1 0/2] mm/memory_hotplug: introduce and use
 PG_offline_skippable
Date: Wed, 14 May 2025 09:45:52 -0400
X-Mailer: MailMate (2.0r6255)
Message-ID: <4B7FCC74-EAB2-426B-AFE0-4250FE4F7480@nvidia.com>
In-Reply-To: <20250514111544.1012399-1-david@redhat.com>
References: <20250514111544.1012399-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR15CA0004.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::17) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA1PR12MB8555:EE_
X-MS-Office365-Filtering-Correlation-Id: 14cce672-fb4e-49c0-3cd1-08dd92eda5a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2xkMDFvY05RbzlrVW5DQS9QaWRzbWNzb29meU5Vb2hFeFdrTW1CSFRmMWN3?=
 =?utf-8?B?cGJNZnZvRFJ1aXpLeGVremdlZHBEazcydEZiVlFFQWp2VDBQclRrbExidURy?=
 =?utf-8?B?RVZSd1ZHZGtQendKV2FZMGhKZGE0SzFIYnppdUgveVcvSzYvL0lkVkVXWU01?=
 =?utf-8?B?TlFjYk5jYzU3bHhGQkY0T3RMMUl0c20rTS9XYld3RDRYb255YWM3RTRZK0NP?=
 =?utf-8?B?WkFvTldOU2xRc0lqVXM0MmZBdXlYS2M5TGYxR2RoT2dZOHFnQk5jMHBoZ2tL?=
 =?utf-8?B?VVVaOGxyRnRoelUvaVBzUzhRUStHZjg0QjdqR1lpaEthMTk3a0NXOVJxL1hp?=
 =?utf-8?B?UFp5UFkzZGRINFM3MUtBUFBiUjBtYUR4UU9TVnliNlNXaktvcEJTUURjeUNW?=
 =?utf-8?B?MVAxVWVLc2J5S0ZET00xQVBsZUp3ZDJqc21neWx2NUNBQVVmU3ZCc0lRRk5P?=
 =?utf-8?B?L1hyZWJnU1ZJQmhVSzljbmJuMG9vaEVhRng5clp4ZkRtQUl6bUt3K2hhVXZG?=
 =?utf-8?B?Q0lBNWg4N0tIOGdPRFVzWUhIUWhjNndUeFVzcnBEenMxdkxEaExIUXZvRG0x?=
 =?utf-8?B?RmZDSUoyUjBrTUQ4NWE0bC9sblhSNS9JMmV2d282eEUvRGtqMk9RVGZQbnls?=
 =?utf-8?B?WlJrMzRMRVg5NG55c3dodmJ6ZzNTclNkVTVOUGRZRUkvWWlwTnN0eU1Famxz?=
 =?utf-8?B?QllJcFhMbW1VNnZrZjFPenNSOWQySTZRb0NvS0NDSkVoOGNQNWNWY25hQnpH?=
 =?utf-8?B?U0tQbDhMejUrcnRQVWx3dDlrcXRHcVNRdm9ib01nWHI0alBGNkhHYVFneENW?=
 =?utf-8?B?dlBsdlFRK1dwQWgxTlpBWVpVT3BFNmNHMEs3WGRiRXl0TDhxOE5kSFNtelB2?=
 =?utf-8?B?eWk5Qk9XR2V6NlJMUnp1b0dnOFRZUmN1NmFYdkU2ZTJncGpsZ0R4dFQ2cXJO?=
 =?utf-8?B?NGZYa2RwcFcrT1F4WXZiZUF6aFdZZ0w0dTJaMW9BU3BSU21GajhuK2NzS09u?=
 =?utf-8?B?ZHdsMkJqSTZ3d3c4MndqL0pxWit0M0JMYVlUT1ZXS04rN1BWNGFScWNnamdV?=
 =?utf-8?B?R21UWUFTWVd0UmlDOGJWcUhhVEpvUGJwNjBlKzFGcGtRY3llbW1oSE1heHhv?=
 =?utf-8?B?aUxUTzVNWm4wV2oydWhzZ3JBb0VORDA4ZGRxVW80ZVdHd3NNc1NKVzR0MkpI?=
 =?utf-8?B?N2dMa25WeGRqMGtRdEZBY3ZHbUhyMTdHRVArSS9nS0c2VzdGaDNTM3V2SFZ1?=
 =?utf-8?B?ZWhZT01JYzd0clA2elBUVDlWTkhMQ0pUVEhuVXZNN05SYi9wRHNFemRINmRM?=
 =?utf-8?B?TGZrNEF4MmprTTRKUmo4cTk1cmdxT3NidTJnQVZQQ2FCVncxUHZLcGdLdnA2?=
 =?utf-8?B?K0p4K0ZxN21iVFU0VDBBbnBrMVBseFl0YnhESTlCS2FkV3BCRE96NlVDb3dO?=
 =?utf-8?B?di90UDFxcjNIeDBVQnd0TkxJRXlKc3JMckJ0K2lqeEpFbkNqeDZ6bUV5MjVm?=
 =?utf-8?B?V21yaFROdjBWckpLOFdJSWs0aDY3ZVJtc2I5MDR4SFh4Qm1vc1RpWUhoWEJw?=
 =?utf-8?B?eWh5ZTR3RmRsRzV4bFRiOGpWVWdjYnNpdzYzTGJjWEdrYUdQSXJyaVBGMEh5?=
 =?utf-8?B?UVYzelZhekJRTDlXVys2MHVXdHQ1cDVHZ0ZVbXlxS2RxR1YxTmdEN0xtMVBq?=
 =?utf-8?B?VUc5WjJGV2JJbXlPU2dzUDFNVFhPVkphemJ0QWVBdHB5VUtYY2l2QnlIbW15?=
 =?utf-8?B?TXB5citpamZ1MlFnOUdXWThwUlRQL2xJVlVhQmZwVzVmUHZFaTFEU0IwZURt?=
 =?utf-8?B?ckw1bkkzcnh6blhpNTZZUnMzZnBWQWt3T25lSjV4ZnJsMDJnVW85ajg2Y0dJ?=
 =?utf-8?B?UFBTdzNmYmdGSEFlcnJGYkNnOTB2MzJUNUNaRXJCTG9CTTBZN1NnUi9acUsx?=
 =?utf-8?Q?mtskrMz/oNA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGpZaVBjNFQwbys1NXhIUVBGOG9ZNzZXcTRJbzYzbUNLUGxiU2RDdGZRQXJI?=
 =?utf-8?B?S1ZaTUlQMkF2dVpoQU5GNWgzMXF2Z2VLVlBBazczeDloVlNFenI1djl4M0Y4?=
 =?utf-8?B?cHEyalB4c1JrT0ZrZFVLaWsxNWJVeFp5ZjJPMFhNU01KcEZHT2J3ZE54SEww?=
 =?utf-8?B?RG0yRDI1TW11OW1ETmx5bEE2Z2hLMU1idHJUemdMK01lWGQycEpJTWd4Wm96?=
 =?utf-8?B?ZGszU01hNURoOUVQN3orRTRHOFNOZ2pKREZFSnRHekF4VmNFcU5wZ2ovaGxx?=
 =?utf-8?B?Ti95b0V3NmRIOUZwb2NuS0ZibktjbG9SdmlqaEVMYmdxdzBkR2phKy9LN3Ft?=
 =?utf-8?B?RmR4TjQwWDlYeXV3d3FMYkx6eDRwWEMvOEphUjl0QXNNZWxHQ2xWUE93RTgr?=
 =?utf-8?B?dzJUcDIyc1cxSWt2aHlTdW9CQUFjbFZINE1aakQ3SHlHYmhwUUhjNFR6UnF6?=
 =?utf-8?B?YURvUDZkdVprSXJRcUdPWDlLNlR1ZWlmQUVWM0FaTTIybUJIRG1JOFNodVhB?=
 =?utf-8?B?UElzK2VNUEdNZy9rYUs5ckx5eFJxR3NoenpWS0piWHBJMng0OG9DaGtWTXc3?=
 =?utf-8?B?bmkzNXVJam5abTVMOFVKUDBuQ2hadC9uQjZTMmlFM29EYjBVRmVJT2tWaElj?=
 =?utf-8?B?RkFiUExDaG5JbVZEWnRFaDNkSnJRTEhrbDE0R3VHcWJHRDdKaUlLSnA0WEpV?=
 =?utf-8?B?UklUVmhhWUl4SmZXOE5mMnk2V3R2S3NtNGZkSjg4NXp1OCs1TFpkSmRiNm5U?=
 =?utf-8?B?VzBYbVFlb2cxaDFTekhuV01UWHA0eStZOWRnaU4wQi9vWDdtQkdmR2tzaWdG?=
 =?utf-8?B?OGNGTEpoK1lVS0tUMFJaWWFKTmdqa25adTM4VzRBaG10ZzZ5NHJ2citieGUw?=
 =?utf-8?B?ckxUL3ZuOG9seGlLa0VhMEpMS0NWYUF0L3FCM1lpOU5kMSt1YktSYllDNHBX?=
 =?utf-8?B?MC9YbmRWblNQSkRRcnpuNmM2cHV0Rm80ME5VR1BkK1h5ekh4dHJrS2JRblRU?=
 =?utf-8?B?WURxR0s3TCtZaG1Eb3ZZUVJNVEtMc2JCbHBnWUxqZUtQN1dpdld4TXhrQ3Bn?=
 =?utf-8?B?bTdvZngvVHhVNWQ4ZGIzNk8zUjUyMS9aNE1VZ3NkZC8yV3N1T1pQenVZYnFS?=
 =?utf-8?B?NWk4VE1TV0NndnZ4NGhrckFwdnExTnZVVjZOU21EQUhpdzRhbDlmSkIrTGNI?=
 =?utf-8?B?SWVXSUpNeEpxS2h5cVRSVkVSaVJyUjlWMTY0NDVWN1JydTMzQWloWkhWTkhL?=
 =?utf-8?B?WFB5REpvaFpQb2t4OEVxL1VhdXNuemM3cjhaYnFyZWxWblZ0Qk14ZVZQbEZn?=
 =?utf-8?B?VHB2OEtud0FMUmYyUkxoZ0YyMDF2RlUwOEQvK3J4UTlLMFZMcWNYTEl3RzF1?=
 =?utf-8?B?S2szYktTVzV3aHlxQmRzYVYxS3JVSFRQRmN5NkUwR0hKWXdyMlMyNThQTVhn?=
 =?utf-8?B?YndkZ0xTMUc4TnNFdUtqeC9QN0lGRnNSRGMycTZkbzB6b3J0aTFCdTZRTVpm?=
 =?utf-8?B?VElCenFRM0I1WU90QkdDWFF2ZkxyVDRnZnFubE50VGVmbk5oVnIwcmszelZZ?=
 =?utf-8?B?NGtBRzZyVCtFQVhqTkkxYTNpWTROcXRPN3lRTGlvWUo3ZU1vRVU5b3lNbVU2?=
 =?utf-8?B?UEp3WElKSmtMeTZuc2VoOEVLU29LbU95ZkNabjViRjZRelFlaFpKMFdnRGtw?=
 =?utf-8?B?WGdzeHd5QzJraXlhRkw1bHpPM0RCY2dUa1BkMmlmL3FpTDBacmF1Q0hibnpy?=
 =?utf-8?B?L3U5RWJNRW1TSjRsVTNEYzBCOENWUFRUY1N6cXZJbVpNOXFudnNUb2tUd1dV?=
 =?utf-8?B?dVRGclg0SE5zb0dDZ0ZKZW9HSkZBQUZWZHlnMU5yUmcyQlhwK204cXlmOXVx?=
 =?utf-8?B?VG5aZDlmbFdCZVR6MzdMdlptQjBZblBDNUJ1MlFaMUU2N3BvaXhSZFNPWjBo?=
 =?utf-8?B?SVlKL1JUZEtIVFRHQW5YUmxHZHZLL3pyZHErRWVtK0N0cFRGRi93UjROWndz?=
 =?utf-8?B?VGxGVGppdU4xdytvNGUwWlM0NlRLUHBJMHZ1MURZQTd3eVgrOHJ3WkpvUHhz?=
 =?utf-8?B?V1AvT3VTb3N3YmpScGZlY0s1YmE0aXYyZ1N5SVRHcGdWcHZCUGc2VjV3UFdi?=
 =?utf-8?Q?OF4/Uq6Uuq5QrotBEu27brZN5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14cce672-fb4e-49c0-3cd1-08dd92eda5a9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:45:54.1850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RFlwi0aEhwcF3nXNppRkH1SFqM9i20dgO0Anl0Ou68jbVPqCjXrA5YvBbNhpsMjs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8555

On 14 May 2025, at 7:15, David Hildenbrand wrote:

> This is a requirement for making PageOffline pages not have a refcount
> in the long future ("frozen"), and for reworking non-folio page migration
> in the near future.
>
> I have patches mostly ready to go to handle the latter. For turning all
> PageOffline() pages frozen, the non-folio page migration and memory
> ballooning drivers will have to be reworked first, to no longer rely on
> the refcount of PageOffline pages.
>
> Introduce PG_offline_skippable that only applies to PageOffline() pages --
> of course, reusing one of the existing PG_ flags for now -- and convert
> virtio-mem to make use of the new way: to allow for skipping PageOffline
> pages during memory offlining, treating them as if they would not be
> allocated.

IIUC, based on Documentation/admin-guide/mm/memory-hotplug.rst,
to offline a page, the page first needs to be set PageOffline() to be
removed from page allocator. Next, the page is removed from its memory
block. When will PG_offline_skippable be used? The second phase when
the page is being removed from its memory block?

Thanks.

>
> Note that the existing mechanism relied on the driver (virtio-mem)
> dropping its reference during MEM_GOING_OFFLINE, which is complicated and
> not compatible with the concept of frozen pages (no refcount).
>
> Tested with virtio-mem on x86, including  partially hotplugging a memory
> block (hotplugging 64MiB with a 128 MiB memory block size), and repeatedly
> onlining+offlining the memory block.
>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Cc: "Eugenio Pérez" <eperezma@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Brendan Jackman <jackmanb@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>
> David Hildenbrand (2):
>   mm/memory_hotplug: PG_offline_skippable for offlining memory blocks
>     with PageOffline pages
>   mm/memory_hotplug: remove -EBUSY handling from scan_movable_pages()
>
>  drivers/virtio/virtio_mem.c | 111 +-----------------------------------
>  include/linux/page-flags.h  |  29 +++++++---
>  mm/memory_hotplug.c         |  22 ++-----
>  mm/page_alloc.c             |   8 +--
>  mm/page_isolation.c         |  21 +++----
>  5 files changed, 40 insertions(+), 151 deletions(-)
>
>
> base-commit: 2f6baf8dadecc2bec7d6bc931f7e0d58d8443d76
> -- 
> 2.49.0


--
Best Regards,
Yan, Zi
