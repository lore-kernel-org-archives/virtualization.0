Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793386449;
	b=UGsaiALB/moEtchX73gUkk1UUXruTCjqpMvDCqvjzVxlqmyltRQFUPtxEwiFc+BgkCRw
	 UJ8BOd6V8FZndxFp2vkuXZtKzdp20sr5atKGkdlrD4gzcskUPYY5ATE/Qcv1FbktzjZ3x
	 GdaCJZa+LtPvgpACxxh9HuHB0HRnIz7Z7zJ3h7Hsg9Buf5N9lkVIgW3yKO+Ffjq8h9b79
	 myadCkrM1jZNSMNMirKb2hvrEsJ5rnToOGUPGUQC3hlF7n8ampr6VY85Yv6HYZCsKHPgA
	 0zlU91TX12daPr7A7EI4Rx76X8wEg4pYGMlE2DBtqA5MD2XyWtXwavOnFssaY049uLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793386449;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YIB3idJExjEZ0F5IyWy0/u4X70yJkQGQTLF/EQMmzFQ=;
	b=0H9EXfe1YEqhJwxkx9OjglU8N6V5Qc0I7E9royay8ZP0T4A0Xnqd18YkYrsk8BZPnnVI
	 Y8Org8Btq1kUGfB9+EKPIti4eJz2lVJksQ7IgP8UcJhnTInHdQQQgLFCTKUOVo68bS5zF
	 qp7O7aL8qvxH5HWoQOqf8Ohwvae/XuIv4qd5Y615tWa+clPONeUUfJOkdaFelYkOiFZgr
	 pG8yuSdAhkP3lR2NQLPBdGnbo/jv5Cinx8Xro9VXqaVDLGFx+/DYFohhSBmanCcnV9eln
	 JB1B17Nk8dvGE7e/27xWA31m/D3DYTxkHQWZ3yznRAYp/OfKYw60jcYSsaw13Lgdftw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DOU2nFkM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871DB606A31C
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 18:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DOU2nFkM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FD81F00A1A;
	Fri, 30 Oct 2026 18:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793386449;
	bh=YIB3idJExjEZ0F5IyWy0/u4X70yJkQGQTLF/EQMmzFQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DOU2nFkMX5WEdslbSRwuDlrNelSPLcVKAv+Fb1q4WyKNOyXp2vcAybcAP5k4AJ221
	 jL40vSOMRvM1pE8d5ioA5H0vNNZF1VBCydYVegPkJv+bxXqW2nXeJK3E7LqReTG4C/
	 GL6YXkfyKeSWOolni5euRMo0EEkpINghKOIZOae8RYIIldQvDgGpaDxIlqFacS04LK
	 cBORHs/czAV7Lv+BAs3cbusq0eVJtZo+1++QsuK2PC/iN2c7c1Gqmex8vW1kwhO1J4
	 EacFjF/yS+cwUpKR/WF60ATKqFAq7/N4ViuwQ484L3DLqF5Wlen6rK8z+LMRT68G0M
	 rUCErvIF5NdJA==
Message-ID: <sashiko-outbox-191417@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v7 1/5] net: account for ingress-resolved virtio net
 hdr state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <305bcadb19f4a539a318c6b87c829fbe43d0ffdb.1793276116.git.mst@redhat.com>
References: <cover.1793276116.git.mst@redhat.com>
 <305bcadb19f4a539a318c6b87c829fbe43d0ffdb.1793276116.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 18:54:08 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The following patch will add ingress resolution of uncommon virtio net
> hdr checksum metadata (software checksum completion at ingress) which
> adds performance overhead to the packet processing.
>=20
> We should make it visible, so a hypothetical workload relying on
> uncommon metadata can be distinguished from none at all. This way issues
> in the parsing will be reported and not quietly pay the host-CPU
> checksum overhead instead of offload.
>=20
> Flip every call to virtio_net_hdr_to_skb to test for negative errno
> only.  The um vector raw transport even ignored the return value
> altogether: rejected packets went on into the stack with their
> metadata unvalidated, so check it there as well.
>=20
> Have tun count these events per device as rx_csum_sw, exposed via
> ethtool -S.
>=20
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/305bcadb19f4a539a31=
8c6b87c829fbe43d0ffdb.1793276116.git.mst@redhat.com?part=3D1

