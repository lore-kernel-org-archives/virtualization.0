Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBE8C433EF
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 08:15:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A05460F41;
	Wed,  9 Mar 2022 08:15:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WmYFtepOR10v; Wed,  9 Mar 2022 08:15:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7A8C460D4E;
	Wed,  9 Mar 2022 08:15:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49E9DC001D;
	Wed,  9 Mar 2022 08:15:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08068C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 08:15:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DCCEE84160
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 08:15:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wiMe2eXHCeu7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 08:15:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 56B5D84159
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 08:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646813700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bzlf6DGCK/4iQk439uQYS1xS2KTI+bfWjuKB96wdyKs=;
 b=I65BF0LbWef57M0EZ/eszBqLOi4o6YrZ2OFlDCOW1rO4YSd7qGlsfYgz9y4M5EKyZwzX1c
 28vZV5Mfpzbo/AzLRlzoFFMsvUr9BSqGZ6l1oiYOwtUp/yXQmOqJkQqgXO8ArXc6QF6tnr
 D81q8AcAq9o6zXpipRCtP9QGj3VURxw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-zCe0MxwuMEmK5SXpXUp3Vg-1; Wed, 09 Mar 2022 03:14:59 -0500
X-MC-Unique: zCe0MxwuMEmK5SXpXUp3Vg-1
Received: by mail-lf1-f69.google.com with SMTP id
 o25-20020a05651205d900b0043e6c10892bso561638lfo.14
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Mar 2022 00:14:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bzlf6DGCK/4iQk439uQYS1xS2KTI+bfWjuKB96wdyKs=;
 b=t/+AJAKO8ipf8z8gITANKfby60HUJelbtrxad7KV7JJxCebpFShz0OaTew3WYS2Jbf
 RCiwnor3ZO2/qA5eUkIbmqcjDCbPnSFdzOT1f/Ygkwm06aO6ylkgdkFZiXLLkuDBmPhR
 e9PUYqnUs1vhfDze2sCYBN0NtYaUkQTHtQNV7yqcVRltjAFAaarMEJtz90NtEoWdUcz6
 hOIiNiYlLCpzVj30vF3Tztr3lYaj27ZArANwqTEqHIKV5yJfxxYXRSDx/V4IO5ZHjVca
 WYSQ/ZJMnATW3xiC13Atq6XTp+XDZMwx1Y720sBz+kfptujmJ8ta3CD3NDLSNanKHLq7
 XWfA==
X-Gm-Message-State: AOAM533ohVtKO9N0WTBAFhn8InlDIFlIxvoipV8nYF+75GAg84xVL37a
 oZIqpG7yesFsue6Kj6sFBvYZNzUtFwBgH9EF9EVKCDBmzO5viowuvTweGrmSff/gKZfCqkyZRx1
 3yhLFC5igI/1Uta3NZkXSqavVCaaQz693SaWgsBJXNWWmJHQUpIwH3kVRvA==
X-Received: by 2002:a2e:b004:0:b0:247:e29f:fbd4 with SMTP id
 y4-20020a2eb004000000b00247e29ffbd4mr9954440ljk.315.1646813696985; 
 Wed, 09 Mar 2022 00:14:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzXc3hukHXqXWjc+72LrEtaMi+EyWtuyOx5RH8MJKJxudh7SaVkY++j5q6d008w15/KCVsRnHrsvHG7xNIHM7w=
X-Received: by 2002:a2e:b004:0:b0:247:e29f:fbd4 with SMTP id
 y4-20020a2eb004000000b00247e29ffbd4mr9954423ljk.315.1646813696711; Wed, 09
 Mar 2022 00:14:56 -0800 (PST)
MIME-Version: 1.0
References: <20211019070152.8236-1-jasowang@redhat.com>
 <20211019070152.8236-5-jasowang@redhat.com>
 <87y21kzd3f.wl-maz@kernel.org> <20220308113119-mutt-send-email-mst@kernel.org>
 <CACGkMEszR12BoEV=tds3u1DcC3VrChKuc9H3FzxAg1rH8im=_g@mail.gmail.com>
 <20220309020123-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220309020123-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Mar 2022 16:14:45 +0800
Message-ID: <CACGkMEtQHOpF13ZpQPyoRjBGpTn0d_CrsPao_d9XpG4nW70Lqg@mail.gmail.com>
Subject: Re: [PATCH V3 04/10] virtio_pci: harden MSI-X interrupts
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Content-Type: multipart/mixed; boundary="===============2021979946063502652=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============2021979946063502652==
Content-Type: multipart/alternative; boundary="00000000000067778f05d9c4b11f"

--00000000000067778f05d9c4b11f
Content-Type: text/plain; charset="UTF-8"

On Wed, Mar 9, 2022 at 3:04 PM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Wed, Mar 09, 2022 at 11:41:01AM +0800, Jason Wang wrote:
> >
> >
> > On Wed, Mar 9, 2022 at 12:36 AM Michael S. Tsirkin <mst@redhat.com>
> wrote:
> >
> >     On Tue, Mar 08, 2022 at 03:19:16PM +0000, Marc Zyngier wrote:
> >     > On Tue, 19 Oct 2021 08:01:46 +0100,
> >     > Jason Wang <jasowang@redhat.com> wrote:
> >     > >
> >     > > We used to synchronize pending MSI-X irq handlers via
> >     > > synchronize_irq(), this may not work for the untrusted device
> which
> >     > > may keep sending interrupts after reset which may lead unexpected
> >     > > results. Similarly, we should not enable MSI-X interrupt until
> the
> >     > > device is ready. So this patch fixes those two issues by:
> >     > >
> >     > > 1) switching to use disable_irq() to prevent the virtio interrupt
> >     > >    handlers to be called after the device is reset.
> >     > > 2) using IRQF_NO_AUTOEN and enable the MSI-X irq during .ready()
> >     > >
> >     > > This can make sure the virtio interrupt handler won't be called
> before
> >     > > virtio_device_ready() and after reset.
> >     > >
> >     > > Cc: Thomas Gleixner <tglx@linutronix.de>
> >     > > Cc: Peter Zijlstra <peterz@infradead.org>
> >     > > Cc: Paul E. McKenney <paulmck@kernel.org>
> >     > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> >     > > ---
> >     > >  drivers/virtio/virtio_pci_common.c | 27
> +++++++++++++++++++++------
> >     > >  drivers/virtio/virtio_pci_common.h |  6 ++++--
> >     > >  drivers/virtio/virtio_pci_legacy.c |  5 +++--
> >     > >  drivers/virtio/virtio_pci_modern.c |  6 ++++--
> >     > >  4 files changed, 32 insertions(+), 12 deletions(-)
> >     > >
> >     > > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/
> >     virtio_pci_common.c
> >     > > index b35bb2d57f62..8d8f83aca721 100644
> >     > > --- a/drivers/virtio/virtio_pci_common.c
> >     > > +++ b/drivers/virtio/virtio_pci_common.c
> >     > > @@ -24,8 +24,8 @@ MODULE_PARM_DESC(force_legacy,
> >     > >              "Force legacy mode for transitional virtio 1
> devices");
> >     > >  #endif
> >     > >
> >     > > -/* wait for pending irq handlers */
> >     > > -void vp_synchronize_vectors(struct virtio_device *vdev)
> >     > > +/* disable irq handlers */
> >     > > +void vp_disable_cbs(struct virtio_device *vdev)
> >     > >  {
> >     > >     struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> >     > >     int i;
> >     > > @@ -34,7 +34,20 @@ void vp_synchronize_vectors(struct
> virtio_device
> >     *vdev)
> >     > >             synchronize_irq(vp_dev->pci_dev->irq);
> >     > >
> >     > >     for (i = 0; i < vp_dev->msix_vectors; ++i)
> >     > > -           synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> >     > > +           disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> >     > > +}
> >     > > +
> >     > > +/* enable irq handlers */
> >     > > +void vp_enable_cbs(struct virtio_device *vdev)
> >     > > +{
> >     > > +   struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> >     > > +   int i;
> >     > > +
> >     > > +   if (vp_dev->intx_enabled)
> >     > > +           return;
> >     > > +
> >     > > +   for (i = 0; i < vp_dev->msix_vectors; ++i)
> >     > > +           enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> >     >
> >     > This results in a splat at boot time if you set maxcpus=<whatever>,
> >     > see below. Enabling interrupts that are affinity managed is *bad*.
> You
> >     > don't even know whether the CPU which is supposed to handle this is
> >     > online or not.
> >     >
> >     > The core kernel notices it, shouts and keeps the interrupt
> disabled,
> >     > but this should be fixed. The whole point of managed interrupts is
> to
> >     > let them be dealt with outside of the drivers, and tied into the
> CPUs
> >     > being brought up and down. If virtio needs (for one reason or
> another)
> >     > to manage interrupts on its own, so be it. But this patch isn't the
> >     > way to do it, I'm afraid.
> >     >
> >     >       M.
> >
> >     Thanks for reporting this!
> >
> >     What virtio is doing here isn't unique however.
> >
> >     If device driver is to be hardened against device sending interrupts
> >     while driver is initializing/cleaning up, it needs kernel to provide
> >     capability to disable these.
> >
> >     If we then declare that that is impossible for managed interrupts
> >     then that will mean most devices can't use managed interrupts
> >     because ideally we'd have all drivers hardened.
> >
> >
> > Or that probably means we need to use a driver specific mechanism as
> what we
> > did for INTX instead of using NO_AUTO_EN.
> >
> > Thanks
>
> What we did for INTX was pretty expensive, we justified this
> by saying INTX handling involves expensive IO reads anyway
> so it's in the noise.
>

We only add a READ_ONCE() on the callback like:

+       if (!READ_ONCE(vp_dev->intx_soft_enabled))
+               return IRQ_NONE;

It should not be that expensive.


>
> Let's see what does Thomas suggest.
>

Yes, sure.

Thanks


>
> >
> >
> >     Thomas I think you were the one who suggested enabling/disabling
> >     interrupts originally - thoughts?
> >
> >     Feedback appreciated.
> >
> >
> >
> >     > [    3.434849] ------------[ cut here ]------------
> >     > [    3.434850] WARNING: CPU: 0 PID: 93 at kernel/irq/chip.c:210
> >     irq_startup+0x10
> >     > e/0x120
> >     > [    3.434861] Modules linked in: virtio_net(E+) net_failover(E)
> failover
> >     (E) vir
> >     > tio_blk(E+) bochs(E+) drm_vram_helper(E) drm_ttm_helper(E) ttm(E)
> ahci
> >     (E+) libah
> >     > ci(E) virtio_pci(E) virtio_pci_legacy_dev(E)
> virtio_pci_modern_dev(E)
> >     virtio(E)
> >     > drm_kms_helper(E) cec(E) libata(E) crct10dif_pclmul(E)
> crct10dif_common
> >     (E) crc32
> >     > _pclmul(E) scsi_mod(E) i2c_i801(E) crc32c_intel(E) psmouse(E)
> i2c_smbus
> >     (E) scsi_
> >     > common(E) lpc_ich(E) virtio_ring(E) drm(E) button(E)
> >     > [    3.434890] CPU: 0 PID: 93 Comm: systemd-udevd Tainted: G
>
> >     E     5.
> >     > 17.0-rc7-00020-gea4424be1688 #63
> >     > [    3.434893] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS
> >     0.0.0 02
> >     > /06/2015
> >     > [    3.434897] RIP: 0010:irq_startup+0x10e/0x120
> >     > [    3.434904] Code: c0 75 2b 4c 89 e7 31 d2 4c 89 ee e8 dc c5 ff
> ff 48
> >     89 ef e8
> >     >  94 fe ff ff 41 89 c4 e9 33 ff ff ff e8 e7 ca ff ff e9 50 ff ff ff
> <0f>
> >     0b eb ac
> >     >  0f 0b eb a8 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00
> >     > [    3.434906] RSP: 0018:ffff972c402bbbf0 EFLAGS: 00010002
> >     > [    3.434908] RAX: 0000000000000004 RBX: 0000000000000001 RCX:
> >     0000000000000040
> >     > [    3.434912] RDX: 0000000000000000 RSI: ffffffffa768dee0 RDI:
> >     ffff8bcf8ce34648
> >     > [    3.434913] RBP: ffff8bcfb007a800 R08: 0000000000000004 R09:
> >     ffffffffa74cb828
> >     > [    3.434915] R10: 0000000000000000 R11: 0000000000000000 R12:
> >     0000000000000001
> >     > [    3.434916] R13: ffff8bcf8ce34648 R14: ffff8bcf8d185c70 R15:
> >     0000000000000200
> >     > [    3.434918] FS:  00007f5b3179f8c0(0000)
> GS:ffff8bcffbc00000(0000)
> >     knlGS:00000
> >     > 00000000000
> >     > [    3.434919] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >     > [    3.434921] CR2: 000055ca47bab6b8 CR3: 000000017bc40003 CR4:
> >     0000000000170ef0
> >     > [    3.434928] Call Trace:
> >     > [    3.434936]  <TASK>
> >     > [    3.434938]  enable_irq+0x48/0x90
> >     > [    3.434943]  vp_enable_cbs+0x36/0x70 [virtio_pci]
> >     > [    3.434948]  virtblk_probe+0x457/0x7dc [virtio_blk]
> >     > [    3.434954]  virtio_dev_probe+0x1ae/0x280 [virtio]
> >     > [    3.434959]  really_probe+0x1f5/0x3d0
> >     > [    3.434966]  __driver_probe_device+0xfe/0x180
> >     > [    3.434969]  driver_probe_device+0x1e/0x90
> >     > [    3.434971]  __driver_attach+0xc0/0x1c0
> >     > [    3.434974]  ? __device_attach_driver+0xe0/0xe0
> >     > [    3.434976]  ? __device_attach_driver+0xe0/0xe0
> >     > [    3.434978]  bus_for_each_dev+0x78/0xc0
> >     > [    3.434982]  bus_add_driver+0x149/0x1e0
> >     > [    3.434985]  driver_register+0x8b/0xe0
> >     > [    3.434987]  ? 0xffffffffc01aa000
> >     > [    3.434990]  init+0x52/0x1000 [virtio_blk]
> >     > [    3.434994]  do_one_initcall+0x44/0x200
> >     > [    3.435001]  ? kmem_cache_alloc_trace+0x300/0x400
> >     > [    3.435006]  do_init_module+0x4c/0x260
> >     > [    3.435013]  __do_sys_finit_module+0xb4/0x120
> >     > [    3.435018]  do_syscall_64+0x3b/0xc0
> >     > [    3.435027]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> >     > [    3.435037] RIP: 0033:0x7f5b31c589b9
> >     > [    3.435040] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44
> 00 00
> >     48 89 f8
> >     >  48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05
> <48>
> >     3d 01 f0
> >     >  ff ff 73 01 c3 48 8b 0d a7 54 0c 00 f7 d8 64 89 01 48
> >     > [    3.435042] RSP: 002b:00007ffc608fc198 EFLAGS: 00000246
> ORIG_RAX:
> >     00000000000
> >     > 00139
> >     > [    3.435045] RAX: ffffffffffffffda RBX: 000055ca47ba8700 RCX:
> >     00007f5b31c589b9
> >     > [    3.435046] RDX: 0000000000000000 RSI: 00007f5b31de3e2d RDI:
> >     0000000000000005
> >     > [    3.435048] RBP: 0000000000020000 R08: 0000000000000000 R09:
> >     000055ca47ba9030
> >     > [    3.435049] R10: 0000000000000005 R11: 0000000000000246 R12:
> >     00007f5b31de3e2d
> >     > [    3.435050] R13: 0000000000000000 R14: 000055ca47ba7060 R15:
> >     000055ca47ba8700
> >     > [    3.435053]  </TASK>
> >     > [    3.435059] ---[ end trace 0000000000000000 ]---
> >     > [    3.440593]  vda: vda1 vda2 vda3
> >     > [    3.445283] scsi host0: Virtio SCSI HBA
> >     > [    3.450373] scsi 0:0:0:0: CD-ROM            QEMU     QEMU
> CD-ROM
> >     2.5+ PQ
> >     > : 0 ANSI: 5
> >     >
> >     > --
> >     > Without deviation from the norm, progress is not possible.
> >
> >
>
>

--00000000000067778f05d9c4b11f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 9, 2022 at 3:04 PM Michae=
l S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, Ma=
r 09, 2022 at 11:41:01AM +0800, Jason Wang wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Wed, Mar 9, 2022 at 12:36 AM Michael S. Tsirkin &lt;<a href=3D"mail=
to:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Tue, Mar 08, 2022 at 03:19:16PM +0000, Marc Zyng=
ier wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; On Tue, 19 Oct 2021 08:01:46 +0100,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Jason Wang &lt;<a href=3D"mailto:jasowang@redh=
at.com" target=3D"_blank">jasowang@redhat.com</a>&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; We used to synchronize pending MSI-X irq =
handlers via<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; synchronize_irq(), this may not work for =
the untrusted device which<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; may keep sending interrupts after reset w=
hich may lead unexpected<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; results. Similarly, we should not enable =
MSI-X interrupt until the<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; device is ready. So this patch fixes thos=
e two issues by:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; 1) switching to use disable_irq() to prev=
ent the virtio interrupt<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 handlers to be called after =
the device is reset.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; 2) using IRQF_NO_AUTOEN and enable the MS=
I-X irq during .ready()<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; This can make sure the virtio interrupt h=
andler won&#39;t be called before<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; virtio_device_ready() and after reset.<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; Cc: Thomas Gleixner &lt;<a href=3D"mailto=
:tglx@linutronix.de" target=3D"_blank">tglx@linutronix.de</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; Cc: Peter Zijlstra &lt;<a href=3D"mailto:=
peterz@infradead.org" target=3D"_blank">peterz@infradead.org</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; Cc: Paul E. McKenney &lt;<a href=3D"mailt=
o:paulmck@kernel.org" target=3D"_blank">paulmck@kernel.org</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; Signed-off-by: Jason Wang &lt;<a href=3D"=
mailto:jasowang@redhat.com" target=3D"_blank">jasowang@redhat.com</a>&gt;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 drivers/virtio/virtio_pci_common.c =
| 27 +++++++++++++++++++++------<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 drivers/virtio/virtio_pci_common.h =
|=C2=A0 6 ++++--<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 drivers/virtio/virtio_pci_legacy.c =
|=C2=A0 5 +++--<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 drivers/virtio/virtio_pci_modern.c =
|=C2=A0 6 ++++--<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 4 files changed, 32 insertions(+), =
12 deletions(-)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; diff --git a/drivers/virtio/virtio_pci_co=
mmon.c b/drivers/virtio/<br>
&gt;=C2=A0 =C2=A0 =C2=A0virtio_pci_common.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; index b35bb2d57f62..8d8f83aca721 100644<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; --- a/drivers/virtio/virtio_pci_common.c<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; +++ b/drivers/virtio/virtio_pci_common.c<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; @@ -24,8 +24,8 @@ MODULE_PARM_DESC(force_=
legacy,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &quot;Force legacy mode for transitional virtio 1 devices&quot;);<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 #endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; -/* wait for pending irq handlers */<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; -void vp_synchronize_vectors(struct virti=
o_device *vdev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; +/* disable irq handlers */<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; +void vp_disable_cbs(struct virtio_device=
 *vdev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=A0struct virtio_pci_devi=
ce *vp_dev =3D to_vp_device(vdev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=A0int i;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; @@ -34,7 +34,20 @@ void vp_synchronize_ve=
ctors(struct virtio_device<br>
&gt;=C2=A0 =C2=A0 =C2=A0*vdev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0synchronize_irq(vp_dev-&gt;pci_dev-&gt;irq);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; v=
p_dev-&gt;msix_vectors; ++i)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0synchronize_irq(pci_irq_vector(vp_dev-&gt;pci_dev, i));<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0disable_irq(pci_irq_vector(vp_dev-&gt;pci_dev, i));<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; +/* enable irq handlers */<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; +void vp_enable_cbs(struct virtio_device =
*vdev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; +=C2=A0 =C2=A0struct virtio_pci_device *v=
p_dev =3D to_vp_device(vdev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; +=C2=A0 =C2=A0int i;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; +=C2=A0 =C2=A0if (vp_dev-&gt;intx_enabled=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; +=C2=A0 =C2=A0for (i =3D 0; i &lt; vp_dev=
-&gt;msix_vectors; ++i)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0enable_irq(pci_irq_vector(vp_dev-&gt;pci_dev, i));<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; This results in a splat at boot time if you se=
t maxcpus=3D&lt;whatever&gt;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; see below. Enabling interrupts that are affini=
ty managed is *bad*. You<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; don&#39;t even know whether the CPU which is s=
upposed to handle this is<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; online or not.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; The core kernel notices it, shouts and keeps t=
he interrupt disabled,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; but this should be fixed. The whole point of m=
anaged interrupts is to<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; let them be dealt with outside of the drivers,=
 and tied into the CPUs<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; being brought up and down. If virtio needs (fo=
r one reason or another)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; to manage interrupts on its own, so be it. But=
 this patch isn&#39;t the<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; way to do it, I&#39;m afraid.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0M.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Thanks for reporting this!<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0What virtio is doing here isn&#39;t unique however.=
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0If device driver is to be hardened against device s=
ending interrupts<br>
&gt;=C2=A0 =C2=A0 =C2=A0while driver is initializing/cleaning up, it needs =
kernel to provide<br>
&gt;=C2=A0 =C2=A0 =C2=A0capability to disable these.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0If we then declare that that is impossible for mana=
ged interrupts<br>
&gt;=C2=A0 =C2=A0 =C2=A0then that will mean most devices can&#39;t use mana=
ged interrupts<br>
&gt;=C2=A0 =C2=A0 =C2=A0because ideally we&#39;d have all drivers hardened.=
<br>
&gt; <br>
&gt; <br>
&gt; Or that probably means we need to use a driver specific mechanism as w=
hat we<br>
&gt; did for INTX instead of using NO_AUTO_EN.<br>
&gt; <br>
&gt; Thanks=C2=A0<br>
<br>
What we did for INTX was pretty expensive, we justified this<br>
by saying INTX handling involves expensive IO reads anyway<br>
so it&#39;s in the noise.<br></blockquote><div><br></div><div>We only add a=
 READ_ONCE() on the callback like:</div><div><br></div><div>+ =C2=A0 =C2=A0=
 =C2=A0 if (!READ_ONCE(vp_dev-&gt;intx_soft_enabled))<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return IRQ_NONE;<br></div><div><br></div=
><div>It should not be that expensive.</div><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
<br>
Let&#39;s see what does Thomas suggest.<br></blockquote><div><br></div><div=
>Yes, sure.</div><div><br></div><div>Thanks</div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Thomas I think you were the one who suggested enabl=
ing/disabling<br>
&gt;=C2=A0 =C2=A0 =C2=A0interrupts originally - thoughts?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Feedback appreciated.<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.434849] ------------[ cut her=
e ]------------<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.434850] WARNING: CPU: 0 PID: =
93 at kernel/irq/chip.c:210<br>
&gt;=C2=A0 =C2=A0 =C2=A0irq_startup+0x10<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; e/0x120<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.434861] Modules linked in: vi=
rtio_net(E+) net_failover(E) failover<br>
&gt;=C2=A0 =C2=A0 =C2=A0(E) vir<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; tio_blk(E+) bochs(E+) drm_vram_helper(E) drm_t=
tm_helper(E) ttm(E) ahci<br>
&gt;=C2=A0 =C2=A0 =C2=A0(E+) libah<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; ci(E) virtio_pci(E) virtio_pci_legacy_dev(E) v=
irtio_pci_modern_dev(E)<br>
&gt;=C2=A0 =C2=A0 =C2=A0virtio(E)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; drm_kms_helper(E) cec(E) libata(E) crct10dif_p=
clmul(E) crct10dif_common<br>
&gt;=C2=A0 =C2=A0 =C2=A0(E) crc32<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; _pclmul(E) scsi_mod(E) i2c_i801(E) crc32c_inte=
l(E) psmouse(E) i2c_smbus<br>
&gt;=C2=A0 =C2=A0 =C2=A0(E) scsi_<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; common(E) lpc_ich(E) virtio_ring(E) drm(E) but=
ton(E)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.434890] CPU: 0 PID: 93 Comm: =
systemd-udevd Tainted: G=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0E=C2=A0 =C2=A0 =C2=A05.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; 17.0-rc7-00020-gea4424be1688 #63<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.434893] Hardware name: QEMU S=
tandard PC (Q35 + ICH9, 2009), BIOS<br>
&gt;=C2=A0 =C2=A0 =C2=A00.0.0 02<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; /06/2015<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.434897] RIP: 0010:irq_startup=
+0x10e/0x120<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.434904] Code: c0 75 2b 4c 89 =
e7 31 d2 4c 89 ee e8 dc c5 ff ff 48<br>
&gt;=C2=A0 =C2=A0 =C2=A089 ef e8<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 94 fe ff ff 41 89 c4 e9 33 ff ff ff e8 e=
7 ca ff ff e9 50 ff ff ff &lt;0f&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A00b eb ac<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 0f 0b eb a8 66 2e 0f 1f 84 00 00 00 00 0=
0 0f 1f 44 00<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.434906] RSP: 0018:ffff972c402=
bbbf0 EFLAGS: 00010002<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.434908] RAX: 0000000000000004=
 RBX: 0000000000000001 RCX:<br>
&gt;=C2=A0 =C2=A0 =C2=A00000000000000040<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.434912] RDX: 0000000000000000=
 RSI: ffffffffa768dee0 RDI:<br>
&gt;=C2=A0 =C2=A0 =C2=A0ffff8bcf8ce34648<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.434913] RBP: ffff8bcfb007a800=
 R08: 0000000000000004 R09:<br>
&gt;=C2=A0 =C2=A0 =C2=A0ffffffffa74cb828<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.434915] R10: 0000000000000000=
 R11: 0000000000000000 R12:<br>
&gt;=C2=A0 =C2=A0 =C2=A00000000000000001<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.434916] R13: ffff8bcf8ce34648=
 R14: ffff8bcf8d185c70 R15:<br>
&gt;=C2=A0 =C2=A0 =C2=A00000000000000200<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.434918] FS:=C2=A0 00007f5b317=
9f8c0(0000) GS:ffff8bcffbc00000(0000)<br>
&gt;=C2=A0 =C2=A0 =C2=A0knlGS:00000<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; 00000000000<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.434919] CS:=C2=A0 0010 DS: 00=
00 ES: 0000 CR0: 0000000080050033<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.434921] CR2: 000055ca47bab6b8=
 CR3: 000000017bc40003 CR4:<br>
&gt;=C2=A0 =C2=A0 =C2=A00000000000170ef0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.434928] Call Trace:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.434936]=C2=A0 &lt;TASK&gt;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.434938]=C2=A0 enable_irq+0x48=
/0x90<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.434943]=C2=A0 vp_enable_cbs+0=
x36/0x70 [virtio_pci]<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.434948]=C2=A0 virtblk_probe+0=
x457/0x7dc [virtio_blk]<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.434954]=C2=A0 virtio_dev_prob=
e+0x1ae/0x280 [virtio]<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.434959]=C2=A0 really_probe+0x=
1f5/0x3d0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.434966]=C2=A0 __driver_probe_=
device+0xfe/0x180<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.434969]=C2=A0 driver_probe_de=
vice+0x1e/0x90<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.434971]=C2=A0 __driver_attach=
+0xc0/0x1c0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.434974]=C2=A0 ? __device_atta=
ch_driver+0xe0/0xe0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.434976]=C2=A0 ? __device_atta=
ch_driver+0xe0/0xe0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.434978]=C2=A0 bus_for_each_de=
v+0x78/0xc0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.434982]=C2=A0 bus_add_driver+=
0x149/0x1e0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.434985]=C2=A0 driver_register=
+0x8b/0xe0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.434987]=C2=A0 ? 0xffffffffc01=
aa000<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.434990]=C2=A0 init+0x52/0x100=
0 [virtio_blk]<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.434994]=C2=A0 do_one_initcall=
+0x44/0x200<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.435001]=C2=A0 ? kmem_cache_al=
loc_trace+0x300/0x400<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.435006]=C2=A0 do_init_module+=
0x4c/0x260<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.435013]=C2=A0 __do_sys_finit_=
module+0xb4/0x120<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.435018]=C2=A0 do_syscall_64+0=
x3b/0xc0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.435027]=C2=A0 entry_SYSCALL_6=
4_after_hwframe+0x44/0xae<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.435037] RIP: 0033:0x7f5b31c58=
9b9<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.435040] Code: 00 c3 66 2e 0f =
1f 84 00 00 00 00 00 0f 1f 44 00 00<br>
&gt;=C2=A0 =C2=A0 =C2=A048 89 f8<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 8=
9 c8 4c 8b 4c 24 08 0f 05 &lt;48&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A03d 01 f0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 ff ff 73 01 c3 48 8b 0d a7 54 0c 00 f7 d=
8 64 89 01 48<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.435042] RSP: 002b:00007ffc608=
fc198 EFLAGS: 00000246 ORIG_RAX:<br>
&gt;=C2=A0 =C2=A0 =C2=A000000000000<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; 00139<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.435045] RAX: ffffffffffffffda=
 RBX: 000055ca47ba8700 RCX:<br>
&gt;=C2=A0 =C2=A0 =C2=A000007f5b31c589b9<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.435046] RDX: 0000000000000000=
 RSI: 00007f5b31de3e2d RDI:<br>
&gt;=C2=A0 =C2=A0 =C2=A00000000000000005<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.435048] RBP: 0000000000020000=
 R08: 0000000000000000 R09:<br>
&gt;=C2=A0 =C2=A0 =C2=A0000055ca47ba9030<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.435049] R10: 0000000000000005=
 R11: 0000000000000246 R12:<br>
&gt;=C2=A0 =C2=A0 =C2=A000007f5b31de3e2d<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.435050] R13: 0000000000000000=
 R14: 000055ca47ba7060 R15:<br>
&gt;=C2=A0 =C2=A0 =C2=A0000055ca47ba8700<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.435053]=C2=A0 &lt;/TASK&gt;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.435059] ---[ end trace 000000=
0000000000 ]---<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.440593]=C2=A0 vda: vda1 vda2 =
vda3<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.445283] scsi host0: Virtio SC=
SI HBA<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [=C2=A0 =C2=A0 3.450373] scsi 0:0:0:0: CD-ROM=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QEMU=C2=A0 =C2=A0 =C2=A0QEMU CD-R=
OM=C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A02.5+ PQ<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; : 0 ANSI: 5<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; --<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Without deviation from the norm, progress is n=
ot possible.<br>
&gt; <br>
&gt; <br>
<br>
</blockquote></div></div>

--00000000000067778f05d9c4b11f--


--===============2021979946063502652==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2021979946063502652==--

