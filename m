Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD46179D1
	for <virtualization@lists.linux.dev>; Tue, 18 Jun 2024 01:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718675235; cv=fail; b=AwCSYn11ax+eAxn+rGdA6ohYpg9ru1Jacsro2+VHVRC1+/dhBHi0Xo3qDrazwr5kXOlD4d76c7Xhd3UEaT8aQpSz5vM901Zg8KOcOKr8vZfvxVmCTv5s3Z319qRx2DfknnR06jnfYxbYlBV5ybiVYhsIbVrpMrRQbkc7zHmnx3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718675235; c=relaxed/simple;
	bh=vrDi0ULQaAhCwBtouJsdoUxRWf+TLrY1XaMTxR1nr5c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WRKg+9B9np8jnDOhYyiXK9F1n8sO/gQZDl8PO/QrrfXXRDV51UA2UHINzJ0xmBNpr3m195sRvLdKC4kmIoZHXYnbeL8oAs2PWx73lCbHkbL5uDSYlZ5bjTVlSMsiadSbim3R//Qvzj/GyiBepoRuCgWjV7Q2GhC6F+ZA2ksqzEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bm1Udy+i; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bm1Udy+i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718675234; x=1750211234;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vrDi0ULQaAhCwBtouJsdoUxRWf+TLrY1XaMTxR1nr5c=;
  b=Bm1Udy+iFUPBoR02DuIvF00ZFIWZB/7v5G8A3uH2kGKPy3gpYT1AGPoa
   EocfZM5CPzC2HLRtXpw0DSf3T0koNHIm+BzHM8m6/66YK50JgBVQvJmbH
   MLGTChQhWwMzO97NrrOBt5LOYonDJrI3sR7jxULPzrDAaeqwSQWiUCcju
   91y5DtkZHkqZfq229VT0HBegW739lIj0Q08VJLnPj1D4t58xDxWynSSHI
   9vx12tU7dnVp2lcYnzrnl4AkYMyyezFgL+XYUVH0ur0xdI0a1cEKlGqz8
   cbZQp3aQPlLvTpNz3FNOU8yzpQnA5movmGemeHqqxEqMklEwT176u9dIQ
   Q==;
X-CSE-ConnectionGUID: enCePlNFRh2nQMEkFLAJ2Q==
X-CSE-MsgGUID: ryrUcIDLRwKLfSbZrI7CtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15400369"
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="15400369"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 18:47:13 -0700
X-CSE-ConnectionGUID: 5Zmc2HlQT9OM6JTmCf3qyQ==
X-CSE-MsgGUID: fnWOSD9KTrK62P85k+dVZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="41249955"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jun 2024 18:47:13 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 18:47:12 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 18:47:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 17 Jun 2024 18:47:12 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 18:47:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYtSTBrYPOTtOZYV6/c4FPVho7FB9tlYwQAfa0GI5urgcKvM4a5YRloYI09xvBBbIedmxKikuwltjNe8UECdv/1GJltfIBJMbrazezddjyEpd5L7m6nEX/VONC0lkeI1Q//cLiRgXeIW2FKKhcxzADr+aektGTEHVx7mC242n7CM/JR5g1/ljCcdR0vdOx3CFcrmfqp2TyFihAakP65sHEd2BylurgNvNcLOGO6hyPea8bfUtpXxzqd3s3Id1ALmomGumZYXwpUvngvFz3gfqLY4Db4sQcOSfuq+/rIQcVOeYvqkx1CB5FSJrdsdUwcagpbgd8bplV8gw5fI05iTNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkAKnLDLjMC5GKDChgWQ2lKYMKCvN5K94hnidoBr4BA=;
 b=OsppgY86vP9Ypy3CbM4ZEYaluA9u4U2OwA+6+p2KgNMp7nZjAv8rfKsTx29siym7m9VE56fwLlc4tOUIwsG5kafaytRd+2xIXmpCOWsx5SotfkFj76tOZvqh+9DlezPjZCZJyODvzrmMqXn8n8DKIVZaA3JtBLivBnJRoIz0HKMDtTiyBNdkxao4HpWJWMf1HvMGjns/RAyBQC3EGxfH1HIklRgvX/vYGem+M41o414dL47XxUquQ55aPfLX/r2CCvhnmCBUO2blBHtoKMJ7c34yh9FcpMDCB397ySOEAWWts1sHaiqRpm0oTCvJcwKj7ou/m3vjPtngg32fUAshrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 CY8PR11MB7337.namprd11.prod.outlook.com (2603:10b6:930:9d::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.31; Tue, 18 Jun 2024 01:47:10 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%7]) with mapi id 15.20.7633.036; Tue, 18 Jun 2024
 01:47:10 +0000
Date: Tue, 18 Jun 2024 09:46:56 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>, Juergen Gross
	<jgross@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Ajay Kaher
	<ajay.kaher@broadcom.com>
CC: <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann
	<arnd@arndb.de>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>, "Prem Nath
 Dey" <prem.nath.dey@intel.com>, Xiaoping Zhou <xiaoping.zhou@intel.com>
Subject: Re: [PATCH v2] x86/paravirt: Disable virt spinlock on bare metal
Message-ID: <ZnDnEHV+Nxj0OpVs@chenyu5-mobl2>
References: <20240526015847.14142-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240526015847.14142-1-yu.c.chen@intel.com>
X-ClientProxiedBy: SI2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:196::14) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|CY8PR11MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d1958f8-eeb0-48ff-9108-08dc8f389194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011|7416011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+aLuPdnNO8M8xcimLHFEK1s3FG8JJBQNgLrHxEY35YybjkDP77CgJO8Bw19U?=
 =?us-ascii?Q?7y0W7NquMZYiPrmGhjbrBgXoHToXr/6oCZZc5rxu2QqjM3LG3xq9LSb24tfT?=
 =?us-ascii?Q?Wjvq6rVBqBDq0wDawo4sPwzeU+nJPAmMWMzsXTawUYxceTD1RkuAG7JApvDr?=
 =?us-ascii?Q?FdDKcD68wyCNSfiXtxJKvSIIkc8xTRYPEgui0Eeza0XZGVg3HD/J+Rjyr9HF?=
 =?us-ascii?Q?t2nl3dW9m0SzjOBriu2Nqg3NNjFryDjyJBuk6h1oEUK03+YabmzpqUG3lLtA?=
 =?us-ascii?Q?Mc+XlqwMEVV0k6cYLABa/Y9ARuRsauNIZDffvdKixDCoy3Fef/dP2XtzaOWR?=
 =?us-ascii?Q?c5yOx0xZJTAkcuHqO1gEg2rK7E6l9Ry+0LMg3KLlOuFB0vagJV55jRq6GstV?=
 =?us-ascii?Q?xwzRNfrXZlzAGOeTeB7RdgDk5oPejN3MW3eyMoHkmKhWwLT8YTfl8qVNdoQR?=
 =?us-ascii?Q?6NWfPtOiZg8Lj/4u0HFgSjWbFjtx8CFhMKrY1H5oTe95zKNEfeqVdWuoauah?=
 =?us-ascii?Q?pdePtn6HY/7php6km+kZIQme7SJ1sebEjNcQ2tqc8dVEgeTLdqulgqBHvsEq?=
 =?us-ascii?Q?xjVub8AJjiAXrf4SexMDE4QQ7LtP3nCxS8YxMDrrADwFDIqA7kb2b1ktrQRE?=
 =?us-ascii?Q?KtF1pRGsAN16lSd53ZOf/QtJuRTWoyqPgLWvPJ9TfFkbhA4CQoiKtlw5zA9L?=
 =?us-ascii?Q?1OwBneqXIb+d6/6Pf5NwwcB/To/PMikklQ/UXBfMcjSYQyRTpmtDmm+3tOTj?=
 =?us-ascii?Q?Ws3ba47m6vlfUqBt/gqR6BWAjoJsWlK1PS4lciHAE3TUmPxUC2HkiaxaKoKc?=
 =?us-ascii?Q?Y9UwUfFgzrszGKhjleME9UIRIQlzzd+6Vl49ezKpt7RdVZO9OzCSGQAnx92j?=
 =?us-ascii?Q?y6dK141d4XNzN3+I6Yx8uYsx0PCAPY0C9pUG614OM7tz2WrlgDWfz98ObjDv?=
 =?us-ascii?Q?WZAVwsprCLa0809DlL2VczOV65FbTfELDM2t5KPvucyOrI3MeQ4l8f7ve5FI?=
 =?us-ascii?Q?IUD2HJxXnXBjdWgB23FPWM0HrYw9JRCiSpsyO1UB05d8I0Iy7Lfa50qLAdzj?=
 =?us-ascii?Q?vyPV2sUQUp0DCcGHI5hjOarnRtrmY5XxCjLUi1hAkCw4yh4hC/5aeBg5Vdlo?=
 =?us-ascii?Q?KtrAdTumrdYgndTZNUuiAnj1HwgtEJ/HSnm5vLGmIaGW2VAfdFQRgQp3xx/n?=
 =?us-ascii?Q?PFt+dXvwThFWRIncB3DfMLNSqzGNpw7vp81SU9BhHEVxyb+RAN5rT1JBZ0yP?=
 =?us-ascii?Q?WC0RHyWOI4UewlNL72+NyJvxW/jOP2MBgjuC51v5Q9DsPg0YIXu/m285AYvW?=
 =?us-ascii?Q?4hI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(7416011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1IWr2mPjApYxWKDucSwQDAhrec/TCl/KZoYbwQ0Aqe82JUvy6dpXnigEJtz8?=
 =?us-ascii?Q?B8CT1JscizYzQuGi4YidQUze0s6iDGsgcnKETH4IaBCHxdjGp7jve871OkT3?=
 =?us-ascii?Q?qFkiWgi+zbwdOYvl4i8gh4tnDpE89ivsTtCogr3N5H5W5w7EgMrzCD6FI6ys?=
 =?us-ascii?Q?utEs6qrLENmNArJ6rTay8g+xCj3xlf+E/PCgolt2Mxh6SbanKTKz9AIy7TIp?=
 =?us-ascii?Q?yG/foojjx5cOW6GxBON5PYP+VsgTpZk9LYsDCLNYTCeFRWEvMdkZZ1Y55rWw?=
 =?us-ascii?Q?sxlkBkdNLuIqyg8zf7DkpeGPDtkPQCa6eNcmdjOb266VAPQRUExGsSO9nIHV?=
 =?us-ascii?Q?TQ4gsa8pOTArxFlQa7vccdZtkuSVa7xpkYbb/oDaXVABprTGGNm5I+I+hD9A?=
 =?us-ascii?Q?ZqUO41yyfwom8OWghC/RkU9xFOvB+NEf6wM0biStluSI/hZ0EKorj8mQLMnx?=
 =?us-ascii?Q?ExWb6h/wgtr8jPdr/8+j+bmGu6iqfjnz5s7yKt5hoRbRYuSuERWR8nPkJIaV?=
 =?us-ascii?Q?wPr44dZtjWmGkt9ZcWFI296HDE9MhMqtXKdaXnP0iOXOvWJE0Ab8eBiHLbPV?=
 =?us-ascii?Q?sVnZbJ54DN6X1o1lc0mndOOVgwOIFh+XFwqjVwyUMuYWZstCkAp3TEWoVPKU?=
 =?us-ascii?Q?Vv3IcRZcuWdR0nRsU+ewM4pf2VG6pnIsOHyO+p2mUzzi5Hu/EQnwHYb5Zl1G?=
 =?us-ascii?Q?MJkayoZhUhg1nCuV1C4CvyqcoO405iwdTiWXMk78vpSurMkUMDYA4l22FdVt?=
 =?us-ascii?Q?LGCfZVrH+JNk/uNaR73ggjPwnKsmhQl6vHfj+RTckSVJLFCP7HejehblYXBl?=
 =?us-ascii?Q?P3HXxbmZbEmQ46REV5/b4q+9JIeTcBqLNyvwDu9YvPBpz51Xzk8ZFvZGDLFw?=
 =?us-ascii?Q?VzlhRkePzjTWFIV9ZGY3bPTvbYrcTDoZWMQ5xmHT13fjP/xxqrJVBTuiLzvg?=
 =?us-ascii?Q?54fgoNf0uXLv3aC+eWTgfqRj+Pca67+5VMQtJUehJTKXLWkSghj4ZiVXDHSn?=
 =?us-ascii?Q?nbKB+uaVf9iL1jc3lUBvxWEw1FkAtWDpqmjLzXaNhYPhroh62s7IjXykKhVx?=
 =?us-ascii?Q?EenXa3n8diIOjJaF77uT0IRoe4IpQZNkG19DrF32uznYwMw9WfuZhAmSeHQC?=
 =?us-ascii?Q?s/pJ1wkWnfW52S9ipxpED0sMk6wdCuzdnwoa97Clg3YG+U080V5OUm8YkcNv?=
 =?us-ascii?Q?P+LYpityzUgthFEPlKD0g4xLTqW2kO8cNnRtmOHdh5MNAM1rgAPqWxtX/Flc?=
 =?us-ascii?Q?riiptOa2Ej+dFILFigIDeXgzShVfTKlOUawwiQ2CjQIgmL5Hba2KKuz80Lcn?=
 =?us-ascii?Q?bzKJqsilMSs/IdJ7OqoFojBYVHNRYksfTWjQa0+cpzA4ZgQIhJ+BY+gxWv50?=
 =?us-ascii?Q?tZgmsdOQdf6EcLF8wv/TDyE7zgyb04hRlMx3Hqle/S9y4jaFUbCooDVyRn4e?=
 =?us-ascii?Q?UPimwUwWsJpKEVGfN7Ey1sb/YudnzccELXb3tfjAmqOEQogIRNmoxXXmZTBp?=
 =?us-ascii?Q?cioXWvXdnfJtOtyTncoE+8SrXzodfyb64ZZnQigbcIvSjLJYU47eyd+csc1r?=
 =?us-ascii?Q?aXiCoGYR6sM1Vyh2fjwSQFL6i2aOevmZi99y460N?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1958f8-eeb0-48ff-9108-08dc8f389194
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 01:47:10.4291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gw2CDTx5DJz8e6hkaitkBCumkF4uk2RF+odQXNcd5IssqRPlUfo7A3PjBluCy3VDHco/8Wv8he/Q9LLOrSXnNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7337
X-OriginatorOrg: intel.com

Hello,

On 2024-05-26 at 09:58:47 +0800, Chen Yu wrote:
> The kernel can change spinlock behavior when running as a guest. But
> this guest-friendly behavior causes performance problems on bare metal.
> So there's a 'virt_spin_lock_key' static key to switch between the two
> modes.
> 
> The static key is always enabled by default (run in guest mode) and
> should be disabled for bare metal (and in some guests that want native
> behavior).
> 
> Performance drop is reported when running encode/decode workload and
> BenchSEE cache sub-workload.
> Bisect points to commit ce0a1b608bfc ("x86/paravirt: Silence unused
> native_pv_lock_init() function warning"). When CONFIG_PARAVIRT_SPINLOCKS
> is disabled the virt_spin_lock_key is incorrectly set to true on bare
> metal. The qspinlock degenerates to test-and-set spinlock, which
> decrease the performance on bare metal.
> 
> Fix this by disabling virt_spin_lock_key if it is on bare metal,
> regardless of CONFIG_PARAVIRT_SPINLOCKS.
> 
> Fixes: ce0a1b608bfc ("x86/paravirt: Silence unused native_pv_lock_init() function warning")
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Suggested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Reported-by: Prem Nath Dey <prem.nath.dey@intel.com>
> Reported-by: Xiaoping Zhou <xiaoping.zhou@intel.com>
> Reviewed-by: Juergen Gross <jgross@suse.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

A gentle ping on this patch :)

thanks,
Chenyu
