Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B374C433F5
	for <virtualization@archiver.kernel.org>; Tue, 18 Jan 2022 15:20:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD98B60E22;
	Tue, 18 Jan 2022 15:20:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h44KEkYIKtnY; Tue, 18 Jan 2022 15:20:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 44C1860AEA;
	Tue, 18 Jan 2022 15:20:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D63FC0031;
	Tue, 18 Jan 2022 15:20:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFF12C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 15:20:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C009A60BCF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 15:20:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YD82epCbgF8W
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 15:20:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CF07960AEA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 15:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642519213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gY6Hax963rHOpjf62HVLLjpmM0CdjtqRy7qF6ZHQCGc=;
 b=I3uyVQluuO+9TLFfcseeSqyrc4XcBW6OoQaVuiX+xtz1xyi/5bAwFQpvXsuK4SkhiYdDhu
 fP+RRItvvT12DlcZVGscE859MHC5IDIWUEXuwCxJh7mQQfCDA4XGvO1vTk4TLrB2PWjwYy
 FKCfSxODp95qRxkzytJkaeOXYngEyDQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-0VGcG67wMXaokGi2R_7txw-1; Tue, 18 Jan 2022 10:20:12 -0500
X-MC-Unique: 0VGcG67wMXaokGi2R_7txw-1
Received: by mail-ed1-f72.google.com with SMTP id
 o10-20020a056402438a00b00403212b6b1aso4206777edc.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 07:20:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gY6Hax963rHOpjf62HVLLjpmM0CdjtqRy7qF6ZHQCGc=;
 b=q+Le5Gr3jWqtvA+UJe2E1YJ+MWvjf/vjbm4TeSwC8vk47YKgRnsriNQMgEZKLEmZiv
 Y8Z+I7mFsmo4dGW+6S0gssmMZbqJZHk0UGYPFVtjhnCFdvlYQoGVATrhFFDU9cbS4OV5
 y7OEeJvhPtoqTwDof1itQKR2Sz1xgMelfndvaIqeFvE8G+KoTs9oXvzApqZSSIA55Xj2
 KG3rn3v4+Fu0U1yQZIz9IBFbMzQrVHoA7OovFO6KhPGpS8wGPsHwyP9B9bB09tyYfZia
 J6Dkm0QMgQgxlqsSOCzHv2wTINjUzsG7IaCiLZleKB7950KtwRXfugV7dP/r7i1a6llH
 zkDQ==
X-Gm-Message-State: AOAM533Vn1bKKcQ0GzZCHyelrGaa+ZAOqxUcXHiDxqdh4TKKK8gNDyzJ
 JyhvI/xGKBNiTPPlN8PY5RVrBAaSWprQpkr3oLuDmEFlafjZsVmqcR8uPWg3d1o/xp6W4EfPy/W
 vlfQ32Qzxj2OPbd9Ica0xMSUTNrrhVztmrj9z2MoRmg==
X-Received: by 2002:a05:6402:350f:: with SMTP id
 b15mr25709378edd.77.1642519206797; 
 Tue, 18 Jan 2022 07:20:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwrPUpMZrXZZ6hhQLm6jDDIK+KWCDI7IJhGLGk4DhdtM+pN0tvJUeMqVeEWPPbTOnCCPxX2CA==
X-Received: by 2002:a05:6402:350f:: with SMTP id
 b15mr25709360edd.77.1642519206567; 
 Tue, 18 Jan 2022 07:20:06 -0800 (PST)
Received: from redhat.com ([2.55.154.241])
 by smtp.gmail.com with ESMTPSA id 26sm5457537ejk.166.2022.01.18.07.20.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jan 2022 07:20:05 -0800 (PST)
Date: Tue, 18 Jan 2022 10:20:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH] virtio: acknowledge all features before access
Message-ID: <20220118101233-mutt-send-email-mst@kernel.org>
References: <20220114200744.150325-1-mst@redhat.com>
 <20220118154350.1ff3fa3f.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20220118154350.1ff3fa3f.pasic@linux.ibm.com>
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

On Tue, Jan 18, 2022 at 03:43:50PM +0100, Halil Pasic wrote:
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
> 
> I agree with that. The crux is what does "acknowledge features" exactly
> mean. Is it "write features" or "complete the feature negotiation,
> including setting FEATURES_OK".

Right. I think originally it was "write features". We then added
the FEATURES_OK in order to give devices a chance to reject
a set of features, and while doing this we failed to
notice that at this point "acknowledge" became confusing.

There's a spec proposal to make things more explicit, and
I think I will tweak it to actually use the term
"acknowledge".

On top of that, it makes sense to go back, scan all of the spec
and see whether any places that we changed from set not negotiated
for clarify actually should read "set in the written".

> My understanding is, that we should not rely on that the device is
> going to act according to the negotiated feature set unless FEATURES_OK
> was set successfully.


not for writes, but for reads there's little choice.

> That would mean, that this change ain't guaranteed to help with the
> stated problem. We simply don't know if the fact that features
> were written is going to have a side-effect or not. Also see below.

right. at the moment it's just the MTU field. In the future it
can be more, but by that future time we can fix the spec ;)

> > 
> > As a side effect, this also reduces the amount of hypervisor accesses -
> > we now only acknowledge features once unless we are clearing any
> > features when validating.
> 
> My understanding is that this patch basically does for all the features,
> what commit 2f9a174f918e ("virtio: write back F_VERSION_1 before
> validate") did only for F_VERSION_1 and under certain conditions to
> be minimally invasive.
> 
> I don't like when s390 is the oddball, so I'm very happy to see us
> moving away from that.
> 
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
> Thanks! I will first provide some comments, and I intend to come back
> with the test results later.
> 
> > 
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
> 
> A side note: config->finalize_features() ain't the best name for what the
> thing does. After config->finalize_features() the features are not final.
> Unlike after virtio_finalize_features(). IMHO filter_and_write_features()
> would be a more accurate, although longer name.

I agree.
But I think I will start with figuring out the best name in the spec.
Maybe write back or acknowledge. Let's see what gets accepted by
the tc. Then I'll change code to match.

> After this point, the features aren't final yet, and one can not say
> that a some feature X has been negotiated. But with regards to features,
> the spec does not really consider this limbo state.
> 
> Should this change? Do we want to say: the device SHOULD pick up, and
> act upon the new features *before* FEATURES_OK is set?

Yes but only for handling config reads. See my spec proposal.

> ...
> 
> > +	if (err)
> > +		goto err;
> > +
> >  	if (drv->validate) {
> > +		u64 features = dev->features;
> > +
> >  		err = drv->validate(dev);
> 
> ... Consider the "we would like to introduce a new config space format"
> example. Here, I guess we would like to use the new format. But let's say
> _F_CFG_FMT_V2 aint negotiated yet. So to be sure about the format, we
> would need to specify, that the behavior of the device needs to change
> after the feature has been written, but before FEATURES_OK is set, at
> least for _F_CFG_FMT_V2.

for config space reads. yes.

> Please also consider the QEMU implementation of the vhost-user stuff. We
> push the features to the back-end only when FEATURES_OK status is
> written.

that has to change, anyway - it's needed to fix endian-ness.

> 
> >  		if (err)
> >  			goto err;
> > +
> > +		if (features != dev->features) {
> > +			err = dev->config->finalize_features(dev);
> 
> It is fine to call it again, because the features aren't finalized yet.
> And re-doing any transport-level filtering and validation is fine as
> well.

Will add a comment.

> > +			if (err)
> > +				goto err;
> > +		}
> >  	}
> >  
> >  	err = virtio_finalize_features(dev);
> 
> Here the features are finally negotiated and final.
> 
> > @@ -495,6 +494,10 @@ int virtio_device_restore(struct virtio_device *dev)
> >  	/* We have a driver! */
> >  	virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER);
> >  
> > +	ret = dev->config->finalize_features(dev);
> > +	if (ret)
> > +		goto err;
> > +
> >  	ret = virtio_finalize_features(dev);
> 
> Looks a little weird, because virtio_finalize_features() used to include
> filter + write + set FEATURES_OK. But it ain't too bad.
> 
> Better names would benefit readability though, if we can come up with
> some.
> 
> Regards,
> Halil

right. I think that can be a patch on top though.

> >  	if (ret)
> >  		goto err;

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
