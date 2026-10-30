Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793398125;
	b=ehlGFn82JiZGcZwuWIaoJkYsAMgldkt346WTunl7V/11dWWaKX5PRsvIAN3J19mHnjRR
	 MwkKNjmy8CPnhBfkBRzJ3DTAKpYfgb9Po7cEFS6TeGLhUKEithQdE9EcqCVVD4qrRF7RA
	 twM7yGNlpCWSYrdKVGCnarqmIMIiGOiyQWB+VvoOPEM/4Y3cWl7mkN/zU/5ieHz3a2x35
	 EtJXal0LlWoqXfRQ+IQBEuRluUpIv3wL/TUygs6MrvFvopuq5jNGsVMgSCK3I6U/EBIdS
	 5W7cr/EuJy4hjVrzYsxBuHZ1I/n6nqeMPrNab8iNLjOit9ClzrxkKE9WxM9lmRCE2vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793398125;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 CC:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Originating-IP:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version;
	bh=IICohW+gXVTtyus0Zx3MeKtRFKP0xbPml/xUyCDOv9s=;
	b=jls3V2YEM7GwCWK+jlxfTmEI02eKcT0RWtpnGvLpvgC7KVAWCZM8IGT4s5nmjWKerAqY
	 imk5KJn/O6nOASx/gDZOzRXyc6I6vRnbbQ9/0N1JFCuxhTY4rOwEWi20e4KqBBhf09xCo
	 X3IRpJsO3Oq4geNgv9XQq8WsdYuqTVI4O3en6b81CLwRnkAZ+dibeHkZG9CaG7Scs1cJx
	 tz3i2bxwJDEapuGofdaBKZ0PvikY+i3lGfICr5v6Gt1S3TAZFf2sPZ9L9P9w405RJYMVL
	 Tt+ayC9wdzMOGONCb9vy2uQRNQrPj4Etohr6nXkdwpFXM2+yxpaF2x3T1Wu1NQy3zuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=VNaMJH8W;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86721606A32C
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 22:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86721606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=VNaMJH8W
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69ULuIu63232843;
	Fri, 30 Oct 2026 15:08:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=IICohW+gXVT
	tyus0Zx3MeKtRFKP0xbPml/xUyCDOv9s=; b=VNaMJH8W1qAXMgaK9QFqxOnGKfV
	KRbHYwrd92+9z5CesSdl54DmSlguoQJKICFhLsbM2F5omxvdYGVT9MOoQKt9veEJ
	yKrUeW3/Q7cwsTidwGG2X4xzkyoPOg1Oq7A6EGS3drqoY990Kn7wu7HqG9PANsbE
	0dc3yLp+5i9NPnvK0bHbZN6+a7FKWSsfFdG17gs1pINX9DYQBQVN1RfVE6fELtca
	DuLtO8TS/Jx+pGl6GqAcU7hfEwMsLE+tCCAErEFagTCMfuzyHD42n5alUTWbMeLU
	j+BdMJ1wDRDTvRCOgFmn4uRz8lU/GomY5cfxc0YcZpzJYsVSaZPX2e2ByeA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hn2wd8avy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 30 Oct 2026 15:08:41 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1b::2d) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Fri, 30 Oct
 2026 22:08:40 +0000
Date: Fri, 30 Oct 2026 15:08:39 -0700
From: Bobby Eshleman <bobbyeshleman@meta.com>
To: <phind.uet@gmail.com>
CC: Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>,
        George Zhang <georgezhang@vmware.com>, Andy King
	<acking@vmware.com>,
        Dmitry Torokhov <dtor@vmware.com>, <virtualization@lists.linux.dev>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vsock: reject negative tv_usec in
 SO_VM_SOCKETS_CONNECT_TIMEOUT
Message-ID: <auUVZ67KRrDLUF45@devvm29614.prn0.facebook.com>
References: <20261030064428.73930-1-phind.uet@gmail.com>
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
In-Reply-To: <20261030064428.73930-1-phind.uet@gmail.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4OCBTYWx0ZWRfXw0MuiDwjz0Em
 krBRGsa3nTSm1kW+UAGL7bTZzIjswi/bXtO5JB39aPVjzr5rM4QwzRpx0hmYL049gOTcV0cqo24
 h3h6NmKV9ne8+vuNRyfQD3xd0Wib8C8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4OCBTYWx0ZWRfX5XlPcq/AhTfp
 LqgTIbPtHMrXuVbks5Txu4lsosGvte0EYTz2EzznVsQOMfHo2pfOdLvIzl1QeoMWIdYw8jImaPr
 gDozDyp1qASdlWbG9ZHbsWpPPRGmTWu2Q2Y+wUam4vzViyu8rLk/S1KYtL8WrmkCoLUlw/QNDVK
 CSc+uZ92OV23h9vnHn43c2u7iBHav1GqGQeliFLu2d474ODLdC7NR/Y5J2s4EmewsabCptiq+Py
 jIxElougHKc6uaknh4DC4mNEvOLXlCA1qph3/q1d9xroz0omgEfsSDGkFo7JzmIyUEHZ0h4uOp6
 52fqCbfqB7WUUYnmYBSlGzXMX9acRf0+lLdsQPNRuh1ZJ8lq7QDSSomA04la4qiLhzP+DkguTbb
 sT1AJl6LG/gUfljfDNgD/JqbReCc+POdryNB2bKXKQg0qMzqx+jDpzRdR5oplPtBO0UTdg7ZH84
 sEZXmmDXGOvHWp77fmw==
X-Authority-Analysis: v=2.4 cv=V9joQuni c=1 sm=1 tr=0 ts=6ae51569 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=8elwO82fXORLTBIkMd32:22 a=pGLkceISAAAA:8
 a=zogz89TECfafHexjI6IA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: ZkVbhWJaWa3dwnSBsflV5sQnJr0JF7Sk
X-Proofpoint-GUID: ZkVbhWJaWa3dwnSBsflV5sQnJr0JF7Sk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_07,2026-10-21_02,2025-10-01_01

On Fri, Oct 30, 2026 at 02:43:50PM +0800, phind.uet@gmail.com wrote:
> From: Nguyen Dinh Phi <phind.uet@gmail.com>
> 
> The timeval validation checks tv_usec < USEC_PER_SEC but not
> tv_usec >= 0, so a negative tv_usec makes the timeout computation
> wrap into a bogus value, later tripping "schedule_timeout: wrong
> timeout value" instead of being rejected.

BTW, this does need the 'net' prefix.

> 
> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
> 
> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> ---
>  net/vmw_vsock/af_vsock.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index d0508887a2fb..1d7d53542724 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -2156,7 +2156,8 @@ static int vsock_connectible_setsockopt(struct socket *sock,
>  					     optname == SO_VM_SOCKETS_CONNECT_TIMEOUT_OLD);
>  		if (err)
>  			break;
> -		if (tv.tv_sec >= 0 && tv.tv_usec < USEC_PER_SEC &&
> +		if (tv.tv_sec >= 0 && tv.tv_usec >= 0 &&
> +		    tv.tv_usec < USEC_PER_SEC &&
>  		    tv.tv_sec < (MAX_SCHEDULE_TIMEOUT / HZ - 1)) {
>  			vsk->connect_timeout = tv.tv_sec * HZ +
>  				DIV_ROUND_UP((unsigned long)tv.tv_usec, (USEC_PER_SEC / HZ));
> -- 
> 2.43.0
> 
