Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216081EB44
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Jul 2024 19:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720467701; cv=none; b=dx/Gzv2iqQE00kcARvLyykR0djC5QHMbXk+74Bx1RgUSu2hVYSXtLZOM5Pv0TGtCub9hdJqbLCM0GdpNi8TJR5Pd5ShNDj7ERCf+mc9ZNKsFM0xAmdHnM4Fffjyt4YaMI/GJUfIAWLLaIwbHJLw/Luz2nbxu834GXBFuetyJu7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720467701; c=relaxed/simple;
	bh=ZYwHIigIhSCIMsMfoGRMJkJk1tF8c24wZcbHSusq7ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJCRWMRLoLJskj8fXfX6XpJEqY+dWKpMNw+9kOFqBpsaRTBDxxb0YaiOSDcySR2KweDWeNRw2yVS9+5burFiLYqqurz8wQ8zmgZ3VJHytRr035k1ny900MMAm3ncDmjdmcvPBxR1SEMCHrW+JhzzKRwdB/tQ9rtWqyM4/QssZbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IzjJXRwx; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IzjJXRwx"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA2A860634
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Jul 2024 19:41:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.102
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NK7fqAvcyg95 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Jul 2024 19:41:39 +0000 (UTC)
X-Greylist: delayed 2436 seconds by postgrey-1.37 at util1.osuosl.org; Mon, 08 Jul 2024 19:41:38 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org EC74A605BD
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EC74A605BD
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=IzjJXRwx
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=<UNKNOWN> 
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EC74A605BD
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Jul 2024 19:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XGGpiGEn99M1OyeTkZzsgnB6kBfceyDYhXGtdp6H+LU=; b=IzjJXRwxcCU8iVPQpEtfBZ9ZSL
	UZB/QcbD4oWaRg9SaqqBXc7UsGT8dZTU4Nd9/SVUYmkhw1gOiXPC+WeKskETHk906vqsclC0AlP2v
	I6+2pQvOThD6jUArmHxfmbGacwlH8SdLYQxI3cIlRgD9xtvQV5u/N4U2ZkjWrsNa+/Uc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sQtba-0024I0-IB; Mon, 08 Jul 2024 21:00:54 +0200
Date: Mon, 8 Jul 2024 21:00:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com,
	parav@nvidia.com, sgarzare@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] vdpa/mlx5: Add the support of set mac address
Message-ID: <b680300d-d18d-45b8-848f-85824332c7ca@lunn.ch>
References: <20240708065549.89422-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708065549.89422-1-lulu@redhat.com>

On Mon, Jul 08, 2024 at 02:55:49PM +0800, Cindy Lu wrote:
> Add the function to support setting the MAC address.
> For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> to set the mac address
> 
> Tested in ConnectX-6 Dx device
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 26ba7da6b410..f78701386690 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3616,10 +3616,33 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
>  	destroy_workqueue(wq);
>  	mgtdev->ndev = NULL;
>  }
> +static int mlx5_vdpa_set_attr_mac(struct vdpa_mgmt_dev *v_mdev,
> +				  struct vdpa_device *dev,
> +				  const struct vdpa_dev_set_config *add_config)
> +{
> +	struct mlx5_vdpa_dev *mvdev = to_mvdev(dev);
> +	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> +	struct mlx5_core_dev *mdev = mvdev->mdev;
> +	struct virtio_net_config *config = &ndev->config;
> +	int err;
> +	struct mlx5_core_dev *pfmdev;
> +
> +	if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> +		if (!is_zero_ether_addr(add_config->net.mac)) {

Is the core happy to call into the driver without validating the MAC
address? Will the core pass the broadcast address? That is not
zero. Or a multicast address? Should every driver repeat the same
validation, and probably get it just as wrong?

    Andrew

---
pw-bot: cr
