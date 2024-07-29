Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C6915A87C
	for <virtualization@lists.linux-foundation.org>; Mon, 29 Jul 2024 19:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722280419; cv=none; b=Eoe69MfKtX1FZ/KykpgiDaH/uezS43NzRrO0Y9qd3Uwa6MY8QgeuLNSTp02P89wvrLeKxl1fJjWXRW4cicf929xXNXWi0SeYkNFDPngW9vjnVukS7X8N1K7gMVjfZ14BWedKF5NSAc58EVobDvGMxs6VSag+OTzo+76dDjo49lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722280419; c=relaxed/simple;
	bh=D/k2gflf1CrQfdyqcQrRM64Li2eb8kGekB0k0/MRf5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=myPQk4uu09ljtyQZz9yVknWCH1zc3jQQOelkDoeWS32cvByQzuUIhvhipk1GFgRzYPoSZTKsMur2hCO5A1QmZ6XZ/xNTXGsvzH+gYHT3utR2UzkyX6FeGqmorUif6t3vNBV/dKO9qobSDvP+9g5DSGT4N3fwJTKlx34kNPdmWVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KKeHxiMG; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KKeHxiMG"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 375A06078C
	for <virtualization@lists.linux-foundation.org>; Mon, 29 Jul 2024 19:13:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.102
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F-6YO23MAOD6 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Jul 2024 19:13:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0FE08606B9
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0FE08606B9
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=KKeHxiMG
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0FE08606B9
	for <virtualization@lists.linux-foundation.org>; Mon, 29 Jul 2024 19:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8ZNHWlm+Nyx2XlIJKfuX2NFq0FaRdmbdH9dI8jmg1jQ=; b=KKeHxiMGW1WqVAx5xcire9s3PW
	pbbSam9Yr97KKG412JLv3dmyYl0G5g2Ek7hi2sa3dtdF78PUdWjto4KsZndNGMWdMAZ1sFJTrWZA7
	QGd4cVL+lVgF3+8/Lsyk+VkCbwIvrG/J0H8nZ8FyjAU1ZfnIl6gFxU+hS2c6HgunBLkk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sYVoE-003UwU-Ho; Mon, 29 Jul 2024 21:13:26 +0200
Date: Mon, 29 Jul 2024 21:13:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com,
	parav@nvidia.com, sgarzare@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] vdpa: support set mac address from vdpa tool
Message-ID: <52af9b4f-aa8f-4c6f-9ced-c6fa9b396343@lunn.ch>
References: <20240729052146.621924-1-lulu@redhat.com>
 <20240729052146.621924-2-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729052146.621924-2-lulu@redhat.com>

> +static int vdpa_dev_net_device_attr_set(struct vdpa_device *vdev,
> +					struct genl_info *info)
> +{
> +	struct vdpa_dev_set_config set_config = {};
> +	struct vdpa_mgmt_dev *mdev = vdev->mdev;
> +	struct nlattr **nl_attrs = info->attrs;
> +	const u8 *macaddr;
> +	int err = -EINVAL;
> +
> +	down_write(&vdev->cf_lock);
> +	if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
> +		set_config.mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR);
> +		macaddr = nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]);
> +
> +		if (is_valid_ether_addr(macaddr)) {
> +			ether_addr_copy(set_config.net.mac, macaddr);
> +			memcpy(set_config.net.mac, macaddr, ETH_ALEN);

ether_addr_copy() and memcpy()?

> +			if (mdev->ops->dev_set_attr) {
> +				err = mdev->ops->dev_set_attr(mdev, vdev,
> +							      &set_config);
> +			} else {
> +				NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +						       "device does not support changing the MAC address");

You would generally return EOPNOTSUPP in this case, not EINVAL.

Also, the device does not support setting attributes. Given the
generic name, i assume you plan to set other attributes in the future,
at which point this error message will be wrong.

	Andrew
