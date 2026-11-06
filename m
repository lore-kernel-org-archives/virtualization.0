Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985315;
	b=yu+XHyeXw40nZYxIjjzZbzIItv0IwFqrUFmhOCYmW4Jl2GKYZ9rLxEa0L1Ie+MAadJDz
	 OU8VBmqK006jzIEkmELp7pIOjVgMOFWk3x5LaO03l0vmwhx5wTVgg6Oi4mD/wECX7Vr96
	 H+Gp0ouUcLG/F6gcvbY97pjnFRP7VvEncwvcCnvuf8vp2RSqVr+RFhCR7OGC8kYZkfaQr
	 o0ki7AtutClOvEN0FNFgEQcb5n8JT4JLz3/VNOApxxI1p0QMNBP4rXeiKAqoEtXn5XSG7
	 K80O4MURHlQkAWLSL63CCk4p3ErpbkRI3//IOjbyZRA5NBZyPGNsvDkWRtlcBdejuBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985315;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=lmKzW+OeZV65HUu7GatYIY1aKfS/VgNzCR8dOXpD9VI=;
	b=I3WHZ+KRtnEr0vVizqmSYBqbMnuAmSLJWWwEy+NakgSh0h7jtu+zRSbmCiS40sEo8kqX
	 V6tUPyJrKlzSPu93vN86EaBgkM8cZwH5G7uGVcUTFXVeO2OVgjg7GL1N13G6fKnmLxUXL
	 s6/FTx/+R2t9WyNsljr4yCpgQ9zZZBFf9tEFdp8NI5aQIiwyXzaP6AFg81O+ZPAfEH/FX
	 NLFhsR/lt8ZTKlitbzjJITWrcD1IjyS+eU/tBouFTSMokV1PddN7tJ60KjE/Wj07XnMAN
	 oI0svwNQUQ5Z+OdtgUj9qcn2a2VSJ5q3PvHzJd7DS8vr4tbRbDTKf1Td+j0Zx5XTOOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lyiSk5EI;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Yr6F7QH2;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07AF606A32E
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 17:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A07AF606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lyiSk5EI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Yr6F7QH2
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6ExrWv3722866
	for <virtualization@lists.linux.dev>; Fri, 6 Nov 2026 17:15:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lmKzW+OeZV65HUu7GatYIY1aKfS/VgNzCR8dOXpD9VI=; b=lyiSk5EIBhoTe0q6
	Db1dkJhOfq/MMO2ic9syj24/2SoSzzCE+hPKgBc4lxpC5pk+SDsBD0db/JqaeNfj
	ZWmFJh3jNWoZQXIFGhsaUrYkCQqNHrikQ7cKjbNaPOyZOI5T1aiQ5blFtg7xKht4
	/g91h7WI2eQ+bf/DZhTnceJlzEcNtTIJLjdAoJOTETTjn7I7Uv03PagjCnwlS1AG
	zyP8nQXUwiHa6apwKp8e3cVoGv3lndfLAnSPV0hDMLARImBFMdYwbcxgNYthvwyT
	JHvNY0r7knqti+YQYPVC8wfs2V9gVWIhbhhbPva6hsIRqx8R3M0dXTY2CtwFnlxm
	dCUYWA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9kspj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Fri, 06 Nov 2026 17:15:13 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso1571989eec.1
        for <virtualization@lists.linux.dev>; Fri, 06 Nov 2026 09:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793985313; x=1794590113; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lmKzW+OeZV65HUu7GatYIY1aKfS/VgNzCR8dOXpD9VI=;
        b=Yr6F7QH2cBwk4HCnYjHIdvGZACaIRUKWieOFl3hvyK0u3wQfUrG406R44IzVMqZ1b4
         NHQ1/PImfBSjs+IZRCNwgny9H4heRM+RFWbL4ADZUtS7TZ0KxjYQDpvB6Sxr6+ixdOjb
         YMmpj2cDeyiSoYBj+RtJEY3NGD0WQF27QZiULgSInzEJW87WNr2bjgmdXn+4ZePZDTn5
         8u3ysEjH0NGvN5sncW25FGpZbwWvlyjpy9RbXhW34ZPTA1qrrxackQesiCKGNwNi7mOC
         fMTgiqXteUXq7AXd9pL4sQbkHbNC2Oxh1JguthyFRyQbqDjqPC3L6fismiKOdNToqUbj
         IM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793985313; x=1794590113;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lmKzW+OeZV65HUu7GatYIY1aKfS/VgNzCR8dOXpD9VI=;
        b=FhDOdxjTDw86uiUd1eEThkalxIhZyMruWq/lneJVHm9a6pBoatY2l3rferGt4ZuWBy
         10kZ/4vzKotBxooAQPEePcl2UOsuYwbxp0QkSe8aZh5RPP/bEu8oQqcLSkuJaxK4DBaH
         zXXBLJMiCaGlOpLEUlXaUshYtC87IEdUIMDntk2OWlhwLfhRxWvjp4LuV83Ena48B8uv
         0s5bz4SEcUkIm10wucIpGh2Yvsf+JMSZZs0QIpv0Q91JNsQLsHzDEL12+jkVmvxgU8Xo
         EeeeMELth1Inwu8xzUUPcdxgP/uLHXsENmoi25hNTxO1VV8Ulp69lcdodc4B4mxOfEy4
         /e/w==
X-Forwarded-Encrypted: i=1; AL+hErHB9B14X0pJm+t+h6baA8T7r/kerqasSUHHl2fPI9BNqh24RfSJxxeb0GMLmwz0kEmJVWAn7wm0p3DqVT4HJg==@lists.linux.dev
X-Gm-Message-State: APuU4Z++lh0Tqy2sHFnsd0bnOLpU+8IiXzUuS5NjrrzewFtdrCKuBrAv
	+1RP3eyQVdzDnOCD6KUdV1/yabw9JpChKMLy3stu7IduQPmb66s8+7pWLB1/ryZYWvjBH68mbOu
	9S4VhBHCWAZiFf9MHcq0SmfqWc4gYx+tJuDOw0Yf2cGHFBG3hLWgOWcyI4BdhW1/9g0SM0w==
X-Gm-Gg: AYBFou0dl9NBtY0KLkRR+T4VsDJe15MM6OKumvwOrR8TLq9IwffrmqbnRWzRb5koJRw
	ypHlD4BcuNXdLi40a3cbmbiYIP0Udiq2rE2kjWMqKVWZjdCg06lCPXrkrQz6Gty4Ft5zqmOuLIJ
	hrSCwyGZGBbQ9IG17sUhWH3LllCXsaISMCYETPGQQhggYpf8wMfuenbRR+uErVgkKDeCHDXgUb7
	72UvljE5O1UvlOtkP+HnZEdn3+8Jzak03s37+3RQs7Bceoste3aq6C6+Faz6oywBAWGukhugvli
	4D488YCFqJUQzY4IB3IjfREffo+CU6AOtIVg54Yb++4uvjVWVfkWvzoKxNM1vYSG7nZUlwbR9hD
	3Nlh10BNfbu7OxXuTXGf1cXaztOLtBVVh+oD+O+rE38zy9BJvhIQffCB9ytqIUS/cA6S8MMsYy1
	9Wo/9yLuTi
X-Received: by 2002:a05:7301:700c:b0:36f:83e7:fb7b with SMTP id 5a478bee46e88-36f83e7fbfemr3882663eec.40.1793985312712;
        Fri, 06 Nov 2026 09:15:12 -0800 (PST)
X-Received: by 2002:a05:7301:700c:b0:36f:83e7:fb7b with SMTP id 5a478bee46e88-36f83e7fbfemr3882602eec.40.1793985312037;
        Fri, 06 Nov 2026 09:15:12 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9aea75fsm14693756eec.15.2026.11.06.09.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 09:15:11 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 22:44:24 +0530
Subject: [PATCH v7 1/5] iommu/dma: Keep reserved regions below the IOVA
 rbtree anchor
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-add_iommu_ranges-v7-1-5c0f72083e52@oss.qualcomm.com>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
In-Reply-To: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>,
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
        Alex Williamson <alex@shazbot.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, devicetree@vger.kernel.org,
        kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793985294; l=4417;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=G44uhZ1HXNVABGhn+qxMp/4C0rxJ1LZuV1TxZ8zeVL8=;
 b=BHBQFBOwgwPIQIoLF/meExK3QhQeHwPdFrwMKaRrt42zE9AMIGbbdJCDmSvFJT7Dzg8ntKu+H
 t0TRfWYzL4RAYGk4cpg8KgcxlTf/ScPXLS9o3YKyz4YsYjLIucY8QmS
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-ORIG-GUID: jJwiZFNtDYHk0NeSBQ5a86SVGhdXWpaC
X-Proofpoint-GUID: jJwiZFNtDYHk0NeSBQ5a86SVGhdXWpaC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2OCBTYWx0ZWRfX2m7GSO4Xig26
 +QpI72JsyBw2n7byOUjXE3SYZDLBTQfICTBuOsZvLsb6MpTHZ5Xo5yEFuU7tx9VhlujsC/ZNqmx
 DvEkzrt9xgl9KwPO6Or3F25nBF4kHig=
X-Authority-Analysis: v=2.4 cv=XvNvqlF9 c=1 sm=1 tr=0 ts=6aee0b21 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=dye_ZhmbRBr0AdBEf-cA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2OCBTYWx0ZWRfX3uUzw8weUSON
 6E1JObmp2g48lM3TLWAdF9Mwh/gZ67mlucltzgkaeYhBTu/rQddgsklviS5fhSGg/IF52ZnDLng
 SdSr9eVC8KLEQVqYsCnxGh3Isz2UvMtpCKULu3Ntffyz4As8yNkruH2bz7WMpvcaJqytip0srK6
 MG22EPoWPylUBng7XgHEGTqfQ53zWmK4PPrP0+jimchmhIXjzMKRnrAiV8F1oZ7Sg84VUiAicTP
 tmw51r7Iat9h8bQ3pJ2oC82Hw43VWo9aiB8VcB+WVk6BpG8wByFfSoCLctkoAqesO+oBgoDONsq
 +ukyZ5/gnHpnS8qkefmMOtKzkGZ3cL/lNjtqUclhEXhgJVybUYOUt32CNhE+ec3gh7J6fJ61T5+
 f+Dwa9/9sqlAWt7hppht8FBB+ZVB4ueHbXC8kUQDuFkxAXqDx6TXqfSRJMC6HbFLLk6krk6oCu9
 uYoiopOlvIa55KCnW/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060068

The IOVA allocator tracks address ranges by page frame number (PFN).
The highest node in its rbtree is a fixed anchor at PFN ~0UL, which is
embedded in the DMA cookie. dma-iommu converts reserved regions to PFNs
with iova_pfn(), which returns unsigned long. On x86-32 with PAE,
addresses are 64-bit but unsigned long is 32-bit, so the upper bits of
the PFN are lost.
A reserved region that ends at the top of the address space then gets
the anchor's PFN. reserve_iova() merges it into the anchor and lowers
the anchor's pfn_lo. At teardown, free_iova_mem() no longer recognises
the anchor and frees it to iova_cache, which corrupts the slab. PCI host
bridge windows above 16TiB and the reservation after the last PCI DMA
window hit the same problem.
Compute the PFNs in u64. Skip ranges that start above the PFN space and
clamp the end one PFN below the anchor. The allocator never hands out
those IOVAs, so nothing is lost. On 64-bit, PFNs never reach ~0UL, so
nothing changes there.

Fixes: fade1ec055dc ("iommu/dma: Avoid PCI host bridge windows")
Fixes: 7c1b058c8b5a ("iommu/dma: Handle IOMMU API reserved regions")
Fixes: aadad097cd46 ("iommu/dma: Reserve IOVA for PCIe inaccessible DMA address")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-195658@kernel.org/
Cc: stable@vger.kernel.org
Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 drivers/iommu/dma-iommu.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 78742aeba932de1054fbf394c4fae86e9b1be20c..fbf788ac055b6d1e87482c3de043ef57bb12d9e6 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -505,21 +505,34 @@ static int iommu_dma_ranges_sort(void *priv, const struct list_head *a,
 	return res_a->res->start > res_b->res->start;
 }
 
+/*
+ * IOVA PFNs are unsigned long, and ~0UL is the rbtree anchor. On 32-bit
+ * with a 64-bit dma_addr_t, iova_pfn() would truncate the range. Compute
+ * the PFNs in u64 instead, skip a range that starts beyond the PFN space
+ * and clamp its end below the anchor. Such IOVAs cannot be allocated.
+ */
+static void iova_reserve_range(struct iova_domain *iovad, u64 start, u64 end)
+{
+	u64 lo = start >> iova_shift(iovad);
+	u64 hi = end >> iova_shift(iovad);
+
+	if (lo < ULONG_MAX)
+		reserve_iova(iovad, lo, min(hi, ULONG_MAX - 1));
+}
+
 static int iova_reserve_pci_windows(struct pci_dev *dev,
 		struct iova_domain *iovad)
 {
 	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
 	struct resource_entry *window;
-	unsigned long lo, hi;
 	phys_addr_t start = 0, end;
 
 	resource_list_for_each_entry(window, &bridge->windows) {
 		if (resource_type(window->res) != IORESOURCE_MEM)
 			continue;
 
-		lo = iova_pfn(iovad, window->res->start - window->offset);
-		hi = iova_pfn(iovad, window->res->end - window->offset);
-		reserve_iova(iovad, lo, hi);
+		iova_reserve_range(iovad, window->res->start - window->offset,
+				   window->res->end - window->offset);
 	}
 
 	/* Get reserved DMA windows from host bridge */
@@ -528,9 +541,7 @@ static int iova_reserve_pci_windows(struct pci_dev *dev,
 		end = window->res->start - window->offset;
 resv_iova:
 		if (end > start) {
-			lo = iova_pfn(iovad, start);
-			hi = iova_pfn(iovad, end);
-			reserve_iova(iovad, lo, hi);
+			iova_reserve_range(iovad, start, end);
 		} else if (end < start) {
 			/* DMA ranges should be non-overlapping */
 			dev_err(&dev->dev,
@@ -568,15 +579,12 @@ static int iova_reserve_iommu_regions(struct device *dev,
 
 	iommu_get_resv_regions(dev, &resv_regions);
 	list_for_each_entry(region, &resv_regions, list) {
-		unsigned long lo, hi;
-
 		/* We ARE the software that manages these! */
 		if (region->type == IOMMU_RESV_SW_MSI)
 			continue;
 
-		lo = iova_pfn(iovad, region->start);
-		hi = iova_pfn(iovad, region->start + region->length - 1);
-		reserve_iova(iovad, lo, hi);
+		iova_reserve_range(iovad, region->start,
+				   region->start + region->length - 1);
 
 		if (region->type == IOMMU_RESV_MSI)
 			ret = cookie_init_hw_msi_region(cookie, region->start,

-- 
2.34.1

