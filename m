Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF954E570
	for <virtualization@lists.linux.dev>; Sat, 25 May 2024 06:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716617034; cv=fail; b=myDFbR+J5+mUOj9flEuxkhZjH4QnrliHAN4asZelqc0/Lo50yh3OXrXibC6XF6mdKdE0mt0jidJwBOXzbl8i+bDFechRZPWpf3jMp5dtwabOxc0oPj5OUqUPMSzmbe62fit9OgqVs4WNAdrQtuk+f/GgtUreCSwzxbJm9XkS5bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716617034; c=relaxed/simple;
	bh=ZjL3g4RRJsK4rnjDqYkgx+Kj8eM3/w61QzphUTj+6+8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LtZWpCzmdfsLWlVdQQKrSJadXG8bOYxwGB35ImXB6rMx50YNgq0diyKfUUKsKc9ZEAhizjb6dIpDa2Br/wVWV9k4rswoQ2JVhVkKY1NvNBVbjE6BQxP4669QT/ewb+kwhl6DfotBRJFLZJoaWlyKhfyIKdd1EZzyWNL1ewsmLuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QLFqT/Te; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QLFqT/Te"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716617033; x=1748153033;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZjL3g4RRJsK4rnjDqYkgx+Kj8eM3/w61QzphUTj+6+8=;
  b=QLFqT/TefgtFASKQMPGH2uZm/UjKZeveSM387ALhXkIY0Ilpixs6RsLx
   +gXDaTPsZDb5IAqS9gXNdFzQ3m7/chLpoX/JE0o4rjZZ53h/Vf0n/DKOg
   FFxSebwA0iOBy68f/1Nm7e+zdxFd43mkJ6poIX4ebOz8qOGxlNZG/PH4N
   g2HvYUvM/cq8YwrKVQIYKmqMjKFCTHN9skRgdRRWSdMf3BDmE/l1EKhmQ
   9WXZCcjUNL/9VN9sxSQ6NZ5gfgULo8Y74kKP2naAKOYZsGn3lf4eHjPpU
   U3IfyIjJiGzI5fM57o+huA7WUxtr89pLo8Gy5xPK9VdSx4Fk/hufS1KoS
   g==;
X-CSE-ConnectionGUID: 2Yp0niD8T+uj+D6ks/TMTw==
X-CSE-MsgGUID: YNG6JvrNROK6eEOte4QY2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11082"; a="13119839"
X-IronPort-AV: E=Sophos;i="6.08,187,1712646000"; 
   d="scan'208";a="13119839"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 23:03:53 -0700
X-CSE-ConnectionGUID: 4kOaJtGzS6SvAp6nIX0Jow==
X-CSE-MsgGUID: TvFFU27ES1WgDiw5HAupMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,187,1712646000"; 
   d="scan'208";a="34732011"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 May 2024 23:03:52 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 24 May 2024 23:03:51 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 24 May 2024 23:03:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 24 May 2024 23:03:51 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 24 May 2024 23:03:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTe0kXpjxnPXIZ26kBqUn/Hg/C91qlaVjVYomSUijQuh7FnPLU/VugQdRr2cXfoj12cWIk3oZLStmVeBHEKWQ313TNKOpTVar1KOSK+0HJfxqManeQi+PcO0+GLhBlBEaPswrhoVuOjhMTXtmGr57vtnm2J4BQiin3P/E5pmWC8Uu+OxG0FbCVFB8jAGyHNY2mcQ2s909NFh0Kqwr0cvN+kTtfJBETeLY3IZD2/R1PGclvDAgbX+tG9R5CnBHn1ft04lHtmue2D1r0eE2Dfsal2uVcakH40tJpCsFvECvJbrztJXGVgbFrHzo7aXy2WwGl6ztQq3U3MKbv8iSp3XAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XR7VdvOUDU83HIQgb4JVDHIdDmBIwkbRsqVeXBnKY8c=;
 b=gnYbYr9BYGzeRWScY/Y8AnEqgmfw/AaZWcnMFwSKlha/O44CWnUWuUUnkn8UCPY8Mh5Prl/BzYpuncvajv5+XytvO9yTdScx/XIq5vZF5CPJvNhyIFjbCzAErEL3IzgJpkkqvAfbSblXAIgq0hK/jqbuxcrCB150767jzFUpivnAg/H1clm9A0PI30LWWAGsTDExYg/7AsdVIEqCW73X6cHC3fmuK0PUKJJEiCwJyS0NrZ876mLfHuIzOuinDFT5XyifxPjJubZ5dLJs6Vj2napyMctIPsyabNqhjefIdqFUbAiWmPg4MZk0/qYRySeQTHoJ460Ock0Afi/Y/FrqUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 MW5PR11MB5931.namprd11.prod.outlook.com (2603:10b6:303:198::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.22; Sat, 25 May 2024 06:03:44 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.7611.025; Sat, 25 May 2024
 06:03:44 +0000
Date: Sat, 25 May 2024 14:03:26 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Dave Hansen <dave.hansen@intel.com>, Juergen Gross <jgross@suse.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Juergen Gross <jgross@suse.com>, Ajay Kaher <ajay.kaher@broadcom.com>, Alexey
 Makhalov <alexey.amakhalov@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, "H.
 Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
	<virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Qiuxu Zhuo
	<qiuxu.zhuo@intel.com>, Prem Nath Dey <prem.nath.dey@intel.com>, "Xiaoping
 Zhou" <xiaoping.zhou@intel.com>
Subject: Re: [PATCH] x86/paravirt: Disable virt spinlock when
 CONFIG_PARAVIRT_SPINLOCKS disabled
Message-ID: <ZlF/Lrr4nWqVpoc8@chenyu5-mobl2>
References: <20240516130244.893573-1-yu.c.chen@intel.com>
 <7b8d1dd6-3913-45fe-941e-aac2c15916dc@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7b8d1dd6-3913-45fe-941e-aac2c15916dc@intel.com>
X-ClientProxiedBy: KU1PR03CA0026.apcprd03.prod.outlook.com
 (2603:1096:802:19::14) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|MW5PR11MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a7620c4-0448-4a1f-5274-08dc7c806f02
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gDtY859RsGR8dj59sYAPiRUiOS+Z8RTJ4hdr1HlmKzLn1v8YA33dEc4oBQtQ?=
 =?us-ascii?Q?tjHr8cNjRCPxN+lVdDz2GceojZyxaIvn20hu36Kv5NOU8aP/Rie2EAkPn107?=
 =?us-ascii?Q?hz2Mi8JFV8euRTjP1ktyRgSB2l91Y5jOypVoBy+LtlLw48IcmSZZFQaC+5p0?=
 =?us-ascii?Q?45BLQ/eJe7eH/uoQ2nK/NFQ/ZVMmPvmiuyq5yVkxp7ozIS2O9aKu+RRXQImg?=
 =?us-ascii?Q?PQgd2KUIjQhwxznLXewLKZN75347nKSYaIQUYDy0eZSFWckeNAemZqNcbl1r?=
 =?us-ascii?Q?We0GVDrNaSUYxguHhmDn92RrYbu5immNqRXnXD7ZUsdMsyYPoKiHHFaqq9B2?=
 =?us-ascii?Q?ho+JEnbm88XXEhWnqdnzeUhV4/kQBzZ5UOKdSrQ5/HeQFnDX3wjr+v1SIS2o?=
 =?us-ascii?Q?7mDHK1aEj6U9xjlx4OD4J6OV482v4j0QSoEJjpQzebD+XOTiqIjFlZeKNB3y?=
 =?us-ascii?Q?S1Cc0nG8KRLrOXKLXwGzbJ5BdM45JyJOvuROHEdhPPSzTxMoUrFTHVspU96h?=
 =?us-ascii?Q?aPKLBmULyH3BU4wW7QlXB2317xNSM8jQqk0jZoDt2lJUxbgCyQ7DktuR0F8g?=
 =?us-ascii?Q?dFQsX0JeIcMxNf7PEAZdFG6ctYW5zRqTzFvvPb3JSwohnvn4XUtmCbU4E+mW?=
 =?us-ascii?Q?ZQUqy770JbTFO74RgEe1OgUEhK5j1qiZ0dBv8XRFxZSKBdcbk6knpei8eCf5?=
 =?us-ascii?Q?PkvBBH/aYqMrpSQd3YzQjlFOBL8Kx8qLPST6XjfhoUf5aaWq5CwfpVA8eDUT?=
 =?us-ascii?Q?DV1rQv1s58WqZMeikCEt53MF1EOwbW1HGWb+s/fyZGzzeHoZBoM4srydQsQ/?=
 =?us-ascii?Q?m6MpjINo3MMFzqNgt2M886Mu6HUkePq/DO33p5tB1eYX2Kv2YOU4sDKVQ4Se?=
 =?us-ascii?Q?Amd2I6vhRzCpEzZQyDT9H8KFyCQy9e78gn+D1At1ajvwlzcGdQ2aA4GZ8fWw?=
 =?us-ascii?Q?7PyG22Buwdom/eRIIlqi9i5fwHLR7369ATfc6MPjgOHLrL1a4iP10gtgmUH3?=
 =?us-ascii?Q?cfkAZR3OAvSfn7ZHsTubx3Qslgh5fBIWuy1XrmgM5FSb0F1CsRX9hYuD5DPw?=
 =?us-ascii?Q?pGfOIu91V0G8qHJ9YfPDU9MYL1j6cTLkRg9QUn9G5fzh3/6EdxwykTU3rz9j?=
 =?us-ascii?Q?/qq664bjYS8da8hxEg6dUxpopXYsRMDU6SGZdTZaaJh790GkjadUz3UvU4u+?=
 =?us-ascii?Q?y50r+RTClLAt4lyXp2REqTSOYfdKwg1q9aOsY2baUQRaRbTQpymAAcLx0z9u?=
 =?us-ascii?Q?OyoEDriQGQHx7BLrOuOCkEVgWTbbKhJ6/6pOkcvwAA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wCUWavelJYKTcaY7cRl/4i3/ZOAFmghDy7bzWOheZ1gJt6xR38RhXIxdPTgo?=
 =?us-ascii?Q?wqYM6/1ivUEnQPltBPi1WmwAxvytVbuF1KOUh41rzKKjKT8zcHnKpA5cGhnS?=
 =?us-ascii?Q?UnsQtIyExDgeys9QWMgYrlggUUwwA5QgXf0h1keuVDhyUtIB4t7vK7XCmeAX?=
 =?us-ascii?Q?NI/AOzjK30eUON+flsnbGa5ugWaRpfOXvKqn1N3jj5wLjn5KqypLt2b9CzGt?=
 =?us-ascii?Q?a6I/hx/0VqAc7/Fp4YCSe/Xtz/Mv50DO5jXsvFGkyNYoq1krLCo+ziGQ3aT1?=
 =?us-ascii?Q?PSl+T0CahP93P+rFDQRkq1vXxHy3a4KLhn2zar34GDZcr0gOQQMZJFqTFz3g?=
 =?us-ascii?Q?7PORdbPHIHmizz/nogkc1z5EdnDePsgnqqHsJyaCATpuF15qFCoPvE6XGoDA?=
 =?us-ascii?Q?sE50bzgYkcNi3VjiSVa2jiVPEq/iePc8uKTgNa0HdXGHRinLVzRuP3NLnP4u?=
 =?us-ascii?Q?bzUNXiJcpqXlgGLAKKScvdFcHu2Mkfa1nAaijMEKQVketTpQB9Gn/vQSGTZ/?=
 =?us-ascii?Q?67SEidLMG9BUi6j7eIGdRdV5eVWVwD/ruJQJKJEBipGSb28dWYakAZbH8It6?=
 =?us-ascii?Q?TuvfysjhsJfGXcODkGfp4X2W+v0caiqoJlZBTm1v7VTrXH3mb021HcwJyWWi?=
 =?us-ascii?Q?6eAhYi5DRVd7AWb2+P9AJ0Umv4XYtGeLbAKsPXM3kbpPaNKK3e9t9e5wkVNY?=
 =?us-ascii?Q?RJ7Wg0haLfCmkNCU3gabYFJX987/VVxB4OZhUKyBvCaa1Z+vsIdU5q67/VUc?=
 =?us-ascii?Q?GBlHgxANi0ae2K34oV3robdUKoMJoRZCPUcwICCv6h9On53+aZk9qMXU+Ad+?=
 =?us-ascii?Q?8CQzd6NT5OOkeBdLi2Ag4bHsvF9d37y/jj5W0lpznye1nQjFCHwSToooDIJ7?=
 =?us-ascii?Q?vytqlb3HzNPI48hsbmPDxQSyf/ZodhlRD9puBM6OpWFgM/CxSSr9kAftAwdb?=
 =?us-ascii?Q?29h+dwxXtcXAnHQZG8ENK6de95rPtGrupvUOHmnSbHNHPUX0P9Z+cXPUJjwd?=
 =?us-ascii?Q?kNTyoM7r+PYVDkuXIITCkjCWuvVJwC02j83IdS8feJYBsCwQ+KCBGoHL7cHY?=
 =?us-ascii?Q?++/E44D2wWSKBCHJuvYJUk4rCYQREr1aoZ0cxDqGBzxnyVsW5FRe4hQHhKqt?=
 =?us-ascii?Q?CMmQFc7+xc9xvIXDElPAzLUsreEqoPWX3/6hxniYdDGUrZCvPOgyAw7UknK3?=
 =?us-ascii?Q?YEWz0gAzeul2x36IZ1Q0P0f8rZCNF1Fz1Z/hEdzEfAEHUv+m/g8+IhO65/mv?=
 =?us-ascii?Q?Xd8jyR5u76R0OsVtwI3Pbj9jvCkgJ3ZLnwlMqL8onrZ0hSXappXdANnV+DQA?=
 =?us-ascii?Q?1QX6501SjM3Z5mH8+TI9DgoqBPMVHbNvWRGKi71VnV8rWTf1ZxrwmHuYhb6L?=
 =?us-ascii?Q?QKiYGDlfhrZ/aPMfYNHTKGneetudw0liI0FR7MjPLn+5HSO00FzkZFT6t2iI?=
 =?us-ascii?Q?s8sEwq5QhuktXQw6P9kbLg2onrkNvTAw2rk0Frml0hNhFzski/vBsSsGXCls?=
 =?us-ascii?Q?1S9dlswFyRc1AvzcrlSoHslDxEagyFFx8nn/lczCuF8SebpBmbFtyK9wxVsf?=
 =?us-ascii?Q?EF0F7lcnhPjfvQ2F+FLi/Xtm5q/6CTQdD5Mc7GtQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7620c4-0448-4a1f-5274-08dc7c806f02
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2024 06:03:44.3681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ddwh/sKDpPvTULLGWzsQlgyHD6AfdIRdE59i286oSRnS9NO93oaoYnYfrsmLPBFdY8s47VCob7LmqjE+vF3XYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5931
X-OriginatorOrg: intel.com

On 2024-05-23 at 09:30:59 -0700, Dave Hansen wrote:
> On 5/16/24 06:02, Chen Yu wrote:
> > Performance drop is reported when running encode/decode workload and
> > BenchSEE cache sub-workload.
> > Bisect points to commit ce0a1b608bfc ("x86/paravirt: Silence unused
> > native_pv_lock_init() function warning"). When CONFIG_PARAVIRT_SPINLOCKS
> > is disabled the virt_spin_lock_key is set to true on bare-metal.
> > The qspinlock degenerates to test-and-set spinlock, which decrease the
> > performance on bare-metal.
> > 
> > Fix this by disabling virt_spin_lock_key if CONFIG_PARAVIRT_SPINLOCKS
> > is not set, or it is on bare-metal.
> 
> This is missing some background:
> 
> The kernel can change spinlock behavior when running as a guest.  But
> this guest-friendly behavior causes performance problems on bare metal.
> So there's a 'virt_spin_lock_key' static key to switch between the two
> modes.
> 
> The static key is always enabled by default (run in guest mode) and
> should be disabled for bare metal (and in some guests that want native
> behavior).
> 
> ... then describe the regression and the fix
>
Thanks Juergen for your review.

And thanks Dave for the write up, I'll refine the log according to your suggestion. 

> > diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
> > index 5358d43886ad..ee51c0949ed8 100644
> > --- a/arch/x86/kernel/paravirt.c
> > +++ b/arch/x86/kernel/paravirt.c
> > @@ -55,7 +55,7 @@ DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
> >  
> >  void __init native_pv_lock_init(void)
> >  {
> > -	if (IS_ENABLED(CONFIG_PARAVIRT_SPINLOCKS) &&
> > +	if (!IS_ENABLED(CONFIG_PARAVIRT_SPINLOCKS) ||
> >  	    !boot_cpu_has(X86_FEATURE_HYPERVISOR))
> >  		static_branch_disable(&virt_spin_lock_key);
> >  }
> This gets used at a single site:
> 
>         if (pv_enabled())
>                 goto pv_queue;
> 
>         if (virt_spin_lock(lock))
>                 return;
> 
> which is logically:
> 
> 	if (IS_ENABLED(CONFIG_PARAVIRT_SPINLOCKS))
> 		goto ...; // don't look at virt_spin_lock_key
> 
> 	if (virt_spin_lock_key)
> 		return; // On virt, but non-paravirt.  Did Test-and-Set
> 			// spinlock.
>

Thanks for the description in detail, my original change might break the
"X86_FEATURE_HYPERVISOR + NO_CONFIG_PARAVIRT_SPINLOCKS " case that, the guest
can not fall into test-and-set.
 
> So I _think_ Arnd was trying to optimize native_pv_lock_init() away when
> it's going to get skipped over anyway by the 'goto'.
> 
> But this took me at least 30 minutes of scratching my head and trying to
> untangle the whole thing.  It's all far too subtle for my taste, and all
> of that to save a few bytes of init text in a configuration that's
> probably not even used very often (PARAVIRT=y, but PARAVIRT_SPINLOCKS=n).
> 
> Let's just keep it simple.  How about the attached patch?

Yes, this one works, I'll refine it.

thanks,
Chenyu 
