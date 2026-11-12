Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794464004;
	b=GKHG3DopF+QcLDcEgdeYdrkhke2w9hknK7348//VYfFNlgdCCjS8GuD2zhsYXsVz2mIJ
	 o/08xgXnY/4pNuvMCAmhCFtFYwb5ecR3p3hgXf9QHSBV5/w9qD2Br5umgcHU7i0Rgidwr
	 BqTdPlNGLb12BZNAT07JbyVfLuwsDTHbYbeAd4kZXXHCLv8dPtBc2+PT2MxtKoQ1/gD8h
	 XUSCbFqu1LNM4vaVvPhYzotMXP6cUpkCw35oSmAix48MIlxvSc66lPbBLOIyGeAG8qhOP
	 qPbst3X2w5D5wx2MZ6hb5bUMCfB2eMVWcgKGWcG1xR8z0nEh9i9B+bpa2oAKp7+YoWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794464004;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pGMAyYHQSc+IevgKt+OivX2Ma/gxcBxOn2PswR59fS0=;
	b=Yfb6ZjdKcHsqQ2huiZL/N7VX5aVxMX2GMhqk1tLLh184PFlpJJryCyjRKnc0oUr0y0KP
	 XJvMv8nGZnopMtU7u8taQjriPLYvrhitUBuaS6D7aeFmy86CcPQuNTp+ObS6iZZaw/dVY
	 n65rFpbiqRIv4KvIF2doA+QyHAdBJaalAZBg15O/yXQLMlTuusJ3fQdsyfWa3+wsV37GH
	 L3c/A7ob1P4yraS+WkEwlASe+beUr4EevCMoto1+rf4jk+iIouBkwC6Kyg6sQCkmu1nEw
	 JTty1NnxJiu+9QPA9mCOqz2esT49f8Xtn05k09D8NtMrBFALSGkauRRRzs/AY6qZERw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mvlH45jb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4A0606A331
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 06:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mvlH45jb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0291F00A07;
	Thu, 12 Nov 2026 06:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794464003;
	bh=pGMAyYHQSc+IevgKt+OivX2Ma/gxcBxOn2PswR59fS0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mvlH45jbl7HAuEoMmFJQhGfQ53Lg7t3U0YsrzTCDVDyzq9sktNIYpyyuX8OgN0KpW
	 ExWq1md/j4auzDxjRER7MvGz4wP4cuJLoNuzeiodaoNjjWxW2YahDdhpqAx6dI0JCk
	 FLgzp4abxZnzcdLNa8GrkNAtPgyDZdUrr2k0G0O3MN+Lle/hSvlaZM5oQbfNMPj7DE
	 OB6BmQrbWFD9gBy62qpmiOkFd8ogc7CnwYLpWfHgg9WJg3a2hLRD4BVdOt6OKFq7x1
	 P+tlngcKa0ixTOWyryZnbMooq+8LxdK4dLuWrxVu9auuq/xEHHI0dNdLjyd/rvJ+Wi
	 ZrqNKgyDZWMVA==
Message-ID: <sashiko-outbox-210502@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v29 07/17] ALSA: virtio: Recover PCM state after a
 failed start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112053446.73504-8-mynameisjune111@gmail.com>
References: <20261112053446.73504-1-mynameisjune111@gmail.com>
 <20261112053446.73504-8-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 06:13:22 +0000
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
> Latch a transfer XRUN in both playback and capture, and schedule the
> existing period worker so a running or draining core stream sees the
> pointer error. This also retires a failed playback START during drain,
> where drain-init can already have advanced the core state to DRAINING.
>=20
> The stopped flag is shared with ACK callbacks that can run without the
> ALSA stream lock. Protect every stopped access with vss->lock. Read the
> pending message count under the same lock in open and hw_params. In
> sync_stop, decide whether RELEASE is needed and mark the stream stopped
> in one locked transition; leave it stopped when release or draining
> fails.
>=20
> Always cancel elapsed-period work in sync_stop, even when no RELEASE is
> needed.
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112053446.7350=
4-1-mynameisjune111@gmail.com?part=3D7

