Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E9C33C1B4
	for <virtualization@lists.linux.dev>; Tue, 25 Aug 2026 16:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787674348; cv=none; b=Y6hUpkqp4uydeMyta413I77nQIRWwt6dTpa4eSHHOMyLJI+Z+3+wv4Rm7cPjqmxk5v1s47B3Tz9zwAuhbmjRJxZHAuiLMGEk81Gnh7ZHaEnz7JRO6WZ+DtEJ4XhC0dkVopQatYRsatggGEJ1rujNbKQrjJDkFBw/B/XUFHoOS3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787674348; c=relaxed/simple;
	bh=wXrgHy62T0tNDn8P/4NZ8q+YEMGB8yHeI1pf6IWRHTM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=dFbl891y+bJGydfCfN2P6s+rm8PjvUcgOtDBfz8ATT5/cRxCA5Vgx3wjaK0Bk62k4wpOJkjW0DE0z48i0MnIbzIscVsWRjyhQ78L1dRlvPKfrqpxYvzW3WMYxCdazFHZ30Utxb1p5erD4HUY59dlhl0mKcq3UQsG0TOxvhg97eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTaLxHkM; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTaLxHkM"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-836cde02992so60168007b3.2
        for <virtualization@lists.linux.dev>; Tue, 25 Aug 2026 09:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787674346; x=1788279146; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=01+frOfya8cSKRerweuTqMaNxLlq2qDmJSW1y4jWqwo=;
        b=PTaLxHkMQquLU4Vz4KX20pIQl8mOS18yr4dX4pG4dOCf9vU9ddhi2ZQxRBZt0XyhTt
         3JTf5qqCb5k2gRjQQgwJSsMmzhpPfRFRVhQEQA2mI9u09puLWsnxgvNw1PWl7wmzKdqb
         qlvGHYCxoKjEKNdgvR6/tU1ecrQGUmDNyUB29ZF27v1EvaT+lscJ9fOiHo1ueM1bhGpF
         UehGMEvGjPx+wpERcvv/Ob+4o1pKXzqZO3tUDd9DqMYe8kRdo7BGzTTkCxq3kgVmHa7A
         QdeC6KIbQgkc2SQCJzE5byTDHAOALkmgQWoxOjGVbs5AJEedCylKEmStaCN/spt3D2dp
         Db6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787674346; x=1788279146;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=01+frOfya8cSKRerweuTqMaNxLlq2qDmJSW1y4jWqwo=;
        b=GhCF6WelmNoZS8q7c4LfNvaSfxtIBXA5ikjHiQLaCqXJLAlCl9A7jO1VFuhphl+My4
         3FtF3SRST00g2KW6ABlopC2fWnNc8SnwFcOK9f2N/EZIIFZ5QRdnbxu8g6Z5jhVtJcwr
         ss7uMJvdUiBlVKApyokBC+TbE4KGU74hWjVGwCBXRDOTGYiK4qRU6QM4r31c31fsjWKN
         BVjt09rUej/jmq2oXx4V/ac1CQwlcMxz93Hc/ENJm3g6YqpQAamQA3Q9rvN7zakaajbb
         wj1evHhJNQb5dWVSa3xw9pREmpMR94b2uiw1/IPKxSHM7yPXxHzxYsjxsqtPEqe30HmB
         u0dg==
X-Forwarded-Encrypted: i=1; AHgh+Ro2C/6hVCf0t6osQbfM53bPqOR5TUGe9li85OnCDzYAMHAnx8349JL68mzLAfBaxMhRqAcUpkNWgPMRnM3f6Q==@lists.linux.dev
X-Gm-Message-State: AFuF++kLlgYKS9I95ToTr4ZObW2x3AR8pAWQWF2yze0b9v7ED7rvd75U
	UCz9P4oj16Lm/cBwDl+FvSFQFC8JEUOk/hQb9SjeJ3KPJyQp5PsRSHCH
X-Gm-Gg: AR+sD12WjU6X8Bq1TvbEbw1yiXG1rZqEfylO/E6YOJx83uoAa7qvW2plG+cIJAukSkE
	8eq8CLlTjaT5bYt4OutZRRgghdMiB0NQniscERbVjetaHHXovHTa7rT/dkKCEn8n//6Dp30yfxT
	qCOrSSAj6VzoWD69iT9OK4VyAtpKo/skoNuQdJD/rb7dj35CJ7xCI/DsZKQks7dT4HyFl4xRVGM
	gNYrBQgIJwOfJqI3P8TweDIGLHp2h09JuzH3kPMg3bNhLrVrLNUKA9HMUfyiQ34pZOCeo/jmgJw
	guWtpIf7n1qDyM/YgSqOLvswvNxyrKRBTLATF4gmQqwNx2QyAiVb7xUFU0eQtQhheQK4cWcRqlO
	hUos0T6urxUw5dZVAQ2Q952vC23ULXDLv55yyqFgURXuc68VbO8PFsfbIcS0DaLO24aV1lawTvP
	CpFNaP9W27uM9u1BWEN4PZ0CB4xbEHUlZrNyZm80RJp8y42K5fejZwthWESIC5aVmH6r+VAPf1S
	4fz4zMzc7ykGffPkasdX3yggkvS6LbaXD7zORiqrxfJoSGZH3Hy
X-Received: by 2002:a05:690c:e1d7:20b0:80e:5236:b944 with SMTP id 00721157ae682-85473d9e59amr26963037b3.10.1787674345937;
        Tue, 25 Aug 2026 09:12:25 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85705387614sm2221077b3.2.2026.08.25.09.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 09:12:25 -0700 (PDT)
Date: Tue, 25 Aug 2026 12:12:24 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: Mirja Kuehlewind <mirja.kuehlewind@ericsson.com>, 
 "shaojijie@huawei.com" <shaojijie@huawei.com>, 
 "shenjian15@huawei.com" <shenjian15@huawei.com>, 
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, 
 "eperezma@redhat.com" <eperezma@redhat.com>, 
 "jasowang@redhat.com" <jasowang@redhat.com>, 
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
 "mst@redhat.com" <mst@redhat.com>, 
 "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, 
 "pabeni@redhat.com" <pabeni@redhat.com>, 
 "edumazet@google.com" <edumazet@google.com>, 
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
 "corbet@lwn.net" <corbet@lwn.net>, 
 "horms@kernel.org" <horms@kernel.org>, 
 "dsahern@kernel.org" <dsahern@kernel.org>, 
 "kuniyu@google.com" <kuniyu@google.com>, 
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "dave.taht@gmail.com" <dave.taht@gmail.com>, 
 "jhs@mojatatu.com" <jhs@mojatatu.com>, 
 "stephen@networkplumber.org" <stephen@networkplumber.org>, 
 "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, 
 "jiri@resnulli.us" <jiri@resnulli.us>, 
 "davem@davemloft.net" <davem@davemloft.net>, 
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
 "donald.hunter@gmail.com" <donald.hunter@gmail.com>, 
 "ast@fiberby.net" <ast@fiberby.net>, 
 "liuhangbin@gmail.com" <liuhangbin@gmail.com>, 
 "shuah@kernel.org" <shuah@kernel.org>, 
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
 "ij@kernel.org" <ij@kernel.org>, 
 "ncardwell@google.com" <ncardwell@google.com>, 
 "Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>, 
 "g.white@cablelabs.com" <g.white@cablelabs.com>, 
 Ingemar Johansson S <ingemar.s.johansson@ericsson.com>, 
 "cheshire@apple.com" <cheshire@apple.com>, 
 "rs.ietf@gmx.at" <rs.ietf@gmx.at>, 
 "Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, 
 "vidhi_goel@apple.com" <vidhi_goel@apple.com>, 
 Parav Pandit <parav@nvidia.com>, 
 Willem de Bruijn <willemb@google.com>, 
 ij@kernel.org
Message-ID: <willemdebruijn.kernel.28ce4bc2544df@gmail.com>
In-Reply-To: <PAXPR07MB7984F0C072220066856DD8ACA3AF2@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260804213510.673084-1-chia-yu.chang@nokia-bell-labs.com>
 <20260804213510.673084-2-chia-yu.chang@nokia-bell-labs.com>
 <20260811173017.3d18dfdc@kernel.org>
 <PAXPR07MB79849A3F1724DBB2DA8EA20AA3DC2@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <20260812155430.6ec81eec@kernel.org>
 <PAXPR07MB7984E3E73868BF8966821C27A3DB2@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <CAF=yD-LQbndjPZiXcfA6fMp6msza_+YdzqqwyeUDVTdOCOHhDw@mail.gmail.com>
 <47BE8A8A-F80C-4C30-BC95-C85FEBFFB606@ericsson.com>
 <PAXPR07MB7984ED42ED0849D3A9AB8C19A3DA2@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <willemdebruijn.kernel.c248a28f9c86@gmail.com>
 <20260814120121.50e61d01@kernel.org>
 <CAF=yD-L1-Sxz9uyP_4WqtNRJHnwTVMhQba_KF-=Eiy=d9Jf-qA@mail.gmail.com>
 <PAXPR07MB7984F0C072220066856DD8ACA3AF2@PAXPR07MB7984.eurprd07.prod.outlook.com>
Subject: RE: [PATCH v5 net-next 1/2] net: update comments for SKB_GSO_TCP_ECN
 and SKB_GSO_TCP_ACCECN
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

> > > On Fri, 14 Aug 2026 09:34:01 -0400 Willem de Bruijn wrote:
> > > > > Current SW GRO sets SKB_GSO_TCP_ACCECN when the flushed skb carries CWR in tcp_gro_complete():
> > > > > if (th->cwr)
> > > > >     shinfo->gso_type |= SKB_GSO_TCP_ACCECN;
> > > >
> > > > And I suppose it follows correct AccECN rules for coalescing.
> > > >
> > > > That is a performance regression from RFC 3168 ECN, as it allows for 
> > > > less effective coalescing. I have no intuition how much it will 
> > > > differ in practice.
> > > >
> > > > > For HW GRO of a legacy device that implementing RFC3168 semantics, setting SKB_GSO_TCP_ECN seems reasonable.
> > > > > However, such a device would not be able to preserve ACCECN signaling across the GRO/GSO.
> > > > > In that case, if preserving AccECN signaling is required, disabling HW GRO may indeed be necessary.
> > > >
> > > > Right.
> > >
> > > I'm still not following.. Maybe Willem can ELI5 what the problem is.
> > >
> > > _SW_ GRO follows only the AccECN rules.
> > > But if HW GRO follows RFC 3168 and we mark the aggregate as 
> > > SKB_GSO_TCP_ECN - TSO will also abide, and segmented output will be 
> > > identical to pre-GRO input.
> > 
> > +1
> > 
> > > Are we trying to ban RFC 3168 behavior in HW purely to match SW?
> > 
> > I think that's the intent here?
> Hi Willem,
> 
> I think we can still change SKB_GSO_TCP_ECN into SKB_GSO_TCP_ACCECN on the RX path, even if HW GRO and SW GRO use different aggregation rules.
> Currently, SW GRO flushes when the CWR state changes and sets SKB_GSO_TCP_ACCECN when the resulting skb carries CWR=1.
>
> 
> For HW GRO, if the device flushes immediately when a CWR=1 packet arrives, there is no need to set either SKB_GSO_TCP_ECN or SKB_GSO_TCP_ACCECN.
> In that case, each CWR=1 packet is emitted separately, and there is no need to preserve multiple CWR indications through GSO.
> So, if the HW can be confirmed to always flush CWR-marked packets without coalescing them, preserving multiple CWR indications through GSO is not required.
> In that case, using SKB_GSO_TCP_ACCECN would not provide any additional benefit.

I agree.

The difference on transmit is that SKB_GSO_TCP_ACCECN will copy the
ECN bits to every segment, whereas SKB_GSO_TCP_ECN will only set the
bits on the first segment.

From commit 023af5a72ab1 ("gso: AccECN support") that introduced
SKB_GSO_TCP_ACCECN:

    With RFC 3168 ECN aware TSO (NETIF_F_TSO_ECN) CWR flag is cleared
    starting from 2nd segment which is incompatible how AccECN handles
    the CWR flag. Such super-segments are indicated by SKB_GSO_TCP_ECN.
    With AccECN, CWR flag (or more accurately, the ACE field that also
    includes ECE & AE flags) changes only when new packet(s) with CE
    mark arrives so the flag should not be changed within a super-skb.

Makes me wonder what SKB_GS_TCP_ACCECN adds. Copying bits
from the GSO skb to all segments is the default. SKB_GSO_TCP_ECN is
an indication that the NIC knows how to diverge from this default for
these specific bits.

That commit confirms this:

    If NIC is completely unaware of RFC3168 ECN (doesn't support
    NETIF_F_TSO_ECN) or its TSO engine can be set to not touch CWR flag
    despite supporting also NETIF_F_TSO_ECN, TSO could be safely used
    with AccECN on such NIC. This should be evaluated per NIC basis
    (not done in this patch series for any NICs).`

> 
> The problematic case is when a HW GRO aggregates multiple packets carrying CWR=1 and only sets SKB_GSO_TCP_ECN.

The driver of such a device could be updated to set SKB_GSO_TCP_ACCECN
or not set any such ECN GSO flag.

The driver of other devices that do follow RFC 3168 semantics will
continue to have to set SKB_GSO_TCP_ECN on the GSO skb. It is quite
plausible that few or no devices currently support ECN in their HW-GRO
coalescing.

> During GSO, only the first output segment would carry CWR=1, which loses the remaining CWR signaling information required by AccECN.
> In that case, changing from SKB_GSO_TCP_ECN to SKB_GSO_TCP_ACCECN would preserve the original signaling by ensuring that the segmented packets carry the correct CWR information.
> As I understand RFC3168, receiving additional CWR-marked packets is harmless, because once a valid CWR has been received, the receiver already stops echoing ECE.

Agreed.

> Additional CWR indications do not change the receiver state.
> This would have a performance impact since it disables HW TSO for the skb and falls back to software segmentation.

You mean if the device advertises NETIF_F_TSO_ECN, and GSO skbs may
contain AccECN signals, the host must downgrade from TSO to GSO to
avoid corrupting the signal?

The cost of that would be significant. Not something to do for
established environments. But technically seemingly correct, at least
for packets with non-zero ECN bits.

> But IMO it preserves correctness for both RFC3168 ECN and AccECN.

Side-note: this thread probably has way too many Cc: for this narrow topic.
