Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA6935DCEE;
	Thu, 22 Jan 2026 16:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769100775; cv=none; b=krMovMhB+VkqUzL+fpa5D+F/I9Wk2Hur1amzSjcBVlPZd2PBiqYN6jufDBx/YQnR590tkXpihiTdKMMS+XLES32COid6QaPOvbGriUUnGrR5eWT8gLQr4vCb/jqcSAhCnDQ4vGz2RMcecx20hpxvFQatd7ARCu1dnZm7JCGWSQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769100775; c=relaxed/simple;
	bh=psjr5AisREuV15xHE84c9dYu6GkG7NdkTjHqKjbkyuU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k+ap/P1zTnZSTVLuJpJPwpo20W212YvOWHIfHSLnrcot/yoWwV+572yPQq3MwJ/Pp0uFGZglPvqRJJhkqUNT7F+WhInvIVbiLjr+iOGf1otqAlShF5l6I9TsOX53zwR4obn8Q7Hh0zDqxVFfCIbeNahsqSf5eabJ8dXYp4mQjjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czLgxvZH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czLgxvZH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B77C116C6;
	Thu, 22 Jan 2026 16:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769100775;
	bh=psjr5AisREuV15xHE84c9dYu6GkG7NdkTjHqKjbkyuU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=czLgxvZHkUY1gXv7zJaBck2lK8TCVng8prVA75Hhc8S8cCGPN2EQ6ncCZdbFYVnyf
	 2HEFsymXnLb3M4FmvVMyo13YB03tPrk3X1iwR2widB44oU2kAa1UjnP9LpUU6x1D9t
	 LwUumYqPNmNs7KBf1ndMgxnIcFctINOIqN32WjtNSuPU3MutW25vGZOvUk6+ReTIl0
	 62ArP4qIfiVA0zFbgSztyr51W2Gh+VxA8Cksm0ReSg30pNDmR4nGZStVErsMMD8BsG
	 BENFPcntMHoC/13dnRlAGjyIqh32MwzJRGK9YgBsGY6Kqe8RtQ5a0xwjrSMGwiaXqQ
	 hVJ4uy23y2PBg==
Date: Thu, 22 Jan 2026 08:52:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Srujana Challa <schalla@marvell.com>, Willem de Bruijn
 <willemb@google.com>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, pabeni@redhat.com, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, ndabilpuram@marvell.com, Willem
 de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next] virtio_net: Increase RSS max key size to match
 NETDEV_RSS_KEY_LEN
Message-ID: <20260122085253.33b93921@kernel.org>
In-Reply-To: <CANn89iL5s+egLhothNtnQf0jtAeftezUjNmbuXtUWgfVV3+bzg@mail.gmail.com>
References: <20260122091527.339180-1-schalla@marvell.com>
	<20260122075206.504ec591@kernel.org>
	<CANn89iL5s+egLhothNtnQf0jtAeftezUjNmbuXtUWgfVV3+bzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Jan 2026 17:13:55 +0100 Eric Dumazet wrote:
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

Just wanted to put that option on the table, it wasn't clear to me what
the exact use case for the sysfs file was. Good to know that someone
cares :) thanks for the reference!
