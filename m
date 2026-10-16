Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B2B46C844
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 12:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792154532; cv=none; b=K7P/DfmxBfkeBaunRrh4QTKs1Wu+ewwBTEtYCfv6F9pPEW2EnBJvWjTkIp1FlNDDAYW/Uqpo0/f+PQ8+1NkWUR5SlS6aDhPGyf4+sw4gSWa65HNYbCiPzU0HgBQRncPDb/8zkx2PQYVhGc4MRhr6dWauTTSxxedRo9NpdZ1HEgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792154532; c=relaxed/simple;
	bh=DkItJasvUZjiFAxlQ+S9c3vc8shcteqTkIzCLM5sq14=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=jeOtioM+URMgDNmOJuF8YMt5L+Jdz8Mftmrlbd/6pTNUWi3HEoCcoBmTXNQWu3+Lou6Mx4JKjt50mGubaudnMbCJmOTYA7jVoSpeXDISwkyFdJ6Ez+D7pTrCssPROYMULFn95hwOlZRrBgXJPPXanqeb5dzHkLeFKzoe5aXOvNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6QnpjGg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6QnpjGg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A483B1F000C4;
	Fri, 16 Oct 2026 12:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792154530;
	bh=DkItJasvUZjiFAxlQ+S9c3vc8shcteqTkIzCLM5sq14=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U6QnpjGgNWt5QFCtG1tK6ytfXnJp+jDszkP/cqWPVZWk1Z0kTEKo8AurvSdRdLAL/
	 0XWjVYmC8lqc9k1CS6JIZxiabVwEboYJYFADHYGqJvbTnAoFM+v0TmEUbtL+nVzzPK
	 3qjSaQw5P8Qgxf5nEsUe1M+YR5nxivaGDKj5iAjssqGs/p/UfeSbb8WwvucK3CkrBp
	 5ilyx/Ov5bUxcGBc56kq8sPxUgGLKPuWGASkPE9Tas3FOE4/3h/q9bzqmy9bBtWq5Z
	 jDUe5tfaPtUkEybe+qWIHU4FADPHXcBcXCWVT9HT4mUFeEkwkDZ4eY/dg0+/aE7Jd9
	 1jqLdd4WX6A9w==
Message-ID: <sashiko-outbox-174316@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 1/7] net: account for ingress-resolved
 virtio net hdr state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <885c413aa895291c0b404e639aa85d1e33353e81.1792067836.git.mst@redhat.com>
References: <cover.1792067836.git.mst@redhat.com>
 <885c413aa895291c0b404e639aa85d1e33353e81.1792067836.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 12:42:10 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> The following patch will add ingress resolution of uncommon virtio net
> hdr checksum metadata (software checksum completion at ingress) which
> adds performance overhead to the packet processing.
>=20
> We should make it visible, so a hypothetical workload relying on
> uncommon metadata can be distinguished from none at all. This way issues
> in the parsing will be reported and not quietly pay the host-CPU
> checksum overhead instead of offload.
>=20
> Flip every call to virtio_net_hdr_to_skb to test for negative errno
> only, and have tun count these events per device as rx_csum_sw, exposed
> via ethtool -S.
>=20
> Assisted-by: LLM
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792067836.gi=
t.mst@redhat.com?part=3D1

