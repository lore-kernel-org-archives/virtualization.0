Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC8B34676F
	for <virtualization@lists.linux.dev>; Tue, 28 Jul 2026 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785243238; cv=none; b=ICmJaaFE/8Ss1Sp/XodchX9eXhRqv+dptNL9TMiAcPfqgFBElRinTgp7Q2PwT2l0Z5Msivpl/DGT/wWVZaYDnznsQY0DBVWnNquDTMgMaE33ayzJMQuihPgH8JUJNHRdO4XG8uLNN4Tk9GSKrbbmIDdh8K2Yn+mHzzpfzTm3h3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785243238; c=relaxed/simple;
	bh=YysH5jsrtcGezK7MNG+pQ8CCef1obHxI/WILbeJeICA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8qTKE4s0YlyRsJRNQsWRsZobnBXfVrIqo7fEnx3MiC0QyGa8yrwU0MsMEgjXQBi4TsJJ6ukrRNFpIp/AAGN5eNiWd8KbmUHFY+9Un6LmQYr9/c/KGZwS7rpHxugNVlMVY9t/CYHVyF/9ZYTu5AqwWtlztD2d9R9J0LRFhr3Qro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mXkXupkS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ByRznZuT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mXkXupkS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ByRznZuT"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SBIVLk2819631
	for <virtualization@lists.linux.dev>; Tue, 28 Jul 2026 12:53:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=idUJR9vbh9mLeQ+LiDmPHED4
	Y3DRfFI4oiLrXFaY0Jo=; b=mXkXupkShT/yLK+Wus0to8i5zGa4VNZDUaLkT49i
	hprZ4t+eXVvkuXJDvEOqJOkAKM+yHsc3BjQnPyfAyQomwFn6O+wSot7MiKpgbNct
	vc1gLdHTG6JwECYYqENVZKy3eZnVTIq29LTHlwVQjOahJKL3j2ayj9Ksh3uySujS
	xeO2C46RcueOe78XgtLxazQ7Kw+Zm/NJmHtK1Dd5W5Tt+UIQgTEoQFd5mJ1A4+WW
	aI6zxCl2RH9C3aehQ2lM6DjArW/CCe95/iJbrivKkbX2CFjUMNQlrXW3mmLBIJL9
	78z9jBVCXh8Ai+lE05VzRah/flxMH0HsglAO6B9tv25Khw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn3y21nu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 28 Jul 2026 12:53:54 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c20762d21so42236341cf.0
        for <virtualization@lists.linux.dev>; Tue, 28 Jul 2026 05:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785243233; x=1785848033; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=idUJR9vbh9mLeQ+LiDmPHED4Y3DRfFI4oiLrXFaY0Jo=;
        b=ByRznZuTsMb4ZwZMaSIR8zXDN52ZpDqbc/Qa8EVHmZWFIkwHGn9u0AUxeYG/WSDK8b
         nAuhV38AbEPxo58fHs8L7w9AGpawj1K2bJp7jhqBm+pR52xd6DqoCgD7W6SN6vEl9hMY
         NNksVqi4b3NVX62Ijj94mUl5mdaLu7TFqefNJDnho6kcf1O9LK8/8QGxmlWCEfgiN9a3
         mu3exSxndawTu5ZQYx7VcHzzbd8b7Jl0Ejg9caaxdytVo8VQLrloOYl0VayD8L3hm5/T
         R+CBKWZLeKpCMZmG3pB7pyElfa8ev4+7jjz0wCrgp6utctCG8HZLsnpgGfoGqiOVAUrn
         jiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785243233; x=1785848033;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=idUJR9vbh9mLeQ+LiDmPHED4Y3DRfFI4oiLrXFaY0Jo=;
        b=hdN8sCy/cXLz7+H4b2IQrV8VKW6e0+4W1Rio0DPRl9uHmJ9RfQ+0AiH+4G82jdOrDM
         EFsQ6UbiyVCqdJziZSahVzdVCzJwR0tcw4OQCOINMhbPkHHGp1cCEkEQwMM7JlTTHcP1
         kQom8zInMp/W5FbrgXMKTFNGqO8N5tC6rvZEfNx1P/5hDeqyhslqNyud+mFnaUDLgonK
         BXuUEDf/sbyx5bPHyobQGIkWFHzMEhtmmwzyLnNolceb1JdYMoV8+tRLLD55KnfS/Hg+
         hfFVi9698UoZxy/ZTG6/YsBpQ/4Dt8b/GQ81wZtSgy5r3Mh+0ioOkQlUNkm0Ij5lq6Uh
         BZ0w==
X-Forwarded-Encrypted: i=1; AHgh+RoBfia/I+Oe53qds+1PsdHZu8NhzOWZ6ufhU0BtGJJLAk8q8LaFqLCgVoyvvu+h6Zr4AIzpi1qu36RV1o+7Nw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4XFhoHhT/54KJ5QmBe9PrM9mYEZEp2kQ4RoSpyt70b1CIyMiv
	b0Jtx8A49kgbyzrZOYKFB0jcyNfJaoqSu6CNVsMAxx0a3Gf0AJImEH0g1YGG6eg1IYK/PQJUTpI
	7LGpEt3iZHE0Q+AcGO+np7bvdU1VjZDCNHZbT4edVASQNMCl9E4ui+UxYecdvDDDHQxOOYw==
X-Gm-Gg: AR+sD10HC1yjE276gZbrxTIKu0XjhrZkPyHh3RkkQqh9t+yyJP+SpOojjmqEwIhvzfQ
	uMTAnUL7Qmn3EOcxLIPeGNLV5R1uAZBFNWZxxEc0vhQ4djfFKkMHsU6TfC0gUGg4/TZewOwvi79
	zOUjbm23kmdZA3BrnxgbMvbPCjMUNjyd1sUfy/AepPVWGPthBgCOUX2PlUMHuXBV4qmc9rp+Jid
	s5eotDowHIK+ycki2l4DRfgYvR0J8TcyJsnJlyZhkiUzgrBF3l8tbWpv5PL3ASw5zK6PE9jMwoI
	8CWbqY/KKd2beV4rKjDax7/xYKpG0FqKmpRrWLJt7czIo+N3Z5bKaKJq7UtWveGbV52jQZP4Dgy
	ipNFCBgalO82LYsJ7MOB274qSxfxxfIdhTWs=
X-Received: by 2002:a05:622a:1a85:b0:51c:1f97:e860 with SMTP id d75a77b69052e-529d70b9700mr17426841cf.3.1785243233399;
        Tue, 28 Jul 2026 05:53:53 -0700 (PDT)
X-Received: by 2002:a05:622a:1a85:b0:51c:1f97:e860 with SMTP id d75a77b69052e-529d70b9700mr17426311cf.3.1785243232759;
        Tue, 28 Jul 2026 05:53:52 -0700 (PDT)
Received: from QCOM-LDTZRie9bq.na.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c492f451bsm685774066b.50.2026.07.28.05.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 05:53:51 -0700 (PDT)
Date: Tue, 28 Jul 2026 14:53:50 +0200
From: Peter Hilber <peter.hilber@oss.qualcomm.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Trilok Soni <trilok.soni@oss.qualcomm.com>, virtio-dev@lists.linux.dev,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH] virtio-mmio: add support for transport version 3
Message-ID: <kmbjsoc532n7dfqzuagbgpqawwj23cbbyufwkilr3la63akzbf@tut6umu6qwyd>
References: <20260605142921.2824-1-peter.hilber@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605142921.2824-1-peter.hilber@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=fbidDUQF c=1 sm=1 tr=0 ts=6a68a662 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=sKjYTbxxC-ymcgnlkHUA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDExNCBTYWx0ZWRfXxCzkci+PuFQm
 qrI4qBd5vMtC6bhgctyQGeoME5eX+vbsstS7S+gGqxbMESfQ60KHe9DVvvLeXoyCE94gLSRHrbU
 IMN7/Z+FrYgXZ/JKZRZ6XasAegXK+tk=
X-Proofpoint-ORIG-GUID: ZZLpZZ4kFPq0GgWKN56ehCANcBO8gHDs
X-Proofpoint-GUID: ZZLpZZ4kFPq0GgWKN56ehCANcBO8gHDs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDExNCBTYWx0ZWRfXwU6RIsYLsKNm
 HLZG2DabQr5VARuTa4JZ/NciBOAc/Zd/Pwi0hE4eJ5Mi8mAFMCX5TKaQfy1RfkjN0qaJm1IpKU9
 EhyMc2+pE2m2SRSIUGxJYjqRQjmdZN8yPtR3MjWGoveYRRcVftWcfAAKeRpkdsrH9zHW4Qet5MP
 cQHSMNuW51s1IYmSN926MzuB+GGRq2ZvjNrFNGcKmDuOLSfJroB8a4VVxn980e4BVH1+aS84cZJ
 WmE5MYKpGJPZGF4go4xkilVQLZoWIqPY7n82JnUuWOFD1JxN8IXkM3dMgyMdoORWDetBoAeFYgt
 WM2EuuNho29cR5mFl5FPlU0CPRSekmSlaueIiwj4ftDDZKc7MgIepzHdMf9A0p3NVjH/Ca4qmDh
 OGQtDWbTBewzhg7fzdkg3pNdnaYbbPQ8HT9CZxgN0riOVZ6LX+9h4CIPo4CJZGFmqFp1IKumsde
 CDS1NZcO0MG9UoGlQDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_03,2026-07-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280114

On Fri, Jun 05, 2026 at 04:29:21PM +0200, Peter Hilber wrote:
> Virtio MMIO transport version 3 allows device reset to complete
> asynchronously. Unlike version 2, where writing zero to Status must
> complete the reset before the write returns, version 3 requires the
> driver to poll Status until it reads back zero before considering reset
> complete.
> 
> Update virtio-mmio accordingly: accept transport version 3 and, during
> reset, wait for Status to become zero. Keep the polling loop unbounded,
> consistent with virtio-pci, since the reset callback does not return an
> error code.
> 
> Signed-off-by: Peter Hilber <peter.hilber@oss.qualcomm.com>
> Link: https://github.com/oasis-tcs/virtio-spec/commit/bb1dd2e1fe89b862f38f15873d835a698b196f89

Gentle ping on this patch from June 5th.

(Adding Jason's updated address, since MAINTAINERS was updated after
this was originally sent.)

Best regards,

Peter

> ---
>  drivers/virtio/virtio_mmio.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 510b7c4efdff..316f03b97356 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -55,6 +55,7 @@
>  #define pr_fmt(fmt) "virtio-mmio: " fmt
>  
>  #include <linux/acpi.h>
> +#include <linux/delay.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/highmem.h>
>  #include <linux/interrupt.h>
> @@ -114,9 +115,9 @@ static int vm_finalize_features(struct virtio_device *vdev)
>  	vring_transport_features(vdev);
>  
>  	/* Make sure there are no mixed devices */
> -	if (vm_dev->version == 2 &&
> +	if (vm_dev->version >= 2 &&
>  			!__virtio_test_bit(vdev, VIRTIO_F_VERSION_1)) {
> -		dev_err(&vdev->dev, "New virtio-mmio devices (version 2) must provide VIRTIO_F_VERSION_1 feature!\n");
> +		dev_err(&vdev->dev, "New virtio-mmio devices (version >= 2) must provide VIRTIO_F_VERSION_1 feature!\n");
>  		return -EINVAL;
>  	}
>  
> @@ -254,6 +255,12 @@ static void vm_reset(struct virtio_device *vdev)
>  
>  	/* 0 status means a reset. */
>  	writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
> +
> +	if (vm_dev->version >= 3) {
> +		/* Wait for reset to complete. */
> +		while (vm_get_status(vdev))
> +			fsleep(1000);
> +	}
>  }
>  
>  
> @@ -600,7 +607,7 @@ static int virtio_mmio_probe(struct platform_device *pdev)
>  
>  	/* Check device version */
>  	vm_dev->version = readl(vm_dev->base + VIRTIO_MMIO_VERSION);
> -	if (vm_dev->version < 1 || vm_dev->version > 2) {
> +	if (vm_dev->version < 1 || vm_dev->version > 3) {
>  		dev_err(&pdev->dev, "Version %ld not supported!\n",
>  				vm_dev->version);
>  		rc = -ENXIO;
> -- 
> 2.43.0
> 
