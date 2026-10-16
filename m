Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546D04C8FE5
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 13:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157788; cv=none; b=gTUzhRJcctc64jPOnb7Vq31Ae6ZtrlrfjS9AHpY5lH7p6otEVlplMsNOMiMczaN0tO02OtITFYTFVWifJMCtH5uxDmabWYMxWzATELaMCHM6kaDFUhhFgzRG2M0nWEksYk0jaiqrS3OnqjG6HbrppVruqM6h0eJA+qSF4qUmmFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157788; c=relaxed/simple;
	bh=CBeI/le4KB3JcYBEgTjW8vxfdRtT049rNqGGQwV1OYM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=i0CoqevXqXyBv21VaP2Bl4X13dA0ITOvnvynz+80/dZ8lcA1NUlfQpyAhEoSpYj7Tea1GT/xrh32dzTlwkcNTcdwHX3XZG99PL5jEcBnOEiXa/xAzloj5EqDdtDvDyKbjWcS0xXE2swAW9CfIAQdopL5hIV7LDaeOX7cW/KXB58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jh2OtgIu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jh2OtgIu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59E81F000C7;
	Fri, 16 Oct 2026 13:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792157787;
	bh=CBeI/le4KB3JcYBEgTjW8vxfdRtT049rNqGGQwV1OYM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jh2OtgIuvg3u+kTdo8TrEyDI+JplxjN8Tki+cb5puGu1OIs1vsYHQ5kl42vZbXfY5
	 4AKNyeTteVvOT9ZTlTNYSQSZ6wJGA9yUDNFCJF6bAoTTl1RBRTRXHt/TcYo+LOObWF
	 Wim0EdGEcwDPtNfIR3WH10l9ceMhpgaPGZ8BXr07kVxy0iCSNWV/b2GDNKOEY7vrLw
	 JcRrUZSeRJ2gG6SGKh4gFJJw3MQckDex/YQLWk67nXJmEaTJfRMt4cy6kzdsOApf9Z
	 XxmEwrlzzSG4UtqhOKfO2d0ulkdYOhJsFrWHkjmec7GXrp6EjhMV3tL9ORAkzyPfHl
	 Lb3GUSeZSx6ig==
Message-ID: <sashiko-outbox-174387@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 3/3] vsock/test: cover SO_INQ
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Carlier" <devnexen@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261016132716.272018-4-devnexen@gmail.com>
References: <20261016132716.272018-1-devnexen@gmail.com>
 <20261016132716.272018-4-devnexen@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 13:36:26 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Check the SCM_INQ value after a partial receive, after draining the
> queue and at EOF, that no cmsg is sent while the option is off, that
> accepted sockets inherit it from the listener, and that out of range
> values and SOCK_SEQPACKET are rejected.
>=20
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Acked-by: Bobby Eshleman <bobbyeshleman@meta.com>
> Signed-off-by: David Carlier <devnexen@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016132716.2720=
18-1-devnexen@gmail.com?part=3D3

