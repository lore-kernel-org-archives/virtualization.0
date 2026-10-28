Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793157710;
	b=UkCfl7BpuiNaVC/mFS4g/aVh8Yb3GnkqzpE64gNid+i0ZGyD831uk3YzkF+iBuuWsCQW
	 AarE6xMaXThu0odq0rmAhdoqV+asEvRBEZ3mC44lY9n4yt1nhA/kaioMAuOnTswYuI2Ei
	 WLsrZAXEIFQG2g18evOHNUyhNTg+ERSwDb6VWk0xEV+d91eLcLTP5hjlbx6MguPgcwnr7
	 geIbgzpNFotcWH280XTM4yQ8d3CIbJUBk2XONTySKyZKjOaErFNB2yC+yWHcG9RCGJfos
	 +4Lb9tzVerZ8J9NW6FS3wIoliJJxHwbXtpuiIJyLxIxlWBRkC35zcuNqtDhKK4NAMxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793157710;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=29M8zr7x17dsoAm84YKB4rnazH1BlXT7XBSIpwwpgxY=;
	b=gcd0po3oyRMbpEjF+j78T9u62FHcmrc/6Y+kj2Rl4p2naRwK4roV+TeAuV01wZuPImR8
	 yHXza6oSZEOl2h+N7Aw+qHps/wyLWELxTh6w1IJVWI82FttJXhvI1C8eWsVGWQ3oet5JM
	 qW65ln2AuUHn3T4I3z0UB7Gw/exosmlVRqcBAsQFOgFzJpBX33Y2B9vtjm2k24dsWM0Fd
	 8DOA5qlJNdGQu8zkcyXDXyDRH+PpbeOKUvkWvXX0zWlwDS8LFQ3s6mr6/qOjxupHOclbB
	 S2Ryg9LoHF8suBNgU/JoRVGgqhncMj2kuYbUtBb3T4XQZec/mWvnCuWhkX4XTkmAhwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WDptkLPp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6DA606A31A
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 03:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WDptkLPp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF621F01825;
	Wed, 28 Oct 2026 03:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793157710;
	bh=29M8zr7x17dsoAm84YKB4rnazH1BlXT7XBSIpwwpgxY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WDptkLPpfBWfctydvNjRRs57BmRVX93mboPduv8ooxGmv73OMpUSYZHTB+xFSkf+P
	 Ws/d1x2Pt8PFuyFSS1YfGQSa3X4Q1oaU6GbYSkrStGlng94xpiO/dMuHjM+8GjhD75
	 QqbNooGtzhdQiXn0bn7zWcZuaoQ27w96Iv0+RNuykZcivqIcZR3/NOFr2e9yvDjsxG
	 I3F/k9b8HgVmET+G/UIg2uGqU1UbNl8vEOXGQKJvRX+rAlPwfHLU33FWxrdxXVCQd5
	 P4Ei3zAwho6JBbJyi0pkCWZFenIu9SK14CCPZ1l2PlsvBc20HFSzoxD/u1qchjHaIO
	 pytLgCmr1Lu1g==
Message-ID: <sashiko-outbox-187417@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/14] ALSA: virtio: Recover PCM state after a failed
 start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261028025317.92450-3-mynameisjune111@gmail.com>
References: <20261028025317.92450-1-mynameisjune111@gmail.com>
 <20261028025317.92450-3-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 03:21:49 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Capture trigger queues I/O messages before PCM_START. If the START
> message cannot be allocated or sent, transfers may remain queued, and
> ALSA does not invoke the action undo callback for the failed trigger.
>=20
> Mark the stream stopped and disable transfers for every failed START
> path. Arm runtime->stop_operating so sync_stop releases pending I/O and
> prevents prepare, hw_params, or START retries until release succeeds.
>=20
> The stopped flag is shared with ACK callbacks that can run without the
> ALSA stream lock. Protect every stopped access with vss->lock. Read the
> pending message count under the same lock in open and hw_params. In
> sync_stop, decide whether RELEASE is needed and mark the stream stopped
> in one locked transition; leave it stopped when release or draining fails.
>=20
> Always cancel elapsed-period work in sync_stop, even when no RELEASE
> is needed.
>=20
> Fixes: da76e9f3e43a ("ALSA: virtio: PCM substream operators")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028025317.9245=
0-1-mynameisjune111@gmail.com?part=3D2

