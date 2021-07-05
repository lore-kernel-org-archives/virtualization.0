Return-Path: <SRS0=2LZG=L5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E85C07E99
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 18:30:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89E316196A
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 18:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89E316196A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5011860802;
	Mon,  5 Jul 2021 18:30:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TjLsvkBaIgtT; Mon,  5 Jul 2021 18:30:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B847F60646;
	Mon,  5 Jul 2021 18:30:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95CE2C0010;
	Mon,  5 Jul 2021 18:30:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE8C4C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 18:30:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9F9F8402BB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 18:30:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2U71RylSCbqG
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 18:30:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ABA1A400D2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 18:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625509822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g99cAC1EqGLpuFXeNRpicbnlN6CA7H9jiKu7Hd/LXNo=;
 b=SIOieA2QaXNLUpz1DfLI5c4r38y7nsmkfzO4X31opfRWjIQ78WMcyhOh33g2ppCR0x9Lj/
 DnEiQ622KYSBkGfrvQeYIIB31mgaZ0hUTVesjiljounwVfYe8w2hm/h/YBR83vhJ4bPRoj
 dx3N8dEGBb92r0rQzmnUBdFv506oPtA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-9yLmXj5WPo-9JU9dAlDsXw-1; Mon, 05 Jul 2021 14:30:21 -0400
X-MC-Unique: 9yLmXj5WPo-9JU9dAlDsXw-1
Received: by mail-ed1-f72.google.com with SMTP id
 i8-20020a50fc080000b02903989feb4920so3985078edr.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Jul 2021 11:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=g99cAC1EqGLpuFXeNRpicbnlN6CA7H9jiKu7Hd/LXNo=;
 b=pUl+u3TqWABzlwqoQUW3l8NOkY4v25XalmQ0kaM8PEEymuslmBkYoGlyCmzPXejeJu
 tslGfMlGGXSkWP9yui5CwSJu2QZA4qBnsk1zzqG4Qna9Y3WabJC/+ZRv1R6SLbZfF9V9
 GwzF9kRFQzGQN9GR1EL/00NMyn/dfwvXF0xE7Qq2d7CVpTNcVIt/NXm7Ho68tgasq+bB
 8Yry6P9cRzD13z0DZssBZrdmwd1F526u8SJ3ysb2A7Uf7OXijw2yo+IJbKZunLABdnIq
 Qo8nSSvaVr3vRnGYXQxf+9A+U/6iRNLhtykh37My3h70S5xXdNlo8jKsZJFjwUaFTUP1
 eS6Q==
X-Gm-Message-State: AOAM532J+X+a/NKw/vB6lfFHPMsVExTJQ6EVP0NPnlfc9yUEfJJLTrsA
 QfG/AnXTxsyI666R2cpGnrdhT5nT9B1Euc7GA6gTBa1r09ajmjx1XLCWbAOejUfih5bV91HNl9I
 rkR7R4qAYm8ZsEWkESiDeU4Zamqo6QC6VFb7rZQKc3g==
X-Received: by 2002:a17:906:6d97:: with SMTP id
 h23mr14409848ejt.467.1625509820362; 
 Mon, 05 Jul 2021 11:30:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxrSChJF68iOfzGKJU54aJxhgYw63mD0CKZbvFzDlEKlYd3LAcQ1+5MlvRrHTR2dK4+EuJOw==
X-Received: by 2002:a17:906:6d97:: with SMTP id
 h23mr14409836ejt.467.1625509820146; 
 Mon, 05 Jul 2021 11:30:20 -0700 (PDT)
Received: from redhat.com ([2.55.8.91])
 by smtp.gmail.com with ESMTPSA id p23sm5845689edt.71.2021.07.05.11.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jul 2021 11:30:19 -0700 (PDT)
Date: Mon, 5 Jul 2021 14:30:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: Re: [PATCH V2 2/2] vDPA/ifcvf: implement management netlink
 framework for ifcvf
Message-ID: <20210705142750-mutt-send-email-mst@kernel.org>
References: <20210705141333.9262-1-lingshan.zhu@intel.com>
 <20210705141333.9262-3-lingshan.zhu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20210705141333.9262-3-lingshan.zhu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Mon, Jul 05, 2021 at 10:13:33PM +0800, Zhu Lingshan wrote:
> This commit implments the management netlink framework for ifcvf,

implements

> including register and add / remove a device
> 
> It works with iprouter2:

I am guessing iproute2?

> [root@localhost lszhu]# vdpa mgmtdev show -jp
> {
>     "mgmtdev": {
>         "pci/0000:01:00.5": {
>             "supported_classes": [ "net" ]
>         },
>         "pci/0000:01:00.6": {
>             "supported_classes": [ "net" ]
>         }
>     }
> }
> 
> [root@localhost lszhu]# vdpa dev add mgmtdev pci/0000:01:00.5 name vdpa0
> [root@localhost lszhu]# vdpa dev add mgmtdev pci/0000:01:00.6 name vdpa1
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>  drivers/vdpa/ifcvf/ifcvf_base.h |   6 ++
>  drivers/vdpa/ifcvf/ifcvf_main.c | 154 ++++++++++++++++++++++++--------
>  2 files changed, 124 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
> index ded1b1b5fb13..e5251fcbb200 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_base.h
> +++ b/drivers/vdpa/ifcvf/ifcvf_base.h
> @@ -104,6 +104,12 @@ struct ifcvf_lm_cfg {
>  	struct ifcvf_vring_lm_cfg vring_lm_cfg[IFCVF_MAX_QUEUE_PAIRS];
>  };
>  
> +struct ifcvf_vdpa_mgmt_dev {
> +	struct vdpa_mgmt_dev mdev;
> +	struct ifcvf_adapter *adapter;
> +	struct pci_dev *pdev;
> +};
> +
>  int ifcvf_init_hw(struct ifcvf_hw *hw, struct pci_dev *dev);
>  int ifcvf_start_hw(struct ifcvf_hw *hw);
>  void ifcvf_stop_hw(struct ifcvf_hw *hw);
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> index 5f70ab1283a0..c72d9b36e4a0 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -218,7 +218,7 @@ static void ifcvf_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
>  	int ret;
>  
>  	vf  = vdpa_to_vf(vdpa_dev);
> -	adapter = dev_get_drvdata(vdpa_dev->dev.parent);
> +	adapter = vdpa_to_adapter(vdpa_dev);
>  	status_old = ifcvf_get_status(vf);
>  
>  	if (status_old == status)
> @@ -442,6 +442,16 @@ static const struct vdpa_config_ops ifc_vdpa_ops = {
>  	.set_config_cb  = ifcvf_vdpa_set_config_cb,
>  };
>  
> +static struct virtio_device_id id_table_net[] = {
> +	{VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID},
> +	{0},
> +};
> +
> +static struct virtio_device_id id_table_blk[] = {
> +	{VIRTIO_ID_BLOCK, VIRTIO_DEV_ANY_ID},
> +	{0},
> +};
> +
>  static u32 get_dev_type(struct pci_dev *pdev)
>  {
>  	u32 dev_type;
> @@ -462,48 +472,30 @@ static u32 get_dev_type(struct pci_dev *pdev)
>  	return dev_type;
>  }
>  
> -static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name)
>  {
> -	struct device *dev = &pdev->dev;
> +	struct ifcvf_vdpa_mgmt_dev *ifcvf_mgmt_dev;
>  	struct ifcvf_adapter *adapter;
> +	struct pci_dev *pdev;
>  	struct ifcvf_hw *vf;
> +	struct device *dev;
>  	int ret, i;
>  
> -	ret = pcim_enable_device(pdev);
> -	if (ret) {
> -		IFCVF_ERR(pdev, "Failed to enable device\n");
> -		return ret;
> -	}
> -
> -	ret = pcim_iomap_regions(pdev, BIT(0) | BIT(2) | BIT(4),
> -				 IFCVF_DRIVER_NAME);
> -	if (ret) {
> -		IFCVF_ERR(pdev, "Failed to request MMIO region\n");
> -		return ret;
> -	}
> -
> -	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> -	if (ret) {
> -		IFCVF_ERR(pdev, "No usable DMA configuration\n");
> -		return ret;
> -	}
> -
> -	ret = devm_add_action_or_reset(dev, ifcvf_free_irq_vectors, pdev);
> -	if (ret) {
> -		IFCVF_ERR(pdev,
> -			  "Failed for adding devres for freeing irq vectors\n");
> -		return ret;
> -	}
> +	ifcvf_mgmt_dev = container_of(mdev, struct ifcvf_vdpa_mgmt_dev, mdev);
> +	if (ifcvf_mgmt_dev->adapter)
> +		return -EOPNOTSUPP;
>  
> +	pdev = ifcvf_mgmt_dev->pdev;
> +	dev = &pdev->dev;
>  	adapter = vdpa_alloc_device(struct ifcvf_adapter, vdpa,
> -				    dev, &ifc_vdpa_ops, NULL);
> -	if (adapter == NULL) {
> +				    dev, &ifc_vdpa_ops, name);
> +	if (!adapter) {
>  		IFCVF_ERR(pdev, "Failed to allocate vDPA structure");
>  		return -ENOMEM;
>  	}
>  
> -	pci_set_master(pdev);
> -	pci_set_drvdata(pdev, adapter);
> +	ifcvf_mgmt_dev->adapter = adapter;
> +	pci_set_drvdata(pdev, ifcvf_mgmt_dev);
>  
>  	vf = &adapter->vf;
>  	vf->dev_type = get_dev_type(pdev);
> @@ -523,9 +515,10 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	vf->hw_features = ifcvf_get_hw_features(vf);
>  
> -	ret = vdpa_register_device(&adapter->vdpa, IFCVF_MAX_QUEUE_PAIRS * 2);
> +	adapter->vdpa.mdev = &ifcvf_mgmt_dev->mdev;
> +	ret = _vdpa_register_device(&adapter->vdpa, IFCVF_MAX_QUEUE_PAIRS * 2);
>  	if (ret) {
> -		IFCVF_ERR(pdev, "Failed to register ifcvf to vdpa bus");
> +		IFCVF_ERR(pdev, "Failed to register to vDPA bus");
>  		goto err;
>  	}
>  
> @@ -536,11 +529,100 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	return ret;
>  }
>  
> +static void ifcvf_vdpa_dev_del(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev)
> +{
> +	struct ifcvf_vdpa_mgmt_dev *ifcvf_mgmt_dev;
> +
> +	ifcvf_mgmt_dev = container_of(mdev, struct ifcvf_vdpa_mgmt_dev, mdev);
> +	_vdpa_unregister_device(dev);
> +	ifcvf_mgmt_dev->adapter = NULL;
> +}
> +
> +static const struct vdpa_mgmtdev_ops ifcvf_vdpa_mgmt_dev_ops = {
> +	.dev_add = ifcvf_vdpa_dev_add,
> +	.dev_del = ifcvf_vdpa_dev_del
> +};
> +
> +static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	struct ifcvf_vdpa_mgmt_dev *ifcvf_mgmt_dev;
> +	struct device *dev = &pdev->dev;
> +	u32 dev_type;
> +	int ret;
> +
> +	ifcvf_mgmt_dev = kzalloc(sizeof(struct ifcvf_vdpa_mgmt_dev), GFP_KERNEL);
> +	if (!ifcvf_mgmt_dev) {
> +		IFCVF_ERR(pdev, "Failed to alloc memory for the vDPA management device\n");
> +		return -ENOMEM;
> +	}
> +
> +	dev_type = get_dev_type(pdev);
> +	switch (dev_type) {
> +	case VIRTIO_ID_NET:
> +		ifcvf_mgmt_dev->mdev.id_table = id_table_net;
> +		break;
> +	case VIRTIO_ID_BLOCK:
> +		ifcvf_mgmt_dev->mdev.id_table = id_table_blk;
> +		break;
> +	default:
> +		IFCVF_ERR(pdev, "VIRTIO ID %u not supported\n", dev_type);
> +		ret = -EOPNOTSUPP;
> +		goto err;
> +	}
> +
> +	ifcvf_mgmt_dev->mdev.ops = &ifcvf_vdpa_mgmt_dev_ops;
> +	ifcvf_mgmt_dev->mdev.device = dev;
> +	ifcvf_mgmt_dev->pdev = pdev;
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret) {
> +		IFCVF_ERR(pdev, "Failed to enable device\n");
> +		goto err;
> +	}
> +
> +	ret = pcim_iomap_regions(pdev, BIT(0) | BIT(2) | BIT(4),
> +				 IFCVF_DRIVER_NAME);
> +	if (ret) {
> +		IFCVF_ERR(pdev, "Failed to request MMIO region\n");
> +		goto err;
> +	}
> +
> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +	if (ret) {
> +		IFCVF_ERR(pdev, "No usable DMA configuration\n");
> +		goto err;
> +	}
> +
> +	ret = devm_add_action_or_reset(dev, ifcvf_free_irq_vectors, pdev);
> +	if (ret) {
> +		IFCVF_ERR(pdev,
> +			  "Failed for adding devres for freeing irq vectors\n");
> +		goto err;
> +	}
> +
> +	pci_set_master(pdev);
> +
> +	ret = vdpa_mgmtdev_register(&ifcvf_mgmt_dev->mdev);
> +	if (ret) {
> +		IFCVF_ERR(pdev,
> +			  "Failed to initialize the management interfaces\n");
> +		goto err;
> +	}
> +
> +	return 0;
> +
> +err:
> +	kfree(ifcvf_mgmt_dev);
> +	return ret;
> +}
> +
>  static void ifcvf_remove(struct pci_dev *pdev)
>  {
> -	struct ifcvf_adapter *adapter = pci_get_drvdata(pdev);
> +	struct ifcvf_vdpa_mgmt_dev *ifcvf_mgmt_dev;
>  
> -	vdpa_unregister_device(&adapter->vdpa);
> +	ifcvf_mgmt_dev = pci_get_drvdata(pdev);
> +	vdpa_mgmtdev_unregister(&ifcvf_mgmt_dev->mdev);
> +	kfree(ifcvf_mgmt_dev);
>  }
>  
>  static struct pci_device_id ifcvf_pci_ids[] = {
> -- 
> 2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
