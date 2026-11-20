Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795171814;
	b=Dpt5SpkVfrtt2V2LGRnrNm5CSbb8S2fctRkUbqmPeqEQWVZY5dSMw8IkL6wFbwlfyOTz
	 l8XHRxBe+jHUi4HWZjw96qsTqFom7vYPayLhrcnm0UPWDBdc6xkGqAB8EjAQqgJ08Di73
	 REBgm6qGRUVR51W5MoiYHSRp5Wpv2HSnDshH/0ZnRBGeXl2pBlBoplJ3X03deaaOGFNoC
	 1uwFgQvlaxzlC9/3M8gBvlQec6ngK6rHLJJbGyRB7xNM6/3hPlhuSV+J+pAG0TF5/LdwJ
	 NOYN4AEvt0L5z3VQ1gs1eRMX2og3GlwaMM+gaWRBot1yatwSFud75Zp8/t6iaIIdzKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795171814;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LpkBbjm428498cvOAsJbjHJKOBmmCksoxrSD16MeSHY=;
	b=mINACcOXyjXWS00EmkXUQZ4mLCfowBGeDy6EtK+sX11TyeQA5/p5YYgy/sUAeQcxXQnl
	 Ekdj7uflSfeibjO9FNai/V9mCzNrXkOg36Kida/8U1sxHjQxwJDpnCDM81Qh89rh/HWSL
	 LxwvTs5w6owkr8yIMN1bKcWUF0yFxWTSinkxuLqWYyc5YIiSHw9+29bSBSXKUwJdDyJ04
	 vuHKezVtHuvn9GE2tlHkdHdJJ/e4i5YeYoRmbw3wf86cxFjRt6JZU2ExnjafIfilANA+Q
	 AzNjv3BgkV9wfwnhm7ZOPmHzS/AF1AdVg8dqdaH8/KixoiQ0o9AjNZqdnBBBQJm7U1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GQ8tTrEt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824F3606A33E
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 10:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GQ8tTrEt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC63F1F000E6;
	Fri, 20 Nov 2026 10:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795171813;
	bh=LpkBbjm428498cvOAsJbjHJKOBmmCksoxrSD16MeSHY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GQ8tTrEtyEQXLe5XhEHteBOlLTw9hlRY4nRpZR5pn8mwv/1XIbLwSOJBN5thh26od
	 9tBJpADkk7s/mOhDr6IbP5MyR03i0fqXcBOJ+yPQanEh52yKRSd23Q4cd44hjrbByt
	 2UbFjZKMwRZa1dRKi9wbBvyedsS0+cxtArR8SDCLdw6V5DnuEizMBUfX6yzY9LbZro
	 LNt7WfhWAcCkof7g0wm8Bb3U8ejfu7JCyf55gxnmGeJiRKB3D3FJ7pMASJvUziqX93
	 I7zehSGxYiWpBPb2NdHWsoTFv+bAHNm370Fwf9hJb0nZc8tXKkzuh5w0x8qGxsWCzh
	 Hh2KUjNgBVQkg==
Message-ID: <sashiko-outbox-224962@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/4] iommu/of: Add support for "iommu-ranges" on a
 device node
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vikash Garodia" <vikash.garodia@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261120-add_iommu_ranges-v8-4-d90486973b73@oss.qualcomm.com>
References: <20261120-add_iommu_ranges-v8-0-d90486973b73@oss.qualcomm.com>
 <20261120-add_iommu_ranges-v8-4-d90486973b73@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 10:50:13 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Reserving an IOVA address using "iommu-addresses" requires it to be
> placed in the reserved-memory node. But when "iommu-addresses" is the
> only property being described and there is no backing "reg" (i.e. no
> actual reserved system memory), it does not really belong under
> /reserved-memory. A device IOVA range is specific to its own address
> space, and does not describe the system physical memory to make it
> qualify under reserved-memory. Given this, place "iommu-addresses"
> inside reserved-memory only when it is paired with a "reg", otherwise,
> define it within the device own node. It was discussed here:
> https://lore.kernel.org/all/662f7093-fb0a-4564-9ca0-98e03e68ba9a@kernel.o=
rg
>=20
> Existing "iommu-addresses" property expects a phandle, which does
> not make sense when the property is defined within the device node.
> "iommu-ranges" was introduced to specify the device specific IOVA ranges
> when there is no backing "reg".
>=20
> Suggested-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-add_iommu_=
ranges-v8-0-d90486973b73@oss.qualcomm.com?part=3D4

