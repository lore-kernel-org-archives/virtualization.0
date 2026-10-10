Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016004A6899;
	Sat, 10 Oct 2026 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791643169; cv=none; b=HqnUScSBiYF8gpg9b3Wx2xRzA9Y//1AaB6/U9U/irb660Wts9RmwdhdIOyPaj/2e237W5VceRXDkoMux4dWE2QTAoelU8EriNUFI/nJYiDS77gGvTvUxLEstclkm4Hs9vbjc9pjmTT4L3f9xy8Eu27j+36im1AmyB7zQEFw6+SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791643169; c=relaxed/simple;
	bh=fFDDWAiIXyf+9/sVEUIb8lxXgTb8KlyXnLjMQoLr2zY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=hZxD04cNb1tBQV+hRRk5g1mxCs6b1AGp9xyB2R9qdoJVfMwz9oSDqWy4RtucIAd26cA+5huJYpTRofjA7Xo9OO6kfHd4wV6Z2hBKFSac7CI2XjAWGER2nTedDmnlHvdZ6yIoAb7kYArIitJdfqkDUba0Xoiz23+WxXLGFQln9jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGwz8FCO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGwz8FCO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BEBC1F00893;
	Sat, 10 Oct 2026 14:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791643163;
	bh=fFDDWAiIXyf+9/sVEUIb8lxXgTb8KlyXnLjMQoLr2zY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MGwz8FCOrwr2IEDawQFCK3BL4R0vTilxyg9Z1LzQp6XgR+xZNDVKNTkEX9aRfwAMF
	 taJRTw4jkQK9J9RXaCazK3cnADDyi3RkHlI0/c+kG06qkLSbD9ukPeQ/h0zt8a3mLG
	 vudNpMYbFNg0LKJ2NRHc0GH8Vly8yJi1zo9tUpZ1y9KzbgGOTppDgq2y4yiyaqr9OX
	 f4u/9pVOeAOWTHfN1vBFh8Nuw8j8WmVM5UgcgyWsY8fczDCwGNEHjdWBaAUcBMEjkP
	 7h25ShwAUh3UCjP34UtxsDCjERqMSHAwfaWwnfggE3cEk/CrNtjMlo7wSLh/R5uUXj
	 5C0IiZ8JoQwLQ==
Message-ID: <sashiko-outbox-166653@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 2/5] vsock/virtio: amortize RX socket
 locking for stream packets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>, bpf@vger.kernel.org, virtualization@lists.linux.dev
In-Reply-To: <20261010142247.99223-3-physicalmtea@gmail.com>
References: <20261010142247.99223-1-physicalmtea@gmail.com>
 <20261010142247.99223-3-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 14:39:23 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> The virtio-vsock RX worker currently acquires and releases the socket lock
> for every received packet. Keep the lock held while processing a bounded
> run of packets that belongs to the same socket.
>=20
> Only ordinary RW packets for an established STREAM socket whose transport
> and protocol remain unchanged are eligible. Control packets, SEQPACKET
> traffic, state or transport changes, malformed packets, and sockets whose
> protocol has been replaced end the active batch and retain their existing
> handling.
>=20
> Serialize the initial eligibility check with sk_callback_lock because
> sockmap removal restores the protocol without taking the socket lock.
>=20
> Limit each batch to 64 packets or 64KB of payload, bounding the work under
> one socket lock. Keep the lookup reference until the batch finishes.
>=20
> Keep a batch only while another skb metadata charge fits in the receive
> buffer. Share this predicate with virtio_transport_inc_rx_pkt(). When an
> enqueued skb consumes the final metadata slot, finish the batch and relea=
se
> the socket lock before processing another packet, restoring the reader's
> scheduling opportunity from the per-packet path.
>=20
> The virtqueue callback remains a queue_work() callback. Batching runs only
> in the process-context RX worker.
>=20
> Introduce virtio_transport_rx_batch_finish() to tear down the batch and
> release the socket lock and lookup reference.
>=20
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010142247.9922=
3-1-physicalmtea@gmail.com?part=3D2

