Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794311241;
	b=MfsFGt9xV/avmsCq+fCVIBJkft7fvNqUabJjcZuCr1opplScbmycmerAdRwKoTfJF1wH
	 uSQVgcIopcevwthR2LVSSOg6r76v2uwq24WM0lq0pWuhtqp2MMmDLHp3SPDqKWMJVvnC6
	 ut5a96WdN4oVt0nlTs9QHJhifO+v6zr82HDjmyoyLpwxPyMvJ3CLmkPXbdUvM28m2Zo5l
	 NSgQVPHwa7kiRuqWWpiLzKmfKkH+DPKQ99DVHddKFWisKVVUDuXEoVL76wZMD9/qVUwiI
	 dUCq0ASHdJSqTxBCqjrb8fikwgxfjK8IBVZezMxcnpfApFZ+iswW06QbpKyF2ig6j/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311241;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type;
	bh=q12MRiSZeyXmoo+5T0Mg9dGA+4+cznjBdzDiNfqHOTQ=;
	b=zyfzvSYh0DzT/H+xCUOLW58lyxIFQ7a/SvfKQYRSLdRpRd0GycJs4NtTWQWRZcSkpxfa
	 SxaKW185ldHnW5XYG5fbZZjNNYV7cnIj+0stNtkjrwTLqo5Rt870/SWdbS7X2GmGZ3JVj
	 ZRdOt0DPsk8c9rS+MeW1uCBDxIARoxMzsyL2LoIbdBqM0W2A7zOTfhsaLmYg1bzxPr3ky
	 J4VbCofoUYDAu8OjlHKLjqNyS369/zO4H1ldCtBqNOuU9wUrOUHkkIoR1Mfoch6mcKTqF
	 4txKpBgI4C+8fOWbgZHXmemjXtrVqAb9MqVfW5EpzAPOMWL+lB3ERjUJTdAD2Dv+srA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=LpURkmIl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97335606A321
	for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 11:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97335606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=LpURkmIl
Received: from ratatoskr.pengutronix.de (unknown [IPv6:2a00:1f:f805:2b01:a03:2f4:308a:7b52])
	(Authenticated sender: str@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3403F20087B;
	Tue, 10 Nov 2026 12:47:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794311238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q12MRiSZeyXmoo+5T0Mg9dGA+4+cznjBdzDiNfqHOTQ=;
	b=LpURkmIlZ2LRrROhU+IRV5IvjuyOzdFaYoSzofAzgfL5hEoabKG+YZ0xr9oAXzFFEybIub
	Bb3MD+LngnmhTIsTKSP8PEs3DysTOqP6+7S7jsqAG+IJhc5/A1dbAmjgaHLNs3fvb7bQYe
	Mgbjo8TY5EiIsmAU4zma5efjxgZUoxuhqZtYdj9GHECKXRfhXsPF658M62nwhiarScNuJ7
	MIffzUI2A+pisxwPn8H7Q6QyQTDxeWrgtvYdd3XsfQV7iuo0/b5nImItOVun3KeyTtyYyY
	r2VadY6EkRiw6G11Ap05QaCYgBB+UoIY+jcGfUIIKxOhUt5aeU8MHe08JfxRBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794311238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q12MRiSZeyXmoo+5T0Mg9dGA+4+cznjBdzDiNfqHOTQ=;
	b=NnrDYON0IoSe9qPdbH3EfN+Oagv5vcaBzhDgeDWRyoQX+4Xi9InHItlXmLGPz/YpEGxsJb
	kiMbii9v1qWTYpdSaMPBr8BbppUKmTn730IIIkPsSaTO0JjiujUwZdDiWIebB68wm6ef1K
	w0rJZYCoo5BS66DWlvu6wIyGHXe3D7qLAaEJokuax+Wqqs1UwPjvz25LO4o6OMglNb0mo6
	gsi88AUVjzLrIb0Sa68aZxrzQ5HJEqVsKBy/keSGzjzJCH3mzuLJN6CdDPxVxFqZY8CMZ4
	JXjo1YumwNvEWKvhe7HjlnL5v73t8YSSpGA2RDstaEbAU3CrZDGPfCK7nUkSzw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794311238; a=rsa-sha256;
	cv=none;
	b=SWAEBG8GR4oDdUdw7UC4IDZxkNUNrqrxB/JYmznZFGIR2Io6NrZsRF+PS2Z81ylYNtVVUH
	U5v6DEdRIrVBy8t+74FY1f6zqlfqiWkqc8W7GSsaxZggVw6MEbXoV4ns8hmtrgysL52EnD
	E2yAERx9NPzu30SL7tcQFW7VGSsiqIQCAUmrKp9B5HRcCT4MySo+b0mMhV4T/gqoynHdOo
	uZRLWs1vaXy6xbhin8l5eF4vHCIJL4VdOumjsLZv9uLgEdxkF1My+E4781Ew9Jn2ogpDP7
	fhEtASyIIsjO1e0Aweby+angdx8L+Z/F56wk/7ksE9NaWrB0OZuvFGBe+iZ3HQ==
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
Subject: Re: [PATCH RFC v4 0/6] virtio-net: add receive timestamp support
In-Reply-To: <willemdebruijn.kernel.1d6388f036c46@gmail.com>
References: <20261026-v6-7-topic-virtio-net-ptp-v4-0-008af03cd43b@pengutronix.de>
	<willemdebruijn.kernel.1d6388f036c46@gmail.com>
User-Agent: mu4e 1.14.3; emacs 31.1
Date: Tue, 10 Nov 2026 12:47:17 +0100
Message-ID: <874ido29iy.fsf@pengutronix.de>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain


Hi Willem,

On 2026-11-01 at 09:57 -05, Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:

> Steffen Trumtrar wrote:
> > This series picks up Willem de Bruijn's work on a virtio-net receive
> > timestamp. The device puts the time of arrival (TAI, ns) into the
> > virtio-net header so the guest can use it for PTP and RTT estimation
> > without taking the timestamp itself after the host-to-guest latency.
> > 
> > The series is an RFC. I am mostly interested in feedback on the
> > approach and on the wire format:
> 
> At a high level +1 from me.

Thanks!

> 
> Some comments inline.
> > 
> >  - The timestamp is a new field at the end of virtio_net_common_hdr
> >    after outer_nh_offset and ipsec, offset 32 (see virtio spec),
> >    negotiated with VIRTIO_NET_F_RX_TSTAMP (bit 49). Header size now 40
> >    bytes.
> >    Willem noted on v3 that virtio_net_common_hdr was not meant to be
> >    extended this way; I kept it as the simplest approach, but a
> >    separate struct for the timestamp header is an option.
> >  - Timestamping is enabled at runtime with SIOCSHWTSTAMP; all
> >    supported rx filters behave the same for now.
> >  - XDP programs can read the timestamp with
> >    bpf_xdp_metadata_rx_timestamp().
> >  - vhost-net passes the feature through; the timestamp itself is
> >    written by tun. The tun patch is only meant as a reference
> >    implementation for the device side.
> >  - The timestamp is in TAI.
> 
> Is this a requirement? It is common for PHCs to be synced to TAI,
> but not 100% the case. Does virtio need to specify this.
>

No, I don't think it has to be TAI. TAI is only what the tun reference
implementation does (ktime_get_clocktai_ns()). What the guest really
needs is to know which clock the timestamp comes from, so it can compare
it with something.

One idea for the spec change: don't fix the time base in virtio-net at
all, only say the timestamp is in nanoseconds of some device clock, and
let the device tell the driver which clock that is. virtio_rtc already
has clock ids with a type (UTC, TAI, monotonic, ...), and the Linux
driver registers a PHC for each of them (with VIRTIO_RTC_PTP).
virtio-net could carry the virtio_rtc clock id in its config space, and
the driver reports the index of that PHC in get_ts_info. That would also
fix the phc_index == -1 problem you pointed out in 2/6.

What I don't like about it: virtio-net then depends on a second device
being there, and with more than one virtio_rtc device the clock id alone
is not enough to find the right one. Without virtio_rtc the driver would
not offer hardware timestamps at all.

The alternative is a PHC in virtio-net itself (gettime over the control
vq), which is a lot more spec for one timestamp field.

Do you think the virtio_rtc way is reasonable, or is there something
simpler I'm missing?

> >    The driver reports it as
> >    SOF_TIMESTAMPING_RAW_HARDWARE without a PTP clock (phc_index -1),
> >    so userspace cannot tell which clock it refers to and may compare
> >    it against CLOCK_REALTIME (currently off by 37s). Options I see:
> >    convert to the guest's system time in the driver (correct only if
> >    host and guest agree on the TAI offset), expose a PHC so the
> >    time base is explicit, or keep the raw TAI value and leave the
> >    conversion to userspace. Which one is preferred?
> >  - Like the existing rx_hash, the XDP timestamp callback locates the
> >    header relative to xdp->data, so it must be called before
> >    bpf_xdp_adjust_head().
> > 
> > A virtio spec change is needed as well and not yet proposed.
> > 
> > Testing: the feature needs a QEMU that knows VIRTIO_NET_F_RX_TSTAMP and
> > sets the matching vnet header size; see
> > https://github.com/strumtrar/qemu/tree/v11.0.1/virtio-rx-stamps
> > 
> > Performance: I measured the receive rate with 64 byte UDP packets in
> > a nested QEMU/KVM setup with vhost-net. The variance between runs is
> > larger than any difference between the variants (without the series,
> > series without the feature, feature negotiated, feature enabled), so
> > I cannot show a measurable cost or the absence of one. Numbers from
> > bare metal will follow with a non-RFC version.
> 
> This does not seem performance sensitive to me. And it is opt-in.
> IMHO no need for extensive testing for performance regressions.
> 

Performance measurements where requested in some of the previous
versions because of the increased header size. But now, as this is
really opt-in, I'll drop that part from the cover letter.


Steffen

-- 
Pengutronix e.K.                | Dipl.-Inform. Steffen Trumtrar |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |
