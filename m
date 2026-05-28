Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B4535CBCB
	for <virtualization@lists.linux.dev>; Thu, 28 May 2026 23:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780009888; cv=fail; b=KppDcfHHjNejxrrXmqMd/RIdYCjJWNLBWd5vO7GdgJ7Pp5odeUCG1aTx4O0QD1wPm4RTM02nEbHoVFqzWc8Xf4cvfMz2JJSYKgARcZuYr6BJpQYnyCjYJFyDiP00BryDji2PVPMBSWrRDsqdALFleyYsS6+TpAetJZv29A49aZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780009888; c=relaxed/simple;
	bh=VZm2wHz8nPaqdbdbnOsnfgDek4Swt6WWpkRdsqMuYoo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=brQgNKzATzPF7NHJNzrzfrUYsEhibqCPzxN07Zu0N2bhQHIKRC7kTvP11f/OuFr4rY8WOaP8UpUj8cJlxTrqaS1DETRwIh+mjXm3JRohrxuFMIXN5tgLznTgPugV4pNrPntxYZP7wAFBCfdZwRZzD+xshwVxPjA0DNhmXu0k94s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=isF2aYHk; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="isF2aYHk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780009886; x=1811545886;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VZm2wHz8nPaqdbdbnOsnfgDek4Swt6WWpkRdsqMuYoo=;
  b=isF2aYHkYZ3xelffN4kd/GHzn1IPBZedPf4QNlqbaOjStmQ3yKUBza+j
   NF57/Qpr+4/FUXvKpOiuAaQh/KIjc8WrBC7AVcajvQMWM85NWY/+J6X7q
   BFSIna4fG4WIQN72xpANEdXsvv/xUKl/qe+jar0S7vVRIthDtE+ieQxlG
   oskALtxMmyW8EWAjlqS85ESbSwxYhIxNyHts274rr8b5FQN9bzk/2av78
   hm30mSKAlPXuRC3CGrJksCA2+uwC74q/n/N+yxA7Z2YEDPxu5/Z64paDY
   M/htpNAHAWX8fDai01ejdkgCcyr/g9OuANJRYeuAVBlqKcMTKlDnX2NHL
   A==;
X-CSE-ConnectionGUID: pi9wzl5MSkOtkTXswmcwzw==
X-CSE-MsgGUID: s0bC1GRRSqyMTFskmAeiTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="80975886"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="80975886"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 16:11:25 -0700
X-CSE-ConnectionGUID: IyY5CJaNSMOuKRhTLFMuOg==
X-CSE-MsgGUID: jYMduZTtT9aWQq9A+VD/Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="246695472"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 16:11:25 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 16:11:24 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 28 May 2026 16:11:24 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.27) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 16:11:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AHCvo79qNv9RaOSebECjCtFNlcVnuLtq/1Yfq705JyXUP9incBNKJFcQ59rTI5vpZ2yWYbi/nJgurJLzMlZ5xnXxfcuxnvBMeMwSvxaMfCtRdjEdHgzH9kKeNOEjKBKoRoP1tN2Y8LmjaKrmDfbawtTg0ikmcFCSHq8ZRjeHI6cbcOGetlHmEdD+HzvRh9Cx7Wooqu7FsL/fv7Y8RKIJuY/LejAT6jmInn9byPd7256ox9dcTq+3Ah889cWVzfh2sx/dEQlRqtDc/XSyf8orcnaYKEEk09Svnn7qEUoYTyL2Rzb5HMmwJxpaHGH8yPKbc3IEEGguaf9aTrSP/Cv0PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ytHz+vtgtZNUsjMfuwAdTcFxhnFLbQhxMs7nvWoEmA=;
 b=y+fX82Cq0oBx+HK81OwN8JRnqOhdoMyH0bK3ZPfgd7XXyB0yd9WIN0eDUmKKkuMN3i/JhRiEcv9FIoLxou4NXVNsOYPdqxvI2bxsjeZC5WQmyWMTjcKiuN6zdIF9kF+rU/21ji6vDR/ivBnKD8aDagKlz93EN2TF2Kfe+2p5R6CGP5a/H17zqxVVbBtG8akAVk0MfWxG+k4+zzuY47L8AGlc7I+V51PeeCCoNI0oUbJ2kmpYTK4wTWBXtt8HO9k+Y412zbUiGZygx9BrdSXe5Ov2laX9xIxe5SSXTPx6hqOU33oWAa6E1c1c4YWzo3xl/lIUMoRqAJfGmBiPlQx1Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by CH3PR11MB8187.namprd11.prod.outlook.com (2603:10b6:610:160::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 23:11:20 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246%4]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 23:11:20 +0000
Message-ID: <94b53854-d98e-4ad7-8421-f062c521d0b4@intel.com>
Date: Thu, 28 May 2026 16:11:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] x86/msr: Consolidate rdpmc() implementations
Content-Language: en-US
To: Dave Hansen <dave.hansen@linux.intel.com>, <linux-kernel@vger.kernel.org>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, Juergen Gross
	<jgross@suse.com>, <virtualization@lists.linux.dev>
References: <20260429184517.7E078510@davehans-spike.ostc.intel.com>
 <20260429184527.E9C6895C@davehans-spike.ostc.intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20260429184527.E9C6895C@davehans-spike.ostc.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0233.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::28) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|CH3PR11MB8187:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b83eb06-e027-4ede-c663-08debd0e6d8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: RtRcPSKm+FwhJOWjaNXDG7whEMhS9EqrxxpjiS+q1gUUfK8kGC1ydhvoqjGj69Wxv4MrNXfWFJMXqbJdhNSGyIq7Nx/dltWtWGOg2oqTuUEov+6L2gkCE2nTllvPf76PCij036Y7zWJlTiTuLRe9WbK41pgYaSZ19k45N5Zz9Ef7xOSIHNKLX7VF63cXwvXJ2poll+jXtz2d8JdGp4P+RR+RuS9X1kn7LL/65AxAW/2pgqLkhq74mhbykg5i0KkFvYfE5UuF/B2BDN9uhsaDYstA37zCmfB7mc71mqiHbAh/qbrvfQ7Ez2Ug9nnXbGEngV3UnfXgERMKZIBfqh6QFGnvghngjEkveFf5+N9kTx+99AdjOIUnHTbefvy+TNgxTAQnp7I3IwDDZ7lG+leWGTXUgWM7PxrcMOoyK6J87bFkWyo/SUYe5x18S4mHSIgoF7wj6Dlu5Av8o6xAFbTOdyTO9xdMK4xc28W0IcRNATP0qKI2hyin/m3fGxWSHbdKA7VY7NmEHcHmjmxJpjQJx64ulZ3pACyVf8BbticIE9kLDJCYr1QDIsp81E2HiLCxtO3EQleZJtBdPhUWI/5HJ7F4KMBPj9bf/MMjDPrQsJKcDY18+fx/M5Qfu9DJD1TUshv28SoQR83A8sOEqGMBHeHoyjLas5ilzGaORMvWoA1A6qqgBkGhjvqf1SwrZcCY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1dBVVpHYzc0Tk5zckZnMHRLdzhaYjBwM1U3OThwRzJEVm9PeVNWblJIRW10?=
 =?utf-8?B?VnFjTVZ2anRuYis0NGF3elNPYmdFeEFselNuUFJOTTRiMXJUbXVkQ0J6a3A5?=
 =?utf-8?B?THdhb256WHB4b3RubTNYa01KUWJ0WmpiM3dxdTZqamJZaUNFV3ZveDBJYzhL?=
 =?utf-8?B?UWNIbGdiYk5vTFRNWGhMWGlYNk5aQlRRK1o2L2pUQzlZdXkvM01JRW5rYnVI?=
 =?utf-8?B?YTZYU1FpTXZsaVUwcFoydm9vcjh6YWJuL3lhZEhGVmg5WFJORE1XYWhmZHlr?=
 =?utf-8?B?WnYzTjg0U3pyN04yU1BVRDd2QmcxTk5ZV1dqQmdhcjFibHZhSGp4bE13M21O?=
 =?utf-8?B?TzdjcWZTcXQ1clRxcHJZRHo2di9qY2JPMzU5a0ZZUmhONGRPTDNpL2hyZldz?=
 =?utf-8?B?VytzNlNHOStreWhXTG4xMjArZjk5L2hGZ2VzOVY4anZDY20xUmZ5Q2lLbVUz?=
 =?utf-8?B?ZmplWW5hUG04VWVldEZIcmltL3hUOGMrbCtreG8wZ2d6ZWNQcTJaRloxVnNh?=
 =?utf-8?B?VmVUUEUzNElpSVJXaFA1ZjlUVnNHOVp6SjBiU0xUYkppZFNuSG5ZNjByMEJs?=
 =?utf-8?B?c0YwQmJLRHlDNERVUGxFd1I2T3haNU41K3NYaUROQW4vWnpOQWJvVEtVSkRV?=
 =?utf-8?B?MjQrRVVmMmZPK3kzdzBjVDVaYkkxUXg3YTRoZ3JHNnZrWVJ5MFArSTI1WUJ2?=
 =?utf-8?B?a1d4U3BBbFJhTGplYTIyWHpmNVpOdG1aNXRyb1hHenhKLzV0TzRTQW1zemMz?=
 =?utf-8?B?MUYrMTZwOW5oVmFmWDlXZXFqdWdDelZHYm8wYUtOZ2JJN1ZLaVNnMFlzQUlz?=
 =?utf-8?B?QXAvUmMzeTBqU1NrWC9XYVRBQ1l5dnkrcVVzSDhTYWtwaWkrcklSOXJGUEh3?=
 =?utf-8?B?WHl6REZTQnBsZkdMWXp1VjJ1YTJjaWtPaFdrdWM0RWxENUhLc2wyYzJoSmVI?=
 =?utf-8?B?YVBHSlUvRHMyWXE2MDdhTEVkbXF4WFhMam8vdC9nbTE5eElFSzhHcU1kRWhi?=
 =?utf-8?B?c0xiaUNidjROOVlkRUw5RVVZT0F5WGhXdkxPOGlNY2IyakNrUWhhVzVKTlVM?=
 =?utf-8?B?TlRxMjJybmM2WWVuazdVSmlwR2dFQWVmWDQvQW1RZC85UFhDN1ZPYnBvYmFz?=
 =?utf-8?B?WDFhVWdocVZ1ZExrRzgzRFhyTEVhNVdWTmorR2NNQnhURmxPaE0rbGEyQUtP?=
 =?utf-8?B?VVYzTTUxT3dRTlNoRC9kb29sR2s5UTNGbWsxUGlLQUt4SVduWHoyM1BYbEV1?=
 =?utf-8?B?TFMyK2hMeWw5MzhaVVp3RHRBNWNrYXVDM3lnSWxIemJHVDR5RXJDRFBJaVUz?=
 =?utf-8?B?RU5Dck9SUmtzbmR6MTlrMEFEYUtQU2hIUUtaR3haM01ZQXEwaGNTN2JWNVAw?=
 =?utf-8?B?WnlpbEZwYzd3bXJxcUQ5S21TWUpld201NXlrQm55ZTR5RVZOc3dORXhMSHp3?=
 =?utf-8?B?dGxSa1lJMEFaVUxWZy81bkU4TUFCcm1aOVY0ZExYaE84U2V3ekFEUmlZN2NT?=
 =?utf-8?B?U0JlbjlCOTg1QW95VG9FVUd1YUNTTHhLVkdSWmgrcTI3TnI0eXdhc3dYNDNq?=
 =?utf-8?B?cjgyQWdEMzJJOE5DY3NtTzB5MUphbk8rSjJSbDYxYi9aTU5wb0Y3dThjL0Jw?=
 =?utf-8?B?NGg0MFpVdHFkWit5UHl2ODF5eEZQR0FFaXpRT1NnQi93UDRsdFRBVGpBaWVj?=
 =?utf-8?B?ZFhTZXl5S0cwQW5yOHJHbWhMMUxSaWlVZldSbFZMdldqRVdLM1dvd0M3N291?=
 =?utf-8?B?T1puTUE1dGZFVnpQTDNRLzFIcFB0Z2ZHdFVmbEtNUUlUMTR0M0pRZnVSOWdj?=
 =?utf-8?B?NFROeTEvNXltSHJxN0plcEtNNitscVV1ejlTTW9XSldESm9FQmtpQjd0dE1p?=
 =?utf-8?B?ZUp0eEtHOTIvcEpnT2szS3lxT0ZqbkRjS2xCb3B3SEdCSkRCSEhYUmh1SnFI?=
 =?utf-8?B?RG5ucDNBWlZiQ1pIUWFPMG9iTCt2SjZ0RXZFd1RtcVh3SHROK2pRcGxYVmEr?=
 =?utf-8?B?MXFCOVRicHFLZm92OWF0T3lHRTZnM2grSU9HMnZYTUtPZVNkQm40YUtwQWEw?=
 =?utf-8?B?MTRMWklUUFp3SjRpbUhVZExTS0lkU2xZdjNDWDdudERnZGp3ck9TSUFUU2hI?=
 =?utf-8?B?T1BOeWFZM1FnYWtLOTROZ0poK29vZzl1YWJQNGNDcEVINW1vWGMxTEFyQlkw?=
 =?utf-8?B?Sk5kTDdWaytMeUR1WUtGT3VNdVdUcjV6UDlZMUxIWFFOL3hjZFkyYkJzY3hJ?=
 =?utf-8?B?TEkwK1czUGlkMzhxS0Y2RkxNbUtrQVl4dnkra1BWRDhGZiszcjlEN0xyR0dv?=
 =?utf-8?B?bWs5dk9oWFArTFM5N1JkeCtHNjZMR2Y3RXYrVlZvQ0UzeEdzZDZMZz09?=
X-Exchange-RoutingPolicyChecked: qHtq8FRuKx5rauwiQbEHNqggZ7gj5b01Fv8cVxflE3TN7hj/9SpejLXNvOoeUGfD1tbH1nfjx6aOuu+2gjug3MIsJWIWrYx7fqwqPPxkgAuQdC4yOlMazcgKJazuLkmmOmsKHu0XyYMTuOqj5PQmukFI6GQD+CqOVsvQLFNgs697zKcX/fovomilMwgz9t91CVU8dTTC7DnqXFA+4LGBNi9vfu988aZGX0op79nuwJ1NAnKJQyvA69ZevTSpuD+C2wqqrlGY37s1BC8QWdqZcBHl1KonE32EEoEWVrensjSKrcPEQPLYx8gZCY9fU33GlZebbC+HT5t74g9T+310Tg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b83eb06-e027-4ede-c663-08debd0e6d8a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 23:11:19.9850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c+kmGauC9vg1XpogxkZNJ8/rhXIDzWtgRDtzOw5EqKPwz45EiqqNJfVGbUerecpBtgpz6sRb7ZJuB5/lS8cOMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8187
X-OriginatorOrg: intel.com


> diff -puN arch/x86/include/asm/msr.h~rdmsr-dups-9 arch/x86/include/asm/msr.h
> --- a/arch/x86/include/asm/msr.h~rdmsr-dups-9	2026-04-01 14:32:58.366520634 -0700
> +++ b/arch/x86/include/asm/msr.h	2026-04-01 14:32:58.373520897 -0700
> @@ -179,6 +179,7 @@ static inline u64 native_read_pmc(int co
>  #define paravirt_read_msr_safe	native_read_msr_safe
>  #define paravirt_write_msr	native_write_msr
>  #define paravirt_write_msr_safe	native_write_msr_safe
> +#define paravirt_read_pmc		native_read_pmc
>  

Extra tab.

>  /*
>   * Access to machine-specific registers (available on 586 and better only)
> @@ -186,11 +187,6 @@ static inline u64 native_read_pmc(int co
>   * pointer indirection), this allows gcc to optimize better
>   */
>  
