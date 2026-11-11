Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794402101;
	b=1JnGY/ZOj5EdVPEFk5c3XawvBU/ulXwenvogJLow10IAJA6DNrtGOcCwmzaR9LgTk2fa
	 M5u3H46ouN5/AnDktK8MsZCf8Zn2Of/b/dNN1nFHp6YIZ73pQFcswEiDhyXMbRa7PWwH6
	 BgwgJvzfrDHnsnurJarOFMPgmhgCITV8VORkSbSd4Ab6NP+nvw44smYnwb/nW0IgNMU43
	 YvvYEUfjjQta6SGVoR43PjmHwEzRlBlBXu674vLuU/JfW8aga5bM5z+DrMdJ4RC2WNXf9
	 citLKKBnRrf3G+kswLVFvHSLR7BPKlUsZQ+6Z2L8N7QiJV8Df8WoWjkJZQfZrsnirmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402101;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=fNNA5DINfFRpf2eORoYgUUVlbLJUUgtkmYcnEbAYKiY=;
	b=qfykqbOePhm9FX7ozL6UclCSF98Ucm+YZ/jPiwgDazaFgs12il9k7M175EBaq5EnXAud
	 QsmF5p5rUf+H8wGyQqqmCRn9KqR1RJwFU1JG4ZOZUFnqf/6eqgL2hKHe/Ryt3Cg75VqEV
	 +50RaTZrOnweq2c4rCGiJ1jw4x3qvPdxpMksnshWXAqExQGXuS3gtyggLymUT/CM59UHL
	 AlWpygWuHJ6kgp7/pldwwCFYc/mG6K1R+j2ferNT8NNsdSFGjzvrqhar2tOwXKcztCA72
	 Y94r80n4QVoe2EMJP4lr2KDq/FpbQbVjBdiAJhAyqmwFTrluXkagFxASI0JYiodiF+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p6q+meWf;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=duTWuxbe;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C475F606A327
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 13:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C475F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p6q+meWf;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=duTWuxbe
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCYrgL2286480
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 13:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fNNA5DINfFRpf2eORoYgUUVl
	bLJUUgtkmYcnEbAYKiY=; b=p6q+meWfh8pxTAsOPcNqXBXxXBRbH+GJDC4uiwKA
	LJ5hYTCU3/k1FKYji7ugZnbHErDA5WuhE5KzDaz8lgoup47Kf0aitPgAEw3rW0lp
	tMtswTpUYDD8q4tClQtiOBprE7ZUy4pXagV9SgI+lMAfwYQfVHVebO5KPPIcUnid
	chmnqaobA7mVsL+v/gdx+NJL5U1KFoj9M4mB1lr2ZMcQaWN29IzteadEmIgwVhrK
	EIpAcU2xW1xN36ygYXdO+5SKN19CrB5t79dsRs5D885Pvk1tYO8MeB2FCyVs7Qv2
	wejjCK8v+qWke5jhjykBYz7/jQCHfyyuSVzlG19XahwgNg==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvksm98ju-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 13:01:40 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5c83124d530so3684767e0c.2
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 05:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794402099; x=1795006899; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fNNA5DINfFRpf2eORoYgUUVlbLJUUgtkmYcnEbAYKiY=;
        b=duTWuxbeL22Wv5GSwX6dEjVQaRjNKkp/GI4WKaHVvOzDQwwCKOAQFqpRD/CDxXYz/J
         N39iYDjmXZrSYtulFTw3F5i8OS6IkONK7bL/61lkXE8Hx60d6IqYPVPaIAuajnb9Ck+D
         RVqOtIEJPqeQJnkfwXUsWNZiCSZSPkuDwEM2gEdqWcionzRsBcy5b2DDRkiAHWd0AnbW
         qMFCZGWU7O5QZlcgwwsSnHHICtAJ9Wa8DaNtmhjKzuNbswTI6b/7sVMbmHXdNKdGd9z6
         W4xwgIIVFSQbTx8fpyTk0zBy+TZbh1TU3IkLrPTWaki56av1kOu3I04cAqYIqDsHp3c5
         OcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794402099; x=1795006899;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fNNA5DINfFRpf2eORoYgUUVlbLJUUgtkmYcnEbAYKiY=;
        b=k6WNEZtD+LOhUQEr/J6ioGRhami/lGn4upqWg1S5VCefZO5zTbiNjNPplLo5tauflE
         94c+ik1rchXNC/BZMgMk8ePTorVR7Kf1XwGKkp5jlJUKTHfy+kRASDFSYXemfZuGbAlw
         eeyfiRZMQizh7c26npM4vJ2OOGxlNqsZ6R3/Ljt2YBgJjf+zAHr9+PEslxudDyIKstDX
         1k/3zPLQCZoWFM4ISDkLUIEAar2yx2zDtNVkMy4x77EClPFU5JXFkknAqaXK5ppSy7Sq
         TlM0FyQc7U2eaTmGSkyUBpN/wgzHfaojCW59rYPfbZKeosBKWJ5xWzvN5yha3XASbTSu
         ii7Q==
X-Forwarded-Encrypted: i=1; AL+hErH61lGKqA8vPxq67LdQPmh2ajKbZtlUbQQYOvggKlJn962A5h7eZPSqiC6/ohI6yVZNktIRKHFbgNYRZr9reg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9b5517R6QZJT9UbTY2EUeNDuble6S1mUN8TVt4TOU2qcnRfIyy
	kR7u9mBkRmFPAmf5NOjxLNQbzyunay7mFT/uwUqBO2OhiePjmbxuZGPBR3oucX+WJETh3EQbywy
	F7GghJad1UjhZju6apFzz/ohO+30dZUZt7LZlGhsNnulS+eIiw2+21ltGiVj4G1VmBp3Scw==
X-Gm-Gg: AYBFou3TZyAoQ0NaR/xjx33BeYvQtC2nSFTqXkut3XrVAC4GVPGo6K4WFmJOgw7YySf
	iCLFoJQoTdH6CDYOxjelF5dsyKYQ07cULGIO8TTvxNSa3fY1mPDITYb7eOMKltdP0tH6SLmR736
	MLAoIO3RfRfKZT3DJbTzeBmthxmEmCw5yjrhjl9elaHIczyf7x97S/eIEVKu6uRJFVB+3ODdB8v
	IiijKTkmgCpR0bmwEBqgJuDpuRT9i3eQYVwJuZcC7YbANmlmddVoYGc/DEUtYZH0u3nd+SO+CX4
	LJ/EmtLYGE75I78ufROnoSGaNoQnuW+/JYIfdvlIiylW8gqKkc7WHlK2O6dbZjFxGPVQugCJuub
	b4A1TqbKgyvdS6bVuye2tcoBFW8FLnhlEpz5tmtHefxV1rWWjUsVUlLCCVQXJ5TDxwzyqPgFRqm
	gjIrJdD+QwUSRhkJmbOCf3MbsQ2Zf9b7M0G8FSsulO1RpTDH/ygkF0d7yf8B8KBA==
X-Received: by 2002:a05:6122:d12:b0:5ea:389c:520b with SMTP id 71dfb90a1353d-5ee1c3daf90mr672614e0c.8.1794402098947;
        Wed, 11 Nov 2026 05:01:38 -0800 (PST)
X-Received: by 2002:a05:6122:d12:b0:5ea:389c:520b with SMTP id 71dfb90a1353d-5ee1c3daf90mr672510e0c.8.1794402098347;
        Wed, 11 Nov 2026 05:01:38 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c157b7a657sm947505e87.11.2026.11.11.05.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 05:01:37 -0800 (PST)
Date: Wed, 11 Nov 2026 15:01:35 +0200
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
Subject: Re: [PATCH v7 0/5] of_iommu: add support for "iommu-ranges"
Message-ID: <h7j7lyl6d67xfdw3gyabfngpurumbqd6fkcvuhyi4juashcx5r@egybwhfdaonn>
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
X-Proofpoint-GUID: rOqtWwK3DV51BWh1u69UY_kp8Pjzoeo-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MSBTYWx0ZWRfX6dqFo263EAS+
 lrD7KKRjkJPC3wrzuwhYvPqSv0zRxVXLpHxFxy7L8yU9XFWpSjfFwX15mFFBO15G9ITq5V/J4Dv
 SxweQ/lo9/DcFMHDmn/ooHxDpFqxDhtfdpO3XNL3UUQl85iNZYTin4/EtpmVV3SZ/2Xa8b9fW9X
 K6ZZ1NcWK6kpAzWE25VtofwKEON/RN5lEvaZNprJorUteb5guIlomNW7327Q9ijdXFT0Rv1cMRt
 PN7H6prMquAzsyCGUM3Cij0SqUs009yv+jtkQBsGbOdz6LTlJKQKs5jTMXct0ZNBBneGI4l5t0n
 WNMznLM+wapVK+JTMbTLGJOffJFH4gSDrcF0AqYo/ktsxW6Abfy1rIXXlxN7ysu+nWWmZcrTxmF
 jT8dKPlMDjd7Ibu5G4q/dIXrGNKrIBksVNpmRB4Rtg82G9ePtr9Hbrd09AJ0RPVBZPED7hqwnBG
 e+N9hxn1C5yYHUArq9g==
X-Proofpoint-ORIG-GUID: rOqtWwK3DV51BWh1u69UY_kp8Pjzoeo-
X-Authority-Analysis: v=2.4 cv=O9isLx9W c=1 sm=1 tr=0 ts=6af46734 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Ycv8Z8E-TvjlFfbjzzEA:9 a=CjuIK1q_8ugA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MSBTYWx0ZWRfXxNqloEXTTm1r
 mA/A+MUXu5yAaytv1avKEeTdADmtLne38sNIt6EVUJvyRYPyhpvKtzPqVo53+JYfHVfmGjjCXHg
 CLlSkRK8wWvJmdQDF55e8f8s1Ul2FmY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110051

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

FWIW these changes are also required for the DCP display controller to
work on Qualcomm platforms...

-- 
With best wishes
Dmitry
