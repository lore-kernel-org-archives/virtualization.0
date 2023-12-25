Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0381652F64
	for <virtualization@lists.linux-foundation.org>; Mon, 25 Dec 2023 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ck4zOBoG"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 75BC2411C6
	for <virtualization@lists.linux-foundation.org>; Mon, 25 Dec 2023 14:40:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 75BC2411C6
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ck4zOBoG
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UF6ULybZjWxm
	for <virtualization@lists.linux-foundation.org>;
	Mon, 25 Dec 2023 14:40:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 883FE410E4
	for <virtualization@lists.linux-foundation.org>; Mon, 25 Dec 2023 14:40:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 883FE410E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703515224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r30bd66jxpHUSXO7YfqG9q0y4ndke472S3P6ZYA5Q2A=;
	b=Ck4zOBoGmyUpGfua6CSj1QbIfpfRd+3QcDcbUrGqBp6n7g8S1Buk6fm0nR8iCmSxVE0xqO
	JjTqQuIzOwbVM/3o0YxWKRG2pOpufCt+a2027iT32ogur+wpJ95WJnboi31GHWMHfUh63I
	857T2+82HLT/8vzRGekk/KqkiBaDdXc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-YwUmgHFwNJCfaNMLwoEVPQ-1; Mon, 25 Dec 2023 09:40:22 -0500
X-MC-Unique: YwUmgHFwNJCfaNMLwoEVPQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40d35a7579bso38569175e9.3
        for <virtualization@lists.linux-foundation.org>; Mon, 25 Dec 2023 06:40:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703515221; x=1704120021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r30bd66jxpHUSXO7YfqG9q0y4ndke472S3P6ZYA5Q2A=;
        b=wanAoIad7CfeALIGV42UzFI/+7y7QdMZTBiekTy7612930L6vq+WCadQFeVEPnIsTx
         AwUG1sRHUB1cQHO+NIUP1iWv/knxc/Zn+DStpeuDr7qO+/FAvJjJo7hInnKN/946uBCM
         A5S3FM7RUDfCheVM1HtaldnmtGgNcaGKdoPJbyDfrvepuA5VOp0rF1DAVnPpK1eygpp4
         2kcQb9t7HDGUVOOiNqsRJuxSfCcEQGQgAlO57rlvSGTsSpGVDjS7wao6RZNG56/HaKFE
         AMzzz2XqD6E7yI9rfNJF50RxCK0V5nPHj+VecKndqrThpNVZNnmbvmYThLMckbZQ4bes
         4YIw==
X-Gm-Message-State: AOJu0YwxDEDO8QVCvkNKFSj++S1p8IcnwEhRqWqp+TJjLoiymiGZdpSu
	rfD4DfTEKS6pXFIBR6bsgKOvinxs4sCPkIPKdgz8GLCUr1rliLNa9/xdZR2vhQzJuOOMaQmivQ7
	ikQRp+AvlOCnf/kceD1ZJMKST85kYC0cGHwtEfi1JeOcfCRH5JA==
X-Received: by 2002:a05:600c:4384:b0:40d:3b3f:6040 with SMTP id e4-20020a05600c438400b0040d3b3f6040mr3277882wmn.45.1703515221634;
        Mon, 25 Dec 2023 06:40:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERj8nKH4lZ+sR7lE0SNWs4rtYfU5jc4PHxOduDICBRxgMJSBULAIhxDrjdg1NIuF/lbbHjJQ==
X-Received: by 2002:a05:600c:4384:b0:40d:3b3f:6040 with SMTP id e4-20020a05600c438400b0040d3b3f6040mr3277872wmn.45.1703515221347;
        Mon, 25 Dec 2023 06:40:21 -0800 (PST)
Received: from redhat.com ([2a06:c701:73ef:4100:2cf6:9475:f85:181e])
        by smtp.gmail.com with ESMTPSA id jg7-20020a05600ca00700b0040c46719966sm25078752wmb.25.2023.12.25.06.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 06:40:20 -0800 (PST)
Date: Mon, 25 Dec 2023 09:40:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio Perez Martin <eperezma@redhat.com>,
	Si-Wei Liu <si-wei.liu@oracle.com>,
	virtualization@lists.linux-foundation.org,
	Gal Pressman <gal@nvidia.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Parav Pandit <parav@nvidia.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 0/2] vdpa: Block vq property change in DRIVER_OK
Message-ID: <20231225093850-mutt-send-email-mst@kernel.org>
References: <20231225134210.151540-1-dtatulea@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20231225134210.151540-1-dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 25, 2023 at 03:42:08PM +0200, Dragos Tatulea wrote:
> This series prevents the change of virtqueue address or state when a
> device is in DRIVER_OK and not suspended. The virtio spec doesn't
> allow changing virtqueue addresses and state in DRIVER_OK, but some devices
> do support this operation when the device is suspended. The series
> leaves the door open for these devices.
> 
> The series was suggested while discussing the addition of resumable
> virtuque support in the mlx5_vdpa driver [0].


I am confused. Isn't this also included in
 vdpa/mlx5: Add support for resumable vqs

do you now want this merged separately?

> [0] https://lore.kernel.org/virtualization/20231219180858.120898-1-dtatulea@nvidia.com/T/#m044ddf540d98a6b025f81bffa058ca647a3d013e
> 
> Dragos Tatulea (2):
>   vdpa: Track device suspended state
>   vdpa: Block vq property changes in DRIVER_OK
> 
>  drivers/vhost/vdpa.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> -- 
> 2.43.0

