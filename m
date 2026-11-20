Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795186459;
	b=ak4WKH1FZgzqXG0rFcoqPVRjo0xezked8zeyfjQPd9cAOwaC7i8w/uTsDr28hYSrvzpz
	 7BrKq/8hgNcWtifcNAIqpRepBfJGR2fNIeK8UNoYRE/dk/zXOef1MVSa1BwBaw/BdoOpO
	 thqZArQjsSsFjsmMWWCG0OJCUTKZ2bQ7zqus7e0c7j6QJwsFqKsqWSCSuWIU+YTFZwxmJ
	 Cp5SQdTRI8UJnPm4U7Rll2V37CWsTlDsFxhTyVDdAjanthagrS2U0q14oCqmhGenGWqmj
	 vb6PsZyvEtoZjYMjSkFFKBxutp61AM9LOuP0t7f13QtjZZsoZL9aIOVseqiccX/9qyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795186459;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EsE8qNm6IjUT0NUHzAENWXXHBDn8FdEN+u3afZwlXBs=;
	b=cuH9Q1uXAleu1Qvnu7DhijTh/7tqzEb32fgjaWZBPjHqw0mp1nJhXrowMtC0Z5/tb21P
	 6EbBobH2EwnvJbumTs+3NbACSKV5Z6/KLGkY6P/xrgV6o8vLIzW0P8xoA7AriABYF2+ea
	 kP0IXlX7vg4v3ulk3sFe35/+COCFR02v35l/YwixmoCle2n6n0zzxCbmD7u+crCxOeMWR
	 xovpzPZ8fCmFwnwH7XDsnMLYAugGMn4+ELXFWMVLicNbKLGOulV0AlLemOfcKKSX8WPCj
	 WENdLzqVOLcnAaPmF83x3twnAyhZBjAb5BPBk0WmkHRDCqALHpNEZbu6AvryXnJjSQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BH6FJYdY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6BF606A320
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 14:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BH6FJYdY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3C61F000C0;
	Fri, 20 Nov 2026 14:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795186458;
	bh=EsE8qNm6IjUT0NUHzAENWXXHBDn8FdEN+u3afZwlXBs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BH6FJYdYcTtV06oLRJPvS8qHrR/HJHfl0CCtC6GVMdg/clDsCzn3twK6JuygWb73C
	 RuKXwYGldBnrQy8oMaO/wb2+UCNiF74nniffdr+qDLt2Pxa1NVLIoLSy7SjOzPhjed
	 puA6qran6rnVFCYV7jlywmQBWAlxLYF2wnimOhlKFXmtXkGVe4aUBVijrWcUyVIjr5
	 zOfhZWhEYYkb8yPcpUN2pliAzWlFeBi9rIUvqO6Bzsje9MobqkhYTY1bBgQKiGhoLm
	 0zyX3Dz14A78aBpI+I5vRL9ecz8q8+CIjovxP+XNqaKC9gVlkCj1s4SoNxVbNR1pcp
	 QirhwQ2d3LdDg==
Message-ID: <sashiko-outbox-225412@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y] virtio_net: check RX buffer length before DMA
 sync
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Petrzhikovskii" <vladimir@dfb.sh>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261120144828.1573321-1-vladimir@dfb.sh>
References: <20261120144828.1573321-1-vladimir@dfb.sh>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 14:54:18 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> [ Upstream commit 29dfa436bc488056a84ee423ba82336db453e2a6 ]
>=20
> An RX queue that uses the DMA API (rq->use_page_pool_dma, for example
> with VIRTIO_F_ACCESS_PLATFORM) syncs each received buffer with
> page_pool_dma_sync_for_cpu() using the length the device wrote to the
> used ring, and checks that length against the posted buffer only after
> the sync.
>=20
> With SWIOTLB bouncing (swiotlb=3Dforce, or a confidential-computing
> guest), the sync copies from the shared bounce buffer into the guest's
> private page, so an oversized length also copies the bytes the device
> wrote past the posted buffer over the neighbouring page pool fragments.
> The later check drops the packet, but the copy has already happened. A
> malicious device, such as a host the confidential guest does not
> trust, can overwrite guest kernel memory next to an RX buffer with
> [ ... ]
>   existing checks then drop the packet. Tested with the reproducer
>   described above: without this patch the marker reaches the guest page
>   for small and mergeable buffers; with it the sync stops at the posted
>   length and the packets are counted in rx_length_errors. ]
> Signed-off-by: Vladimir Petrzhikovskii <vladimir@dfb.sh>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120144828.1573=
321-1-vladimir@dfb.sh?part=3D1

