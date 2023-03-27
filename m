Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0457EC7619A
	for <virtualization@archiver.kernel.org>; Mon, 27 Mar 2023 13:36:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96A2061039;
	Mon, 27 Mar 2023 13:36:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 96A2061039
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H6R8Wjs8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A28U6Cyc3cPE; Mon, 27 Mar 2023 13:36:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 02E9761029;
	Mon, 27 Mar 2023 13:36:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 02E9761029
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD090C0035;
	Mon, 27 Mar 2023 13:36:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B025C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 13:36:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 347E541499
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 13:36:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 347E541499
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=H6R8Wjs8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2S3dSjHevWaz
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 13:36:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 49E0841477
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 49E0841477
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 13:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679924173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w0WnH59cO3DNXjLzNhkzvsOR902jw+28KkZ5Q+GRVgc=;
 b=H6R8Wjs8vLWXKqWYLr2ePpc5lBAWqZXDDE7YQdUxUnLRMtnAoaEXJds8c/lTb0Eug2XG7c
 R5eheqTMsagpVbpftvxJdG0QtJQFyRQihz2pRCNJhUNFXETzJy09QQFKgA1AIVNNV788rQ
 0HG5JydTnAWnAhLM9VNWYy1NWND2IQM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-mojv13XAPD-uw1JKnm40xg-1; Mon, 27 Mar 2023 09:36:11 -0400
X-MC-Unique: mojv13XAPD-uw1JKnm40xg-1
Received: by mail-wm1-f71.google.com with SMTP id
 bi7-20020a05600c3d8700b003edecc610abso5741461wmb.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 06:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679924170;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w0WnH59cO3DNXjLzNhkzvsOR902jw+28KkZ5Q+GRVgc=;
 b=NWDgKbT26Jr+UUQXSISR93nr2HTd4fIZ3wpnRtSisBBnN4eOfzYVRbOsbTQQkItKp0
 h9EHNmq4DU+u3Zv4pt74ZGBhZg1Om34sOxc1OYxlGgpwo8ttDOr3OKV6bf9CJFz1Jfu9
 2HDKnRuJIuknSks+quJxAObWHVCD4012wlz3JlK+95zvnaC1Qkt/jXK5acvKS/DlD22j
 PbZe4s/xJcxW9x0Rq38c+SiyL1wF1C9gJd5ARNSgr9niD1e+YgmPlflh2qbljHlQ8egH
 tZqCBqtArqfIgTlr90q/tt//T24wL0/2sfUr5ChearDmBwWdYCX9WIt0Kf40AJaXDF3z
 49rQ==
X-Gm-Message-State: AAQBX9e0IgnevDqzuzBoYX/LsM+zoB10yFczafkgahqQxPjji3xMkY5V
 98TNeC6BAgUcYeSiyWylPb72KFulMVZplfSJvR5Movnp4QHKYwvWd49YPBFCZHFhmiF47AM5rP2
 L/2Rm2tI8KsIy1gvz0BUiPYVB0sjIYCHZL4cXQdz6rA==
X-Received: by 2002:a05:600c:2144:b0:3ef:6396:d9b3 with SMTP id
 v4-20020a05600c214400b003ef6396d9b3mr5611178wml.18.1679924170781; 
 Mon, 27 Mar 2023 06:36:10 -0700 (PDT)
X-Google-Smtp-Source: AKy350aMdWh9bX9TOnPHFAyHpysM9JbX53EqVW9JFgmwk8D6C1mLAdfGYDbgl15l7ON/VrIwKtiLRw==
X-Received: by 2002:a05:600c:2144:b0:3ef:6396:d9b3 with SMTP id
 v4-20020a05600c214400b003ef6396d9b3mr5611164wml.18.1679924170447; 
 Mon, 27 Mar 2023 06:36:10 -0700 (PDT)
Received: from redhat.com ([2.52.153.142]) by smtp.gmail.com with ESMTPSA id
 p4-20020a05600c204400b003ee4e99a8f6sm13718097wmg.33.2023.03.27.06.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Mar 2023 06:36:10 -0700 (PDT)
Date: Mon, 27 Mar 2023 09:36:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH] vdpa/mlx5: Veirfy wq has a valid pointer in
 mlx5_vdpa_suspend
Message-ID: <20230327093241-mutt-send-email-mst@kernel.org>
References: <20230326131756.783554-1-elic@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230326131756.783554-1-elic@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: eperezma@redhat.com, parav@mellanox.com,
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

typos all over.

subject:
s/Veirfy/verify/
s/has/is/

On Sun, Mar 26, 2023 at 04:17:56PM +0300, Eli Cohen wrote:
> mlx5_vdpa_suspend() flushes the workqueue as part of its logic. However,
> if the devices has been deleted while a VM was runnig, the workqueue

s/the devices/the device/
s/runnig/running/

> would be destroyed first and wq will be null. After the VM is destroyed,
> suspend could be called and would access a null pointer.

s/could be/can be/
s/would/will/

> 
> Fix it by vrifyig wq is not NULL.

s/vrifyig/verifying/

> 
> Fixes: cae15c2ed8e6 ("vdpa/mlx5: Implement susupend virtqueue callback")
> Signed-off-by: Eli Cohen <elic@nvidia.com>


> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 8b52961d1d25..2805d58378fb 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2938,7 +2938,8 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
>  	down_write(&ndev->reslock);
>  	ndev->nb_registered = false;
>  	mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
> -	flush_workqueue(ndev->mvdev.wq);
> +	if (ndev->mvdev.wq)
> +		flush_workqueue(ndev->mvdev.wq);
>  	for (i = 0; i < ndev->cur_num_vqs; i++) {
>  		mvq = &ndev->vqs[i];
>  		suspend_vq(ndev, mvq);
> -- 
> 2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
