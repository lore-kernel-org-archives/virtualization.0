Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986367;
	b=HmchI8g+gF2xSPzG+UALO2JSPysY5nvduCDqgsRYdIw6yS9tF7VWNMrZiQSBFA7D9y3u
	 UfuXFfkAvshMJoitMF7cOEuJaBSN52FhWw6H6AWH8XolT4js7GX4EguO++bMjNDGvUPMI
	 B6NwQ1PWeS/xgBaEtr0up/JXBsXzePjJfpIuzqUJMquUre3sovUMnOa8zPy0XPK0uL9iQ
	 nMsEoL4Q9dH5O+xrVMtTI83LP/urRDDd/8XVcPpB163OVzMoycv4mkLzeg7N5Uroytsfj
	 nEb/7czMtF12JGHv6f2gNuApux6IY0O+K/wTBEWSwykAxkIeOVTV6Ai2Q191PfuNMAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986367;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MW0pBmry4JbZMufEj8yG08UT5smlh4iiqwJ2vER3MwI=;
	b=y0no5c9aQd+hcdh+0MLqFmEQKVToPWLU2Kw0mEf8mGKSyCLBL3O7gt02omzsc53Zkoio
	 rdIKeS0lyo76Ch5VT+uETyDjFhnatGxPfSOUzp0aL4VzUvxq5DgBSee8/BQxW9MRrqQ8K
	 /RAZ9qd6R64alMuCbWlcm6DUu9YtZBKjX4mWjg4cUoDv9BdOnuUqj2QcJ4JKEyKeMRZXO
	 yZPkWiSli9D4DHmHswE4WT5WDfsVmExxNZM02ySbfJYXVxKatrUueZZ94j9YTepa88dsY
	 3VW+rgpophvJncmgtTDo8cVy5aau0DsoCnnj1YULkWL0CmwOqkTTMFI1bcrI5EUM5Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bfwMmobp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6DF606A32E
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bfwMmobp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94CC21F0089F;
	Fri,  6 Nov 2026 17:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793986366;
	bh=MW0pBmry4JbZMufEj8yG08UT5smlh4iiqwJ2vER3MwI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bfwMmobpkuM4Xqy33iq99Czeqy3n0Ca4jUcPH6jqRGH7VFAejn2O760IwngD7Q1+M
	 2+nncGeB3gwEuHn8X+YZVDvY9ig8YKsafX/9jgYvLME9Qm71EJl1BI8p2zaCuX/wQp
	 BbkupCImbBTafLXJFqmsrLqGekhzBi7qCkrjWiDp5uA1aS1Ve6TfXzPn5fJkMB7MuV
	 u9tmTRFcFXnf2hz/MorR9G4sbCaf5jpOxJbNk5MgIycUmS7/OGmKB3H+ArdkksGS1r
	 wl3eD3luz4v+hNpgOTBCy7s4AyTYXTPubbHMacWB6E3dpQwJVO+rW46GyvG2NOyFsY
	 W3G+XklMhqdhg==
Message-ID: <sashiko-outbox-201938@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/5] iommu/of: Add support for "iommu-ranges" on a
 device node
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vikash Garodia" <vikash.garodia@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261106-add_iommu_ranges-v7-5-5c0f72083e52@oss.qualcomm.com>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-5-5c0f72083e52@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 17:32:46 +0000
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
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-add_iommu_=
ranges-v7-0-5c0f72083e52@oss.qualcomm.com?part=3D5

