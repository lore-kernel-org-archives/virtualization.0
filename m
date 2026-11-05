Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793863792;
	b=a7H1HEDmFGKT76vXniaQJolBJZDDK41cdBbfBKRDaJfgEgwUXTxN0SEwEpIEk+rssp32
	 EecvCu+vjmBTisAj2JNVsRr6Hle3LRAZK54IMlSvaf4PqbYOQ3ACDA4JJ5J0hYphAwlVM
	 6f1Uq44eH+WMkgpvKy/OSCllX9ctJQcEl6V1JNxWbhT8FPI3hf8VLmURWhS1wosu59w0L
	 RE8EW7l61/pse/keWu8E7A11Xp/R14ndJrULXCsugA1fqski01huLuPXTsUsE5uVUsnmN
	 cgD6683d3vsC7Vr1HHT88eh4Juzit8ZGDp6M9dAwfem/4e/obqAdwdudITsCoAde4VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793863792;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7l41Ox+HJm+vkx39L9MGaiJPmqLmRfs2ElBtTM35BNk=;
	b=lr0UHHzO880ZueymGZkdhBvNk0DqhPyIyzqLdghECBRr1nj80SZ/4UVZI12QxAGiwDl7
	 5l3eC6zfiY7PDxUiQwWfxz+yFHaEZGTNg79GEpJQrHcPgCEKQ9CaQlG7iA0zPfXyFxLa5
	 k1oX6GlpegvwOAX/z7J3Iob3WApDaehlptPie09s9HRX2CMgzFVZfjCz9uB7lkZWF+qK+
	 rgbLZ74On2M1ZkVPTC5USobPxUkSi8UVhjJJVWL7avlOY7i8uRdcG3VFymCMQ2O8M+7e+
	 E1eiM2wZRoBwS6SXWpTzR8+QdJl8vMLS2+Iht31G6GqsTbuw0ol6Vk3rKEsY5O/TJ6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fOEWrihV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AC6606A31B
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 07:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fOEWrihV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9F71F000C1;
	Thu,  5 Nov 2026 07:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793863791;
	bh=7l41Ox+HJm+vkx39L9MGaiJPmqLmRfs2ElBtTM35BNk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fOEWrihVwexPJr+lk1+CSKjx47K9eJYI7xWyPinvbo59bOWdJEZf4GZ6rZwO88YBB
	 T522TiHP+939qXyR3mWIdSaKaXVpfRJ/xNmiMpTqsHuyAB9IEiBbMr1EqyhfF78vtx
	 A/EVoTdp3lrlwGOTldh+LFQUs/qsdpbLOQHe3Wr7SFOv5OCiDNyPeqSV6dPOWP8QY9
	 a+dNNL9aRmvSMe+EtPIGLjHU9Ob3NvEAWNyGyWzA+RzBcLvK6evUgtNDVpfP13fSkp
	 uOgx/b5i9wpgfDbSWoTfSbljmRRMOoYwuXwY3gJQ5AqsRjTKUdpzLNAAKG7zHROekr
	 pHofIaT9qwaTQ==
Message-ID: <sashiko-outbox-198669@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 09/12] ALSA: virtio: wait through signals for PCM
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105070845.6449-10-mynameisjune111@gmail.com>
References: <20261105070845.6449-1-mynameisjune111@gmail.com>
 <20261105070845.6449-10-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 07:29:50 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A signal can end the interruptible wait while a STOP or RELEASE request
> is still pending. A later teardown may then submit another RELEASE
> before the first request completes.
>=20
> Keep both waits non-interruptible and use the existing message timeout.
> Other control requests remain interruptible. Device reset still cancels
> the pending request and wakes the waiter.
>=20
> Keep completion timeout and wait return values wide enough for the full t=
imeout range on 32-bit and HZ=3D1000 builds.
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105070845.6449=
-1-mynameisjune111@gmail.com?part=3D9

