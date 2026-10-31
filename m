Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793413869;
	b=wb+PesWC/7U6J3QqrIrJsjEs18p1HnJHHPaFNGVPasPK5eGBy3iyPL/lFw7ExkD1gct2
	 jjpihy6YpNSwIHLt1Qrhl99EFGH/Izyb+kyizNPwpHwre/ZJkinv31fuutC5qwQMFVXEL
	 ZpeemS82jyOPLvbsLQLXWe/wrFPWapMm/tQ6jWnEU6C+GXLOGo6d66SUHS1o2mWwaPwMm
	 4VDMMmwYxcmsd/23sDddB2sJjDuMxdghrnyhlhyilOhm+wocey4MFwPoX8I6SY1tNGu0w
	 anOG8NOpqLE3/8zJiL5RW+jieKYDU3ejMKzW3R5u5hrjb9WJ0DtFvKEeR4XHU0M/wwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793413869;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aHvOPUHyTVhMaUFJVFs3NSGBtcUJGjgac2yhnfzdPcI=;
	b=oeYh0OB2clOiQtmoicLMen3r17weao6QuHY3G33MK5UH95HlxbcOB1X1JbY5sc40KR6s
	 Roc3O6mBhNgAuPwuKbi5NplT08mknnq/w9+PGyOIEZG3ehi9TBya1vXnTEsAcAY0WB0c5
	 ca8TcpcACFDZR3MV3KqggxWi/SnXYVFXfcDijgTVkQxhI8Y9DvfFePS/A8HLefgZjSPf/
	 /zfAryJmvzqxY9EEjNp2TzB/8UJXUMsprhN3uXH+PfjtZkxBUYRItVR6SM3EJMyqqDVVh
	 mWmcuL15baX2BgAacyHx2X7jllCyRMAMyEtU4anbH/JvRjOG2hClvfbDXzPh5tzgaNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fduVuqGM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B78606A31D
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 02:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fduVuqGM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378311F000C1;
	Sat, 31 Oct 2026 02:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793413868;
	bh=aHvOPUHyTVhMaUFJVFs3NSGBtcUJGjgac2yhnfzdPcI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fduVuqGMjNe24r89g40K8bcbjP9KUHyMJY30OEEURqzGVyGFVY09CUzrErX3yMhT7
	 O4uhDt7MmBJVT1UTuWYMTCn4CU9er6BSBQ6M12eK2StyC15Ha10w13UcXz9im9/PWC
	 PMRtD/PZgUeRVPZgdqeoYW8xni24XehmDIawPn5ofW8kkmkSyqxJXZiiJGyHqIZjgC
	 g5Vt+mJbmowdReTX8vqrxMBCYBAtjNYc2A+EQmRLKZXSbxgaHMOLmscarZKJwkQiN5
	 kQiY6DoagXlaLUqF4yOouhx9ogfxCR8C/xFLaYvw5hBn3fzDjZOEvBWX7XUSIboj+4
	 kdtgWA/aL/FkQ==
Message-ID: <sashiko-outbox-191708@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 02/14] ALSA: virtio: Recover PCM state after a
 failed start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261031020855.2402-3-mynameisjune111@gmail.com>
References: <20261031020855.2402-1-mynameisjune111@gmail.com>
 <20261031020855.2402-3-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 02:31:07 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Capture trigger queues I/O messages before PCM_START. If the START
> message cannot be allocated or sent, transfers may remain queued, and
> ALSA does not invoke the action undo callback for the failed trigger.
>=20
> Mark the stream stopped and disable transfers for every failed START
> path. Arm runtime->stop_operating so sync_stop releases pending I/O and
> prevents prepare, hw_params, or START retries until release succeeds.
>=20
> The stopped flag is shared with ACK callbacks that can run without the
> ALSA stream lock. Protect every stopped access with vss->lock. Read the
> pending message count under the same lock in open and hw_params. In
> sync_stop, decide whether RELEASE is needed and mark the stream stopped
> in one locked transition; leave it stopped when release or draining fails.
>=20
> Always cancel elapsed-period work in sync_stop, even when no RELEASE
> is needed.
>=20
> Record the RELEASE obligation after successful PREPARE and clear it as
> soon as RELEASE succeeds. If the subsequent RX wait fails, retry that
> wait without submitting RELEASE again.
>=20
> Fixes: da76e9f3e43a ("ALSA: virtio: PCM substream operators")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031020855.2402=
-1-mynameisjune111@gmail.com?part=3D2

