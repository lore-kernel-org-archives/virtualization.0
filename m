Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794402249;
	b=ezMfLyNT20zSA83E06RRW4821fK6UOrXdBuM74mW1eaVM9sROWbZ6YmvgFa2DrJv/Z8L
	 5EAdHaS8WR0y4bxd1jhP4BmuggjohL8S+pWFHeOakclEx7uL2qdpBJrMPAf/UKlgMphdf
	 Ys8KJCL4vskQXM1UhZsFBWtxkXFLL16vL3186TM7gB/QgYazjhVu9AcRdsJybPZsAH5+B
	 xlh6k0YVCbhEiNgEX2iWF/NGpEIbz0lURtcAo7DYawwmNPhWOXmN+qHUrKavbc9E4ipla
	 wTBAu3kzadPsnaBTVmuyFD3tluVYWRaeG5ZWfMQjg2vp7w5KZXCz4FkwR2vYOAgWUrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402249;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=hXFO6nUxnCW4XbKSEmI+WWHTtNiBaotTU8OUh9DkrJ4=;
	b=F8J2iFtAupdaEhN/mrAW18sUUd8qIJ0yM4+bs6Q+AJp9eeZwGB1WvnQQOXmW3qxIKsf6
	 usowFv93wcC0J+5n62WMexO6rK7SkJOMvN2fu2kCV9+0H1ecLDBotjzuQ+ouNnJTTxY1N
	 ldPhxMNmB1UD4qUTAOQgLjvnFeBYpGiBI7qsOQPAkJGsAOv1gSsi6lW65kMe+atQSG5gn
	 aC/Uf0dv2I6yq6qlEmM9XxLbVXwbA0U5oB5PbVV2CZj/iM0ApNUFo4NGXfaNL367RyTbC
	 +G3A+lGvPw95eJnamp9mbWdy55M35QR6FK65hv2nrBZP3mg7kQtw/gsugbbP8xs8uAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZXQgzpip;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZwDQaEGJ;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C3C606A32E
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 13:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81C3C606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZXQgzpip;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZwDQaEGJ
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCYsWX2286495
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 13:04:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hXFO6nUxnCW4XbKSEmI+WWHT
	tNiBaotTU8OUh9DkrJ4=; b=ZXQgzpip5uTvPSftHjwaOcUkWjomKAoZGLBjeYPm
	o1VQ1fRKMILYH+E2uFvWC/UqY3Yc/4Q4Cqy7cnrDFiv4EcuAgnTv3xA+bwMUFWPo
	TOKcHIcBcPBQwTeI6WiNqonqVAiFrS98rjxib8gIQlgalfftVkLQgbSl5+8L9hzN
	2ojK22wdT3LQwRit1G1MrsSzRYQ9WRi5bskOADsWRZ+IDlHaN2bK9DM4sO2KqbBD
	n6fexJdluRTZPVh/Q0Ax3hc2fl3bhyCm3VDwbPe0oGwC43BtkpXpu+dDgqGY0ShZ
	vKLCnaMizQ98DjuFwWT3CLzuTlwV6efLjINJtlAuzKZipw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvksm98vd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 13:04:08 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-9806756ea40so2397012241.1
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 05:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794402248; x=1795007048; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hXFO6nUxnCW4XbKSEmI+WWHTtNiBaotTU8OUh9DkrJ4=;
        b=ZwDQaEGJ6nhzqdiQ8VVI96DxF2/1S5fFz8flgQ+xMGRtaiCRmbtR8nR9j58kxX6f1w
         oEGRBHh5YqWwRyl9I0VfiLSeDxTFzl6YuSwHvMmyQq0VO6idf3W5Aa6TEZTWpDBig/9N
         v6dMRkrRGyI2Oq+UCGxKC5RoztrMrjS/rK1CCoEqHHBsLQLA1GLFC0IGcLJpYv9w6yDY
         nOEBNokFO7Ks81fa8Zhkj1spa46sKnP/fNQO3jbvCchypaJWAI24TIJxyfcIyUVbWWN0
         JVDMD45PRG2lNqhtbfidNdV36/2LP2gXJ4eFpv2QC4yZjyKqOuINcRNo9+y6jCFpFPSW
         vr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794402248; x=1795007048;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hXFO6nUxnCW4XbKSEmI+WWHTtNiBaotTU8OUh9DkrJ4=;
        b=PuoDe5t9yB6cokvDo5Bxn6npxkiSzXGkUQ8KLX+OAsbPZLI4wt63/dRrim8ldwKk4A
         9dlOFE8D4K9DWM3eC1sDPcXqz2kPlny/AS2bbsMwtahlEqrbWDRSVEem2frnqOZswvMW
         1zZuQyUPQdUtWEtgn0jQ1d80uhJWGjEbbbJK0V+wJebYocFxEnXfhA3j/YbKJfrvak/e
         zLo62LbZn1KWV+Y24JnSJG/eTsyJAPdpynvfv/ZGduWeISdvir3UIwK5Wc4kbqvxu2HF
         oYdObXbMgfHOJGLu7ue7yLZsqhAMc51pyPwnbN6dXbB7hhUGxm6D0Y0u4HYW8976Yn5V
         FMaA==
X-Forwarded-Encrypted: i=1; AL+hErEigsZ/lZUXpq4B1bzIokeAxgWOkdVJWmMbCRGTOpzgxA39Dhoh5hgdhgaSoiDf6CgN3wXW4W63dg1OI76Rcg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+Ex3eTevCvXY3mg/hCHFojqkeM1v11+XvXgJO16w4GHGMeutVi
	S8zYUzTOEeugCNEsX23RO5V0iUVbbHaFNqx9UtBVfIGlj3zkTtaQII5Y4Szufd8nZF8q0ho2d7s
	0XV17mtBBnlYFtQY/4G//c6RIWiZAEy93BU+TZwrZRcYYEop6N+VwtKSi4maiUkhZH0zw4w==
X-Gm-Gg: AYBFou3G/zUAMZCH0gtMO0odrBzqWhcDEFFv6e+zpsM1BoOXbT8FhIdRZW7TTRLYYgX
	/aTHpZQyX8t9alnEmOg4tRw1sJAV2CjobSKB4M8rUZ9KDCN5qE1peZaGBHVF4a37Sk39/XpoL4w
	YUMo7cvRt79n1x3rTC2k4WyTAGcoQPhDWao5u7XX9IPCsZ2znQR1mpkNthBm7naTQFo47u9WYPQ
	SJKBJYm6HXK1pK7AL6IBBaQpi2ypBfWpmwuCjIbEi1gZvNZHY7Sy3uSylD0o8Y7lIqYsi03cxcT
	wn48sMqTmQjxbhVtBAT9CzjYSojiOk38ieq8MVnmTE7EXDiOiuDqxDn8QmyY89FwzaTbHjJ+7en
	v09ZGp3U5AyYdaHX2bZuozwZjq/UpIGxRtN7VlW5t6zvT/WTSIAeFdaaT+dxhWuAw/tV4NZjU5D
	MEpENeauGe/IQ9VdL6A6M0/xxih3q0GnebkCD5HJ8d3lMZR/LlGUy0vOW61ABrPw==
X-Received: by 2002:a05:6122:1d8b:b0:5e5:1be6:e12c with SMTP id 71dfb90a1353d-5ee1c490338mr604739e0c.21.1794402244135;
        Wed, 11 Nov 2026 05:04:04 -0800 (PST)
X-Received: by 2002:a05:6122:1d8b:b0:5e5:1be6:e12c with SMTP id 71dfb90a1353d-5ee1c490338mr604634e0c.21.1794402243470;
        Wed, 11 Nov 2026 05:04:03 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c157bb758esm944566e87.67.2026.11.11.05.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 05:04:01 -0800 (PST)
Date: Wed, 11 Nov 2026 15:03:59 +0200
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
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH v7 3/5] iommu/of: Make OF_IOMMU depend on OF_ADDRESS
Message-ID: <yvkcq3zirv5tz2amfbk52a7smbsqs7jrzdisq3qxzw6xkoxklu@rplx3gvxhcoz>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-3-5c0f72083e52@oss.qualcomm.com>
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
In-Reply-To: <20261106-add_iommu_ranges-v7-3-5c0f72083e52@oss.qualcomm.com>
X-Proofpoint-GUID: WN8hJ3I-WMHenvz0xExHmUnnEcP4MjLZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MSBTYWx0ZWRfXxBsp64zYFtBk
 Ve5ALLxsaqlTprxJGoZY2CaMc3zkhsa8LIw6CLK4+2IEEAFU0kOfHznNZIEg+gBB7LXmEaKmL3X
 Aqj2qTbiQeO99BOqQrmbdk/W8UWJP/EiRGVC2/Mv86NYriMEmvSLqyqqB8KNrqkZM0y+0VsGp3C
 2KynDYQ0CSz7eJVfR0Q2NUKoio+Ak4tkeSls14MjRIM+0CfKiLTI+VronpEXeGMez1dlphW/W64
 0AZsWCRZH7xfKikgP/0l4fYk9yp2AUhfB/RXM47tOj0uqQP1nzJkNeYhOPzYMRTA+qCzCRJFg8V
 MltFfPUIda/aB5FUR5cwnpLjtarAXIo/N4VzaGo7qnoGujsTVY0hy8TUCKrNc2NERSfis+wh8mN
 aOrX2zSJUvIssfNpl06kOD4ym+khx5Sq7bcUy93VRwqWIcARlMfOCisFkd+/QGhu35UWjcEBH+i
 EtnQ5KV/Z4sY/UF83Zw==
X-Proofpoint-ORIG-GUID: WN8hJ3I-WMHenvz0xExHmUnnEcP4MjLZ
X-Authority-Analysis: v=2.4 cv=O9isLx9W c=1 sm=1 tr=0 ts=6af467c8 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=icXyEQzqa7ihQCE8Zv4A:9 a=CjuIK1q_8ugA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MSBTYWx0ZWRfX0psGgQeQk31d
 gT63kFcloIUK+MAegyNpbSNnXl8VAsiXgfU0mQ8evnajMPmVDg8IdLYOJp/of4gfXtA6qkl16ko
 1lre18x4l/T6MBqDXuIlS8JR2B2x95E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110051

On Fri, Nov 06, 2026 at 10:44:26PM +0530, Vikash Garodia wrote:
> The OF_IOMMU code relies on OF address parsing helpers, but the
> dependency on OF_ADDRESS is not expressed in Kconfig. As a result,
> of_iommu.c contains CONFIG_OF_ADDRESS guards and a __maybe_unused
> annotation to handle configurations where OF_ADDRESS is disabled.
> 
> Make OF_IOMMU depend on OF_ADDRESS and remove the now unnecessary
> preprocessor guards and __maybe_unused annotation.

Why? What's the problem that you are solving? Why is the current code
bad?

> 
> The only architecture supporting OF without OF_ADDRESS is SPARC, which
> does not use OF_IOMMU, so no functional change is intended.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  drivers/iommu/Kconfig    | 2 +-
>  drivers/iommu/of_iommu.c | 4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 

-- 
With best wishes
Dmitry
