Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D64613C67C
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 18:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721760676; cv=none; b=dDqd1Nyw6kIA7xbdHSyK3HcES6756H/wFjzcDJGgGArgMVwDX/4EwlEISN5CHcqAbbpb9B3ETd/5xDVlpQw+kS7aHKAF+El+svCSp5Lavfeu5o9d0V1oKGRVG6/d5xM+zikuNDhycJxjNUEA4+nMEpdjJf3bv7ora3dKj/EJE5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721760676; c=relaxed/simple;
	bh=8WM45x4aLgxzn24xRVJdcYNSsyPdIGy9A1ixEo4iLgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMJPmGDzAsCIbZfMq6m+dVRBa9XnkxXC85SIEZ0AD/wBXgZDwdiUC1t7RXdQnuoAe22jb+t5wJGWDU7W0OTy8PlVtHUt2e5lFmcHUqDWcsyP8nOvqaz914s8zD10G4gEdMKBh543d6EzyXGCnyK38ZpbXTldidgBIu45hJp2pFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=C3X+BKuj; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="C3X+BKuj"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D41D040549
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 18:51:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.102
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6eEhmCxCgpbL for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Jul 2024 18:51:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org DE03F40544
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DE03F40544
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=C3X+BKuj
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DE03F40544
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 18:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2LdqHMpKyhNeBqbn8cjWJNhWaXvSpX93+fz3qbvwzFc=; b=C3X+BKujtWdnJ7Md9EySwCd7ZS
	alWbsORvT8gp033nu3lRXSQr/BiL/ZUOfuU5e/BAbXM1L9lxu+X65MvL435EIFeKwyXJDh0eoaMH2
	mQy+FTpSRVW5JqjYh0LaJpwABLG5vIjRPXL4M56125EYmhtQ4xwTsv5hC/hp4grrML5E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sWKbM-0035Le-Kq; Tue, 23 Jul 2024 20:51:08 +0200
Date: Tue, 23 Jul 2024 20:51:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com,
	parav@nvidia.com, sgarzare@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATH v5 2/3] vdpa_sim_net: Add the support of set mac address
Message-ID: <aa52dd0c-a5a7-4416-ba15-6527f5490044@lunn.ch>
References: <20240723054047.1059994-1-lulu@redhat.com>
 <20240723054047.1059994-3-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723054047.1059994-3-lulu@redhat.com>

> +static int vdpasim_net_set_attr(struct vdpa_mgmt_dev *mdev,
> +				struct vdpa_device *dev,
> +				const struct vdpa_dev_set_config *config)
> +{
> +	struct vdpasim *vdpasim = container_of(dev, struct vdpasim, vdpa);
> +	struct virtio_net_config *vio_config = vdpasim->config;
> +
> +	mutex_lock(&vdpasim->mutex);
> +
> +	if (config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> +		memcpy(vio_config->mac, config->net.mac, ETH_ALEN);

ether_addr_copy()

	Andrew
