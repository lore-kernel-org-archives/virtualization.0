Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794338832;
	b=zSEQfWg3uONwmx0Q5NnUpKpMYwMmn7gMGivghm3jyArvK7WDrNxBNxi2TADcMi285ltT
	 nWMaI4WjPHflopDzMniNoN46gLQUG/igul4v6TBF27ExFe7czi+wQx8HtN8vxsGYfN9hz
	 DQ4gvLQOd+V56lLp/RRMCDlGVud+kigQ8OwWqie4AQ4nD6ZEdtnZtOUcHHHWLKoORxGkb
	 RevJm4Jarg0Y6sz4MPgHSGxqY3j4DhmJ7189TmBFy4nGzDYsNF7Z2ZeVCATYeBxVuLCGA
	 i3Y7iQZfmRCzdESx8l4M0nwVsJRm3CPJIs4rGhYfbr200A+5y3L+93QKxOOrZh5ZUGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338832;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ODatzweUCW7o26hwhl5kE9FWoziqlEwZz6tErIYcf3Q=;
	b=dBgrQVsNx4bf8xaTqG6NU2AGF8Z7AvxQmVJSAm1Yl6sChKsKLfeUk+iwavHmYbVdbw0K
	 mlEh2ENfheAnUJXYir+eOR7XuTwo3uqyOHZM3aKqpsT6pIPzL8cLaNW59zBWKjBSrqtYy
	 3xkeAHcy98Izvjre5m803/7D+EXGsQA+0z56LE/zLQH65lEmCey0MYu0gvk0Qbrs5FJEC
	 bTPKH6VfSd2tMIDjTBQH84JWsE0VZ/RYIQ9zd8pbOelEjFG8QU5w7p/+ytXC2fqejBC4K
	 zjQY6+vZN8rs0KD1QatkELR/r4yvqvENDWeifiy3jsY+m+4GRPNoFWNkQquqNDgCRzw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=axFxc57Y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D96606A326
	for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 19:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0D96606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=axFxc57Y
Received: from ratatoskr.pengutronix.de (unknown [IPv6:2a00:1f:f805:2b01:a03:2f4:308a:7b52])
	(Authenticated sender: str@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 8BD0E201F43;
	Tue, 10 Nov 2026 20:27:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794338824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ODatzweUCW7o26hwhl5kE9FWoziqlEwZz6tErIYcf3Q=;
	b=axFxc57YGOskhC2HI2z4xDSvzgCtzuAXY8Knr9qFzsc+a7wrW8VAQx/IsBszC7lven9owS
	2FfsB78fRdwzNe47fV2HcPaI0iWunzz5ZMUGJc2mr4/dy6FWo8ACnpoMxBeA/6pKKhXJUR
	QB3+86oOjzX81gKVi130N9q1McuVWktylsu+C1gXCgXIQDDDEPPptbQn6t6JuUcyf5BOE4
	rKPfn33jjKEZPYEw6ihaClJbFpa9kvhDCCqrhWT9o6YQO3z3EP83rBubBfgXjyfPN2jINo
	NDFYV+f8O4KudinwcrmPWIyVTtNnn033e6cTBF8QesUYgkucwN+v2YtOz+SXIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794338824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ODatzweUCW7o26hwhl5kE9FWoziqlEwZz6tErIYcf3Q=;
	b=BuwLSFTXEPbgZoXPmMfP847UiDdg7yfDag5qeRedm6DCAisISY+tAM3ib9uJL4DxX+esnL
	UcBIrds43eOXIbYN7JjoIqbYjk4eKlPgP+FebysRP8HEGfHmg2ycjF2biXZEnolOYSVAE3
	/i8EdUzhzUue/XFv6aUoSDDK17iwNsGl/uZT11NPJOfp5zNEDiUmqMXI/QET/lFq8S8ys2
	J+SFA/7woz09hIdZqXi71fQ4Z1jhE7gvLXvkjy3VT7kwq3QamOH+D5JYCJoFx81dbKRNyX
	SMoAygzG2W/5j1E0sCrtBN7LYbyUmvkphAhjmRkN8Q3ZMh+cFaiyWcpw8Cis7Q==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794338824; a=rsa-sha256;
	cv=none;
	b=VP+KPQ5a7GMBOJPnXBnWZlwAKh3chavc2oaAqwJmKA6Me6u1CuToWDrd0RMFVCdEPgwjDb
	WYEG6EhF6UgqsEk7/lKNVmEajmnuzmlhyx3UCrzdBqz/P4M3oU2csBLGv1nzZ1ABCfApN+
	DA5gGKCqUBokK5qbDEaDBpJlQXjBYs+O/OeqXvmjFBqbEa83bTUcI0vZ+kcU5ZZ726Df6m
	Awfrcmmy/VJT8poW8tYP3PEU1kmUeLJ/JhMLw9EfHh12unTwm2mxUs4nk8YJOf7XZ4xE47
	krNeN+kXbw6/OEJauq2nn4qBSTWYxRQhLBig3Y1jGv29PGIe0DOepYTHrmGfXA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=str@pengutronix.de smtp.mailfrom=s.trumtrar@pengutronix.de
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,  Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>,  "David S. Miller" <davem@davemloft.net>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  Richard Cochran <richardcochran@gmail.com>,  Andrew Lunn
 <andrew+netdev@lunn.ch>,  Eugenio =?utf-8?Q?P=C3=A9rez?=
 <eperezma@redhat.com>,  Jason Wang
 <jasowangio@gmail.com>,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Jesper Dangaard Brouer
 <hawk@kernel.org>,  John Fastabend <john.fastabend@gmail.com>,  Stanislav
 Fomichev <sdf@fomichev.me>,  Eric Dumazet <edumazet@kernel.org>,
  virtualization@lists.linux.dev,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  bpf@vger.kernel.org,  kvm@vger.kernel.org
Subject: Re: [PATCH RFC v4 5/6] virtio-net: add XDP rx timestamp metadata
In-Reply-To: <willemdebruijn.kernel.9c17365c41b3@gmail.com>
References: <20261026-v6-7-topic-virtio-net-ptp-v4-0-008af03cd43b@pengutronix.de>
	<20261026-v6-7-topic-virtio-net-ptp-v4-5-008af03cd43b@pengutronix.de>
	<willemdebruijn.kernel.9c17365c41b3@gmail.com>
User-Agent: mu4e 1.14.3; emacs 31.1
Date: Tue, 10 Nov 2026 20:27:04 +0100
Message-ID: <87pkwczdvb.fsf@pengutronix.de>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2026-11-01 at 10:12 -05, Willem de Bruijn <willemdebruijn.kernel@gmail.c=
om> wrote:

> Steffen Trumtrar wrote:
> > For the skb, the timestamp is read from the header before the XDP
> > program runs, so XDP_PASS keeps it even if the program changes the
> > packet. XDP therefore works with rx timestamping enabled.
> >=20
> > Add xmo_rx_timestamp so XDP programs can read the timestamp with
> > bpf_xdp_metadata_rx_timestamp(). It returns -ENODATA if timestamping
> > is not enabled or the device did not timestamp the packet. Install the
> > metadata ops also if only VIRTIO_NET_F_RX_TSTAMP is negotiated;
> > rx_hash returns -ENODATA then.
> >=20
> > Like virtnet_xdp_rx_hash(), the callback finds the header relative to
> > xdp->data, so it has to be called before bpf_xdp_adjust_head().
> >=20
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > Assisted-by: Claude:claude-opus-5-5
> > ---
> >  drivers/net/virtio_net.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >=20
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 23af10c613b48..e79b65653fad7 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -6848,8 +6848,30 @@ static int virtnet_xdp_rx_hash(const struct xdp_=
md *_ctx, u32 *hash,
> >  	return 0;
> >  }
> >=20=20
> > +static int virtnet_xdp_rx_timestamp(const struct xdp_md *_ctx, u64 *ti=
mestamp)
> > +{
> > +	const struct xdp_buff *xdp =3D (void *)_ctx;
> > +	const struct virtio_net_common_hdr *hdr;
> > +	struct virtnet_info *vi;
> > +	u64 tstamp;
> > +
> > +	vi =3D netdev_priv(xdp->rxq->dev);
> > +	if (!READ_ONCE(vi->hwts_rx_en))
> > +		return -ENODATA;
> > +
> > +	hdr =3D (const struct virtio_net_common_hdr *)(xdp->data - vi->hdr_le=
n);
>=20
>     Reading `hdr->tstamp` in place from `xdp->data - vi->hdr_len` violate=
s the XDP
>     metadata area contract (`Documentation/networking/xdp-rx-metadata.rst=
`: drivers
>     must copy device-reserved metadata out of `[data_hard_start, data)` b=
efore
>     presenting the frame to XDP) and breaks standard XDP metadata consume=
rs:
>     - `hdr->tstamp` sits at `[xdp->data - 8, xdp->data)`. Standard XDP pr=
ograms=E2=80=94such
>       as `tools/testing/selftests/bpf/progs/xdp_hw_metadata.c`=E2=80=94ca=
ll
>       `bpf_xdp_adjust_meta(ctx, -(int)sizeof(struct xdp_meta))` first, in=
itialize
>       fields in `meta` (e.g. `meta->hint_valid =3D 0` at `[xdp->data - 4,=
 xdp->data)`),
>       and only then call `bpf_xdp_metadata_rx_timestamp(ctx, &meta->rx_ti=
mestamp)`.
>       Initializing `meta` overwrites `hdr->tstamp` (and `hdr->hash_v1_hdr=
`) before
>       this kfunc runs.
>     - Calling `bpf_xdp_adjust_head()` before reading metadata also shifts=
 `xdp->data`,
>       reading arbitrary bytes at `xdp->data - vi->hdr_len`.
>=20
>     Wrap `struct xdp_buff` in a driver struct on the stack (`container_of=
`, and in
>     `struct xdp_buff_xsk`'s `cb` verified with `XSK_CHECK_PRIV_TYPE()` fo=
r AF_XDP,
>     matching `gve`/`igc`/`ice`/`mlx5`) and stash `tstamp` (already extrac=
ted in
>     `receive_buf()` and `virtnet_receive_xsk_buf()` before XDP runs) and =
the hash
>     fields before `bpf_prog_run_xdp()`.

Agreed, Sashiko complained about the same thing. I'll stash the
timestamp in a wrapper around xdp_buff before the program runs.


Steffen

--=20
Pengutronix e.K.                | Dipl.-Inform. Steffen Trumtrar |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |
