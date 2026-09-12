Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B74F35C6A9
	for <virtualization@lists.linux.dev>; Sat, 12 Sep 2026 10:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789209449; cv=none; b=kRijGib4qmz/yf2AiFgpkCMr9jmKhdQwmowosuSBDAopRnfIZueF/Aqgoz5L1V3CUpkAnDqLfqQVN0Cv5Cuc122hcD1h6KHdJkcgOuhLQBSeqqwToAqoXyH0AmPlSSl5zmW4qcCD3zNb9SDVQ5JnyDVaSDWfJ7kADtOSBAdTXZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789209449; c=relaxed/simple;
	bh=rMwAIT0jUDiLIyjKor0TRwm61wRnQGvlqh17GveQ3IQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EpJ0kd9BA1PhP5TEPZoDN895AqbK9NgDn4t1X6j8mxENpCf3Qe+iWCrFifNm7mWZoYJwGJtbtb0tuEJzWDeWVlVsS+uSev3ytdIVTsONcXEglgPnMPSRwMG4qbDoGKBY0XRsc3o+N0C98Hx568bCVHUv5YpgNIPoK0hcvJq/VuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Py/ZOp+q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Py/ZOp+q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351E51F0089F;
	Sat, 12 Sep 2026 10:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789209448;
	bh=d8fHmkDfnjhch5wQTgZj+odHQxFncObA6Ekou9dTMpU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Py/ZOp+q+c8PeBc2+UdLF9mZujb/erx9qNfypA8PPn5z3pJAb9MafojfI6mefs1W1
	 /4gb6vy3C2d3iXf5M5NjvN0o8PxNzW2WuopPXAAcoUA5oaUkVH41zE1UpmiSZ1aUbs
	 c1SppSavCC5ZbbGF+CZZC3e3BYYWOxCWMiZku0QanXGsen4V6VKujUodoNtdUBrtq5
	 uaNuxjfgGJh0hY8ZFmuCMVC4JX3fRkeM5Bs3/bB7QYFdcxhpGWy9r2N6xVt6vEQQe7
	 /aymYYaiCphNETjFAV4z9oxfXlhBLu4rrTow8IqyK91APl88Hudm9jm9WLYjRP4Onf
	 sf4yzxvjAU4Tw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] virtio: synchronize callbacks after device reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <8ae2995ee649adcfe1398f7f1c4fc9f7028c3db1.1789204858.git.mst@redhat.com>
References: <cover.1789204858.git.mst@redhat.com>
 <8ae2995ee649adcfe1398f7f1c4fc9f7028c3db1.1789204858.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 10:37:27 +0000
Message-Id: <20260912103728.351E51F0089F@smtp.kernel.org>
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
> Tested-by: Karl Mehltretter <kmehltretter@gmail.com>
> Acked-by: Karl Mehltretter <kmehltretter@gmail.com>
> Assisted-by: LLM
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789204858.gi=
t.mst@redhat.com?part=3D1

