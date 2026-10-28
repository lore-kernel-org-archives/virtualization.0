Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793211278;
	b=wIz6bN3BPqZ93GCC5bpImz+WmV4styNNBjkDfgSi5kNOG/DN86D6w+QsnN5xeh7TXTRa
	 XMMDNuEe1OAE1wpqnyRzsKIQX1p0jRTu7rIcZI+UDx5yGVZeqmp41CbORdjg22lGtSJOj
	 49CTBb1KfMaHDl8m6tf5K3Gj02xW0m9kFJ6hGgNhtmCc3u1vRaqkbyIfzgNKoGb6+OZs3
	 ZIGZm5vuend3Kj2UY7+Bs5P8S7yCiC8ADaFD0MF93BPl4TIhtxbOH/rR1HBy2hwF2GuqX
	 bYWsv1RnSN7DXXwVHqwVbXmXdw8MYZQxxAfiU89gV5eBX+jmDlhCt0xX5lUbNlFz4Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793211278;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3ctwXeBH+HCyIUQY24sEXAoX5AjSay9UGbkxqfaSBZo=;
	b=Wu7CH9TCykDa8Ntter5776PnUOAmPPsjYByQigY9vF0zmWdz7I0/rcAmLU62GtCkAgCB
	 xGKoMLAu+kihGy1b6ZP5g7B56UA5/XDc8jPegv3vU+hdKHgYyrt2+Ywqjc5hNn9XQdOF5
	 wq1FhxbQvZEtSFtHlGAhlvnCaSbLLBEFHG2h9tRTGdKVunP51MbZqeGoL75ba7ZXOPOqH
	 jov9LVqnsHAC+qysDPCfdx7pqGNHIt1EypNThdG5jBO3hS4cF1V7zWQ3/bEq8PZDeVr5A
	 y74Kxc7jyiqRP7LAdOlOFF8nyRFLHt4/iSSruY+4nKOokXl11LloWYOZawp8WCKbYhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GNGH2EaQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492E260A2614
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 18:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GNGH2EaQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28131F01829;
	Wed, 28 Oct 2026 18:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793211278;
	bh=3ctwXeBH+HCyIUQY24sEXAoX5AjSay9UGbkxqfaSBZo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GNGH2EaQAaNqF7mexUgdQ+uJVkGnTfV+V3zCjibjQKtv+0sJeALA1olrk21GLHjYf
	 6GIRNmn1qp3TEYutqVL3DrM9+TXjQGauSaVGi/uy9HB7PTTVuUqSKSn0T/qufj4mnW
	 wYt5gE+cCsmCPtvh3Kw/Dzb0OTWgJ7CpCRmdY3dk1AmdUOwcqU2V7pLJbmoKxMaO4U
	 TffXzKfdMYrUtrrVct4rVM+Mm6DFHi2FabGf4I4Sf/dtuaqY/1BNs3wPHF+Ax7+Zul
	 0ZxUubU9HPZ56iWKCx4+FUXcJRiOp032i4KTn563gFg3flXxpFcw+P+R1ek4JhU9o7
	 R8Oc6Mkq9ZyJA==
Message-ID: <sashiko-outbox-188271@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 2/2] vsock/bpf: fix zero-length, MSG_OOB and
 MSG_ERRQUEUE reads in recvmsg
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jerome Mohm" <jrmmhm.kernel@eldare.de>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261028-kbh3-1-022-fix-v2-v3-2-bc0752b2d3db@eldare.de>
References: <20261028-kbh3-1-022-fix-v2-v3-0-bc0752b2d3db@eldare.de>
 <20261028-kbh3-1-022-fix-v2-v3-2-bc0752b2d3db@eldare.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 18:14:35 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Jerome Mohm <jrmmhm.kernel@eldare.de>
>=20
> vsock_bpf_recvmsg() sends every read that cannot be served from the
> transport's own queue through sk_msg_recvmsg() and its wait loop. Three
> kinds of read do not fit that path:
>=20
>  - len =3D=3D 0: with data queued in the psock ingress queue (for example
>    after an SK_PASS verdict), sk_msg_recvmsg() copies nothing and
>    returns 0, and the wait reports data ready at once, so the loop spins
>    with lock_sock() held. The vsock delivery worker then blocks on the
>    same lock and all rx on the transport stops (hung-task).
>    tcp_bpf, udp_bpf and unix_bpf return 0 early, and
>    __vsock_connectible_recvmsg() handles len =3D=3D 0 too.
>=20
>  - MSG_ERRQUEUE: the read only reaches sock_recv_errqueue() when the
> [ ... ]
> sockmap_basic and the 240 AF_VSOCK cases of sockmap_redir).
>=20
> Fixes: 634f1a7110b4 ("vsock: support sockmap")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-kbh3-1-022=
-fix-v2-v3-0-bc0752b2d3db@eldare.de?part=3D2

