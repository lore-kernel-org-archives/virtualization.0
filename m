Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794209730;
	b=ubeEEuTqlFYeX52+opYPyN4gI7ouWAviQcREUrl+m8VWYDJa5+RgCTJx5KQ52aMRZ7kq
	 V43eGWCV4+1e1Wp3KnjYmPF65TKQiJ1iAWei74ZV50oRkCj4JdBnHRC1D6XEV8RS0wquA
	 ajELe0vswlglu3bggzfqrtQoWsiAJvaKS1w2OREqBVJbTGk7K1phJJLLE1sLFYbJuEc8F
	 SmNTMPPPj2vGFSc2dEqNOBdSgdDLTtbuXDB6FeLqHcYoAKX/3q7q7T/NeovRHxbtCy2LI
	 3FDNJm3pKWFf/rdfmAjqJvbx4zU2naCsSXD7l9sUY7rRbXHBBIEFguqcyZFtJJZf+oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794209730;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TxfInZcqGnOH9YjzPTF16oN8P0HZ2ZpiyPEX4Zg4Qmk=;
	b=w2GEs54f6T38q9l/POf04Xm7KL9KB77lFDhOw5Zmjgj3ij1Q8F+sF340SEhLS1HFCCjm
	 +rCNSGzstcG5KCFME+iV/lrnOsZmxfKz5ejk+FgXQdfV40bDQ7d3FgYKISquihu49cxhl
	 qSypQ+WwztDKdvtuGJYIIWw94sUX41UydG9+LbzhjWy1eXoyts5oVCNb9qktGAiWKvNLw
	 sOyW8bc7z9xtIdcZaA2TY7S7lw2A0yDpLK5ypfg1tgozBAPpE/jcFDPceVOLV+dzU4b8a
	 4mLZ7rkLKKmNN1cx6MthNH1Bq+KJqU96Tppa3kvfiZ70wpfObiZB5OHjoZFIb7/egXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SU34FaKE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04106606DF12
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 07:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SU34FaKE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620A01F0089F;
	Mon,  9 Nov 2026 07:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794209729;
	bh=TxfInZcqGnOH9YjzPTF16oN8P0HZ2ZpiyPEX4Zg4Qmk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SU34FaKEj6KM8aBUf8m5taXYvrOBFXWTJtj1wIMvYFA65UQJriYyOfI3UT1PKPnq0
	 TgE+VRj0NBAg97XWVjGHa4NTClUIuJuTy8DUNBBR8EpdRijEtmOt4yePPSwC2VZUbX
	 wZN4ZTp9U9fcED2O5yv3RS/gXc5sVO+lg7khkGv3fc+p0CEmhrwaKfyNHkecNBkrfl
	 CgsALLiItLrt9oswAxHmVaJGgSgxla21GItFGSjedIEkjOL+0vScJOUCQPhavV1Meu
	 zlKdiHDTj9F+mc0RekGeEXe9a+4RvATs2jL9ESbfL4tZqz002FB1VGDwU5/KTZltSZ
	 E5YU102FalZlw==
Message-ID: <sashiko-outbox-204547@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] virtio_balloon: drain update works on probe error
 paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mingbing Zhai" <zhaimingbing@cmss.chinamobile.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261109072651.1410-1-zhaimingbing@cmss.chinamobile.com>
References: <8f914911-8453-4f8f-b02f-384114f9d4ef@kernel.org>
 <20261109072651.1410-1-zhaimingbing@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 07:35:28 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> init_vqs() arms the stats virtqueue callback, so an update work can
> already be queued on the system freezable workqueue while
> virtballoon_probe() is still running.  If a later probe step fails, the
> error unwind deletes the virtqueues and frees vb without stopping the
> works, and the queued work runs after the balloon struct is gone:
>=20
>   BUG: KFENCE: use-after-free read in virtqueue_get_buf_ctx
>    update_balloon_stats_func+0x121/0x300
>    Workqueue: events_freezable update_balloon_stats_func
>=20
> remove() already handles this via virtballoon_quiesce().  Factor the
> stopping of the update works out of it and run it on the probe error
> path as well, before the queues and vb go away.
>=20
> The same hole exists when init_vqs() itself fails after
> [ ... ]
> Fixes: fad7b7b27b6a ("virtio_balloon: Use a workqueue instead of "vballoo=
n" kthread")
> Fixes: 74cf5b169c4c ("virtio-balloon: remove BUG() in init_vqs")
> Reported-by: syzbot+0f659760bac1ecb01812@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D0f659760bac1ecb01812
> Signed-off-by: Mingbing Zhai <zhaimingbing@cmss.chinamobile.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109072651.1410=
-1-zhaimingbing@cmss.chinamobile.com?part=3D1

