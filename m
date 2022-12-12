Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0731C4332F
	for <virtualization@archiver.kernel.org>; Mon, 12 Dec 2022 09:25:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6AEDD40571;
	Mon, 12 Dec 2022 09:25:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6AEDD40571
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PTcS22Oe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J0u-zXt8Rs58; Mon, 12 Dec 2022 09:25:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E4E50400F2;
	Mon, 12 Dec 2022 09:25:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E4E50400F2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF216C0033;
	Mon, 12 Dec 2022 09:25:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B602C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 09:25:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 49F0E606DC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 09:25:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 49F0E606DC
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PTcS22Oe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RLek3v4ZEu92
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 09:25:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8859460C1C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8859460C1C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 09:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670837131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0JyfgukxH8Bj5hg68NAqVbpkGDDDowiV1dBqHPtCnSU=;
 b=PTcS22OeoLpUoxtT8vsG6Hopy+44QTFAa0Uv9j2VFM5+gJnK6MjmuRkr+pxfjui/r/WvMC
 Tfq/QRkemtA0aPVzgrWvPSLudVDxnbkBVsvhAxi2+5UK7/qGzePhRb9tJ5YPaPMGqRQn5g
 VOz+BsvQ570C++Jub3qk8jU27K+VU4E=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-452-T2CI38VcPXWJVL_zjOddCw-1; Mon, 12 Dec 2022 04:25:30 -0500
X-MC-Unique: T2CI38VcPXWJVL_zjOddCw-1
Received: by mail-qk1-f198.google.com with SMTP id
 i4-20020a05620a248400b006febc1651bbso13317681qkn.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 01:25:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0JyfgukxH8Bj5hg68NAqVbpkGDDDowiV1dBqHPtCnSU=;
 b=2P0xWZF0Vu8MG2N/QlBvytAOhTZ0amlR7PfImie5jZqE8g3hjotZ8y2RPpDsg8Ixlo
 idrnXgAbeWsu/bV8++x+L5Ynpj6CxAfHIlrm8InhmR2ZnymzZHN9Z49XbMndKMku3m4N
 VeidauOmwldnwD8dEFeqFVopwLquZnXbXD4zouX5dnO28NBnHr6AVxghbZR9sYi55VnN
 iYx2/Csrt3dh0UgVg12y3S3ni50szPuvQ3FDiw3rgfQx0ac+aID24wsixAeud+XSBrVm
 uQzs6OgGFymy/Z6M8/21V+u73gEDCBvRh+97sNLONlQyNsP1haafmB/6Y4RGsMqYHlWl
 pntA==
X-Gm-Message-State: ANoB5pkCgPY4v+D8uiA9uimX+29Mh5AwJq87YQsByFaf2Bx0uRdGdmfS
 0VMgdMXO72VVvs1/9Z8zixYH1xshi/XQDaf6GuZS5diwoKW9jMZIVZIZn7ZZc4FOLumb8vc4E+O
 Mkiw6e0FotoU+JuchJ6kNs3JfYYr7LRPGXUqythoAyA==
X-Received: by 2002:a05:6214:e6c:b0:4c7:7257:68a2 with SMTP id
 jz12-20020a0562140e6c00b004c7725768a2mr28389044qvb.15.1670837129720; 
 Mon, 12 Dec 2022 01:25:29 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4lascigSsPr+SAq9gF053iSTVg49y6qJ3To4iG3pwTTJT3W+tds28QF20QeElvO/N/q72GZg==
X-Received: by 2002:a05:6214:e6c:b0:4c7:7257:68a2 with SMTP id
 jz12-20020a0562140e6c00b004c7725768a2mr28389027qvb.15.1670837129491; 
 Mon, 12 Dec 2022 01:25:29 -0800 (PST)
Received: from redhat.com ([185.199.102.21]) by smtp.gmail.com with ESMTPSA id
 bs33-20020a05620a472100b006b61b2cb1d2sm5556345qkb.46.2022.12.12.01.25.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Dec 2022 01:25:29 -0800 (PST)
Date: Mon, 12 Dec 2022 04:25:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net] virtio-net: correctly enable callback during
 start_xmit
Message-ID: <20221212042144-mutt-send-email-mst@kernel.org>
References: <20221212091029.54390-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20221212091029.54390-1-jasowang@redhat.com>
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

On Mon, Dec 12, 2022 at 05:10:29PM +0800, Jason Wang wrote:
> Commit a7766ef18b33("virtio_net: disable cb aggressively") enables
> virtqueue callback via the following statement:
> 
>         do {
>            ......
> 	} while (use_napi && kick &&
>                unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> 
> This will cause a missing call to virtqueue_enable_cb_delayed() when
> kick is false. Fixing this by removing the checking of the kick from
> the condition to make sure callback is enabled correctly.
> 
> Fixes: a7766ef18b33 ("virtio_net: disable cb aggressively")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> The patch is needed for -stable.

stable rules don't allow for theoretical fixes. Was a problem observed?

> ---
>  drivers/net/virtio_net.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 86e52454b5b5..44d7daf0267b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1834,8 +1834,8 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  		free_old_xmit_skbs(sq, false);
>  
> -	} while (use_napi && kick &&
> -	       unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> +	} while (use_napi &&
> +		 unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>

A bit more explanation pls.  kick simply means !netdev_xmit_more -
if it's false we know there will be another packet, then transmissing
that packet will invoke virtqueue_enable_cb_delayed. No?




  
>  	/* timestamp packet in software */
>  	skb_tx_timestamp(skb);
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
