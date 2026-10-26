Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008796;
	b=CiWMzhWFnFfKt+tpPSdq5gTPJj81zp0T+XWbdghQP+0dM9J0tUODeqvZXMXBzAS95UWo
	 2DZgb9ISrpzg26jUC7u5Io30chTL+mxarjOeyY//+LArnpZvu0CE2MiR4khopo5FP3Otb
	 rpJY+74AnbxGa37uBnlSx2VMd1WiJ6hUbPYejcuZHfiunes9Lq8iP2AWhR23hFo+QFKy4
	 3z7aC8OEF4ezkcRHCbRK3mJRk9MQWWUuC6Ec/FyA8Ek8ecAta7Vq+j4VOERBhHu85oRtm
	 25q3VHZg20VVJBDUjbAmtDfFhH5k7nsRwSsja7hjmOmAs5nn+Za4u/WDHNd/4OzxGaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008796;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=EihPl48XyzquhIbKjuEyAajD35LkfbvtwIfgKv80/jQ=;
	b=hg9wuwXrLgxSxGV9oWaQcn43x0irDABFM9I01d5uQ6l+Rl32V5sueTL2t0yDRjYqq7b1
	 LtLPxCV+vWyOw9BfnZiFoVw3ukFbZ0s6v47FmJ+Pn9fSrzRh3obgdpeSYmnOzQHehgwZo
	 jlt2hiSwkbv9W9P16D1N9Rzy5COqFTfuKU3bFslsnDbChjuDnfRhjdOdLGXlF6DnUyDun
	 rwJXm3w+S4+wanqLqHR37/bkA6uLqH3NpSWY4uhTyvXnQdRSjMvUE4Z4P3CLTYvv44Gce
	 HPlUXfRzY/eQi+N7ZXnvvQn9T62MHtWPKD5GPXsNsfpyXLl/Z6YIUzU63eApNGxI2SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=duOPPQmS;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="E/SByKfX";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F67606A8EC
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 09:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7F67606A8EC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=duOPPQmS;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E/SByKfX
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4b0al2806300
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 09:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EihPl48XyzquhIbKjuEyAajD
	35LkfbvtwIfgKv80/jQ=; b=duOPPQmSNBtx6zhy2MyD4npHJuJX7Gm6wHBXP8ce
	gso6SBXwNnKeARLD/e0CobapPe+Pf7ies1PCMX8l0Ug5iwRxIVau+SXTqeR4fsTE
	bPqNxK1Bfn5d+FDp8KiVM+Bp+TZkWsYiaO5Dxo3FHoaEt9Yu7ndZYJNRki6RGyau
	e9TqyPtI9Gei8s75Mu/XbJ23qlTZsPaJIRg3qr0eUH6Wvuq+DaaJU5SFPTDHFggF
	7OibQZR51kSYWjQNBxzIW8c0qzGWVc8rErJCz0VI/N1iO4JE5O3EbCK0hg/I3CsL
	BG8uaN7ChjqvVzPqPBbYVSwVAksgA7o7Ey9Rzt7q1IwiOg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm8xnvv6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 09:59:54 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7c0f07b4e81so401642137.2
        for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 02:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793008794; x=1793613594; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EihPl48XyzquhIbKjuEyAajD35LkfbvtwIfgKv80/jQ=;
        b=E/SByKfX6whDyz3aviCngIRGeIUKaBJJ5ITRat+jgqQVFDCqmQFCXc19tGIfWT3TpU
         Q9RvYVag8t9kVEQ6odt7sbFIRtKCb5NBd3J1Z9njqg5hQ1B35kj+c/8XAC1bi0WpAE+Q
         MPkzmjIKOTg+072NmqhujuX6A88K3vz2Z3D7yXuNU3vbSngmP0/FbmSZ8rrXq6T1vMwO
         CzT8e8Z2rPhkGe14LD27vylFx2a3MybESUsEm0Q2vdUBWphm5Kz+h43YZLEzDS9bBr0/
         uNE5KXpRXcb/0zZkWZpDGZ5h6R6YNCBIM72G8oBNYdxDxqgTrZKxschAGuLG/ipHKMNJ
         kSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793008794; x=1793613594;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EihPl48XyzquhIbKjuEyAajD35LkfbvtwIfgKv80/jQ=;
        b=Rdg7ihfC83pxh6WQhI2lrulM4GKcbJxDiQin/123wy3k2/qAsb0x/L9+n579Xl2Yxb
         huTvRyW5p3+pXDtUstHW2NGKw5MtkoZNptWDWZd6f7CB0BJIndtia7EFyhizx0FNzMD/
         mcnN+DDOqt2slsf/OLRHj/MvCZHOKuBVe3VpoLVlualI34WIqv3+HlYQTN2EPcpjdl4T
         d3WLcweoQEQs4GSQF0DTZCVDpWGsqklyauVNK2PaOSmYtdG+FQ1PJM+XyxNg3hRnn/wW
         t4RWlVfN1d1pqpDzLN7z7dlpLGFu4MQfNLBSwH8+KcwXyiT+PaHmCevyNKvJ45MmvE77
         2F6g==
X-Forwarded-Encrypted: i=1; AKwUvBzwxwxIc4YHP57dFwvU/ivKioO9d+oAGAMy3Oe31BvbxoKUsh9P/fqzDSZGV8sBOQSawd34hwq3B0ha9xDRIg==@lists.linux.dev
X-Gm-Message-State: AFq9FYIkl6Ny19xZkohy1jya77y8FCdaPV/omB2aZy6/tft5q7rfpb1Q
	udn56YFa2td2ospUGgBbEYvM1iOSKh+ZtXC1DnCbROa2kl7rGBd4IAMQYUHVTFuU+xStoU9QRc7
	mDTIgndlbVonvjr5qLPd3JT8qUhnAG96eDK4DMemhRQCtWhCTHczJq3tWmasoHgO1Ls+3Hg==
X-Gm-Gg: AYBFou1ZglspVuMX3J64HgqqJQYH7v/C/tYgoGTM7TbVtPo+i64+xLPq5Md5fyLUXGY
	nsH1+se/sklcSkMeEZT09bFpI/gMKqog2U6nuw2ZDiHW1eXS/9vSg4KVJCG9uTgXhucZnUUrOiV
	p/aXkO88QyDVdsPbjrreH9Bd50R9eaLOxzw0PTRcSTSUXaIKtqOEP2jnIJTuRDBCaduZMc9Ps+v
	T0RfG5KDFqyVej6uul7YrgWnf1hVTin4woz55nW0X+E9168vsJWWqhXZ1lRODvCTkym17/GMDcL
	hYFeLNYsoZePxHhnxU6pRQcq6qImmR+yKCeZNaTK6Wikh1ci9r7T0au/hqulSJZYlqRlUqyWnq9
	Zh8CI/ORN3jgDgXHEw0MEkvZilLhv9coDzdEn4MnkA6tnJDutdFTMzTPD1jnu9GM3f95jZiaQIS
	TVMv7HzGOLu1YN
X-Received: by 2002:a05:6102:511e:b0:7cc:2fd1:7143 with SMTP id ada2fe7eead31-7ce5cd65a0fmr1586642137.17.1793008793896;
        Mon, 26 Oct 2026 02:59:53 -0700 (PDT)
X-Received: by 2002:a05:6102:511e:b0:7cc:2fd1:7143 with SMTP id ada2fe7eead31-7ce5cd65a0fmr1586636137.17.1793008793315;
        Mon, 26 Oct 2026 02:59:53 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ac709d0606sm16973671fa.14.2026.10.26.02.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 02:59:52 -0700 (PDT)
Date: Mon, 26 Oct 2026 11:59:50 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowangio@gmail.com>,
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Philipp Stanner <phasta@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Flemin Jose <flemin.jose@oss.qualcomm.com>,
        Mahadevan P <mahap@oss.qualcomm.com>, virtualization@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 18/23] virtio: Add Qualcomm Platform Services Firmware
 Interface ID
Message-ID: <lisaligvjmnnib7gm6klab77jfzyagn5cx5pix3isodu2cjvrr@o6efvpyte5yg>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-18-7cf014efdee1@oss.qualcomm.com>
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
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-18-7cf014efdee1@oss.qualcomm.com>
X-Proofpoint-GUID: GyROW9oW-KVcPkLWPgEovBNjlrPHaUuw
X-Authority-Analysis: v=2.4 cv=Ra0FmFtv c=1 sm=1 tr=0 ts=6adf249a cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=dTofmrguFlo4DCddnn8A:9 a=CjuIK1q_8ugA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzOSBTYWx0ZWRfXySLeElCQtZgC
 Q/4aL1sqp1Zlq4kK7dKpdjv9ZfNaAXB7QNWSG+j4W6Bf3jrzOPVQ3q1DR24XZ032zZIqEqkgPaA
 dnwvsQ9BBYBLu/Wt34a6aO53ygHlXKQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzOSBTYWx0ZWRfX3QXAA6p7yJ0+
 BpCTolDEZg7LW+NOswALy17skwE9wXBQUIeinb4nV98mMMYLx+wAy0k6wEYyAIGaHA3OmDjNCtY
 MAprSEe4ltxrngIjv8foCi7kVkXN/Kq2mH2PJpz92ETaaEgzqKG0iR145oJdXwsafpPCTmV3ge9
 6MImsS/Btrm55FDS4AJuBsSeSSs5HIjTMi9HaG4HnobeSV5La3H8ML5sGLvwsGSZ4tzAEa+p+nz
 OkmVof4vI3fNFmeKW7Nv0riB7V3zIPMy6zj+gO72Zv4R0vW3CAUsXAW7PQKkQrOXzFH+Cc+tAOd
 Zf53Mlu1iyRWgHSmoTDs6oV0zX1acTfJrUAd1uIGStbmyRHZDkEj1g+rAS5H7xS8oyhOdBO797/
 hxFbL0s5WeOUV2PvcIW6j4elI1SXVNLdr0xlRHSno0YwRIlwXcNovc5J0LJFeir4z8pfrs5h5s+
 ad8jUOscfChwUWbUClA==
X-Proofpoint-ORIG-GUID: GyROW9oW-KVcPkLWPgEovBNjlrPHaUuw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260039

On Mon, Oct 26, 2026 at 11:51:28AM +0530, Jayant Shekhar wrote:
> The Qualcomm Platform Services Firmware Interface (QPSFI) is exposed

Can it be anything other than the DCP? If so, how would you identify it
on the Linux side?

> as a VirtIO device with device ID 52. Define VIRTIO_ID_QPSFI in the
> common VirtIO ID header so transport and function drivers use the
> shared identifier.
> 
> Assisted-by: LLM
> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> ---
>  include/uapi/linux/virtio_ids.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
> index f9056af0c622..6c6f283733b1 100644
> --- a/include/uapi/linux/virtio_ids.h
> +++ b/include/uapi/linux/virtio_ids.h
> @@ -70,6 +70,7 @@
>  #define VIRTIO_ID_GPIO			41 /* virtio gpio */
>  #define VIRTIO_ID_SPI			45 /* virtio spi */
>  #define VIRTIO_ID_MEDIA			48 /* virtio media */
> +#define VIRTIO_ID_QPSFI			52 /* Qualcomm Platform Services Firmware Interface */
>  
>  /*
>   * Virtio Transitional IDs
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
