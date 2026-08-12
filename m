Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010027.outbound.protection.outlook.com [52.101.56.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5879821D591
	for <virtualization@lists.linux.dev>; Wed, 12 Aug 2026 02:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786501510; cv=fail; b=NpAIVhO6xMF523SPizLZtxbbGO0nnPEhlyviQJZak6Hu++U/KMiun49a58DRrXnMboaMdQaN2jKjrExWcTcgrrlwbxOvy3OFB4TlzUciLliLcH8hUsVMC2cE18i/RI40B9Tb+l5i5m1S8WqtJtdF3DSqzWPsf4l4um79Weoovv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786501510; c=relaxed/simple;
	bh=eggVsc/ikLXjgU+w6PQTe9GPCOfLGcCnBMJDx/E8plU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=flWHs+V6LeOppulnEY7yg6vFqmqBooJBPABaq2sxzfnX0p5bhzXyplP1CDd+MK5EIpv9SKPsgBewO89wf9Gqxcb0ZWWJ4Wql2hEgqHD9f47hj6dbOaevGisbX/98IBCXkFPTOyd7rrRCwHTJMt844yNSjhr6TEjQkYJaPVkKuKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IvMtu5Tb; arc=fail smtp.client-ip=52.101.56.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IvMtu5Tb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6jImMKsyGAQtIj5uHMqLMU7z9NXbBpWYbhTt3i4wVDS+Z5abElgXtN4K6ftE4eKYMyYKZ9w2ODGRG8QLDAeXWP/Y68MhJPnDMIlmVaGdfR2V8+YQpfxA5BBMVTLIfADUxV79o9YI/jgUgNG4VwncCQ99JgzSVpNZNGSIlyaOn2n0t8kSofD6WYTuwYJOJUylptf4ECx8Dj7j5qYgzlzwZYszL5uvLqs8DNoh8NYX+8076VruSNQA1zNhmUNfbOfejfVwj3e0LUnHJ2wsqc73ZGFT4iQ+PI8nrlMrQ5DnvDZk82Dor1bhx7fWlI8JfmyFiXHZFEKrf05ogo7hysoSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpseDICmhes/177I3em6bJCyW9HHZ+UT5I0wmQePEE8=;
 b=sSHdhMSy6KEhHoah/bPV18MfnX/zAAc4sXCRtNu0el/aYVdssYAfuHdjgdd1vR8HA9mronxpFhvrnxJdlexrGr9msR7lnhu7nBI/dV0gZln5gVl4qUlT687PocF+9cySJy4kHqpzJLH5tDxiC6D1dvpKR+NgCCQs5Mw7l3CfzOqlC4ulWHxTFDv3puRkl3bVhpTOuDUw3D4lqn9CptVEzjbc3YmbPT4fSfL73NLHEYWxYcuMMX3Uxlu8gd4xZ+MihexT9HqusR6nGSnqJhsMBfVr6qkmLeqI3K1jp5rp43UhisCiYFvjdJtjNPaup1Je4Mg81FUama/snczCcdQ0Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpseDICmhes/177I3em6bJCyW9HHZ+UT5I0wmQePEE8=;
 b=IvMtu5TbV3IyDFhLYAN+8Ueyeoh+ki8u7rBHJpKixQJ86ZpZ9+kuPSlBHV+znpxo5VFH1QAf7nd/K2+KvEmp1dX4CwIqdg8V84BLqeZanRtsOB33cA2B+u+1ZiT/YLTSxzrbYeC7BYIGQqkrOvhE4lSh/OS5q6mVd/gqJne1tk1hvvjftTHSw52KsIoh5jWqE3/wEhVTMtomIKQ+cGZGzhF7rxctDs7ZFYqF5gt6mRh2gRDKDn4jQHRPbzWXgGcwSE6H7QKFtKE75GE0SkD+NZoE/pODGevDmfOAEwce+5lN4ROmVQFEwkiVqgP4l8oTbveCozo0ykXHFM83I7hySw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PR12MB9573.namprd12.prod.outlook.com (2603:10b6:610:2ae::5)
 by PH8PR12MB7421.namprd12.prod.outlook.com (2603:10b6:510:22b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 02:25:03 +0000
Received: from CH1PR12MB9573.namprd12.prod.outlook.com
 ([fe80::d88f:a143:5f79:c148]) by CH1PR12MB9573.namprd12.prod.outlook.com
 ([fe80::d88f:a143:5f79:c148%5]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 02:25:03 +0000
Date: Wed, 12 Aug 2026 10:25:01 +0800
From: "Liu, Changcheng" <jerrliu@nvidia.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: pbonzini@redhat.com, virtualization@lists.linux.dev,
	changcheng.liu@aliyun.com
Subject: Re: [PATCH] virtio_blk: add use_irq_affinity module parameter
Message-ID: <anvZfVak5FVjuJSZ@yokbvdiprd370.nvidia.com>
References: <am2QeS/lS+Cova+I@yokbvdiprd370.nvidia.com>
 <CAJSP0QVSBsg0_pCaxy8Sar3=G+sdj5Z8R5yNmUomGy+C5YrHJQ@mail.gmail.com>
 <anP0FimfttCpDMKW@yokbvdiprd370.nvidia.com>
 <CAJSP0QV1=SUYFy3XKe8tWeore3EVQEjN7EWfLZ8QLm8qY4rEtg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJSP0QV1=SUYFy3XKe8tWeore3EVQEjN7EWfLZ8QLm8qY4rEtg@mail.gmail.com>
X-ClientProxiedBy: FR2P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::18) To CH1PR12MB9573.namprd12.prod.outlook.com
 (2603:10b6:610:2ae::5)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PR12MB9573:EE_|PH8PR12MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: 96ae7dc5-9bf9-4e19-35b6-08def818eac1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|6133799003|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dTafkHybGlY3HqHCgecL0cYK6t6mhiW6Z0HIHg37Hc3lucf1e9lQbIrAc/UQMW0S5yJneHZ9dlEbjhKhEJVQjj4AOrEKbYqxOjGTgLmvXLca9ldXZYIFlN9soLKxVmXQk7EtlLGlAADDV316FRD/P3ufct9TSUbb3Oie3NEij4KNE5lsgbtpqFlq6ipgnC9V0yMcXwvFL2T+Qd6RApyb0SgdjlJeQ7XFch19yuc8C3UqsdkrCnFM9r8rxqP6fcqDeatqK6NzkER82nHAYG64WjjlKgYP5OU8IecY/aSeZivtQ4eReKXN0gzuLwo9MUv+TjHQhItNCzB2MeB2INTywANMFJvVEMGCysLZxxYZtlvs+cbqfSJPOHI2ZeWphyZtkgYPV3o1T3JfdBz1G2cK2Jpneb+e20mdLhNyNMdBqjg/VS1+xO0usSpNVYaB61pJ6lo7+qtXBiIo3pHqQvrHPtoF+Uk4t2eoJ+YQcUrxp4GtqS/7KojXxDvfi6R7PyT0deSeWjW7mSdS1foyswgnvIu8Ree/KVGqgFyB3izBzVpHVvpN/2V77zG02S3iGBynADHMaTKOrn2RAOq/M55YKUuVDgeUGW2XLdVfFvdeOU4XhexsIqPKanCxuR8N0cHbb6AhhXAVTtDPYdjbF+BrLV2kUzb7xZThLNbXaT3scl4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PR12MB9573.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGFBVmptVTVQTWg2Tm5DUFVrdC9YbnVWcnRZcHFxR0hodGR3dnNBZVJReGs4?=
 =?utf-8?B?MEdscmt1RDVCN3JNYWhGNTFlUHpkUnJUaWNVa3dYZEo3TDFmM2htN1l2d2tk?=
 =?utf-8?B?bXdrZnJnK3gyQVZudUFNSjZYS0JraDVVT01uc0dvc2o2N2pucVhhNGdQWWwz?=
 =?utf-8?B?NERlbFFkT1Zndk1FV0lXQ2liOENrOXV1VnoyTyszaytkN0VBRjFWeHkydy91?=
 =?utf-8?B?eGFFNmlmdHBJWCsyN2Y2aVUzZzBsRm9pb29RZHM2aW5FVy83eUo1OVQ0NVhY?=
 =?utf-8?B?bi9JbFZVK1N1OWI0bnMyY09YdEtrR2ozMVc3aUdLazZkTkVGc0FKdVpvbFZZ?=
 =?utf-8?B?V3VROFBXVEMyL3RCRFFHMzFEYVk5dmdOT0l2aDFIY0UyazBsd1FNTlJMWEFX?=
 =?utf-8?B?empEN0hxTjRnRzNTZ21pSTZoaXRZMHlHN2F6VW9tV1FIWFAzV1hiSVM4YlYr?=
 =?utf-8?B?M3dYRlBLWkZDdGd5MXlPUDJuc2UrV0wybW5ncVF5V1J6UzdvQjJhZC93ZTZz?=
 =?utf-8?B?NmJ1ZEFHbDZ1WEsvQjh0RGM3NGRTZ2lDQkxVdTR6OXo3S1IyMjc2Nldibktn?=
 =?utf-8?B?cjR6WGkxdW11amdTUlJWTmtSakFWUUxuQW5mTXJndS9BMktiQUphWVJYQXh4?=
 =?utf-8?B?aGlpWlJyaUZkTnpreXRIMnBGZ0dJTGdZbjMxelhyaElVZUkrN0ROdCtTSUE5?=
 =?utf-8?B?TmYzc1FROWlHOE83enJHRjZaNDVGWHVCSURwcGtNbGRkU3BvRTJPZU5YTCtr?=
 =?utf-8?B?SU1ya05hSjlVemtSYVNreTNGQUxXNHVxdE5wQTlFdVBhT0I0eDA5YW5PYndY?=
 =?utf-8?B?Vkthc0tOWnorK3UwdkVaUkoxcVBkRUNJbmg2S3JKdnhtNDVNeGJaalI4V2xY?=
 =?utf-8?B?UkFlL1ZyMlRDT1lvWFdtVjdyRk5QbURnUVFhQnJ4K05nbHJqMkRXNksvT01M?=
 =?utf-8?B?RElGNmQyMFFEclNZYlNhd2h5MThjcTJna1RLLzJhLzl4Ny9yelQ3RWxHRmZD?=
 =?utf-8?B?dE1KYVllbnl6Z3M3NUFGZE5GSy9OWGtJVllHTVRZeXhZdmhDak1iMHBsQzI5?=
 =?utf-8?B?MFYyY25YSkxhVXZTWGEzbjR1bmh2Sm5oZlJxQUV0a2ZXZkNtSUJVM3Z1eG9o?=
 =?utf-8?B?cktIRmF3RnY5MjZySFF6UllhNURpNmw2VUxURStjNzFaK1VtbDU3eXQzdktk?=
 =?utf-8?B?REpMVHZKcXM3d3FEV1lxUzNQdm1JR2V3cE9hTmhOR1VyUW5takk1RmhDQUNm?=
 =?utf-8?B?eStpUjFtMktCYVJoQ1BERklsczY1VkVvV3daVzRmNlhDa3VtazB5aGl5ODdZ?=
 =?utf-8?B?dlYwaWh2VE5GOUV3U0Zmc3lsR1M2TW56dDYrN1F2YXdVQWJmVHhjQ0wzb2JC?=
 =?utf-8?B?RXEzWnprMEhLWXNUbzVyMVlrUmxFa0h3U0UvMkR1bUxXN21ZK2dGakU0WUp5?=
 =?utf-8?B?MlpxUGtyVzdpYnBsUTF4NVJzM2RSN2RBQXQzanpPa3RHellGRkxHR2RSMGlz?=
 =?utf-8?B?UVpFU213N1Q0THZ1YnUwai93VGc0Z3VhZFRCM0VxWE4vRE1qakVYQWREcGI1?=
 =?utf-8?B?eXlBUlJWRTRLNjJWdHMraUVaeHdEcGFGb1ViN2RmclZsMmgwWWtycGpHMFFo?=
 =?utf-8?B?RWdZMmtsZnFCeWtLMGRtS3JLcE14L2ljL1JJQkduSWwzekhFYitCbjBNNGJs?=
 =?utf-8?B?endRMHVmYytOVWdMS05WdUpqaURKUmJUbVNpWUhFRE9MZ0cxT1VsNmJkd242?=
 =?utf-8?B?UGQ5aUppczJ5bGFHelhqZ2dBQVJRSE9QTHhWWHhHRTRvTytzcUo4M296QWVl?=
 =?utf-8?B?V2JuNjA4aHhNbDd0SGthSUJZQ2JndWMwclZGUVZsNkNrTFVKYTlZbUpnZExJ?=
 =?utf-8?B?aUdhdVR2SFVUc2ZxVFdJL25rQzZ2Q2NLRW1yYmcwNUJUYnNkbWxrSlRudndu?=
 =?utf-8?B?NWJEMEtJTEp1ME9kNkVTNkFlYjhVbjNueStsQXgyVXB5STN6d1VpdHJ1WEp0?=
 =?utf-8?B?SjlkaTBCUmI1QVVOeU42MDFSL2J0RFF4VlhmWlZoKzNZNmNBRmZjY2VTL2xP?=
 =?utf-8?B?NktYNG9zTDhxajAzWENoN0s0dnlDSVIzbTZjd3k2M01pakVkaWViQzJFZGw0?=
 =?utf-8?B?cmpGVGVNNy9CRVlYREdzZFNoSFl6SU4rblZvS0JZUllrR04vU2FDOXQ0R3NZ?=
 =?utf-8?B?c09hTThmMGRmY1RIT0tqK0RoWDBUcDlpcCt4a1ErZjkySVJXVk1Va25obmZr?=
 =?utf-8?B?clpnSWVDa0dRZmduRTB3M1pVWXNXaUpFSlYvU21JNDA2Tjg5Q2ZBbW8xWTBk?=
 =?utf-8?Q?vw0vZ6vkloyS6bJ35z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ae7dc5-9bf9-4e19-35b6-08def818eac1
X-MS-Exchange-CrossTenant-AuthSource: CH1PR12MB9573.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 02:25:03.6066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l3JneDudfhLv2eLsD/TW/UAdfWMahEiIP1Rg3gFnbWBBwCF4B5wnTj7AjWRV0JL802NEDVf2IpTn96JoFB/nOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7421

On Tue, Aug 11, 2026 at 10:37:28AM -0400, Stefan Hajnoczi wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Wed, Aug 5, 2026 at 10:40 PM Liu, Changcheng <jerrliu@nvidia.com> wrote:
> >
> > On Wed, Aug 05, 2026 at 01:45:58PM -0400, Stefan Hajnoczi wrote:
> > >
> > > On Sat, Aug 1, 2026 at 2:21 AM Liu, Changcheng <jerrliu@nvidia.com> wrote:
> > > >
> > > > When creating many virtio-blk devices, probe starts failing with
> > > > -ENOSPC (-28) because the system runs out of interrupt vectors:
> > > >
> > > >   virtio_blk virtioNNN: probe with driver virtio_blk failed with error -28
> > > >
> > > > By default virtio-blk uses managed IRQ affinity, which reserves an
> > > > interrupt vector on every CPU for each device (about nr_cpus vectors per
> > > > device). On a host with many CPUs and many devices this exhausts the
> > > > vectors long before all devices are probed.
> > > >
> > > > Add use_irq_affinity (default true, no behaviour change). Set it to 0 to
> > > > use unmanaged interrupts, so each device only uses a couple of vectors
> > > > instead of one per CPU, allowing far more devices to probe.
> > > >
> > > > Signed-off-by: Liu, Changcheng <jerrliu@nvidia.com>
> > >
> > > There is already a num_request_queues module parameter for cases where
> > > the user wishes to reduce the number of virtqueues. Did you benchmark
> > > that and decide the performance of many queues sharing a single irq
> > > makes it worth adding another module parameter?
> > >
> > > Stefan
> >
> > num_request_queues does not address this case because each virtio-blk device
> > already has only one request virtqueue when the failure occurs, so the queue
> > count cannot be reduced further.
> 
> Okay.
> 
> > The issue is reproduced after probing approximately 800 virtio-blk devices on
> > a 64-core bare-metal host. With managed IRQ affinity, the IRQ-vector reservations
> > are eventually exhausted and probing additional devices fails with -ENOSPC.
> > Disabling managed IRQ affinity avoids these per-CPU vector reservations and
> > allows more devices to be probed successfully.
> 
> I don't follow. My understanding was that non-managed IRQ vectors are
> allocated by request_irq(), which is called during virtio_find_vqs().
> Probing 800 devices would still require 800 * (1 virtqueue irq + 1
> config change irq) = 1,600 vectors. How come non-managed IRQs do not
> hit the limit here?
> 
> Thanks,
> Stefan
> 

With one request queue, virtio-blk allocates two MSI-X interrupts: an
unmanaged configuration interrupt and a managed request-queue interrupt.

The request-queue interrupt's managed affinity mask covers all possible
CPUs. On x86, irq_matrix_reserve_managed() reserves one vector slot on
every CPU in that mask so the interrupt can migrate safely during CPU
hotplug. Consequently, every virtio-blk device consumes one managed
vector slot on every CPU for its lifetime.

Once any CPU exhausts its roughly 200 usable vector slots, managed vector
allocation fails even if other CPUs still have capacity. virtio-pci then
falls back to its shared-vector MSI-X allocation, for which the affinity
descriptor is discarded and the interrupts are unmanaged. Allocation can
continue using capacity on the other CPUs, explaining the observed limit
of approximately 800 devices.

When managed affinity is disabled, both interrupts are activated on
individual CPUs and distributed by the vector allocator. APIC vector
numbers are per-CPU, so the same vector number can be reused on different
CPUs. On a 64-CPU system, 800 devices therefore consume approximately
800 * 2 / 64 = 25 vector slots per CPU.

Thanks
Changcheng

>
> > This patch does not cause multiple virtqueues to share a single IRQ. Passing a
> > NULL affinity descriptor only disables managed IRQ affinity. Regardless of the
> > number of virtqueues, virtio-pci still first attempts to allocate a separate
> > interrupt vector for each interrupt-driven virtqueue. Only if per-VQ vector
> > allocation fails does the existing virtio-pci fallback share a vector among
> > the virtqueues, and that fallback is independent of this patch.
> >
> > The new parameter defaults to enabled, so the existing driver behavior remains
> > unchanged unless the option is explicitly disabled. The option is intended for
> > environments with a very large number of devices, particularly for functional
> > device testing.
> >
> > - Changcheng
> >
> > >
> > > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > > index 32bf3ba07a9d..184f1c1f4485 100644
> > > > --- a/drivers/block/virtio_blk.c
> > > > +++ b/drivers/block/virtio_blk.c
> > > > @@ -41,6 +41,11 @@ static unsigned int poll_queues;
> > > >  module_param(poll_queues, uint, 0644);
> > > >  MODULE_PARM_DESC(poll_queues, "The number of dedicated virtqueues for polling I/O");
> > > >
> > > > +static bool use_irq_affinity = true;
> > > > +module_param(use_irq_affinity, bool, 0644);
> > > > +MODULE_PARM_DESC(use_irq_affinity,
> > > > +                "Use managed IRQ affinity for virtqueues (default: true)");
> > > > +
> > > >  static int major;
> > > >  static DEFINE_IDA(vd_index_ida);
> > > >
> > > > @@ -1016,7 +1021,8 @@ static int init_vq(struct virtio_blk *vblk)
> > > >         }
> > > >
> > > >         /* Discover virtqueues and write information to configuration.  */
> > > > -       err = virtio_find_vqs(vdev, num_vqs, vqs, vqs_info, &desc);
> > > > +       err = virtio_find_vqs(vdev, num_vqs, vqs, vqs_info,
> > > > +                             use_irq_affinity ? &desc : NULL);
> > > >         if (err)
> > > >                 goto out;
> > > >
> > > > --
> > > > 2.43.7
> > > >
> > > >
