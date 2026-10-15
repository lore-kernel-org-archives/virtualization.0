Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5F7525A76;
	Thu, 15 Oct 2026 12:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068936; cv=none; b=Jo5AIapjdDNWvHVmld9zVUTziq974r8CGgDpe5GaJX2A6FKVr7bZRrP2KyUvy2fbJHW1Q8fup4m2BcOnB/S43msKCqSYqdaY/DurWiIxq5akv9Qe8HgLbK+jpQHl2SCkX+wuMFlpov6lCa0QqFU9xnXQgGPfhIVoawKP6NluDmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068936; c=relaxed/simple;
	bh=1VL3ul+oyEqH/SBvPY1P3l7zVD9s1jUU5EEiHqlYnhE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CODgOYjSITQV829hQzExWbazQR9g1Ldhs7Tyi2UVD3OeUoLfbJHpAzf4ekXvD+pRqZH9SfhQ4v8p6Aojt/JUC9AWrhMhCF6OJIKQ0DeQNeBa7JzE7YwHy1TThq2Nc8CbktmtdPpW/6UjZXfqjnMuUC+L999SPPIPNgedALCLees=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=wHImKLHW; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wHImKLHW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zL4P1buyUO0HTa8tz5fIfgHMxvjhBM1cuXeP1N+bW10=;
	t=1792068935; x=1793278535; b=wHImKLHWjYOEFReQdzIl9jLd6b48Nsnes8s4ioAQnRsH1ld
	M08QoGB+/w7SF1ugXglUIHta+zD4ZdWkd+fu1NWAU+pNDRHmiu/k6C72wWsZWOfXvHfux0/j1N4vb
	eWRcEBrc3ifePfHbBjolTBFK86TKpwqaMZJ0+dotRCAxuV/6aoGNl5k+mZ6JspqXM9wenWEd7BsDA
	R8dD8DPRqlNu9ghObdeJl6QejWwVTNS1d4YLetEihADDCMa7KA7rUrK9AbsP07pa/mGeiyQHqzZ6t
	Ddj87I3sQkoYKDPVxgGUIfqJGLAW37BWcMWFCOHMs9z/mDg7kMXjiWJ7NdiAfSpw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xHKzU-00000003bXE-0Kyl;
	Thu, 15 Oct 2026 14:55:24 +0200
Message-ID: <64ee40b97fc447bbf3abb80250ad0d9f3cf3c6fa.camel@sipsolutions.net>
Subject: Re: [PATCH net-next v2 2/7] um: vector: honor virtio net hdr
 conversion failures
From: Johannes Berg <johannes@sipsolutions.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Willem de Bruijn	
 <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowangio@gmail.com>, 
 Eugenio =?ISO-8859-1?Q?P=E9rez?=	 <eperezma@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Andrew Lunn	 <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet	 <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni	 <pabeni@redhat.com>,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,  Rusty Russell
 <rusty@rustcorp.com.au>, Max Krasnyansky <maxk@qualcomm.com>, Richard
 Weinberger <richard@nod.at>,  Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
Date: Thu, 15 Oct 2026 14:55:23 +0200
In-Reply-To: <20261015085119-mutt-send-email-mst@kernel.org>
References: <cover.1792067836.git.mst@redhat.com>
	 <6716834884238de0ab1ab313004044122aa2adbf.1792067836.git.mst@redhat.com>
	 <8420ba1fe84fc7d105825026802d4ad10d44af71.camel@sipsolutions.net>
	 <20261015085119-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2026-10-15 at 08:52 -0400, Michael S. Tsirkin wrote:
> On Thu, Oct 15, 2026 at 02:47:01PM +0200, Johannes Berg wrote:
> > On Thu, 2026-10-15 at 08:41 -0400, Michael S. Tsirkin wrote:
> > > virtio_net_hdr_to_skb() refuses packets whose checksum metadata
> > > it cannot make sense of, but the vector raw transport ignored
> > > its return value: rejected packets went on into the stack with
> > > their metadata unvalidated.
> > >=20
> > > Propagate the failure.
> > >=20
> > > Assisted-by: LLM
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >  arch/um/drivers/vector_transports.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/ve=
ctor_transports.c
> > > index e1fb2a76fdff..8b7548458663 100644
> > > --- a/arch/um/drivers/vector_transports.c
> > > +++ b/arch/um/drivers/vector_transports.c
> > > @@ -210,7 +210,9 @@ static int raw_verify_header(
> > >  		return 1;
> > > =20
> > >  	skb_set_network_header(skb, ETH_HLEN);
> > > -	virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_endian(=
));
> > > +	if (virtio_net_hdr_to_skb(skb, vheader,
> > > +			virtio_legacy_is_little_endian()) < 0)
> > > +		return -1;
> > >  	return 0;
> > >=20
> >=20
> > Seems it'd be simpler to just
> >=20
> > 	return virtio_net_hdr_to_skb(...);
> >=20
> > As far as I can tell, the function only returns -EINVAL or 0 (never a
> > positive value), and the caller only cares about negative (error) or
> > positive (no checksum needed), so that'd be equivalent?
> >=20
> > johannes
>=20
> if raw_verify_header can safely return any errno - i did not want to
> audit it.

You already used an LLM and still didn't want to? ;-)

I checked briefly (by hand) and it seems fine, it's assigned to the
function pointer, which only has two callers on the _kern.c side.

johannes
