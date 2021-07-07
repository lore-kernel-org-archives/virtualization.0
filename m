Return-Path: <SRS0=rr22=L7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605B0C07E95
	for <virtualization@archiver.kernel.org>; Wed,  7 Jul 2021 15:18:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1064D61CC2
	for <virtualization@archiver.kernel.org>; Wed,  7 Jul 2021 15:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1064D61CC2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D1169401FE;
	Wed,  7 Jul 2021 15:18:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9fvZbUjxckw9; Wed,  7 Jul 2021 15:18:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B3451401CE;
	Wed,  7 Jul 2021 15:18:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BBBEC001A;
	Wed,  7 Jul 2021 15:18:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A21AC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 15:18:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3C35260A44
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 15:18:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ea-yH9bKLeAJ
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 15:18:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0020960A41
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 15:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625671078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fLKo2OPwq2DZHj/O8dwU7gitKGZtqVoZ1OSqBdlhM9o=;
 b=EtmpQqOfzfR4D54HvlT8Iq/xD7q0rCfa/3jVptQEdUTE+Tkcy8LGaYUvnJMmMtI13C9jD9
 kDgGA/gKxTVyAO1oPO8dq+AmdMFM9TzNKy6hecn7ZoGS+sP80I70YebOf2c/eatmSxac6I
 mwNTS5LSXD3x1bMy0LywvFkLUwps6FU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-MgX2JVklPC2kGp9HwENZYA-1; Wed, 07 Jul 2021 11:17:57 -0400
X-MC-Unique: MgX2JVklPC2kGp9HwENZYA-1
Received: by mail-wm1-f70.google.com with SMTP id
 p3-20020a05600c3583b02901f55d71e34aso1104958wmq.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Jul 2021 08:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:organization:subject
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=fLKo2OPwq2DZHj/O8dwU7gitKGZtqVoZ1OSqBdlhM9o=;
 b=rTqesd0OP+yGJn8zBQsybRlHYRR1JdYFjtqaFmBwVAj8lfxeUHGilb4OaV8PG5Ah2b
 p3qPAnLxd8nXJw/YGn7vOvtTb+8yZRbDU56lfOpNkQXLmH8ErHc8I58Gl7Q98rCiD1fv
 QO3O2jsgD6Sm8zAw5hdGe48aVdiGhicEUavoqKGggAO8FtS1/8IaBTzODqCvCylfLZIa
 RlgX6J/ZtNAtPM/MRNo2Q8GUJ373Pt4O9j+3WgUzjsYfF31017fd6Y16s5UVXCrYV/l5
 6UWhJNk9sNXicJiMHekUpKLdfV+9HQ3hjBLlk+U7amFEoG5naYZ2lheHvg2WV5nL+iHP
 Hz9g==
X-Gm-Message-State: AOAM531Y4CrmNihvlyISDdcV7UyoxNoKeQLky/EsJzp5t9oDKWrguurM
 D/akLHt4rQkI4vl10I1dY3dpFr4uWiHPdF+SDZNvC8h4OS41S3VGxw6qGD7bvqBr8PNkh0d8CkM
 p9zWnqXNATZGlJE/KGkto1uD0hkYFxpM43Yx1QLralA==
X-Received: by 2002:a05:6000:1a87:: with SMTP id
 f7mr28329931wry.172.1625671075959; 
 Wed, 07 Jul 2021 08:17:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzah6urErPg+YyoBdeo4INZfgkKtMjv5hY7UoQ8zErjkgLHiY+CIDanzMoZE9NYHKyRE1GXlQ==
X-Received: by 2002:a05:6000:1a87:: with SMTP id
 f7mr28329899wry.172.1625671075625; 
 Wed, 07 Jul 2021 08:17:55 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23579.dip0.t-ipconnect.de. [79.242.53.121])
 by smtp.gmail.com with ESMTPSA id x17sm25630828wrn.62.2021.07.07.08.17.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jul 2021 08:17:55 -0700 (PDT)
To: Hui Zhu <teawater@gmail.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210623115839.3524-1-teawater@gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC] virtio-mem: Add support of memory_hotplug.memmap_on_memory
Message-ID: <bc36b6fe-0d1a-6fe2-e8f3-49bbcaebcf41@redhat.com>
Date: Wed, 7 Jul 2021 17:17:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210623115839.3524-1-teawater@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Hui Zhu <teawater@antfin.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 23.06.21 13:58, Hui Zhu wrote:
> From: Hui Zhu <teawater@antfin.com>
> 

Sorry for the delay, once I was back from vacation my inbox was 
overflowing :)

> We did some virtio-mem resize tests in high memory pressure environment.
> Memory increases slowly and sometimes fails in these tests.
> This is a way to reproduce the issue.
> Start a qemu with a small size of memory (132Mb) and resize the
> virtio-mem to hotplug memory.
> Then will get following error:
> [    8.097461] virtio_mem virtio0: requested size: 0x10000000
> [    8.098038] virtio_mem virtio0: plugging memory: 0x100000000 -
> 0x107ffffff
> [    8.098829] virtio_mem virtio0: adding memory: 0x100000000 -
> 0x107ffffff
> [    8.106298] kworker/0:1: vmemmap alloc failure: order:9,
> mode:0x4cc0(GFP_KERNEL|__GFP_RETRY_MAYFAIL),
> nodemask=(null),cpuset=/,mems_allowed=0
> [    8.107609] CPU: 0 PID: 14 Comm: kworker/0:1 Not tainted 5.13.0-rc7+
> [    8.108295] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [    8.109476] Workqueue: events_freezable virtio_mem_run_wq
> [    8.110039] Call Trace:
> [    8.110305]  dump_stack+0x76/0x94
> [    8.110654]  warn_alloc.cold+0x7b/0xdf
> [    8.111054]  ? __alloc_pages+0x2c2/0x310
> [    8.111462]  vmemmap_alloc_block+0x86/0xdc
> [    8.111891]  vmemmap_populate+0xfc/0x325
> [    8.112309]  __populate_section_memmap+0x38/0x4e
> [    8.112787]  sparse_add_section+0x167/0x244
> [    8.113226]  __add_pages+0xa6/0x130
> [    8.113592]  add_pages+0x12/0x60
> [    8.113934]  add_memory_resource+0x114/0x2d0
> [    8.114377]  add_memory_driver_managed+0x7c/0xc0
> [    8.114852]  virtio_mem_add_memory+0x57/0xe0
> [    8.115304]  virtio_mem_sbm_plug_and_add_mb+0x9a/0x130
> [    8.115833]  virtio_mem_run_wq+0x9d5/0x1100
> I think allocating 2 Mb contiguous memory will be slow and failed
> in some cases, especially in high memory pressure environment.

So, interrestingly, what failed was the 2 MB allcoation. But 
vmemmap_populate() on x86-64 will actually fallback to individual 4k 
allcoations. See arch/x86/mm/init_64.c:vmemmap_populate_hugepages(), 
which falls back to vmemmap_populate_basepages().

We could certainly think about silencing this warning (GFP_NOWARN) and 
instead printing a clearer warning like "vmemmap: populating huge page 
failed; falling back to populating base pages"

Did you also see a "virtio_mem virtio0: adding memory failed: .." device 
warning? If not, adding memory did succeed! Although it's suboptimal.


> This commit try to add support of memory_hotplug.memmap_on_memory to
> handle this issue.
> 
> Just let SBM mode support it because memory_hotplug.memmap_on_memory
> need a single memory block.
> 
> Add nr_vmemmap_pages and sbs_vmemmap to struct sbm.
> If memory_hotplug.memmap_on_memory is open, pages number of a memory
> block's internal metadata will be store in nr_vmemmap_pages.
> sbs_vmemmap is the number of vmemmap subblocks per Linux memory block.
> The pages in the vmemmap subblocks should bigger than nr_vmemmap_pages
> because sb_size need to span at least MAX_ORDER_NR_PAGES and
> pageblock_nr_pages pages (virtio_mem_init).
> All the pages in vmemmap subblocks is not going to add to the buddy
> even if the pages that are not used to store the internal metadata
> (struct pages) because they should not work reliably with
> alloc_contig_range().
> 
> When resize virtio-mem, sbs_vmemmap is going to count in
> virtio_mem_sbm_plug_and_add_mb, virtio_mem_sbm_unplug_any_sb_offline
> and virtio_mem_sbm_unplug_any_sb_online.
> Because internal metadata also need the real pages in the host to store
> it.  I think resize virtio-mem size same with the actual memory
> footprint
> on the host is better if we want setup a memory cgroup for QEMU.

So the main thing I dislike about the current RFC state is the waste of 
memory we signaled to the device we are going to use, but we are not 
actually able to use. The remaining stuff looks reasonably clear to me, 
although we could do some refactorings to make it read a bit nicer.

The "loss" currently corresponds to 2 MiB for a 128MB memory block -- 
that's 1/64 of all added memory and just as much as the vmemmap itself!

I don't see an easy way around this when keeping the subblock size at 2 
MiB. We'd have to mess with "partial subblocks" when processing (un)plug 
requests, which is just plain ugly.

There is a big TODO item on my toto list to teach alloc_contig_range() 
to handle pageblock_order properly and I shall start working on that 
soonish. [1]

What I think we should do is


1. Implement the "memory_hotplug.memmap_on_memory" optimization for big 
block mode with a single memory block only for now (Linux also only 
supports this). Environments that desparately need this optimization can 
set "force_bbm=1" when loading the virtio-mem module.

It already has the correct flow -- virtio_mem_bbm_plug_and_add_bb() and 
virtio_mem_bbm_remove_and_unplug_bb(). We'll have to teach:

* virtio_mem_bbm_notify_going_offline() /
   virtio_mem_bbm_notify_cancel_offline() about the special vmemmap
   ranges
* virtio_mem_bbm_offline_remove_and_unplug_bb() about the special
   vmemmap ranges

I think that should be mostly it, but there might be more.

2. Optimize alloc_contig_range() such that we can drop the MAX_ORDER - 1 
requirement. With most devices, we can then use a subblock size of 
pageblock_order (2MiB on x86-64).

3. Pick up a reduced variant of your RFC that implements the 
optimization only if the sbm.vmemmap pages span complete subblocks. That 
removes the need for sbm.nr_vmemmap_pages and consequently results in no 
loss of plugged memory.

[1] 
https://lkml.kernel.org/r/c8e21ac4-ace7-3176-8782-535bd6590583@redhat.com


> @@ -1534,12 +1615,15 @@ static int virtio_mem_sbm_prepare_next_mb(struct virtio_mem *vm,
>   static int virtio_mem_sbm_plug_and_add_mb(struct virtio_mem *vm,
>   					  unsigned long mb_id, uint64_t *nb_sb)
>   {
> -	const int count = min_t(int, *nb_sb, vm->sbm.sbs_per_mb);
> +	int count = min_t(int, *nb_sb, vm->sbm.sbs_per_mb);
>   	int rc;
>   
>   	if (WARN_ON_ONCE(!count))
>   		return -EINVAL;
>   
> +	if (vm->sbm.sbs_vmemmap)
> +		count = max_t(int, count, vm->sbm.sbs_vmemmap);
> +

If you exceed original *nb_sb (which can happen on bigger memory blocks 
like with 2GB where the vmemmap actually spans multiple subblocks), you 
can try plugging more than requested from the hypervisor.

You'd instead have to return with -ENOSPC in case *nb_sb does not at 
least span vm->sbm.sbs_vmemmap.

[...]

>   		/*
>   		 * Remove the block from Linux - this should never fail.
>   		 * Hinder the block from getting onlined by marking it
> @@ -1840,6 +1934,23 @@ static int virtio_mem_sbm_unplug_any_sb_offline(struct virtio_mem *vm,
>   		rc = virtio_mem_sbm_remove_mb(vm, mb_id);
>   		BUG_ON(rc);
>   		mutex_lock(&vm->hotplug_mutex);
> +
> +		/* Remove vmemmap pages. */
> +		if (vm->sbm.sbs_vmemmap) {
> +			rc = virtio_mem_sbm_unplug_sb(vm, mb_id, 0,
> +						      vm->sbm.sbs_vmemmap);
> +			/*
> +			 * Just warn because this error will
> +			 * not affect next plug.
> +			 */
> +			WARN_ON(rc);

We should avoid WARN_ON() and instead use dev_warn() for cases that can 
actually happen. With panic_on_warn(), which some distributions enable, 
we can crash the kernel.

I think error handling might also not be correct. We'd actually want to 
set the state to something like VIRTIO_MEM_SBM_MB_PLUGGED, to retry 
unplug later. Further, we'd want to return to the main loop to retry 
fixing this up.

Because if you leave the vmemmap blocks plugged, 
virtio_mem_sbm_plug_and_add_mb() will later keep failing with invalid 
requests from the hypervisor I guess.

[...]

> -	if (virtio_mem_sbm_test_sb_unplugged(vm, mb_id, 0, vm->sbm.sbs_per_mb)) {
> +	if (virtio_mem_sbm_test_sb_unplugged(vm, mb_id, vm->sbm.sbs_vmemmap,
> +				vm->sbm.sbs_per_mb - vm->sbm.sbs_vmemmap)) {
>   		mutex_unlock(&vm->hotplug_mutex);
>   		rc = virtio_mem_sbm_offline_and_remove_mb(vm, mb_id);
>   		mutex_lock(&vm->hotplug_mutex);
> -		if (!rc)
> +		if (!rc) {
>   			virtio_mem_sbm_set_mb_state(vm, mb_id,
>   						    VIRTIO_MEM_SBM_MB_UNUSED);
> +			/* Remove vmemmap pages. */
> +			if (vm->sbm.sbs_vmemmap) {
> +				rc = virtio_mem_sbm_unplug_sb(vm, mb_id, 0,
> +							vm->sbm.sbs_vmemmap);
> +				/*
> +				 * Just warn because this error will
> +				 * not affect next plug.
> +				 */
> +				WARN_ON(rc);
> +				if (!rc) {
> +					if (*nb_sb >= vm->sbm.sbs_vmemmap)
> +						*nb_sb -= vm->sbm.sbs_vmemmap;
> +					else
> +						*nb_sb = 0;
> +				}
> +			}
> +		}

Same comments as for virtio_mem_sbm_unplug_any_sb_offline().

>   	}
>   
>   	return 0;
> @@ -2444,6 +2578,15 @@ static int virtio_mem_init(struct virtio_mem *vm)
>   		       memory_block_size_bytes() - 1;
>   		vm->sbm.first_mb_id = virtio_mem_phys_to_mb_id(addr);
>   		vm->sbm.next_mb_id = vm->sbm.first_mb_id;
> +		if (mhp_supports_memmap_on_memory(memory_block_size_bytes())) {
> +			vm->sbm.nr_vmemmap_pages
> +				= PFN_DOWN(PFN_DOWN(memory_block_size_bytes()) *
> +					   sizeof(struct page));

I feel like we want memory hotplug code / vmemmap code to tell us 
instead of calculating ourselves.



-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
