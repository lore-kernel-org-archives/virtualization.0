Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7429C5228
	for <virtualization@lists.linux.dev>; Fri, 13 Sep 2024 14:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726238342; cv=none; b=X86SuFn0wdCKUZ18Gxf3HuiN4dqhJ074/JQfbXBiuufJINMLd0vkEcpFDv4xigl1xqOoLGPmeiOgMpQ1/GHG7TBcbXo/IUxeDXmnqAdHeNCZWSrcbwFNH03Q3eAHbinApdgIQKuPvDx68r5cmJjFywcT4wBXJvIF6XkPn3889ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726238342; c=relaxed/simple;
	bh=lBj0YActRmEynLy/fGzrx5Z0od+lfhF1gxPZ5WpaYZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=FnuFYk2mrVg5uiKJi+POSImcM0ua5Rt+GYG5pzWSge7ItYsKsck7dSrOkq2F44+mLC1JZ8FBGj4ZtpB/EzNq5IoyKswXm2aXln0pX53XPB1ggRykhFoRhwj+gpoVi4rJzQxBMY1L3+RNQl2soMIQM5WWSoTvBY2r1yuisG0c4Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Go22AVj/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Go22AVj/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726238339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I0yqbY/OCO9wLgd1HoYr5nBxWhzZs/QuYlUDgnwW+sU=;
	b=Go22AVj/3huDpJ6Z+AbwyT5NtlBBB902Jo6fLqvRJMI6m5l2CDrmGGmLr6g0uDw5wNcdSx
	0njrJ4xEE6fX3KRemQroX+dSWqOIyArQuimN8PYwoM3oucTLSPxz2cpEOy2NON9W4azGi7
	GRltccEEwK5ShoIhM50rPmY/JZIeWDo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-mLHyGfkFNY2VX5yR7EISPA-1; Fri, 13 Sep 2024 10:38:55 -0400
X-MC-Unique: mLHyGfkFNY2VX5yR7EISPA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cbcf60722so16796895e9.1
        for <virtualization@lists.linux.dev>; Fri, 13 Sep 2024 07:38:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726238334; x=1726843134;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I0yqbY/OCO9wLgd1HoYr5nBxWhzZs/QuYlUDgnwW+sU=;
        b=l1gnpcSRpQ/8oIYB8Cf/aFReM+Cgq0ARjAtTZ3qsdGBGhQxbHf7NWbW65kGQv2J3m7
         lKTWljoHEcYE3njWghkTXpkPP231zieIIhy3h63wiob3rD6RlnnSLI6P81cKlDmz777e
         AFdGOOu3ljok+yjDNHtEyIWU+BVN12EMliR6V+lqAFeswHBOovf8Ym3420+pBNX8AtAj
         7zOI9Q9KT5dUZOZm7x4WJHTKekrWsWZIyBO5VllzfAf5AuxOUQ8idPzWinSjvb7AnBHa
         dAZjzgZKFRJO/EPNz+RwCC6iZARpjya2tAxjt4xm/metR/3qJQ03nEbocvBBEdezHttW
         XaYg==
X-Forwarded-Encrypted: i=1; AJvYcCWlF2rS6kbE8I8XceZwsz1vs9rpnGFqHouwxGX0dakTU6se/N2Vl8WXLUP7nHqxYQl+IAfpwxhJTqZKdp9DxA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwFgS61un+YA6Xjq/haMvsFcwgiAsmw+wX3S+VnSzqXla9Tkw7Q
	CbMWx9Om2BlRFgxjah6Ym91BKYmJnLkoA/0AJhdKAPpwd3z34PPjs+5pNCG1qi2sGoKc0UfJBEu
	UVpIM6U1tfBlvEVlE/8+HWgtoQc3rG8m5LLJEsw5zfTIy+hV+s2JCZPobCs8HVbna6cDClctM
X-Received: by 2002:a05:600c:474d:b0:42b:8a35:1acf with SMTP id 5b1f17b1804b1-42cdb586f4cmr57656895e9.25.1726238333700;
        Fri, 13 Sep 2024 07:38:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0wLM2XCe6EYIlhXthu0A0w06hU52pDmnPJjKD55axxzMVLC1lHSc3Rf+thDcnJZi7N8BSNg==
X-Received: by 2002:a05:600c:474d:b0:42b:8a35:1acf with SMTP id 5b1f17b1804b1-42cdb586f4cmr57656275e9.25.1726238332596;
        Fri, 13 Sep 2024 07:38:52 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ed:ea77:491e:7d20:ef52:7bc4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b05da47sm29172935e9.17.2024.09.13.07.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 07:38:51 -0700 (PDT)
Date: Fri, 13 Sep 2024 10:38:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev
Subject: Re: 0010:virtnet_rq_alloc+0x8f/0x1b0 [virtio_net] with 6.10.7 and
 packed virtqueues
Message-ID: <20240913103753-mutt-send-email-mst@kernel.org>
References: <CAK8fFZ6qVutPWxquHg7NEvFqYqDP5BwEdO81hqW8iMFxJFuLSQ@mail.gmail.com>
 <CAK8fFZ5N7EbU=uLbfyeSkQ273NSm+GELWUu1O1OBCpaSwjv6FA@mail.gmail.com>
 <422f35b3-7834-4df7-bcea-e3be12707aef@leemhuis.info>
 <1726216954.7439098-1-xuanzhuo@linux.alibaba.com>
 <565a9204-362d-458d-8b8e-11c5aada7b98@leemhuis.info>
 <CAK8fFZ6W2ZfwTa4nYz8ORTgb0mOTysg89LEEz7cHGtdqwpsvmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAK8fFZ6W2ZfwTa4nYz8ORTgb0mOTysg89LEEz7cHGtdqwpsvmA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Sep 13, 2024 at 11:21:11AM +0200, Jaroslav Pulchart wrote:
> So far:
> 
> 1/ I was able to "do a reproducer" and hit the "random memory
> corruption" issue with vanila 6.10.10 in our setup in ~28m of uptime
> see attached 6.10.10-1.gdc.el9.x86_64.log.
> 2/ I reverted these commits
> "virtio_net: rx remove premapped failover code":
> defd28aa5acb0fd7c15adc6bc40a8ac277d04dea
> "virtio_net: big mode skip the unmap check":
> a377ae542d8d0a20a3173da3bbba72e045bea7a9
> "virtio_ring: enable premapped mode whatever use_dma_api":
> f9dac92ba9081062a6477ee015bd3b8c5914efc4
> in our next build and so far the environment is stable and not
> crashing under same conditions like the previous crash.


Automated backport failed:

http://lore.kernel.org/all/2024091336-family-daffodil-541d@gregkh

Since you have done the revert, and actually tested it, feel free
to post, I will ack.




> 
> pá 13. 9. 2024 v 10:51 odesílatel Linux regression tracking (Thorsten
> Leemhuis) <regressions@leemhuis.info> napsal:
> >
> > On 13.09.24 10:42, Xuan Zhuo wrote:
> > > On Fri, 13 Sep 2024 10:26:57 +0200, "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info> wrote:
> > >> [CCing a few people that know more about this stuff than I do]
> > >>
> > >> On 13.09.24 09:50, Jaroslav Pulchart wrote:
> > >>>
> > >>> actually I'm getting random memory corruption related crashes after
> > >>> updating to 6.10.y. My expectation is that it relates to this issue:
> > >>> https://bugzilla.kernel.org/show_bug.cgi?id=219154
> > >>> It looks like it is almost 1 month ago
> > >>
> > >> A lot of developer ignore bugzilla.
> > >>
> > >>> already from the last comment
> > >>> there, However the patches fixing the regression are not reverted from
> > >>> the 6.10.y tree which surprises me.
> > >>>
> > >>> I will try to revert them from our builds and see if it helps to avoid
> > >>> random daily happening crashes.
> > >>
> > >> Not my area of expertise, but to me it sounds like the problem will be
> > >> resolved my "Revert "virtio_net: rx enable premapped mode by default"":
> > >> https://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com/
> > >
> > > YES. That is merged into net.
> >
> > Well, yes, but TWIMC to avoid confusion, it's already one step further,
> > as mentioned:
> >
> > >> That set just landed in mainline.
> >
> > See
> > https://git.kernel.org/torvalds/c/48aa361c5db0b380c2b75c24984c0d3e7c1e8c09
> > or
> > https://git.kernel.org/torvalds/c/111fc9f517cb293c4213673733b980123c3b0209
> >
> > Ciao, Thorsten
> 
> 
> 
> -- 
> Jaroslav Pulchart
> Sr. Principal SW Engineer
> GoodData

> [ 2224.743780] Oops: stack segment: 0000 [#1] PREEMPT SMP NOPTI
> [ 2224.744605] CPU: 1 PID: 52 Comm: kswapd0 Tainted: G            E      6.10.10-1.gdc.el9.x86_64 #1
> [ 2224.745375] Hardware name: RDO OpenStack Compute/RHEL, BIOS edk2-20240524-1.el9 05/24/2024
> [ 2224.746094] RIP: 0010:refill_obj_stock+0x40/0x170
> [ 2224.746629] Code: 5c fa 65 48 8b 05 c8 c4 bd 77 4c 8d b8 60 12 03 00 49 8b 47 10 48 39 f8 74 5d 4c 89 ff e8 78 ed ff ff 49 89 c6 e8 f0 34 d7 ff <48> 8b 45 00 a8 03 0f 85 ca 00 00 00 65 48 ff 00 e8 ab 74 d7 ff 49
> [ 2224.748241] RSP: 0018:ffffa5024010ce10 EFLAGS: 00010002
> [ 2224.748803] RAX: 0000000000000002 RBX: 00000000000000c8 RCX: 00002d82d4038240
> [ 2224.749449] RDX: ffff977b00aa9a00 RSI: 0000000000000001 RDI: ffff977b00aa9a00
> [ 2224.750082] RBP: a91ef76620614d85 R08: 0000000000000001 R09: ffffffff881b9077
> [ 2224.750720] R10: 0000000000040000 R11: 0000000000000000 R12: 0000000000000282
> [ 2224.751359] R13: ffff977b00235c00 R14: ffff977baa14e280 R15: ffff977f6bd31260
> [ 2224.752183] FS:  0000000000000000(0000) GS:ffff977f6bd00000(0000) knlGS:0000000000000000
> [ 2224.752952] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2224.753593] CR2: 00007f2d7e5dc000 CR3: 0000000222340005 CR4: 0000000000770ef0
> [ 2224.754271] PKRU: 55555554
> [ 2224.754697] Call Trace:
> [ 2224.755112]  <IRQ>
> [ 2224.755509]  ? die+0x33/0x90
> [ 2224.755949]  ? do_trap+0xd9/0x100
> [ 2224.756418]  ? do_error_trap+0x65/0x80
> [ 2224.756903]  ? exc_stack_segment+0x35/0x50
> [ 2224.757417]  ? asm_exc_stack_segment+0x22/0x30
> [ 2224.757999]  ? rcu_do_batch+0x1a7/0x530
> [ 2224.758549]  ? refill_obj_stock+0x40/0x170
> [ 2224.759125]  __memcg_slab_free_hook+0xb0/0x140
> [ 2224.759723]  kmem_cache_free+0x3b2/0x3e0
> [ 2224.760292]  ? rcu_do_batch+0x1a7/0x530
> [ 2224.760845]  rcu_do_batch+0x1a7/0x530
> [ 2224.761399]  ? rcu_do_batch+0x13b/0x530
> [ 2224.761950]  rcu_core+0x256/0x420
> [ 2224.762475]  ? ktime_get+0x34/0xc0
> [ 2224.763010]  handle_softirqs+0xd3/0x2b0
> [ 2224.763573]  __irq_exit_rcu+0x9b/0xc0
> [ 2224.764118]  sysvec_apic_timer_interrupt+0x71/0x90
> [ 2224.764738]  </IRQ>
> [ 2224.765159]  <TASK>
> [ 2224.765594]  asm_sysvec_apic_timer_interrupt+0x16/0x20
> [ 2224.766163] RIP: 0010:mem_cgroup_from_slab_obj+0x51/0x130
> [ 2224.766750] Code: 01 c8 48 8b 35 58 9d 28 01 48 c1 e8 0c 48 c1 e0 06 48 01 f0 48 8b 78 08 48 89 c1 40 f6 c7 01 0f 85 cd 00 00 00 66 90 8b 41 30 <25> 00 10 00 f0 3d 00 00 00 f0 74 45 48 8b 51 38 f6 c2 01 75 15 48
> [ 2224.768355] RSP: 0018:ffffa502403cfa70 EFLAGS: 00000202
> [ 2224.768994] RAX: 00000000ffffefff RBX: ffff977b9fbb7000 RCX: ffffc69214c0b500
> [ 2224.769747] RDX: ffff977f302d6a40 RSI: ffffc69200000000 RDI: ffffc69214c0b501
> [ 2224.770504] RBP: ffff977f302d6a40 R08: ffff977f300e58c8 R09: ffff977f300e58c8
> [ 2224.771246] R10: 0000000000000000 R11: ffffa502403cf900 R12: ffff977b9fbb7498
> [ 2224.771974] R13: 0000000000000000 R14: ffff977b9fbb7070 R15: 0000000000000000
> [ 2224.772678]  list_lru_add_obj+0x6b/0xa0
> [ 2224.773158]  iput+0x1f1/0x210
> [ 2224.773596]  __dentry_kill+0x71/0x170
> [ 2224.774055]  shrink_dentry_list+0x67/0xe0
> [ 2224.774542]  prune_dcache_sb+0x54/0x80
> [ 2224.774996]  super_cache_scan+0x120/0x1c0
> [ 2224.775470]  do_shrink_slab+0x134/0x350
> [ 2224.775916]  shrink_slab_memcg+0x199/0x2c0
> [ 2224.776387]  shrink_one+0x118/0x1b0
> [ 2224.776845]  shrink_many+0x127/0x2a0
> [ 2224.777314]  shrink_node+0x3d7/0x430
> [ 2224.777765]  ? pick_next_task+0x5a/0xae0
> [ 2224.778250]  balance_pgdat+0x29c/0x730
> [ 2224.778704]  ? __try_to_del_timer_sync+0x62/0xa0
> [ 2224.779227]  ? __pfx_kswapd+0x10/0x10
> [ 2224.779674]  kswapd+0xf7/0x180
> [ 2224.780082]  kthread+0xcc/0x100
> [ 2224.780483]  ? __pfx_kthread+0x10/0x10
> [ 2224.780887]  ret_from_fork+0x2d/0x50
> [ 2224.781297]  ? __pfx_kthread+0x10/0x10
> [ 2224.781703]  ret_from_fork_asm+0x1a/0x30
> [ 2224.782118]  </TASK>
> [ 2224.782451] Modules linked in: udp_diag(E) tcp_diag(E) inet_diag(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) binfmt_misc(E) zram(E) tls(E) isofs(E) intel_rapl_msr(E) intel_rapl_common(E) kvm_amd(E) ccp(E) kvm(E) virtio_gpu(E) virtio_net(E) i2c_i801(E) i2c_smbus(E) net_failover(E) failover(E) dimlib(E) virtio_dma_buf(E) virtio_balloon(E) vfat(E) fat(E) fuse(E) ext4(E) mbcache(E) jbd2(E) sr_mod(E) cdrom(E) sg(E) ahci(E) libahci(E) libata(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha512_ssse3(E) virtio_blk(E) serio_raw(E) btrfs(E) xor(E) zstd_compress(E) raid6_pq(E) libcrc32c(E) crc32c_intel(E) dm_mirror(E) dm_region_hash(E) dm_log(E) dm_mod(E)
> [ 2224.782487] Unloaded tainted modules: amd_atl(E):2 edac_mce_amd(E):1 padlock_aes(E):3
> [ 2224.787698] ---[ end trace 0000000000000000 ]---
> [ 2224.788286] RIP: 0010:refill_obj_stock+0x40/0x170
> [ 2224.788860] Code: 5c fa 65 48 8b 05 c8 c4 bd 77 4c 8d b8 60 12 03 00 49 8b 47 10 48 39 f8 74 5d 4c 89 ff e8 78 ed ff ff 49 89 c6 e8 f0 34 d7 ff <48> 8b 45 00 a8 03 0f 85 ca 00 00 00 65 48 ff 00 e8 ab 74 d7 ff 49
> [ 2224.790600] RSP: 0018:ffffa5024010ce10 EFLAGS: 00010002
> [ 2224.791230] RAX: 0000000000000002 RBX: 00000000000000c8 RCX: 00002d82d4038240
> [ 2224.791924] RDX: ffff977b00aa9a00 RSI: 0000000000000001 RDI: ffff977b00aa9a00
> [ 2224.792610] RBP: a91ef76620614d85 R08: 0000000000000001 R09: ffffffff881b9077
> [ 2224.793303] R10: 0000000000040000 R11: 0000000000000000 R12: 0000000000000282
> [ 2224.793985] R13: ffff977b00235c00 R14: ffff977baa14e280 R15: ffff977f6bd31260
> [ 2224.794681] FS:  0000000000000000(0000) GS:ffff977f6bd00000(0000) knlGS:0000000000000000
> [ 2224.795439] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2224.796117] CR2: 00007f2d7e5dc000 CR3: 0000000222340005 CR4: 0000000000770ef0
> [ 2224.796887] PKRU: 55555554
> [ 2224.797384] Kernel panic - not syncing: Fatal exception in interrupt
> [ 2224.798304] Kernel Offset: 0x7000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [ 2224.799190] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
> 

