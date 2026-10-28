Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793181481;
	b=o5GX41TVaRpue9NRIEF9JhkhuMKqwlk3E39kASruhD3I5s691QUGO8HFP9JLXjw7TgWi
	 x30fu5vvaVS4cVRVPm/Uq8CUoxDZX2Qofe2UD5h5gR7YRCB3wB4U50PccgpdG04B8Z8nL
	 O3fHDcqmMUNpC/eCD69e1CztRRmAagV7xioyekg8VLG0Bl0320D0F/ilz/6gtXxZUyEBJ
	 hDCUmFYu/7UcpzaONtHJD0o/slN4FrwNB4OXhFTorgmg3RQRWj7fPZkq/ZB6T681M38ZC
	 5pZdS7GWbmg9MMUsQjJzo/vLyLbO14pAEyetPudNkBzD6bmQwLpoF2kY5fbV+rlO5EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793181481;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2Zz+c3R9qwVDAWmrfGlt+GR4JRzYQWCIPcS0+X8bK64=;
	b=aeeHdYS6EE8x/BCTeD7+Jr2nXBJmhhmvG9yf6YoOWPtWczq46H+gk6PgjoV4Z9hqf9RR
	 XmO4/rGz3lmlBrAwnv98M/9W+j5sh6lhzYEqs5vQHBBuGnTQnUzDvGo6/ivZqRmUqZh+E
	 xCQXwcju3VH4WSUFgly5OE/HutIFVyO3bZsRvbL94JJOxXGQ0XTqRaqkvJw4vwvpbVwiT
	 FIxNQQC6BJyfI39AzjcPFnN14xtB1EW+IbxujHooopq9HePitOtKGQicc4UV5riRAIPSs
	 2AicjyYmfEix6PmEzZnfFToGTBpjWeQpSoivyTyHSO9GZ5ncFewSlHZgjrkzYsiCQSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NMntyzcQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653B2606A31A
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 09:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NMntyzcQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1DA1F01825;
	Wed, 28 Oct 2026 09:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793181481;
	bh=2Zz+c3R9qwVDAWmrfGlt+GR4JRzYQWCIPcS0+X8bK64=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NMntyzcQYkYS/jpUTTe2LY8HksmxwBqfwcMaSXGUNcSTot6AhiK6I3jxSowZ2BZXX
	 O4+h8Uoz3Zf1V7V+I5oZUqGYEmBTttwJDKW3tfJ3gVyBn6S/EAHZv9ga0K3NrfBheB
	 SDB6VBOaKs1OVfe0PBTnpWhbcg+rhj86ZoBPh8WHVk7DSb7m4gufEdanqRu251fO1s
	 OvLtbSuhQGCY4eCDlCV3Mr56nEN5Ab1lSJremZi5fTAy4MoTydqYTrxt+iiPpGUqWo
	 KIE4HcaK0X1AU3oZ9emuf6JvMH4poiNMqfWrYGYzlNlDE3fea+IeHfrBROhMKRQo5p
	 UymNp8d7UVwzA==
Message-ID: <sashiko-outbox-187708@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 12/16] ALSA: virtio: complete control transitions and
 preserve drain tail
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261028094132.20364-13-mynameisjune111@gmail.com>
References: <20261028094132.20364-1-mynameisjune111@gmail.com>
 <20261028094132.20364-13-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 09:57:59 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Pending signals can interrupt synchronous PCM state changes or the RX
> teardown wait after the device has accepted the command. Recovery can then
> issue a conflicting request before the previous transition has completed.
> Wait for SET_PARAMS, PREPARE and START within the existing timeout, as for
> STOP and RELEASE, and make the pending-RX drain wait non-interruptible.
> Device reset still cancels the wait and the timeout remains bounded.
>=20
> Track whether a control request was submitted. Expose that information to
> the pause-restart state machine so it can distinguish a definitive failure
> from a timeout or reset after submission. The next patch uses this helper.
>=20
> Keep INTEGER64 control values in the aligned response-data allocation
> instead of placing them immediately after the four-byte response header.
>=20
> Capture DRAINING must allow consumption of the remaining tail without
> queueing fresh RX requests. Permit its indirect ACK while stopped and skip
> the refill in the transfer callback. A non-staged drain test returned
> -EPIPE with v5; the corrected kernel returned the final frame.
>=20
> These changes address Sashiko findings in patches 1, 5 and 6 of this
> series. They apply after the included prerequisites.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028094132.2036=
4-1-mynameisjune111@gmail.com?part=3D12

