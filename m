Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795500517;
	b=k+TsAfRabzgfsCf2AekuS1DxHy1XajayEdY3LOv8iuv9Sow8WjdRkPnfvifKtpG0w1Oj
	 3oInuJxWQCvtcJ9U+k/iEiYIvPfiXRAqeEfvbjQXQVvcQntjkP+Pq4BVr3/Wvb5SHyqyD
	 f4xRI48wirhuaCIPaxth0ATsmj8IozIPBMCbuVc7OOPL1blYuPB80a8dFqQphgx7kw/AD
	 UeUE3SegGw6JMjI4ACxLG0Clm37W0w8SLDI6rGEwlBlpjxcmA6Jfii6BURNfFLHgCx1EM
	 mWaHT9bqxVC77Xpj/v4sf/97REchLQTZ63AXUgJQAPkvhJeOTjsT43gPyFxdhWtGbyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795500517;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=dvY4KBfiISm+CQm5KIDUrtb6uzBgUaP0PFQaZpqv52w=;
	b=v+XAQrJigTgZLPog+Gg0xgiaLLT0xbQQQr9EeOwiCzcKPnx9/gP2HPqwc3zim/GaTB11
	 tOGhxSMupmEeOGsA2mU3a2EFG3bVHV2EbzDroKOqJnmIz277Nw8XE8wN9781ymzulNcGB
	 bKhXWsNNYTdF+dfk7gN10xfekKByP7tNcmIgrts87olyrIrSI5Xn+7mEHue8LCgEG9PpW
	 8x0evZTjLkMYHVNUgIhmCWCTWQiztOKrIWir3JbNTaA521ZxWQeRKsxtYGt+TuewYRHB8
	 87rtNhjtodiG4bvJY/4YwK0RtbhjcHpsDnjEmVCvtUIgXbycdoVzE/ODsktJJmd8+tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mu+lZvdL;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RnwT0FsY;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82808606A31E
	for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 06:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82808606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mu+lZvdL;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RnwT0FsY
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO2kWts647168
	for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 06:08:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dvY4KBfiISm+CQm5KIDUrtb6
	uzBgUaP0PFQaZpqv52w=; b=Mu+lZvdLXuWGpOkRTkHFjM/i3/zxBEn62CaGxwiM
	4QAwVoT9XEi4yAVQyTS/Hdf4oK6g4Bc9UAYdPk+DRdycbrtCTJCG8mMPRAhd8Itr
	YJhqFMUPxIvAUoO28f/gr9kwh8uoUQMFVNIJ4mHntvWYoUNjLLZJkNIL9C5NO8j5
	4wzwAtnHxt9pAGjuHvdm/dL4ZGq7SYRNZIslZ6b/jAPWSWpvoexho/kIjWyCe8Go
	XEM9WzZZfx7YDi8VBJiRGkruQKiQYtAWiuR5g/M2YJX70BEeqYi1vnUAfiYQx25H
	1Q6Q3rvSf1diwPrHavfw3ko6BktLi1o93wWElVUR6hp2Ww==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4yvd14kd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 06:08:35 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f26dd2165so1039067185a.3
        for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 22:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795500515; x=1796105315; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dvY4KBfiISm+CQm5KIDUrtb6uzBgUaP0PFQaZpqv52w=;
        b=RnwT0FsYHLeD5Sz6jKI8fBrv77b6PZiBSxwAQU3+64E2vDZLBpE4TQIOObMtrZYVS6
         WBNfu8eshQgIEZmrZ1uXrPPc0Rqu5eYniyHMvKm9bHRz0EoDN0WHRrWNsTgGJC31tl3y
         x4l1hoOLE2RqChWNMo8NrMraU0e2fqcxGrjq2viwGTqwA3L7ANjVdqNKYC05IXy6tu1P
         WzBKyznetBCEWgnSdcxmMf2HBKEfFV1f0rl5NN8qaycaf+7JsJYXCzcQZMb7ugKI3G2t
         F+RAOU6Jp3/TYuOay2QcP80SPgQT2x1YS0JAHPHM0ye7YrpPC0e1c32Z79evOtD4+GD/
         lTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795500515; x=1796105315;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dvY4KBfiISm+CQm5KIDUrtb6uzBgUaP0PFQaZpqv52w=;
        b=MVncVx6IO0SiS1oRHIw+3z2TI5JGSjyT3SD+C8CAFIJlag8yf1ySzx+G/XVrVYvfy5
         pj06SOEho6kz1GUh9qZ6i8/SW4k1423xTPFQzZuafbCO6NjDGJVZAZN+QD1oLHWDcVZB
         yHNDFQ26ch1c7Ir6oX/tkb0xDFU42XDL2SXgwqvlYqpoXnODutITQH82RzIXoWT/fSMD
         cj5SUEYtcvYwuAOFH8TIg/sE1NqVtBOFp4O709zxwp7Sjsbz4b9BeYS9Aj2yRPMDM+Gw
         dcGME0uwQfm51ZTogpLgeDi2GlajVMHFFQLy8Ocz12q7R4qku938natB2T4fTjl0eiwS
         bsBQ==
X-Forwarded-Encrypted: i=1; AL+hErF4d06O3beslj6qzgaoIKpDtncRsNa+Y0YGfR6wLYFpVQiBQaJ9fFSED3ew7xtIhiJTi34/gzA2Su+JgeZATQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/2+BWff/G+Uao+X0yHm6y2sqQ32Dw6iFs7titwhuzO/s7i46vi
	s7HWvvnt7ZAxfQf6/5rr7VqKi3sWJQgcWxymsUO3D0gk005BXYKvUJ/pDWulAI/Laff/JuteZ5B
	pqlyzpchpvMv5fPDQ34+btUTxrS4nyuNzbjHRSr8JkLSN+97NNCnSvTm/hmqfD8OnXS7tMw==
X-Gm-Gg: AZFdTZcVnjx+neSKrZWQbOafJst8Jhs0v/BdYibqJeb3KqMYSrPErtRiB2j6939bA9U
	Gf82wakwD5LJguQxhr63nhT6GYl/nRcZYtFLtSc57BLH229M9mSLbefl/thh93zi/hVwzlyxwxE
	Rs6My29YPeAm9QobfxGhsG0zx/W1bbXiWvvHORPf2Y6I6PJbqVyq/DmVYwRUjj9y6ENvFASVEwy
	Crg8Qd1xwqOCXcAF9kvVYzynTP2g+/TdKKq/aboxwMnoC9iNOa4XwBzM0L1m+NGeerFM05zP8z8
	15/DoYspqarcSziPYhtp8xjS8PLpbckcjlFSe/Wu37HwtU2CKzNvDN7ynNOUbfsBbSz0xWlatkY
	QX5cZ8XX2JYmkO7jDeqDlRoCJ/1UfwMj55+2YocxtLSIfHRa+Ee1z6BEWlbE46+4=
X-Received: by 2002:a05:620a:3185:b0:93e:94a4:a97d with SMTP id af79cd13be357-949ba683204mr2433058085a.0.1795500514633;
        Mon, 23 Nov 2026 22:08:34 -0800 (PST)
X-Received: by 2002:a05:620a:3185:b0:93e:94a4:a97d with SMTP id af79cd13be357-949ba683204mr2433050285a.0.1795500514001;
        Mon, 23 Nov 2026 22:08:34 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ad644140b5sm23005124f8f.17.2026.11.23.22.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 22:08:33 -0800 (PST)
Date: Tue, 24 Nov 2026 08:08:29 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowangio@gmail.com>,
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Jens Wiklander <jenswi@kernel.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Cochran <richardcochran@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux.dev, linux-sgx@vger.kernel.org,
        selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org
Subject: Re: [PATCH 10/14] soc: qcom: rmtfs_mem: convert mmap hook to
 mmap_prepare
Message-ID: <7zkdydihgjnqxerwzbebrcryry37hcqc47dpzqmoxdgc7qt3i6@uanst4lmvvkn>
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
 <20261105-late-2026-mmap_prepare-v1-10-c56aadfbab8a@kernel.org>
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
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-10-c56aadfbab8a@kernel.org>
X-Authority-Analysis: v=2.4 cv=ZYeIpcVA c=1 sm=1 tr=0 ts=6b0529e3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=2UNkV1bVvYdQOko7pskA:9 a=CjuIK1q_8ugA:10
 a=QtEvL3ry9E0A:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAyNCBTYWx0ZWRfX8VNsTZOzAzIO
 rhzWEJAJt2bueQ9Js8q1bysZEfObySfzOlemoUvjhkaKtx8smc7GZxSvz76trcvgaAolU2KNoK8
 GUD+Wlm0P5ehj4AyAPH1jAdY1IzzfRk6YPG/QaH36YZ2MshZ+BNcADGukZ8C/CMiWvY/EyvgKxL
 KPEDIz6d7PLx80QPzhtVL+jBJYCve2fkd4XXMh95E85RHp3vkJLVQLzhzWHzHPvxuSun3/qnYJe
 yT3teJWAGagLNjHxRLUMWf0IwuTGT5Z0KQkfHgk8ig4YCWmq3A3Zy9Ucml0XI03QwCXCw6kuL5z
 cyVlkDCPel2PUPIrr0k+tJtHWauixpGbilFJYiOOy/inscgzbIdVAPc1+++av6eJFDye89hx/r2
 O6c03gWWa0Og9vAWhgIJ8c/kvqdYun2sbSw0djMmlLg8B1d7CY/xMt/bHAm6ZF8mZUrC73vxDji
 G3R7As2PjYM8k7RepPg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAyNCBTYWx0ZWRfX0PRnd5jiijYe
 yBCHU7+Ko3mi+yWivOLljC39XviRqobn29zvT9VPERNAhP9/cvoWSIRWHjdsN/v5ah+vD8b0LUE
 hgD6bTn/+84qhUwdbVxOqgJClqhY9rQ=
X-Proofpoint-ORIG-GUID: nL6TUGmIWx24tHOGMif9NLSGMhblacRX
X-Proofpoint-GUID: nL6TUGmIWx24tHOGMif9NLSGMhblacRX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240024

On 26-11-05 21:05:41, Lorenzo Stoakes (ARM) wrote:
> Move from the deprecated mmap hook to the new mmap_prepare hook, using the
> PFN remap mmap action to map the region.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

LGTM, so:

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
