Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E677BB15
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Aug 2024 14:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724682304; cv=none; b=PJLZDDrAwSU6Ks6z7AtBDasELpkkR9DAUJSjugi4g4jk0a4Tjze2XWw4Zuomo0KZ2set4xuyH6SU+ZLikQE5rwttJybFUug8YDRvlba8gILgtHQDqw+hnENUtEsqy8C+XwxaZ4LtxhZLjqOJg8KiqhpPoEbc1KTGXi8OD0hTUW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724682304; c=relaxed/simple;
	bh=bG8kqaZxngIAfDrMIMUCTanhr4CBigPaB0e+Hac/i1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRjHJYh+Tn6vwNe4h5JHSjdqEor2DeGQNM2alRyInQRuvf/kTQsr/8+0iJyutOs/a1aVkP4bA0+clZFkkErfYdeefkQogz6/ER5ngBAv7LBh9d7gQB4lbPiA6pKFMndlYRgSkBIqveSGHP6/abS+jJuyrZw1y7JLIuXQIcIA5CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jO7LpLJA; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jO7LpLJA"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9189040413
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Aug 2024 14:25:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wOpe27qy52AS for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Aug 2024 14:25:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2F09740347
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2F09740347
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=jO7LpLJA
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2F09740347
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Aug 2024 14:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+sTEWQlm/SIizE6LJlOZ3JYq0RVnDt1LZfmj/BC5RB0=; b=jO7LpLJA4NNzbuer2wrKsZaSJp
	N8O/fhhbXaaWUXDuqOw9+S9WY9y2HoRLy8S5mBKDfXpp8aybfGfaGmLeUg34FRupkTSTtd5KRrZCv
	PwD8qj1gIy94sYlhyorR2slWqZUf83DtYSxr301zkx9lpdqJt9cYPdx5MWH5z0NSqa4o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1siaeI-005iS4-Q2; Mon, 26 Aug 2024 16:24:50 +0200
Date: Mon, 26 Aug 2024 16:24:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Carlos Bilbao <cbilbao@digitalocean.com>, eli@mellanox.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	eperezma@redhat.com, sashal@kernel.org, yuehaibing@huawei.com,
	steven.sistare@oracle.com
Subject: Re: [RFC] Why is set_config not supported in mlx5_vnet?
Message-ID: <fd8ad1d9-81a0-4155-abf5-627ef08afa9e@lunn.ch>
References: <33feec1a-2c5d-46eb-8d66-baa802130d7f@digitalocean.com>
 <afcbf041-7613-48e6-8088-9d52edd907ff@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afcbf041-7613-48e6-8088-9d52edd907ff@nvidia.com>

On Mon, Aug 26, 2024 at 11:06:09AM +0200, Dragos Tatulea wrote:
> 
> 
> On 23.08.24 18:54, Carlos Bilbao wrote:
> > Hello,
> > 
> > I'm debugging my vDPA setup, and when using ioctl to retrieve the
> > configuration, I noticed that it's running in half duplex mode:
> > 
> > Configuration data (24 bytes):
> >   MAC address: (Mac address)
> >   Status: 0x0001
> >   Max virtqueue pairs: 8
> >   MTU: 1500
> >   Speed: 0 Mb
> >   Duplex: Half Duplex
> >   RSS max key size: 0
> >   RSS max indirection table length: 0
> >   Supported hash types: 0x00000000
> > 
> > I believe this might be contributing to the underperformance of vDPA.
> mlx5_vdpa vDPA devicess currently do not support the VIRTIO_NET_F_SPEED_DUPLEX
> feature which reports speed and duplex. You can check the state on the
> PF.

Then it should probably report DUPLEX_UNKNOWN.

The speed of 0 also suggests SPEED_UNKNOWN is not being returned. So
this just looks buggy in general.

     Andrew
