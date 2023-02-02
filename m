Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A008DC05027
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 17:30:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D1C9611C2;
	Thu,  2 Feb 2023 17:30:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2D1C9611C2
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h5bCdzG0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PCNtg4UlNNoq; Thu,  2 Feb 2023 17:30:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C16D961185;
	Thu,  2 Feb 2023 17:30:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C16D961185
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9973CC0033;
	Thu,  2 Feb 2023 17:30:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 413CEC002B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 17:30:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1B31361195
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 17:30:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1B31361195
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W6-kHN2kPefB
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 17:30:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CC0EB61185
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CC0EB61185
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 17:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675359001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RNaVe47uc7Q0fXzG8SuhGtyD3Y8OoxsATTFxBzgPmNM=;
 b=h5bCdzG0TaVXrTOnUYhLMm9/PO4oewF6n2eebLvMRKEkrZWj8Hlsx14tTIv8lrlKM6Hytp
 Iu246jPaO9zEJ1l0AXdvyQydM0RSH+d/w8Zi2wNh48zp0nt+7YsSQFpqM0V45orSdh7O9H
 VspDRM8kAr4OUrCbgmUvstgKEPg4m50=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-151-V3HfHncmPxed-pUzEykjkg-1; Thu, 02 Feb 2023 12:29:59 -0500
X-MC-Unique: V3HfHncmPxed-pUzEykjkg-1
Received: by mail-ej1-f71.google.com with SMTP id
 wu9-20020a170906eec900b0088e1bbefaeeso2014329ejb.12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Feb 2023 09:29:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RNaVe47uc7Q0fXzG8SuhGtyD3Y8OoxsATTFxBzgPmNM=;
 b=Lclu0FPRrV1o37LfDxs0qN/8QR4/0JRwsrZlNWO3dO5VWd9bok2Rw3sr9hLRb66UH0
 /oKpA8///We38/E795x9OIDdhlRrDT+o3pdsh/PZ8bSW500GbAOtsqcykBp1GRdvPBlz
 nVg3+ba1t4RKVpzsc6BbNDgI5HFB8tJ7XzJpmc2ZJ+OEWAlsWyiwkCFB8x8PSmGyL6G0
 0rt7GXoCSj22tRQMFArBPXGyXd/IbBVzxtFsqhCaiCA2b8dTkJUbaG1Y6TRp+EUcAjmA
 aytxJh70rfq4VKROlyzcOg9iOZANIqQem/hCaQLAjdU1azOI8StEsQK6swUZ8JUOHXQJ
 gZbA==
X-Gm-Message-State: AO0yUKUOHwIDZIhY1gjjWJeWuVrqm74/0ZUJR/1UclygNMLZdtD3DFD7
 E70q1s5LTmorvU+ZOjJXkqMwNnrXsZEaBfDacIRNnRQ2jU4g3ZyKyFM9+iCHIEiG+fyTrgRx3oO
 TLmBRBxV1odcoOMjNMO1OWynJWkgCxItOOCo7C1pc7w==
X-Received: by 2002:a17:907:6d15:b0:885:fcbd:40d3 with SMTP id
 sa21-20020a1709076d1500b00885fcbd40d3mr9622061ejc.8.1675358998408; 
 Thu, 02 Feb 2023 09:29:58 -0800 (PST)
X-Google-Smtp-Source: AK7set9yIZcEAYWK0GKq9rUYiFeEPeWHuu/njEMLeGRI1WCVonMJlxY1eZTX3Mwnwugq0+WHvT35eA==
X-Received: by 2002:a17:907:6d15:b0:885:fcbd:40d3 with SMTP id
 sa21-20020a1709076d1500b00885fcbd40d3mr9622045ejc.8.1675358998189; 
 Thu, 02 Feb 2023 09:29:58 -0800 (PST)
Received: from redhat.com ([2.52.156.122]) by smtp.gmail.com with ESMTPSA id
 j9-20020a170906534900b0088478517830sm70616ejo.83.2023.02.02.09.29.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Feb 2023 09:29:57 -0800 (PST)
Date: Thu, 2 Feb 2023 12:29:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH v2 4/7] virtio: VIRTIO_DEVICE_F_MASK for all per-device
 features
Message-ID: <20230202122851-mutt-send-email-mst@kernel.org>
References: <1675207345-22328-1-git-send-email-si-wei.liu@oracle.com>
 <1675207345-22328-5-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1675207345-22328-5-git-send-email-si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, elic@nvidia.com,
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

On Tue, Jan 31, 2023 at 03:22:22PM -0800, Si-Wei Liu wrote:
> Introduce VIRTIO_DEVICE_F_MASK bitmask used for identification
> of per-device features. Feature bits VIRTIO_TRANSPORT_F_START
> through VIRTIO_TRANSPORT_F_END are reserved for transport
> features hence are not counted as per-device features against
> the 64bit feature space.
> 
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  include/uapi/linux/virtio_config.h | 8 ++++++++
>  1 file changed, 8 insertions(+)

Pls don't add this in uapi, people tend to depend on this and then
things fail when we extend virtio. For example this won't work with >64
feature bits.

> 
> diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> index 3c05162..3bdc7ed 100644
> --- a/include/uapi/linux/virtio_config.h
> +++ b/include/uapi/linux/virtio_config.h
> @@ -54,6 +54,14 @@
>  #define VIRTIO_TRANSPORT_F_START	28
>  #define VIRTIO_TRANSPORT_F_END		41
>  
> +/*
> + * Bitmask for all per-device features: feature bits VIRTIO_TRANSPORT_F_START
> + * through VIRTIO_TRANSPORT_F_END are unset, i.e. 0xfffffc000fffffff for
> + * all 64bit features
> + */
> +#define VIRTIO_DEVICE_F_MASK (~0ULL << (VIRTIO_TRANSPORT_F_END + 1) | \
> +			      ((1ULL << VIRTIO_TRANSPORT_F_START) - 1))
> +
>  #ifndef VIRTIO_CONFIG_NO_LEGACY
>  /* Do we get callbacks when the ring is completely used, even if we've
>   * suppressed them? */
> -- 
> 1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
