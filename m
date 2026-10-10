Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C2B4A7CA0;
	Sat, 10 Oct 2026 14:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791643164; cv=none; b=AX9j45cdoAnT/vuLV8PuQzMf/OPa2b1iynOo1REJPERTkjBseI1wra7Sp4RzDvRYzH4AZzU1dWXE5wgjZaLAZR8ZokfqvSysvJMeva11E2GE65sFJ6Jb0YNbrWp8LaMpzrGGJE4x4N72xseGep8QmEqgm6O0VRUP5qCyh/M7nTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791643164; c=relaxed/simple;
	bh=C5hXaDhAmWlisDL6H7tR6Gl7cwP6Avw0HfsT17WM0tw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=uvXUpCiKxMQGOtIxJyMhoB9RlpfQs81zQD4pQfJzlFQS5cLkXCf9WOoOCBnJv6vmcnFqOJKzo+lNAy7mAN1dW8UX8OGAuCagVIILpmt0nQ/HeYz61cbNi81HyTsiVCR0XSK8RdbfJotouyoAxvSMxnOVFqGX+TjgeSQX2BBCxTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mh4x5UL7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mh4x5UL7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805AE1F000FF;
	Sat, 10 Oct 2026 14:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791643162;
	bh=C5hXaDhAmWlisDL6H7tR6Gl7cwP6Avw0HfsT17WM0tw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mh4x5UL7SHUdWhzZizxSKY24mYK/D6QJuXUJHfDDLu22nHwZIHOvXR0m0YPdSZiz+
	 61CCxY8LjtH84b1BG7mAjo2qQbw+bTACWUAuDaY9PoSm+NTo6J4+jxrlyJ9IxoIr8Y
	 fr6x6Y3R4uwu3NuiHfqlfRJplSwrKwniNfY50B/4JW0tcC4bIWX3kl6K4mjVgTAgS/
	 Qg5+W4cEPeblNQkw/k0pv/W2ZjOZauNnAd9hVS2p+/Ic30dM9MIuq3SaHuejOW1i6H
	 jcvK9esU2V6ILJ1IjgdSqz50uYrzU4d0pPjy5k29jH8PrUCtew5nVxKAH6n0NhLHsr
	 y0WdefmPkeAiw==
Message-ID: <sashiko-outbox-166652@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 5/5] vsock/virtio: defer RX readable
 notifications until batch unlock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: bpf@vger.kernel.org, "Eugenio Perez" <eperezma@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20261010142247.99223-6-physicalmtea@gmail.com>
References: <20261010142247.99223-1-physicalmtea@gmail.com>
 <20261010142247.99223-6-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 14:39:22 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> An RX batch can make a socket readable while the worker still owns its
> socket lock. Waking a reader at that point can make it immediately wait
> for the same lock.
>=20
> For the callback installed by sock_init_data(), record when the existing
> low-watermark condition is met and issue one notification after the batch
> releases the lock. Save the initial sock_def_readable() callback when the
> AF_VSOCK socket is created because virtio_transport_common can be built as
> a module and cannot refer to that unexported symbol directly.
>=20
> When sk_data_ready or sk_write_space no longer matches that initial
> callback, pass queued skbs to the current callback one skb at a time. The
> handoff stops if the callback is the default again or the queue does not
> shrink. After 64 successful callbacks, queue another bounded handoff if
> data remains. vsock_bpf_update_proto() schedules the same handoff so an
> attach or detach outside the worker still drains skbs already queued.
>=20
> Always deliver a coalesced write-space event to the saved default callback
> before sampling the callback state. A current replacement is invoked by
> the handoff as well, so a callback change cannot hide the native writer
> wakeup or pending sockmap work.
>=20
> Sampling at batch finish takes sk_callback_lock once. The per-packet fast
> path still uses READ_ONCE() and does not take that lock. Control packets,
> state transitions, transport changes and non-batched sockets keep their
> existing behavior.
>=20
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010142247.9922=
3-1-physicalmtea@gmail.com?part=3D5

