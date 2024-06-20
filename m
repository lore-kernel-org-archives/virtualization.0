Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C723C0C
	for <virtualization@lists.linux-foundation.org>; Thu, 20 Jun 2024 04:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718856458; cv=none; b=RbDlx1wmYAC5om+MLsIZB3pHN8r7n0qOdBWPviPoeouRVP7VmtuFEibNPTPPcDlQ9skzNDut9AoJRmxsz//TtIBASR+omIyeG7XATz0cGaCx1TSFG/ggKh++u4aoxE9U0u/yByraN82muO/2+MxVLWoIr+j1nfa8xpEW8Xm55us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718856458; c=relaxed/simple;
	bh=a+vzq/XW9uFucS1RL9lJCKnhCJx6+rx6oAWSeLRQAbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EURInnMxsIOxNcr0Hd/Kt1ciwI8M8J/kovNxMa+VAv+EQip9lyTR/osT+gx9+YPoSNHlLIRH+bshWsULUnfcQsPFY6jxORRMHY0t53kL1D0js9tKK80gOw3SGa5Cfi7LeHsmbIOY+ofQbTEPcDeZhovRYuMWyOACrmyYBzwd4A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yg2anr7z; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yg2anr7z"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BAA9D42CE5
	for <virtualization@lists.linux-foundation.org>; Thu, 20 Jun 2024 04:07:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id snz5511_eLKN for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jun 2024 04:07:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3B42842CE2
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3B42842CE2
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yg2anr7z
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3B42842CE2
	for <virtualization@lists.linux-foundation.org>; Thu, 20 Jun 2024 04:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718856453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rDkO03gbiYnPK5CGpdSOIQSCA79NHuWxZX1Nzfhm98E=;
	b=Yg2anr7zYlXSWwkNX7Tm6PxL4SfGglqj5PloSy1ItCTWgYEFwmb5QWXa2XRzbdOTK5xgiA
	FCpbrg8DxzHGRUSp6x3he8fo+uXPzV+5Mpx0P0/aMqe3XObu7sxKb9XWm7VIyGRKrn1cGY
	6n4XqiyMY8EYkDzqcJDq1PYGMPlANN4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-7M5iZugQMN-1dkrPFdIa7Q-1; Thu, 20 Jun 2024 00:07:28 -0400
X-MC-Unique: 7M5iZugQMN-1dkrPFdIa7Q-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c7a6d3be86so556448a91.3
        for <virtualization@lists.linux-foundation.org>; Wed, 19 Jun 2024 21:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718856448; x=1719461248;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rDkO03gbiYnPK5CGpdSOIQSCA79NHuWxZX1Nzfhm98E=;
        b=baFveEu0hWsUMWnhsAXJ9M0XawbqRqvsMk4kL1xKIWrFBROr/qM3w3j+hEtZUQWoGR
         OWgOVCE5KbKeK6kAm3BxtBqsup6vdaNCXMHX9HLGe050JE6SzEGWKXzWe0gq9DyYuLTo
         rZle5PZnvgn9hmkIE+zOjfgJssc3p1gzBtg/D3dr+GJdCPqXD2JFTpjOJrEzAxJ26nBe
         Y9POvUjo+cdoCyDUpVvvBQszWZ48KvpoLho8tFvebKLPrJmxVSjbMyxKETTc6HDrT4Kr
         ndlcJkjokgrg7fTd0zbG2KF50MYZn7xqGhkabLZzUKN162feWH+/Z221c3AeFYXw7LQH
         cEvA==
X-Forwarded-Encrypted: i=1; AJvYcCXqcS7LsGkP94mEtLzZt4hgqtjPnGX0LP27E4zHBfnXSWRE3t4yzWi5P+djAybvlftBR2h2oaJRsLMau3XknF6WXwe/TxE/+YBqfyyLQNX+CIoZFQGZ4O5Mnw==
X-Gm-Message-State: AOJu0YxEk/CjnpYUr2u4i3xvQXo4enp2myO++hMO3pK+T2/H8oFsDpq2
	bg7ybNmD30wb33R4106Fe5PURPgftYzCIi041Pm0vBVqo6/eX7qfgACFEV+YALu2kUTaIU9Lb7P
	YSffMmNarzIc+jq3PMFCwiqaOAb0SFm7+JzPkSs8MDmNQR4WZKmA/Ioa8769GYCpfgEnW0AvPa5
	Xuv5gdLBfRFv8FL1fkRFEQgxftOENWkSAYtxZ2ZBNHh995psusFuWKew==
X-Received: by 2002:a17:90a:e28f:b0:2c2:d260:f76a with SMTP id 98e67ed59e1d1-2c7b5d8e4fbmr4501411a91.40.1718856447771;
        Wed, 19 Jun 2024 21:07:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgfOFSF3oXoezXkUmYE4m06arWDKJNQwvFv3qWPR3S9dpKwbvp2LVi8bDc15tvSx0ie0szZZb82Thi06W1kSg=
X-Received: by 2002:a17:90a:e28f:b0:2c2:d260:f76a with SMTP id
 98e67ed59e1d1-2c7b5d8e4fbmr4501395a91.40.1718856447399; Wed, 19 Jun 2024
 21:07:27 -0700 (PDT)
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
 <8e540d6f7936852543957970797012ddb351d64d.camel@nvidia.com> <20240619055112-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240619055112-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Jun 2024 12:07:14 +0800
Message-ID: <CACGkMEsQuGdKPO1X=MLWjnynL3D_A9tPa0S4LFWDfRepL85aNg@mail.gmail.com>
Subject: Re: mmap_assert_write_locked warnings during for vhost_vdpa_fault
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, 
	"eperezma@redhat.com" <eperezma@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="000000000000f7cefe061b4a73ff"

--000000000000f7cefe061b4a73ff
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 5:52=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Jun 19, 2024 at 09:14:41AM +0000, Dragos Tatulea wrote:
> > On Tue, 2024-06-18 at 10:39 +0800, Jason Wang wrote:
> > > On Tue, Jun 18, 2024 at 10:03=E2=80=AFAM Tian, Kevin <kevin.tian@inte=
l.com> wrote:
> > > >
> > > > > From: Jason Wang <jasowang@redhat.com>
> > > > > Sent: Tuesday, June 18, 2024 9:18 AM
> > > > >
> > > > > On Mon, Jun 17, 2024 at 11:51=E2=80=AFPM Dragos Tatulea <dtatulea=
@nvidia.com>
> > > > > wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > After commit ba168b52bf8e "mm: use rwsem assertion macros for
> > > > > > mmap_lock") was submitted, we started getting a lot of the
> > > > > > following warnings about a missing mmap write lock during VM bo=
ot:
> > > > > >
> > > > > > ------------[ cut here ]------------
> > > > > > WARNING: CPU: 1 PID: 58633 at include/linux/rwsem.h:85
> > > > > > track_pfn_remap+0x12b/0x130
> > > > > > Modules linked in: act_mirred act_skbedit vhost_vdpa cls_matcha=
ll
> > > > > > nfnetlink_cttimeout act_gact cls_flower sch_ingress mlx5_vdpa v=
ringh vdpa
> > > > > > openvswitch nsh vhost_net vhost vhost_iotlb tap ip6table_mangle
> > > > > ip6table_nat
> > > > > > iptable_mangle nf_tables ip6table_filter ip6_tables xt_conntrac=
k
> > > > > xt_MASQUERADE
> > > > > > nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat b=
r_netfilter
> > > > > > rpcsec_gss_krb5 auth_rpcgss oid_registry overlay rpcrdma rdma_u=
cm
> > > > > ib_iser
> > > > > > libiscsi ib_umad scsi_transport_iscsi ib_ipoib rdma_cm iw_cm ib=
_cm
> > > > > mlx5_ib
> > > > > > ib_uverbs ib_core fuse mlx5_core
> > > > > > CPU: 1 PID: 58633 Comm: CPU 0/KVM Tainted: G        W
> > > > > > 6.10.0-rc1_for_upstream_min_debug_2024_05_29_17_06 #1
> > > > > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> > > > > > rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> > > > > > RIP: 0010:track_pfn_remap+0x12b/0x130
> > > > > > Code: 48 83 c4 08 b8 ea ff ff ff 5b 5d 41 5c 41 5d c3 48 83 c4 =
08 48 89 ef 48
> > > > > > 89 f2 5b 31 c9 4c 89 c6 5d 41 5c 41 5d e9 f5 fb ff ff <0f> 0b e=
b 9b 90 0f 1f 44
> > > > > > 00 00 80 3d ac 59 96 01 00 74 01 c3 48 89
> > > > > > RSP: 0018:ffff888350f8b8e0 EFLAGS: 00010246
> > > > > > RAX: 0000000000000000 RBX: 0000000000001000 RCX: 00000000000000=
00
> > > > > > RDX: ffff8881080ca300 RSI: 0000000000001000 RDI: 00000005440030=
00
> > > > > > RBP: 0000000544003000 R08: ffff888106730a60 R09: 00000000000000=
00
> > > > > > R10: ffff888116eeff60 R11: 0000000000000000 R12: ffff888350f8b9=
18
> > > > > > R13: ffff888149f99da8 R14: 0000000000001000 R15: 00000000000010=
00
> > > > > > FS:  00007f678d800700(0000) GS:ffff88852c880000(0000)
> > > > > knlGS:0000000000000000
> > > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > CR2: 00000000004e54f8 CR3: 0000000112290004 CR4: 0000000000372e=
b0
> > > > > > Call Trace:
> > > > > >  <TASK>
> > > > > >  ? __warn+0x78/0x110
> > > > > >  ? track_pfn_remap+0x12b/0x130
> > > > > >  ? report_bug+0x16d/0x180
> > > > > >  ? handle_bug+0x3c/0x60
> > > > > >  ? exc_invalid_op+0x14/0x70
> > > > > >  ? asm_exc_invalid_op+0x16/0x20
> > > > > >  ? track_pfn_remap+0x12b/0x130
> > > > > >  remap_pfn_range+0x41/0xa0
> > > > > >  vhost_vdpa_fault+0x6c/0xa0 [vhost_vdpa]
> > > > > >  __do_fault+0x2f/0xb0
> > > > > >  __handle_mm_fault+0x13d3/0x2210
> > > > > >  handle_mm_fault+0xb0/0x260
> > > > > >  fixup_user_fault+0x77/0x170
> > > > > >  hva_to_pfn+0x2c5/0x4b0
> > > > > >  kvm_faultin_pfn+0xd7/0x510
> > > > > >  kvm_tdp_page_fault+0x111/0x190
> > > > > >  kvm_mmu_do_page_fault+0x105/0x230
> > > > > >  kvm_mmu_page_fault+0x7d/0x620
> > > > > >  ? vmx_deliver_interrupt+0x110/0x190
> > > > > >  ? __apic_accept_irq+0x16c/0x270
> > > > > >  ? vmx_vmexit+0x8d/0xc0
> > > > > >  vmx_handle_exit+0x110/0x640
> > > > > >  kvm_arch_vcpu_ioctl_run+0xdb0/0x1c20
> > > > > >  kvm_vcpu_ioctl+0x263/0x6a0
> > > > > >  ? futex_wake+0x81/0x180
> > > > > >  __x64_sys_ioctl+0x4a7/0x9d0
> > > > > >  ? __x64_sys_futex+0x73/0x1c0
> > > > > >  ? kvm_on_user_return+0x86/0x90
> > > > > >  do_syscall_64+0x4c/0x100
> > > > > >  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> > > > > > RIP: 0033:0x7f679186a17b
> > > > > > Code: 0f 1e fa 48 8b 05 1d ad 0c 00 64 c7 00 26 00 00 00 48 c7 =
c0 ff ff ff ff
> > > > > > c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 0=
1 f0 ff ff 73 01
> > > > > > c3 48 8b 0d ed ac 0c 00 f7 d8 64 89 01 48
> > > > > > RSP: 002b:00007f678d7ff788 EFLAGS: 00000246 ORIG_RAX:
> > > > > 0000000000000010
> > > > > > RAX: ffffffffffffffda RBX: 000000000000ae80 RCX: 00007f679186a1=
7b
> > > > > > RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 00000000000000=
59
> > > > > > RBP: 000055da5ee22050 R08: 000055da44b28160 R09: 00000000000000=
00
> > > > > > R10: 0000000000000001 R11: 0000000000000246 R12: 00000000000000=
00
> > > > > > R13: 000055da452b05e0 R14: 0000000000000001 R15: 00000000000000=
00
> > > > > >  </TASK>
> > > > > > ---[ end trace 0000000000000000 ]---
> > > > > >
> > > > > > The warnings show up only when the vdpa page-per-vq option is u=
sed
> > > > > (doorbell
> > > > > > mapping to guest).
> > > > > >
> > > > > > The issue seems to have existed before, but was visible only wi=
th
> > > > > CONFIG_LOCKDEP
> > > > > > enabled. I tried finding if this was introduced in more recent =
kernels, but
> > > > > > stopped after going as far back as 6.5: the issue was still vis=
ible there.
> > > > > >
> > > > > > The warning is triggered for the following call chain:
> > > > > > vhost_vdpa_fault()
> > > > > >  -> remap_pfn_range()
> > > > > >   -> remap_pfn_range_notrack()
> > > > > >    -> vm_flags_set()
> > > > > >     -> vma_start_write()
> > > > > >      -> __is_vma_write_locked()
> > > > > >       -> mmap_assert_write_locked()
> > > > > >
> > > > > >
> > > > > > I've been trying to follow how the mm write lock is dropped in =
the above
> > > > > call
> > > > > > chain or not taken at all. But I couldn't make much sense of it=
...
> > > > >
> > > > > I've also had a glance at vfio_pci_mmap_fault, it seems to do som=
ething
> > > > > similar.
> > > > >
> > > > > > Any ideas of what could have gone wrong here?
> > > > >
> > > > > Adding Peter for more thought here.
> > > > >
> > > >
> > > > vfio-side fix was just queued for rc4:
> > > >
> > > > https://lore.kernel.org/all/20240614155603.34567eb7.alex.williamson=
@redhat.com/T/
> > >
> > > Great, thanks for the pointer.
> > >
> > Yes, thanks!
> >
> > > Dragos, do you want to propose a similar fix for vDPA?
> > >
> > Had a first look: the fixes look a bit daunting. I will to "port" them,=
 not
> > promising anything though.
> >
> > Thanks,
> > Dragos
>
> Yea Jason, you coded this in ddd89d0a059d8e9740c75a97e0efe9bf07ee51f9,
> seems a bit much to ask from a random reporter,

Probably, just asking since Dragos has done some investigation.

> this race
> likely can bite anyone.
>

Dragos, I've drafted a patch, please try to see if it works (I had
tested it with LOCKDEP via vp_vdpa in L2).

Thanks

--000000000000f7cefe061b4a73ff
Content-Type: application/octet-stream; 
	name="0001-vhost-vdpa-switch-to-use-vmf_insert_pfn-in-the-fault.patch"
Content-Disposition: attachment; 
	filename="0001-vhost-vdpa-switch-to-use-vmf_insert_pfn-in-the-fault.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lxmqqnb80>
X-Attachment-Id: f_lxmqqnb80

RnJvbSBhOTRhNzAzNzJiNzAyMjQ2NDM2Y2IzM2VjYmFhMDdkNWM2MTI3Y2U3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgpEYXRl
OiBXZWQsIDE5IEp1biAyMDI0IDIxOjI1OjMyIC0wNDAwClN1YmplY3Q6IFtQQVRDSF0gdmhvc3Qt
dmRwYTogc3dpdGNoIHRvIHVzZSB2bWZfaW5zZXJ0X3BmbigpIGluIHRoZSBmYXVsdAogaGFuZGxl
cgoKcmVtYXBfcGZuX3BhZ2UoKSBzaG91bGQgbm90IGJlIGNhbGxlZCBpbiB0aGUgZmF1bHQgaGFu
ZGxlciBhcyBpdCBtYXkKY2hhbmdlIHRoZSB2bWEtPmZsYWdzIHdoaWNoIG1heSB0cmlnZ2VyIGxv
Y2tkZXAgd2FybmluZyBzaW5jZSB0aGUgdm1hCndyaXRlIGxvY2sgaXMgbm90IGhlbGQuIEFjdHVh
bGx5IHRoZXJlJ3Mgbm8gbmVlZCB0byBtb2RpZnkgdGhlCnZtYS0+ZmxhZ3MgYXMgaXQgaGFzIGJl
ZW4gc2V0IGluIHRoZSBtbWFwKCkuIFNvIHRoaXMgcGF0Y2ggc3dpdGNoZXMgdG8KdXNlIHZtZl9p
bnNlcnRfcGZuKCkgaW5zdGVhZC4KClJlcG9ydGVkLWJ5OiBEcmFnb3MgVGF0dWxlYSA8ZHRhdHVs
ZWFAbnZpZGlhLmNvbT4KRml4ZXM6IGRkZDg5ZDBhMDU5ZCAoInZob3N0X3ZkcGE6IHN1cHBvcnQg
ZG9vcmJlbGwgbWFwcGluZyB2aWEgbW1hcCIpCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnClNp
Z25lZC1vZmYtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Ci0tLQogZHJpdmVy
cy92aG9zdC92ZHBhLmMgfCA4ICstLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9k
cml2ZXJzL3Zob3N0L3ZkcGEuYwppbmRleCA2M2E1MzY4MGE4NWMuLjZiOWMxMmFjZjQzOCAxMDA2
NDQKLS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMKKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMK
QEAgLTE0ODMsMTMgKzE0ODMsNyBAQCBzdGF0aWMgdm1fZmF1bHRfdCB2aG9zdF92ZHBhX2ZhdWx0
KHN0cnVjdCB2bV9mYXVsdCAqdm1mKQogCiAJbm90aWZ5ID0gb3BzLT5nZXRfdnFfbm90aWZpY2F0
aW9uKHZkcGEsIGluZGV4KTsKIAotCXZtYS0+dm1fcGFnZV9wcm90ID0gcGdwcm90X25vbmNhY2hl
ZCh2bWEtPnZtX3BhZ2VfcHJvdCk7Ci0JaWYgKHJlbWFwX3Bmbl9yYW5nZSh2bWEsIHZtZi0+YWRk
cmVzcyAmIFBBR0VfTUFTSywKLQkJCSAgICBQRk5fRE9XTihub3RpZnkuYWRkciksIFBBR0VfU0la
RSwKLQkJCSAgICB2bWEtPnZtX3BhZ2VfcHJvdCkpCi0JCXJldHVybiBWTV9GQVVMVF9TSUdCVVM7
Ci0KLQlyZXR1cm4gVk1fRkFVTFRfTk9QQUdFOworCXJldHVybiB2bWZfaW5zZXJ0X3Bmbih2bWEs
IHZtZi0+YWRkcmVzcyAmIFBBR0VfTUFTSywgUEZOX0RPV04obm90aWZ5LmFkZHIpKTsKIH0KIAog
c3RhdGljIGNvbnN0IHN0cnVjdCB2bV9vcGVyYXRpb25zX3N0cnVjdCB2aG9zdF92ZHBhX3ZtX29w
cyA9IHsKLS0gCjIuMzEuMQoK
--000000000000f7cefe061b4a73ff--

