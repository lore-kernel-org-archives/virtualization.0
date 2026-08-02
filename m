Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF1735A387;
	Sun,  2 Aug 2026 09:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785664513; cv=none; b=E/4grgxhV/zpC0HvdUp3HZmFw7PZqYJGTIJimr/k2m5eXuA+LrALsOGlwoYib3bH+wpzSDZ2Qr77hbwY4fvaUMYoN+ai0jdPK7UxtuxFDioDm9IOZ5Dd5x69F5XLqn/Q5MS/6MpJPhRCM41KRSNdOSy00t8NkeekhT8TeEfZPGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785664513; c=relaxed/simple;
	bh=XPT39FKVPO0EvbM9Yeiz1z5zRRqQL2CAlUK9GhiHb/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PPGykzs7/W8HkXIyU3vx4irxrFTuHpgkb5h4D6bmPYQ+lYdAhHwv1bJFVSfBr394a/kDtDK0z2q4gtWbMiLbOWPsJzLoU9MuluyPHP+KFsyqxsFfMGQoWt/bNpkfrlt5MIkUc0g9ex+aT4/FrTgv/xu57TobZehLhsCUHArgLQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=I2ljNp/n; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="I2ljNp/n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
	s=unimail; t=1785664300;
	bh=XPT39FKVPO0EvbM9Yeiz1z5zRRqQL2CAlUK9GhiHb/4=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=I2ljNp/nwBlo4CUWnHQkHGvqYf3MsZTOjj6DG+xpC0kBo7QX+T4pTYE2tpx5P9+Ha
	 p8KPlVh+GeDvp0HJMxeDVkyphtkVcCH0/FifEavxSluWyTaw2RBFZiJiD+0JhKqUxZ
	 5whzJ6mKrx/lImYRptYExFE0actV4TXuZbSWwSmw=
Received: from [IPV6:2a01:599:313:73d7:25e8:a683:3a9b:5cb2] (tmo-121-3.customers.d1-online.com [80.187.121.3])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 6729pYCN019221
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 2 Aug 2026 11:51:34 +0200 (CEST)
Message-ID: <3d7a5938-31ce-48ab-bf96-568f501cd7f9@tu-dortmund.de>
Date: Sun, 2 Aug 2026 11:51:33 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 0/5] tun/tap & vhost-net: apply qdisc
 backpressure on full ptr_ring to reduce TX drops
To: willemdebruijn.kernel@gmail.com, jasowangio@gmail.com, jasowang@redhat.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, mst@redhat.com,
        eperezma@redhat.com, leiyang@redhat.com, stephen@networkplumber.org,
        jon@nutanix.com, brett@librecast.net, corbet@lwn.net,
        skhan@linuxfoundation.org, tim.gebauer@tu-dortmund.de,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux.dev
References: <20260730213639.726381-1-simon.schippers@tu-dortmund.de>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <20260730213639.726381-1-simon.schippers@tu-dortmund.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/30/26 23:36, Simon Schippers wrote:
> This patch series deals with tun/tap & vhost-net which drop incoming
> SKBs whenever their internal ptr_ring buffer is full. Instead, with this
> patch series, the associated netdev queue is stopped, but only when the
> new IFF_BACKPRESSURE flag is set and a qdisc is attached. Without the
> flag, or if no qdisc is present, the existing behavior is preserved. The
> XDP transmit path is not affected. This patch series touches tun/tap and
> vhost-net, as they share common logic and must be updated together.
> Modifying only one of them would break the other.

Sashiko found valid regressions, even though the code stayed the same.

I will address them and send a v14 soon.

