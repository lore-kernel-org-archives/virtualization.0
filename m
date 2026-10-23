Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792743956;
	b=OZ6sYZgC0jc6dva87FTmRMsRyMYdTGw3ff8Caz7D6EhvmnHt5E26/HXNX8LoLAd5lPXG
	 wwZ8deqVEDgTawCwqrOw5tspoOQg5jgb7Fnx7L4GM5fUNJfzvG5hYJlRqKl4k6uJR61kA
	 nRaEc4u/++N05PUU4/YVBFjeHDdqOrpA+KHeXFIU5J+ZNqmEA2cmx7NYJxHlLaykc8Z6f
	 EhOtT17eKZX3pz8YTL7i8q/gDMsC7gEz/byj9sH1TfBLlxJFnSXHKfnQzjQh+XFOS1LI5
	 5k2bvMqBZzBC1SUiFY7ufvL/upSfTFp787EbrRexi0pc95BSukN0RKRwFlvtjpP+Y3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743956;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Le0elig3jyOtXZWExEL5WGxKMJfqgg40Pb5WpDqvPxo=;
	b=NZnVs5xJ3DiT7n4119W1Uz1VB86p5AQ/iiiLJ8az4L1b5oISGzpZtC0M/VUAsrGw5e1f
	 iHp//HFReAjS9SJNvvgXXa/MqoM0hzvC5wtDaa16QR9F1fHpXVnug1kj7Marevzbvv6n+
	 DaeT0Gk225RcU8t5fN50ytvZgWMp4wGMQjpPLxRtkMftsn+6PXduz0rKSPHZ0/mbPEe0V
	 nJF8iC0xa0kCRuxJ2LQaEdaK3vg2V65ZJ8UIiRStcC5h34WAdl698w9wG4qWu6wYPhHLU
	 DVMGnZG1teMlYxtpBnlahm+oC14Y0yPD+bAepcy3+gIvGFKZHNf3Behsy/yj9llZPgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aYgGiO+h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5594606A31A
	for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 08:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aYgGiO+h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28ACE1F01825;
	Fri, 23 Oct 2026 08:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792743955;
	bh=Le0elig3jyOtXZWExEL5WGxKMJfqgg40Pb5WpDqvPxo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aYgGiO+hJac3WlkYPvxSuuZA8nq8fZS4SjqiepjgWiZzhVcFnnozBZ3Acju9yb+B3
	 VHMq+Ywue1Dym9kTP+tpHg5eHMu2yp0w3DxiJGl8x/LYh2IPjR1hTAGkK2VDUmH3H2
	 fmkUroJQoEV1Jwtc7hG1523swBsxFAGxzEs84I6ddyy6JxZvPwsbt9p2zppxAWbj7j
	 e5k4JmdzqyY8Gt9ovzGuV21WF/un70EzYoiIg1CHVLCV4xYmdk5MiwWq1GtkZxpFZ9
	 S7PQi78dSCcKMPOtwa0Ow8LuWCiFfgpShE1XR2Dr44hJ8T7e7/FZI2geHU7P9gMqo2
	 iRZ9espga9Zqg==
Message-ID: <sashiko-outbox-182511@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] virtio_balloon: batch large descriptor chains for page
 reporting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ruben Hakobyan" <hruben@meta.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261023081923.164950-1-hruben@meta.com>
References: <20261023081923.164950-1-hruben@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 08:25:54 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The virtio_balloon driver reports a scatter-gather list of free pages
> to the VMM so it may discard unused pages.
>=20
> For an arm64 kernel with 64 KiB pages, the default reporting and
> allocation orders allow entries ranging from 2 MiB to 512 MiB. If the
> report contains a sufficient number of large entries, we will end up
> with a descriptor chain that represents over 4 GiB of memory. This
> violates virtio spec section 2.7.5.2, which requires that the total
> buffer length of a descriptor chain be at most 4 GiB [1]. A VMM that
> faithfully follows the spec may stop processing the descriptor chain
> when it exceeds 4 GiB, and discard less memory than it could. For
> example, this is the case for the virtio-queue in Rust-VMM [2].
>=20
> Batch the requests into descriptor chains of at most U32_MAX bytes
> (4 GiB - 1 byte). We use U32_MAX here so we can conveniently represent
> the batch length in a u32.
>=20
> [1] https://docs.oasis-open.org/virtio/virtio/v1.4/virtio-v1.4.html
> [2]
> https://github.com/rust-vmm/rust-vmm/blob/9f7250b1555ebe022ea4133fda676e6=
311040738/vm-virtio/virtio-queue/src/chain.rs#L183-L190
>=20
> Fixes: b0c504f15471 ("virtio-balloon: add support for providing free page=
 reports to host")
> Signed-off-by: Ruben Hakobyan <hruben@meta.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023081923.1649=
50-1-hruben@meta.com?part=3D1

