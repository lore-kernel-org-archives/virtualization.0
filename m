Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BEF4BD370
	for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 12:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980115; cv=none; b=bJBflABv+58KveBykG6LPBjWn2g7UH8kO0QamHM2iA4Wl92Dit1HcAvvfx8ZBIENw8E5nQjF7fP2mFHs1PsXlstp+Mw4JcqBuoC800AP+ma4bF3cmIQOdTYHzj2LeH6oagIXGpvCHxy4hr7E+v9taCAEr9w3cEbqrsoQi81Zbgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980115; c=relaxed/simple;
	bh=8HmZ67tQb0GodyGqvLFH9vbhbi8pZScD6oFOix0nkCg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=HDCv+IkHDRkE3OcMeHv/UT0bGHmLf4iOxba3N1FuUV/ek5W+DeJyBDhOJniRQFMEAMCbqWV+Y70ojPIsKe93D7fSFm7r9NZl9VQl6lV8XKmkE3gor0FZYElqZ5vbCJ2hxSpCczNimi52zs2A/MMmzRrBYp/d5YJRuYkY4GMWCEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jG6U3kkA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jG6U3kkA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007371F000FF;
	Wed, 14 Oct 2026 12:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791980114;
	bh=8HmZ67tQb0GodyGqvLFH9vbhbi8pZScD6oFOix0nkCg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jG6U3kkAMOSlzu5SPJ5HgN/5foiwhJ9V4yMwzoRi8ZwiPuDgBORPgsVH4r2erMSjy
	 uE5Sbi9NTBvrn9i5fiQ3UYTaYqO6pWFybebOIIaRIU8girAA+HCxwJj3T710tJSnvH
	 6yrSArsUmQYz4KBGIafrN4VuSwRsoiYME6rWul2K/IZzkzYKgmOmWyzPTZ+zZtqbQ+
	 gVPkowQdhG8cpQGfOUAr9Gx/WkojoKwx+TF05L8+uQNF7flnn77OExKnj2PHCkXdHM
	 mzCYhwhRsuuyTNBKv5D4ychWh1WhICbJ6dWVDQbYv6hQZK5sYrgpDxkfA20zKU1mbd
	 knwP7RGj5rn0w==
Message-ID: <sashiko-outbox-171251@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 2/4] vsock/virtio: amortize RX socket
 locking for stream packets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261014115640.184286-3-physicalmtea@gmail.com>
References: <20261014115640.184286-1-physicalmtea@gmail.com>
 <20261014115640.184286-3-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 12:15:13 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> The virtio-vsock RX worker currently looks up the socket and takes its
> lock for every packet. Keep the socket lock and lookup reference across a
> bounded run of STREAM/RW packets for the same established socket.
>=20
> Reuse the locked socket while packets continue to match the same flow.
> End the batch for a different flow, non-RW traffic, malformed packets, or
> a change in socket state, transport, protocol, or receive-buffer headroom.
> A connected-table miss uses the existing receive path.
>=20
> The reused path still traces every packet, takes an skb owner reference,
> validates the source and transport, updates credit, and runs the existing
> receive state machine.
>=20
> Sockmap can replace the protocol without taking the socket lock. Check the
> psock marker at each packet boundary and serialize initial admission with
> sk_callback_lock, so a concurrent attach ends batching at the next packet.
>=20
> Cap a batch at 64 packets and 64K of payload. The packet limit bounds
> per-packet work, while the byte limit bounds how much data can queue befo=
re
> a reader acquires the socket lock. Batching remains in the process-context
> RX worker.
>=20
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014115640.1842=
86-1-physicalmtea@gmail.com?part=3D2

