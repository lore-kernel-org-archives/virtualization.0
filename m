Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB37C3921F0
	for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 01:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786671920; cv=none; b=lMYZFIK92+vW0Z4BVgwSrhv/GtqtfE8+nK2I8TFhKZqa8GsdgDvtlagMeOj4KM/p9nYBfdzay+n/eqWaE2pg9Nwf4rXkiVBIu4cIxITFvNEIpjH+8trZdGa1wSTuu5C9c3zCEZhH4LH6+6uI0DXMnZYlUYGH1lJW91UeqnJNmjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786671920; c=relaxed/simple;
	bh=heykRPKxHEV0qeGdFAlsBWMKyo8f6xdx4ceOTJOlyac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbS7UKt8HNFr1ajKQpYHALzEG+NkijTWwqHQV3oC2riVHtvwxqfvK/Y9fX3tauAub+dE+3EeJqaphPBpVrQidMnFOdsME0/Zz8lYCs+ZCTElUerP7E1wxaO7xQmlPcCMEoCcNIlOcwxnvX5akEWMIbt5D9MVYQMKl+L+/JpIpIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpxqSnqi; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpxqSnqi"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84867f07d63so393588b3a.2
        for <virtualization@lists.linux.dev>; Thu, 13 Aug 2026 18:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786671918; x=1787276718; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mi5MeuhJzZM9OklNSe8gi6ctTiynO5KFec8hcGTI+Lc=;
        b=RpxqSnqiEXf3JjEhuokfQo7A8Nv0I7yclaK6++00Ti3htWB9bRUqEvlPFag9+xbOTp
         3MQibEzRllTdS9h3m97LYmVqwHhU6eIza2/SwIvz6Qh6s0sdRL07rWO9v3hyJ+4EP1l9
         7zTq/JVay+bse9eVxkJBzUc4/GB7HsYmfhQ4KS9SrzoIObWcDGgXo3uJdb0kkWj9TE1G
         2T5y1HbprdYlj2emI53MAX7/tqpnkkQ5eYr+nukCrM1OmmluSQRgJ42DdiirjFDHRxVw
         Nej2b0Y7PY9D+c5iTLYl7xOOyPEVSzCFoYasmoTWz0qIu34vng3UmxS4vYU/sVHcN/2h
         7zgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786671918; x=1787276718;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mi5MeuhJzZM9OklNSe8gi6ctTiynO5KFec8hcGTI+Lc=;
        b=hvtzu652kAXvH6LyOPQtCTGaYcMxMwFB6K8pxePehxFCdRjOIgrgGdkhwXwtDr3Wng
         cW/sfnLly2C1zaoN7KIefAMoehBkeU5g9SsKc/Bs3H+E/9lPXk1SRxqsnfeVJtCqW+d1
         dX8lyRRSoBBaoTZgfAn6roOVuyeXIQEzYzRptSBam2XXCskUQsals+i6m0Uf2eXjwcAG
         XuJP9bm+dLNpoW+auDxRnzp7/CkphqhtjOQywWPjl9naKFk1fg6nbFJ93Ff2ODwhDIOI
         elbW6kM3rcQ/VwQAInoZNpCQVNZn/A3SNE1cbpLhmoXRFoqZrmkqn2qZCfHi9KZL1MpF
         tKNg==
X-Forwarded-Encrypted: i=1; AHgh+RqCuV0LKwvMZjB2+dARYovIJnyriQhh9Uw9SF/5BCOPKxDcff2q6NApV7SRuEXC7IqSIi4okk8w2fCfCig3Aw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzLxil0TyACK3KaYN8ucfr8npfJuGybgWSzmrJWpfMhLCgFbH3O
	X0kkvhfALmMexqlIFkYOPpaE3TP1WOqLX3mZPlf0x+0GkIQLLJ4/Q8sy
X-Gm-Gg: AR+sD10c9M9GZLEJowMAnEPUfuH6vRFc/QTJDLliyvSTQUf5pS3E4Avb+6L3fP/Dz04
	brJhAwsqGPKGFDTadPwF1sVYO9oXWTsEZF5uA5kboSrkQxgnIsU6+uWjHfuigvrq7idGReL/r+c
	ZkHUogcXjzmMv9W7XGsOA1cwUQ2eqfdBQsnDy34aL50JnDUZFzayCGP3sYH44JXfXeGSyms/vjb
	npVKnH+CBMrdjaZwFcXZ5Nr/rGMi/z15beD6veSsgUrz0VcMmoOcft4zu1jgvAGOoQ8PB8Wx0Lh
	cDAEg5MmRlw+UYUcpMxfQwk5WtW7YE7x66ttTtiGsZapUtjHdZzueFSoS684bTeP4fMCzsM7Sjq
	PvQJgyMPBbn+VbnLsLW356ooCfSQn036pt1ijY7whsr8yYYaSKnsYB86DCnFhDbUBHXsv1iwahT
	PNcDjLpC16XXenaWuIS0nDqWGigkvlECKMpjxW5RiEApeuzFFsX444yDLiaMMhxPyPjiYxXkomZ
	NVA7+Cd
X-Received: by 2002:a05:6a00:8d5:b0:847:926c:582c with SMTP id d2e1a72fcca58-84fde266faamr2008039b3a.29.1786671918198;
        Thu, 13 Aug 2026 18:45:18 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fc4563649sm1508027b3a.7.2026.08.13.18.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 18:45:16 -0700 (PDT)
Date: Fri, 14 Aug 2026 10:45:11 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	leonardi@redhat.com, bobbyeshleman@meta.com, stefanha@redhat.com,
	mst@redhat.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net] vsock: do not reset a socket in connect() once it
 has connected
Message-ID: <an5zJ9Uf94_L9TyB@v4bel>
References: <anzT1fREOSyHT99k@v4bel>
 <218226a4-38e6-4a16-a660-6c1bb92f9f96@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <218226a4-38e6-4a16-a660-6c1bb92f9f96@rbox.co>

On Thu, Aug 13, 2026 at 11:42:17AM +0200, Michal Luczaj wrote:
> On 8/12/26 22:13, Hyunwoo Kim wrote:
> > commit 002541ef650b ("vsock: Ignore signal/timeout on connect() if
> > already established") stopped connect() from resetting an established
> > socket. The check only looks at whether sk_state is TCP_ESTABLISHED at
> > that moment, and the state can change while connect() sleeps.
> 
> I guess this makes my fix incomplete. "Fixes: 002541ef650b"?

It is incomplete, yes. But this has been triggerable since d021c344051a, so
I'd keep Fixes: d021c344051a.

> 
> > A peer RST moves the socket to TCP_CLOSING, and it is not removed from
> > vsock_connected_table on that path. connect() then wakes up, fails the
> > check, and resets a socket that had actually connected to TCP_CLOSE and
> > SS_UNCONNECTED.
> 
> Thanks for the details. Do I get it right: connect() misses the fact that
> socket might have already transitioned TCP_ESTABLISHED -> TCP_CLOSING
> during schedule_timeout()?

Yes, that's it.

> 
> How about:
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 622dbd046799..39c42ef016c3 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -1807,15 +1807,18 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
>  		timeout = schedule_timeout(timeout);
>  		lock_sock(sk);
>  
> -		/* Connection established. Whatever happens to socket once we
> +		/* Connection (has been) established. Whatever happens to socket once we
>  		 * release it, that's not connect()'s concern. No need to go
>  		 * into signal and timeout handling. Call it a day.
>  		 *
>  		 * Note that allowing to "reset" an already established socket
>  		 * here is racy and insecure.
>  		 */
> -		if (sk->sk_state == TCP_ESTABLISHED)
> -			break;
> +		if (sk->sk_state == TCP_ESTABLISHED ||
> +		    sk->sk_state == TCP_CLOSING) {
> +			err = -sk->sk_err;
> +			goto out_wait;
> +		}
>  
>  		/* If connection was _not_ established and a signal/timeout came
>  		 * to be, we want the socket's state reset. User space may want
> 
> ?

Yes, I like it better than mine. I confirmed it fixes the issue.

If you don't mind, would you take the patch from here?


Best regards,
Hyunwoo Kim
