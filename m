Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB61A86341;
	Mon,  5 Oct 2026 01:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791162481; cv=none; b=pL/djs3hV6H4P2m4SFvezQngQBmzcysZmoCHrfzb0vueMIy+GHqOLnFvpABU5pvyy6K3VB/8gj52DVS5cqRaVfWSQdSIRHeVPXineYClh0mu5xMeETcYkIOCcHBKx08Xzti5aH12/g9aUze0HDKwFBByMv2Da9YpAHGX1dMULNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791162481; c=relaxed/simple;
	bh=8ryb6JL6kW94Yg1qGQQJG52N2mPNvJinaIwGvHdv5jQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kcpoyxpJs+U+YLEcjeJX5wJ3sN2r+09Z/h03tFVia/ui8iAOrfdbmu3AJgQfX8nNlqeq403qFo4WCgsrPVe8B5BLA0N95NkBjGPXZe4rYfQIAE51YZJkqLKArbfTddmnKikq4Gkg8k8AYiEw3vIGVAaIev3NkXVcK+HoT4FnsQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVqt+wq8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVqt+wq8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920121F000FF;
	Mon,  5 Oct 2026 01:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791162479;
	bh=9nSzsM2bXvDKmKRbZKG5o8K47G+jhti55dzHMV6kV3A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lVqt+wq8MbgiUCIb9TXjTqiGgHZ5bqPgTWwgZ65K9KoikuOUNgbwmRWzFcjf0ZsIm
	 tZdsQyTlEudikvBlg2ebFrPcZW3LPb3gGIF4sQCOYAqW5FcGx0oEDkbTiPaHLFhoRX
	 xphuFbk3fr7mT+4sgr56tmxwxVq2RRI3HDLkDl1pq5rBmIsTSsMd5XlUZA6IP9Vfeg
	 zWIAXe7zoRTN5G44X5sSDbWkjwrup3VD5UB3AZhy/dqK+PH9gt9Y4KsV8uUIzcwG3Z
	 k1dF7zO2GF3hyUbXtyWd2VDq3c0jii3blLDhIcc8aRlD8gk9zZRNtN/XUxfnPUyCot
	 saEcuGeRmdKGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4] vsock: treat TCP_CLOSING as once-established
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Luczaj" <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>, kvm@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20261005-vsock-connect-reset-closing-v4-1-15d41cfda3ed@rbox.co>
References: <20261005-vsock-connect-reset-closing-v4-0-15d41cfda3ed@rbox.co>
 <20261005-vsock-connect-reset-closing-v4-1-15d41cfda3ed@rbox.co>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 01:07:59 +0000
Message-Id: <20261005010759.920121F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Handle the TCP_ESTABLISHED -> TCP_CLOSING transition on OP_RST, which can
> race with the connect loop. Immediately break and return 0 on
> ESTABLISHED/CLOSING. The return value of connect() should reflect what
> happened up to the point the connection was established or failed. Events
> that occur afterwards must not affect it. E.g. even if OP_RW has already
> set sk_err, connect() should still return 0, not ENOBUFS because of it.
> Adapt the inaccurate comment above signal_pending().
>=20
> Resetting a socket that is still present in connected_table can lead to
> memory corruption. The reporter noted lost transports for in-flight skbs,
> and I have reproduced crashes caused by re-insertion into connected_table.
>=20
>   list_add double add: new=3D, prev=3D, next=3D.
>   kernel BUG at lib/list_debug.c:35!
>   Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> [ ... ]
>=20
> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
> Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
> Link: https://lore.kernel.org/netdev/anzT1fREOSyHT99k@v4bel/
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-vsock-conn=
ect-reset-closing-v4-1-15d41cfda3ed@rbox.co?part=3D1

