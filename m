Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51880C433EF
	for <virtualization@archiver.kernel.org>; Mon, 27 Jun 2022 12:06:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D40AE415A9;
	Mon, 27 Jun 2022 12:06:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D40AE415A9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g4ilFo4R
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HNuI6Hnqj7uo; Mon, 27 Jun 2022 12:06:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2B296415A5;
	Mon, 27 Jun 2022 12:06:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2B296415A5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ECE45C0032;
	Mon, 27 Jun 2022 12:06:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89B50C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 12:06:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 549AA415A9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 12:06:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 549AA415A9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gf-xf_RVyKPw
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 12:06:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 61A36415A5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 61A36415A5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 12:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656331566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oa0hKhTUeCCnu5O/zbJifpjkPRkzcn5Dvdk3HuT+Faw=;
 b=g4ilFo4REN3PdDjBVSvvCMPuY5SFQCEFq7w3s6gCRvKv7HxVeOFk9BzrPh30CB20dibEmT
 +W6J27F2FvDcIHtw/Te8OrSHIi4SnL7C7qK6UlxKFLegNPqYPstmVK5LHL4CfMZhFse1jJ
 Sv4FzwXnNinALXOBdfROJxDLpVVlXU0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-G_qgUledPO6o66SxaUwJoA-1; Mon, 27 Jun 2022 08:06:05 -0400
X-MC-Unique: G_qgUledPO6o66SxaUwJoA-1
Received: by mail-wm1-f71.google.com with SMTP id
 az40-20020a05600c602800b003a048edf007so1092949wmb.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 05:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oa0hKhTUeCCnu5O/zbJifpjkPRkzcn5Dvdk3HuT+Faw=;
 b=S+aAAO8ODlzSOAjCz+7POUVtVAS3mh4a0y+QPRrDrmLUmq59Ti0k4a63MtN7HJxWe6
 NVv8YoobFP1T3PEZNdCeHovjA1x7grQGCWMMPdEwgvaxlov+0MWRP4y87lIQ+J8U3rWE
 /De7Fe4i4ipEiB7UTZjN9sIfaCHOcokld/iPatikWu7CuTqJBjzuufPCklYoXgRhh0Yw
 GRfe26eurNyZZDJEqF1tsbQiV9gOqslR++yiWqFY6jcEtfsS6gqpB+s+KqmBYMme61Tp
 H8vU66ryJMmQo8b8O5TrENNflIw7MZnH9++Ie4tBjQWss/pFuwwiJ+Ct4NH2EeFkVRMa
 5FzA==
X-Gm-Message-State: AJIora8hEhTMEYr+/2yfSBM87XerI8f4r4N4GOKCV6sr2gOzPZICTXfj
 Fe3WhBv78yp/8bLtVvPqGfhbLZcDp4nMqxQ8L523p/9UlxrF5Q8E+rGkb9mpAvFfLAfMTO9XBUG
 Lv6EJ8nhM3y6C56I3ssigzHQa7o0HzU8iG/N39NqLTg==
X-Received: by 2002:adf:fad2:0:b0:21b:b947:bfa8 with SMTP id
 a18-20020adffad2000000b0021bb947bfa8mr12316739wrs.73.1656331564525; 
 Mon, 27 Jun 2022 05:06:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uH4dSe1OM+SF7gXPkS4xVRzc70/2+VEa4uCZyX8h1qerL46FWK8xW87SYP/3wUoSpkIGVe8w==
X-Received: by 2002:adf:fad2:0:b0:21b:b947:bfa8 with SMTP id
 a18-20020adffad2000000b0021bb947bfa8mr12316730wrs.73.1656331564326; 
 Mon, 27 Jun 2022 05:06:04 -0700 (PDT)
Received: from redhat.com ([2.54.45.90]) by smtp.gmail.com with ESMTPSA id
 h4-20020a5d4304000000b0021b829d111csm10533390wrq.112.2022.06.27.05.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jun 2022 05:06:03 -0700 (PDT)
Date: Mon, 27 Jun 2022 08:05:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net V2] virtio-net: fix race between ndo_open() and
 virtio_device_ready()
Message-ID: <20220627080539-mutt-send-email-mst@kernel.org>
References: <20220627083040.53506-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220627083040.53506-1-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kuba@kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Mon, Jun 27, 2022 at 04:30:40PM +0800, Jason Wang wrote:
> We currently call virtio_device_ready() after netdev
> registration. Since ndo_open() can be called immediately
> after register_netdev, this means there exists a race between
> ndo_open() and virtio_device_ready(): the driver may start to use the
> device before DRIVER_OK which violates the spec.
> 
> Fix this by switching to use register_netdevice() and protect the
> virtio_device_ready() with rtnl_lock() to make sure ndo_open() can
> only be called after virtio_device_ready().
> 
> Fixes: 4baf1e33d0842 ("virtio_net: enable VQs early")
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

I reworded the caif commit log similarly and put both on my tree.

> ---
>  drivers/net/virtio_net.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index db05b5e930be..8a5810bcb839 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3655,14 +3655,20 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	if (vi->has_rss || vi->has_rss_hash_report)
>  		virtnet_init_default_rss(vi);
>  
> -	err = register_netdev(dev);
> +	/* serialize netdev register + virtio_device_ready() with ndo_open() */
> +	rtnl_lock();
> +
> +	err = register_netdevice(dev);
>  	if (err) {
>  		pr_debug("virtio_net: registering device failed\n");
> +		rtnl_unlock();
>  		goto free_failover;
>  	}
>  
>  	virtio_device_ready(vdev);
>  
> +	rtnl_unlock();
> +
>  	err = virtnet_cpu_notif_add(vi);
>  	if (err) {
>  		pr_debug("virtio_net: registering cpu notifier failed\n");
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
