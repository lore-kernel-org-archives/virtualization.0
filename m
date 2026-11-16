Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794841605;
	b=eG6kFs4TFs1DFtKZxzG08TCI0Ou+34uuknVjiedSk772g7GsQ0DSlMUyMtzQCD6ryHYa
	 wUexmvrcuJgxQUJ7zOwL91zJXOBOqU+cZgV8N3K2Au0rShbSOsFNpVP/vEcI1PVrHvQiu
	 P7N5DRB9QsBBRVVMv5VmchTVIX5urERUiD1qc8/ozeBrOtB03lvhPddOvxkUc+3bZCcNi
	 8Xoenw52A9B9ojPKb/myRLgg1tVFU+rTQ2OBU8j5gKwYXElY6CmqOANP05LGQodLR+ymW
	 VybmLdDvdh64KLkbb9xZx1Cp+jhfrYtaLdm7fVagI/XnPxr5XBaVQu5+qR0nCSRx7Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794841605;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JqIIqq/makZDvz3EvWoJdaE7BG8K9O/EWgVr92L0ZPU=;
	b=JanORH7PwRQVbyt68WVuVZMYwempafwtSPver3XwjU+CH21BAb6G9s3El8sk3XVUG6qP
	 7AP90JdDyQa5/N8E3tHWIcRzTq8mSWYr8oh/z5IdWYo9swTSe+AHpgw9mCqnxPmo6fUDt
	 nE0GVrJH6m1J+tAjYR8Bc8ihb4JogkNv9ckdNNdF8/N/C5OA4CT10rP/dkqeRIKmTNXBZ
	 04LCifDzZVNp7bdGQSslAJRvjLhMonyXpAh8qINKoVrYa1JP4xqj/pHM5Shduqaw80rM5
	 P+XcvtCAa5pBrEIm9rjxIOIyUybmN8O+qPeKHuYnuuAwqT6VlZ22/Gvqb+sCFPpjOYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="g/9z2UbL";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9022C606A330
	for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 15:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g/9z2UbL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9841F000C4;
	Mon, 16 Nov 2026 15:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794841605;
	bh=JqIIqq/makZDvz3EvWoJdaE7BG8K9O/EWgVr92L0ZPU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g/9z2UbLyZqOU601+VMIV4eXu299gbybD5oYafuUAqsRItljbReU7x6RZjfvmV9fl
	 HeA12uDMyr+0smQvW/O2PDbl04ylcxMNWMvK1uebLqLijl7MGEqK/EjUq5rHWOvzmK
	 7JiRmOk65qnGF9OMX68cLNk0STHVL/r4QsotHzPRtgjVs1ubtGrC+PgyL0+tI2hFRn
	 7pCdmLAzSOmlPexJT8kDVqsWl//9xIlsGb5td2uKByAkgeP4E3z3VZ6Y83d3tRCLMm
	 NpgjeZqx9Y+0DdqJELNRm+8mz54B0PlFkbmcwpB44iv5xuTiOa5wnAVbAUqHINKGgn
	 z6bFuKVEQKPxA==
Message-ID: <sashiko-outbox-217221@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/12] x86/msr: Remove rdmsr_safe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>, virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261116150208.1572254-4-jgross@suse.com>
References: <20261116150208.1572254-1-jgross@suse.com>
 <20261116150208.1572254-4-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 15:06:44 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> rdmsr_safe() has no users left. Delete it.
>=20
> Signed-off-by: Juergen Gross <jgross@suse.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116150208.1572=
254-1-jgross@suse.com?part=3D3

