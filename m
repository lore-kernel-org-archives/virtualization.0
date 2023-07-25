Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831D7C0015E
	for <virtualization@archiver.kernel.org>; Tue, 25 Jul 2023 07:53:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0952B4023F;
	Tue, 25 Jul 2023 07:53:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0952B4023F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jFlc5Bqg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EllvFr1ekv0N; Tue, 25 Jul 2023 07:53:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 94DEA400D2;
	Tue, 25 Jul 2023 07:53:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 94DEA400D2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6986AC0071;
	Tue, 25 Jul 2023 07:53:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0660C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 07:53:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 85E2160AD0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 07:53:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 85E2160AD0
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=jFlc5Bqg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aC0U9APyurRE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 07:53:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C218E608A6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 07:53:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C218E608A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690271598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PWQd09CkgUEL/rfURKCBaafhE1vCc8Dv/cUNXDFlRRE=;
 b=jFlc5Bqgim/9qeYk8f48il32tzN5bMQWh9527XfiWZLGm87raYMWmccciwk+XYzUwV1FtZ
 dZ1jg6PgkX25+egbUsPF9NP4JU//qYVELR/FJ963Vj/SM/WMZ4m0yRApNAFdMQosmr/Rb3
 5MHH1qSkH+qtdXAEiwq7yGYyUrsCYlY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-tjbWcSMWM4GB0znY8PmQTQ-1; Tue, 25 Jul 2023 03:53:14 -0400
X-MC-Unique: tjbWcSMWM4GB0znY8PmQTQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-52231fa854aso1195653a12.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 00:53:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690271593; x=1690876393;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PWQd09CkgUEL/rfURKCBaafhE1vCc8Dv/cUNXDFlRRE=;
 b=cj5MNa88jVnUi81QCOkL+Axv1240inxxxXiB1z32f8OEJf1n0A1aKZFEUPm6tkh/hY
 RH4JYiaVeIn1EcxOCokDt9vwhrSRm2y9Pqn3FnYbz8F1C0s2KPilsEPQQXk6Vi/fJM3B
 uwkeXuwRD7T+ZclvG2lxlBtkgU6VZN3d6M/pC12RGN2YnXCeKnmEdAjlgh4j9v/As9LO
 jc+0OueD7VpvuFUHmvl6a63Yo3B3irCwucULGRLzFQX7fiNT7sHbujwh1HwIc2laTE9+
 /HK8uS42H0wZiVtwhqauEeYgmy562Opo4WphgOpT3aYCjqKjHF0Ww2eExtF9FzTnMuBw
 wytg==
X-Gm-Message-State: ABy/qLZ/hYKCr8l5fwBLvoh8slWzciPTKsM26Kd1Yo/hVAb9anZfrpbB
 pq3jHkjYusxk0Vte/7ySfdi32CpqRJ+BZO05mj+Un/Jhew2yq6gHfnz7afaIOd51o3n0uBSTTuG
 XH7RQeUlrvdykxu1qjxnzBSA3kH2k+iX5WAcArglQDg==
X-Received: by 2002:a05:6402:b11:b0:51d:e2c4:f94a with SMTP id
 bm17-20020a0564020b1100b0051de2c4f94amr10599768edb.20.1690271593632; 
 Tue, 25 Jul 2023 00:53:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGMsygKA53ZagpKmLPph+kYwIqwDrCuyagGjgnUA/UfkItMnc3GeQVj+FzWHvPMnAT7Zuyh3w==
X-Received: by 2002:a05:6402:b11:b0:51d:e2c4:f94a with SMTP id
 bm17-20020a0564020b1100b0051de2c4f94amr10599757edb.20.1690271593305; 
 Tue, 25 Jul 2023 00:53:13 -0700 (PDT)
Received: from redhat.com ([2.55.164.187]) by smtp.gmail.com with ESMTPSA id
 g1-20020aa7c841000000b0051e576dbb57sm7165932edt.61.2023.07.25.00.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 00:53:12 -0700 (PDT)
Date: Tue, 25 Jul 2023 03:53:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net] virtio-net: fix race between set queues and probe
Message-ID: <20230725035120-mutt-send-email-mst@kernel.org>
References: <20230725072049.617289-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20230725072049.617289-1-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
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

On Tue, Jul 25, 2023 at 03:20:49AM -0400, Jason Wang wrote:
> A race were found where set_channels could be called after registering
> but before virtnet_set_queues() in virtnet_probe(). Fixing this by
> moving the virtnet_set_queues() before netdevice registering. While at
> it, use _virtnet_set_queues() to avoid holding rtnl as the device is
> not even registered at that time.
> 
> Fixes: a220871be66f ("virtio-net: correctly enable multiqueue")
> Signed-off-by: Jason Wang <jasowang@redhat.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

stable material I guess?

> ---
>  drivers/net/virtio_net.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0db14f6b87d3..1270c8d23463 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4219,6 +4219,8 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	if (vi->has_rss || vi->has_rss_hash_report)
>  		virtnet_init_default_rss(vi);
>  
> +	_virtnet_set_queues(vi, vi->curr_queue_pairs);
> +
>  	/* serialize netdev register + virtio_device_ready() with ndo_open() */
>  	rtnl_lock();
>  
> @@ -4257,8 +4259,6 @@ static int virtnet_probe(struct virtio_device *vdev)
>  		goto free_unregister_netdev;
>  	}
>  
> -	virtnet_set_queues(vi, vi->curr_queue_pairs);
> -
>  	/* Assume link up if device can't report link status,
>  	   otherwise get link status from config. */
>  	netif_carrier_off(dev);
> -- 
> 2.39.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
