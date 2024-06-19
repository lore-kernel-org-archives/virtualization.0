Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C8E12D758
	for <virtualization@lists.linux-foundation.org>; Wed, 19 Jun 2024 09:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718790736; cv=none; b=oRbusn4+Z3v91/buxBhltnYT6f/kmwx5ESTqyt7Nl+i+M/vQcJ6VmAcm3QVQNXnLbGwT3VD6dCULekkKZ8sBpVLspIvBSmefOXQYcX1bkLtcA0y4PGX4hKNmXDRmAFuirHxOHxYs4klHWk4nyU8KXzogWaqgHe+zX6HNnRVYITo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718790736; c=relaxed/simple;
	bh=7VwQNSXXChoOZBOTUZf7CX+4XipgXxKDfLyf3nwYNKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CSwk8y8S7zoMqGC99ZklLmCFIXgJsAi+f9wtaxEFwpI4QSH3lEUmRKYs4g/J0D8qLeRN285O+9Mia8ufAOMVZsm7iDxPrUlQ628/HERWtumBRI8g7BccD130igHmURKXQ/6Ngu2s6eSDTnzKn7ZlBx9FxTBD6rdBCTzmfsFMZB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CIGLVDsD; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CIGLVDsD"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 51F4F841FD
	for <virtualization@lists.linux-foundation.org>; Wed, 19 Jun 2024 09:52:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IsuMRn0y1pNv for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jun 2024 09:52:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2A0D883B1C
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2A0D883B1C
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CIGLVDsD
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2A0D883B1C
	for <virtualization@lists.linux-foundation.org>; Wed, 19 Jun 2024 09:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718790731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0rD1+HyIKLxD4toPL7WgBLLur+GWSa6LHhD3Ikmrd6Q=;
	b=CIGLVDsD8xu5+T1pd/AFHfS+EZ0OA8nRbtqHPAsGm9v9EmzGamey+DhftQTui0Inee5Tv5
	dkqiYVKLlRtos8fuVpLVG+KobD3xi/TfWV/TwbAYrOYqJLUaV29PCI2UmrC4PXymw2XOl+
	Sj0gm0kxjqBX7yBFRlQ8bmygtATpusE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-59o39XJdMCO22hu03MovTw-1; Wed, 19 Jun 2024 05:52:09 -0400
X-MC-Unique: 59o39XJdMCO22hu03MovTw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4217f941ca8so41174385e9.1
        for <virtualization@lists.linux-foundation.org>; Wed, 19 Jun 2024 02:52:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718790728; x=1719395528;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0rD1+HyIKLxD4toPL7WgBLLur+GWSa6LHhD3Ikmrd6Q=;
        b=Gi3KAOnxzHvnIZg6OnnQPbEzzKHoeXuhTVbK5h9mk/NB4f2Mb8IqOrkWRs78GgSRcM
         NRypRDKb69VAKrb4WEThdQEmy7wlsX8/LgiWikdhVuZYJ/PkHyFFsAg5K+IO6rF4els5
         ZyZul0EQeWIKQ98bE+9dNqZAVxN7N887dNsLQQonOdd9+8KR/4WbUDAij6KPoNfuYgGC
         PGUD3VOs6vd85CwtZZ/96nmix3B50lE5REaoOC1nQo2NmN4et8ng7qv3gcQCB0IlZ0Ny
         4KetZumX2ayRd1wj225UUrguQq+HcqGzRhWWcOAxJ+TnzbGiJqI9fCKOVt9h38Ug5Y+S
         4Mvw==
X-Forwarded-Encrypted: i=1; AJvYcCXQ4VjubiKAB8jR1PfQoYt4xT70Mi0S2GUKCvo4H9jFrZZGpwWmNpcEcaNJf14OKtnHbn5BOKugdolO2l5xKoZEw9j+ZUMnuu8DW4ONqaIjMnfr1jHjpwAgKQ==
X-Gm-Message-State: AOJu0YxKiqV0gOL9Yv9gTYq7YuLoZpe4Jg+3S8Uy2FdEzsEfwuj1Sqr6
	AMUotj3y+rPu5x60XyXLjmBoYnvyuBhZJPorX1+x1H2ydf4F9t5EIYg09iceM6vmxJ33CUF8cUJ
	U5G5L5bR1EzYBqu0BN1m99xypwqBtirrQPpBL4rIHipxqYAORXPWg7DwZvakr3NprPIZW2PNBuZ
	M2GZM=
X-Received: by 2002:a05:600c:2252:b0:424:798a:f7ff with SMTP id 5b1f17b1804b1-424798afeaemr5116625e9.8.1718790728467;
        Wed, 19 Jun 2024 02:52:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM/ws1YeKO4TJCpKXtLfME/GqtenLwS8c/M6b3OX8rTE9AJoM4DcTwnyr6HSTgs4Hf7MNkpw==
X-Received: by 2002:a05:600c:2252:b0:424:798a:f7ff with SMTP id 5b1f17b1804b1-424798afeaemr5116385e9.8.1718790727747;
        Wed, 19 Jun 2024 02:52:07 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874de62fsm261026565e9.38.2024.06.19.02.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 02:52:06 -0700 (PDT)
Date: Wed, 19 Jun 2024 05:51:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "kevin.tian@intel.com" <kevin.tian@intel.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"peterx@redhat.com" <peterx@redhat.com>
Subject: Re: mmap_assert_write_locked warnings during for vhost_vdpa_fault
Message-ID: <20240619055112-mutt-send-email-mst@kernel.org>
References: <11b31b8372331256a66594ebc62fe322098d2b4e.camel@nvidia.com>
 <CACGkMEvtgChCeyWon87sqpN0cY6TQpb1Y7iVxbDuupgbYiEUpQ@mail.gmail.com>
 <BN9PR11MB52768C001E84D048B12F8FE88CCE2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <CACGkMEtQ75NZqoYFTRB5gP81ZHpYAxPPCTiL5+kT_yRiyr138A@mail.gmail.com>
 <8e540d6f7936852543957970797012ddb351d64d.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <8e540d6f7936852543957970797012ddb351d64d.camel@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jun 19, 2024 at 09:14:41AM +0000, Dragos Tatulea wrote:
> On Tue, 2024-06-18 at 10:39 +0800, Jason Wang wrote:
> > On Tue, Jun 18, 2024 at 10:03 AM Tian, Kevin <kevin.tian@intel.com> wrote:
> > > 
> > > > From: Jason Wang <jasowang@redhat.com>
> > > > Sent: Tuesday, June 18, 2024 9:18 AM
> > > > 
> > > > On Mon, Jun 17, 2024 at 11:51 PM Dragos Tatulea <dtatulea@nvidia.com>
> > > > wrote:
> > > > > 
> > > > > Hi,
> > > > > 
> > > > > After commit ba168b52bf8e "mm: use rwsem assertion macros for
> > > > > mmap_lock") was submitted, we started getting a lot of the
> > > > > following warnings about a missing mmap write lock during VM boot:
> > > > > 
> > > > > ------------[ cut here ]------------
> > > > > WARNING: CPU: 1 PID: 58633 at include/linux/rwsem.h:85
> > > > > track_pfn_remap+0x12b/0x130
> > > > > Modules linked in: act_mirred act_skbedit vhost_vdpa cls_matchall
> > > > > nfnetlink_cttimeout act_gact cls_flower sch_ingress mlx5_vdpa vringh vdpa
> > > > > openvswitch nsh vhost_net vhost vhost_iotlb tap ip6table_mangle
> > > > ip6table_nat
> > > > > iptable_mangle nf_tables ip6table_filter ip6_tables xt_conntrack
> > > > xt_MASQUERADE
> > > > > nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat br_netfilter
> > > > > rpcsec_gss_krb5 auth_rpcgss oid_registry overlay rpcrdma rdma_ucm
> > > > ib_iser
> > > > > libiscsi ib_umad scsi_transport_iscsi ib_ipoib rdma_cm iw_cm ib_cm
> > > > mlx5_ib
> > > > > ib_uverbs ib_core fuse mlx5_core
> > > > > CPU: 1 PID: 58633 Comm: CPU 0/KVM Tainted: G        W
> > > > > 6.10.0-rc1_for_upstream_min_debug_2024_05_29_17_06 #1
> > > > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> > > > > rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> > > > > RIP: 0010:track_pfn_remap+0x12b/0x130
> > > > > Code: 48 83 c4 08 b8 ea ff ff ff 5b 5d 41 5c 41 5d c3 48 83 c4 08 48 89 ef 48
> > > > > 89 f2 5b 31 c9 4c 89 c6 5d 41 5c 41 5d e9 f5 fb ff ff <0f> 0b eb 9b 90 0f 1f 44
> > > > > 00 00 80 3d ac 59 96 01 00 74 01 c3 48 89
> > > > > RSP: 0018:ffff888350f8b8e0 EFLAGS: 00010246
> > > > > RAX: 0000000000000000 RBX: 0000000000001000 RCX: 0000000000000000
> > > > > RDX: ffff8881080ca300 RSI: 0000000000001000 RDI: 0000000544003000
> > > > > RBP: 0000000544003000 R08: ffff888106730a60 R09: 0000000000000000
> > > > > R10: ffff888116eeff60 R11: 0000000000000000 R12: ffff888350f8b918
> > > > > R13: ffff888149f99da8 R14: 0000000000001000 R15: 0000000000001000
> > > > > FS:  00007f678d800700(0000) GS:ffff88852c880000(0000)
> > > > knlGS:0000000000000000
> > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > CR2: 00000000004e54f8 CR3: 0000000112290004 CR4: 0000000000372eb0
> > > > > Call Trace:
> > > > >  <TASK>
> > > > >  ? __warn+0x78/0x110
> > > > >  ? track_pfn_remap+0x12b/0x130
> > > > >  ? report_bug+0x16d/0x180
> > > > >  ? handle_bug+0x3c/0x60
> > > > >  ? exc_invalid_op+0x14/0x70
> > > > >  ? asm_exc_invalid_op+0x16/0x20
> > > > >  ? track_pfn_remap+0x12b/0x130
> > > > >  remap_pfn_range+0x41/0xa0
> > > > >  vhost_vdpa_fault+0x6c/0xa0 [vhost_vdpa]
> > > > >  __do_fault+0x2f/0xb0
> > > > >  __handle_mm_fault+0x13d3/0x2210
> > > > >  handle_mm_fault+0xb0/0x260
> > > > >  fixup_user_fault+0x77/0x170
> > > > >  hva_to_pfn+0x2c5/0x4b0
> > > > >  kvm_faultin_pfn+0xd7/0x510
> > > > >  kvm_tdp_page_fault+0x111/0x190
> > > > >  kvm_mmu_do_page_fault+0x105/0x230
> > > > >  kvm_mmu_page_fault+0x7d/0x620
> > > > >  ? vmx_deliver_interrupt+0x110/0x190
> > > > >  ? __apic_accept_irq+0x16c/0x270
> > > > >  ? vmx_vmexit+0x8d/0xc0
> > > > >  vmx_handle_exit+0x110/0x640
> > > > >  kvm_arch_vcpu_ioctl_run+0xdb0/0x1c20
> > > > >  kvm_vcpu_ioctl+0x263/0x6a0
> > > > >  ? futex_wake+0x81/0x180
> > > > >  __x64_sys_ioctl+0x4a7/0x9d0
> > > > >  ? __x64_sys_futex+0x73/0x1c0
> > > > >  ? kvm_on_user_return+0x86/0x90
> > > > >  do_syscall_64+0x4c/0x100
> > > > >  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> > > > > RIP: 0033:0x7f679186a17b
> > > > > Code: 0f 1e fa 48 8b 05 1d ad 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff
> > > > > c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01
> > > > > c3 48 8b 0d ed ac 0c 00 f7 d8 64 89 01 48
> > > > > RSP: 002b:00007f678d7ff788 EFLAGS: 00000246 ORIG_RAX:
> > > > 0000000000000010
> > > > > RAX: ffffffffffffffda RBX: 000000000000ae80 RCX: 00007f679186a17b
> > > > > RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000059
> > > > > RBP: 000055da5ee22050 R08: 000055da44b28160 R09: 0000000000000000
> > > > > R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
> > > > > R13: 000055da452b05e0 R14: 0000000000000001 R15: 0000000000000000
> > > > >  </TASK>
> > > > > ---[ end trace 0000000000000000 ]---
> > > > > 
> > > > > The warnings show up only when the vdpa page-per-vq option is used
> > > > (doorbell
> > > > > mapping to guest).
> > > > > 
> > > > > The issue seems to have existed before, but was visible only with
> > > > CONFIG_LOCKDEP
> > > > > enabled. I tried finding if this was introduced in more recent kernels, but
> > > > > stopped after going as far back as 6.5: the issue was still visible there.
> > > > > 
> > > > > The warning is triggered for the following call chain:
> > > > > vhost_vdpa_fault()
> > > > >  -> remap_pfn_range()
> > > > >   -> remap_pfn_range_notrack()
> > > > >    -> vm_flags_set()
> > > > >     -> vma_start_write()
> > > > >      -> __is_vma_write_locked()
> > > > >       -> mmap_assert_write_locked()
> > > > > 
> > > > > 
> > > > > I've been trying to follow how the mm write lock is dropped in the above
> > > > call
> > > > > chain or not taken at all. But I couldn't make much sense of it...
> > > > 
> > > > I've also had a glance at vfio_pci_mmap_fault, it seems to do something
> > > > similar.
> > > > 
> > > > > Any ideas of what could have gone wrong here?
> > > > 
> > > > Adding Peter for more thought here.
> > > > 
> > > 
> > > vfio-side fix was just queued for rc4:
> > > 
> > > https://lore.kernel.org/all/20240614155603.34567eb7.alex.williamson@redhat.com/T/
> > 
> > Great, thanks for the pointer.
> > 
> Yes, thanks!
> 
> > Dragos, do you want to propose a similar fix for vDPA?
> > 
> Had a first look: the fixes look a bit daunting. I will to "port" them, not
> promising anything though.
> 
> Thanks,
> Dragos

Yea Jason, you coded this in ddd89d0a059d8e9740c75a97e0efe9bf07ee51f9,
seems a bit much to ask from a random reporter, this race
likely can bite anyone.

