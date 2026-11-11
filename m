Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794356778;
	b=3QVr6EYEDai+lXtQSicndIQRUY2nJluZVNkk47w7f0znjWdmok4++Uy7lRAXwnCUW9Np
	 /nqZLqn2i3lvN+UO724aJHXnVTMh/0Xw9Fm0so6ELvMta40RuejxZlpeqe2gwqpkdY9pF
	 /10f2AkS82fk9jUK9fQdM4hYS+PJyZ/6WgxulXonP+thK2xOuz91gatgo8D8pMhUp7fdI
	 JUsWCVxqRvQzHakqfMwGlU5/AbOHhF6kA2+8X099PLKeazJROUtiU21+sIzGPV5XSTOgo
	 S7pJNZHHNY8llFizgCAVTSJGBmDvdoghipKyds60LHOfDpP7yHWRrR/LxElG3Nz0L9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794356778;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oujW4IPC3G3UutCQntEhDo9JQCzbjG06dDdi6o6Pjxs=;
	b=0+D2neWdNGuS24HGd7Pp2ZrNEa6zc/vYprqxhBZV+pF8IZt7oqHYOW7xZB5XDQto4JtV
	 mg5Eq9NLo0lTRtaVZZNNQ38eDS33g9sklNryruWFuU9J5xyHKAojO/KtM8quRt5LSYYxl
	 sgc4TEpME7n4VFZGzEomPpZCQaIC8ydqXjoVDOjUs8fy3dXMnyjrr5MCqcomDXt9lOSLn
	 ETg1Kc+ynFoqxKDJRSiLREmbxpTrvYDIdbu8ZyM2l3C+huzz9SkjGOz2D4YCzal5R5nxa
	 zESYnSYJvQvkaAiFtYuu8inEcXaNnUS0+qfC/gi5prMUEeFv34d1QHwhxueLh9AlP/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m5POyWbo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3AB606A31C
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 00:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m5POyWbo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867D31F0093C;
	Wed, 11 Nov 2026 00:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794356777;
	bh=oujW4IPC3G3UutCQntEhDo9JQCzbjG06dDdi6o6Pjxs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m5POyWboW9MBtK2fuUg4DW90kzUUecOXJbBon/gUjfEO22T3o8i3HmZmcDT5e8lzG
	 U6qCPu4Y3oSiPIMLJWzQfraL41gkVuHrgfKjldF9G7I2E5DcAmf93E+zytUvi7lD6+
	 zCK/t5W2TlmaY13wjO30k8WfOtp87PDRJq6lZ6eV/kXIoGeiBR+cYeLx65emWqzbpG
	 7nCJN3gPhxNSS7VoEp81ZfHpKvZ43U3cvywpamrx1Vf/Fy9oig3ewEARsGtOQjmX6b
	 ZZSXbAj8Q+m/8TA5zBE1ihmr/WTQmuCep3IkTlKnclFKK9HqOscIpeIa/o3e1lpR5K
	 i0n4ggLobSrbg==
Message-ID: <sashiko-outbox-208019@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v24 15/16] ALSA: virtio: reject invalid playback
 completions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261111000543.28550-16-mynameisjune111@gmail.com>
References: <20261111000543.28550-1-mynameisjune111@gmail.com>
 <20261111000543.28550-16-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 00:26:17 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A TX completion currently advances the hardware position even when the
> used length is malformed or the device reports an error. Validate the
> fixed status response before publishing progress. Retire the request
> once, latch XRUN and schedule error delivery while preparation is
> active. Keep malformed or failed transfers out of successful playback
> byte accounting.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111000543.2855=
0-1-mynameisjune111@gmail.com?part=3D15

