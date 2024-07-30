Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD62187337
	for <virtualization@lists.linux.dev>; Tue, 30 Jul 2024 08:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329248; cv=fail; b=KvXGWlFfLWKWEEonnokM1z9CQqVztBs/hyfvVT0q/0F2LgNSIXy0uJxe9YoaHVnHX20pxh0s0QDxwjNP+Gzb3hcuRvpZUUs/brtjOF0gCE9hrU8N/Hvh9Yxz2SoreHG8XR/0OuyaYth0PMC/T2vLcnuU35MLRvqie/c8n11aY0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329248; c=relaxed/simple;
	bh=9RX4FZ/7xlKQqJ5uoLmJdbpV09neCJmPz0bHlDfTnfI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JgHVfR8Sxylt/V3ulfahA2Y0Ft8mF6JgdijV4DW4wu8wBDgb9ugyBOYHaImnn/a8FkTrKUcPUypr5oQxYqe8PVih1vft/P1q1+Z9tGixebOmhLL0tCLtH91Xi9vEVEOML+KkRbi1S+Ueorfw1/BRRZ5iydC1f3qatwsxY/2jAvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gQ0BBWnf; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gQ0BBWnf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722329248; x=1753865248;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9RX4FZ/7xlKQqJ5uoLmJdbpV09neCJmPz0bHlDfTnfI=;
  b=gQ0BBWnfgNRB9Llk96MHIrVDjjyZaLJ8PVzr4o2PB8U1xQ75uPzae1Py
   FF2RvYhX0eYUTSrQgc951ZZmRKZu8G8fNYy56y2JRDmvqvHvlmXcNtUUx
   12brRGazEE9fiokV3oL8BBuyjjLJ1HQBG28yPeIxHMbOsJRrqu6V5yuqO
   Wt2b26l5v+Krw8jWO1V9Kr0nTy2sgo+Gb3QPcJZzvAqURQbuSMmlSZHgp
   +VfHlx4CCmI6eg34i2unPx5Du2g1b6uvmUYHqfYEuVpSHvnUSKRTdO+4s
   fN6x9yaxNkHhmyvlbOxMBVsD3nUaEo52O6iH30iWXuC4mYaD0Sj6iqvmB
   w==;
X-CSE-ConnectionGUID: jOM+M/XDQCOEHylqAJIgUg==
X-CSE-MsgGUID: Qv3w3MyETLeIXnYXmNR4Aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="20282435"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="20282435"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 01:47:15 -0700
X-CSE-ConnectionGUID: rb4mJbRvS8ObRDEQjcbcKw==
X-CSE-MsgGUID: u6xrMGI7QP6vb+91Y3CbwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="53934397"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jul 2024 01:47:14 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Jul 2024 01:47:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 30 Jul 2024 01:47:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 30 Jul 2024 01:47:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/PUhtWCz7hWmg7/bc4C18QoZVJ7PR3UC5i9iRD6jeDkMlvNcSjFuiijLLjQuOmJIUKBsKHoYalZMVyF0G7iTEkgzUP5PXLBZAnKfdV21r0PiCyjFZ+1bdA+Ha0rt6cXQvNfFpYkxq+qxlKzy5lO1fUSf9kUazLDh3MNbuEYSMFA418qgmPuRTk+B1poCBaAyhLzGbqU4F8yG1pbX0mCp5NqpJsM7bolKfRbPL3WVY145AI3Uz1jilIVgeAb+VUE6QqBQ5d4nxrgo4k2R0n0mCZzQSR3qDUCZ8P4s4vW+ococM5BcCBUBheTjZxAixMdksisUEtiSmMDWZ6feFmuag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVilcJXosC9Mwi7xWOwjSCyOOH1o5HhBlhNPLjSdTMU=;
 b=l6y0q7vYVEZd+epSH7yp2OisSC+UG0Yj8DdvaW4UsP8suaYaWF05lUm+gu5RfghWsAcBs5lJxLErQJujXTSA8Ozhh+Mw7JgZXS7Qsvag7zLaMlkTshZDkgFkZ2N1ZaYtpjjpMYp2KWz5QEc5813WxXSPGCv7bAHqnMzAHcBJMKRCRqHTvSicrDPxC3VnIOg2EWGD+2RJNVuG5JY+G1oQ4mxbf+vYQZne2IQXmfexjL9qMRvENfsisdXln+SeNvpXKn3PCUJCm1rwksuWJt/M4Lcvt8sp6f0a8CC6YEKwbAmJriZeQx/mfxzeRy4U+wVXqKCjkwLPwCOZRVi4XG2Wew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 IA1PR11MB7728.namprd11.prod.outlook.com (2603:10b6:208:3f0::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7807.27; Tue, 30 Jul 2024 08:47:11 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 08:47:11 +0000
Date: Tue, 30 Jul 2024 16:46:53 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: maobibo <maobibo@loongson.cn>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann
	<arnd@arndb.de>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Juergen Gross <jgross@suse.com>, "Nikolay
 Borisov" <nik.borisov@suse.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>, "Prem
 Nath Dey" <prem.nath.dey@intel.com>, Xiaoping Zhou <xiaoping.zhou@intel.com>,
	"Peter Zijlstra" <peterz@infradead.org>
Subject: Re: [PATCH v4] x86/paravirt: Disable virt spinlock on bare metal
Message-ID: <ZqiofczTqmn4bvhy@chenyu5-mobl2>
References: <20240729065236.407758-1-yu.c.chen@intel.com>
 <08d75c12-215e-3781-ed89-b1ed5c1e39c8@loongson.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <08d75c12-215e-3781-ed89-b1ed5c1e39c8@loongson.cn>
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|IA1PR11MB7728:EE_
X-MS-Office365-Filtering-Correlation-Id: abc4f9f6-8df4-440e-2425-08dcb07433f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/pvd/lAxDeeU82yr0xftKEgGf31RX3Lm3NOywWs2H3Pi2z/oASYoTJmir9dU?=
 =?us-ascii?Q?jyN21Q6OC80WsWK0SvCKJ4NXipTu78cKxyMD/G3R1L4+G5X04j6WeR63eNuQ?=
 =?us-ascii?Q?q6Nb05FJZtDP2ROwOLdBXUP5on3QqKWbzjLrlHIZBc4Eyzz1FhiPhSuNpedC?=
 =?us-ascii?Q?if2tgRV4JBckV9lZq+giGTxDFbe50EP7gxmIWmPE5ispFn1+gmtA7r71DuOf?=
 =?us-ascii?Q?b35jJ8Ih4VNaQvrJDzNVjvzBAkPGxlsysGK+Pn4zuCUpJ9vyclTwhjuNLjUY?=
 =?us-ascii?Q?nRFdYC9G2M3BYA4G2yEHvTmmc6H/f8cqTojJysIQXyqLRnrQRY/IGgUiNoZO?=
 =?us-ascii?Q?jeIkEOlDWNbWDcA1gEDGzfQhiXpmjh98X9cX4PESwoDIpQoqKGHN6WodW6Iu?=
 =?us-ascii?Q?UAR0PIJ3zzxMBVoO2VT9vqhAHFjUMYii1ercDG/K4aN4Z4zOXtTk4OYkPY3m?=
 =?us-ascii?Q?KuEeWx4YoSL/J1HEAgz0buN8jX8RNDxOs6alUkH/53H1L+n2BfNIbjueW86l?=
 =?us-ascii?Q?1bzYtyMQHcRw85Pe3d/Pvw0sYhpBOUwQlM3xkL5GIDOE9K+KpSvP6nABGAzI?=
 =?us-ascii?Q?gX+Qiim4Ff4YXFkABCTGVGqWB0s214Gbbt6NPnUBIHVfPDEOVVyZrKjaLYjO?=
 =?us-ascii?Q?P44e9h1FgHvgzi0BeYc1dNmGfUstqOSBcRnZqd3MXmT9AXrHZvRK2trFm8sa?=
 =?us-ascii?Q?oCjBvZ1qvnyXCw1cFAdIGXbkQSf4wiyeunMN8OpzPN9KkkL5wWRv74WRWa+k?=
 =?us-ascii?Q?0Lbyl74QeFpftR7/4Al7MW8WqoHgm2K0gMRqzYzmi5Fkwhy77hhP3Qvo34Tn?=
 =?us-ascii?Q?2+40fv5zEAtOWw2ZH27oOcx1dWG3vhxgxNOmDXObMIaZApSwD6atcMOWL4zL?=
 =?us-ascii?Q?kps1GJ+XSaGztxTo6tex+mWehMcZ/GXj2ErtqFquzFA3kZp6XcvXyvAAAg6a?=
 =?us-ascii?Q?ffWBNf61KbYN/19eqYni4p4/pdKPXw40kMvCAKF6egChDD7MqKNwhww8Ze2k?=
 =?us-ascii?Q?iyQKpOs5gJ6whcsCOuBAA6g5QT/q+aWjYJCDE3MiGIJEB6vd31qqaN7BwDyS?=
 =?us-ascii?Q?jEMG2IQdYmA4bIsulmlLCrij2c758VULnnzBVDGSQst2Lwf7lhp0OMbq8ZFA?=
 =?us-ascii?Q?iK/htPY80I6RJYqg1LGtg+l1ZTLHV0D72j6z8XDzToKqdDnvoST2PmkfoLSm?=
 =?us-ascii?Q?fapM6w/w7xzQnidlj/VYsm/Zk0DAwpV9atqRUABWOzSX2aStwf/e39inECU8?=
 =?us-ascii?Q?vGv5a9Vsro79yT7jZRIvcGXFsDbbYT0gqlpNyqoWiqBqB27hR3gdkwv794Rm?=
 =?us-ascii?Q?H/ZG/8pVxhhP1iKFd+OQSAaAxvzPFISXQXBuFPxrNgLhBQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BtmG9ashaw9oAGOwRZ1jVa6w6zoRXlzxsjakb8G0eLXUFhYaok+Nz6rQ9a3v?=
 =?us-ascii?Q?1QxNR1L7G7k6JmXaRQ3BRhQ3GMu9egHifLP9gZK6CKRmPhF7fTij7V1pct5Y?=
 =?us-ascii?Q?RMlKPQYFaJNV71EwNlkmp0HWKzYNFZsQuerMGICrOmjp3yIVAWikGPketTCa?=
 =?us-ascii?Q?mpCeg39/rPdTP8zULr2lXnd+RrwMQ25SW3ih6wwrSBWKTwE+A7snNN041Zj+?=
 =?us-ascii?Q?FK+10UhulU7Z0PEUK6QJoNCDlx7NmDal42Dg9zOsnDrN200ApmGT08t9FOju?=
 =?us-ascii?Q?fEQBLN+6rFOllqSDq2XqEpyFh/u01+BZuHHJnPMdNsz4FtTkPF2Jg7XpzwPj?=
 =?us-ascii?Q?pw5WpYpaYufOiSn66UwVCbLJ1mWuSrjeP4m0zxzatRCAWDwtySZMkOi4w2Qk?=
 =?us-ascii?Q?G4CAh5vT2HmvOfQEkW/9m9OCwzCnnZqjK++W+RiFw4qhbuYPZPOan3dZj/jL?=
 =?us-ascii?Q?yO9YkBEGBU9ga4NCULUTA6FXzJIGkGxJgG3OUwasewuidIOoJwXEG2HGHWYM?=
 =?us-ascii?Q?TwHksp4/ZFlnHR/I4qVieDKl5J+lZw4m1GBQJyOj792u6Qm1i/4+13k2tGXS?=
 =?us-ascii?Q?MyT4KlJk/FojzIr+cEQXyg8TdvpgryPFhVipesFXKExMzH3V0vXgpKghRtWc?=
 =?us-ascii?Q?5WnviHu5+ojqhfF3/EEmhjt8nC8Bh9crD70RLS0+BIeBQ0hZiD+5wKHh++Dr?=
 =?us-ascii?Q?G8eX1h6t+OwI0ZWHZuIoBYk6+BLVR/p5udFCe9dxjrxM1G6VQVaWAJm8fbly?=
 =?us-ascii?Q?/rh3psWVN0DuvgNsqA7fguYXxUJ+oKX2g2ncMa3fU1EenFBBnxnveuK3uKSF?=
 =?us-ascii?Q?4lV7AGMSXgIQDQ9Dt1RMixaSup9gkqqbTsGgE8067ZIqxb5g9JmkIACWW1G1?=
 =?us-ascii?Q?4VHn29z7DCu5YFSL4eV6mduDYknp1IevSUCiC9N/eOgf+dYriY14NFx5TAOX?=
 =?us-ascii?Q?F8M3XtTtKsw2IH5k+Wq5p84hDxCsYWEZZ4W1svHcKQHdXu5o9KXCLhXAGv4Q?=
 =?us-ascii?Q?LLKMvha67sSoTMp9Xb9GktxGmrQpS65KWWRdi6iO0lPtPpQhjc1l5CTSopPq?=
 =?us-ascii?Q?tagxs8BWiwYVsLkXG9Jt/qqK80G4vIBhaiEeJoBH5CqtIR+NcENYtfOyMaqE?=
 =?us-ascii?Q?rQj7K8/B3r4Zc8UEVai0qeOQ8VEsdKlDtPYVfkkhNqxogcOMaJaPJa2ZTOW1?=
 =?us-ascii?Q?jDExkfsX0L8Lo0thrFGYefxQns3wKxEHMK58Ie0ijo/iclbj6kppRF7r9RS4?=
 =?us-ascii?Q?cKlOwlYPu8sIjcjdBicn9Ow3zzrlD4QhQfMXOwAUxZMrfo/bCD2pLbf+aVfh?=
 =?us-ascii?Q?jgq/JG6d1MDXxY/808Z3QKCxFdthdnut0jbOBOksywIqmB+XjjXdJkTT/WZo?=
 =?us-ascii?Q?9lZt4oZTVJzABzUEz9YSkuIyZ8pCR6uPKtRG5Sp9rcHZpX2n7Uc8EaVfGEFf?=
 =?us-ascii?Q?+8mozLPcatmkJrRndwtt3HM+Kw8u7wVvazMIWvuKiBCpNvbfjgaOWcHWLrMV?=
 =?us-ascii?Q?VQ064iqHCueqZy4In2O944eDbCKTWkdRymK1KK7LscxRcGEwbo77QNIGRdP7?=
 =?us-ascii?Q?M9ZXVOTOaQx7X3BFs2q6wYpPQQ5D12xiHvYYOvas?=
X-MS-Exchange-CrossTenant-Network-Message-Id: abc4f9f6-8df4-440e-2425-08dcb07433f4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 08:47:11.5161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9TFWsz+X2QaZFz0FFyoyDRhPEsPeQMqVg5RMy6f+DxEq+kuIzeo8uewiFyZubUD0IdNOoRG9JGHvM1HrpU4+Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7728
X-OriginatorOrg: intel.com

Hi Bibo,

On 2024-07-30 at 09:21:45 +0800, maobibo wrote:
> Chenyu,
> 
> Sorry to bother you, I am porting pv spinlock to LoongArch platform, I do
> not know the history about function virt_spin_lock().
> 
> When CONFIG_PARAVIRT_SPINLOCKS is enabled, there is pv_enabled() before
> virt_spin_lock(), it seems that virt_spin_lock is never called in this
> condition.

Right, if CONFIG_PARAVIRT_SPINLOCKS is enabled, virt_spin_lock() will not be
checked at all and go directly to pv_queue lock section.

>         if (pv_enabled())
>                 goto pv_queue;
> 
>         if (virt_spin_lock(lock))
>                 return;
> 
> When CONFIG_PARAVIRT_SPINLOCKS is disabled, there is no pv qspinlock
> compiled, so what is the usage about function virt_spin_lock()? 
> Is it to switch spinlock method from test-set spinlock to qspinlock? 
> why is there such requirement for spinlock switching method?

Firstly, according to the commit 2aa79af64263 ("locking/qspinlock: Revert
to test-and-set on hypervisors"), virt_spin_lock() was originally introduced
to avoid the over-preemption of native qspinlock(when paravirt-spinlock is
disabled).

Secondly, there is user requirement to use native qspinlock over test-set lock
in the VM. For example, nopvspin parameter is parsed in xen_init_spinlocks().
commit 9043442b43b1 ("locking/paravirt: Use new static key for controlling call
of virt_spin_lock()") was introduced to adjust the key from user boot up commandline.
so the key switches between test-set and the native qspinlock. I've Cced
Juergen and Peter in case I misunderstood. 

thanks,
Chenyu
