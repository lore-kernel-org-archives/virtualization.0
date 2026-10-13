Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B0C3A0B24
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 09:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791883549; cv=none; b=VmV7OJVNcXW0LY5RSB2B4p3M0urHM5I8ZtyKsd1mwHUhlXqgMTq1aKhRx0OlxDezOw7xUvHOGemRy/oriRdbCj3cdLfOqXFHj8ZGijMomM4ACBzml1qaasRd61z92qTGUyDquM+KJF2Y7jPcn3AdKZr1Hd8Tw7VCpYi66mx2dkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791883549; c=relaxed/simple;
	bh=NvYBZm3n1Liz+5IlxpHGZ+oive3veh6QIbLUfZfIqb8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ZX7x+V0sAIvcfZzYcEMzAxl+p5cdAW2T3Om3iIcpwn+tfAjBAC9HYSTP5qBp8l5jA5TyGkXXsGzPXhjkW2oTtx944FXHmUiMnfpSVAmMmCBBDiWi8vElBPQu48/EGLDBjLzKq//hVP7Q8hbVLEyfOs2QLgkzNOhpv0ZahvbEvYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1SRbS0/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1SRbS0/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8D11F000FF;
	Tue, 13 Oct 2026 09:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791883548;
	bh=NvYBZm3n1Liz+5IlxpHGZ+oive3veh6QIbLUfZfIqb8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h1SRbS0/5Lfv9vItSCVBHXY1a37YKGFLB1zQtuGTxU+R5gCLoYKXQE0b+spK2TP4T
	 ppdFA1ySU9+btcI0U8HErIdLfmi6E+3IV/avpBlkY5DpHy8zTHr4Z//9zwXizG5xZE
	 VRXY4JlgkysR//DqS044zy5VBDC6/IrlE02waVcCIpePC8jNAXLVxXD8rOJjjx1j41
	 V/b2PzhgCrqIoid0entcQl+IyFwm7NLpRUGN3IlGXYpKtX4GMtpHqRmB/9cYI+rCL8
	 RS3EacPZeCd1GA6tqSc12WUnNyH2nek3huiQTIlqmEoAHlTsRn3m5wFBJXOpLAtoQj
	 IuaXHDx4NBYzQ==
Message-ID: <sashiko-outbox-169327@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] ALSA: virtio: Recover PCM state after a failed
 start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <e190adbdcb15294b8146cc2f64c43bde5e6a28ff.1791881787.git.mynameisjune111@gmail.com>
References: <cover.1791881787.git.mynameisjune111@gmail.com>
 <e190adbdcb15294b8146cc2f64c43bde5e6a28ff.1791881787.git.mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 09:25:47 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

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
> Fixes: da76e9f3e43a ("ALSA: virtio: PCM substream operators")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791881787.gi=
t.mynameisjune111@gmail.com?part=3D2

