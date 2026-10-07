Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D573859F5
	for <virtualization@lists.linux.dev>; Wed,  7 Oct 2026 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791384825; cv=none; b=G5ojhT7I7t287RScm7A4/uRdks1NULA5jFQaRjH0s0IbRp0tg/vmg6MS2ubpJdflU15Tch6aVFYZZ/aH7HQzJgAhxu596tRBggpx+hwLXyr/Tc+wosTFXkM1CpHKd4rCo5vwONCol8g5pkkYADHBlz9A+8wnnh29o7NQRkWe7Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791384825; c=relaxed/simple;
	bh=Rh1vDgGaywCDQTa5F7V5r7VRzrfjVzOTLR2OpEUNQCM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=YB6mOrp8nVJqi6pLTaa1mMsRajb1KHKtCvkw6Tx6aTN6ghsjxxg5M6aZIdBEy0Qu+jPEQMaxOIJ09eSwJZvR1VFcl5Tc8u70pTK5HSYos2gm7jJSvJCalfVYRacMhIYKPpEdD3QqOOth8Z2UkMbBSCqwVEArSjK12geTS7F2Y/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ul7sbb2X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ul7sbb2X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CA61F00893;
	Wed,  7 Oct 2026 14:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791384819;
	bh=h4+VFH5AgSNt7YORPCZkhhDM7jvAd9WWtLFdUi5oJzY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ul7sbb2XFxxt37SZNCmhhSLMZau1J1whOzMWPDtxvTt4jVO2q2OawRd6AipVcJ8ZF
	 elcLSACKdBNi5AIMP4S05S/I7t56d+0Br+vY0BFc9rrufoFiVNI1qGeRJwTSDbEdUz
	 9roXDRwNApX63/t6P0MdFK4j8YbWLOxllYKZgyp89bPQcjMvufktS4xmebGugw0yo4
	 W6XpLCrDN5dLjPQ/UjA9pYIWvYHjkB0yjWJYafsF5jh4gAJ5IiI8VSOOg94NDyCQge
	 mk2B9KzrekzuZW6kn4XXM4vkHc4BTZIM2ljncbudD6VpIMLsVBSMNk85ULTbRKwAF1
	 4oer9WRfTcaKQ==
Message-ID: <sashiko-outbox-163127@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] vsock: Fix memory leak in
 vmci_transport_recv_dgram_cb()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ilia Gavrilov" <Ilia.Gavrilov@infotecs.ru>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20261007143716.1984702-1-Ilia.Gavrilov@infotecs.ru>
References: <20261007143716.1984702-1-Ilia.Gavrilov@infotecs.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 14:53:39 +0000
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
> Found by InfoTeCS on behalf of Linux Verification Center
> (linuxtesting.org) with Syzkaller.
>=20
> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
> Signed-off-by: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007143716.1984=
702-1-Ilia.Gavrilov@infotecs.ru?part=3D1

