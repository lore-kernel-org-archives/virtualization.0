Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328467;
	b=VLg2nk8eNIpFiXiPdsYoQPOOtNy0sp7ZegC2ilwo/oqiOfVh0xKGdfn0O1JM1bcbMvvG
	 ixO4D+SfjCzphSvn//D20v369NZ1cY+UW+tN9kQqBX8bm31dml5VtnxSfxqWFXGap3qhT
	 8FPFBHxlCnFhxLnZssHEesBqcxsDPTRrk6oOj4FponlPxqZ6bE7J8EmIVK1GsccN2fKTv
	 ktFTmVKsODQFbIhmObq8sSpkygJVgs1/HroCTGVqgdFvX7Rz+meJSCFmhdK+IwNHjuJ+t
	 DAG7SpCqQDhn6pQyITk1WBoFWfUcXrfc6+6/J1QL9pLa71HHqjqsrAfQqtcZtz+ZPdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328467;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=y+V2JxIlVOChITFgo1z9lTreH4E5kp3RpfFu+UewLVo=;
	b=mHoX/zo6kvuN745MMDdv+HgQtxtfHrCNC8+IzAt8otLJT+4fVqRphPpXl6WNw+F6dNZo
	 YvBWIc6J9b8MeZsJTf6toJoD7/xKcS9TArIZN7/395wbogn25dFbwk/iiRjtvLsb5Nf9S
	 TOvGfBIVCn6CG9e9FgBNPwoNbZScr3GiX5aaEeiFNTYZdrRqR39KWh9iFjPjFmfVzgasI
	 TSMJG9xXM1CWAy9hortHc+8UPdgTaKjNi1zMApj9XzAGq5T5bUG0EHFSCUixN4d70PfbH
	 z7o06x3K94euURvwEVXiJYaKurGgAxPyvgAWq/taD2hpPbk3HQyz+Vz7Dml2IDQZsnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CogSuGPl;
	arc=none smtp.remote-ip=209.85.222.44
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599CF606A8A4
	for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 16:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 599CF606A8A4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CogSuGPl
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-97ccbba8e86so597822241.3
        for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 08:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794328466; x=1794933266; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y+V2JxIlVOChITFgo1z9lTreH4E5kp3RpfFu+UewLVo=;
        b=CogSuGPlc5jdAfOI9Yn1v2JGDqN/XPcuNCSGxD5kownz6LXWwSqqSv1r2n8OXI+ix5
         ezHsGg3OzFmneg9+0jdt2D5wU1QiEyG4dvaCyUodvo7WBYdW709skryxzQ6p9HrxeiV6
         AI7aK5aSTR7gaN/zL2q5Cgnn79eeW4XA/54BSpbCVbsxmP3wMPOhBSspGOSBlqJdNF3U
         p78m6bz5xQIhQvrvId+YS3FZ/EPiJLnbV8j6us3wFMxGi+A27DkZRyloAhQp6NFooqUS
         tL0dvz4/QfwMjP2VmWVIYD4Q6EFtX0wwP3QJFOEGNHNTwvJlRiTcOKqIEVYtBtXZUqQk
         etNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794328466; x=1794933266;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y+V2JxIlVOChITFgo1z9lTreH4E5kp3RpfFu+UewLVo=;
        b=EX86E5j1eiHKnaQeU+mrJHqt3AH9IxD2PHTo9PmiechI1M11KrgPWS1za6LjC/TKor
         cFSiLrYtDfA2kKNblNpyCENLyr8CWeUDj54m5Stx8yj4uEwhtzhCwX6grZSDT19uivDZ
         9pplR5GYB3cgP8hapXDQHSE9d9uCRdBL8fGrQYyP9lhhREhR6zFkj70J86xz1fiZgs2N
         y9cqs3RTqBB/kcXvwIaBbXe4+h8SpqgHxDHYW1/w69g4jt3aPyzcP1BRExSMLGvwZn6u
         VIu1fZV1/Lnv6uHfop5k1OeZFqyjJ97aCzgL38wzJttSyl/CHWPMjZoTziY3gWplf4Be
         N5sg==
X-Forwarded-Encrypted: i=1; AL+hErEpFPm6gO0RHtpYH0sAeUxXp73q3Peu11XihiIrFg3OIjK3qxvBwHO9Z0RMoF8R8ToypVqt62nAl+4uNbnQ/g==@lists.linux.dev
X-Gm-Message-State: APuU4Z8L3pWCAh1fDsrHkrbdKpGSQAEz9Cu57UC87HEeW/rlI+ZKnRPG
	7s63UEr5IjrZLq1iKDxs1geX+lHpDNXmnoAKJwAPXWMTKY+Ujfbpm+lN
X-Gm-Gg: AYBFou0rljcPQMnl3EnxIkSnwUCaRoGz4ijG6BxL7FbRUODS0cicFaEm9az4RVLnOCm
	JZGPJBwE1zJXH5yBKx7kQEQT3npo6nS60msRZf4WScIgLGhOGYyzBlR5OnoeJ8QskJzZD7NEE1C
	IEeVEqyfZkYrOzG28dpjUQ8DCnZCKGLMgx/gU16pWD6ulsEzfXuX4TwQhMU9iVxmNt5LhGsiSKO
	0iohHfSclGXfv9cvDiyzSY+vu4QQPhvnzpkTMZN7wjWapAhy8O7P8towKlYRSnBtHiTEcARB6+m
	iY5ANiO3276iLyuiDXaah5IXiSX97AGFXhmELRZ8U068Pu4kzlAOZ94I7aIYnMH8l/cVQ4RUNOz
	e8n0ZsjmDL+lgIIfAl4XGbWOzMOO3IP666xWknbVwPMgdhv9iaGta082eBS8Gsa9Cybbjtrzqwz
	T82+sNwqHtWm/4MHf9WyFa6vUdoqC5AxxZ7qbWLGV8Llk0bL8A2qQS5wLxTOBVYdJS7MRARn34a
	+i8+9hpI8F4SpSkpLHcr6/m19RpLTdCSqooP+4Q68CAhREpbykEGu7gQBWDNWJJGPDK2EMHJAjp
	yN8yPQNORqM31yCcNc4aPbQg7oqZSVEBhFc1gdBHfdrOq81gueaZ/RVffP6t7KXUg98w+Kk+2eJ
	OquvWMrjWch4xltdWLZ2k8oxoH5wrn6ZfvgjhoP3IS7Y6ut4vg4XShUel39OwyNLy1Uc8ObiXnW
	osqjbOBI+a2x5TXBpr
X-Received: by 2002:a05:6102:c54:b0:7b5:7cd5:2a1b with SMTP id ada2fe7eead31-7d301b9d79fmr866580137.10.1794328466169;
        Tue, 10 Nov 2026 08:34:26 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c200838f0sm2147394241.9.2026.11.10.08.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:34:25 -0800 (PST)
Date: Tue, 10 Nov 2026 11:34:25 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 kuba@kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Eric Dumazet <edumazet@kernel.org>, 
 virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 kvm@vger.kernel.org, 
 namangulati@google.com
Message-ID: <willemdebruijn.kernel.4096b48e9e59@gmail.com>
In-Reply-To: <874ido29iy.fsf@pengutronix.de>
References: <20261026-v6-7-topic-virtio-net-ptp-v4-0-008af03cd43b@pengutronix.de>
 <willemdebruijn.kernel.1d6388f036c46@gmail.com>
 <874ido29iy.fsf@pengutronix.de>
Subject: Re: [PATCH RFC v4 0/6] virtio-net: add receive timestamp support
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Steffen Trumtrar wrote:
> 
> Hi Willem,
> 
> On 2026-11-01 at 09:57 -05, Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> 
> > Steffen Trumtrar wrote:
> > > This series picks up Willem de Bruijn's work on a virtio-net receive
> > > timestamp. The device puts the time of arrival (TAI, ns) into the
> > > virtio-net header so the guest can use it for PTP and RTT estimation
> > > without taking the timestamp itself after the host-to-guest latency.
> > > 
> > > The series is an RFC. I am mostly interested in feedback on the
> > > approach and on the wire format:
> > 
> > At a high level +1 from me.
> 
> Thanks!
> 
> > 
> > Some comments inline.
> > > 
> > >  - The timestamp is a new field at the end of virtio_net_common_hdr
> > >    after outer_nh_offset and ipsec, offset 32 (see virtio spec),
> > >    negotiated with VIRTIO_NET_F_RX_TSTAMP (bit 49). Header size now 40
> > >    bytes.
> > >    Willem noted on v3 that virtio_net_common_hdr was not meant to be
> > >    extended this way; I kept it as the simplest approach, but a
> > >    separate struct for the timestamp header is an option.
> > >  - Timestamping is enabled at runtime with SIOCSHWTSTAMP; all
> > >    supported rx filters behave the same for now.
> > >  - XDP programs can read the timestamp with
> > >    bpf_xdp_metadata_rx_timestamp().
> > >  - vhost-net passes the feature through; the timestamp itself is
> > >    written by tun. The tun patch is only meant as a reference
> > >    implementation for the device side.
> > >  - The timestamp is in TAI.
> > 
> > Is this a requirement? It is common for PHCs to be synced to TAI,
> > but not 100% the case. Does virtio need to specify this.
> >
> 
> No, I don't think it has to be TAI. TAI is only what the tun reference
> implementation does (ktime_get_clocktai_ns()). What the guest really
> needs is to know which clock the timestamp comes from, so it can compare
> it with something.
> 
> One idea for the spec change: don't fix the time base in virtio-net at
> all, only say the timestamp is in nanoseconds of some device clock, and
> let the device tell the driver which clock that is. virtio_rtc already
> has clock ids with a type (UTC, TAI, monotonic, ...), and the Linux
> driver registers a PHC for each of them (with VIRTIO_RTC_PTP).
> virtio-net could carry the virtio_rtc clock id in its config space, and
> the driver reports the index of that PHC in get_ts_info. That would also
> fix the phc_index == -1 problem you pointed out in 2/6.
> 
> What I don't like about it: virtio-net then depends on a second device
> being there, and with more than one virtio_rtc device the clock id alone
> is not enough to find the right one. Without virtio_rtc the driver would
> not offer hardware timestamps at all.
> 
> The alternative is a PHC in virtio-net itself (gettime over the control
> vq), which is a lot more spec for one timestamp field.
> 
> Do you think the virtio_rtc way is reasonable, or is there something
> simpler I'm missing?

I don't have an obvious answer. This needs consensus.

Hardcoding clock base to TAI is definitely easiest.

Outside of virtio, the relationship between PHY RX timestamps and PHC
is well understood. It would make some sense for virtio to follow that
model.

But indeed when having multiple NICs and multiple PHCs, how to map them
I think is an unresolved issue in general? Of course, aslo moot if they
are all synced, which I think may be an implicit assumption especially
in the world of spec compliant PTP.

And, if virtualizing anyway, it is feasible to do the clock conversion
in the software device, not having to bother with all this complexity
inside the VM. Though maybe not for direct HW virtio-net queues.

