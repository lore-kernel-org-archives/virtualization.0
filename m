Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292F73DF00F
	for <virtualization@lists.linux.dev>; Mon,  4 May 2026 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777906465; cv=none; b=dVxl/cXYq8271bebKBpdmtaINEfg0kwkPY9fheVOHduCmL1cKxGcCKe85YlLyWCa1v4dLi1mKWLavmZS/8fx2vq0pZsYf4k8Pq2tZnibL+OmO6f3DCVSlAuJ7f5t8iD237WYXsNQecY29T2z5vvK64GeRVbm/W99Qq77KgCY9yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777906465; c=relaxed/simple;
	bh=KHqYr0ItdAFMXMIPUhb8rlWKl8ynxj6igZ73aDx5RRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgGTBo/AjDIOC8/dS9BPonhHvhDKLES0SM2TQL/pU3/KgziLgJFyZbwFybA+KYkGeXdr4OEiryZJtYaBWhuL5+L4MM6TE9cUucptd8nB/bdlgan7A2IhuHjt37E3h/kdPwqdMr8hH87z81eXkcWBDCK+b0sdtq+DfBpPVZdkOmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bh1lyXPW; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bh1lyXPW"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-3652546e41aso1006215a91.1
        for <virtualization@lists.linux.dev>; Mon, 04 May 2026 07:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777906463; x=1778511263; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6kqUUkAQzlw4Bmuk+4uOMY5eXHd7Lb2epHcnpLdT4Iw=;
        b=bh1lyXPW522Ld+jA3jq6j4M++wYF9qCUdO9PRBZlOtddNlLtOXSgAFRF1QcyvaXh6i
         HApS9VNf3vt+6OifA0vRtYAHskIL2Np5Qx1TsEeotoXKCkLIYWRuq+X1+fLv4X5JMH/x
         nfpF0HzPMvXVzZM5emhW/4eHYMI7RwFpIN7o4X3blioQvLgd7IApcudb3VQ+OCuS33ID
         ZCC94Q1NMDgObCF1Jd8CUk2EYpRJ/MKB1dDVRJPAu5iq8ohZNI3HTcSGbM+RzJd23Pij
         qx8AR3Cv86TSHBBZ4x2Oo2hwf08h7IsOCRH53CcyAhymhPKu/kB4KQjTKR4axu0YblEt
         ivpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777906463; x=1778511263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6kqUUkAQzlw4Bmuk+4uOMY5eXHd7Lb2epHcnpLdT4Iw=;
        b=WreieqN9nGMMlIgIABecZXXnbRdp4siYM200ogIkNbCHGh1/OnPHEF/zYYNFr4auWK
         fgdn51dehgzyDOcTwV9Qy759kj9fCstRGgeuJlZgzNjLCCzv9w/OaVkko4Nxs/8PYdfi
         Uz3o6UEbb3aQ5bAOjaddcIOhyFFPmgU67NJ28ap/7XL5yTJZfIl+vM6aIMCf3dzrmVFZ
         YbzhFA1ZPw6jKGOOyqTGoCKwIZtP7aBEXItKmUUPvcKPSumX1dhAv7rmM6molty7M+xs
         rIDy6bs2+Bs3zsTpBZ5/Kun7mH/HpJCtv78UHmWN8rDh9lAkrfBo9JP16S7Gvfk31TJV
         skbw==
X-Forwarded-Encrypted: i=1; AFNElJ9HNoRnF7hJrhqo4tRYVlQ9QosBGAd6wySfYPDM6jl0fXbZWlI/eCkAl6a+JcHbl2TheunCWm74W8EYNeRl/g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyu5Ch8HKG3WMaKj1nVSAKoEXDecv6o5Deq7Ug15PLPdYm6ij6B
	qwuE9ZkGLU5y8326Vvv/z3RuPStPHrOSLn+xShc28Nyp1s1oFz6HgpE9
X-Gm-Gg: AeBDievDjIEzETm5OjSqeygvJ9fKLUqVXiWKQCb/hTMjbWGlWp4wqhiEbGkvo3fDMbv
	sDUdaezuVaaVazB5M6q+YOMUl2p7ZNMf7h/BSAMwEltxal425L/gjf+f2HBlUruSLXtRXQqgAqA
	wXx0tn7e74oqeMjiyuHu6JBAGwWeh0dKydEiheizxCtklIivmo7uHk4wOGopfmhB56heljUQ4Fy
	laKXxdvPmxNdZz4YZxZ9dNRmR2z71eem0hT0z52gjByymZRhXaHdzCJaS4C5pu0h82tNB+RLvqn
	Mb27tYf9w1I/pODIWthKaU5w7E5/x0axb07m7g8Tjmvy6mruqIPfsCRUkh9XNJhWvSjANLi2x/2
	GOhEL5/QoaAX9iR//KaCNzCIBKOUbEYzJV6v4QqozONfjKWqe9u+hR5K88tdt5fDOd1TWk/xa0a
	p2lKwFaJOrpHc7nxebV8LZ+XRfLw==
X-Received: by 2002:a17:90b:2888:b0:35e:5ae3:2993 with SMTP id 98e67ed59e1d1-3650cecebbdmr9653365a91.15.1777906463552;
        Mon, 04 May 2026 07:54:23 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:d::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364be028cd6sm14794209a91.14.2026.05.04.07.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 07:54:23 -0700 (PDT)
Date: Mon, 4 May 2026 07:54:22 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next 2/3] vsock: convert to getsockopt_iter
Message-ID: <afizGJmDPwi92IHx@devvm7509.cco0.facebook.com>
References: <20260501-getsock_one-v1-0-810ce23ea70e@debian.org>
 <20260501-getsock_one-v1-2-810ce23ea70e@debian.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260501-getsock_one-v1-2-810ce23ea70e@debian.org>

On 05/01, Breno Leitao wrote:
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

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
