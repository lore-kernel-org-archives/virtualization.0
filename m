Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B47BC433F5
	for <virtualization@archiver.kernel.org>; Thu, 13 Jan 2022 07:00:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 30F2484BFD;
	Thu, 13 Jan 2022 07:00:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t2joFzmyRvlt; Thu, 13 Jan 2022 07:00:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C376F84C02;
	Thu, 13 Jan 2022 07:00:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90211C002F;
	Thu, 13 Jan 2022 07:00:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 831BCC001E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 07:00:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 536E740407
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 07:00:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6l50kZzyYDI8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 07:00:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 72E6D4000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 07:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642057218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oofgJiBVYgqLMYLTw/TgzerEJj9jajjpyLtxuQwmllE=;
 b=doquDcxdMevCjhXMjB42yNH698cnIKI6gi47Yr3250C+ZdQHEB8v8fxB1LOqR9XIDylXj6
 A+30oW7RnY/a0qTQIRgaGTzEwcRTpcQhiYtX9vm8OEMcGOgaNPbuMzp6RCmUU5WjUxwYQz
 /UNcIbxZ8ORck7l7syv0vd+TPBZb9HA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-UZ8VWD1wN2q06SF78dpKQg-1; Thu, 13 Jan 2022 02:00:14 -0500
X-MC-Unique: UZ8VWD1wN2q06SF78dpKQg-1
Received: by mail-ed1-f70.google.com with SMTP id
 s7-20020a056402520700b003f841380832so4484881edd.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 23:00:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oofgJiBVYgqLMYLTw/TgzerEJj9jajjpyLtxuQwmllE=;
 b=Pxx8Nb7JpzeaCyE5W+flEkat3CLXxdMYwAZm0zuFQHCsH+S7g058exwNVSRsOLYPxC
 DvU8dsJ3O8aELY5Q2xLrRvCP49racAZI+815Sq8fow8So9r8SJfW5pSUXcpyV4eDb8ky
 GIWaUAQVAm44tCwjaMQkk+HMOVE0ScDhfYdsFd7E1qn5IQs9sgZ8V4v2vaYxeMhjgcdN
 80UsPmfhqGmfjJ0Qwd4worPk6tntwAEJ72kTdUyk+rRWhjklttAXNRQjlYVeRe5+gtG/
 t0J7s5qKHLXNnev+WFOuefNKdyMNzYrrRVDkuYYrf1pCf+PT2uiKNdpG/RNtXw6x7W6Q
 qDuA==
X-Gm-Message-State: AOAM532QZWzW35FGcKsrgB90RMLTmMi7DDE5oQdDSmegfmN5HfgQVVxU
 3YJ33J5kIcTzY5LP618po5uw5cjGYiv+Ai+gbCCpJCxZeJ3ew7+W//8lfZXRByluqGLKoSmlJfJ
 StE5hO6QRyfo0Cx7NS3+O7VAIy2ricO+E+9Vv0+lw6w==
X-Received: by 2002:a17:906:505:: with SMTP id
 j5mr2493675eja.764.1642057213101; 
 Wed, 12 Jan 2022 23:00:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzsuEkCf+M3LqO+UXo/dJb6S9DEDf1p+idULT9S19BZo4BvRH32YV1N9UNaUE5TR0HPo3g75g==
X-Received: by 2002:a17:906:505:: with SMTP id
 j5mr2493668eja.764.1642057212929; 
 Wed, 12 Jan 2022 23:00:12 -0800 (PST)
Received: from redhat.com ([2.55.6.51])
 by smtp.gmail.com with ESMTPSA id kx8sm553246ejc.126.2022.01.12.23.00.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jan 2022 23:00:12 -0800 (PST)
Date: Thu, 13 Jan 2022 02:00:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH 3/3] vdpa/mlx5: validate the queue pair value from driver
Message-ID: <20220113015815-mutt-send-email-mst@kernel.org>
References: <1642050651-16197-1-git-send-email-si-wei.liu@oracle.com>
 <1642050651-16197-4-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1642050651-16197-4-git-send-email-si-wei.liu@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lvivier@redhat.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, elic@nvidia.com
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

On Thu, Jan 13, 2022 at 12:10:51AM -0500, Si-Wei Liu wrote:
> Fixes: 52893733f2c5 ("vdpa/mlx5: Add multiqueue support")
> Signed-off-by: Si-Wei Liu<si-wei.liu@oracle.com>

Add motivation for change in the commit log.


> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 46d4deb..491127f 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1563,11 +1563,21 @@ static virtio_net_ctrl_ack handle_ctrl_mq(struct mlx5_vdpa_dev *mvdev, u8 cmd)
>  
>  	switch (cmd) {
>  	case VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET:
> +		/* This mq feature check aligns with pre-existing userspace implementation,
> +		 * although the spec doesn't mandate so.

And so ... why do we bother? what breaks if we don't?

> +		 */
> +		if (!MLX5_FEATURE(mvdev, VIRTIO_NET_F_MQ))
> +			break;
> +


this part is not described in the commit log at all.
is it intentional?

>  		read = vringh_iov_pull_iotlb(&cvq->vring, &cvq->riov, (void *)&mq, sizeof(mq));
>  		if (read != sizeof(mq))
>  			break;
>  
>  		newqps = mlx5vdpa16_to_cpu(mvdev, mq.virtqueue_pairs);
> +		if (newqps < VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN ||
> +		    newqps > mlx5_vdpa_max_qps(mvdev->max_vqs))
> +			break;
> +
>  		if (ndev->cur_num_vqs == 2 * newqps) {
>  			status = VIRTIO_NET_OK;
>  			break;
> -- 
> 1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
