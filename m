Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07AA2144C8
	for <virtualization@lists.linux.dev>; Wed, 19 Mar 2025 22:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742422690; cv=none; b=QnZNI0+ZI8FTdf0ay9jDrSfab2zSZF5acujpEI21DOoyARK2u1XguO1ABRR0PcHLPaI4UQbtZrgusV8DwTg/C4vOkUiFa3QPXpBIXqw4t42GDjbq7/H+fq9nEcg+sWmrLFMRoi/5ezUcl7YHRZEdqoHlZ93BJsjS3Ym/OPAgrX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742422690; c=relaxed/simple;
	bh=YUognYdZVDVKoNWdTzYPY6W8ESehC/hs2B/Ek/cAyZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpvpQe1Xt2aDOWJy3tbCLn/wDEoreMBM7+dEz/2QSo05UKilO4cEFdV5TZoiokQYAsx1/J9Gkaxaj6LrfHImw068i4y7F/7zhi6VVTQJ7cnfJ53B7vLfGgwNxnIBzALylsXnxsiB9idczgW+FIGHHHCDP1ei/jIFA6w9VWIFyXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mD/REI8X; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mD/REI8X"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-225d66a4839so20584255ad.1
        for <virtualization@lists.linux.dev>; Wed, 19 Mar 2025 15:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742422688; x=1743027488; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u4D7n+2LppWRVXPYghpVBpyiFPmMtKDL9HM2hyc7IaU=;
        b=mD/REI8Xb/YUV3f5NC0/9QWpqOXpMc8rG8nC9xQgU2/buHW2xcmVnhoE8x0h/AJd+s
         wouEv6wWYJqUyFe4hzP2vitqtm7x05fakmSa7gEZM5Izqxap2TtADHJm1EgbLxSz1i6k
         FqPIJ0SmDXbr6EXsr7GeZpEZE0iygQqsIUawc/WrC37hF3MvT5JU3Xbv9/gD5trH/i4Q
         BzdNOIexzCHs1OcijhV6GLiCHVvKNfoyORmHWj+rmJY1WEqu9GErlhxXPbONiL0lKKLi
         wU3lCWkcfbsmFLIM0owrFEtj/zSZky+7dyx7Cpzug82p7V9rSunl6jQHRA49JFLGiAFj
         I8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742422688; x=1743027488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4D7n+2LppWRVXPYghpVBpyiFPmMtKDL9HM2hyc7IaU=;
        b=bvWtiWeOD8lXSg78iZG5QdRJa1kEXh4Ekivdnd5tX2TNWUpPwHQISzzl8n0mEWmZ5S
         sG7ZQYZUncKBLf3bWe24DFoL/QM8RXg56QQsppRUjFKw3yYSnk8EMsU6gNFd050wOY6k
         cgS+Ld8+PSH13zKNHchJha/DhIVsmQvTsIsFTLvXCcKHOWqZLCtEpWAnVSVSL4nD+m2J
         czhn/Y/JS8OvDvaXwLdgAwAoWkUcQ333ND7OmJEJI0gbBbVUOo6HREBrHtVWKVE78G/N
         cvDj8rG9euJoTLHeSWMChp+i8t3FAb9vtGDUPief6gxez1Hs3/QXcUbxXK/nLI7Hhv0s
         zk5g==
X-Forwarded-Encrypted: i=1; AJvYcCU1KN+xbPpwg1evtEbXcAl6ujfclKaE+llQ9fNFs8eQCO/cGdqByjFFb/OQriubYiFTRGi0P+QPWuU2FPrxKA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2KyAQ37TbkWwDFwMXh17KpGrl3LB1Ry2MGhc1krwfNVv1huDV
	03FLZrhU7S9WncEqeWneDmA2i0izZHEVzZbt30ro4UkD6RyHWq0clUp30C52
X-Gm-Gg: ASbGncuc/tjy9eeI+t0Ko2UlwEjF4+2rop0TmTRWluSxqATD8Kg5qTzgo87elu5H51Y
	cjREPK3g3Ufkw0yc7LobsXzb0vcZQ+Z5DDgMuHrtseZiPwXqtfVhJ03k8duO5RiZBQPur+tQliY
	RsuYkjTiygF9Nt9QxNeY5O1jZ2m0552SikJUvQ+ys4A9y3ygLK1UaSuhXN4vx64mi36MmfXbEe/
	OJasltp1ckcciiwD3h1ZA5I4MYnYCijE79dHc7Xbvc0eg56du+1WS+6CJebCiynIPOh/jn6l4xb
	ajG1SfQ/LAdNRkaBjSZktm4pc3Egj7ENvmXthOKgCMVQc8Kt
X-Google-Smtp-Source: AGHT+IGK0f2KkWnICFOc8q1r+oYDRZ2i3pe9qWJQ1JQu0L9prPZ3InQnyeIpr/0kzsZTnUAQx2nzGg==
X-Received: by 2002:a05:6a00:1249:b0:736:5969:2b6f with SMTP id d2e1a72fcca58-7377a0d85e8mr1620793b3a.6.1742422687959;
        Wed, 19 Mar 2025 15:18:07 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711695ae4sm12671807b3a.145.2025.03.19.15.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 15:18:07 -0700 (PDT)
Date: Wed, 19 Mar 2025 15:18:06 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v4 3/3] vsock/bpf: Fix bpf recvmsg() racing transport
 reassignment
Message-ID: <Z9tCnq0rBw+nETfW@pop-os.localdomain>
References: <20250317-vsock-trans-signal-race-v4-0-fc8837f3f1d4@rbox.co>
 <20250317-vsock-trans-signal-race-v4-3-fc8837f3f1d4@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317-vsock-trans-signal-race-v4-3-fc8837f3f1d4@rbox.co>

On Mon, Mar 17, 2025 at 10:52:25AM +0100, Michal Luczaj wrote:
> Signal delivery during connect() may lead to a disconnect of an already
> established socket. That involves removing socket from any sockmap and
> resetting state to SS_UNCONNECTED. While it correctly restores socket's
> proto, a call to vsock_bpf_recvmsg() might have been already under way in
> another thread. If the connect()ing thread reassigns the vsock transport to
> NULL, the recvmsg()ing thread may trigger a WARN_ON_ONCE.
> 
> connect
>   / state = SS_CONNECTED /
>                                 sock_map_update_elem
>                                 vsock_bpf_recvmsg
>                                   psock = sk_psock_get()
>   lock sk
>   if signal_pending
>     unhash
>       sock_map_remove_links

So vsock's ->recvmsg() should be restored after this, right? Then how is
vsock_bpf_recvmsg() called afterward?

>     state = SS_UNCONNECTED
>   release sk
> 
> connect
>   transport = NULL
>                                   lock sk
>                                   WARN_ON_ONCE(!vsk->transport)
> 

And I am wondering why we need to WARN here since we can handle this error
case correctly?

Thanks.
