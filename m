Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DF01DA27
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 03:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DjJpTE6T"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8A2A60E1B
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 03:47:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C8A2A60E1B
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DjJpTE6T
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.599
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jv4roZE36YCo
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Dec 2023 03:47:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B458160DFF
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 03:47:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B458160DFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703044037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QDgKeSnW9WjPiYCNV2h6BRFrU23HWRGExp1tEJfVp+A=;
	b=DjJpTE6TpcLhzlk47dtTy09vxOC2KtBWMlQhD8/7vtcmAgTVZre1ZX4Cs6JfaCK7kBIp1n
	dJWk9kYCksLIxJ/arRLbQBmoGxMCIu5OPWhtkEtfJxOvCmKyt4bSCPf/b/92hq2JTwWPXv
	OnAU5tUzF+m8X6ggvHAxC8reyN4pvtA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-OEAhN2DTMEqkMkwX86K4dQ-1; Tue, 19 Dec 2023 22:47:15 -0500
X-MC-Unique: OEAhN2DTMEqkMkwX86K4dQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-28bc9e1f43eso604029a91.0
        for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 19:47:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703044035; x=1703648835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QDgKeSnW9WjPiYCNV2h6BRFrU23HWRGExp1tEJfVp+A=;
        b=dEb6DGUcMBHZEUyK5Cwv8ld79A8MKHPeK8hE1Q8QZtuKZINc6/eu7yIBvUxH/jTvbK
         AbeY+xI5AmCyQB1yoHxwR7HK9eXVQAj+unucruxWqS7L7aNPPnBVExxEaEAzQp9NOlWK
         JqsjMwZDY3wAcec68SiKd6yzLvgLT6p7USSXxIm4lAly+tAYMaXA7OFtmmKR7Jfz/bNS
         zmeyzBIJT4vqNbetsrxBRNfKRevetMI53Ior0b74Yn0nRdbKlBGhTAgn6c1P9XKPcRUZ
         D4vAzbdLNXeNGjTgjeu2OE5B/I4t3TJtHqeuvxwDHOx1glxR9xafSTMLpqqsRUzv1RGd
         c9CQ==
X-Gm-Message-State: AOJu0YwuCR1CGdtRtjaoLjWPI/aziwz0YeA1rwH9jS4lHqK7mCB7xKEr
	3GXKu2/ZxPMXHHq8aRIpPO1I7wlRgNgqI6l/rqXu6Ll1ofpnBXjbdAeGCO4lCHv3Q4stqiGANs1
	SU1DM50GwFg7XC1IetXFnG8P5HV3c9y//SiTt/KFCqTFUlXyfZRQDgHRyhQ==
X-Received: by 2002:a17:90a:e550:b0:28b:6b69:425e with SMTP id ei16-20020a17090ae55000b0028b6b69425emr3250717pjb.34.1703044034770;
        Tue, 19 Dec 2023 19:47:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0dF4xSsJZ5QD3HCGa61B+KNXdkWHm1GNDLBaUm0KZYX0Ya7QIXi6kgXFSx5HjjaDaFnAL8BB6HVPmo69iIiE=
X-Received: by 2002:a17:90a:e550:b0:28b:6b69:425e with SMTP id
 ei16-20020a17090ae55000b0028b6b69425emr3250705pjb.34.1703044034544; Tue, 19
 Dec 2023 19:47:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231219180858.120898-1-dtatulea@nvidia.com> <20231219180858.120898-13-dtatulea@nvidia.com>
In-Reply-To: <20231219180858.120898-13-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Dec 2023 11:47:03 +0800
Message-ID: <CACGkMEusxhpgdhf5BXPp_r913xQk7Td1bw+-oEJyDFhZFsc7tg@mail.gmail.com>
Subject: Re: [PATCH vhost v4 12/15] vdpa/mlx5: Mark vq state for modification
 in hw vq
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, virtualization@lists.linux-foundation.org, 
	Gal Pressman <gal@nvidia.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 2:10=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> .set_vq_state will set the indices and mark the fields to be modified in
> the hw vq.
>
> Advertise that the device supports changing the vq state when the device
> is in DRIVER_OK state and suspended.
>
> Reviewed-by: Gal Pressman <gal@nvidia.com>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

