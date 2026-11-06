Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985829;
	b=26/VILN6Rl3Ichnl3n0On1YjAYrBl1o5VFocsl3O/ZPMYG7e/FSl7e324zNVht84iRAc
	 ieDplZ3IbBr8eefhzREX70Iqk7ItgECNyJpMT7fyrWhBNcOLJ7+xPu1sA4Bf4QXNTyHf1
	 Vf7FFhaIKDLiLqFQQiNJlrM2momiy7fz0YPdAU+5Zk756606wGS55YaH/0IqGvIjGTw47
	 ZLHxz+IRG/Q8T1BdJlwXJAigQUzTYO1SZZz2P9RnvS14lgHG+NsK3isU1qd6kxHtAMabq
	 yA6LXfEylc/fvWOKFTStGA980g4EB/AUmZiuQWAs3Vcwr2QPwxLkiIEo8LSfcL29ngQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985829;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tM4AdbScRIu73D2EPjW8UH5Fw96J73Ivuo9fTXiQmyI=;
	b=OeHTmGHiYWexbQE4r77skfP/Ze45askpnPfed2pN8WRLKrnWP1IYidZ5tsPZg8Sq8b/0
	 hiYO+MHVEfIrGWQtGSVYLq4fXkxI4WXRH91cMLBXvli7O+LI50w4zcBSS7N4SjYv9WQuk
	 71Q7/nAhNNgr+23HFISckv2nCBRPyX1JCrhPp8xGaFQKY2eyiejbX3IqnjiyC4AFRkoJw
	 H0la5KrHtS7IvHm2sB3tnxavjHroQ0WSJ3DuawpifpFf9CFawbDYyP1lKGWm0+LlDz3Mr
	 uf0Pjg85OHlluRk1okzxYQRmozoykJUK1Qlz0MFH846D9iDsCGdk8dJVCnzUNATyMKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XyFc3oRr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46761606A329
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 17:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XyFc3oRr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52EF1F0089F;
	Fri,  6 Nov 2026 17:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793985828;
	bh=tM4AdbScRIu73D2EPjW8UH5Fw96J73Ivuo9fTXiQmyI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XyFc3oRrZhaGbagHL5u/JSiemZ3AlyWUwciJmSbDZ1dq3iieBl9rB/Ws8P1zZUwwQ
	 VitVNhD979JtjIpKNgFzl+wPyP9ekvZyl5o3g1DpSI7nPOhBOcHe75cAquOCHanGhW
	 fJWLiq75kKOapW0mLZ+3wVN/kcbhL8sx/hZlM8sRk3gL8GKSotUarugoRPF0pASLh0
	 v2qDQxrvBg7xcfpFOTIOBHerNiv/AZGgBQ/cOdyoyWLcItOhj/a1QPOdMlbaIROTaJ
	 yBAnHyehWidiqEVE5M3rDMuYu1y8K5gRAvUIx2/xuiANbnxvXEqHmI3OvNa4jyB+tJ
	 HGm+GpylESHSQ==
Message-ID: <sashiko-outbox-201917@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/5] iommu/dma: Keep reserved regions below the IOVA
 rbtree anchor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vikash Garodia" <vikash.garodia@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261106-add_iommu_ranges-v7-1-5c0f72083e52@oss.qualcomm.com>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-1-5c0f72083e52@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 17:23:48 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The IOVA allocator tracks address ranges by page frame number (PFN).
> The highest node in its rbtree is a fixed anchor at PFN ~0UL, which is
> embedded in the DMA cookie. dma-iommu converts reserved regions to PFNs
> with iova_pfn(), which returns unsigned long. On x86-32 with PAE,
> addresses are 64-bit but unsigned long is 32-bit, so the upper bits of
> the PFN are lost.
> A reserved region that ends at the top of the address space then gets
> the anchor's PFN. reserve_iova() merges it into the anchor and lowers
> the anchor's pfn_lo. At teardown, free_iova_mem() no longer recognises
> the anchor and frees it to iova_cache, which corrupts the slab. PCI host
> bridge windows above 16TiB and the reservation after the last PCI DMA
> window hit the same problem.
> Compute the PFNs in u64. Skip ranges that start above the PFN space and
> clamp the end one PFN below the anchor. The allocator never hands out
> those IOVAs, so nothing is lost. On 64-bit, PFNs never reach ~0UL, so
> nothing changes there.
>=20
> Fixes: fade1ec055dc ("iommu/dma: Avoid PCI host bridge windows")
> Fixes: 7c1b058c8b5a ("iommu/dma: Handle IOMMU API reserved regions")
> Fixes: aadad097cd46 ("iommu/dma: Reserve IOVA for PCIe inaccessible DMA a=
ddress")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-195658@kernel.org/
> Cc: stable@vger.kernel.org
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-add_iommu_=
ranges-v7-0-5c0f72083e52@oss.qualcomm.com?part=3D1

