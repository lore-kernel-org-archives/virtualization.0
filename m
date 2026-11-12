Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794479723;
	b=GLsICmCb4klxOURuHAW4HxtX4WMm6y5bA0YsshLnU2KA6/D7hDcXiDhVIfGZz8v3Yv79
	 Iboe7drTmkKIduy1FWOLQ+CsUBhJBd5AUJ58Ltwzn3jAdj0HBdzzj8RvEjQ/9twKC4L3a
	 bK9CbyB84cK53IqWkxiTmy7GrB0OH0XpATUDyNbDtLwcR64yd4AlQgW3ImoCyyjxK6i21
	 4EkXrSyFXVktZyHMZ+SA28wGkl8CrOeWpGT4mDxYTz7t4nrBGcByEL9sniQF/zrZmIAzV
	 EfT9OZ6e3rL0ZUw9We3AE0+deYVmBfzt19m8BUga2Tl4KXGVWgMnEIP4J1aE2LYEegg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794479723;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=72sPZJMfQhmbB1ZVGdOBB0ZnPu9Ix7ckpmn4Q/SFcLw=;
	b=adq6HcM2DSSJNpCZ6i2y7AkD63UzX02CdznlqjkNfjDONo6inLYXAWtEjL29kfqihUof
	 bjOLTBbyN7qq5Hy7APh6EDxQQBE/q0z+gGGyU4EYKqnzYPAGYFs+ISQZGl/2zmlIn8e4Q
	 qmprxekiHrFoJ0c6cjXLYyu54yhf8NDtqRu4QVzRqrqRg/mD9ai+9vQH1o8ooz/vkHKPE
	 HwxP0dv7CX1DlgsDdNtxnoorhBAFo8yhCV1bb7Kr5GQiwjvv9YmbpusO0W8/Rc4WqXNIh
	 z7gcDiTOwq1TY3Lp+bn+mIke/9IXFJXdlqHF+ZS9R2MeGmnSqbUIk1jateAQXQUM6ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	dkim=pass header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=KMoVWYKV;
	arc=none smtp.remote-ip=185.226.149.38
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1092606A31C;
	Thu, 12 Nov 2026 10:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1092606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=KMoVWYKV
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xRS97-004t4u-6j; Thu, 12 Nov 2026 11:35:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=72sPZJMfQhmbB1ZVGdOBB0ZnPu9Ix7ckpmn4Q/SFcLw=; b=KMoVWYKVM9ilqL/7/iePaxMMJT
	LJH6p8ZLBGMuep6DAZfoys0ulDMYxtbO36uhOv4dbLDelpjGo/B6a4pIdM9H9C5a1F7S5xQt9rQZ/
	lP1tsoZfsiqwFevIYwrBVVGDVTH7Hwrn0rT/kTT4wlztFmzbJhsik9m61b261BTGtSHgWM11faKkh
	jI3BSwSDhPIlu902BhqFRrxXz3ZAaal6mhEGarI59C+6DWiU0NnXvTDTDNY9IogpnFWEA9iXjHQks
	WDy09gta1O+IN+NdAVunXUsTvWE95SnuhIK54bF3/nvb1H9oeUZVsBrgyAGuW6cW6r4ucn6plgLZh
	UthB9QPg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xRS8v-0002tw-C3; Thu, 12 Nov 2026 11:34:57 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xRS8p-004y3a-GT;
	Thu, 12 Nov 2026 11:34:51 +0100
Message-ID: <c34123f3-e006-4c25-b8d7-cdf0784926f4@rbox.co>
Date: Thu, 12 Nov 2026 11:34:49 +0100
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net-next v5 4/7] vsock: add a netlink command to assign
 the g2h device to a netns
To: Bobby Eshleman <bobbyeshleman@meta.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Donald Hunter
 <donald.hunter@gmail.com>, Eric Dumazet <edumazet@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, sargun@sargun.me,
 jlinbox@meta.com, Bobby Eshleman <bobbyeshleman@gmail.com>
References: <20261103-vsock-guest-ns-v5-0-48179b9b66b8@meta.com>
 <20261103-vsock-guest-ns-v5-4-48179b9b66b8@meta.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <20261103-vsock-guest-ns-v5-4-48179b9b66b8@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/26 02:53, Bobby Eshleman wrote:

> +/* Avoid breaking the socket when another thread has changed its sock->state
> + * while we were asleep.
> + */
> +static void vsock_connect_close(struct socket *sock)
> +{
> +	sock->sk->sk_state = TCP_CLOSE;
> +	if (sock->state == SS_CONNECTING)
> +		sock->state = SS_UNCONNECTED;
> +}
> +

It'd be nice to have it as a separate commit. If I'm not mistaken, this
itself solved the vsock_connect() vs. transport reset
(vhost_vsock_reset_orphans(), virtio_vsock_reset_sock(),
vmci_transport_handle_detach()) races. And those were already reported a
couple of times, including a recent NIPA/Sashiko Severity-Medium[1].

[1]:
https://lore.kernel.org/netdev/179447093204.2199510.8895677421994612994@kernel.org/

thanks,
Michal

