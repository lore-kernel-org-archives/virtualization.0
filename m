Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5F31990DB
	for <virtualization@lists.linux-foundation.org>; Thu, 20 Jun 2024 08:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718871829; cv=none; b=TAFtO1FN62SE0wTXxuVFS4CTCeh/RyERkzPRf3FpfAfp3mrd+Wb+vTxWrpJLn0Aj04/EzdtkacTyz5CgI4hCnOaNQahUpyQlkv71gwUBhSP7OKgvlSUsxGILio1B4Gh26SzjiWZ2vxGSzXrufv8wMLRy6Y7D9KJY3yqaWRcbxSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718871829; c=relaxed/simple;
	bh=jkonb495yBAzXl/biYoHdSQfCu1AFgAj5boHXSZdqTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a9aFWAJbNhPPNQqbXKWja89oTAO7oC2MExZ04xj4u+gwEmvMkdZHI4YKIYveR+lkxQgDJNsSp4RvNvCF0OhF398TAry67dZKygqYl1SmnonHWNHyc3DdR08t9kNYvhfqhUrB8wHgStg1jp7OPGo6pPTIl+MwIYJ20wUWCaqiY7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mha+npwq; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mha+npwq"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2BF5440516
	for <virtualization@lists.linux-foundation.org>; Thu, 20 Jun 2024 08:23:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1lvaulkcGJuw for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jun 2024 08:23:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7841E404F4
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7841E404F4
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mha+npwq
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7841E404F4
	for <virtualization@lists.linux-foundation.org>; Thu, 20 Jun 2024 08:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718871825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mgMg4m7g9GBJi9R9D9is6X+sVtwno89jD+JUVDCuFcg=;
	b=Mha+npwqzcba9CsUcxxojtMzpJDnW7MinC75C3R3lW9VP9vlZ2k7v4B0ljn+Jq+gTCZwf9
	thh00Z17IXatLQ3KPgpLAQ3/UlQcgUcFjqPfwsLrnngTCgqPDBl+COUwX4UphDcENQ7JqV
	cDoS3bOjyoK3r9j68nz0gqryNy1GCvk=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-IftjDRT4MpyYzthi4usyEA-1; Thu, 20 Jun 2024 04:23:43 -0400
X-MC-Unique: IftjDRT4MpyYzthi4usyEA-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6f8ea7f4501so720023b3a.3
        for <virtualization@lists.linux-foundation.org>; Thu, 20 Jun 2024 01:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718871822; x=1719476622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgMg4m7g9GBJi9R9D9is6X+sVtwno89jD+JUVDCuFcg=;
        b=Y/jbLmQQhhD6VRWnL7JlHikw7EX79ySue/sY+d8D0S2aawSHodNENw+9Ly/E0633RK
         So2MHBj5wa9W1izQahDCJwTkECo3m16maKfeguHby8UDGy9pTdZHpz3E1ysooSu5uVqt
         vRKB0EcG+qgub0P+L8lyQ8yqHm2Yw3jeXqmX3kfK3AktUDx9JaSPQJXdcLN1cyModcWS
         tNBWauUJIs9/eIf082wDJflQNo6qit7m/cVJYG2YGYvCkFIiEvyv8Xbr+48bYd5qAuYS
         ru2IyItZTqfWgun0pKHiuM1lbT1F2/9anl1yLZggId+d3GQ1AxAxrkfLGuGM1MeLjyG5
         bBkw==
X-Forwarded-Encrypted: i=1; AJvYcCU8IyBmEFqqb0LbXdQdPO/LbpCmYYwaeJC4sD3qkVcnu1NWDNr0ex3RHJP6V9WryQDQq+kZMSU2Lokyj1bcwSIzJPA4Pl7MqLHPd01p3bQIdqMalZg2hl6dAw==
X-Gm-Message-State: AOJu0Yy46CzWK00Po+BJtPJ4x9PGqCYrXT1mjgtR6PsWWZx2qXEUiA70
	4u2z6IuI02GyBTrET6LpiACfDotEBgycdEiyYsrFcCc3QLqYuRnUpa6qE/fU5yqVw5QVnXnNJHe
	OBfjeKAv1nOYzOlOMxDM6n4Fm4yaIlitjH0PcgHHiwXslYeKsHN/ezybvKAkv3y7os8Ylk10x5L
	11i8TzTIPQKXiOceHyg/nmMP1LZfV3E4EqdLYB8Leve5cR5dLHYaq1QQ==
X-Received: by 2002:a05:6a20:b71b:b0:1b5:2c97:a88b with SMTP id adf61e73a8af0-1bcbb421491mr4880582637.9.1718871822210;
        Thu, 20 Jun 2024 01:23:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPKNN6hFFqH4J4BmPDYtTO5FCmsdDrdZYdv1xhMjTgOHIQgDCapeDaSQB21miQnRxcyk+TlAnE4yIdXfQU5Rc=
X-Received: by 2002:a05:6a20:b71b:b0:1b5:2c97:a88b with SMTP id
 adf61e73a8af0-1bcbb421491mr4880567637.9.1718871821804; Thu, 20 Jun 2024
 01:23:41 -0700 (PDT)
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
 <20240620013741-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240620013741-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Jun 2024 16:23:30 +0800
Message-ID: <CACGkMEvdsNi2Fd0ZoPJVZUARSRvNqJa4jVxE=8RCWr=dk2_kug@mail.gmail.com>
Subject: Re: mmap_assert_write_locked warnings during for vhost_vdpa_fault
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, 
	"eperezma@redhat.com" <eperezma@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 1:44=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Jun 20, 2024 at 12:07:14PM +0800, Jason Wang wrote:
> > On Wed, Jun 19, 2024 at 5:52=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Wed, Jun 19, 2024 at 09:14:41AM +0000, Dragos Tatulea wrote:
> > > > On Tue, 2024-06-18 at 10:39 +0800, Jason Wang wrote:
> > > > > On Tue, Jun 18, 2024 at 10:03=E2=80=AFAM Tian, Kevin <kevin.tian@=
intel.com> wrote:
> > > > > >
> > > > > > > From: Jason Wang <jasowang@redhat.com>
> > > > > > > Sent: Tuesday, June 18, 2024 9:18 AM
> > > > > > >
> > > > > > > On Mon, Jun 17, 2024 at 11:51=E2=80=AFPM Dragos Tatulea <dtat=
ulea@nvidia.com>
> > > > > > > wrote:
> > > > > > > >
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > > After commit ba168b52bf8e "mm: use rwsem assertion macros f=
or
> > > > > > > > mmap_lock") was submitted, we started getting a lot of the
> > > > > > > > following warnings about a missing mmap write lock during V=
M boot:
> > > > > > > >
> > > > > > > > ------------[ cut here ]------------
> > > > > > > > WARNING: CPU: 1 PID: 58633 at include/linux/rwsem.h:85
> > > > > > > > track_pfn_remap+0x12b/0x130
> > > > > > > > Modules linked in: act_mirred act_skbedit vhost_vdpa cls_ma=
tchall
> > > > > > > > nfnetlink_cttimeout act_gact cls_flower sch_ingress mlx5_vd=
pa vringh vdpa
> > > > > > > > openvswitch nsh vhost_net vhost vhost_iotlb tap ip6table_ma=
ngle
> > > > > > > ip6table_nat
> > > > > > > > iptable_mangle nf_tables ip6table_filter ip6_tables xt_conn=
track
> > > > > > > xt_MASQUERADE
> > > > > > > > nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_n=
at br_netfilter
> > > > > > > > rpcsec_gss_krb5 auth_rpcgss oid_registry overlay rpcrdma rd=
ma_ucm
> > > > > > > ib_iser
> > > > > > > > libiscsi ib_umad scsi_transport_iscsi ib_ipoib rdma_cm iw_c=
m ib_cm
> > > > > > > mlx5_ib
> > > > > > > > ib_uverbs ib_core fuse mlx5_core
> > > > > > > > CPU: 1 PID: 58633 Comm: CPU 0/KVM Tainted: G        W
> > > > > > > > 6.10.0-rc1_for_upstream_min_debug_2024_05_29_17_06 #1
> > > > > > > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> > > > > > > > rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> > > > > > > > RIP: 0010:track_pfn_remap+0x12b/0x130
> > > > > > > > Code: 48 83 c4 08 b8 ea ff ff ff 5b 5d 41 5c 41 5d c3 48 83=
 c4 08 48 89 ef 48
> > > > > > > > 89 f2 5b 31 c9 4c 89 c6 5d 41 5c 41 5d e9 f5 fb ff ff <0f> =
0b eb 9b 90 0f 1f 44
> > > > > > > > 00 00 80 3d ac 59 96 01 00 74 01 c3 48 89
> > > > > > > > RSP: 0018:ffff888350f8b8e0 EFLAGS: 00010246
> > > > > > > > RAX: 0000000000000000 RBX: 0000000000001000 RCX: 0000000000=
000000
> > > > > > > > RDX: ffff8881080ca300 RSI: 0000000000001000 RDI: 0000000544=
003000
> > > > > > > > RBP: 0000000544003000 R08: ffff888106730a60 R09: 0000000000=
000000
> > > > > > > > R10: ffff888116eeff60 R11: 0000000000000000 R12: ffff888350=
f8b918
> > > > > > > > R13: ffff888149f99da8 R14: 0000000000001000 R15: 0000000000=
001000
> > > > > > > > FS:  00007f678d800700(0000) GS:ffff88852c880000(0000)
> > > > > > > knlGS:0000000000000000
> > > > > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > > > CR2: 00000000004e54f8 CR3: 0000000112290004 CR4: 0000000000=
372eb0
> > > > > > > > Call Trace:
> > > > > > > >  <TASK>
> > > > > > > >  ? __warn+0x78/0x110
> > > > > > > >  ? track_pfn_remap+0x12b/0x130
> > > > > > > >  ? report_bug+0x16d/0x180
> > > > > > > >  ? handle_bug+0x3c/0x60
> > > > > > > >  ? exc_invalid_op+0x14/0x70
> > > > > > > >  ? asm_exc_invalid_op+0x16/0x20
> > > > > > > >  ? track_pfn_remap+0x12b/0x130
> > > > > > > >  remap_pfn_range+0x41/0xa0
> > > > > > > >  vhost_vdpa_fault+0x6c/0xa0 [vhost_vdpa]
> > > > > > > >  __do_fault+0x2f/0xb0
> > > > > > > >  __handle_mm_fault+0x13d3/0x2210
> > > > > > > >  handle_mm_fault+0xb0/0x260
> > > > > > > >  fixup_user_fault+0x77/0x170
> > > > > > > >  hva_to_pfn+0x2c5/0x4b0
> > > > > > > >  kvm_faultin_pfn+0xd7/0x510
> > > > > > > >  kvm_tdp_page_fault+0x111/0x190
> > > > > > > >  kvm_mmu_do_page_fault+0x105/0x230
> > > > > > > >  kvm_mmu_page_fault+0x7d/0x620
> > > > > > > >  ? vmx_deliver_interrupt+0x110/0x190
> > > > > > > >  ? __apic_accept_irq+0x16c/0x270
> > > > > > > >  ? vmx_vmexit+0x8d/0xc0
> > > > > > > >  vmx_handle_exit+0x110/0x640
> > > > > > > >  kvm_arch_vcpu_ioctl_run+0xdb0/0x1c20
> > > > > > > >  kvm_vcpu_ioctl+0x263/0x6a0
> > > > > > > >  ? futex_wake+0x81/0x180
> > > > > > > >  __x64_sys_ioctl+0x4a7/0x9d0
> > > > > > > >  ? __x64_sys_futex+0x73/0x1c0
> > > > > > > >  ? kvm_on_user_return+0x86/0x90
> > > > > > > >  do_syscall_64+0x4c/0x100
> > > > > > > >  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> > > > > > > > RIP: 0033:0x7f679186a17b
> > > > > > > > Code: 0f 1e fa 48 8b 05 1d ad 0c 00 64 c7 00 26 00 00 00 48=
 c7 c0 ff ff ff ff
> > > > > > > > c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> =
3d 01 f0 ff ff 73 01
> > > > > > > > c3 48 8b 0d ed ac 0c 00 f7 d8 64 89 01 48
> > > > > > > > RSP: 002b:00007f678d7ff788 EFLAGS: 00000246 ORIG_RAX:
> > > > > > > 0000000000000010
> > > > > > > > RAX: ffffffffffffffda RBX: 000000000000ae80 RCX: 00007f6791=
86a17b
> > > > > > > > RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000=
000059
> > > > > > > > RBP: 000055da5ee22050 R08: 000055da44b28160 R09: 0000000000=
000000
> > > > > > > > R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000=
000000
> > > > > > > > R13: 000055da452b05e0 R14: 0000000000000001 R15: 0000000000=
000000
> > > > > > > >  </TASK>
> > > > > > > > ---[ end trace 0000000000000000 ]---
> > > > > > > >
> > > > > > > > The warnings show up only when the vdpa page-per-vq option =
is used
> > > > > > > (doorbell
> > > > > > > > mapping to guest).
> > > > > > > >
> > > > > > > > The issue seems to have existed before, but was visible onl=
y with
> > > > > > > CONFIG_LOCKDEP
> > > > > > > > enabled. I tried finding if this was introduced in more rec=
ent kernels, but
> > > > > > > > stopped after going as far back as 6.5: the issue was still=
 visible there.
> > > > > > > >
> > > > > > > > The warning is triggered for the following call chain:
> > > > > > > > vhost_vdpa_fault()
> > > > > > > >  -> remap_pfn_range()
> > > > > > > >   -> remap_pfn_range_notrack()
> > > > > > > >    -> vm_flags_set()
> > > > > > > >     -> vma_start_write()
> > > > > > > >      -> __is_vma_write_locked()
> > > > > > > >       -> mmap_assert_write_locked()
> > > > > > > >
> > > > > > > >
> > > > > > > > I've been trying to follow how the mm write lock is dropped=
 in the above
> > > > > > > call
> > > > > > > > chain or not taken at all. But I couldn't make much sense o=
f it...
> > > > > > >
> > > > > > > I've also had a glance at vfio_pci_mmap_fault, it seems to do=
 something
> > > > > > > similar.
> > > > > > >
> > > > > > > > Any ideas of what could have gone wrong here?
> > > > > > >
> > > > > > > Adding Peter for more thought here.
> > > > > > >
> > > > > >
> > > > > > vfio-side fix was just queued for rc4:
> > > > > >
> > > > > > https://lore.kernel.org/all/20240614155603.34567eb7.alex.willia=
mson@redhat.com/T/
> > > > >
> > > > > Great, thanks for the pointer.
> > > > >
> > > > Yes, thanks!
> > > >
> > > > > Dragos, do you want to propose a similar fix for vDPA?
> > > > >
> > > > Had a first look: the fixes look a bit daunting. I will to "port" t=
hem, not
> > > > promising anything though.
> > > >
> > > > Thanks,
> > > > Dragos
> > >
> > > Yea Jason, you coded this in ddd89d0a059d8e9740c75a97e0efe9bf07ee51f9=
,
> > > seems a bit much to ask from a random reporter,
> >
> > Probably, just asking since Dragos has done some investigation.
> >
> > > this race
> > > likely can bite anyone.
> > >
> >
> > Dragos, I've drafted a patch, please try to see if it works (I had
> > tested it with LOCKDEP via vp_vdpa in L2).
> >
> > Thanks
>
> What is going on here that you decided to do an attachment as
> opposed to inlining normally?

Actually, I plan to send a formal patch separately but stop at the
last seconds since it is just tested by L2 + vp_vdpa in L1.

If inline really matters, I will do that next time.

Thanks

>
> --
> MST
>

