Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794992542;
	b=K9JichY2AWAjS2ag3YAGpO59Vf62kY8qnyLXUuNveB3wRSCR1fTuO92BxHouxHexX7OJ
	 uwhoiohGxZbRBLnv7G++wyw1dZrXyB6kMJtGTc2+WnoAcbfbc+5oBSWIbnFafJJo2innL
	 xqTuQh90kuujl3pblsRrI4sr7h3IfiDaVnthMj4QMD69v5fB6d1IE7PzhhPhFnc/JjNdZ
	 yfX38bgyAwLnjGdOX/y1Z4GVdea8eFm+utPGonfwsvN/daeRgZbVmkHZ6KWJyjy1ggJB9
	 duqSFeUB6+ZK9nrnJJvvFL13dZ0nElhRb4+zFUtTH1E/XZ5GJ7Q0oxZqNR5Q/QpyP2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794992542;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=yyZLaNLsFBfc0JqArcrGxcWEFwZyPv7YYEvEtfwd+rk=;
	b=gS2amkX6JjEeR9h56Y1xq2fVzfMzscy4SlG1QVBZL0ZtJmk5V+YCFhetjs9MtMHEIw3w
	 lqi1msUAtx4PztnWFyFsfZJIMgZv1FrTZB/biO84Akm55wh0ptVXPq9selI85Us+o0GuF
	 i626hoSKhxSdcm7V541b3HVBCHvrtCL693DFlyjrgM4HVZZbcNuiI176nraxYGTQAHSlT
	 csakeCDBtlD0RfZbhk9q/LC/Vy5wABq9pHrszx4CrOJ24jTAH4TT4HcfF5+BEVyOjVgrr
	 ExrcpjObiT2rEauzyoEsWQCiAU9uMyrzerGjLK/UGgvk3ptU90A0PblE+FImZsHX6Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="Fa/9Iryi";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FmWF5Ef3;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7199606A32C
	for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 09:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7199606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Fa/9Iryi;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FmWF5Ef3
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI8DTuT764294
	for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 09:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yyZLaNLsFBfc0JqArcrGxcWE
	FwZyPv7YYEvEtfwd+rk=; b=Fa/9IryizRttAHlUczN/6wai6NYxknNzBYBuBmRe
	NDt4VFh45iJ7hI+MPeJ4R2GM9riVStt4nxDR4y7MF60N1Ilg1hozREdZGUO/fea6
	FRVcg/9sS6c4ubwFp60b1dTvcV7OO09I89EJoCIRlrBZ0+ZFgUyV9SbuDmcZSYYo
	rzmubtC6D0DlMC9+7Ql+yf8bUi8vhMzgK4fl0sJ+nkqlv4xYprIv+z6ZrM0V9DBK
	mP4Pr19Ez5j2LwV4H58BGr/7PMfNz48w1KDCre8iWrNi1C0KtSXiJOvjs05senUV
	px8XfQEY9nsOAUQGfpxynRuWxEeFTTKo2d33wfGYtWyGxA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yvba741-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 09:02:20 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f26dd2165so214284485a.3
        for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 01:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794992539; x=1795597339; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yyZLaNLsFBfc0JqArcrGxcWEFwZyPv7YYEvEtfwd+rk=;
        b=FmWF5Ef3TtD8B+dNRYz4Y5wXptQUEMIack8J3Z4OktF9B9SK/I56CZkl+DcC1oAtVm
         Zq/gBSuLA9JyRP4erxbCZR6XcfFmU0n5vmBtPrruDSVkOyUMf97JZ7p6BTAqmlGBSqkH
         TNflglU6j1F3PBgozpGz4XQavW5/r9jT3Z6fJbbD8MWPAWsF++cj7RHyV5RJnuvEJlnd
         +gvi8A6LzN3kzxkpfw6JExmHEUTPyc9ISUg00gck7lOE/oJkHOLik7cDnYbvu5eVBn2W
         Gk2Y/+z4fGOLjvWiMMDS1byPgsMGSF6C/h/TQcJCk8xMnJxjykMTl7hI/qXj2Etxi6Bx
         UzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794992539; x=1795597339;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yyZLaNLsFBfc0JqArcrGxcWEFwZyPv7YYEvEtfwd+rk=;
        b=HK9WHMVr47/gw9dgWmq18S0t9OiQxLkF7TinhkDMLmmD6fuJle6i/pzSJB1KG+qc9r
         fT3a68gSNO9VAHBsYMF/abMX8NGC4gvUmq7BW1DcRa6UMCDjOl5kV5UFhbUgrZNxHZUL
         XeVqWuf3Ee1veMRUiIfvNMFs0wKHI3C9WqbP8ez4CVFzBHa0BbNwLFBB6F77D8iGRpx8
         +r2yX8iEKFeltNbylF+vMXX3JNA8XMZWhkZIqbzIYQmQKzu8aHnkE7vsxJDNAHo2Ohzx
         7v78Cz4aRadTralU8j1LaF5cYGQ93qPHocX7FPI+zUFxh+06n5zeod+6eJlH8ccpcJAG
         5BDw==
X-Forwarded-Encrypted: i=1; AL+hErGq7F8pXKPm+oNOQUCZAL+vseVp7CBWVW6ll9Lxz2mq2pr2JghbiYX2ZzgXC6ygrnj6ZV1IW3x8LwW+wICJFw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8/FgClgHUQLBCffZFeixaGqDBB9H9xhrZJqgvq+ZR5J2U+U8mA
	B/ALdY6UZ7Dd0hSGDiN28ilIlSCq6Kv4ElNI8X+wR/XU/Zai2F2BNmJI3sDFMvu383sDtWtXD5r
	SZL8xPOkOdx3iaKQWtEMtY9QL5etbzO+elW8owcKirvQFL9Ur8h4yQMK+bgzcHcNsLDxwHA==
X-Gm-Gg: AYBFou3IBgfxPtd3hB+PnF7UDW3TnMlznTRqKu1XnvJa4W04VB4YfPMOKaEsGBLmSgP
	HBNY7qwFYODa0+6m95gYxaVzr0QnTbShVvDVW32MVODIyAT7s5AzrSpKt5e0zb22cSRSH+bbSsF
	MEDbYKAkM/1WuuDsB+Vet9OgGTt77u8Bfar0XCcUwyo3QkM4t8SdGLjqexfnyTs/UXA7TDlgQUo
	y42rKpa3JO6du2jLYbv1eYaMT+ufBopu9t5mIeN7rWIbR20MOqVQUhKUPyw0rEoq9uGtetKtudE
	+st7L4MIGkHruVrcVtveUtmjiW8tBWRGF7mu/kx3GkvKFRzxsylwfPb8s5Vov2hFpeNCZ2LLpC6
	EGQNPAsEGzCyrUKg0Vv1/xGBT7XyboqLiI2Gxtqt9/zW3k/b3J/2Lu29YlBTAi3g1MN44eopjK6
	Wo1TB/Ty3Tj1+7hjJhKqiCsPv4RGfsFrbapdipk1gAB/NxIaRjK8B4/xIzgwG7xw==
X-Received: by 2002:a05:620a:628b:b0:93f:2c95:658c with SMTP id af79cd13be357-9499957e6famr377682085a.14.1794992539343;
        Wed, 18 Nov 2026 01:02:19 -0800 (PST)
X-Received: by 2002:a05:620a:628b:b0:93f:2c95:658c with SMTP id af79cd13be357-9499957e6famr377675585a.14.1794992538630;
        Wed, 18 Nov 2026 01:02:18 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae67b429d7sm4551491fa.36.2026.11.18.01.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 01:02:16 -0800 (PST)
Date: Wed, 18 Nov 2026 11:02:12 +0200
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
Message-ID: <vwg74npvbwdhepp4uownnzlj2ybpiknfktfvrpy6462rdw7snd@tj4vgnn3dtml>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-3-5c0f72083e52@oss.qualcomm.com>
 <yvkcq3zirv5tz2amfbk52a7smbsqs7jrzdisq3qxzw6xkoxklu@rplx3gvxhcoz>
 <dd62aee3-4f23-4904-827c-7f776c4be60a@oss.qualcomm.com>
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
In-Reply-To: <dd62aee3-4f23-4904-827c-7f776c4be60a@oss.qualcomm.com>
X-Proofpoint-GUID: rmxJBO5SB7JMBRV7IqMWvCfAIWKFLdEp
X-Proofpoint-ORIG-GUID: rmxJBO5SB7JMBRV7IqMWvCfAIWKFLdEp
X-Authority-Analysis: v=2.4 cv=YfgodARf c=1 sm=1 tr=0 ts=6afd699c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ypECYpogRKzTefqxK8cA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAzNSBTYWx0ZWRfXzeavzVJCObSQ
 rOWwdo75T1FJg2vDFLq0LpUep6ZAc/8i8qci9GSJBqrTi/+tCZ/yuh3NOF6zmzIL/m6/B9ESnpD
 xJu7lwM7Js6kxHSXwAY6Zjl8Hc9OctE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAzNSBTYWx0ZWRfXyq+8sYp5Voue
 v4gGviBgCRUcTEFlb3xlkHBYNNtyVNKOJSymVxH0l4YpPux6Rp5BV1XfEt9iBP0zepcd4kAcgGO
 0bK0Ij4VlmfhWax9gztecbb20P6vrrdFnaENR5RibGOw/XAK4XIQg/80DzoFxrbRhpbD/eEWf6D
 aIFij269QVv2+9Fnq9Bn335oyl4JFZeltdPzGDi464AlOf6pfWtQeY79UaHuMEvnKX9ZeCw237L
 6VFvfjTCzD4pLueXMvXZeiLNhOGzDN9TrTMopaz6NkE7wP1BCnUeeHmTkbn/fQrUYpqgczyoLQl
 CzYGX5z9QOcDhAh8gvcmzcPv1ygSJiaG8+cCF90sXMUQWqC+wRD7fo5h1VCSc0niJOsmaGn7+GX
 NWOqwazCsveiKlP+bZ382Pt32mKQBqEDLQvcIXQG+TRQWKIdjjSDlqtYnhZRtRdAO8zyf5T8SMv
 tBFYt2UIeT0hfd8Ty7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180035

On Thu, Nov 12, 2026 at 07:10:38PM +0530, Vikash Garodia wrote:
> 
> On 11/11/2026 6:33 PM, Dmitry Baryshkov wrote:
> > On Fri, Nov 06, 2026 at 10:44:26PM +0530, Vikash Garodia wrote:
> > > The OF_IOMMU code relies on OF address parsing helpers, but the
> > > dependency on OF_ADDRESS is not expressed in Kconfig. As a result,
> > > of_iommu.c contains CONFIG_OF_ADDRESS guards and a __maybe_unused
> > > annotation to handle configurations where OF_ADDRESS is disabled.
> > > 
> > > Make OF_IOMMU depend on OF_ADDRESS and remove the now unnecessary
> > > preprocessor guards and __maybe_unused annotation.
> > 
> > Why? What's the problem that you are solving? Why is the current code
> > bad?
> > 
> 
> The commit describes the problem as "The OF_IOMMU code relies on OF address
> parsing helpers, but the dependency on OF_ADDRESS is not expressed in
> Kconfig"...and instead the code had checks for config or __maybe_unused for
> cases like sparc.

What is wrong with this approach? What is the problem? There is one, but
please state it in the commit message. Something is wrong, otherwise you
wouldn't be fixing it.

> 
> It was discussed in prior rev
> https://lore.kernel.org/all/20261104160346.GD3951195-robh@kernel.org/

That's fine, but the reason must be capturedd

> 
> Regards,
> Vikash
> > > 
> > > The only architecture supporting OF without OF_ADDRESS is SPARC, which
> > > does not use OF_IOMMU, so no functional change is intended.
> > > 
> > > Suggested-by: Rob Herring <robh@kernel.org>
> > > Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> > > Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> > > Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> > > ---
> > >   drivers/iommu/Kconfig    | 2 +-
> > >   drivers/iommu/of_iommu.c | 4 +---
> > >   2 files changed, 2 insertions(+), 4 deletions(-)
> > > 
> > 
> 

-- 
With best wishes
Dmitry
