Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794398285;
	b=t/cZbQRkVPBrBDlAfx6FxSOqIZlZF579EOln8t1Qn5hl0wcUHAVESit3ZwOIzTzaqFUy
	 ov6zR1ZY10lihNPuAJPAJaZIpuNDL1iH/gydwag5EU1karo4UWjyZpozoFRyEwiDZgQWy
	 MORlMxvPLmcAwyR52N5oOeQwXyKzGUDXq9UcU8dW/CBvua177Lz8ujAShAAKaw+g9x8nM
	 nj4a5jWr1qoUbdeUkUoTKZY7i4vWV2ap0/r49JvOHYyWongqxQ/2WUTfPlg+eWRVlwqeP
	 MQllA0xY/01KGiJ1CIiE3IzUtMoNOjTvCAsfDDFzZh9DkIHSM07QePJ2Me8bTSdpdCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398285;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=QAtpX+mYswT5tfILpPnNE2GO/1nDfiulyO5xnYGFX+Y=;
	b=nVxh9rfwnv9qOZ9RYN84DGvMFVPZIb+RAy/nQp0d8ePesVEQfBNK3HqUjYCV+klD+ZOU
	 kece3TtqyDNH2c/zAXdh5NazjUEMMEEw9NoOWYvLDsFHtjS+2fvRB5d5vvpD/55HcmPwN
	 r8FBM5BqnX9h1f4qYnDEeVyzslZCYIoAPpbVrnnwycUhkZ/XnDVgVk/evSTuk8UiaafOR
	 wf62umuaG1uAs692dfd+tSO87g+4nax9gdZkNypM1Ih7Icu5VG/E+bDQfMVIULv4B+Oz+
	 26N50jBFtNe4KhiXBIzBUPdV2J87VfWHtDdANzq7LoBKuosQ5+4RdJ+tl56KnJdAWEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CZZZt+iD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A6D606A324;
	Wed, 11 Nov 2026 11:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CZZZt+iD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578831F00A05;
	Wed, 11 Nov 2026 11:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794398284;
	bh=QAtpX+mYswT5tfILpPnNE2GO/1nDfiulyO5xnYGFX+Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=CZZZt+iDaXV26+WhMHROR42F2LIOSWiP08Yj50yMgautwfxUqBPhYZhBoclbGVxne
	 yRzQeLwPX0eG0h+9Yna4HkzNVKJI4bEc3LL0ssL70JgtaP3pnKmWupe1yyF7BiILaO
	 6x3cRKxoQtLNkIWsX5g2uKno0nXbMORIfO3ZV1EcYwKZ6tJCp5whTbJPbW153lxl04
	 aLJ7llyakMlfSNeLi5UV5ou50l1lLYLmyF6F2nO3+Lu8+qXe9uIfag4b3Q06VBzgU+
	 Tq1T58X5vncislAwYcO8PSP/IYsi+H6iHzgk+o72oCsf5RWzWpkcW0pj/TI2OawL33
	 CCCmL82f2301Q==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: raoxu <raoxu@uniontech.com>, mst@redhat.com
Cc: jasowangio@gmail.com, eperezma@redhat.com, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, raoxu@uniontech.com
Subject: Re: [PATCH] vhost/net: Fix receive queue test in busy poll
In-Reply-To: <005FA5F7354482C7+20261110051642.249640-1-raoxu@uniontech.com>
References: <005FA5F7354482C7+20261110051642.249640-1-raoxu@uniontech.com>
Date: Wed, 11 Nov 2026 03:58:00 -0800
Message-ID: <87tslna8c7.fsf@all.your.base.are.belong.to.us>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

raoxu <raoxu@uniontech.com> writes:

> From: Xu Rao <raoxu@uniontech.com>
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

This fix is valid, but you need to carry a Fixes: tag. You should also
state what netdev tree you're targeting. Please see
Documentation/process/maintainer-netdev.rst

Could the changelog also state how the bug was found and confirmed, and
how the fix was tested?

Bj=C3=B6rn
