Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794402185;
	b=2M0PD5+4QirrQDiZYd9RaF3UVGEP92z/kjXReBtDPPyOj5cjXBdGN2KU4nq1x+LLuCV5
	 HqAImNiYlSIwqXfXA/wgfLnCSUlLV8ZZT0jypc0w3lWWHCcZLQk7J/2WSXpJHKJ2RpLwr
	 x6SJbj+Pk8DPvQHnTalB9Vi9RqJWvyVOXXNMckQq5LCpEPAZ/LrDdxHeARU4DWFgMge2w
	 OqbSmRM+hKWk7vmpPnKKRDBx0Rbgn93bhdNUEDFEzSlSxGCXnxzdg6e7GxwyFxpfrhxdc
	 qNUYzd4eLwnjq3uDQOA5PMUpQm5BJQPhPR5H+cP000hzU8YM/4Awi7Gahwsg/mPhm2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402185;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=L8WR9+GG2EfUF3UrFaA4c5ksUoCcRyLK8GiwEhxkvFI=;
	b=mzp8KP9mnFZ7kq/hUom9xbWMSwWa8J3CZwqb1oRB3GwsBicqNRur404ElthqxGQElbl4
	 syruaodMN3ZQhN1gJJvalPVp0pzD4Z9GCd+NmI+fL4lUDrYRioKWi7YIMvg6SoXI3jNhO
	 I19jc4DF63l8f1+piLu6C8CJfSApQ6klv8fOwv9dAWE+s3L5GfJsK3ScnYxkPDiHDvDDL
	 FFZa7qM1+tJQ4LOypbP6rOVO2CdI4MtsrUamoa0g2O+TqKFfDk2Z2T7n3NUBvKwFzHrLH
	 OCENbahkWO88M5x/GFNNp1WhytZEAfd2TRmg8+oVOWl0lGYWwsXa6Q/z9vI115oYD4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PH9mWwXg;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iAUCBDn+;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1C1606A31C
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 13:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C1C1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PH9mWwXg;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iAUCBDn+
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCYt2K1806572
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 13:03:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=L8WR9+GG2EfUF3UrFaA4c5ks
	UoCcRyLK8GiwEhxkvFI=; b=PH9mWwXgQ5gEnifkFQhZ3anQH+M6DXWxjaYRNBm4
	8z/pNaY5400bAsBEpQNm+vBW+Q+jfqxxN8HzrTI5OzBHGZzkIlvScO/QKa7SGl2a
	PcypMhUu/gBKUX5uX9oh04q9yOC77RcAXm6BOFLzWoUXUVzVzcsM5EsBVKTYRsaf
	ij+ZkoP+ccbshZD5IvbBTtE8sEoCZpbwWmu4e2y+FeoOw8o2qNPB3O+GvjrxE3+p
	AL5/WPO/FeuqH2XP24+LiL3cpFAdsvCWMFBzD9x9fNyI2UQVztZgs07w1ZKgjDrL
	0O5WFB1GTvFsJB+TEYBpy6tRV1lwTog6SnR/2XN3l1argg==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvfawj7kg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 13:03:04 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5eabb3a1bd8so2972124e0c.0
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 05:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794402183; x=1795006983; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L8WR9+GG2EfUF3UrFaA4c5ksUoCcRyLK8GiwEhxkvFI=;
        b=iAUCBDn+CV+hxKEGNK7zuU7bRVoxF3WWEIwaADPSJcP2mtj3krZ1+9l7PS8l0ePpwz
         XsLPqbqSM7heAPGKBbN9bHR2b3bZBu1Guq64XCrIk8u9qMehi1aT5dD0dSYqa5R2aHXI
         wHeh7+jb1wQ4dSONLVWLxlVPDIGIFnVcHTSD1sBJlRpDvrqVr3j8kgn8u1tP88fWJygM
         H1QYULFHKK5HvgrXsfB4sQ1HiUFtYxxCDC1evT6vw+4rW7Lc6kWJ1im2X5z9pP+e4+Rb
         YpTOq53W+I+TmTOBUBY4iSSZ4LrkfTwsN9PJSiS5EcTCmNXXX0zxCowbhjG8GdmFpLkZ
         v1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794402183; x=1795006983;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L8WR9+GG2EfUF3UrFaA4c5ksUoCcRyLK8GiwEhxkvFI=;
        b=VlJtSAmftKdowgJgsdRc30RD6A+kox6N9bQKot9bPTpe9SxvvCarjf7LUB9nilBwFV
         rElIkoNpd1B3tjA3rZGDs+g6VQjcbYV4ADT1E/wJHBCoNmWIlFcwzef7rzHJkEEsoiHB
         buwDwkEYS37OVa/cdRUEK7NNw5NXnpGY/+I/CgyzsWgFxlav/rELMm5khT0IvI3/D1Fp
         em4eK4awzUM0+XF5T9QQMiSWMBbwTJt434cbFbSMtvyDlt4GrqxdZniwBBr4VviwiHBp
         xgwx1R2fKVsI5HKgH/S8eEjxzbYPsNH+/AHo3S3bFprUR3qIiIBf1QOmBwIOaLI75O0C
         Gamw==
X-Forwarded-Encrypted: i=1; AL+hErGZqT2kQEXuMy82BXLUBHFvl+7mUYWm8YCuMFwOMBGsBdC5/zp9dpQvQFUeVsyyjh5eSnKUX4jedZ8GKCZ6lg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8OByYATQ0PX6Clo1U4YbHhuJxRXAOOpt8ofoMVl3XLe+EpnFjA
	Rpa2e5v5tPD9RRLX4wattqSuG+Hyuero1YTKD3xAEKtDZWY0TxwZQmVT/kfdmfsfeCCPbEB8a2Z
	shbMLyUQ2BLerikBnTmypGnC0QZUnH03dZQ0WjAh83MUmBoTPtTp/7l+ApwmtP8XZ5qvc4w==
X-Gm-Gg: AYBFou1pl6mpyNuiC9nzMyZufAjbHEoVvMACujUeqYukF+nqwIj9tVNTB3IFhwMcJ2U
	y75J1jfJdJC3E5nFPcjTiOTHdYFAw+bkVYFUGlRCeiRGHArcV481cQS3ZiRhl1SMdDGNxjdwn2S
	EU5OeSvmnaSe8BLeHR7LIjTDxVJRxjcZ96wXhsZEU/VO0kiIDV7KYiltP2iKUOM/D4GfgAz2Oi2
	ZxE0xlS90suBOF5f7XRCnsuoXFJT80cKPZT1fyfoAYDyF6XRKCSpBHPpX8ajFvRTruzrLGdo5Xe
	rVRtpFc2K23JckQ2l99jNigaIhAmZQI2jo74hxdAHaAPbmmVfRKzf2rIuhxycera1n65TSl+O8Y
	c7EMrnTv3xAMT0mmB0DTUGCi0x7rAHVoT7APW6VfD49D2+mYvSlp7g/i94AYvY5dE2ZBARceJtp
	1musMimHxBjHWPF0FyiHReuGNpPnxQfGvU+GMJnPSiMF4PCbDbnujhZZVsJsS4EA==
X-Received: by 2002:a05:6122:1782:b0:5c9:a7af:8178 with SMTP id 71dfb90a1353d-5ee1c2b2435mr795035e0c.2.1794402183587;
        Wed, 11 Nov 2026 05:03:03 -0800 (PST)
X-Received: by 2002:a05:6122:1782:b0:5c9:a7af:8178 with SMTP id 71dfb90a1353d-5ee1c2b2435mr795003e0c.2.1794402183114;
        Wed, 11 Nov 2026 05:03:03 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c157bafba6sm959941e87.62.2026.11.11.05.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 05:03:02 -0800 (PST)
Date: Wed, 11 Nov 2026 15:03:00 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jpb@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
        Eric Auger <eric.auger@redhat.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Joerg Roedel <jroedel@suse.de>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Oza Pawandeep <quic_poza@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex@shazbot.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH v7 1/5] iommu/dma: Keep reserved regions below the IOVA
 rbtree anchor
Message-ID: <5pyhbuzlrk2pf3sct7zopoycvgliuvzzmd5qse65p3r63jarvo@g3clac2ao4xq>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-1-5c0f72083e52@oss.qualcomm.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106-add_iommu_ranges-v7-1-5c0f72083e52@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MSBTYWx0ZWRfX9k/6NFwsdTrS
 KxT80PPSRdV3txOrdmFqmGbURnRBiXzCr4c1kUPPJU6iJFEL8FkRh/J1icb62LldmVr2JhBthCN
 nUnALzBIc5epic72pPFtfEJIBMPILJ0=
X-Proofpoint-ORIG-GUID: B2BdEmD8M6s12qeNTOLFV6OXce19GS7A
X-Proofpoint-GUID: B2BdEmD8M6s12qeNTOLFV6OXce19GS7A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MSBTYWx0ZWRfXwX6WUwhjwSmL
 CTJ6jGnqTonLKTYuMCMC1SUXwIs080hi0lIXS4BmZjrLxUgM9hIOIeEJFoIPCd2IOeeAfoh1iaC
 4SXX2Dy2NbT0j0HeQUsGWH0oQmWsGpzVgOKj6J3AZowgFyd3GaX4eKt7hm9oODfA3L+N2o/aEsv
 H9Resf9r6ihBWH1D7f/IhFcwCIIVmpTGWO6w3CER3p87LwDlHowNVAAHqUfA4RnxTULHtx8Jg3d
 x8wWNUDp3dnCIP/Jj+8Nuiw1McgCbHG1UUc1O8YEVGH1NlQbW8mK3tUCm27mrED/yT0/fTJcJ4K
 HZXilgeHfRaK1cAvQzc1YftOPd26cbtwb2Sn1WNYxtocZ3J3mAs47hU1P2A4ajgd3yEe24uUkKj
 2FPmRgM1yciE7gKUbwCeXwhuKFgtYFll9VLCTdJzj5ZqtnkBdAnrqVZubNqTqLepzxudXLmm7Vd
 loRl5WRKcOXOEB2trhA==
X-Authority-Analysis: v=2.4 cv=CZadd7rl c=1 sm=1 tr=0 ts=6af46788 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=WA2_6xBGtpbLEjlkeFEA:9 a=CjuIK1q_8ugA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110051

On Fri, Nov 06, 2026 at 10:44:24PM +0530, Vikash Garodia wrote:
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
> 
> Fixes: fade1ec055dc ("iommu/dma: Avoid PCI host bridge windows")
> Fixes: 7c1b058c8b5a ("iommu/dma: Handle IOMMU API reserved regions")
> Fixes: aadad097cd46 ("iommu/dma: Reserve IOVA for PCIe inaccessible DMA address")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-195658@kernel.org/
> Cc: stable@vger.kernel.org
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  drivers/iommu/dma-iommu.c | 32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
