Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA85E7106D
	for <virtualization@archiver.kernel.org>; Thu, 21 Sep 2023 13:46:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1833060E25;
	Thu, 21 Sep 2023 13:46:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1833060E25
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jSh4I32c
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cOBWsHh-hJ8F; Thu, 21 Sep 2023 13:46:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A715E607E1;
	Thu, 21 Sep 2023 13:46:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A715E607E1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67ADDC0039;
	Thu, 21 Sep 2023 13:46:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BBD9C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 13:46:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 36862409BD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 13:46:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 36862409BD
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=jSh4I32c
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9Sn7fSj1_2s5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 13:46:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C129E40A54
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 13:46:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C129E40A54
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695303989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pD7tefHLtUrliixxocdkZvjm/zaq4ygqOegWFqR6dIo=;
 b=jSh4I32cFrbLmDMqdi5hWy1OszALxbrJi8vXdcEiAOi3vzErB49vbsvQIrc1284c41LAhR
 oziJ+DzvBW2kzzjyk507OnMqquuXUU4jVUKXRgbF2D84LPgmXBonk/gOU8ZzldX5+/mVZT
 yYYuc3hLjmOHiYxXj8sjiPphbAxKe1U=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-8cyDBeVvNqSzHuRkAS6ZqQ-1; Thu, 21 Sep 2023 09:46:27 -0400
X-MC-Unique: 8cyDBeVvNqSzHuRkAS6ZqQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-532eb7faea1so746379a12.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 06:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695303986; x=1695908786;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pD7tefHLtUrliixxocdkZvjm/zaq4ygqOegWFqR6dIo=;
 b=YhAWbZG6/Ml/Nu6SzUOrErJuz9R5BcLKaMIJo81CwmJioy9KQsA/1wzMtmwpd0wTiD
 joOxD+SlPZY5z/eGDHAu83jpcB11c2AFEySnKAvTIX7fp9L6wGXa7SN9Gg40ugQaHxhQ
 K3JBwwcmDqkyOZ9yyZPc3jVFtCh4aCGJE9DttxhQFygwy8fQfUPWeKCMIxH/eet+2nJI
 JiIL8GhfM/JRkX8MD1LZpJjOtSmsRy1PazogmyeNU77+YZzh6byH9UYQL7bDVRSHA43z
 oQmrdqKwHtKzKo5iWPrBKm/Cmv2CJwpw/PtKWxUMJXrN0Hn0LeMcMqMmRrCpf/0drV9x
 2Qmw==
X-Gm-Message-State: AOJu0YwFAEV/ejO1OeKRvROa1vNVhyCrtY7rYUbqcxYJ4JAlO+9cSN26
 /qifx/gkr55VAi8GscuIDJUnRZMm3ygOJ4f/HgcYp/EX4NsOZxju1rWstokEXhae8AlCNHPtIVr
 nVKd0yJXauqrn3arqVivIO/y12y7iGZ4bH5Zkr7g/Ew==
X-Received: by 2002:a17:907:3e15:b0:9ad:e403:239f with SMTP id
 hp21-20020a1709073e1500b009ade403239fmr6211305ejc.16.1695303986555; 
 Thu, 21 Sep 2023 06:46:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHs9L6ehtx6mY/P0YeIfqEguc+IZ+ptSKdD6kk1obNofGgXaLJ5xjpnBXqDpRE/Qvku06L07A==
X-Received: by 2002:a17:907:3e15:b0:9ad:e403:239f with SMTP id
 hp21-20020a1709073e1500b009ade403239fmr6211270ejc.16.1695303986151; 
 Thu, 21 Sep 2023 06:46:26 -0700 (PDT)
Received: from redhat.com ([2.52.150.187]) by smtp.gmail.com with ESMTPSA id
 md1-20020a170906ae8100b009a1be9c29d7sm1083322ejb.179.2023.09.21.06.46.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 06:46:25 -0700 (PDT)
Date: Thu, 21 Sep 2023 09:46:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH vfio 01/11] virtio-pci: Use virtio pci device layer vq
 info instead of generic one
Message-ID: <20230921093540-mutt-send-email-mst@kernel.org>
References: <20230921124040.145386-1-yishaih@nvidia.com>
 <20230921124040.145386-2-yishaih@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230921124040.145386-2-yishaih@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jgg@nvidia.com, jiri@nvidia.com,
 leonro@nvidia.com
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

On Thu, Sep 21, 2023 at 03:40:30PM +0300, Yishai Hadas wrote:
> From: Feng Liu <feliu@nvidia.com>
> 
> Currently VQ deletion callback vp_del_vqs() processes generic
> virtio_device level VQ list instead of VQ information available at PCI
> layer.
> 
> To adhere to the layering, use the pci device level VQ information
> stored in the virtqueues or vqs.
> 
> This also prepares the code to handle PCI layer admin vq life cycle to
> be managed within the pci layer and thereby avoid undesired deletion of
> admin vq by upper layer drivers (net, console, vfio), in the del_vqs()
> callback.

> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> ---
>  drivers/virtio/virtio_pci_common.c | 12 +++++++++---
>  drivers/virtio/virtio_pci_common.h |  1 +
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index c2524a7207cf..7a3e6edc4dd6 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -232,12 +232,16 @@ static void vp_del_vq(struct virtqueue *vq)
>  void vp_del_vqs(struct virtio_device *vdev)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> -	struct virtqueue *vq, *n;
> +	struct virtqueue *vq;
>  	int i;
>  
> -	list_for_each_entry_safe(vq, n, &vdev->vqs, list) {
> +	for (i = 0; i < vp_dev->nvqs; i++) {
> +		if (!vp_dev->vqs[i])
> +			continue;
> +
> +		vq = vp_dev->vqs[i]->vq;
>  		if (vp_dev->per_vq_vectors) {
> -			int v = vp_dev->vqs[vq->index]->msix_vector;
> +			int v = vp_dev->vqs[i]->msix_vector;
>  
>  			if (v != VIRTIO_MSI_NO_VECTOR) {
>  				int irq = pci_irq_vector(vp_dev->pci_dev, v);
> @@ -294,6 +298,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
>  	vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
>  	if (!vp_dev->vqs)
>  		return -ENOMEM;
> +	vp_dev->nvqs = nvqs;
>  
>  	if (per_vq_vectors) {
>  		/* Best option: one for change interrupt, one per vq. */
> @@ -365,6 +370,7 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
>  	vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
>  	if (!vp_dev->vqs)
>  		return -ENOMEM;
> +	vp_dev->nvqs = nvqs;
>  
>  	err = request_irq(vp_dev->pci_dev->irq, vp_interrupt, IRQF_SHARED,
>  			dev_name(&vdev->dev), vp_dev);
> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> index 4b773bd7c58c..602021967aaa 100644
> --- a/drivers/virtio/virtio_pci_common.h
> +++ b/drivers/virtio/virtio_pci_common.h
> @@ -60,6 +60,7 @@ struct virtio_pci_device {
>  
>  	/* array of all queues for house-keeping */
>  	struct virtio_pci_vq_info **vqs;
> +	u32 nvqs;

I don't much like it that we are adding more duplicated info here.
In fact, we tried removing the vqs array in
5c34d002dcc7a6dd665a19d098b4f4cd5501ba1a - there was some bug in that
patch and the author didn't have the time to debug
so I reverted but I don't really think we need to add to that.

>  
>  	/* MSI-X support */
>  	int msix_enabled;
> -- 
> 2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
