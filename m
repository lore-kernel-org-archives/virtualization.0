Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5DC480DED
	for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966581; cv=none; b=l0TlkiSoUuZn48CxbzLxiNqt5wivykprQxcjMAV86hJk9oM/HNaLrxiZV/d2hvZ/R6r4Kn5aDY4sAduIvNXPufjQl+KOFTVkYMDEmT/sS0iUnBK/4LkxoFmCFTbU41KO6z4OSUiTIABtGe9hPQNzZbfY2qiK+a4MpxnPgfamfzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966581; c=relaxed/simple;
	bh=/Xt+Ybfk70ayoI7RGLB5AnbUQLDu0rNkQ0v+jstMAAQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=FlHItvjenzhfHu5mOrOrdNslDw1+yGyzg9GC+NO2B28tHDRKmS2+j+yZ0WnwazGMOJAjs/T/OyQSR98X52PB4ST2aeLoPAHRmEGgS9GFasvDFek8HzUUZ2V6m3+lQvpCt243PG89PNv1TF0+riUOhYyvWEk0SpyPJ3/gJoFsPm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uu5seCJS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uu5seCJS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E8A1F000FF;
	Wed, 14 Oct 2026 08:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791966580;
	bh=/Xt+Ybfk70ayoI7RGLB5AnbUQLDu0rNkQ0v+jstMAAQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uu5seCJSCyTJBmwOcrC74r/DPWH0M6sbMdN/TTh5FA1h48847Q0V/KDCxzwotPis1
	 WzNHJTTQllnkQKIUChDRGgMKaZdNkU75HIMmFk14RkxvMCmf+RW98WrG12+c5srA1T
	 IXjwR/aVSMbez704YPBNsBmTAsmNBPVekg/oGri3M2W39zrDpak+F8sS1BbXvfZrXH
	 dBD6x3MvZVdPd5O4kCeA3qA2gNrvWp6ErfVH1WSTwSBFShMTFuCWz1cZH2wGFmP1Dz
	 mY8/WCnp9q53ty6ixgAQZdPgkPmf4k3gToZ9WVpP4dczLIEhnxPD37zc9cOK5NCpPI
	 ws4zv05yvyIaA==
Message-ID: <sashiko-outbox-171008@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/1] ALSA: virtio: wait through signals for PCM
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <rfc-v2-generic-control-wait-1.2eddd58a796e497f@gmail.com>
References: <rfc-v2-generic-control-wait-0.2eddd58a796e497f@gmail.com>
 <rfc-v2-generic-control-wait-1.2eddd58a796e497f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 08:29:39 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

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

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/rfc-v2-generic-cont=
rol-wait-0.2eddd58a796e497f@gmail.com?part=3D1

