Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794474534;
	b=saUjdu26pSqX1H8unnxGDJIS3xmioKaYL98dKt5AQ0aUuJduqkw1MWk3oWCyHeQVsNH4
	 eLC78ivQD3jAm593A/Z52weQLcV0lZ4eW/KQk60NiGo+fni/qKdyOh92Z6iYcla3MstZf
	 ayGqR9zhPWwoLtekKd2+pSX1ttgIuw4xJ9OPjrYc52vgm1qrHbSvtq35HLgSYdDzdrC92
	 HnmU6U3xayrgX7coyvESEf8gRDyXVoXeYsyEnL/S8hawQ8ZsRAfFzukBqHdIuRAyNpPLB
	 dv4YayFA4JU9RAxKQM1hPXqYRA/vyi6frFuL4tnV+lQp729U5F0MsGJGMELelAYHXLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794474534;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/9ww1N5nsdwVJ5jc9GGE9C0y9FZmcAfTmK8O0gHQ4iY=;
	b=YlWD2HXoEmdO4q0C+W9ipQT6FHN9Obpq23ZrjocN5mx5/q4ubYK/XsXI43SFC4pFgbXG
	 3o0C56hsZoVYa7R+zqq3k2QF3eL+93ewgyp64w7Lrya4V/FgnDzAr7f+F4KdxBUuPuSWJ
	 cwjpzyMW9GGrIxfK2APpsFV58qMIyPd6Y7NKfAyjedCph1R42yg9ncn5ldgrqJ1xoYiSm
	 EvsbzI7yFVBmaozQZPdsm9tLbG5WfpxZ0A8BH3YOldfpcKWJIF3NeaeKcyYK5O4JsiQcp
	 sV3lnvF5ahkgjIRGrWNC2to5H5mWC1HVIHfj83/HMjHElGC3B4xMx+f3F1YTsDZz8Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i8FYY37D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C665606A31C
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i8FYY37D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63071F00A06;
	Thu, 12 Nov 2026 09:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794474534;
	bh=/9ww1N5nsdwVJ5jc9GGE9C0y9FZmcAfTmK8O0gHQ4iY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i8FYY37Dojw27MA/CfkLnHoYxFIn4rZBKPwtX7yvmASujMK17nDbAv8AICrGkeoJ3
	 qTFs0eZwywf4ZxfISbDxP4HJgzYJCKOWKPYXBn6f+n+X/H6nLdstIvrOvl0zqy2Dus
	 pzY7bzPyKq+bpHhMU43XebZE13SjqbRgUkV6NPGzTKh6t1/J1It8o0MZNaiNlG28qw
	 +3l+fz9GVGONwQCpwoDW0USsKOGGUzX9Sb/suCp/ZjVDHs/iWBl4nfsvQ2lF+UjYrQ
	 +7MxmtSGgRhKLQ2M0GbBAikgkCigSiJiqULgPox9ftQgfJfR8ZOB2mZj7LYrWE2BvD
	 1lVWgdk3VVbFA==
Message-ID: <sashiko-outbox-210827@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] tools/virtio: add a vhost dirty log test
Reply-To: sashiko-reviews@lists.linux.dev
To: zhaoguohan@kylinos.cn
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112085631.128819-3-zhaoguohan@kylinos.cn>
References: <20261112085631.128819-1-zhaoguohan@kylinos.cn>
 <20261112085631.128819-3-zhaoguohan@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 09:08:52 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Khan Zhao <zhaoguohan@kylinos.cn>
>=20
> Add vhost_log_test, which exercises used-ring dirty logging through the
> existing vhost_test module. It sets a log base with VHOST_SET_LOG_BASE,
> enables VHOST_VRING_F_LOG on the ring, submits descriptors and checks
> the resulting bitmap from userspace. No new kernel interface is needed.
>=20
> The test covers:
>=20
>  - every bit in a byte, repeated sets, and neighbouring bytes being left
>    untouched, including the last byte of a page followed by a PROT_NONE
>    guard page
>  - a log page that has not been faulted in yet, read-only, PROT_NONE
>    and unmapped log pages, and logging after access is restored
>  - private (COW) and shared file mappings, checking that the bit reaches
> [ ... ]
> A --bench mode reports ns per descriptor with logging disabled and
> enabled. vhost_log_test.rst describes how to build and run the test.
>=20
> Assisted-by: Codex:gpt-6.1-sol
> Signed-off-by: Khan Zhao <zhaoguohan@kylinos.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112085631.1288=
19-1-zhaoguohan@kylinos.cn?part=3D2

