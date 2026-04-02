Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C13E36C5AC
	for <virtualization@lists.linux.dev>; Thu,  2 Apr 2026 17:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775150386; cv=none; b=ZRX5QniEWxXVi8YiyldtC4zeqTKlAmG5BlRywKMhafzH39zgUqfiW6jKVoRZaXS9xpEtWlU2CioDVw/wcKtjC5ilJV8o+pIRel5L+bnDrGJIKtgWFt1YdFoPyV1ubrn6JBAMuZSn54Y7KGKMvZyP+v6r+KokPKzZfc1A+rPc1hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775150386; c=relaxed/simple;
	bh=q+bH+MzBqzAaB1kR8c1eOTTKDhHAZs3b4rogy3u0En8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rI+IinXMTGQYss537edfiqNQEtCvCd6XsWuuD5WIldwcH8VLpRAKssvUyWfdqgkMq1yCNg6cZmSfC2touqG90aamVGfv3cQd5jT2/u4oYyuqb5MYn0rB5drl8PKMblV3MsHH4lTyPfdMostZ09oQCSsDVXhYVQLf4KFGpaKf9gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rqt6rJq7; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rqt6rJq7"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79be0de8610so11333047b3.2
        for <virtualization@lists.linux.dev>; Thu, 02 Apr 2026 10:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775150382; x=1775755182; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6UIU0kC8Y0nz3yhV5FHyC+ln+Iwi4Xg/ywzP08MRwPg=;
        b=Rqt6rJq78LgdQJYLBoaygxlC+ikGHq/vjuHSsW6uoGKf+C9LNWK/HPH/m79l50V5ls
         bILMn9FNkds4uPg0ijNooZaMfAD9YTPXOJMOl7GdQt+cC4tX2lJA2ghgvoU6jF1vFykD
         BKBE52F7ytaJLiHF5h5tcMNN8BhKBxajDpCHEVABx62HwMVNKJpAZ14XJJjl8J9+4DsZ
         yz/eYUOub6yBJqaX0xDj9x8v5G+h4lKFK/tLZem46eBlsXT2cpLwPynnRh9AKDbJJeiq
         Y/GgKGQDq+lvoqRNhfAsjKxiNjyX8gi5Nt763DT/2V4s2JhGDncQweMrePZG1WcU3L+w
         gltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775150382; x=1775755182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6UIU0kC8Y0nz3yhV5FHyC+ln+Iwi4Xg/ywzP08MRwPg=;
        b=fP7uRiFXzM6pS5g8la1U9yOpEUPEpFoUFlgUptRkU+GIUNOducNdygqtw7YYr7GN+o
         FkmMjMiUkA5bseGRJdKail7dvJOu9ofLD6tivQQ8yFnnIxhLaacM/tyvmDL+D7QtQgyV
         QOjgs3CPTbPC9k8m0GFwddpX/SrvI2h0CTGHVbxd/e3T8J0i4j00Hb9/EkT7MHjWCkP0
         r8Xnmq4G5n8kZb+zap/nbqRpALwpuSnWARcGHmKGMYvWLzdadyj51uSKCHyOSzPB1E7L
         qkQCNz+O8yTxgkZbR6FqwxNhG2IM929wB+ReDzUoWrMvalq2lbYmHJhcHWyPV9uPcDVg
         IwaA==
X-Forwarded-Encrypted: i=1; AJvYcCW+fSx32KhrOMnGmbkFS3ZH0Z+4RBugoPAEjS5JwAapoMQwOk5TDjQ6EyE5IUzSbElAyRCjYkqKqXxy0ZgwgQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwibmYr5ISp4uok9UYjIXwHECTAZCHaNNwnXzEvH4dvLOZK+B0x
	lIVnFK0wsynYHjNvDCwR11zM224W+6aZ3zDvXo/fAl6TDEpQ8MNClSKM
X-Gm-Gg: AeBDievpgUCBimH+4tWd+an1QY1OP5U8QAcLhc3FgxOoDY9GWaEhYG4HaB7JDtNh/Xb
	iQunWVGIi4+a3ks7YCGgDFNDWtLvQjI6QrX3/mi/9bOaNRnnJ95EOxY+MD9t3iElfCWyawIxaax
	4Q6zHODBVt3vX58EnQ9eQU6YxaIgEaJ4Zuc/kMxr0fK+u4pcbeZ2+tnJ6+XFw6JFunvoAjMLZ32
	uqzJFR5RWM7qVeULRoTTqS10Tg8xzP1P77vTOIKmI++eD//xFvXRrUpdtx7NFPZwMbjeC4Se6u2
	Bz9k0ZfKxq8RMtd9EkeE5ICbPAqibFfiQVp+AWpsUzYfhNgtqy238xJfHmZGe6htWXGk/MQ5Xru
	itEqvwMppBMVnBwJABy0U3CEPIH0rdS3WdN75VJC/KKIzFs8S8tpA/cVtHR9+wISY8c0zULuJRS
	Az0OR/R0ryafGn92W+nKbxCA==
X-Received: by 2002:a05:690c:6e87:b0:79a:da70:864 with SMTP id 00721157ae682-7a4d6152810mr1492807b3.49.1775150381775;
        Thu, 02 Apr 2026 10:19:41 -0700 (PDT)
Received: from syzkaller ([2a03:2880:25ff:4b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a3712f04aesm12714417b3.48.2026.04.02.10.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 10:19:41 -0700 (PDT)
Date: Thu, 2 Apr 2026 10:19:37 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Laurence Rowe <laurencerowe@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH] vsock: avoid timeout for non-blocking accept() with
 empty backlog
Message-ID: <ac6lKTabFc04Fl35@syzkaller>
References: <20260402044637.73531-1-laurencerowe@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402044637.73531-1-laurencerowe@gmail.com>

On Wed, Apr 01, 2026 at 09:46:37PM -0700, Laurence Rowe wrote:
> A common pattern in epoll network servers is to eagerly accept all
> pending connections from the non-blocking listening socket after
> epoll_wait indicates the socket is ready by calling accept in a loop
> until EAGAIN is returned indicating that the backlog is empty.
> 
> Scheduling a timeout for a non-blocking accept with an empty backlog
> meant AF_VSOCK sockets used by epoll network servers incurred hundreds
> of microseconds of additional latency per accept loop compared to
> AF_INET or AF_UNIX sockets.
> 
> Signed-off-by: Laurence Rowe <laurencerowe@gmail.com>
> ---
> 
> This fixes the observed issue for me:
> 
> 1. With loopback vsock on the host running Linux v6.19.10 built with
> config-6.17.0-19-generic from Ubuntu 24.04 and make olddefconfig.
> 
> 2. With Firecracker guests with current torvalds/master, v6.19.10, and
> amazonlinux/microvm-kernel-6.1.166-24.303.amzn2023 used in Firecracker
> CI and examples. (Firecracker guest vsocks are unix sockets on the host
> side so this fix works there with just a fixed guest kernel.)
> 
> I struggled to build a generic 6.1.166 kernel that worked as a
> Firecracker guest but the patch applies (conflict due to change of
> `flags` to `arg->flags` in surrounding context) so I believe it should
> work for generic v6.1.166 kernel.
> 
> Alternatively a minimal version of this fix is to just wrap the
> `schedule_timeout` in an `if (timeout != 0)` but that leaves an
> unnecessary additional `lock_sock` call.
> 
> There are ftrace's and reproduction tools at:
> https://github.com/lrowe/linux-vsock-accept-timeout-investigation
> ---
>  net/vmw_vsock/af_vsock.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 2f7d94d682..483889b6d8 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -1850,11 +1850,11 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
>  	 * created upon connection establishment.
>  	 */
>  	timeout = sock_rcvtimeo(listener, arg->flags & O_NONBLOCK);
> -	prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPTIBLE);
>  
>  	while ((connected = vsock_dequeue_accept(listener)) == NULL &&
> -	       listener->sk_err == 0) {
> +	       listener->sk_err == 0 && timeout != 0) {
>  		release_sock(listener);
> +		prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPTIBLE);
>  		timeout = schedule_timeout(timeout);
>  		finish_wait(sk_sleep(listener), &wait);
>  		lock_sock(listener);
> @@ -1862,17 +1862,15 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
>  		if (signal_pending(current)) {
>  			err = sock_intr_errno(timeout);
>  			goto out;
> -		} else if (timeout == 0) {
> -			err = -EAGAIN;
> -			goto out;
>  		}
> -
> -		prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPTIBLE);
>  	}
> -	finish_wait(sk_sleep(listener), &wait);
>  
> -	if (listener->sk_err)
> +	if (listener->sk_err) {
>  		err = -listener->sk_err;
> +	} else if (timeout == 0 && connected == NULL) {
> +		err = -EAGAIN;
> +		goto out;
> +	}

I wonder if this goto can be omitted since the following 'if
(connected)' guards the connected != NULL case? I don't have a strong
opinion, just noticed it would keep if-else symmetrical.

All-in-all, LGTM.

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
