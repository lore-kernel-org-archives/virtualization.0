Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5145C433EF
	for <virtualization@archiver.kernel.org>; Mon, 16 May 2022 08:32:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5ACCE81DB2;
	Mon, 16 May 2022 08:32:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fIsMC0f4TT_3; Mon, 16 May 2022 08:32:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BB03B819F3;
	Mon, 16 May 2022 08:32:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81977C0032;
	Mon, 16 May 2022 08:32:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3B24C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 08:32:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E0D03819F3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 08:32:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yfsJaa2-pBRV
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 08:32:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 75D1A81831
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 08:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652689937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FCx42Bs4MM+HvQYIekC/oYYamn07ylbJYiU4tVHGnwM=;
 b=AGPGBHhQBjWvyMmaq0lvFXXu26KPoYksTxbCsl9PJLQqOALnUKLRogUss/RYjgIO2TXz3N
 hmdsZ7qFZ5lOq/vdqeQ70Ta6mDZ/0SU/P3letiZ/3chzxerXE21StXHZMfTAnIbceEcBWY
 vzZn+ucyCwwjRXlSwUI5qiA8XzR4HtI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-172-arH4WH9dNJ-I9NYAGr0x3Q-1; Mon, 16 May 2022 04:32:16 -0400
X-MC-Unique: arH4WH9dNJ-I9NYAGr0x3Q-1
Received: by mail-wr1-f72.google.com with SMTP id
 e11-20020adffc4b000000b0020d059c2347so312894wrs.18
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 01:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FCx42Bs4MM+HvQYIekC/oYYamn07ylbJYiU4tVHGnwM=;
 b=NDv1aqoN4suUSBJ5feHjah/tvKGa/pcDnwdG6fWM6LRZeILsrOeS/XAtlN+Ye+PxBZ
 VwwMWVjEayK2jV6rouikruPle77fZ8kMaUDPkr8RUZ3kXRL9+J5zAJTaaHU6EtYjqkfz
 1ZVgFaoi/3gb48ynlUZglg5G82sCmHnVJlKKqWM0mlfq5acXFUke69CfQb5B6FegRi8U
 2/WAON+laPlwKOYNK6VxZKTgO87o8MQxwxvAwFGfLSN8qnLHop+WHYY2m5fQLJsh9hdC
 feuKWxmLb0rfH+z11d8sn57uC8vqkj87Uv1ofhwpTzziGnS6lyHVc2pDBqsiyHrCOFog
 d/Rw==
X-Gm-Message-State: AOAM53076citeCw/o1pMaEzmF1SJSZ2vy6M/WZFUv/MOJ0YcgXBjY+Fn
 57pLY54YXUXAuibJS4l5WzJffMzqH83QOsDyyJuNo7G8jEnWFkFh2cB+SI4YQH5xs3DQs+/1xk2
 +Dpvqf1JC5tpQmSLIYsd+VW0OPv1bvilUTEwPmIUh4Q==
X-Received: by 2002:a05:600c:1986:b0:394:867f:984c with SMTP id
 t6-20020a05600c198600b00394867f984cmr26094713wmq.20.1652689934804; 
 Mon, 16 May 2022 01:32:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqnCoLAYI9Stoy6C6SjMV18R+Z5Kw4Es5GrMl1y+qUcql9LONa6kWArCc0JBw3uMUwIAjVFQ==
X-Received: by 2002:a05:600c:1986:b0:394:867f:984c with SMTP id
 t6-20020a05600c198600b00394867f984cmr26094690wmq.20.1652689934501; 
 Mon, 16 May 2022 01:32:14 -0700 (PDT)
Received: from redhat.com ([2.55.141.66]) by smtp.gmail.com with ESMTPSA id
 j8-20020adfb308000000b0020d0cdbf7eesm1117604wrd.111.2022.05.16.01.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 May 2022 01:32:14 -0700 (PDT)
Date: Mon, 16 May 2022 04:32:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH v2 2/3] vdpa: Add a device object for vdpa management
 device
Message-ID: <20220516042442-mutt-send-email-mst@kernel.org>
References: <20220516060342.106-1-xieyongji@bytedance.com>
 <20220516060342.106-2-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20220516060342.106-2-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: gregkh@linuxfoundation.org, virtualization@lists.linux-foundation.org,
 lingshan.zhu@intel.com, elic@nvidia.com
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

On Mon, May 16, 2022 at 02:03:41PM +0800, Xie Yongji wrote:
> Introduce a device object for vdpa management device to control
> its lifecycle. And the device name will be used to match
> VDPA_ATTR_MGMTDEV_DEV_NAME field of netlink message rather than
> using parent device name.
> 
> With this patch applied, drivers should use vdpa_mgmtdev_alloc()
> or _vdpa_mgmtdev_alloc() to allocate a vDPA management device
> before calling vdpa_mgmtdev_register(). And some buggy empty
> release function can also be removed from the driver codes.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/vdpa/ifcvf/ifcvf_main.c      | 11 ++--
>  drivers/vdpa/mlx5/net/mlx5_vnet.c    | 11 ++--
>  drivers/vdpa/vdpa.c                  | 92 ++++++++++++++++++++++++----
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 39 ++++--------
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 46 +++++---------
>  drivers/vdpa/vdpa_user/vduse_dev.c   | 38 ++++--------
>  include/linux/vdpa.h                 | 38 +++++++++++-
>  7 files changed, 168 insertions(+), 107 deletions(-)
> 
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> index 4366320fb68d..d4087c37cfdf 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -821,10 +821,11 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	u32 dev_type;
>  	int ret;
>  
> -	ifcvf_mgmt_dev = kzalloc(sizeof(struct ifcvf_vdpa_mgmt_dev), GFP_KERNEL);
> -	if (!ifcvf_mgmt_dev) {
> +	ifcvf_mgmt_dev = vdpa_mgmtdev_alloc(struct ifcvf_vdpa_mgmt_dev,
> +					    mdev, dev_name(dev), dev);
> +	if (IS_ERR(ifcvf_mgmt_dev)) {
>  		IFCVF_ERR(pdev, "Failed to alloc memory for the vDPA management device\n");
> -		return -ENOMEM;
> +		return PTR_ERR(ifcvf_mgmt_dev);
>  	}
>  
>  	dev_type = get_dev_type(pdev);
> @@ -842,7 +843,6 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	}
>  
>  	ifcvf_mgmt_dev->mdev.ops = &ifcvf_vdpa_mgmt_dev_ops;
> -	ifcvf_mgmt_dev->mdev.device = dev;
>  	ifcvf_mgmt_dev->pdev = pdev;
>  
>  	ret = pcim_enable_device(pdev);
> @@ -883,7 +883,7 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	return 0;
>  
>  err:
> -	kfree(ifcvf_mgmt_dev);
> +	put_device(&ifcvf_mgmt_dev->mdev.device);
>  	return ret;
>  }
>  
> @@ -893,7 +893,6 @@ static void ifcvf_remove(struct pci_dev *pdev)
>  
>  	ifcvf_mgmt_dev = pci_get_drvdata(pdev);
>  	vdpa_mgmtdev_unregister(&ifcvf_mgmt_dev->mdev);
> -	kfree(ifcvf_mgmt_dev);
>  }
>  
>  static struct pci_device_id ifcvf_pci_ids[] = {
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 79001301b383..3a88609dcf13 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2828,12 +2828,12 @@ static int mlx5v_probe(struct auxiliary_device *adev,
>  	struct mlx5_vdpa_mgmtdev *mgtdev;
>  	int err;
>  
> -	mgtdev = kzalloc(sizeof(*mgtdev), GFP_KERNEL);
> -	if (!mgtdev)
> -		return -ENOMEM;
> +	mgtdev = vdpa_mgmtdev_alloc(struct mlx5_vdpa_mgmtdev, mgtdev,
> +				    dev_name(mdev->device), mdev->device);
> +	if (IS_ERR(mgtdev))
> +		return PTR_ERR(mgtdev);
>  
>  	mgtdev->mgtdev.ops = &mdev_ops;
> -	mgtdev->mgtdev.device = mdev->device;
>  	mgtdev->mgtdev.id_table = id_table;
>  	mgtdev->mgtdev.config_attr_mask = BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR) |
>  					  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP) |
> @@ -2852,7 +2852,7 @@ static int mlx5v_probe(struct auxiliary_device *adev,
>  	return 0;
>  
>  reg_err:
> -	kfree(mgtdev);
> +	put_device(&mgtdev->mgtdev.device);
>  	return err;
>  }
>  
> @@ -2862,7 +2862,6 @@ static void mlx5v_remove(struct auxiliary_device *adev)
>  
>  	mgtdev = auxiliary_get_drvdata(adev);
>  	vdpa_mgmtdev_unregister(&mgtdev->mgtdev);
> -	kfree(mgtdev);
>  }
>  
>  static const struct auxiliary_device_id mlx5v_id_table[] = {
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 2b75c00b1005..3d3f98dd2bb6 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -337,21 +337,80 @@ void vdpa_unregister_driver(struct vdpa_driver *drv)
>  }
>  EXPORT_SYMBOL_GPL(vdpa_unregister_driver);
>  
> +static inline struct vdpa_mgmt_dev *to_vdpa_mgmt_dev(struct device *dev)
> +{
> +	return container_of(dev, struct vdpa_mgmt_dev, device);
> +}
> +
> +static void vdpa_mgmtdev_release(struct device *dev)
> +{
> +	kfree(to_vdpa_mgmt_dev(dev));
> +}
> +
>  /**
> - * vdpa_mgmtdev_register - register a vdpa management device
> + * __vdpa_mgmtdev_alloc - allocate and initilaize a vDPA management device

initialize


> + * @name: name of the vdpa management device
> + * @parent: the parent device; optional
> + * @size: size of the data structure that might contain private datia
> + *
> + * Driver should use vdpa_mgmtdev_alloc() or _vdpa_mgmtdev_alloc() wrapper
> + * macro instead of using this directly.

-> do not call this directly, use vdpa_mgmtdev_alloc or _vdpa_mgmtdev_alloc
wrappers instead.

>   *
> + * Return: Return allocated data structure or ERR_PTR upon error
> + */
> +struct vdpa_mgmt_dev *__vdpa_mgmtdev_alloc(const char *name,
> +					   struct device *parent,
> +					   size_t size)
> +{
> +	struct vdpa_mgmt_dev *dev;
> +	int ret = -EINVAL;
> +
> +	if (!name)
> +		goto err;
> +
> +	ret = -ENOMEM;

well it seems this is always ENOMEM, you can just do
	return ERR_PTR(-ENOMEM);

> +	dev = kzalloc(size, GFP_KERNEL);
> +	if (!dev)
> +		goto err;
> +
> +	INIT_LIST_HEAD(&dev->list);
> +	dev->device.parent = parent;
> +	dev->device.release = vdpa_mgmtdev_release;
> +	ret = dev_set_name(&dev->device, "%s", name);
> +	if (ret)
> +		goto err_name;
> +
> +	device_initialize(&dev->device);
> +	return dev;
> +err_name:
> +	kfree(dev);
> +err:
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(__vdpa_mgmtdev_alloc);
> +
> +/**
> + * vdpa_mgmtdev_register - register a vdpa management device
>   * @mdev: Pointer to vdpa management device
> + *
>   * vdpa_mgmtdev_register() register a vdpa management device which supports

btw repeating vdpa_mgmtdev_register() is not useful. just start with
Register

> - * vdpa device management.
> - * Return: Returns 0 on success or failure when required callback ops are not
> - *         initialized.
> + * vdpa device management. Caller must have a succeed call of vdpa_mgmtdev_alloc()
> + * or _vdpa_mgmtdev_alloc() before.

->
@mdev: Pointer to a vdpa management device, received from a previous
	successful call to vdpa_mgmtdev_alloc or _vdpa_mgmtdev_alloc.

> + *
> + * Return: Returns 0 on success or failure when device is failed to be added


is failed to be added -> on failure to add the device

> + *         or required callback ops are not initialized.
>   */
>  int vdpa_mgmtdev_register(struct vdpa_mgmt_dev *mdev)
>  {
> -	if (!mdev->device || !mdev->ops || !mdev->ops->dev_add || !mdev->ops->dev_del)
> +	int ret;
> +
> +	if (!mdev->ops || !mdev->ops->dev_add || !mdev->ops->dev_del)
>  		return -EINVAL;
>  
> -	INIT_LIST_HEAD(&mdev->list);
> +	ret = device_add(&mdev->device);
> +	if (ret)
> +		return ret;
> +
>  	mutex_lock(&vdpa_dev_mutex);
>  	list_add_tail(&mdev->list, &mdev_head);
>  	mutex_unlock(&vdpa_dev_mutex);
> @@ -379,6 +438,8 @@ void vdpa_mgmtdev_unregister(struct vdpa_mgmt_dev *mdev)
>  	bus_for_each_dev(&vdpa_bus, NULL, mdev, vdpa_match_remove);
>  
>  	mutex_unlock(&vdpa_dev_mutex);
> +
> +	device_unregister(&mdev->device);
>  }
>  EXPORT_SYMBOL_GPL(vdpa_mgmtdev_unregister);
>  
> @@ -432,17 +493,20 @@ EXPORT_SYMBOL_GPL(vdpa_set_config);
>  static bool mgmtdev_handle_match(const struct vdpa_mgmt_dev *mdev,
>  				 const char *busname, const char *devname)
>  {
> +	struct bus_type *bus = mdev->device.parent ?
> +				mdev->device.parent->bus : NULL;
> +
>  	/* Bus name is optional for simulated management device, so ignore the
>  	 * device with bus if bus attribute is provided.
>  	 */
> -	if ((busname && !mdev->device->bus) || (!busname && mdev->device->bus))
> +	if ((busname && !bus) || (!busname && bus))
>  		return false;
>  
> -	if (!busname && strcmp(dev_name(mdev->device), devname) == 0)
> +	if (!busname && strcmp(dev_name(&mdev->device), devname) == 0)
>  		return true;
>  
> -	if (busname && (strcmp(mdev->device->bus->name, busname) == 0) &&
> -	    (strcmp(dev_name(mdev->device), devname) == 0))
> +	if (busname && (strcmp(bus->name, busname) == 0) &&
> +	    (strcmp(dev_name(&mdev->device), devname) == 0))
>  		return true;
>  
>  	return false;
> @@ -469,10 +533,12 @@ static struct vdpa_mgmt_dev *vdpa_mgmtdev_get_from_attr(struct nlattr **attrs)
>  
>  static int vdpa_nl_mgmtdev_handle_fill(struct sk_buff *msg, const struct vdpa_mgmt_dev *mdev)
>  {
> -	if (mdev->device->bus &&
> -	    nla_put_string(msg, VDPA_ATTR_MGMTDEV_BUS_NAME, mdev->device->bus->name))
> +	struct bus_type *bus = mdev->device.parent ?
> +				mdev->device.parent->bus : NULL;
> +
> +	if (bus && nla_put_string(msg, VDPA_ATTR_MGMTDEV_BUS_NAME, bus->name))
>  		return -EMSGSIZE;
> -	if (nla_put_string(msg, VDPA_ATTR_MGMTDEV_DEV_NAME, dev_name(mdev->device)))
> +	if (nla_put_string(msg, VDPA_ATTR_MGMTDEV_DEV_NAME, dev_name(&mdev->device)))
>  		return -EMSGSIZE;
>  	return 0;
>  }
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> index 42d401d43911..e48b061b6c1b 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> @@ -239,15 +239,6 @@ static void vdpasim_blk_get_config(struct vdpasim *vdpasim, void *config)
>  	blk_config->blk_size = cpu_to_vdpasim32(vdpasim, SECTOR_SIZE);
>  }
>  
> -static void vdpasim_blk_mgmtdev_release(struct device *dev)
> -{
> -}
> -
> -static struct device vdpasim_blk_mgmtdev = {
> -	.init_name = "vdpasim_blk",
> -	.release = vdpasim_blk_mgmtdev_release,
> -};
> -
>  static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>  			       const struct vdpa_dev_set_config *config)
>  {
> @@ -298,35 +289,31 @@ static struct virtio_device_id id_table[] = {
>  	{ 0 },
>  };
>  
> -static struct vdpa_mgmt_dev mgmt_dev = {
> -	.device = &vdpasim_blk_mgmtdev,
> -	.id_table = id_table,
> -	.ops = &vdpasim_blk_mgmtdev_ops,
> -};
> +static struct vdpa_mgmt_dev *mgmt_dev;
>  
>  static int __init vdpasim_blk_init(void)
>  {
>  	int ret;
>  
> -	ret = device_register(&vdpasim_blk_mgmtdev);
> -	if (ret)
> -		return ret;
> +	mgmt_dev = _vdpa_mgmtdev_alloc("vdpasim_blk", NULL);
> +	if (IS_ERR(mgmt_dev))
> +		return PTR_ERR(mgmt_dev);
>  
> -	ret = vdpa_mgmtdev_register(&mgmt_dev);
> -	if (ret)
> -		goto parent_err;
> +	mgmt_dev->id_table = id_table;
> +	mgmt_dev->ops = &vdpasim_blk_mgmtdev_ops;
>  
> -	return 0;
> +	ret = vdpa_mgmtdev_register(mgmt_dev);
> +	if (ret) {
> +		put_device(&mgmt_dev->device);
> +		return ret;
> +	}
>  
> -parent_err:
> -	device_unregister(&vdpasim_blk_mgmtdev);
> -	return ret;
> +	return 0;
>  }
>  
>  static void __exit vdpasim_blk_exit(void)
>  {
> -	vdpa_mgmtdev_unregister(&mgmt_dev);
> -	device_unregister(&vdpasim_blk_mgmtdev);
> +	vdpa_mgmtdev_unregister(mgmt_dev);
>  }
>  
>  module_init(vdpasim_blk_init)
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> index d5324f6fd8c7..1adb26f8ac32 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> @@ -124,15 +124,6 @@ static void vdpasim_net_setup_config(struct vdpasim *vdpasim,
>  		vio_config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
>  }
>  
> -static void vdpasim_net_mgmtdev_release(struct device *dev)
> -{
> -}
> -
> -static struct device vdpasim_net_mgmtdev = {
> -	.init_name = "vdpasim_net",
> -	.release = vdpasim_net_mgmtdev_release,
> -};
> -
>  static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>  			       const struct vdpa_dev_set_config *config)
>  {
> @@ -185,38 +176,35 @@ static struct virtio_device_id id_table[] = {
>  	{ 0 },
>  };
>  
> -static struct vdpa_mgmt_dev mgmt_dev = {
> -	.device = &vdpasim_net_mgmtdev,
> -	.id_table = id_table,
> -	.ops = &vdpasim_net_mgmtdev_ops,
> -	.config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR |
> -			     1 << VDPA_ATTR_DEV_NET_CFG_MTU),
> -	.max_supported_vqs = VDPASIM_NET_VQ_NUM,
> -	.supported_features = VDPASIM_NET_FEATURES,
> -};
> +static struct vdpa_mgmt_dev *mgmt_dev;
>  
>  static int __init vdpasim_net_init(void)
>  {
>  	int ret;
>  
> -	ret = device_register(&vdpasim_net_mgmtdev);
> -	if (ret)
> +	mgmt_dev = _vdpa_mgmtdev_alloc("vdpasim_net", NULL);
> +	if (IS_ERR(mgmt_dev))
> +		return PTR_ERR(mgmt_dev);
> +
> +	mgmt_dev->id_table = id_table;
> +	mgmt_dev->ops = &vdpasim_net_mgmtdev_ops;
> +	mgmt_dev->config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR |
> +				      1 << VDPA_ATTR_DEV_NET_CFG_MTU);
> +	mgmt_dev->max_supported_vqs = VDPASIM_NET_VQ_NUM;
> +	mgmt_dev->supported_features = VDPASIM_NET_FEATURES;
> +
> +	ret = vdpa_mgmtdev_register(mgmt_dev);
> +	if (ret) {
> +		put_device(&mgmt_dev->device);
>  		return ret;
> +	}
>  
> -	ret = vdpa_mgmtdev_register(&mgmt_dev);
> -	if (ret)
> -		goto parent_err;
>  	return 0;
> -
> -parent_err:
> -	device_unregister(&vdpasim_net_mgmtdev);
> -	return ret;
>  }
>  
>  static void __exit vdpasim_net_exit(void)
>  {
> -	vdpa_mgmtdev_unregister(&mgmt_dev);
> -	device_unregister(&vdpasim_net_mgmtdev);
> +	vdpa_mgmtdev_unregister(mgmt_dev);
>  }
>  
>  module_init(vdpasim_net_init);
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index d3bf55a58cd2..aa4b5f6fe674 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1475,15 +1475,6 @@ static char *vduse_devnode(struct device *dev, umode_t *mode)
>  	return kasprintf(GFP_KERNEL, "vduse/%s", dev_name(dev));
>  }
>  
> -static void vduse_mgmtdev_release(struct device *dev)
> -{
> -}
> -
> -static struct device vduse_mgmtdev = {
> -	.init_name = "vduse",
> -	.release = vduse_mgmtdev_release,
> -};
> -
>  static int vduse_dev_init_vdpa(struct vduse_dev *dev,
>  			       struct vdpa_mgmt_dev *mdev, const char *name)
>  {
> @@ -1554,34 +1545,31 @@ static struct virtio_device_id id_table[] = {
>  	{ 0 },
>  };
>  
> -static struct vdpa_mgmt_dev mgmt_dev = {
> -	.device = &vduse_mgmtdev,
> -	.id_table = id_table,
> -	.ops = &vdpa_dev_mgmtdev_ops,
> -};
> +static struct vdpa_mgmt_dev *mgmt_dev;
>  
>  static int vduse_mgmtdev_init(void)
>  {
>  	int ret;
>  
> -	ret = device_register(&vduse_mgmtdev);
> -	if (ret)
> -		return ret;
> +	mgmt_dev = _vdpa_mgmtdev_alloc("vduse", NULL);
> +	if (IS_ERR(mgmt_dev))
> +		return PTR_ERR(mgmt_dev);
>  
> -	ret = vdpa_mgmtdev_register(&mgmt_dev);
> -	if (ret)
> -		goto err;
> +	mgmt_dev->id_table = id_table;
> +	mgmt_dev->ops = &vdpa_dev_mgmtdev_ops;
> +
> +	ret = vdpa_mgmtdev_register(mgmt_dev);
> +	if (ret) {
> +		put_device(&mgmt_dev->device);
> +		return ret;
> +	}
>  
>  	return 0;
> -err:
> -	device_unregister(&vduse_mgmtdev);
> -	return ret;
>  }
>  
>  static void vduse_mgmtdev_exit(void)
>  {
> -	vdpa_mgmtdev_unregister(&mgmt_dev);
> -	device_unregister(&vduse_mgmtdev);
> +	vdpa_mgmtdev_unregister(mgmt_dev);
>  }
>  
>  static int vduse_init(void)
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 8943a209202e..bf82a239a17b 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -453,7 +453,7 @@ struct vdpa_mgmtdev_ops {
>  
>  /**
>   * struct vdpa_mgmt_dev - vdpa management device
> - * @device: Management parent device
> + * @device: Management device
>   * @ops: operations supported by management device
>   * @id_table: Pointer to device id table of supported ids
>   * @config_attr_mask: bit mask of attributes of type enum vdpa_attr that
> @@ -461,7 +461,7 @@ struct vdpa_mgmtdev_ops {
>   * @list: list entry
>   */
>  struct vdpa_mgmt_dev {
> -	struct device *device;
> +	struct device device;
>  	const struct vdpa_mgmtdev_ops *ops;
>  	const struct virtio_device_id *id_table;
>  	u64 config_attr_mask;
> @@ -470,6 +470,40 @@ struct vdpa_mgmt_dev {
>  	u32 max_supported_vqs;
>  };
>  
> +struct vdpa_mgmt_dev *__vdpa_mgmtdev_alloc(const char *name,
> +					   struct device *parent,
> +					   size_t size);
> +
> +/**
> + * vdpa_mgmtdev_alloc - allocate and initilaize a vDPA management device with private data
> + *
> + * @dev_struct: the type of the parent structure
> + * @member: the name of struct vdpa_mgmt_dev within the @dev_struct
> + * @name: name of the vdpa management device
> + * @parent: the parent device
> + *
> + * Return allocated data structure or ERR_PTR upon error

Returns

> + */
> +#define vdpa_mgmtdev_alloc(dev_struct, member, name, parent) \
> +			container_of(__vdpa_mgmtdev_alloc( \
> +				     name, parent, \
> +				     sizeof(dev_struct) + \
> +				     BUILD_BUG_ON_ZERO(offsetof( \
> +				     dev_struct, member))), \
> +				     dev_struct, member)
> +
> +/**
> + * _vdpa_mgmtdev_alloc - allocate and initilaize a vDPA management device
> + *
> + * @name: name of the vdpa management device
> + * @parent: the parent device
> + *
> + * Return vdpa_mgmt_dev structure or ERR_PTR upon error


Returns

> + */
> +#define _vdpa_mgmtdev_alloc(name, parent) \
> +			__vdpa_mgmtdev_alloc(name, parent, \
> +					     sizeof(struct vdpa_mgmt_dev))
> +
>  int vdpa_mgmtdev_register(struct vdpa_mgmt_dev *mdev);
>  void vdpa_mgmtdev_unregister(struct vdpa_mgmt_dev *mdev);
>  
> -- 
> 2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
