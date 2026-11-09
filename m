Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794252677;
	b=W5+WEmnn37XLciShwgegEpeq0OJKlfMOg2TRo2U1dKC4DQoZpoZVOTZwRiMU43lkJbt7
	 gvZpl9AiJrl8Ag+uKF4jOcklBQBSBC9uVZrGMXkzX+vQ13AKmYVADtCUEco8DZQFGEfcs
	 CQl1NXglGZ26o8P+Qe4pWxAhU7KfWcCLdVB19yiWjW47yLjrym2zdorUBKzVV2vmiLrdo
	 8rPTtVASTFWfAVEoBq6XnKro1g0zaLV5P+nBjGvFcidmUWmszwAhwkN3v8HJ/TqFDXF6L
	 Z4b/XFdI2GdqEOVXFzExlLDTEQfcCf8CkZbo/fOkho4GD8M0bSPZvPoBxqQyQZCeV0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794252677;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iWqpJB0szfwdV8XtEoPrPUTSNZK/owGwyAGH+8P/tVk=;
	b=3sqpzc/PfIpORbQOfoYJRMoQF0heg7fPzWIbZp8r/wRirND/DE77hoxPl/J4K6Zncd57
	 Tfz5vdjIXw9+st8XuZdL/k8NdgxpMkYNfn4IAEwqJNCWpOat5dhxWtYZ1FI3Dk38tPM4s
	 aruE+lGuWSMXGrDfA/rRu9bcqIOpLcEfykdMJ+jad/c2TBcmSnXZJztQ1Br1dk+lQ4LAb
	 tTiHMGNRqkf/beMI6GyGMlOgzE7sOpHCDwTwAPpraSKgataxkoSMruG16CnkA/eUIKRAQ
	 krsxGRyT99r9uTlarV1Q6jUzgBGEJ1g9sIzLnYtaKwuaE/2OGpc2K2QrXyd/azeTDtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DrWBnB2i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D992606A31C
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 19:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DrWBnB2i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D437A1F0089F;
	Mon,  9 Nov 2026 19:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794252677;
	bh=iWqpJB0szfwdV8XtEoPrPUTSNZK/owGwyAGH+8P/tVk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DrWBnB2i2rmIx9wVLQV/riCOn3gTEdI5f2kRFwiWP8MS6pAhVWQEnT7L1GT+tKnWO
	 s9gPmYvdSmHGca5DSxb7xwcqGv+iyORjjIlyaMnhr8RUch1uupkgshP5Ni4qCuv8XF
	 mgk74DW55CZS6YctkwY3b2dWGmRKU3m0UG5HhXczJhMkhZB6iHS7DvWBA6+uQPxY/M
	 JVEcyagUkf7GmWiHr2mgGXVRxathq2ClhqRoh7Mod8SgdlIdlzsR4WWujPlwxr5LUL
	 3FZNu/7wDU4cn1oWOkypW7leL29zSKubkA6CiSFPywzhN3gh6mqybAvHFsTfLFlHrq
	 rpymhKDg5ufnQ==
Message-ID: <sashiko-outbox-205495@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vdpa/mlx5: Bound the KLM count of the user MR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Petrzhikovskii" <vladimir@dfb.sh>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261109-b4-mlx5-klm-v1-1-787b45145719@dfb.sh>
References: <20261109-b4-mlx5-klm-v1-1-787b45145719@dfb.sh>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 19:31:16 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> create_user_mr() builds one indirect MKey that covers the whole vhost
> IOTLB. It fills each gap between two mappings with null KLMs, one per
> GiB, and never checks the total number of KLMs against the device
> limit, MLX5_CAP_GEN(log_max_klm_list_size).
>=20
> With a virtio-IOMMU the guest chooses the IOVAs: the VMM (QEMU)
> forwards each map the guest makes to the vhost-vDPA device. If the
> guest maps one page at IOVA 0 and one at IOVA 2^58, the driver needs
> more than 2^28 KLMs. create_indirect_key() computes the buffer size in
> an int, which overflows: the driver allocates 336 bytes, and
> fill_indir() then writes 16 bytes per KLM, 4 GiB in total, far past
> the end of the buffer.
>=20
> nnuls is an int, so a gap of 2^61 bytes or more is miscounted on every
> architecture, and on 32-bit the unsigned long num_klms wraps. The gap
> [ ... ]
> Fixes: 94abbccdf291 ("vdpa/mlx5: Add shared memory registration code")
> Cc: stable@vger.kernel.org
> Co-developed-by: Nikolai Kalinin <nikolai@kalinidze.me>
> Signed-off-by: Nikolai Kalinin <nikolai@kalinidze.me>
> Signed-off-by: Vladimir Petrzhikovskii <vladimir@dfb.sh>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-b4-mlx5-kl=
m-v1-1-787b45145719@dfb.sh?part=3D1

