Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC17831815D
	for <virtualization@lists.linux.dev>; Sun, 25 Jan 2026 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769351122; cv=pass; b=bjrMix3m96uv0Lv4UW0IOSfnOUKF0qh1kn94QbWrCov2HYczsMtFSKxQBAsfHuD4P3ywdMEZF2336HVH0JLUCg14EG8mGPtEZemNJenMwMq7T/SHWIcAnaPKCx/QASX5D+vXs2Cr4u82MsW96zPWevpS1oyidJMWBwXwWvXWw/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769351122; c=relaxed/simple;
	bh=hJSx9oaMJHd1dMzail/Y0B2lv7BReDNTK69nls5nKFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoJJs7VW/SOpYvdoMQaNQr4yOFksWuoiEJ1+l7B5cE4N6sL5cqIuk3yqLUNRxYCdIHm7OtrODaTOabna54ncXc+YYJoruFGsWoKZ+uEr1hGeE+XpkXURukC5uYm+XAdD+JAATLZn4ESQuRNN4Nydie41mfVF5a2dFu4QR4sZbCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=T6b+K6TB; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=ugF+Pjp8; arc=pass smtp.client-ip=185.56.87.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="T6b+K6TB";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="ugF+Pjp8"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-h1zn.prod.antispam.mailspamprotection.com; s=arckey; t=1769351120;
	 b=KAU0qtlD9nJRVAKmd+ybOiLmnDiQ1pR1jmxIZMWmQdjW/y1Ywzl06qz7Xs8KmgB8iYk3r3uZwN
	  aqtVe1/l2YMJBriCoIv60rnnwZSjdVLtoZ0ZAyB1b/u6vC6yblTQksvfb/AK6FRvuZKpGnm/g3
	  eUrjuxOCTTlgQwdkakIUVyyswXnxXvLc1YhHNPcA7zzhHPNlD5f+6ZljG6I6MguuFHOFzCXpE7
	  HVJKA7O4ucrNGqCUFksZXcXCyE0iW+XAwRGVe5+DHfhcjT86PfEZd2k9GIl6f1n9tA4m6IOEVz
	  wpALMsyafgRZuSCrBgi6gw67e84ypNA0oi1eyGjAYKEw1Q==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-h1zn.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-h1zn.prod.antispam.mailspamprotection.com; s=arckey; t=1769351120;
	bh=hJSx9oaMJHd1dMzail/Y0B2lv7BReDNTK69nls5nKFU=;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
	  From:Date:DKIM-Signature:DKIM-Signature;
	b=Qg0YWOfn1ASv4quzgrnLaBin5Y3/mUa4B1RDJeBPVvJwz4KibnRyhYrK7duJjcUqdY+UrwM0Ie
	  IfIgUMRvv57lKjoHXKtieZROcdUFCq//7tRcBqD9OW+iZzhO4ogbdEt4eeCavWhXis4x/WpQIc
	  X2pxT7m4ugVsUCNqhQn1af6tBkxSH43cNjuwmf4vxfZZLYyIxoEfLI8JOg4t5ufAmfHqdKB/Ym
	  SSGwMX3brK/Qreo2b5LJdrVsuICnHb7OxSwUyxkZE3SH/ZQXc6S+XVLX0zHrwdTP5E8ZtbFnMC
	  tm12kQeILx28XPWRDUq4dXyaxOTMpQFOoA/YeWAuH3kriw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	List-Unsubscribe:Content-Transfer-Encoding;
	bh=r+TZJIa35LWBpRleXzoyjL90NYJPxXwwqgV0e3QqGBc=; b=T6b+K6TB+dVO1WueZoBTHZXMQf
	VMgIBaMmnSiCPLDEB4sg8yDfNeM8DK/A2P9Jz7nbzqz0+Ifwz1M/IVgXNNXSZkuHnTyPv06dyR0il
	TxFoSYtNsyohV1bAlvfK6jKy9yWe6j9R8+59485RZzayEfsIZg4PIxmcwrWcw0TvHsps=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-h1zn.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vk0pE-00000000mUH-1LK5
	for virtualization@lists.linux.dev;
	Sun, 25 Jan 2026 14:10:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=r+TZJIa35LWBpRleXzoyjL90NYJPxXwwqgV0e3QqGBc=; b=ugF+Pjp8zj0GIK0KOC3TzydUoW
	xGfbWKr4eiMlzS7Uu8JOvOtdjzSWE6qQ0/ShuMJR6CiqViqRMYfYxnwXK+2XxujOunl20vOkikqpx
	uO0wLEBGQ6Lqsv53eCCSYy27L4aJOiOsYbjtiGRNvettjRgOcbKkVizHaPVa9ne4/MWI=;
Received: from [79.52.39.254] (port=64962 helo=bywater)
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <francesco@valla.it>)
	id 1vk0p0-0000000023h-0aP4;
	Sun, 25 Jan 2026 14:10:34 +0000
Date: Sun, 25 Jan 2026 15:10:32 +0100
From: Francesco Valla <francesco@valla.it>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Harald Mommer <harald.mommer@oss.qualcomm.com>,
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-can@vger.kernel.org,
	virtualization@lists.linux.dev,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v8] can: virtio: Add virtio CAN driver
Message-ID: <aXYkWO0ShTsrjP1R@bywater>
References: <aW/D8kiFu666wiuD@fedora>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW/D8kiFu666wiuD@fedora>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 2de2a840d91ee114931aa2dddd12c3cd
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vk0pE-00000000mUH-1LK5-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-h1zn.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Hi Matias,

If an additional version is foreseen, consider dropping some more
note-like comments, as in future they might become dangling.

E.g.:

On Tue, Jan 20, 2026 at 07:05:38PM +0100, Matias Ezequiel Vara Larsen wrote:

[...]

> +
> +/* Poll TX used queue for sent CAN messages
> + * See https://wiki.linuxfoundation.org/networking/napi function
> + * int (*poll)(struct napi_struct *napi, int budget);
> + */
> +static int virtio_can_tx_poll(struct napi_struct *napi, int quota)
> +{

[...]

> +/* See m_can_poll() / m_can_handle_state_errors() m_can_handle_state_change() */
> +static int virtio_can_handle_busoff(struct net_device *dev)
> +{

[...]

> +/* Poll RX used queue for received CAN messages
> + * See https://wiki.linuxfoundation.org/networking/napi function
> + * int (*poll)(struct napi_struct *napi, int budget);
> + * Important: "The networking subsystem promises that poll() will not be
> + * invoked simultaneously (for the same napi_struct) on multiple processors"
> + */
> +static int virtio_can_rx_poll(struct napi_struct *napi, int quota)
> +{
> +

[...]

> +/* Compare with m_can.c/m_can_suspend(), virtio_net.c/virtnet_freeze() and
> + * virtio_card.c/virtsnd_freeze()
> + */
> +static int __maybe_unused virtio_can_freeze(struct virtio_device *vdev)
> +{

[...]
> +
> +/* Compare with m_can.c/m_can_resume(), virtio_net.c/virtnet_restore() and
> + * virtio_card.c/virtsnd_restore()
> + */
> +static int __maybe_unused virtio_can_restore(struct virtio_device *vdev)
> +{


With this (maybe negligible) note considered: 

Reviewed-by: Francesco Valla <francesco@valla.it>
Tested-by: Francesco Valla <francesco@valla.it>


Thank you!

Regards,
Francesco

