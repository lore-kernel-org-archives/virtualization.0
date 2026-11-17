Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794878442;
	b=sej893k/k39JlXX0ewj27f2M6n11UEWZ5IzVIFwRpy5uq6qt2OjbIPELvCN9zw84o+tB
	 dhQwRXxqxv+5QBi+NaHqWM4+uqhATOmPzMfbdUIql9UwpT1mhtiRlQmrWkA2dYjxQ9iR/
	 RyVIcz6OuKCXnKnwCMeMdghvgGGilmDa7TvoB+8vVk/IqJT+nUYBgzPfdEh7FG08zHfQk
	 RxNBTcCZsb3hiGDhjfcGOwIK8X/G9BRuM/yoLm3+Tgpzsnj5H38ESA44RgmkrsEA6ZBLE
	 Hc9oz429DB2IevE6Zjkluqq3SG2aFpB7NnHrq9/sDXyeTLSTEdJ3v0YVG/fPzFd3pHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794878442;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 CC:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Originating-IP:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version;
	bh=OCUSDcMhdyhMckP1nD+6v+1CUzBRpaT6XP/KSo+6PZo=;
	b=PhFFqCncsD2GF4JBoBm3tdoFpsb67/3C7y0wCtAT2cM5uzvs4mVtKyTRBxcpVv/fRWdr
	 K1VO+lKLRTN8DcPatjzgrWpIVeXfE3n+qi+hR5dwSqEvL7w6nbjKGUJ+oLPqYpiA4cDOL
	 mfge5fKOS7Z04z8qx4NuoT9dpy+AMwecQV6uBeJuMue+Tjd2h3r488G5aPmfIaiczDmvV
	 0gIjw4x19sxdgWJY96h7eE9FWtX1CkGVqd6fq/oPhtO60ZVUdF4qMju6N/8FW0MFOF4o2
	 EkMf5NAIKkf+NpuIRzqFOI7aA3pGubm4p8N77Fk2ydyPiTPHxEmxCT4a+OmZ218/p4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=kzonGr2p;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD23606A31C
	for <virtualization@lists.linux.dev>; Tue, 17 Nov 2026 01:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CD23606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=kzonGr2p
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGNPxWO3668401;
	Mon, 16 Nov 2026 17:20:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=OCUSDcMhdyh
	MckP1nD+6v+1CUzBRpaT6XP/KSo+6PZo=; b=kzonGr2pjePeH4erX4OnuT9Tq4n
	JOALdJskj3e2MslEfcjuT/C2tBSDl4PBCDJPkCS0Bb378Y955X7gB+8LLwkpwMLh
	eq8es+kHJzl8N7Q3Xc1xKIyKOeiCrCrZ9/aOoHrt8ixSneIX3qqNDBvocxuFfyb3
	Ehl3CteEnL2e/V2jZ3wa2ZV4Iqzy9eZlygLbjudEe/8wHRHNKCDms4TmEttX4VUw
	jgsOqRxZH2xCUSLfosTnr8OqeddZDoPqpGvTlDI7RIeEer0+nsJ61DQhRgj0274R
	qbIiQMTBSPPhJwoMiLlVO53pTICQJ4XFF74poSUlXl1jfOHXLP80bVuig4A==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hxmj4e8m0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 16 Nov 2026 17:20:34 -0800 (PST)
Received: from localhost (2620:10d:c085:108::150d) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Tue, 17 Nov
 2026 01:20:34 +0000
Date: Mon, 16 Nov 2026 17:20:33 -0800
From: Bobby Eshleman <bobbyeshleman@meta.com>
To: <netdev-bot+sinfo@kernel.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella
	<sgarzare@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang
	<jasowangio@gmail.com>,
        Eugenio =?iso-8859-1?Q?P=E9rez?=
	<eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>,
        <kvm@vger.kernel.org>, <virtualization@lists.linux.dev>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] vsock: only deliver taps to namespaces that can
 reach the device
Message-ID: <avur4Uwbv27bGG67@devvm29614.prn0.facebook.com>
References: <20261116-vsock-tap-net-v1-1-7e24f45adad3@meta.com>
 <179487315810.3291.12142099363352099423@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <179487315810.3291.12142099363352099423@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAwNCBTYWx0ZWRfX6tiSf8A8QvZ6
 Fo0aHzb2/EikCju9G8HPPKwjgsnmuSWFHHjGheIYxN1hjK0Rj9h7+/LmI+6EN976q0cusZk9CPR
 Xqn7R97cUs4zTBAnmwsgYYDcDceBT+g=
X-Proofpoint-ORIG-GUID: CLI4lnM_zEfR7xHMHy2yu8qcgr_dCNHw
X-Proofpoint-GUID: CLI4lnM_zEfR7xHMHy2yu8qcgr_dCNHw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAwNCBTYWx0ZWRfXwADsIqFhERM5
 c3952tnTfD9HPGKYekysLCzCIqeAJfP2qzHTlycLlXpSqhJumprgj2MXpfzCmLztckim1q1xbf5
 +2fDKT4RVFo/QLJpnf4t0gcJy3zvsuEyjl0Iup/jO6jZ7zHfMMji+wtHniVY+kXHu/PKUfR/Zbj
 K/P5+k7fZHGWki8iklbK2bj8YCJ3OXvtyd+pvCBWJ5GIGRh4Bjz2x1KJvT094/Hi7I/oHnhe9nK
 fMqC+bA3rYMdidR5yyyqLiaBTE+gPtyX2vP1/lHEBT5lmRK15QpDpexH6zvvU0+/Yj7PADdFU/m
 oYtsA71hPlRPeFMXl3AdDTW/Mch8PHz4c09V1gN/lbrnWsJ5FkwhJVUDFYQQPCqdFtDawJhvZfg
 ElJ4Jr/df8z3jT7lb1KR8nObarhctDYbutkPnWwKyaClfTylfrkQRVCfLBJ/itcBFollGAsvmWp
 WOLvqhmBNn0/XN/bsmw==
X-Authority-Analysis: v=2.4 cv=Vp+2kO2n c=1 sm=1 tr=0 ts=6afbabe2 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=tpM8CJlwf7uhpglF1g9U:22 a=VwQbUJbxAAAA:8
 a=CG_4ueNEfuzfKVZALy4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_07,2026-11-16_01,2025-10-01_01

On Mon, Nov 16, 2026 at 11:52:38PM +0000, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
> 
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by LLM and not proven at runtime). If it was triggered
>    please include the symptoms, like the stack trace or kernel messages.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account.
> 
> *IMPORTANT*: If you do repost (for other reasons) - please include
> the relevant info in the cover letter or commit messages.
> -- 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

This is a known issue and has come up in review of the guest netns
series (so via code inspection).

Best,
Bobby
