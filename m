Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45B6539C;
	Mon, 13 May 2024 15:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715613854; cv=none; b=QIX/XiB+tFzJ6o7I9dD5GRw0K0bnOSmF9p7SmSp8Uw01fLW5f5RHAu6kwIgRMty9qW+PaPFnuju//yDmaRZbVg6kyaLJWporyV38+Hy6dnKRrbPeU4fRoDPparRJo3YR9VzO6qX+OTFQJZJdBwGy6zWzu7Ym5oKgHD/fwnfoQRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715613854; c=relaxed/simple;
	bh=BcO42AIw8mo5P5+wktc4jRATWiDSkrrN2JRiiYqFvsY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sz8u4Kph+eBiPB5edoA2Y04Es+HsNo4VOl8V7Cq9l5t1+Lmi1HNiWhy3hoDd5UBVg2YYw3vFRd8iwiryQoA+2MHGe/y9GtH77WGRHNnGhyJuIdByuwSWruw8okz3jwjue+w8dXaMTAzdx8TbIB4N7NljCRXeAnHXrk1pm4JFK24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhLdQ2Ug; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhLdQ2Ug"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE8EC113CC;
	Mon, 13 May 2024 15:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715613854;
	bh=BcO42AIw8mo5P5+wktc4jRATWiDSkrrN2JRiiYqFvsY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GhLdQ2UgHNg7HTNWnyl+NvUzvPP6xLJjBMtuUDcho6j8QcOEoF6R8Fbpn8vATJ5Iz
	 Efe+ErQ4NNcOW9rWGw//opXPmcxvxsk3d8QiTMo4cDuxbPZ6D67YCKBbWlOI/a8OsT
	 CjzotsSbWCL2Zp0E8Jdb7rh48vhD/XSvn6IBIZUCJNXZlbHWS14JkakvQqwq0n2pgt
	 bSJWIhPceV2HtyWfWd1tLHJwsaWcXNJB4BNClG872N1wtmPxQ0DJsfHgTnLKGZgoGX
	 ZvX5S52kZdHaJliMixWlJ3G8zBq3M3ZHNiEdbCDEcwfCpAUoQSqUh3qXau+aBeHktt
	 B2IVquzfMxEmA==
Date: Mon, 13 May 2024 08:24:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, "David S . Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Jason
  Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Brett
  Creeley <bcreeley@amd.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Tal Gilboa <talgi@nvidia.com>, Jonathan 
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Jiri Pirko <jiri@resnulli.us>, Paul 
 Greenwalt <paul.greenwalt@intel.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Kory Maincent
 <kory.maincent@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 justinstitt@google.com, donald.hunter@gmail.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v13 2/4] ethtool: provide customized dim
 profile management
Message-ID: <20240513082412.2a27f965@kernel.org>
In-Reply-To: <1715611933.2264705-1-hengqi@linux.alibaba.com>
References: <20240509044747.101237-1-hengqi@linux.alibaba.com>
	<20240509044747.101237-3-hengqi@linux.alibaba.com>
	<202405100654.5PbLQXnL-lkp@intel.com>
	<1715531818.6973832-3-hengqi@linux.alibaba.com>
	<20240513072249.7b0513b0@kernel.org>
	<1715611933.2264705-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 May 2024 22:52:13 +0800 Heng Qi wrote:
> > > So I think we should declare "CONFIG_PROVE_LOCKING depends on CONFIG_NET".
> > > How do you think?  
> > 
> > Doesn't sound right, `can we instead make building lib/dim/net_dim.c  
> 
> Why? IIUC, the reason is that if CONFIG_NET is not set to Y, the net/core
> directory will not be compiled, so the lockdep_rtnl_is_held symbol is not
> present.

Maybe I don't understand what you;re proposing. 
Show an actual diff please.

> > dependent on CONFIG_NET? Untested but I'm thinking something like:
> > 
> > diff --git a/lib/dim/Makefile b/lib/dim/Makefile
> > index c4cc4026c451..c02c306e2975 100644
> > --- a/lib/dim/Makefile
> > +++ b/lib/dim/Makefile
> > @@ -4,4 +4,8 @@
> >  
> >  obj-$(CONFIG_DIMLIB) += dimlib.o
> >  
> > -dimlib-objs := dim.o net_dim.o rdma_dim.o
> > +dimlib-objs := dim.o rdma_dim.o
> > +
> > +ifeq ($(CONFIG_NET),y)
> > +dimlib-objs += net_dim.o
> > +endif  
> 
> 1. This is unlikely to work if the kernel is configured as[1]:
> 
> [1] kernel configuration
> CONFIG_NET=n, CONFIG_ETHTOOL_NETLINK=n, CONFIG_PROVE_LOCKING=y,
> (CONFIG_FSL_MC_DPIO=y && CONFIG_FSL_MC_BUS=y) select CONFIG_DIMLIB=y.
> 
> 
> Then, because CONFIG_NET is not enabled, so there is no net_dim.o,
> the following warning appears:
> 
> ld.lld: error: undefined symbol: net_dim_get_rx_moderation
> referenced by dpio-service.c
> drivers/soc/fsl/dpio/dpio-service.o:(dpaa2_io_dim_work) in archive vmlinux.a
> 
> ld.lld: error: undefined symbol: net_dim
> referenced by dpio-service.c
> drivers/soc/fsl/dpio/dpio-service.o:(dpaa2_io_update_net_dim) in archive vmlinux.a

Simple, dpio-service should depend on NET if it wants NET_DIM
