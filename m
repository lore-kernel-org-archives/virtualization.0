Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0C841D20E
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 21:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162649; cv=none; b=M6XsI3TBrud/4TMmIeLECZZUXQlUg48sCcIsmzrb9Ha3OdqelBHRB/DNIuH52tVnr1EYj3M66dDDvmkPfXr7QsBcii6aJ6GpTUv0fYjFEbasTV3pVmj5u8ddfVYf3jzka78mZUyv+v1j3k3Kkyaix3APk3Eqdkg+xlWrTC9dq6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162649; c=relaxed/simple;
	bh=i0hT857/tXt7UdwMl4vI5SwaEYveCvsQmIU2zy46p/0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nCQXgK+xAvec4l0MDEoQXatQDl7qU3oWMnGbXmCxpm/KQficATfl6GMXvpifmo8Cslbe8/mNaY03pRumStcRHenR4ApRszSsIXsC5bhCzoLd8dAFQnlTuj/UJQkDti0rTxfA7YXgYj/aWwQs2R8qLt6BNsrt8OARAZYogmvhlZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2TpNgTa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2TpNgTa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A901F000FF;
	Fri, 11 Sep 2026 21:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789162648;
	bh=xutBknwR8Ac6iOd8DBIfr+vi6PPnz/zj9GWS2o/MoPg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N2TpNgTankAi27eONgsmCX7zUif+Ve+02+SAQK7zLDuLNVYQ21RBivViqpemVyE1U
	 6SUYv822MwuYcxMM0lpKODDzyv5EILQLMW/5FH6/r33n4gOuFOHnJCXp8/UTrYIVsg
	 ofcFP5bSo5Pfx6t0/SGj2cB5sZa5Gkubt7Xue0VrSfjjca5O5tNCdgOJZXYQkL7raZ
	 ixcikX/DL6FAQGavk3qeht0Pcp37y4A2/XD54He0DDeHQ+e0nKSD1KyOilVrtcTVSk
	 PNM4SnFUL6IAJ/r6o8W0XgOqkyS6n5KlOQJL2FmPpL+gLyc6bd+47EyK6vhamCdKrr
	 7ERDD48ft5blw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] virtio: synchronize callbacks after device reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <01295278b402c2856b83568e07c86853f2d30e2b.1789160982.git.mst@redhat.com>
References: <cover.1789160982.git.mst@redhat.com>
 <01295278b402c2856b83568e07c86853f2d30e2b.1789160982.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 21:37:27 +0000
Message-Id: <20260911213728.15A901F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> virtio_reset_device says:
> 	Note: this guarantees that vq callbacks are not in progress
> but in practice, only virtio pci correctly synchronizes the cbs.
>=20
> On other transports, a callback that is already executing, keeps running
> while the driver tears down the state it uses.
>=20
> Add virtio_synchronize_cbs to virtio_reset_device fixing this for all
> transports that correctly implement synchronize_cbs().
>=20
> Reported-by: Karl Mehltretter <kmehltretter@gmail.com>
> Link: https://lore.kernel.org/all/20260818040433.66986-1-kmehltretter@gma=
il.com/
> Fixes: c46eccdaadab ("virtio: document virtio_reset_device")
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789160982.gi=
t.mst@redhat.com?part=3D1

