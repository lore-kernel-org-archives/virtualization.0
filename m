Return-Path: <SRS0=hVMj=PQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8532C433F5
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 05:40:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CF6460F9D
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 05:40:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4CF6460F9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0322382542;
	Thu, 28 Oct 2021 05:40:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LDdRyx8v_gwn; Thu, 28 Oct 2021 05:40:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A5F7C82400;
	Thu, 28 Oct 2021 05:40:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 734D8C0012;
	Thu, 28 Oct 2021 05:40:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BEB0C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 05:40:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DB4A060627
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 05:40:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KLaFTljcFl-V
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 05:40:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 50637605E7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 05:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635399623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=anF7BPmbH7+9aDUvnziYE4TDy5s8dDRfTV6pgnlOgB8=;
 b=d6qXdqVEYQfqk578iPMGav8ECdHC91nJvquQpAeAzOWxElO1rMjGKbLP1iZh9ZclQQSWkl
 ZgIer3wEjCE82E4RU+Jml/ExEqJs1878PPM+8L/BXSRXGA4LHSoieqsP4OxGhKFtywTqkv
 BNMTtrsDwmEWqfcw9Q+1jacKZRb2d4U=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-Jo0cZuMZNCeRukpxDyEzYA-1; Thu, 28 Oct 2021 01:40:21 -0400
X-MC-Unique: Jo0cZuMZNCeRukpxDyEzYA-1
Received: by mail-ed1-f71.google.com with SMTP id
 s12-20020a50dacc000000b003dbf7a78e88so4512338edj.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 22:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=anF7BPmbH7+9aDUvnziYE4TDy5s8dDRfTV6pgnlOgB8=;
 b=fRbf+2KixtNMNG0ozrai/KDKnyTm/Saus7tT5mwNVisdrdR4VxHEELPzegC2s2Rlxa
 Cl/s8iA/e3QXzo9OMtwnq20vFxTD8JnPTy3aoG51y6w+bvfvnRjLR1JuaeWzqESbqD3p
 QL06+OeDaxFhlZQMB/AbRVK2EdTCTjS/YLfTRqrulPvd22+GfUAMT2u+LGoU7lYJunRA
 dxPx5ydQJpPjRSpK0I4PrRIFqour5O2RLWb9G1h+EA+fxz+VsEL+MYXOLNoNaIy9ckt4
 +Le/AP10eHoEC/bzTnhtCs/6Jm3KA7BMJoMrI/JaRjduBHY+25qsHse02GE7pjLyMSB7
 zTiQ==
X-Gm-Message-State: AOAM533sSd25LF1vqtHF5z3oQf7ouH9LNEGurRxeyBA5XSuwKiWgKWGw
 9XPYxP8Y+GO32SDCJZsxEL+j8880aAB2F2cBPdSrpOcXsm0mwoSd3iywhux+S1cRj6JqZ78sGIZ
 uU9Kd/j5rdlbLbEfnzL1N9RXiU9TyGDce1QtbA29TuQ==
X-Received: by 2002:a17:907:1caa:: with SMTP id
 nb42mr2599411ejc.333.1635399620608; 
 Wed, 27 Oct 2021 22:40:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQhd1vOTP7CLD/BJ5RCWNsTIMoyg9pY3KHXHXK3KvUR6nZvmqchxP6Ys9Sd0YzoBlY6gk8EA==
X-Received: by 2002:a17:907:1caa:: with SMTP id
 nb42mr2599392ejc.333.1635399620384; 
 Wed, 27 Oct 2021 22:40:20 -0700 (PDT)
Received: from redhat.com ([2.55.137.59])
 by smtp.gmail.com with ESMTPSA id n2sm657001ejl.92.2021.10.27.22.40.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Oct 2021 22:40:19 -0700 (PDT)
Date: Thu, 28 Oct 2021 01:40:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Erdem Aktas <erdemaktas@google.com>
Subject: Re: [RFC] Add DMA_API support for Virtio devices earlier than VirtIO
 1.0
Message-ID: <20211028013901-mutt-send-email-mst@kernel.org>
References: <20211027232828.2043569-1-erdemaktas@google.com>
MIME-Version: 1.0
In-Reply-To: <20211027232828.2043569-1-erdemaktas@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
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

On Wed, Oct 27, 2021 at 04:28:28PM -0700, Erdem Aktas wrote:
> Enable DMA_API for any VirtIO device earlier than Virtio 1.0 which
> is the only way for those devices to be configured correctly when
> memory access is retricted.
> 
> Virtio devices can use DMA_API to translate guest phsical addresses to
> device physical addresses if VIRTIO_F_ACCESS_PLATFORM feature is set
> while the device is being initialized. VIRTIO_F_ACCESS_PLATFORM
> feature is only supported in VirtIO 1.0 and later devices. This prevents
> any device using an earlier VirtIO version than Virtio 1.0 to be
> attached when memory access is restricted ie memory encryption features
> (AMD SEV [ES/SNP], Intel TDX, etc..) are enabled.
> 
> Signed-off-by: Erdem Aktas <erdemaktas@google.com>


Sorry .. NACK.

Virtio before 1.0 is on life support. No new features. Just use 1.0
please.


> ---
> I have tested the this patch using linux-stable.git head, 5.15.0-rc6
> kernel and scsi disk with virtio 0.95 version with legacy VM and
> Confidential VM (AMD SEV). I want to get feedback if
> there is any risk or downside of enabling DMA_API on older virtio
> drivers when memory encrytion is enabled.
> 
>  drivers/virtio/virtio.c       |  7 ++-----
>  include/linux/virtio_config.h | 22 ++++++++++++++--------
>  2 files changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 236081afe9a2..71115ba85d07 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -179,11 +179,8 @@ int virtio_finalize_features(struct virtio_device *dev)
>  	if (ret) {
>  		if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1)) {
>  			dev_warn(&dev->dev,
> -				 "device must provide VIRTIO_F_VERSION_1\n");
> -			return -ENODEV;
> -		}
> -
> -		if (!virtio_has_feature(dev, VIRTIO_F_ACCESS_PLATFORM)) {
> +				 "device does not provide VIRTIO_F_VERSION_1 while restricted memory access is enabled!.\n");
> +		} else if (!virtio_has_feature(dev, VIRTIO_F_ACCESS_PLATFORM)) {
>  			dev_warn(&dev->dev,
>  				 "device must provide VIRTIO_F_ACCESS_PLATFORM\n");
>  			return -ENODEV;
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 8519b3ae5d52..6eacb4d43318 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -170,6 +170,15 @@ static inline bool virtio_has_feature(const struct virtio_device *vdev,
>  	return __virtio_test_bit(vdev, fbit);
>  }
>  
> +#ifdef CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
> +int arch_has_restricted_virtio_memory_access(void);
> +#else
> +static inline int arch_has_restricted_virtio_memory_access(void)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS */
> +
>  /**
>   * virtio_has_dma_quirk - determine whether this device has the DMA quirk
>   * @vdev: the device
> @@ -180,6 +189,11 @@ static inline bool virtio_has_dma_quirk(const struct virtio_device *vdev)
>  	 * Note the reverse polarity of the quirk feature (compared to most
>  	 * other features), this is for compatibility with legacy systems.
>  	 */
> +	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1) &&
> +	   arch_has_restricted_virtio_memory_access())
> +		return false;
> +
> +
>  	return !virtio_has_feature(vdev, VIRTIO_F_ACCESS_PLATFORM);
>  }
>  
> @@ -558,13 +572,5 @@ static inline void virtio_cwrite64(struct virtio_device *vdev,
>  		_r;							\
>  	})
>  
> -#ifdef CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
> -int arch_has_restricted_virtio_memory_access(void);
> -#else
> -static inline int arch_has_restricted_virtio_memory_access(void)
> -{
> -	return 0;
> -}
> -#endif /* CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS */
>  
>  #endif /* _LINUX_VIRTIO_CONFIG_H */
> -- 
> 2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
