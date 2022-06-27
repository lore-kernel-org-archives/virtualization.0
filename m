Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C449CCA47E
	for <virtualization@archiver.kernel.org>; Mon, 27 Jun 2022 07:44:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E9CB2408AF;
	Mon, 27 Jun 2022 07:44:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E9CB2408AF
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mv3kIJEr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JOoAc5qY7arU; Mon, 27 Jun 2022 07:44:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 78469403FF;
	Mon, 27 Jun 2022 07:44:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 78469403FF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42575C0032;
	Mon, 27 Jun 2022 07:44:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C231FC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 07:44:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8DFBC415C9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 07:44:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8DFBC415C9
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mv3kIJEr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xYUeC9Ofd5eL
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 07:44:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 72CE0415C8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 72CE0415C8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 07:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656315868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9JFk1orzuEaIozJoxvbuTHAStsu1Q5iabE/7CHYRH08=;
 b=Mv3kIJErS7wp/Y55Ab2p1uQCUVZA/zUdHu0cLlnLJIwsJkJF8M+4fiheZ8El4nfAGf+Rkl
 jlynTXMBUmlJoaBGti7nxQzyd3uX7rm+wOemk6/GIXijQ1Mbpj43f+pZO7VzABcW9/UexR
 DaB1Oej8as9VRRi1YBj2tCWO3Z83GFE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-507-lACsM62bM-qFqXQimrIM5w-1; Mon, 27 Jun 2022 03:44:26 -0400
X-MC-Unique: lACsM62bM-qFqXQimrIM5w-1
Received: by mail-wr1-f69.google.com with SMTP id
 r15-20020adff10f000000b0021bcc217e15so246898wro.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 00:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9JFk1orzuEaIozJoxvbuTHAStsu1Q5iabE/7CHYRH08=;
 b=CSOMOURcev+6PZKtKdD0fNoXJfrYDBQN6fVi667kBjBOUdNlA1ZLP3gulNG4YSjPxk
 L3wI08GhukJxSJUFnTu5HkJnApNN00bIk8WxIJggOpC33XiUQUPR/0YvWXopZqQCYJNR
 ZE0JExd9HYKPkdqv+p8xN0zjgPqfEQPhD0mWuV1jL2hDhzi4G++McC05HzIdPb2s448b
 ZE1Ddv/gSQLBu8Rgej+k2O1R1aG9x4F7lbD7JUv1kA8OLvsHMze2YJr2IVa6Nvvp8Plf
 39UbFeAsOsy/yfYAlBGsAq2g9BZz/BLEl1EIHbScxxSICiVxcHXNinGk6w/vWRHYzddN
 F3xQ==
X-Gm-Message-State: AJIora+GM+eKsEosLIBQhnht/i49/gjxLvSP77s1DpRO2b2krlE25dUF
 k7IAleqzGiI1+1pckAbd6Q+xJfR6lvx0ZTqKudf6rHw2q9Ua3x6VDaICH7p/2f9WB/kW58qhCq5
 Ly4lttv7sTTDM6u60vAyq6p430AbiA+MLEv8nBWT5uA==
X-Received: by 2002:a5d:49cc:0:b0:21b:aaec:eba8 with SMTP id
 t12-20020a5d49cc000000b0021baaeceba8mr10755143wrs.660.1656315865086; 
 Mon, 27 Jun 2022 00:44:25 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sbVryOidUE0xJ953k5Axs8LsqG+OeJXJtKMhrC6JEI5Et8HZUs3TNohurBNJO6jZ45MJflcw==
X-Received: by 2002:a5d:49cc:0:b0:21b:aaec:eba8 with SMTP id
 t12-20020a5d49cc000000b0021baaeceba8mr10755126wrs.660.1656315864813; 
 Mon, 27 Jun 2022 00:44:24 -0700 (PDT)
Received: from redhat.com ([2.54.45.90]) by smtp.gmail.com with ESMTPSA id
 k8-20020a05600c1c8800b003a04722d745sm5020741wms.23.2022.06.27.00.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jun 2022 00:44:24 -0700 (PDT)
Date: Mon, 27 Jun 2022 03:44:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net] virtio-net: fix race between ndo_open() and
 virtio_device_ready()
Message-ID: <20220627033422-mutt-send-email-mst@kernel.org>
References: <20220627063656.52397-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220627063656.52397-1-jasowang@redhat.com>
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

On Mon, Jun 27, 2022 at 02:36:56PM +0800, Jason Wang wrote:
> We used to call virtio_device_ready() after netdev registration.

s/used to call/currently call/

> This
> cause

s/This cause/Since ndo_open can be called immediately
after register_netdev, this means there exists/

> a race between ndo_open() and virtio_device_ready(): if
> ndo_open() is called before virtio_device_ready(), the driver may
> start to use the device before DRIVER_OK which violates the spec.
> 
> Fixing

s/Fixing/Fix/

> this by switching to use register_netdevice() and protect the
> virtio_device_ready() with rtnl_lock() to make sure ndo_open() can
> only be called after virtio_device_ready().
> 
> Fixes: 4baf1e33d0842 ("virtio_net: enable VQs early")

it's an unusual use of Fixes - the patch in question does not
introduce the problem, it just does not fix it completely.
But OK I guess.

> Signed-off-by: Jason Wang <jasowang@redhat.com>

With commit log changes:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

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
