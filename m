Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADC83033F8
	for <virtualization@lists.linux.dev>; Fri,  1 May 2026 17:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777656776; cv=none; b=lLxODdmKw5TjgPyc3zfxRotr6TOIbjAYVUXWKGbqpe5plz4TX9ThhKdrb/TnJBZdo64PqjRZDXZyRPlbJeVESYrG1X2auRYJra16Hfsz8Kw3Eii3cBdSyQ7VupJp07DKYPMHlibX1PJ83+eOOS88/Y6Spm5wm7FsFVZPRkCNH7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777656776; c=relaxed/simple;
	bh=NaBbNXwWIH1VnZaIKy4sMwMBtFjUTNWJd1g7S4np/Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9Qch9SAZwWiSXS/w0W+6oqVvG+dZyd1bI742jzfNN8pp0B+YLEvbvFoqW5HQin9wdjzBZp1j+n5XVL1ze8CJCfBZcaaZhzsLAb46VmgvQefZI1aIZxNJ3zAXIGsHYSo/jpc7kHLkJj/Orm3YbTSDGjEam9jryLvuxaYcw4hIS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kn49fWt+; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kn49fWt+"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79ea87af213so51171867b3.0
        for <virtualization@lists.linux.dev>; Fri, 01 May 2026 10:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777656774; x=1778261574; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AryNV0l+jgUF7izPhm+UoZG1NwQ31VUz12XuoxZ/bAc=;
        b=Kn49fWt+NQXgfL7iqFmQXnNk09/lJy/FbNgFDYhM54fkYMFfbJuVczDb22Bn8agwNZ
         gVa5X1ie4b6Rj03EUqu5vaZDOOWu/Sdu0sSt5K379SoBrnm75EfGX+4eKYgbYrnrMuQY
         7jP429GEG/FV0MhNDIxdHhbZnbgQgkdB0Dv5rUn+okzhHwJqe5eoNEKfWAFhtUme5KT6
         svUwYAM6z5ZKQjDv/rjqqg96wRTDrdYcnu9pgZtR4E8R1+jo/1IWwHW8aEU/cn2aUhvM
         RBxYXP/oc7PfQCywQbwMdH3kyZTOi9QaISAQdnGAZO3QBWcy06kTQORWqWc6ADGLaYoY
         0/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777656774; x=1778261574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AryNV0l+jgUF7izPhm+UoZG1NwQ31VUz12XuoxZ/bAc=;
        b=oCFHDNci25MtKdr25XDymlmeiD3Y5ddctwUMoJCLo8oiVYepKPjOB5dIjuFasmiXcH
         wXV5ONt83NY9Fl/9Z+l6/ZzryXRV4yDf0s2eskG4r5anf3z7GyJDnD+2wAk/RKIft1AW
         JrtGxbFcnqC4K0uDDGFGVmTd8FWptrZRCsoSU7pWeygFvQJiyx2eDgEFK8yG3qqIaD7L
         MdIcbQ4CBfXX6lGTfdfXPG19o5tvR0aHFw7ZQ+5jiGUsx3RtSjQEbooVsDo+Vz2pt+Vg
         mso3vowtPVG/JOY8fY6d9BRLPu6VV8TwFoQJpg1QlL6NsDqwasbXRew3zVlCtyo3uDID
         0rAA==
X-Forwarded-Encrypted: i=1; AFNElJ9Z7Sgqhlq/lE5grAicc24HU2XGemuL8jVn2W6Tp/cyFwIEE5hoEyaF2mz3sv6VQmTk7saj+ORsfpSnGp2Tkw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6IgEzCM2deErYE87OVbRPHqMGKsmBUi12pJw9/B1uoYuKCUZh
	193gErFFRAYmhpYlLaFsHwgc22xVQAeSgSnqs8mMesCuQ1pd3GWh5vUy
X-Gm-Gg: AeBDiesLJ3Tttj5GyI02yn4K09nIjq9lec07PUYGJrQX5zMbePXIlA4mvJMp04lxm/M
	XAN+ml/tGBVHzDtIjWhXwgeiAlZe22LtyoEmmG97jjCJP396++SZpKRVcI2VfaikOH8U1ZmGh6S
	p3X+BQgaKDFL/PS7Iz83zLvLLVIw/5j8JO7oYVt4L3pa7SveZSAvRHTFZMTYnjUII5OvOkpKFa1
	uIq/+793h5Vub0sbkptlVeYWAhpihVRQozMPR7n6bGrJJSSZsKDtqMuGXxTP/8NRw0CUEP1vQfj
	L/vnG8FHixMWhCCPq/L9gIPfMoU2AR2OvpPVlx0yN4Mvogor7LqXTv+qX+XLCuAX31ugtZew1Kp
	7UcpLeiRgNhNDPAm5+L7C6EKgC9DCRCP/Kvyw5BpvP/cqp5uFRa6h8uW215mCrxBfMA6JlEz7Yt
	CHqr/8+/lFDT/FoE06crIlnGemaVPspvMgxmanQUVtvJQBzdpEqWz6T94=
X-Received: by 2002:a05:690c:1d:b0:7b4:6f40:654 with SMTP id 00721157ae682-7bd768772a4mr4403587b3.4.1777656774212;
        Fri, 01 May 2026 10:32:54 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd665694b8sm13710007b3.21.2026.05.01.10.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 10:32:53 -0700 (PDT)
Date: Fri, 1 May 2026 10:32:44 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Shuah Khan <shuah@kernel.org>, sdf.kernel@gmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net-next 2/3] vsock: convert to getsockopt_iter
Message-ID: <afTjvM1P4gjPSvW8@devvm29614.prn0.facebook.com>
References: <20260501-getsock_one-v1-0-810ce23ea70e@debian.org>
 <20260501-getsock_one-v1-2-810ce23ea70e@debian.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501-getsock_one-v1-2-810ce23ea70e@debian.org>

On Fri, May 01, 2026 at 08:52:52AM -0700, Breno Leitao wrote:
> Convert AF_VSOCK's getsockopt implementation to use the new
> getsockopt_iter callback with sockopt_t. The single
> vsock_connectible_getsockopt() callback is shared by both
> vsock_stream_ops and vsock_seqpacket_ops, so both proto_ops are
> updated to use .getsockopt_iter.
> 
> Key changes:
> - Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
> - Use opt->optlen for buffer length (input) and returned size (output)
> - Use copy_to_iter() instead of put_user()/copy_to_user()
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/vmw_vsock/af_vsock.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 44037b066a5ff..d4a97eeb596e6 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -155,6 +155,7 @@
>  #include <linux/random.h>
>  #include <linux/skbuff.h>
>  #include <linux/smp.h>
> +#include <linux/uio.h>
>  #include <linux/socket.h>
>  #include <linux/stddef.h>
>  #include <linux/sysctl.h>
> @@ -2091,8 +2092,7 @@ static int vsock_connectible_setsockopt(struct socket *sock,
>  
>  static int vsock_connectible_getsockopt(struct socket *sock,
>  					int level, int optname,
> -					char __user *optval,
> -					int __user *optlen)
> +					sockopt_t *opt)
>  {
>  	struct sock *sk = sock->sk;
>  	struct vsock_sock *vsk = vsock_sk(sk);
> @@ -2110,8 +2110,7 @@ static int vsock_connectible_getsockopt(struct socket *sock,
>  	if (level != AF_VSOCK)
>  		return -ENOPROTOOPT;
>  
> -	if (get_user(len, optlen))
> -		return -EFAULT;
> +	len = opt->optlen;
>  
>  	memset(&v, 0, sizeof(v));
>  
> @@ -2142,11 +2141,10 @@ static int vsock_connectible_getsockopt(struct socket *sock,
>  		return -EINVAL;
>  	if (len > lv)
>  		len = lv;
> -	if (copy_to_user(optval, &v, len))
> +	if (copy_to_iter(&v, len, &opt->iter_out) != len)
>  		return -EFAULT;
>  
> -	if (put_user(len, optlen))
> -		return -EFAULT;
> +	opt->optlen = len;
>  
>  	return 0;
>  }
> @@ -2631,7 +2629,7 @@ static const struct proto_ops vsock_stream_ops = {
>  	.listen = vsock_listen,
>  	.shutdown = vsock_shutdown,
>  	.setsockopt = vsock_connectible_setsockopt,
> -	.getsockopt = vsock_connectible_getsockopt,
> +	.getsockopt_iter = vsock_connectible_getsockopt,
>  	.sendmsg = vsock_connectible_sendmsg,
>  	.recvmsg = vsock_connectible_recvmsg,
>  	.mmap = sock_no_mmap,
> @@ -2653,7 +2651,7 @@ static const struct proto_ops vsock_seqpacket_ops = {
>  	.listen = vsock_listen,
>  	.shutdown = vsock_shutdown,
>  	.setsockopt = vsock_connectible_setsockopt,
> -	.getsockopt = vsock_connectible_getsockopt,
> +	.getsockopt_iter = vsock_connectible_getsockopt,
>  	.sendmsg = vsock_connectible_sendmsg,
>  	.recvmsg = vsock_connectible_recvmsg,
>  	.mmap = sock_no_mmap,
> 
> -- 
> 2.52.0
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
