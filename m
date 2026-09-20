Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8192D24B7
	for <virtualization@lists.linux.dev>; Sun, 20 Sep 2026 12:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789907558; cv=none; b=XjUUIZJIXSCvdGY7qmLewrLV0yG0BCzeDoXwGVMvkxUrOrK02BB5xmbt5oFqBPk3ApjZ+anMBeQOQG4eGI5Y9X5rNPxoxhkXGx/nVFphaHch5aYrsvTnGtikrMg+czekKXvvpJwGzqHhw+hK97q03BL6k5g23oCHGKwcaPyRJtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789907558; c=relaxed/simple;
	bh=kbSsN1n69F62K+YbivFXqrClqE0l2YBZRxLKQ/HsAnc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rDlvX5sWotVwoQrVABfzzNKCxnhDFh3aDJe18QTz4256Q4JMpikF/9CUeuB/XYfrS8jr7GEg8Ru5uOXyUc3UZBGbnIJs/exO26ayf1Ek2kBktiyXwpFxTtHQicKwm/IrB80sJXgXYKHpAzI2mB6b4W6hTBovgsDWxS2/dxcLf54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRNCue6N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRNCue6N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC431F000FF;
	Sun, 20 Sep 2026 12:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789907542;
	bh=kbSsN1n69F62K+YbivFXqrClqE0l2YBZRxLKQ/HsAnc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SRNCue6NHgCLDHL6FwLbpJYF9RZX0tj701MxuKpmF1wd5UT1Z6NMuTlh4XhoQBmFn
	 qkVMr/fpR5rrGX+BA6aZV/QtpRy5OHdMYnmB2JNJ7nRsYYEOtpYTJf29EKKiknA/PX
	 BNXsiTY2JPuHfcc+tdE2IXoZ3D7g15ork1E2xNb//5NS5u69m3JwGoYbkWKuQWRWy7
	 q+P4cyNEs7rzdKfjnnIy92lCCpKoNEGb3qtFmY+mVIObXbSzjfqH3jFUBnH8xmdl7x
	 5dPPy1+OKmstrX6AWxep6vHOX/58N3bVhTuxL6Zbz521pE92H4q9BvPEkTFmni5HZ0
	 TKPXt0+cxfgQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] vsock/vmci: enforce per-netns mode on the
 datagram receive path
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QmFydMWCb21pZWogRG1pdHJ1aw==?= <bartlomiej.dmitruk@isec.pl>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260919123208.29032-2-bartlomiej.dmitruk@isec.pl>
References: <20260919123208.29032-1-bartlomiej.dmitruk@isec.pl>
 <20260919123208.29032-2-bartlomiej.dmitruk@isec.pl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 12:32:22 +0000
Message-Id: <20260920123222.9DC431F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> The send hook vmci_transport_dgram_allow() refuses datagrams when the soc=
ket's
> netns is not in global mode (vsock_net_mode_global()), but the receive pa=
th
> (vmci_transport_recv_dgram_cb() -> vmci_transport_allow_dgram()) did not,=
 so a
> socket bound in a non-global (local) netns received datagrams from peers =
it
> could never send to, defeating namespace isolation.
>=20
> Add the check at the start of the receive decision, before the
> VMADDR_CID_HYPERVISOR short-circuit, so the hypervisor CID is covered too
> (matching the send side).
>=20
> This was found by code inspection; I do not have VMCI hardware to test on
> (compile-tested only).
>=20
> Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
> Signed-off-by: Bart=C5=82omiej Dmitruk <bartlomiej.dmitruk@isec.pl>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919123208.2903=
2-1-bartlomiej.dmitruk@isec.pl?part=3D2

