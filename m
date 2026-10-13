Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AEA3CC7CC
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 05:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791870153; cv=none; b=WKSO1DxEvznX9Kv4yCJ819tTHTADZRLmZzeO8gpXtK6S9NwPIQ8FGgbBheok4K617TT0c7ey1iqhLGfBHVw9ChERum1LpiotiDjoyTvqUIMIqKt8oxKeao2ne9lhIfeCEUe12t1oKP8hJBn4NX+Jj3hq1Qemt2MDdYkh++sisrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791870153; c=relaxed/simple;
	bh=uOn2NHhiKN52vyawHb+xFQ2QpdWyUGykpzA83cvd2nU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=AYtvMeF0XgtPp81TaiVLt4Kd0dpO6IrU7qfdmDLOyTlxIhn3fTUTwoxgK6VqGz0RSil7+CiIjBYAnjEiooRNuEdX7cka3o/IVMNCyzNlL/0RquNNV+0J54dxa0Ej8KOJdfSA2gfA3S3M9Guwr/6J3U8uLXVktWImGTLTEFxLFJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrBK2t1X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrBK2t1X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B711F00893;
	Tue, 13 Oct 2026 05:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791870151;
	bh=uOn2NHhiKN52vyawHb+xFQ2QpdWyUGykpzA83cvd2nU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nrBK2t1XtdJXqrpaIG1pOTDtUPB20kD88/LTrxjlGsaBErt8B/a5yLDVEW9KrGrlR
	 IP4ho7gsjSA4Pp7Tn+AxVbY7twv/C37IHfwEuznwircgE2XOTK3T+qtNXwFMWzWivb
	 O/buAAh5MIdhPS6AhEWhm4MQkyNfLQowy/BMStjD2ckhFs7m1Xz/5fV1IWLDKChF3C
	 hffOVAcF4knsnB1jwu3SLu1I3xj0mfmOgKleSHg3TKr5V5pKBB/G6YMXYdZTDzdenK
	 EhzCN5HdiQHqXIiTlfZOj8IU49Sf/BelBxNzt02srQA+c9wn9hVRxm8NEnEt6XJhQ/
	 rpoC58Jk746yg==
Message-ID: <sashiko-outbox-169004@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/5] ALSA: virtio: Recover PCM state after a failed
 start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <5f0fd9cf601921d24f07df051f990283e571607c.1791867377.git.mynameisjune111@gmail.com>
References: <cover.1791867377.git.mynameisjune111@gmail.com>
 <5f0fd9cf601921d24f07df051f990283e571607c.1791867377.git.mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 05:42:31 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Capture trigger queues I/O messages before sending PCM_START. If
> allocation of the START control message fails, trigger returns an
> error with capture I/O messages potentially pending, but without
> marking the stream stopped or arming sync_stop. If sending START
> fails, trigger also leaves transfers enabled. ALSA does not run the
> action undo callback after this trigger failure, so the normal STOP
> path cannot be relied on to drain those requests. Retrying START can
> then submit the same capture messages again.
>=20
> Disable transfers and mark the stream stopped after a failed start,
> and arm runtime->stop_operating so ALSA invokes sync_stop. Make
> sync_stop send RELEASE when the stream is stopped or has pending
> I/O, and keep the stream stopped when RELEASE or queue draining
> fails. Reject prepare, hw_params, and START retries until a later
> sync_stop resolves the outstanding state.
>=20
> Always cancel elapsed-period work in sync_stop, even when no RELEASE
> is needed.
>=20
> Fixes: da76e9f3e43a ("ALSA: virtio: PCM substream operators")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791867377.gi=
t.mynameisjune111@gmail.com?part=3D2

