Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B105E07F
	for <virtualization@lists.linux.dev>; Fri,  8 Mar 2024 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709918315; cv=none; b=pwr4E4y9i46b2XB7YpW5az/BoPBstyzehC0V9HTihwCUMF+JCKaRyuMPjfwCAPCyhm8z9J7ezsr7rzBLAqfuRqdt8cPkPa2PDIQidq6QvmBF4r3HxcZ1oSxY+oQZTnlKpH/3c0zLrXyQLF8h2nGeL/PP4XoYoROl1YbBWcjhrp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709918315; c=relaxed/simple;
	bh=LoSGNZh4FtejyrcxyRuCe7BMBFayjFDM4mQ+O9e+4Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UfZsDJyLvi+czadqORg9jtWgPvla54c52ysRto7bMAaPUcM//OXmL2XRbsFi9RCCb8ljhVsfeIQdiPOLJxKHp5yo+/93RYn+fYzqzesg6DzGEVTJRTRYJZmJgwTe7mMi7H5SKOmO0+KDpUBKNsA2h7G3m1wSG+HrVK/5ceCzzQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dUn6/AmZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUn6/AmZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709918312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7yPDbYfYVCjD6jkpVVZaC5nQLyNSNZXwpB21Gzx/O2s=;
	b=dUn6/AmZiLgHPuKECcjLtmxJp+5gziszKRRRwFJxSUbF8IJJVtWOnmDDR0tqUIDrSKyoKv
	5tr1xr/tEvglccuFfBtMW7SipaHdPXYJhzzKU/ZIbQjb5yN1xUWRoYt2S5CV9Z/SdO5b4X
	qRRsuJYxRVo8SZhfpbXhGJlA6ERGzqU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295--bu4vXtIMf26BGf-p2Je4g-1; Fri, 08 Mar 2024 12:18:31 -0500
X-MC-Unique: -bu4vXtIMf26BGf-p2Je4g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33d5aee5f0dso802745f8f.1
        for <virtualization@lists.linux.dev>; Fri, 08 Mar 2024 09:18:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709918310; x=1710523110;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7yPDbYfYVCjD6jkpVVZaC5nQLyNSNZXwpB21Gzx/O2s=;
        b=ZtsfZFzf1EgD/DUb8hCot+PhrkeM90x/SByhuXfdBkKVtU+N7DsPnjEXBRz1Di0pro
         TG/0U5rB9nkHSAjbaC8YFf/WXBrASXXZ8FYv64ssECyGATO7afOgMxQ+SE85b5xcUk2w
         KF+kLmo01RKnTAb8kB6YGyKWO5jUDjV5xbbDJe8e+AqZgum8bz8WB481cguFUxMbMWg3
         F25LE4kmyeX8GCE6gqVoNR0hFYkdnBViMVesLK38h8Gt6nM2gk7oydzBwtK29i+R91Fk
         X79mmq+0fsEEJrkhkG7l9NVawqMWoc7YK1OuUC6kU/R/3eSMtq8kZFmxYZ5egp0Fso6a
         G0FA==
X-Forwarded-Encrypted: i=1; AJvYcCU9yGMZUfnOseMjbGAKQgoq0Q97FYNwteqRFUJYGJlY8y6tCfjjr90GW6BsR3MaG9FGscto510PNBdNzp4mFoCgIgQqL2e++DfHPsFA3ng=
X-Gm-Message-State: AOJu0Yy2B2bNmCepIV3jxQaUY6TUPnQNhNCGGV2bVB2Ecs2JhHveFDT5
	zSt26OWtQnIrdna8g0exBJnBGx8uExHg0rr2dHlrw5UXCcnUeDG+GAf9W2BNqA/VwrVOCqAKoc8
	xWIZWAjueltgoV6Xkcc87cZD3icgLuvM5U4qwUSfK5x48mPiignGHLTrPlixyNYf8
X-Received: by 2002:adf:e310:0:b0:33d:b627:c3ec with SMTP id b16-20020adfe310000000b0033db627c3ecmr17387512wrj.44.1709918309624;
        Fri, 08 Mar 2024 09:18:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEcLCPTsB4rQmZ3icXY8ztQNYxBtAct6i9KrJitWvzDhGIWNg5+ETaBy1dR6GiOUAE/5xXVg==
X-Received: by 2002:adf:e310:0:b0:33d:b627:c3ec with SMTP id b16-20020adfe310000000b0033db627c3ecmr17387493wrj.44.1709918309057;
        Fri, 08 Mar 2024 09:18:29 -0800 (PST)
Received: from redhat.com ([2a06:c701:73cd:f300:bc74:daca:b316:492a])
        by smtp.gmail.com with ESMTPSA id i14-20020adfefce000000b0033e7603987dsm2379319wrp.12.2024.03.08.09.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 09:18:28 -0800 (PST)
Date: Fri, 8 Mar 2024 12:18:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH] virtio-mmio: Convert to platform remove callback
 returning void
Message-ID: <20240308121725-mutt-send-email-mst@kernel.org>
References: <ef71f955531d5e41b20d801e1149bb08d155679a.1709886922.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ef71f955531d5e41b20d801e1149bb08d155679a.1709886922.git.u.kleine-koenig@pengutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Mar 08, 2024 at 09:51:20AM +0100, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

do u want me to merge this?

> ---
>  drivers/virtio/virtio_mmio.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 59892a31cf76..173596589c71 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -696,12 +696,10 @@ static int virtio_mmio_probe(struct platform_device *pdev)
>  	return rc;
>  }
>  
> -static int virtio_mmio_remove(struct platform_device *pdev)
> +static void virtio_mmio_remove(struct platform_device *pdev)
>  {
>  	struct virtio_mmio_device *vm_dev = platform_get_drvdata(pdev);
>  	unregister_virtio_device(&vm_dev->vdev);
> -
> -	return 0;
>  }
>  
>  
> @@ -847,7 +845,7 @@ MODULE_DEVICE_TABLE(acpi, virtio_mmio_acpi_match);
>  
>  static struct platform_driver virtio_mmio_driver = {
>  	.probe		= virtio_mmio_probe,
> -	.remove		= virtio_mmio_remove,
> +	.remove_new	= virtio_mmio_remove,
>  	.driver		= {
>  		.name	= "virtio-mmio",
>  		.of_match_table	= virtio_mmio_match,
> 
> base-commit: 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd
> -- 
> 2.43.0

