Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793145215;
	b=mv7wsWd7CStGxnHMXQikLzFSc8pAdWJ79VHNdoU+tJvKXcWaoSf7Tx73IhJv255prpB+
	 TUhoKoBvvGft2glMpe0QMuExy58HEIHoYisbTPTCnR7NsXid76kvQ0xCdosmtNBv6OARv
	 BuDJe8cWjN74tVA1ruN/nHCPZB1tAKrExFwgWWmX+D3h66gYQBYsIgdNIc1Qf2Pikyhdv
	 3jfIv8SliqqN9NNH7xSAeY+SypHBiWAr7CAUBX8s6TEKArcPJtxZ2ZBEgD6VquKCDbnrC
	 xa2NvU+S8Zd+htIMGG4kh5TpjMQ5FSLU5Rn9/FUZB07KwonnM1sPzCoCiCU0sA/CgDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793145215;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=63tMFJt0xgGy1zUFOfkDGxjWizeYEw5M5XctU2QztK0=;
	b=gHEiN6q9TL/QQ+Xb6Vj31BCE08V5X3BK8BaVSifAb25PP9+QhE1M6Tf0wvvBwBt3dFQ2
	 cbCyO5A+44JXenO0u9Ko/vFnzPyo8HO8/64O4w4zcPHSjxItiyHKc4DAp9FGYTcYo8lAe
	 NNK/m/IjtzIwd+pUctpgd88YvziGyvViytanj+xQY5vpp7abZ+uYosry9RYBnojDda4rn
	 zK+vdqrp48E2CzOPUL5oHuqssrBumFHnEOK8xCs09LQMiPmCudt+Mlf5IOY0sVxrXmImZ
	 Vxo3+oiTfWj8ctGTkzvyqX66/fEFnpESAybd1V3BiJVRxgdIaW9rH9G3WrCZ2ZnbEGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nd3xkLtL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B68C606A31E
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 23:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nd3xkLtL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410DA1F01825;
	Tue, 27 Oct 2026 23:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793145215;
	bh=63tMFJt0xgGy1zUFOfkDGxjWizeYEw5M5XctU2QztK0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nd3xkLtLufehQIysD3295mmeBpmgA8G/C4IVIdMPJ3LvYHnatpmEXK+Hs2KVngAOh
	 ZeKh/7V713OQbX63PGgVaZVhsCAcN0U594Y2NjftWvIZjVjnY6L6GzDzXgthgmcwkV
	 MGP4QIAB81oOUJ/NseFFeNA1+4eVJFS6e6SQb+MXc0dzE/p0cgVl6ZRAygR14k5gb2
	 MWw7j/vZuewrTVTfkO5aDW5HJcBZgqmvgBvefpAhgHHK1kL+IVKRFGcC5sI9VAIL7S
	 RM0ulBk1dlZ8GJ5dyoxgphfzgDhHjK1fbDGItBaA2bmykoonYVQ9jLlpVOR+VDC7KY
	 3PzH3BfP+8uUA==
Message-ID: <sashiko-outbox-187240@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/11] ALSA: virtio: account staged capture reads
 before RX refill
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261027234334.32551-9-mynameisjune111@gmail.com>
References: <20261027234334.32551-1-mynameisjune111@gmail.com>
 <20261027234334.32551-9-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 23:53:34 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The RX callback holds the queue lock across a batch of completions. A
> reader that has copied samples can wait for that lock in ACK before its
> consumed bytes are removed from capture_ready. A later completion in the
> same batch can then reject data using stale ring occupancy.
>=20
> Account the staged read under the substream lock before acquiring the RX
> queue lock. Release that lock before taking the queue and substream locks
> in their established order to refill requests.
>=20
> Once accounting is committed, latch refill errors as XRUN and return
> success from ACK. A negative return would make ALSA restore appl_ptr while
> the driver retained the consumed-byte accounting. Keep pre-commit errors,
> ring-capacity checks, and normal period-work scheduling unchanged.
>=20
> Source-extracted host and kernel fixtures reproduce the stale-capacity
> race and post-commit ALSA pointer rollback. The candidate preserves wrapp=
ed
> data and pointer accounting. KASAN/lockdep QEMU lifecycle checks passed.
> The fixtures substitute selected backend helpers and do not independently
> establish physical-device acceptance.
>=20
> This follows pending staged capture support, whose introducing patch has
> no upstream commit ID for a Fixes tag yet.
>=20
> Link: https://lore.kernel.org/all/rfc-v2-vz-capture-compat-1.b9ab4c1540dc=
4691@gmail.com/
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027234334.3255=
1-1-mynameisjune111@gmail.com?part=3D8

