Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9F5C433EF
	for <virtualization@archiver.kernel.org>; Mon, 28 Mar 2022 20:45:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 37455415AE;
	Mon, 28 Mar 2022 20:45:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rz_g3FQf6x3V; Mon, 28 Mar 2022 20:45:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DFB7F4155C;
	Mon, 28 Mar 2022 20:45:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF804C002C;
	Mon, 28 Mar 2022 20:45:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16D11C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 20:45:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EACB04155C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 20:45:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sf7eu0E3dtiX
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 20:45:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 12A01400FD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 20:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648500334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LnKa6nTnZjVyLapB3u+K+tVTv5yyqsbvt80uXn7tlqE=;
 b=JcFJIigjIiPL6JRREFDdQY5GpHp/z9gh6xqcdtppD1w1SL3iKtYimWesOHx8nCPCGE9Tci
 CQtLiQ35OqnxeLERWoaUGz6/zYuhlL0JOKibpYc2EPT0xn64OuerhPSAjV1m5jYSpoJUNl
 uOpMxQFCbcOeRQPJha2iQAzqr19I3/Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-12-ByjwUyTPMxqRB2hEfrGykA-1; Mon, 28 Mar 2022 16:45:15 -0400
X-MC-Unique: ByjwUyTPMxqRB2hEfrGykA-1
Received: by mail-wm1-f69.google.com with SMTP id
 f19-20020a7bcd13000000b0038c01defd5aso208030wmj.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 13:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LnKa6nTnZjVyLapB3u+K+tVTv5yyqsbvt80uXn7tlqE=;
 b=0sZVY7yDz2E+dNxwkcRuYSr42/+XffjVLMPGNIQPiuwmO4fQzQ9gLjEjcl4pzCxjhU
 88HAQN9MRpyWELHd578JiJb6SFqx8S9k9MR7D0irt606SmQcSuNWfPlVPzdkdo1JghCH
 /k5lpPYynj/TsQEvpZTJRmSnnpbenpvvTKyI7C0ILbmrPMDolUH64F8boJhZn0GpKOw3
 u+hPS8pf2HB3E9t20xtBiyAvK86p8kjHW4FOFN7a4HN1KEtSUMVqqeo95UTsXZotLxxz
 thEYS2+Kfh83wwYUYbCGWlddEgMfeh28JC+7szzONeJmER1OiYCCCzgmDdvwlkrvXwXh
 tBOQ==
X-Gm-Message-State: AOAM531ho5t4054Sk6daqliooW0d8QWhNfw9nVkVgbZLtQMzwiQ166me
 CAMtnRrk+KNT//vi/9vyVGCpqI6eoKItE7NgZbGwQeQSwCWyPDG+aIJW7WBjojvZqDntF7De4Wv
 ChB9M06cKgPPAgREE6DluaqA+W1Bkuc7qlHMu9nhRzg==
X-Received: by 2002:adf:ed50:0:b0:203:da73:e0fd with SMTP id
 u16-20020adfed50000000b00203da73e0fdmr26662473wro.516.1648500313607; 
 Mon, 28 Mar 2022 13:45:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw074Uoe8XwVEA8gx6KrACZhH+gFVcy6Xz6Ap01CnGtcLywUMvECryjGZs5gVgeUc2Qy60EGg==
X-Received: by 2002:adf:ed50:0:b0:203:da73:e0fd with SMTP id
 u16-20020adfed50000000b00203da73e0fdmr26662453wro.516.1648500313409; 
 Mon, 28 Mar 2022 13:45:13 -0700 (PDT)
Received: from redhat.com ([2.52.9.207]) by smtp.gmail.com with ESMTPSA id
 z3-20020a1cf403000000b0037d1f4a2201sm431912wma.21.2022.03.28.13.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Mar 2022 13:45:12 -0700 (PDT)
Date: Mon, 28 Mar 2022 16:45:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: cgel.zte@gmail.com
Subject: Re: [PATCH] virito-pci-modern: Remove useless DMA-32 fallback
 configuration
Message-ID: <20220328164435-mutt-send-email-mst@kernel.org>
References: <20220318005858.2141967-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
In-Reply-To: <20220318005858.2141967-1-chi.minghao@zte.com.cn>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Zeal Robot <zealci@zte.com.cn>, linux-kernel@vger.kernel.org,
 Minghao Chi <chi.minghao@zte.com.cn>,
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

Typo in subj, and pls make subject match actual file name (_ not -).


On Fri, Mar 18, 2022 at 12:58:58AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> As stated in [1], dma_set_mask() with a 64-bit mask will never fail if
> dev->dma_mask is non-NULL.
> So, if it fails, the 32 bits case will also fail for the same reason.
> 
> Simplify code and remove some dead code accordingly.
> 
> [1]: https://lkml.org/lkml/2021/6/7/398
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/virtio/virtio_pci_modern_dev.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> index e8b3ff2b9fbc..dff0b15a239d 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -255,9 +255,6 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
>  	}
>  
>  	err = dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(64));
> -	if (err)
> -		err = dma_set_mask_and_coherent(&pci_dev->dev,
> -						DMA_BIT_MASK(32));
>  	if (err)
>  		dev_warn(&pci_dev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");
>  
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
