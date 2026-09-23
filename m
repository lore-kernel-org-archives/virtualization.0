Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B571F1304
	for <virtualization@lists.linux.dev>; Wed, 23 Sep 2026 18:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790189223; cv=none; b=kemyHTop696Iyk8fSvFFlju17TGBTwUt+YsedDK08ixgRKiWQuhA505uGVWLDcm1KlAGr4g+UPUPljvgbxyJozkL5FZq0nbQ/Ea73OqVqbv8R/XDEIEZRSsPW/38dR/uddnok/lCENL8tRQx6KEUSMBOWJL5RtwPLKzUApSHKTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790189223; c=relaxed/simple;
	bh=Rwbv/GhTglB5a+JNXQBxCq8u5Qq2gGTZe2e4yJTWxsM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aqs+qDVkjiTHe6ggnyS+Pjzd2R1N5eXKVzSICRwlc88GQlTRUXnFlRdliDuK5ipq/yaXm8XrwMIG1qpZaW3XknAFpsrWPg/gvf5GzxyRTYqCI7FDrZjoeKCz4E1s13/z9zQbaeOYb8EwUk0XXsDJ9XEC2rRluVfwIhpvhYkojrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWV5yfvh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWV5yfvh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E0B1F00893;
	Wed, 23 Sep 2026 18:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790189216;
	bh=Rwbv/GhTglB5a+JNXQBxCq8u5Qq2gGTZe2e4yJTWxsM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PWV5yfvh0UFC3ekXt/c8bYO1yGjwtBGVzFwc3EgiDPBCciOHwxaY8AsHYKfxqCXcn
	 8OTYp4RcEiw7wvfKc5+aO1i7wikOQLsJII9OGjcJX/paV4gnGAKJR0v1epkRwrkkHI
	 UIDdzvr4Tacl8JdECZvMjszsOKhixojDc4X0EvtgxEZ98uUrMEwhyHH8hAr5AozO0b
	 4JKY87PRuRB7dMdrCaqr3kJQrfLkoS5Oqxb2cEkEeTHpajPXBNvI+xK4nFIlv9EEbO
	 auO534aEkloxMDgUQvot+T4vc2p5dQE7myc7jMz3Kmppx6gUINHI0irpMkAeg4eH3e
	 FaKRHBHdA/JEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 2/2] vsock/test: cover receive queue hints
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Carlier" <devnexen@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260923184008.153541-3-devnexen@gmail.com>
References: <20260923184008.153541-1-devnexen@gmail.com>
 <20260923184008.153541-3-devnexen@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:46:55 +0000
Message-Id: <20260923184655.E5E0B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Add io_uring receive tests checking IORING_CQE_F_SOCK_NONEMPTY across a
> partial receive, draining while the peer stays connected, EOF, a
> nonblocking receive on an empty queue, a zero-length request, and a
> multishot receive with provided buffers.
>=20
> Signed-off-by: David Carlier <devnexen@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923184008.1535=
41-1-devnexen@gmail.com?part=3D2

