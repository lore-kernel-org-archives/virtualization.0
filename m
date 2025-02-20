Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D49213248
	for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 19:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740078833; cv=none; b=Hoz71X+g2tsjwuPXozAOYBk9epN3y/JVUG24ncjJY8kd/Kx9w5IdwjJJJqBtPliF0No+DBHamlfq8pIR2Mw5RbgnRnWHJ5HeEI+IYZvcw8EGWPsNBNKTvtCSgokKmPBVj2iIuOk+sbVnrWHXqnppMyOHxND1WpeGUzZEMMN2KTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740078833; c=relaxed/simple;
	bh=bYvpIuR6+4V4p0e3j5E3/HYm2LJSdnNVx04OJcQ01F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVUySxgwvgAKlsrvbv3WZVqB6NKgsIZmnlsR7gUc5OkZq8y+6WN/eD93vQUkh/G415gbduFqlRaeCynZMLd8/K0yFkYw8JoXIuO6sAYz8wL9Cx8g2xHxlH5hYzzvrqcGLOwWPHR2k6WcoAzyWQT3BPM3nJDSmLCXXEzAz5Wd4as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EepkNBBH; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EepkNBBH"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2211cd4463cso27547705ad.2
        for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 11:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740078831; x=1740683631; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JkQa+dhEgsqTxqH9wwhvXJ34Tn9uVSWrpA8SXTi2VJk=;
        b=EepkNBBHKDlfxpSbs7t8hk6B9liUDFNF05t9MH+oFid6KWgerNPQWe7G4W16HH8ppw
         zyhtUx5mkEFeRWxct7ZwrT1DVoY28xLh2ET7w0emNQQ1GNHSNnUAfLRYny9n+kqx8MNu
         CfMoJ30gL2phwfcX/7/j25dauk5HjgBUQy0nqt7FGQ6FD+TD0wYDqTWwDAUbQHGDD/Ij
         2ghV5dhNtLp1W85vBDg986PV9tpyoMFuRCdoQp2bcUVw+NIzeoGwxv8jA5AK5P4N1kfs
         K70hGxoKV/hMOMPHH9E8L3XVds8ioaCsPJQSsUy1qMKTlY4BO0QfNR31DTih1qgWQY6Y
         VjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740078831; x=1740683631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JkQa+dhEgsqTxqH9wwhvXJ34Tn9uVSWrpA8SXTi2VJk=;
        b=ZUWE9eLeVzuf3j/Q44R/R71tjqUZUsNMd5Lz3bVwdIlrRygOLxgfiiVWQFvlRJf2Uk
         2EhmaaPIxl7Qe4zCpdD6/BqP+RqeBsZTjg3XvfPQ39Zt/8lzypJKO9/4IE5AHd6bGHC3
         IGsPkbdpBACTE7MmV4dY2pGOR5oMZXdhedDrirZNOfsO/UNQDz7mVBU4sFUiTdDv8O+e
         w1InGl7hEYFJr1VriDPiTWH5Ukqun6nsE7nqKmNhLFNxySqBZRlc31v334/XnFA2l4pO
         s9WMBLtIuaG5VgxQ22MP9weyVNqfQDkP6fmh8aq3K/DYhl4eMnk6T2azWywLNRhBBEMK
         wGXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOWeIb0F8tZsrby9NS8hbESyQO/xPFfQojM0Qx4E87qFUsa065x0kXvvOmfQDC67kwa9RRJihLOyWo2Ew2vw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyYri5XFnqWluc3X2unmH5FbkAxq9gud+8sSRf7k8WgNetTXKbW
	wP5TVPZJa5GngSmAXHkYLS8ck4VSYMwpwb9Rez4NEmtVgfBwIeU=
X-Gm-Gg: ASbGncuXbxeGxUGMNF31ujtVH6Vgsc3qIGu3U1ekiTWnHP2+4OdS+RbPbzA4GnHRK1d
	2edN2s4pTpsygfXJdtyg/Z+DjLnStaKCjWqFOCsD65vSW+M1Ff+FppuZQsSOMeVFBvxXhnboXoV
	ZX1MVnyXC6xmO3FPdMB9ZIvp6yHZkfy51vECD2iwjbenWltlIU6spx+Wq3IYA6PArISw+rzu0tJ
	la/BtC6JPhF0tKVypQGj4pcex70hycRvXEH6mza5PmO+P2sSD4XSwpPc1i/HjDRufTEt9TQN4pf
	F3gUC2pDEZ4mu0I=
X-Google-Smtp-Source: AGHT+IHIIuxiMZMBBkbPNcC5zirNHq1feMk9yHBECVzOv1p5m8kEN9+wL54cjusKTa4cy0GyMsGD0w==
X-Received: by 2002:a05:6a21:7002:b0:1ee:cd18:d3f5 with SMTP id adf61e73a8af0-1eef3cb9b92mr517626637.23.1740078830809;
        Thu, 20 Feb 2025 11:13:50 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-add2e0ad0dfsm10759682a12.78.2025.02.20.11.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 11:13:50 -0800 (PST)
Date: Thu, 20 Feb 2025 11:13:48 -0800
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
Message-ID: <Z7d-7P8kPthyr3bG@mini-arch>
References: <20250220020914.895431-1-almasrymina@google.com>
 <20250220020914.895431-7-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250220020914.895431-7-almasrymina@google.com>

On 02/20, Mina Almasry wrote:
> Drivers need to make sure not to pass netmem dma-addrs to the
> dma-mapping API in order to support netmem TX.
> 
> Add helpers and netmem_dma_*() helpers that enables special handling of
> netmem dma-addrs that drivers can use.
> 
> Document in netmem.rst what drivers need to do to support netmem TX.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
> 
> v4:
> - New patch
> ---
>  .../networking/net_cachelines/net_device.rst  |  1 +
>  Documentation/networking/netdev-features.rst  |  5 +++++
>  Documentation/networking/netmem.rst           | 14 +++++++++++--
>  include/linux/netdevice.h                     |  2 ++
>  include/net/netmem.h                          | 20 +++++++++++++++++++
>  5 files changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
> index 15e31ece675f..e3043b033647 100644
> --- a/Documentation/networking/net_cachelines/net_device.rst
> +++ b/Documentation/networking/net_cachelines/net_device.rst
> @@ -10,6 +10,7 @@ Type                                Name                        fastpath_tx_acce
>  =================================== =========================== =================== =================== ===================================================================================
>  unsigned_long:32                    priv_flags                  read_mostly                             __dev_queue_xmit(tx)
>  unsigned_long:1                     lltx                        read_mostly                             HARD_TX_LOCK,HARD_TX_TRYLOCK,HARD_TX_UNLOCK(tx)
> +unsigned long:1			    netmem_tx:1;	        read_mostly
>  char                                name[16]
>  struct netdev_name_node*            name_node
>  struct dev_ifalias*                 ifalias
> diff --git a/Documentation/networking/netdev-features.rst b/Documentation/networking/netdev-features.rst
> index 5014f7cc1398..02bd7536fc0c 100644
> --- a/Documentation/networking/netdev-features.rst
> +++ b/Documentation/networking/netdev-features.rst
> @@ -188,3 +188,8 @@ Redundancy) frames from one port to another in hardware.
>  This should be set for devices which duplicate outgoing HSR (High-availability
>  Seamless Redundancy) or PRP (Parallel Redundancy Protocol) tags automatically
>  frames in hardware.
> +
> +* netmem-tx
> +
> +This should be set for devices which support netmem TX. See
> +Documentation/networking/netmem.rst
> diff --git a/Documentation/networking/netmem.rst b/Documentation/networking/netmem.rst
> index 7de21ddb5412..43054d44c407 100644
> --- a/Documentation/networking/netmem.rst
> +++ b/Documentation/networking/netmem.rst
> @@ -19,8 +19,8 @@ Benefits of Netmem :
>  * Simplified Development: Drivers interact with a consistent API,
>    regardless of the underlying memory implementation.
>  
> -Driver Requirements
> -===================
> +Driver RX Requirements
> +======================
>  
>  1. The driver must support page_pool.
>  
> @@ -77,3 +77,13 @@ Driver Requirements
>     that purpose, but be mindful that some netmem types might have longer
>     circulation times, such as when userspace holds a reference in zerocopy
>     scenarios.
> +
> +Driver TX Requirements
> +======================
> +
> +1. Driver should use netmem_dma_unmap_page_attrs() in lieu of
> +   dma_unmap_page[_attrs](), and netmem_dma_unmap_addr_set() in lieu of
> +   dma_unmap_addr_set(). The netmem variants will handle netmems that should
> +   not be dma-unmapped by the driver, such as dma-buf netmems.

Not all drivers use dma_unmap_addr_xxx APIs (looking at mlx5). Might
be worth mentioning that for the drivers managing the mappings
differently, care might be taken to not unmap netmems?

> +2. Driver should declare support by setting `netdev->netmem_tx = true`
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index fccc03cd2164..d8cfd5d69ddf 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1753,6 +1753,7 @@ enum netdev_reg_state {
>   *	@lltx:		device supports lockless Tx. Deprecated for real HW
>   *			drivers. Mainly used by logical interfaces, such as
>   *			bonding and tunnels
> + *	@netmem_tx:	device support netmem_tx.
>   *
>   *	@name:	This is the first field of the "visible" part of this structure
>   *		(i.e. as seen by users in the "Space.c" file).  It is the name
> @@ -2061,6 +2062,7 @@ struct net_device {
>  	struct_group(priv_flags_fast,
>  		unsigned long		priv_flags:32;
>  		unsigned long		lltx:1;
> +		unsigned long		netmem_tx:1;
>  	);
>  	const struct net_device_ops *netdev_ops;
>  	const struct header_ops *header_ops;
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index a2148ffb203d..1fb39ad63290 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -8,6 +8,7 @@
>  #ifndef _NET_NETMEM_H
>  #define _NET_NETMEM_H
>  
> +#include <linux/dma-mapping.h>
>  #include <linux/mm.h>
>  #include <net/net_debug.h>
>  
> @@ -267,4 +268,23 @@ static inline unsigned long netmem_get_dma_addr(netmem_ref netmem)
>  void get_netmem(netmem_ref netmem);
>  void put_netmem(netmem_ref netmem);
>  

[..]

> +#define netmem_dma_unmap_addr_set(NETMEM, PTR, ADDR_NAME, VAL)   \
> +	do {                                                     \
> +		if (!netmem_is_net_iov(NETMEM))                  \
> +			dma_unmap_addr_set(PTR, ADDR_NAME, VAL); \
> +		else                                             \
> +			dma_unmap_addr_set(PTR, ADDR_NAME, 0);   \
> +	} while (0)

Any reason not do to static inline instaed?
