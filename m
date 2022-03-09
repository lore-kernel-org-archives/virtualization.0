Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A00BC433F5
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 03:41:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2CDE60BEA;
	Wed,  9 Mar 2022 03:41:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zp0w7hNBvrfX; Wed,  9 Mar 2022 03:41:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AF152608B7;
	Wed,  9 Mar 2022 03:41:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91180C0012;
	Wed,  9 Mar 2022 03:41:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B87BEC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 03:41:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A76D084273
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 03:41:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 32DR7AV8hkuS
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 03:41:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 277F28426F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 03:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646797276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fxj7OqbNP7EXasZNVfoXFHnfeTsAH4VB5HF40ktBlb4=;
 b=a3Op/N6/6pDEhpscMPJ1+g7abTRjr0JXipaqB1lTw8xKGb5AZakyyY1tauaLTwHoq6ah6T
 iVxR4dGO9Ws3hjdESZRgT0WdR+0uKO5BqoDeZ0P3qDBOyup4GpB4zZfLutaaCnOH5QGF2K
 sEj+spVm5XGo9hv3W7WjSL7/bnM7BSA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-478-fnTxhlioOEKQgQr41fs3jQ-1; Tue, 08 Mar 2022 22:41:14 -0500
X-MC-Unique: fnTxhlioOEKQgQr41fs3jQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 h21-20020a05651c125500b002464536cf4eso274403ljh.23
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Mar 2022 19:41:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fxj7OqbNP7EXasZNVfoXFHnfeTsAH4VB5HF40ktBlb4=;
 b=yauHsu529FkIJkjgD86TkQF7o/CVyY8wT1PcUZ7YgjdfMuDVuGRKRqfD6WPfO2uU0t
 3AaGeL2dIFDEIrr9diMBoa/MjQujheA+UYA00hJEONP9b7jd5ZCsX0RqXXbYIiGukn+x
 Y8QLy+lrWx/dGuERcpcMYlptQYFWLx7mq+M/vsbyMKE+5vxt9R3Ia2RbqtLtVMjz/7LQ
 V2xEIZLMBRv5n8Jrk5dMqY2AyiK4Wp8Gera18hT2jrTEBvcyaKEIjB2eVnXkTfJzG1sX
 Fo7QPiKTTQ3D/p9qwpTIAGq/fiAW6AxzYKK1vY2a5W7nGM0KU/Gmf5OqHIpoZBWznLvx
 jn8w==
X-Gm-Message-State: AOAM532mrMdLCkMRWIyO5mD0hRXZjpao7AkI3qs/6WQ8/eeh9TfL3OXV
 gXvW7NsF5PVFTit29E7KY9SmY5MvUlTGEDLeNK83N675HOQaddsQq7JyCluyI3id0v5Bws1h6NZ
 NhMZgjrtnbWkc+fR39zVSoQqSPpX7S5saPbHsBSJYrxSc5JSZgLIs0SVnDg==
X-Received: by 2002:a05:6512:3d08:b0:43f:8f45:d670 with SMTP id
 d8-20020a0565123d0800b0043f8f45d670mr13261657lfv.587.1646797272822; 
 Tue, 08 Mar 2022 19:41:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxT2D5Z9+x7SqQ/6dVwE5qTjYhDIt8KgIpTGzUnnO0EdyPXVmC7QCZNcLJqIscH10CIB3yOBMWPgzh3xL11jqE=
X-Received: by 2002:a05:6512:3d08:b0:43f:8f45:d670 with SMTP id
 d8-20020a0565123d0800b0043f8f45d670mr13261646lfv.587.1646797272568; Tue, 08
 Mar 2022 19:41:12 -0800 (PST)
MIME-Version: 1.0
References: <20211019070152.8236-1-jasowang@redhat.com>
 <20211019070152.8236-5-jasowang@redhat.com>
 <87y21kzd3f.wl-maz@kernel.org> <20220308113119-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220308113119-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Mar 2022 11:41:01 +0800
Message-ID: <CACGkMEszR12BoEV=tds3u1DcC3VrChKuc9H3FzxAg1rH8im=_g@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============4693123589580649933=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============4693123589580649933==
Content-Type: multipart/alternative; boundary="00000000000072ee9905d9c0de39"

--00000000000072ee9905d9c0de39
Content-Type: text/plain; charset="UTF-8"

On Wed, Mar 9, 2022 at 12:36 AM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Tue, Mar 08, 2022 at 03:19:16PM +0000, Marc Zyngier wrote:
> > On Tue, 19 Oct 2021 08:01:46 +0100,
> > Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > We used to synchronize pending MSI-X irq handlers via
> > > synchronize_irq(), this may not work for the untrusted device which
> > > may keep sending interrupts after reset which may lead unexpected
> > > results. Similarly, we should not enable MSI-X interrupt until the
> > > device is ready. So this patch fixes those two issues by:
> > >
> > > 1) switching to use disable_irq() to prevent the virtio interrupt
> > >    handlers to be called after the device is reset.
> > > 2) using IRQF_NO_AUTOEN and enable the MSI-X irq during .ready()
> > >
> > > This can make sure the virtio interrupt handler won't be called before
> > > virtio_device_ready() and after reset.
> > >
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  drivers/virtio/virtio_pci_common.c | 27 +++++++++++++++++++++------
> > >  drivers/virtio/virtio_pci_common.h |  6 ++++--
> > >  drivers/virtio/virtio_pci_legacy.c |  5 +++--
> > >  drivers/virtio/virtio_pci_modern.c |  6 ++++--
> > >  4 files changed, 32 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_pci_common.c
> b/drivers/virtio/virtio_pci_common.c
> > > index b35bb2d57f62..8d8f83aca721 100644
> > > --- a/drivers/virtio/virtio_pci_common.c
> > > +++ b/drivers/virtio/virtio_pci_common.c
> > > @@ -24,8 +24,8 @@ MODULE_PARM_DESC(force_legacy,
> > >              "Force legacy mode for transitional virtio 1 devices");
> > >  #endif
> > >
> > > -/* wait for pending irq handlers */
> > > -void vp_synchronize_vectors(struct virtio_device *vdev)
> > > +/* disable irq handlers */
> > > +void vp_disable_cbs(struct virtio_device *vdev)
> > >  {
> > >     struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > >     int i;
> > > @@ -34,7 +34,20 @@ void vp_synchronize_vectors(struct virtio_device
> *vdev)
> > >             synchronize_irq(vp_dev->pci_dev->irq);
> > >
> > >     for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > -           synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > +           disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > +}
> > > +
> > > +/* enable irq handlers */
> > > +void vp_enable_cbs(struct virtio_device *vdev)
> > > +{
> > > +   struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > +   int i;
> > > +
> > > +   if (vp_dev->intx_enabled)
> > > +           return;
> > > +
> > > +   for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > +           enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> >
> > This results in a splat at boot time if you set maxcpus=<whatever>,
> > see below. Enabling interrupts that are affinity managed is *bad*. You
> > don't even know whether the CPU which is supposed to handle this is
> > online or not.
> >
> > The core kernel notices it, shouts and keeps the interrupt disabled,
> > but this should be fixed. The whole point of managed interrupts is to
> > let them be dealt with outside of the drivers, and tied into the CPUs
> > being brought up and down. If virtio needs (for one reason or another)
> > to manage interrupts on its own, so be it. But this patch isn't the
> > way to do it, I'm afraid.
> >
> >       M.
>
> Thanks for reporting this!
>
> What virtio is doing here isn't unique however.
>
> If device driver is to be hardened against device sending interrupts
> while driver is initializing/cleaning up, it needs kernel to provide
> capability to disable these.
>
> If we then declare that that is impossible for managed interrupts
> then that will mean most devices can't use managed interrupts
> because ideally we'd have all drivers hardened.
>

Or that probably means we need to use a driver specific mechanism as what
we did for INTX instead of using NO_AUTO_EN.

Thanks


>
> Thomas I think you were the one who suggested enabling/disabling
> interrupts originally - thoughts?
>
> Feedback appreciated.
>
>
>
> > [    3.434849] ------------[ cut here ]------------
> > [    3.434850] WARNING: CPU: 0 PID: 93 at kernel/irq/chip.c:210
> irq_startup+0x10
> > e/0x120
> > [    3.434861] Modules linked in: virtio_net(E+) net_failover(E)
> failover(E) vir
> > tio_blk(E+) bochs(E+) drm_vram_helper(E) drm_ttm_helper(E) ttm(E)
> ahci(E+) libah
> > ci(E) virtio_pci(E) virtio_pci_legacy_dev(E) virtio_pci_modern_dev(E)
> virtio(E)
> > drm_kms_helper(E) cec(E) libata(E) crct10dif_pclmul(E)
> crct10dif_common(E) crc32
> > _pclmul(E) scsi_mod(E) i2c_i801(E) crc32c_intel(E) psmouse(E)
> i2c_smbus(E) scsi_
> > common(E) lpc_ich(E) virtio_ring(E) drm(E) button(E)
> > [    3.434890] CPU: 0 PID: 93 Comm: systemd-udevd Tainted: G
> E     5.
> > 17.0-rc7-00020-gea4424be1688 #63
> > [    3.434893] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> 0.0.0 02
> > /06/2015
> > [    3.434897] RIP: 0010:irq_startup+0x10e/0x120
> > [    3.434904] Code: c0 75 2b 4c 89 e7 31 d2 4c 89 ee e8 dc c5 ff ff 48
> 89 ef e8
> >  94 fe ff ff 41 89 c4 e9 33 ff ff ff e8 e7 ca ff ff e9 50 ff ff ff <0f>
> 0b eb ac
> >  0f 0b eb a8 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00
> > [    3.434906] RSP: 0018:ffff972c402bbbf0 EFLAGS: 00010002
> > [    3.434908] RAX: 0000000000000004 RBX: 0000000000000001 RCX:
> 0000000000000040
> > [    3.434912] RDX: 0000000000000000 RSI: ffffffffa768dee0 RDI:
> ffff8bcf8ce34648
> > [    3.434913] RBP: ffff8bcfb007a800 R08: 0000000000000004 R09:
> ffffffffa74cb828
> > [    3.434915] R10: 0000000000000000 R11: 0000000000000000 R12:
> 0000000000000001
> > [    3.434916] R13: ffff8bcf8ce34648 R14: ffff8bcf8d185c70 R15:
> 0000000000000200
> > [    3.434918] FS:  00007f5b3179f8c0(0000) GS:ffff8bcffbc00000(0000)
> knlGS:00000
> > 00000000000
> > [    3.434919] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    3.434921] CR2: 000055ca47bab6b8 CR3: 000000017bc40003 CR4:
> 0000000000170ef0
> > [    3.434928] Call Trace:
> > [    3.434936]  <TASK>
> > [    3.434938]  enable_irq+0x48/0x90
> > [    3.434943]  vp_enable_cbs+0x36/0x70 [virtio_pci]
> > [    3.434948]  virtblk_probe+0x457/0x7dc [virtio_blk]
> > [    3.434954]  virtio_dev_probe+0x1ae/0x280 [virtio]
> > [    3.434959]  really_probe+0x1f5/0x3d0
> > [    3.434966]  __driver_probe_device+0xfe/0x180
> > [    3.434969]  driver_probe_device+0x1e/0x90
> > [    3.434971]  __driver_attach+0xc0/0x1c0
> > [    3.434974]  ? __device_attach_driver+0xe0/0xe0
> > [    3.434976]  ? __device_attach_driver+0xe0/0xe0
> > [    3.434978]  bus_for_each_dev+0x78/0xc0
> > [    3.434982]  bus_add_driver+0x149/0x1e0
> > [    3.434985]  driver_register+0x8b/0xe0
> > [    3.434987]  ? 0xffffffffc01aa000
> > [    3.434990]  init+0x52/0x1000 [virtio_blk]
> > [    3.434994]  do_one_initcall+0x44/0x200
> > [    3.435001]  ? kmem_cache_alloc_trace+0x300/0x400
> > [    3.435006]  do_init_module+0x4c/0x260
> > [    3.435013]  __do_sys_finit_module+0xb4/0x120
> > [    3.435018]  do_syscall_64+0x3b/0xc0
> > [    3.435027]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > [    3.435037] RIP: 0033:0x7f5b31c589b9
> > [    3.435040] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
> 48 89 f8
> >  48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48>
> 3d 01 f0
> >  ff ff 73 01 c3 48 8b 0d a7 54 0c 00 f7 d8 64 89 01 48
> > [    3.435042] RSP: 002b:00007ffc608fc198 EFLAGS: 00000246 ORIG_RAX:
> 00000000000
> > 00139
> > [    3.435045] RAX: ffffffffffffffda RBX: 000055ca47ba8700 RCX:
> 00007f5b31c589b9
> > [    3.435046] RDX: 0000000000000000 RSI: 00007f5b31de3e2d RDI:
> 0000000000000005
> > [    3.435048] RBP: 0000000000020000 R08: 0000000000000000 R09:
> 000055ca47ba9030
> > [    3.435049] R10: 0000000000000005 R11: 0000000000000246 R12:
> 00007f5b31de3e2d
> > [    3.435050] R13: 0000000000000000 R14: 000055ca47ba7060 R15:
> 000055ca47ba8700
> > [    3.435053]  </TASK>
> > [    3.435059] ---[ end trace 0000000000000000 ]---
> > [    3.440593]  vda: vda1 vda2 vda3
> > [    3.445283] scsi host0: Virtio SCSI HBA
> > [    3.450373] scsi 0:0:0:0: CD-ROM            QEMU     QEMU CD-ROM
> 2.5+ PQ
> > : 0 ANSI: 5
> >
> > --
> > Without deviation from the norm, progress is not possible.
>
>

--00000000000072ee9905d9c0de39
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 9, 2022 at 12:36 AM Micha=
el S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, M=
ar 08, 2022 at 03:19:16PM +0000, Marc Zyngier wrote:<br>
&gt; On Tue, 19 Oct 2021 08:01:46 +0100,<br>
&gt; Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.com" target=3D"_blank=
">jasowang@redhat.com</a>&gt; wrote:<br>
&gt; &gt; <br>
&gt; &gt; We used to synchronize pending MSI-X irq handlers via<br>
&gt; &gt; synchronize_irq(), this may not work for the untrusted device whi=
ch<br>
&gt; &gt; may keep sending interrupts after reset which may lead unexpected=
<br>
&gt; &gt; results. Similarly, we should not enable MSI-X interrupt until th=
e<br>
&gt; &gt; device is ready. So this patch fixes those two issues by:<br>
&gt; &gt; <br>
&gt; &gt; 1) switching to use disable_irq() to prevent the virtio interrupt=
<br>
&gt; &gt;=C2=A0 =C2=A0 handlers to be called after the device is reset.<br>
&gt; &gt; 2) using IRQF_NO_AUTOEN and enable the MSI-X irq during .ready()<=
br>
&gt; &gt; <br>
&gt; &gt; This can make sure the virtio interrupt handler won&#39;t be call=
ed before<br>
&gt; &gt; virtio_device_ready() and after reset.<br>
&gt; &gt; <br>
&gt; &gt; Cc: Thomas Gleixner &lt;<a href=3D"mailto:tglx@linutronix.de" tar=
get=3D"_blank">tglx@linutronix.de</a>&gt;<br>
&gt; &gt; Cc: Peter Zijlstra &lt;<a href=3D"mailto:peterz@infradead.org" ta=
rget=3D"_blank">peterz@infradead.org</a>&gt;<br>
&gt; &gt; Cc: Paul E. McKenney &lt;<a href=3D"mailto:paulmck@kernel.org" ta=
rget=3D"_blank">paulmck@kernel.org</a>&gt;<br>
&gt; &gt; Signed-off-by: Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.c=
om" target=3D"_blank">jasowang@redhat.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 drivers/virtio/virtio_pci_common.c | 27 +++++++++++++++++++=
++------<br>
&gt; &gt;=C2=A0 drivers/virtio/virtio_pci_common.h |=C2=A0 6 ++++--<br>
&gt; &gt;=C2=A0 drivers/virtio/virtio_pci_legacy.c |=C2=A0 5 +++--<br>
&gt; &gt;=C2=A0 drivers/virtio/virtio_pci_modern.c |=C2=A0 6 ++++--<br>
&gt; &gt;=C2=A0 4 files changed, 32 insertions(+), 12 deletions(-)<br>
&gt; &gt; <br>
&gt; &gt; diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/=
virtio_pci_common.c<br>
&gt; &gt; index b35bb2d57f62..8d8f83aca721 100644<br>
&gt; &gt; --- a/drivers/virtio/virtio_pci_common.c<br>
&gt; &gt; +++ b/drivers/virtio/virtio_pci_common.c<br>
&gt; &gt; @@ -24,8 +24,8 @@ MODULE_PARM_DESC(force_legacy,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Force legac=
y mode for transitional virtio 1 devices&quot;);<br>
&gt; &gt;=C2=A0 #endif<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt; -/* wait for pending irq handlers */<br>
&gt; &gt; -void vp_synchronize_vectors(struct virtio_device *vdev)<br>
&gt; &gt; +/* disable irq handlers */<br>
&gt; &gt; +void vp_disable_cbs(struct virtio_device *vdev)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0struct virtio_pci_device *vp_dev =3D to_vp_dev=
ice(vdev);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0int i;<br>
&gt; &gt; @@ -34,7 +34,20 @@ void vp_synchronize_vectors(struct virtio_devi=
ce *vdev)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0synchronize_irq(vp=
_dev-&gt;pci_dev-&gt;irq);<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; vp_dev-&gt;msix_vectors; =
++i)<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0synchronize_irq(pci_irq=
_vector(vp_dev-&gt;pci_dev, i));<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0disable_irq(pci_irq_vec=
tor(vp_dev-&gt;pci_dev, i));<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +/* enable irq handlers */<br>
&gt; &gt; +void vp_enable_cbs(struct virtio_device *vdev)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0struct virtio_pci_device *vp_dev =3D to_vp_device(v=
dev);<br>
&gt; &gt; +=C2=A0 =C2=A0int i;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0if (vp_dev-&gt;intx_enabled)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0for (i =3D 0; i &lt; vp_dev-&gt;msix_vectors; ++i)<=
br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enable_irq(pci_irq_vect=
or(vp_dev-&gt;pci_dev, i));<br>
&gt; <br>
&gt; This results in a splat at boot time if you set maxcpus=3D&lt;whatever=
&gt;,<br>
&gt; see below. Enabling interrupts that are affinity managed is *bad*. You=
<br>
&gt; don&#39;t even know whether the CPU which is supposed to handle this i=
s<br>
&gt; online or not.<br>
&gt; <br>
&gt; The core kernel notices it, shouts and keeps the interrupt disabled,<b=
r>
&gt; but this should be fixed. The whole point of managed interrupts is to<=
br>
&gt; let them be dealt with outside of the drivers, and tied into the CPUs<=
br>
&gt; being brought up and down. If virtio needs (for one reason or another)=
<br>
&gt; to manage interrupts on its own, so be it. But this patch isn&#39;t th=
e<br>
&gt; way to do it, I&#39;m afraid.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0M.<br>
<br>
Thanks for reporting this!<br>
<br>
What virtio is doing here isn&#39;t unique however.<br>
<br>
If device driver is to be hardened against device sending interrupts<br>
while driver is initializing/cleaning up, it needs kernel to provide<br>
capability to disable these.<br>
<br>
If we then declare that that is impossible for managed interrupts<br>
then that will mean most devices can&#39;t use managed interrupts<br>
because ideally we&#39;d have all drivers hardened.<br></blockquote><div><b=
r></div><div>Or that probably means we need to use a driver specific mechan=
ism as what we did for INTX instead of using NO_AUTO_EN.</div><div><br></di=
v><div>Thanks=C2=A0</div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
<br>
Thomas I think you were the one who suggested enabling/disabling<br>
interrupts originally - thoughts?<br>
<br>
Feedback appreciated.<br>
<br>
<br>
<br>
&gt; [=C2=A0 =C2=A0 3.434849] ------------[ cut here ]------------<br>
&gt; [=C2=A0 =C2=A0 3.434850] WARNING: CPU: 0 PID: 93 at kernel/irq/chip.c:=
210 irq_startup+0x10<br>
&gt; e/0x120<br>
&gt; [=C2=A0 =C2=A0 3.434861] Modules linked in: virtio_net(E+) net_failove=
r(E) failover(E) vir<br>
&gt; tio_blk(E+) bochs(E+) drm_vram_helper(E) drm_ttm_helper(E) ttm(E) ahci=
(E+) libah<br>
&gt; ci(E) virtio_pci(E) virtio_pci_legacy_dev(E) virtio_pci_modern_dev(E) =
virtio(E) <br>
&gt; drm_kms_helper(E) cec(E) libata(E) crct10dif_pclmul(E) crct10dif_commo=
n(E) crc32<br>
&gt; _pclmul(E) scsi_mod(E) i2c_i801(E) crc32c_intel(E) psmouse(E) i2c_smbu=
s(E) scsi_<br>
&gt; common(E) lpc_ich(E) virtio_ring(E) drm(E) button(E)<br>
&gt; [=C2=A0 =C2=A0 3.434890] CPU: 0 PID: 93 Comm: systemd-udevd Tainted: G=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 E=C2=A0 =C2=A0 =C2=A05.<br>
&gt; 17.0-rc7-00020-gea4424be1688 #63<br>
&gt; [=C2=A0 =C2=A0 3.434893] Hardware name: QEMU Standard PC (Q35 + ICH9, =
2009), BIOS 0.0.0 02<br>
&gt; /06/2015<br>
&gt; [=C2=A0 =C2=A0 3.434897] RIP: 0010:irq_startup+0x10e/0x120<br>
&gt; [=C2=A0 =C2=A0 3.434904] Code: c0 75 2b 4c 89 e7 31 d2 4c 89 ee e8 dc =
c5 ff ff 48 89 ef e8<br>
&gt;=C2=A0 94 fe ff ff 41 89 c4 e9 33 ff ff ff e8 e7 ca ff ff e9 50 ff ff f=
f &lt;0f&gt; 0b eb ac<br>
&gt;=C2=A0 0f 0b eb a8 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00<br>
&gt; [=C2=A0 =C2=A0 3.434906] RSP: 0018:ffff972c402bbbf0 EFLAGS: 00010002<b=
r>
&gt; [=C2=A0 =C2=A0 3.434908] RAX: 0000000000000004 RBX: 0000000000000001 R=
CX: 0000000000000040<br>
&gt; [=C2=A0 =C2=A0 3.434912] RDX: 0000000000000000 RSI: ffffffffa768dee0 R=
DI: ffff8bcf8ce34648<br>
&gt; [=C2=A0 =C2=A0 3.434913] RBP: ffff8bcfb007a800 R08: 0000000000000004 R=
09: ffffffffa74cb828<br>
&gt; [=C2=A0 =C2=A0 3.434915] R10: 0000000000000000 R11: 0000000000000000 R=
12: 0000000000000001<br>
&gt; [=C2=A0 =C2=A0 3.434916] R13: ffff8bcf8ce34648 R14: ffff8bcf8d185c70 R=
15: 0000000000000200<br>
&gt; [=C2=A0 =C2=A0 3.434918] FS:=C2=A0 00007f5b3179f8c0(0000) GS:ffff8bcff=
bc00000(0000) knlGS:00000<br>
&gt; 00000000000<br>
&gt; [=C2=A0 =C2=A0 3.434919] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033<br>
&gt; [=C2=A0 =C2=A0 3.434921] CR2: 000055ca47bab6b8 CR3: 000000017bc40003 C=
R4: 0000000000170ef0<br>
&gt; [=C2=A0 =C2=A0 3.434928] Call Trace:<br>
&gt; [=C2=A0 =C2=A0 3.434936]=C2=A0 &lt;TASK&gt;<br>
&gt; [=C2=A0 =C2=A0 3.434938]=C2=A0 enable_irq+0x48/0x90<br>
&gt; [=C2=A0 =C2=A0 3.434943]=C2=A0 vp_enable_cbs+0x36/0x70 [virtio_pci]<br=
>
&gt; [=C2=A0 =C2=A0 3.434948]=C2=A0 virtblk_probe+0x457/0x7dc [virtio_blk]<=
br>
&gt; [=C2=A0 =C2=A0 3.434954]=C2=A0 virtio_dev_probe+0x1ae/0x280 [virtio]<b=
r>
&gt; [=C2=A0 =C2=A0 3.434959]=C2=A0 really_probe+0x1f5/0x3d0<br>
&gt; [=C2=A0 =C2=A0 3.434966]=C2=A0 __driver_probe_device+0xfe/0x180<br>
&gt; [=C2=A0 =C2=A0 3.434969]=C2=A0 driver_probe_device+0x1e/0x90<br>
&gt; [=C2=A0 =C2=A0 3.434971]=C2=A0 __driver_attach+0xc0/0x1c0<br>
&gt; [=C2=A0 =C2=A0 3.434974]=C2=A0 ? __device_attach_driver+0xe0/0xe0<br>
&gt; [=C2=A0 =C2=A0 3.434976]=C2=A0 ? __device_attach_driver+0xe0/0xe0<br>
&gt; [=C2=A0 =C2=A0 3.434978]=C2=A0 bus_for_each_dev+0x78/0xc0<br>
&gt; [=C2=A0 =C2=A0 3.434982]=C2=A0 bus_add_driver+0x149/0x1e0<br>
&gt; [=C2=A0 =C2=A0 3.434985]=C2=A0 driver_register+0x8b/0xe0<br>
&gt; [=C2=A0 =C2=A0 3.434987]=C2=A0 ? 0xffffffffc01aa000<br>
&gt; [=C2=A0 =C2=A0 3.434990]=C2=A0 init+0x52/0x1000 [virtio_blk]<br>
&gt; [=C2=A0 =C2=A0 3.434994]=C2=A0 do_one_initcall+0x44/0x200<br>
&gt; [=C2=A0 =C2=A0 3.435001]=C2=A0 ? kmem_cache_alloc_trace+0x300/0x400<br=
>
&gt; [=C2=A0 =C2=A0 3.435006]=C2=A0 do_init_module+0x4c/0x260<br>
&gt; [=C2=A0 =C2=A0 3.435013]=C2=A0 __do_sys_finit_module+0xb4/0x120<br>
&gt; [=C2=A0 =C2=A0 3.435018]=C2=A0 do_syscall_64+0x3b/0xc0<br>
&gt; [=C2=A0 =C2=A0 3.435027]=C2=A0 entry_SYSCALL_64_after_hwframe+0x44/0xa=
e<br>
&gt; [=C2=A0 =C2=A0 3.435037] RIP: 0033:0x7f5b31c589b9<br>
&gt; [=C2=A0 =C2=A0 3.435040] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f =
1f 44 00 00 48 89 f8<br>
&gt;=C2=A0 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 0=
5 &lt;48&gt; 3d 01 f0<br>
&gt;=C2=A0 ff ff 73 01 c3 48 8b 0d a7 54 0c 00 f7 d8 64 89 01 48<br>
&gt; [=C2=A0 =C2=A0 3.435042] RSP: 002b:00007ffc608fc198 EFLAGS: 00000246 O=
RIG_RAX: 00000000000<br>
&gt; 00139<br>
&gt; [=C2=A0 =C2=A0 3.435045] RAX: ffffffffffffffda RBX: 000055ca47ba8700 R=
CX: 00007f5b31c589b9<br>
&gt; [=C2=A0 =C2=A0 3.435046] RDX: 0000000000000000 RSI: 00007f5b31de3e2d R=
DI: 0000000000000005<br>
&gt; [=C2=A0 =C2=A0 3.435048] RBP: 0000000000020000 R08: 0000000000000000 R=
09: 000055ca47ba9030<br>
&gt; [=C2=A0 =C2=A0 3.435049] R10: 0000000000000005 R11: 0000000000000246 R=
12: 00007f5b31de3e2d<br>
&gt; [=C2=A0 =C2=A0 3.435050] R13: 0000000000000000 R14: 000055ca47ba7060 R=
15: 000055ca47ba8700<br>
&gt; [=C2=A0 =C2=A0 3.435053]=C2=A0 &lt;/TASK&gt;<br>
&gt; [=C2=A0 =C2=A0 3.435059] ---[ end trace 0000000000000000 ]---<br>
&gt; [=C2=A0 =C2=A0 3.440593]=C2=A0 vda: vda1 vda2 vda3<br>
&gt; [=C2=A0 =C2=A0 3.445283] scsi host0: Virtio SCSI HBA<br>
&gt; [=C2=A0 =C2=A0 3.450373] scsi 0:0:0:0: CD-ROM=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 QEMU=C2=A0 =C2=A0 =C2=A0QEMU CD-ROM=C2=A0 =C2=A0 =C2=A0 2=
.5+ PQ<br>
&gt; : 0 ANSI: 5<br>
&gt; <br>
&gt; -- <br>
&gt; Without deviation from the norm, progress is not possible.<br>
<br>
</blockquote></div></div>

--00000000000072ee9905d9c0de39--


--===============4693123589580649933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4693123589580649933==--

