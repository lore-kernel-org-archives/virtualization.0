Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D2E50129B
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 21:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790112070; cv=none; b=s/Qf3UupnLo0LUhUvoz6bPVAxx2MLqirkNXaKzQZ+50Ky4zgj5lDm0GHLzzFsUtdbcS7o20jR61sq589y5MgNp0AQIbmbCZWJBGQT0GutsRMH94PGXcLlIYNHvX0m0ompuFZgoNfzGl8hm7rhNIrg8bMV5qXrJlCSS9wMOu9n6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790112070; c=relaxed/simple;
	bh=9KTsxIsOtAqCD/hKL4EnNraZLdcCejXvreT+IW78x54=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EadtZb7lhtrE9yJuJhS42ppTbxiZML3oFQg3jV3oQBgYnBMyW8mpQs8gOclA/fbevtbBoRzvs3/fKZRTuH5jkjyYHteoJqaNd8i+IMPtnbpVffz+g8TleMp6Uj6jn0ipQ+P+SmGC5aOeYGgptpcnAvmJzcarIoDK4pKEPxldEII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbGTpQOO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbGTpQOO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE801F00893;
	Tue, 22 Sep 2026 21:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790112059;
	bh=6F7tSYM9tAiHqqBkAbs11ccB7ngWZHbwmQB6tVkrsF8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kbGTpQOOxXN95IAgyKn+CKZ/xQ7mPAJciLfu4rX5TqZFrKsK4yyQAEianTZN9DI50
	 w2KRgX5FF7FHehUcN5+H0YyJPagLQpVL99v0s51D9n4TRPjlL0ey3PfeDsHtne6Acw
	 EpmZhRZXt9gTn6kmujCMc/WCGSE3UhENxFJD4S834bAWaWKGHuqrQa6n/+Xa7bQ1Ix
	 1BIflvlMKUmO64jnmPl4VZEHrAV22/4VVcfOR4DCVUW+cTpXcW4jqLQPWDLpPE0MLR
	 3Xf/k7QQP6CTpDA4SJCQTaEgiNK9Ur2y7Ba3XSkRqaDzAMxAIn3aVjaSiPbU7hLnd7
	 E/4ksawUPkIuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] virtio_blk: Reset device on probe error paths after
 DRIVER_OK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuho Choi" <oss.patchbox@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260922211207.523999-1-oss.patchbox@gmail.com>
References: <20260922211207.523999-1-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 21:20:59 +0000
Message-Id: <20260922212059.8AE801F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> virtblk_probe() marks the device ready before revalidating zones and
> adding the disk, and either of those can fail.  The out_cleanup_disk path
> they take goes on to delete the virtqueues, but nothing tells the device
> to stop first, so it is still live when the rings are freed.
>=20
> Reset the device at out_cleanup_disk, which is only reachable after
> virtio_device_ready().  virtblk_remove() and virtblk_freeze_priv() both
> reset before deleting the virtqueues for the same reason.
>=20
> Fixes: dbb301f91fc8 ("virtio_blk: add error handling support for add_disk=
()")
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922211207.5239=
99-1-oss.patchbox@gmail.com?part=3D1

