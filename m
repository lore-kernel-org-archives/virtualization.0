Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013039.outbound.protection.outlook.com [40.93.196.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C719A336888
	for <virtualization@lists.linux.dev>; Tue, 21 Jul 2026 17:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784653790; cv=fail; b=q6cnZWibSWXNmePjmtGUPLxHwts0ibnbyod/cfsZSSS1zg+meFIm77mxxoocXmCYfXNZinLJ/KKB18621zElU8VFbz2LZdZQFjC4x175uA7d/8E65mqLfssNka12B52xAfxVOUdKfNMlBSZJ/BKZ5G0cMv8lw34LSTGBhKOww8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784653790; c=relaxed/simple;
	bh=uvNM0txmYatuc30/9w/ThMe4AuWEmglPhKHgEBBWEcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nJLFsZvyId2BSjelDFLO6+45mC/U5qGIrFHWDZ0jOI2VLKmrIeuUk9bh/EhQga6lGtCW3J7zUS5mgqrBOMoJLCvR55mapWqAMTR/NYuYeyk3AWxgboUPKRAsplT+hPr5dgKPJBosnOaspiaQs7e2cufaYk8FhOPtzaHChpsDJks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lb3O5+fZ; arc=fail smtp.client-ip=40.93.196.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lb3O5+fZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1XNtg9NouAU8Yd+K1OD3qsDcKMwR1NCgg39ikjE+sOlQhLFPNDKbctsXPTbY3DiA57uh+LpEaib3kqpe2IY94EF8PEJfNNDswbLlb8uhfuAWG//5w649uNnFaYdWnd88OvDZg5UWE2bMZljhvWXMxt7P6j9XQ30HK4RkvmyP4djsFbqObmEsDxYI1qEmoMoQ2LmJSFx/OHYMGlw9pFZJZnCxFCLVbd5HrFMEKKQZHyL2cubbtuuJOSxeRow35Fct8+uGK3iXtBC+hZPjqfWx1qYpJfhKoNYaCvLdPA+72Dloc+0e9dEHeFwEy3i96hKQciYu6o1kyyCyEY/073b2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Fj8LP5yznK3BCQRAsR6sgdEG6GRRKPGCqcdcLVxwR8=;
 b=stqUKNEcSh/hCZmdQswL6AqX1chV2lmRm+dTTbKQzO7nQe0x/dO4eZVNEPdQ02tRRfQaZUv6KjhGhxEZPr0sYo0TBBEwdQr1NKLQvqVGSYZDT6A/XjJRUXHTczP6xFfF/qS3l5+EcNchHPvlFY119J/5vSVxwwyq6P2shWwm+nJIkpQGV560gvRSVFp8rNA/wQP7FEypJBnL/iy0Vst0zrizSWdMquPH/n8FJ5EFAlOLBFBWiJfwCkf8G/cEqCsKqOas9AWmQlQ8mK1BQ5qMZyWWf8kddWU+A8hxaion+NkXqp67s1/CThkDttTpHrwxKEqkhI5Qd3PKJDvzpo6z3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Fj8LP5yznK3BCQRAsR6sgdEG6GRRKPGCqcdcLVxwR8=;
 b=lb3O5+fZU3P4HvxeDaTZ3I3KVC/NwNGlSotbctTsSO3CT+xmz/nD5/nkTLu10jGAnCv0QGzY0cjMnOoW5vHWSh0QDWH71E4n8kE1VXUl/AAE7FPLttbT2WQrF0fJuZpkxbc4Fy2K2loN5AfZbBYFxyRR2VBPrOxRsVMi23GTfticEHRLNDgl4sXW5jZ8JrERS+bUUrZov69gDyZmLvWKDknKtHEcweOAXD+8EEjH04TuDh5SrOp3eTv8RPoUWdHiERLDmp6Wf1Idcwl2hjbg5oykBC63psVPJgl7NifHgUHmCNxE7xhTJBT8kNRArfx4V5KjQNgxEPbKFTlBT6O/zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9349.namprd12.prod.outlook.com (2603:10b6:0:49::12) by
 PH0PR12MB8799.namprd12.prod.outlook.com (2603:10b6:510:28e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Tue, 21 Jul 2026 17:09:42 +0000
Received: from DM3PR12MB9349.namprd12.prod.outlook.com
 ([fe80::7678:ab4c:4a7d:7f9f]) by DM3PR12MB9349.namprd12.prod.outlook.com
 ([fe80::7678:ab4c:4a7d:7f9f%4]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 17:09:40 +0000
Date: Tue, 21 Jul 2026 13:09:38 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	yury.norov@gmail.com, kprateek.nayak@amd.com, iii@linux.ibm.com,
	corbet@lwn.net, tglx@kernel.org, gregkh@linuxfoundation.org,
	pbonzini@redhat.com, seanjc@google.com, vschneid@redhat.com,
	huschle@linux.ibm.com, rostedt@goodmis.org,
	dietmar.eggemann@arm.com, maddy@linux.ibm.com, srikar@linux.ibm.com,
	hdanton@sina.com, chleroy@kernel.org, vineeth@bitbyteword.org,
	frederic@kernel.org, arighi@nvidia.com, pauld@redhat.com,
	christian.loehle@arm.com, tj@kernel.org,
	tommaso.cucinotta@gmail.com, maz@kernel.org, rafael@kernel.org,
	rdunlap@infradead.org, kernellwp@gmail.com,
	linux-doc@vger.kernel.org, jgross@suse.com,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v8 08/11] virt: Introduce steal governor driver
Message-ID: <al-n0iPGnlTr39P9@yury>
References: <20260720172250.2257582-1-sshegde@linux.ibm.com>
 <20260720172250.2257582-9-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720172250.2257582-9-sshegde@linux.ibm.com>
X-ClientProxiedBy: SJ0PR03CA0058.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::33) To DM3PR12MB9349.namprd12.prod.outlook.com
 (2603:10b6:0:49::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9349:EE_|PH0PR12MB8799:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d91c166-7b46-47d3-53e7-08dee74ada0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|11063799006|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Ln40HB4XdSXuVSRIMesWuy4p1265M7hC9v/EdHzYso6r7QSl7Ay+h4bkH9twpuzFBOiuWhegZb+Ahcnf3WdEtTFKxxzocU3ADwLN0LSDaQh7YM0DAJbC5An3bY8SjpGDPNABgXcdUWjJ2TRkkf/CRf1BrXewvtFtAo7b/6x7wMIJnO2NEYMI6m/PJ7/P06HE1BuHBqWNj9gwqkf/JtfX9lkgMTQViZ53qC5TsbxAYWoxkcOvT2tK14x3CESBfSlLjBVL5dhz0q50RAThQf29GVLZ/vW8rwjconE6LnsyL1U+cAs2phfX47cqEx/RgXcqsIYFQ957P21ukz2seEZdfvBX2s1LSNdFwU94mnxE+uMlWwecqWwriJNrXjzBAf6m1W7GHjHL9AlzbAw4hB/e0DBJC6sFhmP5nwN7+sVexyacnmLiP2TRJ/WTQkAmqB40g15Ze7X9ivUfNkhfqBOyKa5Y9XvR2+7N3zhi9Byxrf8mFdOtwQyqzO9TfHPbbd/vNH/tpWvsaWfiHsOjeRbvNVGteRanbKIMfuxdomjT+pwOjuIx0oItlTjE5EePPi0sPI/wUlA4LPwtu0mr8jOw/MXA4vlOHp0rA4bN/YDfyvytLDUz15fUeJ8WZfNbbgm9qP4JxfigLoqpwZeCo5h4OQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(11063799006)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B0UW5zZ++IdylOZpAyKobKTXdz8aDjOQBaFLg+DkvREu3qGwuiXa1kIOeyST?=
 =?us-ascii?Q?ezG2JA0wueSGLPw8YRtPLJby1TYpnJAszQaitW9wsOHG9cC9ZFbCJUBld8rb?=
 =?us-ascii?Q?uwnLNjm6TCFOz+DdK1+fE1+zlHmYK3B5ginTcqM6k/KbxVIY82sWED+j1Jcr?=
 =?us-ascii?Q?5XIsET9FXG5nbTQgEfy3a15YMC/le5Jv9WfaMnFtuIHdhT/2xHPNTMQtG4w4?=
 =?us-ascii?Q?wh8aukdNa2gfkDodIfEp+gClNWhil7qpWmNkNLOeQxXj92t/iPYPiht4XjJH?=
 =?us-ascii?Q?IesSmYZg+O5LvcfToB0GFce+JsWTuBp09laqrjKH6yjWhggfcmAErbxcpBlH?=
 =?us-ascii?Q?lLShrhh9aQ+E6d6Zbb5PTq081yVDYrXjygaRFyWeW55ZIt4BOQ4VafusLoq5?=
 =?us-ascii?Q?cSM688ivf7yf6/B0DS2zrjVU4pLhX3tnsdKkvXS47/9XSPaVe2CQX2pGfDQD?=
 =?us-ascii?Q?40ObgH25DxxRS/9zmACR00ylhdae+05YhEfbYo8Yc6alRKV1adyRqpDy4SO4?=
 =?us-ascii?Q?xpIQrOY12bREJGpxs/lnmt24A/EshCDrlfApOUZDFJ0BuAQRDJoN/iM8d0v6?=
 =?us-ascii?Q?RnsKx9Y1t7cWWaFfGiqEKDk+YTLygkAhnicIx9uHaZc8Q38KvJWwg7xO9fLv?=
 =?us-ascii?Q?iSIeHTndQj7MK2IkTixKIGEP24BlXXoDM+vB1gM9xh5oADuJJm4EeXF7dGB0?=
 =?us-ascii?Q?xUudNEcQ7hLiSPTKRdO3tl+tXZ5kgdfHdsGS1lQ9z/x9VJwojL5tJ+NEM/LO?=
 =?us-ascii?Q?k8regC/g9vA3xfZ1aF0UOwHK0OrPH/sQObgmIb570nUQaM30NYTCwqZUQkdj?=
 =?us-ascii?Q?KVUlFhoICuVJ8A8lKS1RDxqJxGqhP8PXBFjwrREYu5ekVKodPV8LxVy2V9Rc?=
 =?us-ascii?Q?1dOg1yGlLfHEyT6xHNPlCFmKLRNxujTZ5z8Tl+waLaw/ibWXOznTX+pG+uH7?=
 =?us-ascii?Q?8wGid1WL6hSekOcZc7FwXwRd6jqoCFp/rQFAfd52Tm5jEI4lkQMJN7STmuIA?=
 =?us-ascii?Q?JEjCve+GGajpg+BrUqTdsz0hMsgIfBXSW5LfCpOlhAKDL3LTRKgHrMMRnbYG?=
 =?us-ascii?Q?dNt25mctgOYZccxUWfOh632SHqDKkLsnP0EFM6ceC6iWUaZOKMJ90AFI6a9j?=
 =?us-ascii?Q?367Ic370l+AAV8LCkPYojC2kJfh/t/fxTStZkou3k7pgnmfoArMJBgfPnc0l?=
 =?us-ascii?Q?yvxQ+KrQJBbK6hOvyiFsJuUVotcvZzlRQ7csSvkFl6X+cwPOcIT6eotszr67?=
 =?us-ascii?Q?E6mpsor2fwvshx8a1ssDplJYJNvXhK/sTANcAZQfvwlv/BOOG5Ab0Qm+DRcq?=
 =?us-ascii?Q?RaEdDQp9YKKyL0tKy+v8tLuxL7rPR0sl3jTUf6titfcQT8fmhyRUqUnEK2ix?=
 =?us-ascii?Q?bNax789NvIkWBezzM1E79dG1dVHzM/IWY1C47fRuSJxdup04mwKAoKAxRqie?=
 =?us-ascii?Q?nTW6AewC13ovg9GHqeNsVh0DtsDJr53qkpM2o7Z1Yidk5eu4g+0WlVlMbD+r?=
 =?us-ascii?Q?3JZ1T7ZFaVffmcrO3ptQo2lZurXQb50FvSikSinsMWLqVFip7IzLbI13EGCi?=
 =?us-ascii?Q?IjLhNKcBGvJCfBRriQcfIVZFRdXL7AemQwlLKSddU4wrFZmccpmazrISlgek?=
 =?us-ascii?Q?CPskJ09kkOxTruKYNJGKrgiZKk14OZm0suXOXTueVkS21RmxAJZujo2CLgQk?=
 =?us-ascii?Q?G7jIouJ9s5wZv8fuM2BEqjCtlf+luuJgomQdal4vpqJM1caCY4hpjtek9tf7?=
 =?us-ascii?Q?Ck/GxA2fqg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d91c166-7b46-47d3-53e7-08dee74ada0d
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 17:09:40.7868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yabOySpcl9Mt80Sj27uWAU5AMWGJQl8CZVPqbQ5ZNabT8sspe/8wANxa2HvdmcgJKq3cbQNmM54uNssI4/4mkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8799

On Mon, Jul 20, 2026 at 10:52:47PM +0530, Shrikanth Hegde wrote:
> Introduce a new driver in virt named steal_governor. This driver
> will compute the steal time and drive the policy decisions of preferred
> CPU state.
> 
> More on it can be found in the Documentation/driver-api/steal-governor.rst
> 
> There is a new kconfig called STEAL_GOVERNOR which is introduced in
> subsequent patches. That driver is going to select PREFERRED_CPU.
> This makes configs driven by user preference.
> When the driver is disabled, preferred CPUs is same as active CPUs.
> 
> File layout of the driver is being kept simple.
> - core.c - contains main driver code. This includes the periodic
>   work function and take action on steal time which is introduced
>   in subsequent patches.
> - core.h - header file which includes data structure.
> 
> Main structure of steal governor has,
> - work: deferred periodic work function
> - steal, time: To calculate the delta in periodic work.
> - interval_ms, high_threshold, low_threshold: debug knobs of
>   steal_governor.
> 
> While there, Add MAINTAINERS entry for this new driver.
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  Documentation/driver-api/index.rst          |   1 +
>  Documentation/driver-api/steal-governor.rst | 117 ++++++++++++++++++++
>  MAINTAINERS                                 |   9 ++
>  drivers/virt/steal_governor/core.c          |  48 ++++++++
>  drivers/virt/steal_governor/core.h          |  25 +++++

Unless I missed something, you don't use struct steal_governor out of
the driver. If so, you don't need this layout. Just put everything in 
drivers/virt/steal_governor.c.

Thanks,
Yury
