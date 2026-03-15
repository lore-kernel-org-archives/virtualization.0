Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3591D7995;
	Sun, 15 Mar 2026 01:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773537165; cv=none; b=l30lVvoyG4M3lI72HS7uqy9QVF6319Cp1+Oyuao/EjldmizYSnyC+v22/H2oY6n/62vA5Wc3FZlGbUe+xPDF/4PoJfV/nxp5ic1fYL5qRnKV7dsDdVNAq9FWm8eST0odqStiWk6hZTrj5k7HDwHko+6eY+MA72ijO2BScnlTL7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773537165; c=relaxed/simple;
	bh=JAs/1nlYTkYCSuyox/Z4p/qg35k7HFn5402MuhdAo3g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AnD2/JXwCPxdzKQRkM7Jr62d+YW1CdXvQgijjTtbsDCFJ5J9mc1kunZ0cROSygi/tFm7Bg3y8auPekG3jg5TyW8fVEUq73iJwcM9P006PbMqjH+NrI/A411Nk8mvsyPkSFjzqz45xxg15e8kMJemGkDJmmI749O+lJsG291TaFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdJGaiPB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdJGaiPB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31517C116C6;
	Sun, 15 Mar 2026 01:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773537164;
	bh=JAs/1nlYTkYCSuyox/Z4p/qg35k7HFn5402MuhdAo3g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SdJGaiPB8kA5VjEf+HBii1iPWqlVB7gSwv1gRkXcjcRaA4X4OKNCqrYHtzVEjwt/2
	 W3mkfCxb+FPk1cKpiwjN0HxpK3XsF9DD9Y/VsaHRx7MiS/WtoDi+/R7ncZnOiyfESU
	 jkkIE6Xo2rS9Y9HoPkCPfa9k1TC2paVUmx34NFKhFJoiPKssfm2cxW64dYwsc/2Krw
	 p5kWl6r01Or1MCuoSW1i3tykayDGqvfGxmf3YqN3poJxvIycu4cS9nEUkslBpbm/Ws
	 En1AzOmiQrz5sBBZh5U9qu/4vtXcNtWD/5orhm6a3wX9K8vT+/Fa2a/gK7WpPmZOJe
	 ru63pHsk7191w==
Date: Sat, 14 Mar 2026 18:12:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: xietangxin <xietangxin@yeah.net>, "Michael S . Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v2] virtio_net: Fix UAF on dst_ops when
 IFF_XMIT_DST_RELEASE is cleared and napi_tx is false
Message-ID: <20260314181243.177d4ab4@kernel.org>
In-Reply-To: <CANn89iJHp+nCcAo7tzMTfH5yW2qDsEXP_u=RzdV=DC9ZvDH9Fg@mail.gmail.com>
References: <20260312025406.15641-1-xietangxin@yeah.net>
	<20260314124017.59206dac@kernel.org>
	<CANn89iJHp+nCcAo7tzMTfH5yW2qDsEXP_u=RzdV=DC9ZvDH9Fg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Mar 2026 21:11:33 +0100 Eric Dumazet wrote:
> > On Thu, 12 Mar 2026 10:54:06 +0800 xietangxin wrote:  
> > > Fixes: f2fc6a54585a ("[NETNS][IPV6] route6 - move ip6_dst_ops inside the network namespace")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: xietangxin <xietangxin@yeah.net>  
> >
> > The Fixes tag should be:
> >
> > Fixes: 0287587884b1 ("net: better IFF_XMIT_DST_RELEASE support")  
> 
> I disagree
> 
> What was the situation before this patch ?

My thinking process was that it's fairly unusual that the dst is kept
because the stack decided so. Normally its the device driver that asks
for dst to be kept when its xmit is called. I thought 0287587884b1 was
the first time when stack could make the dst decision behind device
driver's back. But my analysis was very shallow, could well be wrong.
