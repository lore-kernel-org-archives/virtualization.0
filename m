Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4B1C7EE25
	for <virtualization@archiver.kernel.org>; Thu,  8 Jun 2023 19:45:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F181242025;
	Thu,  8 Jun 2023 19:45:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F181242025
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UIF3Fy67
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MiQZK2ppkGQs; Thu,  8 Jun 2023 19:45:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0591042054;
	Thu,  8 Jun 2023 19:45:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0591042054
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3902C007A;
	Thu,  8 Jun 2023 19:45:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94CC9C0029
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 19:45:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 73F5B611C6
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 19:45:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 73F5B611C6
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UIF3Fy67
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nViJjXAYasTR
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 19:45:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 786D761553
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 786D761553
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 19:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686253505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JmF/x59Qx/JvKg/Xn0EqjpftmVd313DRoIAQfS/rxFs=;
 b=UIF3Fy6724G+vtn3IBRWjXwce4/N2WIQbI3QjobH2nMi13KheEG6UR/awh1ZejRaLfECAv
 qmZiBEZ+Qien/de2zId5yYKlVKXqsSa30Te65v0rEqMJf75x7m33/VCR+bBwYcpxC+MhPa
 M+TIzOdyL+vPvn3QAD6qUJF7JLkzJAs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-vYPrqJW5MEmv2QOVntxATA-1; Thu, 08 Jun 2023 15:45:02 -0400
X-MC-Unique: vYPrqJW5MEmv2QOVntxATA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-94a341efd9aso119664866b.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Jun 2023 12:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686253501; x=1688845501;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JmF/x59Qx/JvKg/Xn0EqjpftmVd313DRoIAQfS/rxFs=;
 b=BMlHBtDnIhGC2A4LCfbtvHzzitYkvFg2mv+RqOyMZX3ehnnLYR5utKVuaePtyXuVpB
 XpT4clowrL+3YBpBp+8qkDe3vRxzuIAMBTbqLcG1ceQY2Ghz27O3Q5OMim8ezbdVwBZL
 pcQS0E0jlnDMg9TZ8vFdx4wChnqNVE+wl5HQokP2FvECRDhWOUQ1Rd/Ahg2HpnQLz3v+
 ZHMpajYKU6pyGFv+P0+c+sqyIRXu8OcqddwmxU/enklPdLlnG1wkEFzWa7oPF0hx09R1
 H7uI7RFgbuEKjsDVdxmqgdq/jb9Mu20SlK+oCHLNTWEDPr75McWOL0EGOzdxlgim6sao
 F2kw==
X-Gm-Message-State: AC+VfDwMIUmnO9InibDmIb7S/euSuqSW4rh0iGL3EL11Cx9UAAIZaf/k
 J7SQbWLz2Hozt1r0vnw8qs/sZrsBjD4whPX7rExfai6zUvKFcAZdHkvzMAtHshJdV2eluu6MDa8
 zY3+tIoRqN9qZQ2/KFf/DqCYw5GPodzcDq/cKLJmPjw==
X-Received: by 2002:a17:907:6ea1:b0:969:bac4:8e22 with SMTP id
 sh33-20020a1709076ea100b00969bac48e22mr190957ejc.26.1686253501284; 
 Thu, 08 Jun 2023 12:45:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ638uv4/Vr+tj9RPa/sHzhVcwrauzcttV3G6j2YKZTAjolaDA5VYvQTw6KbxvqJuZQOjZ3t1g==
X-Received: by 2002:a17:907:6ea1:b0:969:bac4:8e22 with SMTP id
 sh33-20020a1709076ea100b00969bac48e22mr190943ejc.26.1686253501017; 
 Thu, 08 Jun 2023 12:45:01 -0700 (PDT)
Received: from redhat.com ([2.55.4.169]) by smtp.gmail.com with ESMTPSA id
 17-20020a05600c235100b003f7f475c3c7sm534780wmq.8.2023.06.08.12.44.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 12:45:00 -0700 (PDT)
Date: Thu, 8 Jun 2023 15:44:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Angus Chen <angus.chen@jaguarmicro.com>
Subject: Re: [PATCH v2] vdpa/vp_vdpa: Check queue number of vdpa device from
 add_config
Message-ID: <20230608154400-mutt-send-email-mst@kernel.org>
References: <20230608090124.1807-1-angus.chen@jaguarmicro.com>
MIME-Version: 1.0
In-Reply-To: <20230608090124.1807-1-angus.chen@jaguarmicro.com>
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

On Thu, Jun 08, 2023 at 05:01:24PM +0800, Angus Chen wrote:
> When add virtio_pci vdpa device,check the vqs number of device cap
> and max_vq_pairs from add_config.
> Simply starting from failing if the provisioned #qp is not
> equal to the one that hardware has.
> 
> Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>

I am not sure about this one. How does userspace know
which values are legal?

If there's no way then maybe we should just cap the value
to what device can support but otherwise keep the device
working.

> ---
> v1: Use max_vqs from add_config
> v2: Just return fail if max_vqs from add_config is not same as device
> 	cap. Suggested by jason.
> 
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 35 ++++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index 281287fae89f..c1fb6963da12 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -480,32 +480,39 @@ static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>  	u64 device_features;
>  	int ret, i;
>  
> -	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
> -				    dev, &vp_vdpa_ops, 1, 1, name, false);
> -
> -	if (IS_ERR(vp_vdpa)) {
> -		dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\n");
> -		return PTR_ERR(vp_vdpa);
> +	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) {
> +		if (add_config->net.max_vq_pairs != (v_mdev->max_supported_vqs / 2)) {
> +			dev_err(&pdev->dev, "max vqs 0x%x should be equal to 0x%x which device has\n",
> +				add_config->net.max_vq_pairs*2, v_mdev->max_supported_vqs);
> +			return -EINVAL;
> +		}
>  	}
>  
> -	vp_vdpa_mgtdev->vp_vdpa = vp_vdpa;
> -
> -	vp_vdpa->vdpa.dma_dev = &pdev->dev;
> -	vp_vdpa->queues = vp_modern_get_num_queues(mdev);
> -	vp_vdpa->mdev = mdev;
> -
>  	device_features = vp_modern_get_features(mdev);
>  	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
>  		if (add_config->device_features & ~device_features) {
> -			ret = -EINVAL;
>  			dev_err(&pdev->dev, "Try to provision features "
>  				"that are not supported by the device: "
>  				"device_features 0x%llx provisioned 0x%llx\n",
>  				device_features, add_config->device_features);
> -			goto err;
> +			return -EINVAL;
>  		}
>  		device_features = add_config->device_features;
>  	}
> +
> +	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
> +				    dev, &vp_vdpa_ops, 1, 1, name, false);
> +
> +	if (IS_ERR(vp_vdpa)) {
> +		dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\n");
> +		return PTR_ERR(vp_vdpa);
> +	}
> +
> +	vp_vdpa_mgtdev->vp_vdpa = vp_vdpa;
> +
> +	vp_vdpa->vdpa.dma_dev = &pdev->dev;
> +	vp_vdpa->queues = v_mdev->max_supported_vqs;
> +	vp_vdpa->mdev = mdev;
>  	vp_vdpa->device_features = device_features;
>  
>  	ret = devm_add_action_or_reset(dev, vp_vdpa_free_irq_vectors, pdev);
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
