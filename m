Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0297F4C6D
	for <virtualization@lists.linux-foundation.org>; Tue, 18 Jun 2024 01:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718673493; cv=none; b=CqjwAyfEmt5vqwuOaZsrUrfRGWe0MqQct7AYucevaOZgEqkfOYONNNg37V7ckq5cB0FxUHrEbuUuPmXGKPEAAymLwILjufrqokoOJTGPmovlqzRKkwRR5hmGf+t13iNNk4YyfRAYA5pFTpJvwUFodzE/4eoD0dMeLJVShhxqW9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718673493; c=relaxed/simple;
	bh=1ts1q9y5FM50/TIaLk5PowYmi1+zwe6jqMy8RjBf31k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B2AAagFNKhdNVUzfVeq1RCHYFNY5UQOC8YmsJtOTJ2atoYFa+4qHai7KjqEgdDYJi/oNPEr/qYdRrZ7I/KPYKqr/t7nW5CIro3uelp/+kufpeAWCbjWSR1w4eM1X6hyAH6s/KXHRuSKd0Xk2r2Fi6YfMbxRE6RFOz3BFlVYFVsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iV+fNSLV; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iV+fNSLV"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8119F40572
	for <virtualization@lists.linux-foundation.org>; Tue, 18 Jun 2024 01:18:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5o4EZ-2h4L7U for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jun 2024 01:18:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org BF0914055A
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BF0914055A
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iV+fNSLV
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BF0914055A
	for <virtualization@lists.linux-foundation.org>; Tue, 18 Jun 2024 01:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718673488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M6yJ18tEwQTy9e+Dgcq1oWDBk9uLC9RVBBMesVxDlUk=;
	b=iV+fNSLVX+pSgayKSsKPavd8lgL7VUc53hPx8uT29mFmWjTu2HofhvpvWvi3asmn8q/x8j
	IiT0/Eh9gSlaiq4hFpWXK+m5sII/VNED5SpstUIFAQF0T7WarQSv2OnKCNoyM0jPcNtaWE
	YZjUcY2W9KKwHJ3IVo0KWw8M7DEhRFU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-BoQ1kao8OoWlJ1M_YGXgFQ-1; Mon, 17 Jun 2024 21:18:06 -0400
X-MC-Unique: BoQ1kao8OoWlJ1M_YGXgFQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2c2d6e09e62so5152563a91.2
        for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 18:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718673485; x=1719278285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6yJ18tEwQTy9e+Dgcq1oWDBk9uLC9RVBBMesVxDlUk=;
        b=mvjGGvft5qsVFuuIe9v4kqIHD+22rcjzZa4MI78V+fwim5TEtSt+jGo6doNvAeiNf3
         pPEG/iya3ifmmBZeY1gqDIIoWEHL3dkqO5myZvKalfaG7/QehZ4C57yZCK69nrwPHFaA
         GP7TKaieyfU0g3TWznKEcq6V0dR1c6F4BTHPcMQXv+BFR43N99kqwoYvRiUm2FJn3OOD
         WM5y5U17nvXZDt+Y/dv34eciDkzoCM1lqonK9O8cTMvP4oJKkNSGDRXHT7jlp+J4UHq3
         LG0xcZuogCe5fQJQ/t/wUKIJOmMLvUpUvR+cAxex1C/s6pDsV7rShG2/gfAx0gO4RgMf
         upZg==
X-Forwarded-Encrypted: i=1; AJvYcCUjQJHftyU4EC70l+0I8nr56I2264r51vT3BxuCXb9IIl+TNSiEW3exd2snLYAL8dsvSG7ADiHHuY12otphcp0Kq7/mpE+XIW6kY7ssDg18uI5HIVEe69HNXw==
X-Gm-Message-State: AOJu0Yxz/11NLio1EkymRTQqBWIwOxViHFMFWLF+Eu1kCgAbqo07RD58
	CP4F7WXrthrABykwrfn/+Yxlqw3UgKUg2Waty5XX4MgiRFLGaD40bHanrlb32bX4JyWE/kYIZw7
	voIVV2dEH0Bl+TEblLJlCE1BdvXzugKS06fm2Z4EBD7PeRBIBlNWppTlBlK1icZxz3oHSIsWjdn
	BR/Klyx3bU6khP44y6Op6ieqSBUpbA4nUk3NCf1i8evKM7Z2HRbcnspQ==
X-Received: by 2002:a17:90b:1112:b0:2c2:d442:aa10 with SMTP id 98e67ed59e1d1-2c4dbd37314mr9690035a91.45.1718673485412;
        Mon, 17 Jun 2024 18:18:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf/HGXhdbdVg2X8H4E93vwCjVuTrjNa5+INZ62KQOYlRFmv98Eaz1qIIEGAcC9WEozKsWzI/2NYO+5l4OBp94=
X-Received: by 2002:a17:90b:1112:b0:2c2:d442:aa10 with SMTP id
 98e67ed59e1d1-2c4dbd37314mr9690020a91.45.1718673485010; Mon, 17 Jun 2024
 18:18:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <11b31b8372331256a66594ebc62fe322098d2b4e.camel@nvidia.com>
In-Reply-To: <11b31b8372331256a66594ebc62fe322098d2b4e.camel@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Jun 2024 09:17:53 +0800
Message-ID: <CACGkMEvtgChCeyWon87sqpN0cY6TQpb1Y7iVxbDuupgbYiEUpQ@mail.gmail.com>
Subject: Re: mmap_assert_write_locked warnings during for vhost_vdpa_fault
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "eperezma@redhat.com" <eperezma@redhat.com>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Peter Xu <peterx@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 11:51=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> Hi,
>
> After commit ba168b52bf8e "mm: use rwsem assertion macros for
> mmap_lock") was submitted, we started getting a lot of the
> following warnings about a missing mmap write lock during VM boot:
>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 58633 at include/linux/rwsem.h:85
> track_pfn_remap+0x12b/0x130
> Modules linked in: act_mirred act_skbedit vhost_vdpa cls_matchall
> nfnetlink_cttimeout act_gact cls_flower sch_ingress mlx5_vdpa vringh vdpa
> openvswitch nsh vhost_net vhost vhost_iotlb tap ip6table_mangle ip6table_=
nat
> iptable_mangle nf_tables ip6table_filter ip6_tables xt_conntrack xt_MASQU=
ERADE
> nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat br_netfilte=
r
> rpcsec_gss_krb5 auth_rpcgss oid_registry overlay rpcrdma rdma_ucm ib_iser
> libiscsi ib_umad scsi_transport_iscsi ib_ipoib rdma_cm iw_cm ib_cm mlx5_i=
b
> ib_uverbs ib_core fuse mlx5_core
> CPU: 1 PID: 58633 Comm: CPU 0/KVM Tainted: G        W
> 6.10.0-rc1_for_upstream_min_debug_2024_05_29_17_06 #1
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> RIP: 0010:track_pfn_remap+0x12b/0x130
> Code: 48 83 c4 08 b8 ea ff ff ff 5b 5d 41 5c 41 5d c3 48 83 c4 08 48 89 e=
f 48
> 89 f2 5b 31 c9 4c 89 c6 5d 41 5c 41 5d e9 f5 fb ff ff <0f> 0b eb 9b 90 0f=
 1f 44
> 00 00 80 3d ac 59 96 01 00 74 01 c3 48 89
> RSP: 0018:ffff888350f8b8e0 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000001000 RCX: 0000000000000000
> RDX: ffff8881080ca300 RSI: 0000000000001000 RDI: 0000000544003000
> RBP: 0000000544003000 R08: ffff888106730a60 R09: 0000000000000000
> R10: ffff888116eeff60 R11: 0000000000000000 R12: ffff888350f8b918
> R13: ffff888149f99da8 R14: 0000000000001000 R15: 0000000000001000
> FS:  00007f678d800700(0000) GS:ffff88852c880000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000004e54f8 CR3: 0000000112290004 CR4: 0000000000372eb0
> Call Trace:
>  <TASK>
>  ? __warn+0x78/0x110
>  ? track_pfn_remap+0x12b/0x130
>  ? report_bug+0x16d/0x180
>  ? handle_bug+0x3c/0x60
>  ? exc_invalid_op+0x14/0x70
>  ? asm_exc_invalid_op+0x16/0x20
>  ? track_pfn_remap+0x12b/0x130
>  remap_pfn_range+0x41/0xa0
>  vhost_vdpa_fault+0x6c/0xa0 [vhost_vdpa]
>  __do_fault+0x2f/0xb0
>  __handle_mm_fault+0x13d3/0x2210
>  handle_mm_fault+0xb0/0x260
>  fixup_user_fault+0x77/0x170
>  hva_to_pfn+0x2c5/0x4b0
>  kvm_faultin_pfn+0xd7/0x510
>  kvm_tdp_page_fault+0x111/0x190
>  kvm_mmu_do_page_fault+0x105/0x230
>  kvm_mmu_page_fault+0x7d/0x620
>  ? vmx_deliver_interrupt+0x110/0x190
>  ? __apic_accept_irq+0x16c/0x270
>  ? vmx_vmexit+0x8d/0xc0
>  vmx_handle_exit+0x110/0x640
>  kvm_arch_vcpu_ioctl_run+0xdb0/0x1c20
>  kvm_vcpu_ioctl+0x263/0x6a0
>  ? futex_wake+0x81/0x180
>  __x64_sys_ioctl+0x4a7/0x9d0
>  ? __x64_sys_futex+0x73/0x1c0
>  ? kvm_on_user_return+0x86/0x90
>  do_syscall_64+0x4c/0x100
>  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> RIP: 0033:0x7f679186a17b
> Code: 0f 1e fa 48 8b 05 1d ad 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff f=
f ff
> c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff=
 73 01
> c3 48 8b 0d ed ac 0c 00 f7 d8 64 89 01 48
> RSP: 002b:00007f678d7ff788 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 000000000000ae80 RCX: 00007f679186a17b
> RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000059
> RBP: 000055da5ee22050 R08: 000055da44b28160 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
> R13: 000055da452b05e0 R14: 0000000000000001 R15: 0000000000000000
>  </TASK>
> ---[ end trace 0000000000000000 ]---
>
> The warnings show up only when the vdpa page-per-vq option is used (doorb=
ell
> mapping to guest).
>
> The issue seems to have existed before, but was visible only with CONFIG_=
LOCKDEP
> enabled. I tried finding if this was introduced in more recent kernels, b=
ut
> stopped after going as far back as 6.5: the issue was still visible there=
.
>
> The warning is triggered for the following call chain:
> vhost_vdpa_fault()
>  -> remap_pfn_range()
>   -> remap_pfn_range_notrack()
>    -> vm_flags_set()
>     -> vma_start_write()
>      -> __is_vma_write_locked()
>       -> mmap_assert_write_locked()
>
>
> I've been trying to follow how the mm write lock is dropped in the above =
call
> chain or not taken at all. But I couldn't make much sense of it...

I've also had a glance at vfio_pci_mmap_fault, it seems to do something sim=
ilar.

> Any ideas of what could have gone wrong here?

Adding Peter for more thought here.

Thanks

>
> Thanks,
> Dragos

