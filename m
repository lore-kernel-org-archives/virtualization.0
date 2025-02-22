Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA0029405
	for <virtualization@lists.linux.dev>; Sat, 22 Feb 2025 00:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740183652; cv=none; b=OplgvHeabU27wcTkVtEmqP87HDs4OZ7UEFzt1ZflGJL+wK+Ckaa8Bs4ES3t8HWD4a58sFjyCHuybWQ8Q4XeqfUVaocYJpKloq9YEET1GgUwgBiYIQ641sm+7E8i+qVqheSQdRykcrh9dZVIMxTMJo3lvsGiuUcLPDdWfDgN/At0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740183652; c=relaxed/simple;
	bh=Jpld/wsaMvDtefkVSAfetn//7dDE7ynrwiVJdhUy0CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBwAmLEbdFbeHm4n3wyjzoY04XvPXrtrI0LPaUqfPw8kUbB0QusbJYAg9e01CzKHpWBSU6fj7Eij18kcObolk66d0s6fpWeMYAIK7hDNX40YVdBmycuNaW4Erhym54Ft5H45iEM8qkp0euVGLCpHjDcu2hCWX3ufIUEsB+2vj+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgwZITFR; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgwZITFR"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220f048c038so50929155ad.2
        for <virtualization@lists.linux.dev>; Fri, 21 Feb 2025 16:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740183650; x=1740788450; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=baX1epNayrlQi72ddzJtpU1XVAnuAk4Noe2u7Id9cIE=;
        b=NgwZITFRAuflfD0hVTKKJ4tikgrxzbfId5LYVAAZ5wfD+V5ii5UgJo7VzZ8HX7vKS+
         gcGBu79JbIePV9N20YUHjGt2wmF8PvoHNoX/PaJl1jHl8vvtzmOG4vOG0qQGggNErglp
         +4e+V4xWityUM0R54Pd4FS9y7fg6flatTmNkaEASJq5EJMYaFjV3a4eZGMMcxeCfVRD5
         3vrACE8VTUysAubYLXz27JxYwAtdi4rNnAMKj9y7b8Um2Ak5xGARmJJVIKtmzANGHgaN
         4BvKZ9vUUnjNHlVs2wCSblLdMAkdOAmQo4CzTM8DPUYCSaEif9w+hbIyTLEm8pIwfXVZ
         heNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740183650; x=1740788450;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=baX1epNayrlQi72ddzJtpU1XVAnuAk4Noe2u7Id9cIE=;
        b=bKy8pZHkjrqr/hGqU4zd+SW2CRY/n/lqLKHzDwjJfNjaynXU1Kz+q1b8c2yKM9f6us
         reyLttE3s88dy0RZZbeknALmhJCo8erTbdMMGwMidJqCwT9dP85SfyCfH9Tz6BI52+Cg
         cHOv3XL2Hiy3fsEG/fDoD7mwN7yDUg9fWRUXL/hhRnvv3pJF/dubL3tugNUMeuFRcDhF
         Zjdq2JVPCY02TJSk/rVJQ5u18rZcvC61souxoTjgotKS1eA1fjvUzYEGtAs/fRu3IJdf
         qRAGM0C51YKVPnMp0XiMa6S0Y7Oc7k3++qlULRHKoNfcsoF/zlKiuEUVLIxCYAsRQ676
         7XJg==
X-Forwarded-Encrypted: i=1; AJvYcCVnu9MtcAVXIMW4mXYXRwPAJoNI8QFawM7SEXdmhqRF9WGaVRxTx2QZdSNwW4AhEqqYGMWWxMGQ5VDDy3RYgg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywo73yAoxThSe4UFanBVZUmYmGVoIHUiSt9GP2IcTKkNE+xPWaB
	RWkrXTUj1ZDmQp7GQ6/6JMSVw9k18WC+mzylPcE7VVQMEWML8sk=
X-Gm-Gg: ASbGncu1xoUxjDiJz5E1qufnbRQgJtz9FQf+EmQ6A1Z1xIFumGM8zOf1rQ0716z6r7j
	1tEVIrxrBPn27yxpIylo0eUF9/DgrZ50GjsEFC8tVQMjTYsqiNZz/xg5kf9WU00ANJ3Z9NEkXKH
	FbjLNbsNXmOa2UYpInQ72JYpXPNsJzjWlCW6nOJyXos7hxn+DEFgAO/FP4fSNETmEJwXjhDgTP/
	zvC0HeJ5RDhnCuWxyqBDhcAPYINV0gfnnc3AYUqfpbNahTcB4BuRWiFpSjseflG7f1bIwCULhvV
	4sWL0QWQ3JwdqQ3jYiSP3pdQEg==
X-Google-Smtp-Source: AGHT+IFrCX359QmoPl+1WWab5kh2KoJ8H2vJqfNJp4uKVLxMtCxfKGr/wOCTqr8fdP4NEXKxJS3a3A==
X-Received: by 2002:a17:902:ea11:b0:216:55a1:35a with SMTP id d9443c01a7336-2219ff61e5cmr69980445ad.30.1740183650542;
        Fri, 21 Feb 2025 16:20:50 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d545d051sm141438035ad.108.2025.02.21.16.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 16:20:50 -0800 (PST)
Date: Fri, 21 Feb 2025 16:20:49 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
	asml.silence@gmail.com, dw@davidwei.uk,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH net-next v4 9/9] selftests: ncdevmem: Implement devmem
 TCP TX
Message-ID: <Z7kYYXixRws7Kk-q@mini-arch>
References: <20250220020914.895431-1-almasrymina@google.com>
 <20250220020914.895431-10-almasrymina@google.com>
 <Z7eKHlA0rCF2Wgxb@mini-arch>
 <CAHS8izPA2eQ251-whnsT7ghG01c0e=tERL4Cwg1tBr+ZfVNHpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izPA2eQ251-whnsT7ghG01c0e=tERL4Cwg1tBr+ZfVNHpA@mail.gmail.com>

On 02/21, Mina Almasry wrote:
> Hi Stan,
> 
> Thank you very much for testing. I was wondering/worried that there
> will be some churn in getting the test working on both our setups.
> It's not unheard of I think because your ncdevmem changes had to go
> through a couple of iterations to work for our slightly different
> setups, but do bear with me. Thanks!
> 
> On Thu, Feb 20, 2025 at 12:01 PM Stanislav Fomichev
> <stfomichev@gmail.com> wrote:
> > > @@ -25,18 +25,36 @@ def check_rx(cfg) -> None:
> > >      require_devmem(cfg)
> > >
> > >      port = rand_port()
> > > -    listen_cmd = f"./ncdevmem -l -f {cfg.ifname} -s {cfg.v6} -p {port}"
> > > +    listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.v6} -p {port}"
> > >
> > >      with bkg(listen_cmd) as socat:
> > >          wait_port_listen(port)
> > > -        cmd(f"echo -e \"hello\\nworld\"| socat -u - TCP6:[{cfg.v6}]:{port}", host=cfg.remote, shell=True)
> > > +        cmd(f"echo -e \"hello\\nworld\"| socat -u - TCP6:{cfg.v6}:{port},bind={cfg.remote_v6}:{port}", host=cfg.remote, shell=True)
> >
> > IPv6 address need to be wrapped into [], so has to be at least:
> >         socat -u - TCP6:[{cfg.v6}]:{port},bind=[{cfg.remote_v6}]:{port}
> >
> 
> Yeah, I will need to propagate the ncdevmem ipv4 support to devmem.py
> in the future, but unnecessary for this series. Will do.
> 
> > But not sure why we care here about bind address here, let the kernel
> > figure out the routing.
> >
> 
> I will need to add this in the future to support my 5-tuple flow
> steering setup in the future, but it is indeed unnecessary for this
> series. Additionally the bind in the check_tx test is unnecessary,
> removed there as well. Lets see if it works for you.

Hmm, true that it's not needed in check_tx as well. Let's drop from
check_tx and introduce when you need it? (but up to you really,
was just wondering why change rx side..)
