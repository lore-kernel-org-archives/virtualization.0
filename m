Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E656FE71072
	for <virtualization@archiver.kernel.org>; Thu, 21 Sep 2023 14:16:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8062D83C2A;
	Thu, 21 Sep 2023 14:16:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8062D83C2A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Pg9fdy9c
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GvnjImqkQnyR; Thu, 21 Sep 2023 14:16:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0379783C0F;
	Thu, 21 Sep 2023 14:16:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0379783C0F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C906DC0071;
	Thu, 21 Sep 2023 14:16:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4BCA8C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 14:16:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 13F2B60B71
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 14:16:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 13F2B60B71
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Pg9fdy9c
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gqZT-WuEkgs3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 14:16:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EE67860AE6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 14:16:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EE67860AE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695305771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kw3etIssxrQ/liX7DeJiNaZoQgTiKSXZrdJc1Pm8JT0=;
 b=Pg9fdy9c1KnDG2MLFofmngUPCmdHVh7v4ME8/NQgbIuo/ZXTtrTkDy3tnNZkAvPgk9VyR9
 pEO3ccnkO46sbjoAfqkUWUgFS3twbnBrjxjKvIA8fcmNsdU8ca+DiMGAjbEg10g4JociMc
 lGPvJU7GEIVBK1oNEDrOlwF04YOv3/U=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-sC6CYwxfOAOZAhd__pA5qA-1; Thu, 21 Sep 2023 10:16:10 -0400
X-MC-Unique: sC6CYwxfOAOZAhd__pA5qA-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-532ec54cab9so688890a12.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 07:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695305769; x=1695910569;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kw3etIssxrQ/liX7DeJiNaZoQgTiKSXZrdJc1Pm8JT0=;
 b=PZibzF0Aa7zvzxzLzhcWAb0CckrXAcFC83S8QDr+dpw582PU+EHfVfjdXlXVMkX6Hy
 nJEwMjPDy5D/LBFGWnM+IICwnCkxadz3Xr4iL6fXx4dfFyvSE1qWKabYaS9hTROYFx3y
 1TesjICxbYkhhphdb8RdIUfsrUq6LNwum/JpPLZy0z/aUtPJAajl7qy8PLr0hgNmSOOn
 m8Z/bD/M8klourJViw6wBQC0bTn3hH1pFtVLbnp4ziqVVfo9GPgmxs8Q6mToo2crOxEB
 Q0l9/inZLvZeDjbSs1yWFNTjA7w1puR2U0vV7FUvYSTv/EVh/MHElLNTpnvNOW9Yx4PJ
 dBHw==
X-Gm-Message-State: AOJu0YyQBkG0RuJ3v0pDNAQJbyt7gasctkId9iKoKEX9OxMNGKbvGzqw
 ewm3eE6a1P5I0dU8+pvO0da46S946IzgsjLFTzF8CkMzhFH4dPiqsm+YV99f0mrnCyYiS11Vyvh
 cstqQNuKNK4EH9VuYcy/lPNxbB/Ar5SHz2s/5Mw6EKQ==
X-Received: by 2002:a05:6402:799:b0:532:e39b:8c05 with SMTP id
 d25-20020a056402079900b00532e39b8c05mr4331267edy.42.1695305769323; 
 Thu, 21 Sep 2023 07:16:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxzLTHbNt2ebIMAxi0oxKaUMqw3rlH/H3Y3TPwFJTbD5T4ggpvGGooE7Nirx4Fu9wkUuMjcQ==
X-Received: by 2002:a05:6402:799:b0:532:e39b:8c05 with SMTP id
 d25-20020a056402079900b00532e39b8c05mr4331243edy.42.1695305768915; 
 Thu, 21 Sep 2023 07:16:08 -0700 (PDT)
Received: from redhat.com ([2.52.150.187]) by smtp.gmail.com with ESMTPSA id
 g16-20020a056402181000b005312a2b00cbsm870624edy.63.2023.09.21.07.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 07:16:08 -0700 (PDT)
Date: Thu, 21 Sep 2023 10:16:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20230921101509-mutt-send-email-mst@kernel.org>
References: <20230921124040.145386-1-yishaih@nvidia.com>
 <20230921124040.145386-12-yishaih@nvidia.com>
 <20230921090844-mutt-send-email-mst@kernel.org>
 <20230921141125.GM13733@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230921141125.GM13733@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jiri@nvidia.com, leonro@nvidia.com
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

On Thu, Sep 21, 2023 at 11:11:25AM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 21, 2023 at 09:16:21AM -0400, Michael S. Tsirkin wrote:
> 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index bf0f54c24f81..5098418c8389 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -22624,6 +22624,12 @@ L:	kvm@vger.kernel.org
> > >  S:	Maintained
> > >  F:	drivers/vfio/pci/mlx5/
> > >  
> > > +VFIO VIRTIO PCI DRIVER
> > > +M:	Yishai Hadas <yishaih@nvidia.com>
> > > +L:	kvm@vger.kernel.org
> > > +S:	Maintained
> > > +F:	drivers/vfio/pci/virtio
> > > +
> > >  VFIO PCI DEVICE SPECIFIC DRIVERS
> > >  R:	Jason Gunthorpe <jgg@nvidia.com>
> > >  R:	Yishai Hadas <yishaih@nvidia.com>
> > 
> > Tying two subsystems together like this is going to cause pain when
> > merging. God forbid there's something e.g. virtio net specific
> > (and there's going to be for sure) - now we are talking 3
> > subsystems.
> 
> Cross subsystem stuff is normal in the kernel.

Yea. But it's completely spurious here - virtio has its own way
to work with userspace which is vdpa and let's just use that.
Keeps things nice and contained.

> Drivers should be
> placed in their most logical spot - this driver exposes a VFIO
> interface so it belongs here.
> 
> Your exact argument works the same from the VFIO perspective, someone
> has to have code that belongs to them outside their little sphere
> here.
> 
> > Case in point all other virtio drivers are nicely grouped, have a common
> > mailing list etc etc.  This one is completely separate to the point
> > where people won't even remember to copy the virtio mailing list.
> 
> The virtio mailing list should probably be added to the maintainers
> enry
> 
> Jason

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
