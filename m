Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B99EB64D7
	for <virtualization@archiver.kernel.org>; Fri, 30 Jun 2023 08:35:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 02E08418F9;
	Fri, 30 Jun 2023 08:35:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 02E08418F9
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CHXIjeKV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GVopF71NIWu3; Fri, 30 Jun 2023 08:35:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8A60240131;
	Fri, 30 Jun 2023 08:35:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8A60240131
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6320AC0072;
	Fri, 30 Jun 2023 08:35:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BFDB9C0037
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jun 2023 08:35:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 865C340154
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jun 2023 08:35:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 865C340154
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lG9bG1xvjKDv
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jun 2023 08:35:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D8D4F40131
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D8D4F40131
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jun 2023 08:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688114113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TnaOhNvtxh50U8yZd9VkBSSsjMY9dRb44ZcwWbWlcRU=;
 b=CHXIjeKVmCEfW4Neik9fKpMUDMEOWEQWsUc5lKymGGF67J4JONawJtk+yZ1sg/YqJz9/J6
 8cI2xIVR3v/h5awWHFBxI4RUsKdhwbgMCJg/2/kaPQBUwAWJdPel66GCWYkG0UdNGQNXFn
 OHK5vSmPdnQ3XHVwsnYupzYweTfQ9Z4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-u32Q5vspNR-o-8asBl8SAw-1; Fri, 30 Jun 2023 04:34:13 -0400
X-MC-Unique: u32Q5vspNR-o-8asBl8SAw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f81dda24d3so23458685e9.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jun 2023 01:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688114052; x=1690706052;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TnaOhNvtxh50U8yZd9VkBSSsjMY9dRb44ZcwWbWlcRU=;
 b=gUggC794yqrm/1pE605SUUtDEavgk499LsQvaINUeTy2KK2th8u6s8kEOLSnaNYDwX
 mM/jGiBWmGZYjBdh60oiLtcNd9U+IJCfnIDgRA3+8awxV+4wXNn+K3wLH+0c/F+fdjpx
 93Zo9xCSNEMajTue0qJnvIAFSbh65sxCiDeEO+lPVSjPVm+x5hpck8KLiStbgIST+hGY
 /yYBZWiQn9yqdxvs9yUCIM5fipM/reiIPntYsO9zueCw9R74V/2r/QQLKnsrvYteGiWJ
 mWDSfuuJ3xP66l7WaTL1jVfefTt8Tk9jOKa737R85bNBoIYmfBozKdaRLYoOh/R9k7To
 yDYw==
X-Gm-Message-State: AC+VfDxBBbp9obrBHzOw4wxh6ur6fq4I5iFrza7w7fkUGjV16sJWS0n5
 ht2gh8Vt8goY/PACZEasAK+vobTf43m35nOhqroIq7GQ40yY7iMwGlr2JyU1Ko7bq3iyoNYODtY
 kBTiLzSuH15R3wzzX87mmqIfePAolkIMJYEIAMuWtkw==
X-Received: by 2002:a7b:cd8e:0:b0:3fa:8aed:d57f with SMTP id
 y14-20020a7bcd8e000000b003fa8aedd57fmr1714741wmj.24.1688114052467; 
 Fri, 30 Jun 2023 01:34:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6rjC7KQu1QwHKrASacJdWaPZDMD1SUADNxMqW8XVs6LwTiOUh89h6kOAfgnx8Ur5YqXjLOnA==
X-Received: by 2002:a7b:cd8e:0:b0:3fa:8aed:d57f with SMTP id
 y14-20020a7bcd8e000000b003fa8aedd57fmr1714725wmj.24.1688114052172; 
 Fri, 30 Jun 2023 01:34:12 -0700 (PDT)
Received: from redhat.com ([2.52.154.169]) by smtp.gmail.com with ESMTPSA id
 a20-20020a05600c225400b003fbb06af219sm6631296wmm.32.2023.06.30.01.34.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 01:34:11 -0700 (PDT)
Date: Fri, 30 Jun 2023 04:34:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: Re: [PATCH] vp_vdpa: synchronize irq when free irq
Message-ID: <20230630043342-mutt-send-email-mst@kernel.org>
References: <20230630103656.345870-1-lingshan.zhu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20230630103656.345870-1-lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Cindy Lu <lulu@redhat.com>, virtualization@lists.linux-foundation.org
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

On Fri, Jun 30, 2023 at 06:36:56PM +0800, Zhu Lingshan wrote:
> This commits synchronizes irqs when free them
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> Tested-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index 281287fae89f..d8ee3e68cd2d 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -116,6 +116,7 @@ static void vp_vdpa_free_irq(struct vp_vdpa *vp_vdpa)
>  	for (i = 0; i < vp_vdpa->queues; i++) {
>  		if (vp_vdpa->vring[i].irq != VIRTIO_MSI_NO_VECTOR) {
>  			vp_modern_queue_vector(mdev, i, VIRTIO_MSI_NO_VECTOR);
> +			synchronize_irq(vp_vdpa->vring[i].irq);
>  			devm_free_irq(&pdev->dev, vp_vdpa->vring[i].irq,
>  				      &vp_vdpa->vring[i]);
>  			vp_vdpa->vring[i].irq = VIRTIO_MSI_NO_VECTOR;
> @@ -124,6 +125,7 @@ static void vp_vdpa_free_irq(struct vp_vdpa *vp_vdpa)
>  
>  	if (vp_vdpa->config_irq != VIRTIO_MSI_NO_VECTOR) {
>  		vp_modern_config_vector(mdev, VIRTIO_MSI_NO_VECTOR);
> +		synchronize_irq(vp_vdpa->config_irq);
>  		devm_free_irq(&pdev->dev, vp_vdpa->config_irq, vp_vdpa);
>  		vp_vdpa->config_irq = VIRTIO_MSI_NO_VECTOR;


Weird, doesn't free_irq synchronize automatically?

>  	}
> -- 
> 2.39.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
