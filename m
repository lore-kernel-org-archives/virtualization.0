Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794873184;
	b=HBiPib7KAmFb/I+fJD2+lj06eid335v/RPrT5vfHld59gDds6vhskDBFdDE14YyHQ7Dp
	 Tt4pHKwGopxSVV6qwzGX8s7lJb1pK+tLIhCR4yQ8R5u6hHRkKfOIq3iDmARc57l8aW74a
	 OtKjyjF1m+zYFeT/fPHdEdqwL9nlfaxYK8Wf665vLa5yrubd1kAz2lry0ovGgbtxboHjK
	 jxH+X3ufjZDkNjz8MgOPvQtCnuSh/OiOx6HhHU1tWA2S/GGBKga9gU2fQtu459eGzpqZq
	 IVmvteCEni8jlZRm+QxwWikMfaqttF8vLxCsAWP3bM6r4a0tT2WyJs905pHzrB4lHAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794873184;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=esXfWMrnsXJWQm2rmAb/6+XsSAi/41B+G873udBcS8I=;
	b=Eef/B7R9vM8gW5zKsVNtbMEzQqlbechvXLDA6xvTlNxMyxrOK6cRdLryR6C7XE/0uLhD
	 8FPqEkCQQ/zG1G63pPfPJMKZNDu2w8IK1csTBYZX3H+TCetLc8INuAoCDH4TYqCcLKX6j
	 fqyBXitGxzuDhfvNImiRZM5oEgbKHzFVhMIl7Hi+lOIZEBNuWYYMOpleW2orkfbfj/E0c
	 lDrCxxsCqZ9GskTx5QktTBIykdsPmfO+OJ5EOGiYygh/dAnyQHzKSMLQf3/Z2fdxvj1jN
	 DyHF9Ubt2Ahy8qjc3jCG+s9RNl0TrMidGZAHohO8bBxx9aQjmrHrB5kh+GqccmRb0ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZRLA22ls;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DA0606A32F
	for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 23:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZRLA22ls
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30101F000C4;
	Mon, 16 Nov 2026 23:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794873183;
	bh=esXfWMrnsXJWQm2rmAb/6+XsSAi/41B+G873udBcS8I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZRLA22lsRX+xW0xLNgnrorHel7o2pXZ02leTQJ0jQcpWfmZpOnimENb/R2YtQ/Ntx
	 kREXay0hoavvUa1ukwMERWhmWr83/6gCDj6l/fMGd3eOrMTnKQSAJ1JF+17pPejdZ1
	 Xu0U2KMXFDYm3AVImowmepU22Dk3HcudWzjVCM02aaoxGBncwAZeHoTWr5ENsDeIF4
	 ihNBmLUu+n2tf6xKAWlZyspU9r3iai3HqozAilVQsNtlUAFLN2ZLDlddl84ZxPwBkG
	 kBOTmp6nzv2/BhlNJsDw0nKBJpelGJ67VDDAPGliYRzHn2zheaSTQ7Gt0+9QttXSfu
	 MQkEePRp0ef8A==
Message-ID: <sashiko-outbox-217935@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] vsock: only deliver taps to namespaces that can
 reach the device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261116-vsock-tap-net-v1-1-7e24f45adad3@meta.com>
References: <20261116-vsock-tap-net-v1-1-7e24f45adad3@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 23:53:02 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> vsock_deliver_tap() clones every packet to every vsockmon device on the
> system. Creating one needs only CAP_NET_ADMIN in the owning user
> namespace, so an unprivileged user can capture the traffic of local mode
> namespaces.
>=20
> Pass the packet's netns to vsock_deliver_tap() and only deliver to
> devices that pass vsock_net_check_mode(), the same rule socket lookups
> use. vhost passes the vhost_vsock netns, loopback the sending socket's
> netns, and virtio-vsock NULL (global mode).
>=20
> Fixes: a69686327e42 ("vsock: add netns support to virtio transports")
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-vsock-tap-=
net-v1-1-7e24f45adad3@meta.com?part=3D1

