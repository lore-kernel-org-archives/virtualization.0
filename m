Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B2CC433EF
	for <virtualization@archiver.kernel.org>; Mon, 27 Jun 2022 06:33:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0A275405E2;
	Mon, 27 Jun 2022 06:33:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0A275405E2
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JM3lm2PI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u673NkierUvs; Mon, 27 Jun 2022 06:33:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8CAAE400F2;
	Mon, 27 Jun 2022 06:33:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8CAAE400F2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5DA11C007A;
	Mon, 27 Jun 2022 06:33:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 858DEC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 06:33:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5706D408DF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 06:33:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5706D408DF
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JM3lm2PI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xc-Rbo_DPIjH
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 06:33:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B201C408D3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B201C408D3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 06:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656311603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k4eRa49m+YdcPBeD5jFFPN5PIxxfzxkdDaDDwK1F1sg=;
 b=JM3lm2PIbeGb5zF3ISGjAXBObG6DrppUjDs27XXnqUZvM+4F6+a52dSX6iMzCqNbSA+9rg
 Sv0exqGN0o79FcUh1qh/PMI8w8Qm5fW2Vw3BvDTi1O8xfaWf0pojQy7PTrPapPxfdQC/bo
 5VQO8sqYu2aYABZWrm/OAXhfMlbNM1k=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-y2RJ6_FyNVesF1qrg3j2GQ-1; Mon, 27 Jun 2022 02:33:21 -0400
X-MC-Unique: y2RJ6_FyNVesF1qrg3j2GQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 f29-20020a19dc5d000000b004811c8d1918so602850lfj.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Jun 2022 23:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=k4eRa49m+YdcPBeD5jFFPN5PIxxfzxkdDaDDwK1F1sg=;
 b=wEZwS3gWHfOY5MD/CFgdrbLo0UelrFQfNHThFL6dC1U5A2hHJITva4dNW9UyQY2hQ5
 00v5n9DUCh5i4T41Uz+m43i/CmEfARtOQ5vYJeWNoPCb02ytp7+Uv8dt5CkOg9W/LMLN
 tBjXuE2NqE+F3m1q7Prf7cNg8eymwPV9Os9EhpwUrP6Zh2855Mb/jktrGQaUAC9PGHFg
 RGPiCzx/1gAHuzouNdzdXu53YcJm0eEbQS561kgpG1yZQss0RRnFxx3+zw4z7zEP1mOC
 6hAvS5s5okT+LBO5kA4U/p21K7MWN5JxzR9Mf0gf3Haea2wuaI35GvR3DV/ilKbBWyE1
 AlZg==
X-Gm-Message-State: AJIora9e0QbFy9YHljYq2i29xeQYvYAvvkG0q4Mf8YmgpQ6dxg8aAiF0
 LJIMk2oSS1+HdaubvVYnlWqZIM/1WpS7twOukh7H5IRI1t22JGFhtE6+bGCqjvJEkGog6uLytQV
 UeE21MZknDuhU6A1oim/2yu/HzKwJjXn8vNYAvpjWO6vR/wL/GXvFNogHYg==
X-Received: by 2002:a05:6512:22c3:b0:47f:704b:3820 with SMTP id
 g3-20020a05651222c300b0047f704b3820mr7251443lfu.411.1656311600068; 
 Sun, 26 Jun 2022 23:33:20 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u4kj9/LdxwlhRoiiAperrqoK4EQmj2BMt0PLamzAFFQv2Cn7vjYYLmaS1CdNqkHAmYF6tQcTMfpNkQ98/wUfQ=
X-Received: by 2002:a05:6512:22c3:b0:47f:704b:3820 with SMTP id
 g3-20020a05651222c300b0047f704b3820mr7251428lfu.411.1656311599885; Sun, 26
 Jun 2022 23:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220617072949.30734-1-jasowang@redhat.com>
In-Reply-To: <20220617072949.30734-1-jasowang@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 27 Jun 2022 14:33:08 +0800
Message-ID: <CACGkMEstGdmCCVKVXAWsWZXZNiYs7+P3yOtZG2cVNai=F5NyUg@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: fix race between ndo_open() and
 virtio_device_ready()
To: mst <mst@redhat.com>, jasowang <jasowang@redhat.com>,
 davem <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Fri, Jun 17, 2022 at 3:29 PM Jason Wang <jasowang@redhat.com> wrote:
>
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

Ok, I think we're fine with this. So I will repost against -net.

If we spot issues with unregistering, we can use a separate patch for that.

Thanks

> ---
>  drivers/net/virtio_net.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index db05b5e930be..8a5810bcb839 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3655,14 +3655,20 @@ static int virtnet_probe(struct virtio_device *vdev)
>         if (vi->has_rss || vi->has_rss_hash_report)
>                 virtnet_init_default_rss(vi);
>
> -       err = register_netdev(dev);
> +       /* serialize netdev register + virtio_device_ready() with ndo_open() */
> +       rtnl_lock();
> +
> +       err = register_netdevice(dev);
>         if (err) {
>                 pr_debug("virtio_net: registering device failed\n");
> +               rtnl_unlock();
>                 goto free_failover;
>         }
>
>         virtio_device_ready(vdev);
>
> +       rtnl_unlock();
> +
>         err = virtnet_cpu_notif_add(vi);
>         if (err) {
>                 pr_debug("virtio_net: registering cpu notifier failed\n");
> --
> 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
