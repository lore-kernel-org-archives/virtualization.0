Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B41FC77B73
	for <virtualization@archiver.kernel.org>; Sun, 30 Apr 2023 13:27:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 35C4D403D6;
	Sun, 30 Apr 2023 13:27:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 35C4D403D6
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JX52VvI6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I0_j89XSmnWT; Sun, 30 Apr 2023 13:27:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 67C3640017;
	Sun, 30 Apr 2023 13:27:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 67C3640017
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FA38C0037;
	Sun, 30 Apr 2023 13:27:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93432C002A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Apr 2023 13:27:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 677F883C64
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Apr 2023 13:27:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 677F883C64
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JX52VvI6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2PtB6Zsn7g6p
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Apr 2023 13:27:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F388783C32
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F388783C32
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Apr 2023 13:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682861252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ByfksgfAfk/uxpL9BVE+5FLntDZWZHVF8lQ+xy8gE0M=;
 b=JX52VvI6F8464GKqZvZjeX9/yTR2ky5KHilUCWpb4xCgT1cS4OcCrzfy9dS5qGefdqUJq5
 QZ3BbC1mtaQ8ckyeDQdYi+Q8dwSlZNSLvmh5qjIE2CJpSLlQeJT+5BYC3lT4KGjQ5gn1Qg
 IhPQv53BYe4kkhWXLl/61MiglBG2twQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-TOF4goQ6OnChGwOgp2b0CA-1; Sun, 30 Apr 2023 09:27:28 -0400
X-MC-Unique: TOF4goQ6OnChGwOgp2b0CA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f1749c63c9so4248785e9.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Apr 2023 06:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682861247; x=1685453247;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ByfksgfAfk/uxpL9BVE+5FLntDZWZHVF8lQ+xy8gE0M=;
 b=M5WBAdi59uqRO1KU51JTB9Ta1r9dEkd0VLP1GACB/7wYMN3Ts+DIlLfWQB6/SfSwCU
 40n+DR+3cC/heH/7nJzF1bTuufduWWg8v/jtz80YhagffMXR1eLYnovbOfStByoqk+87
 HWYtMO+3y0xoscC0tzybtoN+hQQjl3DtMFig2UPrLr/WT4CpVIgSbI750irBZdT/RowS
 8V8qnqelhu2k7jPkmLN5BTUE0N3cKoYT9mM1NVBhjsLikW2ndKGuk3qjMMuoxrRSM56z
 8a1wf175qq6xtM4El//P1AtNo5hRlTuvaHUXuxpCoUjvjRB0RI+1/XhBgv8qlAYUuX5b
 wvSQ==
X-Gm-Message-State: AC+VfDzoirBhWT7hZw0QbYis9NyCIAgzvItZKWaD5z5AzrRJCJTOD1C3
 cAOQpH6hNKcC8BK17PAY5mQ4ed5z+I6zK4vwSk5yq1pCO5thfEhkWTg4BGw0q0JVyv915QNsQ5W
 j9Bw+OLoLCyEjnY3c3I24y01Z9WAIUOeY+M9KwiG0sw==
X-Received: by 2002:a7b:c015:0:b0:3f1:662a:93d0 with SMTP id
 c21-20020a7bc015000000b003f1662a93d0mr8322127wmb.15.1682861247612; 
 Sun, 30 Apr 2023 06:27:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ETv6GryHgo+COy+D101D1I+zk9PjXqylCJcECyfbSbp4HpTMUDiTN0979D6XmXqcM12ZLdg==
X-Received: by 2002:a7b:c015:0:b0:3f1:662a:93d0 with SMTP id
 c21-20020a7bc015000000b003f1662a93d0mr8322115wmb.15.1682861247234; 
 Sun, 30 Apr 2023 06:27:27 -0700 (PDT)
Received: from redhat.com ([2.52.139.131]) by smtp.gmail.com with ESMTPSA id
 x8-20020a05600c21c800b003f2390bdd0csm21102744wmj.32.2023.04.30.06.27.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Apr 2023 06:27:26 -0700 (PDT)
Date: Sun, 30 Apr 2023 09:27:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [RFC PATCH net 1/3] virtio: re-negotiate features if probe fails
 and features are blocked
Message-ID: <20230430092142-mutt-send-email-mst@kernel.org>
References: <20230430131518.2708471-1-alvaro.karsz@solid-run.com>
 <20230430131518.2708471-2-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
In-Reply-To: <20230430131518.2708471-2-alvaro.karsz@solid-run.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

On Sun, Apr 30, 2023 at 04:15:16PM +0300, Alvaro Karsz wrote:
> This patch exports a new virtio core function: virtio_block_feature.
> The function should be called during a virtio driver probe.
> 
> If a virtio driver blocks features during probe and fails probe, virtio
> core will reset the device, try to re-negotiate the new features and
> probe again.
> 
> Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
> ---
>  drivers/virtio/virtio.c | 73 ++++++++++++++++++++++++++++++-----------
>  include/linux/virtio.h  |  3 ++
>  2 files changed, 56 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 3893dc29eb2..eaad5b6a7a9 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -167,6 +167,13 @@ void virtio_add_status(struct virtio_device *dev, unsigned int status)
>  }
>  EXPORT_SYMBOL_GPL(virtio_add_status);
>  
> +void virtio_block_feature(struct virtio_device *dev, unsigned int f)
> +{
> +	BUG_ON(f >= 64);
> +	dev->blocked_features |= (1ULL << f);
> +}
> +EXPORT_SYMBOL_GPL(virtio_block_feature);
> +

Let's add documentation please. Also pls call it __virtio_block_feature
since it has to be used in a special way - specifically only during
probe.

>  /* Do some validation, then set FEATURES_OK */
>  static int virtio_features_ok(struct virtio_device *dev)
>  {
> @@ -234,17 +241,13 @@ void virtio_reset_device(struct virtio_device *dev)
>  }
>  EXPORT_SYMBOL_GPL(virtio_reset_device);
>  
> -static int virtio_dev_probe(struct device *_d)
> +static int virtio_negotiate_features(struct virtio_device *dev)
>  {
> -	int err, i;
> -	struct virtio_device *dev = dev_to_virtio(_d);
>  	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
>  	u64 device_features;
>  	u64 driver_features;
>  	u64 driver_features_legacy;
> -
> -	/* We have a driver! */
> -	virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER);
> +	int i, ret;
>  
>  	/* Figure out what features the device supports. */
>  	device_features = dev->config->get_features(dev);
> @@ -279,30 +282,61 @@ static int virtio_dev_probe(struct device *_d)
>  		if (device_features & (1ULL << i))
>  			__virtio_set_bit(dev, i);
>  
> -	err = dev->config->finalize_features(dev);
> -	if (err)
> -		goto err;
> +	/* Remove blocked features */
> +	dev->features &= ~dev->blocked_features;
> +
> +	ret = dev->config->finalize_features(dev);
> +	if (ret)
> +		goto exit;
>  
>  	if (drv->validate) {
>  		u64 features = dev->features;
>  
> -		err = drv->validate(dev);
> -		if (err)
> -			goto err;
> +		ret = drv->validate(dev);
> +		if (ret)
> +			goto exit;
>  
>  		/* Did validation change any features? Then write them again. */
>  		if (features != dev->features) {
> -			err = dev->config->finalize_features(dev);
> -			if (err)
> -				goto err;
> +			ret = dev->config->finalize_features(dev);
> +			if (ret)
> +				goto exit;
>  		}
>  	}
>  
> -	err = virtio_features_ok(dev);
> -	if (err)
> -		goto err;
> +	ret = virtio_features_ok(dev);
> +exit:
> +	return ret;
> +}
> +
> +static int virtio_dev_probe(struct device *_d)
> +{
> +	int err;
> +	struct virtio_device *dev = dev_to_virtio(_d);
> +	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
> +	u64 blocked_features;
> +	bool renegotiate = true;
> +
> +	/* We have a driver! */
> +	virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER);
> +
> +	/* Store blocked features and attempt to negotiate features & probe.
> +	 * If the probe fails, we check if the driver has blocked any new features.
> +	 * If it has, we reset the device and try again with the new features.
> +	 */
> +	while (renegotiate) {
> +		blocked_features = dev->blocked_features;
> +		err = virtio_negotiate_features(dev);
> +		if (err)
> +			break;
> +
> +		err = drv->probe(dev);


there's no way to driver to clear blocked features, but
just in case, I'd add BUG_ON to check.

> +		if (err && blocked_features != dev->blocked_features)
> +			virtio_reset_device(dev);
> +		else
> +			renegotiate = false;
> +	}
>  
> -	err = drv->probe(dev);
>  	if (err)
>  		goto err;
>  
> @@ -319,7 +353,6 @@ static int virtio_dev_probe(struct device *_d)
>  err:
>  	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
>  	return err;
> -
>  }
>  
>  static void virtio_dev_remove(struct device *_d)
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index b93238db94e..2de9b2d3ca4 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -109,6 +109,7 @@ int virtqueue_resize(struct virtqueue *vq, u32 num,
>   * @vringh_config: configuration ops for host vrings.
>   * @vqs: the list of virtqueues for this device.
>   * @features: the features supported by both driver and device.
> + * @blocked_features: the features blocked by the driver that can't be negotiated.
>   * @priv: private pointer for the driver's use.
>   */
>  struct virtio_device {
> @@ -124,6 +125,7 @@ struct virtio_device {
>  	const struct vringh_config_ops *vringh_config;
>  	struct list_head vqs;
>  	u64 features;
> +	u64 blocked_features;

add comment here too, explain purpose and rules of use

>  	void *priv;
>  };
>  
> @@ -133,6 +135,7 @@ void virtio_add_status(struct virtio_device *dev, unsigned int status);
>  int register_virtio_device(struct virtio_device *dev);
>  void unregister_virtio_device(struct virtio_device *dev);
>  bool is_virtio_device(struct device *dev);
> +void virtio_block_feature(struct virtio_device *dev, unsigned int f);
>  
>  void virtio_break_device(struct virtio_device *dev);
>  void __virtio_unbreak_device(struct virtio_device *dev);
> -- 
> 2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
