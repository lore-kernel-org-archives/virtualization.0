Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E7BE71094
	for <virtualization@archiver.kernel.org>; Thu, 21 Sep 2023 16:53:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 358194012F;
	Thu, 21 Sep 2023 16:53:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 358194012F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ifaQ38Yh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e_1nwkd8U6cT; Thu, 21 Sep 2023 16:53:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5C69A4012C;
	Thu, 21 Sep 2023 16:53:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5C69A4012C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31DDAC0071;
	Thu, 21 Sep 2023 16:53:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9F77C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 16:53:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 70F9C60B74
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 16:53:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 70F9C60B74
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ifaQ38Yh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FXzTon7lD_At
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 16:53:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 105DE608B7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 16:53:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 105DE608B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695315193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dTY51miggRdWE++wgWPSa631sVV6TNDOXdpfXXaCrio=;
 b=ifaQ38Yhe3ZUA23Yvq207m1ac4Mps+y+9UZQpWNI9ZQRjcuox6OFr81pb6XYU3f8LOJpVE
 Ttjp3MFzJhY157/v07rutZqxUr5zsto/0MtcT591bjNRJLSXoziC/fDIvGFY6uVi4HJILc
 WT1VIfd/RXkQ12wp/P8WaHkENYnpRqo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-i7OfK3A9N-qLfYDyRqAUEw-1; Thu, 21 Sep 2023 12:53:10 -0400
X-MC-Unique: i7OfK3A9N-qLfYDyRqAUEw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-993eeb3a950so91464666b.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 09:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695315189; x=1695919989;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dTY51miggRdWE++wgWPSa631sVV6TNDOXdpfXXaCrio=;
 b=PZIb7pW+J7XwmjSZjLjHOhkOazVTgEKPb95BVxyXltcx6DX5yMJdsJqgcSz6T2OuVt
 VIwYY8UtMmSa86xgwjXinb14gKDmvBGg88BfLMamUNQGcPPmraNTKMol02J+K+god9ft
 Kp9DTkI+XaCPoUwBEIlmDAqwN7lQ7jfi6CL0HZPy99orxje5P8KdS1J55vBzTFk9NHWN
 IyfcUjZiLqLEbKEawAHMT9JbGehUksqFFPKLZsZ5EVwysT/nRyf0AYOLzty79RGIJBkc
 uzkS9e8nGv6tV4ye0uC+WJQWYZAdOsWAKr6/bAnpcleokT6/58kv9XPmj95yYlK1Wo9u
 2lRA==
X-Gm-Message-State: AOJu0YzEDEOQv+3t3fOjqnxyZT/w0lcUUgaNZtHs547QKvjeT6DqjooS
 kz9mSe9MMeqhD7/0nNx/mc+I4rLHbHZxGdF/gL01933kZZS3KcWrz15QPBDj0pZ8b88VjPF7QO/
 aIil+ajXEPi1VNwqN8jITiAM/Sky8pIbz787lVbjofA==
X-Received: by 2002:a17:906:2096:b0:9ae:1de:f4fb with SMTP id
 22-20020a170906209600b009ae01def4fbmr4943109ejq.46.1695315189578; 
 Thu, 21 Sep 2023 09:53:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkuLbe2i4Ae15AXKkkLrs7IbEfMsz8AYs1syIIGDGmJjEOv+8QQvZkGaXHkm+zKICx2kVaNA==
X-Received: by 2002:a17:906:2096:b0:9ae:1de:f4fb with SMTP id
 22-20020a170906209600b009ae01def4fbmr4943100ejq.46.1695315189205; 
 Thu, 21 Sep 2023 09:53:09 -0700 (PDT)
Received: from redhat.com ([2.52.150.187]) by smtp.gmail.com with ESMTPSA id
 h1-20020a1709063c0100b0099bc038eb2bsm1304274ejg.58.2023.09.21.09.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 09:53:08 -0700 (PDT)
Date: Thu, 21 Sep 2023 12:53:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20230921124331-mutt-send-email-mst@kernel.org>
References: <20230921124040.145386-1-yishaih@nvidia.com>
 <20230921124040.145386-12-yishaih@nvidia.com>
 <20230921090844-mutt-send-email-mst@kernel.org>
 <20230921141125.GM13733@nvidia.com>
 <20230921101509-mutt-send-email-mst@kernel.org>
 <20230921164139.GP13733@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230921164139.GP13733@nvidia.com>
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

On Thu, Sep 21, 2023 at 01:41:39PM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 21, 2023 at 10:16:04AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Sep 21, 2023 at 11:11:25AM -0300, Jason Gunthorpe wrote:
> > > On Thu, Sep 21, 2023 at 09:16:21AM -0400, Michael S. Tsirkin wrote:
> > > 
> > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > index bf0f54c24f81..5098418c8389 100644
> > > > > --- a/MAINTAINERS
> > > > > +++ b/MAINTAINERS
> > > > > @@ -22624,6 +22624,12 @@ L:	kvm@vger.kernel.org
> > > > >  S:	Maintained
> > > > >  F:	drivers/vfio/pci/mlx5/
> > > > >  
> > > > > +VFIO VIRTIO PCI DRIVER
> > > > > +M:	Yishai Hadas <yishaih@nvidia.com>
> > > > > +L:	kvm@vger.kernel.org
> > > > > +S:	Maintained
> > > > > +F:	drivers/vfio/pci/virtio
> > > > > +
> > > > >  VFIO PCI DEVICE SPECIFIC DRIVERS
> > > > >  R:	Jason Gunthorpe <jgg@nvidia.com>
> > > > >  R:	Yishai Hadas <yishaih@nvidia.com>
> > > > 
> > > > Tying two subsystems together like this is going to cause pain when
> > > > merging. God forbid there's something e.g. virtio net specific
> > > > (and there's going to be for sure) - now we are talking 3
> > > > subsystems.
> > > 
> > > Cross subsystem stuff is normal in the kernel.
> > 
> > Yea. But it's completely spurious here - virtio has its own way
> > to work with userspace which is vdpa and let's just use that.
> > Keeps things nice and contained.
> 
> vdpa is not vfio, I don't know how you can suggest vdpa is a
> replacement for a vfio driver. They are completely different
> things.
> Each side has its own strengths, and vfio especially is accelerating
> in its capability in way that vpda is not. eg if an iommufd conversion
> had been done by now for vdpa I might be more sympathetic.

Yea, I agree iommufd is a big problem with vdpa right now. Cindy was
sick and I didn't know and kept assuming she's working on this. I don't
think it's a huge amount of work though.  I'll take a look.
Is there anything else though? Do tell.

> Asking for
> someone else to do a huge amount of pointless work to improve vdpa
> just to level of this vfio driver already is at is ridiculous.
> 
> vdpa is great for certain kinds of HW, let it focus on that, don't try
> to paint it as an alternative to vfio. It isn't.
> 
> Jason

There are a bunch of things that I think are important for virtio
that are completely out of scope for vfio, such as migrating
cross-vendor. What is the huge amount of work am I asking to do?



-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
