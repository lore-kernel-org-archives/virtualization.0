Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793339441;
	b=OGFymQl4n4mM2iQWQ9zkF9+nuM5nUlB/AJV1BQQlp+TSFLzGuswrvRKEqs1azLcZAuZH
	 3m1OyXrexi2nfc1SfAQwO4sRwh3pteerQdls7GVLTXVpGaBUUL282HL24UghPL4ZN+yvE
	 n9/SDX7PIbmQDQA3AEJXqKU65DcWUj9Y4OCmJJo5apq+1IcUfA8MvoMGeeh5e1nloDFlg
	 Km3Ay2PT4Vjr91i83XZOEUEDQkaRj0JjfyT713sywS7C34Ka0Upu3n003o+OKldH/9In7
	 HDIU8G11e4sLHcODq5G0H5F8sMEp8b04znzDmxcHSvzDKEbOO0DV4KmeKiAMj8Vzcsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793339441;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yZENMQPk6n2a6PknDU+m/f03pHVRrBu77q1crRttR38=;
	b=VNL7S94jEkNmpWL6lY9R2ZviJBEOU44xDMciJVTF4Kv5yfiUo73iNrjO21ptkagdNINj
	 lGsYP7u7mkSlo6MYl/M+eoQKBQSoJLTQjNFkCtlQ14eo27WHGa0Y1EF8S/49f/C3vZgco
	 kzMyY3QqR0SBOnSA33XWs8FLIX38sCAIbsTj3HqGT6u67n0/52eCUA3j9yHxrB7CABGyI
	 oNu6NAi/6P6iNmBmFMJ87DO4nQfzeK0d7XxSWUK/l3iMBfvDERYO6LnC/AY+m1QHj8eK5
	 Og1q20fI/irnoY9KJbM8nFRCQveIGqnkGhPs/erX31BQMklCw8otWwYZiz5BPZi9/cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pax1wMIi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1318606A32A
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 05:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pax1wMIi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C661F00A15;
	Fri, 30 Oct 2026 05:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793339440;
	bh=yZENMQPk6n2a6PknDU+m/f03pHVRrBu77q1crRttR38=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pax1wMIiNFEYR73qZ+joY1ynYyoK4T0R3jnbKKY/RT53mwhTCl6Tjzr8FoqZljhUI
	 9FZkywNVQ/UppUrsrmwhmk+YvDmFn1AnnJJ0b1uqoii3LdHvnivfl5qHWSdNPwB5Mn
	 uSIQLaDNhbLx/Sm4cYBIjDhLYX88exlbgM45kXHTZI0EISmwKJsOehu/tv8hS1Fg2X
	 21P7mo14HDyBpALzTYCZtm/2+bjtJH6neBEASn6pEwF/qe9NFEwVSH4IrSUZjoVN0m
	 uAPLQmWPg152Hv2/gmDarNmzsOEyliiOBVHDKzZXlQgxFU9h6/W7borsavXTYgDTD6
	 0yZ9F5nH1Obxg==
Message-ID: <sashiko-outbox-190577@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 02/14] ALSA: virtio: Recover PCM state after a
 failed start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261030052629.27742-3-mynameisjune111@gmail.com>
References: <20261030052629.27742-1-mynameisjune111@gmail.com>
 <20261030052629.27742-3-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 05:50:40 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030052629.2774=
2-1-mynameisjune111@gmail.com?part=3D2

