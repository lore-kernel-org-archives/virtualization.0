Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EA5366
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jul 2024 00:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720051890; cv=none; b=j2mJ4S31mfmcgEzegzt7kG96+jnPTf0Cq78rTTwMBFBvm7DdUJRyYtVtrMI+JBjr0wJX542ciDmnxtFJc/9C0Di6Zkec6ePMjnr3ncIufZVkWdGCI2Zp1UkrxU0/IpA1cM7BZPtTroJXhfy0Gwwa8nazfMAQIdSEkopPVDX4vz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720051890; c=relaxed/simple;
	bh=bixIeYGxLefMCt743O4uEgL6TpPVgBTytLFfXOydeiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XTuZwHIYa/NVuNXCWnp++GTSBaY9XwfNwW/tLvIT98XRgUGH/rVrUlNISXOAlQquLQnTxIeoJB03pQCW/PEZ7mG+To+AWhxzvxLqlfbU5Bv6Qfjs7jZVfu7yl8x8M0RiJU//Pz4XvmViuWrKFBfxqVsbG7vgvILEpNTR4+qH18A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VNN77NIJ; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNN77NIJ"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3ACA341E3B
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jul 2024 00:11:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RyCC4vaoVBxL for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Jul 2024 00:11:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 84CA941A75
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 84CA941A75
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VNN77NIJ
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 84CA941A75
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jul 2024 00:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720051885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q8Sr285TLvTYeRn427QR9vXQyEylsfUmll3+e+nJkpI=;
	b=VNN77NIJCEVYAp/J3FA/gomZolJ9EVVccci/BWiKFwPhj4vj7v7G+xIcQgc4KAe+GAREgP
	0WL5DoDZsg5If+bZfoG6yzsqTgfXE4wHSI8MiuPPXdsErJU63hiyRYInSgovXZN0s1cpCS
	cpAutIJEwVA6rwXtMauTHKUhQrzhQ/M=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-ygRpae46NgSZP5uZBC3RuA-1; Wed, 03 Jul 2024 20:11:23 -0400
X-MC-Unique: ygRpae46NgSZP5uZBC3RuA-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7066693876aso82195b3a.3
        for <virtualization@lists.linux-foundation.org>; Wed, 03 Jul 2024 17:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720051882; x=1720656682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8Sr285TLvTYeRn427QR9vXQyEylsfUmll3+e+nJkpI=;
        b=PNKg7V7hLtJZY6qMZjtcgJ2FhT85gg1kSBYYyOoz+KdckLCmnGE0a2YNXoUV+TR21r
         3hAtd8x+Y6XrGx93Nc0Koilw8tbbII3dWpq44qVtmn/qUnBjNmdmpqTNL6Vm8UsxJV+4
         8SeqpAL5VtmYXu6kIWKmsWRyRPnoiL/d7CkC4qeVq2tiPGPpZKorpzQMNhKe8vtmBF0l
         Z4MRiRa4Td0010Qeg1936iYFsCng26/KyDwlArIc143SxOasiPgJI33EH0ZGf4hCROsz
         4QTeyNkoSdo3+jm9PTZFei6UD/rNa3EtW3sffni3immnl8OYSD44uJ+fVmu0Dv68D/z5
         YxKg==
X-Forwarded-Encrypted: i=1; AJvYcCVwYZ0sDKW0z674smCFrcG4u/GC0dpFZZN8Rw4A750JSrpvj5Jr2CC9EHbRgDz69t66sQicPpqBI1EJ1loPyBvLhZQfcWOFVdrJ7+67xCvtYo1rRwtsVrblSw==
X-Gm-Message-State: AOJu0YwPR2d35DgWfkXDZNJm35RmgUYuTqeElUhaHeheWJRFwaHhVr+4
	uCVvq+3mvr95HNAjV+uejL6oEs3VWjDM7aHTrNdpEPDo/5gqtlW5CbyxFvIjzGOGjv5aQo+LCnV
	XWi9XxMorcHepE4hxstQNhCjDqE7y/xBFxUb/oGs7pucKNP1DcKPuZL3TkTju/DZM30i2n6QSGh
	HsL/01FlnrZj4RkMEeLSH94pSkxWqx5716DygPiuHPIahbB9nY5Semxg==
X-Received: by 2002:a05:6a00:3d0b:b0:706:7577:c564 with SMTP id d2e1a72fcca58-70b00ac9ac3mr92876b3a.21.1720051882375;
        Wed, 03 Jul 2024 17:11:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJR1las6Ai7+RFqzRiK/rQZ0dIcD9hug2fjVhLYVP0DrcssZhehykqg05ow/IYsRRRVdAK0HdBazDkDmuRWCg=
X-Received: by 2002:a05:6a00:3d0b:b0:706:7577:c564 with SMTP id
 d2e1a72fcca58-70b00ac9ac3mr92851b3a.21.1720051881839; Wed, 03 Jul 2024
 17:11:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <11b31b8372331256a66594ebc62fe322098d2b4e.camel@nvidia.com>
 <CACGkMEvtgChCeyWon87sqpN0cY6TQpb1Y7iVxbDuupgbYiEUpQ@mail.gmail.com>
 <BN9PR11MB52768C001E84D048B12F8FE88CCE2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <CACGkMEtQ75NZqoYFTRB5gP81ZHpYAxPPCTiL5+kT_yRiyr138A@mail.gmail.com>
 <8e540d6f7936852543957970797012ddb351d64d.camel@nvidia.com>
 <20240619055112-mutt-send-email-mst@kernel.org> <CACGkMEsQuGdKPO1X=MLWjnynL3D_A9tPa0S4LFWDfRepL85aNg@mail.gmail.com>
 <20240620013741-mutt-send-email-mst@kernel.org> <CACGkMEvdsNi2Fd0ZoPJVZUARSRvNqJa4jVxE=8RCWr=dk2_kug@mail.gmail.com>
 <20240703122244-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240703122244-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 4 Jul 2024 08:10:59 +0800
Message-ID: <CACGkMEvfopd3s=XaEZuqLAs28oPPCbgykdxGrWZjDsysBvjQQA@mail.gmail.com>
Subject: Re: mmap_assert_write_locked warnings during for vhost_vdpa_fault
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, 
	"eperezma@redhat.com" <eperezma@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 12:23=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Jun 20, 2024 at 04:23:30PM +0800, Jason Wang wrote:
> > On Thu, Jun 20, 2024 at 1:44=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Thu, Jun 20, 2024 at 12:07:14PM +0800, Jason Wang wrote:
> > > > On Wed, Jun 19, 2024 at 5:52=E2=80=AFPM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Wed, Jun 19, 2024 at 09:14:41AM +0000, Dragos Tatulea wrote:
> > > > > > On Tue, 2024-06-18 at 10:39 +0800, Jason Wang wrote:
> > > > > > > On Tue, Jun 18, 2024 at 10:03=E2=80=AFAM Tian, Kevin <kevin.t=
ian@intel.com> wrote:
> > > > > > > >
> > > > > > > > > From: Jason Wang <jasowang@redhat.com>
> > > > > > > > > Sent: Tuesday, June 18, 2024 9:18 AM
> > > > > > > > >
> > > > > > > > > On Mon, Jun 17, 2024 at 11:51=E2=80=AFPM Dragos Tatulea <=
dtatulea@nvidia.com>
> > > > > > > > > wrote:
> > > > > > > > > >
> > > > > > > > > > Hi,
> > > > > > > > > >
> > > > > > > > > > After commit ba168b52bf8e "mm: use rwsem assertion macr=
os for
> > > > > > > > > > mmap_lock") was submitted, we started getting a lot of =
the
> > > > > > > > > > following warnings about a missing mmap write lock duri=
ng VM boot:
> > > > > > > > > >
> > > > > > > > > > ------------[ cut here ]------------
> > > > > > > > > > WARNING: CPU: 1 PID: 58633 at include/linux/rwsem.h:85
> > > > > > > > > > track_pfn_remap+0x12b/0x130
> > > > > > > > > > Modules linked in: act_mirred act_skbedit vhost_vdpa cl=
s_matchall
> > > > > > > > > > nfnetlink_cttimeout act_gact cls_flower sch_ingress mlx=
5_vdpa vringh vdpa
> > > > > > > > > > openvswitch nsh vhost_net vhost vhost_iotlb tap ip6tabl=
e_mangle
> > > > > > > > > ip6table_nat
> > > > > > > > > > iptable_mangle nf_tables ip6table_filter ip6_tables xt_=
conntrack
> > > > > > > > > xt_MASQUERADE
> > > > > > > > > > nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat =
nf_nat br_netfilter
> > > > > > > > > > rpcsec_gss_krb5 auth_rpcgss oid_registry overlay rpcrdm=
a rdma_ucm
> > > > > > > > > ib_iser
> > > > > > > > > > libiscsi ib_umad scsi_transport_iscsi ib_ipoib rdma_cm =
iw_cm ib_cm
> > > > > > > > > mlx5_ib
> > > > > > > > > > ib_uverbs ib_core fuse mlx5_core
> > > > > > > > > > CPU: 1 PID: 58633 Comm: CPU 0/KVM Tainted: G        W
> > > > > > > > > > 6.10.0-rc1_for_upstream_min_debug_2024_05_29_17_06 #1
> > > > > > > > > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIO=
S
> > > > > > > > > > rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> > > > > > > > > > RIP: 0010:track_pfn_remap+0x12b/0x130
> > > > > > > > > > Code: 48 83 c4 08 b8 ea ff ff ff 5b 5d 41 5c 41 5d c3 4=
8 83 c4 08 48 89 ef 48
> > > > > > > > > > 89 f2 5b 31 c9 4c 89 c6 5d 41 5c 41 5d e9 f5 fb ff ff <=
0f> 0b eb 9b 90 0f 1f 44
> > > > > > > > > > 00 00 80 3d ac 59 96 01 00 74 01 c3 48 89
> > > > > > > > > > RSP: 0018:ffff888350f8b8e0 EFLAGS: 00010246
> > > > > > > > > > RAX: 0000000000000000 RBX: 0000000000001000 RCX: 000000=
0000000000
> > > > > > > > > > RDX: ffff8881080ca300 RSI: 0000000000001000 RDI: 000000=
0544003000
> > > > > > > > > > RBP: 0000000544003000 R08: ffff888106730a60 R09: 000000=
0000000000
> > > > > > > > > > R10: ffff888116eeff60 R11: 0000000000000000 R12: ffff88=
8350f8b918
> > > > > > > > > > R13: ffff888149f99da8 R14: 0000000000001000 R15: 000000=
0000001000
> > > > > > > > > > FS:  00007f678d800700(0000) GS:ffff88852c880000(0000)
> > > > > > > > > knlGS:0000000000000000
> > > > > > > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > > > > > CR2: 00000000004e54f8 CR3: 0000000112290004 CR4: 000000=
0000372eb0
> > > > > > > > > > Call Trace:
> > > > > > > > > >  <TASK>
> > > > > > > > > >  ? __warn+0x78/0x110
> > > > > > > > > >  ? track_pfn_remap+0x12b/0x130
> > > > > > > > > >  ? report_bug+0x16d/0x180
> > > > > > > > > >  ? handle_bug+0x3c/0x60
> > > > > > > > > >  ? exc_invalid_op+0x14/0x70
> > > > > > > > > >  ? asm_exc_invalid_op+0x16/0x20
> > > > > > > > > >  ? track_pfn_remap+0x12b/0x130
> > > > > > > > > >  remap_pfn_range+0x41/0xa0
> > > > > > > > > >  vhost_vdpa_fault+0x6c/0xa0 [vhost_vdpa]
> > > > > > > > > >  __do_fault+0x2f/0xb0
> > > > > > > > > >  __handle_mm_fault+0x13d3/0x2210
> > > > > > > > > >  handle_mm_fault+0xb0/0x260
> > > > > > > > > >  fixup_user_fault+0x77/0x170
> > > > > > > > > >  hva_to_pfn+0x2c5/0x4b0
> > > > > > > > > >  kvm_faultin_pfn+0xd7/0x510
> > > > > > > > > >  kvm_tdp_page_fault+0x111/0x190
> > > > > > > > > >  kvm_mmu_do_page_fault+0x105/0x230
> > > > > > > > > >  kvm_mmu_page_fault+0x7d/0x620
> > > > > > > > > >  ? vmx_deliver_interrupt+0x110/0x190
> > > > > > > > > >  ? __apic_accept_irq+0x16c/0x270
> > > > > > > > > >  ? vmx_vmexit+0x8d/0xc0
> > > > > > > > > >  vmx_handle_exit+0x110/0x640
> > > > > > > > > >  kvm_arch_vcpu_ioctl_run+0xdb0/0x1c20
> > > > > > > > > >  kvm_vcpu_ioctl+0x263/0x6a0
> > > > > > > > > >  ? futex_wake+0x81/0x180
> > > > > > > > > >  __x64_sys_ioctl+0x4a7/0x9d0
> > > > > > > > > >  ? __x64_sys_futex+0x73/0x1c0
> > > > > > > > > >  ? kvm_on_user_return+0x86/0x90
> > > > > > > > > >  do_syscall_64+0x4c/0x100
> > > > > > > > > >  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> > > > > > > > > > RIP: 0033:0x7f679186a17b
> > > > > > > > > > Code: 0f 1e fa 48 8b 05 1d ad 0c 00 64 c7 00 26 00 00 0=
0 48 c7 c0 ff ff ff ff
> > > > > > > > > > c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <=
48> 3d 01 f0 ff ff 73 01
> > > > > > > > > > c3 48 8b 0d ed ac 0c 00 f7 d8 64 89 01 48
> > > > > > > > > > RSP: 002b:00007f678d7ff788 EFLAGS: 00000246 ORIG_RAX:
> > > > > > > > > 0000000000000010
> > > > > > > > > > RAX: ffffffffffffffda RBX: 000000000000ae80 RCX: 00007f=
679186a17b
> > > > > > > > > > RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 000000=
0000000059
> > > > > > > > > > RBP: 000055da5ee22050 R08: 000055da44b28160 R09: 000000=
0000000000
> > > > > > > > > > R10: 0000000000000001 R11: 0000000000000246 R12: 000000=
0000000000
> > > > > > > > > > R13: 000055da452b05e0 R14: 0000000000000001 R15: 000000=
0000000000
> > > > > > > > > >  </TASK>
> > > > > > > > > > ---[ end trace 0000000000000000 ]---
> > > > > > > > > >
> > > > > > > > > > The warnings show up only when the vdpa page-per-vq opt=
ion is used
> > > > > > > > > (doorbell
> > > > > > > > > > mapping to guest).
> > > > > > > > > >
> > > > > > > > > > The issue seems to have existed before, but was visible=
 only with
> > > > > > > > > CONFIG_LOCKDEP
> > > > > > > > > > enabled. I tried finding if this was introduced in more=
 recent kernels, but
> > > > > > > > > > stopped after going as far back as 6.5: the issue was s=
till visible there.
> > > > > > > > > >
> > > > > > > > > > The warning is triggered for the following call chain:
> > > > > > > > > > vhost_vdpa_fault()
> > > > > > > > > >  -> remap_pfn_range()
> > > > > > > > > >   -> remap_pfn_range_notrack()
> > > > > > > > > >    -> vm_flags_set()
> > > > > > > > > >     -> vma_start_write()
> > > > > > > > > >      -> __is_vma_write_locked()
> > > > > > > > > >       -> mmap_assert_write_locked()
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > I've been trying to follow how the mm write lock is dro=
pped in the above
> > > > > > > > > call
> > > > > > > > > > chain or not taken at all. But I couldn't make much sen=
se of it...
> > > > > > > > >
> > > > > > > > > I've also had a glance at vfio_pci_mmap_fault, it seems t=
o do something
> > > > > > > > > similar.
> > > > > > > > >
> > > > > > > > > > Any ideas of what could have gone wrong here?
> > > > > > > > >
> > > > > > > > > Adding Peter for more thought here.
> > > > > > > > >
> > > > > > > >
> > > > > > > > vfio-side fix was just queued for rc4:
> > > > > > > >
> > > > > > > > https://lore.kernel.org/all/20240614155603.34567eb7.alex.wi=
lliamson@redhat.com/T/
> > > > > > >
> > > > > > > Great, thanks for the pointer.
> > > > > > >
> > > > > > Yes, thanks!
> > > > > >
> > > > > > > Dragos, do you want to propose a similar fix for vDPA?
> > > > > > >
> > > > > > Had a first look: the fixes look a bit daunting. I will to "por=
t" them, not
> > > > > > promising anything though.
> > > > > >
> > > > > > Thanks,
> > > > > > Dragos
> > > > >
> > > > > Yea Jason, you coded this in ddd89d0a059d8e9740c75a97e0efe9bf07ee=
51f9,
> > > > > seems a bit much to ask from a random reporter,
> > > >
> > > > Probably, just asking since Dragos has done some investigation.
> > > >
> > > > > this race
> > > > > likely can bite anyone.
> > > > >
> > > >
> > > > Dragos, I've drafted a patch, please try to see if it works (I had
> > > > tested it with LOCKDEP via vp_vdpa in L2).
> > > >
> > > > Thanks
> > >
> > > What is going on here that you decided to do an attachment as
> > > opposed to inlining normally?
> >
> > Actually, I plan to send a formal patch separately but stop at the
> > last seconds since it is just tested by L2 + vp_vdpa in L1.
> >
> > If inline really matters, I will do that next time.
> >
> > Thanks
>
> Jason are you going to submit a patch, now it's been tested?

I've posted it yesterday:

https://patchwork.kernel.org/project/netdevbpf/patch/20240701033159.18133-1=
-jasowang@redhat.com/

Thanks

>
> > >
> > > --
> > > MST
> > >
>

