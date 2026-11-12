Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794512237;
	b=V4ffFgwj447SLV+HXaRAK/04SvgRiKUrRI05JVpWkrhmWwlobZoD0GrMV0p7a4wxfQoi
	 62xt+T/EEDqIISCeGqSG4ZEw7mgMiS7VVgxexyNrmh8lMkpBEnbk5+9bYSI0ZHJq1KP3z
	 Hq0Ps3FsE1VOZlslgyJdcxqk/bJPEspE68xYornp3nXcIFL2MzeCG1wv3TCLepIjFf7QA
	 qjpEtfschmq8kYWRaySR0a/9+M0lWoLr+gkHefn5lA61I4fEbchydPX6Edo/vjLsx+f7R
	 4x7QWGZEDjB1WmRQa1+9s58sCkdPlkWDnbq4GhsIzEUdc9AnNnjab/t6/miBRK9khOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794512237;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=C/qQpXfxA4MRPeR0h1so2JDfd/ebbE+5w/wqAEeO1us=;
	b=beE0uKAELjyQ4Sq53IkEeUgGZjdsbkfZKmEdf4D44t0IAlnWg4xQ8kBGIvp6tCRtDTxo
	 jSUS00jh4AQqmQSVnzVLcvw8t5z/RESbpYCemxQlk0OPjKNiHdcihEvbyhFMV1wr6FHEi
	 7YMzS/UHkXi3ircBwDEfJ6y0sqGfEJQ4cw9oiz2ZfEIfwdI+cTbJGTxa+ZebE4hdyFr9c
	 +Yt9gTJdS0F8Cp+ePz4l40kCTNS/sVPbF8u4FP+jaAF+9nIc2JloLiJyXPXtoUsFdBjr7
	 IKlfWsXNQS6JLIQqB4dJ1tx8V0uVOvCr3gxQQdZibfAHfN1LlRwpReSopc1shPqXjTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RjYQt6bd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FA9606A31C
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 19:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RjYQt6bd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77751F000C4;
	Thu, 12 Nov 2026 19:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794512237;
	bh=C/qQpXfxA4MRPeR0h1so2JDfd/ebbE+5w/wqAEeO1us=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RjYQt6bdeeAwxPOE9fOXnALEljyRZhRphMEuXPkAVHLSuhSuALKa51HGI6tq28uXD
	 1DJ9bhTLMNEUL0ACwWASSo2CMpE4kvrhiVUulVzZObsckvm8u5o0V6s/uCw8CwxEwd
	 T93s43jerEUc462EJIESOer+nvGY9lzLynyZsiBisGnYRIEbjWWlMoki7mGi5Y6zbp
	 0gsGcphkr1TMuHdZkeVAvY9GPFcdl4Tv1uPSBhQclQkJSB7ifDFTB4TD1s58AQC7d6
	 VFR4EO/ZUeXbz429mYy1ZIdW8oih6YSmfZ2nOsAwZ4ZLkJQINAdXIPswKP5IxVWGB+
	 I5LAzKazHcLlA==
Message-ID: <sashiko-outbox-211770@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND] arm64: paravirt: Mark steal_acc as __initdata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thorsten Blum" <blum@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112193513.2655-2-blum@kernel.org>
References: <20261112193513.2655-2-blum@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 19:37:16 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> steal_acc is only written by parse_no_stealacc() and read by
> pv_time_init(), both of which are __init functions.
>=20
> Reviewed-by: Juergen Gross <jgross@suse.com>
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112193513.2655=
-2-blum@kernel.org?part=3D1

