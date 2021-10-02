Return-Path: <SRS0=UZhq=OW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC32C433EF
	for <virtualization@archiver.kernel.org>; Sat,  2 Oct 2021 10:21:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25A96615A4
	for <virtualization@archiver.kernel.org>; Sat,  2 Oct 2021 10:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 25A96615A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D560642621;
	Sat,  2 Oct 2021 10:21:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KygXpNiEaQVZ; Sat,  2 Oct 2021 10:21:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 380ED42618;
	Sat,  2 Oct 2021 10:21:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17D35C000F;
	Sat,  2 Oct 2021 10:21:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21B07C000D
 for <virtualization@lists.linux-foundation.org>;
 Sat,  2 Oct 2021 10:21:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0A2DC846BA
 for <virtualization@lists.linux-foundation.org>;
 Sat,  2 Oct 2021 10:21:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wTvDwhjcyN8B
 for <virtualization@lists.linux-foundation.org>;
 Sat,  2 Oct 2021 10:21:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DE556846B5
 for <virtualization@lists.linux-foundation.org>;
 Sat,  2 Oct 2021 10:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633170102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ralEWdhrk09yJSkvlggMNWVcH3C+hpuchF+iW56D2YA=;
 b=HUw1ZqpUWIM4NabrwxhH1FCjQp5d9ztF5SajrdlgV6k8IRDOAXFjo16XMyfUinnXGY2sJz
 Og1TNSkWofacSQhI/TPvWhlvF1Ec6rMk6DBfl5nCWD7m+gzk9X5sLOx2Q7QO7bZ8WBLEWz
 16R5pMnzPJRAgQsv33IG8IBTdl0XhlI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-kixJ6uY7P-e4GY_01vegZQ-1; Sat, 02 Oct 2021 06:21:39 -0400
X-MC-Unique: kixJ6uY7P-e4GY_01vegZQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 y142-20020a1c7d94000000b0030cdc76dedeso7171671wmc.5
 for <virtualization@lists.linux-foundation.org>;
 Sat, 02 Oct 2021 03:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ralEWdhrk09yJSkvlggMNWVcH3C+hpuchF+iW56D2YA=;
 b=ZuCH1t7kshWFZdIHl2SI5R+lTEp4qKA5Zo9Wiy3dzQsmjYUMBPbM8soiVzQxjyh+nM
 ahPl+URo6QI2cHQbn6sVOEBWza+5gbI3ILgjSuVcQSp66up04bxQg0im+7laGsLfY4jp
 4ZV0DbM9twRc3aIC/9bb2UKKtvaMq3fqoHE81D3IYBbG1CuL2N+mYJFjYUtWJtWyWDfy
 UphI+UYSLv2y30ZjSNWuFLJPlFROMEKMTswXDNUOPVLuyhR2cUxJwKbOusOI4l+DtSJa
 VKbMaWtotHLZY+SpJO1MTPbrCX6roiQk9DM+h40v3/5dFTBBxHO/QXP/IPaRemPGxV5z
 UmPA==
X-Gm-Message-State: AOAM531SjZlyo06CwiwcsxTi+1rOY6sCLGYmvUb+bfDH36Q7cNPU8Ke1
 IZvr+a3jH47yb0KNOjqqnzOmzE0j1FBpEELkuxeMLg8RjPmzhHHaZwqJiM/UQ92fsC6L5upQA8D
 /lNc2WwfxoEV1MC/RPs12h6YiaboQDaIDUYoGTuOgrQ==
X-Received: by 2002:adf:e309:: with SMTP id b9mr2717110wrj.81.1633170098273;
 Sat, 02 Oct 2021 03:21:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaYuniCZqgujfLZEPFmteRflgkqbcg4NLL2qSDJrEuxaqnXY86gX1bStILdbzjT4HLj8pVew==
X-Received: by 2002:adf:e309:: with SMTP id b9mr2717071wrj.81.1633170097875;
 Sat, 02 Oct 2021 03:21:37 -0700 (PDT)
Received: from redhat.com ([2.55.22.213])
 by smtp.gmail.com with ESMTPSA id e22sm599592wme.36.2021.10.02.03.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Oct 2021 03:21:36 -0700 (PDT)
Date: Sat, 2 Oct 2021 06:21:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
Message-ID: <20211002055605-mutt-send-email-mst@kernel.org>
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <20210930070444-mutt-send-email-mst@kernel.org>
 <20211001092125.64fef348.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20211001092125.64fef348.pasic@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-s390@vger.kernel.org, markver@us.ibm.com,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>
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

On Fri, Oct 01, 2021 at 09:21:25AM +0200, Halil Pasic wrote:
> On Thu, 30 Sep 2021 07:12:21 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Thu, Sep 30, 2021 at 03:20:49AM +0200, Halil Pasic wrote:
> > > This patch fixes a regression introduced by commit 82e89ea077b9
> > > ("virtio-blk: Add validation for block size in config space") and
> > > enables similar checks in verify() on big endian platforms.
> > > 
> > > The problem with checking multi-byte config fields in the verify
> > > callback, on big endian platforms, and with a possibly transitional
> > > device is the following. The verify() callback is called between
> > > config->get_features() and virtio_finalize_features(). That we have a
> > > device that offered F_VERSION_1 then we have the following options
> > > either the device is transitional, and then it has to present the legacy
> > > interface, i.e. a big endian config space until F_VERSION_1 is
> > > negotiated, or we have a non-transitional device, which makes
> > > F_VERSION_1 mandatory, and only implements the non-legacy interface and
> > > thus presents a little endian config space. Because at this point we
> > > can't know if the device is transitional or non-transitional, we can't
> > > know do we need to byte swap or not.  
> > 
> > Hmm which transport does this refer to?
> 
> It is the same with virtio-ccw and virtio-pci. I see the same problem
> with both on s390x. I didn't try with virtio-blk-pci-non-transitional
> yet (have to figure out how to do that with libvirt) for pci I used
> virtio-blk-pci.
> 
> > Distinguishing between legacy and modern drivers is transport
> > specific.  PCI presents
> > legacy and modern at separate addresses so distinguishing
> > between these two should be no trouble.
> 
> You mean the device id? Yes that is bolted down in the spec, but
> currently we don't exploit that information. Furthermore there
> is a fat chance that with QEMU even the allegedly non-transitional
> devices only present a little endian config space after VERSION_1
> was negotiated. Namely get_config for virtio-blk is implemented in
> virtio_blk_update_config() which does virtio_stl_p(vdev,
> &blkcfg.blk_size, blk_size) and in there we don't care
> about transitional or not:
> 
> static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
> {
> #if defined(LEGACY_VIRTIO_IS_BIENDIAN)
>     return virtio_is_big_endian(vdev);
> #elif defined(TARGET_WORDS_BIGENDIAN)
>     if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
>         /* Devices conforming to VIRTIO 1.0 or later are always LE. */
>         return false;
>     }
>     return true;
> #else
>     return false;
> #endif
> }
> 

ok so that's a QEMU bug. Any virtio 1.0 and up
compatible device must use LE.
It can also present a legacy config space where the
endian depends on the guest.

> > Channel i/o has versioning so same thing?
> >
> 
> Don't think so. Both a transitional and a non-transitional device
> would have to accept revisions higher than 0 if the driver tried to
> negotiate those (and we do in our case).

Yes, the modern driver does. And that one is known to be LE.
legacy driver doesn't.

> > > The virtio spec explicitly states that the driver MAY read config
> > > between reading and writing the features so saying that first accessing
> > > the config before feature negotiation is done is not an option. The
> > > specification ain't clear about setting the features multiple times
> > > before FEATURES_OK, so I guess that should be fine.
> > > 
> > > I don't consider this patch super clean, but frankly I don't think we
> > > have a ton of options. Another option that may or man not be cleaner,
> > > but is also IMHO much uglier is to figure out whether the device is
> > > transitional by rejecting _F_VERSION_1, then resetting it and proceeding
> > > according tho what we have figured out, hoping that the characteristics
> > > of the device didn't change.  
> > 
> > I am confused here. So is the problem at the device or at the driver level?
> 
> We have a driver regression. Since the 82e89ea077b9 ("virtio-blk: Add
> validation for block size in config space") virtio-blk is broken on
> s390.

Because of a qemu bug. I agree. It's worth working around in the driver
since the qemu bug has been around for a very long time.


> The deeper problem is in the spec. We stated that the driver may read
> config space before the feature negotiation is finalized, but we didn't
> think enough about what happens when native endiannes is not little
> endian in the different cases.

Because the spec is very clear that endian-ness is LE.
I don't see a spec issue yet here, just an implementation issue.

> I believe, for non-transitional devices we have a problem in the host as
> well (i.e. in QEMU).

Because QEMU ignores the spec and instead relies on the feature
negotiation.

> 
> > I suspect it's actually the host that has the issue, not
> > the guest?
> 
> I tend to say we have a problem both in the host and in the guest. I'm
> more concerned about the problem in the guest, because that is a really
> nasty regression.

The problem is in the guest. The bug is in the host ;)

> For the host. I think for legacy we don't have a
> problem, because both sides would operate on the assumption no
> _F_VERSION_1, IMHO the implementation for the transitional devices is
> correct.

Well no, the point of transitional is really to be 1.0 compliant
*and* also expose a legacy interface.

> For non-transitional flavor, it depends on the device. For
> example virtio-net and virtio-blk is broken, because we use primitives
> like virtio_stl_p() and those don't do the right thing before feature
> negotiation is completed. On the other hand virtio-crypto.c as a truly
> non-transitional device uses stl_le_p() and IMHO does the right thing.
> 
> Thanks for your comments! I hope I managed to answer your questions. I
> need some guidance on how do we want to move forward on this.
> 
> Regards,
> Halil

OK so. I don't have a problem with the patch itself,
assuming it's enough to work around all buggy hosts.
I am especially worried about things like vhost/vhost-user,
I suspect they might have a bug like this too, and
I am not sure whether your work around is enough for these.
Can you check please?

If not we'll have to move all validate code to after FEATURES_OK
is set.

We do however want to document that this API can be called
multiple times since that was not the case
previously.

Also, I would limit this to when
- the validate callback exists
- the guest endian-ness is not LE

We also want to document the QEMU bug in a comment here,
e.g. 

/*
 * QEMU before version 6.2 incorrectly uses driver features with guest
 * endian-ness to set endian-ness for config space instead of just using
 * LE for the modern interface as per spec.
 * This breaks reading config in the validate callback.
 * To work around that, when device is 1.0 (so supposed to be LE)
 * but guest is not LE, then send the features to device one extra
 * time before validation.
 */

Finally I'd like to see the QEMU bug fix before I merge this one,
since it will be harder to test with a fix.




> > 
> > 
> > > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > > Fixes: 82e89ea077b9 ("virtio-blk: Add validation for block size in config space")
> > > Reported-by: markver@us.ibm.com
> > > ---
> > >  drivers/virtio/virtio.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > index 0a5b54034d4b..9dc3cfa17b1c 100644
> > > --- a/drivers/virtio/virtio.c
> > > +++ b/drivers/virtio/virtio.c
> > > @@ -249,6 +249,10 @@ static int virtio_dev_probe(struct device *_d)
> > >  		if (device_features & (1ULL << i))
> > >  			__virtio_set_bit(dev, i);
> > >  
> > > +	/* Write back features before validate to know endianness */
> > > +	if (device_features & (1ULL << VIRTIO_F_VERSION_1))
> > > +		dev->config->finalize_features(dev);
> > > +
> > >  	if (drv->validate) {
> > >  		err = drv->validate(dev);
> > >  		if (err)
> > > 
> > > base-commit: 02d5e016800d082058b3d3b7c3ede136cdc6ddcb
> > > -- 
> > > 2.25.1  
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
