Return-Path: <SRS0=0GV8=DF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77915C4727F
	for <virtualization@archiver.kernel.org>; Mon, 28 Sep 2020 19:21:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE00B2071E
	for <virtualization@archiver.kernel.org>; Mon, 28 Sep 2020 19:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VsYht/7h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE00B2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2298285691;
	Mon, 28 Sep 2020 19:21:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XfZYAD2v-SNf; Mon, 28 Sep 2020 19:21:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 863BB855F6;
	Mon, 28 Sep 2020 19:21:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DB4DC016F;
	Mon, 28 Sep 2020 19:21:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB4E9C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 19:21:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id AF33685D5C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 19:21:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ldrTTZ7QDD+R
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 19:21:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DE6E085E12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 19:21:15 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601320874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2OhlWzkl3+ngLI58gPOC/Z0lJ6eOh7uuWEoKpx328TM=;
 b=VsYht/7hbUHOU8pXF3weA9trWQ+XLTL8DNfoZN1mrmf0lUokXCTdqo9tagk/inY8dWeX2k
 kUkJyp+im0Y/Kx82xxOH1eoOIAqKpVVhEVqBsi2LphIKl+UjpFwJY0XKam7Gm4df71x+vr
 gbA9UqwscJFklZl2VtCvmqLJhoSv6cY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-oyVgrzuCOSWXhphThoiAew-1; Mon, 28 Sep 2020 15:21:12 -0400
X-MC-Unique: oyVgrzuCOSWXhphThoiAew-1
Received: by mail-wm1-f72.google.com with SMTP id a11so10950wmh.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 12:21:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2OhlWzkl3+ngLI58gPOC/Z0lJ6eOh7uuWEoKpx328TM=;
 b=askcPtw+ibaZymu+CHhc/wRnhh7xDtoBi6jPRKQ2QZoetcWx67wm2sQGImJCn1HrGI
 r8HVCFsaxFj9HSwMo5HLo806muvSjiLHfVb4VDD+nQCdhcCXWlzlDQHZRWacW6rpnZCq
 N/kGnNGjpQeu5FRlTqERy/tnAHfYBn2wJjGu2JNc511nNanbHmARLJFjGKvrjet+P8iJ
 Ay5mA52yo+DU5NcQWz3rUMdYWbPl79QB95844fK5/OzcjAKZaY/32GZOM8NC4j1ECHv5
 UcPzIyeMUCyeFIb/WyTrfcm9VT/B8x/rqGYMs4UCSyXz+a9/PJ0RC4iegcl9nN29eVet
 NTww==
X-Gm-Message-State: AOAM530eMYi2a/wBYQjlxCIkbk/Vy+TLvwE2tgfwflSZw/QGktG3cpKG
 evzvCt79iyWxcG2nPvdGrJ8GUhfBiyTDe4+DqWKZnAtqp1b0iPhYibxacwgQs9ZFUPWeXnCsXcD
 ifkdfVLXanPufCFJE+NM8r+qpexkNmwCqhqdpL02opw==
X-Received: by 2002:a5d:5306:: with SMTP id e6mr40837wrv.156.1601320871513;
 Mon, 28 Sep 2020 12:21:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7okRmYrVVUx0n6LCWLSnUOaq34NYTzgvkcsJF1a1sHoHmoT1V3VxY05bZkSpuaLhksN/TeA==
X-Received: by 2002:a5d:5306:: with SMTP id e6mr40820wrv.156.1601320871351;
 Mon, 28 Sep 2020 12:21:11 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id f6sm2551606wro.5.2020.09.28.12.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 12:21:10 -0700 (PDT)
Date: Mon, 28 Sep 2020 15:21:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: xiangxia.m.yue@gmail.com
Subject: Re: [PATCH 1/2] virtio-net: don't disable guest csum when disable LRO
Message-ID: <20200928151531-mutt-send-email-mst@kernel.org>
References: <20200928033915.82810-1-xiangxia.m.yue@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200928033915.82810-1-xiangxia.m.yue@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
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

On Mon, Sep 28, 2020 at 11:39:14AM +0800, xiangxia.m.yue@gmail.com wrote:
> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> 
> Open vSwitch and Linux bridge will disable LRO of the interface
> when this interface added to them. Now when disable the LRO, the
> virtio-net csum is disable too. That drops the forwarding performance.
> 
> Fixes: e59ff2c49ae1 ("virtio-net: disable guest csum during XDP set")

I am a bit confused by this tag. Did this change bring about
disabling checksum when LRO is disabled? I am not sure
I follow how ...

> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> ---
>  drivers/net/virtio_net.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7145c83c6c8c..21b71148c532 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -63,6 +63,11 @@ static const unsigned long guest_offloads[] = {
>  	VIRTIO_NET_F_GUEST_CSUM
>  };
>  
> +#define GUEST_OFFLOAD_LRO_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
> +				(1ULL << VIRTIO_NET_F_GUEST_TSO6) | \
> +				(1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
> +				(1ULL << VIRTIO_NET_F_GUEST_UFO))
> +
>  struct virtnet_stat_desc {
>  	char desc[ETH_GSTRING_LEN];
>  	size_t offset;
> @@ -2531,7 +2536,8 @@ static int virtnet_set_features(struct net_device *dev,
>  		if (features & NETIF_F_LRO)
>  			offloads = vi->guest_offloads_capable;
>  		else
> -			offloads = 0;
> +			offloads = vi->guest_offloads_capable &
> +				   ~GUEST_OFFLOAD_LRO_MASK;
>  
>  		err = virtnet_set_guest_offloads(vi, offloads);
>  		if (err)
> -- 
> 2.23.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
