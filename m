Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A6820DD79
	for <virtualization@lists.linux.dev>; Fri, 10 Jan 2025 15:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736521813; cv=fail; b=asuvxFN15bqMlNz7tbq6tWh65kNUsIHND8YVt7IBFTxRvjbFhYsjXccmoXlmBJK3fN7Ntc8y6Wphhb2/wghgwNBpI5y+tcvsU2hVuBE5DE4jjAjdEs/aUjy0KTJaKv5l5m8qv/OS/qoiQuKlvw3lWb5IwhuQiQe4ZAmn/JsQvKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736521813; c=relaxed/simple;
	bh=7XEZHCDLfZ3rcjtzbDcan387+a6EsJs+RB2bal8tjOY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VNHlWSKAhwHwql91c8Hhga4KX93Cke/+k7p2DBwV+nHkcJz2+0RVB/hI0SWprZw18u/SPHQiSArxcCRpM6/Zx65eK2t4d4pTg6QpQpwbj2mwkBvmjk0zI5YaszAtLNJCsvVJjBsg/cvts9RTezSqzIEst5ER90iOen9CoNd2ZZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LHVNg7Vy; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LHVNg7Vy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736521811; x=1768057811;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7XEZHCDLfZ3rcjtzbDcan387+a6EsJs+RB2bal8tjOY=;
  b=LHVNg7Vy7WOABBbCCXWeGcqEPPJ9Cm1oFUDAG08EaI9qZVWY/nrKWbyg
   f+r3m1+3rAG1JX9P4QDLnMm8kjKLUZyAdZOQxHjHpSxY7sAcFYBLcuWOl
   /skYP/msKgaSEN3IajMiKDuNeD0kIbl8PppZEYywFEFtBlaL6iDwEC9wD
   OiYDJXV+Ox1RolgG0pd7Ig4kuic2Pti1VLKknvjPGx4yGwT9MuM1sWsHg
   SH1/mPzSNbhHNCPbON8I34y3Z26wXAzaaE2rzoTYHqVIWeIg9Zvw0tChB
   b4aOfcWMoepCU62Pgc7igllTrfIPcyLv21cPTy2gRyW6qTWeQkT4GTj/h
   Q==;
X-CSE-ConnectionGUID: kjVnMR5TSZqc0TedxfgseQ==
X-CSE-MsgGUID: hVomWz6lSu2pYD44Tz+nyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="40583089"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="40583089"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 07:10:10 -0800
X-CSE-ConnectionGUID: MOM5E4EtT5iJajhd+Etx+w==
X-CSE-MsgGUID: 4RWwGWt5TbKQ16goD1vtzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="127039696"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jan 2025 07:10:10 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 10 Jan 2025 07:10:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 10 Jan 2025 07:10:09 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 10 Jan 2025 07:10:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4qN+uOsdy2B12MhnWQcZexhbranG5SYVGnm/3CcHPPIvkLe4iY2nhYUNlqXd5IPZ2uew/AYhUr5msiXkqw6/fB/bpj85JR6oOYN1WEVwcSX6z1vU+qH5J3vf3YkrDiFTuuGQGDWhPRafbcywTk3jZWV+/jelF0locx24SQJC0VoNwLnhc+I5b5ORi9tlx9yJFUSYDLgK1ts3a0ED9Ah7MwPevWmisI+xnx/NVi2omZHoCgcbZmhq27JihAGg5CZqirjaiS7X1Jhj7PLCwSMa8PEvkbO4dvbjk29d1fcbK3rCIEVmMQTaDjftTSx7Cr54uMvt5jLrm0zeQor80TvCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VhKaezIyvoaulLjeKFChbiQagBpZVwskySAEAqbOXk=;
 b=jhD9Vaf7bqrTQHF/Kc1+8uMuogdJmwfkQP7WmmB4/hYrdOjDPnH5KcF8CxpMHRJE5nHJWbrBmHnnTIIxYA69YQJD0XftNuah88KIqYtk2kbLAwSoFsx18zSWisDpDL1op4HwNQHaYyUbedEqgcGdvGyqsl5HGMhpoBN9pbtiWGxS65973zfDyPOHxZKvo+HfaXNcQutwDmIKjYe6wPpouBfaGx3q5Nmc+0m4o4uGqyS0uh8SmEd/dd6pOBG/dAGsYGIJYyWaB7dByCh/6Z146LZlzd2yf2VyRJa4vzqPTWUCrrEhqBcpOZwlr8lguVjbj5LKL8EdLzv7xqcy8nvClQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA2PR11MB4825.namprd11.prod.outlook.com (2603:10b6:806:111::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Fri, 10 Jan
 2025 15:09:53 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%4]) with mapi id 15.20.8314.015; Fri, 10 Jan 2025
 15:09:53 +0000
Date: Fri, 10 Jan 2025 09:09:49 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: David Reaver <me@davidreaver.com>, Amit Shah <amit@kernel.org>, "Arnd
 Bergmann" <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: David Reaver <me@davidreaver.com>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>
Subject: Re: [PATCH] virtio: console: Replace deprecated kmap_atomic with
 kmap_local_page
Message-ID: <6781383df520_167faf2946@iweiny-mobl.notmuch>
References: <20250109035904.168345-1-me@davidreaver.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250109035904.168345-1-me@davidreaver.com>
X-ClientProxiedBy: MW4P223CA0030.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::35) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA2PR11MB4825:EE_
X-MS-Office365-Filtering-Correlation-Id: c1aecb3a-01a2-4670-5abd-08dd3188d5dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YxTLXVIQLuS9wZuHisG24UMd/+j+hMZOBPJL8JJDL3N0vyfHJgOZBWcJ7p1H?=
 =?us-ascii?Q?6xMMYNxPrh8ykytTSgfmHVGstWTsVZLtcw0K9ZmYZMbckvGGb72UGR/m/btN?=
 =?us-ascii?Q?wD4uTE6yOZPtpQW+JMgt5k5XoJIBwRHGYiTczHZ5RtfwXzMzqxbfZarb1Py8?=
 =?us-ascii?Q?ZlAyB4qoHH8M2Fqx2Iw/EJCHBS/o52d4W4QLhZ6NFontiIJoBen6jhJqzVf+?=
 =?us-ascii?Q?D9doUeDxG0VEC5c2OmvYv/tdsnzdUSsEhbT8wjbUORHvfo80/9pYAnVBGmaE?=
 =?us-ascii?Q?wLD91Ok8cQx6n7zYB/nEK2+n8zh7mUeG+AsTcRsbbkajJrgudPjl1TDUw36x?=
 =?us-ascii?Q?lyqqeWe3boU6AL9vNuu1JkNLhheI46sYV6eGH2VozjkaT88nMQIrqpHLBDFM?=
 =?us-ascii?Q?UVslsAD4iaUR3CvhyN43DHxynGBi4E8TWeP2h3JMdIXKeRZXRUASeFjIGw6L?=
 =?us-ascii?Q?nLB/fZAlePvds/KfZlKKdmMlM7mFK/sO/hPfCkLRcdt+6ktO5xQ3xjd0QkG3?=
 =?us-ascii?Q?jdZU9WC4VmPXhUbBd4cet53I7enZDRjUEU85vrNE/OA9HEklu73+NDu1MtXy?=
 =?us-ascii?Q?zsNAskCvwIO2qHYzcMHCJ/jQj/qO7j4JZthMKH7m12Lh1e8E8yIZkNd7ffSX?=
 =?us-ascii?Q?sxSxiUWI3TtKkilJozyfi5Di1lkfXkuziQh2YMHBlJZs4ypaQFJS4P2EYSST?=
 =?us-ascii?Q?xdpxB3UmXzmr+Qo2RANDfm3sjIxZQp62Gg4s7MJIhXTAnniQGt+SF8fXRrNE?=
 =?us-ascii?Q?ybfQnLXzazuRt3sFimWfg+/hMr6zLsIE4NrsdyChsv7Ttssyip9hZxhgkdNn?=
 =?us-ascii?Q?Qq11BoZmgpdexv2Ilz7S7VYAcFSDiuveWzwKZJF1KPsMWt5Ln8IHkisuFqBa?=
 =?us-ascii?Q?0r9jBMFOyOBAYrZ13nPwkLjypOWj8ep1d/G1Vhz3kL5Ys8vbtiULPEOYqGgr?=
 =?us-ascii?Q?zK5ZvxFQz6jW/eZwFvP9XzIBWpnmhXemefEUUmwsp5UCSALx+WCn+LrjfvP9?=
 =?us-ascii?Q?NebpkeUH7jTpBNsep8Oaeq4//p+kkbrejDt7wwX9+pEoHxg9BmP9RjRNX3qx?=
 =?us-ascii?Q?nJ4b5cN87iSTdPA4tTT4CcLjMQswNERXBC5iP4Jb2PclLHKCoyWB0RhBWqOG?=
 =?us-ascii?Q?Zke1qnNjE3kUvakyRBinMkuGbi8V93YbOjszt+3k09sCDqOTydy+rmg5qnWa?=
 =?us-ascii?Q?iqXXWmjA8/TWrdSvzCI6nvfuD2gs0743ZeFvFqRxVcN7QYnLCzYgL8H1htgM?=
 =?us-ascii?Q?cN9uS+00chXLrpSmVMHTj+1tgTLUOPtInRSjsX1YR9oBYeG/SPyc6fXUkKbU?=
 =?us-ascii?Q?A0DfICnHqBTRnifFaCST/rKpSnI6xzfDEsdpxw10p7QHQw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dJRW0ktoCofw9ndR219OAVY1Vv72TBpLAs5C6aHVXb78shSyEGtIPEz0I7wR?=
 =?us-ascii?Q?fJiTSacr/D6D/qKExJTTc0yQ2Dva/bySXDA5lxvFy06kbiHuN6rvi797esq5?=
 =?us-ascii?Q?iEFhcobflJqbnpCHeVzK+jg8tvIolOtn+7bcfMHg5xEeY9MobxGNdx16b4sM?=
 =?us-ascii?Q?sdK67q0RrlOoycfuygKP6VEjELDtYV+TCXlgHt/ipPjMu9H7o3SugMVCdPMA?=
 =?us-ascii?Q?ctaGDa53QC8rLCrRUZ109PpFAGpXGjT/m5shisT88/MHsjvWz+NRt3MM+WnB?=
 =?us-ascii?Q?0Zf+Vj5qNnvz+PZZIJ3a31tj/LMokUIi5HCTtCKMQjjfdN+sTXarSdLxyiVK?=
 =?us-ascii?Q?XT8EIGUgrTlGTCYscjw/52LOVuocW5OjASLc/2qSFKCumyq4aSsnCPBAkvIq?=
 =?us-ascii?Q?LtxLwKYYSfbMnJrT2wAIbGv+cZ2yHMx9AGK0sxx/GeC2f8shnc6zk0JEn2M3?=
 =?us-ascii?Q?NA+lBCDOpSQS91FqcQKx/ThOkPIXIrm8cxQ55sUJTEWO6CO4EZEho1PZ+ePd?=
 =?us-ascii?Q?Mhi7hz/3tgFiw4Omnlpi+I2FivoO/ct4zMSzo1umZbvEYBg5VOy1GhEB9uFT?=
 =?us-ascii?Q?CgyETgI609w/fbDIeEDq4VdUSaalms9HkLSGZl/Ec9vWPXqih0enEP5RuoqF?=
 =?us-ascii?Q?ZZsqakeRfzfcKRNhoBVpYEdCipPOVxLrtNJlf/BVC513gfNtytb2vfmOe0um?=
 =?us-ascii?Q?arm4pcXRu/9gNhdffQSWClco4jWTbWZVraGJF1s+rOxljcTbrPGouS1TLbRu?=
 =?us-ascii?Q?W/tUsBW56DawNOT9JEgP+t/xk0Upcr4CodyLCaIIrW7gI69KgKZFx5rjN0B6?=
 =?us-ascii?Q?9HTeWtjm9OjrI1RGllqOFzJRzvuOsPOVDguKO9yBda2AlfOcTyKN1cTBCkoc?=
 =?us-ascii?Q?vn5JJ6MzEqQslXLUK/myzxcrLefdbj9HJIfPmdzPIu58wpEHP4ddnPazFpij?=
 =?us-ascii?Q?LNXZBaB5jii4V88pZpGjtWQbI2t2hQjtL8l2vWT7AYmqGiAEJeWs0yPpMf/P?=
 =?us-ascii?Q?BBtVkh5oHZZ9R9sTMNNnkXvXU9cCMzQreANMZPw9qFra36euoTwS/9dm6iyb?=
 =?us-ascii?Q?cJab3SYEXTyc2zpMuAajBXuWRDmmKC75pW5PjmicX4CdVX9aASKf3sZbstj7?=
 =?us-ascii?Q?qvBhwD5JYLJarvUuJVpQwwVjSKslVgmORI8dkCA6k7HlOu22zBEaxht3s7oA?=
 =?us-ascii?Q?D4lkQfWLtKZ7bN5Ppcp4sBBvdgOE4N2Oh5R1kmn7u+jOgbXn8eBi0fvBlHVO?=
 =?us-ascii?Q?KppsYk/RU4SaFRPwd2Phba+LaIDY6ZF4JFnAX7Awopw4QWjJk852w1dry1nm?=
 =?us-ascii?Q?iSzR2Z2DiWKa+sphwYxsy6LGJE8ItQtifp/2iHF3hAPMum04j8WiDhIjp7r/?=
 =?us-ascii?Q?iEg1ac2JMfjF6Xe7BWTbwwIQ0BPfxyr2H9L2EQGkstHotAOMaWqf3HMz4bzd?=
 =?us-ascii?Q?VsXUBi8J764ORr02e1mZvr5CiTVU4H8dKTpdv3LmdJS0vITf49Kx3c3s9EVs?=
 =?us-ascii?Q?y87cUJj91lLCPJb6UoGqNTBiekVbMj7sceUb7EA8cltXVa2wGfN7aMtdjruo?=
 =?us-ascii?Q?/n2Zp7YI8+OX6oiO+radFnSOJV02iYYymIqQGusz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1aecb3a-01a2-4670-5abd-08dd3188d5dd
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 15:09:53.1525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gmlutYDtaoFovFgpglowmXzcVRBcW8GP+k4+AtP4rMTgRFxB8e5F/v40Q+NYCKbjzTRT7VQiHG4kRYtk+GVykg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4825
X-OriginatorOrg: intel.com

David Reaver wrote:
> kmap_atomic() is deprecated and should be replaced with kmap_local_page()
> [1][2]. kmap_local_page() is faster in kernels with HIGHMEM enabled, can
> take page faults, and allows preemption.

Thanks for taking these on!  It is good to see some progress here.

> 
> According to [2], this replacement is safe as long as the code between
> kmap_atomic() and kunmap_atomic() does not implicitly depend on disabling
> page faults or preemption. In this patch, the only thing happening between
> mapping and unmapping the page is a memcpy, and I don't suspect it depends
> on disabling page faults or preemption.
> 
> [1] https://lwn.net/Articles/836144/
> [2] https://docs.kernel.org/mm/highmem.html#temporary-virtual-mappings
> 
> Signed-off-by: David Reaver <me@davidreaver.com>
> ---
>  drivers/char/virtio_console.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index c62b208b42f1..24442485e73e 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -883,9 +883,9 @@ static int pipe_to_sg(struct pipe_inode_info *pipe, struct pipe_buffer *buf,
>  		if (len + offset > PAGE_SIZE)
>  			len = PAGE_SIZE - offset;
>  
> -		src = kmap_atomic(buf->page);
> +		src = kmap_local_page(buf->page);
>  		memcpy(page_address(page) + offset, src + buf->offset, len);
> -		kunmap_atomic(src);
> +		kunmap_local(src);

memcpy_to_page()

Ira

[snip]
