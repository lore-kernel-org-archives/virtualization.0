Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794201662;
	b=Ehp4GlnUpKM/D8hbcSufurdTv33tP+iEsTsgnKuOqOpdDgVaV0YAGMa79GV7HMlimDLr
	 +2HLdaaYEdUJE2w9xb3XlLW2tl9DAEfwvXXkWpf+HAFUfVTuoV9EAZkE+i59wGyVso2Af
	 5ugSfTtmSeBHXSxZnVIIwIm/zUixCXcWh0jnk34ZP/offFrx70Hb6JbefF/qklkOksFrJ
	 wRJqtVyFSYr0NcKh97NE3TzLbOeAdZfu91lNx9bo0cZmGXC+2HaGmd1MPLrYhv/l/2elW
	 P7g2J1PYOUPXvSWQOd1E0d4c+sJvaZKGohNRknaB5eXoQmulfC097ajB4O1Bgkv0nRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794201662;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=69C/O5LXwhlVhr4g+GCYycZ0amqAQQh/h7oh0CSWizY=;
	b=EzTByfkBd8jdQ9B0q2Z5jlXSpKJXpo120jJ/4LP323guXRhutecCwl0nm4k5kks0Kzgp
	 S5RWwE4s2Tb3h09W5V/OiyjTr9b9pKt1HqTmX30+IxNbLrJQwY4nKufX+O+Hd+1O+efkq
	 w/bLEfqDw4pw1YJzo7gkwZKbVZRLYsjx3yTK4+1WuUd5/02eGblZCvTGwaKEj8znOiGZC
	 Rphancug8GJV8fQ9L/gsmKqW1XQmdfn8e1xqSQpCNoC55/wm3ac8YbQLQu0KiPUf+HFA8
	 B/zI2SiJy1xiY+WQDiWo+9mX04ze3IsOrK1y54YIvwr+7GIU9dazooIWSEDsu5FPQUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g7rOkKsb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8E7606A321
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 05:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g7rOkKsb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E0E1F0089F;
	Mon,  9 Nov 2026 05:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794201661;
	bh=69C/O5LXwhlVhr4g+GCYycZ0amqAQQh/h7oh0CSWizY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g7rOkKsbcqkFyICFt9ktUTmgjBDP2Ga5K4q1rzbNkKTAd8cSSYKpRWt2eWyoyrXRh
	 rcWIPZviuykgShCYEOzAYqduO+bPI2XosNJwFh7MAAF+kj5qj4+AsBITfzgmLlnTcn
	 5W0HDTlIRP9/UbI2iF4zPN9QgWe6Mm6LOoMZ/tCtl+8roD2xoyAwdWQy/3sVgRRuit
	 hBkswHoIKupUVtAw7mKLRObJQXat5AVMzOGE7Y98xrR6E5MDxxOuqj7IPjXtxyANKF
	 +S8zWK4F4B5zReuJDiXmcW2iG+f1DIjgwT8L/SCYLqinsWkKnde0ozVPBH4hiXuufL
	 r2PJezzc6bQVg==
Message-ID: <sashiko-outbox-204429@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v22 02/13] ALSA: pcm: report partial progress under the
 stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261109051618.22506-3-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
 <20261109051618.22506-1-mynameisjune111@gmail.com>
 <20261109051618.22506-3-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 05:21:01 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Staged capture can make readable data available before a complete period
> has elapsed. Skipping notification leaves a blocked reader asleep, while
> using the period-interrupt path for this event can infer a false ring
> wrap when the notification is delayed.
>=20
> Add snd_pcm_progress_under_stream_lock() to update the hardware pointer
> through the non-interrupt path and notify readers and fasync listeners.
> It runs under the caller's PCM stream lock and does not tick the PCM
> timer. The driver must release its pointer and trigger locks before
> calling it. Existing period notification callers keep their current
> behavior.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109051618.2250=
6-1-mynameisjune111@gmail.com?part=3D2

