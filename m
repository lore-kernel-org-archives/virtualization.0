Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794402156;
	b=m4bbxbsSru0APswXzsl2pbA2cbo6q0DcwTfbROnzb2bbKN3bBcuhJmYLvg/XM9Z+zeFb
	 LZgj4pVAZNbVl5POej/O6sYRTcW+KbgytVYgsiMyNE2H9ChhWur7tBqnlbUiCsr8yuX1B
	 HPtT7PgBhipjMoXFPiq7/yUl9tSpT4JqY6lSudwF2XfMgVarWQrtB6Y8l+JliyY6u1INf
	 NIXMJeWVnD9K8vLmVvAZ2knPriB8zyLktaADAJSMu6UYrYirh28tuLyyUVuvS71ccaNiE
	 AtNBOGyZOJ2oPQ1v8JFuxuatyKUx9eZxTeTQawoI/sHcsqpHBvpp8+iMlMo+t6FoZOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402156;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=gL7PRluqOkzpLiN/UK7bTD43fl5T1IxvJlK3ZPRyK2w=;
	b=Pe0243Rp35nIwfwF5LYLOJ79BtZ3OUHgXBl8pR40UHCZ4pQau+CsxKJUuqjohNYBfeYz
	 piwl5FZ90Wt25hgKd2/iA4EM0Rs34y6AbHrQDW/x+wg9hLYbnW/RBOfq9pGV7GCZYKUqe
	 NppJRJ8Z0XTCU2ghRjb4bGmeW9r3WGvIYZrPuqw/UZ2FX/+NQD469+4HK8dJNhX4I1zkd
	 jxToq7XuAY9ahk5nLsVs6LBW3/TUrEEiP9A8RIxK2l3dxhdv9qF5mCjjGvjhKcrJFeDDW
	 flUFhd00Ky7UiP9FU5e7zVKRv+9WnFJg+7d2NxV1mj5i+GGgh1or52KQvrklH5EgYuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EMYvY7ez;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IuUDYmaS;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A5A606A894
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 13:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12A5A606A894
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EMYvY7ez;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IuUDYmaS
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCYt2I1806572
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 13:02:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gL7PRluqOkzpLiN/UK7bTD43
	fl5T1IxvJlK3ZPRyK2w=; b=EMYvY7ezmzJ0k40Xt1ZuHaDmzZ3tilOwId0a9hlK
	AQFxTU37UV7LI9UXhgIZXO+CS4P1RpIm31tkGUjuTadL6oV/3qq5WgSSD226R9jq
	qbuJpilJYMz5hu+B4t0TpR9eAGf0kyGl6OxeDSpq33jzWKKYVKt79BbIX4u1X0qP
	cJm3uxvBWcuaQzBZtQiXE3DtrPa7XqBEy1P3zNquohvHnQRdxZEtl8aP4O8ghzH7
	uRH0iP7kni+J5wq4twsVr3vu5IRzq71lqawbB3iNG2K8r+T+a3vPWopy/oXK/jEt
	GJr5A2ke5Kkqx9r8eJKJwPyt0NYJlJ0rwoN4LJOSqulQGQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvfawj7hr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 13:02:34 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5eacd2f2229so3551830e0c.0
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 05:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794402154; x=1795006954; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gL7PRluqOkzpLiN/UK7bTD43fl5T1IxvJlK3ZPRyK2w=;
        b=IuUDYmaSALa74nGIZ8AH51AvvdL58eqbUvFNjr6K9VeIVGsFFxjdYjIwf7xML8ToqW
         Aiq8camDSDqWSQZnT4vW1jjG8ZhGWzGMn6XV01wSNXvEu6Jt878TKsRFqE+Bb6EcjM8Q
         R0zucNjZUIOit2FAba6UJQK8pDZA+f30Iu+gGUam6MFDnr3uE+ca7EMDfvrqdL5+VeKX
         WFss6G3wRa/ktfh/nsqf6xErarDpaapxAhIBY/7P6X7iuTsGsQdwRGdpwBCFpBhJ4cvP
         eRCj6Cee7Vqt9MD66UMNSXJqsU7JQ0u7YL+iSvdWxfWAi8jZq2g9V9Zl9WxvOq+QoGvq
         bE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794402154; x=1795006954;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gL7PRluqOkzpLiN/UK7bTD43fl5T1IxvJlK3ZPRyK2w=;
        b=pv54SCZHyurstBIGwc22Upvg2PRbKjzwrSRncF6VMNIpfIOoQHsLBXTFw1Yg1x+/WR
         YaTBxRfVoJMdoWaejsd+cb7eqpe+eMDM3exd8x2U61q0NfICvoyM4N+rhOeoEnvLYcWW
         foAxx+u+wz246nZe8TpbQiQFVdZw/mMVXhCus3QQ8PMkJPL+HWOWlSVohAhmbEGHZltJ
         Kzr8rPg5BUJfAv4FqKYlOomXG5n8wXIX+Adtrsxx4QR2izhF/JNigDORQ+k46RqC4jfL
         wWv2dVE+4f9NvASm7lSR3iPRKdqqImd803wZfkV5y58DJBhho2fYRcbHTEFY8H1Ve0yt
         1a6w==
X-Forwarded-Encrypted: i=1; AL+hErG2a+Eq8+cnDxQJ7WlZCS/CSrxuQj8sDNKJU9h0bsB5GYBUONiXQeXswfZO8Tf9fwn4lR4y6tFkujsnujxUHA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8ESDtuyF/amgn58U7cG8iehScZcN1QXk2v+kud8REeM0etXuQi
	nuB7Zw9fcPSyiVphjJcB2EH2btD9z009hS5ugJi6ncpkeot08QuLgpiYR4qosv0pDvoa+5lshZk
	DyqlCMcE4B5YMzAg36+yOaD83TDSWsvZ285+pCco0aQWQFmoDnKlJqcX95Kozi19m6PMy0A==
X-Gm-Gg: AYBFou269+F7dAEaKdFQ97W8T4lnzYO1izb6uF2e8nQcL7hklnA6NkFDzNpDpE9bkuD
	TY3Z6abYHFI2anT377EIhmxP8ekoSKmKXU78lgWmKngPxutNGzjJqhbIXDzUt0XquNR219mm9SG
	0hryZPydIojEOOvpzWP/tHq8iRdV46UqgYTneF09aAdpst6Hib5vgIlFyC97xk8FrUz2NigZtxb
	xwvu+fWH5lXP31XZ12+yJkUEvTrNh/KIUGAS1KQULaH71PGwk2qU0kc5l/NUUIWl/fSTWxBWktg
	qwmjfT0ePYSZmlBS3pVE+lvUfYVO7byCWQW8bQM924qCJk1v9AtCQl7ZL1QzncgcCOrK6SUGumr
	CblhqtOvIbC+njDOrk/7nwMAOfetFwK2z36atM04+bi1lfXLiJA+I5H1JFbYrBI5xbdCJc0+ial
	e0P7XJmM/7yh4LpWyTdC12hp2KZh1RnfdprUP43xKjDEOlPdgpWW3EMfrim3ULBQ==
X-Received: by 2002:a05:6122:e248:b0:5ec:c180:e1a1 with SMTP id 71dfb90a1353d-5ee1c292c8bmr762379e0c.2.1794402153792;
        Wed, 11 Nov 2026 05:02:33 -0800 (PST)
X-Received: by 2002:a05:6122:e248:b0:5ec:c180:e1a1 with SMTP id 71dfb90a1353d-5ee1c292c8bmr762282e0c.2.1794402153278;
        Wed, 11 Nov 2026 05:02:33 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c157baba35sm933313e87.46.2026.11.11.05.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 05:02:32 -0800 (PST)
Date: Wed, 11 Nov 2026 15:02:30 +0200
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
Subject: Re: [PATCH v7 2/5] iommu: Use resource_size_t for reserved region
 length
Message-ID: <hn7dczsvgtq6siyikoaf6y5stlacmdyq53eg4mhyonugjhujlp@7k4cxflzuu56>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-2-5c0f72083e52@oss.qualcomm.com>
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
In-Reply-To: <20261106-add_iommu_ranges-v7-2-5c0f72083e52@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MSBTYWx0ZWRfXyfHnAVKFvJCH
 dOCS5HUr9DooxAwBRmTfBAZ18xfcIydOYmQcTMLRDmO0g/QAWpGk6UB6DeeKLgtuXVPbXWu42Bu
 Pi2ZrOr2fOLRl/SiRhzGduEfWI1ZXh0=
X-Proofpoint-ORIG-GUID: aS8tYHhRSUn7HCEXfwmBjwPUY3nMSLRv
X-Proofpoint-GUID: aS8tYHhRSUn7HCEXfwmBjwPUY3nMSLRv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MSBTYWx0ZWRfX9d8jFX6KSwea
 Kax2KKojERO7mbdfgYYoiutNgaBjGJb2Gz6T6MDp/gK/eSeQDM6f5nJewxrA9GlWxm76nL0tOvj
 zG1ABzhGOmm4DLWS0gU0STwjNB+guMazGzgPaxfKovPmb/zRv9EZ0WdTLjdwyhWZC5N5/GdqWE2
 Ha/Pc5XJCAdWLcIZskrP+uvlSLQrIEdAf8z93atXuBDL+jqT+GDAZMSdZ6kcJTpqiKLU2nodiA9
 sM/XYsyWpxwyKwi9ajsNcH/Pm2ieh9wNyIZS1R0k1tWn5Wrs442KnzHPUfbK9lM6u5ET2PmsOEv
 NsA28UfRsIn/iLmQSyYyrsIIPgjOnAXmp44PAIti8ZBzzBk+OWs7/ie2kp1oCzltOqudUq4shZd
 iFM/wCTVOgYBlgEEp1/sff/V4w6xpoBXqCz4KNqNzqgCxBr6YWc+bTGEZPp5nyxJTPq7U8TBzuL
 5gErgbfwjrUmXygAW6Q==
X-Authority-Analysis: v=2.4 cv=CZadd7rl c=1 sm=1 tr=0 ts=6af4676a cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=EE9pRYFAw_fItPXnlVYA:9 a=CjuIK1q_8ugA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110051

On Fri, Nov 06, 2026 at 10:44:25PM +0530, Vikash Garodia wrote:
> On 32-bit systems with LPAE, physical addresses are 64-bit. A reserved
> region can be larger than 4GiB, but its length is stored as size_t,
> which is only 32-bit there. The length gets truncated.
> Use resource_size_t for the length so it matches the width of
> phys_addr_t and holds the full size of the region.
> 
> Fixes: 2b20cbba3390 ("iommu: iommu_alloc_resv_region")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/d223ee9f-b262-408a-a201-8b16d310bbe0@oss.qualcomm.com
> Cc: stable@vger.kernel.org
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  drivers/iommu/amd/iommu.c       | 2 +-
>  drivers/iommu/intel/iommu.c     | 2 +-
>  drivers/iommu/iommu.c           | 2 +-
>  drivers/iommu/of_iommu.c        | 4 ++--
>  drivers/iommu/virtio-iommu.c    | 2 +-
>  drivers/of/address.c            | 2 +-
>  drivers/vfio/vfio_iommu_type1.c | 2 +-
>  include/linux/iommu.h           | 4 ++--
>  include/linux/of_address.h      | 2 +-
>  9 files changed, 11 insertions(+), 11 deletions(-)
> 

Thanks!


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry
