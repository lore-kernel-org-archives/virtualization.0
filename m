Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793291432;
	b=WRzC9XCoNBm5Voc310b8EOqTVgL8tQdr2bflOQoH+hKO1WMNEhxdMgmEQywFTsQLJO7W
	 5lUkILgO1p003IYd27xTUOEYKRco4eR/FhP4IvVt0VdZL9eiRXKc9WCS6m7iVmzWWBuA7
	 kOQexEkSMlB3xoR6WRNWejWhLFPoDgEiHMOpavSSzIbykSayz5lloX1Nzu4SOJGPF1k6c
	 3l1tgYl9ZdqZc9c47vsQcqWqIF601mc8jjR7ce7kM0Q+Xod71aGVojN2jpGV7jgHAzEoH
	 InfRBolmN0PG8cJXHN6kPRdzI7r0CEaR2FQmYcmDmT9galnqqLsa5iiWZmdosErOrXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291432;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Ow3fU7PzSqpq9Q4/DhMG8hz2Z6aMLUDTpEpRY8WB0j4=;
	b=ZyPeLumTfvTlBZPurrI/P50u4KZbND0wlLQ6hHnv8Hp8tfoh5kMykiG3kXCIoeM/1Uag
	 VduPNPI+lPAp/oCzFa9PkaPuaOcSbCHL3xl+iio+jttqLv1wEL82+dbcS35Ru8FSMN02s
	 6clnbhzW6OjxmBzT0bR/bV8O03MjAobZWb/FAtIcmuMdZ8BQgzBo1HJ6PeiVddc+SlDZt
	 LW+NUIFasdfYtCxZnwYGiDeOyXhnXsPwqa8hNVXGIpqqYlKL3yBzh3wbDJJuTYgRqaahF
	 eBSMvF0E3y32HSkJgLD/tVtjJDa7+Rl63tTljZhUlwex3FrO4J1LH8+akOXyhkRI/HQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WhloXtT7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.28
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010028.outbound.protection.outlook.com [52.101.61.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A61606A31F
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 16:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03A61606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WhloXtT7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZqGwMyHKoX0x5PPSLK8iUoswUWEhsHrP9hvd2igf4SLfwks7M2x4n+SjCdIGJv1pbCUnb8IiuIXXZStiITM2W7hdpcffrTIFifl7d6V+jHe+B8Mpyaj1bo8euZ8YzWJ48mwF9DsM9TRQ77j1ahV/lMUyRgDEubqYsscNwuqW/VXwwUpAEuluT1Pq2yj70mgrq2Gg9WCYMvTxTVkfV8N4dHqpycG8jTiQkk1DVGt+fzuYXBFnOBZ7eQtp3qAS3mPlPf+wc0H+l0nXAvaIIyQ3vuZKoKpGCxbe07ofSXdJG4mq53GsnQuMMW7yHVejERrD9CMCsW4zUcC9zAzin+Q9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ow3fU7PzSqpq9Q4/DhMG8hz2Z6aMLUDTpEpRY8WB0j4=;
 b=CXpQ1j3dcxS29lYA9OKh4dD7kh7nRrUFqJq/r8zxEU79TVy3rprfhOhcY0ea6tmpyVk8bq1H3Uezt/MfHKkC27gyQ0klvQF1A+6oiBEDwzumea+9DrkGrVjtJWWdqvk584KA0J2NkSjILUuibELvAAE2IHRdvR7qX8RW+ZS88HFPrJfQgnoz+RiI07zFEy+onQ9Q/nnTMzD46wysiPaklrSTd/yhfg5zmpUoYpDPp2Wlx4fxDSo2S9vV+ym5TE7BH6syqk52YQH8wTqZS9OpSbtm9bWRztuNuVeG7yg/DTZh9Baju5gEHZtQi+1cmL5gsM3yiYKLjyGNVvMMAQObSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ow3fU7PzSqpq9Q4/DhMG8hz2Z6aMLUDTpEpRY8WB0j4=;
 b=WhloXtT7eQ9kfcVxNrSQTG5FA78Ba0e2vChR1YR7OolWb4uj4US5qYAiiduSGp+WvhLoorNZBaGqYMMZJnjN27mWaifogtAjEs98ywuQWcgmf2X5XWNsJzeZYk7AkktG7locgy+VIB5wvWBtL6QdK+VICmECg8VgVq9n0Px1hdRdZIPJKD0DUPmk9S3waq4MkIg/RuU5qoOIgZznxFNRCXtHbwMPrJcD9PCxCYVYcsMrjs4qcPCBCexEYYBjN8rYHMkkCFPlo++ACG7teRWoQ3O2v3DFDsuinbgdVqbEsO1fYG6Az7Wfogh+JSW8BW7OMR425iActDw1g3I2PpFYRg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9349.namprd12.prod.outlook.com (2603:10b6:0:49::12) by
 PH7PR12MB6908.namprd12.prod.outlook.com (2603:10b6:510:1ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 16:28:11 +0000
Received: from DM3PR12MB9349.namprd12.prod.outlook.com
 ([fe80::7678:ab4c:4a7d:7f9f]) by DM3PR12MB9349.namprd12.prod.outlook.com
 ([fe80::7678:ab4c:4a7d:7f9f%3]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 16:28:10 +0000
Date: Thu, 29 Oct 2026 12:28:08 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Mete Durlu <meted@linux.ibm.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
	mingo@kernel.org, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, yury.norov@gmail.com,
	kprateek.nayak@amd.com, iii@linux.ibm.com, corbet@lwn.net,
	tglx@kernel.org, gregkh@linuxfoundation.org, pbonzini@redhat.com,
	seanjc@google.com, vschneid@redhat.com, huschle@linux.ibm.com,
	rostedt@goodmis.org, dietmar.eggemann@arm.com, maddy@linux.ibm.com,
	srikar@linux.ibm.com, hdanton@sina.com, chleroy@kernel.org,
	vineeth@bitbyteword.org, frederic@kernel.org, arighi@nvidia.com,
	pauld@redhat.com, christian.loehle@arm.com, tj@kernel.org,
	tommaso.cucinotta@gmail.com, maz@kernel.org, rafael@kernel.org,
	rdunlap@infradead.org, kernellwp@gmail.com,
	linux-doc@vger.kernel.org, jgross@suse.com,
	virtualization@lists.linux.dev, sunlightlinux@gmail.com
Subject: Re: [PATCH v14 04/13] cpumask: Introduce cpu_preferred_mask
Message-ID: <auN0GKVMNvXbNdCN@yury>
References: <20260928053728.797539-1-sshegde@linux.ibm.com>
 <20260928053728.797539-5-sshegde@linux.ibm.com>
 <4605dad5-aab2-49e3-b919-bf9897181834@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4605dad5-aab2-49e3-b919-bf9897181834@linux.ibm.com>
X-ClientProxiedBy: BN0PR02CA0049.namprd02.prod.outlook.com
 (2603:10b6:408:e5::24) To DM3PR12MB9349.namprd12.prod.outlook.com
 (2603:10b6:0:49::12)
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
X-MS-TrafficTypeDiagnostic: DM3PR12MB9349:EE_|PH7PR12MB6908:EE_
X-MS-Office365-Filtering-Correlation-Id: d3a92518-51e9-422f-8f46-08df35d99ef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|6133799003|18002099003|22082099003|3023799007|5023799004|56012099006|11063799006|261026140227099003|4143699003|261021130227099003|261021135927099003|261021123027099003|261021121427099003|261026130827099003|261026135527099003|261026121527099003|10067099003|261021133027099003|261022075727099003|261009223027099003|261022105027099003|261022115727099003|261022113327099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
 KtkjZGcwA04cRAl0uj12K7Jg/LugP8cdwG9iQIRknDbuOAl1c8GOWyugTFxWqbt+Xgr9sh5EGnyaBhMXT5BGifYbLm28g9DMKVRvM+f3b4Al362QoDWRjLqMV8xWJKQxUV7cjg7lllLvAdI0PVwVN+MV8acBOrjWYJWkxZkYoY3buFPZdru3vc+VdCU7MC6U7VZ4g9OKF5AM3GTdcrHH+EXlkdZVN9TwL+67Jgh8kUJUo4M1eJJu0JJ7Z0IBj1gEDL12NyyRJvKRrIH7HRZSKccRO/R9QYpjoGNM/j7zgqPNncFd92JCIRJ1GBwsGcBoV6RPCxb90LsuqgQXV5bL76opRrCACYm0h1bUh/ri3/DBMi2Q5qiBdAcAiXZq4i7jUV0IQvgLB8Z5spkuwGsXnsbL6aBLsehoTp472Cv7IhKgIXQqn4EWqu+1GhZ3utUpZ2So70s/1evJWmQhrxa8fSfatGn35VMkrMu5KyhnUNyWJ6Sx7yI5JKVdQfAPt04n8Q3hjh8OmXOQ5bqXayYfcLpZEV9LyPjV2nUnUFHdjZi2JkUTpgI/qcRtfrAHNknM9MZA6wO3c72FIEZNUXqldmrTPxOW4cZpvkf7XsIiczirX4Jh+smaMe7muDYS5eggtRGwGMEnIy84GIDNL7ZYNPGZCiyMOqBbg1otZKPUVe8=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(6133799003)(18002099003)(22082099003)(3023799007)(5023799004)(56012099006)(11063799006)(261026140227099003)(4143699003)(261021130227099003)(261021135927099003)(261021123027099003)(261021121427099003)(261026130827099003)(261026135527099003)(261026121527099003)(10067099003)(261021133027099003)(261022075727099003)(261009223027099003)(261022105027099003)(261022115727099003)(261022113327099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UVdDTG5FT0VwSHNUZ0d3TEFqK0F0MHZ1Qk9CM1NPOGNvUkZhamp5UHZjNUMv?=
 =?utf-8?B?RUFwL25DSStRWnFSaEZubURnOWI4dlh4ZGlCQXFTZldyR2E2K093YWU2VEl5?=
 =?utf-8?B?cEFMWHgwUzBqQTFCZC9UOW5ab1pPNEhkUmZPTEdNcjhBT0NOYTVJd2MvTSsx?=
 =?utf-8?B?YldWU0YvR0xMUGJMUEFRL0EraE0wOWpEMnVWc2c0UzltdXlPYVNuUS9RcVg0?=
 =?utf-8?B?QjdvMXlzYml4K3lDMGNybm40Z3dxOWlUVWc1RkNUTmQ4NzNrTEp1eEREYWo2?=
 =?utf-8?B?Qm9mWDVWeCsvekFNcXpxMS9INXB1UzBXYU5ob01GbCtRVnlwWDNkV3k5Y0RI?=
 =?utf-8?B?S0haVENsUVBvR0J3RXdWNUt2MnlMQmhHczA0dXlpSy9Od3lZeUdzK3dYVEhn?=
 =?utf-8?B?VnRPa2E5UnE4YXNyOGRLNk9tbUhuVmVrRDZ1Q0RJb0lOaXd1VnVpTjdBZUEr?=
 =?utf-8?B?UmpwZVk3Ukt2YnFoZ3dYS2lIVXhRclhLd3JCUFpYckxUYzk3VVhPeHJjL3hH?=
 =?utf-8?B?U0lUM3c0Y2FRU0FwU2dtbHZhdHBqd21PRjYwSU5lSjVuU2VzZ01JSEZ5TDdY?=
 =?utf-8?B?elJrV1N4bFFERktwQWdWbDlHUmJaTHVnUHVqRktVdWI3MmRXQVlZU01NVjZH?=
 =?utf-8?B?SWRNUWYrb0Q3NFIyLzBYMmdnYUVTTDIzalZxbURGUXRBTXBOeXBCYUh4NS9S?=
 =?utf-8?B?cndOaHhJVTg0TVpoUTUrcFNGL3dRMzUyMGtPUXFKWGxRRjFOWk1yZVN5Q09C?=
 =?utf-8?B?Qkd0OVFLdlp3aDZETmQ4NUhQR0pONzV3UDJGMy90VkNVUVkxSHphanlsRXdU?=
 =?utf-8?B?TWFvbnd1K1l2VVQ1OXhaK3dwSTcrZHMrcWM5K2VmSXhYUzQyTk1wZTdwTzVz?=
 =?utf-8?B?aVo3ZWRMbzAwenpyR05uZVNPQVZmd21wR1hkaDdpbUV5eGhtUnFoWWROK0ho?=
 =?utf-8?B?bTc2SDVFSWxzQUhWVmdlMGtzWDJxaXM4VW5BRUxYZTVCeldlTVV2UjFYV1RG?=
 =?utf-8?B?TnV2Y2R1UWQ1TzdLZEcyb1BPSEJLeU00WEVWYUVjSUVwUnlCMTM2b2dwT2RB?=
 =?utf-8?B?R0hzZ0FLRUFjODQ2V3hlNkJnOTRSSHZpeWh3Wkd1akNrVzdmQUxCN2pCQlVB?=
 =?utf-8?B?bEg3WEtuQzlKUDVDU3lSby9rNTNMTlV1TU9ML1UyTzR6U2J5cFFsaEwwNGZw?=
 =?utf-8?B?TW82YjJ0QnRySlNNeVlwYk5uVGx3TzhDL2NSWUxOK3hEL2JOREFaL2V6TmtX?=
 =?utf-8?B?cERDaDVFdjRiajVsYmd5aHRHSWxFUURlaTU3T1Nhb3lDWlcxU0lXSmkxRmRO?=
 =?utf-8?B?MUpaVjBGWHVtNnAxR3pLcWpONXMzdjJxVDEyYjlqT3k2bFZxeU16SFpMd1gx?=
 =?utf-8?B?RTFGU2llblIxbVRROS9xbVFQMGJBZzlwc3UrRnVnZzhkK21sc1hReFV5ZWlN?=
 =?utf-8?B?dC9wQWRNMjk2M3FFdkVzeDRUSjFKVDhUaHdxNFMxaUJFODR6WVF1Sm9VS2ov?=
 =?utf-8?B?ZHFtR0ZSV2laSlcxU3p4ZGNlWG9MMWZOWWYvOURuK05JMnJZQ28yc3JqSFpH?=
 =?utf-8?B?Z241N1Y3cUFlUE9qZ2hxN3piNHFPSTNUOHFneXVvTSs5clZ5eDBuUlFxR0Yv?=
 =?utf-8?B?eHdwOS9qWmNyK011ZzYxOU5lWU1rck8rSCs5a1NRYnVyUDlrRlNVMFdyTWU2?=
 =?utf-8?B?RlgxRVp3WVZTYitFQzRHWWFrNjY5ZnFKK0d0dnQ0cUhwNWpLbXliMHYxdWhO?=
 =?utf-8?B?Vk9pMStTTCt6MGtIZTl3WmlSalBWNitmQUE2d1I5R2MyWS9SeVQ4R081L3RN?=
 =?utf-8?B?MjRhSFN2TXR2cVJIQ001ZjFLbHRIdzNpN05GclNtODFiNWtQQmt2R1RMQkdr?=
 =?utf-8?B?K3NCMFZYaGxmcktJKzZjVFBMU1c3QzB3UXd2bEEvTy9qSURlRk8yUEg2Z2FJ?=
 =?utf-8?B?NWRTQ2JkNEZtaVJ4ZkJIUmVqaE93Qjk2VG1rYU1vNSs0SS9rRTkwd2dhQUU0?=
 =?utf-8?B?TVFtZmNnQXZDbnVtcEYzcjZZeVNCL1BYUWdFUXNRcmZDMGNOY3BRZmR0MVZx?=
 =?utf-8?B?dWdPaytobXFXb0FDVmFYWG9pRS9MdmpWM3Vabm1NRHdYUlBlQmVOOVRwcW9v?=
 =?utf-8?B?SmN2WnJPaHB4dUFYYlUvd1Z0cVYyWEx1Wm85cGZCTVJValFheDN6ZFNIYUlX?=
 =?utf-8?B?eVFOVk5DWHNqa1NBdFNHSm5PanNVTzUzckpJZnFWR0R2NGcyL0VxeExkaUlG?=
 =?utf-8?B?R21jNzBWa3pBV0VZeDR3QnhPRVRMdjFzb1JOMC9EaUp1TkNQMy9tUGtqL3JO?=
 =?utf-8?B?NW4rUEJ6SkR4V0RDRDlYdWJOVnZhREVPZ0NVdHNqTTdEek5OVHZxUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a92518-51e9-422f-8f46-08df35d99ef7
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 16:28:10.2824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJ2dnIgb4VAglcHQaBTHkmocjEq7dfJlTuPz9TPhugQ1p3X1hj++r2Xx0UN0oz+tXQt/tibqZp+CC4yZeWevzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6908

On Thu, Oct 29, 2026 at 02:32:08PM +0100, Mete Durlu wrote:
> On 28/09/2026 07:37, Shrikanth Hegde wrote:
> > Provide the preferred CPU infrastructure. Define get/set macros
> > which could be used to get/set CPU state as preferred.
> > 
> > CONFIG_PREFERRED_CPU will be selected by the driver which handles
> > steal time values. It is going to set/clear preferred CPU state.
> > This driver will be called steal_governor and it is introduced in
> > subsequent patches. It periodically computes the steal ratio and
> > decides on preferred CPU state.
> > 
> > A CPU is set to preferred when it becomes active. Later it may be
> > marked as non-preferred depending on steal ratio by the steal_governor.
> > 
> > Always maintain design construct of preferred is subset of active.
> > i.e. preferred ⊆ active ⊆ online ⊆ present ⊆ possible
> > 
> > With CONFIG_PREFERRED_CPU=n, ensure set_cpu_preferred is a nop and get
> > method returns the active state in that case.
> > 
> > Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> > ---
> >   include/linux/cpumask.h | 24 ++++++++++++++++++++++++
> >   kernel/Kconfig.preempt  |  4 ++++
> >   kernel/cpu.c            |  6 ++++++
> >   kernel/sched/core.c     |  5 +++++
> >   4 files changed, 39 insertions(+)
> 
> [..snip..]
> 
> >   #define cpu_is_offline(cpu)	unlikely(!cpu_online(cpu))
> > diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
> > index 985aea617cfe..edc067a0c422 100644
> > --- a/kernel/Kconfig.preempt
> > +++ b/kernel/Kconfig.preempt
> > @@ -194,3 +194,7 @@ config SCHED_CLASS_EXT
> >   	  For more information:
> >   	    Documentation/scheduler/sched-ext.rst
> >   	    https://github.com/sched-ext/scx
> > +
> > +config PREFERRED_CPU
> > +	bool
> > +	depends on SMP && PARAVIRT
> FWICT, PREFERRED_CPU mechanism can work perfectly fine without PARAVIRT
> selected. It would be annoying to enable it and implement a dummy
> paravirt_steal_clock() just for that.
> 
> Shrikanth, would it be possible to drop that dependency?

Do you have a non-paravirt case in mind? 

I'm actually about to submit an RFC that drops the PARAVIRT dependency
and provides write access to the preferred mask. But I want to make
sure that we need it, and we've got no reasonable mechanism to put
unneeded CPUs on idle already.

Simply relaxing the PARAVIRT dependency without a solid use case would
bloat configuration space for nothing. If you've got such a case in
mind, the rest is trivial.

Thanks,
Yury
