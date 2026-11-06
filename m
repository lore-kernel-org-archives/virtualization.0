Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986434;
	b=etLRJ8qF1pCNqHEOquKUHZZ5AZXt2I86bbX1RCUQ07QtiQuiFNNyrx3jKjXjioqSZ9Zx
	 xSsdKAl+VkTQvrFfDluNAKw3Ou0Z/Op1Oj5ICMJ52Xd9rMo02oumSMNlrp/hgMMUuWJA7
	 gTCBYdU9wB7ZEPJoNYyqgHZYNfOk+TxpXK3Y+1K07fmIMn2DzvQmvsieLsst6cgeghk7B
	 5LgXrXAEw1dcXrd5iQwFxfzQuwOPql34LVqkW6g8uCc5cK5HmVHaPiKBaeuP0HdRu4mZE
	 Hr0Aa1fca9d9ZIaF58mLVdq74Tk9dZ0jFbb1mta2X00BtWDQWHmFPu5cuFYmVA2nU2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986434;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=znTU4JAC2MqDVhizxZsWOApzoNkIqzP1DBfHTuKzxys=;
	b=X14RhwMKfWRd6nfrUENDzAIGoSO92e2eX3jJyYCL4MRd+039sOy1/rw+HOdzKV7YvaR6
	 3nYR5mwR/KGyzClsotCaB1ub8x2sPIUl9b74KdOKAgBItG08tqkB2HEh8rSizuoPo+qeq
	 oGdeBkOtvQyJ+pk9kWHUt9N1OPEsfXsV3IySIHcdbumnWTWL5VgM/mOMwEaPCs9qWijR5
	 bIINe3SzJdAIIwKpmIbDWUrmLM6RsQiequYzh0VcsqSQirVjeQO3y6oUAh1rbJFjr1zyW
	 XcS6SLMzAeG9tEzVPyW2lhKSu0vyuhYR5zuX1ypQlM9g+oAs0qek6/Kc+ZOrRe6jgpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KYpR7dwA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07722606A326
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KYpR7dwA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37381F0089F;
	Fri,  6 Nov 2026 17:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793986433;
	bh=znTU4JAC2MqDVhizxZsWOApzoNkIqzP1DBfHTuKzxys=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KYpR7dwA8myKCTUKrGhLgDEWimbwxhPNDxvcaoCi/Iy3ymWEuHCD0JLA8pJ7g+hb1
	 1iHjMJBMK2mgZsYhuJKhsnBOU7bEfu+1t5KA4BHJ9GbY5L8ycyzUEFYRK6yDFk7R/i
	 v8WSWkh+mqg2sssFDt7MCiu2k6jUpiKrwbqFPaYRD2rHTLL52NU81vWNBcNiVWb3Ak
	 7knaRf7P+pbncKbBdu2vT76bCwkcKVrAXWATql2kYlNgXLA7M8IFvCWMXQ1IJSgnGc
	 n7gBFXYNnXgJ+g52vujZzBpPLlLY7P6Pji1qa7bp99lQLyCfWfh9pOfGeGZ4wmnxp8
	 u16yhQntxMwUw==
Message-ID: <sashiko-outbox-201941@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/5] iommu: Use resource_size_t for reserved region
 length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vikash Garodia" <vikash.garodia@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261106-add_iommu_ranges-v7-2-5c0f72083e52@oss.qualcomm.com>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-2-5c0f72083e52@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 17:33:53 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> On 32-bit systems with LPAE, physical addresses are 64-bit. A reserved
> region can be larger than 4GiB, but its length is stored as size_t,
> which is only 32-bit there. The length gets truncated.
> Use resource_size_t for the length so it matches the width of
> phys_addr_t and holds the full size of the region.
>=20
> Fixes: 2b20cbba3390 ("iommu: iommu_alloc_resv_region")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/d223ee9f-b262-408a-a201-8b16d310bbe0@=
oss.qualcomm.com
> Cc: stable@vger.kernel.org
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-add_iommu_=
ranges-v7-0-5c0f72083e52@oss.qualcomm.com?part=3D2

