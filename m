Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1044E36D6
	for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 12:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980117; cv=none; b=M5a3f1xO8oMaXZtgwpX5vRP21e6ND2p7YCzjY6OO1BoIigvegqTU9MhB6TlK+Axm0KvoTYRZOLL5rLG5FLOzyuGKVMjLbfFCGsgBiKpnSzKPB6RcKQGA83fmek7ydN3y3EXTic6ZzH/VMAS4n383DFPBhI4ehvYTX/S232cHins=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980117; c=relaxed/simple;
	bh=t0PGYDYtM0J/W3AkiY1gXRMI6QspeLsiBrOrPbIqG34=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=aTcP537qf3PeACRdhrn/o8YSumx4jdka1XZy3LD3387RRB264fL7HpGHYDDbrZFA8CYLPx7C7V5DiV6FO/Z3u/dtNzzo7Ny2wyNt3dkiTcVKUoxWU17GT7OSkI612NLykfEfH2zPof5gOUw3RjNCVUoP/K+4L8QNMRkb3D0DJGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnnGvmk3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnnGvmk3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D061F000FF;
	Wed, 14 Oct 2026 12:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791980116;
	bh=t0PGYDYtM0J/W3AkiY1gXRMI6QspeLsiBrOrPbIqG34=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FnnGvmk3DnhurNuysAqxpm6/b5HwQAuNG2eOTaT/YrTHqPFMdjXq2cLdOrb/CKiYu
	 ap92WTmcKp1vb2sS5NOAk1EfV7klRTO958qkb0V0SqevO0QS4UtshDQ26gljQw+X0E
	 TM4P0N/vvFMMYnVNQpKEEzKk5fA7nirwzCOY41VLdqiHAA3ZFd1cJlWzFfy6x8YxHD
	 ilUNZCoApbbfdk4Gy75ZDXb8hSHopXqf67tVscEUvQB2D6j50Km2AM8GMCcLYatE+T
	 DJbBH6aUpsPSDVQbOcmhH4IP9GwjLTdDRliIrw6r/ka0QAK4OoqzbfUHx/0pY40wbS
	 I0depdikR9Ljg==
Message-ID: <sashiko-outbox-171253@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 3/4] vsock/virtio: coalesce RX write-space
 notifications in lock batches
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261014115640.184286-4-physicalmtea@gmail.com>
References: <20261014115640.184286-1-physicalmtea@gmail.com>
 <20261014115640.184286-4-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 12:15:15 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Each received packet updates peer credit and may call sk_write_space().
> A writer cannot use that credit until the batch releases the socket lock,
> so one notification at batch finish is sufficient.
>=20
> Save the initial sk_write_space callback when the AF_VSOCK socket is
> created and require it to remain installed for batching. This lets the
> transport module deliver the deferred notification without referring to
> the unexported default callback. Sockets with replaced callbacks retain
> their per-packet behavior.
>=20
> Record the batch socket before processing its first packet so a batch that
> ends on that packet cannot lose the pending notification.
>=20
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014115640.1842=
86-1-physicalmtea@gmail.com?part=3D3

