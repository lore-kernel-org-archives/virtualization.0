Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBC61DFEA
	for <virtualization@lists.linux.dev>; Fri,  2 Aug 2024 13:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722606788; cv=fail; b=nAKt4/9u5OSAEg9ionwmUHC2OKGxUAsd9ZRMBrAkzQ8tIPsaJkpDC8gGdJDnWUA4XgFOPIfmgh2fzuF24CExLS1hdFKA5c3iw2MH+6I/2B2y8syEk8m4lBRygacH1E8DYOXVS6SUQ0+zO4MYSRJmb7osF1MUZTaxE6eYqrPP5Rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722606788; c=relaxed/simple;
	bh=wKrnzAkKDR864k90xEM/6Eoh4GKhggHBXTho6IyAhiY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Sj5Jcg1B6TM8uuPBKiTKZF3Dbdgb7G/R6ch+2XjhmQkpZDGq6I93ZVpfVmU0tbtTWz+9rlpI0VP6/SP3bsuVI3mA9ePBsBbWRyDqvd7jGl49j5Q7T5N4diNNQDsezvtqgls2PZib6fUjTMScukMKzVpFlwj1SOrJQbMR/TGTP3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CXo1bCHh; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CXo1bCHh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722606786; x=1754142786;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=wKrnzAkKDR864k90xEM/6Eoh4GKhggHBXTho6IyAhiY=;
  b=CXo1bCHhrSyCAvy8Ob1sTnrLrFazRVkYoDn7s2Xx9iuCWrKQB+/fZeGi
   0DdCzINk8xdCulj6n4PkypnoXH/SgxRnnnAf1Eiczqfur8G1w4psLvJqG
   GTm4i8S4d+0Cq4ZhMQUB10M6iPLVmE7zrW4kiq5wzfEYr8+0H7MtOVphp
   cwdf/zh7B8j9Ey90Ydg91mAK+EK4NThkhuiVRXZJiqXSiV/m7QgUc0U2x
   tXAGWNhYn8QhVaHUnkVCaE7h5JnNw6xxorWDfZuV8wllrzOru3bIFNnXI
   9j5y7XLSFLp0YDoMGEWyM7MAeu4hyt7rH3Oy+LWDVJfOMNjIvNbtyXi8p
   w==;
X-CSE-ConnectionGUID: I+NFneKSQqWumJX0yzUqzQ==
X-CSE-MsgGUID: 6ShkITC2TOqMRjMf6LfJAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="38128777"
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="38128777"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 06:53:05 -0700
X-CSE-ConnectionGUID: 8sQgVTbTQp2sW2twOjbT+w==
X-CSE-MsgGUID: xUPiv95NTpuxlterlI5f9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="55298315"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Aug 2024 06:53:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 2 Aug 2024 06:53:03 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 2 Aug 2024 06:53:03 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 2 Aug 2024 06:53:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBHFspDkErFOzKi7MOIcbGCaRnAPdGka1eBFP4nG7FGPgukWFtvVvSGgBPG0b3RRosmK+9P90Zqo8MtfrT7qSBB1u350DzgtPy8vE6WFMKB2wKS+44swT2kyIpRVivj+D/90jcfUkiyrUBQyXPT7+GJD1fw6TbDQ2GbpxyxVMzf+S30WUKwwuH5nMPkDwmwhZ4T3p4UnPvTJNNmMZZ9LYGJvKpOENwIHT5Vrx/phcfbJENLD2Djz+ewjTjfp0bkl7hBlbUsHXStoo6elINWt7plbi3FK7D9oUTtTSt449LTryQDzN687UuEsA3M6vVSDlkhC8VRQBwQqdwyFApzAaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BO+sNHo2mmR/tGb1gum4Rgh1ayhM+MrMuybiL6WyoJM=;
 b=R4b5XNRHAwU9wFIAW8PGjbxkrTh+jbRuur/zmox0EsVTQpQF+1G6Z2Gs/G6GWz0UEUps4/GO4fFpxMDxDrdiQtfvQy4Z2azMCIwPor+DsT6CM1LAh499O6RUk49bFU/AH8hHtzNsoNHn5Q+oYj3ZGuYmnID3MThVthL+m/JGUITXzYHtkIJbLs5L17FnY1ugiV3rPh22bwgPzp4U8JcKUBwK1ERmxTYxPkd0v8yhrBe6IS7jd8bf7mZQ3fBfl+VKufKQt2qr0UK1pLsMwF2vYe9ammwp0dyJjGTslRoWYc/ReV4CfZUptj5ueIKL3Blt79WsLYYduGKW4bg5IJMU1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 IA0PR11MB7377.namprd11.prod.outlook.com (2603:10b6:208:433::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 13:53:01 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7807.026; Fri, 2 Aug 2024
 13:53:01 +0000
Date: Fri, 2 Aug 2024 21:52:44 +0800
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
Message-ID: <ZqzkrNixwNdR1qeW@chenyu5-mobl2>
References: <20240729065236.407758-1-yu.c.chen@intel.com>
 <4d31e1b4-2113-c557-b60a-3a45b2840f26@loongson.cn>
 <ZqueWhX6lqS+1vwg@chenyu5-mobl2>
 <a3c4b603-fc8d-bfa4-7e5d-0b2d8043131b@loongson.cn>
 <ZqyRG7LNx0RMD98e@chenyu5-mobl2>
 <c543a2e1-a4ea-5f81-cc3f-6bd0185c7461@loongson.cn>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c543a2e1-a4ea-5f81-cc3f-6bd0185c7461@loongson.cn>
X-ClientProxiedBy: SG2PR04CA0212.apcprd04.prod.outlook.com
 (2603:1096:4:187::8) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|IA0PR11MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: e363fe92-64c2-47e5-6d3f-08dcb2fa6c71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L2xOYVRyaHZKWW9pNlRVWm85OGRpeUh3bUpIcW4xUVM2ZnVPTmdUNVNtRVFn?=
 =?utf-8?B?YVZqY0hMRy9hbjNlUC9qem44bjAraFVuMWtXbTlzV2NCQVdCQ292VlIxanpI?=
 =?utf-8?B?V1JGS051eDNRZWVRZHlvbVhrcklGSjVpUFVMQnBxdkJ5VHVtUC90ejhIYXFw?=
 =?utf-8?B?bmJjOTNzMzJ4SkRpWDl3V2I3bko3ZUZZZjArajRrZ1V6Q0pTTUNkVldyVUFP?=
 =?utf-8?B?RTZhVkJkYUV4UDR1NDBORGFTOXlrTU1HZFpLT09PV3VzMUVUL2svNGRCNits?=
 =?utf-8?B?a0MvY2hqb0lBZGlUODFhZTdxalZRU2hEWVNXYkZCcGo2bklYU1M5RjhJNVVx?=
 =?utf-8?B?U1RsdXVLSXAwOHBNSmRXTTdHMmZnUGZGeEtqT0JoQ1BDL2RHRWxVampUbTJu?=
 =?utf-8?B?WmVBK0RITkwxQnpZMDhDTjZrVThsdUJqTStJSWpuTC9pNEdaeXUvZUhKd3Zu?=
 =?utf-8?B?OGk2aFk3M09iNjVSLzZlUTVMZE12cmswUjREbStkTENEZFNQdVA2R1ZuZWVa?=
 =?utf-8?B?UGVTWXRjME5iUTg0Y0tpVDZVQVJub2ZSOVdBOHRFYm0xQ3lpRTRxWFRUL0pL?=
 =?utf-8?B?TEZQWVJOTzNRcUtZeWJiMUpES3IvaTVUSlBCRFZ1akZsUk5lam9aTFl5RnAw?=
 =?utf-8?B?cHRndjRlem1JdXhObmExYnZEK1pFWUlkcHJ6WTFibEdndC92dWZmRTFNN1p1?=
 =?utf-8?B?blZKUEpzZmZyeUtoUjhrWkE0Q29xVFhPT1B2cmhPdU1XVmtwS3lCM3N0a0dB?=
 =?utf-8?B?Tkx6emtoS3RVa3pybncyRVZ0RDQ4dnZyUmsweHNTMVBZaGlCa3dCSTNRTzVo?=
 =?utf-8?B?bHRtUmJIczBsZGFBNU5QVnI4WFY5M2gzOGpGMnR1ZDhueHNtU0RUbXhxYXdT?=
 =?utf-8?B?a2h6emZheXJha28vV1BNenkvOFlDRm0xVVRXVGFyaDl5dU9nR2dteXE5NHBk?=
 =?utf-8?B?M1RUekpMZ3Q4eEtzQU15VnJDL1ZWbWVUTC9ZSEJLQlEyNFBiZlgySkNCdHJ1?=
 =?utf-8?B?QVhSbFlKVVE2MGRpaDNzTDk4eWxTTDNncW9tL0lWNUw1Q0JIalcrQ2R2bm16?=
 =?utf-8?B?V1dhMDhkRE9tYjFuUlgzT3hSSVFLOFBUZXg0ZjBXZG1nV29hT0lBNDJJcFdW?=
 =?utf-8?B?U0RwRkJZRGdVVmhzdjdMN29NS0VReEJWMnNkR1Z1eDZocGdTZDJVV20vVEhq?=
 =?utf-8?B?M0c1RkRzWURXWHdqZENtYSsrWUNuVlZFdjUzQWpVdnFNczlVeFpiU3g2NUFR?=
 =?utf-8?B?U2grRFZTWGF6T0R0OXZmOEt0cExpalZwUWxOM2ZtZ3VtOGczckk0YzNPcTFF?=
 =?utf-8?B?c09hV2JaaVFZNGg4RFJFSDI1dTE4NkFHcGlKZ21SWUdRL3RRaDBWYjYvbDhC?=
 =?utf-8?B?TXVmQmZkY29ES2g4ZnFqNllwa0paYzk3TGQ2ODF0Q2I1OUVvUk1xNGdSOVVB?=
 =?utf-8?B?QUhNak1jRGN3MG9ZWjRxSnhwQURJakwyTnkrazU5QVpydEZ4VUFkbWNkSUhw?=
 =?utf-8?B?cTNOVXJTc3lYT1hveC82YzdBSEpkSzRGdGdFK0owOUVreHpSRGVrOUZ1KzJi?=
 =?utf-8?B?b2g0V3dKdi9laHVHMXpsUnUrOFU2MFNxOElnQ2Zyck9pdFVmdTBjT2lubi9Y?=
 =?utf-8?B?bHRIRXRhZ09xclJCeWJvSUFicDRMK2E5cjBRMkVOVDcwY055eW96eEVRNlpy?=
 =?utf-8?B?RzdacVhUbml1bjQ5SFhKMmYzVi9jWEZzajBvQ0x0Z0JUMkI5TTluMzBFY0Yx?=
 =?utf-8?B?TGJSdks3S000RDAySW8vVWlzVnBUcWtGaDNlSmVjcDJaSm5XL1owdElkLzBs?=
 =?utf-8?B?TnVUbndGOTF1OUFvT3Mvdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3hpZ01USlByM2lTRUpUOHRqT0JZdVVaVVpHTUUya25wL0xiaUJmLzRpM1U4?=
 =?utf-8?B?NTJiUE9UYUowS0tJV2xmMVlSRWVMc2trL21DYWpabjJFODhQeWpVaUw2azI4?=
 =?utf-8?B?RWplem02K1RFR3pMbUhWbWRwRlBEV2Z3bGVJRUZzZkprOG9VdEpWQ0UxVlZZ?=
 =?utf-8?B?eTdXVkFxVUZSN2hFaythTTk0TVZxZnE5Z0hibFE2b0ZoQ1BieUNjb291M0tU?=
 =?utf-8?B?R0sweTBJWEFBOE9OLzhtN0dMRFV5YlJBVE8zTUpnWEhmOWY5dHRjZHd3akky?=
 =?utf-8?B?cGw5YU9XZG9Sd2tVKzM0Z1UwMVZJV0x0UEY4UnBJeXA3cEN2RVVQME1lN0hi?=
 =?utf-8?B?NHZUU3BNNmtvR3IrNm1TanZBeDhXVlJvVzhaamhSVUZyYTdUd1NmR0NMbHp4?=
 =?utf-8?B?aEJkdmRQNFZqVzJtQzlXZTduaDV6T1hIY1JaT1BaakY3SkJXOUo2S2JXeVAr?=
 =?utf-8?B?eEFaMHVWR09vQWFvYXZEQWRpc0VVWUFiU2VXWml1aHBzZ3o2cEhLc0laTkc2?=
 =?utf-8?B?MERBZ2FzWndkOG52QkgrKzVhRklzRW1Vdlg5YkU2Z2d1WWk4N2loa0RpZWNt?=
 =?utf-8?B?OFhPWWpidWZzcndJZVNYQytvb3ZnNDVrd1ZwTkQ0K3JYMlN2a2pGNGplOEhM?=
 =?utf-8?B?djJZMklFb3RRczJicXoxc2ZJUUxUWndQZHhtSzZuWVA2dXUra0xEK3BLSjJi?=
 =?utf-8?B?VkUzMHdQcmdVVEp3OUUxRWd0TUVSWGhDZDc4L0FsUDkyVWtFdzhKNDBwemta?=
 =?utf-8?B?eVZIQ0I0ZDNWNVZwaWZOQUhmaFBSaFQ5YnlHRzM4Y0IwTWhwYVd6cUttZVQ1?=
 =?utf-8?B?dDJ5ZmVtbCs5VzliS2hlcGxTUW42Qmw5UFNhbjJVT1BBUmtsY0MrUFdpZjdr?=
 =?utf-8?B?VENuWTcrWEpXczc2cEpyRU1IR280bFcxVVEvdHZGVlZqZVk3RzlrNXB2YnJ6?=
 =?utf-8?B?MjFWcVB5YkhUS2dCd3Nmd0JCNnBCcGNmakNNaTlXVzc1QmpqTkcxRStEOEE5?=
 =?utf-8?B?c1piNzNWV01rbVNsT1dtTXZZTHNjTkVIcVpUNk4wTE8rZjRud0Z3S3lWZlJa?=
 =?utf-8?B?ZG9Ed0tOQkxFWG1WK0wvR2lkRGE1WUlJdWlwemdjcjhRWkdkWk9NSWl2d3A4?=
 =?utf-8?B?cmloVHZialpGNnBVYUlnNHNkWHRrTVFrVXQ2dnRrVXBFS25qVzRyWk5TMXNK?=
 =?utf-8?B?WnhlM01qV2dFc3NCbVJWaHpJcmEwell0bHM4a0s5WGFUa3QvNnpkRHpOdXlO?=
 =?utf-8?B?bVg2MCtWZ0NjNmlTMCt6Q0RPYU9CRXJJbnJzd2JxbDdDY2ZhYnQ0YW93Rys0?=
 =?utf-8?B?UnZZOUdkVjZRTk50UFFNOWc0SzRZbGE5aGRMcG5jaVRRbTlFMHpoK1hkSnBG?=
 =?utf-8?B?bjVPbjUzTzc4QURzZy9iOW1TaHRxZkREWndpcHRpMktISzdLNy9nRVdIN3g0?=
 =?utf-8?B?UXZiMEdpZEpNbEgzQklsc2t5S2VMMnFWc09oV0JONGRFcCtiM3VIRjhwVEoy?=
 =?utf-8?B?QlJlVTZLdERlUkJqemk1VzlPVVNpZVV0NC9IZ0JGZ0NYS3Q3S0lyTXVFckha?=
 =?utf-8?B?MmdaZEJSc2VNT3hJeHhKbVVnSEpRYUE3Tmc3SGtEZWFteitUa3pSK2xJaXpo?=
 =?utf-8?B?NnZTa3h0VzlvZUJQcGFCTkJ3bnJQVUx3QUpIM1JXN0diTXZLUGtwOVM0U1U1?=
 =?utf-8?B?NUE2Z2VNV2ZUM295aWV5YzFxby9DQnczc3JiLzN6U1IzYmpFK3ZYN0tyd3VU?=
 =?utf-8?B?OFl5Y1QyNzg2ZFdWZGZvM3dDZk1kRFArZGIrZnl1NGt1Snc4UkNMMysyUjJO?=
 =?utf-8?B?WnRLSHkwSUlSYVdFRnlROCtXSjRjbVUrWlZCTHVWWC91L2dNRDQ4THY0U1d4?=
 =?utf-8?B?d2hDNXRMeUlRNnVPQmpmNVdsL3Z0YUZpUE1MRm5uVytWTnFLM1I5NU9sOG1y?=
 =?utf-8?B?SFJkSSt0dElRKytrdEdoblFCTTRXZmVWeHRpaUwwSTF2eWxQek1GeFZ3QXFh?=
 =?utf-8?B?ZWQxZ0oxcEtxVEpqYWt3N0JKK0VMYXhVcUxxUDFvT0ozTmJVdXYwUVBucnRY?=
 =?utf-8?B?d21zS2ZJYlY1NjR2c0lxS3JvMkgremIvYkUxR0dTdDlTK3VSWTFqeG0rdkJE?=
 =?utf-8?Q?DxUHfLddS1Ns6M9ySJ+u0Yr4B?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e363fe92-64c2-47e5-6d3f-08dcb2fa6c71
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 13:53:01.2340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J3CpeZGf7fOGX3xuheMzNiCBz4P7b/yhKYivuO6LuEdW21UWXWbtt7YjnuLDVB80+wrXTfQ5cHllSogCtPLGUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7377
X-OriginatorOrg: intel.com

On 2024-08-02 at 16:13:48 +0800, maobibo wrote:
> 
> Hi Chenyu,
> On 2024/8/2 下午3:56, Chen Yu wrote:
> > On 2024-08-02 at 09:27:32 +0800, maobibo wrote:
> > > Hi Chenyu,
> > > 
> > > On 2024/8/1 下午10:40, Chen Yu wrote:
> > > > Hi Bibo,
> > > > 
> > > > On 2024-08-01 at 16:00:19 +0800, maobibo wrote:
> > > > > Chenyu,
> > > > > 
> > > > > I do not know much about x86, just give some comments(probably incorrected)
> > > > > from the code.
> > > > > 
> > > > > On 2024/7/29 下午2:52, Chen Yu wrote:
> > > > > > X86_FEATURE_HYPERVISOR         Y    Y    Y     N
> > > > > > CONFIG_PARAVIRT_SPINLOCKS      Y    Y    N     Y/N
> > > > > > PV spinlock                    Y    N    N     Y/N
> > > > > > 
> > > > > > virt_spin_lock_key             N    N    Y     N
> > > > > > 
> > > > > > -DECLARE_STATIC_KEY_TRUE(virt_spin_lock_key);
> > > > > > +DECLARE_STATIC_KEY_FALSE(virt_spin_lock_key);
> > > > > 
> > > > > @@ -87,7 +87,7 @@ static inline bool virt_spin_lock(struct qspinlock *lock)
> > > > >    {
> > > > >           int val;
> > > > > 
> > > > > -       if (!static_branch_likely(&virt_spin_lock_key))
> > > > > +       if (!static_branch_unlikely(&virt_spin_lock_key))
> > > > >                   return false;
> > > > > 
> > > > > Do we need change it with static_branch_unlikely() if value of key is false
> > > > > by fault?
> > > > 
> > > > My understanding is that, firstly, whether it is likely() or unlikely()
> > > > depends on the 'expected' value of the key, rather than its default
> > > > initialized value. The compiler can arrange the if 'jump' condition to
> > > > avoid the overhead of branch jump(to keep the instruction pipeline)
> > > > as much as possible. Secondly, before this patch, the 'expected' value
> > > > of virt_spin_lock_key is 'true', so I'm not sure if we should change
> > > > its behavior. Although it seems that in most VM guest, with para-virt
> > > > spinlock enabled, this key should be false at most time, but just in
> > > > case of any regression...
> > > yes, it does not inflect the result, it is a trivial thing and depends on
> > > personal like or dislike.
> > > 
> > > > 
> > > > > >     /*
> > > > > >      * Shortcut for the queued_spin_lock_slowpath() function that allows
> > > > > > diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
> > > > > > index 5358d43886ad..fec381533555 100644
> > > > > > --- a/arch/x86/kernel/paravirt.c
> > > > > > +++ b/arch/x86/kernel/paravirt.c
> > > > > > @@ -51,13 +51,12 @@ DEFINE_ASM_FUNC(pv_native_irq_enable, "sti", .noinstr.text);
> > > > > >     DEFINE_ASM_FUNC(pv_native_read_cr2, "mov %cr2, %rax", .noinstr.text);
> > > > > >     #endif
> > > > > > -DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
> > > > > > +DEFINE_STATIC_KEY_FALSE(virt_spin_lock_key);
> > > > > >     void __init native_pv_lock_init(void)
> > > > > >     {
> > > > > > -	if (IS_ENABLED(CONFIG_PARAVIRT_SPINLOCKS) &&
> > > > > > -	    !boot_cpu_has(X86_FEATURE_HYPERVISOR))
> > > > > > -		static_branch_disable(&virt_spin_lock_key);
> > > > > > +	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
> > > > > > +		static_branch_enable(&virt_spin_lock_key);
> > > > > >     }
> > > > > 
> > > > >   From my point, the sentence static_branch_disable(&virt_spin_lock_key) can
> > > > > be removed in file arch/x86/xen/spinlock.c and arch/x86/kernel/kvm.c, since
> > > > > function native_smp_prepare_boot_cpu() is already called by
> > > > > xen_smp_prepare_boot_cpu() and kvm_smp_prepare_boot_cpu().
> > > > > 
> > > > 
> > > > The key is enabled by native_smp_prepare_boot_cpu() for VM guest as
> > > > the initial value(default to true). And later either arch/x86/xen/spinlock.c
> > > > or arch/x86/kernel/kvm.c disable this key in a on-demand manner.
> > > I understand that you only care about host machine and do not want to change
> > > behavior of VM. Only that from the view of VM, there are two conditions such
> > > as:
> > > 
> > > 1. If option CONFIG_PARAVIRT_SPINLOCKS is disabled, virt_spin_lock_key is
> > > disabled with your patch. VM will use test-set spinlock rather than
> > > qspinlock to avoid the over-preemption of native qspinlock, just the same
> > > with commit 2aa79af64263. And it is the same for all the hypervisor types.
> > > 
> > > 2. If option CONFIG_PARAVIRT_SPINLOCKS is enable, pv spinlock cannot be used
> > > because some reasons, such as host hypervisor has no KVM_FEATURE_PV_UNHALT
> > > feature or nopvspin kernel parameter is added. The behavior to use test-set
> > > spinlock or native qspinlock is different on different hypervisor types.
> > > 
> > > Even on KVM hypervisor, if KVM_FEATURE_PV_UNHALT is not supported, test-set
> > > spinlock will be used on VM; For nopvspin kernel parameter, native spinlock
> > > is used on VM. What is the rule for this? :)
> > > 
> > 
> > If CONFIG_PARAVIRT_SPINLOCKS is enabled, the test-set spinlock has nothing to do
> > with the lock path, because if pv_enabled() is true, it will skip the
> IIRC, if CONFIG_PARAVIRT_SPINLOCKS is enabled, there is two qspinlock path:
> native_queued_spin_lock_slowpath() and __pv_queued_spin_lock_slowpath().
> pv_enabled is false for native qspinlock path
> native_queued_spin_lock_slowpath(), test-set spinlock can be used in
> function native_queued_spin_lock_slowpath(). pv_enabled() is true only for
> function __pv_queued_spin_lock_slowpath().
>

Thanks for this explaination in detail!
 
> > test-set spinlock and go to pv_queue section. If for some reason the pv spinlock
> > can not be used because KVM_FEATURE_PV_UNHALT is not supported, it will fall into
> > the default qpinlock without pv-qspinlock(no pv_wait hook because it is NULL).
> yes, if pv spinlock cannot be used, native_queued_spin_lock_slowpath() will
> be called for spin_lock_slowpath, then there will be native qspinlock and
> test-test spinlock.
>

If I understand correctly, your concern about current logic is that, when
CONFIG_PARAVIRT_SPINLOCKS is set but unfortunately disabled at runtime, there is
inconsistence between using native qspinlock and test-set. My guess is that,
nopvspin is for user who wants non-paravirt and native qspin, no matter it is xen
or the kvm, all the other cases prefer test-set lock, no?

thanks,
Chenyu
