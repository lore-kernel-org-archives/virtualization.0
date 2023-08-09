Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA49EB64DD
	for <virtualization@archiver.kernel.org>; Wed,  9 Aug 2023 06:40:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F6FB417D1;
	Wed,  9 Aug 2023 06:40:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6F6FB417D1
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i0mTPqgm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PT5GNHTTeSx7; Wed,  9 Aug 2023 06:40:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C9C794177C;
	Wed,  9 Aug 2023 06:40:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C9C794177C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97435C0072;
	Wed,  9 Aug 2023 06:40:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01871C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 06:40:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D0BE160BA9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 06:40:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D0BE160BA9
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=i0mTPqgm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q3-5bFTnU1mf
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 06:40:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 77D4460B68
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 06:40:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 77D4460B68
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691563227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TJJ3jCTu6LtoeROu3S/wj01MIog+Ejx9gJ/wdAIt/q8=;
 b=i0mTPqgmUhK4wBdB7qbhgd3p205Vdi7Ew7S2sBbXw9ErWLCgS+h2kkCk3De9rsQpunSbMj
 Xzl9krO3Ucl3tZEff0M5kNaYoq4uGlkqr0p9TQ/XTJ7rp4e6Kb0ms5AkOvq5mjgNxBy2Pw
 BfOLv6dCbjW0L494VsBcezFqMSUXtds=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-pzzcJV5POI6_xJjeF0MefQ-1; Wed, 09 Aug 2023 02:40:25 -0400
X-MC-Unique: pzzcJV5POI6_xJjeF0MefQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-993d7ca4607so435667366b.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Aug 2023 23:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691563224; x=1692168024;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TJJ3jCTu6LtoeROu3S/wj01MIog+Ejx9gJ/wdAIt/q8=;
 b=F0V8jvRU7eBddbg/QWsoKtZQeVvnqYZ8A/yfifHiK6Dv/MIhVCFPd+4ryjif5zu6O1
 LicBUDDWNw85XLLPIpHrYtbts0iLliMMY1vSWDtB2IAk9Lc0OW54rJPWx3SaB6mDpQs9
 GGqwuCFo2GCPnH5zmtupgeqDQraKjJ0rwPTYaRCcDnYM/kk4/iXRtMuh2BI7c801UHhY
 hGcXNIBAJeVR4hmn7MY0htRYlXWl/VhTi2kkveqzqxvDgYA8p34sIy4DC28yYMej4XHU
 n94aHB4U1t/7KeapgIh30MUO3pGJJhm1Yq/9jcrfAQ14SmeBLtCk6kZ/Se706uJjnSuN
 Jo3Q==
X-Gm-Message-State: AOJu0Yx0BLKKYnjMofqAd/epvb0LhM7jQywlrjkEd2u85z03LDjhsVla
 ITOeuMb9lxobPsIroCfVLxkzWk/6zFnuFYu+lM4RrwK5II2pEiTOdFksDgs9sYBgZ3SwBfGbDlv
 Vxv/a/MUv9MgcSz/RJvOdFussXXA21IP3kfG20Ni12A==
X-Received: by 2002:a17:907:a073:b0:99b:5e5f:1667 with SMTP id
 ia19-20020a170907a07300b0099b5e5f1667mr1495509ejc.15.1691563224621; 
 Tue, 08 Aug 2023 23:40:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg8T51M5Yw9NGLLwVCRBOtdjLe2xwQK0NK5aYDOQNXcPWOdFN2HnOZIeRflZV1n7ejsAacOA==
X-Received: by 2002:a17:907:a073:b0:99b:5e5f:1667 with SMTP id
 ia19-20020a170907a07300b0099b5e5f1667mr1495493ejc.15.1691563224263; 
 Tue, 08 Aug 2023 23:40:24 -0700 (PDT)
Received: from redhat.com ([2.52.159.103]) by smtp.gmail.com with ESMTPSA id
 re8-20020a170906d8c800b00992076f4a01sm7594060ejb.190.2023.08.08.23.40.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 23:40:23 -0700 (PDT)
Date: Wed, 9 Aug 2023 02:40:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net] virtio-net: set queues after driver_ok
Message-ID: <20230809024013-mutt-send-email-mst@kernel.org>
References: <20230809031329.251362-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20230809031329.251362-1-jasowang@redhat.com>
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

On Tue, Aug 08, 2023 at 11:13:29PM -0400, Jason Wang wrote:
> Commit 25266128fe16 ("virtio-net: fix race between set queues and
> probe") tries to fix the race between set queues and probe by calling
> _virtnet_set_queues() before DRIVER_OK is set. This violates virtio
> spec. Fixing this by setting queues after virtio_device_ready().
> 
> Fixes: 25266128fe16 ("virtio-net: fix race between set queues and probe")
> Reported-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> The patch is needed for -stable.
> ---
>  drivers/net/virtio_net.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1270c8d23463..ff03921e46df 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4219,8 +4219,6 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	if (vi->has_rss || vi->has_rss_hash_report)
>  		virtnet_init_default_rss(vi);
>  
> -	_virtnet_set_queues(vi, vi->curr_queue_pairs);
> -
>  	/* serialize netdev register + virtio_device_ready() with ndo_open() */
>  	rtnl_lock();
>  
> @@ -4233,6 +4231,8 @@ static int virtnet_probe(struct virtio_device *vdev)
>  
>  	virtio_device_ready(vdev);
>  
> +	_virtnet_set_queues(vi, vi->curr_queue_pairs);
> +
>  	/* a random MAC address has been assigned, notify the device.
>  	 * We don't fail probe if VIRTIO_NET_F_CTRL_MAC_ADDR is not there
>  	 * because many devices work fine without getting MAC explicitly
> -- 
> 2.39.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
