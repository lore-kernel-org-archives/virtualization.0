Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A96C2EC0A4
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 03:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792120015; cv=none; b=SpTK9qQCYwm0jlkXrA5j5ARw9XtR/36fFPVeLEWSrDC3CzkGlnTGXILHd6lTIWJYgDSZ2+5CV1MHVfqyqwKja8dD9xz7iR39rpd9TzwoORW/1MjTGVg2cT0uOtYAv7YhQqwoGOAjKZVaN+zbe1t86JixP6HkIr92l0e/XQ9BziY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792120015; c=relaxed/simple;
	bh=n/JaJBUpft1JCRYyAP3VPRcD9eJqAecl1hlA1nIDfKI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=V+7sRLCUXRvHad3nHcjKWvM1U9eTh552b06dSB5b4cM4agHb8dt3GB4S52O2F9/MuRYIhWaeGuEAMJCJL+a4g1RuLx+L6iuBghB+Qyas6MImCfxRTyzYvneVpLu6qNHFW4kpfJQappfwC12Xp+fZ+b4XFncQIMii5+7Mw2cg6oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5CLn/Aw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5CLn/Aw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787321F000C4;
	Fri, 16 Oct 2026 03:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792120013;
	bh=HD5w40BeBi0oAsvg1O+aGoczdTWvaT+gWAcjjL+F4UU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f5CLn/Aw0dnNFafjMZJOUiS4Zez90kE9vRq7Kt8uzboLnaDmgdLis9fZFswDi7ice
	 c0IAwnXw7M1Lf6hMuPO7WyTZWZyT7wIM4WnsT9YRlHgjVKFY4E11yY4ZIj1gcD5Vq8
	 bDLsLb/Fm/uPF+JpQ0mEBk3H4OI3oU78A4aiHCFzTOl5fgImA1tvMSNMU3QzAkl46B
	 9WV8qjeNGoMvPbjI3bKW6L84JKnBXFIb+DzmKW3SCxTwg+4SdrczvE0ZUgxce0jYsE
	 MS8fb+faLIo8jstJ5zlXryx1tlTPPQbkAkwvLeobDHWaimsrwKllFlPnP/Gbg5Iz31
	 0CDzt6bmo3kLw==
Message-ID: <sashiko-outbox-173647@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] virtio_balloon: initialize wakeup_lock before
 virtqueues are set up
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mingbing Zhai" <zhaimingbing@cmss.chinamobile.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261016025429.901-1-zhaimingbing@cmss.chinamobile.com>
References: <0e69abdc-0127-45dc-9bc1-bf48772cc7ea@kernel.org>
 <20261016025429.901-1-zhaimingbing@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 03:06:53 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Since c578123e63da ("virtio_balloon: Treat stats requests as wakeup
> events") the stats_request() virtqueue callback takes vb->wakeup_lock
> via start_wakeup_event().  init_vqs() registers that callback and even
> primes and kicks the stats queue, so the lock is reachable from irq
> context as soon as init_vqs() returns, long before the driver sets
> DRIVER_OK: vring_interrupt() dispatches to the callback without any
> DRIVER_OK check unless CONFIG_VIRTIO_HARDEN_NOTIFICATION is set, and
> that option depends on BROKEN.  syzbot hit it from a threaded irq:
>=20
>   INFO: trying to register non-static key in stats_request
>   ...
>   assign_lock_key
>   register_lock_class
>   lock_acquire
>   rt_spin_lock
> [ ... ]
>=20
> Fixes: c578123e63da ("virtio_balloon: Treat stats requests as wakeup even=
ts")
> Reported-by: syzbot+13df72e0dc4be5c62215@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D13df72e0dc4be5c62215
> Signed-off-by: Mingbing Zhai <zhaimingbing@cmss.chinamobile.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016025429.901-=
1-zhaimingbing@cmss.chinamobile.com?part=3D1

