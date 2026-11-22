Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795360870;
	b=ZOzSexHl1KnWbhNsj3W3dRALhO5HZdReYhbDOnQS9kzwBqHmVDxcvY59v/BAxdbKh8aJ
	 0AECzTVdUHkr053xN3LtgIoj5atiSCbmqrizr4x4d4hn+ntL5QT/tdTUiHUoALMcfosmd
	 5YYON/xvOGyZ00j2uhofQrVll3egOHW/V+m2u97hPOZOIyx9esHwcB7UMV3ol4aCYgt0M
	 qSjTukYTV60iURmVrjRUNzC+OEeiJscSev136W6m7YSlj1qiDVCNG9Qt4vYwnRMSKIz2d
	 bbDxBkkVFf9fjNegHBh5YBtsjqvvCu5qEhQHk3TmGTkKfJD6NaQ/cm1MjF/Amfqmjbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795360870;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OJCYba84rNtrSz5kZ0VF8mnQi8/Mfn3+Ajgn20LG5/g=;
	b=4nPhRT84DvMKzm4euu7QPtI1cltmsFSgMak4GSp1Ax/rr+TzlzfhxQkhFSi95lJH0wvR
	 DZE5Js5BiOTs2LAf6bk+pgHTNupn+spMHxKNI3Xs0ZLQDr6inyhz4J1gGD6cke/vHdrQK
	 tb/sJ4gB6QQvLEq10CYXgBwMtVA/r3mqid1Wl+vFOk9HzryRtYNiwP3jvYX1igRLx52Wv
	 kRmt5DCMaV4SVft2DKrhFKByD6uurZYaOwcECQAEV5xBNm/lj040X10n3iAFxMebNNMXu
	 FIMUOdItzFWR8sKNftVUxB8EWgkJ5sYLrDNIzDpHC7r3edbtRGwur65JqBAU5hk9Swg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dX9k0eGc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2312606A331
	for <virtualization@lists.linux.dev>; Sun, 22 Nov 2026 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dX9k0eGc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BE01F000C0;
	Sun, 22 Nov 2026 15:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795360870;
	bh=OJCYba84rNtrSz5kZ0VF8mnQi8/Mfn3+Ajgn20LG5/g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dX9k0eGcRasH8x2jDTe2oXSyqA2AhCXGiW41frwKAhNJIQK3lph0uTRmlaVVpqR2a
	 S0zKF6B26Y2tpSMAg5cjvlCyovZ6KKRDT6MmaizYiJ4/iF3xfChIIapPWsaF4iQVk2
	 RJeI4LpN0kFknojmjW4UTNffEH3PM529YXvDfmMLK8Q0uGaT5t+9CJ7KaMg+eYyu4C
	 DQe0hcoh7czTbRLKz8bM2Tg2FSEJhMjdwF9Gwh3fFAHYVSOVcOwVHRk1YGxw7N1ezR
	 TUYmzPcqYJ+FaYwMCsbDrmQXUJ5VeCfsjtbTOmrcJZXVTPQh4DCVMGJVl2vahGirJM
	 THKUrWOPjI7zg==
Message-ID: <sashiko-outbox-228038@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/qxl: zero-initialize struct qxl_release
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?w5NzY2FyIE1lZ8OtYSBMw7NwZXo=?= <megia.oscar@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261122151629.223013-1-megia.oscar@gmail.com>
References: <20261122151629.223013-1-megia.oscar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 15:21:09 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> qxl_release_free() used to check release->base.ops to find out whether
> the embedded dma_fence had been initialized. Since commit 2bcbc706dfa0
> ("dma-buf: add dma_fence_was_initialized function v2") it uses a flag
> in fence->flags instead, but qxl_release_alloc() allocates the release
> with kmalloc(), so the flags contain stale data.
>=20
> Cursor releases never go through dma_fence_init(), so with a stale flag
> qxl_release_free() takes the initialized-fence path and calls
> dma_fence_signal() on a garbage fence->lock, triggering:
>=20
>   BUG: KASAN: slab-use-after-free in _raw_spin_lock_irqsave+0x7b/0xe0
>   Write of size 4 at addr ffff888010462700 by task kworker/3:1/91
>=20
>   CPU: 3 UID: 0 PID: 91 Comm: kworker/3:1
>     Not tainted 7.3.0-00341-gf47d223627f8-dirty #556 PREEMPT(lazy)
> [ ... ]
>=20
> Fixes: 2bcbc706dfa0 ("dma-buf: add dma_fence_was_initialized function v2")
> Assisted-by: claude-Sonnet 5.5
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: =C3=93scar Meg=C3=ADa L=C3=B3pez <megia.oscar@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122151629.2230=
13-1-megia.oscar@gmail.com?part=3D1
