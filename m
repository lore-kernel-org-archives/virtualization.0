Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0570C433FE
	for <virtualization@archiver.kernel.org>; Wed, 23 Nov 2022 15:49:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 31E084042B;
	Wed, 23 Nov 2022 15:49:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 31E084042B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=amB4gwMR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id An-G79mwDVSn; Wed, 23 Nov 2022 15:49:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9A81C4050C;
	Wed, 23 Nov 2022 15:49:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9A81C4050C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6FF3DC0032;
	Wed, 23 Nov 2022 15:49:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF0F8C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 15:49:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8BB69607EC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 15:49:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8BB69607EC
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=amB4gwMR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BpOTJ7Qzaolh
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 15:49:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C41D5606A9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C41D5606A9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 15:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669218571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KF/ov70bORdprLanpzIpmLSFeEwa9e3wCywBo/4P5WE=;
 b=amB4gwMR5notD8cQ+Oi7tHbDwYzeIz6mr2rSOqjZzjI/6xBS4RzyIgHeYmj842tOnPao69
 kApmVssGznQqwEG9ggAieC9U8lKb8V6uKa6HyrzgUkkCTCUHiDD9Xg0o+dTLk8ym4E0EeP
 ViTMZ/4z4ZrhLtvExWbgMeYuSU87X+c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-459-j0Ic-vQzNK-KMRkzlPs1IQ-1; Wed, 23 Nov 2022 10:49:30 -0500
X-MC-Unique: j0Ic-vQzNK-KMRkzlPs1IQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 8-20020a05600c228800b003d0376e42deso78362wmf.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 07:49:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KF/ov70bORdprLanpzIpmLSFeEwa9e3wCywBo/4P5WE=;
 b=ebrKHknNswwUv1ORN8o+Zr8KGXklrikcIy/fqp96y0XY0SvXx/dyNg5zISDHLZ5ZzC
 TTob/vLmvn0QAJHcp9nvrLwLPVEg5DO4xDRBWC55RDImys6V1yvfSQLT+YtSGjkm9bxM
 2jUIiD1p7NV+dXlZhV01/8FEoOxkKe1dVqq6ydPUOnzpD+k5K1gYy0seiJO4dD+vIoWW
 BYZ9l8Vf+9dEzMW6hEybkt5syK4ZGCT5zVBK7yM1yNyAuJTP4moAmtSLQXO7YIAFVQLX
 GgGOJNohMGda8ufGIxmLehw+admDWWkAdREsOODDFQCDzT2l7pR6sz2mi608/bRlLenG
 zwbQ==
X-Gm-Message-State: ANoB5plG1SfXpWhFd49c2xLJuBMMtp+VW7xHTj1KzJeaoqReufdcScR+
 BQz1YbIaMuTrDnYm9Pc3R70DpkTyqwNRR4txnLFAWZwzri+VL7kXTaMxbtTP4MkXh3keTF1JcM3
 at3oJvU3TIkCf9uI1mz1jih56vzWRE5lC/YmBSbdTjw==
X-Received: by 2002:a5d:6706:0:b0:241:cf90:ab1e with SMTP id
 o6-20020a5d6706000000b00241cf90ab1emr8060360wru.685.1669218568962; 
 Wed, 23 Nov 2022 07:49:28 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5MXC1Gnn3d7MuC2idiVTxfYIH+t32YkYXeo2vUYG8xk+Blpi+PNvoc7oab2ZPOg4ajRWOf5w==
X-Received: by 2002:a5d:6706:0:b0:241:cf90:ab1e with SMTP id
 o6-20020a5d6706000000b00241cf90ab1emr8060343wru.685.1669218568717; 
 Wed, 23 Nov 2022 07:49:28 -0800 (PST)
Received: from redhat.com ([2.52.16.74]) by smtp.gmail.com with ESMTPSA id
 x9-20020a5d6509000000b0023c8026841csm17024927wru.23.2022.11.23.07.49.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Nov 2022 07:49:28 -0800 (PST)
Date: Wed, 23 Nov 2022 10:49:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dawei Li <set_pte_at@outlook.com>
Subject: Re: [PATCH] virtio: sanity check on callback of virtio drivers
Message-ID: <20221123104757-mutt-send-email-mst@kernel.org>
References: <TYCP286MB23234D3251765359630AD72ECA0C9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
In-Reply-To: <TYCP286MB23234D3251765359630AD72ECA0C9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
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

On Wed, Nov 23, 2022 at 11:32:27PM +0800, Dawei Li wrote:
> This commit includes changes below:
> 
> 1 Since register_virtio_driver doesn't force probe & remove
>   to be mandatory callback, so it's caller's job to make the
>   sanity check before invocation.

What's the point of these checks? I don't see how any driver
won't have these set. Why waste memory checking?

> 2 Replace sprintf with sysfs_emit or its variants for their
>   built-in PAGE_SIZE awareness.

this makes sense.

> Signed-off-by: Dawei Li <set_pte_at@outlook.com>
> ---
>  drivers/virtio/virtio.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 828ced060742..e391a8dff333 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -15,7 +15,7 @@ static ssize_t device_show(struct device *_d,
>  			   struct device_attribute *attr, char *buf)
>  {
>  	struct virtio_device *dev = dev_to_virtio(_d);
> -	return sprintf(buf, "0x%04x\n", dev->id.device);
> +	return sysfs_emit(buf, "0x%04x\n", dev->id.device);
>  }
>  static DEVICE_ATTR_RO(device);
>  
> @@ -23,7 +23,7 @@ static ssize_t vendor_show(struct device *_d,
>  			   struct device_attribute *attr, char *buf)
>  {
>  	struct virtio_device *dev = dev_to_virtio(_d);
> -	return sprintf(buf, "0x%04x\n", dev->id.vendor);
> +	return sysfs_emit(buf, "0x%04x\n", dev->id.vendor);
>  }
>  static DEVICE_ATTR_RO(vendor);
>  
> @@ -31,7 +31,7 @@ static ssize_t status_show(struct device *_d,
>  			   struct device_attribute *attr, char *buf)
>  {
>  	struct virtio_device *dev = dev_to_virtio(_d);
> -	return sprintf(buf, "0x%08x\n", dev->config->get_status(dev));
> +	return sysfs_emit(buf, "0x%08x\n", dev->config->get_status(dev));
>  }
>  static DEVICE_ATTR_RO(status);
>  
> @@ -39,7 +39,7 @@ static ssize_t modalias_show(struct device *_d,
>  			     struct device_attribute *attr, char *buf)
>  {
>  	struct virtio_device *dev = dev_to_virtio(_d);
> -	return sprintf(buf, "virtio:d%08Xv%08X\n",
> +	return sysfs_emit(buf, "virtio:d%08Xv%08X\n",
>  		       dev->id.device, dev->id.vendor);
>  }
>  static DEVICE_ATTR_RO(modalias);
> @@ -54,9 +54,9 @@ static ssize_t features_show(struct device *_d,
>  	/* We actually represent this as a bitstring, as it could be
>  	 * arbitrary length in future. */
>  	for (i = 0; i < sizeof(dev->features)*8; i++)
> -		len += sprintf(buf+len, "%c",
> +		len += sysfs_emit_at(buf, len, "%c",
>  			       __virtio_test_bit(dev, i) ? '1' : '0');
> -	len += sprintf(buf+len, "\n");
> +	len += sysfs_emit_at(buf, len, "\n");
>  	return len;
>  }
>  static DEVICE_ATTR_RO(features);
> @@ -302,9 +302,11 @@ static int virtio_dev_probe(struct device *_d)
>  	if (err)
>  		goto err;
>  
> -	err = drv->probe(dev);
> -	if (err)
> -		goto err;
> +	if (drv->probe) {
> +		err = drv->probe(dev);
> +		if (err)
> +			goto err;
> +	}
>  
>  	/* If probe didn't do it, mark device DRIVER_OK ourselves. */
>  	if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
> @@ -329,7 +331,8 @@ static void virtio_dev_remove(struct device *_d)
>  
>  	virtio_config_disable(dev);
>  
> -	drv->remove(dev);
> +	if (drv->remove)
> +		drv->remove(dev);
>  
>  	/* Driver should have reset device. */
>  	WARN_ON_ONCE(dev->config->get_status(dev));
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
