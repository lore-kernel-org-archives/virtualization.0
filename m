Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4B9C433FE
	for <virtualization@archiver.kernel.org>; Tue, 14 Dec 2021 23:26:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB237813DB;
	Tue, 14 Dec 2021 23:26:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FgVV_Iw2WEPx; Tue, 14 Dec 2021 23:26:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8044181379;
	Tue, 14 Dec 2021 23:26:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44BB0C002F;
	Tue, 14 Dec 2021 23:26:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51AE1C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 23:26:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 362FB4027A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 23:26:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vnNjWi-OCYq9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 23:26:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2FDE640179
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 23:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639524405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LDA9jVOy/ZRGCA3pqs+Olfx4vK3cOd0BCYRpSVgNd3U=;
 b=gUujYyJvPIi5+p4RcZkgRxrDhGXzW/l73WEIFA/dtQ77ZqENG5WOPbV9H8F5uC5vcnJx91
 GrRY4M+BMQl9yfQLbiml0YFqtiGR1RPhB/ANkWplI3f+dZjPHGIklKIBFQ7ikVqSNwctm1
 f+BEPOI7rRZa73lEIfXKKnErbWXYO7c=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-454-uqtYK4jLMaiWOI61ejoM7Q-1; Tue, 14 Dec 2021 18:26:44 -0500
X-MC-Unique: uqtYK4jLMaiWOI61ejoM7Q-1
Received: by mail-ed1-f69.google.com with SMTP id
 w18-20020a056402071200b003e61cbafdb4so18426572edx.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 15:26:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LDA9jVOy/ZRGCA3pqs+Olfx4vK3cOd0BCYRpSVgNd3U=;
 b=aXp4UB/3ySl+7EYi1AuCPQxcofxVijp/1JzM9KUF+kL2JYbtMDWYzCydtvXht3wOpz
 UMLdHaKDc3eDuUjcwMF91ebnUj7Bit6gNPv/uWTwR+zgY8Gu76YvWsBCWvymrc4h1wIl
 iX3Z5eO6DMQuG3bmoHLqESx9gFZFfyobIfhrySiIDbsSYN1/h4igrJOUDXp47UxJy5Qg
 tNhVP2NmHOsUlzox4faPY5/DC1Obg6mhwl6dB8YhvA67w9sRejBLB2OznZQUkbOIcWhO
 Ce/9Q4OscKO1vWrWQ61S/lPSw5msUsKBFWRcT7nLkAI2cCWx41IsS9do9YqnflZtYiWv
 woaA==
X-Gm-Message-State: AOAM530FtMShXJ9j1prItRu4GbNWGhkIWb3/zdBEZavWtz9ncMFOe7nf
 ftShZYDYPhT8NxMfB2lWectfbhiabAnPyEFJ2lmZ1n12yjnMNqqzLXoCPxXdi4es2GfktYHXFOa
 RrpBVlJ5ai3JfTxKGN8aC6gbN+6TyXcWVlpnABYjUhA==
X-Received: by 2002:a17:907:8a13:: with SMTP id
 sc19mr8319058ejc.130.1639524403064; 
 Tue, 14 Dec 2021 15:26:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxY9VeEUwbwOQjfz6ubzWVYWdjmxkerIQ6XgtO+Jvoh1RAxswqJWM3ChpSChcFlpxDXjdGQtw==
X-Received: by 2002:a17:907:8a13:: with SMTP id
 sc19mr8319045ejc.130.1639524402869; 
 Tue, 14 Dec 2021 15:26:42 -0800 (PST)
Received: from redhat.com ([2.55.154.189])
 by smtp.gmail.com with ESMTPSA id d18sm90019edj.23.2021.12.14.15.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Dec 2021 15:26:42 -0800 (PST)
Date: Tue, 14 Dec 2021 18:26:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
Subject: Re: [RFC PATCH] virtio: do not reset stateful devices on resume
Message-ID: <20211214182611-mutt-send-email-mst@kernel.org>
References: <20211214163249.GA253555@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <20211214163249.GA253555@opensynergy.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Tue, Dec 14, 2021 at 05:33:05PM +0100, Mikhail Golubev wrote:
> From: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
> 
> We assume that stateful devices can maintain their state while
> suspended. And for this reason they don't have a freeze callback. If
> such a device is reset during resume, the device state/context will be
> lost on the device side. And the virtual device will stop working.
> 
> Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
> Signed-off-by: Mikhail Golubev <mikhail.golubev@opensynergy.com>

A bit more specific? Which configs does this patch fix?

> ---
>  drivers/virtio/virtio.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 236081afe9a2..defa15b56eb8 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -472,6 +472,13 @@ int virtio_device_restore(struct virtio_device *dev)
>  	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
>  	int ret;
>  
> +	/* Short path for stateful devices. Here we assume that if the device
> +	 * does not have a freeze callback, its state was not changed when
> +	 * suspended.
> +	 */
> +	if (drv && !drv->freeze)
> +		goto on_config_enable;
> +
>  	/* We always start by resetting the device, in case a previous
>  	 * driver messed it up. */
>  	dev->config->reset(dev);
> @@ -503,6 +510,7 @@ int virtio_device_restore(struct virtio_device *dev)
>  	/* Finally, tell the device we're all set */
>  	virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
>  
> +on_config_enable:
>  	virtio_config_enable(dev);
>  
>  	return 0;
> -- 
> 2.34.1
> 
> 
> -- 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
