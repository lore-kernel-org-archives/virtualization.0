Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25762C4332F
	for <virtualization@archiver.kernel.org>; Mon, 12 Dec 2022 13:10:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 84EA14094D;
	Mon, 12 Dec 2022 13:10:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 84EA14094D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jKa5qDFd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IVJ2w_rbfKC6; Mon, 12 Dec 2022 13:10:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 88FD94098F;
	Mon, 12 Dec 2022 13:10:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 88FD94098F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B775C0032;
	Mon, 12 Dec 2022 13:10:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BAE51C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 13:10:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 960CF81327
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 13:10:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 960CF81327
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=jKa5qDFd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ISn5xTWLmrKe
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 13:10:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A6B7C81313
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A6B7C81313
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 13:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670850616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pgww3P7VivOi/FIBxfkPIAXabbHo6t9kWUrRb+E5jZY=;
 b=jKa5qDFdEFtCfbBo1EQG9BlaKtKCwpretb/hmFynvAoTzbBBTOihYTWIjWpOKG1pNwlx5g
 yPE+06HJXKj6irIJPDu7fEeiB+G+wjGNqrPeyKwmtTtRy5K6mcS9XgKONBc0rX4qBxWca+
 JXOqIAxslNeGGemddK5Pt8BJw+v+UXc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-103-MCPouN9IOJWGQ0sPWYV0-Q-1; Mon, 12 Dec 2022 08:10:15 -0500
X-MC-Unique: MCPouN9IOJWGQ0sPWYV0-Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 9-20020a1c0209000000b003d1c0a147f6so4149336wmc.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 05:10:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pgww3P7VivOi/FIBxfkPIAXabbHo6t9kWUrRb+E5jZY=;
 b=Sqmjkgv9POauvZ8T4EnQglKl3kgf70bdC2yYRiGFE3pCHAS1H0uLmMh+f1dx5z8Gv9
 +Xflwpo3+OkckoCTXGIub8fSzoC0XTwF1oE290+JcueI7Elo6NBwaWSEOt3y0NLjy5nD
 70voawgM/6l3/vr/Mrkl9earJBmElsLfmmMwq5rLTrUzyIcOD9AV4D+Gx/NLH0tXolUN
 AgSUAtq+3PY9oi8DmjD8+L1Xe8XTk5wODaB8bUU0+q6d2l2+kJVzYnMOvlE+zwLCHL1K
 R5k6TSDBfZR6mXJ2zLBqtEPP7CGAnUsfVilMaeAmN/vCoeU1iaNkl3FQrNK6kKvEuDYe
 FV2A==
X-Gm-Message-State: ANoB5pl9txWlgHbIfnk9KZNuaJuekx6gduWk0iGUvU20Z25vCz4GA4Ob
 o/5y8FupCJMXbHlzQrZuJnS0/5OjaetiZ8gPruHW1IX5cUkOhXSHHI1q99qaCWoNpnaZDZIAD/W
 OxpDlc9YQLXAue+RJEB/BQ0754lpzFnjp/4fXPKTE7A==
X-Received: by 2002:adf:f205:0:b0:24d:58b3:e55b with SMTP id
 p5-20020adff205000000b0024d58b3e55bmr5008022wro.22.1670850614239; 
 Mon, 12 Dec 2022 05:10:14 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7OWZ/ougLMGglCtagFz7TqkIUSxpgqX0sWv2cXCfzNusgn/DA3jXTHuPSG+QkujdHkMWAm2A==
X-Received: by 2002:adf:f205:0:b0:24d:58b3:e55b with SMTP id
 p5-20020adff205000000b0024d58b3e55bmr5008009wro.22.1670850614025; 
 Mon, 12 Dec 2022 05:10:14 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it.
 [87.11.6.51]) by smtp.gmail.com with ESMTPSA id
 g14-20020adffc8e000000b002421ed1d8c8sm8740554wrr.103.2022.12.12.05.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Dec 2022 05:10:13 -0800 (PST)
Date: Mon, 12 Dec 2022 14:10:08 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Carlos Llamas <cmllamas@google.com>
Subject: Re: [PATCH 1/1] virtio/vsock: Make vsock virtio packet buff size
 configurable
Message-ID: <20221212131008.aeui7ahq2jp4j33r@sgarzare-redhat>
References: <20210721143001.182009-1-lee.jones@linaro.org>
 <20210722125519.jzs7crke7yqfh73e@steredhat>
 <Y5OQ8jQsK2Dz8tPy@google.com>
MIME-Version: 1.0
In-Reply-To: <Y5OQ8jQsK2Dz8tPy@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: jiang.wang@bytedance.com, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ram Muthiah <rammuthiah@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 virtualization@lists.linux-foundation.org, Lee Jones <lee.jones@linaro.org>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Dec 09, 2022 at 07:48:02PM +0000, Carlos Llamas wrote:
>On Thu, Jul 22, 2021 at 02:55:19PM +0200, Stefano Garzarella wrote:
>> >
>> > +uint virtio_transport_max_vsock_pkt_buf_size = 1024 * 64;
>> > +module_param(virtio_transport_max_vsock_pkt_buf_size, uint, 0444);
>> > +EXPORT_SYMBOL_GPL(virtio_transport_max_vsock_pkt_buf_size);
>> > +
>
>I'm interested on this functionality, so I could take this on.

Great!
We are changing the packet handling using sk_buff [1], so I think it's 
better to rebase on that work that should be merged in net-next after 
the current merge window will close.

>
>>
>> Maybe better to add an entry under sysfs similar to what Jiang proposed
>> here:
>> https://lists.linuxfoundation.org/pipermail/virtualization/2021-June/054769.html
>
>Having a look at Jiang's RFC patch it seems the proposed sysfs node
>hangs off from the main kernel object e.g. /sys/kernel. So I wonder if
>there is a more appropriate parent for this knob?

Agree, what about /sys/devices ?
I would take a closer look at what is recommend in this case.

>
>Also, I noticed that Ram's patch here is using read-only permissions for
>the module parameter and switching to sysfs would mean opening this knob
>up to be dynamically configured? I'd need to be careful here.
>

True, but even if it's changed while we're running, I don't think it's a 
big problem.

Maybe the problem here would be the allocation of RX buffers made during 
the probe. Could this be a good reason to use a module parameter?

Thanks,
Stefano

[1] 
https://lore.kernel.org/lkml/20221202173520.10428-1-bobby.eshleman@bytedance.com/

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
