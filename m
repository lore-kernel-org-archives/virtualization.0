Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0177E792;
	Thu,  1 Oct 2026 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790857602; cv=none; b=EXQo/ftBOiGRdIWdks7YSZ0Ha7Bk3Gb39FPC9+70Gv47Gh6iKZQZVD9wUb/ukf7Iwc5zq/XNrkRNt/4drAy6j0RKWwJwJ/Jd7qjjUBOYVBYXyqxGlZYH96jr3Kh49KCl1D1fHZ7uOidYe1A4onjboQct16VyrKbvO+PsKyRBomc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790857602; c=relaxed/simple;
	bh=bkCuTs837g+9aewkTPrqJxbKJ1hZ5Y4Uu85+sD/30v4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MqBfQNpiEzahktO59tFZhTJuYdWPwzYBKAVToDOEkBfnGH/Ph4mzcYHvApzfnbkKMSUjomDKS3vvN5fvmniAupPT4fLLb5LjWMFsKQ6k9FyWKRXhbKp5fMDZbK472OLH2Vglpy/+U6snU+ZAb6gZbH+hSuXuEYieA9fhuLQ7dlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=or9qp2E3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="or9qp2E3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2361F000FF;
	Thu,  1 Oct 2026 12:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790857600;
	bh=LvTK3dcJ4MovklybGQxKneeayBBtRTGGB/P6YcFO4sM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=or9qp2E3Knn8FgZLtoi7SXfOtZrDFJFco2KWsqBeK4t5gLgx0yDSMF9VxUuVUW0Rk
	 9W/jtWqD+U8oNhZmKkGR6dwQdN+cHJ2mSj24QLtR73IIJRLuH/oY5OTgEbikgYCzpb
	 wDm4bukVcC9sjdmixSWw2GFlr+KMHyXK63QHSx8ahPIfWKLzM51XOUTC9hBLc3CQZV
	 GWIvjPl6LxBY9NYCs6HZF0RZ7ektLYSS799WbgpJXJrEYhdA9XOMpGlXTatzIJcCxj
	 LtM7TYGjUmKDF0a50ct+m67gkUwyAnopjFwspSsyYZitf0otyorgbEcpje0ZXwMsJb
	 CLOZbZTrJsWCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] vsock: account only unread bytes in read_skb()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daehyeon Ko" <4ncienth@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261001121541.2983379-1-4ncienth@gmail.com>
References: <20261001121541.2983379-1-4ncienth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 12:26:40 +0000
Message-Id: <20261001122640.9E2361F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> After a partial stream receive, rx_bytes tracks the unread suffix while
> buf_used and peer credit still cover the whole packet.
> virtio_transport_read_skb() dequeues that packet but passes pkt_len for
> both counters, underflowing rx_bytes.
>=20
> On a connected CID_LOCAL stream with an SK_SKB verdict, a 40-byte read
> from a 100-byte packet made SIOCINQ report -40, an empty recv return
> ELOOP, and poll report the empty socket readable.  After verdict detach,
> receiving 40 bytes wrapped the counter to zero and hid those queued bytes
> until one more byte arrived.  The fixed run kept the counter balanced
> and exposed all queued data immediately.
>=20
> Subtract only skb->len minus the VSOCK offset from rx_bytes.  Retain the
> full packet length for buf_used and peer credit.
>=20
> Fixes: 45ca7e9f0730 ("vsock/virtio: fix `rx_bytes` accounting for stream =
sockets")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001121541.2983=
379-1-4ncienth@gmail.com?part=3D1

