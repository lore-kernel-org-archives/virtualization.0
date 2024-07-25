Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86EB19E7D0
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jul 2024 17:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721928728; cv=none; b=YsYFFZf/zdX0FKQAqncwgLxpO5uvruzOWDPq/XIqd1YqABUhnEhVZGaFqNm80zxWwGzRAmgtU8t3a05YhdKiZoKaUdshij7GyPLYkoxB+9trRUEdomwE82hmA2OAK2aeSVGM3sS4i9hDFsEjxmg08iIKV2HrJ+O9PqpXwmS91N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721928728; c=relaxed/simple;
	bh=2B8f8WrE/l9cZDKXtQV+EoRITpd2Vb6bfklW5ohZbOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iv2g9bWHWOdKOoUlKv7mhtITj35IkypXC6yHcmHImUmKRJYh+4EJGAwUVsO4z5stpAkVzb3wJ1Tjx2a7YNrZUYWYjwa+k1pRUvHClKPHgZU8p2pU3cwdyYedqLEnaoKayc1NwYF0OUcVrx17jS/kMfi1GokxZGVLxnbwxUIBry8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=gfa7+e8R; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="gfa7+e8R"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 86A43405D2
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jul 2024 17:32:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kqJXzjeTNvfm for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Jul 2024 17:32:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=jdamato@fastly.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 98DD8404D4
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 98DD8404D4
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=fastly.com header.i=@fastly.com header.a=rsa-sha256 header.s=google header.b=gfa7+e8R
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 98DD8404D4
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jul 2024 17:32:05 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1fd78c165eeso10806825ad.2
        for <virtualization@lists.linux-foundation.org>; Thu, 25 Jul 2024 10:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1721928725; x=1722533525; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mTcg3xMugKDibMEmmZN7kJxyVON51JXLS1Pzxqr/s+s=;
        b=gfa7+e8RpX7A8SyQXAVAhA7zbzO34P+3laET6e+HdEDfR+a/WQVNFzWsdkboszb08J
         Ou+0CkUL358rBt+sj3/di7b9hUaGf/SvwcNophunFF5zaSKO4wxOfKesVfm3J7e4HL7i
         TB3xf/s96UR9Y5uPrwd0PVL+euyrIhHsPb6mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721928725; x=1722533525;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mTcg3xMugKDibMEmmZN7kJxyVON51JXLS1Pzxqr/s+s=;
        b=p8hpO5WIL2USDmG0N+R2CclbM5OqCrx6JjBQgZboo3yo93KitEkaKAtznQtquvGA6Y
         x5pH4MehGatBdmfwko425LIEsyvLV57Os+USt7c6ua928g1+mBScRolc10Vfd8MatGLH
         3jYm6XAE19cV/fCzb16H6qCBMoP5ZPMnIxCnpTObsrCeFly+bFl7hqdsBwwhDKbP+jJk
         I7UmqXf0esoj8PoquiPRugux2BRmUblJtN/TraOsaKi/lqtjui8qqIYRS7965O3/a4hV
         /XH8D4amKZSAZd8KPrCQcj0kY4XMezvVyUx/qU5cMsSlf/EtxbYkxX7Hr4Oy+sHgKAbg
         sbGA==
X-Forwarded-Encrypted: i=1; AJvYcCXBg3lipNBm4JEAPGREd9aFvs4sSXX9QBPte5bOIvHT2Wz9x4kk5dv+DquB4Zz8NxgR/iDlsl3XgoolMbNV6pZQUIK4oLxzTPxvb9BeDX7WIxdby2Nmeo1Ojg==
X-Gm-Message-State: AOJu0YwFhliewvCOOx6D9kwCJM0LmVyHZm8ob2uUbBIhKkZa1cQil/p3
	6ZrxSfauLeQ0MRv/RsGa+/24r76gTkMizUkrQmybWSZQY/tQth9HCiAJqUfCiR8=
X-Google-Smtp-Source: AGHT+IEHWuSit46jzp2J7leIsiryxj2NVW4bJWKskg5DpGgQVktJIJ9Ea8ATaouY1IkMnAbA/2Yiag==
X-Received: by 2002:a17:902:ea0a:b0:1fc:58fc:caf7 with SMTP id d9443c01a7336-1fed91d6d82mr31849155ad.14.1721928725156;
        Thu, 25 Jul 2024 10:32:05 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fa988dsm16802115ad.263.2024.07.25.10.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 10:32:04 -0700 (PDT)
Date: Thu, 25 Jul 2024 10:32:02 -0700
From: Joe Damato <jdamato@fastly.com>
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com,
	parav@nvidia.com, sgarzare@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATH v6 3/3] vdpa/mlx5: Add the support of set mac address
Message-ID: <ZqKMEoDIZx8XFhlq@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Cindy Lu <lulu@redhat.com>, dtatulea@nvidia.com, mst@redhat.com,
	jasowang@redhat.com, parav@nvidia.com, sgarzare@redhat.com,
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
References: <20240725013217.1124704-1-lulu@redhat.com>
 <20240725013217.1124704-4-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725013217.1124704-4-lulu@redhat.com>

On Thu, Jul 25, 2024 at 09:31:04AM +0800, Cindy Lu wrote:
> Add the function to support setting the MAC address.
> For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> to set the mac address
> 
> Tested in ConnectX-6 Dx device
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index ecfc16151d61..d7e5e30e9ef4 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3785,10 +3785,38 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
>  	destroy_workqueue(wq);
>  	mgtdev->ndev = NULL;
>  }

Nit: Other code in this file separates functions with newlines,
perhaps one is needed here?

> +static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev,
> +			      struct vdpa_device *dev,
> +			      const struct vdpa_dev_set_config *add_config)

Nit: it appears that the alignment is off on these parameters. Did
checkpatch.pl --strict pass on this?

> +{
> +	struct virtio_net_config *config;
> +	struct mlx5_core_dev *pfmdev;
> +	struct mlx5_vdpa_dev *mvdev;
> +	struct mlx5_vdpa_net *ndev;

[...]
