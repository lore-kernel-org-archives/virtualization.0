Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE33C433F5
	for <virtualization@archiver.kernel.org>; Thu, 24 Mar 2022 11:07:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F79A60E11;
	Thu, 24 Mar 2022 11:07:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wbtXxIO2FeJ6; Thu, 24 Mar 2022 11:07:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id ACB0360087;
	Thu, 24 Mar 2022 11:07:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FDD0C001A;
	Thu, 24 Mar 2022 11:07:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05E39C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 11:07:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E639B4102A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 11:07:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D9E6vS70NYvQ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 11:07:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D4BFB400A6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 11:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648120036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1T0yWbiZx8k6dMvysOvcdB5ykkIHbUMTZtgTTPZEYIg=;
 b=V3IVFZTupoQa7heVCz7mi8m6OofsNLmEvmVPXwr6nWM2ML4yo0ml26s9b6nrOxnLdjW5jx
 rzHCkdU4PUQed+fJn9PEv4v2nqnsD9wzTbL3Uttir7fqfvpIfNuVj3WzEUq/bQ5z/LpkEC
 V+1AIO8K+H9vFIRcRshvGTfoBI9ljuM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-164-giN36AisN2yL4sWFWvjoqw-1; Thu, 24 Mar 2022 07:07:15 -0400
X-MC-Unique: giN36AisN2yL4sWFWvjoqw-1
Received: by mail-wm1-f70.google.com with SMTP id
 i6-20020a05600c354600b0038be262d9d9so3893003wmq.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 04:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1T0yWbiZx8k6dMvysOvcdB5ykkIHbUMTZtgTTPZEYIg=;
 b=SeFPVOq3HD/Ulwx82dvYUDRhOObkzUJ0QDPbMhEgbQJI12mX325YmWuN83lpxUeVal
 ruFbqkQY8AXUMhIdcFXFfWUglVHUKhPedJa+XKFl5S+/+VBC3cmL1zQ+VHyE/QZ9WOpn
 Du71zcK15az86qQUK7xas0offyGBFL6DONYlm/DKGY5MtLmzRSOZcPBIWhdryXE0Cpzi
 U0+2XqXcRElT07BcWnbI+iBtrtZtPeKyprng85Id/YlJ0mL70T+3Jv7jjN+VTYi0wDuS
 8NIMuLclmQb60FXUt05iaGkvL4tHktV/LJ+gJNq4ic3nxXBefFtWiFCYPuxlfadm4bWJ
 1/BQ==
X-Gm-Message-State: AOAM533HWS4C/vgD9geNB1CzH2vzYrqazDUztYFzbKb63IKi1IV5xMah
 MHQiDSRSI8VeGUUGd7paiFU0LRvt/8gy6Nz4EGCFGvjT8jx8qL1sLJ5ipFaaSlld+igVG4kZtAm
 HUAU06FtXuFNL58VoNfUowtcka+1gcLe34tgt+dOkKA==
X-Received: by 2002:a05:600c:1989:b0:38c:b8b3:8fa8 with SMTP id
 t9-20020a05600c198900b0038cb8b38fa8mr13195867wmq.18.1648120034251; 
 Thu, 24 Mar 2022 04:07:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwA0EZumo0j0KssEfmzzO7vlsnhjaOg1S762Lka3uCpCQVy1H8Qhey1LQHCTinjFhD77Ni4HQ==
X-Received: by 2002:a05:600c:1989:b0:38c:b8b3:8fa8 with SMTP id
 t9-20020a05600c198900b0038cb8b38fa8mr13195841wmq.18.1648120033977; 
 Thu, 24 Mar 2022 04:07:13 -0700 (PDT)
Received: from redhat.com ([2.55.151.118]) by smtp.gmail.com with ESMTPSA id
 k18-20020a5d6d52000000b00203da94cf01sm2333203wri.14.2022.03.24.04.07.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Mar 2022 04:07:13 -0700 (PDT)
Date: Thu, 24 Mar 2022 07:07:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH 1/3] virtio: use virtio_device_ready() in
 virtio_device_restore()
Message-ID: <20220324070612-mutt-send-email-mst@kernel.org>
References: <20220324084004.14349-1-jasowang@redhat.com>
 <20220324084004.14349-2-jasowang@redhat.com>
 <20220324064205-mutt-send-email-mst@kernel.org>
 <20220324110307.iizkdwuhc5c75noj@sgarzare-redhat>
MIME-Version: 1.0
In-Reply-To: <20220324110307.iizkdwuhc5c75noj@sgarzare-redhat>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: peterz@infradead.org, maz@kernel.org, keirf@google.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 tglx@linutronix.de
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

On Thu, Mar 24, 2022 at 12:03:07PM +0100, Stefano Garzarella wrote:
> On Thu, Mar 24, 2022 at 06:48:05AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Mar 24, 2022 at 04:40:02PM +0800, Jason Wang wrote:
> > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > 
> > > This avoids setting DRIVER_OK twice for those drivers that call
> > > virtio_device_ready() in the .restore
> > 
> > Is this trying to say it's faster?
> 
> Nope, I mean, when I wrote the original version, I meant to do the same
> things that we do in virtio_dev_probe() where we called
> virtio_device_ready() which not only set the state, but also called
> .enable_cbs callback.
> 
> Was this a side effect and maybe more compliant with the spec?


Sorry I don't understand the question. it says "avoids setting DRIVER_OK twice" -
why is that advantageous and worth calling out in the commit log?


> > If yes this one looks like a red herring. Yes we skip a write but we
> > replace it with a read which is not better performance-wise.
> > If we want to optimize this, it is better to just do that inside
> > virtio_add_status:
> > 
> > 
> > 
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index 75c8d560bbd3..cd943c31bdbb 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -161,8 +161,14 @@ static void virtio_config_enable(struct virtio_device *dev)
> > 
> > void virtio_add_status(struct virtio_device *dev, unsigned int status)
> > {
> > +	unsigned int device_status;
> > +
> > 	might_sleep();
> > -	dev->config->set_status(dev, dev->config->get_status(dev) | status);
> > +
> > +	device_status = dev->config->get_status(dev);
> > +
> > +	if (status & ~device_status)
> > +		dev->config->set_status(dev, device_status | status);
> > }
> > EXPORT_SYMBOL_GPL(virtio_add_status);
> 
> Could there be a case where we want to set the status again even though the
> device tells us it's already set?
> 
> I think not, so I guess it's okay.
> 
> > 
> > 
> > > and it will allows us to do
> > > extension on virtio_device_ready() without duplicating codes.
> > > 
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  drivers/virtio/virtio.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > index 22f15f444f75..75c8d560bbd3 100644
> > > --- a/drivers/virtio/virtio.c
> > > +++ b/drivers/virtio/virtio.c
> > > @@ -526,8 +526,9 @@ int virtio_device_restore(struct virtio_device *dev)
> > >  			goto err;
> > >  	}
> > > 
> > > -	/* Finally, tell the device we're all set */
> > > -	virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
> > > +	/* If restore didn't do it, mark device DRIVER_OK ourselves. */
> > 
> > I preferred the original comment, it said why we are doing this,
> > new one repeats what code is doing.
> 
> I agree, copy & paste from virtio_dev_probe().
> 
> Jason can you fix this patch or should I resend?
> 
> Thanks,
> Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
