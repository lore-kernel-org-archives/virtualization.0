Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41FD2F28FF;
	Wed, 16 Sep 2026 13:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789564561; cv=none; b=ncajiQI0H+tHeFaYmbui4Oik0/2w/nwbEiNGaJ6myL9AmRDl9sSWP3SIJxkTcA9xlchC0oDCYruZ0SR9LZu9PFVgvQTDDZv4VWMu5N1S3/k5W++XLgjkciBhgkwYDdo4qdpoJyZabL+SFYNqTljGsXwmNMlZ7dX3/dp+fwxlEuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789564561; c=relaxed/simple;
	bh=Lc0rLf19IsM8R3K7ZLPMFRu3XLASZ4jE6WD+1eHBW0Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kJ1FOtZeh8q8tz0a+Czp+R2HOnkRQpecprDAsQxXCBcBYyGfug+R3eZpYgPb0cQHSzUKLqSMmhHo9jYWBbvPljMskfPWIKAwFNJqFEqYZzbuiac33n0z/HFwj5qu9tJceHWPb854kx7rSXKdcNK+rgBgm93DmuHPVvg1DuNvlfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUMMVdu1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUMMVdu1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D9B1F00898;
	Wed, 16 Sep 2026 13:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789564559;
	bh=xYDFsT51uAGXAOJoe1gXsDtdZ1wy1F5AbNcqAArzh9E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XUMMVdu15dqYZ94O34/bjyFuaFLXRMNJrVCSkxJ3g7VKH533a5gwxtOi3v+42f1/n
	 9NPyHPEpSriyglFKJV2914L5qpdqUQRIbhzwckevVbolqJD3uF4G2ivawST8+fbBVX
	 JQyAaj6wpEotWHB70FeO6R64aEy5OjO2G7tA7ZmQf8uSK6tV/41/jz049WMlnGnJ1l
	 xkHVX9P2SlzmA5klyYBCkOOtmxL7qNTsqG+Vie+KMNOPrGyr2GJwRHFcDZ1uextpRL
	 GdGgM0QXjBaPm2BlUrDtw0kzGpgqPLp1jXsg78ziyJcv5q/O6GKNiWIsuKB1IfRlqh
	 bqiyUtkZyZHPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 2/5] vsock/virtio: Streamline socket reset on
 transport/PM event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Luczaj" <mhal@rbox.co>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20260915-vsock-connect-reset-closing-v2-2-a1d9abb472f7@rbox.co>
References: <20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7@rbox.co>
 <20260915-vsock-connect-reset-closing-v2-2-a1d9abb472f7@rbox.co>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 13:15:58 +0000
Message-Id: <20260916131559.28D9B1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] vsock: lost peer_shutdown update in lockless reset
--

commit c52d0f36e0857217fee2a98454aaab9edf069cc3
Author: Michal Luczaj <mhal@rbox.co>

vsock/virtio: Streamline socket reset on transport/PM event

This commit streamlines socket resets on transport or power management
events by setting SHUTDOWN_MASK in virtio_vsock_reset_sock(). It aligns
the virtio transport with similar behavior in vhost and VMCI.

> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_tran=
sport.c
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c

[ ... ]

>  static void virtio_vsock_reset_sock(struct sock *sk)
>  {
> +	struct vsock_sock *vsk =3D vsock_sk(sk);
> +
>  	/* vmci_transport.c doesn't take sk_lock here either.  At least we're
>  	 * under vsock_table_lock so the sock cannot disappear while we're
>  	 * executing.
>  	 */
> =20
> +	vsk->peer_shutdown =3D SHUTDOWN_MASK;

[Severity: Medium]
Could this lockless assignment race with the lock-protected read-modify-wri=
te
in the RX path?

Looking at virtio_transport_recv_connected(), it processes
VIRTIO_VSOCK_OP_SHUTDOWN while holding sk_lock. It reads vsk->peer_shutdown
via READ_ONCE(), applies a bitwise OR (such as peer_shutdown |=3D RCV_SHUTD=
OWN),
and writes it back with WRITE_ONCE().

If the lockless assignment here occurs between the RX thread's read and
write, could the RX thread overwrite SHUTDOWN_MASK with its local value,
dropping the SEND_SHUTDOWN state?

If this lost update occurs, it seems the socket would lose its full shutdown
state. Would this cause vsock_poll() to miss setting EPOLLHUP and EPOLLRDHUP
flags, breaking API expectations?

Additionally, might this plain write trigger KCSAN data race warnings again=
st
concurrent READ_ONCE() calls?

>  	sk->sk_state =3D TCP_CLOSE;
>  	sk->sk_err =3D ECONNRESET;
>  	sk_error_report(sk);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-vsock-conn=
ect-reset-closing-v2-0-a1d9abb472f7@rbox.co?part=3D2
