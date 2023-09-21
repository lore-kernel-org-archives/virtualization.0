Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D71E7D0A2
	for <virtualization@archiver.kernel.org>; Thu, 21 Sep 2023 20:55:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5318942129;
	Thu, 21 Sep 2023 20:55:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5318942129
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KBUPuVtn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pP_jFyzcCGMk; Thu, 21 Sep 2023 20:55:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 75F9842012;
	Thu, 21 Sep 2023 20:55:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 75F9842012
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4BA10C0071;
	Thu, 21 Sep 2023 20:55:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E86DC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 20:55:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 157BF613D7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 20:55:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 157BF613D7
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KBUPuVtn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sOkwK3emoZIo
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 20:55:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 54D5160BBD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 20:55:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 54D5160BBD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695329713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x2GFnQYMs7RLu1Nka2/IBYuhXJchf/y41F4WyNwuFGY=;
 b=KBUPuVtnB4KQKz1I5RUUesOxb40qW+mGTxWtBDUE+cQupqJXTI2ZJOk9nvk/t3APY9C0JD
 8CRQ5zIbdECcCGXz2YiW36FoU5QRaaxhEBS47Myqk+yQu+7hu0s6mRGL0KrbzO3Gk+G7b0
 xr6eZhHwEhDBAxPFuiwBTdVa6400z2A=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-sHhCQm_PPam-3winygzwHw-1; Thu, 21 Sep 2023 16:55:11 -0400
X-MC-Unique: sHhCQm_PPam-3winygzwHw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-532e56aa8f1so970695a12.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 13:55:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695329710; x=1695934510;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x2GFnQYMs7RLu1Nka2/IBYuhXJchf/y41F4WyNwuFGY=;
 b=almbnUlBeD+7SYKhU3izR6Cwic2H4j63+oYG8No2/TDa5R9c4tafuYugKMi0z+OGHl
 mYpTd4M2jFOZ1GWQidW6UxVIpgfNuJmLsWJtqH/MBQAfe9e0GwXfmriAkASerBHxC+Gg
 0OXqAqJaVyUio4rO+ycl6fKjWZRr8zCAy+lfHJf/QMrtcCcn6JeLj3PwdQF5rNm1GvBa
 t1fJ2SdrMShdGuHkF9XTYSvNLkJPxxXJU4NzuzO3FjR37eaI0jbzyzVjF4PM+ihrJMV4
 xG09fiFq9iWy5si8Mg/LBnJxHGujaVw+Crw+sExMZzNhW3GyXw1y9wwVDiNaTFCVYHdb
 ttjw==
X-Gm-Message-State: AOJu0YwSEj80SwScsspWWRak+dUvibJhRQtiu6OlGi5M64rX9cOw+qXS
 d972XNIJv0EEWkhWagpE4OTayqlu1CWVlQ8dc+FoFk+2QtmxasuvDbFKXYab1e10+ePc/mjn7w5
 Eaj1ZIr/3AyfZ8EYAUSIW8xcfmLmfGEqVP13grqbYgg==
X-Received: by 2002:a17:906:cc9:b0:9a1:bee8:9252 with SMTP id
 l9-20020a1709060cc900b009a1bee89252mr5499467ejh.29.1695329710699; 
 Thu, 21 Sep 2023 13:55:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJ+gjiY2qKz49SqOzH96PvcDQ//acHYSyEsL/nahBhRDrFSrox1rM/f0uOn3wusa63GltzDg==
X-Received: by 2002:a17:906:cc9:b0:9a1:bee8:9252 with SMTP id
 l9-20020a1709060cc900b009a1bee89252mr5499456ejh.29.1695329710343; 
 Thu, 21 Sep 2023 13:55:10 -0700 (PDT)
Received: from redhat.com ([2.52.150.187]) by smtp.gmail.com with ESMTPSA id
 ce21-20020a170906b25500b009ad850d4760sm1555657ejb.219.2023.09.21.13.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 13:55:09 -0700 (PDT)
Date: Thu, 21 Sep 2023 16:55:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20230921164558-mutt-send-email-mst@kernel.org>
References: <20230921124040.145386-1-yishaih@nvidia.com>
 <20230921124040.145386-12-yishaih@nvidia.com>
 <20230921090844-mutt-send-email-mst@kernel.org>
 <20230921141125.GM13733@nvidia.com>
 <20230921101509-mutt-send-email-mst@kernel.org>
 <20230921164139.GP13733@nvidia.com>
 <20230921124331-mutt-send-email-mst@kernel.org>
 <20230921183926.GV13733@nvidia.com>
 <20230921151325-mutt-send-email-mst@kernel.org>
 <20230921195115.GY13733@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230921195115.GY13733@nvidia.com>
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

On Thu, Sep 21, 2023 at 04:51:15PM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 21, 2023 at 03:17:25PM -0400, Michael S. Tsirkin wrote:
> > On Thu, Sep 21, 2023 at 03:39:26PM -0300, Jason Gunthorpe wrote:
> > > > What is the huge amount of work am I asking to do?
> > > 
> > > You are asking us to invest in the complexity of VDPA through out
> > > (keep it working, keep it secure, invest time in deploying and
> > > debugging in the field)
> > 
> > I'm asking you to do nothing of the kind - I am saying that this code
> > will have to be duplicated in vdpa,
> 
> Why would that be needed?

For the same reason it was developed in the 1st place - presumably
because it adds efficient legacy guest support with the right card?
I get it, you specifically don't need VDPA functionality, but I don't
see why is this universal, or common.


> > and so I am asking what exactly is missing to just keep it all
> > there.
> 
> VFIO. Seriously, we don't want unnecessary mediation in this path at
> all.

But which mediation is necessary is exactly up to the specific use-case.
I have no idea why would you want all of VFIO to e.g. pass access to
random config registers to the guest when it's a virtio device and the
config registers are all nicely listed in the spec. I know nvidia
hardware is so great, it has super robust cards with less security holes
than the vdpa driver, but I very much doubt this is universal for all
virtio offload cards.

> > note I didn't ask you to add iommufd to vdpa though that would be
> > nice ;)
> 
> I did once send someone to look.. It didn't succeed :(
> 
> Jason

Pity. Maybe there's some big difficulty blocking this? I'd like to know.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
