Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80DD157E6C
	for <virtualization@lists.linux.dev>; Mon, 29 Jul 2024 18:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722278876; cv=fail; b=aSylfkJNJdMKXlTWLMT0bjsXzKuuqaD2vMcGs4acr5/RfuvbQVtWKSWy5DOZ+BQKwqGbF+Ylmo/Nx0PoA79dOeFNJhNBOxYoAfa9A5g/e0C6Bd32Y/1NqOLSqk/1Uvn7ouUY9kuYJLw5NBBGTEwqPjdRVajAQu84/3U0jbi44Zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722278876; c=relaxed/simple;
	bh=ATtMWJ3+fQOoyKyoDSVWbHLoW0wW7TcQvDFlzrdQkv8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kjTbU2r6KPMsOSgsZh2pIEE4Izu0iMauiQV9ycHmqmXbJoOZ/hJO0lq6MFe+KpyHzPg3YUYZ9VYo9n93AMw5gjcvlZj4uYJjAmEGGho1OI44PqilTFZR1WG+Iu2JsFPECy4rnkKMJTbYCyCVA5jqJigcEN3JgzV82yXkKkw2Hr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cijJl9Tn; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cijJl9Tn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722278873; x=1753814873;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ATtMWJ3+fQOoyKyoDSVWbHLoW0wW7TcQvDFlzrdQkv8=;
  b=cijJl9TnRu4FSM8Q3BqVhxjo5DqA0xZiqqcxUQtxpwTiZRHPjFMZtRdR
   XseRBpPQWgBw7swJcELfwVekxhTOkXuz+bARRpwGshEKyqXRbG6KGNi3D
   7jyEemAgY5UIJ95xRHcZ9KR70iENl7ECYMuAm7RegsKHKbiFP7QeBOtHN
   wG90ozHsc60Mth/rU3sw1U00GNHsYfQ2LS6QbSv5no/48ShxSq+eCnscF
   NECDXYRUCwVSMQqiyQZCfPUX9wlvtRjkD/5Z1c8p/DcMxLzzc2b/EbIqL
   vLIvaupVKfVhU/9zkFqgYTLRIFyPfr2Qg/u7jPN/08wz/0Bp0OFeNQ+IH
   Q==;
X-CSE-ConnectionGUID: VlaH5+PMSnanI9HhsYdTEA==
X-CSE-MsgGUID: qhiqBMJgRw6g0PA2V+Y1KA==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="31455008"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="31455008"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 11:47:53 -0700
X-CSE-ConnectionGUID: Ht+HgEIGSJKWeRjZzXdkIg==
X-CSE-MsgGUID: 0Y/xPs0IS8mj9UvEnls9gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="53965697"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jul 2024 11:47:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 29 Jul 2024 11:47:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 29 Jul 2024 11:47:52 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 29 Jul 2024 11:47:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AtcmXA3vLi90x3IwzrbQ3PqMFGINlp9p920VLADyQU9bMwTxOtPG/5Q/SZLvtGGlVIeMfcS66Toj+L+2AuLXpdI18bDYBKQIg9fR4XVn5FfAjtcnXCoj+cWtsTaVMAq6wGlyoLZjvQFoZGV93+rKhnjxAumh6Ap8768Cg7WdZkMCRWO2Snsp4g++QJAYpMklsdpru43gyJorynXD+7aKbN+kYQLXFALMQXlHVow4XxcPLkPIiuHzs/RW+hJqX7X7DPNMrxr221QK8OT8/6wQlxNWW6HKBChJ1zhXJfJ6riBj3eTzZj2SHSknZEx/2xnBKbKYSDHd2qRyOEo0bIXIQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWl8dPJsUn8rRCXK2LzErr/5QyC+xLD1HJUNoJnvcEE=;
 b=U+Q6PC7aarLACmBDEXdBm8cneyi6uKrQ+CRL2CIVSM6v/9QoMSdBgIXfnFlgIMzjfdbFu4yIc6qzZv9OtMqTwc6cuQ8b097dWP6g9RvTTplat9mmxVO0cp0E6KIhnsWGMRWePBOIhA317rnoM8rjIcqpR/2fOvC2LSW9yMV/nPjUQBVR4b+kDSKwBI/i46BuUOjeOZZIIfE2g3KLkDH6KgX0a7MeohJnuvJmQWjww2R8GEW7ezohkzIX6Aep5EVJlvZfQ/QGf4W+EHoZcNCAkCDKQ1eH3fMZ1et73ljNyfOz/tSZLN/L1SEO+PLtd/VWWUrFGHSXKQH65aA5KlvlYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 MW4PR11MB7152.namprd11.prod.outlook.com (2603:10b6:303:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 18:47:49 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 18:47:49 +0000
Date: Tue, 30 Jul 2024 02:47:35 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "Arnd
 Bergmann" <arnd@arndb.de>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Juergen Gross <jgross@suse.com>, "Nikolay
 Borisov" <nik.borisov@suse.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>, "Prem
 Nath Dey" <prem.nath.dey@intel.com>, Xiaoping Zhou <xiaoping.zhou@intel.com>
Subject: Re: [PATCH v4] x86/paravirt: Disable virt spinlock on bare metal
Message-ID: <Zqfjx6eI9F8sHi/p@chenyu5-mobl2>
References: <20240729065236.407758-1-yu.c.chen@intel.com>
 <87cymw8j2e.ffs@tglx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87cymw8j2e.ffs@tglx>
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|MW4PR11MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: 821acc23-c9b4-4d76-947a-08dcaffef19e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qRKeki1TV53H3owMPpTd10U+4oP+e0az6TazFJocogMxbzZ3+6z1Z+RHNU0D?=
 =?us-ascii?Q?oy31tqTNmMGpUiOgxAgmyzC8EQCnz5A6UrjEa7lq5/BSHtuY9vIR3Ad6sISY?=
 =?us-ascii?Q?3FaJj+jHb/j8EzjKjvDXn7mPpHRwb4uqoKheC72ProQAGp68JNbjAUOB3k1Q?=
 =?us-ascii?Q?Xgxum+HYyA7dN0An8DOGljGoPx8NP98iC47AKGh2JFsAY5Vlo94Ly+TZk4no?=
 =?us-ascii?Q?S9E/dgt+qvVRnHhAE/wewEOfvHK/Ua05ZKHv7YPMAQ0RJ2Ukw8uNnjcAC+E0?=
 =?us-ascii?Q?UlKFzfuZsNuKG/EbEJrPYS4Zy0YwOfNf2SDRy972fLMHL3UZEh02Swp8EH7+?=
 =?us-ascii?Q?T1IYyJyaPyRiTbOhXK5yeDXvhcYse4++uMUf6eQB0SsKtBtCHWWI1HZ106MN?=
 =?us-ascii?Q?um1OVsE7j3RURVuxvm4wP03DL+wCIRtwLNuCh+yBNWM5KAfYYtL4uunAHxK7?=
 =?us-ascii?Q?rAH0Oi5/dNjhHvruCy7V6TfUOObn1k9VqENF64oCwt5DpFVeQEeGr9iPSURQ?=
 =?us-ascii?Q?WEg5OaaYk6k+rdWC6+fEKtUDkt995X+VwRwPWfOU1rHuossYJBBsaBZ279Vx?=
 =?us-ascii?Q?ndmGO5Ea/PANiY+T0Z0G4AWCTYXTLq+xrRiosPKExBsiLOZH0coyTovXWx5+?=
 =?us-ascii?Q?O/4kpjZqzVM0z0h9hBQ5kUWYIhcQUtgTDX47mAbWWaq3HyRw33LM2wuCGEu5?=
 =?us-ascii?Q?7zHXE/7NpxAIzXwchUsx9w/wWITFfqBWjBUMMMRSR1I3slHtVcBivb70L+Nk?=
 =?us-ascii?Q?8QhsB1oNHp8nOyHaAF7WYmUAsQsuuZwsUc1OzQ/91PZ+Nwx1tGxKn9ec1r7m?=
 =?us-ascii?Q?SfCY/GDDByZZhWvFYs3RYnthkHxs7T2LTp+xWKiFP6c4QaOc7D5EK58EgL0B?=
 =?us-ascii?Q?rJLawvglfgbgo18gIuQcXB9lGeS0EHJCQZYZDhtbaSkb59egD1rVUqtJkmRk?=
 =?us-ascii?Q?SmSUOKvl6yZhuusm17WjebAMTpie+fcCnD1RUFlQMk2pqK3u4xqPV5peHvd9?=
 =?us-ascii?Q?0aXNHkamlDtSfElo++bPd20EQ11Vx6ltPf0mqyCtxY3B3rkMb1sbzITTkT3Z?=
 =?us-ascii?Q?MvVHPqHxglMIs1hfBnJClxhKoa+hXjT3x6q3inEWfq+yhSilaFdVFUwx+rwv?=
 =?us-ascii?Q?AE6HJ7nVrAfBJO7cUszZkakilzndJVEK6prtWCwknGaQx963pZp6PgZuDTCo?=
 =?us-ascii?Q?51qeaR5sX4sRyRbaNGSim6dGrp8S7uLpYGicSmA9oZtH6WZ1+UFRduTPBWiv?=
 =?us-ascii?Q?/p9eyecDgfPRxVzFEPsgiGuaB3yBcLoBcsywcYfLrxt6WRcKFgz0jkPKawIo?=
 =?us-ascii?Q?jbIdu1er1vtW8dupw3eVgNo+Z08/rLFOKur0Vf3OEzsTAQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bv8sslTN/FFsEQr86LW5qTcZak3xsLtHb+m+GDOXcwzIDx5SxtyxPFFAELp8?=
 =?us-ascii?Q?+L7aj+FHUHhPeUIjg9qUcmSRr60wa9DkE1XBO4VJJg/iAUKWdEc93Mi2PVBd?=
 =?us-ascii?Q?hqhdVmN16HCciJp8+G096on80+M1cfFjWgGPYB6vGngKNA1PxophZlRMLrOo?=
 =?us-ascii?Q?ToLQko5KApIvErQyMoTcm4urmaWA1raVnKI4QNqcpVFosacAuvFJmCZnGxMP?=
 =?us-ascii?Q?4Tt+B6vXwvBpCt4xeKF/aagUTT5tcJyyvTiF1b2flKceU/YQ9qmx/RdMoAQF?=
 =?us-ascii?Q?YaBWcuDtP2UWQ8jC9U6P7PyzLx/DIDMEGEgkZ5WtLUwZkhucBw4ptovidMmK?=
 =?us-ascii?Q?bPoToUfFFWy8WD7aEqDKO0Ai+E5RMR7qk0C3l8fLxLbKHAKYzvwtI1FuUHV0?=
 =?us-ascii?Q?39nXW388FWT68drt6F4kSgm7Hc5gSj95qewXWjftUfxGs9WEnZ9g0NGYnTQs?=
 =?us-ascii?Q?UX2mqaRpZBGuSKm+gWJ5tvx8ZeuYUSe7cimu4pCxTY7UY5JC3eiaWlQVvSOO?=
 =?us-ascii?Q?ZJibnFE94vOg9FcLkoHTV7YR+7SSpQB8kQrNL7zDsjCMN36SzJmns8d2tAhZ?=
 =?us-ascii?Q?RaBc2MP6+UYcDqkTJ1EewMf6Pind9VaXJ7kU4rEx+JT1dpyeLHHf6VN+MVCr?=
 =?us-ascii?Q?qHe8yQBNpiB2J7WZfm4/JX4PH5HuJ6ISPjDVKSRn29wzngDoApSUrqcy9y2Y?=
 =?us-ascii?Q?29F5bfGJBPL1uVKTQ7HJ3PN/BAP7PqxdQhKukq7TsewO4dwVVzSUftLHdv36?=
 =?us-ascii?Q?GIUeKxMpy52S2vqt9xa3HwlAnT4uaPey2gEXLCCZd1P5tORMsG2MX+RPhI+w?=
 =?us-ascii?Q?BMREuCmGyG6AuqA6baSVeLzEquMWjUhrk1bAGXgV+DYcsII8uaR0cpAOadUw?=
 =?us-ascii?Q?tMpTR/VURE3F6Gdka555bP7hKTFu9Scetkff8QtX2loE4/mnWn7SOIP/h8KZ?=
 =?us-ascii?Q?vnssxZhsb3A2NM2kj4uBprRIGWqQy18sRWqI1ktFt8YXWbW/xfSOZNY24MJ0?=
 =?us-ascii?Q?vtqprX3cDh6RSsYMjB+DfCmqEHmtA44AgoQkKdTuRUB6ob+XXwYcV7cFF0Uy?=
 =?us-ascii?Q?2hDOnkR0lTY9e4shT9wheNs4cFplgx2g1TPyNLftKc6vlq0Mk2L3RmETb4Qs?=
 =?us-ascii?Q?JQf8FuNa/wP2y6jbJ0W4rdmpt2Uaz1wwJ219FY7f/NpBNCFdWg8UIMR/eOan?=
 =?us-ascii?Q?V3r2F0WPO4Nnf/Ro6FDYi5ECnmaj8GA+gHvNMk7jiQo7COq9513UC3uDUBCS?=
 =?us-ascii?Q?sh+xfHtC7nKAkCZ2EQFv2faQ+494ihwwqmiAU/boo8nh6uLNAyAOO/LKZN6C?=
 =?us-ascii?Q?XspD1K3YK7y3BLH6RAPabPDa1bDJhl+K97iuSPMa2gQDWZFTmuh6NdfHda3+?=
 =?us-ascii?Q?6/okCnGgrZcW1BN2iYrr3jy7mndkVoJevWQLvMOhO4zGdJUuINpxSzH/JQ2o?=
 =?us-ascii?Q?7xrf4O2cRyXqGnYyHwqdl3AuW1pQNn3k0gof+afIfFRp2HBYzEBcwXBbSHph?=
 =?us-ascii?Q?FEV9vziQNRfoNfYdd3z2dDuYTDuIrwiQlyxBVzqzexqHOtdxi9KmQzbvOhqn?=
 =?us-ascii?Q?BuY5p0I8A6+k/5DMGc12hFD/qwPrGgnHV7PaAwiE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 821acc23-c9b4-4d76-947a-08dcaffef19e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 18:47:49.3469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hyNaDZ4+X8poYSESXCbivSOmaVGywwKjubLaTjHX0ntLWsIOCOtFTi3xsEASDlG3RePEu0BVJmzFKJhsrrlw0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7152
X-OriginatorOrg: intel.com

Hi Thomas,

On 2024-07-29 at 14:43:37 +0200, Thomas Gleixner wrote:
> On Mon, Jul 29 2024 at 14:52, Chen Yu wrote:
> >  #ifdef CONFIG_PARAVIRT
> >  /*
> > - * virt_spin_lock_key - enables (by default) the virt_spin_lock() hijack.
> > + * virt_spin_lock_key - disables (by default) the virt_spin_lock() hijack.
> >   *
> >   * Native (and PV wanting native due to vCPU pinning) should disable this key.
> >   * It is done in this backwards fashion to only have a single direction change,
> >   * which removes ordering between native_pv_spin_init() and HV setup.
> 
> This comment is bogus now.
>

Yes, now it could be two direction: enabled first and disabled later. Let me refine
the comments.

thanks,
Chenyu 
