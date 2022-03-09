Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E46C433FE
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 11:27:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CBE7B842AF;
	Wed,  9 Mar 2022 11:27:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GwvnoDieJUuK; Wed,  9 Mar 2022 11:27:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 64E8F842AA;
	Wed,  9 Mar 2022 11:27:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15E98C0012;
	Wed,  9 Mar 2022 11:27:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93B91C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 11:27:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6DB9F41696
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 11:27:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uulQDbyIpAv3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 11:27:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2117241695
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 11:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646825270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r1dry0lyUeg8BL93lixPa+Zflu8wHHVu2YISeXmZ4Ik=;
 b=F8980wOTFSqjcsTapQWENwRxhle6o4Rv5LBccf2TTPanIbp0vTkMRWHL6cS3Zm99WekC1F
 nBSEbnnmVim3P2Kia2swpnG2eVM7TYD7VMrq5AsJ6JZ8WskbCyp+QS5CWv7g7VotcXh074
 dA+lnrEz8kvUV9u/Y8VOrB6jS4nOj2o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-MnezioUyOyyAqKpa8muQnw-1; Wed, 09 Mar 2022 06:27:48 -0500
X-MC-Unique: MnezioUyOyyAqKpa8muQnw-1
Received: by mail-wm1-f71.google.com with SMTP id
 h206-20020a1c21d7000000b003552c13626cso2476626wmh.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Mar 2022 03:27:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=r1dry0lyUeg8BL93lixPa+Zflu8wHHVu2YISeXmZ4Ik=;
 b=6o2+KSzN3iOEie/Yl3PknHqnxAjXD1/i2TaBDOLmjo15DHcSuNQ1yqms5DDUGrJ7Ot
 jPwRUMqY37CCcH2bJXHR0dOq4kqWVbQqZDj0k78ra6DjOIOlV6NeWUfw47bHrxfK9005
 CO8A81VFeRGSJfQM5nLK5StUGEt6Er26OMAELHMXizhgxUOiw/j+lNSBS9uA7EzGpRiT
 iDElr1oZXc2XwXOdDwgVYY4yFnDRQWfzUX5zMKG5iuDUOdH9NXi24hPgV5mlTFdZ939J
 qEyTnH46yfpN588OWpkunALK5tdr9IEIjSr2xQgNgknpxR7DIhchmdcb40CEPDdAst7b
 7jwA==
X-Gm-Message-State: AOAM530+cW70DsjiH9p35hWV1JKhaRGQiFfKt0XUPkHLC0a9jJs4VEWG
 djxD201HpA58geOLtIvvrMJMTtoi3/CriC9wXim2SWgbjBWxdlVyapY6rtf5uvi+jlu/g5rAPph
 hZyevIB4rlw9O/lxb/SRwY9RC0YK8HmxoBYXM/hRGIg==
X-Received: by 2002:a5d:5850:0:b0:1f0:2d5b:dc35 with SMTP id
 i16-20020a5d5850000000b001f02d5bdc35mr15385681wrf.344.1646825267359; 
 Wed, 09 Mar 2022 03:27:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5EnTxMjHseQJzsLJ5Wu/dTwFF7Brw8lDvcPJ3itJlIDDt9Pu0F10asMB1wyA3mLuGf/VXjA==
X-Received: by 2002:a5d:5850:0:b0:1f0:2d5b:dc35 with SMTP id
 i16-20020a5d5850000000b001f02d5bdc35mr15385660wrf.344.1646825267128; 
 Wed, 09 Mar 2022 03:27:47 -0800 (PST)
Received: from redhat.com ([2.55.24.184]) by smtp.gmail.com with ESMTPSA id
 q11-20020adfcd8b000000b001e320028660sm1387682wrj.92.2022.03.09.03.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Mar 2022 03:27:46 -0800 (PST)
Date: Wed, 9 Mar 2022 06:27:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH V3 05/10] virtio-pci: harden INTX interrupts
Message-ID: <20220309060703-mutt-send-email-mst@kernel.org>
References: <20211019070152.8236-1-jasowang@redhat.com>
 <20211019070152.8236-6-jasowang@redhat.com>
 <87wnh3z9nm.wl-maz@kernel.org>
MIME-Version: 1.0
In-Reply-To: <87wnh3z9nm.wl-maz@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: keirf@google.com, "Paul E . McKenney" <paulmck@kernel.org>,
 david.kaplan@amd.com, konrad.wilk@oracle.com,
 Peter Zijlstra <peterz@infradead.org>, f.hetzelt@tu-berlin.de,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>
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

On Wed, Mar 09, 2022 at 10:45:49AM +0000, Marc Zyngier wrote:
> [Adding Will to check on my understanding of the interactions between
>  spinlocks and WRITE_ONCE()]
> 
> On Tue, 19 Oct 2021 08:01:47 +0100,
> Jason Wang <jasowang@redhat.com> wrote:
> > 
> > This patch tries to make sure the virtio interrupt handler for INTX
> > won't be called after a reset and before virtio_device_ready(). We
> > can't use IRQF_NO_AUTOEN since we're using shared interrupt
> > (IRQF_SHARED). So this patch tracks the INTX enabling status in a new
> > intx_soft_enabled variable and toggle it during in
> > vp_disable/enable_vectors(). The INTX interrupt handler will check
> > intx_soft_enabled before processing the actual interrupt.
> > 
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_pci_common.c | 23 +++++++++++++++++++++--
> >  drivers/virtio/virtio_pci_common.h |  1 +
> >  2 files changed, 22 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > index 8d8f83aca721..1bce254a462a 100644
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -30,8 +30,16 @@ void vp_disable_cbs(struct virtio_device *vdev)
> >  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> >  	int i;
> >  
> > -	if (vp_dev->intx_enabled)
> > +	if (vp_dev->intx_enabled) {
> > +		/*
> > +		 * The below synchronize() guarantees that any
> > +		 * interrupt for this line arriving after
> > +		 * synchronize_irq() has completed is guaranteed to see
> > +		 * intx_soft_enabled == false.
> > +		 */
> > +		WRITE_ONCE(vp_dev->intx_soft_enabled, false);
> >  		synchronize_irq(vp_dev->pci_dev->irq);
> > +	}
> >  
> >  	for (i = 0; i < vp_dev->msix_vectors; ++i)
> >  		disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > @@ -43,8 +51,16 @@ void vp_enable_cbs(struct virtio_device *vdev)
> >  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> >  	int i;
> >  
> > -	if (vp_dev->intx_enabled)
> > +	if (vp_dev->intx_enabled) {
> > +		disable_irq(vp_dev->pci_dev->irq);
> > +		/*
> > +		 * The above disable_irq() provides TSO ordering and
> > +		 * as such promotes the below store to store-release.
> > +		 */
> > +		WRITE_ONCE(vp_dev->intx_soft_enabled, true);
> 
> What do you mean by TSO here? AFAICT, the CPU is allowed hoist this
> write up into the lock used by disable_irq(), as the unlock only has
> release semantics. Is that what you are relying on? I don't see how
> this upgrades WRITE_ONCE() to have release semantics.
> 
> > +		enable_irq(vp_dev->pci_dev->irq);
> 
> Same thing does here: my understanding is that the write can be pushed
> down into the lock, which has acquire semantics only.
> 
> Thanks,
> 
> 	M.

Overall I feel what we are doing here is very standard and should be
pretty common for a driver that wants to be protected against a
malicious device:


1- get IRQ
2- initialize device with IRQ
3- enable IRQ

Doing it in the core kernel helps make sure interrupts are
not lost if they trigger during 2.

Without core kernel support one has to refactor the driver along the lines of:

a- initialize driver
b- get IRQ
c- initialize device with IRQ

and this is often tricky especially if one wants to do things like
discover device configuration and reconfigure the driver accordingly.


> -- 
> Without deviation from the norm, progress is not possible.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
