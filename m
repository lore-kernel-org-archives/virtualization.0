Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E4D1C19F2D
	for <virtualization@archiver.kernel.org>; Thu,  4 Aug 2022 07:36:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B32D640503;
	Thu,  4 Aug 2022 07:36:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B32D640503
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NlUhqNN6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c0DjSGZfQSe3; Thu,  4 Aug 2022 07:36:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 498A140525;
	Thu,  4 Aug 2022 07:36:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 498A140525
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08ED9C0032;
	Thu,  4 Aug 2022 07:36:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25622C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 07:36:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E46A6410C4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 07:36:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E46A6410C4
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NlUhqNN6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mhfj866igFWZ
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 07:36:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D33AE403C8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D33AE403C8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 07:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659598569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3/muRkmZux4hv+ibTgAF3IB/lKVb0GckZo4ERwwvrw0=;
 b=NlUhqNN6KHptMYoYZ6vZiOWOw802dYVby3t+JaZG4beaDuIiGkLZ7kSQPPPTcytlD9LE8a
 2cgKq/fo0/w+UbFEyeWhW4KEk3i8/4UKr/nCCMll5DIaDadn5c27dSGzH58OF43RtTJpBs
 KS5YPHGdNSzOOY2GkLYcJlb72jkfsco=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-FIGsqhSWPXu1Liw8xpjSmg-1; Thu, 04 Aug 2022 03:36:06 -0400
X-MC-Unique: FIGsqhSWPXu1Liw8xpjSmg-1
Received: by mail-lj1-f198.google.com with SMTP id
 p8-20020a2e8048000000b0025e51a00a43so2740728ljg.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 04 Aug 2022 00:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3/muRkmZux4hv+ibTgAF3IB/lKVb0GckZo4ERwwvrw0=;
 b=OpC8B7rpJBHKFGbphy28h+DhYnlHWaoVXl4c3jv5u0DAUlkA+aohz+mSYQmvPIQohr
 /DyAmp8QjJScsf/eEkHH99Uuc2waARXnIjisHM3O+lWDXW2+JFwizY5JN7cM70t7jIVW
 tRLs5Ug97fPYLA91aiILik4IN/gHzxNsUP+bBCLMadWHN38DeGghzN8iUTT3qbL/k5Yx
 AQbNShm+PAvqqObd914ggzAfXWYsSMWtpegpM7Cs2L6irsi2x7XqYxRxNCLX3JvBWTQK
 DGAV/BomCeRqZ8KIqw9Y7kQ/5yFgSKbkjzQMqRRmAooDWYTuGzE96C/IUlZAgaCaTZog
 V3kw==
X-Gm-Message-State: ACgBeo3c4SQIdNM9IhB5J6BZ5kjZH5adZSMXjWFeyzIGMDPpXlXYxWXs
 YPI6LbJtBDg2EN/XRbNwNkDoUNV18orDx/GHo73EcYpo7rs2l3UymY+TjmMynnU2j85P04u25hL
 1UoRanG7VeD84Z92POkR9zo8Ouqc8wYxS6oeJ3Z6f0GyigfoD0gybirwuCA==
X-Received: by 2002:a2e:944d:0:b0:25e:6fbf:4a02 with SMTP id
 o13-20020a2e944d000000b0025e6fbf4a02mr175938ljh.323.1659598564896; 
 Thu, 04 Aug 2022 00:36:04 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4WyJkqP9zMTF5pOWPqJ+IHorwZ+JCDjdZHzX+TqrbwcI3nlP/+2xwwglAHxYjDerGDb9kg/2qog+EM2jKNg38=
X-Received: by 2002:a2e:944d:0:b0:25e:6fbf:4a02 with SMTP id
 o13-20020a2e944d000000b0025e6fbf4a02mr175928ljh.323.1659598564723; Thu, 04
 Aug 2022 00:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220804063248.104523-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20220804063248.104523-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 4 Aug 2022 15:35:53 +0800
Message-ID: <CACGkMEvDE2mBHx7BOt0c6VswwzaJ4nTfb3+MMbRE=NS90YRAvA@mail.gmail.com>
Subject: Re: [PATCH net] virtio_net: fix memory leak inside XPD_TX with
 mergeable
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 "open list:XDP \(eXpress Data Path\)" <bpf@vger.kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Thu, Aug 4, 2022 at 2:33 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> When we call xdp_convert_buff_to_frame() to get xdpf, if it returns
> NULL, we should check if xdp_page was allocated by xdp_linearize_page().
> If it is newly allocated, it should be freed here alone. Just like any
> other "goto err_xdp".
>
> Fixes: 44fa2dbd4759 ("xdp: transition into using xdp_frame for ndo_xdp_xmit")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/net/virtio_net.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index ec8e1b3108c3..3b3eebad3977 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1057,8 +1057,11 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>                 case XDP_TX:
>                         stats->xdp_tx++;
>                         xdpf = xdp_convert_buff_to_frame(&xdp);
> -                       if (unlikely(!xdpf))
> +                       if (unlikely(!xdpf)) {
> +                               if (unlikely(xdp_page != page))
> +                                       put_page(xdp_page);
>                                 goto err_xdp;
> +                       }
>                         err = virtnet_xdp_xmit(dev, 1, &xdpf, 0);
>                         if (unlikely(!err)) {
>                                 xdp_return_frame_rx_napi(xdpf);
> --
> 2.31.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
