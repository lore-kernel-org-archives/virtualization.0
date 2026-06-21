Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014042EF652;
	Sun, 21 Jun 2026 22:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782079572; cv=none; b=jZw5//idDFrmnO3Gf7U8gUEDqlMmFIDtanhFpR8bwtKzqBkEbr0bua9G3qmrcW90/ghVDd629K9+WuI2QAGIrDRKZafUORbI/UvYVEry3JXobJhI7+LADL9Ze0OGCEWp2ALqSgR6sMQOiXXCiwUJdSzBLQ9+WfkqM9rQefuICTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782079572; c=relaxed/simple;
	bh=1DJqPRY6i99+vjc+yLgP3ut8+7CArs/ZawFf5y8LCzg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dgNvpSsnq9BQ/Bx+VLz8jk2VQGX+r+kF0MVtLN3fo3UCA7Ih/1XjHAYLrLqZPImJMamHBp7JBOQQE5Ka0qQmWriIipo09GAkAWKGLRo9JOXGgN19JZExOmxWZO0JzLtiqrBWQzHtkmOacT6KS9YIfsFTVEmb+bat+PIcp5DNybk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAMdFzLx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAMdFzLx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0AE1F000E9;
	Sun, 21 Jun 2026 22:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782079571;
	bh=0jRK8ItK0sZaZhCC4/wpSQncIoEHVkfMVHG4sDnkFCU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VAMdFzLxa2VAahWb9CUDyjwa+fBm2FAZ8QAsY+uUliz62lSeQ0vk0w2xdFJyijIMo
	 OzwKCzKxHAykiIsbLZiSSKImGPLTTXK3OqJ/5E3LKrDwJn7kXkZM/AoIXqZUd30bH3
	 NGMLYDdnkFtjRdgGU3MQ8sQ2WntHCYvjS1YaMhek6H4dPUfVMA9PILhM1e/88vI4B9
	 725vpvu3GfLv1ziSyxrXIv/x3Rg27QBwWqI8rzQ+Ms9DHioW1ypdt3bEjekNpulZeR
	 OHiUJWaibObyH0gIH+XOLFsgrU9wZeE5KxFanCHT7bGOv1xw91JuAOQ9SoNqMATg1k
	 OBARyPDTFlhMA==
Date: Sun, 21 Jun 2026 15:06:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: xuanzhuo@linux.alibaba.com
Cc: Menglong Dong <menglong8.dong@gmail.com>, eperezma@redhat.com,
 mst@redhat.com, jasowang@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] virtio-net: xsk: support tx wake up
Message-ID: <20260621150610.0ad5d02e@kernel.org>
In-Reply-To: <20260616115912.513183-1-dongml2@chinatelecom.cn>
References: <20260616115912.513183-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jun 2026 19:59:12 +0800 Menglong Dong wrote:
> For now, XDP_RING_NEED_WAKEUP is not supported properly by the virtio-net
> in the tx path for example: we set xsk_set_tx_need_wakeup() in
> virtnet_xsk_xmit(), but we didn't call xsk_clear_tx_need_wakeup()
> anywhere, which means the user will call send() for every packet.
> 
> We call xsk_set_tx_need_wakeup() after virtnet_xsk_xmit_batch() if sq->vq
> is empty, as we can't be wakeup by the skb_xmit_done() in this case.
> Otherwise, we will clear the wakeup flag.
> 
> Race condition is considered for tx path.

Seems to follow what mlx5 does so presumably this is fine but IDK if
there's anything virtio-specific that we need to be worried about.

Xuan Zhuo, please TAL?
-- 
mping: VIRTIO NET DRIVER
