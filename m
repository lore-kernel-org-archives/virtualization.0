Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794357293;
	b=Kklr2W2dfXrtnbeNekugc0nOypORLCAu5GF3iP5IXxgV84OLbGbfdN8+g9GdO7NkvZt9
	 Nplk8L+FqWah3A+19CglHfuI1nlXYlFEaiTA3INW56IxFZlE9DOPhkOFIoRUlQ4N5Yk0P
	 fW5alNqwoDP6OLNWj2RcZEzLuabjYwn0smugEIVLSreV5nFMT51K5GNS70jP3YTt/Svyy
	 /e5MZbUHdufQwOISd3zn5rWS63x6ywHbhVPezNi3OlfFcxWnro09f8ZpejoY8PBywb6cC
	 F8GM5Te9OGkAB7Mo+mzH0IFauv7a7/Bw3w5seNWS0eI3zQQlyOKwxjIRx2+uns7vH0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794357293;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YkF/HwbnjPkCaPTy/9vZP30XQaHD/SdZM20GgfrPuDU=;
	b=4K9AO8CXsgOuhv6V01JM3QOhetj13CGq8uo8r3nhUeZW5ABSvmY82uB4NQVV1KeVN4Vm
	 3PW4wNLm7mRlEYCmKrHk/G8Kfvs1RvtlAcOD2r7ZweTlX9pY8bxm9AphwOVb78cTlr4kA
	 S+mWrbHRkBWm9JEb3Dn8xIH0H/X41dksnkEZ3wo2WzpitiMPgAhcXZsb8o7Si47dJnkXH
	 GCtMzSPnTjD4FfgkCzVBl2xtXX0h1VOzntm/SYkLgnK520Tg7thvvgXIsQ5F+VQvcfs6K
	 nIf6rqmEz+tnZHAsjd5BdH+Up5hxvdbmEM+SoTuNvi+Ka2ME4XIbQtkE+RUwwZZ9cbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VMhHUFGC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AF0606A31C;
	Wed, 11 Nov 2026 00:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VMhHUFGC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43081F0089F;
	Wed, 11 Nov 2026 00:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794357293;
	bh=YkF/HwbnjPkCaPTy/9vZP30XQaHD/SdZM20GgfrPuDU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VMhHUFGC1pld8b9qsQbWTchaHPLtgww/RDmcatpiR4kOjfvZHtlR97xJXf/AsfgJ9
	 5/0zA/2KjNWgmP42w6DnLtBgxgpzR7CGM/WXj7qzIQuTm6U3VOA2Tqi8HN8QPdBY4o
	 AwXR+lqn9LhixcZneYwTZowVfpTa6hR3aBaCcDro7V1GqR0juvYgPW1x8r59VxHi++
	 AqRtjS1CKijoE7pbVdzgv2LxKQNmGU1WDnBUnMmkNtQdEwpf8lS5jqVgjMPUtt6i26
	 BQfzxYZ6If3YKA/9Ef1/yyA8am9bwpWwV2RoUk3WBcdXnQ/MGGjwy6MXHNpSgMBMy8
	 uw4kEjmrSG9FQ==
Message-ID: <sashiko-outbox-208025@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v24 06/16] ALSA: virtio: propagate playback send
 failures through ACK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261111000543.28550-7-mynameisjune111@gmail.com>
References: <20261111000543.28550-1-mynameisjune111@gmail.com>
 <20261111000543.28550-7-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 00:34:52 +0000
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
- [Low] ALSA: virtio: missing Fixes trailer for virtsnd_pcm_pb_ack()
  error handling
--

commit 3596501a89f0fc9dc71bdef6501f19077abb9bc2
Author: Joonho Lee <mynameisjune111@gmail.com>

> ALSA: virtio: propagate playback send failures through ACK
>
> Propagate playback submission failures through ACK and commit indirect
> accounting only after transport submission succeeds. Keep the PCM state
> and buffer-access checks synchronized with playback transfer admission.
> The existing capture ACK callback and initial queue reservation behavior
> remain together until the request-owned capture conversion in patch 12.
> That conversion introduces RX reservation, validation and refill as one
> contract.
>
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

[Severity: Low]
This fixes ignored send failures in virtsnd_pcm_pb_ack() ->
virtsnd_pcm_trans_copy(), unrolled msg->length updates in
virtsnd_pcm_msg_send(), and missing xfer_xrun checks in
virtsnd_pcm_pb_pointer() and virtsnd_pcm_cp_pointer().  Should this
include:

  Fixes: fe981e67568c ("ALSA: virtio: use ack callback")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111000543.2855=
0-1-mynameisjune111@gmail.com?part=3D6
