Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3871C433FE
	for <virtualization@archiver.kernel.org>; Tue,  8 Mar 2022 16:36:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 71E4C415E1;
	Tue,  8 Mar 2022 16:36:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5tw0YdSU9wVH; Tue,  8 Mar 2022 16:36:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D31D2415CA;
	Tue,  8 Mar 2022 16:36:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 894C8C001D;
	Tue,  8 Mar 2022 16:36:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02CEFC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 16:36:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E687082AA2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 16:36:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JC4E7B5ITeOj
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 16:36:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E700E8143C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 16:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646757360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tk/496Md2LTTkhGgluhs+UDBntZIgjQTlPnbG9BspMI=;
 b=XO2ZJtVsmLm7W4fSZi2j9aLu2sYgelJDP8boo0FfVgYdrD19tIV8ppQkyZpwgQCWLfMN5+
 eqeli7aG8Xu8AdomYpIBJSpm8dvMgPrGqlnnDfseAY49/aZF76nQDMJVlVrmMJkB7yMNLO
 vOdFnECdYpOjHSsMMD923bG4FFXFaAQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-127-YAU3vCiVN9yvsoqTOa9cHA-1; Tue, 08 Mar 2022 11:35:59 -0500
X-MC-Unique: YAU3vCiVN9yvsoqTOa9cHA-1
Received: by mail-wr1-f70.google.com with SMTP id
 h11-20020a5d430b000000b001f01a35a86fso5636952wrq.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Mar 2022 08:35:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Tk/496Md2LTTkhGgluhs+UDBntZIgjQTlPnbG9BspMI=;
 b=70VL0YBrPRC5hQq0cqWWJeTW4nPmEO0Nx4eqjI2z3nMZgsZ9bhgc703//tUAwtOa5j
 DgMCRvpoDro/wfBeEOQdhJJPD/TV4/Ug0oE+UoXQP7HPKWQ5LhS9t4O4g5MYGKir1I/D
 maUcWYFvz2N4QhUo6zDn+ctSVJLJ7Xgm0MbTx4MeEmIXL4usHHKULv60mcY5K1NOvjLr
 TVvGvD+Q2oI8b5Kpnj+ejWCyrrv3ihpuyfngVwqQVNGa7NJEJ9M6rm4voh4Ff550n91N
 NepGiLddFKoVADlPxfeIOHY1egOQ3X9+mVbzWtj1ReVt2tiuEWQ4rb+/YqvT8a+q4XwQ
 ezxQ==
X-Gm-Message-State: AOAM533rYeGI4j2zX+9czRB2DoyR/+mEbM8pg1s0cQp+GwpMIugmHT5q
 jX1gzh66adm5/rNfy1cKOX1e8GzSHGCleOmuelAZoHFa59PE2ptkOlPDsXwPcnfhTBpAxQFOnAU
 OX//7T6e2lV59nXS9dr5uPX19JCB3PQDTPLMsq76jqQ==
X-Received: by 2002:a05:6000:1acf:b0:1f0:5e59:6c40 with SMTP id
 i15-20020a0560001acf00b001f05e596c40mr13438679wry.42.1646757357484; 
 Tue, 08 Mar 2022 08:35:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyUtsDjFCICwCDFdDPDnV/PVBiOSj1rSGkA8pr/83Zz4NJb6K1kx9w0E2RKcRIEKqCta5l9nA==
X-Received: by 2002:a05:6000:1acf:b0:1f0:5e59:6c40 with SMTP id
 i15-20020a0560001acf00b001f05e596c40mr13438663wry.42.1646757357188; 
 Tue, 08 Mar 2022 08:35:57 -0800 (PST)
Received: from redhat.com ([2.55.24.184]) by smtp.gmail.com with ESMTPSA id
 n8-20020adf8b08000000b001f046cc8891sm14552768wra.24.2022.03.08.08.35.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Mar 2022 08:35:56 -0800 (PST)
Date: Tue, 8 Mar 2022 11:35:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH V3 04/10] virtio_pci: harden MSI-X interrupts
Message-ID: <20220308113119-mutt-send-email-mst@kernel.org>
References: <20211019070152.8236-1-jasowang@redhat.com>
 <20211019070152.8236-5-jasowang@redhat.com>
 <87y21kzd3f.wl-maz@kernel.org>
MIME-Version: 1.0
In-Reply-To: <87y21kzd3f.wl-maz@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: keirf@google.com, "Paul E . McKenney" <paulmck@kernel.org>,
 david.kaplan@amd.com, konrad.wilk@oracle.com,
 Peter Zijlstra <peterz@infradead.org>, f.hetzelt@tu-berlin.de,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Mar 08, 2022 at 03:19:16PM +0000, Marc Zyngier wrote:
> On Tue, 19 Oct 2021 08:01:46 +0100,
> Jason Wang <jasowang@redhat.com> wrote:
> > 
> > We used to synchronize pending MSI-X irq handlers via
> > synchronize_irq(), this may not work for the untrusted device which
> > may keep sending interrupts after reset which may lead unexpected
> > results. Similarly, we should not enable MSI-X interrupt until the
> > device is ready. So this patch fixes those two issues by:
> > 
> > 1) switching to use disable_irq() to prevent the virtio interrupt
> >    handlers to be called after the device is reset.
> > 2) using IRQF_NO_AUTOEN and enable the MSI-X irq during .ready()
> > 
> > This can make sure the virtio interrupt handler won't be called before
> > virtio_device_ready() and after reset.
> > 
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_pci_common.c | 27 +++++++++++++++++++++------
> >  drivers/virtio/virtio_pci_common.h |  6 ++++--
> >  drivers/virtio/virtio_pci_legacy.c |  5 +++--
> >  drivers/virtio/virtio_pci_modern.c |  6 ++++--
> >  4 files changed, 32 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > index b35bb2d57f62..8d8f83aca721 100644
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -24,8 +24,8 @@ MODULE_PARM_DESC(force_legacy,
> >  		 "Force legacy mode for transitional virtio 1 devices");
> >  #endif
> >  
> > -/* wait for pending irq handlers */
> > -void vp_synchronize_vectors(struct virtio_device *vdev)
> > +/* disable irq handlers */
> > +void vp_disable_cbs(struct virtio_device *vdev)
> >  {
> >  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> >  	int i;
> > @@ -34,7 +34,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
> >  		synchronize_irq(vp_dev->pci_dev->irq);
> >  
> >  	for (i = 0; i < vp_dev->msix_vectors; ++i)
> > -		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > +		disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > +}
> > +
> > +/* enable irq handlers */
> > +void vp_enable_cbs(struct virtio_device *vdev)
> > +{
> > +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > +	int i;
> > +
> > +	if (vp_dev->intx_enabled)
> > +		return;
> > +
> > +	for (i = 0; i < vp_dev->msix_vectors; ++i)
> > +		enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> 
> This results in a splat at boot time if you set maxcpus=<whatever>,
> see below. Enabling interrupts that are affinity managed is *bad*. You
> don't even know whether the CPU which is supposed to handle this is
> online or not.
> 
> The core kernel notices it, shouts and keeps the interrupt disabled,
> but this should be fixed. The whole point of managed interrupts is to
> let them be dealt with outside of the drivers, and tied into the CPUs
> being brought up and down. If virtio needs (for one reason or another)
> to manage interrupts on its own, so be it. But this patch isn't the
> way to do it, I'm afraid.
> 
> 	M.

Thanks for reporting this!

What virtio is doing here isn't unique however.

If device driver is to be hardened against device sending interrupts
while driver is initializing/cleaning up, it needs kernel to provide
capability to disable these.

If we then declare that that is impossible for managed interrupts
then that will mean most devices can't use managed interrupts
because ideally we'd have all drivers hardened.

Thomas I think you were the one who suggested enabling/disabling
interrupts originally - thoughts?

Feedback appreciated.



> [    3.434849] ------------[ cut here ]------------
> [    3.434850] WARNING: CPU: 0 PID: 93 at kernel/irq/chip.c:210 irq_startup+0x10
> e/0x120
> [    3.434861] Modules linked in: virtio_net(E+) net_failover(E) failover(E) vir
> tio_blk(E+) bochs(E+) drm_vram_helper(E) drm_ttm_helper(E) ttm(E) ahci(E+) libah
> ci(E) virtio_pci(E) virtio_pci_legacy_dev(E) virtio_pci_modern_dev(E) virtio(E) 
> drm_kms_helper(E) cec(E) libata(E) crct10dif_pclmul(E) crct10dif_common(E) crc32
> _pclmul(E) scsi_mod(E) i2c_i801(E) crc32c_intel(E) psmouse(E) i2c_smbus(E) scsi_
> common(E) lpc_ich(E) virtio_ring(E) drm(E) button(E)
> [    3.434890] CPU: 0 PID: 93 Comm: systemd-udevd Tainted: G            E     5.
> 17.0-rc7-00020-gea4424be1688 #63
> [    3.434893] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02
> /06/2015
> [    3.434897] RIP: 0010:irq_startup+0x10e/0x120
> [    3.434904] Code: c0 75 2b 4c 89 e7 31 d2 4c 89 ee e8 dc c5 ff ff 48 89 ef e8
>  94 fe ff ff 41 89 c4 e9 33 ff ff ff e8 e7 ca ff ff e9 50 ff ff ff <0f> 0b eb ac
>  0f 0b eb a8 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00
> [    3.434906] RSP: 0018:ffff972c402bbbf0 EFLAGS: 00010002
> [    3.434908] RAX: 0000000000000004 RBX: 0000000000000001 RCX: 0000000000000040
> [    3.434912] RDX: 0000000000000000 RSI: ffffffffa768dee0 RDI: ffff8bcf8ce34648
> [    3.434913] RBP: ffff8bcfb007a800 R08: 0000000000000004 R09: ffffffffa74cb828
> [    3.434915] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
> [    3.434916] R13: ffff8bcf8ce34648 R14: ffff8bcf8d185c70 R15: 0000000000000200
> [    3.434918] FS:  00007f5b3179f8c0(0000) GS:ffff8bcffbc00000(0000) knlGS:00000
> 00000000000
> [    3.434919] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    3.434921] CR2: 000055ca47bab6b8 CR3: 000000017bc40003 CR4: 0000000000170ef0
> [    3.434928] Call Trace:
> [    3.434936]  <TASK>
> [    3.434938]  enable_irq+0x48/0x90
> [    3.434943]  vp_enable_cbs+0x36/0x70 [virtio_pci]
> [    3.434948]  virtblk_probe+0x457/0x7dc [virtio_blk]
> [    3.434954]  virtio_dev_probe+0x1ae/0x280 [virtio]
> [    3.434959]  really_probe+0x1f5/0x3d0
> [    3.434966]  __driver_probe_device+0xfe/0x180
> [    3.434969]  driver_probe_device+0x1e/0x90
> [    3.434971]  __driver_attach+0xc0/0x1c0
> [    3.434974]  ? __device_attach_driver+0xe0/0xe0
> [    3.434976]  ? __device_attach_driver+0xe0/0xe0
> [    3.434978]  bus_for_each_dev+0x78/0xc0
> [    3.434982]  bus_add_driver+0x149/0x1e0
> [    3.434985]  driver_register+0x8b/0xe0
> [    3.434987]  ? 0xffffffffc01aa000
> [    3.434990]  init+0x52/0x1000 [virtio_blk]
> [    3.434994]  do_one_initcall+0x44/0x200
> [    3.435001]  ? kmem_cache_alloc_trace+0x300/0x400
> [    3.435006]  do_init_module+0x4c/0x260
> [    3.435013]  __do_sys_finit_module+0xb4/0x120
> [    3.435018]  do_syscall_64+0x3b/0xc0
> [    3.435027]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [    3.435037] RIP: 0033:0x7f5b31c589b9
> [    3.435040] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8
>  48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0
>  ff ff 73 01 c3 48 8b 0d a7 54 0c 00 f7 d8 64 89 01 48
> [    3.435042] RSP: 002b:00007ffc608fc198 EFLAGS: 00000246 ORIG_RAX: 00000000000
> 00139
> [    3.435045] RAX: ffffffffffffffda RBX: 000055ca47ba8700 RCX: 00007f5b31c589b9
> [    3.435046] RDX: 0000000000000000 RSI: 00007f5b31de3e2d RDI: 0000000000000005
> [    3.435048] RBP: 0000000000020000 R08: 0000000000000000 R09: 000055ca47ba9030
> [    3.435049] R10: 0000000000000005 R11: 0000000000000246 R12: 00007f5b31de3e2d
> [    3.435050] R13: 0000000000000000 R14: 000055ca47ba7060 R15: 000055ca47ba8700
> [    3.435053]  </TASK>
> [    3.435059] ---[ end trace 0000000000000000 ]---
> [    3.440593]  vda: vda1 vda2 vda3
> [    3.445283] scsi host0: Virtio SCSI HBA
> [    3.450373] scsi 0:0:0:0: CD-ROM            QEMU     QEMU CD-ROM      2.5+ PQ
> : 0 ANSI: 5
> 
> -- 
> Without deviation from the norm, progress is not possible.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
