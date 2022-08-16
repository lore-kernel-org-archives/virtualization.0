Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B7DC2BB41
	for <virtualization@archiver.kernel.org>; Tue, 16 Aug 2022 13:41:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8170861038;
	Tue, 16 Aug 2022 13:41:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8170861038
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CsfEe8vY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EFJZIKhCq4qj; Tue, 16 Aug 2022 13:41:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F30F561028;
	Tue, 16 Aug 2022 13:41:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F30F561028
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CADD6C0033;
	Tue, 16 Aug 2022 13:41:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9DA4C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 13:41:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A439D61036
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 13:41:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A439D61036
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lizunNShVEH4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 13:41:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AC76261028
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AC76261028
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 13:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660657277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1UCrYFr0DcB0r8pAF7e2ByinvijBGvEey6g1DDxFix8=;
 b=CsfEe8vYFB5kHeW9TzU2ewNc6WlP+O5wNSXynJEz9o2HRZhF1/My45Qpplgjlmrhy4WAi5
 RgkKOaSle8BP87/u6Za6PQ2DAWaF9njLsV+cWzCNuKAzaBoMXRpmzG7A7N1cBuytlBU6Lp
 PW+FoSkurEkQijWqyzib2dW/ZxKJYWI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-206-oXgRhaEjNMC-YpX-uoFPoQ-1; Tue, 16 Aug 2022 09:41:16 -0400
X-MC-Unique: oXgRhaEjNMC-YpX-uoFPoQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 o3-20020adfa103000000b0022514e8e99bso495799wro.19
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 06:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=1UCrYFr0DcB0r8pAF7e2ByinvijBGvEey6g1DDxFix8=;
 b=BpgrIdym61P04l5UR6GQ4SrU41sz0n1rsiLegivk/mheo+Ap8U4re5TbS9oASEsXQx
 rADh4xD7iwPhBzjLvEX9EEu5aOl6kxlQBkm08MvIOMLRG761ypVeEOXLyMTgCDiFvT73
 +zRYRvgh2e3KyDSW62YZZN3dbZzK3RaVAS+s3GtkFwkQ+nfqEvMkku2w8FN3P//Fa94Y
 LM5TZII0gK4Zsj9+J+GTwHgXO8mFSB3OyJPEqinUV0tintlMkTi8VLPdIS5vpRaiwa0E
 GXkZ0miG2fzZAR/TkEwKZn19sqNCbnAnxLosNQTbmjqrVEYEdmoGsARJWm9DaSngnRKC
 ALzA==
X-Gm-Message-State: ACgBeo08B6+CC1Vs/sgWdH3AtIT8+4MKh7LHo+9Zs+9TSn5ntnQpRisP
 uDVMTw6dQffGeDiM7Z1HVmFslCANyNKNwHfFsY2OSeIR5Zv9+QNsmfxrsKu9rordAMujp4mnxYI
 YOHs448bv7ttR2CBTmwnXcnxSJVDmRFQ5xHei+WK48g==
X-Received: by 2002:a5d:5281:0:b0:224:fe40:798f with SMTP id
 c1-20020a5d5281000000b00224fe40798fmr6859128wrv.90.1660657275095; 
 Tue, 16 Aug 2022 06:41:15 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5ZTvheSv0ssbv5tHt+swIqUffpectLQQ19ywUNmPTvA8oR25a/bCcOt24S9+Qd7ZYoOOBDOA==
X-Received: by 2002:a5d:5281:0:b0:224:fe40:798f with SMTP id
 c1-20020a5d5281000000b00224fe40798fmr6859117wrv.90.1660657274871; 
 Tue, 16 Aug 2022 06:41:14 -0700 (PDT)
Received: from redhat.com ([2.55.43.215]) by smtp.gmail.com with ESMTPSA id
 c21-20020a05600c0ad500b003a53e6c5425sm12677021wmr.8.2022.08.16.06.41.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Aug 2022 06:41:14 -0700 (PDT)
Date: Tue, 16 Aug 2022 09:41:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: Re: [PATCH] drivers/virtio: fix repeated words in comments
Message-ID: <20220816094100-mutt-send-email-mst@kernel.org>
References: <20220816125959.23737-1-yuanjilin@cdjrlc.com>
MIME-Version: 1.0
In-Reply-To: <20220816125959.23737-1-yuanjilin@cdjrlc.com>
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

On Tue, Aug 16, 2022 at 08:59:59PM +0800, Jilin Yuan wrote:
>  Delete the redundant word 'the'.
> 
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>

send this kind of thing to trivial pls.

> ---
>  drivers/virtio/virtio_mmio.c           | 2 +-
>  drivers/virtio/virtio_pci_modern_dev.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index f9a36bc7ac27..f638142654e6 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -255,7 +255,7 @@ static void vm_set_status(struct virtio_device *vdev, u8 status)
>  
>  	/*
>  	 * Per memory-barriers.txt, wmb() is not needed to guarantee
> -	 * that the the cache coherent memory writes have completed
> +	 * that the cache coherent memory writes have completed
>  	 * before writing to the MMIO region.
>  	 */
>  	writel(status, vm_dev->base + VIRTIO_MMIO_STATUS);
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> index a0fa14f28a7f..b790f30b2b56 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -469,7 +469,7 @@ void vp_modern_set_status(struct virtio_pci_modern_device *mdev,
>  
>  	/*
>  	 * Per memory-barriers.txt, wmb() is not needed to guarantee
> -	 * that the the cache coherent memory writes have completed
> +	 * that the cache coherent memory writes have completed
>  	 * before writing to the MMIO region.
>  	 */
>  	vp_iowrite8(status, &cfg->device_status);
> -- 
> 2.36.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
