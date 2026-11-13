Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794553692;
	b=L7NKTgBhkVdCY8FlaDIOIt1jZBN9IsWgDTkorcHtYvHYgMLvjJO24gM8oR/wysutaR+d
	 FkD04b50QaPbRGLo3WA62H3HB/yvTP+XUSNvKtCdwplR8IMXfydsM587iJNn2pUoLr2FQ
	 RlEVJagRZoNiB4+5tVhhpo17ffJNTI4PxElT+4kAUgdwjwpBMX94wFLZWCpM9TFwz2ocT
	 SuwZK89jxlcolOKGzuq0MV++FXAabaDFFZU93QTmZY+O8iEVtAdgkuXKiPt4DrUd1O77M
	 WmKCMBCICorDTPhy8apINDLeso9Xe9NuaObx7bOSZhgbIYuUQMwXf0ssOwGbt8SAmGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794553692;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4R7CFCb3u+BkndReowW+9ldQ4i1uoBIBSabOKRL78dc=;
	b=tosbSo0oz11i1iECbljRd6FqXJsnN0p3539zoVa78fHJwnfbHMeYzAg4uMgRzLkeciuj
	 2RgSsDO7A8g9MhNdu/5DHVXbd5S3qNQf6Z272e3aVGmwGRYEXK9BM57y4CKYgr7BJFejJ
	 Tp6k0s/44LavvYlwNPXMUy8D3l7N9coyt78Wc3+R8ZjxBJbny7ss2TrC5vYG+94FAEZ87
	 wEvYmNrv0FGhowgjcW36mXW0Un0Qz6II86CqIYuVgYl/9VjcCRGZmqyY8rx28KiCGe3Qq
	 vPDJX2XWREBHKKy0i+nKJ234vWdljcvvgkNslVuDu7+xoVEeAuEeiT9Y0iYKPB3YH3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jj86BYJK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1611060A3802
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 07:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jj86BYJK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7911F000CC;
	Fri, 13 Nov 2026 07:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794553691;
	bh=4R7CFCb3u+BkndReowW+9ldQ4i1uoBIBSabOKRL78dc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jj86BYJKpvC3udSqrH8ySfrzxYz7YYSrj7XlNU/5uEjyz7Cg5Qa0ybZPFspdQjmhW
	 Rkk+U+/qnZTXpPPl07ClfVJ8CllZqXdWNQZt8ovQqFfXqvrLMaIECcpeQN1Cq4JTJp
	 LWwKU8jTLC0vJ7OLeErMkTRhhdeoPjPOylvYIA4YyJ7U0J9aty0uU3/FpJSbiE4IPl
	 2sD5HscKZHpgJoPEWxShbTugsGS7/3ql7WdrFW1vFzA/RuEK1uPmgA802FUp3pz4aj
	 Y1dvTmWXbpp1mgM7ZyHJ5VjG31XSF3YIqnb2QG/Kbp0E2Bjr6y1JUSjeUJ6Dpiq/Tm
	 oOYqLCliVykpQ==
Message-ID: <sashiko-outbox-212321@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v32 07/20] ALSA: virtio: Recover PCM state after a
 failed start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v32-7-4e95979e312c@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
 <20261113-fix-virtio-snd-recovery-final-v32-7-4e95979e312c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 07:08:10 +0000
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
> Capture trigger queues I/O messages before PCM_START. If the START
> message cannot be allocated or sent, transfers may remain queued, and
> ALSA does not invoke the action undo callback for the failed trigger.
>=20
> Mark the stream stopped and disable transfers for every failed START
> path. Arm runtime->stop_operating so sync_stop releases pending I/O and
> prevents prepare, hw_params, or START retries until release succeeds.
>=20
> Latch a transfer XRUN in both playback and capture, and schedule the
> existing period worker so a running or draining core stream sees the
> pointer error. This also retires a failed playback START during drain,
> where drain-init can already have advanced the core state to DRAINING.
>=20
> [ ... ]
> wait without submitting RELEASE again.
>=20
> Fixes: da76e9f3e43a ("ALSA: virtio: PCM substream operators")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-fix-virtio=
-snd-recovery-final-v32-0-4e95979e312c@gmail.com?part=3D7

