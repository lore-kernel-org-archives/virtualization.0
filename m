Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBA336C5A9
	for <virtualization@lists.linux.dev>; Fri,  1 May 2026 21:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777670470; cv=none; b=mhS1qLoGhYiGrFgu9wb/K0LDV6fmRBIrwIqpcYEm+9k9whL9DcOAW66Lhvdf53nFfjCu5ltqoe6s815T+nNMEiP+MWR9oggeXrL7cByx7sPzPBUoqUxaDt1JgxlofocdmVUewfueot0EZvkT28IncUbQdysD6Jm0NI6EBuz9/Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777670470; c=relaxed/simple;
	bh=gbYFLTANvKgL0YLaobKU6Pf+SimnzpTiv2B12KmDMck=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0tBfyUwVyhZyKeeu3OfS1ueQXN2Nhddh1uH0OZylJ6qmv+Q+evuZF3tsORo0uOdYead0VwRZ2ob14rPKTnFXJEhR1GHc4fZwarMjoFr4Il70ZALypIwY3XsrmDcOSxtUPRHdFr+tgUezEWXMCv86OFTAcKwgzFTSA1PGXYwvwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKjg3PqG; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKjg3PqG"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43cfd832155so1398958f8f.1
        for <virtualization@lists.linux.dev>; Fri, 01 May 2026 14:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777670467; x=1778275267; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3Cu+Df2v8gmiZwpX0nD5Z+6tJtgNGySMwqyhPLW2dM=;
        b=nKjg3PqGV0UW/XrOIHIGwElfWN+R/nkaWYQpIbr5zwyvcmCnYMD3U92/nzt4oyEiX9
         w5l17CJcr2aApHM5m+jNRFm3Zh3s9KXhRYCUL2vdPIywFQLiibt/CRmgfk1Sr9mjbgMV
         I3sCnMaU1h7LBD5cYHFZXzFRWaFFx3K96NTfi9UyyZYuALYm4RTfl8bIwzcpXl0bsn9k
         aS5TRN7atsvfUlainyRQhd//Q00LUDTeYnCS1GyAh3dJ2UMXSmFRaMCnjdD6tRhGCktD
         w2GeL4OoeMDwuN1H+/4r4yOiPW0WpK7OCp2sqb0qNCtZaTjf2QdFsnZZ9dD4zSNvwL/D
         etbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777670467; x=1778275267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E3Cu+Df2v8gmiZwpX0nD5Z+6tJtgNGySMwqyhPLW2dM=;
        b=lmFbV8uUYMGpZ17Pdj5gu/v0kmj/WSbfCQjt17AaPMyOptbPoqmtQciB+scKT67JZE
         jD2eH76jc8Ct3ADpg4ck7dJLPrmhd89mtouW5ij80RUo3+iVmrv1pmfp2zzb1pe1SN5+
         pe4R6uoRl4QuRwowR08+RC3ZHr0BFoMCKzgUmfgmzHMCd3y5UHyQ/Cc9KpZbW6213O18
         bntePSKuGxLaHXnSIeZM4butW9Wqi0UBdWfZbxrrjknKEy4lVzXgJs0B0JFcZ2qUu/1x
         t2Pb+EPcUt0LmOfuPrUQTzfWWk/0UZQAyxY1RIWZoK6L1/naHfRs4HTZl18ySRc1e/Vn
         3jjw==
X-Forwarded-Encrypted: i=1; AFNElJ9U9iTnb7VU9Gs67LdbaCESjEDKjHg3YCaTEacmZzWCsMEek0nMy3EgM4pAAk0BSqvDaWMrKDYcl9n+O29hfw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7kXSS0G3ACqRceM9hJKE3VNIuUZZI0WxZNyK/rywInmGvhPdB
	sM4d/z/fjaaXZJDITUs/nTfZJYly3hdNmyPCze6z4HMt0S2nBpcrGuIn
X-Gm-Gg: AeBDietteMiQdw4aAI2qQ/81rEHvFJrJ1yz/dWiYHfosnXNFDLcetOaz6ajvZKvMULU
	p3YvWdTf6ieON6g659a3cHd33H4NnBEDJiaDqozmXA+nALPX1lToPWQhmb2cLZBHPJYD0OGJI8E
	SxmgUUMIQsCstay0HUMKWyBifWv1OyTHktjevNyiH4IZ5E96jSpEaTwEDoQ/DocaNXJP7zT+/YT
	EJfEfnE0RHRlYew2hlCvnnRGlEpuQ7puAL9UgDhB+k39OvZRA1dpPj2CtS4hWeUayI90idHYgOd
	78brgqoFM78pfkh2fbLkLsmq+42qV+z86AsjJFmxYCRScEyuOJQ6f+U6zcx+AZwbAPwiEN2g6A4
	Al+L9feY4Koq8EJO3caBY6O1cqLm3qsTddjgvdN8WIhmZAtZHTq+ckkMOI52MPOZ4HvSEQ64De5
	tsT22dts092Ot+/hON+EFgX8sdLgNek93hzt+21cuwW2cypJm2L15ZgHyxJ7OK23OEPNAGXJbWe
	Ks=
X-Received: by 2002:a05:6000:288b:b0:43d:7a97:78b5 with SMTP id ffacd0b85a97d-44bb5e2deb9mr1495268f8f.33.1777670466885;
        Fri, 01 May 2026 14:21:06 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a8f51bac8sm7514313f8f.16.2026.05.01.14.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 14:21:06 -0700 (PDT)
Date: Fri, 1 May 2026 22:21:05 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan
 <shuah@kernel.org>, sdf.kernel@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next 2/3] vsock: convert to getsockopt_iter
Message-ID: <20260501222105.747dea59@pumpkin>
In-Reply-To: <afTjvM1P4gjPSvW8@devvm29614.prn0.facebook.com>
References: <20260501-getsock_one-v1-0-810ce23ea70e@debian.org>
	<20260501-getsock_one-v1-2-810ce23ea70e@debian.org>
	<afTjvM1P4gjPSvW8@devvm29614.prn0.facebook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 May 2026 10:32:44 -0700
Bobby Eshleman <bobbyeshleman@gmail.com> wrote:

> On Fri, May 01, 2026 at 08:52:52AM -0700, Breno Leitao wrote:
> > Convert AF_VSOCK's getsockopt implementation to use the new
> > getsockopt_iter callback with sockopt_t. The single
> > vsock_connectible_getsockopt() callback is shared by both
> > vsock_stream_ops and vsock_seqpacket_ops, so both proto_ops are
> > updated to use .getsockopt_iter.
> > 
> > Key changes:
> > - Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
> > - Use opt->optlen for buffer length (input) and returned size (output)
> > - Use copy_to_iter() instead of put_user()/copy_to_user()
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  net/vmw_vsock/af_vsock.c | 16 +++++++---------
> >  1 file changed, 7 insertions(+), 9 deletions(-)
> > 
> > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> > index 44037b066a5ff..d4a97eeb596e6 100644
> > --- a/net/vmw_vsock/af_vsock.c
> > +++ b/net/vmw_vsock/af_vsock.c
> > @@ -155,6 +155,7 @@
> >  #include <linux/random.h>
> >  #include <linux/skbuff.h>
> >  #include <linux/smp.h>
> > +#include <linux/uio.h>
> >  #include <linux/socket.h>
> >  #include <linux/stddef.h>
> >  #include <linux/sysctl.h>
> > @@ -2091,8 +2092,7 @@ static int vsock_connectible_setsockopt(struct socket *sock,
> >  
> >  static int vsock_connectible_getsockopt(struct socket *sock,
> >  					int level, int optname,
> > -					char __user *optval,
> > -					int __user *optlen)
> > +					sockopt_t *opt)
> >  {
> >  	struct sock *sk = sock->sk;
> >  	struct vsock_sock *vsk = vsock_sk(sk);
> > @@ -2110,8 +2110,7 @@ static int vsock_connectible_getsockopt(struct socket *sock,
> >  	if (level != AF_VSOCK)
> >  		return -ENOPROTOOPT;
> >  
> > -	if (get_user(len, optlen))
> > -		return -EFAULT;
> > +	len = opt->optlen;
> >  
> >  	memset(&v, 0, sizeof(v));
> >  
> > @@ -2142,11 +2141,10 @@ static int vsock_connectible_getsockopt(struct socket *sock,
> >  		return -EINVAL;
> >  	if (len > lv)
> >  		len = lv;
> > -	if (copy_to_user(optval, &v, len))
> > +	if (copy_to_iter(&v, len, &opt->iter_out) != len)

I'd wrap that as copy_to_sockopt(&v, len, opt).
or to make the edits easier: copy_to_sockopt(opt, &v, len).
Then if someone decides to change the implementation none of the call
sites need changing.

-- David

> >  		return -EFAULT;
> >  
> > -	if (put_user(len, optlen))
> > -		return -EFAULT;
> > +	opt->optlen = len;
> >  
> >  	return 0;
> >  }
> > @@ -2631,7 +2629,7 @@ static const struct proto_ops vsock_stream_ops = {
> >  	.listen = vsock_listen,
> >  	.shutdown = vsock_shutdown,
> >  	.setsockopt = vsock_connectible_setsockopt,
> > -	.getsockopt = vsock_connectible_getsockopt,
> > +	.getsockopt_iter = vsock_connectible_getsockopt,
> >  	.sendmsg = vsock_connectible_sendmsg,
> >  	.recvmsg = vsock_connectible_recvmsg,
> >  	.mmap = sock_no_mmap,
> > @@ -2653,7 +2651,7 @@ static const struct proto_ops vsock_seqpacket_ops = {
> >  	.listen = vsock_listen,
> >  	.shutdown = vsock_shutdown,
> >  	.setsockopt = vsock_connectible_setsockopt,
> > -	.getsockopt = vsock_connectible_getsockopt,
> > +	.getsockopt_iter = vsock_connectible_getsockopt,
> >  	.sendmsg = vsock_connectible_sendmsg,
> >  	.recvmsg = vsock_connectible_recvmsg,
> >  	.mmap = sock_no_mmap,
> > 
> > -- 
> > 2.52.0
> >   
> 
> Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
> 

