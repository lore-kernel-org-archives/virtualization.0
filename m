Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1827E846F
	for <virtualization@lists.linux.dev>; Mon, 20 May 2024 02:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716170866; cv=fail; b=ew5V49biLnyBoQdgfqZ3nPPbOUXW2vG9vKTAtfZJxaZ70sLqfOcaOaDYodBJUACpyH6QrzviQGbiGds+Nk6c05Jc+iFkU9vX9/9CrWsYG3SEsSQc7dE0SFIIBIICKWw6R57ErqcqtERlUqsD6orw8wOHmdLxcy6jCZYvvwIitA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716170866; c=relaxed/simple;
	bh=8+oKljGRsIBnnUwu+m7AamVByPzgN6xse4ZkPVFDbmA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pwLs4uzHgetP9jTNWP7kj9E2lmgm0hkhJtQ4wyPV9qQGXrYmzLMZD6sYmHj2OU4MiCkppg02x+DV7lYsmibCf65EJk61selBNsjYFqB4KmAso9wZHiPD12DLTxfHqQ0akqyFQMSrCyF5WF55bNowZ2lnVUKym/JuAKZhllBcZWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V+dJkgbK; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V+dJkgbK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716170865; x=1747706865;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8+oKljGRsIBnnUwu+m7AamVByPzgN6xse4ZkPVFDbmA=;
  b=V+dJkgbKflk63XnHIVoIGqgrkkaW1uj/zRn3B8iBd34e4+iwmetjvpoh
   onmh4L39YWJ3ckeQRyOVlgXCtut9faEfIEyhllPscd3HNmjqDnxVxOVuE
   L79ljQxjUhaqV12SS3wX5o4jWWRlCIHvZGf94AOwEvr2tQF28o779AUT0
   bZwp+btK7CdqFebKYqJdFSf3+i1qpXFiT/ZiIo3z6j+ZBgPu2iE8FEtKy
   lKJ6T8x2x5ebgwaFX7dIZ7v4VBO5va1nsyFSzs8qP5F1Mz3GSxzZCCKon
   3a6pOAk9n9OWpICE6wvjfvE4nBtU3BXWMdGcEoCCZ/Nn0yAyAvFdA6ZjH
   Q==;
X-CSE-ConnectionGUID: WnUv0a01SOiM4KkNTLnEFA==
X-CSE-MsgGUID: juJDaAXJSRut1vNG9EXt0Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="16106455"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="16106455"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 19:07:44 -0700
X-CSE-ConnectionGUID: sDFDGYZjSB2rNRsFxF8YKg==
X-CSE-MsgGUID: Vl3fj8GKQuiujP53l452IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="63605318"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 May 2024 19:07:44 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 19 May 2024 19:07:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 19 May 2024 19:07:43 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 19 May 2024 19:07:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3cYodVnXV8yMXxnVHBBQleeHehcGY3z/jFHyVhSBCdhwXQ4lUg4snc7yHAdK+JvTxU41stHIi0Zi3g8k9DsLxq8njlzWFwcKsyPOGYh460wgpDXbMxH7Al4PIw6QBkuTro/VOaKCOxOylYYVFUh6as+xQ90hcesbe2+ASCMh/FI1HI3BS3VBukJOX/PEfaw1NhbNEMoCaB8T25i/Rp7bnmr6g589i/BOD9u9tNA3kmNVBciWmJCXSvfOL6awe6tMrkgXc9QVK8FQVTfSKVqlEBBDkWadCDqZY2saqAkU9lvo9OOCGmez9vPO+eCHYjvxMpwEo9/yestN2RJMsLS6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wntIRFlo4Y6RTA4eD8ECFrASEdGUCwARqtUQlCp+mKc=;
 b=DuZ7IrytT0M46RjeC7dhwCwTRKiR+xkPuaGkF9x79h2Kwf1zGa98C9xofh7d9iY8jC5hGCZnPHn2O+M8tQiJnzBOH2fUdX57r72vc4Iu4XIRAAQ9OW9l7lzugdi4eNjFRnsp4HCTXy6lh/2pZ1EGvHtVya78L8p0jZjL7VTKfonAxtY484kxPs3EhaAtShQFYRSoljovZozaTNizbAMgVe7c9cmVnGzX3ttaqAhmgrci0Jndrei89VOpqU6Bfr1iNlpTWJDuq1LJAYjMHHulZFyA4e2zcQfMzf7GZ1ys1eN3L4pcN7eH5Qta7k7d5BxEraaHrTDQZEyrngR+qZMkUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6153.namprd11.prod.outlook.com (2603:10b6:a03:488::18)
 by SJ0PR11MB6671.namprd11.prod.outlook.com (2603:10b6:a03:44b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 02:07:41 +0000
Received: from SJ1PR11MB6153.namprd11.prod.outlook.com
 ([fe80::9546:aa5b:ecae:4fd2]) by SJ1PR11MB6153.namprd11.prod.outlook.com
 ([fe80::9546:aa5b:ecae:4fd2%5]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 02:07:41 +0000
Date: Mon, 20 May 2024 10:31:15 +0800
From: Fei Li <fei1.li@intel.com>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
CC: <linux-kernel@vger.kernel.org>, <virtualization@lists.linux.dev>
Subject: Re: [PATCH] virt: acrn: Remove unusted list 'acrn_irqfd_clients'
Message-ID: <Zkq183IzBA6cV9FE@louislifei-OptiPlex-7090>
References: <20240504174725.93495-1-linux@treblig.org>
 <ZkfyfrDysJ2WnSZq@gallifrey>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZkfyfrDysJ2WnSZq@gallifrey>
X-ClientProxiedBy: KL1PR0401CA0004.apcprd04.prod.outlook.com
 (2603:1096:820:f::9) To SJ1PR11MB6153.namprd11.prod.outlook.com
 (2603:10b6:a03:488::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6153:EE_|SJ0PR11MB6671:EE_
X-MS-Office365-Filtering-Correlation-Id: b8706a97-d9e0-4a60-21ee-08dc7871a173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gj6617P7AaeJOa2zgEXPP+wHGbj3A/gKrnV/PpGztfYjq1XIo+JIGzzETCzV?=
 =?us-ascii?Q?HC8geVf4i2zGCJ1MYwKJIjQ1k0S6fN7DzK6NXDRVbzjoHPclerpbMbuFHPIq?=
 =?us-ascii?Q?iXp1x1HbKHEV2Bo85cEMbGGJc3rGlVTa0huGP4Ncf6/TfeeYOArE/YENdGDS?=
 =?us-ascii?Q?K8iXQu9KlGQ/TnUL0VTYdu3wILbP5CiwMLYpTJ0M/tymK0/QL1MXzOqNEiNX?=
 =?us-ascii?Q?DLcIS+YIzRV7QRnv4L0Ez4iBiPjj0IU1yytS1gilTMwpenCUe6t1BeML1hUj?=
 =?us-ascii?Q?hUfSUHLOlX/Yd5sE9FLV44kOJI5H3t0nVaen9LkvU3mZvCo0GlKwrfFY/9pg?=
 =?us-ascii?Q?SbgzXYFn5XWAen1LiZIBA4b8QQKkW2coo3xKihOs3PxDjlquxL8tWH++tL1s?=
 =?us-ascii?Q?/xqSPWZBkDcpscQs8Seot9ahVFQNfvLKN9emX05v4sxsgo6Fs/TyH2YYzV+l?=
 =?us-ascii?Q?xFtUmlqIp+TbGh877xE8t0sm/NF1CUn1vjQ4jDRv0pN26TmhQ/OkYsaEMdzZ?=
 =?us-ascii?Q?PjmCoju9KkMT92pOsX4qaMrRu0MfcNFw4WuX/wMQ4qJAmfh6fDGBGMJ8vSG9?=
 =?us-ascii?Q?2zngxJblCKP4/jiVWB886L2hThrrIPhioioE17gGThRnRGNHBduOI2i2EDKh?=
 =?us-ascii?Q?IkGomuNvy1ZJQ3La6nkVRSIjL1S70ffT0o98g2xN4xrxyGjRZ4q9j2ATxQc1?=
 =?us-ascii?Q?imgXXx3KJ0dGoKJKN+j6GdTdD96e36mqVC29GEaAE4qoc5l7MxUR7W9IIy4b?=
 =?us-ascii?Q?5V1Ops4951v1udaOOnGh79JNDm7xd9z/2anR+j6ynjglymW8iXdUOnneYbLx?=
 =?us-ascii?Q?P521Z8t9SIu++hxENiuW4wPTXDB5g6mXpIUWlA+VoSySeKPUoLTgjs1ivJQ0?=
 =?us-ascii?Q?TyseK4TyGatFbrzuc8Rdzhq03pHEKhvKiGlQpNsGLZdo0T/tDRjdUimiQjC5?=
 =?us-ascii?Q?ueq6MybwgMVu3GFjsa0HCL+kwMcMEMOT+zkgR+8r0WmgyHAxFqSIuel8sVwW?=
 =?us-ascii?Q?onv2Etjw5hbysjDmE30nn1k6qxHfoFqWV0jeeo4UJ93YAyJOUPId/luaF7m4?=
 =?us-ascii?Q?WXhXxjFuDtRgPGcdHRxrlhb++NzPn7yg/s7Wj2oTWL6ndMdYu6rEmjZDysSg?=
 =?us-ascii?Q?OT+idezY75N902nwIp/wjCng191Eh4vahFKMNyo8k3P0S90r2ZFzHyOaIAEb?=
 =?us-ascii?Q?ntbZjIGfQMf72mDKgDy5yBJD3QmuWH/y84El8w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6153.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2LZuyQayBn4CZaZHM+Og1484XZ7g9TgCUC2jD+yGfDjos3IYyONLyuDFdw7J?=
 =?us-ascii?Q?MfPb/Tbn2uyYlcnop9fazXLC60FR4MAqEd5IdMnYWRetGbyNOItizcBdElqA?=
 =?us-ascii?Q?GkvzEpgsGUcd7+GflORff5e763W0DEwZhf7XO4iXvKO5UqWst6iUe9YgtGU2?=
 =?us-ascii?Q?38qTngqZDTiw3AZ2+jZ3H7qEd09jOmCuXebOMlUyIJVUPNqDSNsxBDC7rYGC?=
 =?us-ascii?Q?5P4why+5to54DcxQffrc8DLmjPV2jVmYOrGROWo65dY40jS2QyZxUQQuTLj3?=
 =?us-ascii?Q?xe+QmjNI602CcweKmZX4hOw0Dz7GY9CAo6cli57hoRMB8jOO48M/ojOKnKrF?=
 =?us-ascii?Q?lXWUyVTWZi0PstnB/nI1NgfxM9Jd6B8eWQchAse5ITONkXQrrHxfnI4tnJ2r?=
 =?us-ascii?Q?GEAi0x2Igyc/GKoykO85EZuyhECVZNe2ZTTlmRKMM7efjhdLxn98yRsqBRTn?=
 =?us-ascii?Q?8DbeFtoW5028MN6ZBevcpLiXTtEvt4NrDdDiHie6p3ahNGAwxiQUcCAJsFXz?=
 =?us-ascii?Q?DdOoOXE09y9/YJkZj2JP5C6cUCDGyX9neI9jAz9Y9hGhMLOoLCc4hWBZz6gL?=
 =?us-ascii?Q?C1tVobSInzKKjZLY63To3K2QeebtA1copIhQBDq2DD4yJRm1LF1pKZ/STztH?=
 =?us-ascii?Q?bxUYyxBcI8NZ0DsYgOVZr0AoKIpsiYyORgfsVTqrvVuXCC2+DoNal3GiFkWW?=
 =?us-ascii?Q?ylhORVsUXxF5JPmWBvuneXPcssxf8ZdrMkQyTXEh1R4ywdYbYvazNxv04IYw?=
 =?us-ascii?Q?CSzCOY/6N7hFznZhYjlYkmFGdZky4CFDFyf3KR26AvX3LQXKEXK16J0+pyos?=
 =?us-ascii?Q?+qZ+ivTXmpOM+o2+4CwJqFljhNHPJWf+qwBpLh/SzdCrIbc/7uAwFH9EOynO?=
 =?us-ascii?Q?dsV/aZERh6XvkcjKt53T2HtPWQR+MIk2MwC8Y5VRlaOV9+jTI6t6UsE+4ByW?=
 =?us-ascii?Q?6qaBpXK42FAp8yIoEahJvfjkX8hSkCPpVWz956db9CGLcP0ZZTzFGznDmgUm?=
 =?us-ascii?Q?ULfpSM6Hm7gTFr3hCI3MWyYOfAnn8okspfn7XmSzWbvvSCgSOU6PsQTi7aJS?=
 =?us-ascii?Q?sWWAQ9JKWFpFcSCDg3d38wTkaENruf81HfVNONA4bmmsmlr5LSpgv7ByVCx6?=
 =?us-ascii?Q?FdygKnS6hpkkMbvKdKHZwJJ3odmh9YGQf2onYSdU6ep+QYtZZ4viJpp3Ed3h?=
 =?us-ascii?Q?hMnSFBwCJnAoV+v7lA7X3ZgZqUbxmuObzlwJ/DclV5MRpCONJLhU0sL0GT7P?=
 =?us-ascii?Q?6iCqV9aIj+y2ln4wj7eU2vWuyD+L2UrwZmBEam9KxZ9lmOkqtu0Ha+TMJi1O?=
 =?us-ascii?Q?dck01I8up3yBXglRSIJE3xQbu/kkEro6fbaY88/rve3xntLI+HMbpFnMmeqC?=
 =?us-ascii?Q?h+bQuSBZRdO6O6/A5nzsIkpqRtG23VYgMzI2jnzRRUbw3rFXfDI56tdZWTww?=
 =?us-ascii?Q?tsVflPuw55F/j88qKM+X68qWzzIuSRHt+0/jw5EE6a74kwMbCjWDsiQYgvD2?=
 =?us-ascii?Q?3/GSRbGeUrtit7bCHrRUJ/TY9zOt+9jNQ/0Ai/Z4EXSSkikBFaCaZcQzE3aO?=
 =?us-ascii?Q?Adq7RXGXFY2LRII7G6O5CJF2lVwHbmFAD/Wq15/v?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b8706a97-d9e0-4a60-21ee-08dc7871a173
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6153.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 02:07:41.6012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cO09T09QpSbc/l03/1Q3+Z/QihvZO4bVAFrFk63GZ2fIPK/MH6TJB4kZXv5ewzfhqJYCaDO9fLMJJ1RLHfqYrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6671
X-OriginatorOrg: intel.com

On 2024-05-18 at 00:12:46 +0000, Dr. David Alan Gilbert wrote:
> * linux@treblig.org (linux@treblig.org) wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > It doesn't look like this was ever used.
> > 
> > Build tested only.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> Ping

Acked-by: Fei Li <fei1.li@intel.com>

Thanks.

> 
> > ---
> >  drivers/virt/acrn/irqfd.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/virt/acrn/irqfd.c b/drivers/virt/acrn/irqfd.c
> > index d4ad211dce7a3..346cf0be4aac7 100644
> > --- a/drivers/virt/acrn/irqfd.c
> > +++ b/drivers/virt/acrn/irqfd.c
> > @@ -16,8 +16,6 @@
> >  
> >  #include "acrn_drv.h"
> >  
> > -static LIST_HEAD(acrn_irqfd_clients);
> > -
> >  /**
> >   * struct hsm_irqfd - Properties of HSM irqfd
> >   * @vm:		Associated VM pointer
> > -- 
> > 2.45.0
> > 
> -- 
>  -----Open up your eyes, open up your mind, open up your code -------   
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/
> 
