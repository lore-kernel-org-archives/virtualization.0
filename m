Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCA71A727D
	for <virtualization@lists.linux.dev>; Wed, 16 Jul 2025 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752672453; cv=none; b=KJv7geLgdu9lcCqMpESigv9g9nV9sqRR0VnKckh+iWI9aSLlgWKGgyE4HfdHwP7z+T5fFrCiHYmT9EqByL6BEhXygYYa82nXaplPwXKoEPskEwEjudmlFdd5H9Z9ZifpZxXg1dUvkAqx5Du10402el6/yeMY9dk8gaGdaTcvJUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752672453; c=relaxed/simple;
	bh=AhM7Gbo34MvyrwDuefykC3U1phCmTU+xRmitbDdZIb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bS3p6jaOuG7ji1vbVVZ+gaeXoPkpq9glCCOz+aLF8/Gbqi2DJmT24wmFl1fbD+cdp4BCnKiiLJ9y8w6e52YOMn1PwQE5vTXg9foOaSnf/auKiY8IorL8wN/N+2r2ccq7E9IU3HAmk3e6Uo3k44uSjuePl5QPFwij3N8MAo/2v2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FZPTKGJX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZPTKGJX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752672450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xIUzUI8LCPje/1PLfr5clYD7hM1EsM0qntpxYAf55oE=;
	b=FZPTKGJX37JrWvlsaJakUBWOYeSujkyINlT+VuaCdRem1cPKHzf9erF8hUDRw0KAZcwB+H
	dSdH4AyLBnPwTzIYb8IUOrOZ8nLrGs5653uV+4JOG+xR7ebe1H19U0kn8xZuWnGnXQ53Il
	/uKXG5KXJZRIA4+tG2JlonWqZ2g7qpc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-uScO_U3DMSqo5ywTldR-aw-1; Wed, 16 Jul 2025 09:27:29 -0400
X-MC-Unique: uScO_U3DMSqo5ywTldR-aw-1
X-Mimecast-MFC-AGG-ID: uScO_U3DMSqo5ywTldR-aw_1752672448
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4561bc2f477so20864235e9.0
        for <virtualization@lists.linux.dev>; Wed, 16 Jul 2025 06:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752672448; x=1753277248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIUzUI8LCPje/1PLfr5clYD7hM1EsM0qntpxYAf55oE=;
        b=rJpU6ltfbcIvvUOAr6eHplo6qgttx4/XuBH76AR9VdSLZJATNZpcnt7/0FJN0axh6H
         oBqJY+sj0QNZOlPxMB7XH6cX8g9NaM4/huHK32AEzmn02aAy8QZVAzUQQTmEqHuLVSpE
         VQdAIBdjzWdGfkh8EMLixUh21c/f9dbMLMxpjwBldXojzNA/5SlT1lHksKrIJ5hGceo6
         dJo2sjcRYG/GwL7Lt7NYXsPopprle1g2rdIZ2i4qQkIJPViM36OeOVDMIFplPodDh8NL
         2pTZU7vbhK6oroZLscgw0wZ3JjvU/qPVKr36xA6HzahcFPIoW/tFlJEuaps/WstN+WCq
         bHsw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ0HJvxNsYFoxjywXuXHjzhsUc92+Vx5iGFfiJXg7+uqYSoXx7znyl6S0ZMoT6GsNwv9wVR1KCXRWZgThXEw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgLeTKcDVseZx6aAEzPYJHCNv4qh82kkffVkWmgyn4m+gRzQ6a
	0rtcRvfLC4vHc3UobWl5uN6Gi76RRvqMebrd0C+HrOitMyPM9Ngkoc0pO08q29yJGBtxt0znxaM
	xmMLskSsnVHT7E+0ePK0dPpHe/RKK15nIbMSVTbBDk1IujkfLh5fF7opDJMikaS2iM39Z
X-Gm-Gg: ASbGncuJdkr4RvEWc1Sq1qkwcmx1oOp6XjodYmK9YDDJMOc+f0esKbHaZ275hHezpFM
	4ZROulasOJyaBk9KHfUSSVakY8XoXqWQ0Q0sx6U8158VjDip44zdOML5d0pQo5s1pXKOCmfE3sI
	+p+ILaqilp9aEvC/TBCfRq+IbnKi2wk4lBdMIqB/wYhzYtdbnW0LTrpQVtzEUx7HBAC38aeIC6t
	bK6vRgRwZMpBwSoavbi7Va4Z5MNGTrkR3vVKrd8rD5EvVOhViv9swvIk9iTH5Efr16kGz++zmaO
	uLx9efWrLE2UkJFHNWeMgSTFLbDHKXHK
X-Received: by 2002:a05:600c:674a:b0:456:2b4d:d752 with SMTP id 5b1f17b1804b1-4562e373e16mr24560635e9.20.1752672448178;
        Wed, 16 Jul 2025 06:27:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHbDh/0mz0p15FDovo+BRjkyUmjje/T03BW5/61Wm+8H+LQBbslJKqM78ICO4/OJJMN3SMhg==
X-Received: by 2002:a05:600c:674a:b0:456:2b4d:d752 with SMTP id 5b1f17b1804b1-4562e373e16mr24560295e9.20.1752672447754;
        Wed, 16 Jul 2025 06:27:27 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc1de0sm17724383f8f.24.2025.07.16.06.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 06:27:27 -0700 (PDT)
Date: Wed, 16 Jul 2025 09:27:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zigit Zo <zuozhijie@bytedance.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net v3] virtio-net: fix recursived rtnl_lock() during
 probe()
Message-ID: <20250716092717-mutt-send-email-mst@kernel.org>
References: <20250716115717.1472430-1-zuozhijie@bytedance.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250716115717.1472430-1-zuozhijie@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: p3qkaLIxjzEegcZF3TpoW0WWR2WtgMzRsJBkfYpLQgE_1752672448
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 16, 2025 at 07:57:17PM +0800, Zigit Zo wrote:
> The deadlock appears in a stack trace like:
> 
>   virtnet_probe()
>     rtnl_lock()
>     virtio_config_changed_work()
>       netdev_notify_peers()
>         rtnl_lock()
> 
> It happens if the VMM sends a VIRTIO_NET_S_ANNOUNCE request while the
> virtio-net driver is still probing.
> 
> The config_work in probe() will get scheduled until virtnet_open() enables
> the config change notification via virtio_config_driver_enable().
> 
> Fixes: df28de7b0050 ("virtio-net: synchronize operstate with admin state on up/down")
> Signed-off-by: Zigit Zo <zuozhijie@bytedance.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> v3 -> v2:
> * Simplify the changes.
> v1 -> v2:
> * Check vi->status in virtnet_open().
> * https://lore.kernel.org/netdev/20250702103722.576219-1-zuozhijie@bytedance.com/
> v1:
> * https://lore.kernel.org/netdev/20250630095109.214013-1-zuozhijie@bytedance.com/
> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 5d674eb9a0f2..82b4a2a2b8c4 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -7059,7 +7059,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	   otherwise get link status from config. */
>  	netif_carrier_off(dev);
>  	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> -		virtnet_config_changed_work(&vi->config_work);
> +		virtio_config_changed(vi->vdev);
>  	} else {
>  		vi->status = VIRTIO_NET_S_LINK_UP;
>  		virtnet_update_settings(vi);
> 
> base-commit: dae7f9cbd1909de2b0bccc30afef95c23f93e477
> -- 
> 2.49.0

