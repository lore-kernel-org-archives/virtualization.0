Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC87156C5E
	for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718812134; cv=fail; b=Z2mjuAg5tX4rGa5UDf637QgiOwuuh3prELLaiI3SlaUUj8ii04+wKxXHgLZkaL2UaId404EWZNFW4hj41hp0GSmvsAP/1xNd+0In2okjUp/21wXFb37YHBVBp+ZQPNV+flpoi53L8DFWWfjh6y48gbe7VGMFKlLDTIIuantq3Lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718812134; c=relaxed/simple;
	bh=AZveLGQU57sVJVobm81P+kLsvWBuQRkPItviBAALhT0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oze3xvckn9VD8/ZB1xbY5RtWcY3Zh/RbFXok3FLthkFkUqcum7HAc8ng7SFVFIEzgBUYlLcydc+hgWBWwr0/WS0dUa/DYepQrBH6ySTfR5CW+CgY6M7K9OV9IzG4pGOcH7blkUgcLs96k3wJYIrVfqZ8THeW9uD2QCLoe6OoYLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JOsWrcFI; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JOsWrcFI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718812131; x=1750348131;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=AZveLGQU57sVJVobm81P+kLsvWBuQRkPItviBAALhT0=;
  b=JOsWrcFIK2ptLOspSnKWlAGqrMRBMZFcgf2NTpUgPPLucUGS5G43M6WG
   VyfpncDYfcXK6p5zF8Wx7bR61/slNOPb6FR/W9T1JE5jS9zO/YaLe4ywv
   xrcNnXMOUOGy+dGN5mlkXLqNm4iYXAiJmlczQVhS7sIrPEkKKYSpQlyLV
   vu4mjyqd2ZmT+YR8X/bDtVt7njrpT+JkFncafCV1wh122XnqeUvOArY5/
   zod0PYvAmdulo4N66YNlsouXd+YqwWEMPx9Fte9qh9zB4LxKAHS2dX4uY
   xNLXcS7CSB/V6s4Qc0H4tBGqahqPn8n+IRvNk0YrzYoSgIATfHq3IewVG
   Q==;
X-CSE-ConnectionGUID: ubEnCGNhQw+vFCz4VFpK9w==
X-CSE-MsgGUID: 7eXA+Sb8S2uUCDE/iZbCWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="41163047"
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="41163047"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 08:48:50 -0700
X-CSE-ConnectionGUID: BAAiHE2wR4qBpw52CTuoRQ==
X-CSE-MsgGUID: rgb/nKIlSt2v2aBPTfeZjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="41818821"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jun 2024 08:48:50 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 08:48:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 08:48:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 19 Jun 2024 08:48:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 19 Jun 2024 08:48:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTCZoSXrpXFHFlnfuvun0uNkFZiHblaCNjO989aIpai3MblpLZ73zzz3GcPsarA+IERSEuq5SakWlkGpAEYkADoqBceE/FFyedymezuQUhmhgdU5urv6x0QV/dlRcIuCYkq3ZLoAB3U+I96kTyJD/XMptgl+JD8jKAuMG2L5/VBoDT3V0pcl3OQGBv7u8WPVhDtccxjfuHzSZPNgUX8ObZvAxDtfR4MeYyDaMRhnpeD7kgLh088WTZHAmE7wLYz+ykoBHddlAeEDD73LbKF42Z4g+UI+kvu608HDe/y4hC6qJg7CXYG1WePviqYVr65yuMCwjyAUYQhQjrodXs86Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMc/8/9uIOdcIcAW1z6McMHUg4wfm8e6DiQca4L7Pz4=;
 b=H6cL9/t6SoBE+dVfr1de7cev38G5WlFMfdYVSgZkvzhZiwWhnYrscz02MHtAvdZU/sDVQAzU4PWuJo7nVSuq6woqbVMRpCjadIGbStflKORgOW8+CBsTaCN9Wzk6IH/ULY6j94gt94BwynCyO98mUyNjsj7LAYhgat8/JM+aTp0l8zGuK1BXG/yOhJOePVsV5CNIzX58pE7OQ9ZB2wEwBxbCt7qjz7cWInUO7Q9J7JpHbEhhIy6SVgyQxWW25ktqXfT4XFBPIwIduM3loWmgcRR43J6SZULd7QWDKcu9BVEpTw+os72HigdOEpQ9rA9TNBoOEO2WIeExGNAgiKhL7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 DS0PR11MB7411.namprd11.prod.outlook.com (2603:10b6:8:150::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.31; Wed, 19 Jun 2024 15:48:47 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%7]) with mapi id 15.20.7633.036; Wed, 19 Jun 2024
 15:48:47 +0000
Date: Wed, 19 Jun 2024 23:48:31 +0800
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
Message-ID: <ZnL9z/wr+x67G14s@chenyu5-mobl2>
References: <20240526015847.14142-1-yu.c.chen@intel.com>
 <c83127de-b59a-4475-8d20-e3582ee2e6f8@suse.com>
 <ZnL4VRwPNd58Ccl+@chenyu5-mobl2>
 <5eeeb8ae-db72-4468-bff1-2de402ea113f@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5eeeb8ae-db72-4468-bff1-2de402ea113f@suse.com>
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|DS0PR11MB7411:EE_
X-MS-Office365-Filtering-Correlation-Id: cb5b9e3f-7b29-491c-8fd7-08dc90774e65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YWF3Qkh1blJQbVhRT3lQZmhSQmhMZmt3ZXU5WDJDdXFRQU1BM0lrZ1V2cjJp?=
 =?utf-8?B?RjhhcHZ6VkZkcnI0N0Z6ekJEZFI0RlRJUGNKc0lMVTNIUFduNmJiTlZWQ3dH?=
 =?utf-8?B?aEdKVkNqK1VMN3R6UnlybGtuc1pHYm9pcnFyMExTazA4TFRoaEV3QmRMc2VS?=
 =?utf-8?B?V1ZKbnl1UXp0bWZKOEZSRm51U2VzYXdQYWpFdFFadHZzTVh1RHpoOUM4Uk9t?=
 =?utf-8?B?ZnpCUzVBT3hkbnpwQ0xvVy90V0FpWHZkSjZUUlNPM2JRZ2NKbHBNdzBZcDZ2?=
 =?utf-8?B?Tml3cXcvMHdhUDhVVG9GVG5ZQWVRYUJkUXd0SkloVEdMVEZ6ZGwwN1MvMFFB?=
 =?utf-8?B?N3JjNCsvMEIzZnN0dzh1UHpWdE5FOVVYSi9QT0FadkxBbGd1MnpCd052b0hH?=
 =?utf-8?B?VVlHclVFK3drQTV6L3ZyNlBrbjd5L0lMMFJjRHRRZFVJRHVRUFBSWXR3RUxP?=
 =?utf-8?B?MTVYUmRRNkpCN2tNQTNkVTg3dmhya2VqVWRnWXJnMUVnV0lxWUs4N1JTczZC?=
 =?utf-8?B?U1o1cXZzZTZSY3kzNEpxTFVHdnVoTEdOeFJ0UGhxKzhWNmE2QTRUN1RNVlpX?=
 =?utf-8?B?aDFXaU1ta0lrbFdnYVcySWU5RzhqSGhVT0dUMFQzUkZpRVJPRDNhdUI2MkEz?=
 =?utf-8?B?Y1NMYzQwZXFHcFdsczZSWDZTdnlSeXpGNEx5QUpIRkQ1eDBJTDR6eVBVSlNq?=
 =?utf-8?B?WlJLeFlCdVlJSXhHWjFjc2NWaG1SWjdIUU5hRTR5WTBTOWNQRGtKcUFuUVUr?=
 =?utf-8?B?ZFQxVnZhaTdpNjFncnkyblJ4MXM0UWM2SjJaZXdhTGlsMjNsRDQyczh0UHNK?=
 =?utf-8?B?OWFxenF2aWZzb3pQMGd4NGlHYTM1eU10MThkY3lNTWc5OEFwUFlFUHlydW5M?=
 =?utf-8?B?ZjdFbzkyTU9DR2U3aktMcjdWb2dFQk9ZQ3ZFQWpXTWRlczByR0Y0WGpmTVcr?=
 =?utf-8?B?bEVidTdtelpxa3BIaFdoUGdpbEpEaFpnVGFvRThoWFErSW1ta1hZcVdFdEU3?=
 =?utf-8?B?akZkc29pZVYzZWdJNFkvNjlLS0xIQzJWZENrc2wyTk1KNW1MYXBQeGZRQ0tm?=
 =?utf-8?B?bXJyYmhzc2RRY0NJQWJmMzFTajFSWk04OU9wVXNpSWtUWGVkK2loZUs5Y2ZQ?=
 =?utf-8?B?TE1zSkw5RzFJcXg2emdvZi9LcVYzNWxmVGdSNnc2OUtlQ0tERGVWQm9VQW1Q?=
 =?utf-8?B?NVU0WjJFeUlMaklvZERkTHJZT1ZSVlJXOWR6am9XNU44QVAxY09wRXBsa0x2?=
 =?utf-8?B?d1hycEczMGhJbGtCT3Ara3A2UXNtUDVFMjhyN0Zuc0ozT1pxWlpSViswek9Z?=
 =?utf-8?B?Ny9WNFVWdnZNdnpQMkg5dkRVdE1MZDVGNU04SEhXYjJHcWxDZFIrTVFiUkxs?=
 =?utf-8?B?YlFlNmdXaG1iNG9GbHkwOFlodGw2V3hRVTJ1UUZtYUlsQnZPK3orckxWczVa?=
 =?utf-8?B?RWdPRGNTZ2tkUlN3eFllNUFtbVN1cUNMN0xaQjJYTEY3dHZVUW5nbjlNYnhB?=
 =?utf-8?B?MkFoTGF1dkpIQUFwK0phTkl6REU1Y1NZbE4wODlucXFjanArR3V1czFOUXNn?=
 =?utf-8?B?Q2t4MmVYTDFJZ09wQTZFajRkN0Q4cSszSTRObU83L2EwaGowbklIK2tZTmZq?=
 =?utf-8?B?V0YxL2VpK0RyQXpkWWFHaDV5WU16MzU0YVNkV3VtN3VEZlFBNGg2UklhL0xv?=
 =?utf-8?B?b08ycmpQMWdxSjVUejlFOGJGVmFVWXE0aGNuNmJFK1NuUWZBWjJtSGhmaFNN?=
 =?utf-8?Q?ayVxQZRs2N8ZaribOgPckelY0vpP7vVobnQ/g6v?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVJabXBtVDRxZDUweFJ6cU5hS1VCS2s3ZVJCOE1TcDVIT09SaWNKdlArcEhx?=
 =?utf-8?B?dXZBa1paSE54YUFtTEloR0ZveUU3Ymc1ekRqWU9NY1BXVFlSZkpHUFMxVkhR?=
 =?utf-8?B?YUhESVo0d1VhcUlWd05nMm1kN0JQY21HS0I0VlY2a2RpQTR3c3hySUtRSHl1?=
 =?utf-8?B?L2daaXBEWi85Szc2czZONjVIZkV6MWNHVGhWRlpVMGdyZlJJKzNXOWI3MVhB?=
 =?utf-8?B?Z09SVVBHdTh5VERRNmNkVEw4K2lGeTYzUEpaem51NWJaeng0RllxUGdoQjJR?=
 =?utf-8?B?QW1oQW1jaVk0cXNqL1I1T1ZRb1dHQnAwVTNtM3hhbjM1MnplVVhWNjVNS3ZY?=
 =?utf-8?B?dS9uaHdWRnJ0eW0rSG00NG55a3ZKYTV2ZGI4cG9mNll1MFcrUkdvSEtMcEVz?=
 =?utf-8?B?dDQ4eEkxMS9Zcm5DdHZ6dDlsZkhETm53Vys3WmJHRzhIZWNPUWtmZ2ZUUkRt?=
 =?utf-8?B?MzdVZWx4aEpab1RCd0JJc0JuY1pueG9iSGZhNklnTHdTNXNNcG5sem5FL2xZ?=
 =?utf-8?B?MFprRWRycWhrRGZqc0lnUzdwUkFFUURuZzVxaGNHTGJ6T3JLTTJjSzQxK29P?=
 =?utf-8?B?V1NzVHdINmtoQU95dTlxK3JBRDJ3M0hKNVlVcXJsbmJ6dzRZVXlabnp4Smd3?=
 =?utf-8?B?WW1qQXlDc2JLa0t4VGxDcWZHNmtYODV4bWJhVnRjQ2pIQkpMMGw1TVRWVjVK?=
 =?utf-8?B?K2lhY0V3eHdyOUN2eWRLTEVIU0pib2VqMUFDY3JTRXZ3cWJSaHlTVnNwcVBM?=
 =?utf-8?B?eWRXdGNOcHBxUzkrNzY3bU55Q0NGZGFpamZuTlJkSjVubDRyWHFxN2JxMk02?=
 =?utf-8?B?TzBMcTQ3eGFPYXpYZ2NEcHIrQTlRZWMvT01WdlpzRTdsRzAwM0xMeS8yMUNw?=
 =?utf-8?B?SFF5cmNzSnM4dVBZb2JKK2NpQnBsYWxQck9UZ1FXcXlFczlXbkk3YlNOSTh1?=
 =?utf-8?B?aWpLVW1WY0lmbmdPQ1RwTzU3TU1xWnViSzdlMmZsM2czK1o5MGdRT0QwNmxi?=
 =?utf-8?B?WDVLd3ZLdnErYWwrNDZwcGptQ1JSbTA1TXFoRnNoYnY2Vmo4ckJCc2I1V3E4?=
 =?utf-8?B?bUVlRVNldVBSMmVRa0cxTHVKdjJ6K1ZXYTI5RENHZDhSVWZWdllxZnp4QTNP?=
 =?utf-8?B?YTRWY2RlOGpOMHA5R0J1WWxpODk5bDVMUzRneVdxRjIybEl4WmpjN2NiZXFM?=
 =?utf-8?B?ODVRV24ybU10bmR2VlFoeTdJZDJsR1lpb05UcFJZelRlbmRYbXd0UHBoRTRm?=
 =?utf-8?B?T3RWdDgvUDdKWHRBVXhTNmpRd3I0UXF4VlY2Vit0Q24vWFdGK2d1dkU5WFpq?=
 =?utf-8?B?dC8vandsbDZFRm8xY0psUWVRWFAvaDlvS1Qrd2hvSXYyV2VGZHU1ZUFEcUlH?=
 =?utf-8?B?dVkrWE5LeTJDbi90eWFsU3V1aWZkQVhJR2FFUWcydHRXNFkxVzRlajBBUjJE?=
 =?utf-8?B?TDEyUnJDWXpsdUk4OHJ2SzNWNW15aXJHc0JCbDJmbkorOTdyTkVoVytoRWc5?=
 =?utf-8?B?UHdmV3ZKQnRQc0F6aGxML1BBV3cvVmV0c2UzSjhEY1lPN20xYmRqdWhOdmxY?=
 =?utf-8?B?b0gwVWs3TWRZMHRsdkVrby9BazlxWlUrekprcXJuK1h4UUkwVk92VDFLWjZK?=
 =?utf-8?B?WEV4VTZzdkwxWmQza0RLSEF0dFVlc2dqM1BiQUViUnRRaTNCUXZLRE1oWHh2?=
 =?utf-8?B?alZMMk5XMXNNQnZ0THBYR3c3VXRFUy9oVzBzVkx5R1BXTERML0ZmY1FWa1pI?=
 =?utf-8?B?MWRBajVTbUYvb3QyTFFlV3dwd3MyYVphQk5tSSszUTNpSm5VV0Z1WW1HRmtD?=
 =?utf-8?B?VGVxYW9TUFFkem5Fd2Zob280blhrWmp6V3RnQ3BLcWp0TXVCTFdaRkFyOFBW?=
 =?utf-8?B?bERWVWFPZWNOZndlOHZ6dmxHdEdSeVkzVjlwS1R0bkcxamJTaWE2dXVDQUoz?=
 =?utf-8?B?bXdyK25pWnkzbjJXOVA3QzZ4anpwL1pnd0xUeVlDQ3hUVS9zVHNXZ0FqczZH?=
 =?utf-8?B?amZteHEvRGhDU1I2RG0ySTB3c1MyejZ6M2lZdmE1OXBSYUpWSUhoS3Q4d08v?=
 =?utf-8?B?TTY0dkphT1ZIckhtbytwYldDTGdiNzNYWDZFYlNEaVJweVRvRjZobS9aQXJj?=
 =?utf-8?Q?HhZ/zUNNx/mMBaHeFSmoyNt6r?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5b9e3f-7b29-491c-8fd7-08dc90774e65
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 15:48:47.2685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qzti46f+FMY11NU2lmssMCXl9/hIUKvQ5+idOTP0xgY7j0scMngn33LjVcS7FXOcA28k0CotU+DaXBFoPvGY7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7411
X-OriginatorOrg: intel.com

On 2024-06-19 at 18:34:34 +0300, Nikolay Borisov wrote:
> 
> 
> On 19.06.24 г. 18:25 ч., Chen Yu wrote:
> > Hi Nikolay,
> > 
> > On 2024-06-18 at 11:24:42 +0300, Nikolay Borisov wrote:
> > > 
> > > 
> > > On 26.05.24 г. 4:58 ч., Chen Yu wrote:
> > > > The kernel can change spinlock behavior when running as a guest. But
> > > > this guest-friendly behavior causes performance problems on bare metal.
> > > > So there's a 'virt_spin_lock_key' static key to switch between the two
> > > > modes.
> > > > 
> > > > The static key is always enabled by default (run in guest mode) and
> > > > should be disabled for bare metal (and in some guests that want native
> > > > behavior).
> > > > 
> > > > Performance drop is reported when running encode/decode workload and
> > > > BenchSEE cache sub-workload.
> > > > Bisect points to commit ce0a1b608bfc ("x86/paravirt: Silence unused
> > > > native_pv_lock_init() function warning"). When CONFIG_PARAVIRT_SPINLOCKS
> > > > is disabled the virt_spin_lock_key is incorrectly set to true on bare
> > > > metal. The qspinlock degenerates to test-and-set spinlock, which
> > > > decrease the performance on bare metal.
> > > > 
> > > > Fix this by disabling virt_spin_lock_key if it is on bare metal,
> > > > regardless of CONFIG_PARAVIRT_SPINLOCKS.
> > > > 
> > > 
> > > nit:
> > > 
> > > This bug wouldn't have happened if the key was defined FALSE by default and
> > > only enabled in the appropriate case. I think it makes more sense to invert
> > > the logic and have the key FALSE by default and only enable it iff the
> > > kernel is running under a hypervisor... At worst only the virtualization
> > > case would suffer if the lock is falsely not enabled.
> > 
> > Thank you for your review. I agree, initializing the key to FALSE by default seems
> > to be more readable. Could this change be the subsequent adjustment based
> > on current fix, which could be more bisectible?
> 
> Why can't this change be squashed in the current proposed patch?
>

Current patch deals with the incorrect condition of CONFIG_PARAVIRT_SPINLOCKS.
The change of the virt_spin_lock_key's default value is supposed to be "no functional
change expected", but maybe just in case of some corner cases...
Anyway, I'll put the changes together in one patch and do some tests.
 
> > 
> > 
> > Set the default key to false. If booting in a VM, enable this key. Later during
> > the VM initialization, if other high-efficient spinlock is preferred, like
> > paravirt-spinlock, the virt_spin_lock_key will be disabled accordingly.
> 
> Yep, or simply during the initialization stage the correct flavor will be
> chosen, no need to do the on-off dance. But that's a topic for a different
> discussion.
>

Yes it is doable. 

thanks,
Chenyu
> > 
> > diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
> > index cde8357bb226..a7d3ba00e70e 100644
> > --- a/arch/x86/include/asm/qspinlock.h
> > +++ b/arch/x86/include/asm/qspinlock.h
> > @@ -66,13 +66,13 @@ static inline bool vcpu_is_preempted(long cpu)
> >   #ifdef CONFIG_PARAVIRT
> >   /*
> > - * virt_spin_lock_key - enables (by default) the virt_spin_lock() hijack.
> > + * virt_spin_lock_key - disables (by default) the virt_spin_lock() hijack.
> >    *
> >    * Native (and PV wanting native due to vCPU pinning) should disable this key.
> >    * It is done in this backwards fashion to only have a single direction change,
> >    * which removes ordering between native_pv_spin_init() and HV setup.
> >    */
> > -DECLARE_STATIC_KEY_TRUE(virt_spin_lock_key);
> > +DECLARE_STATIC_KEY_FALSE(virt_spin_lock_key);
> >   /*
> >    * Shortcut for the queued_spin_lock_slowpath() function that allows
> > diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
> > index c193c9e60a1b..fec381533555 100644
> > --- a/arch/x86/kernel/paravirt.c
> > +++ b/arch/x86/kernel/paravirt.c
> > @@ -51,12 +51,12 @@ DEFINE_ASM_FUNC(pv_native_irq_enable, "sti", .noinstr.text);
> >   DEFINE_ASM_FUNC(pv_native_read_cr2, "mov %cr2, %rax", .noinstr.text);
> >   #endif
> > -DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
> > +DEFINE_STATIC_KEY_FALSE(virt_spin_lock_key);
> >   void __init native_pv_lock_init(void)
> >   {
> > -	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
> > -		static_branch_disable(&virt_spin_lock_key);
> > +	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
> > +		static_branch_enable(&virt_spin_lock_key);
> >   }
> >   static void native_tlb_remove_table(struct mmu_gather *tlb, void *table)
