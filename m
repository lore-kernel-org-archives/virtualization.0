Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD2C25622
	for <virtualization@lists.linux-foundation.org>; Mon, 29 Jul 2024 19:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722280538; cv=none; b=Ixf0BfO3/Tm7eDbaQ/tXeMzNX6sprEQ3IWACc9vnnnaM+Aml8EVbCA2ZSb1rIyM6o76wdqK/2mwUoEy/HMZZWWHL0iyUq2Wb9XhtmVEeoGM3l+Z7R2l0oytWHs5uHYBIiIfr8AtZMlMPGaipE7qqzvCYVO94mfi7T9CqFKxjYno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722280538; c=relaxed/simple;
	bh=qq2DO28hcKeyDuon/L08bnLzinZyM8SrFE8xrk6i86I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAJxJG3k+sEns5GR1+BFGwtG1Y1lXnp5qZPtZKDzyfczCmq1HJT70Mgj+5h6PG+UaFCPZYbZbyB4hh7JjhgC/CHwmqCsbETjPFhjjkwKM6xaDPdDPU2L8VNW/ulwKuOd0itDb7t6mvY/5oGk0kMbfORCXzZ1kq6hJ/LRwwfAOos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jd4HSP14; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jd4HSP14"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 371966078C
	for <virtualization@lists.linux-foundation.org>; Mon, 29 Jul 2024 19:15:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.102
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rw5E1jJR8Kll for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Jul 2024 19:15:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6E880606D0
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6E880606D0
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=jd4HSP14
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6E880606D0
	for <virtualization@lists.linux-foundation.org>; Mon, 29 Jul 2024 19:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JUswwxAcJrKXhGjojB6xZnwDm90M314QmoVFTw2vIsw=; b=jd4HSP14ku2WtGso/OwOCG74Nb
	kS29pr8fW3NUgjEx5qyzQathZ+HLZB3C6jfDDFSFmVAEe/Vw/vm4lG3R6MdOZG+8lvAryd0+f3qVh
	So7S3IeHAJi1Usd5ZOn4rLQOA4UC4LQEIMJBqmoZ76usMZ3tq0B+PP+Oa85Yy6V+0ZBE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sYVqG-003UxQ-DI; Mon, 29 Jul 2024 21:15:32 +0200
Date: Mon, 29 Jul 2024 21:15:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com,
	parav@nvidia.com, sgarzare@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/3] vdpa_sim_net: Add the support of set mac address
Message-ID: <a5898ab7-a2ad-412a-85e6-9c7ad590704c@lunn.ch>
References: <20240729052146.621924-1-lulu@redhat.com>
 <20240729052146.621924-3-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729052146.621924-3-lulu@redhat.com>

> +static int vdpasim_net_set_attr(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev,
> +				const struct vdpa_dev_set_config *config)
> +{
> +	struct vdpasim *vdpasim = container_of(dev, struct vdpasim, vdpa);
> +	struct virtio_net_config *vio_config = vdpasim->config;
> +
> +	mutex_lock(&vdpasim->mutex);
> +
> +	if (config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> +		ether_addr_copy(vio_config->mac, config->net.mac);
> +		mutex_unlock(&vdpasim->mutex);
> +		return 0;
> +	}
> +
> +	mutex_unlock(&vdpasim->mutex);
> +	return -EINVAL;

EOPNOTSUPP would be more appropriate.

	Andrew
