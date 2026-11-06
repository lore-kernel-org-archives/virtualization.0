Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957360;
	b=bwJYVml8GnjOE+Iq4tB7IZj5u8uWpaX2JmsRe/bRDJvzYn0WJ6eyByyAdcvgGDueeAq8
	 BLU1aDdi332e4+D5p4cnfieyJhZCNqqoBOy8qCgIxA44cXIwfy9bpxOZBP1WnMNCKeqaF
	 hs299TkAiS1zUcTBGhuzJl1Ihvg4j7rzVkP5vaCv/Wqq5y54fQQ7/ZZ19DAnDYfKwH+os
	 HpFeSoaspzAjoXrgbqgk1IxBlEv0ya+FAObSmiUhtrWWYHzVa8vvgI/q3ZTT1geqCCDGk
	 dQlUyIkz51EElSQWgsr1ibGjYGY7cCghmkaAqOulo5hq6lgCeMLvJZ0t3nSR4AgXZ+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957360;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2OiJxRtMGB983ufmn6Inj9dQCD2W2lpW+ZOvblbLPHI=;
	b=nm4KewSiIDBqP/VbEoBqWyBYuMudcFjPLeMuGrtWl3NGvD5nDu1L2Rnks8LeNHx6Ivtq
	 t2CymRgGQJGSsQdV0HGgUVkNtCi7Lff2//Jm2NjKMUavumCuTC+hpbiX5n2Z752sLu6Om
	 IUWJH6eM417yeVoF/Fs00ql5b2AzjOz2JgPTIe9kO6SO4AzXbC+nhukTU9JiX07xxBYIx
	 8EZ2N3gUUpQ5824X84tAvMzRKYIgtDjamZwSG5DGEKLQyMoSPjZq3ZODrg3rs5uaOg60/
	 vwCQg9CU1F2UvnCkdI7btsTKXzwy6aHPtpUAzgLdPbp4uATOBTfybkgBEUdLF/moq4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nsp7e1Gs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD56E606A330
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 09:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nsp7e1Gs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A191F008A3;
	Fri,  6 Nov 2026 09:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793957359;
	bh=2OiJxRtMGB983ufmn6Inj9dQCD2W2lpW+ZOvblbLPHI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nsp7e1Gs/XqvfQ9MLL7Vgn07JvVS9KRqzizid9Emc0bQLGbvykJsEf4jSKT3+VxUd
	 /vm2891+Z68RHvuhCyYflQ73ZMXSSxL59iC33r9UR5BiyvORxDL4R2Fj0Bd7FYTFdk
	 5sufLjc/gNs3rNIDufIz51y1VKkJGyOrIRiGAMW/AuqsWyPIw8JKAr8iVg3QA1Zbuv
	 Wy+bZZwTg6L7mG27tR72Az4ZHJYdOp4N73YrsRqzfDslYiydug5eb8jiPdCQzbD+fd
	 ysMMryJaBHaTu3DMdqWLmBo9KH0fIWjzQ6pa606TR0ooel0wmfr4FbvSUlHS4xBY9M
	 EbqrrhTe6y++g==
Message-ID: <sashiko-outbox-201109@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] virtio_console: fix buffer ownership and unplug
 races in the read path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yaohan Li" <shunsheng1218@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261106091739.1334178-1-shunsheng1218@gmail.com>
References: <20261106091739.1334178-1-shunsheng1218@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 09:29:17 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The read path hands port buffers to readers without any ownership
> protocol.  Two threads sharing one file descriptor can both pick up
> port->inbuf, copy from it concurrently and requeue it twice, and an
> input virtqueue callback prefetching the next buffer can drop the
> remainder a reader is about to put back.  During port unplug a
> reader can also call add_inbuf() on a virtqueue that is being torn
> down (KASAN: slab-use-after-free in virtqueue_get_buf_ctx), or
> requeue a buffer nobody will free anymore.  The input virtqueue
> callback itself can run past find_port_by_vq() into port->portdev
> and the virtqueue after unplug_port() has cleared them.
>=20
> Track buffer ownership explicitly:
>=20
> - fill_readbuf() claims port->inbuf under inbuf_lock and owns it
>   exclusively across the unlocked copy.  port_read_snapshot() and
> [ ... ]
> DMA buffer path is covered by code inspection of the claim, deferred
> free and reclaim ordering, not by a runtime test.
>=20
> Fixes: 203baab8ba319 ("virtio: console: Introduce function to hand off da=
ta from host to readers")
> Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106091739.1334=
178-1-shunsheng1218@gmail.com?part=3D1

