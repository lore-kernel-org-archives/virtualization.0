Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6885A6FA8;
	Wed, 19 Jun 2024 15:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718809684; cv=none; b=bReyeWALFHU2CsAf1kUI4ljWpJK4LHs9s+rIT+bgkVHgn0cABsHWdH2P5Lyy9a4rY0P4fYYunuk6BrZWGw+i3526gz9K2e6TMmPFwoCG+Qy3SHp/O8ihS03f8TbJJAGPRaYTkHQp2/P88w1zlhQw9gku8yg4Pzfl0l+Pp7gUBBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718809684; c=relaxed/simple;
	bh=Ew7DEzh7UDLk9j70nGGG9ah+QcztYrAjq9d1edBgKFM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JIb84dwMHi8eSrnOBEmf3+uj7FEnA7p+pmZMZWvEtVHus3wr39pwuPkZoen4RICPSZwRMeJWRy6PT3YEm0jP0uYP7imTQAHHwDObmM4ekjkATgZzEs/uB2enUoHRdkJLoxQRyhG7h+IYut50BrIy4LYhjMHwHY8EUDUBsyTSyRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNAtAiGY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNAtAiGY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52589C2BBFC;
	Wed, 19 Jun 2024 15:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718809684;
	bh=Ew7DEzh7UDLk9j70nGGG9ah+QcztYrAjq9d1edBgKFM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YNAtAiGY2FbJI2SOctetkcVe0eH6FjRfPpoONhbvUzAXnHd0Xgn8eq23O+nSrkpwf
	 pg/F1zHTjeDcKV0ub69HoLR4iNfyOVmkybkykgnNGWRku4lbIQvIbmwa4efXOVcqKp
	 zCvO9Y9GeuNmWdoRNMgROyhf88+51iZN7lPY8Mt3n0GM79ty8mwnSpmEJzngh+MG6/
	 8OaEUEEH433TnqruTZFN4FYOeITa4ee1V+hVz+sUnbHLwtavn4KcOx1kiBBW45s6WS
	 dutm+fWEDeklhec91OWE8kpvq13s6EwByKwbeTU7D+jDgA/AgWsNv50/IsTV+7/c3d
	 LWEMQq4p/Wqww==
Date: Wed, 19 Jun 2024 08:08:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, Thomas Huth <thuth@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Eric Dumazet <edumazet@google.com>, "David S.
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>
Subject: Re: [PATCH 1/2] virtio_net: checksum offloading handling fix
Message-ID: <20240619080802.07acb5ac@kernel.org>
In-Reply-To: <1718762578.3916998-2-hengqi@linux.alibaba.com>
References: <20240617131524.63662-1-hengqi@linux.alibaba.com>
	<20240617131524.63662-2-hengqi@linux.alibaba.com>
	<CACGkMEvDUcVmaT1dBoWnFx0CO5kH+HYp9je5bJ1dFR1+EEdyWA@mail.gmail.com>
	<1718680142.7236671-11-hengqi@linux.alibaba.com>
	<20240618181516.7d22421e@kernel.org>
	<1718762578.3916998-2-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Jun 2024 10:02:58 +0800 Heng Qi wrote:
> > > Currently we do not allow RXCUSM to be disabled.  
> > 
> > You don't have to disable checksuming in the device.  
> 
> Yes, it is up to the device itself to decide whether to validate checksum.
> What I mean is that we don't allow users to disable the driver's
> NETIF_F_RXCSUM flag.

I understand. What I'm suggesting is that you send a follow up patch
that allows it.
