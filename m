Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793665453;
	b=fLEh+KY87wToZalfND4jh6S2wRbMppqWemFxB3xbRz2McpZL/MInuHEaW8IICwvUYAMm
	 xKJTJYjqkQh9BtRowF4sIyqX+4kFPWeLTZYVYtASwavPAFyqYfzKazFnpZ87QCZate4WR
	 fiP8Z8Lp8BHRJ/Ck7hIP7ljJ8EKs6MUDksW59pkeXPgHJtEvATREvf7H24koD0e7Mge/L
	 24PNJCPr+lGos+vhVX1E5rO28F6WrFj4dZrasQlLE6JFq9WYwSOWV5kmUQpDw8sKmJw2/
	 rWceVfs4zpwqhQzPWTMWmfUr/QX7j+mt5QaNq28kRAgOTAVJ8UcEemSURCj/obyNGjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793665453;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DqS8Ydps0njI0OAU1BvpsOm4Kr9FvcT4hibJAVIZu6I=;
	b=RRfqtcViwRJJCk+RHr9zbynPVZVxp2zluPlLhKTGANUu1XwhbuQdLuzUeQafsAL4vTG9
	 LiOUFuqQzHA/BqBdFHfBastwBszPl8+Nn+3quaX/PuPSBbWdhPtIKARx8+EfABoT4nPMO
	 Cezh2+xpZnug5w2AD8KOMoUSC220ncH4EQ0tdwej6ElEla9OB6JHbESq4A2CkKM26pJcG
	 8F5NUEQuzQM0XBa+HqqHp3nmyyMNcHnFnYWw0rrVunjqCYE63I9qdVY+eMTXVfT+RFBrf
	 syAlmwQ+8esPc5I/LOcHMZVcD+s+oYpYLABbEOM7XiJbd/77CLDuaJP/5cFtFx0bRRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="f/j2VLtK";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7725B606A324
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 00:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f/j2VLtK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4481F000C1;
	Tue,  3 Nov 2026 00:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793665453;
	bh=DqS8Ydps0njI0OAU1BvpsOm4Kr9FvcT4hibJAVIZu6I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f/j2VLtKeIu2O/V6kcszO+T76+JGeYxNQ0U4pO+4mSJMIo73fy3ZB+QZfGtP4XLKv
	 1fKjCjrxMEOAnmpvtskfETPvueYXFUaL7JrxnvHahrg4IMqOyOzpG8XA/VgNnosOg2
	 pgBlAGSEFuUHIekyVku0uDk0RjN7pKc5RS2BOp8PYjVwHdwC16WYpNiyLwp+9zUnFY
	 jyDhiTTkGbCDbLoOwkh+aRjFDsiOUva4CPCsN58nzs/bmPZfdMCg155iWRbabULxYS
	 KVRwJFT0g+pjthygRcIygIDKOf/8fBxvEI0aXA5x93z/pI5up44wF6kbvADFs0kRKC
	 /hOSC2DzqwhBw==
Message-ID: <sashiko-outbox-194372@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 06/12] ALSA: virtio: wait through signals for PCM
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103000403.67106-7-mynameisjune111@gmail.com>
References: <20261103000403.67106-1-mynameisjune111@gmail.com>
 <20261103000403.67106-7-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 00:24:12 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A signal can end the interruptible wait while a STOP or RELEASE request is
> still pending. A later teardown may then submit another RELEASE before the
> first request completes.
>=20
> Keep both waits non-interruptible and use the existing message timeout.
> Other control requests remain interruptible. Device reset still cancels t=
he
> pending request and wakes the waiter.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103000403.6710=
6-1-mynameisjune111@gmail.com?part=3D6

