Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9020C18E35D
	for <virtualization@lists.linux.dev>; Tue,  3 Sep 2024 17:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725385055; cv=fail; b=nkeh8eDirx7qEjYEP4lDLOIUhXqCSjJwWmGKfoiezaq58HuquWdnoayvhVXeOk+wjiMWmwSX8k/NtBk3ADMSqgzrlPGffTh50YqfPtMl3h3NFWQMzvbstNV5WxL0ZLd8r2Pm0MRqA6OQVspT5FDbvt/KvA2stBKrcJBvepoVDvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725385055; c=relaxed/simple;
	bh=HRUCH6frL6uBu4qr7HFTQBdc5Fj5al1dB8/rD24Qe2Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uzAenuhEMJ1Y/W1TXGUnoAtJCxIxU4iJkaN0TvOGJavGTbRE/k48LG/tBzBGZweFwTXJ6i8Pv+Yvhx3oPjmE+bJUO7KZ0Zq8EUVVwTN29HFxsRM2Wp2nKiDhn6TNVrH8Stn60yS8y7+WEfPMXExpr7EiaHjU9eF1MtBREWLEM1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lVuxvnVr; arc=fail smtp.client-ip=40.107.100.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lVuxvnVr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejtz0BRSL5K7e2JQ7mPTd6tm5dvXVP8SOJvRJ7VQFA5O8qP6oEsgHhweVmFSUdo+g3PUtTuVKUjKYqzw42Hi7NUzMyNxvaPFICtnB1fRc6vTD1itV+xXaEpAiGAW2Vt5HhXv1U8cVCo0PBDxx3bz8ZFcMoxbQ1BJRdmVDi+cV7fKFVUmALFwVv1oUL89Rj6qrygdCp3mLktZdVSLKbIbmRnFcaysm/4I62app5UOPAzmLITrFcL984oGZ4QFFKq/qEicGQA0AtHP+fJmGrKXAwMYHR7GbX5eklHfb8eShi0mbT6C2CekmAg4YA2FRF5LePLL9vxpmLUEia06SvXDPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfI6QjYL7dOLa4RhFtlAWiMZXKiw2QYbQYVMa/5OIuE=;
 b=VMbvdC0S5w1x4pa1kHLbgIr//5IDaEbLWlsyOkpQjhS1zYAjNPUjkaOL8bp/Ol9Zi6SFxrdA7q5fFcTZymvI0fmuzAKIkK2MjB3Ot5+Fj9G9ldHy/08krl/9q6R3SWJ3/zVMF3aVe2/igJNdpszucYjHM0d+VBV7PMjvmWabRLb4TPV1DCZXFOB4XOrtqNBt827gpSKny8qSuB6KxwdDBCgKLBwednNVxStlEp2Vm5AKOijGTlzEpwuJpzuK/2hjRTq3KZaBsqEUnd6Z1DpU9RcncCF0rWtE4S71RDPYGxOrnoOmJtEhPm9+2l6tJWdpL1qKHywtgpO3Ms5P1xr+4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfI6QjYL7dOLa4RhFtlAWiMZXKiw2QYbQYVMa/5OIuE=;
 b=lVuxvnVrZsCp/UriR1wdmkPdA9jfLhDE/7ibrdaDJD6v6nHlrAgahznT1VNkHuduEg3zwIp/1JGw+OA9tq38t6eeA/yMqxIX7gQ+91j03xWn1NsORu/exrn/kMlsgWZZTUcqYFDCMv3cdvKr3OX082LqiYHCHQhztxcD0d4ou8c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 PH7PR12MB5829.namprd12.prod.outlook.com (2603:10b6:510:1d4::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.25; Tue, 3 Sep 2024 17:37:28 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 17:37:28 +0000
Message-ID: <3e9a6d05-a76c-4bbf-9f4e-2e126259b70e@amd.com>
Date: Tue, 3 Sep 2024 10:37:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] vdpa/mlx5: Set speed and duplex of vDPA devices to
 UNKNOWN
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, dtatulea@nvidia.com,
 mst@redhat.com, jasowang@redhat.com, sashal@kernel.org,
 alvaro.karsz@solid-run.com, christophe.jaillet@wanadoo.fr,
 steven.sistare@oracle.com
Cc: bilbao@vt.edu, xuanzhuo@linux.alibaba.com, johnah.palmer@oracle.com,
 eperezma@redhat.com, cratiu@nvidia.com, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Carlos Bilbao <cbilbao@digitalocean.com>
References: <20240903171514.201569-1-carlos.bilbao.osdev@gmail.com>
 <20240903171514.201569-2-carlos.bilbao.osdev@gmail.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240903171514.201569-2-carlos.bilbao.osdev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0362.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::7) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|PH7PR12MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: 23542ca6-a011-49b1-6441-08dccc3f1487
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjVFUC9lRmRCN081Qk1pU3R5SnVwQkZVWDY3Ui9iUzJnSU9pazFhRWZJV2pq?=
 =?utf-8?B?RFVGQnBHZWZnNHJheXFoWlUzODNuZU5GYmJ5ZVZpOUJrWWtVRUNtK05MZWJx?=
 =?utf-8?B?UFhGeEsybEFVb0ExNElXREgxaEkzQkwrOHd1c0t5eXFIazBvUkYvL3N4VmxK?=
 =?utf-8?B?Z3d6SW5lM1c3cmRqZDFnM0pRMzdENGRrajB2aUxNSHlWdmxDdFpRWXAxRHA3?=
 =?utf-8?B?OG1NbWFSdXNjRUN3aVh1Mm1lMXlHcnJod1hHeENpTS94NElSVlA0Ylp2czhY?=
 =?utf-8?B?UTE3NFUzSE5LU0JYK3ZYNTJBRWlDVURpUVdyQ3kzMlRFUUo3S2J4STZSRWZy?=
 =?utf-8?B?eGNXZU9ObDU3M1RpNW9ibVFmdlRYZ0pweWVtQkpkZ0VVamdYTmgxSlZpc1o0?=
 =?utf-8?B?Yk1JeGpOMU5uNVdJTlROajhTS1A0TmlsVW5xUGY2S3d1cE1pU1JvVmp0NlFy?=
 =?utf-8?B?QUNZblpyUnNBcmQwcndDV0RYT0ZtN0F0bUREbTRKVHVucTRlK2o3R3l4eFph?=
 =?utf-8?B?MGNkZzVxdWFqSU1KTlNrRWpNZWJJV2Y0OVFUMTR1NFNoTTA5eGRWUDBMcUhX?=
 =?utf-8?B?ZG5RRHNhNldPdTB5Nk1xS2JjdS9kd1E1a3pkaWpqODBlUzJyK3J5SWNKVFEv?=
 =?utf-8?B?clhURmdWL0xobGNvZ1I0VlpTWElXanhRZkJ1a2xuVEROZnRCSHFLSmZBN1lF?=
 =?utf-8?B?T08vbHR4OEtwTGJuQW5IbVBYYUQxWlBBU2k3MVdadHZzbkZydmRacGJQaSto?=
 =?utf-8?B?ZHBaNXZGekNvYkxBMmFLNXJVaS82K2FUekIvcEFBRGMzQ3drcCtVb1NGenNG?=
 =?utf-8?B?Zk1WNTZTN2hKTTlXQXBzM0Q5SWgxZVhRTTFIWTdoVTQyU2R5STZvR2M4M3RT?=
 =?utf-8?B?QmNkaWRrT0JVUy9pT1JoUVdzOXpMQ2dXbkN0Qk1JMS82T3M2VmVzek1zSHpQ?=
 =?utf-8?B?WVdpRTkyclNZVFU2MUt0RnByVlRoa0d3RG8vS08yNkdRUVhnbW9yUzdTK0tH?=
 =?utf-8?B?alZQa2RzQVUxWGI2Mkc5bkQ0TnE5OWtvclpyR2s3c3JXbE54K00rdUZGZGU2?=
 =?utf-8?B?a085RHhvOGhBQTczNGhYSUZOd2thb3d3VlhzN2VzejJlQ09QNGlrYmRoZEc5?=
 =?utf-8?B?akV3R3FWa0k2eTY3S0FpSW1SM2dVZ3dTYVZmZkprZnBvZlVvanlIUHRPOUN2?=
 =?utf-8?B?dnczV3JrRFBGRjdjMnd2VGRJczRiZVVFRDA0dWM3M1BZTXVmQjhhMjVOeHFV?=
 =?utf-8?B?U2JCejJxQnNjWklONkcySjlJcHdaVS80WTg4bmREMTVyb1lBTkdaUWExZk0z?=
 =?utf-8?B?UkNCbVg1ZUt6OC9icFRURlRLdWhkQVlCOXEvRTg5VERPY3RIa3hicVRHTWpw?=
 =?utf-8?B?V2l2SjBocWpxMVBXSEVLTkJlVGw2Y3VOa3h3QVhCYk4rUmU0b2tFUGJXUVFY?=
 =?utf-8?B?WlFraVBpSWZXL29aQU5XZ3E3RVlSYlJoTHFtQmF1UFlRblVCeDV1MC9BaFhG?=
 =?utf-8?B?MFU5VmpIL3lRNTFYMWZJT3E1WXVCczdoS0l0SE9PMnBKenp0dEpHbmtZRDBD?=
 =?utf-8?B?RUVYSzBxd2k0S1lVQTI2Wk1lOU5QRVRPNzBDMUQyWnNUekdQbVRNVHFRSWwx?=
 =?utf-8?B?KzdWVS90ZzdiYXo5cmJ1cG13YXhxQ0NSa0VmY1BLait2U1dkTkkzdW5mUWRF?=
 =?utf-8?B?bnAvTDZVM1ZGVTBtMG8rZFIyMjB4NkpOclBFZnp6czFiVTVrbkhURldCbVpk?=
 =?utf-8?B?YVErSnZUaGZIV2JxSEJUZVVCOFVWU3pKd2RBUjd2YWNtcnNMUnIvRlFhM0Ir?=
 =?utf-8?B?TXFkdjlVdFZsamUrS2VPUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3luTUdiU3FwRDVhSlZMNGowUnNldFVVaTBIQktiQlk3WVhJK1VLQmh1amJr?=
 =?utf-8?B?V0xad3NhblhscG5qNXJ4eUJaWThMNnNKUDk0NUU3ZWlTRjJ4U28vNXZabXBK?=
 =?utf-8?B?RFREK1BYZ2RQZ3RCOHYwRFlNbkQ1S1lER20yL28zK1l3WGtUNWtrZFpvKy9w?=
 =?utf-8?B?emxvMnQ5VWI4aSsrbDI5V1JpdDFIWURsS2lsaXlXOWo0czVxV2MrdTNCZzR5?=
 =?utf-8?B?aXZDREdnV2pNZzZ0VWNkeTYydFp2Rkc4dzZNem14RFN2YjBwVjNhOXppbVdE?=
 =?utf-8?B?VG9CNlZHNi84NU96aHVaMnBOL1NMZ3IwTndaRHZFY1BzdjEycEpRenEvb2sw?=
 =?utf-8?B?cmQ0Z05nUEpmcXY0VEdKRlV2L2JaTjRkTHc5UW03WlNqaW1XM3N3ZEdiUk00?=
 =?utf-8?B?eDdNakN6N0FhTTk4b3pVeDFWbExNVjhSQS9UelRXd09WMnh3TjRQaVM0U2pL?=
 =?utf-8?B?ZmVtN3l1TmFFdUlTWU1EQVZWZm9iWUZZeGZ4MnVnMFU3QUNJdWl0RHdGSWRo?=
 =?utf-8?B?QmhlaXFmQURGU1A3SW5TY3BETllpbUVkMnhtNStkVFBjVU9xU25rMmlxb2xn?=
 =?utf-8?B?b1VEdVhmNWFHUmNIbTZXbVRCekd1Z1BXZWhnU0NxcFczb29ROEVGRGtmYWlq?=
 =?utf-8?B?d29mVDl4SHJ3ZHpHaW15cmpwSUMxRFpmalRwWGFmTi80TjJIQ05zdzlnU0Rn?=
 =?utf-8?B?TVdJeTNNMVcydVRqSjB2MzgyMlpYVW5yTkJERWxUcThZMDZZNnJhVmFwRWZz?=
 =?utf-8?B?d0lLKzZJNXA3cStVOUh1N1VWd21HWTk1czFBNDlneTE4L3VPL1d6RDFKMHJY?=
 =?utf-8?B?eG01OUd5aVAvbXJOMVY3WFBWdjVJOWlLSUZZNERnV3NpTDRMYmhmRU0vRXZr?=
 =?utf-8?B?SjlHdE1laTNXdURINUw4VERWNXNJUGpnVTMwWmdxSjJtQjlnS1pyNlhjdUhT?=
 =?utf-8?B?RzlUUWU3OUhLclhVQXlKSU5nWjJ2MUlXOStBVFJFS1RuZnNXRVliL1hndUJn?=
 =?utf-8?B?VTcybWVIcnAzVVNPcmpaNUJSZHhnQWQvQlZFbzF5L1BweXlwdkhsaVVWSXd4?=
 =?utf-8?B?MTcvZm9Jdzl1UE1xMkppdW9oMFlmUllBWHl0ZUxpaGpqMmc3bWswY2w4K3lR?=
 =?utf-8?B?Z0c4dW1VcEtQSk9oWldaM2hZVllTbldQQmhVUDdRVmVTN25WRWxRdGJlNm1G?=
 =?utf-8?B?RDl2QmFZc3JRWDhaWjllcXRFOHFyaVozTzBQU3h6ODNUdEFrd0pMdTI5RHpt?=
 =?utf-8?B?YUxNc0tFQXVVMVJPL2Q3QmdsSUY2T2lVSXJCM3NHWExPU2ZRQzlaSGUxN2d5?=
 =?utf-8?B?UUl2ODUrLzAwQUdHeDl2ZUZVZmZNRDEwazMyaEZ5czdMYkkxTi9QNDFuYitv?=
 =?utf-8?B?R1U3T29WQnk2L1FZSi85NWVKcU85ZDlURXkvcHI2QU1lTitSa1gzSThhOEtM?=
 =?utf-8?B?MG1PY0haRGIzMEZlNFM5WVRWY2FGVlVUQVI1WWI1UU1KZTBIdzVla3dWL0d5?=
 =?utf-8?B?clJELzhPa0l3dVNJZjltWmNuMjVrb3lHWnR5LzloT1o3bHkzeUU5alhrRXA1?=
 =?utf-8?B?NkFTZk9kUlA0S05IOGJud0VOandjRWd5bEV5RlFBOXZnaVhCY2JSRld1WjEx?=
 =?utf-8?B?V21Kd0IvbFR3SzdrbkV4Mlp3UlN1Yi9iUzNkYkszZmN1QlBTMlJUeDJFNjB6?=
 =?utf-8?B?dHpxYzBSMXRodjFHMjZ6clJETW1Xdm81bVNTWnJCTUgxVXZ2TEs4SnlWTE1w?=
 =?utf-8?B?Q25jZ0I5WTMzSTlEMTI3ZVlxR0ZkSHVDRWJ6Rnk0MHcyN0t1TE01bWNaNnNo?=
 =?utf-8?B?OVh1YjZMSEp6MjNnOUw2RkZyb1hWdU9jWUYzQmppZ2tkY0h1R3ptMDY1R3JY?=
 =?utf-8?B?eGR0Ykw0SjJTY0FGU1N4NGcrV1Fjd20vSGpGRk9YSkVFdWdWRlhZUWx1Uk1Y?=
 =?utf-8?B?NWhpd1JZLytGVUFBTzFLRXNRSmJSSWg3SXdQaWpabHlOQlFhZmFxN2JCRU1G?=
 =?utf-8?B?K1BPd1NiQkFSQ1AwcnFHOWZPaHppUmd6MVQvY2x5ZVAvRVNFUEdYWHFYM0Qz?=
 =?utf-8?B?MzBFQkpETWl0WHNQNGdlTWptaVZtN2pkaE9iT0tXSjF5T3NqUWpWOGJrdyt0?=
 =?utf-8?Q?egcNBQ1rC7kIUUjC5OS/8vqW2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23542ca6-a011-49b1-6441-08dccc3f1487
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 17:37:28.0646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EBgWe8sDtrYpJbHGvsVA72uDZj33/GbyNc/kRNw68pduIRSWaIdasIfkQ/rudWyVm5HQ50lt9ZRZP5MjwX3xjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5829

On 9/3/2024 10:15 AM, Carlos Bilbao wrote:
> From: Carlos Bilbao <cbilbao@digitalocean.com>
> 
> Initialize the speed and duplex fields in virtio_net_config to UNKNOWN.
> This is needed because mlx5_vdpa vDPA devicess currently do not support the
> VIRTIO_NET_F_SPEED_DUPLEX feature which reports speed and duplex. Add
> needed helper cpu_to_mlx5vdpa32() to convert endianness of speed.
> 
> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index b56aae3f7be3..5fce6d62af4f 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -173,6 +173,11 @@ static __virtio16 cpu_to_mlx5vdpa16(struct mlx5_vdpa_dev *mvdev, u16 val)
>          return __cpu_to_virtio16(mlx5_vdpa_is_little_endian(mvdev), val);
>   }
> 
> +static __virtio32 cpu_to_mlx5vdpa32(struct mlx5_vdpa_dev *mvdev, u32 val)
> +{
> +    return __cpu_to_virtio32(mlx5_vdpa_is_little_endian(mvdev), val);

I hate picking at little things like this, but this should be a tab 
rather than 4 spaces.

sln


> +}
> +
>   static u16 ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev)
>   {
>          if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
> @@ -3433,6 +3438,13 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>          init_rwsem(&ndev->reslock);
>          config = &ndev->config;
> 
> +       /*
> +        * mlx5_vdpa vDPA devices currently don't support reporting or
> +        * setting the speed or duplex.
> +        */
> +       config->speed  = cpu_to_mlx5vdpa32(mvdev, SPEED_UNKNOWN);
> +       config->duplex = DUPLEX_UNKNOWN;
> +
>          if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) {
>                  err = config_func_mtu(mdev, add_config->net.mtu);
>                  if (err)
> --
> 2.34.1
> 
