Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7671C32
	for <virtualization@lists.linux.dev>; Sat, 22 Feb 2025 00:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740182937; cv=none; b=gOHMVSmoZ9Rqmr/aHO66G1xefnZcpQ6Vut8TCCIbO4Nj959qZCGVDdAH/cpKzgmFo+8IuvYVtmyUx+dpZihvCfhk8yi0JA1I8i7Psb77s+YZOZc75Fvj3jevlfBmG9oMn5lXBYVFImWSyh3zAxkg0iYQ+ZuANgYxq+1+dgfce+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740182937; c=relaxed/simple;
	bh=PdvNIGHQi28mOeEpG9qqj09SgaiMTVaG11C/XJdJ5Ik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4qFIoY5puwgJXJk6Y2uxMiYaCAuKbdIYsbpDpxJ7xC7pHh3YMvEJP0rnO0shLJ2q1CRAp00TzxrCI6CR9zktAPX7kXgybQxN7POIvsJd/dMcOrlTZCGzv2bG45B3D5LBBkVkUjYdeS9eChhTJ6H9eid/jKZW+7B3fneqJX8O7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ac89ZfDj; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ac89ZfDj"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22117c396baso31645ad.1
        for <virtualization@lists.linux.dev>; Fri, 21 Feb 2025 16:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740182935; x=1740787735; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1LxlF2XPfvnxZQ102MjlGXWCnz/+GLqNslH9rkDQj9E=;
        b=ac89ZfDjWDZJiYMaxgr38tUJXtKrysWN446kC2VtTyzG3jqDNXDw7WLINtxtp3sWJx
         jYLYlSgbJnr6PhKwnhit10BtD9NBuVtAHTkB80kJFs6OV6B7NVwz1l4io0yeRExMi6Q1
         lwHKleLK1BIAT/efATv01vWrROXCJPcVu22Un1aQpH+tGb3nFKqnz7DHZVeGENAITcNQ
         zeeXPB6gC35Ztew3Ryom+Zjx15v2ergIiYS5eBSowzIhJWld3LmzO+YlbAS+hcYAXcCM
         PdrVU6wLPiE7yYXUPiVrbR+jJI3r2qUGjYC6D/DIvKZtX+iSYcnaUoyUzPD64XNtHZSz
         t2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740182935; x=1740787735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1LxlF2XPfvnxZQ102MjlGXWCnz/+GLqNslH9rkDQj9E=;
        b=BLlnsomJdhs48l+fVZOYN8IYOeqNsxDHe8hJWQNCHM1JsybOHOp1YiFJjEw+BQF+1b
         3Zc/c8eJeFv3GTSfOzy8ns3PU+pr68QTZW+QUMpHmVqDaxP/7h/0n5HUHW1rhmseQPBZ
         k7VA26S6o/7VMoGW/eqFuCoKg1ZPhHZJ6/n/GkaViosmhKzRhe8TcNzYeA61bakDhkEA
         jyeROeRBilNnyIOC4qI4grjp8opcwY1s1VryYjC2hlA5A5ONEPxpdxAjPl0vbubSpZc2
         o4raREx30f87sJT1HLegZGhhbCxb3QC6kWI9HalbhXLa6o21FHMNVg9DcYZHvd4dZq1D
         z0Ug==
X-Forwarded-Encrypted: i=1; AJvYcCUPmWuAPXjd2LnG7Zrz0E95ikGxtX3NYjhShqzMmsa/OIqswX0A7PLf2V5LGDOlxJxx/EysgWe12c+dafu0rw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwwDgwewlvkZZpsR5aS62u2wLPq2wU/8WxtNQ/jpMUV6hIc7R8N
	EWsJB/A1FLuYW1o+lsWuWFV4hvpMmZKr1uesdrQtKx7QxJ7E6xsLzsnjvi7dnyMBsXqS7PfKA+4
	ATubkB2ixzSWCcoYHKYo2eE/kJQdlniMqWweMRwxQZAHDRZtCkqZW
X-Gm-Gg: ASbGncvCQyMPQ2cnHx/0rOiicgca6ZZ5vrlcTB5iueOBoO5j84fYLDbfu6p7IQ1EJ2A
	SI4vhTE2+tTAJbwnZo93KjiD5X6ypF33fQqxl4PUvYQsCuOvs1NO3LVg/MTHQWSESsxtIwLaTvi
	7P5FAbXis=
X-Google-Smtp-Source: AGHT+IFs8OSDbikLuc4z8Je8QeS+ag2Wiy+VmDy4SB3aG6a3gth4nejCH8UkdT2ijydQhcSXWuEfpYlNQX3au+sfJ1A=
X-Received: by 2002:a17:902:e852:b0:216:6dab:8042 with SMTP id
 d9443c01a7336-221b9d2e706mr1003815ad.12.1740182935131; Fri, 21 Feb 2025
 16:08:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250220020914.895431-1-almasrymina@google.com>
 <20250220020914.895431-10-almasrymina@google.com> <Z7eKHlA0rCF2Wgxb@mini-arch>
In-Reply-To: <Z7eKHlA0rCF2Wgxb@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 21 Feb 2025 16:08:42 -0800
X-Gm-Features: AWEUYZmBWXmjjwtaXgQB3UGLCCYTeJGLoZajHgAmTK8d-xFcEm-al47z60fCJhk
Message-ID: <CAHS8izPA2eQ251-whnsT7ghG01c0e=tERL4Cwg1tBr+ZfVNHpA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 9/9] selftests: ncdevmem: Implement devmem TCP TX
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Shailend Chand <shailend@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stan,

Thank you very much for testing. I was wondering/worried that there
will be some churn in getting the test working on both our setups.
It's not unheard of I think because your ncdevmem changes had to go
through a couple of iterations to work for our slightly different
setups, but do bear with me. Thanks!

On Thu, Feb 20, 2025 at 12:01=E2=80=AFPM Stanislav Fomichev
<stfomichev@gmail.com> wrote:
> > @@ -25,18 +25,36 @@ def check_rx(cfg) -> None:
> >      require_devmem(cfg)
> >
> >      port =3D rand_port()
> > -    listen_cmd =3D f"./ncdevmem -l -f {cfg.ifname} -s {cfg.v6} -p {por=
t}"
> > +    listen_cmd =3D f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.v6} -p=
 {port}"
> >
> >      with bkg(listen_cmd) as socat:
> >          wait_port_listen(port)
> > -        cmd(f"echo -e \"hello\\nworld\"| socat -u - TCP6:[{cfg.v6}]:{p=
ort}", host=3Dcfg.remote, shell=3DTrue)
> > +        cmd(f"echo -e \"hello\\nworld\"| socat -u - TCP6:{cfg.v6}:{por=
t},bind=3D{cfg.remote_v6}:{port}", host=3Dcfg.remote, shell=3DTrue)
>
> IPv6 address need to be wrapped into [], so has to be at least:
>         socat -u - TCP6:[{cfg.v6}]:{port},bind=3D[{cfg.remote_v6}]:{port}
>

Yeah, I will need to propagate the ncdevmem ipv4 support to devmem.py
in the future, but unnecessary for this series. Will do.

> But not sure why we care here about bind address here, let the kernel
> figure out the routing.
>

I will need to add this in the future to support my 5-tuple flow
steering setup in the future, but it is indeed unnecessary for this
series. Additionally the bind in the check_tx test is unnecessary,
removed there as well. Lets see if it works for you.

> Also, seems like "bkg(listen_cmd)" needs to be "bkg(listen_cmd,
> exit_wait=3DTrue)", otherwise sometimes I see racy empty result.

It passes for me with/without, but also fine, will do!

Thanks again for testing!

--=20
Thanks,
Mina
