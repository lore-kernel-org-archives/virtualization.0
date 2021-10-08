Return-Path: <SRS0=03hR=O4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DBDC433EF
	for <virtualization@archiver.kernel.org>; Fri,  8 Oct 2021 15:42:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D86360F6F
	for <virtualization@archiver.kernel.org>; Fri,  8 Oct 2021 15:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0D86360F6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B08D540222;
	Fri,  8 Oct 2021 15:42:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s_6Rgyo3RyJG; Fri,  8 Oct 2021 15:42:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BA125401CB;
	Fri,  8 Oct 2021 15:42:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90738C0011;
	Fri,  8 Oct 2021 15:42:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 727DCC000D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Oct 2021 15:42:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5445560ADD
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Oct 2021 15:42:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DJ2A9G2JoNBQ
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Oct 2021 15:42:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 07BB760AD5
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Oct 2021 15:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633707730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qMC5Klotg1aJNEk7elIqSRCi23Sna03uJX/agMDIgxg=;
 b=hfG3zom7+tWBYTRUDnC3e7/50qouLfw3ciRb2G5ZG0Kn38JGdJz5/rc9MTxIgLHoBcb8mo
 oRDpLvVzxVl4W+8LJ9OexglyqZc9n7xXkcb7b4HtmCOa0rcb6oDUKdGLCaBitA8KaTFizC
 e4rTYcqPJv4F8jp7yNFVg7+x8gk1w40=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-X4p4aagvOc-YpjAVOuU95w-1; Fri, 08 Oct 2021 11:42:09 -0400
X-MC-Unique: X4p4aagvOc-YpjAVOuU95w-1
Received: by mail-ed1-f69.google.com with SMTP id
 u24-20020aa7db98000000b003db57b1688aso4191006edt.6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 08 Oct 2021 08:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qMC5Klotg1aJNEk7elIqSRCi23Sna03uJX/agMDIgxg=;
 b=m6fDB2U/NQck3n8S6gI3vfmnXR1yoNFnWhCO2uBCrM+flsMke/DSdz4l3aQZqn1uRr
 J7ULnZEdyMkm+phaQl1kh3MByN9eeM7gYQFApRHNXr1+7LxerSyjnGWCSRPdNxpy4P2Q
 H7II4TcUGUKhEYd2Nib6Jp3L9AkXppcWuoWyE7Kow3RZGjnRQIY7suoMCOLg17RL3zo+
 zrKoxNV4vNWEP9sSyb1JkXkqBJFfIYFXCUdyTZM1W2hbRMumhB7oDob51QweevtlyL03
 EiRMgcLd+BFhTiHk6uA7YLhVrwyxo/T6kShOmwMP5jJpJsc8KWdu1gKDrUuQO0n6JLwl
 5ITQ==
X-Gm-Message-State: AOAM5307F0OBv/lFkGND9bEOVqPSYukND7csRZ20X7fNHAd3isYRP8mD
 3v0o8s4BPGq5+05wwMGODOdst2VaYBUcpffsKS//SHQelR3Zm6xV32t54+aVHzL/THr+X5KtvjT
 IqdyS6fTItjsQPt72ySRkTB5uomyTIxhH+eJCkgottA==
X-Received: by 2002:a50:da04:: with SMTP id z4mr15752281edj.52.1633707728430; 
 Fri, 08 Oct 2021 08:42:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHLSNoBYozNsq5483RYGKOQ6xoIu8y6Sysra7Dpoor+71RjKofWVLel+TDlQXhZNhKirsgbQ==
X-Received: by 2002:a50:da04:: with SMTP id z4mr15752226edj.52.1633707728015; 
 Fri, 08 Oct 2021 08:42:08 -0700 (PDT)
Received: from redhat.com ([2.55.132.170])
 by smtp.gmail.com with ESMTPSA id m9sm1193458edl.66.2021.10.08.08.42.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Oct 2021 08:42:07 -0700 (PDT)
Date: Fri, 8 Oct 2021 11:42:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] virtio: write back F_VERSION_1 before validate
Message-ID: <20211008113904-mutt-send-email-mst@kernel.org>
References: <20211008123422.1415577-1-pasic@linux.ibm.com>
 <20211008085839-mutt-send-email-mst@kernel.org>
 <20211008155156.626e78b5.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20211008155156.626e78b5.pasic@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-s390@vger.kernel.org, markver@us.ibm.com,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>, stefanha@redhat.com,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
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

On Fri, Oct 08, 2021 at 03:51:56PM +0200, Halil Pasic wrote:
> On Fri, 8 Oct 2021 09:05:03 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Fri, Oct 08, 2021 at 02:34:22PM +0200, Halil Pasic wrote:
> > > The virtio specification virtio-v1.1-cs01 states: "Transitional devices
> > > MUST detect Legacy drivers by detecting that VIRTIO_F_VERSION_1 has not
> > > been acknowledged by the driver."  This is exactly what QEMU as of 6.1
> > > has done relying solely on VIRTIO_F_VERSION_1 for detecting that.
> > > 
> > > However, the specification also says: "... the driver MAY read (but MUST
> > > NOT write) the device-specific configuration fields to check that it can
> > > support the device ..." before setting FEATURES_OK.
> > > 
> > > In that case, any transitional device relying solely on
> > > VIRTIO_F_VERSION_1 for detecting legacy drivers will return data in
> > > legacy format.  In particular, this implies that it is in big endian
> > > format for big endian guests. This naturally confuses the driver which
> > > expects little endian in the modern mode.
> > > 
> > > It is probably a good idea to amend the spec to clarify that
> > > VIRTIO_F_VERSION_1 can only be relied on after the feature negotiation
> > > is complete. However, we already have a regression so let's try to address  
> > 
> > actually, regressions. and we can add 
> > "since originally before validate callback existed
> > config space was only read after
> > FEATURES_OK. See Fixes tags for relevant commits"
> > 
> > > it.
> 
> How about replacing the paragraph above with the following?
> 
> "It is probably a good idea to amend the spec to clarify that
> VIRTIO_F_VERSION_1 can only be relied on after the feature negotiation
> is complete. Before validate callback existed, config space was only
> read after FEATURES_OK. However, we already have two regression,

two regressions

> so
> let's address this here as well."
> > > 
> > > The regressions affect the VIRTIO_NET_F_MTU feature of virtio-net and
> > > the VIRTIO_BLK_F_BLK_SIZE feature of virtio-blk for BE guests when
> > > virtio 1.0 is used on both sides. The latter renders virtio-blk
> > > unusable with DASD backing, because things simply don't work with
> > > the default.  
> 
> and add 
> "See Fixes tags for relevant commits."
> here.
> > 
> > Let's add a work around description now:
> > 
> > 
> > For QEMU, we can work around the issue by writing out the features
> > register with VIRTIO_F_VERSION_1 bit set.  We (ab) use the
> s/features register/feature bits/
> rationale: ccw does not have a features register, and qemu does not
> really act as if its behavior was controlled by the values in a features
> register. I.e. when we read the register we see VIRTIO_F_VERSION_!
> because the feature is offered. In QEMU we basically read host_featues
> but write the guest_features. And what drives device behavior is mostly
> guest_features. 
> 
> s/(ab) use/(ab)use/
> 
> > finalize_features config op for this. It's not enough to address vhost
> 
> s/It's/This is/
> 
> > user and vhost block devices since these do not get the features until
> 
> s/vhost user and vhost block/some vhost-user and vhost-vdpa/ ?

Let's just say "not enough to address vhost devices since some
of these etc" 

> Ratioale: I think vhost block is just a vhost-user device. On the other
> hand vhost-user-fs works like charm because the config space is
> implemented in qemu and not in the vhost-user device. I
> didn't check vhost_net. I'm not even sure qemu offers a vhost_net
> implementation.

it does

> Anyway I wouldn't like to make any false statements here.

ok

> > FEATURES_OK, however it looks like these two actually never handled the
> > endian-ness for legacy mode correctly, so at least that's not a
> > regression.
> > 
> > No devices except virtio net and virtio blk seem to be affected.
> > 
> > Long term the right thing to do is to fix the hypervisors.
> > 
> 
> Sounds good. Thanks! Are you OK with my changes proposed to your changes?
> 
> Regards,
> Halil

yes.

> > 
> > > 
> > > Cc: <stable@vger.kernel.org> #v4.11
> > > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > > Fixes: 82e89ea077b9 ("virtio-blk: Add validation for block size in
> > > config space") Fixes: fe36cbe0671e ("virtio_net: clear MTU when out
> > > of range") Reported-by: markver@us.ibm.com
> > > ---
> > >  drivers/virtio/virtio.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > > 
> > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > index 0a5b54034d4b..236081afe9a2 100644
> > > --- a/drivers/virtio/virtio.c
> > > +++ b/drivers/virtio/virtio.c
> > > @@ -239,6 +239,17 @@ static int virtio_dev_probe(struct device *_d)
> > >  		driver_features_legacy = driver_features;
> > >  	}
> > >  
> > > +	/*
> > > +	 * Some devices detect legacy solely via F_VERSION_1. Write
> > > +	 * F_VERSION_1 to force LE config space accesses before
> > > FEATURES_OK for
> > > +	 * these when needed.
> > > +	 */
> > > +	if (drv->validate && !virtio_legacy_is_little_endian()
> > > +			  && device_features &
> > > BIT_ULL(VIRTIO_F_VERSION_1)) {
> > > +		dev->features = BIT_ULL(VIRTIO_F_VERSION_1);
> > > +		dev->config->finalize_features(dev);
> > > +	}
> > > +
> > >  	if (device_features & (1ULL << VIRTIO_F_VERSION_1))
> > >  		dev->features = driver_features & device_features;
> > >  	else
> > > 
> > > base-commit: 60a9483534ed0d99090a2ee1d4bb0b8179195f51
> > > -- 
> > > 2.25.1  
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
