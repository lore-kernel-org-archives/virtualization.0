Return-Path: <SRS0=LBOH=OZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75462C433F5
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 11:11:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14875611F0
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 11:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 14875611F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D573460A36;
	Tue,  5 Oct 2021 11:11:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GpFs7vhFewRu; Tue,  5 Oct 2021 11:11:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id ECB4860679;
	Tue,  5 Oct 2021 11:11:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD132C0011;
	Tue,  5 Oct 2021 11:11:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 570D8C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 11:11:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2AEBB60A36
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 11:11:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pyjYlj8HhkNl
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 11:11:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9A68160679
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 11:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633432276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NCYJPP3FFrgISDtIJT+y5O+ipNCSqP+Pcims2GkFTq8=;
 b=LJHd00GV/QtGmFrIQF8ODc6FiSG8SEO2doUHKxlAPRbeP2qAminbb7ZnHzYN6BicgTGIIV
 TCT5/aIA3tozFNsCVlh5gf2LzWvL4GRZuxe7TplAjtNegtB5QPeWeHvNMI+rDu5/0rd/6A
 xGcjfjNdUYFcpNDEL7G+VEMbRUqty2s=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-uuwOXqw8OPiW_P5lZTxbSA-1; Tue, 05 Oct 2021 07:11:13 -0400
X-MC-Unique: uuwOXqw8OPiW_P5lZTxbSA-1
Received: by mail-ed1-f70.google.com with SMTP id
 i7-20020a50d747000000b003db0225d219so3110474edj.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 05 Oct 2021 04:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NCYJPP3FFrgISDtIJT+y5O+ipNCSqP+Pcims2GkFTq8=;
 b=zKkHMGqJkFuinGPXpKSxBVkDak11CqJBLLOniADapt2ELaHhI0g6YlH7PYDFQrBjZ5
 enwwmocIDjGWevR7gkSlvH4ezlFcplOjSAkFFUOCsLN83xKkWNzeWlK2WA5py67CqA/u
 u/ooMZ76fLgx3ViDZuEoL92kycmNBQ6VFw+I/V5jDfnMlsatQN0/radSZ6b+Hv8cSvzD
 aBlKsxS1FajynXRQL3nQHEkI1UFAtsswVp2Vpw9RC4vSCrGflfd/5ajyLfgn1KkIS4u1
 Ocl8poqOgdvfH9WQwIRwZsxm2GK7FOwAopZdn4GyWN4ozpCFWJ/8D5+P3gst6fqPtPP9
 552Q==
X-Gm-Message-State: AOAM532mhGAKIFX84HmeyQPnpgGIze3YxLueLlq5qoAdblMhYBTHD+r+
 jYcS8TfKCnrPwHiO0bWB3Jt8sDR1T9gRCt9FxTdfUdHiBgFB5i5OFjkJkjoZ0aYVaJ+kibW/s1r
 wzyhz1irKue3OtwcOsjvOr07CB+RfmoIVpO7oEJe3eA==
X-Received: by 2002:a17:906:3cb:: with SMTP id
 c11mr21643990eja.404.1633432272002; 
 Tue, 05 Oct 2021 04:11:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjYUtlvxP3luzwhOKU99IsdRXObW1QTbhZlbk6Hpov3xA9zQZ39go9F2RqIHcIXuKQiE2kBA==
X-Received: by 2002:a17:906:3cb:: with SMTP id
 c11mr21643963eja.404.1633432271725; 
 Tue, 05 Oct 2021 04:11:11 -0700 (PDT)
Received: from redhat.com ([2.55.147.134])
 by smtp.gmail.com with ESMTPSA id l25sm8643295eda.36.2021.10.05.04.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Oct 2021 04:11:10 -0700 (PDT)
Date: Tue, 5 Oct 2021 07:11:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
Message-ID: <20211005064817-mutt-send-email-mst@kernel.org>
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <87r1d64dl4.fsf@redhat.com>
 <20210930130350.0cdc7c65.pasic@linux.ibm.com>
 <87ilyi47wn.fsf@redhat.com>
 <20211001162213.18d7375e.pasic@linux.ibm.com>
 <87v92g3h9l.fsf@redhat.com>
 <20211002082128-mutt-send-email-mst@kernel.org>
 <20211004042323.730c6a5e.pasic@linux.ibm.com>
 <20211004040937-mutt-send-email-mst@kernel.org>
 <20211005124303.3abf848b.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20211005124303.3abf848b.pasic@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-s390@vger.kernel.org, markver@us.ibm.com,
 Xie Yongji <xieyongji@bytedance.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, linux-kernel@vger.kernel.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, stefanha@redhat.com,
 virtualization@lists.linux-foundation.org
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

On Tue, Oct 05, 2021 at 12:43:03PM +0200, Halil Pasic wrote:
> On Mon, 4 Oct 2021 05:07:13 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Oct 04, 2021 at 04:23:23AM +0200, Halil Pasic wrote:
> > > On Sat, 2 Oct 2021 14:13:37 -0400
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >   
> > > > > Anyone else have an idea? This is a nasty regression; we could revert the
> > > > > patch, which would remove the symptoms and give us some time, but that
> > > > > doesn't really feel right, I'd do that only as a last resort.    
> > > > 
> > > > Well we have Halil's hack (except I would limit it
> > > > to only apply to BE, only do devices with validate,
> > > > and only in modern mode), and we will fix QEMU to be spec compliant.
> > > > Between these why do we need any conditional compiles?  
> > > 
> > > We don't. As I stated before, this hack is flawed because it
> > > effectively breaks fencing features by the driver with QEMU. Some
> > > features can not be unset after once set, because we tend to try to
> > > enable the corresponding functionality whenever we see a write
> > > features operation with the feature bit set, and we don't disable, if a
> > > subsequent features write operation stores the feature bit as not set.  
> > 
> > Something to fix in QEMU too, I think.
> 
> Possibly. But it is the same situation: it probably has a long
> history. And it may even make some sense. The obvious trigger for
> doing the conditional initialization for modern is the setting of
> FEATURES_OK. The problem is, legacy doesn't do FEATURES_OK. So we would
> need a different trigger.
> 
> > 
> > > But it looks like VIRTIO_1 is fine to get cleared afterwards.  
> > 
> > We'd never clear it though - why would we?
> > 
> 
> Right.
> 
> > > So my hack
> > > should actually look like posted below, modulo conditions.  
> > 
> > 
> > Looking at it some more, I see that vhost-user actually
> > does not send features to the backend until FEATURES_OK.
> 
> I.e. the hack does not work for transitional vhost-user devices,
> but it doesn't break them either.
> 
> Furthermore, I believe there is not much we can do to support
> transitional devices with vhost-user and similar, without extending
> the protocol. The transport specific detection idea would need a new
> vhost-user thingy to tell the device what has been figured
> out, right?
> 
> In theory modern only could work, if the backends were paying extra
> attention to endianness, instead of just assuming that the code is
> running little-endian.

I think a reasonable thing is to send SET_FEATURES before each
GET_CONFIG, to tell backend which format is expected.

> > However, the code in contrib for vhost-user-blk at least seems
> > broken wrt endian-ness ATM.
> 
> Agree. For example config is native endian ATM AFAICT. 
> 
> > What about other backends though?
> 
> I think whenever the config is owned and managed by the vhost-backend
> we have a problem with transitional. And we don't have everything in
> the protocol to deal with this problem.
> 
> I didn't check modern for the different vhost-user backends. I don't
> think we recommend our users on s390 to use those. My understanding
> of the use-cases is far form complete.
> 
> > Hard to be sure right?
> 
> I agree.
> 
> > Cc Raphael and Stefan so they can take a look.
> > And I guess it's time we CC'd qemu-devel too.
> > 
> > For now I am beginning to think we should either revert or just limit
> > validation to LE and think about all this some more. And I am inclining
> > to do a revert.
> 
> I'm fine with either of these as a quick fix, but we will eventually have
> to find a solution. AFAICT this solution works for the s390 setups we
> care about the most, but so would a revert.

The reason I like this one is that it also fixes MTU for virtio net,
and that one we can't really revert.


> 
> 
> > These are all hypervisors that shipped for a long time.
> > Do we need a flag for early config space access then?
> 
> You mean a feature bit? I think it is a good idea even if
> it weren't strictly necessary. We will have a behavior change
> for some devices, and I think the ability to detect those
> is valuable.
> 
> Your spec change proposal, makes it IMHO pretty clear, that
> we are changing our understanding of how transitional should work.
> Strictly, transitional is not a normative part of the spec AFAIU,
> but still...
> 
> 
> > 
> > 
> > 
> > > 
> > > Regarding the conditions I guess checking that driver_features has
> > > F_VERSION_1 already satisfies "only modern mode", or?  
> > 
> > Right.
> > 
> > > For now
> > > I've deliberately omitted the has verify and the is big endian
> > > conditions so we have a better chance to see if something breaks
> > > (i.e. the approach does not work). I can add in those extra conditions
> > > later.  
> > 
> > Or maybe if we will go down that road just the verify check (for
> > performance). I'm a bit unhappy we have the extra exit but consistency
> > seems more important.
> > 
> 
> I'm fine either way. The extra exit is only for the initialization and
> one per 1 device, I have no feeling if this has a measurable performance
> impact.
> 
> 
> > > 
> > > --------------------------8<---------------------
> > > 
> > > From: Halil Pasic <pasic@linux.ibm.com>
> > > Date: Thu, 30 Sep 2021 02:38:47 +0200
> > > Subject: [PATCH] virtio: write back feature VERSION_1 before verify
> > > 
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
> > Well we established that we can know. Here's an alternative explanation:
> 
> 
> I thin we established how this should be in the future, where a transport
> specific mechanism is used to decide are we operating in legacy mode or
> in modern mode. But with the current QEMU reality, I don't think so.
> Namely currently the switch native-endian config -> little endian config
> happens when the VERSION_1 is negotiated, which may happen whenever
> the VERSION_1 bit is changed, or only when FEATURES_OK is set
> (vhost-user).
> 
> This is consistent with device should detect a legacy driver by checking
> for VERSION_1, which is what the spec currently says.
> 
> So for transitional we start out with native-endian config. For modern
> only the config is always LE.
> 
> The guest can distinguish between a legacy only device and a modern
> capable device after the revision negotiation. A legacy device would
> reject the CCW.
> 
> But both a transitional device and a modern only device would accept
> a revision > 0. So the guest does not know for ccw.
> 


Sorry I was talking about the host not the guest.
when host sees revision > 0 it knows it's a modern guest
and so config should be LE.

> 
> > 
> > 	The virtio specification virtio-v1.1-cs01 states:
> > 
> > 	Transitional devices MUST detect Legacy drivers by detecting that
> > 	VIRTIO_F_VERSION_1 has not been acknowledged by the driver.
> > 	This is exactly what QEMU as of 6.1 has done relying solely
> > 	on VIRTIO_F_VERSION_1 for detecting that.
> > 
> > 	However, the specification also says:
> > 	driver MAY read (but MUST NOT write) the device-specific
> > 	configuration fields to check that it can support the device before
> > 	accepting it.
> 
> s/ accepting it/setting FEATURES_OK
> > 
> > 	In that case, any device relying solely on VIRTIO_F_VERSION_1
> 
> s/any device/any transitional device/
> 
> > 	for detecting legacy drivers will return data in legacy format.
> 
> E.g. virtio-crypto does not support legacy, and thus it is always
> providing an LE config space.
> 
> > 	In particular, this implies that it is in big endian format
> > 	for big endian guests. This naturally confuses the driver
> > 	which expects little endian in the modern mode.
> > 
> > 	It is probably a good idea to amend the spec to clarify that
> > 	VIRTIO_F_VERSION_1 can only be relied on after the feature negotiation
> > 	is complete. However, we already have regression so let's
> > 	try to address it.
> > 
> > 
> 
> I can take the new description without any changes if you like.
> I care
> more about getting a decent fix, than a perfect patch description. Should
> I send out a non-RFC with that implements the proposed changes?

Also add a shortened version to the code comment pls.

> 
> > > 
> > > The virtio spec explicitly states that the driver MAY read config
> > > between reading and writing the features so saying that first accessing
> > > the config before feature negotiation is done is not an option. The
> > > specification ain't clear about setting the features multiple times
> > > before FEATURES_OK, so I guess that should be fine to set F_VERSION_1
> > > since at this point we already know that we are about to negotiate
> > > F_VERSION_1.
> > > 
> > > I don't consider this patch super clean, but frankly I don't think we
> > > have a ton of options. Another option that may or man not be cleaner,
> > > but is also IMHO much uglier is to figure out whether the device is
> > > transitional by rejecting _F_VERSION_1, then resetting it and proceeding
> > > according tho what we have figured out, hoping that the characteristics
> > > of the device didn't change.  
> > 
> > An empty line before tags.
> >
> 
> Sure!
>  
> > > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > > Fixes: 82e89ea077b9 ("virtio-blk: Add validation for block size in config space")
> > > Reported-by: markver@us.ibm.com  
> > 
> > Let's add more commits that are affected. E.g. virtio-net with MTU
> > feature bit set is affected too.
> > 
> > So let's add Fixes tag for:
> > commit 14de9d114a82a564b94388c95af79a701dc93134
> > Author: Aaron Conole <aconole@redhat.com>
> > Date:   Fri Jun 3 16:57:12 2016 -0400
> > 
> >     virtio-net: Add initial MTU advice feature
> >     
> 
> I believe  drv->probe(dev) is called after the real finalize, so
> that access should be fine or?
> 
> Don't we just have to look out for verify?

you mean validate.


> Isn't the problematic commit fe36cbe0671e ("virtio_net: clear MTU when
> out of range")?

exactly.

> The problem with commit 14de9d114a82a is that the device won't know,
> the driver didn't take the advice (for the MTU because it deemed its
> value invalid). But that doesn't really hurt us.
> On the other hand with fe36cbe0671e we may deem a valid MTU in the
> config space invalid because of the endiannes mess-up. I that case
> we would discard a perfectly good MTU advice.

right.

> 
> > I think that's all, but pls double check me.
> 
> 
> Looks good!
> $ git grep -e '\.validate' -- '*virtio*'
> drivers/block/virtio_blk.c:     .validate                       = virtblk_validate,
> drivers/firmware/arm_scmi/virtio.c:     .validate = scmi_vio_validate,
> drivers/net/virtio_net.c:       .validate =     virtnet_validate,
> drivers/virtio/virtio_balloon.c:        .validate =     virtballoon_validate,
> sound/virtio/virtio_card.c:     .validate = virtsnd_validate,
> 
> But only blk and net access config space from validate.
> 
> > 
> > 
> > > ---
> > >  drivers/virtio/virtio.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > index 0a5b54034d4b..2b9358f2e22a 100644
> > > --- a/drivers/virtio/virtio.c
> > > +++ b/drivers/virtio/virtio.c
> > > @@ -239,6 +239,12 @@ static int virtio_dev_probe(struct device *_d)
> > >  		driver_features_legacy = driver_features;
> > >  	}
> > >  
> > > +	/* Write F_VERSION_1 feature to pin down endianness */
> > > +	if (device_features & (1ULL << VIRTIO_F_VERSION_1) & driver_features) {
> > > +		dev->features = (1ULL << VIRTIO_F_VERSION_1);
> > > +		dev->config->finalize_features(dev);
> > > +	}
> > > +
> > >  	if (device_features & (1ULL << VIRTIO_F_VERSION_1))
> > >  		dev->features = driver_features & device_features;
> > >  	else
> > > -- 
> > > 2.31.1
> > > 
> > > 
> > > 
> > > 
> > > 
> > >    
> > 
> > _______________________________________________
> > Virtualization mailing list
> > Virtualization@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/virtualization

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
