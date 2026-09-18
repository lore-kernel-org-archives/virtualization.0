Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8C8238C16
	for <virtualization@lists.linux.dev>; Fri, 18 Sep 2026 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789740738; cv=none; b=b3e42nh4ur1kxE4l+R33nlWf/EHTe7KN0NuDMnbNsI/B631nN3b+kxf42WBmX6iqDj8KG+umhbPlKXR5kYa/Y9oQ2aWEmPYEleKzEOxN2rhZYtPucyaXco2M2quml5lI51VIBluJbXP2C2idyW9zhVIcfPGC7P/BK0L1joXa7ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789740738; c=relaxed/simple;
	bh=Slbbda9XWW4XrSOsD01gkAfOCIPM2QfLgngpa37GW/o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZE2glnKP+AoetwnLN7MgUUlFrJn1KVnXZmr4c/q4+nTGnYk4vLGmqIbSxmxYr1sxu8BGMmvd4w+uM8UbGEzl/eLduwucUx6wYa3Dj51eANHBQ73bJs/aaQ0ckvxdv0obuzOSzzMKsPJx08e06Jk2MER01dVQLqxXw6aZiUHEaqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdTy4V63; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdTy4V63"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715EA1F000FF;
	Fri, 18 Sep 2026 14:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789740736;
	bh=gRnVVItSCueUlcZ+G+e8H/wqX9lMz0rTFvdAPH/AQbs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gdTy4V63yTMlH2GpNVscx9XbCD0tMzRholv3tn7r2rjK/hlg698n3fGCnop7IJk0s
	 7mdNqKIc3PwBkPG1dRedxilytfWV4Z8Ks3YlqhvExUArvB7G1OoeTHqjRxlTAyGcuU
	 1pGCD+Oyb5CUzvHz6IPuQcv0ioWOLcfAkkudMov/lXhXxb2+h6KBJ/fH0iv/2mZK9m
	 CUE2/uystqM2T2SC+3Jx4/lLa4cuBnd4qocBbE4+XTqL+qCehJnsfZ/zWW6EwOqF2Z
	 6OjjuFagkGZfnhb6qDkm2exZg0oAbdoWx+cU7Jz0nl/diy+PWppHo0vCzBqePcI+Ky
	 UVV6Qz959z+Yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] virtio_blk: set the zone write granularity
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Cassel" <cassel@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260918140641.2031075-2-cassel@kernel.org>
References: <20260918140641.2031075-2-cassel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:12:16 +0000
Message-Id: <20260918141216.715EA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> virtblk_read_zoned_limits() reads the write granularity that the device
> reports in virtio_blk_zoned_characteristics and assigns it to the
> physical block size and to io_min, but never to the limit that is named
> after it. queue_limits.zone_write_granularity is left at zero, so
> blk_validate_zoned_limits() raises it to the logical block size:
>=20
> 	if (lim->zone_write_granularity < lim->logical_block_size)
> 		lim->zone_write_granularity =3D lim->logical_block_size;
>=20
> A device that reports a granularity coarser than its logical block size,
> which is what the field exists to express, therefore has it silently
> reduced. A 512e host managed disk passed through to a guest reports a
> logical block size of 512 and a write granularity of 4096, and the guest
> ends up with a zone write granularity of 512.
>=20
> [ ... ]
>=20
> Set the zone write granularity from the value that the device reports.
>=20
> Fixes: 95bfec41bd3d ("virtio-blk: add support for zoned block devices")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918140641.2031=
075-2-cassel@kernel.org?part=3D1

