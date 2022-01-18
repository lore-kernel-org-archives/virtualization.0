Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B910C433EF
	for <virtualization@archiver.kernel.org>; Tue, 18 Jan 2022 15:11:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2DC2B401A1;
	Tue, 18 Jan 2022 15:11:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ci2MEZUqoH2C; Tue, 18 Jan 2022 15:11:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 569B4400D3;
	Tue, 18 Jan 2022 15:11:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19477C0031;
	Tue, 18 Jan 2022 15:11:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39C52C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 15:11:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1A34040962
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 15:11:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jfZV-u4_2Rdx
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 15:11:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1419A4027B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 15:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642518689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AwvMWEfnP+eoe9J52kdeva4MMtThgldbDLr+jG0anUw=;
 b=VaHIjyW+5OXjK7EuJCSMRZ0UKw9HbV1QsB3pmXFN0Y7xYjnqKb8PLgY2/wB7A3QwXJDpmb
 wl+nR8z/PgEGluAByWQaZEid1yOaowMHJga9KKWwq29CKXsqwmNCudre6ZT6CpIH8Goo6l
 9d9IDmIj/1xO9h29FDLchxXJaW1UZ9c=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-wx6wiWLnNxaUmv_rdZl9lQ-1; Tue, 18 Jan 2022 10:11:28 -0500
X-MC-Unique: wx6wiWLnNxaUmv_rdZl9lQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 s9-20020aa7d789000000b004021d03e2dfso7043443edq.18
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 07:11:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=AwvMWEfnP+eoe9J52kdeva4MMtThgldbDLr+jG0anUw=;
 b=Syr8qTk1gE9s7Az2nOQIVYvOrtmvR+uYDnmCi/iQppISsrGWlEVatIDLPgveTx0HAu
 HY51UdJvkuPLje8EzQxb2I9GYsX48XZwR2GpegVSKeO2ztad7J15IeOSMWoIL/pxvEvV
 fRrkuh7AQppbFgXzRYk6A+P1x3jtPM3Vf/TVx3hf5NuGAKLB2DdX79yngvrjirfxS5jV
 kYPTntWND6ZCQ41GQcxyV2VbEJWNjfEMdxA9gXiIFws1SMmgRInIwMxkOVA6E2K/czWr
 UTxEJBZ9ZWfD8txNDDz0RI41PBXUW2TOuXPLedaK1+nSwJB+U/MzZhf5fuIwJbO16W6X
 s62Q==
X-Gm-Message-State: AOAM533J83oIR/gB+xYdpBvUda/uqKiI628/31exol0E/HFtlNEC2Sdk
 4zSp1DZa2tNXJKNQhu2vyeye/Wv7KAIfpvCuctRTk5jrGCEnPLY9/3PleZ1do5+WacWMl+J+z79
 j2259OnwU1bk3cX+F104kaHAbFdF8rW3AzHX+iRMd9A==
X-Received: by 2002:a17:907:c26:: with SMTP id
 ga38mr8576212ejc.521.1642518687227; 
 Tue, 18 Jan 2022 07:11:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxP6vMAJgIYQJ9LQ1cBLwMks8Dw0loNKFcydZ2FZsDsUmVAhjwn/XHQ47D6dQDr/t9ecgfTnA==
X-Received: by 2002:a17:907:c26:: with SMTP id
 ga38mr8576188ejc.521.1642518686993; 
 Tue, 18 Jan 2022 07:11:26 -0800 (PST)
Received: from redhat.com ([2.55.154.241])
 by smtp.gmail.com with ESMTPSA id 17sm5435824eju.65.2022.01.18.07.11.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jan 2022 07:11:26 -0800 (PST)
Date: Tue, 18 Jan 2022 10:11:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH] virtio: acknowledge all features before access
Message-ID: <20220118101010-mutt-send-email-mst@kernel.org>
References: <20220114200744.150325-1-mst@redhat.com>
 <20220118134855.3e8cbce5.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20220118134855.3e8cbce5.pasic@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Tue, Jan 18, 2022 at 01:48:55PM +0100, Halil Pasic wrote:
> On Fri, 14 Jan 2022 15:09:14 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > The feature negotiation was designed in a way that
> > makes it possible for devices to know which config
> > fields will be accessed by drivers.
> > 
> > This is broken since commit 404123c2db79 ("virtio: allow drivers to
> > validate features") with fallout in at least block and net.
> > We have a partial work-around in commit 2f9a174f918e ("virtio: write
> > back F_VERSION_1 before validate") which at least lets devices
> > find out which format should config space have, but this
> > is a partial fix: guests should not access config space
> > without acknowledging features since otherwise we'll never
> > be able to change the config space format.
> > 
> > As a side effect, this also reduces the amount of hypervisor accesses -
> > we now only acknowledge features once unless we are clearing any
> > features when validating.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 404123c2db79 ("virtio: allow drivers to validate features")
> > Fixes: 2f9a174f918e ("virtio: write back F_VERSION_1 before validate")
> > Cc: "Halil Pasic" <pasic@linux.ibm.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > 
> > Halil, I thought hard about our situation with transitional and
> > today I finally thought of something I am happy with.
> > Pls let me know what you think. Testing on big endian would
> > also be much appreciated!
>  
> Hi Michael!
> 
> I was just about to have a look into this. But it does not apply
> cleanly to Linus master (fetched a couple of minutes ago). I also tride
> with d9679d0013a66849~1 but no luck. What is a suitable base for this
> patch?
> 
> Regards,
> Halil

It's on top of
	virtio: unexport virtio_finalize_features
You can also get
	commit cc1f7f0bb64302c1153aa9337db970e6360b379d (HEAD, kernel.org/vhost, kernel.org/linux-next)
from my tree.

> 
> >  drivers/virtio/virtio.c | 31 +++++++++++++++++--------------
> >  1 file changed, 17 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index d891b0a354b0..2ed6e2451fd8 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -168,12 +168,10 @@ EXPORT_SYMBOL_GPL(virtio_add_status);
> >  
> >  static int virtio_finalize_features(struct virtio_device *dev)
> >  {
> > -	int ret = dev->config->finalize_features(dev);
> >  	unsigned status;
> > +	int ret;
> >  
> >  	might_sleep();
> > -	if (ret)
> > -		return ret;
> >  
> >  	ret = arch_has_restricted_virtio_memory_access();
> >  	if (ret) {
> > @@ -244,17 +242,6 @@ static int virtio_dev_probe(struct device *_d)
> >  		driver_features_legacy = driver_features;
> >  	}
> >  
> > -	/*
> > -	 * Some devices detect legacy solely via F_VERSION_1. Write
> > -	 * F_VERSION_1 to force LE config space accesses before FEATURES_OK for
> > -	 * these when needed.
> > -	 */
> > -	if (drv->validate && !virtio_legacy_is_little_endian()
> > -			  && device_features & BIT_ULL(VIRTIO_F_VERSION_1)) {
> > -		dev->features = BIT_ULL(VIRTIO_F_VERSION_1);
> > -		dev->config->finalize_features(dev);
> > -	}
> > -
> >  	if (device_features & (1ULL << VIRTIO_F_VERSION_1))
> >  		dev->features = driver_features & device_features;
> >  	else
> > @@ -265,10 +252,22 @@ static int virtio_dev_probe(struct device *_d)
> >  		if (device_features & (1ULL << i))
> >  			__virtio_set_bit(dev, i);
> >  
> > +	err = dev->config->finalize_features(dev);
> > +	if (err)
> > +		goto err;
> > +
> >  	if (drv->validate) {
> > +		u64 features = dev->features;
> > +
> >  		err = drv->validate(dev);
> >  		if (err)
> >  			goto err;
> > +
> > +		if (features != dev->features) {
> > +			err = dev->config->finalize_features(dev);
> > +			if (err)
> > +				goto err;
> > +		}
> >  	}
> >  
> >  	err = virtio_finalize_features(dev);
> > @@ -495,6 +494,10 @@ int virtio_device_restore(struct virtio_device *dev)
> >  	/* We have a driver! */
> >  	virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER);
> >  
> > +	ret = dev->config->finalize_features(dev);
> > +	if (ret)
> > +		goto err;
> > +
> >  	ret = virtio_finalize_features(dev);
> >  	if (ret)
> >  		goto err;

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
