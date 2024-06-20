Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7A214F9E5
	for <virtualization@lists.linux-foundation.org>; Thu, 20 Jun 2024 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718874328; cv=none; b=Z5i4HWs9bsaQd8HdDuVywvmHYF4N4obe8+hpO6iSvFpHqaNytSZgT2euldqMVmSsVUQ56XOUE1SM9JQbcnrkH+7aLV/k8/A1aYIWSGY21BW1Qkx45LedkR9VYPH43exgBdyiigfJiSGj63JfmEDpMElPERLJIMUhrr3BUwdOfM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718874328; c=relaxed/simple;
	bh=c1CWWqhz8yPbmqdNSs0zmRLmXvwU9s56TLA2bLWTJKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=F2C1zslCA7MwbIeED4o5W/Cvrmc4xcgvhq3FaBuK3eHaiilhJDzGf6cP8N5wqdOhKhihtAJ+GQsNrANTmrNrYBq5UEfsKhpysOpIqe3BaVPScsKGi45pKQHt+zHT53noj/T/68zhVno8PHmiOvzcuSQq7VRG3evX4XdreosT/U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NdYnZTx6; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NdYnZTx6"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5A22384620
	for <virtualization@lists.linux-foundation.org>; Thu, 20 Jun 2024 09:05:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5TRCD12P48WV for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jun 2024 09:05:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E97ED8461F
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E97ED8461F
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NdYnZTx6
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E97ED8461F
	for <virtualization@lists.linux-foundation.org>; Thu, 20 Jun 2024 09:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718874323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bAre/i8vfZApAeoujq+FeNQn6RSAPR+2/C7zMKsEabw=;
	b=NdYnZTx6Jum6RDJrKmCfkGNDYHM9N60LLT8fHVgSQgGpGToH79g5KejM1/77b5lI+nDmN6
	yXk6jFNgzftUrT34UhAasQLIB3B3P1ky797mTzWBmoCcsQ+H4l+AT22vm8i2+egAu6LRDB
	aMmmkufweM0D0Ne5M1olFhjHMrjOi4c=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-hLHjzq-rMvmfiNoXX6Aaxg-1; Thu, 20 Jun 2024 05:05:22 -0400
X-MC-Unique: hLHjzq-rMvmfiNoXX6Aaxg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-57cb86ffb3eso260898a12.0
        for <virtualization@lists.linux-foundation.org>; Thu, 20 Jun 2024 02:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718874321; x=1719479121;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bAre/i8vfZApAeoujq+FeNQn6RSAPR+2/C7zMKsEabw=;
        b=YzMA6GDoAFTeL9pSHHH853SFjQXmrwHsDSWUjU5IlTnAHSsqMMGTJbB0pPxA1rbM1O
         U+af+S97+DzCPrhhTgmSHVfqdklU1iGGuv3A0vNS1t1MILHfPglErqiXUArwCmr0w9pG
         cnaXjLhItvsPM8N5zug8hA8W7eupg1TAMmlVNtvvQudRnTey5atomygw1yb65zsMWurV
         +aBitQqmS9QrIYHnS0ZVM71Dk/bVDt7P4hN9qiHzjqSZsbHjVJ6O+IN0VFSLv/KgPQPh
         spgRoOYzboERxtsAYqr0o0BGWXKew/qoI4/WSbCMLdBzZ7FmvAnqMjCPtP7Nvdjne13A
         Arbg==
X-Forwarded-Encrypted: i=1; AJvYcCUGqNeM4Ctv/T99EgJMdJjry1fF6eMGDxcFNYecdSB36xPk+n1AoJ/IBPgtXgQlXinedKABuyFWJvTPvZ8QUZGCZLl9pdWtRg569ESLtpRuTERQR/WL4ieDmA==
X-Gm-Message-State: AOJu0YwSATx+2evjdWJyf+tLEanKIGiwkb4Q3wH1DYTKPFzOe+LoyoPk
	kaS8VZKt/JKBSlDKv1CKTzPY3sRBvvIGcutl8XaIcM9yPIZ4hvY31uY4gbgtFon021BpRTco/XU
	JCN0O3PdRwq85p67iyIAwYdCxG5Sc4A2T12OnxSB/7KvybTufBlqG5qXvx+IOQiwOcWFPc8lPPx
	XccWc=
X-Received: by 2002:a50:cc98:0:b0:57c:9c5d:d18e with SMTP id 4fb4d7f45d1cf-57d07edcf80mr3243492a12.36.1718874320964;
        Thu, 20 Jun 2024 02:05:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1VzMdYzAGcAQ2/MY1LW4yoqahgiHfGuVDtINBpnKcNT1qhfm3UhHoXiSHFFSqa3IzFXXvvA==
X-Received: by 2002:a50:cc98:0:b0:57c:9c5d:d18e with SMTP id 4fb4d7f45d1cf-57d07edcf80mr3243444a12.36.1718874320043;
        Thu, 20 Jun 2024 02:05:20 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72cdf2bsm9408395a12.17.2024.06.20.02.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 02:05:19 -0700 (PDT)
Date: Thu, 20 Jun 2024 05:05:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"peterx@redhat.com" <peterx@redhat.com>
Subject: Re: mmap_assert_write_locked warnings during for vhost_vdpa_fault
Message-ID: <20240620050436-mutt-send-email-mst@kernel.org>
References: <11b31b8372331256a66594ebc62fe322098d2b4e.camel@nvidia.com>
 <CACGkMEvtgChCeyWon87sqpN0cY6TQpb1Y7iVxbDuupgbYiEUpQ@mail.gmail.com>
 <BN9PR11MB52768C001E84D048B12F8FE88CCE2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <CACGkMEtQ75NZqoYFTRB5gP81ZHpYAxPPCTiL5+kT_yRiyr138A@mail.gmail.com>
 <8e540d6f7936852543957970797012ddb351d64d.camel@nvidia.com>
 <20240619055112-mutt-send-email-mst@kernel.org>
 <CACGkMEsQuGdKPO1X=MLWjnynL3D_A9tPa0S4LFWDfRepL85aNg@mail.gmail.com>
 <20240620013741-mutt-send-email-mst@kernel.org>
 <CACGkMEvdsNi2Fd0ZoPJVZUARSRvNqJa4jVxE=8RCWr=dk2_kug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvdsNi2Fd0ZoPJVZUARSRvNqJa4jVxE=8RCWr=dk2_kug@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jun 20, 2024 at 04:23:30PM +0800, Jason Wang wrote:
> On Thu, Jun 20, 2024 at 1:44 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Jun 20, 2024 at 12:07:14PM +0800, Jason Wang wrote:
> > > On Wed, Jun 19, 2024 at 5:52 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Wed, Jun 19, 2024 at 09:14:41AM +0000, Dragos Tatulea wrote:
> > > > > On Tue, 2024-06-18 at 10:39 +0800, Jason Wang wrote:
> > > > > > On Tue, Jun 18, 2024 at 10:03 AM Tian, Kevin <kevin.tian@intel.com> wrote:
> > > > > > >
> > > > > > > > From: Jason Wang <jasowang@redhat.com>
> > > > > > > > Sent: Tuesday, June 18, 2024 9:18 AM
> > > > > > > >
> > > > > > > > On Mon, Jun 17, 2024 at 11:51 PM Dragos Tatulea <dtatulea@nvidia.com>
> > > > > > > > wrote:
> > > > > > > > >
> > > > > > > > > Hi,
> > > > > > > > >
> > > > > > > > > After commit ba168b52bf8e "mm: use rwsem assertion macros for
> > > > > > > > > mmap_lock") was submitted, we started getting a lot of the
> > > > > > > > > following warnings about a missing mmap write lock during VM boot:
> > > > > > > > >
> > > > > > > > > ------------[ cut here ]------------
> > > > > > > > > WARNING: CPU: 1 PID: 58633 at include/linux/rwsem.h:85
> > > > > > > > > track_pfn_remap+0x12b/0x130
> > > > > > > > > Modules linked in: act_mirred act_skbedit vhost_vdpa cls_matchall
> > > > > > > > > nfnetlink_cttimeout act_gact cls_flower sch_ingress mlx5_vdpa vringh vdpa
> > > > > > > > > openvswitch nsh vhost_net vhost vhost_iotlb tap ip6table_mangle
> > > > > > > > ip6table_nat
> > > > > > > > > iptable_mangle nf_tables ip6table_filter ip6_tables xt_conntrack
> > > > > > > > xt_MASQUERADE
> > > > > > > > > nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat br_netfilter
> > > > > > > > > rpcsec_gss_krb5 auth_rpcgss oid_registry overlay rpcrdma rdma_ucm
> > > > > > > > ib_iser
> > > > > > > > > libiscsi ib_umad scsi_transport_iscsi ib_ipoib rdma_cm iw_cm ib_cm
> > > > > > > > mlx5_ib
> > > > > > > > > ib_uverbs ib_core fuse mlx5_core
> > > > > > > > > CPU: 1 PID: 58633 Comm: CPU 0/KVM Tainted: G        W
> > > > > > > > > 6.10.0-rc1_for_upstream_min_debug_2024_05_29_17_06 #1
> > > > > > > > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> > > > > > > > > rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> > > > > > > > > RIP: 0010:track_pfn_remap+0x12b/0x130
> > > > > > > > > Code: 48 83 c4 08 b8 ea ff ff ff 5b 5d 41 5c 41 5d c3 48 83 c4 08 48 89 ef 48
> > > > > > > > > 89 f2 5b 31 c9 4c 89 c6 5d 41 5c 41 5d e9 f5 fb ff ff <0f> 0b eb 9b 90 0f 1f 44
> > > > > > > > > 00 00 80 3d ac 59 96 01 00 74 01 c3 48 89
> > > > > > > > > RSP: 0018:ffff888350f8b8e0 EFLAGS: 00010246
> > > > > > > > > RAX: 0000000000000000 RBX: 0000000000001000 RCX: 0000000000000000
> > > > > > > > > RDX: ffff8881080ca300 RSI: 0000000000001000 RDI: 0000000544003000
> > > > > > > > > RBP: 0000000544003000 R08: ffff888106730a60 R09: 0000000000000000
> > > > > > > > > R10: ffff888116eeff60 R11: 0000000000000000 R12: ffff888350f8b918
> > > > > > > > > R13: ffff888149f99da8 R14: 0000000000001000 R15: 0000000000001000
> > > > > > > > > FS:  00007f678d800700(0000) GS:ffff88852c880000(0000)
> > > > > > > > knlGS:0000000000000000
> > > > > > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > > > > CR2: 00000000004e54f8 CR3: 0000000112290004 CR4: 0000000000372eb0
> > > > > > > > > Call Trace:
> > > > > > > > >  <TASK>
> > > > > > > > >  ? __warn+0x78/0x110
> > > > > > > > >  ? track_pfn_remap+0x12b/0x130
> > > > > > > > >  ? report_bug+0x16d/0x180
> > > > > > > > >  ? handle_bug+0x3c/0x60
> > > > > > > > >  ? exc_invalid_op+0x14/0x70
> > > > > > > > >  ? asm_exc_invalid_op+0x16/0x20
> > > > > > > > >  ? track_pfn_remap+0x12b/0x130
> > > > > > > > >  remap_pfn_range+0x41/0xa0
> > > > > > > > >  vhost_vdpa_fault+0x6c/0xa0 [vhost_vdpa]
> > > > > > > > >  __do_fault+0x2f/0xb0
> > > > > > > > >  __handle_mm_fault+0x13d3/0x2210
> > > > > > > > >  handle_mm_fault+0xb0/0x260
> > > > > > > > >  fixup_user_fault+0x77/0x170
> > > > > > > > >  hva_to_pfn+0x2c5/0x4b0
> > > > > > > > >  kvm_faultin_pfn+0xd7/0x510
> > > > > > > > >  kvm_tdp_page_fault+0x111/0x190
> > > > > > > > >  kvm_mmu_do_page_fault+0x105/0x230
> > > > > > > > >  kvm_mmu_page_fault+0x7d/0x620
> > > > > > > > >  ? vmx_deliver_interrupt+0x110/0x190
> > > > > > > > >  ? __apic_accept_irq+0x16c/0x270
> > > > > > > > >  ? vmx_vmexit+0x8d/0xc0
> > > > > > > > >  vmx_handle_exit+0x110/0x640
> > > > > > > > >  kvm_arch_vcpu_ioctl_run+0xdb0/0x1c20
> > > > > > > > >  kvm_vcpu_ioctl+0x263/0x6a0
> > > > > > > > >  ? futex_wake+0x81/0x180
> > > > > > > > >  __x64_sys_ioctl+0x4a7/0x9d0
> > > > > > > > >  ? __x64_sys_futex+0x73/0x1c0
> > > > > > > > >  ? kvm_on_user_return+0x86/0x90
> > > > > > > > >  do_syscall_64+0x4c/0x100
> > > > > > > > >  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> > > > > > > > > RIP: 0033:0x7f679186a17b
> > > > > > > > > Code: 0f 1e fa 48 8b 05 1d ad 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff
> > > > > > > > > c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01
> > > > > > > > > c3 48 8b 0d ed ac 0c 00 f7 d8 64 89 01 48
> > > > > > > > > RSP: 002b:00007f678d7ff788 EFLAGS: 00000246 ORIG_RAX:
> > > > > > > > 0000000000000010
> > > > > > > > > RAX: ffffffffffffffda RBX: 000000000000ae80 RCX: 00007f679186a17b
> > > > > > > > > RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000059
> > > > > > > > > RBP: 000055da5ee22050 R08: 000055da44b28160 R09: 0000000000000000
> > > > > > > > > R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
> > > > > > > > > R13: 000055da452b05e0 R14: 0000000000000001 R15: 0000000000000000
> > > > > > > > >  </TASK>
> > > > > > > > > ---[ end trace 0000000000000000 ]---
> > > > > > > > >
> > > > > > > > > The warnings show up only when the vdpa page-per-vq option is used
> > > > > > > > (doorbell
> > > > > > > > > mapping to guest).
> > > > > > > > >
> > > > > > > > > The issue seems to have existed before, but was visible only with
> > > > > > > > CONFIG_LOCKDEP
> > > > > > > > > enabled. I tried finding if this was introduced in more recent kernels, but
> > > > > > > > > stopped after going as far back as 6.5: the issue was still visible there.
> > > > > > > > >
> > > > > > > > > The warning is triggered for the following call chain:
> > > > > > > > > vhost_vdpa_fault()
> > > > > > > > >  -> remap_pfn_range()
> > > > > > > > >   -> remap_pfn_range_notrack()
> > > > > > > > >    -> vm_flags_set()
> > > > > > > > >     -> vma_start_write()
> > > > > > > > >      -> __is_vma_write_locked()
> > > > > > > > >       -> mmap_assert_write_locked()
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > I've been trying to follow how the mm write lock is dropped in the above
> > > > > > > > call
> > > > > > > > > chain or not taken at all. But I couldn't make much sense of it...
> > > > > > > >
> > > > > > > > I've also had a glance at vfio_pci_mmap_fault, it seems to do something
> > > > > > > > similar.
> > > > > > > >
> > > > > > > > > Any ideas of what could have gone wrong here?
> > > > > > > >
> > > > > > > > Adding Peter for more thought here.
> > > > > > > >
> > > > > > >
> > > > > > > vfio-side fix was just queued for rc4:
> > > > > > >
> > > > > > > https://lore.kernel.org/all/20240614155603.34567eb7.alex.williamson@redhat.com/T/
> > > > > >
> > > > > > Great, thanks for the pointer.
> > > > > >
> > > > > Yes, thanks!
> > > > >
> > > > > > Dragos, do you want to propose a similar fix for vDPA?
> > > > > >
> > > > > Had a first look: the fixes look a bit daunting. I will to "port" them, not
> > > > > promising anything though.
> > > > >
> > > > > Thanks,
> > > > > Dragos
> > > >
> > > > Yea Jason, you coded this in ddd89d0a059d8e9740c75a97e0efe9bf07ee51f9,
> > > > seems a bit much to ask from a random reporter,
> > >
> > > Probably, just asking since Dragos has done some investigation.
> > >
> > > > this race
> > > > likely can bite anyone.
> > > >
> > >
> > > Dragos, I've drafted a patch, please try to see if it works (I had
> > > tested it with LOCKDEP via vp_vdpa in L2).
> > >
> > > Thanks
> >
> > What is going on here that you decided to do an attachment as
> > opposed to inlining normally?
> 
> Actually, I plan to send a formal patch separately but stop at the
> last seconds since it is just tested by L2 + vp_vdpa in L1.

tag it as RFC, explain the testing status in the mail.

> If inline really matters, I will do that next time.


yes, this way people can comment.

> Thanks
> 
> >
> > --
> > MST
> >

