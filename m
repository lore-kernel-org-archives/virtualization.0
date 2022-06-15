Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6CAC433EF
	for <virtualization@archiver.kernel.org>; Wed, 15 Jun 2022 01:41:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 02ABE60F90;
	Wed, 15 Jun 2022 01:41:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kmFqLY0LG95t; Wed, 15 Jun 2022 01:41:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5850E60F9E;
	Wed, 15 Jun 2022 01:41:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2EC81C0032;
	Wed, 15 Jun 2022 01:41:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C389DC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 01:41:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A239C832A9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 01:41:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VGzgRYnmXImS
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 01:41:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8BC7E831DA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 01:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655257294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tjo7rOXFgcmcCqbuVi40NzVO+eoWKTNwC6WBHBvxqjA=;
 b=ReY9YGOpUp1Epp1BVo/PrrHwCcUJhiBillCihFbIqjoEZenGZABl9eTp7zUCWuQ0oFKhC8
 J6Sz5fnCV1O/1i8hvgNG0PqGi+o4S2si8j6nQ5eGg3oxMXpyhI1sVvVQxz0uyxjzELyF9I
 P4k0zdUosF4yhFGX403IhCk4ZQJf/Ug=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-182-oAeJU1pDP2ujXSjbPGUqgQ-1; Tue, 14 Jun 2022 21:41:31 -0400
X-MC-Unique: oAeJU1pDP2ujXSjbPGUqgQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 c5-20020a056512238500b0047954b68297so5309865lfv.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 18:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Tjo7rOXFgcmcCqbuVi40NzVO+eoWKTNwC6WBHBvxqjA=;
 b=geH2Ki7C4HB5ZeY8pCLalwauLYPEjl2HzS/T/iU6W85/idTxT0jj8RqnTZs3hGLkxP
 3KYyJDWPazkFLNpNRCUQlkKmOV7EdEavSpBoCH8hYmG0YpQmp0ENr8bzw49+mJEQ5qlu
 eyyVVqDgOrJE3iJMfKbQvVgUb0yB//Cyb25Sx6jFtCFmpWZhBunKmNwuOdR6fxemUjLA
 fOsqOVV1382Yv06aRFxZV9CanIeSgjXHQT+CmIcNcMfZCTP+wNFtpMqc6ZFqsWHT/FAJ
 diC4qu3KUf76loFDTRuiuiXmJIzLw5JGZhEV4WgIwr/VEE2HVkgfFuDxIplf3DDURfjv
 2CjA==
X-Gm-Message-State: AOAM533xfSR4Ynv2ZFRaJgkZZdgVDAHChPWTWik8Wo0rR2m8IrDyxrS7
 XB+mGCC13ZjBocE6iv7e47xIfyt1RNVtodfksDdAK5irjJGE2nK9viCW6yRFZsXQv7v9G0xGgRo
 zNUbBUda/pVU/gX6V+R+0KWtWnAS+SR68QmYogV5c/Y+0EKYpXiEPsowsaA==
X-Received: by 2002:a05:6512:5cc:b0:47a:bf7:f1ab with SMTP id
 o12-20020a05651205cc00b0047a0bf7f1abmr4782687lfo.397.1655257289804; 
 Tue, 14 Jun 2022 18:41:29 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tDV4hBFtKl8kADWcRc+MNJ9+9+kb+tRZy9v8Ps88kwY81XvKzLZe8MX1RGaJY/cunkIjz4qJ9rGU/f6NhQ3Q4=
X-Received: by 2002:a05:6512:5cc:b0:47a:bf7:f1ab with SMTP id
 o12-20020a05651205cc00b0047a0bf7f1abmr4782662lfo.397.1655257289594; Tue, 14
 Jun 2022 18:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <CACGkMEtRP+0Xy63g0SF_y1avv=3rFv6P9+Z7kp9XBS5d+_py8w@mail.gmail.com>
 <20220613023337-mutt-send-email-mst@kernel.org>
 <CACGkMEs05ZisiPW+7H6Omp80MzmZWZCpc1mf5Vd99C3H-KUtgA@mail.gmail.com>
 <20220613041416-mutt-send-email-mst@kernel.org>
 <CACGkMEsT_fWdPxN1cTWOX=vu-ntp3Xo4j46-ZKALeSXr7DmJFQ@mail.gmail.com>
 <20220613045606-mutt-send-email-mst@kernel.org>
 <CACGkMEtAQck7Nr6SP_pD0MGT3njnwZSyT=xPyYzUU3c5GNNM_w@mail.gmail.com>
 <CACGkMEvUFJkC=mnvL2PSH6-3RMcJUk84f-9X46JVcj2vTAr4SQ@mail.gmail.com>
 <20220613052644-mutt-send-email-mst@kernel.org>
 <CACGkMEstGvhETXThuwO+tLVBuRgQb8uC_6DdAM8ZxOi5UKBRbg@mail.gmail.com>
 <Yqi7UhasBDPKCpuV@e120937-lin>
In-Reply-To: <Yqi7UhasBDPKCpuV@e120937-lin>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 15 Jun 2022 09:41:18 +0800
Message-ID: <CACGkMEv2A7ZHQTrdg9H=xZScAf2DE=Dguaz60ykd4KQGNLrn2Q@mail.gmail.com>
Subject: Re: [PATCH V6 8/9] virtio: harden vring IRQ
To: Cristian Marussi <cristian.marussi@arm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Vineeth Vijayan <vneethv@linux.ibm.com>, Cindy Lu <lulu@redhat.com>,
 Marc Zyngier <maz@kernel.org>, Halil Pasic <pasic@linux.ibm.com>,
 eperezma <eperezma@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 linux-s390@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 virtualization <virtualization@lists.linux-foundation.org>,
 conghui.chen@intel.com, pankaj.gupta.linux@gmail.com,
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev <netdev@vger.kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Peter Oberparleiter <oberpar@linux.ibm.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, sudeep.holla@arm.com
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

On Wed, Jun 15, 2022 at 12:46 AM Cristian Marussi
<cristian.marussi@arm.com> wrote:
>
> On Tue, Jun 14, 2022 at 03:40:21PM +0800, Jason Wang wrote:
> > On Mon, Jun 13, 2022 at 5:28 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
>
> Hi Jason,
>
> > > On Mon, Jun 13, 2022 at 05:14:59PM +0800, Jason Wang wrote:
> > > > On Mon, Jun 13, 2022 at 5:08 PM Jason Wang <jasowang@redhat.com> wrote:
> > > > >
> > > > > On Mon, Jun 13, 2022 at 4:59 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Mon, Jun 13, 2022 at 04:51:08PM +0800, Jason Wang wrote:
> > > > > > > On Mon, Jun 13, 2022 at 4:19 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Jun 13, 2022 at 04:07:09PM +0800, Jason Wang wrote:
> > > > > > > > > On Mon, Jun 13, 2022 at 3:23 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Mon, Jun 13, 2022 at 01:26:59PM +0800, Jason Wang wrote:
> > > > > > > > > > > On Sat, Jun 11, 2022 at 1:12 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Fri, May 27, 2022 at 02:01:19PM +0800, Jason Wang wrote:
> > > > > > > > > > > > > This is a rework on the previous IRQ hardening that is done for
> > > > > > > > > > > > > virtio-pci where several drawbacks were found and were reverted:
> > > > > > > > > > > > >
> > > > > > > > > > > > > 1) try to use IRQF_NO_AUTOEN which is not friendly to affinity managed IRQ
> > > > > > > > > > > > >    that is used by some device such as virtio-blk
> > > > > > > > > > > > > 2) done only for PCI transport
> > > > > > > > > > > > >
> > > > > > > > > > > > > The vq->broken is re-used in this patch for implementing the IRQ
> > > > > > > > > > > > > hardening. The vq->broken is set to true during both initialization
> > > > > > > > > > > > > and reset. And the vq->broken is set to false in
> > > > > > > > > > > > > virtio_device_ready(). Then vring_interrupt() can check and return
> > > > > > > > > > > > > when vq->broken is true. And in this case, switch to return IRQ_NONE
> > > > > > > > > > > > > to let the interrupt core aware of such invalid interrupt to prevent
> > > > > > > > > > > > > IRQ storm.
> > > > > > > > > > > > >
> > > > > > > > > > > > > The reason of using a per queue variable instead of a per device one
> > > > > > > > > > > > > is that we may need it for per queue reset hardening in the future.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Note that the hardening is only done for vring interrupt since the
> > > > > > > > > > > > > config interrupt hardening is already done in commit 22b7050a024d7
> > > > > > > > > > > > > ("virtio: defer config changed notifications"). But the method that is
> > > > > > > > > > > > > used by config interrupt can't be reused by the vring interrupt
> > > > > > > > > > > > > handler because it uses spinlock to do the synchronization which is
> > > > > > > > > > > > > expensive.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > > > > > > > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > > > > > > > > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > > > > > > > > > > Cc: Marc Zyngier <maz@kernel.org>
> > > > > > > > > > > > > Cc: Halil Pasic <pasic@linux.ibm.com>
> > > > > > > > > > > > > Cc: Cornelia Huck <cohuck@redhat.com>
> > > > > > > > > > > > > Cc: Vineeth Vijayan <vneethv@linux.ibm.com>
> > > > > > > > > > > > > Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> > > > > > > > > > > > > Cc: linux-s390@vger.kernel.org
> > > > > > > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > Jason, I am really concerned by all the fallout.
> > > > > > > > > > > > I propose adding a flag to suppress the hardening -
> > > > > > > > > > > > this will be a debugging aid and a work around for
> > > > > > > > > > > > users if we find more buggy drivers.
> > > > > > > > > > > >
> > > > > > > > > > > > suppress_interrupt_hardening ?
> > > > > > > > > > >
> > > > > > > > > > > I can post a patch but I'm afraid if we disable it by default, it
> > > > > > > > > > > won't be used by the users so there's no way for us to receive the bug
> > > > > > > > > > > report. Or we need a plan to enable it by default.
> > > > > > > > > > >
> > > > > > > > > > > It's rc2, how about waiting for 1 and 2 rc? Or it looks better if we
> > > > > > > > > > > simply warn instead of disable it by default.
> > > > > > > > > > >
> > > > > > > > > > > Thanks
> > > > > > > > > >
> > > > > > > > > > I meant more like a flag in struct virtio_driver.
> > > > > > > > > > For now, could you audit all drivers which don't call _ready?
> > > > > > > > > > I found 5 of these:
> > > > > > > > > >
> > > > > > > > > > drivers/bluetooth/virtio_bt.c
> > > > > > > > >
> > > > > > > > > This driver seems to be fine, it doesn't use the device/vq in its probe().
> > > > > > > >
> > > > > > > >
> > > > > > > > But it calls hci_register_dev and that in turn queues all kind of
> > > > > > > > work. Also, can linux start using the device immediately after
> > > > > > > > it's registered?
> > > > > > >
> > > > > > > So I think the driver is allowed to queue before DRIVER_OK.
> > > > > >
> > > > > > it's not allowed to kick
> > > > >
> > > > > Yes.
> > > > >
> > > > > >
> > > > > > > If yes,
> > > > > > > the only side effect is the delay of the tx interrupt after DRIVER_OK
> > > > > > > for a well behaved device.
> > > > > >
> > > > > > your patches drop the interrupt though, it won't be just delayed.
> > > > >
> > > > > For a well behaved device, it can only trigger the interrupt after DRIVER_OK.
> > > > >
> > > > > So for virtio bt, it works like:
> > > > >
> > > > > 1) driver queue buffer and kick
> > > > > 2) driver set DRIVER_OK
> > > > > 3) device start to process the buffer
> > > > > 4) device send an notification
> > > > >
> > > > > The only risk is that the virtqueue could be filled before DRIVER_OK,
> > > > > or anything I missed?
> > > >
> > > > btw, hci has an open and close method and we do rx refill in
> > > > hdev->open, so we're probably fine here.
> > > >
> > > > Thanks
> > >
> > >
> > > Sounds good. Now to audit the rest of them from this POV ;)
> >
> > Adding maintainers.
> >
> > >
> > >  drivers/i2c/busses/i2c-virtio.c
> >
> > It looks to me the device could be used immediately after
> > i2c_add_adapter() return. So we probably need to add
> > virtio_device_ready() before that. Fortunately, there's no rx vq in
> > i2c and the callback looks safe if the callback is called before the
> > i2c registration and after virtio_device_ready().
> >
> > >  drivers/net/caif/caif_virtio.c
> >
> > A networking device, RX is backed by vringh so we don't need to
> > refill. TX is backed by virtio and is available until ndo_open. So
> > it's fine to let the core to set DRIVER_OK after probe().
> >
> > >  drivers/nvdimm/virtio_pmem.c
> >
> > It doesn't use interrupt so far, so it has nothing to do with the IRQ hardening.
> >
> > But the device could be used by the subsystem immediately after
> > nvdimm_pmem_region_create(), this means the flush could be issued
> > before DRIVER_OK. We need virtio_device_ready() before. We don't have
> > a RX virtqueue and the callback looks safe if the callback is called
> > after virtio_device_ready() but before the nvdimm region creating.
> >
> > And it looks to me there's a race between the assignment of
> > provider_data and virtio_pmem_flush(). If the flush was issued before
> > the assignment we will end up with a NULL pointer dereference. This is
> > something we need to fix.
> >
> > >  arm_scmi
> >
> > It looks to me the singleton device could be used by SCMI immediately after
> >
> >         /* Ensure initialized scmi_vdev is visible */
> >         smp_store_mb(scmi_vdev, vdev);
> >
> > So we probably need to do virtio_device_ready() before that. It has an
> > optional rx queue but the filling is done after the above assignment,
> > so it's safe. And the callback looks safe is a callback is triggered
> > after virtio_device_ready() buy before the above assignment.
> >
>
> I wanted to give it a go at this series testing it on the context of
> SCMI but it does not apply
>
> - not on a v5.18:
>
> 17:33 $ git rebase -i v5.18
> 17:33 $ git am ./v6_20220527_jasowang_rework_on_the_irq_hardening_of_virtio.mbx
> Applying: virtio: use virtio_device_ready() in virtio_device_restore()
> Applying: virtio: use virtio_reset_device() when possible
> Applying: virtio: introduce config op to synchronize vring callbacks
> Applying: virtio-pci: implement synchronize_cbs()
> Applying: virtio-mmio: implement synchronize_cbs()
> error: patch failed: drivers/virtio/virtio_mmio.c:345
> error: drivers/virtio/virtio_mmio.c: patch does not apply
> Patch failed at 0005 virtio-mmio: implement synchronize_cbs()
>
> - neither on a v5.19-rc2:
>
> 17:33 $ git rebase -i v5.19-rc2
> 17:35 $ git am ./v6_20220527_jasowang_rework_on_the_irq_hardening_of_virtio.mbx
> Applying: virtio: use virtio_device_ready() in virtio_device_restore()
> error: patch failed: drivers/virtio/virtio.c:526
> error: drivers/virtio/virtio.c: patch does not apply
> Patch failed at 0001 virtio: use virtio_device_ready() in
> virtio_device_restore()
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
>
> ... what I should take as base ?

It should have already been included in rc2, so there's no need to
apply patch manually.

Thanks

>
> Thanks,
> Cristian
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
