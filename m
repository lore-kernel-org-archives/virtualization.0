Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E761BF301
	for <virtualization@lists.linux.dev>; Fri,  2 Aug 2024 07:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722585397; cv=fail; b=CAIbkZzxTRPdljnhvF8lOh8WScRStyuGpTrR336xOy3Q2ZeevzWulcwAM0PXVrg7iprMG2p/lj5gU19yz5riQyTlKMmomVDgJZEnDDniA7vR9kzb+A6i/BrqRdVKVb5jfpTKYI2JlifX2bCMwI5m1HOxK4td9jhYY2t3IqYOCI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722585397; c=relaxed/simple;
	bh=eBTL8F6IvUm5j6JA4xRFr35VR2phNAR45C1+rG3Shxw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O8qbgTkY9ufzvB9Soc2GbC2lOtf0w2L21feSkRuOc9P8UfsGxgJ7kxF3oBj/eheeRn9J6flFAvcT+T6qKco5nIfDCFQGEDDjiNaQuQYXd0TELC1h4soTvYoxSHfyk9JIyD4/OFnMBM82t3c8AJCIQyo0wOTJYvHSj/jxoaIIVok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RD/sXFhT; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RD/sXFhT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722585396; x=1754121396;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=eBTL8F6IvUm5j6JA4xRFr35VR2phNAR45C1+rG3Shxw=;
  b=RD/sXFhTV6pCqly9x3NFDH6AYzES0dB0f+iyr5CSJJSqTN22t+A+99Vp
   FyaJJ0gD09cmcTFXNYh0SHc4j+90WmKzKvHkRSlGVHsrbzWTOjmNM+6YE
   mEB7ROLH+8oHyG9S0xGG2xEqsePoH2VVHaoTb9UVY58XcFGH0WKzGBOL3
   R1/Z18M6NJ3Nb9TVEeBc9xLL8jVni/DPHNNtTrVDmDCzB5GvqNGoR7A81
   EXzB3S5/DBZLm9NEwPD/cjP7xWuyEx+nd/Y1dGolb/ooXUDjjxGcFg7ab
   iVzFkf/nhCKEAkmr0lLh0RY2mcgjR2bsCu+olc6i62ALMgT/foYJMBDPj
   g==;
X-CSE-ConnectionGUID: 2H/QdINpTAaUI5xXmjQzag==
X-CSE-MsgGUID: NdLzxlVSSIOKxH9V8ce+aA==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="24376608"
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="24376608"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 00:56:34 -0700
X-CSE-ConnectionGUID: XOryMfWHQXKi/fa7ZX5YMw==
X-CSE-MsgGUID: E55GLVCpRjelnuhA0aPC4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="55243794"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Aug 2024 00:56:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 2 Aug 2024 00:56:32 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 2 Aug 2024 00:56:32 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 2 Aug 2024 00:56:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFEDSfuCeBtHT4+n13c/hJZGErXOrgAk5E94DvrEszuxFHtV/RPgyzA4jaH4glVWtNkhpxVUBlKKcHZbuxkcfJBeTOuCb7wm0A/qy26G4x/n1RZGw5IUxv+cAubxdOkbFlHKZEcdAvNOdk/telWmdPzWs+TPg7WW1K7SuY0Wa/ZCwvqG2P13n1fUFthC7UuiLWueRe+3jxx3dHFk648VCz8Rzvumb9wT6N6QZ6w49lqgIFMy8Ks9NkaiFA7dyiSU7t41RbnX4bgz/L02SaS14jSYbNNgUUdazYBAlokOnVxHihQfWJUzLhqqGMH/7Ly0er+HqOY4W+DczSk9Q4hiEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSqwVd6D/XLybF+t6on7Gk2FIlm3RhCoQeSnxvzMU9c=;
 b=jvpaQXamy7xD7b4ahUnuDAyYnHYw2GKOmvzXxKq0e80+OX4eZLnJ14Yc2EVNDeICYZY8sjfOCcUJBLXvcDWxugTg60u4VoCSYXpPm8C2gtAMonlQMP6k4AoC8yUlPPL73WhK7jLIBTg82VLE1Lp5uSV+WMLsyknVkb/e1TmJOc8kbgUWGSjdsDRIbFQyeGc8Dy0qyotO7ge/yZOGfT5yyJpsiWHh4Ik9+hHlb24Qu9iaCFtppUERHeopehLYTOTLLciIGBBTbhAPIZC08xJsQP1aKcjYlDtn0XPUytIVo4hYRr+leuAT/WQ41Lq930WTvkmrDvB/fT/Jve3j9X+gwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 DS7PR11MB6198.namprd11.prod.outlook.com (2603:10b6:8:9a::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7807.32; Fri, 2 Aug 2024 07:56:25 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7807.026; Fri, 2 Aug 2024
 07:56:25 +0000
Date: Fri, 2 Aug 2024 15:56:11 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: maobibo <maobibo@loongson.cn>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann
	<arnd@arndb.de>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Juergen Gross <jgross@suse.com>, "Nikolay
 Borisov" <nik.borisov@suse.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>, "Prem
 Nath Dey" <prem.nath.dey@intel.com>, Xiaoping Zhou <xiaoping.zhou@intel.com>
Subject: Re: [PATCH v4] x86/paravirt: Disable virt spinlock on bare metal
Message-ID: <ZqyRG7LNx0RMD98e@chenyu5-mobl2>
References: <20240729065236.407758-1-yu.c.chen@intel.com>
 <4d31e1b4-2113-c557-b60a-3a45b2840f26@loongson.cn>
 <ZqueWhX6lqS+1vwg@chenyu5-mobl2>
 <a3c4b603-fc8d-bfa4-7e5d-0b2d8043131b@loongson.cn>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3c4b603-fc8d-bfa4-7e5d-0b2d8043131b@loongson.cn>
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|DS7PR11MB6198:EE_
X-MS-Office365-Filtering-Correlation-Id: a66c88c2-3263-4ae2-5c6e-08dcb2c89b8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MVFmOWZ0ZXBTWjFpVFNsY3lSbjVCNlFpU1haQ21URWp1YnBkREhHbUhNT3RQ?=
 =?utf-8?B?RFdoL05sYU9XQjdILyszczA1UFM3UU92djBDNEFwTzZ6RzdEdWJTU2MrVkpG?=
 =?utf-8?B?UGN6QVJaRUszOS9UUGdnWDVDbWxZNUt4UUoxQXJLZ0paSTdNTHNVNmpLZkZK?=
 =?utf-8?B?ZTRyWFdoVlcvK2F1M2hFOGZKbEVyVjI1M1pMcXJIUEtmUnFSdmtYSm5zcm9u?=
 =?utf-8?B?eEl6K2tnTzFTdXdDcWxhU0J2VGFLMHJ3OTg5TWR3WXdpYWsybTkxejJtdHY0?=
 =?utf-8?B?NWc2ei9pbnVqUmhuN0NFbmdScEtiZDMrcXFsTTVxdVNjYlZ4VlBMbVlpdXFv?=
 =?utf-8?B?Ull4bkFJQ3RNcVRrd1BxSnUvOVZLcEd6OVFZV1czcXJ6eHdQUTBsOHZSUko5?=
 =?utf-8?B?bXl0MDc2SGk3VnRuOGIxK1pScXI1RVZaZlZ6aDRKL3pjV0loQ01GVytRNFRw?=
 =?utf-8?B?cmhxUVdOVDZNU1NLZXQ5NGJoQWFzSTdwS3pWL3MvNmUzNzE2SXRaMkplRlVD?=
 =?utf-8?B?YThaNk5kU1NQNHJDbC91MGhrN2JTczhNeTA4OGdKeHFOMU1XMDZ5cGRGV0pI?=
 =?utf-8?B?RHl5TVpYb0lBOU1aV2xqNndvSjZnalc4TmZGZjZ2M1g1K05ZekhnUllNYWJP?=
 =?utf-8?B?UW9mNlJMUU8vNVFxeDBXa2Q2ek1jYUlrdGtyaXBxbXF0TXVyRisveE5EZlFF?=
 =?utf-8?B?NXFwbi9CMmczeHZWb01BaE1JWVM5akQ5YkJHNWNCb2hUZWsweDRMb0tiYnVk?=
 =?utf-8?B?eTVWM3BnN3JYYkNqWEs5MFlNL1JnQlpWK3B3Yksvc1lWK2xwcmd5eHYySUNE?=
 =?utf-8?B?SE9ybldyK2J4OTVNNmZiTFRGUHBlOEt6WlZKYXpyZzlNZ2M4MlVhdG5naW8y?=
 =?utf-8?B?UFpON3VUanpRVEtjNmdQSllUbHZzeTA2T0pCWHI0UWxPRFc1MStZTTNNVWRn?=
 =?utf-8?B?eE5iWGxBcEVJWU9OTHVySXVUMUNjSEtqRzRKb21kSEtZUndjbUh5bXBmem8r?=
 =?utf-8?B?ZDdpVDBGN3k2R3BheHcwZlp0ZU9IRkZiZHFmYUI5V2ZqenNXeTlwTmJzMWl5?=
 =?utf-8?B?VEUzeGJqRG9ab1c2d1RrMFpURzdnaTREMGE3clQ5VXFyMVVLaTNxcmZtQkkz?=
 =?utf-8?B?MDJEK2FBaC9aZVRySHZmMnB5djIzTE9EK1k3NkZYd204UnIrL1MxbkVXbzVm?=
 =?utf-8?B?dDhUL1ViTlZpUm1IMTNsODBFbEQzclkyeGtpTmgrUk9BZUlqRDF5dk9CTmNj?=
 =?utf-8?B?RWJvc2VxWTJpZWJOUTFCenBvMHVOU3QxbGxhNFRzTmYya0ttaTEzWUZKOW5u?=
 =?utf-8?B?QWc4U01uKzQ1OGM4TjNPMGtZWmZwbzVkTXdubHFkSkNucllHWlhYSGlmbHpy?=
 =?utf-8?B?OXJwRWtjOEVNRFl3ZW1SWHpiVXFzQUZ3K2x3Z0p2Vk1yTURvbDZ2dExPNGR5?=
 =?utf-8?B?aDlxZnlPNjlUR0pWNW9WK00xUzRqQnhla0JTVWpGNXhIbXZnQ09EN1grcDVj?=
 =?utf-8?B?clp1bktpVDROU0dPSE9nRXRyUjVaN2g0RFpiUS9qeXFKZXIrTzNwR0pxZUw4?=
 =?utf-8?B?L3ROQXdlUDVBMlhqdkpsQ2tOZGFsRmZBUkU4WDY1VlRVV1ZuOTk5eHlhN0J2?=
 =?utf-8?B?R3hkaVJIdTU5OFRub20xV3lEZXQzSTJPT3lFR1dSR2d3S3h4NVRHRVBMUW1O?=
 =?utf-8?B?cTNQYWU1VHB0YXlKSkN3Z3BWeE5IRFlEdC9qc1lGSFNEK0V4WUNIZTI1SmJD?=
 =?utf-8?B?SXBoVG1XbFdNbFFzZ2FMY2V1c2lldGVyb0xOOC90NFVQTkJ3eTF3VmdheEJB?=
 =?utf-8?B?R1NyNkh5UjFxNHJxcjRJdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHVLeXltMDlrN3FvdGFzQjBpYUdWODAxeHoyT3lQQTdyNEsyNXZsT0NLWVFC?=
 =?utf-8?B?REllbmFMRnFFM3JtVEI3d3F1aGZsWWFycTBUeHZWOTNqYWJMUlNnTEVZMmEz?=
 =?utf-8?B?M3ArbkVaVll1TE16c0FPR0RjbG1vQkk4RUNBWmVreTd6Q2ZPdkNYSXZaTnRz?=
 =?utf-8?B?SVlWZGEwU3k0TmFjLzlid2c1eUFrMHhmNHpOZWt0Q252Ylo4Zm9KSm5GMVVy?=
 =?utf-8?B?NVlEVEJmcyt0Q1B3QlpaRjFUclZWZUgvRjdyeUtTaEJjSnFlVVVwVWU2MW9P?=
 =?utf-8?B?L3prSDJvNU1ZNVhtOGVFeDkyclVlM09UMkhGcmEwSjB1cE0weVNjYTNST2Ez?=
 =?utf-8?B?TmN6TnRVQWR6RG5OTzArTHdteUJyMXB4QmF5Z1I0UGt4c3YzeTkwbEcrS01p?=
 =?utf-8?B?TFJyU0xBR2RKeHpTMGRUZ3VpU0VYWnpLM3RJRFhvWHVxdzJOazdqS0tidVYz?=
 =?utf-8?B?ckYyT2ZwdGhNSWRYUEkxZnNXNUdzam9WWlR6TTUxUEpEb1dYL1JoVEE4aEd6?=
 =?utf-8?B?QXVWa0pPM0NSY1BOZVRMZW9WMXNobjJsbDNlVVIyY1ptL1loVmJDZG5HSENW?=
 =?utf-8?B?aHU2VnRKSDg1MzNDOWhTYTdsRXdsTVdUcDIyR3R3TFlVVWdzNlF2a3F5VXll?=
 =?utf-8?B?bXZCT05UODdsRVF4QVBXNmwwN0lvbWNHekdpbHlML3dzakxpbFF1ZHpOTUlq?=
 =?utf-8?B?L1pXNi9pclVIVzRMUERPa1dtWnE4VjhMcFphQjk2c1J1Q2dmbTV4dWx6L1pS?=
 =?utf-8?B?cjFJR1pRc1NaWitMdkQvbEVxUVE3K0NyQy8yK2d2VmYwN0pDcnJYNmQzL2JB?=
 =?utf-8?B?MzZySXFvK082TUxpZkRLZ29mUm1kczB0cFpPZElWQXc4bWxDVmpjS2VLdFkz?=
 =?utf-8?B?L2J5d08xVEIzQlNQdFdHQkpSNHp5TTJsNllUWVF2aXFJalhLa1VKazk4d3R2?=
 =?utf-8?B?SnljT0Fma1ZwQTNaUGROTjA1YXo2RnRlbWN1eHF5aERvQjQ4VThxTFZDYVBj?=
 =?utf-8?B?NWgvc2g2Qm54Y2lWNS8rdmtiZ3pmOFVxdjgxOXFnekdMTldQcTQzU3NocDBv?=
 =?utf-8?B?UmJMb040TGhreFIxREpwU1VFanA4VVJRVWd3MGJVd1c1NU41REJONDVxSTJR?=
 =?utf-8?B?NytJamNjNXhLVHpaVUp5RktWUlRGbDlPTEtydnFMOU1vb1ZiNGE2YWdaNGdp?=
 =?utf-8?B?b0lia2xjZHhRdFpPWHg3SFN3UnJpZ3dob1FJb0xmanR1ZmM4dXg2SkZzNThN?=
 =?utf-8?B?WnVyd0x2V1Y0eTNOeldTRGJQVks1TmpEbW9vaG54TnRLTjhuL1JnR3dyYnpB?=
 =?utf-8?B?QjJuQzZFZjM1SSs5KytESzJQVXR1cjA1bG43VlA4OUtYU1Z3QnZtRVd4VTNS?=
 =?utf-8?B?YkFwaStVQ1JRQVl0VGNSOUhyYk4xTWtwRTdrUDZJNHRpdmpNTmhMMHJ1Wi9F?=
 =?utf-8?B?NHd5K29BbDJJblR3cEQvZ1VXbmkvN1MrZTliaFhUN3ZBcE1sMytwb2VNTlpL?=
 =?utf-8?B?SFNkM3diaVBHOUZnNms2N1oya2t5SVM2akJvbkVhM3grR25lbmFxUGxCSGdm?=
 =?utf-8?B?aTZCWXErS2JvcytRM1ZxTDRIVXI5bEhmWXlIK2hBVUJUbFdtNDV6aGxNTDVr?=
 =?utf-8?B?OEU5bkFRMEJPVUxDbnBOQWs3OEtncFZoZURiRnhyVlJRUWk3M25JUjdHNUxx?=
 =?utf-8?B?VVpUOE0wUmRoOWtWSVB5WXJ5S093Sk1WOXN2OVgreWhod3hWMUJGY012Y3Vi?=
 =?utf-8?B?dTJEQlJVL2RCS0hNbUlpUXRCaDJMNWwvZHlVN1l2TlFTZks2dW9lUDVqNlpS?=
 =?utf-8?B?SDMwOVd1RWlHK3JldmFJR054TkJ0OFJpWVk4elk0Y0lXLzYvQkdTQkFEUGQ2?=
 =?utf-8?B?WEZUMU9nTUd1eGE4cTEyN0xDbEhTcTFQSm56Ukk5Q0RoT2o2Yk5HSmJCQnNh?=
 =?utf-8?B?dkRmd0NuQ3lnME9WOVFmK2IwR1Z1V2RPNjFiNkxwOEVqWEFnTTFmaS96NHRK?=
 =?utf-8?B?ZHFtWnVRL1NuU0RNdStaWUVldmlJSktoSHBCblM1UXNyRjY3Tm1xWi8vNHJm?=
 =?utf-8?B?MlowMEx0YnZjbDVMVU1BTVBUWmNsZ1ZEZzh1K3BxN2hvYlZDQXN1anIyQjJF?=
 =?utf-8?Q?+XqgcIw2Ac46ZTtjZKlDAEXQp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a66c88c2-3263-4ae2-5c6e-08dcb2c89b8a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 07:56:25.3784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GpGgGD0egnuIgN2pfsYhwk2pMLAcieFZ7Kca/Dss0h/Xkp4zSwpJZ/c0BNhZGVeDANzG5ph+DsJqUoOfVoiTnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6198
X-OriginatorOrg: intel.com

On 2024-08-02 at 09:27:32 +0800, maobibo wrote:
> Hi Chenyu,
> 
> On 2024/8/1 下午10:40, Chen Yu wrote:
> > Hi Bibo,
> > 
> > On 2024-08-01 at 16:00:19 +0800, maobibo wrote:
> > > Chenyu,
> > > 
> > > I do not know much about x86, just give some comments(probably incorrected)
> > > from the code.
> > > 
> > > On 2024/7/29 下午2:52, Chen Yu wrote:
> > > > X86_FEATURE_HYPERVISOR         Y    Y    Y     N
> > > > CONFIG_PARAVIRT_SPINLOCKS      Y    Y    N     Y/N
> > > > PV spinlock                    Y    N    N     Y/N
> > > > 
> > > > virt_spin_lock_key             N    N    Y     N
> > > > 
> > > > -DECLARE_STATIC_KEY_TRUE(virt_spin_lock_key);
> > > > +DECLARE_STATIC_KEY_FALSE(virt_spin_lock_key);
> > > 
> > > @@ -87,7 +87,7 @@ static inline bool virt_spin_lock(struct qspinlock *lock)
> > >   {
> > >          int val;
> > > 
> > > -       if (!static_branch_likely(&virt_spin_lock_key))
> > > +       if (!static_branch_unlikely(&virt_spin_lock_key))
> > >                  return false;
> > > 
> > > Do we need change it with static_branch_unlikely() if value of key is false
> > > by fault?
> > 
> > My understanding is that, firstly, whether it is likely() or unlikely()
> > depends on the 'expected' value of the key, rather than its default
> > initialized value. The compiler can arrange the if 'jump' condition to
> > avoid the overhead of branch jump(to keep the instruction pipeline)
> > as much as possible. Secondly, before this patch, the 'expected' value
> > of virt_spin_lock_key is 'true', so I'm not sure if we should change
> > its behavior. Although it seems that in most VM guest, with para-virt
> > spinlock enabled, this key should be false at most time, but just in
> > case of any regression...
> yes, it does not inflect the result, it is a trivial thing and depends on
> personal like or dislike.
> 
> > 
> > > >    /*
> > > >     * Shortcut for the queued_spin_lock_slowpath() function that allows
> > > > diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
> > > > index 5358d43886ad..fec381533555 100644
> > > > --- a/arch/x86/kernel/paravirt.c
> > > > +++ b/arch/x86/kernel/paravirt.c
> > > > @@ -51,13 +51,12 @@ DEFINE_ASM_FUNC(pv_native_irq_enable, "sti", .noinstr.text);
> > > >    DEFINE_ASM_FUNC(pv_native_read_cr2, "mov %cr2, %rax", .noinstr.text);
> > > >    #endif
> > > > -DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
> > > > +DEFINE_STATIC_KEY_FALSE(virt_spin_lock_key);
> > > >    void __init native_pv_lock_init(void)
> > > >    {
> > > > -	if (IS_ENABLED(CONFIG_PARAVIRT_SPINLOCKS) &&
> > > > -	    !boot_cpu_has(X86_FEATURE_HYPERVISOR))
> > > > -		static_branch_disable(&virt_spin_lock_key);
> > > > +	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
> > > > +		static_branch_enable(&virt_spin_lock_key);
> > > >    }
> > > 
> > >  From my point, the sentence static_branch_disable(&virt_spin_lock_key) can
> > > be removed in file arch/x86/xen/spinlock.c and arch/x86/kernel/kvm.c, since
> > > function native_smp_prepare_boot_cpu() is already called by
> > > xen_smp_prepare_boot_cpu() and kvm_smp_prepare_boot_cpu().
> > > 
> > 
> > The key is enabled by native_smp_prepare_boot_cpu() for VM guest as
> > the initial value(default to true). And later either arch/x86/xen/spinlock.c
> > or arch/x86/kernel/kvm.c disable this key in a on-demand manner.
> I understand that you only care about host machine and do not want to change
> behavior of VM. Only that from the view of VM, there are two conditions such
> as:
> 
> 1. If option CONFIG_PARAVIRT_SPINLOCKS is disabled, virt_spin_lock_key is
> disabled with your patch. VM will use test-set spinlock rather than
> qspinlock to avoid the over-preemption of native qspinlock, just the same
> with commit 2aa79af64263. And it is the same for all the hypervisor types.
> 
> 2. If option CONFIG_PARAVIRT_SPINLOCKS is enable, pv spinlock cannot be used
> because some reasons, such as host hypervisor has no KVM_FEATURE_PV_UNHALT
> feature or nopvspin kernel parameter is added. The behavior to use test-set
> spinlock or native qspinlock is different on different hypervisor types.
> 
> Even on KVM hypervisor, if KVM_FEATURE_PV_UNHALT is not supported, test-set
> spinlock will be used on VM; For nopvspin kernel parameter, native spinlock
> is used on VM. What is the rule for this? :)
>

If CONFIG_PARAVIRT_SPINLOCKS is enabled, the test-set spinlock has nothing to do
with the lock path, because if pv_enabled() is true, it will skip the
test-set spinlock and go to pv_queue section. If for some reason the pv spinlock
can not be used because KVM_FEATURE_PV_UNHALT is not supported, it will fall into
the default qpinlock without pv-qspinlock(no pv_wait hook because it is NULL).

thanks,
Chenyu
