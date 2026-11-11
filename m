Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794356909;
	b=dRgo4crNJnLWahGnlC+2qa9Bvzzdb7AFJUOdc61n+869sNf5K6UGQiztA/+3lRoVBkpe
	 QgKLGaevkbTVlW3s+heLbk1ed9rvLjxl90avK/k2kxyjqmu1QqFBJFa3x91hL1z0eM22+
	 ck8tNz+a5dlohflmGkJ3rZbHzRa+PF99FtYgh9IlqSsZG6arJkHyspKCTmgB9AMPW17/K
	 NhE4JvigQBw23F+0zvyeRDsyt7yvSAgSBjAgTVcepTwLWfw9Mq7/3uFg17K/kKC6WWPFV
	 /+qYp67V3UY1PKWUvw5lN+raE2J5WEQ7Mc059G/3Zgg0sTvtIDlKJhU1z/OTcAE+nhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794356909;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0xXES2y2gctr9qr+JLOk1o/CVzBdjPmgMOXwoqks8AM=;
	b=IS1Tq7Jd0rroe0VSdoZ3n+Q9D073IxL4SeN35xsHmesSxgFfbLkWbeDzV5e8qDUdkr9a
	 jNP1h5AIe9De8sWAR2kOuEeiF4KjRzzN7Uo0JE92jZ/S3Qbhd7fbTdF3wgBLh4oxmUu8+
	 KWm4LR0IIDvxRn0rr7dFt6EufrIK6p7Hst28yNj6uf9tp3RcOq/evyfN5DQcWPNgBrOXf
	 mLINxBu1WyN3YcpkAhWby0JHIhsYkSRfdcBGAH3xOhrHMF6oQdLrwtKZ6FD2ZROlu50Sx
	 666gEABuFeTqNmuRCaOLL2+ewfkOCrkookO5YCpF4ZRYWkcoJsqkumkrpsAIT8IufsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PPfnw07B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2AF606A31C;
	Wed, 11 Nov 2026 00:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PPfnw07B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BCA1F0089F;
	Wed, 11 Nov 2026 00:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794356909;
	bh=0xXES2y2gctr9qr+JLOk1o/CVzBdjPmgMOXwoqks8AM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PPfnw07BGjhAtXX07HINzeFhn48RLpvVWSgi8PjlyBiTY3IhqNZCmpxUrLG+HJGEO
	 YCs/WjxJ9c4QtyGnbQ6VVqEIS9+9+9zhbhAm2uqCYA9P1NIl3CNR+fcYEyEtW7BO3B
	 o6aMfzMvjCynOSADavunFptN7r978xKlV7SbGYr2cdA6TUleP2YGTMoN61O6//Ft+k
	 ocXQxNYsq0b/PJeDL5rVsdqsbBC2Or/fkCw5MSUe2k0rQ2wZ2sR5HJprK3EnNdTCmM
	 IieZGypqEVKZBZ3sf8PnG695KGKx4m9wJDLHT+29muosMwaq+6Eti/22V59CkMr1bB
	 gIoQtv8blJlPA==
Message-ID: <sashiko-outbox-208022@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v24 11/16] ALSA: virtio: wait through signals for PCM
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261111000543.28550-12-mynameisjune111@gmail.com>
References: <20261111000543.28550-1-mynameisjune111@gmail.com>
 <20261111000543.28550-12-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 00:28:28 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] ALSA: virtio: missing Fixes trailer for control message
  completion wait fix
--

commit e4fff26b024a131c706193108ab28e9413a49ca2
Author: Joonho Lee <mynameisjune111@gmail.com>

> ALSA: virtio: wait through signals for PCM teardown
>
> A signal can end the interruptible wait while a STOP or RELEASE request
> is still pending. A later teardown may then submit another RELEASE
> before the first request completes.
>
> Keep both waits non-interruptible and use the existing message timeout.
> Other control requests remain interruptible. Device reset still cancels
> the pending request and wakes the waiter.
>
> Keep timeout and wait results in the types returned by the kernel wait
> APIs.
>
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

[Severity: Low]
This fixes a bug in the completion wait for PCM teardown control messages.
Should it include a Fixes: tag?

  Fixes: 9d45e514da88 ("ALSA: virtio: handling control messages")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111000543.2855=
0-1-mynameisjune111@gmail.com?part=3D11
