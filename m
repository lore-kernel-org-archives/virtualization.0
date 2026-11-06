Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986467;
	b=ttTQuE2uFi5NPX6+5/vAvf9V8qAK+hG1dCMoXI9oKtzkUZnZbOwqTdgFRJq8mrJZuETU
	 gLe1FH1V5iU6Q0fLexVbQApeiU9IRY3x42v9hc7FlGYdNKD+aX3rNGT/7yJlSc2ne8Wma
	 IAUuPsze2X3JA6kqg0g/buLlGevtOvsBb0uZtYaW7il6MBwhCrexO/bw0dfie3xD1qgBV
	 rNcmxx3LxAQ+fGljKkt23+lhtd4tXbFqxOH1g9ZIej1/vEJ542g7mDC6bDPthzh0cm7pQ
	 UFFLKd7qdXje1K5npVOFuP4H8L/L+l2FuUWMxHWBqOyyCGt8QqV/AUw66BsccA0h6fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986467;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vIorZkMDG3l+fIJ4DFT7m5s5UE8F+aWUWq7OsyknvSU=;
	b=hTO2G7N4D38O8QOZNXEBhtYlLJiZETXGVFvQ7zZOAe1McaJFL7kvYvalT3fCBPb1J8PA
	 9Sz0NaECb1lFsglKBiBUr0UjhuVAxFWm/xCZwpr9Eyt95qt8al8ApGXnvs8oDTQvcuPv8
	 AnEYjWQBWxA6zz+vced0Q5je+69YG6uqFnchvnFp1RxLCLV7bWqcHqO58T5DsIVjNrX/N
	 mg3d5FL1iCEmj8KdL6Hmk4aM8/9PAeYdiR7oCTYdYIkXInGqz//rnEqP2zJS2l59m4z5J
	 Bnf4bJnR0O9W5GtIPn6JPN0nR4icVS23bK0AisdcLB+V3apvQxdj/mblUWo6jV37slA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bJe6t/Jz";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A2B606D806
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bJe6t/Jz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4901F008A1;
	Fri,  6 Nov 2026 17:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793986466;
	bh=vIorZkMDG3l+fIJ4DFT7m5s5UE8F+aWUWq7OsyknvSU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bJe6t/Jz2+AyiT967DMzeg55TBsb32cI413tLHDYmcW8TIN2LmHgFuCspBNsmHCV7
	 vW8JQ1ORLjEYGzyGEWokt+XFU5kHaGn8eTWRCUEShXcGTgSf1eAQN0w6OrToQULvKT
	 8M6u5jiMBEqlmnpQGi0zENCKcRRBEAi+d4REoEr2U6vzQpmnDXKMyQUPJsIwHkQBkW
	 jhSiNu/3E2Pzu8gA9KMGCDZWdspPwIr9OxbDSKmQYR1qjoLZKbcbGMjXBWJQxlFUL5
	 5fI18VwA7jHDT2a+UfNdepfZmn/CDlRg867Um06xOiGY86Wr0LVV6+pr4ISrR5FD8T
	 QGiMpW30Dukpw==
Message-ID: <sashiko-outbox-201945@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/5] iommu/of: Make OF_IOMMU depend on OF_ADDRESS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vikash Garodia" <vikash.garodia@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261106-add_iommu_ranges-v7-3-5c0f72083e52@oss.qualcomm.com>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-3-5c0f72083e52@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 17:34:25 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The OF_IOMMU code relies on OF address parsing helpers, but the
> dependency on OF_ADDRESS is not expressed in Kconfig. As a result,
> of_iommu.c contains CONFIG_OF_ADDRESS guards and a __maybe_unused
> annotation to handle configurations where OF_ADDRESS is disabled.
>=20
> Make OF_IOMMU depend on OF_ADDRESS and remove the now unnecessary
> preprocessor guards and __maybe_unused annotation.
>=20
> The only architecture supporting OF without OF_ADDRESS is SPARC, which
> does not use OF_IOMMU, so no functional change is intended.
>=20
> Suggested-by: Rob Herring <robh@kernel.org>
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-add_iommu_=
ranges-v7-0-5c0f72083e52@oss.qualcomm.com?part=3D3

