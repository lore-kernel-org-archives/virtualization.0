Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793785884;
	b=wsAMqvIxtJM0dfuTdRcQKQWkhfe8oS8ROj830ErFIsgAwDOGsZozHy+5Ndo18xko30RI
	 x+bGLRMpHnTvb0xJQTni7Cmn6p1dsz7Us+H9aa7lzon3EaH/1Za2BJFTvpYguARQVA2yo
	 tF8kiH2uXEWmimT+rdaVyoUhi5jXbAkas4MVUX+FK88Y6a0/IMFRk+XLVJLut3+YHJ+9f
	 QmS+d61+r8un47hZPwCHXkgs/2tcoqV2ptCBsMmNdTtoZQdu0JQ36/mh8t9i0L1aiKkN9
	 Kc4o91nwASTvpIksATlr+2rCva/JYyfQhZCNnrFNubIIvols3CHDnzdkVoo40mlBKlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793785884;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nFOrB0RlUyfBaL1ZVNyfIXXD7jm51UKr3SX0ZVzaBSM=;
	b=TuGcHxPc2lKP5pb1U8EQFguF9WIEJlSijL042Zz2Q3QWgh5oE6XfoDkx1IqokS+sQoRi
	 uvGMuCfjCu4VWAyDzueQr6ER9i7BbxcpfyTv8uZgD5XfQNOSImCBZ9J85U3tjTws7UsQz
	 xM3HmAOxkXFkqo8DbGExazxgCFV7662tTPNb4210JlpmFkDrvz2yM6Jo5wXowriQMQbEu
	 CM6ANyesfCGu79toY6wgU+2yrqbCSpcavS1wZcuFZzgFXqJEE8dmEZtVBqJ6z/yx7pU1t
	 gkcpbOYss4iHtZzQ/8xDBrRw5A33kiAtdNXi2VRWWCJF7knABj6Gas8N19Re53UJ+qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oudw1gho;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82CB606A328;
	Wed,  4 Nov 2026 09:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oudw1gho
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E221F00919;
	Wed,  4 Nov 2026 09:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793785883;
	bh=nFOrB0RlUyfBaL1ZVNyfIXXD7jm51UKr3SX0ZVzaBSM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oudw1ghofc92RwmeX+P3J9uu8wG0/EGGONuNuDVEJPiJ8h1qlF6AL1v7AiGaRFIb8
	 a6LkTbPpLJaV3Jfo86XS7xXCDZRfIlRg4cpeizPdgkXnKg8MUGzCqhosT7TDw7+cpG
	 1UifggURqR3AtHwfwdjuMzXyMBKEGH/+CtH1GS+xeHrdqXZCHyTXS8sDv2BJy8V7WE
	 sJvMuyl7LXooB6tyg98+03iIQdgMdeIqU6W8ldNzmvd7JW8ua+wl7EU9uBSJXjjLX2
	 L+RnymVx7mTq6VopCnCX9ZE0smTg9GRY2jyiqeGuwbPiiOuEuhr51RkyVIX9xsXr58
	 fovbepPsx19OA==
Message-ID: <sashiko-outbox-197002@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 3/6] virtio-mem: support memmap_on_memory in Big
 Block Mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nikolaos Karaolidis" <nick@karaolidis.com>, "David Hildenbrand" <david@kernel.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Vlastimil
 Babka" <vbabka@kernel.org>, "Mike Rapoport" <rppt@kernel.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Randy Dunlap" <rdunlap@infradead.org>
Cc: "Oscar Salvador" <osalvador@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>, "Jason
 Wang" <jasowangio@gmail.com>, "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>,
 =?utf-8?b?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Michal
 Hocko" <mhocko@suse.com>, "Hui Zhu" <teawater@gmail.com>, "Georgi Djakov" <georgi.djakov@oss.qualcomm.com>, virtualization@lists.linux.dev, linux-mm@kvack.org, linux-cxl@vger.kernel.org
In-Reply-To: <20261103-virtio-mem-memmap-v1-3-308ae1da6240@karaolidis.com>
References: <20261103-virtio-mem-memmap-v1-0-308ae1da6240@karaolidis.com>
 <20261103-virtio-mem-memmap-v1-3-308ae1da6240@karaolidis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 09:51:22 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] virtio-mem: missing kernel-parameters.txt entry for virtio_mem.memm=
ap_on_memory
--

commit 20926ca463fbc5ddc5964493d1dbdfa119302f38
Author: Nikolaos Karaolidis <nick@karaolidis.com>

virtio-mem: support memmap_on_memory in Big Block Mode

This commit adds a virtio_mem.memmap_on_memory module parameter to enable
self-hosted memmaps via MHP_MEMMAP_ON_MEMORY when operating in Big Block Mo=
de,
and skips the memmap pages during fake-offlining and rollback.

> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index ab06adbc0342b..034d07207e44d 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -40,6 +40,11 @@ module_param(bbm_block_size, ulong, 0444);
>  MODULE_PARM_DESC(bbm_block_size,
>  		 "Big Block size in bytes. Default is 0 (auto-detection).");
> =20
> +static bool memmap_on_memory;
> +module_param(memmap_on_memory, bool, 0444);
> +MODULE_PARM_DESC(memmap_on_memory,
> +		 "Allocate the memmap from hotplugged memory itself if memory_hotplug.=
memmap_on_memory is enabled. Default is 0.");

[Severity: Low]
drivers/virtio/virtio_mem.c registers the new memmap_on_memory module
parameter with 0444 permissions, which can be passed on the kernel command
line at boot as virtio_mem.memmap_on_memory=3D.

Should Documentation/admin-guide/kernel-parameters.txt also be updated to
document virtio_mem.memmap_on_memory, its format, what it controls, and the
architectures it applies to?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-virtio-mem=
-memmap-v1-0-308ae1da6240@karaolidis.com?part=3D3
