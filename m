Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794395111;
	b=WJ5GyIzyTi/PUBz2VhIlIUJaw9yYsZdzdNsZ5MJ2aS54wZk0bd658NaTujWAfhslL3Bi
	 qf24uzJQe40w1BLQ/M7DlGVV+CBB8xnNG3nfs6oipArA8/dG/X+Ww/8ZV0vlmeMW3pnis
	 j1xy/50eGW67qQHxYJHAJsAxbXbHgHt135SvSV346KklRU8pvrRza+2Ewa8K0JLT9hmeo
	 i8T9+6Inwx+o7VnRf5oJec8UHPo+OV8hFFfY9iOJd2a+Tt3tve/ZbVhloCKcu1k7bvirj
	 WoKU86CsjlvJAPQD6zAEY/lHlIimXb88tj6NjNgborK4QsPEowqjbcbHmjHO7XTX73Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794395111;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=aWDnnNx26bu9eNBEE5EhcsojfHfv5oN9+T/oze9PJL4=;
	b=Clo3uqgZJo+9sqeq/IzltR0j/0Y76RKjTcwvH60ckP2AgWUPuv5QgbGZY+sIH5u89Xmw
	 iSwVExAG79lsN7xZN+VBNO7QITopXqA4/K2TCL884/37lx2YpeE1FxHvYfayl58947K0f
	 vJLOANLNUoV/JOAccSUgIDB7fkr27A5EiR5ueM5GZCe61P9ES0OQdgQ8mzDe6sDrIX8fT
	 aKnv+cJIPWQUV3zCcdz/rL+raI0fAX90CZDKZK0snB4RNPowSYmj0xmDk1qYL+9qCPz6m
	 QLUIijY6Losl9K17wRXj5B4Pv64J6M4+9vQ+zimlU4qiUzwu4UaHNrV9xLNVGhsyqAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mz7BvnsU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jL3lApD0;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E177606A31C
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 11:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E177606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mz7BvnsU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jL3lApD0
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5KKbF2350842
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 11:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aWDnnNx26bu9eNBEE5Ehcsoj
	fHfv5oN9+T/oze9PJL4=; b=mz7BvnsUk9uvZQBPrlrCP0FY0EpKMK8Fnk/BJHJZ
	eIoz6x8b3e5HhK20kdOqW2ekkFFf4tIzIIQd5SEedf5uMjSOn1lfN3HMweVk6lH5
	ntz+LJKj1xA3zC1lWMiPjWdkI7P4ItEVdW191lQ5ipmefuyWEOahTrGjWcSdxLuU
	6o+wZx4H6jlX5sycKyAHYbwEDsNvpGFbhB0YgljGlpALYPGUt4AeZiDZLjWRE7EO
	9Vv4M/xETI0XHrHJGE+QWvWV4JiSzyR+bb63NyL/COQ00bTFpK9FUgmvXY0PAZvi
	blXIaVCaAkAuxykk5ieBxYSJL7zNSqx6hLI4vaa2D1tpzA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdnp26t2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 11:05:10 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-37158b53d06so487457eec.1
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 03:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794395110; x=1794999910; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aWDnnNx26bu9eNBEE5EhcsojfHfv5oN9+T/oze9PJL4=;
        b=jL3lApD0uyJ1xeB5oYKw2wIcXni52E406bRDMhrwqo9E4F7wtRkIjSqc2T3HgkAUzk
         b/vBsku4PA0oYOdHcGL/lg9lmCjDqm60bwa81Qnu8KwmmzKJ5ABFqKMc6DXOjh2bpGRv
         jan58CKAY+wH3ia0fuqszw1PBAASgughX4PAmgpoHMhfrbzc/BloXCiVBzaZbaa7o4tK
         zaWfMwsLYrfNlgfVGtDha6Z4fT0x8lSNMI7686TMrX0qYbIIvlRZs/2yeRK4GnEdKy9y
         Fl96lOSsVpbpl+yCZO+HGmih+EJjHkfReJYc2hH7TY0k7J3aU8imnrcZ9FO/Dp6ygUuB
         Nn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794395110; x=1794999910;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aWDnnNx26bu9eNBEE5EhcsojfHfv5oN9+T/oze9PJL4=;
        b=v79zB1zeyq1zCPkhvmMvUZX7CzIIaXk1aaAPHhavqiNKefMXWr2b3ThesP7W9qD0Ay
         v5uuke/XMlm70sGnmLWVe8jFD3Kpqw6l3O8GFpRDCRbj/CgE6bx9gzELmdq/PB+1tJcn
         z8BNia0788dslLsjce0ERcSLWS8NB2KMYg+Hmk7Ul+jYXfS4dnHUZjr1/qZHgQ+7rWDS
         tUn4ts1BVk7HCiLO/wfvRwKXal71jI7vQQXpct26G4C2s2vJNxgOVVXuBayCx1SDz7to
         XUeSz6qxJ1/g0pBhrDZO+T9bPJF4TPTGO0irRvwN756zymrjqlkZzx3ilH6S3ZWk6quZ
         CQag==
X-Forwarded-Encrypted: i=1; AL+hErExf6tH/OzJ2VHOpdE2pxtDuyIg+OaeDRl32Dvm4GzMqyingfzL7p2E/r/B/xDqlWeld9UTVItxFf2fM7zhHA==@lists.linux.dev
X-Gm-Message-State: APuU4Z98kjOP570W3iAWOFZuFoBtOsWHoWnCurbo3fDFAPz3PCK38QVe
	1A/e7l82LL+eKsif8zlkguwFo5j6Sl7QA/P3BRZ0X9BW3sN/3hcCcZ6kG27kQHs+bkdLFDak1LO
	oCK/1g8Y1u9iE8Jyrv6A8Tp/+Pb6/QFm7RZmkEqpTBuq/b7ACiEyc0Cpo+sl03i77/KFhP7Mm4d
	oOuA==
X-Gm-Gg: AYBFou2gKsag4TT1Z4ACu3zwz5oqFyV21JqJouJaRqT2a3Ny5SUcKr09HfWOZaGhH3a
	JbZnF+WtuNjcgegfBzXbbxyrTWDoGLWv95ZaqWHez5Q5XSZViKS+upJ2VBv5OOwHs6XyGihrrEh
	vbuKyXKUVITSrczbt3he2LqWSJCPFOVJ63B/jqdAiWq8opsQOUYCGJp/Dm3BWC8GtLMvPS7TKWm
	qke1Wmo1TjwIgiFmstSqq5TxwVfGFp5yAn8U89ogq7YL/T6OoNNz8U3VmWrjzmwXotTO9loLPBt
	LtnXoQFh9pcyNRDsqlSaIvXtRRjWY9vFzx/w5ehqgm3qqieTKVAFN4YMrTjrlyIn1y24cy83gbb
	AVDgswoemS0lOsn46oUIpMwN6jXAs2dwgIKZw66QliSN32HWYlTnC46vmJKjoU9+SKGqtBbFASJ
	4p9YOZOCg=
X-Received: by 2002:a05:693c:6391:10b0:376:c208:ed7a with SMTP id 5a478bee46e88-376c208ef25mr1678172eec.8.1794395109777;
        Wed, 11 Nov 2026 03:05:09 -0800 (PST)
X-Received: by 2002:a05:693c:6391:10b0:376:c208:ed7a with SMTP id 5a478bee46e88-376c208ef25mr1678128eec.8.1794395109019;
        Wed, 11 Nov 2026 03:05:09 -0800 (PST)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520608b52sm13502136eec.13.2026.11.11.03.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 03:05:08 -0800 (PST)
Date: Wed, 11 Nov 2026 16:34:56 +0530
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
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
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Subject: Re: [PATCH v7 0/5] of_iommu: add support for "iommu-ranges"
Message-ID: <avRL2AeIXEpA8SE/@hu-vkatoch-hyd.qualcomm.com>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
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
In-Reply-To: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA0NCBTYWx0ZWRfX8tJy8FzaqWJL
 xygN6dS1UlMqOGO+MLmeH5qqiyJiNvoFiGL+4OKZHlT8NA6irQc5gT5wq+mgIn5YuuhZFJTMQZX
 7PvjAyC0x8ZQJsfzDIQNpW62DOkkgRAOppuIuvycaetMZ3AKnXeuyxWmoDXWwV7vZUzFnCbr1kY
 l/z+K4BYaJ+Gi9k/N2AKszmwOweGZIURSWEm6QzQxu1TtKed9M4Di0b7U6hbStwW2XYz8wwQVDu
 jZtEA4uaR2qHDHOE1yv7uSHxso8+WNXJudNUJGDMkSyQjr1cAMJOJiU1R8IzWFaWaZjY1t82/za
 CZJyzfMmVWsGwHpeA9If1HFEVNNBxgmvzyfZyTugpA0X1azKZQ55HbGco2qY8trMSbOO+CuGeLH
 wnHLOxJzo4xQovXZYwc/vHL5D0LARHOyLQbF5+lXJKyVzxndNpgs+97tflWKbkdBVA66CVzSq1I
 aTCevJWgS5vClosA8Ww==
X-Proofpoint-GUID: 78dxKSrcwYNnFQ9TB82R92NkUnliMNK4
X-Proofpoint-ORIG-GUID: 78dxKSrcwYNnFQ9TB82R92NkUnliMNK4
X-Authority-Analysis: v=2.4 cv=NK1AaE6g c=1 sm=1 tr=0 ts=6af44be6 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=DzlgiSjgYWYhIfnXaHkA:9
 a=CjuIK1q_8ugA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA0NCBTYWx0ZWRfX+M/IH1B9Au4F
 HCKqzx/cyA05fZExiuFbYDDYnaXFCfyvKMpZ0s968ZcEmkrWhbHLLbH+EFibQ8V6Mwy4vhHgzZp
 x8qq995zgrX2kI9od+LxLQyEwH9IDGQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1011 suspectscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110044

On Fri, Nov 06, 2026 at 10:44:23PM +0530, Vikash Garodia wrote:
> The series adds support for recently introduced property 
> "iommu-ranges". It adds the required checks to error out for cases 
> which are not following the schema definition.
> 
> Iommu-ranges was defined in schema with this PR
> https://github.com/devicetree-org/dt-schema/pull/207
> 
> The patch series is being posted as revision v6, since the patches 
> were initially part of the media series [1]. The patches are moved out 
> to get review comments from iommu reviewers, which was otherwise looking 
> as a media series. Happy to move this back to media series if anyone have 
> any concerns. 
> [1] 
> https://lore.kernel.org/linux-media/20260926-vpu_iommu_iova_handling-v5-0-0322ca5dc10c@oss.qualcomm.com/
> 
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
> Changes in v7:
> - Move the "iommu-addresses" behaviour change ("reg" required, non-direct
>   mappings rejected) into its own patch before the iommu-ranges patch (Bryan)
> - Make OF_IOMMU depend on OF_ADDRESS and drop the #if guards (Rob)
> - Use resource_size_t for the size in vfio_find_dma() (Sashiko)
> - End the derived trailing reserved region at PHYS_ADDR_MAX - 1 to avoid
>   overflow (Sashiko)
> - Add a dma-iommu fix to protect the IOVA rbtree anchor on 32-bit with
>   64-bit dma_addr_t (Sashiko)
> - Use the "iommu/of:" prefix and fix the subject case
> - Link to v6: https://lore.kernel.org/r/20261103-add_iommu_ranges-v6-0-361f3921a133@oss.qualcomm.com
> 
> Changes in v6:
> - Addressed sashiko comments.
> - Addressed comment from Bryan.
> - Link to v5: https://lore.kernel.org/all/20260926-vpu_iommu_iova_handling-v5-4-0322ca5dc10c@oss.qualcomm.com/
> 
> ---
> Vikash Garodia (5):
>       iommu/dma: Keep reserved regions below the IOVA rbtree anchor
>       iommu: Use resource_size_t for reserved region length
>       iommu/of: Make OF_IOMMU depend on OF_ADDRESS
>       iommu/of: Require reg for iommu-addresses
>       iommu/of: Add support for "iommu-ranges" on a device node
> 
>  drivers/iommu/Kconfig           |   2 +-
>  drivers/iommu/amd/iommu.c       |   2 +-
>  drivers/iommu/dma-iommu.c       |  32 +++++----
>  drivers/iommu/intel/iommu.c     |   2 +-
>  drivers/iommu/iommu.c           |   2 +-
>  drivers/iommu/of_iommu.c        | 147 ++++++++++++++++++++++++++++++++++------
>  drivers/iommu/virtio-iommu.c    |   2 +-
>  drivers/of/address.c            |   2 +-
>  drivers/vfio/vfio_iommu_type1.c |   2 +-
>  include/linux/iommu.h           |   4 +-
>  include/linux/of_address.h      |   2 +-
>  11 files changed, 155 insertions(+), 44 deletions(-)
> ---
> base-commit: 2637bdec0535a2044cd830eba9a79363651d9043
> change-id: 20261103-add_iommu_ranges-549cf3fb0867
> 
> Best regards,
> -- 
> Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> 
FYI, we need this series too, for the extended mapping support [1] in
the fastrpc driver. I'll be posting a new version of that series soon.
[1] https://lore.kernel.org/all/20261007-extended-mapping-v2-0-5dca3aa2c2d3@oss.qualcomm.com/
