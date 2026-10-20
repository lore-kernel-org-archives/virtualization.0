Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493887;
	b=4jv2PQsekQNOARqqSNbgfACvr8QJTdAS7CaJpo0ImVMNSwNZhBL4WgoplJktOlzg9O8A
	 XpT1RUpxfWboFzdgHJEwKss2svh1HY5O2x66MpNOIxfPpsyC9bqBtHPOo7V0E6cDfk5nU
	 SD/1gMg1tEuhT9FEYxHfhHxr70+xh+Nw96o+vx57sIOL6x6T/A21i+wv1fpRvLZYIbMyH
	 byOX1iQS1dp6Lx0xrCtoHLQ4b/t+xNR9y336S7cgPzZC6Wnv59hzWCO08HYSsVk++QI8J
	 6AR0IXAMutMQnkTw6N1mYvC7NOwTfxsg11YGlM7j5dBXCyJuZ98nBEL4bUj5JkOPm1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493887;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ePnEsSEO7VVdQj0TT52MOzvoj7B3abN9Dn5ZTfuWyKI=;
	b=y2CnhuZgvRDblGlI7PUKNo6nDTnyHQ3eRIb9wXeqTi5qfh92HiHAW3IIoYMs2KG85PqU
	 VCZyinwVoabQrlGkFu/Dhp5AVKRq1NHSKObncOniUN6Q28PUzdcYDNJtq0Cxh7LbHFfLF
	 XTl5iN789LnpdKYTueehkEJkkWZldha0BHgzaSor0FnKFMzFSMwpIrwC8ALXwcN6lifRx
	 mgfxgSVpGM0Ziu/buM1Jsd7g3vouolETWrQB8oO/ZPMlTe32WoT3D6Na4QUwQNYlnWS2E
	 upseP5IQeesAxs6p6/2RUpvWV6+R9iBZ0+elKpFhIYcXwFQCPr349CuYXSjAugipteA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JBVHXREq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD09606A319
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 10:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JBVHXREq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F541F000C5;
	Tue, 20 Oct 2026 10:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792493886;
	bh=ePnEsSEO7VVdQj0TT52MOzvoj7B3abN9Dn5ZTfuWyKI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JBVHXREqM6oIgil2SpVXQSzCR5hbiL5RGubLNl68SgrGAZYa1Bp+W3se5kYI9we75
	 iUgIvo7fm7vqO6yl45p7tdStc2S4QPHl+J4RMtaQi0/ouQkm+jZE+oVSXW8ml3sbHK
	 yM+R3V4BCGPnsLupOgsN+LenE9ocbxCG7nOuy9a5ww2k+Tnu4cQJ+Q3QvdOwk62WZg
	 lPYZ6T6KkaU1GWuwo5yNgR1vlaE/cP7+W9YuexYkSCrTVW5/UWOxZpOnNLcpIY5963
	 PrDCAYV3FbzSmZA7Y3O8CHD3+3GnUn9fvvaQLZbNbMH47YhnM5+j1GF9u1fU30hdeM
	 xGKbvdIhw8qQw==
Message-ID: <sashiko-outbox-178866@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] vhost-scsi: zero misaligned I/O bounce pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shubham Antil" <shubham@octane.security>, virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261020105503.75904-1-shubham@octane.security>
References: <20261020105503.75904-1-shubham@octane.security>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 10:58:05 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The misaligned I/O fallback copies the full bounce scatterlist to the
> request buffer during completion.  If a data-in command transfers less
> than requested, part of a newly allocated bounce page can remain unwritte=
n.
>=20
> Allocate bounce pages with __GFP_ZERO so all bytes copied during completi=
on
> have a defined value.  This path is already the slow fallback for
> misaligned I/O, so the added initialization cost is acceptable.
>=20
> Found during an LLM-assisted source audit and validated with a QEMU/KVM
> vhost-scsi target using misaligned data-in commands.
>=20
> Fixes: 5ced58bfa132 ("vhost-scsi: Fix alignment handling with windows")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM (OpenAI Codex, gpt-5.6-sol)
> Signed-off-by: Shubham Antil <shubham@octane.security>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020105503.7590=
4-1-shubham@octane.security?part=3D1

