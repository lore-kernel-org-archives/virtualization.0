Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794553107;
	b=Rqqy9VNT9WBqs3Irw/gJoEqUO0CPepWVUV60+JRvHNZfsKk7G6n47kTFr7nGF3mSf381
	 sCP+d81YgGKMTNgjZGVFDCYOBUZp9+WM6ELuwzADzq7UnuHJtCNaVlZUirJadg25lvV1w
	 Gfw0M6DrItvKLrtHeh+m7oiJqlrI4XRfUgiPwiyjNo6j5U2nUULBCZNYjuV4Sheid52dk
	 Is1Z3yLAdoIctaZZrMgtethvEZSxrp2azwIGXHcm9ln0XEuecmNmpUwEDpkRrsX25pRZN
	 /GiJqtQkNBESsXXrj7T1XsoAGeUYUbsxUvq88uK5M7h+FSQcT4SUihftf7+9yFggO8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794553107;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AUsj1AganWmMmOxzoaD4a8c9detz/52/I/4cpoAh0/w=;
	b=KYXE9UJQ1RrpaQl82qLpHaUZVJBW6R4yRkAzefAHvJc/WsqWVnqp7ywAT8pfaQ9DxG2E
	 l9r+z3Hzw5F0gjzDepKMCc+k4viWd2DftSew70nuCJHBg1rv1BB36gmtibF52at8SCBfL
	 d6ZoAVWiXtJmi5Q3rtSvtRSRJaVpP91l36eoMeL4j8MD8FLA9GrOIV2dbBlbSrlkD/iOM
	 qFexdye+epK5NDGvCpkk4cRmvx73sC/LmQJ/PO0+vJoItMkSn2tiiXxfvIBD0dYG9odsU
	 rzwJFge3qreXeqcE39YBkZ/p1v23JMtVKfUtZI0anjOQ9MqF992OxylEDWK/jTNDG4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cTSrclZz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A29606A31C
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 06:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cTSrclZz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D1C1F000C4;
	Fri, 13 Nov 2026 06:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794553107;
	bh=AUsj1AganWmMmOxzoaD4a8c9detz/52/I/4cpoAh0/w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cTSrclZzjlbXslPRFu5NqnOfLfAz/y4k9pdNNerVVXT1vmowHwLkjPm3G/l5cOiXf
	 x6KU+bk57eI5u3QXqwd/TNrhzAnIHwG78mGzmdzGI0rG7WoTvBHwZ2uuQ/IuoUBchj
	 KeumKY/d/8nSt0JUqkT2aeCK4HTwOJytHmSYybRRLJ/9HkKjugU9ibsdlksbnk1uic
	 eZ3iT+o1F4fTZt9qlCsggwkEdv0k1EjnOOj96uZthTWMcBMTuqsL8ub66FCaeZ9DoK
	 AkwVauR7lLv1ZFc3PNVp9doP1pvEQb/icYCcHn7tM6iVcj9KoeZxzaD3B9jiffZA+Q
	 07sHteF1x0M0A==
Message-ID: <sashiko-outbox-212302@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v32 19/20] ALSA: pcm: allow stream suspension without
 power management
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v32-19-4e95979e312c@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
 <20261113-fix-virtio-snd-recovery-final-v32-19-4e95979e312c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 06:58:26 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Joonho Lee <mynameisjune111@gmail.com>
>=20
> Device recovery needs to suspend PCM streams even when CONFIG_PM is disab=
led. The no-op snd_pcm_suspend_all() stub leaves active streams running whi=
le virtio-snd resets their queues, so an application sees an I/O failure in=
stead of the suspended state needed for prepare and recovery.
>=20
> Build the logical stream suspension operation independently of power mana=
gement. Keep system resume support conditional on CONFIG_PM.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-fix-virtio=
-snd-recovery-final-v32-0-4e95979e312c@gmail.com?part=3D19

