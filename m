Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792743270;
	b=zaAoQ/5FJX44q+I6dPT6ASbqKVZ84iaDb44CPK15el9DtnQSd9mMk6svbCSy3S2NYmGW
	 0jYS7lda8fq+NT+pV9i+WNXgN5aKFViHhsRAI4kQpc1ygiii3yU75Mo2V92PJagHwxFxm
	 qqGlcL0xZ0tlAmTsgs20XQIZJbY7m9+3E8lSpi1FSob3qNurDJRYZHJPT2x+ZlNxOH/PI
	 XfTZ1b9U8peW8rvqXbNLP+g7ugjuJ3LAxV/jauyfC9K4LOb9SdJ+CSDY0qo0bwroF9fjE
	 otLckg1NlAbXCt8NthMiEz4pkw9NnEwsoUp/xk/5rp3tPKhXcA58Qa57ZbWvJ6QzmWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743270;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lRvQBYsSfafK7zE9fnkjXRgAl8k4TqHvbVGNAI8L5Vc=;
	b=pCPjHQh57WGPRh+/T1BPFxA6h88g8P8rnnP172gwRLLFjcBBq4lqD5UCCaWT03prVTPG
	 aeDC79HOMd1R7iBzHrh4QoAaOz+mUmzVrftYmLlb950USis2JvLkRztxfGBwOT/Qz/7Hu
	 9l7AVj40Ks0lzs/v+EDeMvewzDTDCh7dh8Tn0A9xMb1S6Wa7gU9aqHNxu8zy0tJJYlZv4
	 P/EJn+3COhVmm97foVIRJXmiVekE+qVULgnlN4plYGupuQwgCBhIMTO0H9lpmnyYzvE3J
	 tdkOi7FVxBbZmcln+ZA4I7PWHv6FF3vcVjucMs1FDvVSQ+MJGJWpAze0ZVIH1mZ4aUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A6RFbKYZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC6F606A31E
	for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 08:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A6RFbKYZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370CA1F01828;
	Fri, 23 Oct 2026 08:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792743270;
	bh=lRvQBYsSfafK7zE9fnkjXRgAl8k4TqHvbVGNAI8L5Vc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A6RFbKYZe9P4uK7zQ5gMrertFOmFcpi8Eo2g3Zgf0ehiMZE7k0ovWXS107s8F/coT
	 b01C0+D8lziVdpicLqSiBgZiLzaXok61qBe2skoILzUHLQs1AGA8T/ymrs+g+WON+d
	 vpbq41nJasxzt2Mzwx4vEL5TZyEQfN1VaAMlw3NtlCI7dMPfJ8FHzGQdg7VmPq4QCh
	 5HxndTvS/rLPr5NJVc0468VlVdlLMt15kaI0vgsfR9Y/Pt2WrUxFIzzYmxB1twUGKi
	 YC0cAY1BcdatYu/gylZIKm2RVxmzLmYXAJ+CCah7HAngPz7RKEX1Lguub+GYxbPU51
	 aixw82I1ynRtA==
Message-ID: <sashiko-outbox-182490@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 2/5] vsock/virtio: factor RX skb metadata
 budget check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261023075140.9613-3-physicalmtea@gmail.com>
References: <20261023075140.9613-1-physicalmtea@gmail.com>
 <20261023075140.9613-3-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 08:14:29 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Extract the skb metadata budget check from virtio_transport_inc_rx_pkt()
> into virtio_transport_rx_buf_full().
>=20
> The helper retains the existing condition and will be reused by a
> following RX batching change.
>=20
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023075140.9613=
-1-physicalmtea@gmail.com?part=3D2

