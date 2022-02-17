Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547E2C433F5
	for <virtualization@archiver.kernel.org>; Thu, 17 Feb 2022 11:49:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA76A825B1;
	Thu, 17 Feb 2022 11:49:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WtQ2EXllqfYm; Thu, 17 Feb 2022 11:49:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 80AC281D88;
	Thu, 17 Feb 2022 11:49:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5711DC0021;
	Thu, 17 Feb 2022 11:49:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 302A6C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 11:49:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 233114023F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 11:49:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qwgX6yR9gH2f
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 11:49:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2C1EA401AF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 11:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645098592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gALIg6xlgMdhdwx8t2xzrU0jw5dw1sQaOoUvnaVhPS4=;
 b=NU3YFNaVZJJiKQLxStsWMFtOo8BMEXHQj3GxPBp3H+Iq7xuQ2hfP2b6TTlI+aRVNxSzbEt
 R66kmTc3L5NjV2fpNm7JPGPPACYGTCXPIh6XWoJO/Sm+b0bfpg6ihFdmFxW9eERajt/Fsm
 b8aCCL02xGuV3D7OcVEeNmGSNt3tokw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-118-KTvS5hm2NsiuTo7DMXMKKA-1; Thu, 17 Feb 2022 06:49:51 -0500
X-MC-Unique: KTvS5hm2NsiuTo7DMXMKKA-1
Received: by mail-wr1-f69.google.com with SMTP id
 g11-20020adfa48b000000b001e57dfb3c38so2194606wrb.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 03:49:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gALIg6xlgMdhdwx8t2xzrU0jw5dw1sQaOoUvnaVhPS4=;
 b=NG8HcqpE0/vu1cEi5DNTPMsiFKa2zknLqxRT7DuUMP4lzEinsyU4KS4FaIq/h/rQTy
 6vB8LkZk+cT1FLuXPiYXJXU2fzW9f8i6vwT627LAoE8FT7JVSJcyfcS1p5nDGyBxA5zd
 AF/1n73V9wj3kseYkpt1XzMr8eaUhY87ImBgdE0QI8eXETmYsRsfNZRkIiqQSXXdGsC2
 IZKyhvW8+3ZyrN4db0ujEkFaCVL3iXJcGISYWwF7RfUWdM83fUEJsca8YaP702d97aMD
 Il9POsuFYfnDpVlHm7JOhq47hf/KEKtOBIgPMr/196TwQUysT44yDBAhVtinfzrGTbCk
 7w6g==
X-Gm-Message-State: AOAM533QLCAaE8ydullXQdlZOFPKwSo+qAy51lCpmNFx4ntjp0nEPnD/
 /yjxB3zIUCv3KqbLdjXonfeHn/KQDcEjGeAa1dA9ak8rhPakfDKnEIRFsuzJ8q+GSdrOcWzJWev
 bagsF1/W9apwne+KkpVpx5eA6l7A2aKw8SSvmKEbpvQ==
X-Received: by 2002:a5d:6da3:0:b0:1e3:2f74:f025 with SMTP id
 u3-20020a5d6da3000000b001e32f74f025mr2042016wrs.59.1645098590368; 
 Thu, 17 Feb 2022 03:49:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxFFm2H3T61W7L3b2Wo/F3BcJhy2eZbqbZiWDR+4LRCBqflJflNdzUZXqfXont0bQDGNIXjRw==
X-Received: by 2002:a5d:6da3:0:b0:1e3:2f74:f025 with SMTP id
 u3-20020a5d6da3000000b001e32f74f025mr2041996wrs.59.1645098590133; 
 Thu, 17 Feb 2022 03:49:50 -0800 (PST)
Received: from redhat.com ([2.55.139.83])
 by smtp.gmail.com with ESMTPSA id k34sm1051134wms.35.2022.02.17.03.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Feb 2022 03:49:47 -0800 (PST)
Date: Thu, 17 Feb 2022 06:49:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH] virtio: Add definition for VIRTIO_F_NOTIFICATION_DATA
 feature flag
Message-ID: <20220217064512-mutt-send-email-mst@kernel.org>
References: <20220217095545.195426-1-elic@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20220217095545.195426-1-elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lvivier@redhat.com, virtualization@lists.linux-foundation.org,
 stephen@networkplumber.org, eperezma@redhat.com,
 Edward Cree <ecree@solarflare.com>, si-wei.liu@oracle.com
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

On Thu, Feb 17, 2022 at 11:55:45AM +0200, Eli Cohen wrote:
> This is required by iproute2 to display the capabilities of a vdpa based
> virtio device.
> 
> Previously, drivers/net/ethernet/sfc/mcdi_pcol.h made use of a private
> definition of this flag. Modify the definition to rely on the new
> generic definition.
> 
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>  drivers/net/ethernet/sfc/mcdi_pcol.h | 2 +-
>  include/uapi/linux/virtio_config.h   | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/sfc/mcdi_pcol.h b/drivers/net/ethernet/sfc/mcdi_pcol.h
> index d3fcbf930dba..2603e04dae06 100644
> --- a/drivers/net/ethernet/sfc/mcdi_pcol.h
> +++ b/drivers/net/ethernet/sfc/mcdi_pcol.h
> @@ -21477,7 +21477,7 @@
>  #define        VIRTIO_BLK_CONFIG_VIRTIO_F_SR_IOV_LBN 37
>  #define        VIRTIO_BLK_CONFIG_VIRTIO_F_SR_IOV_WIDTH 1
>  #define        VIRTIO_BLK_CONFIG_VIRTIO_F_NOTIFICATION_DATA_OFST 0
> -#define        VIRTIO_BLK_CONFIG_VIRTIO_F_NOTIFICATION_DATA_LBN 38
> +#define        VIRTIO_BLK_CONFIG_VIRTIO_F_NOTIFICATION_DATA_LBN VIRTIO_F_NOTIFICATION_DATA
>  #define        VIRTIO_BLK_CONFIG_VIRTIO_F_NOTIFICATION_DATA_WIDTH 1
>  #define       VIRTIO_BLK_CONFIG_FEATURES_LBN 0
>  #define       VIRTIO_BLK_CONFIG_FEATURES_WIDTH 64

I don't think we need to bother with macros in mcdi_pcol.h - that header
is generated by some kind of script, this probably is why it has
all these macros that are otherwise unused.

Cc Edward Cree who added them - Edward, is there a way to
get rid of VIRTIO_ macros inmcdi_pcol.h?

> diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> index b5eda06f0d57..30eb76dcdcad 100644
> --- a/include/uapi/linux/virtio_config.h
> +++ b/include/uapi/linux/virtio_config.h
> @@ -92,4 +92,10 @@
>   * Does the device support Single Root I/O Virtualization?
>   */
>  #define VIRTIO_F_SR_IOV			37
> +
> +/* When negotiated, indicates that the driver can pass extra data beyond
> + * virtqueue identification when sending notifications
> + */
> +#define VIRTIO_F_NOTIFICATION_DATA	38
> +
>  #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */
> -- 
> 2.32.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
