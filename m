Return-Path: <SRS0=k93m=FM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94A6C4361B
	for <virtualization@archiver.kernel.org>; Tue,  8 Dec 2020 21:45:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6076A23B26
	for <virtualization@archiver.kernel.org>; Tue,  8 Dec 2020 21:45:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6076A23B26
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C41F0275A5;
	Tue,  8 Dec 2020 21:45:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VA5MhyH+9Obu; Tue,  8 Dec 2020 21:45:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8E91C204BB;
	Tue,  8 Dec 2020 21:45:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61265C0FA7;
	Tue,  8 Dec 2020 21:45:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8399C013B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 21:45:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CE76586AE8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 21:45:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1o0Quro0fIdT
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 21:45:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id ABAA786AC6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 21:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607463912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+efrBz8AmXzGUD15XyQRufBjSK+9yNQ71jf2nuJyarI=;
 b=CGHVdKAMGjrf+KC3JIR5Na1LOzfKpvRqnXwYw8l01NSpcEm25VZ1Co9+yMfI/0Namn5W6K
 LvQh0QNKdZg9j5q8JWqRPgKYSJhSjUbjutiZmc1HTFh+s1wqwd6ArH4zwFf/+AThtnyT2i
 C9w7kc3gqtmBMbs7MaGIJPxTSTIkj9M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-yGvyrMgSO8-Q9l-KjC1TCg-1; Tue, 08 Dec 2020 16:45:10 -0500
X-MC-Unique: yGvyrMgSO8-Q9l-KjC1TCg-1
Received: by mail-wr1-f69.google.com with SMTP id 91so6674161wrk.17
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Dec 2020 13:45:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+efrBz8AmXzGUD15XyQRufBjSK+9yNQ71jf2nuJyarI=;
 b=ZgMnoE4KZdhkvD7XCS739nTUPLajc8cZRq+ECTVx9uQyCXjd20zG9vvmbHFoUS7DPo
 wdbG5tnELdWm5RKcQJpO7aymF62WThCtqXoHDNdQ51X+WbrUY8jLXAD9bMfW5zLZT/Mi
 jNjndJ+ydUALthiSeBN9cW7K3cYRNvMzv0nGbfGs2jsJCpw4BaEVx4aA7sR1aygmqToo
 HyiTaRKUu3vdm6x8eysZpTGLmqDFMmCVD5Fv7P9BHHwVEjaLMsA+QNBIB/ht+0yQkfua
 HcBQrVy5X8VpbkzGa5StFPKqL5dBegxF0+7ioSUXLUF7IQZ1THozm9pskjTI+0tZpuSK
 QqCA==
X-Gm-Message-State: AOAM5311gkhpeYpDCdnekq5NHMhI8t5vE3s0YCG2CLONp9fi6zcFn+hE
 15/oKLdP+5TAL8aPoGv9qKKlHuKChV2GYpYId2GzU1F1AuxsMswXGKh3czXgA41XU0NF4JUq4dy
 qag9rOpdmU8fG6EUOCRW8qmIVkADO6RpCjdgONxGXog==
X-Received: by 2002:a5d:6902:: with SMTP id t2mr104777wru.214.1607463908413;
 Tue, 08 Dec 2020 13:45:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXGvbxAcbO5BFwkDYJ7jC95TKxqn9gNikXqZCE7BFMQOriT1WGuoUMulzEYkt3Yx0aZc7tWA==
X-Received: by 2002:a5d:6902:: with SMTP id t2mr104763wru.214.1607463908279;
 Tue, 08 Dec 2020 13:45:08 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
 by smtp.gmail.com with ESMTPSA id n17sm99784wmc.33.2020.12.08.13.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Dec 2020 13:45:07 -0800 (PST)
Date: Tue, 8 Dec 2020 16:45:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH] vdpa/mlx5: Use write memory barrier after updating CQ
 index
Message-ID: <20201208164356-mutt-send-email-mst@kernel.org>
References: <20201206105719.123753-1-elic@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20201206105719.123753-1-elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, lulu@redhat.com,
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

On Sun, Dec 06, 2020 at 12:57:19PM +0200, Eli Cohen wrote:
> Make sure to put write memory barrier after updating CQ consumer index
> so the hardware knows that there are available CQE slots in the queue.
> 
> Failure to do this can cause the update of the RX doorbell record to get
> updated before the CQ consumer index resulting in CQ overrun.
> 
> Change-Id: Ib0ae4c118cce524c9f492b32569179f3c1f04cc1
> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Aren't both memory writes? And given that, isn't dma_wmb() sufficient
here?


> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 1f4089c6f9d7..295f46eea2a5 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -478,6 +478,11 @@ static int mlx5_vdpa_poll_one(struct mlx5_vdpa_cq *vcq)
>  static void mlx5_vdpa_handle_completions(struct mlx5_vdpa_virtqueue *mvq, int num)
>  {
>  	mlx5_cq_set_ci(&mvq->cq.mcq);
> +
> +	/* make sure CQ cosumer update is visible to the hardware before updating
> +	 * RX doorbell record.
> +	 */
> +	wmb();
>  	rx_post(&mvq->vqqp, num);
>  	if (mvq->event_cb.callback)
>  		mvq->event_cb.callback(mvq->event_cb.private);
> -- 
> 2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
