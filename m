Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E386D44C8B;
	Mon, 11 Mar 2024 15:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710171813; cv=none; b=JdLzoSJ1GwbFP/meHE57unqx01mcgCdJ9IO0AWFiVpO+c+ntRC75USK36IeTJleVJsZkmdDO8B6gEjQuclZVqcMJGYRcdKQMOmNb38xvApPvu18mqIJpQePxPhwlRDDBFQtQcYZ8Hn/+b4vvBN2129x87hEFyJ1z+SJHLlVZa40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710171813; c=relaxed/simple;
	bh=tVOUm4eBVB9aa7asbkuZKPYMDmrBZ5Abtdilf3V/dgo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ACLUa+VL47SOxK1bGcEfxcm9hCY9S0OHeAGDMGepaU61a1LSrIAJu+bVuY5/N6djsYFIxhXaA/mZldSb9DaqckYCrSgTorEh7y17axUucNe025IXMSwnvHNqnzynUgoDggnU1Y1SNMN2pIJeRHGRFOFfsKd+519n9VtQDgF0NTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfEidXTQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfEidXTQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDD0C433C7;
	Mon, 11 Mar 2024 15:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710171812;
	bh=tVOUm4eBVB9aa7asbkuZKPYMDmrBZ5Abtdilf3V/dgo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RfEidXTQetRSbMXgWssHizfLrZiVhVW1Xsk3m0k9UZgijOl/4B9DVQQlgv1QlONiw
	 ZPbGk+NXXwcvPSqq7L2uA5oAvsqnkg9UxzAnASL+yqfrwPiqnmfJjPNUCQILJRuQLY
	 xkevEEslcpr3sk9zqFGPqvZdBN9mCKQJeIbJCKxZpC2JLRKvQCnq1Rct+1jY/rZDIy
	 KO8q0dNtm36f/4XGVxeKnGAvf1b5RQOdRIHQGYv6n3/5MqW9Rvg8qvSxgVCjAnnXME
	 iUNCQI0p0b2Cmi5pLI++EDRFPGPkiWm39CcJ3tNsYMmVqYDoDBhIQvfr5FkXjSOAJS
	 7EEwmR/ikn/PA==
Date: Mon, 11 Mar 2024 08:43:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason 
 Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric 
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Tariq Toukan <tariqt@nvidia.com>,
 Michael Chan <michael.chan@broadcom.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: Re: [PATCH net-next v3 3/6] virtio_net: support device stats
Message-ID: <20240311084330.47840d50@kernel.org>
In-Reply-To: <1710154125.7529383-1-xuanzhuo@linux.alibaba.com>
References: <20240227080303.63894-1-xuanzhuo@linux.alibaba.com>
	<20240227080303.63894-4-xuanzhuo@linux.alibaba.com>
	<20240307085021.1081777d@kernel.org>
	<1710154125.7529383-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Mar 2024 18:48:45 +0800 Xuan Zhuo wrote:
> On Thu, 7 Mar 2024 08:50:21 -0800, Jakub Kicinski <kuba@kernel.org> wrote:
> > CC: Willem and some driver folks for more input, context: extending
> > https://lore.kernel.org/all/20240306195509.1502746-1-kuba@kernel.org/
> > to cover virtio stats.
> >
> > On Tue, 27 Feb 2024 16:03:00 +0800 Xuan Zhuo wrote:  
> > > +static const struct virtnet_stat_desc virtnet_stats_rx_basic_desc[] = {
> > > +	VIRTNET_STATS_DESC(rx, basic, packets),
> > > +	VIRTNET_STATS_DESC(rx, basic, bytes),  
> >
> > Covered.  
> 
> About "packets" and "bytes", here is coming from the hw device.
> Actually the driver also count "packets" and "bytes" in SW.
> So there are HW and SW versions. Do we need to distinguish them?

Yup, there are already separate counters defined for SW 
and HW packets / bytes. For the feature specific counters
I don't think we need to have both SW and HW flavors defined.
But for pure rx / tx packets / bytes users may want to see both.

> > > +static const struct virtnet_stat_desc virtnet_stats_rx_gso_desc[] = {
> > > +	VIRTNET_STATS_DESC(rx, gso, gso_packets),
> > > +	VIRTNET_STATS_DESC(rx, gso, gso_bytes),  
> >
> > I used the term "GSO" in conversations about Rx and it often confuses
> > people. Let's use "GRO", so hw-gro-packets, and hw-gro-bytes ?
> > Or maybe coalesce? "hw-rx-coalesce" ? That's quite a bit longer..  
> 
> GRO may also confuse people.
> 
> I like hw-rx-coalesce-packets, hw-rx-coalesce-bytes.

FWIW the HW offload feature in ethtool -k is called 'rx-gro-hw',
but we can use "hw-rx-coalesce-*" and mention the feature in the
documentation.
