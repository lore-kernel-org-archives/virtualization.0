Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794374374;
	b=zjfcyzJvb0wJQ9oaUHYdzIdP6egc+x7/lga3lHAuvXqxYtPdgpwWpwEMtN+Af2XFCmDy
	 tEBf2ovmt6PcDa1xE5LKx9P+egO5IBV62Wa4Q5yp5JXhsdCAuesxOjjbUPvTYOIndzxHl
	 i0/UJ4Q93Xcs87x+EEFbC0OG12wXZ0PYOW/GlBK7XOGeEf3zvMBFtcUL0n6KUrn05m0tm
	 ZkLjwQLY8Et4BvuVIKiInI//64++uohcckt1M3vjsq2Z/qMFYB7bVw4JhkJlVOybeWiOZ
	 IeP4rqxVXJGD8LFvDRbf2XnaA0csJFLZJM+OVn9U/EUwKehAIQJuBt/1874E0HVGB+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374374;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=m0jYuTCTkl1vhQ4/KfCh1IR+Y4VH2EAT7vxwJAz9d0w=;
	b=tAj9JjOtSzUhfcJBrskNaxBn8o7b3P9RhKzcZ/hnTGywL7quTy02Mf959Rq0tddiKkWQ
	 S/EtLSqe+NSTXDCyqtytatroVv9by+g5RdwfE0R5JxO5iHCGCRD7rhb0oY3Ue9XOXJN3N
	 qYtvD3kzloaiKwIfqzqtHtA17wRpUvB8vktLfe/rOUiqob8AdHIlXVEPnBxWCxvmuPc6U
	 bRCaFIA79oFBk6TBR2L1U7WdD9y6bZiMfKwavbWSyNk4Sfs+GCF7EoxdCHZAWBrvxttyj
	 t3AbMpVTC4JQOOYsDRCmEWj+/td2mQ0mnYJnHv05ypXGlFbZkZsMVe/mHJHxeERiuow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="W2C3z/9n";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109EF606A31C;
	Wed, 11 Nov 2026 05:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W2C3z/9n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5F81F0089F;
	Wed, 11 Nov 2026 05:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794374373;
	bh=m0jYuTCTkl1vhQ4/KfCh1IR+Y4VH2EAT7vxwJAz9d0w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W2C3z/9nLoHYU00/HaNJZFn3Hv1ZgeF+9QsvNmHYCm6Zd0VI4YiZ6MVVUyVjm+3SJ
	 a98pBpUzmdzeN1X8GdRCKw9gtsak3/FiFgrN51aHJ1BpLP3tnoMGlguG5By0IU6qUv
	 qw+t6HO8EDoAzT20jpZEUwj3ZxjiZ9wcN4V0RVNINS3ZqMgn0IHNURLYYqP+py5Pji
	 8TFQMK0x5BLCe7Y8Z4CT8faHfggfm7SHEZstsQFIx3FGhFWehWOmW3keRRHHUMQQ4W
	 FheqwDvQrdSElBD8cc8ubrXIep8zR7Y4yeER72IHAmTzRsvRBRQuxhWuC67nRAc3E4
	 9lQd7ZrNZPWow==
Message-ID: <sashiko-outbox-208329@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vhost/net: Fix receive queue test in busy poll
Reply-To: sashiko-reviews@lists.linux.dev
To: raoxu <raoxu@uniontech.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <005FA5F7354482C7+20261110051642.249640-1-raoxu@uniontech.com>
References: <005FA5F7354482C7+20261110051642.249640-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 05:19:32 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] vhost/net: missing Fixes trailer for sock_has_rx_data() bug fix
--

commit e704f9e65e5ab760d5f0c63a3cc9fef9370b05b7
Author: Xu Rao <raoxu@uniontech.com>

> vhost/net: Fix receive queue test in busy poll
>
> sock_has_rx_data() returns a positive result when receive data is
> available. Socket implementations with a peek_len() callback follow
> that convention, but the fallback for sockets without one returns
> skb_queue_empty(), which has the opposite meaning.
>
> This makes busy polling stop when a raw packet socket has no queued data
> and fail to recognize queued data through the fallback path. Return the
> negated queue-empty result so the fallback matches the callback and its
> callers.
>
> Signed-off-by: Xu Rao <raoxu@uniontech.com>

[Severity: Low]
The inverted skb_queue_empty() return value was introduced by
1576d9860599 ("tun: switch to use skb array for tx") and later moved to
sock_has_rx_data() by dc151282bbda ("net: vhost: factor out busy polling
logic to vhost_net_busy_poll()").  Should this include a Fixes tag, such
as:

  Fixes: 1576d9860599 ("tun: switch to use skb array for tx")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/005FA5F7354482C7+20=
261110051642.249640-1-raoxu@uniontech.com?part=3D1
