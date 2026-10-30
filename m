Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793398084;
	b=pVPUX8lRE5yzVDh+7GSUlW6tYsJpAx4JE00kUu0bOecU77rzPuftAd5Apvf+s4SrgDD5
	 WyHniXdH+O5NZcObmqpnfkM34mzyJgDMxABpPe7ezHQNirHd2HxoQsCBUa/6ZS/Srbt5+
	 aaT/St9hIpwJsKdus1qbVreDMeTlwCk8IkrCOGn7rIXfzM7Nto2SMdfphXMj+u/V8Dti2
	 BPzVKVCBdmJ4yaxulohQIU2FFrav6S22fKGRxW56Mz7wxw4iFuLYNqyzSmL3137fY7fJ1
	 tM60jd94fynqPxVhatxGdGUht5JZ6ENSlB0QCQbrY3QI2jGHfYtZ0kce1rir9OEnGCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793398084;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 CC:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Originating-IP:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version;
	bh=E1Nwp6YDz6qZM2OTPwc4W8dECJoXWXtojx10dqTdLUY=;
	b=X4zehy+zkSLaPp2PHiF7DK1EcghAZI0jOuj+MC7xnN8yOL8XCBhdx9xZxZXplQ5lL6Au
	 I4v9hb8W+3ChIRvcgjBMGl7sIzemX6oAhrVEYzL+Wyp6NSZI33HlMo/VQSAMSQte56Iv4
	 3ZvU/wnpyT+JcuFKxIOdVJamkH5lyy4gSqq+ugoG8CG3r6wMBTa06uvJBwOuOEPscFnn3
	 VbHIOUYC0Nr772eictYhQGOltrieNiSkXNdqAJP+p1QbJEreJKI1g/pPkudQ8IemHSYEc
	 814JYD/lmNtz/iMuzZ6EV7jMzcZG4Na7YCfuoUG1IMFOTje2nknEUlblB4oMesIFhbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=MMURQSq8;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAD0606A31D
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 22:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDAD0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=MMURQSq8
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69ULuFMB518247;
	Fri, 30 Oct 2026 15:08:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=E1Nwp6YDz6q
	ZM2OTPwc4W8dECJoXWXtojx10dqTdLUY=; b=MMURQSq8xaDALKzGaFXVIpZ01Me
	jXTOLs9+pzKmiH5IIlGWAJxRWt9gsO5AkNwfB1loKOYrQuwxvAnXQQF5XmoDz+94
	Mh34hP4f1ZkIhUcnHtX37fpCJJNUA4jtHpkkqJXix9SnkKY2dTZISDcJZGYoE6O3
	yGnUA/rUqMd17oggwh6FL01lgVDeJTDoHoH5R/V9BzeMKND8jLg+bYqkJYASKXJw
	1RDNJwGJ81KqJ3RnWMH2NgYq9ftaSaKVxyUJS8dnDXPUDMVrMLq08EIp7WJIu2Y6
	k76d6yCyZtrkBncUrmr+f7FpUIRVKID9TBIhBwgoWxi1UQk1c3nKrsDbqtg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hn2wbrb5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 30 Oct 2026 15:08:00 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:fe::f072) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Fri, 30 Oct
 2026 22:07:58 +0000
Date: Fri, 30 Oct 2026 15:07:52 -0700
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
Message-ID: <auUVOP8G8f1PNYaG@devvm29614.prn0.facebook.com>
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
X-Proofpoint-ORIG-GUID: 3XkDo1hC7pks_BabNDy6fDi1PuWXflUD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4OCBTYWx0ZWRfX5CXmhdJQQsFq
 kKgTnlOP7TDm+flCpVQSG5gwkopLjbcKchXNA7fn0mDv3VuFlGR55RhvhMo8IgAT9ZZkvO2Gkwu
 oHbMzTVJdtSXQoa3Hmv2AHMThNL4DBs=
X-Proofpoint-GUID: 3XkDo1hC7pks_BabNDy6fDi1PuWXflUD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4OCBTYWx0ZWRfX4hoh0OtRbBJR
 b98ZpvIEufRL1kfC8r8Pkv4epfrOquEtisQUXFkplaAcAcsvRNy51zG3kwc8lWBGHI6CnxEfwa4
 Vijggm8IZzCmVyIBEqaX45C0btycXMRO+S23PEdt6YnGoD6Ly404N9pf/6SoJMWiDkMEdGjJbOM
 fQwiszL7IYvk1ThcpVHErKKKQ3YCK3FV9BI1W2GJ1IIH4XbdGaCbSbjM/TYaL46b+1/RmKv1qZh
 3FZ4zi4cFbUT2FLVKfSXNZ4XcL8Nvkh49FnjU6QdaY6yjAhGX+lzTGuOrzUoedBv/LoKb2iMY85
 Yzj4Am25Fyj+wJEr8TMAk4uCobe9vRhy3CwP8xyLNCONH5cwg+dQ9QFwoiJpCXXDS49brD53P+U
 9/0dU+w9odI1+z0h118iHbi7knxoRL1rVKQ3iDSF6RUkzAWbtBm91wXO6yp6qdjCz4elqfNyUgg
 b1d8hECgc0JtxjD3l0w==
X-Authority-Analysis: v=2.4 cv=PdNqFShd c=1 sm=1 tr=0 ts=6ae51540 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22 a=pGLkceISAAAA:8
 a=VabnemYjAAAA:8 a=KYg8dRGmnzwnUi-rXPcA:9 a=CjuIK1q_8ugA:10
 a=gKebqoRLp9LExxC7YDUY:22
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

LGTM. Maybe we could think about adding some easy opt range tests into
vsock_test in the future.

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
