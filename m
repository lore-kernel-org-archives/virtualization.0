Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793020416;
	b=G91adsfeFYks+PQUrACeeVgX3VrBXHA7OZQZ0DLxQDu+kcmk2EkQkH17D+SmTooaoiFk
	 bUZX4DM9GFsc2d5PZL8QPn3jFSxVdSJIXF3iEo/0jPQAWH1joAu2LR//eSYP2mUPkPiSR
	 s3CQSWv8GT7hisdEzQw2w843MwxGORXEiFjd6NOLkH7gGxa7d3qQuEY2EWKBuUrI2Ftzi
	 /iY+RCCZvTDpQoW2FtdebCdlJG88rhBJLHQRLDa7IsN3J8JuebNePsfjUy/CV8A95F8qq
	 QbWvLAu7fiUM2DUIZT21M3c2rbC7BeaMGk2u+GwcHE1NKqqZISTd7B4TTDx01l4Avbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793020416;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=C2FTxKbPnljSo33P/L5McZmfT02NwFnhtYsxX0fuQuU=;
	b=4Rl7ZieP64c09s93KnybkIDqPPuC5VYbr2+E52cOQ/AoQ91QPyrJQkNOrvCPQ9gtNCxO
	 JfOkAGFEG03vRtwI5AOlBJ+JMwXPG6e46i7lHGDIf0nYYolED+THHRYXXTl41ewrVlMGB
	 FeeRBIj8EA3H+2ZJzIHo6/AieZI9v5FH2aIIRveYbdAxSyOTwOaIs0irv+gjE/631IanW
	 JjcQGm+o+8eGKBWocS8/SANDr+HZgLfNCb+g4dFlDlQ/drBGT7k64zuvjXDn3CythIUV4
	 DtWwlOWz0NL8MlGrgUTxa1gPh4P6JdU0/bRC0WUW2U3mxdrYzMSDOP9SrRN4/M/B4RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ipiH5Mfu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90E8606A324
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 13:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ipiH5Mfu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1681F01825;
	Mon, 26 Oct 2026 13:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793020415;
	bh=C2FTxKbPnljSo33P/L5McZmfT02NwFnhtYsxX0fuQuU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ipiH5Mfuwa3f3icTzBtgSpphX7a9g3Wh4UZju00miuNlYRorkClJPMMxkLMvdjKve
	 jgLxraNd2dpryWvbJVyfza408ACt3PUMpQZsj3Q4KerzmJxnc8iSX2KLj76A0pR2TF
	 5eKKauOU7zkfScn4m8K6uQnJRGlF8raZVf2zx7ioga7czlZIVAUi6ToO83YjhFX0CF
	 W5eIroTc3rXFzzvARqm3XIiiHgS4s6YeWzWJt85m9wdsv940CFqqZTjIHwP9/H2A6U
	 EOQlv8lqQ57p/oQYkmLqDM+pWng+N1yI1X4B8+oMw89sSxlXMUfkFjE6efvgJ2eTgA
	 LihCEmjKd5WtQ==
Message-ID: <sashiko-outbox-185291@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/12] x86/msr: Remove wrmsr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>, virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261026130223.773129-10-jgross@suse.com>
References: <20261026130223.773129-1-jgross@suse.com>
 <20261026130223.773129-10-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 13:13:34 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> wrmsr() has no users left. Delete it.
>=20
> Signed-off-by: Juergen Gross <jgross@suse.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026130223.7731=
29-1-jgross@suse.com?part=3D9

