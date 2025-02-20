Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8508262D39
	for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 20:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740081698; cv=none; b=VErDqThY9cfBGRxdguA64Xgb3wjcu5i0QATVh3wgEVXmdC2PZzUN46TJ1lDzhgn+w0Fwjo9hmnHHBVPjlbmkZogRdpMCsysVPpeePjNTfAU14tC+gfNc3VL1Eghnhbp5VyGvqH1cf/3+buxQI8iAnZwan6xxrArQB51efv4w98U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740081698; c=relaxed/simple;
	bh=GXCL6RSUSvS7HAMVCHd+mRQklIK6uRVePTBP+wR/0W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/f/rmjp278LRNGJeB9SRVUuIAF6g7Yickb01Qn/KZj5anwN3vMmGhIzbeoFloG97gXm5m/C+yzjhCYA8YYoRDJ2CQaswixR05tVMvv2dk+TzfiWMOL0k3/zfAW8MNcaeXCwcYnWxZ17d0QfDUm8dN4UoEkajH+fNpJD/KjKq94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egjga3OD; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egjga3OD"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220c8cf98bbso28670045ad.1
        for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 12:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740081696; x=1740686496; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xXVAzd9z1Xkj/FF5pL9lHEU7EIbxtObnzcYt42L9wXI=;
        b=egjga3ODu+0F/0hZlabJsTxKMV2pbv3Zx4eOUlGYk58Hiwc4rzoFeJ1qHyZMVMjR/1
         FuLbfr15j4g9Otla7Iw7Ii19JCpwERi8iquU0QXZYsoBOQi5nZdtL0LHkY8TvnG3yNBL
         DLcYmD1YDxsPAnpS12Y8qUVH7sqVymnnNWaGUJyTTJF0rxYhPF91fRhtCeoa1gSpcmfj
         l4uPzmeGvqjivEOUEqPN4HdGFP9ZWfAsCTOq+B4b+XK0wwxsjAUELk/b6/wDuvm8Yr6d
         2x1K/HE3ZAR52fbPR1nSXN/dFqP8+t6e4rrNPjvZP9EvPkiG1lAidA7p2cGpen5mGNCK
         ccKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740081696; x=1740686496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXVAzd9z1Xkj/FF5pL9lHEU7EIbxtObnzcYt42L9wXI=;
        b=p4aIYgqRDfX8P2LvNgmMBarSNAZpHzeJ7w90UqrDtq3PEjKt2UYexargv6AXKi4PC2
         YlGzZn8bPIHbdu4ik0saOpE+Ced3kRbpIe5RAXtMHHXUypCSZiqSb+q1Kdkl6Ffhvmlc
         A045hn5JYSccUbkfu7yAjpp3fAwmBbbjG61qCKBRD2JnnPmNp2PCIeaOterE23/3PTSV
         kkgjz13qmlQTATn+aW53/yxWyDWAuvietpA/B3Fponnx7ch5H0AOaWr2ZpTNG6MKTrJN
         f6gG+Wp/3VjV5f5D6RDdMBPc85RTilxNCiChdtS/jmKESd4owsorYqnviDtTCXadFaCL
         fxnw==
X-Forwarded-Encrypted: i=1; AJvYcCUh1PRtx8PfjNFD1xrSY8EA/05vrpJRWrZkORBduFatCzwuzBkpQGB0YCwSz4nK0QLyI9AOUkUXqOLfD3uItA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1H8evyy+7DB3SD8RIebGxOMDv/fc8qwNjX1Dv8Sgzt8BNaRbf
	OGR+h63S+JuyTjNqkoJYs/0gS19XnyAKI1Bk1npoGff61anwJrY=
X-Gm-Gg: ASbGncs2G+bOzlqqWj6stuLqLJCXpI/H85zVL15Ri6BeI81ockmrGMEccLtVH47iJ+x
	Psv5R7sukBDiFU0qxYt1QFZMnwp3iPmKlrfPFSsrBXTZn0ewfPvbDM11/Y4sAQm0l88mC2rYuaQ
	8CQaP26iv6gzeuCHuCOxdSDN63ltaNG3URyAf7O6zi5Z3B9YIlIM32fhRE5ij2Ic1OFvpHLU0ZF
	sVpWu23S+o+Ja73h+/ZPJzJyM4IbGyAt5bFbrS//LYZzmvVL35PPvlUpKUXh0UK1gNnnZBmIkaF
	ZNy3aUIZ1UsOvtc=
X-Google-Smtp-Source: AGHT+IG15zCfEBW31sU+1aRPB26CfUNNJjIKvAOSrUMtD5sMukp+5wmY0Gkb9qUidKnvxdpmpChoZA==
X-Received: by 2002:a17:902:e5c5:b0:220:cd9a:a177 with SMTP id d9443c01a7336-221a0ec33d8mr457305ad.9.1740081696137;
        Thu, 20 Feb 2025 12:01:36 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d556e15esm126564135ad.190.2025.02.20.12.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 12:01:35 -0800 (PST)
Date: Thu, 20 Feb 2025 12:01:34 -0800
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
Message-ID: <Z7eKHlA0rCF2Wgxb@mini-arch>
References: <20250220020914.895431-1-almasrymina@google.com>
 <20250220020914.895431-10-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250220020914.895431-10-almasrymina@google.com>

On 02/20, Mina Almasry wrote:
> Add support for devmem TX in ncdevmem.
> 
> This is a combination of the ncdevmem from the devmem TCP series RFCv1
> which included the TX path, and work by Stan to include the netlink API
> and refactored on top of his generic memory_provider support.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> ---
> 
> v4:
> - Add TX test to devmem.py (Paolo).
> 
> v3:
> - Update ncdevmem docs to run validation with RX-only and RX-with-TX.
> - Fix build warnings (Stan).
> - Make the validation expect new lines in the pattern so we can have the
>   TX path behave like netcat (Stan).
> - Change ret to errno in error() calls (Stan).
> - Handle the case where client_ip is not provided (Stan).
> - Don't assume mid is <= 2000 (Stan).
> 
> v2:
> - make errors a static variable so that we catch instances where there
>   are less than 20 errors across different buffers.
> - Fix the issue where the seed is reset to 0 instead of its starting
>   value 1.
> - Use 1000ULL instead of 1000 to guard against overflow (Willem).
> - Do not set POLLERR (Willem).
> - Update the test to use the new interface where iov_base is the
>   dmabuf_offset.
> - Update the test to send 2 iov instead of 1, so we get some test
>   coverage over sending multiple iovs at once.
> - Print the ifindex the test is using, useful for debugging issues where
>   maybe the test may fail because the ifindex of the socket is different
>   from the dmabuf binding.
> 
> ---
>  .../selftests/drivers/net/hw/devmem.py        |  28 +-
>  .../selftests/drivers/net/hw/ncdevmem.c       | 300 +++++++++++++++++-
>  2 files changed, 312 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
> index 1223f0f5c10c..3d4f7fc5e63f 100755
> --- a/tools/testing/selftests/drivers/net/hw/devmem.py
> +++ b/tools/testing/selftests/drivers/net/hw/devmem.py
> @@ -1,6 +1,7 @@
>  #!/usr/bin/env python3
>  # SPDX-License-Identifier: GPL-2.0
>  
> +from os import path
>  from lib.py import ksft_run, ksft_exit
>  from lib.py import ksft_eq, KsftSkipEx
>  from lib.py import NetDrvEpEnv
> @@ -10,8 +11,7 @@ from lib.py import ksft_disruptive
>  
>  def require_devmem(cfg):
>      if not hasattr(cfg, "_devmem_probed"):
> -        port = rand_port()
> -        probe_command = f"./ncdevmem -f {cfg.ifname}"
> +        probe_command = f"{cfg.bin_local} -f {cfg.ifname}"
>          cfg._devmem_supported = cmd(probe_command, fail=False, shell=True).ret == 0
>          cfg._devmem_probed = True
>  
> @@ -25,18 +25,36 @@ def check_rx(cfg) -> None:
>      require_devmem(cfg)
>  
>      port = rand_port()
> -    listen_cmd = f"./ncdevmem -l -f {cfg.ifname} -s {cfg.v6} -p {port}"
> +    listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.v6} -p {port}"
>  
>      with bkg(listen_cmd) as socat:
>          wait_port_listen(port)
> -        cmd(f"echo -e \"hello\\nworld\"| socat -u - TCP6:[{cfg.v6}]:{port}", host=cfg.remote, shell=True)
> +        cmd(f"echo -e \"hello\\nworld\"| socat -u - TCP6:{cfg.v6}:{port},bind={cfg.remote_v6}:{port}", host=cfg.remote, shell=True)

IPv6 address need to be wrapped into [], so has to be at least:
	socat -u - TCP6:[{cfg.v6}]:{port},bind=[{cfg.remote_v6}]:{port}

But not sure why we care here about bind address here, let the kernel
figure out the routing.

Also, seems like "bkg(listen_cmd)" needs to be "bkg(listen_cmd,
exit_wait=True)", otherwise sometimes I see racy empty result.
