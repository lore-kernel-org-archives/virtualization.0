Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432C04DC530
	for <virtualization@lists.linux.dev>; Thu, 22 Jan 2026 16:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769098695; cv=pass; b=g6AkR3QBkFTHqRtPCRqhOKThp97vqoOQ/IePKX0HPIyTPmrOs9k/UGdPe2Vpy0YL+XPnGItY9q31yfFvsnHTPemf9HvogRo1jeUaQ+aFEa832p3FlfKjGGNg27a+AgKZLgI0urNQvfCP5MN1N2wCFJO42VWQ/gDbx06O8C9e6Fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769098695; c=relaxed/simple;
	bh=4EcZlvqIrK25utzKAJDzkzB4IaMwK7OCW1fUm7993K0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pz4gt2jpmL3eua7M07LXLP8FNZmBgVarcisYzlTDphSlqPNQ5AXp+6nWDbBRZwARbjraeWFpkc6BAi50m7YhlMSW61e21Kc9Qp0Mc0L+0HEeOo7DnDRR4mQ15nMAD1bQaB/8C/Wa8d8Yt7JX5RHjlypTtGCe1mn3f7sfE0Q/sFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=euwylY2+; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="euwylY2+"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5014f383df6so8935961cf.1
        for <virtualization@lists.linux.dev>; Thu, 22 Jan 2026 08:18:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769098685; cv=none;
        d=google.com; s=arc-20240605;
        b=XV50n2TfGtGlh6qJJy1tV5KRP3HJ4ku3nJ8DxOhVRxHEiZ+9cimtOgyf+TEcEoZ5DI
         yDy4PSGLqNnjjN4dAh6KYw71vLqHgLUaNIv1lpxsds5kbLf9OyrGgDXFDZVmYQOJZkH3
         6MEYb2gdkG6eYTQ9bVNSONnqTfEs/hOhSH4Duaq+xa9cmcMV2FXnS1E0AFOzk2N3bxIJ
         npUbYTbERpkeSSHitzYpBMcDolsVjjvM5DWCmAyZN7VBiGjO2ZSgr5MeQA4j3lO1MgI5
         9FlP1p1ASE+NZosrMJQkPY4Y9ytHpiCHYuimm48oRvuIa41QxNAnV3FoAC72D7Ab9kYf
         1zkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8mGUkSnoCMX0c5y8OzCg730s87hzIp9pHV9djN0CtBk=;
        fh=s+1OZDR8K+p0YORIhYzFwrhOXVv6aJB1GbOhiH6+Jp8=;
        b=TMmHzS6eHEBmZH+pGl45C4Io885YJxNMMfjLvfZWCndapNOt2vFGmlcOGGKGh93TQ9
         XJg1hPXTVqJ6kcLn7hMrU3YCDc/fq4i0jFrgnjmQFFdRPFxc8I4BTuQ09JnRSD8zcmKH
         RlFQXHine1saZGmzkK9GNTvTYPwatP2qZX68uzPjyKA3B13tDuWuVlEI737gdh2NRhyK
         fyw65O36OHlbTS995HAgMOuudjSrxg45t75dA4lGdNnJt2DcZ5rx/wMzrxbF+ZY1AJSP
         QfY7tXJJ7ZdlKTJVxoGVY+iLcq14XEOOSUoU2U4xE0QlEfOX9Fa9Iqgi5guusA/zR+jg
         TH6Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769098685; x=1769703485; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mGUkSnoCMX0c5y8OzCg730s87hzIp9pHV9djN0CtBk=;
        b=euwylY2+Yfe9qa1H2xY/YmhAHmJaLydtjiyCAwlTBkm0NWIvGfMRuyIatGUEhRKWh/
         Ea3TjMZOHInwvdi66EuCZtzx3i6sAPYggHkSKvB90IIeT8lMWkYX2Zx6hVOZRNdNmlJl
         zK5wEfKtPqUZ2ybp0knJKdXo93RTZbbfMh/1SxMYHWkRgx5GTPagUPrCpZu0c1HLZdWn
         W0i0i8idvcbaLr6IKpTl5ZpaZ6mL3sj725mWCkrIB/wwcu1grmtGTDIsM9qUhk7bNfRP
         6r2SMfbbdrvkwt5qILtp3Z74EqMKSiywtjs9RB6AfnW6aIuXIiLIjjzSXGFxC++CHhH9
         OszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769098685; x=1769703485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8mGUkSnoCMX0c5y8OzCg730s87hzIp9pHV9djN0CtBk=;
        b=wJM4MDIDqREArz4tYnLi/V+uKfVBCLdLTQ1WLFB7P6FgXkYMAqpu94TTxggdTBR7Dk
         7qWrtNmq2nKmQ/BqyTlVm/QKsx7ZRyjhsWv8tuknNL0xifrg8yVWcUHGZLyKuPS9s+M3
         X3jRA+CTrW6rB8u5b0UdCyxOn1hbE6Pn2iGMQpapR5wWsCGjKrfUXlTL2pGfsZCPtypH
         k1cF5x4i7GQ7GztJxf9atcom+k7M0YnKOy0X5wwUnVn0Wm9fdK2tIsEyO0sddB+qDnWp
         8o2RhLbmFoYQYP4tC/75RgQ1q3uezEUbgkczNrAfyGY6nZLatXXbjbaK9rP8cKrvj2PH
         XtbA==
X-Forwarded-Encrypted: i=1; AJvYcCUPfhrJVjuhjqDZAjcMnKcia/5lcC2XHz4c0NiWVrSC/gLGHQ5In4zg5SIj25nAmtebR6Mjy8zD7DZzmNelsw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywok3DW3gCAnQ7ZK5Q8f0U8w9ZH7lmfDFroy4nMFxzs4eIjDu6P
	aJNLTjva/Y+Ej2R2XxhRUH5LkAvyX3IzF0EzIiaGwbyW+v5KSxq+8xZ/XLNOPKYFdYFWlHcuABD
	sbtzDz/W1EllDQMaL3vKKwMLiGdEk0QnlbXAzkFPQ
X-Gm-Gg: AZuq6aL3/WaaM6tIkLSSTo2qYwbJq9S5ColiuV0/rb/Stzt3mCqEP9doEOpw3B10imm
	NE5RM2IwT8dM1A4coqDkJP7j+23mescVK8F2DsO9db0o5fpD1Rg7djThyn/Ar2dnZG2R3fzz27i
	9wrzernDBERJv75u1yDWlwJ5OQJRvC/xf97XO19lqtuwz7RXuE3jZwzD0OX4EQo14Dyg8I6HCsd
	HeLm2vaN/GO4IGHU4Xi7PHRZkvv/525YDPeV/rwslbYoyaCHL6ujVQHYdHeQlaVKKcNLco5
X-Received: by 2002:ac8:5fcd:0:b0:4ec:f697:2c00 with SMTP id
 d75a77b69052e-502f779b7acmr687831cf.42.1769098683855; Thu, 22 Jan 2026
 08:18:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260122091527.339180-1-schalla@marvell.com> <20260122075206.504ec591@kernel.org>
 <CANn89iL5s+egLhothNtnQf0jtAeftezUjNmbuXtUWgfVV3+bzg@mail.gmail.com>
In-Reply-To: <CANn89iL5s+egLhothNtnQf0jtAeftezUjNmbuXtUWgfVV3+bzg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Jan 2026 17:17:52 +0100
X-Gm-Features: AZwV_QjFSwZ3BduD3JW5Pi3e6oTuS7B3XfiVwuw9sYCVXAr7yfIwzrmnPKTOoXQ
Message-ID: <CANn89i+e+eawQVvmVuA7jyZ=DCU+wPq3z+q6_PoVVY7ZhX2UGQ@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio_net: Increase RSS max key size to match NETDEV_RSS_KEY_LEN
To: Jakub Kicinski <kuba@kernel.org>
Cc: Srujana Challa <schalla@marvell.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, pabeni@redhat.com, mst@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, ndabilpuram@marvell.com, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 5:13=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Jan 22, 2026 at 4:52=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Thu, 22 Jan 2026 14:45:27 +0530 Srujana Challa wrote:
> > > Increase VIRTIO_NET_RSS_MAX_KEY_SIZE from 40 to 52 bytes to align wit=
h
> > > the kernel's standard RSS key length defined by NETDEV_RSS_KEY_LEN.
> >
> > I've been meaning to bump NETDEV_RSS_KEY_LEN to 128 or some such.
> > Most modern drivers can't use netdev_rss_key_fill() either because
> > core generates a tiny key. And the devices support hashing over two
> > layers of IPv6 for tunnels.
>
> Seems fine to me. Back in 2014, RSS was limited to 52 bytes on all known =
NIC.
>

BTW make it 256 bytes. 128 is already too small.

> >
> > Willem, WDYT? Is there a reason to keep the core key small?
> > Or deprecate netdev_rss_key_fill()?
>
> What do you mean by deprecating it ?
>
> One of the ideas was to make sure multiple NIC would share the same key,
> for some bonding setups.
>
> commit 960fb622f85180f36d3aff82af53e2be3db2f888    net: provide a per
> host RSS key generic infrastructure
>
>
>
> >
> > > The virtio specification requires devices to support at least 40 byte=
s
> > > for the RSS key size. However, devices may support larger key sizes
> > > up to 52 bytes (as reported by the device's rss_max_key_size config
> > > field). This change allows such devices to work properly.
> > > Previously, devices reporting rss_max_key_size > 40 would fail with
> > > an error during initialization.
> > >
> > > The driver already handles variable key sizes dynamically through
> > > vi->rss_key_size, so increasing the maximum limit is safe and
> > > maintains backward compatibility with devices that support smaller
> > > key sizes.
> >
> > > -#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
> > > +#define VIRTIO_NET_RSS_MAX_KEY_SIZE     52
