Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280663BE636;
	Wed, 16 Sep 2026 05:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535696; cv=none; b=b12yt+GVal8/5tRWyvzLCngM76bby+d49J+Zq530VahF4GpN3uhjgGz2ZekiA+d9bWihczQXGMQRuiimQoVghThTyKemQBszTAqO3OnPIhyypnlMll0Ef8bOEG0eLnj6WsJkegUM4OMD+6EHTsd9ZBmKtr8T3ejbBhXm5GRgQ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535696; c=relaxed/simple;
	bh=fGj9/5OQOV4Ip5RVdGriX4UL0p/oxQkkn6SL1qStYXg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oHpN/zJX2DoMxBIRqj4GQUPjpTG0Jt/LTHszWSceDLHBO5JYsWzvLrB012W9LQQU8MnOncFtbg55Qg0Y1UoVaRa1ra1ATXsfUp4TkzHvQrvCny2Z9Iixt2PgcKa3gL6Nz6OsNHqLVQvXHv/b+iLqNy0LNjRQCb980o2UDtpT/cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZk4Omgz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZk4Omgz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748B41F000FF;
	Wed, 16 Sep 2026 05:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789535694;
	bh=fGj9/5OQOV4Ip5RVdGriX4UL0p/oxQkkn6SL1qStYXg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UZk4OmgzPMex/GTbNlQ5mGYP9DIi6SK6gl3oQIcW9iRibJ92Ifg+WrJavJMNdPBKq
	 jBcLF5uQwShCLMuiM1qBI0x7KWwICllcz+gbIQ4zWy/w3f+LptzEqNoYhz39s9mc1g
	 nUl4xGXe4R9EyuehQLTlensbuk2U6nXw2wAktz3kEQooUbf2BL8szlFyFg5f3MjIsX
	 JH5cVJZwh8D0YZMXgHsntlDkgDRK0OYak7MKWkd/XxFqRf/TmQs7T3R4hQnKFEWtAH
	 PbOzRrOyB3yF27iJiYrfw9UONsdOCiqDcv4vA0dKtIdRZgr/GxSoc6ZI2sG0OESP7x
	 xN0wITukoFPKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] x86/vmware: Decrypt steal-time storage before
 sharing it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zack Rusin" <zack.rusin@broadcom.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev
In-Reply-To: <bbdb89067cd07d07fe4963ad229932faf87b0ef9.1789488039.git.zack.rusin@broadcom.com>
References: <cover.1789488039.git.zack.rusin@broadcom.com>
 <bbdb89067cd07d07fe4963ad229932faf87b0ef9.1789488039.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 05:14:53 +0000
Message-Id: <20260916051454.748B41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> VMware's steal-time counter must be in shared memory so the host can
> update it. Encrypted guests currently register its address without
> decrypting the storage. Move their setup to an early initcall, when the
> memory allocator is available for page-table splitting, but before
> secondary CPUs start. Leave ordinary guests' setup unchanged.
>=20
> Convert every possible CPU's storage before registering any address.
> Zero each object after conversion, since its contents may not survive
> conversion and the host initializes only the counter. Register the boot
> CPU with preemption disabled; the existing hotplug callbacks handle the
> others. If conversion or boot-CPU registration fails, attempt to re-encry=
pt
> all affected ranges, including a partially converted failing range, and
> disable steal time.
>=20
> TDX's conversion path requires directly mapped memory. Check all per-CPU
> objects before converting anything, and disable steal time if a TDX guest
> uses the page per-CPU allocator, which supplies vmalloc mappings. This
> also covers automatic fallback from the embedded allocator. AMD guests
> are unaffected by this restriction because their conversion path supports
> those mappings.
>=20
> Link: https://lore.kernel.org/r/20260309235250.2611115-5-alexey.makhalov@=
broadcom.com
> Co-developed-by: Bo Gan <bo.gan@broadcom.com>
> Signed-off-by: Bo Gan <bo.gan@broadcom.com>
> Co-developed-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789488039.gi=
t.zack.rusin@broadcom.com?part=3D2

