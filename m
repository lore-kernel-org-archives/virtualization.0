Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793864361;
	b=k6RTxPxjWGW3xm6k/g2bNPsJFBjJ6p7aCW/7dmh2ui3slMKYBF3808l/HdvMk3vZNuZs
	 FK7QFn0Mlsx8IJ/rKevsF4QAJ+8WLkztYqxRZdkONA9lhTTqJgHiyh23jwPXvBK8+YJ8s
	 Y3wna5Xmke+iRqXrqhend2gXEhLhLz/ZLQczxziCuVyrMfCZ6VZgsY0qFZ4862XUVwlBf
	 +z1+JKJvjhBZDCnaRghhx1urC+Q4Uc0w9OUzFeJEB0J1ySefc7QKXRy3RxE84PKUJTvG6
	 hhD4yTALO1DeCiwsp/kZDDmZMpvghwrET63WBrWEiZcqv7xHb5EI+5ATpxBkPrdaydQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793864361;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oM6fF49Ld6HfbzUcHB4+ecsQ9KxHa0z1ZEDp8sA1rjQ=;
	b=Mpq0YdDP0Z/NspDNpH5qrT81GuOirlEzI8QfWxkhlt6maBqXYwEBC3Qqam+faqKQ7qOL
	 jQdWXhJQ8Zz+N6JqxLB0/EeKlUcfqUxxbAtIZtdcz5c6djUKenzsh0Wk4CLgIOq/LXi3f
	 XLm/yPHy9/W3W3S9fISHWNL8RWzOc+/h8mWuR1eDfliDb92I8H4UjLXoQbnwIY4m3UR9m
	 TLmtJCzzHbiBzstVvZ6+d8ou8XYkPvlbD3AExljD6xCe102K/nEVsRvMLwFNkNIxudhpR
	 ouuzX+tXdt3bek9zJugfmIBUnVQACB3RisjXJAVLTlVX0LTUyswMIK3RmhAMOIJkqkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N5w+QPRJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7822E606A31B
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 07:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N5w+QPRJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C531F000C1;
	Thu,  5 Nov 2026 07:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793864361;
	bh=oM6fF49Ld6HfbzUcHB4+ecsQ9KxHa0z1ZEDp8sA1rjQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N5w+QPRJ2qwcI9BZvQ7A1uwPJDh8UA+HqbKrqpzAOvY5I7gkuh5miNHMjZxfDi/Ad
	 xm/q8JF6Eb5ytBNkh7TK3LEcs9golaAX7C3YXGQ84VyMZl5qLe9fjZLeQmTKnKsnEj
	 b63X8lQgwYrJ1Zw8H+ADf5fZz15V8ciwujbidxQuEO6+Zq4vYUnANW9MfRt2PqIhrH
	 flpIM80Ca5+m7afLfF0eO1bout71pGQXgh0OXb5YuJiUHcCrBc8t303u9hgsu1FNiy
	 hQ6hK9N7uV0ApMH48DUlIHuEYrw3miZ3ADHkrovV9JnX39aera+yk0ErHNa+ghSfMb
	 xMQ11m9HJW2lA==
Message-ID: <sashiko-outbox-198688@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 06/12] ALSA: virtio: Retain queued messages through
 device reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105070845.6449-7-mynameisjune111@gmail.com>
References: <20261105070845.6449-1-mynameisjune111@gmail.com>
 <20261105070845.6449-7-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 07:39:20 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Keep the control queue available through snd_card_free() so close-time
> STOP and RELEASE commands can still be submitted. Block new control
> requests and mark pending messages canceled before reset, then release
> their queue references only after reset and queue deletion.
>=20
> For PCM queues, detach each remaining virtqueue buffer after the device
> has stopped DMA and retire its message without reporting a normal
> completion. Detach all queues before deleting them so outstanding DMA
> mappings are unmapped and no token remains for a late device completion.
>=20
> Protect event callback admission with the event queue lock. Disabling
> events waits for an active dispatch, and later callbacks see a closed
> gate before ALSA objects are freed. Enable and pending-event draining
> share the same lock.
>=20
> Reclaim pending event buffers after a failed probe without dispatching
> notifications into ALSA objects that have not been constructed. Record
> the queue's prior enabled state under its lock before closing admission.
>=20
> Fixes: 9d45e514da88 ("ALSA: virtio: handling control messages")
>=20
> Track virtqueue initialization across partial restore so rollback deletes=
 only queues created by the current attempt. Clear freed event-message owne=
rship before a later remove can reclaim it.
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105070845.6449=
-1-mynameisjune111@gmail.com?part=3D6

