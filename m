Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F92F1850BB
	for <virtualization@lists.linux-foundation.org>; Wed,  3 Jul 2024 16:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720023797; cv=none; b=i671TzsK1YVk9nuBRS0cCO6i0/vq3xvOGM3VQI198h34EhGV4XSeMIeNTOgzuaHWD4wLUnfjpW1BCa8QnzpedjWbFrJBbq16gG86K5JqiXVQNwN9aN1mQ+NuJ5Crdejj15c4rFvcz31WnL5NHW7Oh4Nav/H3CR/cyefR8nXHm4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720023797; c=relaxed/simple;
	bh=xAVKFZAm1ErDoImqkI/3RHBP54FM2bi4vQTqNMiPOlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZYSUFwGardVMlq0vjpziAbN52CH8jVqZBJlcywffuC6KHMXsOzGCgebpWt6Q+WHvOqu5yMAIL6GoNg9XDl2Rb9GAWHCTHzBbJ+6q06xZhwrIVCKPXqyd6T8h63z6YmC2bPIx0OhxBc+hZCWtVfgtlThFIEpBGjDoFzSroQIFTCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K2ZtJ6HU; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K2ZtJ6HU"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 37F63417E4
	for <virtualization@lists.linux-foundation.org>; Wed,  3 Jul 2024 16:23:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dh-P_yF3ULEP for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Jul 2024 16:23:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 72F8B414DE
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 72F8B414DE
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K2ZtJ6HU
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 72F8B414DE
	for <virtualization@lists.linux-foundation.org>; Wed,  3 Jul 2024 16:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720023793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rloU87m1PJWrTbsusoJJL1e1e7aHeQaxYGb4azxqS0c=;
	b=K2ZtJ6HUsrSJsgxfTcCKS7BknYNKRwyfsjDzSF2TUQEgjNndxWQSrc6CedF3X5vCGjHAec
	zSHn4eD4wurD9B7uA48wnyarZMpY9rRisOumIzHphGW2rykMRwdFZhEPC6Plj8RqC5CxTs
	mMX++CArpFpiNedqdEuD/ZfOhPK3388=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-DiY86BDvNPuPm7Hlkl0JPQ-1; Wed, 03 Jul 2024 12:23:11 -0400
X-MC-Unique: DiY86BDvNPuPm7Hlkl0JPQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ee4e043c76so65621511fa.0
        for <virtualization@lists.linux-foundation.org>; Wed, 03 Jul 2024 09:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720023789; x=1720628589;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rloU87m1PJWrTbsusoJJL1e1e7aHeQaxYGb4azxqS0c=;
        b=jHbBnWTpRC4epCCrf+h+ktS/7q0PLEc2y9r6lV8xYeVaMkdYSrzLxl7BTqPKxuBQs/
         UiTR8nMRg3JndSK76Mz1U6Wz4kzhB/skHg9t5Ek8Ony1VfueiGz1XYK49lDF/f+SEUZq
         knNAJkNHBRwCV0JESrrh6yiFN5hexSL7AT8bxUGxvwQy9GyQNqyDQ4H0+3qTMGPyrfRc
         jT1x68xVxW1KrvRnqBlSTT6qqmSUqre8NGWiIrn/4/ff8zsAcScQeBOy6dmZ7pbcSeCi
         VvQRb0zycKojUqEBME1Ugjn4qkHXDfD3VoHpaHwjfpKD7Q57Tetf2DDA5+iUDR8FhbhH
         sCYw==
X-Forwarded-Encrypted: i=1; AJvYcCVJGmKmZE8mYgzLy3bs4dxzbFfgazF2xh5DxwxUGuZ76gLivxEkNvOwUT2azIVYTIwZaxoKKzgeEzxyB4Bt4UHYKteFacXIOhk5DTvFmo/fBVN05LOsPsna9w==
X-Gm-Message-State: AOJu0YxGK1MrHeYwTlcKXnoSKl2ZIspYVgtHtZzYF9hBYgxjMVOjv/3s
	XGNDZwhXbDhsguTS0jSLO4gRApKvy9i972cVd375H/Bj5FBqieHBAc+Y/gnaGw4kV/OBgSFbWwk
	XtkGhylCUhZtMp3SVrbpzgVcQ2x1RkWvZHCxUYerpSviq+Q5jgrJnGw+70fGrBL0hDNyg8NErZ+
	EPp3Q=
X-Received: by 2002:a05:6512:6d2:b0:52c:84d1:180e with SMTP id 2adb3069b0e04-52e827344e4mr8293741e87.67.1720023788954;
        Wed, 03 Jul 2024 09:23:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGz6LhmSUGEeMOTZnZ9Ee1I/CMu2P8HTda2vjmZRUzwQZTHThxKIdkLuADQcnSeFIKo8ZIGNQ==
X-Received: by 2002:a05:6512:6d2:b0:52c:84d1:180e with SMTP id 2adb3069b0e04-52e827344e4mr8293700e87.67.1720023788146;
        Wed, 03 Jul 2024 09:23:08 -0700 (PDT)
Received: from redhat.com ([31.187.78.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af5b66csm240573575e9.18.2024.07.03.09.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 09:23:07 -0700 (PDT)
Date: Wed, 3 Jul 2024 12:23:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"peterx@redhat.com" <peterx@redhat.com>
Subject: Re: mmap_assert_write_locked warnings during for vhost_vdpa_fault
Message-ID: <20240703122244-mutt-send-email-mst@kernel.org>
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
> 
> If inline really matters, I will do that next time.
> 
> Thanks

Jason are you going to submit a patch, now it's been tested?

> >
> > --
> > MST
> >

