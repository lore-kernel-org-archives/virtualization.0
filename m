Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F80271464
	for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792051100; cv=none; b=q7osLjuPNvbOMZcYpmypzgNdTq1OtdreuAav7WXtjj6I+nUx1E3DXk2OjOreEPLNvTgNejNc0IHvTrGpfUpsEVrM14K0Eoof3Q9n+C7P4qk+DMtqZSgwKu0LcgV/5au3u7HlqtYqe5mp2N41EDqrLL7aKZ4QjKlA2Xzx1DbVpRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792051100; c=relaxed/simple;
	bh=DIwUWdtl+gmjrREbO5f6oYcy8lDT2yV1LORE1wze2Vw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=YMV6vMOhSOANVNkBmgHJBFtE+dowZA2hLZGUZqNsNbuIp6DtsBvGnnwHsiDiECPdk52mX8765WkiWfu7OQtJ6KMIt5aP11iHUmJtkNiTK+oFCrrPMifX9jC4cVGWMK2ZY27jODM27xjRy2gdNfrL6SYhjAeOaBRRwKZEUmQ+UQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyX/ZcxG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyX/ZcxG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4E91F000C4;
	Thu, 15 Oct 2026 07:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792051099;
	bh=DIwUWdtl+gmjrREbO5f6oYcy8lDT2yV1LORE1wze2Vw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RyX/ZcxGTzi6zg0xl7y+qzFRc52srX/7+1BqdCwWoXyLDu4n1nejSRyyUmrYsqYTl
	 movs6MDRuaUip/Pnct5cqVPuUzmmUZCDaZyjZ+cVMBw10wngFqsztJSJCe4pdyG+He
	 gZBGE7qJvTYT9pFYsUqNwHglZeqx1ddBKlsNiXE9tYElo9txC7SZdzoFnfZimmjqN/
	 6rZMjvsurqkDXug8rZxT0hNIEUmrP6/g+A59YL3xZoHFMAhbwLVR5eSe6Hpa1pVfph
	 cdNMKFnL0HOX5++kGbBRQ8t9adg2DvXXG6Kc9VP9xwKw4j4dnnJa3qrxLQ7np/6CfW
	 2FdNanBSM04sA==
Message-ID: <sashiko-outbox-172440@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH nf v8 2/3] netfilter: nf_dup_netdev: bound asynchronous
 duplication
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zihan Xi" <zihanx@nebusec.ai>, virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <a23b041de631f3c3821de021cbd4d421f2359ae9.1792048855.git.zihanx@nebusec.ai>
References: <cover.1792048855.git.zihanx@nebusec.ai>
 <a23b041de631f3c3821de021cbd4d421f2359ae9.1792048855.git.zihanx@nebusec.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 07:58:18 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> The task-local transmit recursion counter covers synchronous
> dev_queue_xmit() recursion, but does not follow a duplicated skb through
> asynchronous receive paths. Carry a bounded duplication depth with the skb
> and preserve it across skb and XDP conversions.
>=20
> Store the depth in the sk_buff headers group. __copy_skb_header() copies
> that group with a single memcpy(), so skb_clone() preserves the depth.
> Propagate it explicitly when veth converts an skb to an XDP buffer and
> when XDP buffers or frames are converted back to skbs in the core and
> virtio paths. Preserve it through zero-copy XDP frame conversion as well.
>=20
> Clear the depth when GRO reuses an skb and when AF_XDP or libeth
> reinitializes a recycled XDP buffer, so a fresh packet does not inherit
> stale recursion state.
>=20
> Keep the existing recursion limit and reject MIRRED flow offload where
> the software depth cannot be enforced.
>=20
> Fixes: 502061f81d3e ("netfilter: nf_tables: add packet duplication to the=
 netdev family")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: LLM
> Co-developed-by: Luxing Yin <root@tr0jan.top>
> Signed-off-by: Luxing Yin <root@tr0jan.top>
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792048855.gi=
t.zihanx@nebusec.ai?part=3D2

