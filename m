Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4174935948
	for <virtualization@lists.linux.dev>; Sat, 22 Feb 2025 00:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740184527; cv=none; b=AQTK69FSzq0nqFxTCPSuEb+rF68/xkJkNxrUmmfVtV+audGUvDYUQVcE4oVq0j45YrfnbGwCERgEgqJbqgc3/RFhcQRdikyd10Vfs5DTwBRZNRx5dBnCh/qR04qFmq9dRNg+VyXfu/CLi9oPJtWzOPVTh1O7HyS2bUzhSw+sTiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740184527; c=relaxed/simple;
	bh=A/U7E1kvmOIAm34x3bsa6I7eO8q1nXzHWrVjh3Cd3qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXbhpC8vwLxNzBEbaEKc7yZyko/0mT/vcxzdKRU4gnc0t8vYoUlnPPUNTWpP6ad5ZnEGZTV5bfwGbOwaOzTeA0hU8lcV0VJQwiR0QClGUmXXHbzp8A33HvJyJK2fdes064LGrlNEj+b3rjGSNcRaYQQbaPgpPsvEUIAXNjcRSqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIa72RMs; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIa72RMs"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f83a8afcbbso4796498a91.1
        for <virtualization@lists.linux.dev>; Fri, 21 Feb 2025 16:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740184525; x=1740789325; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IDsaJerQGd1Bqxw/Zj/tNEGHvZAzlmCa/b+i2T0mnRQ=;
        b=bIa72RMspU9u20baEV99pAxF17I9Q0rzg92aTBrKqlIYtT94faR3buvgRycQu9d1bM
         zA1zY9fJOzCiB9eiiPfwOX1gLN2ya1EKMPPfdw1DUnX+2CRYNwZiT8HFjO6SZ7iiZr3O
         yJMkim/ayh3rExAD4WlCDNjzXzZ/WIiKqt0X54jVQcC1K75co3d/nvZg1PJNPGXpq1cK
         1uJ02R/dIco1zWHA9JNFD7rNwp5qNqUK9nKjz5710FuzLZrv0WsSzz8i0PxXU41ixlsa
         qRpfIbERaIOtANOGOlj5tfmw2WbS1+arBJKZcwBmCFpP9H9EKCTkJQ3oxIFtiCOBuYPn
         SClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740184525; x=1740789325;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IDsaJerQGd1Bqxw/Zj/tNEGHvZAzlmCa/b+i2T0mnRQ=;
        b=ICh4h2A1O++LP0qpvBWgw8CQYaz5dAwSo1MwH9KNAlnjxo3ZaMqXv+a50WrP4P1GUI
         NBHqPodCjPoufGgvbxZXYlPR97E6RIh9eSu6k5kmqrPEiDiyqdK7HmsptPj2/hpgpzD8
         fvAObZqV+knDPpnqCyA/jyMGK+gIynUtVGGGzZHNtDvDyrc40Nq34nBISFf2KWZCnTFV
         UUfH9JEPFkx54L8S2nOPKd530JbvX4UDPqk1FOS1+3E3kyoxh9aplQKOUqcOav2zRFk0
         TnYYLGj3x7vcJXBiCnZ9bh95uer+HadayXZCYdKqMcRMD6E6ZAkePcWCyQtbw3E0ri5D
         A/0g==
X-Forwarded-Encrypted: i=1; AJvYcCUVRwd5C8sr8q1kP5inz9dIy4Wmsy34B3Sv9P+FVHnl06yyoUlaULvdJ78kt5NwLFpa6kuyD/lhTh8cUsXL0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwATUnRMLQ4U8Af/KycPyiGbJcRCiDlGrU3cslC0gUM6udfpunv
	c68GkGH0g8dxBKTPR5pl2N0fP2yaPe6MCFdKpAxlDQe0RWRxoe0xvmVc9/M=
X-Gm-Gg: ASbGncsy7VQZzQWEJRh3xWdLdTPUQZE3eRoWkyZLPsifjbcMRTAtrSYNmDvFrXDYATP
	JwRsg07osR4wDlMLpE1JWoiqhBU5ok2iUYKz+8Cq7iyYplc+dtBN890XyH7TsNziy9xnPxcB/2/
	u7oatQlmVmKwHPbyiqSv97tTkT26hXeyDcOf9Mz84yQiPTzfK65OYe8WFgzOebmAIieXceyHbTf
	kC4MQu7WJO2ZxH8PDMJLa5Cw5DYbOPu6O1j8tq6RBE03bYrgHoiqAYIWKeCAyP32meIqTB/LU4z
	IZtqiFPC6u+uB48Fvj+GJ0oo+w==
X-Google-Smtp-Source: AGHT+IET/SzbSrTVKUnnK0GqjFXKwFRmQS4ofsUjliII251jmk4kh/bg7fWjJNmQshjMuEInDZQ6dw==
X-Received: by 2002:a17:90b:56cd:b0:2fa:22a2:26a3 with SMTP id 98e67ed59e1d1-2fce7ae91d9mr8697512a91.6.1740184525301;
        Fri, 21 Feb 2025 16:35:25 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fceb04c45dsm1987382a91.20.2025.02.21.16.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 16:35:24 -0800 (PST)
Date: Fri, 21 Feb 2025 16:35:24 -0800
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
Subject: Re: [PATCH net-next v4 6/9] net: enable driver support for netmem TX
Message-ID: <Z7kbzJSl_nNUoPnR@mini-arch>
References: <20250220020914.895431-1-almasrymina@google.com>
 <20250220020914.895431-7-almasrymina@google.com>
 <Z7d-7P8kPthyr3bG@mini-arch>
 <CAHS8izO2PU-A9gQHkJpB=QkFkiKvVUNCm5Von5GFY+5qV5+Oog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izO2PU-A9gQHkJpB=QkFkiKvVUNCm5Von5GFY+5qV5+Oog@mail.gmail.com>

On 02/21, Mina Almasry wrote:
> On Thu, Feb 20, 2025 at 11:13 AM Stanislav Fomichev
> <stfomichev@gmail.com> wrote:
> >
> > On 02/20, Mina Almasry wrote:
> > > Drivers need to make sure not to pass netmem dma-addrs to the
> > > dma-mapping API in order to support netmem TX.
> > >
> > > Add helpers and netmem_dma_*() helpers that enables special handling of
> > > netmem dma-addrs that drivers can use.
> > >
> > > Document in netmem.rst what drivers need to do to support netmem TX.
> > >
> > > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > >
> > > ---
> > >
> > > v4:
> > > - New patch
> > > ---
> > >  .../networking/net_cachelines/net_device.rst  |  1 +
> > >  Documentation/networking/netdev-features.rst  |  5 +++++
> > >  Documentation/networking/netmem.rst           | 14 +++++++++++--
> > >  include/linux/netdevice.h                     |  2 ++
> > >  include/net/netmem.h                          | 20 +++++++++++++++++++
> > >  5 files changed, 40 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
> > > index 15e31ece675f..e3043b033647 100644
> > > --- a/Documentation/networking/net_cachelines/net_device.rst
> > > +++ b/Documentation/networking/net_cachelines/net_device.rst
> > > @@ -10,6 +10,7 @@ Type                                Name                        fastpath_tx_acce
> > >  =================================== =========================== =================== =================== ===================================================================================
> > >  unsigned_long:32                    priv_flags                  read_mostly                             __dev_queue_xmit(tx)
> > >  unsigned_long:1                     lltx                        read_mostly                             HARD_TX_LOCK,HARD_TX_TRYLOCK,HARD_TX_UNLOCK(tx)
> > > +unsigned long:1                          netmem_tx:1;                read_mostly
> > >  char                                name[16]
> > >  struct netdev_name_node*            name_node
> > >  struct dev_ifalias*                 ifalias
> > > diff --git a/Documentation/networking/netdev-features.rst b/Documentation/networking/netdev-features.rst
> > > index 5014f7cc1398..02bd7536fc0c 100644
> > > --- a/Documentation/networking/netdev-features.rst
> > > +++ b/Documentation/networking/netdev-features.rst
> > > @@ -188,3 +188,8 @@ Redundancy) frames from one port to another in hardware.
> > >  This should be set for devices which duplicate outgoing HSR (High-availability
> > >  Seamless Redundancy) or PRP (Parallel Redundancy Protocol) tags automatically
> > >  frames in hardware.
> > > +
> > > +* netmem-tx
> > > +
> > > +This should be set for devices which support netmem TX. See
> > > +Documentation/networking/netmem.rst
> > > diff --git a/Documentation/networking/netmem.rst b/Documentation/networking/netmem.rst
> > > index 7de21ddb5412..43054d44c407 100644
> > > --- a/Documentation/networking/netmem.rst
> > > +++ b/Documentation/networking/netmem.rst
> > > @@ -19,8 +19,8 @@ Benefits of Netmem :
> > >  * Simplified Development: Drivers interact with a consistent API,
> > >    regardless of the underlying memory implementation.
> > >
> > > -Driver Requirements
> > > -===================
> > > +Driver RX Requirements
> > > +======================
> > >
> > >  1. The driver must support page_pool.
> > >
> > > @@ -77,3 +77,13 @@ Driver Requirements
> > >     that purpose, but be mindful that some netmem types might have longer
> > >     circulation times, such as when userspace holds a reference in zerocopy
> > >     scenarios.
> > > +
> > > +Driver TX Requirements
> > > +======================
> > > +
> > > +1. Driver should use netmem_dma_unmap_page_attrs() in lieu of
> > > +   dma_unmap_page[_attrs](), and netmem_dma_unmap_addr_set() in lieu of
> > > +   dma_unmap_addr_set(). The netmem variants will handle netmems that should
> > > +   not be dma-unmapped by the driver, such as dma-buf netmems.
> >
> > Not all drivers use dma_unmap_addr_xxx APIs (looking at mlx5). Might
> > be worth mentioning that for the drivers managing the mappings
> > differently, care might be taken to not unmap netmems?
> >
> 
> Yes now that I take a closer look, it's poorly worded to imply the
> issue is limited to dma_unmap. I will reword to say that all
> dma_map*() APIs must be avoided, and we have helpers for
> dma_unmap_*(), and more helpers can be added if needed (similar to
> wording in the Driver RX requirements).
> 
> > > +2. Driver should declare support by setting `netdev->netmem_tx = true`
> > > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > > index fccc03cd2164..d8cfd5d69ddf 100644
> > > --- a/include/linux/netdevice.h
> > > +++ b/include/linux/netdevice.h
> > > @@ -1753,6 +1753,7 @@ enum netdev_reg_state {
> > >   *   @lltx:          device supports lockless Tx. Deprecated for real HW
> > >   *                   drivers. Mainly used by logical interfaces, such as
> > >   *                   bonding and tunnels
> > > + *   @netmem_tx:     device support netmem_tx.
> > >   *
> > >   *   @name:  This is the first field of the "visible" part of this structure
> > >   *           (i.e. as seen by users in the "Space.c" file).  It is the name
> > > @@ -2061,6 +2062,7 @@ struct net_device {
> > >       struct_group(priv_flags_fast,
> > >               unsigned long           priv_flags:32;
> > >               unsigned long           lltx:1;
> > > +             unsigned long           netmem_tx:1;
> > >       );
> > >       const struct net_device_ops *netdev_ops;
> > >       const struct header_ops *header_ops;
> > > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > > index a2148ffb203d..1fb39ad63290 100644
> > > --- a/include/net/netmem.h
> > > +++ b/include/net/netmem.h
> > > @@ -8,6 +8,7 @@
> > >  #ifndef _NET_NETMEM_H
> > >  #define _NET_NETMEM_H
> > >
> > > +#include <linux/dma-mapping.h>
> > >  #include <linux/mm.h>
> > >  #include <net/net_debug.h>
> > >
> > > @@ -267,4 +268,23 @@ static inline unsigned long netmem_get_dma_addr(netmem_ref netmem)
> > >  void get_netmem(netmem_ref netmem);
> > >  void put_netmem(netmem_ref netmem);
> > >
> >
> > [..]
> >
> > > +#define netmem_dma_unmap_addr_set(NETMEM, PTR, ADDR_NAME, VAL)   \
> > > +     do {                                                     \
> > > +             if (!netmem_is_net_iov(NETMEM))                  \
> > > +                     dma_unmap_addr_set(PTR, ADDR_NAME, VAL); \
> > > +             else                                             \
> > > +                     dma_unmap_addr_set(PTR, ADDR_NAME, 0);   \
> > > +     } while (0)
> >
> > Any reason not do to static inline instaed?
> 
> Because the args passed to dma_unmap_addr_set are quite unique,
> AFAICT. PTR is a pointer to any struct that has a field (anywhere)
> inside of it called ADDR_NAME, then dma_unmap_addr_set does something
> like:
> 
> PTR->ADDR_NAME = VAL;
> 
> A static inline needs well defined types, and I couldn't figure out
> how to do that (or if it is possible), so a macro it is I guess.
> 
> Where I could, I went with static inline.

Ah dma_unmap_addr_set itself is an ugly define :-( Makes sense.
