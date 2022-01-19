Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99BAC433EF
	for <virtualization@archiver.kernel.org>; Wed, 19 Jan 2022 09:18:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3FB4C403B3;
	Wed, 19 Jan 2022 09:18:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wFv_zvP5w2i9; Wed, 19 Jan 2022 09:18:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 51EBA403A4;
	Wed, 19 Jan 2022 09:18:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21F04C0039;
	Wed, 19 Jan 2022 09:18:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2193C002F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 09:18:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B2BB481764
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 09:18:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mn-cy9v0oAFh
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 09:18:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9F4CA8148A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 09:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642583891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PtP9Iz6xHgK8mpeAVkx8NjBKePAszJ/UHQqLGQj4py8=;
 b=RYx/og+viVB3EZF2dRUqkep2Fhgbg+A28zPKxD0loNr7ewan5ugz0C3OYDrbV/fgAj7U8e
 +2XIzI3eC5L7ElY2D9JUWPzaOCaKfACgO5lq6w/0Qh6+N+8OOxpGSrTNJhNX2Y/St2gMj5
 GTbbR7ULOTAQyjvax8YPkKYJgh9zOYM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-CA39M06ONc2azU3z2dB1lA-1; Wed, 19 Jan 2022 04:18:09 -0500
X-MC-Unique: CA39M06ONc2azU3z2dB1lA-1
Received: by mail-wm1-f71.google.com with SMTP id
 o3-20020a05600c4fc300b0034aee9534bdso906498wmq.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 01:18:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PtP9Iz6xHgK8mpeAVkx8NjBKePAszJ/UHQqLGQj4py8=;
 b=0eQV0WmxaZTOtlDYWRKfalsYKu06Xo9Bsv4ZTBOZN71lk0b+2CD9T0xZpAtYvibL3d
 Xq887e5A28TVcl7t3qxlUooRipKNSAix9hPWEcpEl1l2pbzlyQOlqYIBQC8iuE82aeP7
 om3rM12agM6pmKDQy0eSzSUpd/aC+Z0LZgJU2CWcGnYfYaxLFyoLGRTkSumW178raH+k
 oSmCTaBcudJkVnNj6E8JUaCRi8ifekPknkmJ9Q11FguY84cNynH1HXgqWoMpmYJct8q9
 trUp4Onj5vh/eTbQKIChH7jlZUkg0Zkl4QfcuuOVkVLOIsvcw9inSWbJhwGize7QFLKM
 sBsg==
X-Gm-Message-State: AOAM531Nre7p6BQ3Y6vm8/K6+bMe4pS7l0QXprjP4U+UE3cP8uH1Rsvm
 PHxyJm429Cdp5XqL2dMy48w8WFL4O8i/IV/WfarLS05mttFKbxmLn1Lda9gqBnIkNVgzZf28Fpp
 KLWTWJno6IyX34uYfyVTofBtp2bYZg4mz61nTO3Qh3Q==
X-Received: by 2002:a1c:a5d4:: with SMTP id o203mr2424969wme.43.1642583887743; 
 Wed, 19 Jan 2022 01:18:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzNONKGHOTAFJF5G1x97BSccLbhtafxrPkf8JhnJiBYP3SHxWpJQF3HD4Wypo5gsmCWaWxBIQ==
X-Received: by 2002:a1c:a5d4:: with SMTP id o203mr2424959wme.43.1642583887489; 
 Wed, 19 Jan 2022 01:18:07 -0800 (PST)
Received: from redhat.com ([2a10:8008:4454:0:bb37:a05d:7459:8682])
 by smtp.gmail.com with ESMTPSA id n32sm4860459wms.8.2022.01.19.01.18.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jan 2022 01:18:06 -0800 (PST)
Date: Wed, 19 Jan 2022 04:18:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 2/2] virtio: acknowledge all features before access
Message-ID: <20220119041343-mutt-send-email-mst@kernel.org>
References: <20220118170225.30620-1-mst@redhat.com>
 <20220118170225.30620-2-mst@redhat.com>
 <CACGkMEt-Q7baDDUM8aC_Lki1aeO36xi02AE7kEapi5NVqkGErg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEt-Q7baDDUM8aC_Lki1aeO36xi02AE7kEapi5NVqkGErg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
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

On Wed, Jan 19, 2022 at 10:52:34AM +0800, Jason Wang wrote:
> On Wed, Jan 19, 2022 at 1:04 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > The feature negotiation was designed in a way that
> > makes it possible for devices to know which config
> > fields will be accessed by drivers.
> >
> > This is broken since commit 404123c2db79 ("virtio: allow drivers to
> > validate features") with fallout in at least block and net.  We have a
> > partial work-around in commit 2f9a174f918e ("virtio: write back
> > F_VERSION_1 before validate") which at least lets devices find out which
> > format should config space have, but this is a partial fix: guests
> > should not access config space without acknowledging features since
> > otherwise we'll never be able to change the config space format.
> 
> So I guess this is for this part of the spec 3.1.1:
> 
> """
> 4. Read device feature bits, and write the subset of feature bits
> understood by the OS and driver to the device. During this step the
> driver MAY read (but MUST NOT write) the device-specific configuration
> fields to check that it can support the device before accepting it.
> """
> 
> If it is, is this better to quote in the change log?

I don't think this spec actually clarifies anything.
Sent some spec patches to improve the situation.

> Other than this,
> 
> Acked-by: Jason Wang <jasowang@redhat.com>
> 
> >
> > To fix, split finalize_features from virtio_finalize_features and
> > call finalize_features with all feature bits before validation,
> > and then - if validation changed any bits - once again after.
> >
> > Since virtio_finalize_features no longer writes out features
> > rename it to virtio_features_ok - since that is what it does:
> > checks that features are ok with the device.
> >
> > As a side effect, this also reduces the amount of hypervisor accesses -
> > we now only acknowledge features once unless we are clearing any
> > features when validating (which is uncommon).
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 404123c2db79 ("virtio: allow drivers to validate features")
> > Fixes: 2f9a174f918e ("virtio: write back F_VERSION_1 before validate")
> > Cc: "Halil Pasic" <pasic@linux.ibm.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > fixup! virtio: acknowledge all features before access
> > ---
> >  drivers/virtio/virtio.c       | 39 ++++++++++++++++++++---------------
> >  include/linux/virtio_config.h |  3 ++-
> >  2 files changed, 24 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index d891b0a354b0..d6396be0ea83 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -166,14 +166,13 @@ void virtio_add_status(struct virtio_device *dev, unsigned int status)
> >  }
> >  EXPORT_SYMBOL_GPL(virtio_add_status);
> >
> > -static int virtio_finalize_features(struct virtio_device *dev)
> > +/* Do some validation, then set FEATURES_OK */
> > +static int virtio_features_ok(struct virtio_device *dev)
> >  {
> > -       int ret = dev->config->finalize_features(dev);
> >         unsigned status;
> > +       int ret;
> >
> >         might_sleep();
> > -       if (ret)
> > -               return ret;
> >
> >         ret = arch_has_restricted_virtio_memory_access();
> >         if (ret) {
> > @@ -244,17 +243,6 @@ static int virtio_dev_probe(struct device *_d)
> >                 driver_features_legacy = driver_features;
> >         }
> >
> > -       /*
> > -        * Some devices detect legacy solely via F_VERSION_1. Write
> > -        * F_VERSION_1 to force LE config space accesses before FEATURES_OK for
> > -        * these when needed.
> > -        */
> > -       if (drv->validate && !virtio_legacy_is_little_endian()
> > -                         && device_features & BIT_ULL(VIRTIO_F_VERSION_1)) {
> > -               dev->features = BIT_ULL(VIRTIO_F_VERSION_1);
> > -               dev->config->finalize_features(dev);
> > -       }
> > -
> >         if (device_features & (1ULL << VIRTIO_F_VERSION_1))
> >                 dev->features = driver_features & device_features;
> >         else
> > @@ -265,13 +253,26 @@ static int virtio_dev_probe(struct device *_d)
> >                 if (device_features & (1ULL << i))
> >                         __virtio_set_bit(dev, i);
> >
> > +       err = dev->config->finalize_features(dev);
> > +       if (err)
> > +               goto err;
> > +
> >         if (drv->validate) {
> > +               u64 features = dev->features;
> > +
> >                 err = drv->validate(dev);
> >                 if (err)
> >                         goto err;
> > +
> > +               /* Did validation change any features? Then write them again. */
> > +               if (features != dev->features) {
> > +                       err = dev->config->finalize_features(dev);
> > +                       if (err)
> > +                               goto err;
> > +               }
> >         }
> >
> > -       err = virtio_finalize_features(dev);
> > +       err = virtio_features_ok(dev);
> >         if (err)
> >                 goto err;
> >
> > @@ -495,7 +496,11 @@ int virtio_device_restore(struct virtio_device *dev)
> >         /* We have a driver! */
> >         virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER);
> >
> > -       ret = virtio_finalize_features(dev);
> > +       ret = dev->config->finalize_features(dev);
> > +       if (ret)
> > +               goto err;
> > +
> > +       ret = virtio_features_ok(dev);
> >         if (ret)
> >                 goto err;
> >
> > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > index 4d107ad31149..dafdc7f48c01 100644
> > --- a/include/linux/virtio_config.h
> > +++ b/include/linux/virtio_config.h
> > @@ -64,8 +64,9 @@ struct virtio_shm_region {
> >   *     Returns the first 64 feature bits (all we currently need).
> >   * @finalize_features: confirm what device features we'll be using.
> >   *     vdev: the virtio_device
> > - *     This gives the final feature bits for the device: it can change
> > + *     This sends the driver feature bits to the device: it can change
> >   *     the dev->feature bits if it wants.
> > + * Note: despite the name this can be called any number of times.
> >   *     Returns 0 on success or error status
> >   * @bus_name: return the bus name associated with the device (optional)
> >   *     vdev: the virtio_device
> > --
> > MST
> >
> 
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
