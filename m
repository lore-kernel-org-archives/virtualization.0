Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C361527B8
	for <virtualization@lists.linux.dev>; Tue,  9 Jul 2024 08:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720512839; cv=none; b=eDTwcYc4RyKtXkux2W8iw4+VHk5v1yBYBiwk9msFRpObm9lNPBWrss7A0Hnliu3UuC12B4gBbNP8lONZtF+Lho7WsGUFKGePuIOKXFm1qztfXFD0anWq3tMSyB705Ds1RUE69teptORsUo5qIypRm4TE8JhCQeK2e3qI4ws6KD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720512839; c=relaxed/simple;
	bh=oJ8hh/8t4vsjU+ysZF9EeLCSM6YbX2RXOLNAbTgTtr0=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=KC2luQUI9I4orp7MJkqYStNI4I6gA8sd/Jdxz9nzup8g/kcAXgXX26NM45zL8AtHOjue8qziOkjBacOaTKmy4scsYvrEigzb2jtqG19ix9BFsC0dFaikHti9ACd566pwgwFuSK1LjFtTftzuf1idV6yaOCEGShDMua7KamO2Kmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AU3CebR2; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AU3CebR2"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720512828; h=Message-ID:Subject:Date:From:To;
	bh=cU7A1IzavM9ch2++8WnhmaPS8oMLehuFnhF2+Q5ihsg=;
	b=AU3CebR2gW8EO1xnKpEjgZkJU2OlGRJRze1bQ6mNycs4W+RTUXMJdJwhQQfZ4nvbx2vBy8D4E0ixpnlYpkAmG6dJJCqgPC3jJrDtOjnF9Dc7sYPFlUyhIp+qt1ZBYTV9IMPiKDqS0A8OTzV2Nsr+K8bORbzTl0/xxLmOEHlA1kE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045220184;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0WABApQw_1720512826;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WABApQw_1720512826)
          by smtp.aliyun-inc.com;
          Tue, 09 Jul 2024 16:13:48 +0800
Message-ID: <1720512816.0395122-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v3 1/3] virtio: rename virtio_config_enabled to virtio_config_core_enabled
Date: Tue, 9 Jul 2024 16:13:36 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 netdev@vger.kernel.org,
 Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>,
 "Gia-Khanh Nguyen" <gia-khanh.nguyen@oracle.com>,
 mst@redhat.com,
 jasowang@redhat.com,
 eperezma@redhat.com
References: <20240709080214.9790-1-jasowang@redhat.com>
 <20240709080214.9790-2-jasowang@redhat.com>
In-Reply-To: <20240709080214.9790-2-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Tue,  9 Jul 2024 16:02:12 +0800, Jason Wang <jasowang@redhat.com> wrote:
> Following patch will allow the config interrupt to be disabled by a
> specific driver via another boolean. So this patch renames
> virtio_config_enabled and relevant helpers to
> virtio_config_core_enabled.
>
> Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Thanks.

> ---
>  drivers/virtio/virtio.c | 22 +++++++++++-----------
>  include/linux/virtio.h  |  4 ++--
>  2 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index b968b2aa5f4d..73bab89b5326 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -127,7 +127,7 @@ static void __virtio_config_changed(struct virtio_device *dev)
>  {
>  	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
>
> -	if (!dev->config_enabled)
> +	if (!dev->config_core_enabled)
>  		dev->config_change_pending = true;
>  	else if (drv && drv->config_changed)
>  		drv->config_changed(dev);
> @@ -143,17 +143,17 @@ void virtio_config_changed(struct virtio_device *dev)
>  }
>  EXPORT_SYMBOL_GPL(virtio_config_changed);
>
> -static void virtio_config_disable(struct virtio_device *dev)
> +static void virtio_config_core_disable(struct virtio_device *dev)
>  {
>  	spin_lock_irq(&dev->config_lock);
> -	dev->config_enabled = false;
> +	dev->config_core_enabled = false;
>  	spin_unlock_irq(&dev->config_lock);
>  }
>
> -static void virtio_config_enable(struct virtio_device *dev)
> +static void virtio_config_core_enable(struct virtio_device *dev)
>  {
>  	spin_lock_irq(&dev->config_lock);
> -	dev->config_enabled = true;
> +	dev->config_core_enabled = true;
>  	if (dev->config_change_pending)
>  		__virtio_config_changed(dev);
>  	dev->config_change_pending = false;
> @@ -322,7 +322,7 @@ static int virtio_dev_probe(struct device *_d)
>  	if (drv->scan)
>  		drv->scan(dev);
>
> -	virtio_config_enable(dev);
> +	virtio_config_core_enable(dev);
>
>  	return 0;
>
> @@ -340,7 +340,7 @@ static void virtio_dev_remove(struct device *_d)
>  	struct virtio_device *dev = dev_to_virtio(_d);
>  	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
>
> -	virtio_config_disable(dev);
> +	virtio_config_core_disable(dev);
>
>  	drv->remove(dev);
>
> @@ -455,7 +455,7 @@ int register_virtio_device(struct virtio_device *dev)
>  		goto out_ida_remove;
>
>  	spin_lock_init(&dev->config_lock);
> -	dev->config_enabled = false;
> +	dev->config_core_enabled = false;
>  	dev->config_change_pending = false;
>
>  	INIT_LIST_HEAD(&dev->vqs);
> @@ -512,14 +512,14 @@ int virtio_device_freeze(struct virtio_device *dev)
>  	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
>  	int ret;
>
> -	virtio_config_disable(dev);
> +	virtio_config_core_disable(dev);
>
>  	dev->failed = dev->config->get_status(dev) & VIRTIO_CONFIG_S_FAILED;
>
>  	if (drv && drv->freeze) {
>  		ret = drv->freeze(dev);
>  		if (ret) {
> -			virtio_config_enable(dev);
> +			virtio_config_core_enable(dev);
>  			return ret;
>  		}
>  	}
> @@ -578,7 +578,7 @@ int virtio_device_restore(struct virtio_device *dev)
>  	if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
>  		virtio_device_ready(dev);
>
> -	virtio_config_enable(dev);
> +	virtio_config_core_enable(dev);
>
>  	return 0;
>
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 96fea920873b..a6f6df72f01a 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -115,7 +115,7 @@ struct virtio_admin_cmd {
>   * struct virtio_device - representation of a device using virtio
>   * @index: unique position on the virtio bus
>   * @failed: saved value for VIRTIO_CONFIG_S_FAILED bit (for restore)
> - * @config_enabled: configuration change reporting enabled
> + * @config_core_enabled: configuration change reporting enabled by core
>   * @config_change_pending: configuration change reported while disabled
>   * @config_lock: protects configuration change reporting
>   * @vqs_list_lock: protects @vqs.
> @@ -132,7 +132,7 @@ struct virtio_admin_cmd {
>  struct virtio_device {
>  	int index;
>  	bool failed;
> -	bool config_enabled;
> +	bool config_core_enabled;
>  	bool config_change_pending;
>  	spinlock_t config_lock;
>  	spinlock_t vqs_list_lock;
> --
> 2.31.1
>
