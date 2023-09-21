Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A05E4E71094
	for <virtualization@archiver.kernel.org>; Thu, 21 Sep 2023 17:01:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F39B82032;
	Thu, 21 Sep 2023 17:01:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2F39B82032
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q2xN+SZL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R5I3Et8vzbr8; Thu, 21 Sep 2023 17:01:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A480C8214B;
	Thu, 21 Sep 2023 17:01:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A480C8214B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 841B9C0071;
	Thu, 21 Sep 2023 17:01:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A363C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 17:01:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 06E2060D4C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 17:01:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 06E2060D4C
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q2xN+SZL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZEEkmwIw4f94
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 17:01:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3D17C606A0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 17:01:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3D17C606A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695315682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eXLjSJIMRxcWvPfwsAym08vPACVukQQjMlk91zESb4A=;
 b=Q2xN+SZLffP8rTDfFxY5TkaZT7Q5QFZofWuZn+SsmQOq+AzLHM2lH9LWzRr6s9lZGxHlCY
 yQbQ3rWYzZcpW4ZgYKNMjfk5bDICxE7FKw4kSDkrb9ZUSBFdYICxVt2LAUGhaDUrDETuDU
 zaQks3qhSQCbx7Hbnk465vXGz4meQXY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-04xZzqAIP2qw47aQlTR15g-1; Thu, 21 Sep 2023 13:01:18 -0400
X-MC-Unique: 04xZzqAIP2qw47aQlTR15g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40309efe8b1so8905185e9.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 10:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695315677; x=1695920477;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eXLjSJIMRxcWvPfwsAym08vPACVukQQjMlk91zESb4A=;
 b=oOpK3P1Apd1IvYN8qPhUs+yvCDQSdJA7A6P451gXqkZqfrwY3gtlrdiAdAOx8PkCob
 RkWlB8p2br2q3ZtrM7+9YlL1hDKRZULsN7nXOp5mM830wrR9UGlV7XgXoHXyigtQyEXq
 cigcqNp/QFghHSK7Dp/ZONVMwwx7LbMWc0tDqCjt9aOIU8tvYGbKOgGajeAaatUITNRs
 4rWLVq24aaw2BItXLLfpDVpLcQtdH1O316LvyYqv3WoYW8j8CqeT4do0GDIwXPszS4hl
 TfToJBHoxICoSLtKDitbDHhBJ6GjVx3Y9BZZUvmOW1Du5I859HZS6nEW/9JHBA9lq8Rd
 OSzA==
X-Gm-Message-State: AOJu0YywHknZeSh/vRS65fyjKyyIURWBtOUBe96ptXfsFgy5yRrOEk0M
 CIHVS8fqUfYFIN1qrkgUYNUIRpotdmeDqa9SSNstgDZrFncxRjJ5ymdmASXGh5CZFgX4Y67fl1I
 Hu7Dc9vYj6ZOvMyJTM0AWHaN7yDTiEhFLSVg5yQ9o4A==
X-Received: by 2002:a5d:4002:0:b0:31f:fa38:425f with SMTP id
 n2-20020a5d4002000000b0031ffa38425fmr6223634wrp.9.1695315676887; 
 Thu, 21 Sep 2023 10:01:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZwr2zrzHEqGG+dt5nELJ8fK8Zh8B8fa0c6Q4DwZ9VFKGUV6CPz1ZEPZrn4R+cr3pruDWXcQ==
X-Received: by 2002:a5d:4002:0:b0:31f:fa38:425f with SMTP id
 n2-20020a5d4002000000b0031ffa38425fmr6223610wrp.9.1695315676542; 
 Thu, 21 Sep 2023 10:01:16 -0700 (PDT)
Received: from redhat.com ([2.52.150.187]) by smtp.gmail.com with ESMTPSA id
 bg1-20020a170906a04100b009adce1c97ccsm1330409ejb.53.2023.09.21.10.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 10:01:15 -0700 (PDT)
Date: Thu, 21 Sep 2023 13:01:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20230921125348-mutt-send-email-mst@kernel.org>
References: <20230921124040.145386-1-yishaih@nvidia.com>
 <20230921124040.145386-12-yishaih@nvidia.com>
 <20230921104350.6bb003ff.alex.williamson@redhat.com>
 <20230921165224.GR13733@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230921165224.GR13733@nvidia.com>
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

On Thu, Sep 21, 2023 at 01:52:24PM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 21, 2023 at 10:43:50AM -0600, Alex Williamson wrote:
> 
> > > With that code in place a legacy driver in the guest has the look and
> > > feel as if having a transitional device with legacy support for both its
> > > control and data path flows.
> > 
> > Why do we need to enable a "legacy" driver in the guest?  The very name
> > suggests there's an alternative driver that perhaps doesn't require
> > this I/O BAR.  Why don't we just require the non-legacy driver in the
> > guest rather than increase our maintenance burden?  Thanks,
> 
> It was my reaction also.
> 
> Apparently there is a big deployed base of people using old guest VMs
> with old drivers and they do not want to update their VMs. It is the
> same basic reason why qemu supports all those weird old machine types
> and HW emulations. The desire is to support these old devices so that
> old VMs can work unchanged.
> 
> Jason

And you are saying all these very old VMs use such a large number of
legacy devices that over-counting of locked memory due to vdpa not
correctly using iommufd is a problem that urgently needs to be solved
otherwise the solution has no value?

Another question I'm interested in is whether there's actually a
performance benefit to using this as compared to just software
vhost. I note there's a VM exit on each IO access, so ... perhaps?
Would be nice to see some numbers.


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
