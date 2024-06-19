Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93A0335A7
	for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718810729; cv=fail; b=rL6ApiXxksozpia6xPhnHYPoXUurD2GlrBLjAv46pfhg7nqLEZtVmvoD5JpuYkd0Fvla1gs8OeDUHKIIiMpfn2TtDd1Xe1kEcNTPdmxCMJrez4coaV2K3VRvgSzIndfL0dJTtGXr6WUWp84HnuBRDvY9DEwLmsbUXUMo/480Ao8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718810729; c=relaxed/simple;
	bh=s9ogkwBmoZa+HQNiW8J3Zp1fc3C+82JClJ5Hcw31n7k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MO8fK0aMGD+OF8ucUz1D6jmWSySawRkXnaInXqjmznCD4DSWHxb/cux9fBNuhFrYkGCmyoEygWZEhVQ0mNw1APxdD65ITSWOZF04etOJ5iXk80cS6OdQ0RrIiTn34JpfcVorKTggh4yWKO6dJ8ML/nDrMpKnl02L5rU+xmj06Rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ElmLhetE; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ElmLhetE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718810728; x=1750346728;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=s9ogkwBmoZa+HQNiW8J3Zp1fc3C+82JClJ5Hcw31n7k=;
  b=ElmLhetEgQwT1TYwIZ38OORNaeQvVoxB7T+vte9SajH4i/m3F49j72NO
   QVx9aXlxFSt8wL+p3q2TZu++eEyIXI2Uc4KZQ4QRX4Yv7lrf0guk3cwwe
   kxhLtb7O671t0mQMFu6Yw8FniSEkPaOk6+UEO+oayaeQWzef+Pgy5xla7
   VAN5XmqvgzylHl0Jet0hCNMHWiAnjtdu1kIvP8dxQE3GEH0D64lmjbSkq
   hl5SD8YCK6Sza+HKAUCClDSuWqgoobensWHIIaQXS1hY2WYkIJ2AFriCM
   GH9QHunfAZrlLiNQ9qemd3GG+/D/DA94CNqswmyTOGXVwatxd45n+QSoF
   g==;
X-CSE-ConnectionGUID: +28JgNb8SYCjnZ6rFe9Egw==
X-CSE-MsgGUID: Ki09hbgmTPinXFi6erAc9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="41159910"
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="41159910"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 08:25:27 -0700
X-CSE-ConnectionGUID: BZMzjppCTka6ABscimKM7Q==
X-CSE-MsgGUID: wbtlh00VSYuBRkMqkGrz0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="42656267"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jun 2024 08:25:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 08:25:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 19 Jun 2024 08:25:26 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 19 Jun 2024 08:25:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftIIEaC97/JP0Ev7tr3EUHU/XmZbJ8CkaQHlq34nbTXNBrUrxEIlqso1DBAi/eDYvrR+ncBf0tmbCU9WLe7wi9IIxSX0FBl7+EKLj4wRXr6wS1tRM8Bxnd+0VO1fw4rjjWhB3zgBdGouXvEj/3BcAGVJudT6aB/s1g40T5qwWmgMTj+9ms4/U5K55NYXHkPZsYypwgoJ7LfYNDxsgttIyO8YrtUEQHgY5Tiv81IJd2ky/MOD+RzPjOAPdmiQb+JUSyYi9NOZnhrdMOvEHSeNOQB9Ho9gJI/ZXIF9OrkMp30C7TL8t2El1B4HmJaaznD2Hm2ZQpxHm95uS9sc0ND2KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmcwoD2u4BuB2U+5LxcGoiFs0kYQNKSSAWxog/K2EKc=;
 b=Isb1y4h9mL6fB+OpfD17eBA/sJSbHkQDq/hGXWsonARMAVZF+axActFdYjQaIzyQVso+8U8IurkMHxfqCkyY/XGn1dz6JIWC+8fnMmHjQBu3WIFaSgaza2vSdS9Y4Q+uGCMC57+62wqxtiW7G2IfKuVmgzCkauHuV9kjt3U9ZCL60WINZXd33PLuacgNoyPvrUaPqqcnQRBCzWuQIrXnz+92XpZIbdqOcWjkVFaE98FlVgS3iMAq15JaW8gFXFGk7rl+ACT5G5lSZw5oFyyx2Z6LG+0U2Rzo378k02WLO1EBIE5Cg5XjWEGMLxEukzHU/9xoV+UBEvjc7agzBXMxsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SJ2PR11MB7548.namprd11.prod.outlook.com (2603:10b6:a03:4cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.18; Wed, 19 Jun
 2024 15:25:24 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%7]) with mapi id 15.20.7633.036; Wed, 19 Jun 2024
 15:25:24 +0000
Date: Wed, 19 Jun 2024 23:25:09 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Juergen Gross
	<jgross@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Ajay Kaher
	<ajay.kaher@broadcom.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	<virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Qiuxu Zhuo
	<qiuxu.zhuo@intel.com>, Prem Nath Dey <prem.nath.dey@intel.com>, "Xiaoping
 Zhou" <xiaoping.zhou@intel.com>
Subject: Re: [PATCH v2] x86/paravirt: Disable virt spinlock on bare metal
Message-ID: <ZnL4VRwPNd58Ccl+@chenyu5-mobl2>
References: <20240526015847.14142-1-yu.c.chen@intel.com>
 <c83127de-b59a-4475-8d20-e3582ee2e6f8@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c83127de-b59a-4475-8d20-e3582ee2e6f8@suse.com>
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SJ2PR11MB7548:EE_
X-MS-Office365-Filtering-Correlation-Id: 751ae410-bdc4-417b-5d2d-08dc90740a33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnpLYnZrMlRweXdiK2JoZHFlZEhUb1hJTThIOGxKaURTWlprYU84cy93VTg4?=
 =?utf-8?B?QW1VWTFTZUNUTDBXaW5CTW5BYTBrRWhkZU5BU2VCMDhOZHhWZHVHZzF4TkVn?=
 =?utf-8?B?b3BUN1NkZ3pKMDh2QkUycDhLOU0vZ2QrK0lSK0llN2t1ZFZVY2M1aDdDRmg1?=
 =?utf-8?B?WTg5SUtyY2UzcHVlOWY2em9ETGQwNmgyMWJaRkt4NUlIQmR1OTl6SGdPSnJv?=
 =?utf-8?B?Y3BGZ1lwa3U4cHN0YmdPTCsvWGZyLzBMc2dTWTJ6QngyVkNOUk5sMVB5OEda?=
 =?utf-8?B?dlNWUTY5dkhlVC9FRXhYWWpsZk03U3pGbHZ3L0ZPcVhIekRWNXVvSHczakU1?=
 =?utf-8?B?Smo0QUtMVCsxd21xWEwwWEFsZVQvWGlaZ1hKUnZaNEh5RkFTVE41TWI3QUQx?=
 =?utf-8?B?STczMVp1cHdyOFczdEI4U212b0YvbkhTdXJZMjI4eWpaUVJMbVJObGI2Z08r?=
 =?utf-8?B?R0ZFZjJwRjdkVGxvb3NDcWd0Z1Zac29zYUJJaEEzTTFIQW9pRUtqbEw2THlY?=
 =?utf-8?B?R0lxR3RRTzdMbThVWUlDeUk4dWplQ1JtLzQwV2VEYXdISVNOV2I1NGhnV0kw?=
 =?utf-8?B?dU11U0NMNXB0SkRhVFFpNE9OMVBVQ3RaV1ZaRDB6YlZ1QkxWOWg3MEN4QU9H?=
 =?utf-8?B?eDlwa1BzRGtjODdDbXR0TTB2MXQxcC9nelRtM3BSYlZLenR2elFCSisvU2ts?=
 =?utf-8?B?RWlvQ09pNFF6L1VSNWpQRE1GTDZrZzl3VmNFQStvbTlmQ0hnQmM5S051ZU8w?=
 =?utf-8?B?NjY3MzZMY1BnL2R2bGpKUXVqOUMrclJ2b0FKVmV3MFVocE9wYlNSdWVQdXVF?=
 =?utf-8?B?RUhjeE8wa284clFkK1BILzVDaEJTK2t1cU5mNVovUzNYQzE1VEtWQnpUK084?=
 =?utf-8?B?OXkyVHoxZlF4cnU3UlFnSUNJTmtLZTVOUVBna04vOE1mOHd6VmRYUEhUdXBq?=
 =?utf-8?B?SmlpdWlvZkhhTzdMd011QmxHSktIUk03cXM1alI3Q1ZZZnYyNnVPNHpZODRR?=
 =?utf-8?B?MWJuWHlGSlpmQ0U2NGpYYi82NmxFNWp4VmRlZ0NqdTYzRmZhc3EyTnlHV1Ar?=
 =?utf-8?B?Ym80dUtwRDY4Q0RvTXhtVkIvbThvZ3BaWGhtc04wRWRxekFBNXVlMXhkUE1O?=
 =?utf-8?B?SWtCbFBkekdXUWQwZ25pcDN6Szg4RWNEWTV6R3hsL1ZSclBmWXhYQmZLZUF0?=
 =?utf-8?B?VVJxWXJEb3RrT0k5Y01RZmdldHZIZ3ZHVkZENThnakJpRmhzOFhmeGlWUmV6?=
 =?utf-8?B?VDZIMlpEbkh5eHY0cmpkT3d6ZHNzTWZ3YkFvQzd0bm90cHFhaXVtTElQa050?=
 =?utf-8?B?eU43bFRHNVFiRVJIWTFCcjJaZFJxMHg5TTMzaHJ0VjYvOWR6SGhNNEFUaFU4?=
 =?utf-8?B?eFJXeUZZWSt6VXVjb1JjcTJFcXZwTUhPcjNHd3FDYVlwUFYrelZDZ2wxZm9Y?=
 =?utf-8?B?cWxwb0NobzRWOWFmNzM5WmFpdGwxNGVzbkRXOUJOVXdybmdzNW9sKzhubEFQ?=
 =?utf-8?B?ZDg4OEx4QmlLMFN6QS9xUHJQWkdJZ1FpU3JOZkdDc1IrVzRCK28yOGs5K0E3?=
 =?utf-8?B?d0RvakhBZTZVNzFpY3pkeForZjZETlhCbW1KRG4xeGszODhFNmc1OS8vWU8x?=
 =?utf-8?B?N3hHYUVVdnlrVTFGaUs1NVZCY0Q0NGZHNUlmRVgzOVd4c0JHNjJLcVZHa0pG?=
 =?utf-8?B?akt6Ty9NWG4wd3ozVkcrSmtsTmNKc0lqeHRkbkorR1g2cHdPUVlPVU16OTRm?=
 =?utf-8?Q?HY6bCzbAbDLJUt9j4Bu94F6h2IMqPx+WH5ve0Lx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SExGM3VFR0JZODQzcFFNbWM3K1VVUVJOZTFBWGpYY3U3QWZpeVYzMlZpYm1S?=
 =?utf-8?B?elJjZVhZRUl3TFd0azhPVWVMT3U2am83dU5sTHlFdUhWcVlnL2t4YzlrNGMz?=
 =?utf-8?B?cm1wdG9EMWh5Ykc3R2NhVFBOVW55eTRaY3VBVDBoMVVmdkVSOUJkanpRWGE2?=
 =?utf-8?B?RmRKb3hhQXM2bTRmT2QwZlljbnBYWGgzaDZZejAra3ZETFYzSCt0RmZ1OHNk?=
 =?utf-8?B?WXJZdXJZc0F1UEM1UGpnV2xGSy9DKzgzN2JpcDVVQ0JpSFJ3OHBidEUwZmVN?=
 =?utf-8?B?VU5HeklOcGhjQWVodyt5VElnYkhkQ3NJN05BcXh1NUhUczRkOFpxYXFQSTlG?=
 =?utf-8?B?aUxNQjRVYllVL1ErZjlsNHJ4WnNoU2xrTTZ6VFE1MEM2RXIxRzQ3K1RkMXM3?=
 =?utf-8?B?NEJqR294SE5TSEFDbGVUK3lIdTZsQjZoaWNVQzJhNzNmcjdwZERJTlZBNlJM?=
 =?utf-8?B?RG5ZZ1J4WHdrYVd0WUU5SU0wR0p1Wjk2Vk9CRHhQbzF4MWNOVHlhSVFkWHFN?=
 =?utf-8?B?T3hVNmxSa0JnU1JxckxNWElsamhia1NXT1hyZnRlOVEyQkY2dmFlNHF2Y283?=
 =?utf-8?B?a29XVGhZZFB4YVpsaXI1UVB6WFlKQkVYU3U0R1hCM2J5YjVyWGcrZTNNZEo4?=
 =?utf-8?B?OGgrWmJZcGJPd1lSci9ZS3Zlb21KYVROaWk3ZWR0N1JVN3pTZmVpbXVrZGto?=
 =?utf-8?B?dEVENXNrV0xob2ZlTWlPbXJRTmFHWHN4MDBBWitzNmxDbVJjVURaOVhlazE2?=
 =?utf-8?B?eTdRSnpvOGd2c3FFdHYzNERCbWY0YlNzcFNZS254Skswa0MzQzdWRlJkazlM?=
 =?utf-8?B?K3Z5Z01KWEs5ZGdPT0RJMERzaVpFcjFKRUtKcEd4d3Y1ZWRFQWZCTEZRRUx2?=
 =?utf-8?B?ekxIZFBWRVVRN0NHV1VDVFVveVFjV3dzWFRnTFN1Rk9VQjd6bDVQMnN1aVVN?=
 =?utf-8?B?bVltazFNc240Qm50QUUxVVF2MzMwYkdOTElFUlFxQjRlUSswRkRZTkw0Umhy?=
 =?utf-8?B?d3lDbFVsMEJkS1VTU0JxR1FLTkhEczQ5YzVFN3ZGRGxjVWhUcUtBanJLS3Q1?=
 =?utf-8?B?N3grcU1wMm9ia1NNbVF2R2JTWHJuTS9LRVAwWFNXTmxYd2ZaL014SERnbExu?=
 =?utf-8?B?U1pEM0l2Sys3RWtPOWZNM3YwbDVyQU80NzR3cFdNRnplYmoyNXBVZEFnNjNH?=
 =?utf-8?B?TXlZQThPcVBoMTNhcUIzZE4xS2RVYTFHKyt5cEZHMCtQcWJDZUNnU0Q3aXZu?=
 =?utf-8?B?N2xVZXVKZ3lYT0FONitpUEtsamJnSjQ4ckttQzhGWkgwellzemJPU2h6VHl2?=
 =?utf-8?B?L1V4Skl6N3F5NDVSNmxUcHVJV016MFg2KytUY0djTC8xeFFpOC9Xd21qaCt0?=
 =?utf-8?B?Q1VIdmxHSjA5NlpLSHVETitHN1FFcE1TOThsUU9vMmRzT1pLb0U3NWZDZ2ln?=
 =?utf-8?B?TlJNNURESjF6MWF6cVJ2ZTNiMWR2MGVYZzNqcTgzVmx2VUJJTjZCMk9OMjA5?=
 =?utf-8?B?cHNNU1dHRExmU0pCemNIbmR6b3JhOS9NY2tnUTNySlNGOFI0MUdzNkNnNUhN?=
 =?utf-8?B?ZVhWQXBKM2tKbERWbG11aXRnTVkxc2lQUXBVa25yMXFIbjIwNFhLZ0NKL0Y0?=
 =?utf-8?B?UnFLMjJjSlJFaVV5RFlhbTlSMzlScnNSeHZBZ0dUYm5KUkFYcDJjaGNWalZz?=
 =?utf-8?B?c1B1T3ZMdFNWM0dFbzhQMmZtMjByMS9kTEJQclB3eDV2T1F4TlVBMk41VEs3?=
 =?utf-8?B?M0wyQmpZTnErZGhhNlRHYW9lMVJ2Yy8zdFR5K1h5ZDgzc2hrZlZ6ZEYwWlBJ?=
 =?utf-8?B?OVN1MnAwL0N0bm5qOVI1eVo3WVRISEhQTis5TXhkWnphaXlYRU5LTlNadFM0?=
 =?utf-8?B?N2xnTzJPZjd0eDBUUVRnWjRnbWNlelI2VUhiVG03cllmOFUvcUxmeldrSE1T?=
 =?utf-8?B?VGdNcWxMVVNydTdqNGZaWXVXSUJlME9vTGh1RzVZckhTMzRUSUl2eTlwbHkr?=
 =?utf-8?B?OEFxVE5BVmZESWVEdWtRT2o2QTJlazBpNmRmTVBSRzhESjlpK2NzVkNUampj?=
 =?utf-8?B?aFlOMVpMcTFlOWh5RGJhRnZrL01PeUw0L0ZuNEQ5NHBqUzNDMVNDZTh1TzlR?=
 =?utf-8?Q?Pd1MTj1Z35B17PV7+V6hNRbH+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 751ae410-bdc4-417b-5d2d-08dc90740a33
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 15:25:24.3251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cYVZm1fQvzVB0EAPWirO7m/teiajUozmvFoMIo+KksO2OSRMpgORTEuApVyoBbYizZc2KJ8tRrNLvvBm+yx3EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7548
X-OriginatorOrg: intel.com

Hi Nikolay,

On 2024-06-18 at 11:24:42 +0300, Nikolay Borisov wrote:
> 
> 
> On 26.05.24 г. 4:58 ч., Chen Yu wrote:
> > The kernel can change spinlock behavior when running as a guest. But
> > this guest-friendly behavior causes performance problems on bare metal.
> > So there's a 'virt_spin_lock_key' static key to switch between the two
> > modes.
> > 
> > The static key is always enabled by default (run in guest mode) and
> > should be disabled for bare metal (and in some guests that want native
> > behavior).
> > 
> > Performance drop is reported when running encode/decode workload and
> > BenchSEE cache sub-workload.
> > Bisect points to commit ce0a1b608bfc ("x86/paravirt: Silence unused
> > native_pv_lock_init() function warning"). When CONFIG_PARAVIRT_SPINLOCKS
> > is disabled the virt_spin_lock_key is incorrectly set to true on bare
> > metal. The qspinlock degenerates to test-and-set spinlock, which
> > decrease the performance on bare metal.
> > 
> > Fix this by disabling virt_spin_lock_key if it is on bare metal,
> > regardless of CONFIG_PARAVIRT_SPINLOCKS.
> > 
> 
> nit:
> 
> This bug wouldn't have happened if the key was defined FALSE by default and
> only enabled in the appropriate case. I think it makes more sense to invert
> the logic and have the key FALSE by default and only enable it iff the
> kernel is running under a hypervisor... At worst only the virtualization
> case would suffer if the lock is falsely not enabled.

Thank you for your review. I agree, initializing the key to FALSE by default seems
to be more readable. Could this change be the subsequent adjustment based
on current fix, which could be more bisectible?


Set the default key to false. If booting in a VM, enable this key. Later during
the VM initialization, if other high-efficient spinlock is preferred, like
paravirt-spinlock, the virt_spin_lock_key will be disabled accordingly.

diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index cde8357bb226..a7d3ba00e70e 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -66,13 +66,13 @@ static inline bool vcpu_is_preempted(long cpu)
 
 #ifdef CONFIG_PARAVIRT
 /*
- * virt_spin_lock_key - enables (by default) the virt_spin_lock() hijack.
+ * virt_spin_lock_key - disables (by default) the virt_spin_lock() hijack.
  *
  * Native (and PV wanting native due to vCPU pinning) should disable this key.
  * It is done in this backwards fashion to only have a single direction change,
  * which removes ordering between native_pv_spin_init() and HV setup.
  */
-DECLARE_STATIC_KEY_TRUE(virt_spin_lock_key);
+DECLARE_STATIC_KEY_FALSE(virt_spin_lock_key);
 
 /*
  * Shortcut for the queued_spin_lock_slowpath() function that allows
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index c193c9e60a1b..fec381533555 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -51,12 +51,12 @@ DEFINE_ASM_FUNC(pv_native_irq_enable, "sti", .noinstr.text);
 DEFINE_ASM_FUNC(pv_native_read_cr2, "mov %cr2, %rax", .noinstr.text);
 #endif
 
-DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
+DEFINE_STATIC_KEY_FALSE(virt_spin_lock_key);
 
 void __init native_pv_lock_init(void)
 {
-	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
-		static_branch_disable(&virt_spin_lock_key);
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		static_branch_enable(&virt_spin_lock_key);
 }
 
 static void native_tlb_remove_table(struct mmu_gather *tlb, void *table)
-- 
2.25.1

