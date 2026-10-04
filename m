Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCD1369990;
	Sun,  4 Oct 2026 23:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791158181; cv=none; b=cpWh3dvpLLjtCOswC8kNiQSWp1F9MaJXK2PtM06V5eO9dnWQyuTtOF7EunLAOUh4Zg4Bg5bz20ksA/wf3fpQ5KOoyBv0QYdKLbqXjryax6e9g1uqU8tIbqXPlDNsBAopiYFwcLICU57EKD09v20V0CpBcesx8uulSvph/O8Ni/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791158181; c=relaxed/simple;
	bh=mO7ockWNMQbe9vT1F9/Rhz+Oc4XM/8L/LLPNEMYGgy8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U8dVLpxqMnRb0u3K+r5N9mNJ5I9o+o+8T11uibiumsSV+bxQzuNHV/XZj38bl/LiIEeir8STmUPp95G+HiOiAwaDaRdPUtD6a3h1ziAokGc/EY9+by0xPjd0atfhzhtUMQygeXdfDrLtOcf/PE/wJsmca4fKo//njJc29+nQIcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/emhz7Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/emhz7Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64811F000FF;
	Sun,  4 Oct 2026 23:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791158180;
	bh=HwYP6idY0UtcBpNgmgV+f6yJzagXTPEiK3bJDsl5ZcY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f/emhz7QFaelJfxtHcUzQ47bEtU2t3ybP6eKm1VH1nzGqySdUC1O58LdgkM4N0Y1m
	 SLDNOFGg47zFZBfDypZ4drHjqZp/+PllTXZPicMrwrR9sTrsYNXUVIjrZkcnHXWviX
	 eu8HazS0KwYZ1dn7K+2xfnXRdcsmv1bNclwEHEay50Clty3r5/TUBQZSdJrpQZgvqu
	 KES/wvcybN2tO4au/h6ffiE+RmFqc6jRX3Tzm80c+TglEJRhsBWE71HhPCXyEkvHqs
	 h4Ha6Rh4J42f5i96Bk+H/VY6HYz1yTXanZCSBHzOm/iOYkea181psVJSKkxrbQz4Du
	 fEphiZyzcm5uw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3] vhost/vsock: size receive SKBs from declared
 payload
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daehyeon Ko" <4ncienth@gmail.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20261004235101.1464007-1-4ncienth@gmail.com>
References: <20261004235101.1464007-1-4ncienth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 23:56:19 +0000
Message-Id: <20261004235619.C64811F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> vhost_vsock_alloc_skb() sizes the skb from iov_length(), the total guest
> descriptor length.  virtio_transport_inc_rx_pkt() instead adds hdr->len to
> rx_bytes and buf_used, and budgets each queued skb as SKB_TRUESIZE(0).  T=
he
> guest controls the descriptor length and hdr->len independently.
>=20
> A guest can therefore provide a 64 KiB descriptor while declaring a zero
> payload.  The descriptor-sized skb remains queued, rx_bytes and buf_used
> remain unchanged, and only the fixed queue-entry budget limits retention.
> This is not a lifetime leak: the skb is freed when dequeued or at socket
> teardown.  Repeating this across connections can nevertheless exhaust host
> memory.  On Linux v7.2, 455 such descriptors retained 30,255,680 bytes for
> a 262,144-byte receive buffer; a full-payload control retained 265,984
> bytes.
>=20
> Vhost previously read hdr->len and allocated pkt->buf from that value.  T=
he
> conversion from virtio_vsock_pkt to sk_buff instead allocated receive skbs
> from the descriptor length, introducing the allocation-accounting mismatc=
h.
>=20
> Copy the header into a stack object and validate hdr->len before allocati=
ng
> the skb.  Size the allocation as sizeof(hdr) + payload_len so descriptor
> capacity no longer determines queued memory.  Check payload_len against
> len - sizeof(hdr) to avoid addition overflow on 32-bit hosts.
>=20
> Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff=
")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004235101.1464=
007-1-4ncienth@gmail.com?part=3D1

