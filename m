Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795638789;
	b=cXP/Z2M1nL8CfAJkcE0wqgzGGfed91Lwo2BvqC3q7vj0fjJx6S3KoW2AuSH+3cVSXeEy
	 tefsxIb971lXt15UoWz0SSx39qGL9Ydo4/FC+0u6Rw8oKQ7E9XRCQjsnutV1UGukv9Wx9
	 xL/2NChrfL1G06vLoj2KWqx0WA1TpgpdmHrUJCQJxBRHZjKxLpUwzCHRq8EllIgf/AxS2
	 2IN+zgr9yDhyGGslgvWCoi/GK1SmUcotBdZawnQZjuL+9Y6/mFhdMja5dtbkCg3nT8JwY
	 X1y6kts0x7vhP9RCktjV6XIUJ+HlSK9Hv2uiyZH8PflMThojEhqhFi4dnUppgf2NIZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795638789;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:Date:MIME-Version:User-Agent:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=jEeLCB+aXgOVbuv66IfMGqFTl5oga9w2PPFkHOWOMdM=;
	b=T351DBWybhGQ6MSoMa5PrdNU+v683bS5FXdrcvNsucLldn9BM2Z21Bbr5QgLlK8ZCOQM
	 Cnty5Iy6IEhfRFT1wCNKlXIw4nog9wQtyTsH9vwsNsptWJEfQe0nRGtAGcYJBfESRsOjY
	 eNGh01lj6pzb2zqA2xMSDo9Oj61idl8DTzDgnsSwejirOFssjz7NWuK5B4wpeUXClz2mT
	 M2pLAcgNlrfBGuiGFHe3jMooRA3RoasTwkCTaOIlaxM86o43m1QmUv43rW2wZadqoQiMt
	 kWufoVSd4G7XYegANwR9X3Jtw6794JRfRNMDhcNhJsANL+1i+nQw03wWujSa6C/CQaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=M9xSkiRk;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0A2606A31E;
	Wed, 25 Nov 2026 20:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B0A2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=M9xSkiRk
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APJYlho613499;
	Wed, 25 Nov 2026 20:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jEeLCB
	+aXgOVbuv66IfMGqFTl5oga9w2PPFkHOWOMdM=; b=M9xSkiRkEO176N8TQ1Ps5c
	p3TkpgcyRrbbPjl6/XwPrCOwH/khz8SIIdzCwmfzISKZtgr3mkiD3zLQmjV4CQWM
	hODw385qM1J64HExQUMD3kL2LYs5ciAnsNc9jZNdbTdLM7Qo0Bp9cA+JTqOBkAuT
	mYmNTPEkoRzSgvw1LuJCHKgFF5UUfXpfTb5ys9fpONk85kfJSGWqPheFc4eWEFIC
	iOeDdc98amRKKBKH/1lTaLk7PjYNnIeZ1zQIKQCAhKuKkdXaKfvm7C8slvVgfwkP
	lmA7REQBaOU5yHLQAocWdYVWrQw7xYigFgshev1i5A1h5UuBNKwv/ivfxVPPux1Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g3eg83-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 20:32:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6APJJLTO1254917;
	Wed, 25 Nov 2026 20:32:55 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5dcuvyj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 20:32:55 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6APKWrJx27722414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Nov 2026 20:32:54 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 976845803F;
	Wed, 25 Nov 2026 20:32:53 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A471058054;
	Wed, 25 Nov 2026 20:32:51 +0000 (GMT)
Received: from [9.111.87.46] (unknown [9.111.87.46])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Nov 2026 20:32:51 +0000 (GMT)
Message-ID: <f2ce64236c70db1e377c3cb5b6acabcf6e8be8d2.camel@linux.ibm.com>
Subject: Re: [RFC linux v1 3/3] iommu/virtio: Add device links for endpoints
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Cam Miller <cam@linux.ibm.com>, jpb@kernel.org, joro@8bytes.org,
        will@kernel.org
Cc: robin.murphy@arm.com, iommu@lists.linux.dev,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
        mjrosato@linux.ibm.com
In-Reply-To: <20261124155410.768743-4-cam@linux.ibm.com>
References: <20261124155410.768743-1-cam@linux.ibm.com>
	 <20261124155410.768743-4-cam@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 21:31:50 +0100
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SoQFe/O0 c=1 sm=1 tr=0 ts=6b0745f7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=w36FetE1Bn8a3QyTgNcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA4MCBTYWx0ZWRfX3rMBp8VrwuXs
 TC7gM4EAMZCdQfVQABK9+9H2xjDyy9G8oAgzvqXhC/47OmL1RbD9BGTgGYhZjEgPC2lHjOJKzhk
 Xck0hdrlWlK8J0O3J299od3baDdWZyI=
X-Proofpoint-ORIG-GUID: gzkm3lQmll0A_GmF04sM4d0S7gAqb43j
X-Proofpoint-GUID: gzkm3lQmll0A_GmF04sM4d0S7gAqb43j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA4MCBTYWx0ZWRfX+D4AMmdaABfI
 HTGE6JwDrBZn2oIX3ND0mrgszhdXgBJdAJuSuKdzFmfULaD8OYPqQ052IaLOukdmcuLan4BybC5
 qs8Wb8t40+AxkoieakYIIh0VdvEXtxkEh2cdnMRxL301WzcUWaPQ8FJeiIexsf2DlByzZguG8kB
 Pqs9DUq0/7IEN+Hkcputrmu2vlA1J3a8YtkEzOt4sllsGu93PP1uD4L+eAec224DmvVHyCP/0Jd
 J3wpD+c8ljwqs8D3DEAmHGPlEbD5uarCPWpWxqK4H0pPqGRuJsZSFND8R0kWl5FqbPS95xouK5g
 qNfQKkaPNPJO1HT/5sBmOmocwEbTrMQ3hpJE75zKB5icXw0qNeqc9lkdhLji62jUT4zIngYy97E
 7dLlYDULWPQGS3pMasDtzO8nGrWFt3dGHZMqBGz3xFjQjiG+hQ8A9FFdA2RXvZzaRwiooLILtVX
 yocn46pc2RImNotMv2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_05,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250080

On Tue, 2026-11-24 at 10:54 -0500, Cam Miller wrote:
> Make each endpoint a consumer of the virtio-iommu device, so that the
> driver core unbinds each endpoint driver before viommu_remove() runs.
>=20
> Before this change, removing a virtio-iommu (for example via "echo 1 >
> /sys/bus/pci/devices/<dev>/remove") tears down the IOMMU groups of all
> its endpoints while their drivers are still bound. The endpoints keep
> stale IOVAs and their later dma_free_contiguous() leads to WARNs in
> __iommu_group_free_device(), endpoint IO hanging, and crash at shutdown.
>=20
> Make each endpoint a consumer of the viommu with device_link_add(), as
> arm-smmu and other IOMMU drivers do. The driver core then unbinds the
> endpoint drivers before viommu_remove() runs, so that their DMA teardown
> will still see an intact domain.
>=20
> Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
> Suggested-by: Jean-Philippe Brucker <jpb@kernel.org>
> Signed-off-by: Cam Miller <cam@linux.ibm.com>
> ---
>  drivers/iommu/virtio-iommu.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index dd10c3e98a3d..a84a653f269e 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -1044,6 +1044,9 @@ static struct iommu_device *viommu_probe_device(str=
uct device *dev)
>  			goto err_free_dev;
>  	}
> =20
> +	if (!device_link_add(dev, viommu->dev, DL_FLAG_AUTOREMOVE_SUPPLIER))
> +		dev_dbg(dev, "could not add device link\n");
> +
>  	return &viommu->iommu;
> =20
>  err_free_dev:

Looks good to me and like the unbind suppression is also already used
by other IOMMU drivers in this case e.g. arm-smmu in a similar fashion.

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks,
Niklas
