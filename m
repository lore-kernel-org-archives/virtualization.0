Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9056C00140
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 06:07:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1BD4C40146;
	Mon, 15 Aug 2022 06:07:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1BD4C40146
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gCRLsCmU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CNYNw-QCNo31; Mon, 15 Aug 2022 06:07:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A910940347;
	Mon, 15 Aug 2022 06:07:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A910940347
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B88BC0032;
	Mon, 15 Aug 2022 06:07:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54E7AC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 06:07:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 30A7740347
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 06:07:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 30A7740347
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MRAqGUTgQXjI
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 06:07:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 24EFF40146
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 24EFF40146
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 06:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660543641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=miQ+LrhTjrCdn3JmNHg0o7+cx9B77lvSoDGipC2aLoI=;
 b=gCRLsCmU5qBm7RYQM5TiNiCjAbT54/l672AqTMt2S/9IhZg/Uy90wHll2jhhx1dfwGZCEQ
 0PseWTKjSQWvMtZ1szN8SAdkULaBym2yukH1k6Mr8oSDlbys4WUdfDDxa3sjAPkMDCvXD2
 8GlpGr7Pcd+H3F2+rtTqEQhR2P7hXdY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-395-ea1a1irWP-avYarqDITIOw-1; Mon, 15 Aug 2022 02:07:15 -0400
X-MC-Unique: ea1a1irWP-avYarqDITIOw-1
Received: by mail-ed1-f70.google.com with SMTP id
 z6-20020a05640240c600b0043e1d52fd98so4235226edb.22
 for <virtualization@lists.linux-foundation.org>;
 Sun, 14 Aug 2022 23:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=miQ+LrhTjrCdn3JmNHg0o7+cx9B77lvSoDGipC2aLoI=;
 b=n3a+uuVW1+KhGdfKKB9pBwaN5XCo7IS4lreMUGaAmmcrlwC3gl3NeOq1cGOdIZR+9W
 TBUZh/E5DoRXhXBlwtVtC/xZsHfsYiUAEjw+qehzHT66fSM3AGl2C8h5MtxvXLMxQwOz
 IlrRjc7WDWou1mnxRPYZk152DW4zexNlDpP0raDaIUdDtmshObgak6S5h7x4sR7ACRzd
 kVZpa8SX+xCfIcZ/R4koLh78At2+CaufFFYBAagxY+89epmZGE6jEgYb1RdLwmMe1NQi
 nUvuqawU6kbh0MOBq2zwOZ6WPTqGUsUNR0+y/6F5koA9g3uvADX06xD+VUtd3CnW0BCO
 YKGg==
X-Gm-Message-State: ACgBeo1r+vA/37DpKfsrDk3ONp76yZPNdm0NAcw/rWXFepG2y6qaAtOi
 9bv/QakhSVVmQJzLDmi3rg/U16Flnr5QVsYmEIxxgTpT+R77w7ncsq9YSckJD+f/sXynI/GEvBC
 5JgYARYJ6zPxQyC3dhvpnSLJpencZdlD9K7FnH5AvxA==
X-Received: by 2002:a05:6402:40c9:b0:43d:cc0d:e9de with SMTP id
 z9-20020a05640240c900b0043dcc0de9demr13192944edb.319.1660543634274; 
 Sun, 14 Aug 2022 23:07:14 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5IxHumafujgE9z2U2QiRC8adJ4lPgnG3uYrrXb/EOiabr2Dh6aNojO23Eqns8Uqq534VjGmQ==
X-Received: by 2002:a05:6402:40c9:b0:43d:cc0d:e9de with SMTP id
 z9-20020a05640240c900b0043dcc0de9demr13192925edb.319.1660543634027; 
 Sun, 14 Aug 2022 23:07:14 -0700 (PDT)
Received: from redhat.com ([2.54.169.49]) by smtp.gmail.com with ESMTPSA id
 z7-20020a170906d00700b00726c0e63b94sm3688949ejy.27.2022.08.14.23.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Aug 2022 23:07:13 -0700 (PDT)
Date: Mon, 15 Aug 2022 02:07:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v14 30/42] virtio_pci: introduce helper to get/set queue
 reset
Message-ID: <20220815020548-mutt-send-email-mst@kernel.org>
References: <20220801063902.129329-1-xuanzhuo@linux.alibaba.com>
 <20220801063902.129329-31-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20220801063902.129329-31-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vadim Pasternak <vadimp@nvidia.com>, linux-remoteproc@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, platform-driver-x86@vger.kernel.org,
 Eric Farman <farman@linux.ibm.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, kangjie.xu@linux.alibaba.com,
 Heiko Carstens <hca@linux.ibm.com>, linux-um@lists.infradead.org,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Mathieu Poirier <mathieu.poirier@linaro.org>,
 netdev@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
 Sven Schnelle <svens@linux.ibm.com>, Johannes Berg <johannes@sipsolutions.net>,
 "David S. Miller" <davem@davemloft.net>
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

On Mon, Aug 01, 2022 at 02:38:50PM +0800, Xuan Zhuo wrote:
> Introduce new helpers to implement queue reset and get queue reset
> status.
> 
>  https://github.com/oasis-tcs/virtio-spec/issues/124
>  https://github.com/oasis-tcs/virtio-spec/issues/139
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_pci_modern_dev.c | 39 ++++++++++++++++++++++++++
>  include/linux/virtio_pci_modern.h      |  2 ++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> index fa2a9445bb18..869cb46bef96 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -3,6 +3,7 @@
>  #include <linux/virtio_pci_modern.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/delay.h>
>  
>  /*
>   * vp_modern_map_capability - map a part of virtio pci capability
> @@ -474,6 +475,44 @@ void vp_modern_set_status(struct virtio_pci_modern_device *mdev,
>  }
>  EXPORT_SYMBOL_GPL(vp_modern_set_status);
>  
> +/*
> + * vp_modern_get_queue_reset - get the queue reset status
> + * @mdev: the modern virtio-pci device
> + * @index: queue index
> + */
> +int vp_modern_get_queue_reset(struct virtio_pci_modern_device *mdev, u16 index)
> +{
> +	struct virtio_pci_modern_common_cfg __iomem *cfg;
> +
> +	cfg = (struct virtio_pci_modern_common_cfg __iomem *)mdev->common;

This should use container_of, and assignment combined with the
declaration.

> +
> +	vp_iowrite16(index, &cfg->cfg.queue_select);
> +	return vp_ioread16(&cfg->queue_reset);
> +}
> +EXPORT_SYMBOL_GPL(vp_modern_get_queue_reset);
> +
> +/*
> + * vp_modern_set_queue_reset - reset the queue
> + * @mdev: the modern virtio-pci device
> + * @index: queue index
> + */
> +void vp_modern_set_queue_reset(struct virtio_pci_modern_device *mdev, u16 index)
> +{
> +	struct virtio_pci_modern_common_cfg __iomem *cfg;
> +
> +	cfg = (struct virtio_pci_modern_common_cfg __iomem *)mdev->common;
> +
> +	vp_iowrite16(index, &cfg->cfg.queue_select);
> +	vp_iowrite16(1, &cfg->queue_reset);
> +
> +	while (vp_ioread16(&cfg->queue_reset))
> +		msleep(1);
> +
> +	while (vp_ioread16(&cfg->cfg.queue_enable))
> +		msleep(1);
> +}
> +EXPORT_SYMBOL_GPL(vp_modern_set_queue_reset);
> +
>  /*
>   * vp_modern_queue_vector - set the MSIX vector for a specific virtqueue
>   * @mdev: the modern virtio-pci device
> diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
> index 05123b9a606f..c4eeb79b0139 100644
> --- a/include/linux/virtio_pci_modern.h
> +++ b/include/linux/virtio_pci_modern.h
> @@ -113,4 +113,6 @@ void __iomem * vp_modern_map_vq_notify(struct virtio_pci_modern_device *mdev,
>  				       u16 index, resource_size_t *pa);
>  int vp_modern_probe(struct virtio_pci_modern_device *mdev);
>  void vp_modern_remove(struct virtio_pci_modern_device *mdev);
> +int vp_modern_get_queue_reset(struct virtio_pci_modern_device *mdev, u16 index);
> +void vp_modern_set_queue_reset(struct virtio_pci_modern_device *mdev, u16 index);
>  #endif
> -- 
> 2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
