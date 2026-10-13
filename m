Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE7951A722
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 16:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909560; cv=none; b=mdRrEwulDIBQDf/I2KcqlYdJX1EN3vxU7cGfOWuu11DFaHy3UnenIrj1enbgJ+wgq2lJZH0erPiukSU84uIcYdIW7N8yZ73Mm2DLcwVl5miRuaMq5bV0ZRSlm6OStJn2PEBcnNFOtyyFYIHHr0+9lVxzonYTOSlIYN4SfxPFdrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909560; c=relaxed/simple;
	bh=maN9WdDQNyJW7hwIAQoj0chqRIgr2kVisoCOCJBKBW8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCfvCe9oyI6aAB1pH3UZ4LIixta9vde1BvwnO96QATZVC1ZiYkPUk1uJJkTukNPTm54D5RP2pgth6IfpYNmdc1qWjz7vqFmULy5bupSQO5H6aM2nZPQMJG2WwoxGRZo7ARsHq9dxk1NEsuAyT/j3bE4m+PPYQr332Vk3CFc6IGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=OmfsvGvg; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="OmfsvGvg"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DG29vC4133169;
	Tue, 13 Oct 2026 09:39:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=NrtxiVYJba0
	YrHlHuBie68yLp0FWH7fr0REcb0AeLL0=; b=OmfsvGvgRWiHR3oh2Z+9auPT9tf
	T2SDIRdrvf3wKhwmcNVS9Us8NY/wkNFFf0L1I2P/asgwTOGJZFwrYqWmeLh54ebI
	PZLRPS7GJBqOzF8vMJ4FNfMkGrt9nTqGGlUWxfJ2qxkNcJMQklhcpHyKiisiemj9
	SnNg/vNNs4lx6mkJhGy2/lzChIA2yr512RMCTPmCXA1s6IwYeR2pojwjR5mpC0gc
	WWXawypLN3pTyRyMJX/viJf9+cxZAMc4Gc1IylI4ZatDcrxErrksFMDIPSrpYCVd
	8HYY2oLGM1wP+pTRFS82TgHTxpsFcCWKTRhJNn6vLYF4EMUW3N08jM8Y2Qw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4h9kmd2jbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 13 Oct 2026 09:39:16 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1b::2d) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.49; Tue, 13 Oct
 2026 16:39:03 +0000
Date: Tue, 13 Oct 2026 09:39:01 -0700
From: Bobby Eshleman <bobbyeshleman@meta.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <netdev@vger.kernel.org>, <virtualization@lists.linux.dev>,
        <kvm@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet
	<edumazet@kernel.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Jakub
 Kicinski <kuba@kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] MAINTAINERS: add Bobby Eshleman as vsock reviewer
Message-ID: <as5epSRVAJ+C+Ltf@devvm29614.prn0.facebook.com>
References: <20261012-add-maintainers-v1-1-ef0488f460db@meta.com>
 <20261013061724-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261013061724-mutt-send-email-mst@kernel.org>
X-Authority-Analysis: v=2.4 cv=I+jw19gg c=1 sm=1 tr=0 ts=6ace5eb4 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=8elwO82fXORLTBIkMd32:22 a=VabnemYjAAAA:8
 a=20KFwNOVAAAA:8 a=iCU-dymRbZCnDCLPvtkA:9 a=CjuIK1q_8ugA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: Ry9W6e7FNUEVt4HigOCkmYJ59Mcw50Qz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA2NiBTYWx0ZWRfX3Jnxr/rWd6Ml
 Cg2A+ki3B7vnZC3KfWVoItChi0Ss/o2bSv+cRg+eLR4u4pEl0g3w3Jb0IDWkqHmavt+yrA3Vbhq
 BA17q0u1jg2GXj4oScrt0WgFYmkQbtWD2mgBVFu5w8MkJO3Yq6tqMEDQ+mCFUZc9UY9bu1QVIF6
 sPwjHuI7pk/MIrAHflVX3PY4lC8U2o+IdtDB4y2IjiJbm4vIyEyYWmeuayV3RZnCW5FE2puosuz
 eBzc+nLPNquqNgn0cuMrCrT9EB4ejd/rR2JaG5Afanmj84ybMjzjfnUqLU9VfBfZaD2PVRdIQXg
 Q+9RvKmEucIoWoH/dMX0hbGxmooCyAxbbbeOWt36sLKNeFlNjzBCXC8l32lqePJrGG3Bcw9x2u0
 wmWGpeGhE56hWUbu0le54sewXQqhSnMP5gXO96RD/MCpxG9Of8uoEmXl1KP4PYP9fDO9fr7+SVk
 IqXmvoOW0JkBtLXOkJw==
X-Proofpoint-GUID: Ry9W6e7FNUEVt4HigOCkmYJ59Mcw50Qz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA2NiBTYWx0ZWRfX/dt7EVAZv4DG
 g+618KvUKZLynBqaf0nJa+i4Vzq/F/xn1xuszigWNKizVoVPOwLS3xYbXyIfIbPOsgRC44+bdiJ
 2MCwlL2rxNiPzMUI57KjcUD1PLOPGVY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01

On Tue, Oct 13, 2026 at 06:17:43AM -0400, Michael S. Tsirkin wrote:
> On Mon, Oct 12, 2026 at 12:58:08PM -0700, Bobby Eshleman wrote:
> > I've been reviewing vsock via lore+lei for a while now.
> > 
> > Finally adding myself as a formal reviewer, since vsock will continue
> > being stuck with me for the foreseeable future.
> > 
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> 
> Bobby's doing a stellar work.
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Thanks Michael!

Best,
Bobby
