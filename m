Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1E51DE8A8
	for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740078602; cv=none; b=Deb7yua4D5Av8CwEAoVBCHsLS33ish8NcT7r+mktAUfvs1lj1GaXfh9ya/vsWAZDF3z550nQrT1v1EuC1+ZdxJQiJq8xeyILwzxejpoXdPiap2crF4ut6KlqW+io+IRMgW0YyqAsj6Rov+7bsHSKJWOc4KqfWVBEj3QMlwl0wCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740078602; c=relaxed/simple;
	bh=mpA/MrEeSlFfQy/SUQZrdZ86KKOSDip+BWmaXv9pjDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pm4Cw+SJFnZCWXQN3W/uWFebCKgb4ToQwyUwiqcCoXR3ck0AWovgnW8lkib71TyF7bg2d0TLK8sjwXNGGkmx0QkczSSTm1vGr69LhQUZ7lfltZ9t7G9G22LYM+jJnq0/PqKtDtJh5K9qwGo0r45XWoHZ2wJcQ2pN+xmjCHUNC7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYPCL3YR; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYPCL3YR"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fc1f410186so4290635a91.0
        for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 11:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740078599; x=1740683399; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rQV/ZoI7XcCPA75+erkDe6R94FlXLvLV8fokf9ogYZQ=;
        b=QYPCL3YRIemQ+YXhgD/bZ2Fvsuyi8IQH54D3RPCE4NADXHrodbA6bHYeL+RjK8qOvX
         gu1Jb0RsITovEfPu0jAeXWQoICCn9dEbDa8W0VF2aZdTuJVuz55xLtsMsX0/HetDI4CX
         rUyfitA+Q57Je15p3e8fZyUqBngIY8qZMwWF0YflNewnXqDp4lq2kGOfvmCsHZjGRtwY
         NsWejO7WpigU3tQ2Z4Glq9/rCTSRMKaww9RfcnWOIfefm4LhCF63Rx4j0tAi9Y5YLFyF
         a9TrvzDRGzEg1UiOUdJQe97rpWtMZzpFBRR8q3VaVAs4mPJeSX0VJIauSSc7b2LgaBR7
         jHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740078599; x=1740683399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQV/ZoI7XcCPA75+erkDe6R94FlXLvLV8fokf9ogYZQ=;
        b=lewGF4HB5fDjl3C1QM9iHqZPoAmrlwMYkQGzyV+smzUbWFwbfpL6xBb0DfNisaz/yX
         bz162r5qtN+lJdLDGpOmHaxmxL5e599TeHP6YrsyEf0GUCw49wooHTTVso6Kv2Qyjj5w
         XpKYrKOlVwOrRslhWHYEpcUWhmAxDnCohE0Za5Mzs8fCIHrGHq8vzNuIzirKOQ9dBf2L
         hB2SpnmaDHkPhFbQ3rMB4Kf8pCltUCg9zJAWD8V8nR+kCgsr92NQBRzvF50bj7xnfC/J
         dMXpxKxn+fDkUaF2ftHamUBELlgxHbKY7/3t/5HNTe/Psx33XGT9nT0GkDENEBNpj2Ea
         O9Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWGhDbTDiUcsGdUJq7InVFQvymPrFMmCIByxTSZEnT77wSRkbmmhwwL+VKYDzQGk/zCQLE7PKk99Zko2xNnSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywx+fgwZ6VBzNEyk7QX69Ymz1dY6yIjAa/RLgtkMJ/ay+R3tBGx
	m7LlI3eA/zqWcbW+IzLJbUWMGw9o6PUDaMeb9F1o6Nt4DSRDKWU=
X-Gm-Gg: ASbGncvsjS4FjIN/5wHNfod67FVTGZWw8rPBzsF1mYQ0ZhnX8QQ27ODFhmO1VdsMYGr
	Yzse8At+ZM5ynDkgvlJBx3baKQVLvNalqidT0QcYijV2j0FfQwcZNbmOQR9WVCAEVW5eLHYxc/+
	jzbI5Ken0tfXOyEtENdcKd9C883It1tSGRf337HM1oMgPuA7qjuAXcYNjtBczDU9wQ94RdVYghh
	75zQcAACTWPTi7SAdbqWS/aFJy+DuDbJdvIrPBa0iRImFo/G7aqS3mqHp19HXbxJXXPNsSB3QyA
	7+eIFVSM+jnKfyE=
X-Google-Smtp-Source: AGHT+IEvQXeZzfRjz714HfRbuoChSJiph3o3vx35z1y6/TWaF62kBH0YqfkLwI1WQdwkSFnjKYBxnA==
X-Received: by 2002:a05:6a00:8a17:b0:732:6a48:22f6 with SMTP id d2e1a72fcca58-7341410bb54mr6308200b3a.9.1740078597790;
        Thu, 20 Feb 2025 11:09:57 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7326b5ef448sm10144080b3a.173.2025.02.20.11.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 11:09:57 -0800 (PST)
Date: Thu, 20 Feb 2025 11:09:55 -0800
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
Message-ID: <Z7d-A7yhzH1t8D_3@mini-arch>
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

Commit de94e8697405 ("selftests: drv-net: store addresses in dict indexed by
ipver") just went it, so v6 needs to be addr_v['6'] and remote_v6 needs
to be remote_addr_v['6'].

>  
>      with bkg(listen_cmd) as socat:
>          wait_port_listen(port)
> -        cmd(f"echo -e \"hello\\nworld\"| socat -u - TCP6:[{cfg.v6}]:{port}", host=cfg.remote, shell=True)
> +        cmd(f"echo -e \"hello\\nworld\"| socat -u - TCP6:{cfg.v6}:{port},bind={cfg.remote_v6}:{port}", host=cfg.remote, shell=True)
> +

[..]

> +    ksft_eq(ncdevmem.stdout.strip(), "hello\nworld")

s/ncdevmem/socat/ (or rename socat in the with block above)

> +@ksft_disruptive
> +def check_tx(cfg) -> None:

[..]

> +    cfg.require_v6()

This is also now require_ipver("6") I think..

Gonna try to run the selftest and see if anything else pops up...
