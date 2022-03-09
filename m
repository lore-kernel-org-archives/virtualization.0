Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F078C4332F
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 07:04:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B15F060D55;
	Wed,  9 Mar 2022 07:04:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f892CmceAu8M; Wed,  9 Mar 2022 07:04:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E70FC60C22;
	Wed,  9 Mar 2022 07:04:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A63DDC0012;
	Wed,  9 Mar 2022 07:04:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D26B4C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 07:04:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A64DC8333F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 07:04:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KH-cG5oYfbVX
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 07:04:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 83ADD83323
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 07:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646809451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cZlxSCuMLBQaOXGBfR9hCieMl+CRPGYnGKDTh2qEHUI=;
 b=D9klu0PyIoOg1XY0C6xEVfaPi99Q4/YuUJg5bkb7VVNUxrf7FWJPgxEmRXiwVxnKxGEHLk
 znu93BXXvfXBRFN3F3/fgEr85Jtyq0W3bzyVlQ/+c9TLObqvYMXtkC6qPHFayJay4/zSHx
 oH5n2zbhdSsbe7wh7Nqup7Hx98RIwZ0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-133-vApLvpZ9Nz6SYMDsG8GIRA-1; Wed, 09 Mar 2022 02:04:10 -0500
X-MC-Unique: vApLvpZ9Nz6SYMDsG8GIRA-1
Received: by mail-wr1-f72.google.com with SMTP id
 t8-20020adfa2c8000000b001e8f6889404so415457wra.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Mar 2022 23:04:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=cZlxSCuMLBQaOXGBfR9hCieMl+CRPGYnGKDTh2qEHUI=;
 b=LXN2bZWx4+1x064yrbSRAC0MC7ZxrhWGlToENlxgEoWIFqYHIlHKnWVVbD9XFOsz86
 h7JYRRPtNXLsrJZigxMd3DdZTcnJi8793/xcblc2al6xE5X5Kt2EvKgBbYv0R9WCB8lD
 5ELeV2olsehS3te7GOq34Z7Qn4gSg4lsC7/OcylB0uoQd9JlLJBUrBWHMbOrzfyZL71P
 hkxdbAD5FkaT1ilmgsECX/PmaCjNTta9VRi1KVI/NQeZpCCkmEcsecrdJUeR1k2dqUyH
 C9MhcAEvh69pglEfU3pcwtU7Czcux0OaH7w4Ktrds5vnA8YifvGGSDNkaTbNCzTU6VeN
 mEYQ==
X-Gm-Message-State: AOAM532F0Hwuw3GKw6DXgvBL6Nkb51FqcIZZWpDYItJaJcfR1sItQpSh
 lSJPSLaqGWa3Mbzy3jxiZ4YxwHJ24X/a33TkHssI0UGMw+qoSxrOlw9ZTyxkiVehk64cH4OwfPk
 Gg+24e8IiG0Bf3BLjniwoCP0sLoI9CYUAlHd8O7CGAA==
X-Received: by 2002:a5d:5887:0:b0:1f1:eb44:724e with SMTP id
 n7-20020a5d5887000000b001f1eb44724emr12027325wrf.44.1646809448421; 
 Tue, 08 Mar 2022 23:04:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwsy6Ytwma5gqRDMKuXAQewkNAd01cq5kPhy3hzhCjwT33e0tUETPpdiECHZdsMyGjAfTEcHQ==
X-Received: by 2002:a5d:5887:0:b0:1f1:eb44:724e with SMTP id
 n7-20020a5d5887000000b001f1eb44724emr12027302wrf.44.1646809448122; 
 Tue, 08 Mar 2022 23:04:08 -0800 (PST)
Received: from redhat.com ([2.55.46.250]) by smtp.gmail.com with ESMTPSA id
 s17-20020adfbc11000000b001f023d197b8sm830608wrg.68.2022.03.08.23.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Mar 2022 23:04:07 -0800 (PST)
Date: Wed, 9 Mar 2022 02:04:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 04/10] virtio_pci: harden MSI-X interrupts
Message-ID: <20220309020123-mutt-send-email-mst@kernel.org>
References: <20211019070152.8236-1-jasowang@redhat.com>
 <20211019070152.8236-5-jasowang@redhat.com>
 <87y21kzd3f.wl-maz@kernel.org>
 <20220308113119-mutt-send-email-mst@kernel.org>
 <CACGkMEszR12BoEV=tds3u1DcC3VrChKuc9H3FzxAg1rH8im=_g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEszR12BoEV=tds3u1DcC3VrChKuc9H3FzxAg1rH8im=_g@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: keirf@google.com, "Paul E . McKenney" <paulmck@kernel.org>, "kaplan,
 david" <david.kaplan@amd.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>, "Hetzelt,
 Felicitas" <f.hetzelt@tu-berlin.de>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Mar 09, 2022 at 11:41:01AM +0800, Jason Wang wrote:
> =

> =

> On Wed, Mar 9, 2022 at 12:36 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> =

>     On Tue, Mar 08, 2022 at 03:19:16PM +0000, Marc Zyngier wrote:
>     > On Tue, 19 Oct 2021 08:01:46 +0100,
>     > Jason Wang <jasowang@redhat.com> wrote:
>     > >
>     > > We used to synchronize pending MSI-X irq handlers via
>     > > synchronize_irq(), this may not work for the untrusted device whi=
ch
>     > > may keep sending interrupts after reset which may lead unexpected
>     > > results. Similarly, we should not enable MSI-X interrupt until the
>     > > device is ready. So this patch fixes those two issues by:
>     > >
>     > > 1) switching to use disable_irq() to prevent the virtio interrupt
>     > >=A0 =A0 handlers to be called after the device is reset.
>     > > 2) using IRQF_NO_AUTOEN and enable the MSI-X irq during .ready()
>     > >
>     > > This can make sure the virtio interrupt handler won't be called b=
efore
>     > > virtio_device_ready() and after reset.
>     > >
>     > > Cc: Thomas Gleixner <tglx@linutronix.de>
>     > > Cc: Peter Zijlstra <peterz@infradead.org>
>     > > Cc: Paul E. McKenney <paulmck@kernel.org>
>     > > Signed-off-by: Jason Wang <jasowang@redhat.com>
>     > > ---
>     > >=A0 drivers/virtio/virtio_pci_common.c | 27 +++++++++++++++++++++-=
-----
>     > >=A0 drivers/virtio/virtio_pci_common.h |=A0 6 ++++--
>     > >=A0 drivers/virtio/virtio_pci_legacy.c |=A0 5 +++--
>     > >=A0 drivers/virtio/virtio_pci_modern.c |=A0 6 ++++--
>     > >=A0 4 files changed, 32 insertions(+), 12 deletions(-)
>     > >
>     > > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/
>     virtio_pci_common.c
>     > > index b35bb2d57f62..8d8f83aca721 100644
>     > > --- a/drivers/virtio/virtio_pci_common.c
>     > > +++ b/drivers/virtio/virtio_pci_common.c
>     > > @@ -24,8 +24,8 @@ MODULE_PARM_DESC(force_legacy,
>     > >=A0 =A0 =A0 =A0 =A0 =A0 =A0 "Force legacy mode for transitional vi=
rtio 1 devices");
>     > >=A0 #endif
>     > >=A0
>     > > -/* wait for pending irq handlers */
>     > > -void vp_synchronize_vectors(struct virtio_device *vdev)
>     > > +/* disable irq handlers */
>     > > +void vp_disable_cbs(struct virtio_device *vdev)
>     > >=A0 {
>     > >=A0 =A0 =A0struct virtio_pci_device *vp_dev =3D to_vp_device(vdev);
>     > >=A0 =A0 =A0int i;
>     > > @@ -34,7 +34,20 @@ void vp_synchronize_vectors(struct virtio_devi=
ce
>     *vdev)
>     > >=A0 =A0 =A0 =A0 =A0 =A0 =A0synchronize_irq(vp_dev->pci_dev->irq);
>     > >=A0
>     > >=A0 =A0 =A0for (i =3D 0; i < vp_dev->msix_vectors; ++i)
>     > > -=A0 =A0 =A0 =A0 =A0 =A0synchronize_irq(pci_irq_vector(vp_dev->pc=
i_dev, i));
>     > > +=A0 =A0 =A0 =A0 =A0 =A0disable_irq(pci_irq_vector(vp_dev->pci_de=
v, i));
>     > > +}
>     > > +
>     > > +/* enable irq handlers */
>     > > +void vp_enable_cbs(struct virtio_device *vdev)
>     > > +{
>     > > +=A0 =A0struct virtio_pci_device *vp_dev =3D to_vp_device(vdev);
>     > > +=A0 =A0int i;
>     > > +
>     > > +=A0 =A0if (vp_dev->intx_enabled)
>     > > +=A0 =A0 =A0 =A0 =A0 =A0return;
>     > > +
>     > > +=A0 =A0for (i =3D 0; i < vp_dev->msix_vectors; ++i)
>     > > +=A0 =A0 =A0 =A0 =A0 =A0enable_irq(pci_irq_vector(vp_dev->pci_dev=
, i));
>     >
>     > This results in a splat at boot time if you set maxcpus=3D<whatever=
>,
>     > see below. Enabling interrupts that are affinity managed is *bad*. =
You
>     > don't even know whether the CPU which is supposed to handle this is
>     > online or not.
>     >
>     > The core kernel notices it, shouts and keeps the interrupt disabled,
>     > but this should be fixed. The whole point of managed interrupts is =
to
>     > let them be dealt with outside of the drivers, and tied into the CP=
Us
>     > being brought up and down. If virtio needs (for one reason or anoth=
er)
>     > to manage interrupts on its own, so be it. But this patch isn't the
>     > way to do it, I'm afraid.
>     >
>     >=A0 =A0 =A0 =A0M.
> =

>     Thanks for reporting this!
> =

>     What virtio is doing here isn't unique however.
> =

>     If device driver is to be hardened against device sending interrupts
>     while driver is initializing/cleaning up, it needs kernel to provide
>     capability to disable these.
> =

>     If we then declare that that is impossible for managed interrupts
>     then that will mean most devices can't use managed interrupts
>     because ideally we'd have all drivers hardened.
> =

> =

> Or that probably means we need to use a driver specific mechanism as what=
 we
> did for INTX instead of using NO_AUTO_EN.
> =

> Thanks=A0

What we did for INTX was pretty expensive, we justified this
by saying INTX handling involves expensive IO reads anyway
so it's in the noise.

Let's see what does Thomas suggest.

> =

> =

>     Thomas I think you were the one who suggested enabling/disabling
>     interrupts originally - thoughts?
> =

>     Feedback appreciated.
> =

> =

> =

>     > [=A0 =A0 3.434849] ------------[ cut here ]------------
>     > [=A0 =A0 3.434850] WARNING: CPU: 0 PID: 93 at kernel/irq/chip.c:210
>     irq_startup+0x10
>     > e/0x120
>     > [=A0 =A0 3.434861] Modules linked in: virtio_net(E+) net_failover(E=
) failover
>     (E) vir
>     > tio_blk(E+) bochs(E+) drm_vram_helper(E) drm_ttm_helper(E) ttm(E) a=
hci
>     (E+) libah
>     > ci(E) virtio_pci(E) virtio_pci_legacy_dev(E) virtio_pci_modern_dev(=
E)
>     virtio(E)
>     > drm_kms_helper(E) cec(E) libata(E) crct10dif_pclmul(E) crct10dif_co=
mmon
>     (E) crc32
>     > _pclmul(E) scsi_mod(E) i2c_i801(E) crc32c_intel(E) psmouse(E) i2c_s=
mbus
>     (E) scsi_
>     > common(E) lpc_ich(E) virtio_ring(E) drm(E) button(E)
>     > [=A0 =A0 3.434890] CPU: 0 PID: 93 Comm: systemd-udevd Tainted: G=A0=
 =A0 =A0 =A0 =A0 =A0
>     E=A0 =A0 =A05.
>     > 17.0-rc7-00020-gea4424be1688 #63
>     > [=A0 =A0 3.434893] Hardware name: QEMU Standard PC (Q35 + ICH9, 200=
9), BIOS
>     0.0.0 02
>     > /06/2015
>     > [=A0 =A0 3.434897] RIP: 0010:irq_startup+0x10e/0x120
>     > [=A0 =A0 3.434904] Code: c0 75 2b 4c 89 e7 31 d2 4c 89 ee e8 dc c5 =
ff ff 48
>     89 ef e8
>     >=A0 94 fe ff ff 41 89 c4 e9 33 ff ff ff e8 e7 ca ff ff e9 50 ff ff f=
f <0f>
>     0b eb ac
>     >=A0 0f 0b eb a8 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00
>     > [=A0 =A0 3.434906] RSP: 0018:ffff972c402bbbf0 EFLAGS: 00010002
>     > [=A0 =A0 3.434908] RAX: 0000000000000004 RBX: 0000000000000001 RCX:
>     0000000000000040
>     > [=A0 =A0 3.434912] RDX: 0000000000000000 RSI: ffffffffa768dee0 RDI:
>     ffff8bcf8ce34648
>     > [=A0 =A0 3.434913] RBP: ffff8bcfb007a800 R08: 0000000000000004 R09:
>     ffffffffa74cb828
>     > [=A0 =A0 3.434915] R10: 0000000000000000 R11: 0000000000000000 R12:
>     0000000000000001
>     > [=A0 =A0 3.434916] R13: ffff8bcf8ce34648 R14: ffff8bcf8d185c70 R15:
>     0000000000000200
>     > [=A0 =A0 3.434918] FS:=A0 00007f5b3179f8c0(0000) GS:ffff8bcffbc0000=
0(0000)
>     knlGS:00000
>     > 00000000000
>     > [=A0 =A0 3.434919] CS:=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050=
033
>     > [=A0 =A0 3.434921] CR2: 000055ca47bab6b8 CR3: 000000017bc40003 CR4:
>     0000000000170ef0
>     > [=A0 =A0 3.434928] Call Trace:
>     > [=A0 =A0 3.434936]=A0 <TASK>
>     > [=A0 =A0 3.434938]=A0 enable_irq+0x48/0x90
>     > [=A0 =A0 3.434943]=A0 vp_enable_cbs+0x36/0x70 [virtio_pci]
>     > [=A0 =A0 3.434948]=A0 virtblk_probe+0x457/0x7dc [virtio_blk]
>     > [=A0 =A0 3.434954]=A0 virtio_dev_probe+0x1ae/0x280 [virtio]
>     > [=A0 =A0 3.434959]=A0 really_probe+0x1f5/0x3d0
>     > [=A0 =A0 3.434966]=A0 __driver_probe_device+0xfe/0x180
>     > [=A0 =A0 3.434969]=A0 driver_probe_device+0x1e/0x90
>     > [=A0 =A0 3.434971]=A0 __driver_attach+0xc0/0x1c0
>     > [=A0 =A0 3.434974]=A0 ? __device_attach_driver+0xe0/0xe0
>     > [=A0 =A0 3.434976]=A0 ? __device_attach_driver+0xe0/0xe0
>     > [=A0 =A0 3.434978]=A0 bus_for_each_dev+0x78/0xc0
>     > [=A0 =A0 3.434982]=A0 bus_add_driver+0x149/0x1e0
>     > [=A0 =A0 3.434985]=A0 driver_register+0x8b/0xe0
>     > [=A0 =A0 3.434987]=A0 ? 0xffffffffc01aa000
>     > [=A0 =A0 3.434990]=A0 init+0x52/0x1000 [virtio_blk]
>     > [=A0 =A0 3.434994]=A0 do_one_initcall+0x44/0x200
>     > [=A0 =A0 3.435001]=A0 ? kmem_cache_alloc_trace+0x300/0x400
>     > [=A0 =A0 3.435006]=A0 do_init_module+0x4c/0x260
>     > [=A0 =A0 3.435013]=A0 __do_sys_finit_module+0xb4/0x120
>     > [=A0 =A0 3.435018]=A0 do_syscall_64+0x3b/0xc0
>     > [=A0 =A0 3.435027]=A0 entry_SYSCALL_64_after_hwframe+0x44/0xae
>     > [=A0 =A0 3.435037] RIP: 0033:0x7f5b31c589b9
>     > [=A0 =A0 3.435040] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f =
44 00 00
>     48 89 f8
>     >=A0 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 0=
5 <48>
>     3d 01 f0
>     >=A0 ff ff 73 01 c3 48 8b 0d a7 54 0c 00 f7 d8 64 89 01 48
>     > [=A0 =A0 3.435042] RSP: 002b:00007ffc608fc198 EFLAGS: 00000246 ORIG=
_RAX:
>     00000000000
>     > 00139
>     > [=A0 =A0 3.435045] RAX: ffffffffffffffda RBX: 000055ca47ba8700 RCX:
>     00007f5b31c589b9
>     > [=A0 =A0 3.435046] RDX: 0000000000000000 RSI: 00007f5b31de3e2d RDI:
>     0000000000000005
>     > [=A0 =A0 3.435048] RBP: 0000000000020000 R08: 0000000000000000 R09:
>     000055ca47ba9030
>     > [=A0 =A0 3.435049] R10: 0000000000000005 R11: 0000000000000246 R12:
>     00007f5b31de3e2d
>     > [=A0 =A0 3.435050] R13: 0000000000000000 R14: 000055ca47ba7060 R15:
>     000055ca47ba8700
>     > [=A0 =A0 3.435053]=A0 </TASK>
>     > [=A0 =A0 3.435059] ---[ end trace 0000000000000000 ]---
>     > [=A0 =A0 3.440593]=A0 vda: vda1 vda2 vda3
>     > [=A0 =A0 3.445283] scsi host0: Virtio SCSI HBA
>     > [=A0 =A0 3.450373] scsi 0:0:0:0: CD-ROM=A0 =A0 =A0 =A0 =A0 =A0 QEMU=
=A0 =A0 =A0QEMU CD-ROM=A0 =A0 =A0
>     2.5+ PQ
>     > : 0 ANSI: 5
>     >
>     > --
>     > Without deviation from the norm, progress is not possible.
> =

> =


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
