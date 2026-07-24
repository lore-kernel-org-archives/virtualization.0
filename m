Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011067.outbound.protection.outlook.com [52.101.52.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7D14908A5
	for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 21:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784929242; cv=fail; b=CDwPzH8der4lBhXLCGLUz/Du+cKF4dzs72yG6v5nWZ7vX+BZt/A1EjwvGkPFqxnX4wty0XXM2Nz3PWjFlKmQk0Q1A/eO9paBRZOeHxXkT4re4tO2hx6t/kdD4CooJtTXebt8r5fGizWdnauiH431+IU+StDoHx/F7WMRcGP1UzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784929242; c=relaxed/simple;
	bh=QrOeCA5/kml4OL+UKCUKiSiJC4CIkogUB1+IcD6Vaa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WQRQGdkQLIFSvoM0egDvEmCXN3jwoe4oBmfsP2vGyC5qx9kNgZ4IMFJzzvGEwHZ4z/B2mBVstOdR829/CoUl60pfPOfNnGBwjUjzbO9uCZ1CccI2cdLR572PpEGusQGF37V7YPd49fqgg7HZqpOJtYFJEdFbBlgvCw7K/a0KvUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jqrQENZa; arc=fail smtp.client-ip=52.101.52.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jqrQENZa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LpJhMGq9Y/Xqp5c2J3lfsjdUXCC5HBwK6RoXfLVQYEaNhVAhkkgjuy/yUYH0UoaqeKW3dm904I0+4CUqVpxrjJgL2NmdJ6XblK8u2h7N8qkPUVZAP7AjMOk8hMcGBZwZesGbzX/dm9A/Nv9A5wOv8CMXTtVlGcnL5xv5oELJ67c4KwBEUbwB9vOSxaYZEwNvWrFAcAoqNd6c/Pi6RJX4QLPBI9R2KENgCgdFijEITM7+HQZq3Q3QeRWd/M8RuY5S1QyfJZ7xKUzljzTWGaC34ZhOmktwVWjZAFWeLkQfRk+IPodDlAzrFByjKDOxS5B3xsYpaNckXCQWMTI8cuJCHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqVLL2KGNBFEuUaSROl91UrwpdTDjupRFnvSBHe3qp8=;
 b=ZkZgDRssvSITNftS7wOp3mHwEESSPfne8BhSYOW9qSeyocdTtkkBVF4sN22wW8oObKTG8PRhMppSqMIPDEsE7p95zmUaGmIIDrtYiMXQLHghcFq7Rr0tmaoaUGSJ+qYK9JyXFmbvR3hsK/WzNCGPMYsdhotZ+GAZ9Gifhes1cwjCcTm0ExIJbEyCO7wjOl+WrC//fKJ4XaF3fpTgIqlrG8xwjsWXQKZPHOSCxTYVxQWKgXAYwrKqYVzS9GJznuSSr55K23ZdSbyKC/nnG8DA/1hrmiFPHxxYRRIuH8h73/jBxMZKESJDC5YUvLrASAkJuOxQp1ZcJZXSgDBrlMqc4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqVLL2KGNBFEuUaSROl91UrwpdTDjupRFnvSBHe3qp8=;
 b=jqrQENZa9CKVf/QgmGY976etbCNwlgcZpSjDPvTL/IT4G7or6gu5AeNZVN7QQwP7KD8O3FspHbiyaRRAtXOjeuc4ek7xAF+ET3NMH02Oe60wFE5XaGmbW0aamtwUHJyOg0sl30l9ryl7kAp3NRzmMSBc9d/0PE8pe+AJkajJclbcfzhj8Oy1b8jHK+NwWSXoYj5/TwFzaQxwyq0uBWQNVyCm10GYZL4EcdzoyiZRxS5i2lsb/i3rRjsQGOpC2hHW7P0D8y1970n9XKCDqQxTERgbqPh4Hd+2RjMqdBVNcXTgpmPIi4Pvk7DOwJt3z6ib07IjmoBvrII/vWfRUJtS7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by DM4PR12MB6423.namprd12.prod.outlook.com (2603:10b6:8:bd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.11; Fri, 24 Jul 2026 21:40:32 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 21:40:28 +0000
Date: Fri, 24 Jul 2026 17:40:26 -0400
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
Subject: Re: [PATCH v9 05/11] sched/fair: Load balance only among preferred
 CPUs
Message-ID: <amPbythM-IBt6j_e@yury>
References: <20260724140732.2683314-1-sshegde@linux.ibm.com>
 <20260724140732.2683314-6-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724140732.2683314-6-sshegde@linux.ibm.com>
X-ClientProxiedBy: SJ2PR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:a03:505::29) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|DM4PR12MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bab16c6-23fb-431c-5fa9-08dee9cc2df0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|6133799003|18002099003|22082099003|5023799004|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	MD08qvtZDyeeLRwfJ1ZcdwjgzvBxArT1b9hOf4308zPMcyL4Gf/7VazQhsY6MOriiaKrHVPKpIMnz4DQqmppxa5cWoWdKYNp/ZaN80oMEtek482JI8VurbyEzp8bS8QaUdUgy6X+dzFDhNGHFddcgIaZPRqRNqK0uc++1H3vCLxNYfxhgbyIpmR8NdGFMkVP+C3WhEn7WaoEP5lX65kuBXjEPELzJWxTh4mq8g6vThM75DC7A+Bj+1y0e2pxvgj9GDFhz9i8mKZrE9Xb7s96saz7rQQZbmkCrnGmOiJdCIh+fQaqh6uMTmTqao6H2PfzvwmJumXAKP41EIP8o++X7S1JFL7l1l/RRu+47tIT02neZnjujEIUNA4FXj8X1CsFgW+5gSnqvmIjx4VZYC12yB2+WYHERKQb2SdA/uNF0IC/UUOy2ehLGkYXEu4lUffyYO8NH1UMgEj08cJAfCM/35RdSPGuqhfJgpKQrwqPRlYDA6D4wnNl5EgjQY/XA2bnds1c5YelsBC+QS3/hibl3DHaAXF3dLXMVwtuBJaU+YzKLZAaQJc/iuw2Jncg7UZ0IuzLpJTUYeEUT7jXpsA5zkAxEWzFrbYTM/6n/2rHPLrgPclwRetxXxAq/zPuFSN/Ub+5L3BREAiTbxE5q8z3uKjSK3dylDGxnmUwZmnOPxI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(5023799004)(11063799006)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w3NTt+LwZLgkXkYnu+iix49U8FNdqf0MVTu8v2MvnhEDEw40xW1xhGeQIOI2?=
 =?us-ascii?Q?0Se8Jl2M80nJnKFJ62U7ZjuOWBsjZdv9Usfk38cIDu4Zr/s3Ygg3uL0knHuw?=
 =?us-ascii?Q?aQbZvbxZQzEsrKk6CEoD8ZuxakKEXyUlt5FiT+oJMlAHWhgp0Ka79DJN76yr?=
 =?us-ascii?Q?X6LIzTjfT/R4K0Eprui3v4OndZPY2jqu+vyrfIoNe/jrn24nzdaMEhhAi66d?=
 =?us-ascii?Q?xPbBH3+FDUieBMBz4ULndSKHRqNpypub7GJgM4WiuEY8Wuh24opgB6Px6/7l?=
 =?us-ascii?Q?4KgjO65MOEfsONMHngCVGxgp/IOBr38jh5bItU11jYjbeay5qsMhAYmcLj2k?=
 =?us-ascii?Q?5wEfd+WnsYClNP5NvUPEXyeMJUrMnMWx0Zm7I8QaEutX4F3gNuOvwadp0EpV?=
 =?us-ascii?Q?o8q+1wGakX4MlypOoNneLzZvRWO7M6uKW/Wmj/EkFASsKQyjfKTaTiqcKoco?=
 =?us-ascii?Q?Jrtd4MvHHEjiUiOGZ7mL7eY2BbC+jSI+hKJrjgnSCI+dkcB0ra8RPeri+MaV?=
 =?us-ascii?Q?iJmXNjPxqT+3PMPlE3Hci8HurPTvRWstnDZZLP2k7VsMES8rCjGmMznZ69MZ?=
 =?us-ascii?Q?cKRQ2RrfsEs0SaKUFWqZwope5xZKWbncJ/yFziwoo5Aqhh3/UOCdBs8NRE/m?=
 =?us-ascii?Q?eeukwURS9l16qE1phe1OoQbe37PL2iAne/DvhmX0kkJRps9SZEpJsN7LsZJf?=
 =?us-ascii?Q?fQPvazw8kFhhtqQiQV7a/rHDibosnRBgT+FIiQACtPfAblwJub8umU3fVCdh?=
 =?us-ascii?Q?OG+yYV7OSsUUEPVNTRZlNZSpjICGnNGeaU6YUXswIQvM6KQ7SeQDwYnp63jq?=
 =?us-ascii?Q?dAmAQeHOGIGH9ZPkg3o1w3t/IwpZSEWO+pU+0Yzoi97nCNpZndhyRqwToe48?=
 =?us-ascii?Q?EOD0tT1xgOu4xBNF0qQZLfE0K+ibIoHSk3VZRYSNyyU2E21v/jt+oEIjZDJ0?=
 =?us-ascii?Q?eoSstRcTmGYxVX3bS7rUqf1zBOcDpgfg35u7BZBbTHZbL8D+wvOAI6cL9Dh1?=
 =?us-ascii?Q?o/cMnDg0PywF/zY/Lp6n7THp5ifOuz9iB/w2BopujSMIw/glZEQWZ0cDQbqX?=
 =?us-ascii?Q?Af48vmx9BKnAGua/3dxxpGzVd3/zRn2NLljrhg5Ao8Wl0C5FzUJsVsFlaDdf?=
 =?us-ascii?Q?9ezZv3egF9/CQrh788BxlgnQ1WpDNfFTdGsXO4fBJEKodd0oqYm32avxRZFc?=
 =?us-ascii?Q?K+xNuCLmurjsLPzCcEOA5C/h9dUWgCEIqJ8rRDJckhnnXKhtUmcPvMK1N7BD?=
 =?us-ascii?Q?Tqc79hka7iCeoRLOOpqObUn40RZ+ensseXssnRBCV9KC85yi/zbheLgxVUJa?=
 =?us-ascii?Q?zB25S2DOIrGG9V8dOVxmhivb9eOZNYIq2W/rZVeNCCELkdmqpF7EMNNzZDW0?=
 =?us-ascii?Q?gdT8vbvDEJiU3RViu/tHX1zgp3lxhowpLwjq5J+UuP2uBeWBZfm3UzoP8TIL?=
 =?us-ascii?Q?2WWYcXWISimsUob/iUKeZeaL7UIidIAZKnRyhinyeIAGcIfJo8r2bwNozr59?=
 =?us-ascii?Q?ALoP/HpRFzLiUKw0Ll39TP9QQnoiPVPp//Nwp+OOlyqAdKQONWvDiVKX8SMG?=
 =?us-ascii?Q?amboO/x0ZwX/+N3U/HbaDS5mQLrdGLxf7gmLWw8WhqqtaqNuMPoK8I07+Jlz?=
 =?us-ascii?Q?uMOSYqFjIJ6b/el+lRs4ytjpynrLxUcXdP044Y0ar1ZgxbqWbC9wae1acQBY?=
 =?us-ascii?Q?xcAKZg+S6x7tNMqlj1/hXeYyiNbQJIopboi/b7akhRxGj1FLG8QrFcvZYgTE?=
 =?us-ascii?Q?9/qbi11OyA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bab16c6-23fb-431c-5fa9-08dee9cc2df0
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 21:40:28.7948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TkFAKOZlIsNqohttWguJsAe3bv0GswyFeim3mHcAvWe36rsNE/kLb37j/oBpUNMpuT+CFZ2DIXZj5pr70wBz3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6423

On Fri, Jul 24, 2026 at 07:37:26PM +0530, Shrikanth Hegde wrote:
> When cpu is marked as non preferred, any load pulled towards it is
> pointless since in the next tick task will be pushed out again.
> So, Consider only preferred CPUs for load balance.
> 
> This makes it not fight against the push task mechanism which happens
> at tick. Also, this stops active balance to happen on non-preferred CPU
> pulling the load.
> 
> This means there is no load balancing if the task is pinned only to
> non-preferred CPUs. They will continue to run where they were previously
> running before the CPUs was marked as non-preferred.
> 
> Bailout early for NEWIDLE and IDLE balance as load balancing is done
> only on preferred CPUs.
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  kernel/sched/fair.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index df8c9c2c7918..12f5b7de28d2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -13399,7 +13399,7 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
>  	};
>  	bool need_unlock = false;
>  
> -	cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
> +	cpumask_and(cpus, sched_domain_span(sd), cpu_preferred_mask);
>  
>  	schedstat_inc(sd->lb_count[idle]);
>  
> @@ -14337,7 +14337,8 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags)
>  			update_rq_clock(rq);
>  			rq_unlock_irqrestore(rq, &rf);
>  
> -			if (flags & NOHZ_BALANCE_KICK)
> +			if (flags & NOHZ_BALANCE_KICK &&
> +			    cpu_preferred(balance_cpu))
>  				sched_balance_domains(rq, CPU_IDLE);

Here you skip the sched_balance_domains() for idle non-preferred CPUs,
which means you don't re-calculate the rq->next_balance.

In the following code, we update the global nohz.next_balance
depending on the new rq->next_balance, which doesn't happen if
the sched_balance_domains() is not invoked.

So, you propagate an already-expired per-CPU deadline back into the
global NOHZ deadline. It may lead to unneeded asynchronous IPI in the
nohz_balancer_kick() -> kick_ilb() path.

I think, you need another helper, something like:

        void sched_balance_domains(rq, idle)
        {
                __sched_balance_domains(rq, idle);
                advance_rq_next_balance(rq, idle);
        }

And then in the code above:

        if (flags & NOHZ_BALANCE_KICK) {
                if (cpu_preferred(balance_cpu))
                        __sched_balance_domains(rq, CPU_IDLE);

                advance_rq_next_balance(rq, idle);
        }

> @@ -14481,10 +14482,8 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
>  	 */
>  	this_rq->idle_stamp = rq_clock(this_rq);
>  
> -	/*
> -	 * Do not pull tasks towards !active CPUs...
> -	 */
> -	if (!cpu_active(this_cpu))
> +	/* Do not pull tasks towards !preferred CPUs */
> +	if (!cpu_preferred(this_cpu))
>  		return 0;
>  
>  	/*
> -- 
> 2.47.3
