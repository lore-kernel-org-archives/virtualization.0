Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB134C9D
	for <virtualization@lists.linux-foundation.org>; Tue, 18 Jun 2024 02:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718678394; cv=none; b=Wm+BcIF+ny3f9dLk9b0/isCzxrGnJOQea4mrM3X5ugxBSbZK39Zx+lhq82qZ/1kAh6uLRD8pw5SCg8M7QwM5hk3j8y4PlmT4oxdLaLJbC8t2mDcm2KGXjuwNs4I/KyETn7KFpMGZTcwSDyEPkkIuRJ8KVFZQbW45PAKnuzgD9no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718678394; c=relaxed/simple;
	bh=XIyXcsSgRMJlCUHVcdEI+0cFaN7G2P1AMcnsytRJ/U8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NoFZc9160qLnuBxb8m2LJxYI/4MJJoo4qDhWpsDVs21rF93qPUxsmRkUPCD3jLU+U9uq6hkH4ZafYdoQMVu3T+X6MvJnjuAKwq8WYcmaPdtbuePwTgQFY/F2uDbs2J9A5GVoMOEhkGWr4gMufA+eEGMVGvC2DOJIrlmLN1r2fT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IJammFrH; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJammFrH"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 22CE940231
	for <virtualization@lists.linux-foundation.org>; Tue, 18 Jun 2024 02:39:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lkrpsA5yOiao for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jun 2024 02:39:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 664A8401D8
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 664A8401D8
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IJammFrH
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 664A8401D8
	for <virtualization@lists.linux-foundation.org>; Tue, 18 Jun 2024 02:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718678389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vsVZSoIRw0vYaQF0nf6l88O4g7OO2hRtP1XwFQH5oDs=;
	b=IJammFrHnEx19aR705Ac/lGR8dcPU82XkjUxxIqlh/ajP5lCMYllLGTnaTm2pIyFXU4XnS
	TQG0h2UlMXk/S93LSKoW9JB+pAQoGM9rjJMj7MEbc86jMCIQBHePi+MkJ4N9MBXl3a/2x5
	LjsOaA/letHIsvx8/HEFHZQdyJ8fh5Y=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-P5dmZl0jNU-MQczxC9tWew-1; Mon, 17 Jun 2024 22:39:47 -0400
X-MC-Unique: P5dmZl0jNU-MQczxC9tWew-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c4cffc4bc9so4906829a91.3
        for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 19:39:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718678386; x=1719283186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsVZSoIRw0vYaQF0nf6l88O4g7OO2hRtP1XwFQH5oDs=;
        b=GHy4Fwq9MKuQ8ygMvf7gqhffsAPmCJXUCo0tg4W7rKS4fGwCifk721GFv+ty5og7Ud
         +1SFBjhZGmIsVWSFD2+tgYMjIbmwTXSe6cwJ3ozSBu3Ej+2MEPUfsjodt1NoZpGmCg6P
         TWCLMAq28NtsN7hMkSo9dFHtMPH09mDsFUH3m9eV02ebXQz0zgT2OgCvvHc+LUnyo5TK
         RGkFKa8syU2Jito/IHVXu8cMBWLRIHHFC0UsfpFzQzrHKWd+Wx43fPRfpiMGaYn6Twp9
         ibBh6e2BGpkRjoWBEV6dglVWm9Y/FuE3E+9t0vTYPFHzmOWj+ZgqLm2Gz28isvT/cHy5
         T8cg==
X-Forwarded-Encrypted: i=1; AJvYcCXEvOxqG+hSoaCu1K4SGrmee8pWDBRgUr2RfVaMa3S1fejydrIpz7TnmXYOSfn4bLBPYxBbtHrlkSam0fiqaUWXSuZMwUCKyjV2/Ce0z2/lY/hd8vWqulu76Q==
X-Gm-Message-State: AOJu0Yzz/kPO91qD8NzNfl2kfs3N3Dr1zVom8YPpumF3BePstNXb4/80
	tDYTiVj/Nks9roRmi5+QLKoGbGkGy/Gyr3GzrBpf5h1mrb6h5WtHNmtRK/wWHHVt4vAsE9Mh4WW
	sE5coQNdKoJ6fjQhwSg/KgEfOahv258m3qTwvnHZSCjeHq2rqssIrCX3mMN3J14kwA8Byxsf3i+
	+Ffp6wcGA4jwCCesHXM+Shy2dLzrbY/wMuDCzEjjsECdNz4/NRM0/QfA==
X-Received: by 2002:a17:90a:4403:b0:2c4:def3:b88b with SMTP id 98e67ed59e1d1-2c4def3b98bmr11685863a91.23.1718678386193;
        Mon, 17 Jun 2024 19:39:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrKVZ1DaXzc6nwxcj5QjfJt6neBvRYDRH3qVK447gA5ciVXzAG2nQWv+zSAtbsR66MIAKKJ+rpcCuEwXkg9C8=
X-Received: by 2002:a17:90a:4403:b0:2c4:def3:b88b with SMTP id
 98e67ed59e1d1-2c4def3b98bmr11685851a91.23.1718678385791; Mon, 17 Jun 2024
 19:39:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <11b31b8372331256a66594ebc62fe322098d2b4e.camel@nvidia.com>
 <CACGkMEvtgChCeyWon87sqpN0cY6TQpb1Y7iVxbDuupgbYiEUpQ@mail.gmail.com> <BN9PR11MB52768C001E84D048B12F8FE88CCE2@BN9PR11MB5276.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB52768C001E84D048B12F8FE88CCE2@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Jun 2024 10:39:34 +0800
Message-ID: <CACGkMEtQ75NZqoYFTRB5gP81ZHpYAxPPCTiL5+kT_yRiyr138A@mail.gmail.com>
Subject: Re: mmap_assert_write_locked warnings during for vhost_vdpa_fault
To: "Tian, Kevin" <kevin.tian@intel.com>, Dragos Tatulea <dtatulea@nvidia.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "eperezma@redhat.com" <eperezma@redhat.com>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Peter Xu <peterx@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 10:03=E2=80=AFAM Tian, Kevin <kevin.tian@intel.com>=
 wrote:
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Tuesday, June 18, 2024 9:18 AM
> >
> > On Mon, Jun 17, 2024 at 11:51=E2=80=AFPM Dragos Tatulea <dtatulea@nvidi=
a.com>
> > wrote:
> > >
> > > Hi,
> > >
> > > After commit ba168b52bf8e "mm: use rwsem assertion macros for
> > > mmap_lock") was submitted, we started getting a lot of the
> > > following warnings about a missing mmap write lock during VM boot:
> > >
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 1 PID: 58633 at include/linux/rwsem.h:85
> > > track_pfn_remap+0x12b/0x130
> > > Modules linked in: act_mirred act_skbedit vhost_vdpa cls_matchall
> > > nfnetlink_cttimeout act_gact cls_flower sch_ingress mlx5_vdpa vringh =
vdpa
> > > openvswitch nsh vhost_net vhost vhost_iotlb tap ip6table_mangle
> > ip6table_nat
> > > iptable_mangle nf_tables ip6table_filter ip6_tables xt_conntrack
> > xt_MASQUERADE
> > > nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat br_netf=
ilter
> > > rpcsec_gss_krb5 auth_rpcgss oid_registry overlay rpcrdma rdma_ucm
> > ib_iser
> > > libiscsi ib_umad scsi_transport_iscsi ib_ipoib rdma_cm iw_cm ib_cm
> > mlx5_ib
> > > ib_uverbs ib_core fuse mlx5_core
> > > CPU: 1 PID: 58633 Comm: CPU 0/KVM Tainted: G        W
> > > 6.10.0-rc1_for_upstream_min_debug_2024_05_29_17_06 #1
> > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> > > rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> > > RIP: 0010:track_pfn_remap+0x12b/0x130
> > > Code: 48 83 c4 08 b8 ea ff ff ff 5b 5d 41 5c 41 5d c3 48 83 c4 08 48 =
89 ef 48
> > > 89 f2 5b 31 c9 4c 89 c6 5d 41 5c 41 5d e9 f5 fb ff ff <0f> 0b eb 9b 9=
0 0f 1f 44
> > > 00 00 80 3d ac 59 96 01 00 74 01 c3 48 89
> > > RSP: 0018:ffff888350f8b8e0 EFLAGS: 00010246
> > > RAX: 0000000000000000 RBX: 0000000000001000 RCX: 0000000000000000
> > > RDX: ffff8881080ca300 RSI: 0000000000001000 RDI: 0000000544003000
> > > RBP: 0000000544003000 R08: ffff888106730a60 R09: 0000000000000000
> > > R10: ffff888116eeff60 R11: 0000000000000000 R12: ffff888350f8b918
> > > R13: ffff888149f99da8 R14: 0000000000001000 R15: 0000000000001000
> > > FS:  00007f678d800700(0000) GS:ffff88852c880000(0000)
> > knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 00000000004e54f8 CR3: 0000000112290004 CR4: 0000000000372eb0
> > > Call Trace:
> > >  <TASK>
> > >  ? __warn+0x78/0x110
> > >  ? track_pfn_remap+0x12b/0x130
> > >  ? report_bug+0x16d/0x180
> > >  ? handle_bug+0x3c/0x60
> > >  ? exc_invalid_op+0x14/0x70
> > >  ? asm_exc_invalid_op+0x16/0x20
> > >  ? track_pfn_remap+0x12b/0x130
> > >  remap_pfn_range+0x41/0xa0
> > >  vhost_vdpa_fault+0x6c/0xa0 [vhost_vdpa]
> > >  __do_fault+0x2f/0xb0
> > >  __handle_mm_fault+0x13d3/0x2210
> > >  handle_mm_fault+0xb0/0x260
> > >  fixup_user_fault+0x77/0x170
> > >  hva_to_pfn+0x2c5/0x4b0
> > >  kvm_faultin_pfn+0xd7/0x510
> > >  kvm_tdp_page_fault+0x111/0x190
> > >  kvm_mmu_do_page_fault+0x105/0x230
> > >  kvm_mmu_page_fault+0x7d/0x620
> > >  ? vmx_deliver_interrupt+0x110/0x190
> > >  ? __apic_accept_irq+0x16c/0x270
> > >  ? vmx_vmexit+0x8d/0xc0
> > >  vmx_handle_exit+0x110/0x640
> > >  kvm_arch_vcpu_ioctl_run+0xdb0/0x1c20
> > >  kvm_vcpu_ioctl+0x263/0x6a0
> > >  ? futex_wake+0x81/0x180
> > >  __x64_sys_ioctl+0x4a7/0x9d0
> > >  ? __x64_sys_futex+0x73/0x1c0
> > >  ? kvm_on_user_return+0x86/0x90
> > >  do_syscall_64+0x4c/0x100
> > >  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> > > RIP: 0033:0x7f679186a17b
> > > Code: 0f 1e fa 48 8b 05 1d ad 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff =
ff ff ff
> > > c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 f=
f ff 73 01
> > > c3 48 8b 0d ed ac 0c 00 f7 d8 64 89 01 48
> > > RSP: 002b:00007f678d7ff788 EFLAGS: 00000246 ORIG_RAX:
> > 0000000000000010
> > > RAX: ffffffffffffffda RBX: 000000000000ae80 RCX: 00007f679186a17b
> > > RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000059
> > > RBP: 000055da5ee22050 R08: 000055da44b28160 R09: 0000000000000000
> > > R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
> > > R13: 000055da452b05e0 R14: 0000000000000001 R15: 0000000000000000
> > >  </TASK>
> > > ---[ end trace 0000000000000000 ]---
> > >
> > > The warnings show up only when the vdpa page-per-vq option is used
> > (doorbell
> > > mapping to guest).
> > >
> > > The issue seems to have existed before, but was visible only with
> > CONFIG_LOCKDEP
> > > enabled. I tried finding if this was introduced in more recent kernel=
s, but
> > > stopped after going as far back as 6.5: the issue was still visible t=
here.
> > >
> > > The warning is triggered for the following call chain:
> > > vhost_vdpa_fault()
> > >  -> remap_pfn_range()
> > >   -> remap_pfn_range_notrack()
> > >    -> vm_flags_set()
> > >     -> vma_start_write()
> > >      -> __is_vma_write_locked()
> > >       -> mmap_assert_write_locked()
> > >
> > >
> > > I've been trying to follow how the mm write lock is dropped in the ab=
ove
> > call
> > > chain or not taken at all. But I couldn't make much sense of it...
> >
> > I've also had a glance at vfio_pci_mmap_fault, it seems to do something
> > similar.
> >
> > > Any ideas of what could have gone wrong here?
> >
> > Adding Peter for more thought here.
> >
>
> vfio-side fix was just queued for rc4:
>
> https://lore.kernel.org/all/20240614155603.34567eb7.alex.williamson@redha=
t.com/T/

Great, thanks for the pointer.

Dragos, do you want to propose a similar fix for vDPA?

Thanks

