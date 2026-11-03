Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701657;
	b=S9pK1NCPfKUBZeyQoNK2mHQoWHWvho3bDn3e+1s/Ij01g4qbOjzswV7HA493m0XDorNm
	 CsN/G23nHnFj7gHnRBEHEbk1JZmFgEzk26ra3UFcbBn79sHHmPk0cA2gGjzhJh6WObiCo
	 tvzXMrX0aghMJtICnwNMgeCO1zXUkx2yvzIP9JTLg9043c/P70PcudLGFHD/OoG5L9uJq
	 +Is745WrNYo9dDQzKZ3akHadaFthktMTzOqIjUHPmFhz7Y6rrcNvXfaWjBtMlzbRngD3k
	 9WQnefr5LLd4gGLT5MSmJ8GvNaHFA3oKAbqQwjL2SqtbceUfR7ZfiqDmMGrA0IfpA7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701657;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Sbspv5tCflEkEw4OjR4ULfSGXw/2nul5H9D/U1KIzLM=;
	b=w5MtRsQr9uMqWjEV/WmDigqtW1O0GOE7qJvBXlKJ0TX0yCmSHkERfxcUNvzASDz8fAgw
	 fbpTCgmptCexcsY0lQ4qTCpsGkmz35gp25Cch3wTbM9MYJsL/0BcWDKQLtlWlUdbBrbKB
	 TwI+oMmlDlxHHdpToigjqIXHEYxf9TWOaddkkxFrjOFrfXWiNsOuQ5pLSwuUoSaw3SyAC
	 Qt7k01vBaz5tKpQO+w6xgitZgBBhqlFbJxuuv3FNA92lhcrvD0scmEBfl5d+FDsT6A/Z/
	 aCALNI8uLf8YBpnD18tYTOw/WP7oMjAXKR15j4N5/CzB6zzUAwFfBv9bQUygOhEeK/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lamVqSWD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A00F606A332
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 10:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lamVqSWD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD601F000C1;
	Tue,  3 Nov 2026 10:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701656;
	bh=Sbspv5tCflEkEw4OjR4ULfSGXw/2nul5H9D/U1KIzLM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lamVqSWDNkiapXZX2r0KuKLrhCc8RXjrvOftGgUIK/gEni7M7R1zO9+bt5NqrbLno
	 FF8WvpEmDqSbZwXWqISh0zI9vMbaXt1WZmOVz8F1Tn6qb6TUisojt2m9baELHnZBm9
	 +ZBbnZAJ0rRBgK2UIZcTzUiXyq3cVaKwDDE9ma+BHBuWWLMTleHW0jsDMdGneA1gqv
	 xxR/l3Fxsc15P8Z2gZV5Aa9jd2PfS9qRaAsv0TpVESj7slnmXB6wKXgelafSJ/sNSj
	 kPiPnR8UfnbXgjFi+tBKyAG0q6y6LUXF8BiI8G4Vjlp/RsMKRKqp5OpI/CjNtGK21d
	 Xrd4NRgixgBXw==
Message-ID: <sashiko-outbox-195048@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 09/12] ALSA: pcm: add an optional reset operation
 under the stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103080821.16983-10-mynameisjune111@gmail.com>
References: <20261103080821.16983-1-mynameisjune111@gmail.com>
 <20261103080821.16983-10-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 10:27:35 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A driver may need to synchronize private capture accounting with the
> common RESET pointer observation and the core's position rebase.
>=20
> Add an optional reset operation called under the member's stream lock.
> Expose snd_pcm_lib_reset() so the callback can retain common pointer and
> time handling. On zero return the core completes that member's rebase
> before unlocking it. Drivers without the callback retain the ioctl path.
> The operation is also used after a successful prepare.
>=20
> Zero permits the position rebase; it does not promise XRUN recovery.
> A negative return skips the core rebase, so a callback returning an error
> must leave coherent pointer state even after partial work.
>=20
> Linked RESET and prepare stop at the first error without rollback.
> Earlier callback members may already have completed. Legacy members keep
> [ ... ]
> callback retained an acknowledged appl_ptr of 64, and finite-silence
> playback kept the written prefix while clearing the rewound tail.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103080821.1698=
3-1-mynameisjune111@gmail.com?part=3D9

