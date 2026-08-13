Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952041F8691;
	Thu, 13 Aug 2026 01:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786585746; cv=none; b=Ib5YE0Drm2rkWKT5LtRbwrSRX+5uzgXEXZ5ilv2QnfoTgaTxQxL6Nl8ezqTsZy42Ggy3IdfjkEsv5uGeQBn1HIQnCE42OETbiXp+SbhV9GRKZjSiqAyhPZK+0qJMo2zMdlI7tttuoWAMzQLWcEEjaHKv8Ha/47yx/sh5+UyBBMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786585746; c=relaxed/simple;
	bh=0U680LeW7vTkGON73EYi1Tv5zWSqI/1M9rs/m0IQK34=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HOJPrcwmjWt6eIsJfml77t2nO8u8SL6IaKRgGlu3D/ZBAb4ExDD3NBfsppqwgMlu6UppH3niqlEZO7X0bUbhPv9oY6zzQux+WXyuLCUJif5s/ISoZKrYj692DMOoGUGKIXKC2NXyaOFYAOlTIDKcUrCeD1iSikL8uM7m4UlDOac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VU8sFSYT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VU8sFSYT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AD81F000E9;
	Thu, 13 Aug 2026 01:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786585745;
	bh=3FIfmdBDj7y+E80KXVO9Y5kFPzVxznZnfzd+5WDpN50=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VU8sFSYTyyJ9taU34+yR09PRUP6H26nUPsjJP/B6eD5BlDU+e/pLaE6UXWM241+1y
	 5JUWnVOpLqlIXlLHs0xRfUUqenPDK6Mi8jla98zBFjPV8Oo4Vi0B3OFYDW14DUSjZf
	 HrA9zLYMRmXqaGvto9GF4XywBeNEHFRESK9wrE9kE3mzdznKyntjYcLtOuvCsC18MH
	 hrQqvKk1jA0IAgzCzg89ZywKhcDYpZQsHvm/DVuTcQeFa8fZAzRCmsmq9CnLXxGZWt
	 g5GylIdjqYKII0RoL86PIAjYzsM8AJwECPA75ORicPqArMEJzWyDNp4sCMZon10yI1
	 dp7YWhMoNrWng==
Date: Wed, 12 Aug 2026 18:49:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xiong Weimin <xiongweimin@kylinos.cn>
Cc: netdev@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowangio@gmail.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] virtio_net: refuse XDP queue shrink while
 AF_XDP is bound
Message-ID: <20260812184904.50dda8ac@kernel.org>
In-Reply-To: <20260807013220.2130441-2-xiongweimin@kylinos.cn>
References: <20260807013220.2130441-1-xiongweimin@kylinos.cn>
	<20260807013220.2130441-2-xiongweimin@kylinos.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Aug 2026 09:32:20 +0800 Xiong Weimin wrote:
> virtnet_xdp_set() can lower curr_queue_pairs when an XDP program is
> detached.  Unlike ethtool channel updates, that path does not check for
> AF_XDP zero-copy pools on the queues being dropped.  A pool can remain
> bound on a qid that is no longer covered by curr_queue_pairs, which
> breaks later unbind and can leave stale rq/sq->xsk_pool pointers.
> 
> Refuse the shrink with -EBUSY while any AF_XDP pool is still bound on a
> queue that would become inactive.

This is really odd. The extra XDP queues should not be visible to the
stack and therefore to AF_XDP. AF_XDP and XDP only share the name for
"marketing reasons", they are distinct things.

We should try to prevent this oddity and prevent the XDP queues from
being exposed to the stack. let's see if anyone complains.

The patch as posted is only going to create problems further down the
line, the stack assumes that XDP detach can never fail.
