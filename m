Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E821A389107
	for <virtualization@lists.linux.dev>; Thu, 13 Aug 2026 15:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786636742; cv=pass; b=VkIK3FJcOUNhup5VEhK0s1k7uaazWaG6tOYWdnBUqwNbPvPVQZ9HIpVD8l/bosusCMIGXSndt9GHJf6aMibIbtP4JCo15BuR+zjiVmPwBniE840hyc0gsLqQMPfMxTcRaPx/KwDALYU8O/VlOMY206Sseg9yRF+GeAVCs2OdJqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786636742; c=relaxed/simple;
	bh=1qZPJLbxk0wqdttDxWXJdq7N6rwl113FWoMfJzcYy9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uuss4FUoTZ8gliCd6WUSRjaJ3iTW2k+7yyN1wH4caUkXEULS3imcEsIj+YoH6sRIMJTxrwRDMicTi5gulUAILseQ8vT8fi1tb6FLvWTpexevNE9KbVkGOJlD6n9IclU+Gm4kr6m/aptzDvREnzEEyKXsSY3v6RYob4RPjZK3TiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmtrLM3x; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmtrLM3x"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66c2d726650so64357d50.0
        for <virtualization@lists.linux.dev>; Thu, 13 Aug 2026 08:59:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786636740; cv=none;
        d=google.com; s=arc-20260327;
        b=b8Q1T0AEn37jmq7Cq/qEcujSsm2z4juFBWTvl/XD7zg4KlQS9jN+qploRFTFgo/ruB
         dXrXsjVOy7ZDhVLY6TqWTvoH+I+Q5lscL9jqVmrOoTuXgb5e0Z/SMbbpry8+5fX0JNkM
         KZsYnGsjmE+rpwgivvPlVPcgEf4h1EbclYzKftoCt7qNVXLqms4oCjYfPf5qJsJ7/rzx
         I8Ijxo7C9e0vLU8ld+1J6Wvx98VgFrTpF/PU6Ef60GLMrlzqu9kHrUYyIweqbsqLQzDg
         +YJT5nxJSdRSZhQ4Ih2HJpmwK/KjErv4BrTSsdWaDogpZLpgFa05Wz6tQ4aRd8yzl1WY
         Qe/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3700YXJGZEBQK93k1TvUa1Hm3bijHaLKBZNSZbXc0r4=;
        fh=XfvtYuXAMzwcACXd/OC4kbvz8AoEN5MQql8rDkuUUfY=;
        b=qQQgtIEjDQh1ilqfKARQgTH2D8kkeVXyHuLfhKLO/avRunss/jwSeQsz1RQkCnazQ1
         qGDtRkCI/7kAFkBgxkLRc+X25ANxxaXonewd7Eh7d2+T9EWVV5gq4UsNmjOxjQuIz4hH
         3XQRvACP0mGR8TKlhLpNsGrXGnaiXousc8dYJ5JdB+SV1VAE/MmmvuNTLISZuYMKRYRh
         q2O1utHi94SuyywXS1XahawraB7UgG+a7aj5NW+j5guFwFi5XoaR/N7FOlKYPsEfu9xF
         0EoCq8L2akHf7Ah9hhkWn2AfQNFBK3Gk7i6W5bsgBbRz/nB5LveAAp2TX6k5rvCX9Riw
         yuBQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786636740; x=1787241540; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3700YXJGZEBQK93k1TvUa1Hm3bijHaLKBZNSZbXc0r4=;
        b=PmtrLM3xr2Kx173IKmhFIqXywz8ayaTIgr9xB0sxLimHpyD6ROrdwNs4SK5fR4F6r6
         asDK9Iq1cC6zErUhSj0PXKHroB2Ir/EPj98d4KJSPkfvyCzv4erK9KxJMRtZ0N1R+BGS
         Zt6IQqZAZxRjH5D84RsVgzvSOvG6dMhW1vdjIhKbyx+T6RX44TSJ6YT6r0i/Mxc3SrCJ
         2SbIs/E6VmARK9OyizhSyOnjj0WCvhsuJxocAfCfR8Sf1dWTNvOdXuV7SsRdBlVeDXZC
         LREVyqQZsihn/udoeV8WLPjIm6J4YDHUNP8Igszm40O3akT/HLeGsbcivY+FIkMYJedH
         kY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786636740; x=1787241540;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3700YXJGZEBQK93k1TvUa1Hm3bijHaLKBZNSZbXc0r4=;
        b=IE5kbYFnoxsMC41ZyFxgpNFZWW1LAnSvSDEe9BiDTE4mHNY5FG6OI34kbuW6Tp6J8i
         7ejhfj9SZ62TzW/l/E/9SAJUajUvMuNKzvtTRFn0JTxUkfaIJ5B8F1wdmLdYn0kZ8oLz
         WnwWk/2WWXk60TaykBhctjeNOvTatJeyZ7mHUTdWtMS+5CWAe14hltj4y3wUepulXGIk
         e9RqyXKko2xyODzKgHnXSEYoxQIWJxbnu1oOsLgmm1VYMgH+EjS5ZO4QEfUbuZ6uQILJ
         CrQ0uiYV63BRNYiA+SoTVd6kkavmO8DBojqHYzOrKWdol4JWjcKHuH4V1BtYnAhpnOkj
         oHjw==
X-Forwarded-Encrypted: i=1; AHgh+Ro6yCPgOrCmc1J4QKE2mWXqUQ7JiHp2ZY+ESg8ZMzGPqn65eVr9plbFON2wAMJ0Cgt4QyEwBtp5tCELoIeNNw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyKVyEF6TJEjoq8eVt5Zk/NKYuvE16j/3hD/mAIddkwUvZa/x4n
	fZEB2bIEN4kYhXJHJc7sABEl7lxV03NC/iS1qDlikm2q7ItUSv8/BbMQbrFwwSUMNR6reBRz9TP
	5Asxkm0XDD3YPY+ISePNIWDC6ulI8PRE=
X-Gm-Gg: AR+sD11KV6hewNhg7DOJ3R2HX4vcwKuJodUwPc8wSXaeLREkqqfIO2ka5/vgUxfqohN
	NVDJ9w78jIn3e8XTefHyEBGS6P/GdgdwNmlrVVOq+brwGmi1QYDMmiD8EZJLvZzMShHqSyCzFKU
	69cEzmthZ9k5rzwVcGh83G2UE7gmpBK6Dq8YM3aOHxZG+R2yIf2othwJiROAIDe5iId3rZ+t/8p
	7SQR0/nSh3htjLCw5opZr6MqmT6KCFKyF6eDllkBgFMwc4qJrpSxwdd6Ahi3p6KnlrxU642a8sI
	iD8XaSa8rnn0HoQYQ4OYqjrIonwwNCUZw/y1TmsFJnpGtMn0FS3t1bqQ5lAFVin5/2BH2PLC95M
	m9fDu
X-Received: by 2002:a53:ca09:0:b0:664:d0ac:7c8f with SMTP id
 956f58d0204a3-66c51642096mr1997694d50.30.1786636739609; Thu, 13 Aug 2026
 08:58:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260804213510.673084-1-chia-yu.chang@nokia-bell-labs.com>
 <20260804213510.673084-2-chia-yu.chang@nokia-bell-labs.com>
 <20260811173017.3d18dfdc@kernel.org> <PAXPR07MB79849A3F1724DBB2DA8EA20AA3DC2@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <20260812155430.6ec81eec@kernel.org> <PAXPR07MB7984E3E73868BF8966821C27A3DB2@PAXPR07MB7984.eurprd07.prod.outlook.com>
In-Reply-To: <PAXPR07MB7984E3E73868BF8966821C27A3DB2@PAXPR07MB7984.eurprd07.prod.outlook.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 13 Aug 2026 11:58:22 -0400
X-Gm-Features: AUfX_mwopSgwyvZOjYUqpXm2XmwhtsPjHx2eC07FAHM6dlfLpKgUy4Q4kn_Y1Ps
Message-ID: <CAF=yD-LQbndjPZiXcfA6fMp6msza_+YdzqqwyeUDVTdOCOHhDw@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 1/2] net: update comments for SKB_GSO_TCP_ECN
 and SKB_GSO_TCP_ACCECN
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "shaojijie@huawei.com" <shaojijie@huawei.com>, 
	"shenjian15@huawei.com" <shenjian15@huawei.com>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "eperezma@redhat.com" <eperezma@redhat.com>, 
	"jasowang@redhat.com" <jasowang@redhat.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, "mst@redhat.com" <mst@redhat.com>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"edumazet@google.com" <edumazet@google.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>, 
	"horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org" <dsahern@kernel.org>, 
	"kuniyu@google.com" <kuniyu@google.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dave.taht@gmail.com" <dave.taht@gmail.com>, 
	"jhs@mojatatu.com" <jhs@mojatatu.com>, 
	"stephen@networkplumber.org" <stephen@networkplumber.org>, 
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>, 
	"davem@davemloft.net" <davem@davemloft.net>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "ast@fiberby.net" <ast@fiberby.net>, 
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>, 
	"ncardwell@google.com" <ncardwell@google.com>, 
	"Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>, 
	"g.white@cablelabs.com" <g.white@cablelabs.com>, 
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>, 
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>, 
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, 
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>, 
	Parav Pandit <parav@nvidia.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 6:33=E2=80=AFAM Chia-Yu Chang (Nokia)
<chia-yu.chang@nokia-bell-labs.com> wrote:
>
> > On Wed, 12 Aug 2026 10:33:19 +0000 Chia-Yu Chang (Nokia) wrote:
> > > > > -     /* This indicates the tcp segment has CWR set. */
> > > > > +     /* For TX, this indicates that the first TCP segment has CW=
R set, and
> > > > > +      * any subsequent segment in the same skb has CWR cleared. =
This flag
> > > > > +      * must not be used in RX, because the connection to which =
the segment
> > > > > +      * belongs is not tracked to use RFC3168 or AccECN. Using R=
FC3168 ECN
> > > > > +      * offload may clear CWR and corrupt ACE signal (CWR is par=
t of it).
> > > > > +      * Instead, SKB_GSO_TCP_ACCECN shall be used to avoid CWR c=
orruption.
> > > > > +      */
> > > >
> > > > I still can't wrap my head around this TBH.
> > > >
> > > > SKB_GSO_TCP_ECN means RFC3168
> > > > SKB_GSO_TCP_ACCECN means AccECN
> > > >
> > > > If the HW can correctly detect cwr on first frame and then no cwr a=
nd report that as ECN/RFC3168 - what's the problem? TSO will produce the ex=
act expected segment sequence.
> > > >
> > > > Is the program that if we re-GRO that frame in SW we end up with
> > > > ECN+ACCECN on the same skb?
> > >
> > > Yes, this is the problem.
> > > The HW does not know whether the received packets belong to an RFC316=
8 ECN flow or an AccECN flow on the RX path.
> > > For example, HW GRO may set SKB_GSO_TCP_ECN after observing that the =
first packet has CWR=3D1:
> > >
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> > > |     Packet id     | CWR flag |       Flag      | Flushed as SKB |
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> > > |         0         |     1    | SKB_GSO_TCP_ECN |        0       |
> > > |         1         |     0    |         -       |        0       |
> > > |         2         |     1    |         -       |        0       |
> > > |         3         |     1    |         -       |        1       |
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> > >
> > > If the aggregated skb is forwarded through a device using GSO, e.g.,
> > > HW RX (GRO) -> veth TX (GSO), the SKB_GSO_TCP_ECN applies RFC3168
> > > semantics. This means that only the 1st segment keeps the CWR flag
> > > while all subsequent segments have CWR cleared:
> > >
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D+
> > > |     Packet id     | CWR flag |
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D+
> > > |         0         |     1    |
> > > |         1         |     0    |
> > > |         2         |     0    |
> > > |         3         |     0    |
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D+
> > >
> > > This behavior is ok for RFC3168, since CWR is expected to appear only
> > > once. However, for AccECN, CWR is part of the ACE signal and must be
> > > preserved across all segments.
> >
> > But this would be obviously a buggy HW-GRO implementation.
> > The rules for HW-GRO RFC3168 are -- ignore CWR on first segment (host r=
esponsible for populating SKB_GSO_TCP_ECN), and CWR _must be 0_ for all sub=
sequent segments.
> >
> > > In the example above, the original CWR sequence was 1,0,1,1.
> > > But after re-segmentation it becomes: 1,0,0,0.
> > > This is why SKB_GSO_TCP_ECN should not be used in RX/GRO paths.
> >
> > We have extensive gro tests under
> > tools/testing/selftests/drivers/net/gro.py
> >
> > If you want to catch bad devices - add appropriate test cases there.
> >
>
> I added a test case in patch 6f74bc8b6e8d related to the CWR flag.
> In that case, there are 5 packets with CWR values of 0, 1, 1, 0, and 0, a=
nd packets are flushed after the 1st, 3rd, and 5th packets.
> The gro.py uses this case in tools/testing/selftests/net/lib/gro.c to ver=
ify CWR behavior.
> But indeed, that does not cover whether SKB_GSO_TCP_ECN or SKB_GSO_TCP_AC=
CECN shall be set during the GRO.
> So, a test might be added to verify the SKB_GSO_TCP_ECN or SKB_GSO_TCP_AC=
CECN flags (if there is another suggested way, please let me know)?
>
> > The comment as stated seems to be misleading - there's nothing wrong wi=
th using the flag if the device follows the RFC3168 semantics correctly.
> >
> > And of course, adding a comment and hoping people will find it is much =
weaker than adding tests.
> >
> > Again, maybe I'm missing what _actually_ doesn't work here.
>
> Before adding an extra test, we need to clarify the definition and usages=
 of these flags.
> At the TX path, in tcp_gso_segment() of net/ipv4/tcp_offload.c, the SKB_G=
SO_TCP_ACCECN flag is used to preserve the CWR flags for AccECN flows.
> Otherwise, when without SKB_GSO_TCP_ACCECN (RFC3168 ECN or Non-ECN flows)=
, cwr will be cleared from the following packets.
>
> For the RX path, unfortunately I do not find a clear rule of when SKB_GSO=
_TCP_ECN shall be set except in include/linux/skbuff.h.
> Plus, the device usually does not track packets belonging to RFC3168 ECN =
or ACCECN flows.
> So, my previous thought is to always use SKB_GSO_TCP_ACCECN in the RX pat=
h to avoid any potential CWR bleaching.

This would be a case where AccECN support causes a regression for
regular ECN handling, if that is no longer allowed to be coalesced.

Most HW-GRO hardware out there today likely only supports ECN. In
which case they can set SKB_GSO_TCP_ECN fine.

If AccECN flows cannot be differentiated from ECN flows, on such
devices, does the admin have to disable HW-GRO with ECN if they care
about preserving AccECN signals?

What does SW GRO do here?
