Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794203332;
	b=kslODk6Ig8vp+i8pvRopp3/hmmBJ4MOXXmeYdtW1cuDlhOvTWJN4bEbkGRhc3GklcaOT
	 XaroJFG12XWUq4T6xThqHxjB6iqqLj0227TluUeveBFhEclP3JRVLiY2aPaSLD12UTFPM
	 4pQSrleV69efd52+tIAUqQLzWL6cQ9l3uQb/DkKsV9asWP6CqhV1g0/ccNVbHimWDOLRe
	 WbLL7cnhMzMKbkxe1HfObLGCkBEWYfDTiPIpVLd1Clb7AMlztd8rOVz+a58jwJCvu8j8U
	 dTtQ7S5zF93bfoYiYtgZvnFuGvvv8w2+G8noghsHAwVFym6HwMEHQPBjpoFjU9dBSow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794203332;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KCSKoKLr9Nyhc8TR98gddvGgMCAz3yAQmVUM53lXs0M=;
	b=zGwZF2/YP6R+tj8h8Rfu3qu4lQrQIYKKornon1n0C82QbwLy8Fbw4V5ROu7/g3a24bqn
	 N0Al7RJw3KiZijYESPxLOe2WogXZbeTT2KLjG7Q7Iy4YreNeNtgGeAUe2U+5MC+/aw+ps
	 WauXYGJTLluVZWmgsOYCrU4vSWiW+9riK/q4BTTtGrP3idJonYVdgoOGMbdlvmTCpgKVN
	 b4Yqzwrq8kIi0kWczRCILord0CE7zL8vrP+X1gdcvFWe8+ZxhmpBuUl1txijY3K906uaH
	 FIYAbDrMkTuFkLtegOomaqj2a69u02BVx6ntxNYR5DttB6HFy2Wb9tziV9sUPoKJPvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dUmztV9z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF24606A321
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 05:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dUmztV9z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8151F0089F;
	Mon,  9 Nov 2026 05:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794203331;
	bh=KCSKoKLr9Nyhc8TR98gddvGgMCAz3yAQmVUM53lXs0M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dUmztV9znZ5ZUpRees9dYMbyXUmOvUG9x7i5RyZ5VKS6JV7rvTc/u8Q99XAFLXUx4
	 jIuW1JYbLIYORdLHt4ZXk8zR9Yw/XD43nbODf0ccAeIUdUoHfhGjTjp9T0DPwZeHuz
	 VTlnAv3QFBApXJbEJ7i1cEs/El4MOq2Iei5oLcBhkASm3llwwulH7lbBnblDjtT/fv
	 qisfD+hgP0BsfM9YefIPvTcxupNheeuUjHXWHKzuNKkrTi3b5p+NRq/JL37d46PyMw
	 bh106ANTw5ffwrf43+mi+bvhQzfqHFTR9N3G1o9yMAky12vF86qk+HnRRgWbEwqf8g
	 ZcD+ofcWZWc8A==
Message-ID: <sashiko-outbox-204457@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v22 07/13] ALSA: virtio: Retain queued messages through
 device reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261109051618.22506-8-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
 <20261109051618.22506-1-mynameisjune111@gmail.com>
 <20261109051618.22506-8-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 05:48:51 +0000
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
> Track successful virtqueue initialization so teardown and failed restore
> cleanup call del_vqs() only for an initialized queue set.
>=20
> Fixes: 9d45e514da88 ("ALSA: virtio: handling control messages")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109051618.2250=
6-1-mynameisjune111@gmail.com?part=3D7

