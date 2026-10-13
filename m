Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB9937A83D
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 06:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791874180; cv=none; b=KEocGLxGy7wRTagO1kne/SGlRvKfVc05rGN2mjQave93X/KN+WZ4mDyqrMyfCvhOLVp0SG4Ukjq8/lZQ7FigXtXqyNnPd0z1gUe8Rq38cn07B5M1DiPhcTXCMC2J7b0C1IMUebWmHYHQeCyG0XiGbRiUwVP1KHRZvFaub5jID2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791874180; c=relaxed/simple;
	bh=13S4O2dbfp+XbxSzy3jgIKo63eXk0Q3zTLGhhi5Pmgs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Ued0jz7zV1arSNTRrHP3YNVjV4Ym3Q0fE7EwksDwFoKHy2OZIzHYeF1o/4rpWBS+xnMvRRi8BcmaLfZcIyU3+zch1hI3Z8fFCg9FQiQiewppEfQoec1mFJ+N35xFpNDYdrY42jCIR4mO4QdLB7r3Zopv9rzaUXdWtGq44O/rCGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqFyQuTu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqFyQuTu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3059E1F000FF;
	Tue, 13 Oct 2026 06:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791874179;
	bh=13S4O2dbfp+XbxSzy3jgIKo63eXk0Q3zTLGhhi5Pmgs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BqFyQuTuIXqxpPpOHO6dHIKM4Ly15aJU+0bB1p/Wa4vTeQ1DXRtT1C0DFMmslrhtA
	 uY/FTcjH4obFJzQZMANJVIk7QjtR1sFHLEpU5REJB6HG8Ka6eYXMCfii3K1TXcmodJ
	 2DHq4CEYc5S7tz/KfFDQGEu3TQHiEao5Nih+jMElfBW8UaxrvkEnyZwtmDH+a+NkbN
	 GSIVJkDXJw965y4GhAAHMGIOICyXBkptWejUMnhCgBnC1t7tIKbcKzwKNaT/VP71tQ
	 sDWMG76zBhKuuqJMlOSFKyVePcs+BEtQa7My6EELHWh6UZbbnBY5wWPDwgicN6agQG
	 sDwfW9pJ8a1Hw==
Message-ID: <sashiko-outbox-169138@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 1/4] vsock/virtio: split socket lookup from
 locked RX processing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261013063112.168321-2-physicalmtea@gmail.com>
References: <20261013063112.168321-1-physicalmtea@gmail.com>
 <20261013063112.168321-2-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 06:49:38 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Split virtio_transport_recv_pkt() so socket lookup is separate from the
> receive state machine that runs under the socket lock. This prepares the
> receive path for keeping a looked-up socket across multiple packets in a
> later change.
>=20
> Keep virtio_transport_recv_pkt() on its existing per-packet locking path.
> Pass the network namespace and decoded address tuple directly to the lock=
ed
> receive path, preserving source validation and failure handling.
>=20
> No functional change intended.
>=20
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013063112.1683=
21-1-physicalmtea@gmail.com?part=3D1

