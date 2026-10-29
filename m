Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793265297;
	b=lxiS/tw/vVeHT671LhpZEGGxTwd5AWgEZ745V+HhGjk/ymNE9XlFIZ6V1jtJ04JigZwH
	 AOHBhKc+Cz1tsJJrnZ8t5vXvjlmwhtyCkRzb4uUbhgyt4ZjcnCDdlMmUc+525ku4CR8r5
	 sS9XS8wUKvsV0Wm30Va2wxH2VGsrXttLGFMbW3GV89wUhPz3CFLCogKGa0mCAhtpofEz3
	 ciGBiYRo1mb+VpUoVMGULTscyXR2Fo4UJucrF/7DVAbqvdOA9Gc/B3gSbonwKwKGl+mab
	 +bn1DOOwUapbfqglGJ65BO8evcmR85t1cDnb7qWpuXhZ/O+qlayVDt//z4iJrbKmglg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265297;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KZppy8U6WoXjhaFtvR4p3kjpu4UVOqnUIEprfsUw2o4=;
	b=yaJDFzvTxm7H8qYFRcXHRVJno59aMmhEbu++aYpfB6eAW62C+S4Nv9NEiaoivhGC+kzB
	 rqKUEm62cAihR5zPln0dBYCS1vCjSe1ejfnbyxrobZU8gWJtzb2NfqYvL1nz89QTFW4Pk
	 avSI48UCUI+sAMdiZtFeAiZdNhUWF7Bb+fItq3TyBjousQRA7X093ryuRIqJKw4Zc/s6u
	 l0MCxzJDXSOFgEXIoRCViG0gfszvcUv42LUUOKw0UrKqtXXPhnQjv6cA4r+iv1Ce5rzF+
	 +SRP1pvy82BqI6ZEUMWGheaAJ8WotVsojUxG/xq8vr4VCq5CpsrEtUfN/lqSYyRqdNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EDm4w4Oc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E15606A31A
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 09:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EDm4w4Oc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AB01F01828;
	Thu, 29 Oct 2026 09:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793265297;
	bh=KZppy8U6WoXjhaFtvR4p3kjpu4UVOqnUIEprfsUw2o4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EDm4w4Oc7n7hZXvoQ6cOGBRRVPLdvgihL8uIs1vpoSpPQSTeOGqNcQ52I0R4gZkUR
	 F0QRJ1z6mEDs7nl47dNE99FX2cWB1S4Ja2i6AoqWHzcvL0zPSnK9vBucxZ/GhpB+3U
	 Rtx95q2p/cPTDqBZE0kLYoJo4AvVU1xbBhMMHNLEpuknMkEmX4XH/QZA4+p/F1dUGz
	 qf74jMDzZc+3Jj7P0QlbkmcMo5xuzl1tF9KbAWDUf3+srfZH7fqWfvo6itB5pXJ0vE
	 bNcC9C8FExx/iYXwsY3VDulHRKYK3tFa3bbCVBYq8VFGSxK6t6Y8DAgHr3enP/XldV
	 ioAeW/B5fwnFQ==
Message-ID: <sashiko-outbox-189011@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 01/14] ALSA: virtio: Propagate PCM send failures
 through ACK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261029085032.70689-2-mynameisjune111@gmail.com>
References: <20261029085032.70689-1-mynameisjune111@gmail.com>
 <20261029085032.70689-2-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 09:14:56 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> virtsnd_pcm_msg_send() can fail while queueing a transfer. Restore the
> failed message's length and notify the device about earlier messages
> queued by the same call, so they do not remain stranded.
>=20
> Propagate that failure through the indirect PCM transfer callback instead
> of discarding it. Commit the updated indirect state only after successful
> submission and stop further transfers when a send fails. Return an XRUN
> error to ALSA so the stream can recover.
>=20
> Keep the polling feature path unchanged.
>=20
> Fixes: fe981e67568c ("ALSA: virtio: use ack callback")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029085032.7068=
9-1-mynameisjune111@gmail.com?part=3D1

