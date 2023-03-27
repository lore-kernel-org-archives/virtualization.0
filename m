Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1A9C76195
	for <virtualization@archiver.kernel.org>; Mon, 27 Mar 2023 13:36:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 13D6F61030;
	Mon, 27 Mar 2023 13:36:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 13D6F61030
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YjC1lbAR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sSC2jdaIVxNk; Mon, 27 Mar 2023 13:36:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4583D60F41;
	Mon, 27 Mar 2023 13:36:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4583D60F41
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 248A1C0035;
	Mon, 27 Mar 2023 13:36:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3DE31C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 13:36:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2689881B26
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 13:36:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2689881B26
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YjC1lbAR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5uMNmtRioJp9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 13:36:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5F9CF8193E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5F9CF8193E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 13:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679924203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QGb9Y8u4VdFIVFe92Sm3/aHansOct5x6Ey1ArWHA1zI=;
 b=YjC1lbAR83BD5G0aVJf7nbZTT/Htzs9bCxQlLOjdfty+3mQ34M+edFS0W/YEM76pFNeGpM
 1hLUezwo7H+SMqWX+K0BJjhFVAp0Bzx78gjAEjnB5Wzu0F6PFo5WTZKiTMgB+a92QIxVwC
 X9XS4ioxQNrIFYWZM8Y7A7idBk3Pc9I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-_1WyZZBSPsOP8iKE_g0FkQ-1; Mon, 27 Mar 2023 09:36:41 -0400
X-MC-Unique: _1WyZZBSPsOP8iKE_g0FkQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 i4-20020a05600c354400b003ef649aa8c7so3201101wmq.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 06:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679924200;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QGb9Y8u4VdFIVFe92Sm3/aHansOct5x6Ey1ArWHA1zI=;
 b=nnYGXsOpzn2kYQkKuHUXye5tZn54JtB9srmlAG3GsmqprdgREjS06UEMiv4CvagEfL
 FrfK8z0fHc5lv5ZTwSjOoc4rN9zPnY9+oC7N/iPCGHgWZUlzhxmdTJFbv2KLC96pH2lZ
 a2WP0pWogL80TNWGZ4+EqC19W2BFoGMYeJ6Dv+hg04ZoKLLRl0VBJYjGOn6kcfllk0my
 1aNzyiWfGvGfhDLv74p+zAY5GkAjAQ3ucvBcXNtwT3Y3Udnm6OO58ou98DYGhdlXaI26
 77/4LT5pK+uHt8/esP9T1Z8LfN/N6AdtGLFovCJ/rxUzOHRxSnemlu1k83Z/JjDi59NJ
 mmQw==
X-Gm-Message-State: AO0yUKXvXxVyQe0AhpuK5LOMf9Nf41DB5+GL8rT5/yzXmZWuvrQ24PwB
 bYMFIM49ciUaLMIRnatjEe6ai+Oe+TFzBIx8B4mur4wIZ7hOMcPdNUbBGJ4BLaOOgdo/7NU1BBW
 78xtkEPNM0RetYpMp02F30HTQBh/eJopdAVUkMQ/FHQ==
X-Received: by 2002:a05:600c:548d:b0:3ee:c06:e942 with SMTP id
 iv13-20020a05600c548d00b003ee0c06e942mr8949735wmb.25.1679924200386; 
 Mon, 27 Mar 2023 06:36:40 -0700 (PDT)
X-Google-Smtp-Source: AK7set9OiIbOHBEE3o9xr2+8DmuhB3+KVSXXkL7eLYQm19KV3NTH9RLp4eFxhFvRl3WZJkFktdeKQA==
X-Received: by 2002:a05:600c:548d:b0:3ee:c06:e942 with SMTP id
 iv13-20020a05600c548d00b003ee0c06e942mr8949720wmb.25.1679924200086; 
 Mon, 27 Mar 2023 06:36:40 -0700 (PDT)
Received: from redhat.com ([2.52.153.142]) by smtp.gmail.com with ESMTPSA id
 n6-20020a7bcbc6000000b003ed243222adsm13675149wmi.42.2023.03.27.06.36.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Mar 2023 06:36:39 -0700 (PDT)
Date: Mon, 27 Mar 2023 09:36:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH] vdpa/mlx5: Add and remove debugfs in setup/teardown driver
Message-ID: <20230327093617-mutt-send-email-mst@kernel.org>
References: <20230326131819.783581-1-elic@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230326131819.783581-1-elic@nvidia.com>
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

On Sun, Mar 26, 2023 at 04:18:19PM +0300, Eli Cohen wrote:
> The right place to add the debufs create is in

s/debufs/debugfs/

> setup_driver() and remove it in teardown_driver().
> 
> Current code adds the debugfs when creating the device but resetting a
> device will remove the debugfs subtree and subsequent set_driver will
> not be able to create the files since the debugfs pointer is NULL.
> 
> Fixes: 294221004322 ("vdpa/mlx5: Add debugfs subtree")
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 2805d58378fb..d012732e3835 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2547,6 +2547,7 @@ static int setup_driver(struct mlx5_vdpa_dev *mvdev)
>  		err = 0;
>  		goto out;
>  	}
> +	mlx5_vdpa_add_debugfs(ndev);
>  	err = setup_virtqueues(mvdev);
>  	if (err) {
>  		mlx5_vdpa_warn(mvdev, "setup_virtqueues\n");
> @@ -2593,6 +2594,8 @@ static void teardown_driver(struct mlx5_vdpa_net *ndev)
>  	if (!ndev->setup)
>  		return;
>  
> +	mlx5_vdpa_remove_debugfs(ndev->debugfs);
> +	ndev->debugfs = NULL;
>  	teardown_steering(ndev);
>  	destroy_tir(ndev);
>  	destroy_rqt(ndev);
> @@ -3313,7 +3316,6 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>  	if (err)
>  		goto err_reg;
>  
> -	mlx5_vdpa_add_debugfs(ndev);
>  	mgtdev->ndev = ndev;
>  	return 0;
>  
> -- 
> 2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
