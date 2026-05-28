Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CC4369D60
	for <virtualization@lists.linux.dev>; Thu, 28 May 2026 23:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780009663; cv=fail; b=IKDqAc6UiSmV+oWtqaJeCp+O00civA1RBFxCDRcjbzgX5cXWWehShOW8V4KOlxO2ZVyhO7rznuOl4rSFaPPuNauOg/KE+kBcrgxwkwdcfj520NisBACPCOdH9Aqc5g5T6yTObQFBenabDdC+QHFBJUc6FPZLTZJ5x16VihNJH64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780009663; c=relaxed/simple;
	bh=meiPMbn7O30ho+uQ+421pG17klqJs6jYgQXrOQS/nSo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E21kD/vkHV6a4e0Evp5ZS2GRjmsFP3jNGQnddgZ1X79ZjWeyfVd1MkNrxUo6cIGgvwHj59LTsXKk9voD/l0JpULPEKE2FoczCRWP5h5ym8a1AX1sHULQKCpFXvEp6nfZP9fMJiV5ia7oAiTaiujsyJMCaXH58DEdT2MXoKDMJX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dz52qO3k; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dz52qO3k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780009663; x=1811545663;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=meiPMbn7O30ho+uQ+421pG17klqJs6jYgQXrOQS/nSo=;
  b=dz52qO3kAOYomVB0gioG6gYazfpmaoDJkFjJx/OLpQYK+zgTPyQzeI28
   D2/FCoi1CCcKAmR93GF7ky1OA9ymphdWak5xm0PIAIupJrqo2MNk7t3oK
   mnXFJDXNbfXYUnqNE2YzHl++M3PFZDhVv2bNIDnHsQazeUgUqkWJMoEus
   0ipgCAWoqNl3ZgkVPuNqJmO/OmTmLYhRHruuTdM6LOZzHOqI6lt0PWGU3
   PUcKUUVYq2PXYXaad1Eob+G3ig68AQJfQNjhaC4jQo9mxeed81Wz6KUfx
   1g9pfDkaOB1Iy+JVsV5RJXiwUMVWo3EIh02qQ+kWmoNVVKSPllMHe6N21
   g==;
X-CSE-ConnectionGUID: qQrdUpAQQLeGZMzGShjP3g==
X-CSE-MsgGUID: P6+jsNsBROG7otEGQDZRUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="80833757"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="80833757"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 16:07:42 -0700
X-CSE-ConnectionGUID: nK3xByBmQkeab3CopJe07g==
X-CSE-MsgGUID: pXLR/UOgSDuyveQe2yRKjQ==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 16:06:17 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 16:06:17 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 28 May 2026 16:06:17 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.1) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 16:06:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5fjMRMh1ARL8MIRkQyHjH3JPrWXGyOCUjqPOR61EFuZMSVL3Fd8UtuNQEbdNNV1KQEGTqFaILkrDw2GE9V+3obuNDgSJQ8MzTbZatEQobhHaCgmK9ZnMvwNhSyreM7e9YbdxUHTdUDcq4RbihAvV1+/HgGPcTHVyMoCS4sqxZ+Okdu/HH0XSbwub1VVguP9LhjZo61FDvH6GgYgRZl0SkjeJCi8sBxJBWaRQXGhfzsv/yO7Qkyh2aOY1c79GGEAY8wP23WaNYwQT44iU7JCqwo5oYW08C9YIM+a2PFXbU7SeyI1lqNzSZ1o7+VFmzyn2TyzQCTTHsxxKJrtcxbzsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sApeW7UEnrQrXsvD0JAnnc0VJk64HInV8xz2suyi45I=;
 b=Rgr7CGCzqftnRlQg5MfzfczDiYVG2EFgwetC4dyemExp08zdafJ/O4HraN72L2JpLzaBzErYEajPogGtBwdkmgzjPhat+nK2xScb/yXE3D/B1IjQTqGuAZosL9UpqwNrYrEGRjcR8pL3XMgtBZzKN5MoVj9oPxFszqxqs26q0NZkKkQFgd2VaLSF7W4txblyckOuV8k6q6FpdYzybN5PrvRzZcgRDdfVPeyzddSCbKTcRAS0ACENRACFvYjbXTAyEZkFMf6+rhSl3EzqcEQ0B4Auk5zIS6Fi7f6GLW8yZYRwreLRt7HIv+UCQQp89j9dmWpp7ded4SRCZC6UzCFamA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 23:06:15 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246%4]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 23:06:14 +0000
Message-ID: <a0d76782-09e8-45fd-b53a-8cb621aef596@intel.com>
Date: Thu, 28 May 2026 16:06:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] x86/msr: Use paravirt "calls" in common code
Content-Language: en-US
To: Dave Hansen <dave.hansen@linux.intel.com>, <linux-kernel@vger.kernel.org>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, Juergen Gross
	<jgross@suse.com>, <virtualization@lists.linux.dev>
References: <20260429184517.7E078510@davehans-spike.ostc.intel.com>
 <20260429184519.A701C74E@davehans-spike.ostc.intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20260429184519.A701C74E@davehans-spike.ostc.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0234.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::29) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|DS0PR11MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: b12bdeb7-6ef5-4f6e-975d-08debd0db7a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7eOZGEwunWT7aHnjCK6mAy4o8oQjm9L+ZiDmb+1WlUhn2tUzyKE5QkW5cnRnIjFmlUL7DnSDocHfS7R/adaZXs+F0u0yC+hxO5Wi7dhc75OtdYOfTS4r0gJvq2HKIo2i8ctKSI5fCNukKQb44SKmGzrGyrq2tCccXVkR1VyF4B+Fe2gkObvgyUvD4i8P+HISexQDEQkmnhpSb3qcgyK0MQqWfQmYlZNqCifPvA//vFSFG1Q2khCJKbhyyfTZYtm4n6268u0wDDNyfVORNiwoLllesG+BILnjcx9a0v5IRVnjZAUS3SCmA2WvcqImf5UKZJrh+WD/ngueE7K8MLc5znQuBD6X8pdTVCkWdbmymPqf13jIMZT/rjrRPGvFe2u+STrGKLQIbfjGv0s5mTwStPIwWaY7WYj0LAGvsH0/QT4njKPaacFsh8mPShHBKVN4Iq33FqDkqLbhH/8+QGRHOn8BhxwnU2a3c4PABEGeVLOeBNh84frlbf2DjvoV+CU6QeZbkonBedAQoTLS3GfAuHCJjJOYX8QJl77o+hciKGsoqibrGn0zEPlyZlhYPervnVzN5HdKn/w/yNrsPc1Pk1woZ5+PllcxNxQoN7zYiHaDqE2LPThfbvdrdYf2LZrP+452NERxfRa+n6bM7HJmsjVVYBHODtXpyMlxR1FULWowRdEG4ZVmnsnCNdkEyFJn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFRJVEVmRG9NcHI5SytFNkFzRzJIUUV2VTJWUm5Pb0czRytBMXNOMmhjTGty?=
 =?utf-8?B?QWJnNC94b2ozSzVkSmUzUXlXTFhCMHhBdG9pQTl3N3NRVkpNcFdPU3p0eUJ0?=
 =?utf-8?B?SUdiYWR2Qy9mcW1rWTcvaE0xSzFaZjR2cVp5VkdRZC9LdENGdVlIYUdqSEJK?=
 =?utf-8?B?ai9vdUZvQkZnS2dtSEg1MVNGMDlSb2luNm1EeVdJUXdUc1ZNakJnY3FleitD?=
 =?utf-8?B?OWQ0RlpSdFpSdUlScHhrdDIxVGtjL2JNMHVwSEgzcXZHWjRaSlZUY1MvY2di?=
 =?utf-8?B?eEgzQ1ozWXJxaTRYekxGTkFGWm9UZUJsekNnU3l5eE9oaG9VS2lWVkV3TjUv?=
 =?utf-8?B?UnA0bDZ6T1pEY1lvN1JIQ01Lc1FOQXN6RXY0SjZiWC9ZQW5RdjAxYWM5eWw4?=
 =?utf-8?B?U295b3hCSGFvb3JTaWU4YkZEcW5jVjBkSk8rVDh1T0hqUnR2bTBINEJqYnYx?=
 =?utf-8?B?d09CU2JYUEd6WnZrZFA2WTdNVzVEMUhlZkkvMDR0OTJaZ2VQNElpLzF3d0Jy?=
 =?utf-8?B?c2dYSHhHZ2xqYm0rdXNWSW9sM3JKc3l5SHpweEFRQmVlNnF4NStXWlZjSmJR?=
 =?utf-8?B?WTRkSVpZR2N0SE9ZckcySUY1SFpSSXM2YUlqcGRDaUthbUdOMmxCNFZ2aTVV?=
 =?utf-8?B?YUsvZFBPbkVTYVNUNmlCU1ZRRG9pUFF5OUlMUnNNT0g3MmFhUW1JVDJPWlQ2?=
 =?utf-8?B?TDJTTlFpUi90RFE3Vm80bVIzbDFsQVhoNEZ0aGZNRmt0cTVrSUczekYyZjJo?=
 =?utf-8?B?WSt2dGd5NDdhSFdlczRTZ1djN2tDcFNPVVFWOE95MVl1MVpmSkV0bVBvVlBK?=
 =?utf-8?B?T013eDVMYU5kR2ovV2lZWXRZbFFNbGtBSjBTNjlyTE50SlozRERHMURIQ2xk?=
 =?utf-8?B?M1hEVWFPQ0J5UTZrRjZ6ZWNab3U3cHlhQVBzVG9iVStKZzVZZkU2SGpiaDBK?=
 =?utf-8?B?K0orVTBKQzNDeGxBWUJGcHBQaUZGRlNaRHNOWGRBbmhRSWl3VVVhdUpzM09X?=
 =?utf-8?B?VGI3NXlXcEpUTnlTWE5lRWNiMTVCamZKMlpUYmt1TmhGN055NHh4UnA4TDUy?=
 =?utf-8?B?YlhDempzbDdaRWVtSkJUWENmOWlEcUo3aFV5ZEJvVmhmeWNlQ3FLcUJlYi9Z?=
 =?utf-8?B?dk9SZ1A2SnFBRmx3QjNIWnZoZEQzd3phUC9wamdBZFgzS2NvdUgxazJmZVJ4?=
 =?utf-8?B?MWxCRHZvd0g1OFBDWjZVSUJxUkVSdG9KREx1Nks3eURjNmtKWnlxaE5FRnow?=
 =?utf-8?B?QzdqS2hwcjFNOW5rSmpmSGRoQUJzRjlUQWxvVEdONjlXOVdjSEx0aHJDWlha?=
 =?utf-8?B?ZmY0aldsNktXUGZXZ09yTDVmUWdjNjcyTUJabXRRUHBFaGtWK0lDVlZOWXFq?=
 =?utf-8?B?WVFMREFhMFN1b2x4TGxOOVVRblV6S3lJUHNBK2V2V2VwUjAzRHQrZForMk9V?=
 =?utf-8?B?bkZHVWowTUJFWTZEbTYwajdsWEVFRUxLeUtYem5ndmpTaWRVVUVyNm95emlY?=
 =?utf-8?B?WllBbzNRbFBISTBKb1F2bTJtZitoMWVpdlZDTUFBM3NjRFdCdlY0U2tJeW1X?=
 =?utf-8?B?NWZLRjFtU3dqNGVvV0dqL1lwdE9zeW5aOXA3UWtGMlJIY09YZXBnY1BTOGw3?=
 =?utf-8?B?VU9kMHVSUVhKbEE1TVg4SkFLbnVBQmRrcE1PWCtzNERrQ0xwLzY2bXNDOS8w?=
 =?utf-8?B?Tjk4WmQ2aFpPQUNtSVBhN2tSQUFoYWNaSHlVNExTdHh5OUpTQUxRZENwQ0Jt?=
 =?utf-8?B?OXJDcU9IaHRPWGJKTFBUM1JwbFpLUGVWT2l5NVR4RXUzYm4yM25jR1kvSGE2?=
 =?utf-8?B?OGZ2d0t4SHBjUlRXNE5hbWVRNSs5VGhBNXlUWnBTc0t2cXFOVXlZYisrK3Fz?=
 =?utf-8?B?bTU5V2FFNWtrQ2Nxbk1JL1RodjcycTVrMWZuRDRuN1g1SkkrZmFSdFhYRm9z?=
 =?utf-8?B?NURlS2pJWW1JRThrU0dqdmo3eVpZRzNXRlVBbnhmNlVSZ3dWUmJpWkpKdUpU?=
 =?utf-8?B?UGZ5Rk83VkRjOWxqdk1tQ0xKRlZXUE5TOFVuWVN0aUJOc2FtVWZvL1N0VHo0?=
 =?utf-8?B?YW54VXgzZmZsQWg5ZGRCQjFtaG5UOXhqZ0FqVTc2eVlERGUxVXB4SE1NaUZX?=
 =?utf-8?B?N2Q5d00yck5YTThqdnNIVGxhVFpJcmlOVHVMcEJQK2szV3cyc2lRQkwvOTlT?=
 =?utf-8?B?MlRkQU1jcUdyVTV2MHZDVm8rcGwzSFF2V1A4a1pJK3J3aXo0MWNRbTlsTXU3?=
 =?utf-8?B?T0pSbThPVFZVS2lZNVZ1dXlXK0VXbVY2NU9pRDVZd2Y0bXhWYXBKQ3diNlVO?=
 =?utf-8?B?cnljeFN0aTJ0ZFFzemlYT2pGUDUvbUZDaDl2UUlBZkhmTXgwQ2pNUT09?=
X-Exchange-RoutingPolicyChecked: WOq0otFw0fBTF2txrUEnE9MGgT6/GH9jx+uq/Qpg/rVZO+B5UTWe3X/4PLqpXSZ30IGpUDzGaoHcKqdNhydByJh5oo93RPzTIHAnPcrpHcKoqDlGB5Z4dkpqAOu4rpZ+BViovh6Mbw/0VMVGbmVaNliJCifZSOX34EZTIZ+BR3JsK5ChsSfK3AIHIu6FxrbtcJmbxQllYLOlC2eEOfZJzc2zFCWfui2hGux7qy9bOzJGn1Sn8J+sDSCwzmlxW2CCWFkMQL1/OppcJk5bQH8CPjR8PFdgWrVBZQFJ1ujiX/p2nR+rKj/fQkT2noWrJ8sF7s6LmswXaecAeD5oKplObw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b12bdeb7-6ef5-4f6e-975d-08debd0db7a2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 23:06:14.8352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dw6zb48B+SMW1CAri5n1TuzNUShnL2m7wpiTBwY2FUdqFxHczKT2cZ5RSXVbbUCs5egqIXrUGvFuux9weE+s4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6375
X-OriginatorOrg: intel.com

On 4/29/2026 11:45 AM, Dave Hansen wrote:

>  /* rdmsr with exception handling */
>  #define rdmsr_safe(msr, low, high)				\
>  ({								\
>  	u64 __val;						\
> -	int __err = native_read_msr_safe((msr), &__val);	\
> +	int __err = paravirt_read_msr_safe((msr), &__val);		\

Extra tab

>  	(*low) = (u32)__val;					\
>  	(*high) = (u32)(__val >> 32);				\
>  	__err;							\
