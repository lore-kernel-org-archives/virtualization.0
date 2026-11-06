Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985992;
	b=scYlPTDOiVDlbCya3mkQkhvHrQ7PfF6CuOE5yC3L00rKsh1TSV+kUWvHinhvrNe55HLP
	 Qt1WUF/8zCsjXKMC79TKa3Vw3mfhzuW69JJ6w4H7mr+gnlj/cBbsYY/1rt7YuZ2etFZ0r
	 PTataZzW3FaLMLgRhC1Xp6xrsFNkPO1rQpjuoT/JI+R7e1PbqIrOa7Dm1e8IPPW3IN1yT
	 1ROncR0dJP4Ep3YD7d2HLj273jjVjDUMsYRUNjpahtb8N2JxUmBB75BHU0AvZSfj5wPbo
	 k7mWRJjhtJzPNxnCN02mdfLM6gmjZedm8gmN+DUFzJ6l7e419M4Bv8SoRkA1oTqUwHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985992;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AFbMcNqN+JBuzRKctKtvRZpCV8C47mPdc6YTEEb1YCw=;
	b=D95O1xfZqI21T8QIvmqY/8rcZvPNA3pr7x/4mlH4XQRJlZ77cgoTshNmyFf7Xt8pbgkc
	 4qTKXF5fY4gu0gxxkjJSunTT7+fu8Mr93aHTArMBMbENoR0o106ovrHjWcGfgkGWGbLi3
	 UJqEz+/UK+Z7WOEjj8gJFCvCNuNQnXjYMPmeKS0R/wcQo/DpfwMk05Ehx+frZ5EpKCVN1
	 ZGPzhwVaLQp0PxwU4sgUQ1y9Nn0GUPR2bS9+lQ/40kZAfAL8zTZi2pRetE1nBciLUXt4J
	 94WTKWcwS8MBFD/40qPLAvVFOjh5cj25U3Sus0TPCk72WYo9iXBB/7L2b6IJkmSQwzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gonsm/kT";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84B8606A326
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gonsm/kT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222471F008A1;
	Fri,  6 Nov 2026 17:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793985991;
	bh=AFbMcNqN+JBuzRKctKtvRZpCV8C47mPdc6YTEEb1YCw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gonsm/kTIwx1wVnsVJUZQ0iblgU0D7mxTya/sDbV9XUQAjANRzrXMFAPmQMRQWEpt
	 MbfpjWP5R6SuXOICWm/ORTKufDxh6uuXOCmSKsWBZYWIhtEz/pb1tiEhZsoKiaCaNt
	 zVB+A5lpeqpkW9IPYFg+y+VPYVtWS20iSXJCnoiW1bv6AyoWOXQsqPrYUBMML44HUs
	 zshO8VxjEJeQsJ6bmaaDYay+to0B6j+JbrLiZ16XrIvSYgXOSeaD2kzKrzbvTuT+Wx
	 g9c317EOyTtnThS1LQSC1uYHCYV7I0JVLvYJlkn3J+XSCIhGWGlkvA3WvCvW32f898
	 FQChPvSljiB1Q==
Message-ID: <sashiko-outbox-201923@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 05/12] ALSA: virtio: Recover PCM state after a
 failed start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261106161838.94308-6-mynameisjune111@gmail.com>
References: <20261106161838.94308-1-mynameisjune111@gmail.com>
 <20261106161838.94308-6-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 17:26:30 +0000
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
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106161838.9430=
8-1-mynameisjune111@gmail.com?part=3D5

