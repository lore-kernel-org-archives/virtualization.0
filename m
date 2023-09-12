Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65CD2EE3F22
	for <virtualization@archiver.kernel.org>; Tue, 12 Sep 2023 20:53:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CEC6860B25;
	Tue, 12 Sep 2023 20:53:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CEC6860B25
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LnBDizzf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7E6XtaVjfPxf; Tue, 12 Sep 2023 20:53:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4F2B160ADE;
	Tue, 12 Sep 2023 20:53:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4F2B160ADE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22891C0071;
	Tue, 12 Sep 2023 20:53:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5473FC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 20:53:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1C55B4002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 20:53:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1C55B4002B
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LnBDizzf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s_OoNq0m8yxK
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 20:53:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CE4A640004
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 20:53:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CE4A640004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694552031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h7gqxsWGxYdMmHjhvfD7Qqc8EetmHcPGV2O7WRpaBLQ=;
 b=LnBDizzfL++gZ96TAcmaG2Mb1uWsdecdatM4J3/1Q2bWFpxkDyIH/bgpzwJCQ2PJseYPLP
 W1apgB7K3iljEcpTCtPALdOEwV4V7p/DLiSahuSRR67eumrNeNF3es7P+nDv3w4u8J/1nB
 s2jAahtnsLBrFyXXE8iKb8+xVOoa8HY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-c3tIDK4oOEaoEJRNGvED9g-1; Tue, 12 Sep 2023 16:53:49 -0400
X-MC-Unique: c3tIDK4oOEaoEJRNGvED9g-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-52a62955316so4171055a12.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 13:53:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694552028; x=1695156828;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h7gqxsWGxYdMmHjhvfD7Qqc8EetmHcPGV2O7WRpaBLQ=;
 b=VCdhBfybo3DV7p1H9MPvnI2TiH8JrGnvGl+L3+cO1npcalpgKo/Rb/V8pBGMVh72/+
 nXWVqV0uPxedlOIbMDguoJvryRSwNrgMnU9/hWJDvhaRj+IBS0e6fTj0v5hs+rIZGLLG
 uqDKdXAGYSNLsIbd1uSMtJ6r9XjIt5XkTHUp7HI4o8Zsmz2a4xNZIH0j+Wnd3sPYGF9q
 pWvPKvSaf6td3ihrr1fDcV4ChhK7lZPqrMkaucj+Vo+jX9zvIZCJobVr23G96KnPFPCN
 Mtso/YDj7kXXw20byV4m6Q6MGbwfm9qB8WyKF0v2pz1KKIuMp3HjyptepZNgDfv2p5wD
 aVqw==
X-Gm-Message-State: AOJu0YymmkXZ62B8Ar1RbkBaVE4yOQJTNJLDuwevTbObEypfO7uBYAJ4
 SwtEEUEx3W2dkx3B2hiLJ4vZ6mZIdOChQ+U8em40K/Pykve4ZJcB7itCD7QPrbt5qFUvbuIa52z
 l6B8rF7yTs8A/GC9wd8jS+d2vSvdfBBloxLvCSulbXw==
X-Received: by 2002:a05:6402:6d0:b0:521:a4bb:374f with SMTP id
 n16-20020a05640206d000b00521a4bb374fmr725827edy.5.1694552028477; 
 Tue, 12 Sep 2023 13:53:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGc2BLxKU/ksq/+8WwZzj4E5STO0xOwYElcI4SSFgQhPbX048/Lcnncc+nW3pYUPefRnpegTA==
X-Received: by 2002:a05:6402:6d0:b0:521:a4bb:374f with SMTP id
 n16-20020a05640206d000b00521a4bb374fmr725815edy.5.1694552028183; 
 Tue, 12 Sep 2023 13:53:48 -0700 (PDT)
Received: from redhat.com ([2.52.10.100]) by smtp.gmail.com with ESMTPSA id
 bc3-20020a056402204300b0052348d74865sm6224540edb.61.2023.09.12.13.53.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 13:53:47 -0700 (PDT)
Date: Tue, 12 Sep 2023 16:53:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Subject: Re: [PATCH net-next] virtio: kdoc for struct virtio_pci_modern_device
Message-ID: <20230912165335-mutt-send-email-mst@kernel.org>
References: <20230911213104.14391-1-shannon.nelson@amd.com>
MIME-Version: 1.0
In-Reply-To: <20230911213104.14391-1-shannon.nelson@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: brett.creeley@amd.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 simon.horman@corigine.com, kuba@kernel.org, drivers@pensando.io,
 davem@davemloft.net
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Sep 11, 2023 at 02:31:04PM -0700, Shannon Nelson wrote:
> Finally following up to Simon's suggestion for some kdoc attention
> on struct virtio_pci_modern_device.
> =

> Link: https://lore.kernel.org/netdev/ZE%2FQS0lnUvxFacjf@corigine.com/
> Cc: Simon Horman <simon.horman@corigine.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> Acked-by: Eugenio P=E9rez <eperezma@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  include/linux/virtio_pci_modern.h | 34 ++++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 12 deletions(-)
> =

> diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci=
_modern.h
> index 067ac1d789bc..a38c729d1973 100644
> --- a/include/linux/virtio_pci_modern.h
> +++ b/include/linux/virtio_pci_modern.h
> @@ -12,37 +12,47 @@ struct virtio_pci_modern_common_cfg {
>  	__le16 queue_reset;		/* read-write */
>  };
>  =

> +/**
> + * struct virtio_pci_modern_device - info for modern PCI virtio
> + * @pci_dev:	    Ptr to the PCI device struct
> + * @common:	    Position of the common capability in the PCI config
> + * @device:	    Device-specific data (non-legacy mode)
> + * @notify_base:    Base of vq notifications (non-legacy mode)
> + * @notify_pa:	    Physical base of vq notifications
> + * @isr:	    Where to read and clear interrupt
> + * @notify_len:	    So we can sanity-check accesses
> + * @device_len:	    So we can sanity-check accesses
> + * @notify_map_cap: Capability for when we need to map notifications per=
-vq
> + * @notify_offset_multiplier: Multiply queue_notify_off by this value
> + *                            (non-legacy mode).
> + * @modern_bars:    Bitmask of BARs
> + * @id:		    Device and vendor id
> + * @device_id_check: Callback defined before vp_modern_probe() to be use=
d to
> + *		    verify the PCI device is a vendor's expected device rather
> + *		    than the standard virtio PCI device
> + *		    Returns the found device id or ERRNO
> + * @dma_mask:	    Optional mask instead of the traditional DMA_BIT_MASK(=
64),
> + *		    for vendor devices with DMA space address limitations
> + */
>  struct virtio_pci_modern_device {
>  	struct pci_dev *pci_dev;
>  =

>  	struct virtio_pci_common_cfg __iomem *common;
> -	/* Device-specific data (non-legacy mode)  */
>  	void __iomem *device;
> -	/* Base of vq notifications (non-legacy mode). */
>  	void __iomem *notify_base;
> -	/* Physical base of vq notifications */
>  	resource_size_t notify_pa;
> -	/* Where to read and clear interrupt */
>  	u8 __iomem *isr;
>  =

> -	/* So we can sanity-check accesses. */
>  	size_t notify_len;
>  	size_t device_len;
>  =

> -	/* Capability for when we need to map notifications per-vq. */
>  	int notify_map_cap;
>  =

> -	/* Multiply queue_notify_off by this value. (non-legacy mode). */
>  	u32 notify_offset_multiplier;
> -
>  	int modern_bars;
> -
>  	struct virtio_device_id id;
>  =

> -	/* optional check for vendor virtio device, returns dev_id or -ERRNO */
>  	int (*device_id_check)(struct pci_dev *pdev);
> -
> -	/* optional mask for devices with limited DMA space */
>  	u64 dma_mask;
>  };
>  =

> -- =

> 2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
