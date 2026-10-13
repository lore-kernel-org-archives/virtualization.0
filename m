Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EAF51C340
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 16:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909661; cv=none; b=KLM1anyW97C8GP/RBt3Ftg5njY820ScWFJmK9nYUEAli4Q7xt3QU+kJ2ln26CUMhbMBzYEU/Qb89d4qBmB8HbgMv6RSa14pDCwUqeJEUoIfHtq/oH9Yv86E+I+fcBaFXmu1DjVahH/b4N6VjU5Xzh4dvew6pvOGBFXxBKV7khis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909661; c=relaxed/simple;
	bh=8te07FYLgPO91T7wo0EFOQyReV3FSbf/3hKKuAcj+cA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUP+d6N6FJe9l1HhnTsVQExaKhzW2CA2mJaYj3n6+VvZDH9Z+qF59o3bvMV6yAFgkjywm3KnhnDDS3ZkBPBGcXxuDagRfLqWK3SXMINbxiDY4/ZCraCCI6I4jS7UrWu/LdozuLA5v3ksoOThuIA1EwSxno9yJpVAib+GVDimq08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=K19lZGds; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="K19lZGds"
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DG26XJ1037957;
	Tue, 13 Oct 2026 09:40:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=xGFk0Q0ppkN
	vQhqnT6zebW3QAQf84npqNgH0cWSwwD8=; b=K19lZGdsvVyMm4lufXEqqBp84BI
	d7bmIIZdfHK2A5zuES7kVhMLpnw96KKHs9dwUa4R+GcGAcrujfjzxkYCZvgGPiED
	7cEUyfj7CoyNKLod7ZPUKqHD0EN5nmX9lYF5vQLw6bxXr6l4EwWv3V2YI2N+A8SF
	OnoibH/Objz67uNcnvosrm4s/7A64m5nK1bXgK/dXsfcwsHZl11tODvl+n9t50xp
	GvDMvxhLzQFLI/JkdDjIKxnnN8LCoc4H+ODtaVu/gL1RJKlhagLevQa+K/Sn585q
	VvMUd/CY8UXjx992zCGawWQ518kfoOJpRxrJ1cZ7QxAYF80zER+B8BqsXJg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4h9qt6rck7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 13 Oct 2026 09:40:53 -0700 (PDT)
Received: from localhost (2620:10d:c085:108::150d) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.49; Tue, 13 Oct
 2026 16:40:52 +0000
Date: Tue, 13 Oct 2026 09:40:52 -0700
From: Bobby Eshleman <bobbyeshleman@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>
CC: <netdev@vger.kernel.org>, <virtualization@lists.linux.dev>,
        <kvm@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Stefan Hajnoczi
	<stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] MAINTAINERS: add Bobby Eshleman as vsock reviewer
Message-ID: <as5fFGRffTpxNKfV@devvm29614.prn0.facebook.com>
References: <20261012-add-maintainers-v1-1-ef0488f460db@meta.com>
 <as32zxVBpgdtMUOU@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <as32zxVBpgdtMUOU@sgarzare-redhat>
X-Proofpoint-GUID: hStfsbLFP7IHG8JuIEBYVT65QoaWEKlB
X-Proofpoint-ORIG-GUID: hStfsbLFP7IHG8JuIEBYVT65QoaWEKlB
X-Authority-Analysis: v=2.4 cv=OPKyTiaB c=1 sm=1 tr=0 ts=6ace5f15 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=03ozwUkBphtHgyqjj1sw:22 a=VabnemYjAAAA:8
 a=20KFwNOVAAAA:8 a=tIo0XsLEN4aCIxp0aswA:9 a=CjuIK1q_8ugA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA2NiBTYWx0ZWRfX0Kul/WHXPAx6
 /YMMCh19J/Lg6gqSyrnDGY3YsS4stcRFU5SsCS4KSlpMN2Eva/cGq0xSUnitnMsRC++OhjmQEEy
 O+JjQZFfk2ki4Y4MUWSZGM70dcUgucqCpcpVru2p/KuG2iMnwpto2NVuQrJ3kJSMAntjbqi0d5o
 V6HH5m7XpKOZiNULj6DK63fbbBsy95i7r90c6IRX4LQ4v/fIjbRJp6gc7vkGiUtROSbOSdL2e9V
 0ZHG9IpTFlO/cY84GQFtisNxx2ZpqTEYBfKYjheh6mzHH/DkBh8w/fH/BZjkJOSkrGrKffeu+Hg
 JvDMzgKm4OnzEcRSNcgWzkRuiLmmuTEqzxoktWR+hyi5WgNoSpsfPZs2teMKSvmD5NUcBEJ19nX
 yR10s0KiGtxO4mmMb8rXFOoapUOt1B0ge0ZZlw+nCA0Gus2U4bKTJWqAITQHNrwxqooVzd2nZ2c
 /srp+z6iRqupBgSnhKA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA2NiBTYWx0ZWRfX8zVmtkina8lU
 92vPSvs+GF7iYjGKTcjgf93d2367528PjGFebd1c07haU5rYNVxYHoAc/M+5qvlV3Ta5+R9GHWv
 kBwJ84LPR8LXNiwUtY6DLfehkBk7fmg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01

On Tue, Oct 13, 2026 at 11:18:59AM +0200, Stefano Garzarella wrote:
> On Mon, Oct 12, 2026 at 12:58:08PM -0700, Bobby Eshleman wrote:
> > I've been reviewing vsock via lore+lei for a while now.
> > 
> > Finally adding myself as a formal reviewer, since vsock will continue
> > being stuck with me for the foreseeable future.
> 
> Thank you so much for agreeing to help when we met at LPC xD

Happy to help! Thanks for all the work you've put into my patches in the
past and into vsock in general.

> 
> > 
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > MAINTAINERS | 2 ++
> > 1 file changed, 2 insertions(+)
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> 

Thanks!

Best,
Bobby
