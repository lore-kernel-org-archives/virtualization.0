Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793847754;
	b=uikNErZmmPjfmpTxOdSAs6pKEIfmJGDwaDJAXH8Wx3PJLtBZuhDgDOuLwc8+HkhSSJF5
	 kedOYk/8jg6Kgh+6M7ynKq1af1rS0kxLfKUWx32jA1yx94iQZAVE1YUc41CaL2C+4WTnO
	 xVx7mm4kGMkSZdjPReKteWSdtCLfsMG5WHfkH62lzowOpHa4E0ch8n6ceQ+j++eKZo/nW
	 lY16oRGkBp9gX6tGZ5omF8zHDuMmCHiDwzipS8VyzMk+MHECtKo6XsuRfzLHYcwsgetvx
	 W+2GFX7T4xShmMr1soTsDfNzqNrZLtM+UOXVz6pMFMQsBkOn0SE+9GII3X0qTWsZYAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793847754;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IUhDd6MGNCZQt8wLQjWAix4GexaiY2w4BL0lPeBEhKM=;
	b=TnaRWrEFi7NzkthGrFqN4qVoauqzbzqSjS7WsuZmWPuzCtI/wjxBJKmYbfAsEeXgm5fb
	 7ZhI1qTp+tKhHJfKg+6aHVqoA79FprUGOPEUSjgVmyPQojBdnvBCxWU6h3HHJPaPt8aIM
	 DqoWWa7SH1PVgaypkXKXNWeyJnXYraienrPjX5l1Y+cbE2ZtWUgx6R1dS8hxdlKk7WTDP
	 PiSP8C644B4DmeyJNVl7ebA63Ta6DWWmGRDBQOieK3CLSS74jzEYM4sHjfwbH5DN3/+fS
	 1CCp+VZ0HfxuJYz0jaf+E+95+A1ANfwdswfcq831Tsk/IHfKlFZPwbiG18B8ayzeb4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kjv/7wTJ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6A1606A326
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 03:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kjv/7wTJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10EDB1F000C1;
	Thu,  5 Nov 2026 03:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793847753;
	bh=IUhDd6MGNCZQt8wLQjWAix4GexaiY2w4BL0lPeBEhKM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kjv/7wTJqdIjMT5OcOoelAqXKkds65fw+27+NR2dzUnX9UFSJMcmA4EGLMwuNkgO6
	 9YZcR+28YWgPH+Roa0P/drcZklVR/k8wpeze8/kUKGRlKMeC+9huMlOe1hXHjcvFEq
	 l0lzWxeHEz/lkDqXsbXb3AdVS98lCqNcHmydKCP0vltQFoXAY5vCd8NCvbl027jeaF
	 OJpprR7X8e+n/vdCAVSOq+AQj8ATliGwpZMmrr4T9J7ERsRD+kuqGI/3rFLrv/El/e
	 iasU1cPDi+cYvbF3CxC+/HiTJ+l2bVUhv1Y+eV4EkCc0sXbwX4dXQJfAx+QlZ4UHIA
	 rMuPxJ6nj1tog==
Message-ID: <sashiko-outbox-198499@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 06/12] ALSA: virtio: Retain queued messages through
 device reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105023140.18373-7-mynameisjune111@gmail.com>
References: <20261105023140.18373-1-mynameisjune111@gmail.com>
 <20261105023140.18373-7-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 03:02:32 +0000
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
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105023140.1837=
3-1-mynameisjune111@gmail.com?part=3D6

