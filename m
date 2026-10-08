Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A656A4C2273
	for <virtualization@lists.linux.dev>; Thu,  8 Oct 2026 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470983; cv=none; b=KmQVSK/G5fXJlfdIADS0r8KLtEFKMuS0KHNv4U+RV14gsXunNIK16+7TBCJt3oSD+vdPidrY96JUDsJuJcCaf+4WQODwdZV29k/wbWcXlj1uPxFpLpngLi3F+FmX61CkQsidkJ0lIIVNlfUyPKGjCnu1yh7tUfbnLMj5DUes3Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470983; c=relaxed/simple;
	bh=kXs4O0p/YPKklR7HQYjK4igi9xyN+E1DUQqxA9E9TgM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Yydahtsk5xw5mAtI/PaSdl75w8el2/cBopX+F44+H8yrgD+ctYtp/bXLVFsIPLZAmJS7uI2T4n++tuahd+k4lmu7iIVtRt+9VbyemrLaj07Gru+iubNCtbi7Jckm2NsooBn877/4E9LEeYXQuPDkHD+seYX4qtKzNRG8axPIb98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMclNnDC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMclNnDC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFEE51F000FF;
	Thu,  8 Oct 2026 14:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791470970;
	bh=ivgdeM9IjeZZ+WaSfVrqTkHPJxH6P62MDMa6JC6Qhcg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RMclNnDCRPcP3kJk6K5VO5LVThza4Tjxb+lhgcfjGj+Ysg87gR42ThGwcSOfLj6fe
	 XDrW7InRF4uuYEB6Vvh+aak0FV7u7dAUrZPiHvedh+gpGWVrdC5iCvD6qkHlHGMTGx
	 8tvoiVyODRGucO9k/61uK8YQ7PcpGQ5q+U7J4/jB2W8c3eYrtYvTaPwTrA5WWCX1F9
	 +quPDLr873q9rOfozA1fqZxNfC9T34bZae8fWbQumNEFbb+lTix2DdRgSJD+HgdikC
	 PfRe13jaCRESWfjZjiOwu9lxzfBqdoYbR37/Xu5oMjoWg9uNTF07fyqSCLbwOENHVt
	 nNGNFcqEknseQ==
Message-ID: <sashiko-outbox-164325@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] vsock: Fix memory leak in
 vmci_transport_recv_dgram_cb()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ilia Gavrilov" <Ilia.Gavrilov@infotecs.ru>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20261008144046.90853-1-Ilia.Gavrilov@infotecs.ru>
References: <20261008144046.90853-1-Ilia.Gavrilov@infotecs.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 14:49:29 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> During the closure of a datagram socket, the vmci_transport_recv_dgram_cb=
()
> function may be called, which will add the packets
> to the socket's backlog; then, after the receive queue is cleared,
> the __release_sock() function will move the packet back from the socket's
> backlog to the receive queue, which will lead to a memory leak.
>=20
> sock_close
>   __sock_release
>     __vsock_release
>       // take ownership by user-space
>       lock_sock_nested
>       sock_set_flag(sk, SOCK_DEAD)
>       vmci_transport_release
>                                       vmci_dispatch_dgs
>                                         vmci_datagram_invoke_guest_handler
> [ ... ]
> (linuxtesting.org) with Syzkaller.
>=20
> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008144046.9085=
3-1-Ilia.Gavrilov@infotecs.ru?part=3D1

