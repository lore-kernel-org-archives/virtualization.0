Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 623ABC43334
	for <virtualization@archiver.kernel.org>; Thu, 16 Jun 2022 17:11:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D888E60E2B;
	Thu, 16 Jun 2022 17:11:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fOy_la7jMm3S; Thu, 16 Jun 2022 17:11:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 72D6A60A92;
	Thu, 16 Jun 2022 17:11:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C31FC0039;
	Thu, 16 Jun 2022 17:11:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA7B6C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Jun 2022 17:11:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AE925403E2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Jun 2022 17:11:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s-ydqeVncVVY
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Jun 2022 17:11:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B4E36400E3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Jun 2022 17:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655399504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TBl5iK81jQ/YZfhxlbTGrMVlmj+3IfYosPkLM7FZV9g=;
 b=aBFYPTTVp5yX/xd+M2wfFB5pUoIsIYAt0t/xUxYcxkHhQTMd46fv4YZrxU5UB3Lji1e3LF
 /rbzvXTEEMvPBu53QCejAPqrx5daPeRQL5iDkkttm0IuXej04qfl7tF92XMmtFgxtLEx8k
 v0IHmr1DTDdXkbEQpszNw9omrEzTKJE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-14-2dpmmTHMPEanyFNOnJyQPA-1; Thu, 16 Jun 2022 13:11:42 -0400
X-MC-Unique: 2dpmmTHMPEanyFNOnJyQPA-1
Received: by mail-ej1-f72.google.com with SMTP id
 l2-20020a170906078200b006fed42bfeacso860952ejc.16
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Jun 2022 10:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TBl5iK81jQ/YZfhxlbTGrMVlmj+3IfYosPkLM7FZV9g=;
 b=ExBC8zOqR8HeFCtj52+53WCpnkPT9DGJtKsAaDVhk2wgPm0EPn3a+PnXw5AiDsQGqi
 SDn8NuRR/CQJtCmk1UY/2zlrk4+kYoo0LY6ccG/eaZlnWvhaOd7oYS1HiIzg2S2UxgDK
 Zeap8YL8nAZTmXHHdsV4H2UkIeo0dpnGrSzpqYQpDWkpiOxFjtPnp5CIwHcSA3ftPuEq
 DF4NDog1joCqD31Orp2cwTeys/ntzWygHmduMJ4Sdy7xOS3ixYRXND0eVRgbYRu0rCp0
 TpYuIOy0MAm7QgBZyitb8jv8wliWOh1FU3zDaLT5SdG3khJr5CvtbHjN+JcxqVAfJ5vS
 LecA==
X-Gm-Message-State: AJIora/x/U4e7O5DaBUdzMwJM5OuY6yFeQXJI3Hdp9R8H/Ctn6mit3ih
 LptiLL20wa051jPI29byHVTzoJHVeTwakrQRKnDRbu9z+vfr0RPpxdLQDm/0XRzfKNUd0ZeL4jT
 rd79fxF7VxJVvocETx6O3rwt8RFYKcrjxBPYK8f39jw==
X-Received: by 2002:a17:907:a422:b0:705:e944:fd3e with SMTP id
 sg34-20020a170907a42200b00705e944fd3emr5279415ejc.309.1655399501527; 
 Thu, 16 Jun 2022 10:11:41 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sZ3vn+lfQreHacJz6xcVoo8Ecj0aJC3jwdGK6U+HkH4QB7M2xOrIl5gTDz451kthB0bleklQ==
X-Received: by 2002:a17:907:a422:b0:705:e944:fd3e with SMTP id
 sg34-20020a170907a42200b00705e944fd3emr5279386ejc.309.1655399501243; 
 Thu, 16 Jun 2022 10:11:41 -0700 (PDT)
Received: from redhat.com ([2.53.13.204]) by smtp.gmail.com with ESMTPSA id
 24-20020a170906309800b006f3ef214dbesm1000727ejv.36.2022.06.16.10.11.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jun 2022 10:11:40 -0700 (PDT)
Date: Thu, 16 Jun 2022 13:11:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V6 8/9] virtio: harden vring IRQ
Message-ID: <20220616130945-mutt-send-email-mst@kernel.org>
References: <CACGkMEs05ZisiPW+7H6Omp80MzmZWZCpc1mf5Vd99C3H-KUtgA@mail.gmail.com>
 <20220613041416-mutt-send-email-mst@kernel.org>
 <CACGkMEsT_fWdPxN1cTWOX=vu-ntp3Xo4j46-ZKALeSXr7DmJFQ@mail.gmail.com>
 <20220613045606-mutt-send-email-mst@kernel.org>
 <CACGkMEtAQck7Nr6SP_pD0MGT3njnwZSyT=xPyYzUU3c5GNNM_w@mail.gmail.com>
 <CACGkMEvUFJkC=mnvL2PSH6-3RMcJUk84f-9X46JVcj2vTAr4SQ@mail.gmail.com>
 <20220613052644-mutt-send-email-mst@kernel.org>
 <CACGkMEstGvhETXThuwO+tLVBuRgQb8uC_6DdAM8ZxOi5UKBRbg@mail.gmail.com>
 <20220614114839-mutt-send-email-mst@kernel.org>
 <CACGkMEthExrqFNkOzLGwaffvHw=Tc3MXPtTTiRsnpFDGKPRP=A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEthExrqFNkOzLGwaffvHw=Tc3MXPtTTiRsnpFDGKPRP=A@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Peter Zijlstra <peterz@infradead.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Vineeth Vijayan <vneethv@linux.ibm.com>, Cindy Lu <lulu@redhat.com>,
 Marc Zyngier <maz@kernel.org>, Halil Pasic <pasic@linux.ibm.com>,
 eperezma <eperezma@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 linux-s390@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 virtualization <virtualization@lists.linux-foundation.org>,
 conghui.chen@intel.com, cristian.marussi@arm.com, pankaj.gupta.linux@gmail.com,
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

On Wed, Jun 15, 2022 at 09:38:18AM +0800, Jason Wang wrote:
> On Tue, Jun 14, 2022 at 11:49 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Jun 14, 2022 at 03:40:21PM +0800, Jason Wang wrote:
> > > On Mon, Jun 13, 2022 at 5:28 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, Jun 13, 2022 at 05:14:59PM +0800, Jason Wang wrote:
> > > > > On Mon, Jun 13, 2022 at 5:08 PM Jason Wang <jasowang@redhat.com> wrote:
> > > > > >
> > > > > > On Mon, Jun 13, 2022 at 4:59 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Jun 13, 2022 at 04:51:08PM +0800, Jason Wang wrote:
> > > > > > > > On Mon, Jun 13, 2022 at 4:19 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Jun 13, 2022 at 04:07:09PM +0800, Jason Wang wrote:
> > > > > > > > > > On Mon, Jun 13, 2022 at 3:23 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Mon, Jun 13, 2022 at 01:26:59PM +0800, Jason Wang wrote:
> > > > > > > > > > > > On Sat, Jun 11, 2022 at 1:12 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Fri, May 27, 2022 at 02:01:19PM +0800, Jason Wang wrote:
> > > > > > > > > > > > > > This is a rework on the previous IRQ hardening that is done for
> > > > > > > > > > > > > > virtio-pci where several drawbacks were found and were reverted:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > 1) try to use IRQF_NO_AUTOEN which is not friendly to affinity managed IRQ
> > > > > > > > > > > > > >    that is used by some device such as virtio-blk
> > > > > > > > > > > > > > 2) done only for PCI transport
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > The vq->broken is re-used in this patch for implementing the IRQ
> > > > > > > > > > > > > > hardening. The vq->broken is set to true during both initialization
> > > > > > > > > > > > > > and reset. And the vq->broken is set to false in
> > > > > > > > > > > > > > virtio_device_ready(). Then vring_interrupt() can check and return
> > > > > > > > > > > > > > when vq->broken is true. And in this case, switch to return IRQ_NONE
> > > > > > > > > > > > > > to let the interrupt core aware of such invalid interrupt to prevent
> > > > > > > > > > > > > > IRQ storm.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > The reason of using a per queue variable instead of a per device one
> > > > > > > > > > > > > > is that we may need it for per queue reset hardening in the future.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Note that the hardening is only done for vring interrupt since the
> > > > > > > > > > > > > > config interrupt hardening is already done in commit 22b7050a024d7
> > > > > > > > > > > > > > ("virtio: defer config changed notifications"). But the method that is
> > > > > > > > > > > > > > used by config interrupt can't be reused by the vring interrupt
> > > > > > > > > > > > > > handler because it uses spinlock to do the synchronization which is
> > > > > > > > > > > > > > expensive.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > > > > > > > > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > > > > > > > > > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > > > > > > > > > > > Cc: Marc Zyngier <maz@kernel.org>
> > > > > > > > > > > > > > Cc: Halil Pasic <pasic@linux.ibm.com>
> > > > > > > > > > > > > > Cc: Cornelia Huck <cohuck@redhat.com>
> > > > > > > > > > > > > > Cc: Vineeth Vijayan <vneethv@linux.ibm.com>
> > > > > > > > > > > > > > Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> > > > > > > > > > > > > > Cc: linux-s390@vger.kernel.org
> > > > > > > > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > Jason, I am really concerned by all the fallout.
> > > > > > > > > > > > > I propose adding a flag to suppress the hardening -
> > > > > > > > > > > > > this will be a debugging aid and a work around for
> > > > > > > > > > > > > users if we find more buggy drivers.
> > > > > > > > > > > > >
> > > > > > > > > > > > > suppress_interrupt_hardening ?
> > > > > > > > > > > >
> > > > > > > > > > > > I can post a patch but I'm afraid if we disable it by default, it
> > > > > > > > > > > > won't be used by the users so there's no way for us to receive the bug
> > > > > > > > > > > > report. Or we need a plan to enable it by default.
> > > > > > > > > > > >
> > > > > > > > > > > > It's rc2, how about waiting for 1 and 2 rc? Or it looks better if we
> > > > > > > > > > > > simply warn instead of disable it by default.
> > > > > > > > > > > >
> > > > > > > > > > > > Thanks
> > > > > > > > > > >
> > > > > > > > > > > I meant more like a flag in struct virtio_driver.
> > > > > > > > > > > For now, could you audit all drivers which don't call _ready?
> > > > > > > > > > > I found 5 of these:
> > > > > > > > > > >
> > > > > > > > > > > drivers/bluetooth/virtio_bt.c
> > > > > > > > > >
> > > > > > > > > > This driver seems to be fine, it doesn't use the device/vq in its probe().
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > But it calls hci_register_dev and that in turn queues all kind of
> > > > > > > > > work. Also, can linux start using the device immediately after
> > > > > > > > > it's registered?
> > > > > > > >
> > > > > > > > So I think the driver is allowed to queue before DRIVER_OK.
> > > > > > >
> > > > > > > it's not allowed to kick
> > > > > >
> > > > > > Yes.
> > > > > >
> > > > > > >
> > > > > > > > If yes,
> > > > > > > > the only side effect is the delay of the tx interrupt after DRIVER_OK
> > > > > > > > for a well behaved device.
> > > > > > >
> > > > > > > your patches drop the interrupt though, it won't be just delayed.
> > > > > >
> > > > > > For a well behaved device, it can only trigger the interrupt after DRIVER_OK.
> > > > > >
> > > > > > So for virtio bt, it works like:
> > > > > >
> > > > > > 1) driver queue buffer and kick
> > > > > > 2) driver set DRIVER_OK
> > > > > > 3) device start to process the buffer
> > > > > > 4) device send an notification
> > > > > >
> > > > > > The only risk is that the virtqueue could be filled before DRIVER_OK,
> > > > > > or anything I missed?
> > > > >
> > > > > btw, hci has an open and close method and we do rx refill in
> > > > > hdev->open, so we're probably fine here.
> > > > >
> > > > > Thanks
> > > >
> > > >
> > > > Sounds good. Now to audit the rest of them from this POV ;)
> > >
> > > Adding maintainers.
> > >
> > > >
> > > >  drivers/i2c/busses/i2c-virtio.c
> > >
> > > It looks to me the device could be used immediately after
> > > i2c_add_adapter() return. So we probably need to add
> > > virtio_device_ready() before that. Fortunately, there's no rx vq in
> > > i2c and the callback looks safe if the callback is called before the
> > > i2c registration and after virtio_device_ready().
> > >
> > > >  drivers/net/caif/caif_virtio.c
> > >
> > > A networking device, RX is backed by vringh so we don't need to
> > > refill. TX is backed by virtio and is available until ndo_open. So
> > > it's fine to let the core to set DRIVER_OK after probe().
> > >
> > > >  drivers/nvdimm/virtio_pmem.c
> > >
> > > It doesn't use interrupt so far, so it has nothing to do with the IRQ hardening.
> > >
> > > But the device could be used by the subsystem immediately after
> > > nvdimm_pmem_region_create(), this means the flush could be issued
> > > before DRIVER_OK. We need virtio_device_ready() before. We don't have
> > > a RX virtqueue and the callback looks safe if the callback is called
> > > after virtio_device_ready() but before the nvdimm region creating.
> > >
> > > And it looks to me there's a race between the assignment of
> > > provider_data and virtio_pmem_flush(). If the flush was issued before
> > > the assignment we will end up with a NULL pointer dereference. This is
> > > something we need to fix.
> > >
> > > >  arm_scmi
> > >
> > > It looks to me the singleton device could be used by SCMI immediately after
> > >
> > >         /* Ensure initialized scmi_vdev is visible */
> > >         smp_store_mb(scmi_vdev, vdev);
> > >
> > > So we probably need to do virtio_device_ready() before that. It has an
> > > optional rx queue but the filling is done after the above assignment,
> > > so it's safe. And the callback looks safe is a callback is triggered
> > > after virtio_device_ready() buy before the above assignment.
> > >
> > > >  virtio_rpmsg_bus.c
> > > >
> > >
> > > This is somehow more complicated. It has an rx queue, the rx filling
> > > is done before virtio_device_ready() but the kick is done after. And
> > > it looks to me the device could be used by subsystem immediately
> > > rpmsg_virtio_add_ctrl_dev() returns.
> > >
> > > This means, if we do virtio_device_ready() after
> > > rpmsg_virtio_add_ctrl_dev(), we may get kick before DRIVER_OK. If we
> > > do virtio_device_ready() before rpmsg_virtio_add_ctrl_dev(), there's a
> > > race between the callbacks and rpmsg_virtio_add_ctrl_dev() that could
> > > be exploited.
> > >
> > > It requires more thoughts.
> > >
> > > Thanks
> >
> > I think at this point let's do it before so we at least do not
> > get a regression with your patches, add a big comment and work
> > on fixing properly in the next Linux version. Do you think you can
> > commit to a full fix in the next linux version?
> 
> I think it should be ok.
> 
> If I understand you correctly, you meant to disable the hardening in
> this release?
> 
> (Actually, my understanding is that since we are developing mainline
> instead of a downstream version with a hardening features, bug reports
> are somehow expected, especially consider most of the bugs are not
> related to hardening itself)


Absolutely. Question is do you think we can fix everything by the
release? At least for rpmsg we don't seem to have a handle on it yet.


> Thanks
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 13a7348cedff..7ef3115efbad 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1688,7 +1688,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
>         vq->we_own_ring = true;
>         vq->notify = notify;
>         vq->weak_barriers = weak_barriers;
> -       vq->broken = true;
> +       vq->broken = false;
>         vq->last_used_idx = 0;
>         vq->event_triggered = false;
>         vq->num_added = 0;


and drop it on reset?

> >
> >
> > > >
> > > >
> > > > > >
> > > > > > >
> > > > > > > > If not, we need to clarify it in the spec
> > > > > > > > and call virtio_device_ready() before subsystem registration.
> > > > > > >
> > > > > > > hmm, i don't get what we need to clarify
> > > > > >
> > > > > > E.g the driver is not allowed to kick or after DRIVER_OK should the
> > > > > > device only process the buffer after a kick after DRIVER_OK (I think
> > > > > > no)?
> > > > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > > > drivers/gpu/drm/virtio/virtgpu_drv.c
> > > > > > > > > >
> > > > > > > > > > It calles virtio_device_ready() in virtio_gpu_init(), and it looks to
> > > > > > > > > > me the code is correct.
> > > > > > > > >
> > > > > > > > > OK.
> > > > > > > > >
> > > > > > > > > > > drivers/i2c/busses/i2c-virtio.c
> > > > > > > > > > > drivers/net/caif/caif_virtio.c
> > > > > > > > > > > drivers/nvdimm/virtio_pmem.c
> > > > > > > > > >
> > > > > > > > > > The above looks fine and we have three more:
> > > > > > > > > >
> > > > > > > > > > arm_scmi: probe() doesn't use vq
> > > > > > > > > > mac80211_hwsim.c: doesn't use vq (only fill rx), but it kicks the rx,
> > > > > > > > > > it looks to me we need a device_ready before the kick.
> > > > > > > > > > virtio_rpmsg_bus.c: doesn't use vq
> > > > > > > > > >
> > > > > > > > > > I will post a patch for mac80211_hwsim.c.
> > > > > > > > > > Thanks
> > > > > > > > >
> > > > > > > > > Same comments for all of the above. Might linux not start using the
> > > > > > > > > device once it's registered?
> > > > > > > >
> > > > > > > > It depends on the specific subsystem.
> > > > > > > >
> > > > > > > > For the subsystem that can't use the device immediately, calling
> > > > > > > > virtio_device_ready() after the subsystem's registration should be
> > > > > > > > fine. E.g for the networking subsystem, the TX won't happen if
> > > > > > > > ndo_open() is not called, calling virtio_device_ready() after
> > > > > > > > netdev_register() seems to be fine.
> > > > > > >
> > > > > > > exactly
> > > > > > >
> > > > > > > > For the subsystem that can use the device immediately, if the
> > > > > > > > subsystem does not depend on the result of a request in the probe to
> > > > > > > > proceed, we are still fine. Since those requests will be proceed after
> > > > > > > > DRIVER_OK.
> > > > > > >
> > > > > > > Well first won't driver code normally kick as well?
> > > > > >
> > > > > > Kick itself is not blocked.
> > > > > >
> > > > > > > And without kick, won't everything just be blocked?
> > > > > >
> > > > > > It depends on the subsystem. E.g driver can choose to use a callback
> > > > > > instead of polling the used buffer in the probe.
> > > > > >
> > > > > > >
> > > > > > >
> > > > > > > > For the rest we need to do virtio_device_ready() before registration.
> > > > > > > >
> > > > > > > > Thanks
> > > > > > >
> > > > > > > Then we can get an interrupt for an unregistered device.
> > > > > >
> > > > > > It depends on the device. For the device that doesn't have an rx queue
> > > > > > (or device to driver queue), we are fine:
> > > > > >
> > > > > > E.g in virtio-blk:
> > > > > >
> > > > > >         virtio_device_ready(vdev);
> > > > > >
> > > > > >         err = device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
> > > > > >         if (err)
> > > > > >                 goto out_cleanup_disk;
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > > ---
> > > > > > > > > > > > > >  drivers/s390/virtio/virtio_ccw.c       |  4 ++++
> > > > > > > > > > > > > >  drivers/virtio/virtio.c                | 15 ++++++++++++---
> > > > > > > > > > > > > >  drivers/virtio/virtio_mmio.c           |  5 +++++
> > > > > > > > > > > > > >  drivers/virtio/virtio_pci_modern_dev.c |  5 +++++
> > > > > > > > > > > > > >  drivers/virtio/virtio_ring.c           | 11 +++++++----
> > > > > > > > > > > > > >  include/linux/virtio_config.h          | 20 ++++++++++++++++++++
> > > > > > > > > > > > > >  6 files changed, 53 insertions(+), 7 deletions(-)
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> > > > > > > > > > > > > > index c188e4f20ca3..97e51c34e6cf 100644
> > > > > > > > > > > > > > --- a/drivers/s390/virtio/virtio_ccw.c
> > > > > > > > > > > > > > +++ b/drivers/s390/virtio/virtio_ccw.c
> > > > > > > > > > > > > > @@ -971,6 +971,10 @@ static void virtio_ccw_set_status(struct virtio_device *vdev, u8 status)
> > > > > > > > > > > > > >       ccw->flags = 0;
> > > > > > > > > > > > > >       ccw->count = sizeof(status);
> > > > > > > > > > > > > >       ccw->cda = (__u32)(unsigned long)&vcdev->dma_area->status;
> > > > > > > > > > > > > > +     /* We use ssch for setting the status which is a serializing
> > > > > > > > > > > > > > +      * instruction that guarantees the memory writes have
> > > > > > > > > > > > > > +      * completed before ssch.
> > > > > > > > > > > > > > +      */
> > > > > > > > > > > > > >       ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_WRITE_STATUS);
> > > > > > > > > > > > > >       /* Write failed? We assume status is unchanged. */
> > > > > > > > > > > > > >       if (ret)
> > > > > > > > > > > > > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > > > > > > > > > > > > index aa1eb5132767..95fac4c97c8b 100644
> > > > > > > > > > > > > > --- a/drivers/virtio/virtio.c
> > > > > > > > > > > > > > +++ b/drivers/virtio/virtio.c
> > > > > > > > > > > > > > @@ -220,6 +220,15 @@ static int virtio_features_ok(struct virtio_device *dev)
> > > > > > > > > > > > > >   * */
> > > > > > > > > > > > > >  void virtio_reset_device(struct virtio_device *dev)
> > > > > > > > > > > > > >  {
> > > > > > > > > > > > > > +     /*
> > > > > > > > > > > > > > +      * The below virtio_synchronize_cbs() guarantees that any
> > > > > > > > > > > > > > +      * interrupt for this line arriving after
> > > > > > > > > > > > > > +      * virtio_synchronize_vqs() has completed is guaranteed to see
> > > > > > > > > > > > > > +      * vq->broken as true.
> > > > > > > > > > > > > > +      */
> > > > > > > > > > > > > > +     virtio_break_device(dev);
> > > > > > > > > > > > >
> > > > > > > > > > > > > So make this conditional
> > > > > > > > > > > > >
> > > > > > > > > > > > > > +     virtio_synchronize_cbs(dev);
> > > > > > > > > > > > > > +
> > > > > > > > > > > > > >       dev->config->reset(dev);
> > > > > > > > > > > > > >  }
> > > > > > > > > > > > > >  EXPORT_SYMBOL_GPL(virtio_reset_device);
> > > > > > > > > > > > > > @@ -428,6 +437,9 @@ int register_virtio_device(struct virtio_device *dev)
> > > > > > > > > > > > > >       dev->config_enabled = false;
> > > > > > > > > > > > > >       dev->config_change_pending = false;
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > +     INIT_LIST_HEAD(&dev->vqs);
> > > > > > > > > > > > > > +     spin_lock_init(&dev->vqs_list_lock);
> > > > > > > > > > > > > > +
> > > > > > > > > > > > > >       /* We always start by resetting the device, in case a previous
> > > > > > > > > > > > > >        * driver messed it up.  This also tests that code path a little. */
> > > > > > > > > > > > > >       virtio_reset_device(dev);
> > > > > > > > > > > > > > @@ -435,9 +447,6 @@ int register_virtio_device(struct virtio_device *dev)
> > > > > > > > > > > > > >       /* Acknowledge that we've seen the device. */
> > > > > > > > > > > > > >       virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > -     INIT_LIST_HEAD(&dev->vqs);
> > > > > > > > > > > > > > -     spin_lock_init(&dev->vqs_list_lock);
> > > > > > > > > > > > > > -
> > > > > > > > > > > > > >       /*
> > > > > > > > > > > > > >        * device_add() causes the bus infrastructure to look for a matching
> > > > > > > > > > > > > >        * driver.
> > > > > > > > > > > > > > diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> > > > > > > > > > > > > > index c9699a59f93c..f9a36bc7ac27 100644
> > > > > > > > > > > > > > --- a/drivers/virtio/virtio_mmio.c
> > > > > > > > > > > > > > +++ b/drivers/virtio/virtio_mmio.c
> > > > > > > > > > > > > > @@ -253,6 +253,11 @@ static void vm_set_status(struct virtio_device *vdev, u8 status)
> > > > > > > > > > > > > >       /* We should never be setting status to 0. */
> > > > > > > > > > > > > >       BUG_ON(status == 0);
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > +     /*
> > > > > > > > > > > > > > +      * Per memory-barriers.txt, wmb() is not needed to guarantee
> > > > > > > > > > > > > > +      * that the the cache coherent memory writes have completed
> > > > > > > > > > > > > > +      * before writing to the MMIO region.
> > > > > > > > > > > > > > +      */
> > > > > > > > > > > > > >       writel(status, vm_dev->base + VIRTIO_MMIO_STATUS);
> > > > > > > > > > > > > >  }
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> > > > > > > > > > > > > > index 4093f9cca7a6..a0fa14f28a7f 100644
> > > > > > > > > > > > > > --- a/drivers/virtio/virtio_pci_modern_dev.c
> > > > > > > > > > > > > > +++ b/drivers/virtio/virtio_pci_modern_dev.c
> > > > > > > > > > > > > > @@ -467,6 +467,11 @@ void vp_modern_set_status(struct virtio_pci_modern_device *mdev,
> > > > > > > > > > > > > >  {
> > > > > > > > > > > > > >       struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > +     /*
> > > > > > > > > > > > > > +      * Per memory-barriers.txt, wmb() is not needed to guarantee
> > > > > > > > > > > > > > +      * that the the cache coherent memory writes have completed
> > > > > > > > > > > > > > +      * before writing to the MMIO region.
> > > > > > > > > > > > > > +      */
> > > > > > > > > > > > > >       vp_iowrite8(status, &cfg->device_status);
> > > > > > > > > > > > > >  }
> > > > > > > > > > > > > >  EXPORT_SYMBOL_GPL(vp_modern_set_status);
> > > > > > > > > > > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > > > > > > > > > > index 9c231e1fded7..13a7348cedff 100644
> > > > > > > > > > > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > > > > > > > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > > > > > > > > > > @@ -1688,7 +1688,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
> > > > > > > > > > > > > >       vq->we_own_ring = true;
> > > > > > > > > > > > > >       vq->notify = notify;
> > > > > > > > > > > > > >       vq->weak_barriers = weak_barriers;
> > > > > > > > > > > > > > -     vq->broken = false;
> > > > > > > > > > > > > > +     vq->broken = true;
> > > > > > > > > > > > > >       vq->last_used_idx = 0;
> > > > > > > > > > > > > >       vq->event_triggered = false;
> > > > > > > > > > > > > >       vq->num_added = 0;
> > > > > > > > > > > > >
> > > > > > > > > > > > > and make this conditional
> > > > > > > > > > > > >
> > > > > > > > > > > > > > @@ -2134,8 +2134,11 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
> > > > > > > > > > > > > >               return IRQ_NONE;
> > > > > > > > > > > > > >       }
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > -     if (unlikely(vq->broken))
> > > > > > > > > > > > > > -             return IRQ_HANDLED;
> > > > > > > > > > > > > > +     if (unlikely(vq->broken)) {
> > > > > > > > > > > > > > +             dev_warn_once(&vq->vq.vdev->dev,
> > > > > > > > > > > > > > +                           "virtio vring IRQ raised before DRIVER_OK");
> > > > > > > > > > > > > > +             return IRQ_NONE;
> > > > > > > > > > > > > > +     }
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >       /* Just a hint for performance: so it's ok that this can be racy! */
> > > > > > > > > > > > > >       if (vq->event)
> > > > > > > > > > > > > > @@ -2177,7 +2180,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
> > > > > > > > > > > > > >       vq->we_own_ring = false;
> > > > > > > > > > > > > >       vq->notify = notify;
> > > > > > > > > > > > > >       vq->weak_barriers = weak_barriers;
> > > > > > > > > > > > > > -     vq->broken = false;
> > > > > > > > > > > > > > +     vq->broken = true;
> > > > > > > > > > > > > >       vq->last_used_idx = 0;
> > > > > > > > > > > > > >       vq->event_triggered = false;
> > > > > > > > > > > > > >       vq->num_added = 0;
> > > > > > > > > > > > >
> > > > > > > > > > > > > and make this conditional
> > > > > > > > > > > > >
> > > > > > > > > > > > > > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > > > > > > > > > > > > > index 25be018810a7..d4edfd7d91bb 100644
> > > > > > > > > > > > > > --- a/include/linux/virtio_config.h
> > > > > > > > > > > > > > +++ b/include/linux/virtio_config.h
> > > > > > > > > > > > > > @@ -256,6 +256,26 @@ void virtio_device_ready(struct virtio_device *dev)
> > > > > > > > > > > > > >       unsigned status = dev->config->get_status(dev);
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >       BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
> > > > > > > > > > > > > > +
> > > > > > > > > > > > > > +     /*
> > > > > > > > > > > > > > +      * The virtio_synchronize_cbs() makes sure vring_interrupt()
> > > > > > > > > > > > > > +      * will see the driver specific setup if it sees vq->broken
> > > > > > > > > > > > > > +      * as false (even if the notifications come before DRIVER_OK).
> > > > > > > > > > > > > > +      */
> > > > > > > > > > > > > > +     virtio_synchronize_cbs(dev);
> > > > > > > > > > > > > > +     __virtio_unbreak_device(dev);
> > > > > > > > > > > > > > +     /*
> > > > > > > > > > > > > > +      * The transport should ensure the visibility of vq->broken
> > > > > > > > > > > > > > +      * before setting DRIVER_OK. See the comments for the transport
> > > > > > > > > > > > > > +      * specific set_status() method.
> > > > > > > > > > > > > > +      *
> > > > > > > > > > > > > > +      * A well behaved device will only notify a virtqueue after
> > > > > > > > > > > > > > +      * DRIVER_OK, this means the device should "see" the coherenct
> > > > > > > > > > > > > > +      * memory write that set vq->broken as false which is done by
> > > > > > > > > > > > > > +      * the driver when it sees DRIVER_OK, then the following
> > > > > > > > > > > > > > +      * driver's vring_interrupt() will see vq->broken as false so
> > > > > > > > > > > > > > +      * we won't lose any notification.
> > > > > > > > > > > > > > +      */
> > > > > > > > > > > > > >       dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
> > > > > > > > > > > > > >  }
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > --
> > > > > > > > > > > > > > 2.25.1
> > > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > >
> > > > > > >
> > > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
