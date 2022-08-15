Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D90C00140
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 21:04:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C79FD81489;
	Mon, 15 Aug 2022 21:04:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C79FD81489
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C9m2HGwO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q_BGU_qcHok3; Mon, 15 Aug 2022 21:04:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4D3E381457;
	Mon, 15 Aug 2022 21:04:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4D3E381457
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0568AC0032;
	Mon, 15 Aug 2022 21:04:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF6E0C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:04:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C9BFD81471
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:04:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C9BFD81471
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MmNrYWw3cG7E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:04:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B701D81457
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B701D81457
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660597459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WXAjcjO7a1Xec1M0FgrBvJ/DZYv1/GC3KzW8DO8JMZQ=;
 b=C9m2HGwO9a6XEziS6KOzdP50gzjVrjwbVR/jHQlJhdObITUvff0VEmRxATyyNbohJW9oVN
 O8rS7c6zoQXGRUAH12QbYkQtrPWtjIkcz59FLf22evVHL7mOsG82w6+EIeTYi1ufR71VPb
 WxfkV0Yx1dgsyCT3K8m4c/2lwlH7+qw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-372-cZG28I_vOOaWSah6a6Yn8Q-1; Mon, 15 Aug 2022 17:04:16 -0400
X-MC-Unique: cZG28I_vOOaWSah6a6Yn8Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 i132-20020a1c3b8a000000b003a537064611so3993445wma.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 14:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=WXAjcjO7a1Xec1M0FgrBvJ/DZYv1/GC3KzW8DO8JMZQ=;
 b=0X0Zs3SyHCE4+aK1F5XDIsp1cf6RXTg0DW3Vo8Wp1gOq+5gtzjMuBVxzFurUli0TtX
 IN/nWKjlOcgY5NfgeUWWQOgm/LszRgB0x+9XEnCppip/VP3IJFJU+HJ9ngO3bSmFcLhD
 9BHQov1dbAyDHTwh0MLh5lNsDsPb0v4gJZR/orl3iw+t9syEG/e1zpAcOkz6DJ4deBXk
 gRvFO4GzZGhfmAH+wUfu8fxbRtfSBQEBMgwoi1pKiiKevFqQu2aSXO1errLfH0kiHc+h
 8T7p6wsnnogCMr9uSCgYyxTHWvJwkSrxgpQejBwMdzjWiQGDmNX98X0uaptCYCal5C+K
 QBsw==
X-Gm-Message-State: ACgBeo2HYKOoe0jvGgxGhZjDVRPkyip1N6qr/SpxYoNVyE44w/Y+EO9R
 Z52IppOCJLL2io6IH+xZrEe9Nl/NZ6tCmErSE5yAFgfSlw6QWRvZWn59DTaXrLhhRxxHXQKfY1X
 iE5Umu0oJU5j22WrmcseC0IQfQgMX1jHbL7AoSNvyOg==
X-Received: by 2002:a5d:6b12:0:b0:21f:1568:c7e1 with SMTP id
 v18-20020a5d6b12000000b0021f1568c7e1mr9679664wrw.532.1660597455258; 
 Mon, 15 Aug 2022 14:04:15 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7Gmr8llRM16MIbIkEtv0F723o5Cn9itzZIe2uXIUI1CVZP1QlRvrTBQuLdNU9JyUxOsISU1g==
X-Received: by 2002:a5d:6b12:0:b0:21f:1568:c7e1 with SMTP id
 v18-20020a5d6b12000000b0021f1568c7e1mr9679646wrw.532.1660597455016; 
 Mon, 15 Aug 2022 14:04:15 -0700 (PDT)
Received: from redhat.com ([2.55.43.215]) by smtp.gmail.com with ESMTPSA id
 t18-20020a5d42d2000000b0021f15514e7fsm10719060wrr.0.2022.08.15.14.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Aug 2022 14:04:14 -0700 (PDT)
Date: Mon, 15 Aug 2022 17:04:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] virtio_net: Revert "virtio_net: set the default max ring
 size by find_vqs()"
Message-ID: <20220815165608-mutt-send-email-mst@kernel.org>
References: <20220815090521.127607-1-mst@redhat.com>
 <20220815203426.GA509309@roeck-us.net>
 <20220815164013-mutt-send-email-mst@kernel.org>
 <20220815205053.GD509309@roeck-us.net>
MIME-Version: 1.0
In-Reply-To: <20220815205053.GD509309@roeck-us.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Greg KH <gregkh@linuxfoundation.org>,
 c@redhat.com, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andres Freund <andres@anarazel.de>,
 "David S. Miller" <davem@davemloft.net>
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

On Mon, Aug 15, 2022 at 01:50:53PM -0700, Guenter Roeck wrote:
> On Mon, Aug 15, 2022 at 04:42:51PM -0400, Michael S. Tsirkin wrote:
> > On Mon, Aug 15, 2022 at 01:34:26PM -0700, Guenter Roeck wrote:
> > > On Mon, Aug 15, 2022 at 05:16:50AM -0400, Michael S. Tsirkin wrote:
> > > > This reverts commit 762faee5a2678559d3dc09d95f8f2c54cd0466a7.
> > > > 
> > > > This has been reported to trip up guests on GCP (Google Cloud).  Why is
> > > > not yet clear - to be debugged, but the patch itself has several other
> > > > issues:
> > > > 
> > > > - It treats unknown speed as < 10G
> > > > - It leaves userspace no way to find out the ring size set by hypervisor
> > > > - It tests speed when link is down
> > > > - It ignores the virtio spec advice:
> > > >         Both \field{speed} and \field{duplex} can change, thus the driver
> > > >         is expected to re-read these values after receiving a
> > > >         configuration change notification.
> > > > - It is not clear the performance impact has been tested properly
> > > > 
> > > > Revert the patch for now.
> > > > 
> > > > Link: https://lore.kernel.org/r/20220814212610.GA3690074%40roeck-us.net
> > > > Link: https://lore.kernel.org/r/20220815070203.plwjx7b3cyugpdt7%40awork3.anarazel.de
> > > > Link: https://lore.kernel.org/r/3df6bb82-1951-455d-a768-e9e1513eb667%40www.fastmail.com
> > > > Link: https://lore.kernel.org/r/FCDC5DDE-3CDD-4B8A-916F-CA7D87B547CE%40anarazel.de
> > > > Fixes: 762faee5a267 ("virtio_net: set the default max ring size by find_vqs()")
> > > > Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > Cc: Jason Wang <jasowang@redhat.com>
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > Tested-by: Andres Freund <andres@anarazel.de>
> > > 
> > > I ran this patch through a total of 14 syskaller tests, 2 test runs each on
> > > 7 different crashes reported by syzkaller (as reported to the linux-kernel
> > > mailing list). No problems were reported. I also ran a single cross-check
> > > with one of the syzkaller runs on top of v6.0-rc1, without this patch.
> > > That test run failed.
> > > 
> > > Overall, I think we can call this fixed.
> > > 
> > > Guenter
> > 
> > It's more of a work around though since we don't yet have the root
> > cause for this. I suspect a GCP hypervisor bug at the moment.
> > This is excercising a path we previously only took on GFP_KERNEL
> > allocation failures during probe, I don't think that happens a lot.
> >
> 
> Even a hypervisor bug should not trigger crashes like this one,
> though, or at least I think so. Any idea what to look for on the
> hypervisor side, and/or what it might be doing wrong ?
> 
> Thanks,
> Guenter

Sure!
So virtio has a queue_size register. When read, it will give you
originally the maximum queue size. Normally we just read it and
use it as queue size.

However, when queue memory allocation fails, and unconditionally with a
network device with the problematic patch, driver is asking the
hypervisor to make the ring smaller by writing a smaller value into this
register.

I suspect that what happens is hypervisor still uses the original value
somewhere. Then it things the ring is bigger than what driver allocated.
If we get lucky and nothing important landed in the several pages
covered by the larger ting, then the only effect is that driver does not
see the data hypervisor writes in the ring, and this is the network
failures observed - most likely DHCP responses get lost and
guest never gets an IP. OTOH if something important lands there then when
hypervisor overwrites that memory it gets corrupted and we get crashes.


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
