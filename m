Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802BFCA0FE9
	for <virtualization@archiver.kernel.org>; Tue, 12 Sep 2023 20:54:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1972B40BFB;
	Tue, 12 Sep 2023 20:54:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1972B40BFB
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CM02FocD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ri55UNFmPvYI; Tue, 12 Sep 2023 20:54:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9A7E0404DB;
	Tue, 12 Sep 2023 20:54:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9A7E0404DB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77D04C0071;
	Tue, 12 Sep 2023 20:54:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79DDEC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 20:54:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4558840898
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 20:54:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4558840898
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CM02FocD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gT23n3YL3-pa
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 20:54:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 16DFF40886
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 20:54:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 16DFF40886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694552063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ijWxXQrMbFDRYhu2hkP5ViJPf81XjON2E0T1RctinI0=;
 b=CM02FocD+cj6WPX2nTeL0EINIg3MMMFi7ImOSmL7FgAe05sYIkzZ4VQIz0HRGu2LL0hmBm
 HC/5zsnlFvzs79+XJgoGDiTnAeKM9ocNoF6fdCNO67uIghi4TnCsdZLrfRnOUeRFPSsoDF
 xRZelhG1ui1ylOUzHZ2xENDi0p2jBmE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-K_RD0d57MH2iE8fMDLf8tA-1; Tue, 12 Sep 2023 16:54:21 -0400
X-MC-Unique: K_RD0d57MH2iE8fMDLf8tA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-94f7a2b21fdso388487466b.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 13:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694552060; x=1695156860;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ijWxXQrMbFDRYhu2hkP5ViJPf81XjON2E0T1RctinI0=;
 b=PlRzJxk4gKdwx3/MkS9a/t8HlDBJxaVp5hD447h2AbqadRKJttTYghCiOYRvXcXFUv
 6gbh9cIcAmp6+02zCU6QwEJcj6MJUT5aitCQNAtK4ZnvIwlUwHgXNaQbzPQH9RhiSa9J
 ud50CAWx3XZAoCHaTzQi5xbiU8xpADtebXki7fryTALBVpy3yDnN9TnJp5/m9ilXkXsK
 hrQLfzQ03gaH45/pO8F8Eg85ULFRRaojrB1UlPe88bBNnQr4bCvpqJ7crCFE5B52DWAz
 ZPxMLHMAN9LD9TFCiZLaAhUR9ESYjXNSg1wcN+bTmbERZtfN9wtyx0OSE8vqVwUkbCr2
 kedA==
X-Gm-Message-State: AOJu0YwNBQURpbgviufmsU69hOB2hdSK1p9CVPVG3QFBu8eaWmDpce06
 H6MOfufQZXgNzDzCNk6Ol5EtuxPxSF7OeVEg1Vv0qlZIlF+5fbfKj8OJF+M7Z07CNnXBEiVwpxq
 PKzW2+nOgYbqPWI3QyFK5vbNr6veDNrEcqSdcO+qzww==
X-Received: by 2002:a17:907:762d:b0:9a1:edfd:73b2 with SMTP id
 jy13-20020a170907762d00b009a1edfd73b2mr333970ejc.2.1694552060374; 
 Tue, 12 Sep 2023 13:54:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnYBJkuLhJzI88PFNoikAiC6EDSv3wLMLb4ZDAGoRXLAyQXdTnHGROIdoQ7FcDxEiAcFo9rQ==
X-Received: by 2002:a17:907:762d:b0:9a1:edfd:73b2 with SMTP id
 jy13-20020a170907762d00b009a1edfd73b2mr333957ejc.2.1694552060112; 
 Tue, 12 Sep 2023 13:54:20 -0700 (PDT)
Received: from redhat.com ([2.52.10.100]) by smtp.gmail.com with ESMTPSA id
 h10-20020a1709063b4a00b009737b8d47b6sm7203807ejf.203.2023.09.12.13.54.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 13:54:19 -0700 (PDT)
Date: Tue, 12 Sep 2023 16:54:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Subject: Re: [PATCH net-next] virtio: kdoc for struct virtio_pci_modern_device
Message-ID: <20230912165357-mutt-send-email-mst@kernel.org>
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

not sure why this is net material though.
I think I will take it in virtio tree.

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
