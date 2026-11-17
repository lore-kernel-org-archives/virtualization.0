Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794928931;
	b=d3z/87N74fDWQ7Ms7TqNva2QrW1jGGSiYXvvs8d5pYo8/MeyDKx/x64CmosmTqTpGats
	 /dtws6OqxyhmFRnHm0mlbDif4HMY6tw9E/DR78sphOSybkKXqBJcQXyXVLuxsbOZBInhX
	 quekL2ajvU0KtTFuy6/jTqbM5aQhTSy4gMHn3/Abu1vWxH1c87f7/kfzUl+oKAdIt0Q5k
	 GWuJ2/A85EyJKaSrxM64cKpYln7TZAQlTZySYCLN5vWaNa0ZvdkymIzcrSgMn4ksXneVD
	 yAgQwnoHvo7EzeIpBcauoouAVIa3jB7r88IaD3oZafLa5A2KbWqPACEKPddEyPb6WvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794928931;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vO6vCb3YpKQ2ldIS6bDX3ong+sI2GOsfk9cbd3HouCY=;
	b=4hsMVCE56Y6xQ4BRqrazVix6jKbEo32Sk32hnFDHoGlphY1OKfCxPmpieH9D/1ezpjzF
	 4qrhw1PgV9luy8jHebf/beCTEOSyonTjuhT5wP/Llm20yFOgAsMlb2eoooBjRypmPeBMf
	 HO6QMsEWOfFQKSs3PAs0TQmcNfIudND5tzuRWhbzpQWc+GfuzrJgMo7kJS9IQ+X0miW8u
	 jcUvSkTN4a8s7tZ0p8IOUBeJrzouDlKcCDgmCm9CqqNWYX9d2NOk63tu5ZsvU7N97Oz8s
	 as9ch3QIDcjWUwj/h5RZ1qWsHjQynltGEJbqlavLeWNOHbUVQ8py6cNDvzwPjMG+Y/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BBDebEJp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AB6606A31C
	for <virtualization@lists.linux.dev>; Tue, 17 Nov 2026 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BBDebEJp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9186B1F000C5;
	Tue, 17 Nov 2026 15:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794928930;
	bh=vO6vCb3YpKQ2ldIS6bDX3ong+sI2GOsfk9cbd3HouCY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BBDebEJpHdPFIrYdEM9xyY2EpNhw09Ct35zQXs2ejm57LHQffFgkVJUEw5cO51bva
	 hWPGobCquOHcQyd4k4ExFwQgsL2jM82Fn5qXkU34N0Jth36wpFckwsAHv4D+x7wh4z
	 It7XDBli2xMQiPBEtiaIAFB8SWMySG+30xy1pEKM6dRvb+Pg1oUg/bWwxn1TlcRT//
	 OmYXMi8tJWeDdl3DQOhwgf1oXA435qzrnH+Wd911SM+yPHrsR2VyYTHQn3TTTLQK0W
	 e4ZKrkkN3TAMgsaXB1+F0TPP8dUtGc59bf5vBxYOVn6FtXnxaWiwOscc2ouw/3qKYA
	 0J3c7QFcu7SUg==
Message-ID: <sashiko-outbox-219054@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vhost: synchronize worker freeing on vhost-net teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yaohan Li" <shunsheng1218@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261117145314.1092372-1-shunsheng1218@gmail.com>
References: <20261117145314.1092372-1-shunsheng1218@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 15:22:10 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> vhost_workers_free() only waits for RCU readers when sync is true.  Both
> vhost-net teardown paths pass false, relying on the assumption recorded
> when the sync parameter was introduced (5efd97e6f0c7) that "net and scsi
> stop their virtqueues before the workers are freed".
>=20
> That assumption does not hold when a tap queue is detached while the
> socket is still attached.  __tun_detach() runs tun_queue_purge() on the
> detaching thread, so skb_queue_purge() releases the zerocopy skbs and
> vhost_zerocopy_complete() -> vhost_poll_queue() runs there rather than on
> the vhost worker.  The vhost_dev_flush() calls in vhost_net_flush() and
> vhost_dev_stop() only wait for the vhost workers, so the queueing can
> still be in flight when vhost_dev_cleanup() frees the worker, and
> vhost_worker_queue() then dereferences freed memory.
>=20
> Pass sync=3Dtrue from vhost_net_release() and vhost_net_reset_owner() so a
> [ ... ]
> Both teardown paths reproduce the use-after-free on this base, and both
> are clean with this change while the injection is still taken.  The same
> injection reproduced on the earlier base where the analysis was done.
>=20
> Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117145314.1092=
372-1-shunsheng1218@gmail.com?part=3D1

