Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C93C4332F
	for <virtualization@archiver.kernel.org>; Thu, 15 Dec 2022 09:03:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 146D9418D9;
	Thu, 15 Dec 2022 09:03:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 146D9418D9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WKcxcGnD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ork7EBRdD7iN; Thu, 15 Dec 2022 09:03:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5D4F0418CD;
	Thu, 15 Dec 2022 09:03:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5D4F0418CD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F65FC0032;
	Thu, 15 Dec 2022 09:03:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 456F4C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Dec 2022 09:03:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 05A21418CD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Dec 2022 09:03:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 05A21418CD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0W_CALN3c4Ux
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Dec 2022 09:02:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0715C418CF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0715C418CF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Dec 2022 09:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671094977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uwD8NOGTwYs5ieTi5qX1aPfmwnbaS+5RWWUvD/filRE=;
 b=WKcxcGnDrRGVCmEfnImlEQ8do2JO5IuRT1xQwQuqSEYiu5e5lHk0KRpiSK2XV2P974Db0t
 1pRSs8ZWCHaZMHONfZw+G0RtErmZ+zdf/3u7zz0FPUPl/xw9lcVeMuZ/y7KEcLHyk/x6GX
 yNKRonKdic+HL+2qGIRS3V/RYvAnlvg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-460-EF9uRePKOPu0ZvaxQyVW6g-1; Thu, 15 Dec 2022 04:02:56 -0500
X-MC-Unique: EF9uRePKOPu0ZvaxQyVW6g-1
Received: by mail-wr1-f72.google.com with SMTP id
 g14-20020adfa48e000000b00241f94bcd54so498570wrb.23
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Dec 2022 01:02:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uwD8NOGTwYs5ieTi5qX1aPfmwnbaS+5RWWUvD/filRE=;
 b=jH/4BS1tvVL3L3zuw+CdKFh7xdx5ZwWzPvpqztfTw+BF1aq/TdW2qbDLH6pKB7Y4nF
 QjTcl98DqdmOuN3l97SN4m1bsNyHS0BoKgkLRMJw84zc+5CkeN8qFGu5Y3/+SNeRToc2
 Yerh/XRpKP0UXMjRm8ZH+lNLy/XZc084/gyzrpXGilwt/+44IyuIeEf5hp4CBpUGl6DJ
 ofyyhALAAHe2MEdJ5+jDf2n0tehJxj+touTlzBbz8URTwHzurQ85GGdFltTzYmbur0nl
 cnzdHVvYRP4Ku4dallplMBuaiVx8gammu8Hf8y1IHfWiSGzVTB99JULbTduE2T8kTQfh
 sN8g==
X-Gm-Message-State: ANoB5pmq4hctL8Ybcm7CbhyBIVkhPAUQW769ivSoNwREsaKUo/jgeoc5
 9Z60jsSlNf/VNOXVOSXmsv9kJ6QMjQNXAnTJOWOilVsEkiB4+G8w542eeapCTzTMNMz31htzfpE
 rwUvuZmv4z0vj/Pz0SjuNXJplLieAGKFcRmTcqHtEPA==
X-Received: by 2002:a05:6000:1290:b0:242:733b:af28 with SMTP id
 f16-20020a056000129000b00242733baf28mr22015727wrx.5.1671094975062; 
 Thu, 15 Dec 2022 01:02:55 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7qzb9+a/uvtxVcEC9zmWpJUTR422PGn73vR3sy+XJdK14+q15lG471pPpuDffznLF34RdQqg==
X-Received: by 2002:a05:6000:1290:b0:242:733b:af28 with SMTP id
 f16-20020a056000129000b00242733baf28mr22015704wrx.5.1671094974758; 
 Thu, 15 Dec 2022 01:02:54 -0800 (PST)
Received: from redhat.com ([2a02:14f:179:247f:e426:6c6e:c44d:93b])
 by smtp.gmail.com with ESMTPSA id
 x12-20020a5d650c000000b002415dd45320sm5151669wru.112.2022.12.15.01.02.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Dec 2022 01:02:54 -0800 (PST)
Date: Thu, 15 Dec 2022 04:02:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net V2] virtio-net: correctly enable callback during
 start_xmit
Message-ID: <20221215034740-mutt-send-email-mst@kernel.org>
References: <20221215032719.72294-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20221215032719.72294-1-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

On Thu, Dec 15, 2022 at 11:27:19AM +0800, Jason Wang wrote:
> Commit a7766ef18b33("virtio_net: disable cb aggressively") enables
> virtqueue callback via the following statement:
> 
>         do {
>            ......
> 	} while (use_napi && kick &&
>                unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> 
> When NAPI is used and kick is false, the callback won't be enabled
> here. And when the virtqueue is about to be full, the tx will be
> disabled, but we still don't enable tx interrupt which will cause a TX
> hang. This could be observed when using pktgen with burst enabled.
> 
> Fixing this by trying to enable tx interrupt after we disable TX when
> we're not using napi or kick is false.
> 
> Fixes: a7766ef18b33 ("virtio_net: disable cb aggressively")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> The patch is needed for -stable.
> Changes since V1:
> - enable tx interrupt after we disable tx
> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 86e52454b5b5..dcf3a536d78a 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1873,7 +1873,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	 */
>  	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
>  		netif_stop_subqueue(dev, qnum);
> -		if (!use_napi &&
> +		if ((!use_napi || !kick) &&
>  		    unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
>  			/* More just got used, free them then recheck. */
>  			free_old_xmit_skbs(sq, false);

This will work but the following lines are:

                       if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
                                netif_start_subqueue(dev, qnum);
                                virtqueue_disable_cb(sq->vq);
                        }


and I thought we are supposed to keep callbacks enabled with napi?
One of the ideas of napi is to free on napi callback, not here
immediately.

I think it is easier to just do a separate branch here. Along the
lines of:

		if (use_napi) {
			if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
				virtqueue_napi_schedule(napi, vq);
		} else {
			... old code ...
		}

also reduces chances of regressions on !napi (which is not well tested)
and keeps callbacks off while we free skbs.

No?


> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
