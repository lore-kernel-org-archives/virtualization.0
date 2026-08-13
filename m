Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EF915665C
	for <virtualization@lists.linux.dev>; Thu, 13 Aug 2026 00:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786580032; cv=fail; b=sYWSpBk5TZM81AsOi/zTKxTOHNSqqpn/uomDdnIwulF82eGhIe/1d0QOBl1AIZ1VKd8bzjiDbZItaj5klT4Jbvp62WcEucStRA/XA3+yjAKhzGTXIiFEZCgJ+rWlx1nmTnF0c9qZjh82+IIH8cXMul/fvJfIguEKMwieCwzBWRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786580032; c=relaxed/simple;
	bh=tZE/OqYl9Tlsp7DDfMnj84mI4WxTF6FR6TdNQpeGIi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mtl2knZn7tpExsICTSwCeU6axOiL+RZOKf1MoyW50zOnJuVtf1VojBL7QK0F3jef9rabp77mBeykvwTghiPxWYGrrBmeXG+20rTy8gIu8zwmLi+AVoEHmgRzFIrHBz0OMPAEFi9duk0duQlq3QXDxn9Ti2Lp3kfJ9ZUKMemzLSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Oy2ks57Y; arc=fail smtp.client-ip=52.101.62.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Oy2ks57Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=asdhS7xeeYA5M2p+nRxYBlGfylwjZ9gbz8CkwLFAemg/tyLiHa/gsglYa/0lEfhDfyoIA2zxy0nHJRE9o3z99Dkb1fBrzS0TcsWvNmjy0BAJzXnB/BeKIMYPh5hDJxMIpkZf/905TvXyP9on7z2TWqvocHL8rxTJ1SkP8DV17o/PDYRaHDI3wRsPBTZ5u8jRKAG/HE1l46rH5NxD+bkwYPV/WfUSnceBSZYuFRb/nk0/YxpdqUVGLDnFSz76qJFFqFYkpW+O6XoFQHjzyVGowgz/6nMsPakrVqYezGuVv3ks6D28cZFx94y7xXB8comiTuXkQLOc/j98Vt86W8Gy+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45VFOtbT8QSLz5SsuRuEOERMt0/QTaEljr+9NLwNUcI=;
 b=YgpfmPDDLm0hrVUfXRoydgqL8McESFnwI4we2i8Aoa3EoRu2xz3/jI/lQ3HBxSQMUHpG4YvBSdxfEvJovYB3BOhYGDBjrZMIuTAjiUp046VoZIa2Y+KUDn/JeADKatuIx9fbQ3OMvF5TYieCMGIRxsm6lEQuzi9FfLbJsKBFGj+VOGCKHU1xc6kAvSbuCdfKTgLe+DtylJf4Z5FT7REU9PQD1Zk/SbNb+inqzyPgekk4q7016yTdM/HjVLU0xPvPv6LDMhWIDyd1zTy1Y60/h38WqqsZFhV4M/FlA0w5ljnn4O0mMbtE30Okj0ncripyC5A/YboHx1XATIOJtFJQpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45VFOtbT8QSLz5SsuRuEOERMt0/QTaEljr+9NLwNUcI=;
 b=Oy2ks57YlgX2Fjas6lFjtWVN8lObvhE4I/LEc3Npldyc1OUMA8p+8L669h1Uf2upFTcat1XT3JZ3Q+HCUazYEsDm0r3erPP86wN3gbQWRz5d6OWqgJLe/Eo1slqErlakALCr4w5YpGGdYrEkSnQqBk2C6tTJb5tovrRlq9ZpQNDy7UVtDjSfZwyPYHPfJ6L8ws6gnGon0n1a/bD0JqyM4E1mKkuB8cQMsnvmkyDBB+IXXQZWT8IADoXnYmMLm7UZZIEAHv2L/JQDVRHQtRB+AlWflOfUiVfLFev2Nz9lPTEHhVm4kXtUblkGNzkNacihLlTTWSbZj7KpV/ybvZir/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by CH2PR12MB9459.namprd12.prod.outlook.com (2603:10b6:610:27d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Thu, 13 Aug
 2026 00:13:40 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0315.012; Thu, 13 Aug 2026
 00:13:40 +0000
Date: Wed, 12 Aug 2026 20:13:36 -0400
From: Yury Norov <ynorov@nvidia.com>
To: "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, arighi@nvidia.com,
	chleroy@kernel.org, christian.loehle@arm.com, corbet@lwn.net,
	dietmar.eggemann@arm.com, frederic@kernel.org,
	gregkh@linuxfoundation.org, hdanton@sina.com, huschle@linux.ibm.com,
	iii@linux.ibm.com, jgross@suse.com, juri.lelli@redhat.com,
	kernellwp@gmail.com, kprateek.nayak@amd.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	maddy@linux.ibm.com, maz@kernel.org, meted@linux.ibm.com,
	mingo@kernel.org, pauld@redhat.com, pbonzini@redhat.com,
	peterz@infradead.org, rafael@kernel.org, rdunlap@infradead.org,
	rostedt@goodmis.org, seanjc@google.com, srikar@linux.ibm.com,
	tglx@kernel.org, tj@kernel.org, tommaso.cucinotta@gmail.com,
	vincent.guittot@linaro.org, vineeth@bitbyteword.org,
	virtualization@lists.linux.dev, vschneid@redhat.com,
	yury.norov@gmail.com
Subject: Re: [PATCH] Re: [PATCH v10 00/12] sched, steal_governor: Introduce
 preferred CPUs and steal-driven vCPU backoff
Message-ID: <an0MMNBkyeeZEa8f@yury>
References: <20260812054033.95658-1-sshegde@linux.ibm.com>
 <20260812194600.52516-1-sunlightlinux@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812194600.52516-1-sunlightlinux@gmail.com>
X-ClientProxiedBy: BY3PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::32) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|CH2PR12MB9459:EE_
X-MS-Office365-Filtering-Correlation-Id: ab1b12f5-e101-4d9a-a0ea-08def8cfb9e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|56012099006|5023799004|4143699003|10067099003|11063799006|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Zpr0F+prW9qTDv4o+0CTkbYnTOJ6cVfL/WxOw88R1hv9E/V2OkkSJHJZOmk2h26wsNbv9As9KiyU2h7tG9+fVXPm4hyDXYgclHyxr8vNqJamPtnRfa5O2vYctrN7T/Wu2PKZMQjNhmknfmN9eYngyrPc4j+dPb2KAPMXVY3NYuIMAdaOCLpx5ykg/5ewvvrTLnupY6sxPQjgwpcfy1kCX9L3s8F2FwRed6KYfokOITxdBn4ogrBbJLi5fB6QHpys8JQGb11N3hmR4etww0PuHZdTQZzlvf5zbbZGL7z4mW/I8RrUbvlI4EariPjE+PfuYbCmjAHSFj4RnzxIjJXvx7TudvdyQO1mo+Sa1W0RAcuKlQeoc5VZT5HqRnhb0DCEdm+koizxInkavD6kMQsYq29Amfp97hA4n5kRTsUzPUKJvZJGKQ1WH6rW5aTY6O6Cik611WoTumiXmBuHKmAUOUbRCWRE7nYBUvLh8mCC7h/RoekS6AQK/1AFksknbwQJN/YpDRQwBUWRMc9gYXdpTBSWIg5UDiqssE61O/d9GtD1HzML4md0lwNFIOdu8Zqr2Zeh4zff5r3d/op6ErH+0OqPA+rt5/bBddEdCjKo/yhDlgjyG6X/TPwnMrxn1V5sFpHPRwBuM/4QTDDAXgEWOMAhZtYK8EXQgDRNbqiXvCY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(56012099006)(5023799004)(4143699003)(10067099003)(11063799006)(6133799003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oW3vpSxqx62gsgguVsozMbcrL2e2ZlNojS4/VaBQk3VcaDLfLrC8zx6NwbPS?=
 =?us-ascii?Q?vkJyjeZabHWekKpI+jkn890x1fxkiUESqKbVCI9Yqs+aqo/63q8sSXgbwXzA?=
 =?us-ascii?Q?SNDcuU37oMeINawlXfPXfXkN4H5//iFbpISwo0xhuGHAdddX0Y17RIhdcyw8?=
 =?us-ascii?Q?8/Ic8mG/t5J1Qdl3v0SUFHWYZ8VleAuvEyX94Vs+92vzNdSFSo8XKZs983GA?=
 =?us-ascii?Q?MLiXUgTlaBnODSbSQTv7XXPhVn0MM7R7h+LaGxGJGKXjs/zCrnGlVfTNACXx?=
 =?us-ascii?Q?yduNk4oupz0Q9Wh6Ek+lFdsuGee2e4r8i3lNItGJ9P/781u73NV/GGFAVBbe?=
 =?us-ascii?Q?qOtOCwg1ue/cSJYzSkuRaIFS3dY+5MLbo6qofxzH4IdsxxEEb8LXZm/WV+hq?=
 =?us-ascii?Q?lOh4VZ/x8qnKlPYkHo0IC66NvY7vnz7r/1mmOxXD3T2kwpiUBa1OZRMEH9KS?=
 =?us-ascii?Q?gof68iNuIfX00vOnVz0rrJVPAkLemzaQHqqIeskZhoeAKZsCKBFq1q+d3AkU?=
 =?us-ascii?Q?f9UsKlxSlNwIiDiVLXqoiNCVJYuulnkyL+P0srlTOOGkGOV9rYD+8pFKnSI7?=
 =?us-ascii?Q?keETtMlqXUBsyGFdZVBRCZ4GkDY3vtIbay+IL4WGXvmJJ0piu6A599gj5ck4?=
 =?us-ascii?Q?YsfFjBGFq+QDiDLes+WSdMSUK+uWX9Btz6sXuDDgCUAfIlhzf63PWyWKVXgD?=
 =?us-ascii?Q?Cda2szCNzilQdTJr3eLRlcJdEcq9YVIb4/VUhlLJzxaDATGY3jtAHOkxX39o?=
 =?us-ascii?Q?hVt6B9gRYh2oXX3uU8VtPOw81kETryCFB9suzoWowwkxnongLw4RCf5M5mHY?=
 =?us-ascii?Q?dPGgTBfX0N7B4F30kGION9Tbyi1E8c/kODJ12b+xX5VE2/y+KnGn6AL5RuJ2?=
 =?us-ascii?Q?FXSB6aUwFj2TfMtp0H8MOktf70eb4vnMdMwbSKJ1+KfaPpfodl7BRSU5se/6?=
 =?us-ascii?Q?yIqVkYMCMf5YsbbLuVULl0m12LsyGkSOe/JrD8MNtzhQNfRZ1hFSceyYIPk9?=
 =?us-ascii?Q?zAu9TierkYhgVxS/ikb0Md6A05GcgvUBl4/eV082TG9t5TYpZxouC+Unxe/k?=
 =?us-ascii?Q?Y/+XGJRr9ltQaANSZfS3PU4VZiE2EI+YV+bF3iq9ACpwwLFJAALvTwpK/9qU?=
 =?us-ascii?Q?w5UJRXVn4wVsKkGbVlu9doHIC/fNwF1+j+mjN1fgyz1aeDT1frtGDjQNdv9L?=
 =?us-ascii?Q?T3WMSqqg5VO/ZwR2gB42trR9tfCcvDT0TyzcubtZw9qU2Oy/VaRZgAZ/Y6xZ?=
 =?us-ascii?Q?ltXb2PL5j7oHccl29kMNmJM5EbArZjyUZA2kNeYZ94+UVpLEKQnKXQwoJXf4?=
 =?us-ascii?Q?LOGdEGHnevLHuldlIwRnOFb13zRTw3FHRJ96WXoWraFNUMPCHoEAIrSrPNDE?=
 =?us-ascii?Q?a4FqIfaC31RBuqk9/Za7yw1ohJQ0yEbd7SIBvINve44T9crAqnst7/yzTjou?=
 =?us-ascii?Q?N0AUlLRXyag4EdLWZWr6TruLPrDITXv5+wCvoEpFLEA/ozJ03+XigX+plfIV?=
 =?us-ascii?Q?qqtBEERph0S4E1MSYId31C1MKhZZ0GPtVjxBTRe3j/Oh+BmIWh6buskodTJI?=
 =?us-ascii?Q?JtWwbnFPdkKP4GDCv0QG850jYCOZ4eyEgk0s6rTWvrPAgStns3IJvB2a6wR3?=
 =?us-ascii?Q?P2sAsbNrvD59/FEIg4EI6U1mQ6PZEt3jLCADyiPBrM+frnbsF1feag+kGmY/?=
 =?us-ascii?Q?mde6PciHqN/zfaI5HhsG8MoQbEiIJPZQOcyl5j0mDmUUjf+LCsT3IXQnQTHV?=
 =?us-ascii?Q?AvQqoCzryw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1b12f5-e101-4d9a-a0ea-08def8cfb9e5
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 00:13:40.0244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NDpnc1j0/aH3Y/p0nFYQFq0MANAM02LRuPqqB58yBKj1S3FzuW2AOMZ46lAY4Fhzv+9hI8/pqKgreJ8FQYk7uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9459

Hi Ionut,

Thanks for the details. It was indeed an informative reading. Let me
add a couple notes below.

Thanks,
Yury

On Wed, Aug 12, 2026 at 10:45:56PM +0300, Ionut Nechita (Sunlight Linux) wrote:
> On Wed, Aug 12, 2026 at 11:10:21AM +0530, Shrikanth Hegde wrote:
> > This patch series represents the result of multiple iterations,
> > redesigns and community feedback.
> 
> Nice work, and thanks for the very readable cover letter.
> 
> I looked at this from the KVM and Xen guest angle rather than from
> PowerVM, since that is what I run.  Three observations below.  All of
> them are from code inspection only -- I have not measured any of this,
> so please treat the numbers as arithmetic rather than as results.
> 
> Code references are against next-20260812, which already carries your
> base commit f2c2ba7219e5, so the series applies there directly.
> 
> 
> 1) Default thresholds are unreachable on common QEMU command lines
> ==================================================================
> 
> get_system_cpus() returns num_possible_cpus(), and steal_governor_loop()
> divides by it:
> 
> 	delta_ns = max_t(u64, div_u64(delta_ns * get_system_cpus(), 10000), 1);
> 	steal_ratio = div64_u64(delta_steal, delta_ns);
> 
> On x86 the possible map is sized by topology_init_possible_cpus()
> (arch/x86/kernel/cpu/topology.c) from assigned + disabled CPUs, where
> "disabled" is incremented by topo_register_apic() for every APIC that is
> registered but not present.
> 
> QEMU emits exactly such MADT entries for the range [smp, maxcpus), and
> acpi_is_processor_usable() in arch/x86/kernel/acpi/boot.c documents that
> this is deliberate:
> 
> 	/*
> 	 * QEMU expects legacy "Enabled=0" LAPIC entries to be counted as
> 	 * usable in order to support CPU hotplug in guests.
> 	 */
> 
> So those vCPUs are registered as usable, land in nr_disabled_cpus, and
> end up in the possible map.  A guest started with
> 
> 	-smp 4,maxcpus=32
> 
> has num_possible_cpus() == 32 while only 4 vCPUs ever run.  The steal
> ratio is then diluted 8x, and the default thresholds of 5% / 2% become
> 40% / 16% of the steal that is actually observable.  The governor never
> leaves the "do nothing" window, and the only symptom is that nothing
> happens.
> 
> Xen PV guests are affected in the same way, and often more strongly,
> because the possible map there tends to be sized for vCPU hotplug.
> 
> I understand from the v9 changelog why possible CPUs were chosen -- it
> keeps the accumulated steal monotonic across hotplug, which is a real
> property worth having.  The documentation does describe the effect and
> gives a worked example for recomputing the thresholds by hand.  But for
> a mechanism whose whole premise is that every VM on the host opts in
> with the same policy, requiring each operator to first derive their own
> thresholds seems likely to translate into low real-world adoption.
> 
> Some options, roughly in increasing order of intrusiveness:
> 
>   - emit a pr_info() (or pr_warn()) at module init when
>     num_possible_cpus() significantly exceeds num_online_cpus(), naming
>     the ratio and the effective thresholds.  Cheap, and turns a silent
>     no-op into something diagnosable.
> 
>   - scale the thresholds by num_possible_cpus() / num_online_cpus() at
>     init, so the documented defaults keep their intended meaning.
> 
>   - keep summing steal over the possible mask, as today, but divide by
>     the online count, and handle the hotplug discontinuity by resetting
>     the sg_ctx.steal baseline from a hotplug notifier.
> 
> I do not have a strong preference among these, and the first one alone
> would already be a large improvement.

I asked the same question on v9 iteration, but the problem is still
there. I don't think that VM with a big number of offlined CPUs is
something that needs to bring admin's attention with pr_info(). The
solution should be found withing the driver.

I thought about saving the steal time for each CPU in an array, so on
the next iteration we count steal time from the same subset of CPUs,
regardless of hot plugging. 

Your approach with num_possible_cpus() / num_online_cpus() scale looks
nicer, if it works. Definitely need a testing for both. Resetting the
steal baseline on each hotplug is another option, but to me the least
attractive.

This problem must be resolved this way or another before we merge the
driver.

> 2) Nothing stops the driver from folding Xen dom0
> =================================================
> 
> dom0 accounts steal time like any other domain -- xen_time_setup_guest()
> in arch/x86/xen/time.c wires up pv_steal_clock unconditionally, with no
> feature negotiation and no privileged-domain exemption.
> 
> So loading steal_governor in dom0 makes it shrink its own preferred mask
> under contention.  That is precisely when the blkback and netback
> threads serving every other guest need CPU, and the driver has no notion
> that this domain is different from the ones it is trying to be polite
> towards.  The effect would be host-wide, not confined to the domain that
> loaded the module.
> 
> Given that Kconfig carries "default m", the module is built on any
> distro kernel with PARAVIRT=y, which includes dom0 kernels.  It is one
> modprobe away from being loaded there, quite plausibly by someone who
> read the documentation's advice to enable it uniformly across all VMs.
> 
> A xen_initial_domain() check that refuses to load, or at minimum a loud
> warning, seems worth having.  More generally it may be worth stating in
> the documentation that the driver is meant for guests only -- the same
> argument applies to a KVM host that is itself running nested guests.
> 
> Juergen and the virtualization list are already on Cc -- I would value
> their view on this one in particular.
> 
> 
> 3) Core granularity degenerates to single vCPUs on KVM and Xen
> ==============================================================
> 
> decrease_preferred_cpus() and increase_preferred_cpus() step by
> topology_sibling_cpumask(), which matches PowerVM, where the hypervisor
> schedules whole cores.
> 
> On Xen PV that mask is always the CPU itself, by design.  The header
> comment of arch/x86/xen/smp_pv.c is explicit about both the behaviour
> and the reason for it:
> 
> 	/*
> 	 * Because virtual CPUs can be scheduled onto any real CPU, there's
> 	 * no useful topology information for the kernel to make use of.  As
> 	 * a result, all CPUs are treated as if they're single-core and
> 	 * single-threaded.
> 	 */
> 
> A plain "-smp N" under QEMU gives one thread per core and one core per
> socket, with the same result.  So on both hypervisors the step size is
> one vCPU, and convergence to a folded state takes proportionally longer
> than the PowerVM numbers would suggest.
> 
> I do not think this is a correctness problem -- per-vCPU is arguably the
> right granularity there, for exactly the reason the Xen comment gives.
> The case that does not work as intended is the opposite one: a guest
> given a synthetic topology such as
> 
> 	-smp 16,sockets=1,cores=8,threads=2
> 
> will fold what it believes is a core, but those two vCPU threads need
> not be co-located on any host core, so nothing in particular is freed.

On 2 and 3.

If the governor will become a practical tool for admins, I believe
there will be the more corner cases, the more adoption the driver
gets. 

That's why I suggested the modular architecture for the governor. Now
we have 2 options:

1. Keep the driver as a single module, and add those checks for DOM 0
   and per-core vs per-thread behavior.
2. Rename this driver to powervm_steal_governor, and let KVM and XEN
   engineers implement their own drivers.

The options are not mutually exclusive. The earlier versions of the
driver had a 'core' part and hooks for different arches.

At this point, I believe, keeping the driver simple is the most
important goal for making it upstreamable. When it's merged, it
will be much easier to add more functionality and tuning for
different VMs and architectures.
 
> So mainly a documentation request: a sentence in
> Documentation/driver-api/steal-governor.rst noting that the core-level
> step assumes the guest topology reflects host scheduling granularity,
> and that on KVM and Xen it commonly does not.  It would also explain to
> readers why convergence looks slower there than in your PowerVM numbers.

I agree, this should be documented.

> --
> 
> I would be happy to run this on x86 KVM and on Xen PV guests if that is
> useful -- the series has no Xen coverage that I can see, and points 1
> and 3 above would both show up there first.

I didn't test the patches myself yet, mostly because configuring VMs
is a separate topic. If you share a script that configures an
environment with paravirtual VMs that run some payload that overcommit
the vCPUs, it would be a valuable addition to the series.

Andrea Righi with his virtme is already in CC. It's a very friendly
and highly configurable wrapper around qemu that allows to compile a
and run kernel with a couple commands. Andrea, can the virtme prepare
such an environment? For testing we need:

 - several paravirtual VMs, so that the number of vCPUs exceeds the
   number of CPUs, and
 - some payload running on them to overcommit the vCPUs, triggering
   the steal time counter.

Thanks,
Yury
