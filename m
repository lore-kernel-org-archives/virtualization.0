Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12902C761A6
	for <virtualization@archiver.kernel.org>; Tue,  4 Apr 2023 15:07:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4C1814051A;
	Tue,  4 Apr 2023 15:07:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4C1814051A
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=As7jdBmj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O5Djdh7K0Lq4; Tue,  4 Apr 2023 15:07:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B0F6E400EA;
	Tue,  4 Apr 2023 15:07:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B0F6E400EA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 880A8C0037;
	Tue,  4 Apr 2023 15:07:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB7BFC002F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 15:07:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B2D4960BE6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 15:07:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B2D4960BE6
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=As7jdBmj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3nMF7WiMEtDr
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 15:07:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8B6C960B0D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8B6C960B0D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 15:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680620852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rQk3nISo4vMzd8ey9AutG4ssv6ydC5hYrH0Vy7FuS8M=;
 b=As7jdBmje2ZGgH8GzWzWobKWSjY33tpYN7xhrQWGuL1lg5QaNuYXU58ybcGFt2rBr0isvK
 ZpsrD5c3SKYngixoqH26deKJlDGNe2YmAkmYAxu+G0KBOpQ7DMB1WNrQvAgFK2y+YfhNcX
 AtRlSv4yGWydIeIfBrye0z7MMsM722k=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-fZwlbWKBPh-kC33Sfma7Xw-1; Tue, 04 Apr 2023 11:07:27 -0400
X-MC-Unique: fZwlbWKBPh-kC33Sfma7Xw-1
Received: by mail-ed1-f69.google.com with SMTP id
 s30-20020a508d1e000000b005005cf48a93so46193911eds.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Apr 2023 08:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680620846;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rQk3nISo4vMzd8ey9AutG4ssv6ydC5hYrH0Vy7FuS8M=;
 b=EbcFgRE7BJoLhBXye0jPWal2pnA/PdrdxnnPIHu0U8TnLLnZ2YJcGuakQQCtIQP82u
 7NYy2c6apEm7F1n4Sacxn4h0vBAXSTwGkj2EtPb+1fsMq5W0m0kp76hpEVg604yEUqPJ
 fyLjbuIatbYDChK7OLqVKvSzJn+Dq0OZy1L1gKAOiypTfDwayXnPcjjdJ26AKWJ5DODA
 7JwfBgJFwdBh13R7n6ToRXOX84IFROaLLaiTN2IkDtLH3DcwbB/Q/n0tr0EDVAYiAUOm
 B6yK1dSuGgmLgnA904yVBKNgJs1ccQIRVlvJg4uHNao5HuTK0qVJnxOaW/gxUwU8Slnc
 wJww==
X-Gm-Message-State: AAQBX9dCGF/7BWn7GHe3zJcJqu1PQFVzG0XcJ4I+TBExJBvMy17lij7I
 Lc9S7lqhSIxJM7W3WfnFuPQRhKArsfMW4Zz2GhPc/vAZS9M81pbiCV4/s8XxUJv7Xr1SErPL+Hz
 CMy792n9qbq7429qCIJIXBACvszgKKNIa9VDMY44Log==
X-Received: by 2002:a17:906:4811:b0:946:bfb0:de85 with SMTP id
 w17-20020a170906481100b00946bfb0de85mr2432663ejq.70.1680620846714; 
 Tue, 04 Apr 2023 08:07:26 -0700 (PDT)
X-Google-Smtp-Source: AKy350aauZ1GxrFXc/flAZwxUKkCmzdXMrUap9TWgRzI7c1jjsVwXH8KBbEcOz3OpNDqgXNGANFrxg==
X-Received: by 2002:a17:906:4811:b0:946:bfb0:de85 with SMTP id
 w17-20020a170906481100b00946bfb0de85mr2432651ejq.70.1680620846464; 
 Tue, 04 Apr 2023 08:07:26 -0700 (PDT)
Received: from redhat.com ([2.52.129.179]) by smtp.gmail.com with ESMTPSA id
 tg9-20020a1709078dc900b009481d17befdsm4462119ejc.2.2023.04.04.08.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Apr 2023 08:07:25 -0700 (PDT)
Date: Tue, 4 Apr 2023 11:07:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH v2] vdpa/mlx5: Verify wq is a valid pointer in
 mlx5_vdpa_suspend
Message-ID: <20230404110652-mutt-send-email-mst@kernel.org>
References: <20230328071810.843361-1-elic@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230328071810.843361-1-elic@nvidia.com>
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

On Tue, Mar 28, 2023 at 10:18:10AM +0300, Eli Cohen wrote:
> mlx5_vdpa_suspend() flushes the workqueue as part of its logic. However,
> if the device has been deleted while a VM was running, the workqueue
> will be destroyed first and wq will become null. After the VM is destroyed,
> suspend can be called and will access a null pointer.
> 
> Fix it by verifying wq is not NULL.
> 
> Fixes: cae15c2ed8e6 ("vdpa/mlx5: Implement susupend virtqueue callback")
> Signed-off-by: Eli Cohen <elic@nvidia.com>


This conflicts with the patch for not losing link state updates.
How do you want to handle this?

> ---
> v1 -> v2:
> Fix spelling errors
> 
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 85866ace0061..b73c5943aefd 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2929,7 +2929,8 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
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
