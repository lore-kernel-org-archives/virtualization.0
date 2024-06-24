Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284201339A4
	for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 09:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719223177; cv=none; b=Y7vDNwpxXPS17qUil0s0QOp3lJpUqIDorYVhOA1xVfcSUjKwXFbp383qPrOB7WbEgyQoaW74PoArtWu5fxwBN++5bTbP+RuhGbNHJlXCuB1UCC3XR9duGwh9yV9Va8X11O0a4Ucvm7bbQSbA5TgiJvK6J5KfFx6kewpvwoyTMog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719223177; c=relaxed/simple;
	bh=8IRKD2VDK4RtOqMcQRev9Lu8Sns19P6qT0a8xgsE+Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YbqSvzYR1KlnscjH/do3gUZsfzsdUY/KZmxioybiEMr7NTWQS9FjHUT3ew16wso2rZbdIkJK2qpX5KY1FHG/RVwMU8upE6sSoMywe4QhIynhbxd2vA8nrPtQ9Rm5NxOz+l9e8jWNCY2NP+ucdLQ5XKsyLhWxiiVzx+zJSL+UD10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XJ5Loi3r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJ5Loi3r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719223175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PwlMgaE8+kBE4Dvy2LlPLjnBZ3dnXU/5g0//YUxNCgs=;
	b=XJ5Loi3rljjVMAgGmXqLQLFc1A7xipkwy//GE1na26m5NL5zJD6xbHyZq/MJt8eb4vI3t0
	vqBF1ZVgsM2dVyyMjdbrEen0TjhJfpzjuJyPx+RLtvmkgqbebWLvmo3q2zlCbgZ3XVgqzM
	f4uKJB+HQkYTC91YGah11Br85Wu6Eq0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-TtlxmK4ONDmqINFpUkVemQ-1; Mon, 24 Jun 2024 05:59:32 -0400
X-MC-Unique: TtlxmK4ONDmqINFpUkVemQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52cd7e63b2aso1983535e87.3
        for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 02:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719223171; x=1719827971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwlMgaE8+kBE4Dvy2LlPLjnBZ3dnXU/5g0//YUxNCgs=;
        b=Ym5i6AMb/5j3cAJl3zQIGB/9ObTQylZLHe/wLuUT5V1UvcVLO1pCPaW/z3ZH3ckkzg
         btdjPK2loBjbgKagQQlswFZ8fUOZc9CWeOwEbYDtrZK9ipw8Ck4/MwOJH4MFacBiO27I
         /mOZs8s+pEZWuTGw7uJTxrFa8TgcV0DO0+ABtZmj9CEVXtSkSKj72T25REpbM/5FNSuM
         4w2WTmTWPFC/RLSNeEz48gl/Fl5GgRycNzQylyizeYd6CCvGERh/jeZJDBh68QWpIwnK
         iOHX1f3HWpbB4PH4movd3fMbT/6lwex7P3EAevYq0ZQaN/yBTs9P2VupdFPAHwzPSpGq
         ycZw==
X-Forwarded-Encrypted: i=1; AJvYcCX5kSUmxybDzW9CSf/wV7zGHfMPTt4C07AgIaaFtzQSF4BYCkSjHyem5saNbkw7csvaYpi0nlQZ4wosvdwW9c8woN161lX8xSLrcAUNgBw=
X-Gm-Message-State: AOJu0YzxtDaHacFBHasYcoGjaCtvEnSamghuSwSK3erK37DnRzN4CAuU
	lw3KZVM92aArj7osnG8FU9FCo9/5Kfh8XuY2oD9QdjIp1aOSey5hhGDzNI5ovKlQA9C3hohwKJN
	vuOIjqbaJ9UUkDkHetCKuNbBOA55nBHJE4PkcBvZDcd7dmO1QgMZpJ9oD6gO70/Qj
X-Received: by 2002:a19:c219:0:b0:52c:d5b3:1a6a with SMTP id 2adb3069b0e04-52ce061cedfmr2938792e87.28.1719223170737;
        Mon, 24 Jun 2024 02:59:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHa9zU5lz/eJ4TII5tOUnKtVMjwizb2UTpSRF7P4MzTiK4ikVcABLfXc8Ps4KqAgiNvWG1Y+Q==
X-Received: by 2002:a19:c219:0:b0:52c:d5b3:1a6a with SMTP id 2adb3069b0e04-52ce061cedfmr2938775e87.28.1719223169992;
        Mon, 24 Jun 2024 02:59:29 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366389b8985sm9587026f8f.43.2024.06.24.02.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 02:59:29 -0700 (PDT)
Date: Mon, 24 Jun 2024 05:59:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, venkat.x.venkatsubra@oracle.com,
	gia-khanh.nguyen@oracle.com
Subject: Re: [PATCH V2 1/3] virtio: allow nested disabling of the configure
 interrupt
Message-ID: <20240624054403-mutt-send-email-mst@kernel.org>
References: <20240624024523.34272-1-jasowang@redhat.com>
 <20240624024523.34272-2-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240624024523.34272-2-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 24, 2024 at 10:45:21AM +0800, Jason Wang wrote:
> Somtime driver may want to enable or disable the config callback. This
> requires a synchronization with the core. So this patch change the
> config_enabled to be a integer counter. This allows the toggling of
> the config_enable to be synchronized between the virtio core and the
> virtio driver.
> 
> The counter is not allowed to be increased greater than one, this
> simplifies the logic where the interrupt could be disabled immediately
> without extra synchronization between driver and core.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio.c | 20 +++++++++++++-------
>  include/linux/virtio.h  |  2 +-
>  2 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index b968b2aa5f4d..d3aa74b8ae5d 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -127,7 +127,7 @@ static void __virtio_config_changed(struct virtio_device *dev)
>  {
>  	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
>  
> -	if (!dev->config_enabled)
> +	if (dev->config_enabled < 1)
>  		dev->config_change_pending = true;
>  	else if (drv && drv->config_changed)
>  		drv->config_changed(dev);
> @@ -146,17 +146,23 @@ EXPORT_SYMBOL_GPL(virtio_config_changed);
>  static void virtio_config_disable(struct virtio_device *dev)
>  {
>  	spin_lock_irq(&dev->config_lock);
> -	dev->config_enabled = false;
> +	--dev->config_enabled;
>  	spin_unlock_irq(&dev->config_lock);
>  }
>  
>  static void virtio_config_enable(struct virtio_device *dev)
>  {
>  	spin_lock_irq(&dev->config_lock);
> -	dev->config_enabled = true;
> -	if (dev->config_change_pending)
> -		__virtio_config_changed(dev);
> -	dev->config_change_pending = false;
> +
> +	if (dev->config_enabled < 1) {
> +		++dev->config_enabled;
> +		if (dev->config_enabled == 1 &&
> +		    dev->config_change_pending) {
> +			__virtio_config_changed(dev);
> +			dev->config_change_pending = false;
> +		}
> +	}
> +
>  	spin_unlock_irq(&dev->config_lock);
>  }
>

So every disable decrements the counter. Enable only increments it up to 1.
You seem to be making some very specific assumptions
about how this API will be used. Any misuse will lead to under/overflow
eventually ...



My suggestion would be to
1. rename config_enabled to config_core_enabled
2. rename virtio_config_enable/disable to virtio_config_core_enable/disable
3. add bool config_driver_disabled and make virtio_config_enable/disable
   switch that.
4. Change logic from dev->config_enabled to
   dev->config_core_enabled && !dev->config_driver_disabled



  
> @@ -455,7 +461,7 @@ int register_virtio_device(struct virtio_device *dev)
>  		goto out_ida_remove;
>  
>  	spin_lock_init(&dev->config_lock);
> -	dev->config_enabled = false;
> +	dev->config_enabled = 0;
>  	dev->config_change_pending = false;
>  
>  	INIT_LIST_HEAD(&dev->vqs);
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 96fea920873b..4496f9ba5d82 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -132,7 +132,7 @@ struct virtio_admin_cmd {
>  struct virtio_device {
>  	int index;
>  	bool failed;
> -	bool config_enabled;
> +	int config_enabled;
>  	bool config_change_pending;
>  	spinlock_t config_lock;
>  	spinlock_t vqs_list_lock;
> -- 
> 2.31.1

