Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFAC46C844
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 17:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912882; cv=none; b=OF5Vgz0vazhM9Ae0pIpp+JQWtcZQ8lbqRmjjndeBGHX3VETA7UjCsshAG3aXsaG/YrRHPyJ9Nz6PgwJFlaG2gVzmb2cgiZjpopb74CBY8/kK9/69EHwoVHjp+19x1pTdKbj8Q2VC69WtvD/AjZ7SPEfFNGCKHCqWuZ75D/CLjKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912882; c=relaxed/simple;
	bh=D3UYt0i5hAKFhi8tFEEKwRghDne3HmZX19J1SbhWdwA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbQ8U6JlkXQg2uJVIDzkBjup7mm2bOQKkLHo2eVMAjH8WJh92wg9kXSXcmpaBguc8AGfWlKuX4duGNaJQghj3ZECHBCCBqgcuVcgYWTC2XVYRtyo0/PrQi3ep+1ptWA/OTKG6WtSFfz5L96mWd64QziF2FlP39HfU7b8om+WgGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=AeJxApnX; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="AeJxApnX"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DH31Na1158838;
	Tue, 13 Oct 2026 10:34:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=LWL/XRN8x3Z/WAwoivm6i1fVHwe3fxfm0cZor
	ef+30w=; b=AeJxApnXUsz7mSwHpTEM8k99my3aArx+5CsRLETzTtoQj9yegU6AK
	ghB/sP6YuSGn/oSUHNYIw6KYA9QMKS2Gokzzg5hkYEshs7DyrWvurUdQZhM7MDz4
	JW6dULZw1HKgDh8olHw+QhkxDrh9AycpnMFOeYzDPvMlp8HrLEdn+uZW1659AzwH
	tr7QUqt9YP5RlrI+0fk2mzr3yoPpn68OK03+DtnO9WDvFAxEEP75dZbauk2Bd0gy
	z2MILJ/vsj1WlH+yTelF3WbvveRFDHH7cy62y6Am3ITo2ipKFe4CGqrV6bxZvKtq
	T1IYGRh5vsa+kPpVmVYJng9Xkk7VYvhQg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4h9hc43xva-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 13 Oct 2026 10:34:27 -0700 (PDT)
Received: from localhost (2620:10d:c085:208::7cb7) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.49; Tue, 13 Oct
 2026 17:34:26 +0000
Date: Tue, 13 Oct 2026 10:34:26 -0700
From: Bobby Eshleman <bobbyeshleman@meta.com>
To: Daniel Pereira <danielmaraboo@gmail.com>
CC: <sgarzare@redhat.com>, <davem@davemloft.net>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <stefanha@redhat.com>, <mst@redhat.com>,
        <jasowangio@gmail.com>, <xuanzhuo@linux.alibaba.com>,
        <eperezma@redhat.com>, <shuah@kernel.org>, <rdunlap@infradead.org>,
        <donald.hunter@gmail.com>, <edumazet@kernel.org>,
        <virtualization@lists.linux.dev>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <sargun@sargun.me>, <jlinbox@meta.com>
Subject: Re: [PATCH net-next v3 4/7] vsock: add a netlink command to assign
 the g2h device to a netns
Message-ID: <as5roqKrcZ+0WYIj@devvm29614.prn0.facebook.com>
References: <20261012-vsock-guest-ns-v3-0-b32447c66b23@meta.com>
 <20261012-vsock-guest-ns-v3-4-b32447c66b23@meta.com>
 <CAMAsx6fKVQaYLzkK34v5DRkmQS5Ym-XqwNh-+Jj_Uue8NJCNUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMAsx6fKVQaYLzkK34v5DRkmQS5Ym-XqwNh-+Jj_Uue8NJCNUg@mail.gmail.com>
X-Authority-Analysis: v=2.4 cv=L86I0OT8 c=1 sm=1 tr=0 ts=6ace6ba3 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=8nJEP1OIZ-IA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22 a=VabnemYjAAAA:8
 a=IhaVPjiSUfC3lUqgL44A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA2OSBTYWx0ZWRfXweRN4xWDXlRU
 QYe3T0G1lTLn8kzE8+h7GJpNcWDizdt2gDMq2z3tkLHOR3BO/csllYNf97Aw8G79kjqnDYWx372
 9eHx3+N0IrJoKHmFhGifo1o6WS4qR/A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA2OSBTYWx0ZWRfX1QZzySfg7Iql
 zY4V15sByE3oHUpSIIV3Q6s4f4/6Sj2GnR0xww2Mu1pj48pXZ2DnI/Bs48xyuChTigOYIb8Yg5v
 oJSjFsdMsNNT3fYO+iYQ9oi6QCvFvxj6shYyvnd9XQTU6WWhk+tHBphaC/bn7YdpAcMQ+EN7jpB
 jkMUMHocjxur1dOxBHRmAlzIcqsty66EfL58I6pq6k568m2Q9MxsQp9gtNbEMspz2rRBaQGu2ly
 oWAZlq98ZCpTjGtprTUB2yLtOPvvmlpmO7UDoHPpCfEdJhIlP/xHk/c+BGGqzGATB+mFJS7ZY4B
 bYrWl+/3dgk+OS42jgbLxfSqWWP1fqi9h0rjXsUoIJ4Kd9UsQAW0mkx3ys6CjCF9I9w6E4rtXN9
 xVz3YLbRDUupyT9yfIIH5hO7No3g9GxGbHTJjBNnXzGWbJ6bD7r4kjklqwVdqNmUuC3rBkIbBpc
 V4/EsVtkHqo+KLY4Ihg==
X-Proofpoint-ORIG-GUID: crBcu5j1ETahNAP4cu-GvJGR3AqHg4Mk
X-Proofpoint-GUID: crBcu5j1ETahNAP4cu-GvJGR3AqHg4Mk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01

On Mon, Oct 12, 2026 at 10:44:55PM -0300, Daniel Pereira wrote:
> Em seg., 12 de out. de 2026 às 19:51, Bobby Eshleman
> <bobbyeshleman@meta.com> escreveu:
> >
> [...]
> > + Movement to an unreachable local namespace results in sockets being
> > + closed with ECONNRESET. Peers are not guaranteed to be notified via
> > + an RST.
> 
> This reads a bit differently from the sysctl documentation in the same
> patch, which says:
> 
> Connections established before the move, from a namespace that can no
> longer reach the device, are closed with ``ECONNRESET``.
> 
> The net.rst wording also covers moving the device back to init_net from
> a local namespace, which this sentence does not. Maybe use the same
> wording here:
> 
> Connections established before the move, from a namespace that can
> no longer reach the device, are closed with ECONNRESET. Peers are not
> guaranteed to be notified via an RST.
> 
> Daniel

Thanks Daniel, I forgot to update the docs with that change. Your
rewording sounds good to me.

Best,
Bobby
