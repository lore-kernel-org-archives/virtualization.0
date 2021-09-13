Return-Path: <SRS0=Do4E=OD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E800EC433F5
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 07:02:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9551760FDA
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 07:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9551760FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 657C080D80;
	Mon, 13 Sep 2021 07:02:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vIlEkczR97s0; Mon, 13 Sep 2021 07:02:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D180680D14;
	Mon, 13 Sep 2021 07:02:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD0B6C0011;
	Mon, 13 Sep 2021 07:02:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0CA36C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 07:02:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E0C0840441
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 07:02:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wL5j42UBN5CX
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 07:02:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2913340430
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 07:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631516549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B3xga+XtM9D0cLew21idW0fKhvufHgnjYqMJYJQKJQA=;
 b=JssfHFOy4M5+3TzQtYZ42ECLdTS/wGCL+1ntsBUxFHRDvEtDLNBrhty/n78NqM2M9p5cih
 jDuYp4XWC34UF0ULpOT9HYWwYDobA96YPNJHkjWbUeP4V3BJo5O1B07Bx6oU4eJdpCggJd
 C/nAvGuMwNFJbcEYXp0Av/yOZgqb0Hc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-JURfdsQ3NYuCNk6VO8iFJw-1; Mon, 13 Sep 2021 03:02:26 -0400
X-MC-Unique: JURfdsQ3NYuCNk6VO8iFJw-1
Received: by mail-wm1-f69.google.com with SMTP id
 m4-20020a05600c3b0400b00303b904380dso2271761wms.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 00:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=B3xga+XtM9D0cLew21idW0fKhvufHgnjYqMJYJQKJQA=;
 b=UnYlZadBuJu0mumQj90Hvzg4l6OdjpcQAgwGtW0F1osj5aBwXMZH2BKlP3P0F/eSgj
 c6NsVHf3Mw/6swZa7WcW0jTKHSaBu11+XQfuWLs9LtC7VUA4WElO+qhbi8aK9Bty1gpS
 15KM+i33mJSHsJYbUu7chbMk3Dxj59R30pStzGTLvqiQa6LSz57cAQAoNy/eIc8pqwlY
 mONtxl2heEcJG01X9tpcfWntVj8LRDRd/HVtICNuRtkjCoO2g5bkBO2tjW0RKNgCohM8
 gnnxTAg++d7vBAB5Bp7wE+Ox/LkCPaw+MoDldeTr1twft8r6EfsIiPhMWBMV9iotDXcC
 T7zA==
X-Gm-Message-State: AOAM531f13pIqnXYhA84jhU0mK/bgIAK/2DrE91mV03yGJXopAC0y5aM
 QiVoGmsSj6TA8bq4gH67Y/mOaZTHf6fLf/hHiPjx+iZCFxpWjKeZAhVl82C3sFlSf6yVJy0qFow
 D2HId8HoI4wJcIfiFT0m49rnEWFF1XipqMukpcUSnVg==
X-Received: by 2002:a1c:2547:: with SMTP id l68mr9485137wml.23.1631516545540; 
 Mon, 13 Sep 2021 00:02:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxD55TVvlDtRtqgJCBRla+/PTUug5ntfDs6eJ/eUl/ouRdkIPoitUu0G630NOp5JJrqUko78w==
X-Received: by 2002:a1c:2547:: with SMTP id l68mr9485113wml.23.1631516545307; 
 Mon, 13 Sep 2021 00:02:25 -0700 (PDT)
Received: from redhat.com ([2.55.27.174])
 by smtp.gmail.com with ESMTPSA id v20sm6613465wra.73.2021.09.13.00.02.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 00:02:24 -0700 (PDT)
Date: Mon, 13 Sep 2021 03:02:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 7/9] virtio-pci: harden INTX interrupts
Message-ID: <20210913030134-mutt-send-email-mst@kernel.org>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-8-jasowang@redhat.com>
 <20210913022824-mutt-send-email-mst@kernel.org>
 <CACGkMEtnmLzQDNVYnAYSsEmjjRJVDhuK6VNj56S__zU9+5-JQQ@mail.gmail.com>
 <20210913023757-mutt-send-email-mst@kernel.org>
 <CACGkMEskmq7azAP6QiNz=_nXaU6vbtr975wk3kr9H6pOGs-ZuQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEskmq7azAP6QiNz=_nXaU6vbtr975wk3kr9H6pOGs-ZuQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Hetzelt,
 Felicitas" <f.hetzelt@tu-berlin.de>,
 linux-kernel <linux-kernel@vger.kernel.org>, "kaplan,
 david" <david.kaplan@amd.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Mon, Sep 13, 2021 at 02:45:38PM +0800, Jason Wang wrote:
> On Mon, Sep 13, 2021 at 2:41 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Sep 13, 2021 at 02:36:54PM +0800, Jason Wang wrote:
> > > On Mon, Sep 13, 2021 at 2:33 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, Sep 13, 2021 at 01:53:51PM +0800, Jason Wang wrote:
> > > > > This patch tries to make sure the virtio interrupt handler for INTX
> > > > > won't be called after a reset and before virtio_device_ready(). We
> > > > > can't use IRQF_NO_AUTOEN since we're using shared interrupt
> > > > > (IRQF_SHARED). So this patch tracks the INTX enabling status in a new
> > > > > intx_soft_enabled variable and toggle it during in
> > > > > vp_disable/enable_vectors(). The INTX interrupt handler will check
> > > > > intx_soft_enabled before processing the actual interrupt.
> > > > >
> > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > >
> > > >
> > > > Not all that excited about all the memory barriers for something
> > > > that should be an extremely rare event (for most kernels -
> > > > literally once per boot). Can't we do better?
> > >
> > > I'm not sure, but do we need to care about the slow path (INTX)?
> >
> > Otherwise we won't try to support this, right?
> 
> Sorry, what I meant is "do we need to care about the performance of
> the slow path".
> 
> >
> > > (Or do you have a better approach?)
> > >
> > > Thanks
> >
> > Don't know really, maybe rcu or whatever?
> 
> I am sure it's worth it to bother since it's the slow path.
> 
> > But let's try to be much more specific - is there anything
> > specific we are trying to protect against here?
> 
> The unexpected calling of the vring or config interrupt handler. (The
> same as MSI-X, e.g the untrusted device can send irq at any time).
> 
> Thanks

And so, does this do more than crash the guest?  Hypervisors
already can do that ...


> >
> >
> >
> > > >
> > > > > ---
> > > > >  drivers/virtio/virtio_pci_common.c | 18 ++++++++++++++++--
> > > > >  drivers/virtio/virtio_pci_common.h |  1 +
> > > > >  2 files changed, 17 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > > > > index 0b9523e6dd39..835197151dc1 100644
> > > > > --- a/drivers/virtio/virtio_pci_common.c
> > > > > +++ b/drivers/virtio/virtio_pci_common.c
> > > > > @@ -30,8 +30,12 @@ void vp_disable_vectors(struct virtio_device *vdev)
> > > > >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > > >       int i;
> > > > >
> > > > > -     if (vp_dev->intx_enabled)
> > > > > +     if (vp_dev->intx_enabled) {
> > > > > +             vp_dev->intx_soft_enabled = false;
> > > > > +             /* ensure the vp_interrupt see this intx_soft_enabled value */
> > > > > +             smp_wmb();
> > > > >               synchronize_irq(vp_dev->pci_dev->irq);
> > > > > +     }
> > > > >
> > > > >       for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > > >               disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > > @@ -43,8 +47,12 @@ void vp_enable_vectors(struct virtio_device *vdev)
> > > > >       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > > >       int i;
> > > > >
> > > > > -     if (vp_dev->intx_enabled)
> > > > > +     if (vp_dev->intx_enabled) {
> > > > > +             vp_dev->intx_soft_enabled = true;
> > > > > +             /* ensure the vp_interrupt see this intx_soft_enabled value */
> > > > > +             smp_wmb();
> > > > >               return;
> > > > > +     }
> > > > >
> > > > >       for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > > >               enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > > @@ -97,6 +105,12 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
> > > > >       struct virtio_pci_device *vp_dev = opaque;
> > > > >       u8 isr;
> > > > >
> > > > > +     if (!vp_dev->intx_soft_enabled)
> > > > > +             return IRQ_NONE;
> > > > > +
> > > > > +     /* read intx_soft_enabled before read others */
> > > > > +     smp_rmb();
> > > > > +
> > > > >       /* reading the ISR has the effect of also clearing it so it's very
> > > > >        * important to save off the value. */
> > > > >       isr = ioread8(vp_dev->isr);
> > > > > diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> > > > > index a235ce9ff6a5..3c06e0f92ee4 100644
> > > > > --- a/drivers/virtio/virtio_pci_common.h
> > > > > +++ b/drivers/virtio/virtio_pci_common.h
> > > > > @@ -64,6 +64,7 @@ struct virtio_pci_device {
> > > > >       /* MSI-X support */
> > > > >       int msix_enabled;
> > > > >       int intx_enabled;
> > > > > +     bool intx_soft_enabled;
> > > > >       cpumask_var_t *msix_affinity_masks;
> > > > >       /* Name strings for interrupts. This size should be enough,
> > > > >        * and I'm too lazy to allocate each name separately. */
> > > > > --
> > > > > 2.25.1
> > > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
