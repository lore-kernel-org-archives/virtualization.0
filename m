Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A8DC636CC
	for <virtualization@archiver.kernel.org>; Fri,  3 Feb 2023 09:24:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F286F4114E;
	Fri,  3 Feb 2023 09:24:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F286F4114E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eu7YUVXN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JA27dHufYRzC; Fri,  3 Feb 2023 09:24:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 64D9A401D5;
	Fri,  3 Feb 2023 09:24:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 64D9A401D5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38B70C0033;
	Fri,  3 Feb 2023 09:24:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 168E3C002B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:24:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D03F460AF6
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:24:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D03F460AF6
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=eu7YUVXN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w45brSG3RsN1
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:24:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EC0BE608B7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EC0BE608B7
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675416278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hzQ7UoxDCUOIsyyrWZEEJT3XokG9b81p4j2nZwVsXUk=;
 b=eu7YUVXNnlYoLrqBMmues/51LlqxCLbvTFzxG9eKVmCV+2XmD6lKXsb5ERAztxUO7H+O3U
 7ExdS+x9QnwLjU0J4qdVOWpgqPbA4/TTxQuOsLatQ2V6nSUh1vNAerFleBUuu24FLCS28D
 xC0U5WSXao/sDY/FHXaaGt/S2F7V940=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-14-BxH3JdZXPOWzcPrVA0WCiA-1; Fri, 03 Feb 2023 04:24:37 -0500
X-MC-Unique: BxH3JdZXPOWzcPrVA0WCiA-1
Received: by mail-ed1-f70.google.com with SMTP id
 o21-20020aa7dd55000000b004a245f58006so3226021edw.12
 for <virtualization@lists.linux-foundation.org>;
 Fri, 03 Feb 2023 01:24:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hzQ7UoxDCUOIsyyrWZEEJT3XokG9b81p4j2nZwVsXUk=;
 b=qfCUnIIwYJa9KipYcoWOou/EgXXqY0O6bs+uCi0M7DXxPNyWsD9uLe6RpeNvwoX++u
 2fvZkr01QKhXIrf7F2dxhUNW09EFbem7w1FwPKgcSkYxigup26lQsBHiiLvzcFnL4Nka
 ji34yI2jJpLC5aPCNRW0rUMBkWzthVXQV40QYKWpeQsWgil+rTAcI6Z2Qhx5XsqXz5TR
 oQarQmRZ5md1CfDO9gFZjseig7ffcCldy2TDmJpJLJbnfIdpKB3QtHb4cn23qInccT50
 H5TL991o+rW96ue4lMS3Tk5bQmapgTV5rnmh0UKrMByLn6v7Mmu13eOjxDyC/5d68l6H
 bhbw==
X-Gm-Message-State: AO0yUKX6Y17N7DFIvIkyiNGA1j2XLnB1Uwn1ZaUUJjjWUyQaC5zPoo17
 XZfUxK8tCpAzpgENeJ+EGxum7dA4YUzeifBO22PkOiFpBdFz3Laiua4VCGAukbYmZh2zONc/442
 TofRDzuvVDq+DyjPuq1x8N0AbqwKsAPNKnjGDQ/bt9w==
X-Received: by 2002:a17:906:22c7:b0:877:ef84:c7de with SMTP id
 q7-20020a17090622c700b00877ef84c7demr8845488eja.61.1675416275977; 
 Fri, 03 Feb 2023 01:24:35 -0800 (PST)
X-Google-Smtp-Source: AK7set+TxlGnu/L3yT0xGpB437kqNK6vjM70U7jlUdSRH3DIj5ht8LTpXWMZWGwS/IflEeUiZZRQzQ==
X-Received: by 2002:a17:906:22c7:b0:877:ef84:c7de with SMTP id
 q7-20020a17090622c700b00877ef84c7demr8845459eja.61.1675416275741; 
 Fri, 03 Feb 2023 01:24:35 -0800 (PST)
Received: from redhat.com ([2.52.156.122]) by smtp.gmail.com with ESMTPSA id
 e11-20020a170906314b00b0084c4b87aa18sm1093420eje.37.2023.02.03.01.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Feb 2023 01:24:35 -0800 (PST)
Date: Fri, 3 Feb 2023 04:24:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 08/33] virtio_ring: introduce dma sync api for virtio
Message-ID: <20230203042103-mutt-send-email-mst@kernel.org>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
 <20230202110058.130695-9-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230202110058.130695-9-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Petr Machata <petrm@nvidia.com>, Menglong Dong <imagedong@tencent.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

On Thu, Feb 02, 2023 at 07:00:33PM +0800, Xuan Zhuo wrote:
> In the process of dma sync, we involved whether virtio uses dma api. On
> the other hand, it is also necessary to read vdev->dev.parent. So these
> API has been introduced.

you don't need to repeat implementation here.
just list the new APIs and how they will be used
with premapped API.



> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 61 ++++++++++++++++++++++++++++++++++++
>  include/linux/virtio.h       |  8 +++++
>  2 files changed, 69 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 67eda7bc23ea..7b393133fd27 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -3102,4 +3102,65 @@ void virtio_dma_unmap(struct device *dev, dma_addr_t dma, unsigned int length,
>  }
>  EXPORT_SYMBOL_GPL(virtio_dma_unmap);
>  
> +/**
> + * virtio_dma_need_sync - check dma address need sync

.... whether a dma address needs sync

> + * @dev: virtio device
> + * @addr: DMA address
> + */
> +bool virtio_dma_need_sync(struct device *dev, dma_addr_t addr)
> +{
> +	struct virtio_device *vdev = dev_to_virtio(dev);
> +
> +	if (!vring_use_dma_api(vdev))
> +		return 0;
> +
> +	return dma_need_sync(vdev->dev.parent, addr);
> +}
> +EXPORT_SYMBOL_GPL(virtio_dma_need_sync);
> +
> +/**
> + * virtio_dma_sync_signle_range_for_cpu - dma sync for cpu
> + * @dev: virtio device
> + * @addr: DMA address
> + * @offset: DMA address offset
> + * @size: mem size for sync
> + * @dir: DMA direction
> + *
> + * Before calling this function, use virtio_dma_need_sync() to confirm that the
> + * DMA address really needs to be synchronized
> + */
> +void virtio_dma_sync_signle_range_for_cpu(struct device *dev, dma_addr_t addr,
> +					  unsigned long offset, size_t size,
> +					  enum dma_data_direction dir)
> +{
> +	struct virtio_device *vdev = dev_to_virtio(dev);
> +
> +	dma_sync_single_range_for_cpu(vdev->dev.parent, addr, offset,
> +				      size, DMA_BIDIRECTIONAL);
> +}
> +EXPORT_SYMBOL_GPL(virtio_dma_sync_signle_range_for_cpu);
> +
> +/**
> + * virtio_dma_sync_signle_range_for_device - dma sync for device
> + * @dev: virtio device
> + * @addr: DMA address
> + * @offset: DMA address offset
> + * @size: mem size for sync
> + * @dir: DMA direction
> + *
> + * Before calling this function, use virtio_dma_need_sync() to confirm that the
> + * DMA address really needs to be synchronized
> + */
> +void virtio_dma_sync_signle_range_for_device(struct device *dev,
> +					     dma_addr_t addr,
> +					     unsigned long offset, size_t size,
> +					     enum dma_data_direction dir)
> +{
> +	struct virtio_device *vdev = dev_to_virtio(dev);
> +
> +	dma_sync_single_range_for_device(vdev->dev.parent, addr, offset,
> +					 size, DMA_BIDIRECTIONAL);
> +}
> +EXPORT_SYMBOL_GPL(virtio_dma_sync_signle_range_for_device);
> +


Pls document how these APIs are only for pre-mapped buffers,
for non premapped virtio core handles DMA API internally.


>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index ce89126becc5..8c2fae318b0c 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -227,4 +227,12 @@ dma_addr_t virtio_dma_map(struct device *dev, void *addr, unsigned int length,
>  int virtio_dma_mapping_error(struct device *dev, dma_addr_t addr);
>  void virtio_dma_unmap(struct device *dev, dma_addr_t dma, unsigned int length,
>  		      enum dma_data_direction dir);
> +bool virtio_dma_need_sync(struct device *dev, dma_addr_t addr);
> +void virtio_dma_sync_signle_range_for_cpu(struct device *dev, dma_addr_t addr,
> +					  unsigned long offset, size_t size,
> +					  enum dma_data_direction dir);
> +void virtio_dma_sync_signle_range_for_device(struct device *dev,
> +					     dma_addr_t addr,
> +					     unsigned long offset, size_t size,
> +					     enum dma_data_direction dir);
>  #endif /* _LINUX_VIRTIO_H */
> -- 
> 2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
