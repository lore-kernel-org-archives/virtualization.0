Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3CAC43334
	for <virtualization@archiver.kernel.org>; Fri, 17 Jun 2022 10:13:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CDF8660B49;
	Fri, 17 Jun 2022 10:13:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CDF8660B49
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WnkaPveG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XmMphnIYG_mH; Fri, 17 Jun 2022 10:13:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5DE10606E6;
	Fri, 17 Jun 2022 10:13:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5DE10606E6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C23EC0032;
	Fri, 17 Jun 2022 10:13:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F151C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 10:13:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DA9E041A37
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 10:13:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DA9E041A37
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WnkaPveG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uKBDE9Agz-OO
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 10:13:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5DE53418D3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5DE53418D3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 10:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655460783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/Egh8+Gz6P7sJjajReRg4TwcxQZ6PNsT6qhTrjGb38E=;
 b=WnkaPveGz/u80WBMumjbIbULmYvkw9UPrPFsylqKwthXnTWJuVIHtaHJbDwMDYKPdC4A9l
 4V0yZKrH4YKXobcNevgOb9EIvFq3pojZbMgUIL0PNiWwQ0h3anYnPy8IHha+Ojl9EQiFE/
 mSZuolhGu0ywj7OtZDh7Xf4+x5391qw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-Ajut63NLM6GWEDAZsx7ujQ-1; Fri, 17 Jun 2022 06:13:02 -0400
X-MC-Unique: Ajut63NLM6GWEDAZsx7ujQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 v14-20020a5d610e000000b00213b51a0234so856774wrt.11
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 03:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/Egh8+Gz6P7sJjajReRg4TwcxQZ6PNsT6qhTrjGb38E=;
 b=aTXhpn00iv9LChWgulC3PzGni/NyaXRzyto56tKIqKFvaHeRHgt+zjEGC+Vu3dYzZz
 6QSmNkg7uxIOutQ7KxO1rU5k5M/KKzIR7TG4HFk4uSej0dYxLWdUm6PZ9to926tiIdfl
 XlMvO5Zzpx3YiI0ZtjKV1dcAQTlzmlr7RPgu7W/3BNPnb76JuDmmub2w/0MYksxi+Qjn
 S+P3xiyG7HRGxwKui1X7fFWPUMunvyBn1L81Q9Qar5xuw8AKGyqgaPm3AbSef+9OB/+7
 HIMLphREDG+alDao/aX1wYfk3QU+HLqPZhDW0nuueHTocVNbQT05Pf10h9Fflo2SLZ6i
 iYSQ==
X-Gm-Message-State: AJIora8y9Zr4WfOFEvdUqQpQsKoH2m+I4LlNqjqjjsUojjMi0wToZ5Kf
 WIdZtjgddNOykGBqfwmm0eCFmRzhvIwmL6BDRWx5mt+lsDsnNnx9Y2wAJrwaGG8mZvPPHf3PTfg
 auaEjm+Hw5vsp3HXO/Q0z3yWuPfMaZIOzxSxdOFKF4A==
X-Received: by 2002:a5d:6d8b:0:b0:218:4dc8:293e with SMTP id
 l11-20020a5d6d8b000000b002184dc8293emr8684809wrs.612.1655460781815; 
 Fri, 17 Jun 2022 03:13:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uCeVJ3V3dWfzRxiKB7fJuvCI0FPi1R5vsbVVS3gLAKJyU7vKwteL3gJz5FSVTdXRodiZ6DGg==
X-Received: by 2002:a5d:6d8b:0:b0:218:4dc8:293e with SMTP id
 l11-20020a5d6d8b000000b002184dc8293emr8684788wrs.612.1655460781577; 
 Fri, 17 Jun 2022 03:13:01 -0700 (PDT)
Received: from redhat.com ([2.54.189.19]) by smtp.gmail.com with ESMTPSA id
 i188-20020a1c3bc5000000b0039ee52c1345sm2137495wma.4.2022.06.17.03.12.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jun 2022 03:13:01 -0700 (PDT)
Date: Fri, 17 Jun 2022 06:12:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio-net: fix race between ndo_open() and
 virtio_device_ready()
Message-ID: <20220617060632-mutt-send-email-mst@kernel.org>
References: <20220617072949.30734-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220617072949.30734-1-jasowang@redhat.com>
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

On Fri, Jun 17, 2022 at 03:29:49PM +0800, Jason Wang wrote:
> We used to call virtio_device_ready() after netdev registration. This
> cause a race between ndo_open() and virtio_device_ready(): if
> ndo_open() is called before virtio_device_ready(), the driver may
> start to use the device before DRIVER_OK which violates the spec.
> 
> Fixing this by switching to use register_netdevice() and protect the
> virtio_device_ready() with rtnl_lock() to make sure ndo_open() can
> only be called after virtio_device_ready().
> 
> Fixes: 4baf1e33d0842 ("virtio_net: enable VQs early")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
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


Looks good but then don't we have the same issue when removing the
device?

Actually I looked at  virtnet_remove and I see
        unregister_netdev(vi->dev);

        net_failover_destroy(vi->failover);

        remove_vq_common(vi); <- this will reset the device

a window here?


Really, I think what we had originally was a better idea -
instead of dropping interrupts they were delayed and
when driver is ready to accept them it just enables them.
We just need to make sure driver does not wait for
interrupts before enabling them.

And I suspect we need to make this opt-in on a per driver
basis.



> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
