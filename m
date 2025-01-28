Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD9319AD48
	for <virtualization@lists.linux.dev>; Tue, 28 Jan 2025 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738075804; cv=none; b=sQJaeqy8egEe0hf+9VEJMgsqOUMLx4rUJN9BH1QIhmgIE2u2icmc4M3eVBcUR8N2p6f9DLx6JW0rmn8FZlWnWknpSUzu7uQYT53JUi+ysCTpPQtHq6deNd9dlA84jzozgH1qV11qbOPcQ5ywQGYERl+5DObS9y2IR1cwqefACRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738075804; c=relaxed/simple;
	bh=8IpvaS1zfcVdWjXbEe4QmGoiJaTdnB3V6B3WOb2GQHs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=tbEay3yn5nINFhWij7BeSiygJvpSs8wvbss4bL0D2ttfnsZhFroxbUU5X/KWNFVtS94slaRX2CW6rrqTCYQNjc1r36F5q0lJP862ghMtVCWpoIhBQuyLiF2tPyZglsMLbJw4DyqeVTEI/DFEPpGS1+5QPv4Glu1gn89RtbCi0bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZATh7J/; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZATh7J/"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-51619b06a1cso3402337e0c.3
        for <virtualization@lists.linux.dev>; Tue, 28 Jan 2025 06:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738075801; x=1738680601; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zb99191K64oonEm8sGz6Xg9hMLlXiUhPwruyb9S25aU=;
        b=JZATh7J/zwfFGyvYasxPFTEsrigWJFNmpTz899bfVJvFy9NJcSkv1tkF4UpxRXGdQV
         g1Ag1/S2rhS61dB5vAzVBZOiz+YJzVXta/8Ik7x6JFL41AoSABKUD9Rb24yi2BlGRVEB
         SGXFbj36ovTPro+Vq0ev48dlBu2IrEqfOINiMl0ofLbrKNYZldyu65Cdwy15kMYAln+L
         xVEh509NdVrtV69eiG9giDRqeEQKy5BYJj9wf7nSSnPLUmsTiYYwZcdBYV5JMeIK6ZRX
         lYA8zs/uYMiR4peO4zA0fCxVEnuKNBBFST0ots0L5NZu9JWORRioaM0VmDGGhD6rphZ9
         d8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738075801; x=1738680601;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zb99191K64oonEm8sGz6Xg9hMLlXiUhPwruyb9S25aU=;
        b=Unhzzc022Wg5bpILv+FgmEITb9R2LafLW6IIbRxGtKxQ+hcfSvTuIX+/L4lc0cQ4TT
         IhB6QJ683EKwM5mCcgUdJAgPWoACgBs9b193HPuoWrReV0FMCyClTFcrrkmhMja1mPZw
         RAqrdEfWi5AFZLagMGvg0e7+km0LSv81DFSHqI9TsNf9z7Z4y+oj8UANpL8StmZ7YVuP
         oNc8mXQ9ZfKns5+W7ua/TbMsxF70qDBUP3+Z8ZY3ok0XyEjYPk9uDLHPdjayV9lS+hW9
         XulU9vQzqDZ//gRgyCLyAWnfaAGQqKDYe/H4QO50EgzIXR4b5U3GlXSbYnXB1bnRE/vu
         cK/A==
X-Forwarded-Encrypted: i=1; AJvYcCWTCarcvpQOe2zYNC82SDFXklyc0jo/uqTUcxwxVg0oqleyNer9GqnVIe33gSAOIO2sQ9ruEAQwn90WB4jVDA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxa3kXz99NQTmbOidvHQkT/dpYRllPm+SuYgxngv1ZiEk1VeWV6
	8UO89HAxWEYPYSRpHMqNKoniW8fakF9BSmi7izc4P/BssQgF4RNW
X-Gm-Gg: ASbGncuaGPa78tKD5/FcBCjcAGWitxRsoPNN7IYSDvi9+WZ8xyQZl30KdCp6FKs4Elb
	h+Y6Bu+sGMXoPzN9z87gsxq10pybcEtqUayoGy6wS4u+6ysbgTBHRVKwmcpNimxxmMYT1prc71B
	EiC2Rc2uY9xBXWhBlcl4cj0pinl5ayf3UVwLm1nVgJ1T/ec/UbI04qIggZTmibxGWJYksFMuC18
	G/6Huv79EZggnMuXCcvtRrsYJuRN0Hk9+6bcAk4RKKE0s9IJ7D9XX/68PHe6XwIJFbJUC6cYs+p
	/VSYpimXj7RwaZhObPcsxtTDScY5MWzp8ISZSZTEJSHT7YmTZyo0Tz8GXCTHy2M=
X-Google-Smtp-Source: AGHT+IHW31CLAfaZZ/6noX+17+d4mKCF+2r2fMRxUk8GJnrrJeBabGTvUIlBo05ZEujchzkiLC6htg==
X-Received: by 2002:a05:6122:1698:b0:518:91b3:5e37 with SMTP id 71dfb90a1353d-51d5b26bbafmr36947933e0c.5.1738075801328;
        Tue, 28 Jan 2025 06:50:01 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51e4ea71de3sm1791758e0c.12.2025.01.28.06.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 06:50:00 -0800 (PST)
Date: Tue, 28 Jan 2025 09:49:59 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 kvm@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 David Ahern <dsahern@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, 
 Kaiyuan Zhang <kaiyuanz@google.com>, 
 Pavel Begunkov <asml.silence@gmail.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Joe Damato <jdamato@fastly.com>, 
 dw@davidwei.uk
Message-ID: <6798ee97c73e1_987d9294d6@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAHS8izNzbEi_Dn+hDohF9Go=et7kts-BnmEpq=Znpot7o7B5wA@mail.gmail.com>
References: <20241221004236.2629280-1-almasrymina@google.com>
 <20241221004236.2629280-6-almasrymina@google.com>
 <676dd022d1388_1d346b2947@willemb.c.googlers.com.notmuch>
 <CAHS8izNzbEi_Dn+hDohF9Go=et7kts-BnmEpq=Znpot7o7B5wA@mail.gmail.com>
Subject: Re: [PATCH RFC net-next v1 5/5] net: devmem: Implement TX path
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

> > > +struct net_devmem_dmabuf_binding *
> > > +net_devmem_get_sockc_binding(struct sock *sk, struct sockcm_cookie *sockc)
> > > +{
> > > +     struct net_devmem_dmabuf_binding *binding;
> > > +     int err = 0;
> > > +
> > > +     binding = net_devmem_lookup_dmabuf(sockc->dmabuf_id);
> >
> > This lookup is from global xarray net_devmem_dmabuf_bindings.
> >
> > Is there a check that the socket is sending out through the device
> > to which this dmabuf was bound with netlink? Should there be?
> > (e.g., SO_BINDTODEVICE).
> >
> 
> Yes, I think it may be an issue if the user triggers a send from a
> different netdevice, because indeed when we bind a dmabuf we bind it
> to a specific netdevice.
> 
> One option is as you say to require TX sockets to be bound and to
> check that we're bound to the correct netdev. I also wonder if I can
> make this work without SO_BINDTODEVICE, by querying the netdev the
> sock is currently trying to send out on and doing a check in the
> tcp_sendmsg. I'm not sure if this is possible but I'll give it a look.

I was a bit quick on mentioning SO_BINDTODEVICE. Agreed that it is
vastly preferable to not require that, but infer the device from
the connected TCP sock.

