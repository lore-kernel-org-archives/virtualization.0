Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795171411;
	b=QPx//w7VTScrciQrPZXGgNCO2rF5cPxezORCxJQtXXLw02zNaOaTAMR5E/xsNL7wePhh
	 6zXZ8SEqEkvIkrA7EqjQVOE+E4V4Yplbc4DVb63MSQ3BIctnDDQK2c2m136yYYQRLDXjm
	 uB+lR0wIn9F2BZAjw9mOBNZbUEyWJxq1WdXkn3kVmv+JcimLBsnK91F6QNfUGux0rDj+u
	 wHJb2h2VKezugjmAqZ3u8G56be2Mrz2msxtxWE1uHrHe0ykKIulF9HJcUHQVRStIUZjav
	 pyeVJo6LCPjjHK9ozfQzJ2tOIqrRzIYqhiHY+1XV2xCuL3kPtT2EDs03HiTXDjh9asw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795171411;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CU+O03dj6Gje3fXGVkGq7eMguSM7BSZCyEXp3IulLTA=;
	b=JZZx1Ijl3L0wyA8JluYnNspmJXa2qSpghoaKPkUAPhkzFCfH0Zo1FtwU/d/aD7CHT2hu
	 16WbVY9NebM1q/2mJuC7CucO0w2Rwm46MMT7aDu3aMCfMj8AjEnlj129ZSUi9dx62oWSU
	 HpPm3wBs0mipgbL05bklnO2KSw7swKY0uaAHLL7bO28PqpftQDDglnURQnn0F8khZabvp
	 ijwacqD1gHUKDRt4oCc0fnO7hInek6EB0tiDLzykVOnoJ7xv8G0q1TDDKMwOpfBj/KRnv
	 OHLvVDMDtaIHP7JTLTe8Uqf5K3uchCoEa+fQCiNSKLSEFXilCkdLCN81/DSKqsHvoew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PwSmsG5K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E7C606A320
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PwSmsG5K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD161F000C6;
	Fri, 20 Nov 2026 10:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795171410;
	bh=CU+O03dj6Gje3fXGVkGq7eMguSM7BSZCyEXp3IulLTA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PwSmsG5KwRf77/TyX+z0P228qYQA5fXUwCtYfSafiDtBpBz1XdcRVUVPxKsj/o4N7
	 HsG1pu+s7NGSAfkaN0AsJ4PQT+zy3PiN1b8/VkG/H3iAy5MDZRx3CrIHwszfBNyEBk
	 Ef/s2uMdM6Gvr/p8U0C7Ow2TuMY/dy/PvlEVPzB1VPdIC6TIdIBWI1FC6bH0PDREWt
	 RSbrkya1qJyxld4Xwe5WqlnbuKibObw8JbDaob0Gvzj51m1gkzl4IAMpfQ4UXEo0h1
	 3RLf5N5Vte0N/G5WEhy3klneucMTO2T8TxALo2W/Z7NkUBWOjVgCSIH5JIxzCS0fsl
	 Zpi3ypYH3YwSw==
Message-ID: <sashiko-outbox-224953@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/4] iommu/dma: Keep reserved regions below the IOVA
 rbtree anchor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vikash Garodia" <vikash.garodia@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261120-add_iommu_ranges-v8-1-d90486973b73@oss.qualcomm.com>
References: <20261120-add_iommu_ranges-v8-0-d90486973b73@oss.qualcomm.com>
 <20261120-add_iommu_ranges-v8-1-d90486973b73@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 10:43:29 +0000
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
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-add_iommu_=
ranges-v8-0-d90486973b73@oss.qualcomm.com?part=3D1

