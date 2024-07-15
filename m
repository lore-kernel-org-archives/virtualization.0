Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A846113BAEE
	for <virtualization@lists.linux.dev>; Mon, 15 Jul 2024 06:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721025747; cv=fail; b=mQlquC7Sq3a14Js/i1rxlqBPoLritLFs97w2QL30QGirM8+/JOSi4X8Bu5+MHt2nEMAJWlqzhW558W1PSVRvvXt2+o29Xx3Rz5jyh1tn97fNfg2PrAgCKQBVjv90HAVqQnug9MuKZOjdW6uEl5wo0j0FlCP2+oQYRTk3mxXeDMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721025747; c=relaxed/simple;
	bh=X4TCM5xZA6RA9//gphZYr4q9OH5/5LVUWi0m8IzD4mU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F3qc36j7UD7YLe5esb9NlQ289/Nh8G+V0dG6HR2+hsuKecZ0W6OF0/AlxjI0ZDf9W5e4EkcGDQ6G5T4NXp44n4pMlW909bgQikE0bFTNjjP6aEDXxZ1DtUM4+ZJHk4jTQpi3kL/Hne4aeieiTTuhXRDYjq2ycpLmuskrb38cFbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xb8b8vDW; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xb8b8vDW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721025746; x=1752561746;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=X4TCM5xZA6RA9//gphZYr4q9OH5/5LVUWi0m8IzD4mU=;
  b=Xb8b8vDWgh7l8DpzO6xa956/qMSVMdSRbdfa5tFcJ7JprPQgwLAFnt7u
   eP5A3t5Tgv+ZnaHKD70OzZQ3hVYFHqdI5rQIGr0dtB0WNfdICboe6UViU
   Pxcx8oIojo+zfzot1/93DtU+Ufj4YUf/ONx3Ri0lB99Cu1WXBgkeJMkcu
   DR7VPOw734R3+jMqQv7kFrJNjFBQG10QZ9EOkIJdlmMW8kQXm/z4d1wI5
   d9zQ7K7FP71jb+p70+mL2V6VmgiyubZcqJlxU3KozrkEi1rcZgkAvTeFK
   zn4zYpQyWxjVOxuM1rFh6sd9JOXqS+NHDd9DfG8S2/q4BgyEJHS0nsPbM
   Q==;
X-CSE-ConnectionGUID: XvY+pqtFTlixsebGnsC4Kw==
X-CSE-MsgGUID: RC19aVu1QaSR8mxW/lrTvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="18538580"
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; 
   d="scan'208";a="18538580"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2024 23:42:25 -0700
X-CSE-ConnectionGUID: guxoxaFuSja9QKPbcujw/A==
X-CSE-MsgGUID: uf7SM1ACR+imfFgyND76ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; 
   d="scan'208";a="49407310"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jul 2024 23:42:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 14 Jul 2024 23:42:24 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 14 Jul 2024 23:42:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 14 Jul 2024 23:42:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 14 Jul 2024 23:42:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=diWQiy2ROinqKpPAVMWLEQfIe0C02uUm6I7EsjCe1WnZDm6lpnMuAOShkXYG+VahdDjGYFdogPRyaAZ1WeLIadYIvwmQVl8a587hrn2CYDzZGsYD4eI3KwDIuZ6vn4fDkeIJN6q1f0ao6qNakkInflXijBlEquFPnwazv0qiTH23oDc7IHaknhjbTg9ZcN0wQGZXk9TaX2DjxaFfZWt+Rl6Rm32oYVgUqDUss2U9i6MIJmDa1qUzrtAwQzv7tU1smDAmvUCrWVWkMgkVEgZ2sf1AosGk60XZtWwqD1w64KabmCf6qau25SU3EaS4FM7k6e5rtrRhzKf2174C2IPcmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e//uZMz+guhVmOxOPjLxsKE6PunEVhqV/pI90dI2iUM=;
 b=vGJUhE2xF0g1XGGJRmjJJFxuf/C7lJ/QKgcUDe4G5Yefh6cUj2rSf40JQ1iPI5caJzOKH2oYdTnFEcD58OMiAAJtR36+qAjci7fx4hPcciOPVBHObrH2otvgjdcY6X9Yu7ewqDMv4sL4GwQrqiNed6QDOpQTmnx+vU0oI8xjAxKLXidXal1z3iwXW7yoeRYO21jlqBuLLbjWb3a9BFU5ZFKb0pwHtTE+kVjgF9iCt6dbpl6wBkDHaltKw94QNWTPR6BRUoc6JzBKJITdAut9uOd6NA3NWeFmWVPb7arvMyPG8IHIq3gAFmIkO84mSRcx7SjpTt/v5qZyFcWPODDQOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 DS0PR11MB7632.namprd11.prod.outlook.com (2603:10b6:8:14f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.27; Mon, 15 Jul 2024 06:42:21 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7762.020; Mon, 15 Jul 2024
 06:42:20 +0000
Date: Mon, 15 Jul 2024 14:42:03 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>
CC: <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann
	<arnd@arndb.de>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Juergen Gross <jgross@suse.com>, "Nikolay
 Borisov" <nik.borisov@suse.com>, Chen Yu <yu.chen.surf@gmail.com>, Qiuxu Zhuo
	<qiuxu.zhuo@intel.com>, Prem Nath Dey <prem.nath.dey@intel.com>, "Xiaoping
 Zhou" <xiaoping.zhou@intel.com>
Subject: Re: [PATCH v3] x86/paravirt: Disable virt spinlock on bare metal
Message-ID: <ZpTEu6H14Y0GFg13@chenyu5-mobl2>
References: <20240625125403.187110-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240625125403.187110-1-yu.c.chen@intel.com>
X-ClientProxiedBy: SG2PR04CA0153.apcprd04.prod.outlook.com (2603:1096:4::15)
 To DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|DS0PR11MB7632:EE_
X-MS-Office365-Filtering-Correlation-Id: 51c287bd-c09a-4f8f-3a47-08dca49946f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eaNLQd78NKF1nWSkE5i3bAfB/EtsZ3/wPbj2pa5nwHir2YKZ3Ki0FZU6IcWR?=
 =?us-ascii?Q?l64urr90vMDCJpuo0cT5laS7iZUfNL2ivTT/FRIrbQ9RNX63yyscsiNeyZnF?=
 =?us-ascii?Q?Ny4eDJMriV3nmJO+JIkvAzi6tVPUoaGToElCGEIP/ROlQ/U+I+lnARWWmb2q?=
 =?us-ascii?Q?HCqsYWcEubrmvPRYAuwCwlrVuRgesKviWrM2RJ08+7GEtqixdcdXkG9zCvch?=
 =?us-ascii?Q?PsZ5MgGlmKNPA4VdMaJksG4/dgPE3AG33YKSjg03j91435v9RDjmdfnR5aH2?=
 =?us-ascii?Q?yeJBY8Hf+r+5rOpxCfShewPzUSh0MJoULGi/fiN7tT+m7nJfw8ZFoV2gBx3h?=
 =?us-ascii?Q?v7dExaRbHUOClXr46+WdDnQtJu8uBi3LI9oObJMGNbE/oMBVbuAWrTvUIHc5?=
 =?us-ascii?Q?JGpDN1vtH8rr6nJu0suVSgmmhWHX9aaOCH2RU0NyNubZewbXISkudTxZU23I?=
 =?us-ascii?Q?kM0iHY1zU678fl7o/szoUGLPRrAqh3ylRcS6wPgs3UwuSbhgTMfy1cMO/Oxd?=
 =?us-ascii?Q?jUtyuYio/Tb9EMhh22knZmB4+SmQcb9jowoqFub+j4vmksCfAh6WZ/Sqo9Z+?=
 =?us-ascii?Q?8XKFdInVluIyp/fLoTnGW9Z/DLHx0Hk2Mxnhsggp3E3135XL7bdLvb6PGWPo?=
 =?us-ascii?Q?FeqTMHGJvRfxWy4CV/uKp0WT1D9bL3dhacP0kP2RRbUtgnbSv4PWOo4ngpfx?=
 =?us-ascii?Q?89BKbfTWan3mG9xwO2Im7qZkBBm4Twt2qOJF8fA5gc9bYMayr9Nt9yukiY5b?=
 =?us-ascii?Q?MOUw9hpfyYqMWdtQlqnAA8RnvDACSAbFfudYbeWupBCdr1qPKJDroSn3HEU3?=
 =?us-ascii?Q?NApJeJlmC3+bZdBkzfAJQuesoLExUKwM8JTNs9yX61U9sR2bQZXx/ekeR0UU?=
 =?us-ascii?Q?j//zyw1nr+u8EcLsNUUTolyjBWugLBtifVcWmB81ydHFyWXMXfl4lg3brUOK?=
 =?us-ascii?Q?U0f9KmYCc+vV2VWZr2wx7A6bYxNuZPrld/joT/MVKnTfR9FV+1ufhDNJ+Oit?=
 =?us-ascii?Q?dP6LRqvCNo3U6RgFLbkaw3P++0tvyabAwkhI1XXzyuq7wjMXJXs/an3DhltH?=
 =?us-ascii?Q?ElJMT45Bxy/PkBCt1WySZ7QkqPW27AvCOjCo1OF5Hd3nnL+A85gx2C/qmtjV?=
 =?us-ascii?Q?LivuzvFkU18FsCO7pLDWprgC/TQUfTw3gGBK4Pcouk0ExXHKRPtK6do4XctB?=
 =?us-ascii?Q?QDEuTS7odN5U/lSp9j6fgakFa0IA30dYKxgZv4LaqUTrVMfe46xKz7qW6+cg?=
 =?us-ascii?Q?onV0UXjHRfn9iDt1KTJskf8/ztJWPPUmXUXsYlTXmKSz8Mqiih3qq473VEj4?=
 =?us-ascii?Q?po6IsbU0A9bihpGEMa8O2rYotFg9EaqgpqscTAC7izX2uw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GnkSxPleT3OpCAKgGZZ1IwhrMecz5SRHB5aeDewhj8cmYgcio8uphocNVvaK?=
 =?us-ascii?Q?f0yaEFPSoMROmNJpv2HNQghMZWKaqwEiGzqz5ps2vpBblYpRgIg1c7swmLCI?=
 =?us-ascii?Q?Mo8YJ01/cikOVx/vzMAyw0QVZc3a0bkpMzxWTFd0AZ6TgN4xrtbpMZa8KiCC?=
 =?us-ascii?Q?FjsK1v63ke4Y8KtSgFobi0cpT7Y7MzZr4hg9tLekzvdjnwLSHxUCfu+uoK3g?=
 =?us-ascii?Q?9QA1LMIrfpZW+9za+Bi4CnXCpbOL3pjkCJ4Cw8FZ35ycaz5mICQJEJ9XE2Tq?=
 =?us-ascii?Q?Qre7dgf17GTmjxu7DwMj8QL9MRpcDdSHaJZoPiu9RC2s5hHfs3zPCLCO66M/?=
 =?us-ascii?Q?JWcSJdro3qR5nSFlKzIj6a5rjvjT2uyTHMFOIesUbRAK3f9160pWUq3QAWLU?=
 =?us-ascii?Q?Agpyzgc6/IXDH6qA2yjQAycEB3NFfJM7Rusn8fVlojIwl74cUD/PH2w055n5?=
 =?us-ascii?Q?t3SHmyEHhnjiJdpEaJyVeeHCoodwnEZOoCdue+ItMzyNUyceBN1dTwvBzs6y?=
 =?us-ascii?Q?GN6xkorWSJGBDY6S8v8eR7LRyLIOaWGbvaBygiCTrCLcjlSF0NBpRr8mUCwS?=
 =?us-ascii?Q?ZjSDGjeGBUWMrMQ9xEHdvYlPam1f2E+jNy9kIgr/38VY254flPDOjPA8cWLF?=
 =?us-ascii?Q?mOAYcngFBZ92i/6fnvDGfVNzFLDJkiq42Buf1dzDOKJ3OCtuH853skr9flou?=
 =?us-ascii?Q?I33YPynV+fkHvVp25aMoTAtn2luMtht5bBhNI/wPJs5OuuKwc2KxJi9QSgWb?=
 =?us-ascii?Q?Vie14HyVjL1vTONOfB0Obs8r8A2qnelRG1Huv7lTWuQwWdK7UjhDFnVGBqWD?=
 =?us-ascii?Q?ur44OFcLH+uP/rBbepOm2en4oC7wImY98md+ia4Y7j7mXspeO9aVhlU/1zNS?=
 =?us-ascii?Q?aswXTxfdjSNdFNiBKCu4SB8o3X3zj/85w/qla9v1tgnqucPMXD7Xt85p/9EI?=
 =?us-ascii?Q?r1Lrvhi/w8oVyQFbQW4YXKXEFlAqA3ZC38csjpIAQE2UgHVRIZK505d9tbt4?=
 =?us-ascii?Q?zqPpPUuEsunRWbvP7H9LcMm2s3GAGVPqeUhQGa0SGkZIn3A1JzY67E9/LkwA?=
 =?us-ascii?Q?3IpEALwb0Jl8B8ngMcZnMUnEiUsGSEGZFA/JZzldLm5K7HDVi7jF7hWZsu8x?=
 =?us-ascii?Q?vfq28pTZTv2u/vnB04GQDt4BY1D48/CxE9dMND9ffkCtiXGasYikwdyooK74?=
 =?us-ascii?Q?udu4iFnpImzSOSXxJFhyA/bYgjQm6aU3OzmMJy6a+msDnnSMvQpFAdr2r5p6?=
 =?us-ascii?Q?zDFVUvE9NnbxeO+vg2ekAjZRVvM19Mj4iOC06sGtM9Jsa04O3/ib6EgjjaY5?=
 =?us-ascii?Q?EMgBNr1Tt+gxPz6Hn2Co9Pqm8TWXQCpuHAds5qRc2Ex+TyvaUbqeVIv+WO1p?=
 =?us-ascii?Q?ndkjxRRswouiJv3OIvryJ1zwQ8pRuVicNZTOm82b2W/wYmhrpBTOhup+NDok?=
 =?us-ascii?Q?8LTW+HKobT5gQ/gwcy7gQxENf7UQPnTujly6VfHNiIyn8R1hcELih4KD38oJ?=
 =?us-ascii?Q?FqCqrRM4YhS7ZwEzj8YSyXvffaiLWfgc1ey2ZNJb28Dm9O68uATE9FASnC4l?=
 =?us-ascii?Q?X3L0ZcnYpxkC3EmAjB6GajhoP2Vs8rCMn731k/ud?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c287bd-c09a-4f8f-3a47-08dca49946f2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 06:42:20.8071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NNLmqFoWjyuNDipf1d89xwKNygu4SuCgrpbkRZMoavHRqObusBfDFU7uR2ZpwMMz0S4ZscH9+iH5E5+3ERqvlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7632
X-OriginatorOrg: intel.com

On 2024-06-25 at 20:54:03 +0800, Chen Yu wrote:
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
> Set the default value of virt_spin_lock_key to false. If booting in a VM,
> enable this key. Later during the VM initialization, if other
> high-efficient spinlock is preferred(paravirt-spinlock eg), the
> virt_spin_lock_key is disabled accordingly. The relation is described as
> below:
> 
> X86_FEATURE_HYPERVISOR         Y    Y    Y     N
> CONFIG_PARAVIRT_SPINLOCKS      Y    Y    N     Y/N
> PV spinlock                    Y    N    N     Y/N
> 
> virt_spin_lock_key             N    N    Y     N
> 
> Fixes: ce0a1b608bfc ("x86/paravirt: Silence unused native_pv_lock_init() function warning")
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Suggested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Suggested-by: Nikolay Borisov <nik.borisov@suse.com>
> Reported-by: Prem Nath Dey <prem.nath.dey@intel.com>
> Reported-by: Xiaoping Zhou <xiaoping.zhou@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
>

Hi,

A gentle ping of this patch. Or should I need to send a new version with updated
Reviewed-by tag from Nikolay?


thanks,
Chenyu  
