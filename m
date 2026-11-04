Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793762501;
	b=JqOo/b8Bf2SPFlpnJJV/G44LC6mUsy/7gWiMccF1WBz9UnmVya+2tkrr+BQv7VAKdtaI
	 QORKLsqZ66osRb82nPIvzxeJzdoDCcPFNovyAhlkZ/HSfHZz3cl6sBLMZj/lZ+aXYN4WI
	 zjXBGYpCQRNuKO7taJ2Qfq8LIrlphSZMg+3xOI69Z371aPgmOEtCPrAY/CWz+ESY6H+Rv
	 1qALReXtGFIQNaNuZ0Xd8ClA1W5cRo3757MvsSx6Goj99YqZcd3JuShE99kef+W+THvKq
	 V6aNZo3QqngPsEXqx4JpILo5+hal5VuSgYZs7dAI3qzFMhPJP+9dFlYLbsKXfrATGUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793762501;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=R3G1odNlcjw0ee6Tp0l3IRuuQ2xDaqr/lEA9EJTb4Fc=;
	b=XnUdYNKofbr6sRwzvNJu3T+G7CGUOYBorkC0oOJAO33c4kpMdEoGLbQkfLQfk+nWWQNn
	 lm7NLMj1eHfkxNpYp4TA3sUUOzKVYzuv3XTF3c9WJjLBffGKCZ99p9pgmmbR+zJf4JtF2
	 /0rM2nByhZcfVOhOYmjXf+rpVpCHhOaRixEVnAl8HnukjMkH3vGMTRMl8Jf1GOljUu+ky
	 AUtctmJTYkhp7O37cbl0R4Ak3RI0WUe9n0er++iXwQ+zpPX0CgvY9Bk1BELK39cHS6QZJ
	 //k9j242WpbfHPPsxXfa9N5KRXA82lP+v+ESvkgT9eRvfAR5r/W1up/DvVGOor3AcUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QvME1wAo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA00606A31B
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 03:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QvME1wAo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BD01F000C1;
	Wed,  4 Nov 2026 03:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793762500;
	bh=R3G1odNlcjw0ee6Tp0l3IRuuQ2xDaqr/lEA9EJTb4Fc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QvME1wAo4jBE1V9AkTXq5frnE/fDqGJJNVUXGYoACh5EM6qNc418jU8813hIE4u+e
	 KHPEbvMmkhDy9r+738Esz3Q1a3o1LLEglF0z+6cnvFQIcjck4SLGFxIPr2nNtsbiOI
	 hUeQgabJg3/r4bdbDrE5t+j+K0uUMb7lIw1O3kbpiQLm1J9qT0dpcJBShZV4EV/X2g
	 w3yPiWrBdYeaOzRXc6ceTJHRsFULrs0eH4cu1vZD4GHOsN3pU7PwoFFKq3S+NjxsRN
	 Bp49VKqjRYF5MOo6jjlT8IVG+et6/7u5Szn7AKFcrJMajg5KaP1ilunj4Xwgl3FN/S
	 DXbzJ1f+C2P6A==
Message-ID: <sashiko-outbox-196594@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 06/12] ALSA: virtio: Retain queued messages through
 device reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261104021745.57733-7-mynameisjune111@gmail.com>
References: <20261104021745.57733-1-mynameisjune111@gmail.com>
 <20261104021745.57733-7-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:21:39 +0000
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
> Clear each queue wrapper inside the same critical section that detaches
> its buffers. Check the callback's queue identity under the wrapper lock
> for PCM, control and event queues. This makes queue retirement explicit
> through teardown and restore. A forced callback test passed on both
> versions; the proposed detached-ring IRQ failure was not reproduced on
> the tested PCI transport.
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
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104021745.5773=
3-1-mynameisjune111@gmail.com?part=3D6

