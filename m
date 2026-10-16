Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90530485CF9
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 13:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157787; cv=none; b=caqDgzJesYpHxYMJHNlKfLlPgyJ5HihlZpUzL2a/bPJuW1iRJTVm5idO/Ex6/rtkq0671bqYSrIxqipIciZ2vvqBbtZU4mJRneYnEmBTwRDMm11AggUrYc6oYucH2bosJleDelwIYK6tutoiT538hcIF/zWXCvdhlwdgQ8ooIds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157787; c=relaxed/simple;
	bh=CUffIYrZJx6/gDQHKXj6RYHLMijC/MX4992cnbA1n+s=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=hl2loDRU0RHaEnrjHPr4kZVJY6/TMw8sVJxTuuiAfZemRVbOV5y/EsXlUozUKJEsOPZX9YHOvpz+Q5PBUPl5ac9M+VM4g9aHmDHEV1yuqu+py0YUjjXRv0239DyRsdHCvc6Uh2/EvsDgSFS/ibnoyxZ7JfA++NYGEXf68HS39XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ld8Jm27W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ld8Jm27W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127D01F000C6;
	Fri, 16 Oct 2026 13:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792157786;
	bh=CUffIYrZJx6/gDQHKXj6RYHLMijC/MX4992cnbA1n+s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ld8Jm27WSFL+/wxPSrKz7bhLJTfkIEKcy8CF9ObuUrWUVp6QmZrLV2I6LaCjHL2xo
	 JwzkAqm6YvqVBF2x07HOtbkhf4BxPeLwAbitD4QBcKzYlq6YOxwJZCszAuANgQKwOG
	 d4l0y8DVJCda+zarIAXx/FASnUoH8Ouq3aJWilx8ZA0TGXBmeKc28lipFapAhjC7os
	 yJ9lI49zTxm8eot5MWLc/iRn52QWbTuyr+IGYXYMHefP2pE0wGrqUA9nFJM8Wxo7n/
	 xXF6jRJwAV54PuWre4b9gqm10YqRZ11ihr6JMwjENO9m5B0tNSDUxotjCEA4A8XsxM
	 cBx+bFggn49VQ==
Message-ID: <sashiko-outbox-174386@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 2/3] vsock: support SO_INQ on stream sockets
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Carlier" <devnexen@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261016132716.272018-3-devnexen@gmail.com>
References: <20261016132716.272018-1-devnexen@gmail.com>
 <20261016132716.272018-3-devnexen@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 13:36:25 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> SO_INQ makes recvmsg() return the bytes left in the receive queue in an
> SCM_INQ cmsg, saving a SIOCINQ call per receive. AF_UNIX stream sockets
> support it, AF_VSOCK fails with ENOPROTOOPT.
>=20
> Add it for SOCK_STREAM, reusing the hint already computed for io_uring.
> As with TCP_INQ, 1 is reported once the stream is finished so the caller
> reads again and sees EOF, and accepted sockets inherit the setting from
> the listener. No cmsg is sent when the transport cannot report the queue
> length.
>=20
> SOCK_SEQPACKET is refused, as on AF_UNIX: its transport callback counts
> messages, not bytes.
>=20
> Signed-off-by: David Carlier <devnexen@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016132716.2720=
18-1-devnexen@gmail.com?part=3D2

