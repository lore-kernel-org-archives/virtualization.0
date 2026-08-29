Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013015.outbound.protection.outlook.com [40.93.196.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEED2AD2C
	for <virtualization@lists.linux.dev>; Sat, 29 Aug 2026 19:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788031897; cv=fail; b=gO2VUpB3lO9lFfuHT9CWn0SlVgDxbKJfUBAhyI+dYat5a9MQZZsXv3TlifXBwvAn65caPa9PXAEN2UWM/Cr/wqL7MxirVw4UXghIp/poKA/Tc42MDxNgGLMQ5ciXhqrT6ozwzZlJD96vwF2YsDH9TCewpx5yoTqymxJqgn690fY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788031897; c=relaxed/simple;
	bh=Or15ssMoy4EvUYYY2af+EAVO63gW97seK7OHmg7u5oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R0wv30/pIBuKisq1gyEAIbvA9HZo2ZgGFwjwISw8AIvFZiEtr1u+Plh0YZBqWxeuctzHL5o14/z8Q30+2nILjt9UjYX6RKnlpHcZNts1bQPVMKyOrSgqirV7UdAIB7bg4oEBnQfRJB7yIRBSHiQBc9FWjPD1gN8DQ36u+Se+1Vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VpTm53LP; arc=fail smtp.client-ip=40.93.196.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VpTm53LP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpMVToirra/RrEtXZoh6gcO87c+zC6GLOqdtph/NVrBQ1NTksV/cU5GsSfvC4XZUfpx0tgKzGr48YWym326Xr2Y4ng6kGHQK7jPJ5tezHg3G5u+RVTC3gePHYE2QvT1QKzbHFNb7avd+oL2utLIF0qllaJS/L4MmSDzTwwMd3IB/Gi/X4k+ZZ85mJebiegQAgmRb2r74ZBHXQjJjc/mdXcVX+ChjS6Si9ZtSWoFnlKeO/GfDChHWt2vht20LircwlEa4dul6lErghbNofCwseRo3UxUqYpMPq09LuTCqcgnXbTy7C6FPe9FhsRpHmX7coMTBxlC81GxN8LlfnIHPrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8RsL7WNj0OXjtA4Lgv5SAzJww6fPfsxcglgN84xG+I=;
 b=MEI/t5OQGGlIZLhAAbLCxQPEUdQbqH/5sx/d1DH3B54vYRNOb7MxFXk8eK/jl5zSJpf2lvT4ZCmA6EkY1wShqprXm4YAyXVC1GbhYZfJv5kFVNUbY0GByPX4sWmti6a9RfusbzuIWKTeqoyu/1QYPTEUFd+ECRiERAy9Yyg05TlvQlMuvokw9AWXjGB95Ho6ZYYoZ3ijUaEKZkia87SHwOPlnJFxR87faumEwI/SJ4a2WErq+hcJOuqVgeH8omNDb8ZPK8MjzXmB+GiPzNbcnXrme7jH1ex/2KoAXRuKF7IDnYnfSFlo4caJjyz3zwjsMM6HiXtQS4V1iGmP7kms0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8RsL7WNj0OXjtA4Lgv5SAzJww6fPfsxcglgN84xG+I=;
 b=VpTm53LPEsfLb4HySFg6yCwcNiXJPb9fx+hZPgDtbNwNma9lSZCIYhU9WIjShnW/qS8ADbdHE51/YOHUnB5XM+ktWWhQna8ipVv5wZ3FrKEL5t42H/TcA+QsIe8aLJCEtS0r/HmmSDPX4YowJ9dKeXNQ90Q91FZnOoGVbkEW8VvJA//36M6tf0yOmXizMlcV/zADtYH9aVn+7l/Dm4T25DP/E8InbdyX75k3bYPXJ4FqtkSAp71fOFYWal1TiX4XGDe3DTZNCNrzhOmGDcX+jNnMrG/X5PZWYAYtlxOTweXH8+Tx2GWL9Byq2BWSzSUgqz1QNAznsfe+RGnDFDq2Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by PH8PR12MB7133.namprd12.prod.outlook.com (2603:10b6:510:22e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Sat, 29 Aug
 2026 19:31:29 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0360.008; Sat, 29 Aug 2026
 19:31:28 +0000
Date: Sat, 29 Aug 2026 15:31:27 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
	mingo@kernel.org, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, yury.norov@gmail.com,
	kprateek.nayak@amd.com, iii@linux.ibm.com, corbet@lwn.net,
	meted@linux.ibm.com, tglx@kernel.org, gregkh@linuxfoundation.org,
	pbonzini@redhat.com, seanjc@google.com, vschneid@redhat.com,
	huschle@linux.ibm.com, rostedt@goodmis.org, maddy@linux.ibm.com,
	srikar@linux.ibm.com, hdanton@sina.com, chleroy@kernel.org,
	vineeth@bitbyteword.org, frederic@kernel.org, arighi@nvidia.com,
	pauld@redhat.com, christian.loehle@arm.com, tj@kernel.org,
	tommaso.cucinotta@gmail.com, maz@kernel.org, rafael@kernel.org,
	rdunlap@infradead.org, kernellwp@gmail.com,
	linux-doc@vger.kernel.org, jgross@suse.com,
	virtualization@lists.linux.dev, sunlightlinux@gmail.com
Subject: Re: [PATCH v11 05/12] sched/core: Try to use a preferred CPU in
 is_cpu_allowed
Message-ID: <apMziCV_8y0xeIBT@yury>
References: <20260825103855.721013-1-sshegde@linux.ibm.com>
 <20260825103855.721013-6-sshegde@linux.ibm.com>
 <8262d2f9-9f2f-4821-8497-991d7c8448a3@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8262d2f9-9f2f-4821-8497-991d7c8448a3@arm.com>
X-ClientProxiedBy: CH2PR17CA0002.namprd17.prod.outlook.com
 (2603:10b6:610:53::12) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|PH8PR12MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eb6f29f-c47f-4dab-f155-08df06041f68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|23010399003|7416014|376014|22082099003|18002099003|56012099006|3023799007|6133799003|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	hw6B25FEmAQV6vdP8Iqsp+jwOCqPjjDHLziqjEV74ZIoD3NuRkQy9ty6RbyRm4Xm5VZoVmnkSrHen5B7pAbFRa/UCthQL/Nk0Lon3a6VXjbVR3dR+O2QI5P8XKt/hfu7uv9a63UTWxFm3tpAGWAxZ2T1+jk6+Z5IVpIaWM7BeNQYtP5QkQk7eH744YBGHB3qQdaCZ2UUgvYSai2ZU73acj7gIVMzlro2Qs0PKXXFgJYWj2aI0p0HTO5VS04B2bXV3HiR3Aza/oyvdPZN6smfr8SBYiFNQpTVVob4gjaGkGpsXu5kKRk8xvR+9fIdOAUg3PuwdcSkQfqYjlUIWUDhNjTMLTRLKHF7N9gVb/8meEwG54OJe0qNksbgDaSd8TjnMC1x9Wh9ePZynFDFN9GS7WEYa8mYho7YVdXtmuW2V0LgXvezmmF50CuuDH7tLSdIC8EoP4CwxbngYrrAzvr3lH/g1pPrXoMh7fqfObC1INpyNmNJ40RBB45oIIpeAnOWx307yqqDdB2osjMAkwkxoFQryoGZELbAwDgdlXvGLFG3FotX70AKTepBXSgFe1K6hoY0rKHAuqlGnfI/fFFz0MrCGQHlID1/CDErJ++OFa0ivx5JDlXKNz5+GGZsnNM4/C/g5KlW5ivd/qeqd2EWEZsgWPqOf+kNQ/sf1ofkwWk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(23010399003)(7416014)(376014)(22082099003)(18002099003)(56012099006)(3023799007)(6133799003)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vLcBhEff6pYXb/Wi1SUyEQ73pS8w2UJn5ZnN55B5enOoEp+buhlNn1PIG34H?=
 =?us-ascii?Q?C/DP27UGqM8vVmHg9eaHi0kOaKb7PPTbxw7BdZkhv9jtg2ltnBCaor+WN0lz?=
 =?us-ascii?Q?F5AF2KFE1SEG+svFCZ9UPTRwH8QF427XZQOAMno0BoHI08eb1kphhZC8ZiNW?=
 =?us-ascii?Q?SgrHKs+MuLrP58qdo+2avpWqAmnY2Ov4WzYEnwRaTmm+iPGIaJDmA8nKiSUH?=
 =?us-ascii?Q?1hxHbgLxmyFkt1zm17A5ZV0S3I/q4rtX4rwbH4EC7QY77qUuYML3GHuxAdU7?=
 =?us-ascii?Q?SsDPAxnqT+qFCDbwCkD8RMaqWKhP/wLPN1Ne/7vuHcC0rCzAeLPYtyl4yCgR?=
 =?us-ascii?Q?I4Gd/anFVDZgGK7aSESVXKmprM14mS19yQim4HkkvEgOm7Xh1ZOyx8bNKs5U?=
 =?us-ascii?Q?62Az+PkphypPi2Xn/1029emQ8bGNwD9yPR8mNC5sWtWCnYuD3L0Xsffalbk7?=
 =?us-ascii?Q?0c8FziT74+phbz6I4ybdu21gAQGt1luIb/Ii4QaF/Xc8iWmI+tdNFiVhWtSb?=
 =?us-ascii?Q?cfvm+iOdvAYQ2jypiPkmSgCJ/g9x+hksqUxv+DCd+mTmPl025dQhT7rjT68h?=
 =?us-ascii?Q?cF/nltj6MdVOz+Y6rr3QW6DJtsd9aEO0H+bZvTNRpxlSyZk6v3cfUAQGDuor?=
 =?us-ascii?Q?FmuqNsrkaHquVZRofUmD70Yvh5DEWKFTdpA5WuzE9CVp2Qp2RZgGZKjkVDKG?=
 =?us-ascii?Q?m6dFLjJZIbQbIxEC6KXOqANawyq9xWUS+k3ZJnxg3WWt70hFvUYRGz1SFkfK?=
 =?us-ascii?Q?YE7zOK9g6LSeC6jA4/6DXcf8DnHy/R+cY2dxL/ZqacEa7J9AcRK1MUoeMk0E?=
 =?us-ascii?Q?50PWKli8MByEaBN8hwYlIS6AWlnDsCwFTIUprhcacQZ2+IAAvY8SmDudwn9s?=
 =?us-ascii?Q?i+5z1MifMg/sdFYCewHxDOtBhY6p5J8j2gW5S+vUVLasWqkP5qRKz5Vf/fNP?=
 =?us-ascii?Q?npcFKZ40dMGSSIxtMOLuR42OSF/iPQ9g8t1hn/ApeyMNKPwdLiv3612c2UQS?=
 =?us-ascii?Q?YmWZahlXnSLitz59otzOMSMkOOR03spdFpDB1ZOQ1Kc7wTv00m9PNZhHyI2V?=
 =?us-ascii?Q?Vwho5M0coCOlxt+DBdZcJkkPRgnDmAWJ/aNdVVR8njvrTyvzL0LAFySNjkml?=
 =?us-ascii?Q?LAyzuNchCi87TZ0OI6kn9wJ8Ln3Ni2CquLe405QmEFIhqpcrLgvKPaD9GLTR?=
 =?us-ascii?Q?GPMV2czR4yJSLiHwXVZV/Ahx6R0hvOuPOw12VwuH7jTPBVwfUAMmgHsEmSzE?=
 =?us-ascii?Q?39k+P4gJyoTK5Oc+roYgDVzAZT8gIZL0nf4a18R2ZxfoM2u6oiWUweeyhDGx?=
 =?us-ascii?Q?RXayTo6b4V1uOBV686jNLpxmqovCTmvEfoOVviz9HxcHhKF4w5PIShoIN+Rk?=
 =?us-ascii?Q?GxjYOpH5bq1suSJzIKfSxLHV1wx0KsrecSxDAG9SBBoFHBpLbzhoyMvJ1b5B?=
 =?us-ascii?Q?yT1PRbLF4gGTJYmX0ELFH6Dran5io92QKgQVl+byQ845nhg10qrABrxy7NyL?=
 =?us-ascii?Q?aL+01U4+n+TXZ/8PS3CX92bePrVjjodvws3VKudat7hxmftCJem78qAtCiGv?=
 =?us-ascii?Q?d59Ff1WKGBU2E7Gn4DlKwzFv2aSfUxhMCwA9XEndBbyWI0ZMS84cIc6hCdeN?=
 =?us-ascii?Q?s2Pu2CZrAwvz7VkYoM4u/gD7Y+CBdmBgpeHbw8xFK9ET5gkX0MXr1N2Vs829?=
 =?us-ascii?Q?KjlVXq8vxpIw2uaLWvpxLzATjVNzmKME6bZwAgw2LExI3b5rcp9zxwxxArfU?=
 =?us-ascii?Q?Ge1SSBzn5sTyYf2xNc31KTxDsd1UpaCawijTXDsvKlQ/9rK4h3yF5du7tsLK?=
X-MS-Exchange-AntiSpam-MessageData-1: Ya21VvbpkNLMjQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb6f29f-c47f-4dab-f155-08df06041f68
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 19:31:28.7827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N31MxN2ACs/jYbgA4R/7EDFBHUeLz4NWFxCYfolenssFTgTT9kt0Y+xNhNGIRb+GMN/DN6gbUmozYQeOZg00fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7133

On Fri, Aug 28, 2026 at 09:51:47AM +0200, Dietmar Eggemann wrote:
> On 25.08.26 12:38, Shrikanth Hegde wrote:
> > When possible, try to choose a preferred CPU.
> > 
> > This is essential to maintain user affinities when preferred
> > CPUs change. A task pinned on a non-preferred CPU should continue
> > to run there, since this is a non-user triggered event.
> > 
> > If a CPU is non-preferred and the task can run on other CPUs which are
> > currently preferred, then choose a preferred CPU instead.
> > This is decided by checking if cpus_ptr and cpu_preferred_mask
> > intersect or not. If yes, then the task has other preferred CPUs.
> > 
> > The push task mechanism uses a stopper thread which calls
> > select_fallback_rq() and uses this mechanism to pick a preferred CPU.
> > 
> > This takes care of the wakeup path for FAIR tasks too.
> > is_cpu_allowed() is called to ensure wakeups happen on preferred CPUs.
> > With that, additional checks in available_idle_cpu() are not necessary.
> > 
> > Ignore the preferred CPU state if a task's affinity is changing and
> > its new mask no longer includes the CPU it is currently running on.
> > This ensures migration_cpu_stop() does not abort, preventing the task
> > from being stranded outside its allowed affinity.
> > 
> > Account for tasks with architecture-specific CPU masks
> > (e.g., 32-bit tasks on arm64). For such tasks, explicitly check against
> > the arch-allowed CPUs to determine if any of the preferred CPUs are
> > actually valid.
> > 
> > For the majority of cases, this would still keep select_fallback_rq()
> > as O(N). cpumask_intersects(), which is O(N), is called only if
> > !cpu_preferred. The task running there is expected to move out.
> > Subsequently, it should run on a preferred CPU. This becomes O(N**2)
> > only for tasks pinned solely to non-preferred CPUs. That is a rare case.
> > 
> > Overhead is minimal when the CPU is preferred.
> > 
> > Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> > ---
> >  kernel/sched/core.c | 41 +++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 39 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index a45f7c308329..f71317fe281d 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -2494,6 +2494,35 @@ static inline bool rq_has_pinned_tasks(struct rq *rq)
> >  	return rq->nr_pinned;
> >  }
> >  
> > +static inline bool task_can_sched_on_preferred(int cpu, struct task_struct *p)
> > +{
> > +	const struct cpumask *valid_mask;
> > +	int i;
> > +
> > +	if (cpu_preferred(cpu))
> > +		return false;
> > +
> > +	/* Only FAIR tasks honor preferred CPU state */
> > +	if (unlikely(p->sched_class != &fair_sched_class))
> > +		return false;
> > +
> > +	/* Ignore preferred state if task affinity is changing */
> > +	if (unlikely(!cpumask_test_cpu(task_cpu(p), p->cpus_ptr)))
> > +		return false;
> > +
> > +	valid_mask = task_cpu_possible_mask(p);
> > +	if (likely(valid_mask == cpu_possible_mask))
> > +		return cpumask_intersects(p->cpus_ptr, cpu_preferred_mask);
> > +
> > +	/* Tasks with arch-specific CPU masks. e.g. 32-bit tasks on arm64. */
> > +	for_each_cpu_and(i, p->cpus_ptr, cpu_preferred_mask) {
> > +		if (cpumask_test_cpu(i, valid_mask))
> > +			return true;
> > +	}
> 
> Looking more into this, there might be a window in 64-32-bit execve()
> for 32bit EL0 tasks on Arm64 (w/ allow_mismatched_32bit_el0 command line
> option).
> 
> The time before arch_setup_new_exec() calls
> force_compatible_cpus_allowed_ptr() to restrict CPU affinity for those
> tasks.
> 
> Let me run more test on this ...
> 
> Why not simply:
> 
> - return cpumask_intersects(p->cpus_ptr, cpu_preferred_mask);
> + return cpumask_first_and_and(p->cpus_ptr, cpu_preferred_mask,
> +                              task_cpu_possible_mask(p)) < nr_cpu_ids;
> 
> IMHO, you want to know whether there is at least one CPU that belongs to
> all three CPU masks?
 
Yeah, the cpumask_first_and_and() would replace the for-loop more
effectively, but I'd suggest introducing the new helper:


        return cpumask_intersects_and(p->cpus_ptr, cpu_preferred_mask,
                                      task_cpu_possible_mask(p));

This would also highlight the intention better - we're looking for
intersection, and call the 'intersects' function.

I don't like how this patch plays with likely() macro.
Possible == task_possible condition is surely likely for x86, but is
always unlikely for aarch64/el0-32 tasks. This would lead to suboptimal 
code generation on aarch64.

The approach I've suggested also worsen performance because of a
possibly unnecessary traversing of the cpu_possible_mask.

If task_can_sched_on_preferred() is really a performance critical piece
of code, we can invent arch_task_can_sched_on_preferred() to avoid it.

--

On general side, the governor is really tested in 2 configurations:
PPC+powervm and x86+kvm; and there's clearly an interest from XEN and
ARM engineers.

Maybe, to stay on safe side, we'd enable the feature where it's actually
tested? I suggested it when DOM0 case was revealed, and now we've got
the 2nd corner case from arm64 compat tasks.

The advantages of this approach are:

 - faster adoption of the existing code for the tested architectures;
 - delegate arch/vm support to the domain professionals;
 - delay arch/vm support decisions to the later phase of adoption, when
   the API is better stabilized.

Thanks,
Yury
