Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011023.outbound.protection.outlook.com [52.101.62.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E20F3793B4
	for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 21:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784929543; cv=fail; b=eVzR57P54tEKh+4ezDc2PMdmRMyJJa6A++b/l67P6ytUxjkzJE+7YOXe+fvy6joB1z3KVIqlBmHph9fe39StQK3DmLymMxa9Ka5zAfWg/JzmMLEt44sZl6Ym2GA3p6ZFjIy99g0/2XKSskQxSb2dp/ZABVjIV07AHq8RRfvLnNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784929543; c=relaxed/simple;
	bh=e4AeUWjyRlyfm8HnPxAjAQQEOqMxw6Qqe9YM6a2oFn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XXJD6KpdMcmREbK01agsdn4/ZLZU8kGK1QPCffy+vum1aVC4xXz7/bfhwZoYmL/KaynR6Rbc7Rsdzo2q/9qwlNtIl8VE1+dIF3Ss/W0ng8ZIQRsagLcXBRADagWpDXJuJIPk6RFhKgfoIUHGY9qfcTGNONiMeHXEKbWVe4xiAc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eihF4K4k; arc=fail smtp.client-ip=52.101.62.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eihF4K4k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NvBHt+GOu0+G2KcfKUniBbGK/MnAZ6i2hMWL81sIGrdEV7Nl8dJ0CaTxhKQS0E+7LGChegGauW3NE/9L+nNWVdxmgVARZ48SARPExuDZ8X/qY/Ve1tCzo8YzTBXHSjW5XzIN+r4E7D044TXHRwa55dnt11dH2TPW5l/AqZy6z9zxfT4kB+B0/8CKh1MIkaLVaXH1SpWnujzBureMStwAL7uJ86RMBHYJDM7qIj4Uxe4in8doVonU9zAonQr8Ab3y7eccmfkZ3rcTnlLlthuwbrYFYyDiuFZNRSsiAC2ANn8+g5tcYhNa/N+E3SF7udxmUrlkLm/siRmX1xM36WviOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYvchLGf8u8TS9C/pnOuxOCAebfovtez51IcAyi0yY4=;
 b=W7/lrypktyxNbqiiAV4kDVQ7Qd2pNfdY1m1X7pyxkWSknHjI1K6sfVPStZvYBTbYvQbJXgtmeyQf7onPhWq1xzy2TCS4YbSudEipUBiK1jvrAq6Zhmn6eNZEYelp3z5RJ0khm0BirjOeT+P+U2driZ1MVeqMd+2psJ+HQLBuvRgTGWN/bd4gUJ272tsxloEiKxvwAzgFcMp72KHB4XH88TQ3loN+gwVC+k7OFC+Q3bnQEzgK5/Kyjb0ffrdfTvC7b/8Lcau5rMJss/6kPAR3TYtcTEz9l6QgCXkXi1CqgaIK1A7Kb7WGGbXKIhHhvAI/mTwKQyQmkEeVdVbXvhZmXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYvchLGf8u8TS9C/pnOuxOCAebfovtez51IcAyi0yY4=;
 b=eihF4K4kqm/xRACMpamh37K/MnDMqobDwX5tmhqjsUAv+qVgT2hZVZczPiRmZKGU3NpQbGs1leS3SVVyHEBFSugDi+fNv6gicpctmV10OXwMBCshIVeYtWhWmxr/Q3Gp1M6pKJlz/P/TjKCW24U2aAf4X7PvWHOsaemP0VBKCD8vayf+Oy0v5BYL0OfkqdF/RlQu/VdDapaggYCCQ3/WSGN0F59u22BvX1SxnbLRIuc10+qu9drwOaU9qqBYqONrJyp/nfeBe8FDOiUyQkhWNXvxFzwKDymTtrE78WvwT2ELZexqJ6oRyn+PSTMMD5a3L0faietsA/BGBCUPeX2HXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SN7PR12MB8436.namprd12.prod.outlook.com (2603:10b6:806:2e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 21:45:35 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 21:45:34 +0000
Date: Fri, 24 Jul 2026 17:45:32 -0400
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
	virtualization@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v9 01/11] sched/docs: Document cpu_preferred_mask and
 Preferred CPU concept
Message-ID: <amPc_DXDkeVawXS7@yury>
References: <20260724140732.2683314-1-sshegde@linux.ibm.com>
 <20260724140732.2683314-2-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724140732.2683314-2-sshegde@linux.ibm.com>
X-ClientProxiedBy: SJ0PR03CA0197.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::22) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|SN7PR12MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e403be0-c2cf-4e67-ad59-08dee9cce45f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|6133799003|11063799006|56012099006|10067099003|5023799004|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WUwbmsekEsif5GbyQjYELOT7KR6DS6E9MVsHlfoIK/7LNZ5F9r+yDDenahLzIQHGVhLUnaV5iw0mTRy97pgQK5Ijw+U0YvxXesKQLP8xfNkfCXX1KTorCXnhV1aiBiRLoBOe+9Wtx8x2OLYHy3Cf3y5WMXhuRY99dTMB9lqsA8cCwVyVI4XC42bnY3rEkZ9sKc6Y4m/b5dPR1C59YdZoOKwtAPO1NLkGFOCaS7tHu42oN23LoIfHJPNY9GcwI+k/ItxK5jlNXqQoCxEz7B6mt7k6d10QDzO5kx33O+tnZweQv+u2lSNsIjHkLaiNHnmWtIwvVn/c65OLkkNln/5J/S2bRhpgAkdUE8cakdWyQ2K3BnSsiVoRwGuT+7y6B2fquTlQGit5MgkxVY5j1m3yxZbQXn7kkd6S3jrsEuSBLCDhP0h1+z57LA0Z3toJx1R+I6vm6SHLJVrYUMEEzgNeMkqU2J7Svb+qOPB7l5gtP7NMFoPJwmTLgkddPDlBA0BelEO1jrjMAK82M68MHljFnrzAMsPTmupxkhpjnBaRoflV+nbZLVdLQ6sbsLkxElwfRJ18NV0+9UQ3MCUu4NP7E2D79fm/XGukzG97N5evzskruYZDhABGjX/DtrKl5PRlZb80Dpsvst8kQW9i8ptzDnFytWZBUcqKTZ5mP4osmbg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(11063799006)(56012099006)(10067099003)(5023799004)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BUZs4reSM0GcXR7lkYxeli5RXT+5KfHw+vpYlyuMP7iCG2+Re0soO2hd/Of+?=
 =?us-ascii?Q?Tc2xtIvJ3VDQbFlrO9lVdIxvO2h2JIDlD2hNtVWRUE05HHysI1yyn6edXFCn?=
 =?us-ascii?Q?WaSaY1KmWOxOMtYfll42cpQ0CljJgb5IFZfC2HSkrve2kppTipfmkgY4wlln?=
 =?us-ascii?Q?DI13BZbvBaiFE/F6CX1kGPdqRLZRtC+UXSKZtN09abEEcupFx19YpvHl7e8h?=
 =?us-ascii?Q?Xai1C8YOw6Ht6ljJtuexgqDNYo8vfquUhYdXhoMEA9CAO+PlmxgdMakNvYre?=
 =?us-ascii?Q?8X+FJkIdhwtG4d0ekkUF5FGEw7pKNq0xSQPhKcSsafKAOOs4RPO/xyUFjQhR?=
 =?us-ascii?Q?ZtTDkGt+e6oDeAFTGSyxUn5rO8CCIcHmBKafvfGbAhzdO5FasUaMeo+5vIuq?=
 =?us-ascii?Q?bihEcBlzWwoRgd4igVlvbcIHoPKV3loAQn4dx/CbAHKXNv0He/ukUeNb407B?=
 =?us-ascii?Q?x/qRvuJjVq0ry2xK0R/t9I+sTkQYexfCOHIOLA5twSgCa3l1Aalu51Rk3+Dh?=
 =?us-ascii?Q?/iMrxuPY4fpHCV94L4qRLjJOc7RAsMShK5Jt3OaN7nbna388e69A/kOnuhOQ?=
 =?us-ascii?Q?2M0BE/7OAO0L8Qp/rC/HxIT7pvU4Lg7S+MxQlCqc5OD9H7l7d2rqfGi8zjr6?=
 =?us-ascii?Q?xOQnX+EmEtUgfUEW94P2tTxfln4pP3pabbmXw+wSdf3+0JwdOPHeQuNF1btV?=
 =?us-ascii?Q?6t4BC53QWZqzigAUl6z+lfCk9o+5WDdNeFeHiCF3++jHDWXvUul5bD2s/Ot3?=
 =?us-ascii?Q?SR9rlKLQjDDMhk51y71ZJ5qimIIPPzNi8KTILjPmdzkkG9LMJDgQ9Xcfz4uD?=
 =?us-ascii?Q?k5gIwTgFgBZwVpcD0OITlpzotI3Bffvyj9BRMvQ2kmEubCHoRMMko3y7n7Ac?=
 =?us-ascii?Q?brv9GEYsq+ZbD7DZRoCiDymmqKbcrYJ7dDDTZwVh3UD4ijk7xRRt3ynxd5l/?=
 =?us-ascii?Q?SL3dGr3wIomjGHS0kVjY9rPsOx69BAgjjRdfn/DMjtF1c9yWw2fs1UreXgM4?=
 =?us-ascii?Q?dcKRgK+oGpYoOBwIXvcBPP7acoJQCFTL5lLHpaqfls4yIrYY4Z/CoZeM2uhS?=
 =?us-ascii?Q?DwwYDS66fFFSX2A6EEA5smwl2bGJjcx1EnVpU1ndEHejynlNPD3R+Cr7gJFv?=
 =?us-ascii?Q?B/5wvCKOIf1L2dSWRJnKBIaBYBr4iQluY6YvcKESA6fdimnu90s6r959aSRc?=
 =?us-ascii?Q?r32ZEZ/lYWlnxY0ayudkmmZYPKfGb66oQQr1+Z+qpHEleuSvR8Dfk1kJIw1q?=
 =?us-ascii?Q?bur8P5xLOlkJ4OcHChvaVpwEZNrhM/illzb/IP3cNqsn8DKQKZjJkF/52uGO?=
 =?us-ascii?Q?cWoL3dI9uod//H5qfQEsZh7EGZMPrc5M0S+8DvF2v5uzNdgW2ul8gG35N9fm?=
 =?us-ascii?Q?HWDtjdjWdd3ufiK6LvJJqFfeWVZ8hnAL0hgHEglAxSbv8YhjDGqjB592v6mN?=
 =?us-ascii?Q?x2UPUjVBpHLa2O0iEjpyjA03a+YU+hvKnOIbjlp/6S+oa8Uw9Huagmlum3GI?=
 =?us-ascii?Q?gmYd90f1vH+F5lHeT00fAmj6+5ct8anRSjXutBHn0E/neC9fEs0MRkG9CyQM?=
 =?us-ascii?Q?flRZYSw5FyfNZct4JGzSwn5/4pST+vxDAnrkYMeOji3xgmdMES4iIdPwK3OQ?=
 =?us-ascii?Q?O7Wcg6J+vjeXCWox8HDON5J7V5yxpLUu1hoqWSFyfENoVRMUwYqFEpYuUY5d?=
 =?us-ascii?Q?i0et+QxRSBrkVMFJN3vVPS43vxN4Ij61t+lOPcnPLfGa8nm+AfCPuqfeWBcf?=
 =?us-ascii?Q?2wAaJKUvXg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e403be0-c2cf-4e67-ad59-08dee9cce45f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 21:45:34.8657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QND2HHU8WzZ/gX0ZPLClkaeV3BPMs8U4JB4tS8MYiYhtQ6VW7SD9ECSOnrZzhTLyFNSnQ12O68JQrlr/zE4WAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8436

On Fri, Jul 24, 2026 at 07:37:22PM +0530, Shrikanth Hegde wrote:
> Add documentation for new cpumask called cpu_preferred_mask. This could
> help users in understanding what this mask is and the concept behind it.
> 
> Document how to enable it and implementation aspects of it.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202606180717.yNM0yb41-lkp@intel.com/
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  Documentation/scheduler/sched-arch.rst | 58 ++++++++++++++++++++++++++

And there's really nothing arch-specific in your series. Can you find
a better place for the docs?

>  1 file changed, 58 insertions(+)
> 
> diff --git a/Documentation/scheduler/sched-arch.rst b/Documentation/scheduler/sched-arch.rst
> index ed07efea7d02..0a0a8eadbfd6 100644
> --- a/Documentation/scheduler/sched-arch.rst
> +++ b/Documentation/scheduler/sched-arch.rst
> @@ -62,6 +62,64 @@ Your cpu_idle routines need to obey the following rules:
>  arch/x86/kernel/process.c has examples of both polling and
>  sleeping idle functions.
>  
> +Preferred CPUs
> +==============
> +
> +In virtualised environments it is possible to overcommit CPU resources. i.e.
> +the sum of virtual CPUs (vCPUs) of all VMs is greater than number of physical
> +CPUs (pCPUs). Under such conditions when all or many VMs have high utilization,
> +hypervisor won't be able to satisfy the CPU requirement and has to context
> +switch within or across VMs. The hypervisor needs to preempt one vCPU to run
> +another. This is called vCPU preemption. This is more expensive compared to
> +task context switch within a vCPU.
> +
> +In such cases it is better that combined vCPU ask from all VMs is reduced
> +by not using some of the vCPUs in each VM. vCPUs where workload can be safely
> +scheduled which won't increase any contention for pCPU are called as
> +"Preferred CPUs".
> +
> +Main design construct is preferred CPUs are always a subset of active CPUs.
> +In most cases preferred CPUs will be same as active CPUs, when there is pCPU
> +contention, Preferred CPUs will reduce based on the amount of steal time.
> +When the pCPU contention goes away as indicated by steal time, Preferred CPUs
> +will become same as active CPUs again. These policy decisions are taken by
> +steal_governor driver available at drivers/virt/steal_governor.c
> +
> +Scheduling decisions such as wakeup, pushing the task etc, need this
> +CPU state info. This is maintained in cpu_preferred_mask.
> +vCPUs which are not in cpu_preferred_mask should be treated as vCPUs which
> +should not be used at this moment provided it doesn't break user affinity.
> +
> +This is achieved by:
> +
> +1. Selecting a preferred CPU at wakeup using fallback mechanism.
> +2. Push the task away from non-preferred CPU at tick.
> +3. Only select preferred CPUs for load balance.
> +
> +/sys/devices/system/cpu/preferred prints the current cpu_preferred_mask in
> +cpulist format.
> +
> +Notes:
> +
> +1. This feature is available under CONFIG_PREFERRED_CPU. It is selected
> +   by steal_governor driver (CONFIG_STEAL_GOVERNOR). On enabling the
> +   driver, CPU preferred state can change based on steal time. Without that
> +   driver, preferred CPUs is same as active CPUs.
> +
> +2. This feature works for FAIR class only.
> +
> +3. A task pinned, which can't be moved to preferred CPUs will continue
> +   to run based on its affinity. But no load balancing happens.
> +
> +4. Decision to change the preferred CPU state is driven by kernel.
> +   Hence it shouldn't break user affinities. One of the main reasons why
> +   CPU hotplug or Isolated cpuset partitions was not a solution.
> +
> +5. This feature works best only when all the VMs enable the feature as
> +   it is a co-operative scheme. If a specific VM doesn't enable this feature
> +   it may end up with more CPUs than others, still should lead to better
> +   performance when seen from system view.
> +   Users who enable this driver must ensure it is enabled in all VMs.
>  
>  Possible arch/ problems
>  =======================
> -- 
> 2.47.3
