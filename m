Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC9437A83D
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 06:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791874179; cv=none; b=KTr4raFHwO6+dzCzmr8Q+Ke66sJ7i/phvZ3lt+DxA2BGRsg07cmaIHFQJjvjBB/DavBpHDekM4hC9JM2lvrvZKLU2iwFJ/k973ypulcr6nJl20AYoDC9s21Urs7C57UnpNcOMg71XxPQvgs8/HVsoDvecnday9qCfSosCBb3FCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791874179; c=relaxed/simple;
	bh=mAD7wDdVfMGHYbI0EQrUeQR4hYS39NV+liMJJkG79p8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=WuX66YEhvEF087TH8w4dI26wDIfc8AV1nrUgbsrEoQ03pwLlJ47CQry2pgmTXMRG7ly2K5oZjnuKLQminRonCCDGT+guyl44IRfk16MxXD+wk/ourTnNkWbVmcNlTfyEjo1TZak9AwVjhs9u1XRmitm+0c5Wi9bDywvrbhNj1Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEdutGZB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEdutGZB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59E41F000FF;
	Tue, 13 Oct 2026 06:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791874178;
	bh=mAD7wDdVfMGHYbI0EQrUeQR4hYS39NV+liMJJkG79p8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QEdutGZB10IJoLPYKeep0B2XGTqcqCeSVtUmenvBaOqJn526+MX+fvttQvkOtY6+D
	 qZ7qqRly8NUlV75BilaSbERBzBuWixe14H3imNG+xK6pG55VIyhRKccKJFw4c8UH+H
	 UsvYzpYTqfn7L56Rvi/gCiJyClo5Z0Tip6X/Xtzy4Q98+dUcIgUGk1Bmrq2nSYSU//
	 h7Q1YiD0AblxjBupjX3Tq1TXNYeQc7J9TwTUL5j/Fi2NnvIVQ5BnWRuzDu7hPcQa1u
	 vC1MOY2n/3Dg61zBjKnrBzWPJeywVcw+uBVNdeR3i3Na0d8nUYjviEWqDccLZJot42
	 0enihtYsUxjyA==
Message-ID: <sashiko-outbox-169136@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 3/4] vsock/virtio: coalesce RX write-space
 notifications in lock batches
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261013063112.168321-4-physicalmtea@gmail.com>
References: <20261013063112.168321-1-physicalmtea@gmail.com>
 <20261013063112.168321-4-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 06:49:37 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Each received packet updates peer credit and calls sk_write_space() when
> send space is available. A writer cannot use the newly advertised credit
> until the socket lock is released, so repeated callbacks within one lock
> batch cannot let it make progress sooner.
>=20
> For the callback installed by sock_init_data(), record one pending
> write-space notification and deliver it through the saved default callback
> before release_sock(). Save that callback when the AF_VSOCK socket is
> created because it is not visible to virtio_transport_common when built as
> a module.
>=20
> Keep only sockets using the saved callback eligible for batching. Sockets
> whose callback has been replaced, including sockmap sockets, retain their
> existing per-packet notification behavior. The psock marker checked by the
> batch admission path also excludes a socket before sockmap replaces this
> callback.
>=20
> Set the batch socket before processing its first packet so a batch ending
> on that packet cannot lose the notification.
>=20
> Packets outside the eligible STREAM/RW batch path retain per-packet
> notification behavior. The 64-packet and 64KB limits cap the packets whose
> notifications can be coalesced.
>=20
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013063112.1683=
21-1-physicalmtea@gmail.com?part=3D3

