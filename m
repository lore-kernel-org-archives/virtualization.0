Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DBA1CEADB
	for <virtualization@lists.linux.dev>; Mon, 24 Nov 2025 01:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763946309; cv=none; b=AUeksy4ZdLjrbDbaEpEcjK0TYTFf453MXvf4rS/WK4GohBxgDAGCLGusRll1FDxpa1vSFjF2w01+wviUowMml5dGVBg90kCdsAOVyNP4fJIOjYot36TgR9te0ojybWwhvjs9YnWV0AY1LymUF5PfSr1Xog19/QoVjaxO4cYr+Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763946309; c=relaxed/simple;
	bh=hFaBYbE3y68xOE+XV9Dtx+Qgi0+F14Zb9cUvi3w2ZxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ivC0txERSUpX9XXlix6UOg4NtwsVzmnz8eCZnkmTxYdrmkAbkakaMvHVZAuOKH4ghunoRzYx4t1bTCplhXI/khxGfSZ8PThQF/9NnBxykuDCYaisNv2PR1wEngNGA9On/gouwOzonfPIfO6gHMVTmIvMN1BgVYRdYDORBljCl9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HzNU6Yc4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HzNU6Yc4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763946306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VV+5zSicwL/Rb0C8YO32PyihotdED3oqIKG17hTVQOg=;
	b=HzNU6Yc4b1zXewYBNTBNnNGD7MyDDa6Ey93h2jNvKDGkfz+cJtgWf6Ofcaduj0e99P7tgm
	0JrpXtGb7CdrhTexSurAaPSE3drJrn4DwKNZLJEOb9rx3Juql94yq66K0ZoH4wT4MY/hJ2
	s/njjjPJyaSBuYkTdCyJfhB8pSvmqF4=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-KjcslECTN_u06_jAmtVYRQ-1; Sun, 23 Nov 2025 20:05:05 -0500
X-MC-Unique: KjcslECTN_u06_jAmtVYRQ-1
X-Mimecast-MFC-AGG-ID: KjcslECTN_u06_jAmtVYRQ_1763946305
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-9372b0ea541so8480609241.3
        for <virtualization@lists.linux.dev>; Sun, 23 Nov 2025 17:05:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763946305; x=1764551105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VV+5zSicwL/Rb0C8YO32PyihotdED3oqIKG17hTVQOg=;
        b=poFMd/Prks3ycGjamksTQ1wOEuOhWWAprK3ocXrK3B6cAs2UF9G0nQmbbWX1xOZR3A
         JcKue2HwQHXPyHFw2Jp3qL5pmI7iCEayEnS4cMmRfXlyaPcLo2YFhi3Mqd2IDbIrGA2n
         HnVwa2HRbY7VWr2Tkh/MVRFRqAeQ/EUqTJoN0KNHa3TW9IuxZfcV49bOtrCEMVQ+NyHK
         lELXOLARrcB0q2a/ifgdT58kNV2t0/HN+lQRQ/+QsZsXoL5hHUWK9hjug2Z6BCuI616C
         byhTiAp0H7XvUxY5RFPwsXOMBrK8GhKyIf1WInCqbOwMqCvJ5klwsGMLpQOtC1wEKU7b
         NsBA==
X-Forwarded-Encrypted: i=1; AJvYcCVK17Wl/jEx7JgN9UI7FMH4dAQ527yljIUXotnqmsR69W/Tg/8wiaRTAL1TpZrekrmJY7xvgwU14mBNdJ7vmQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJjwlUwgzqPHoMgXGonHJfhB/cFtQ1i2aE6eXf4RYnW+E1Cdbl
	rA7FJ5buVoh3jl5Y2z0TrhzNrWfY7J31VUeaqYqX2Dag5JMnbbpV6duj9vuB9mZxxoz6OhBrSG0
	RDsmhcT23EKRMP9wSIYGQlCENedcQd0NkEQ3Yzy7IEKdjMTBn1HVul3eMGGO8iPWsmGDWEUpMT+
	XSlhPXYTWiF6x+XF9mOz8gbWQFaz2ZFBs174D2Bv63hkk=
X-Gm-Gg: ASbGnctauyRfG7QIFMukTD+ZQw1GNE760ou/6e1ugLsFT4FshYcVPDR+mEz9AraYriI
	XMM99XqHdIyKn345pajV+7TK8b1/SXoh/ZtSxdzjzKwV7VYyofiRrxNsyMaokoQ3YFqGLANy7ph
	DOb7qhqR6GOCHCLPykSbW4ynYMNBl0JGlv75f7sz4GMh0R9skvFlHHLam9wCoZGsous9w=
X-Received: by 2002:a05:6102:5113:b0:5dd:8992:e38d with SMTP id ada2fe7eead31-5e1de009870mr3053977137.7.1763946304770;
        Sun, 23 Nov 2025 17:05:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7OacEM+zDYjOfkUsz4G/sINm5QjFmTYWbl6BoR4HzQZ3LpfFnpvnnMjxdSI0aO50p576SwyBLD1Of6y3UlXU=
X-Received: by 2002:a05:6102:5113:b0:5dd:8992:e38d with SMTP id
 ada2fe7eead31-5e1de009870mr3053959137.7.1763946304249; Sun, 23 Nov 2025
 17:05:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251120152914.1127975-1-simon.schippers@tu-dortmund.de>
 <CACGkMEuboys8sCJFUTGxHUeouPFnVqVLGQBefvmxYDe4ooLfLg@mail.gmail.com> <b9fff8e1-fb96-4b1f-9767-9d89adf31060@tu-dortmund.de>
In-Reply-To: <b9fff8e1-fb96-4b1f-9767-9d89adf31060@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Nov 2025 09:04:51 +0800
X-Gm-Features: AWmQ_blAfagP4JVcqb3I5pd2yopIE-ehV7wJYeGsn_1Vv8cVt5NT9Qo4mtXzUkM
Message-ID: <CACGkMEufNLjXj37NBVCW4xdSuVLLV4ZS4WTuRzdaBV-nYgKs8w@mail.gmail.com>
Subject: Re: [PATCH net-next v6 0/8] tun/tap & vhost-net: netdev queue flow
 control to avoid ptr_ring tail drop
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mst@redhat.com, eperezma@redhat.com, jon@nutanix.com, 
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AgmmreifuOHchl8gyFRnrivQmvAXBlZDQPfQG3kDIm8_1763946305
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 5:23=E2=80=AFPM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> On 11/21/25 07:19, Jason Wang wrote:
> > On Thu, Nov 20, 2025 at 11:30=E2=80=AFPM Simon Schippers
> > <simon.schippers@tu-dortmund.de> wrote:
> >>
> >> This patch series deals with tun/tap and vhost-net which drop incoming
> >> SKBs whenever their internal ptr_ring buffer is full. Instead, with th=
is
> >> patch series, the associated netdev queue is stopped before this happe=
ns.
> >> This allows the connected qdisc to function correctly as reported by [=
1]
> >> and improves application-layer performance, see our paper [2]. Meanwhi=
le
> >> the theoretical performance differs only slightly:
> >>
> >> +--------------------------------+-----------+----------+
> >> | pktgen benchmarks to Debian VM | Stock     | Patched  |
> >> | i5 6300HQ, 20M packets         |           |          |
> >> +-----------------+--------------+-----------+----------+
> >> | TAP             | Transmitted  | 195 Kpps  | 183 Kpps |
> >> |                 +--------------+-----------+----------+
> >> |                 | Lost         | 1615 Kpps | 0 pps    |
> >> +-----------------+--------------+-----------+----------+
> >> | TAP+vhost_net   | Transmitted  | 589 Kpps  | 588 Kpps |
> >> |                 +--------------+-----------+----------+
> >> |                 | Lost         | 1164 Kpps | 0 pps    |
> >> +-----------------+--------------+-----------+----------+
> >
>
> Hi Jason,
>
> thank you for your reply!
>
> > PPS drops somehow for TAP, any reason for that?
>
> I have no explicit explanation for that except general overheads coming
> with this implementation.

It would be better to fix that.

>
> >
> > Btw, I had some questions:
> >
> > 1) most of the patches in this series would introduce non-trivial
> > impact on the performance, we probably need to benchmark each or split
> > the series. What's more we need to run TCP benchmark
> > (throughput/latency) as well as pktgen see the real impact
>
> What could be done, IMO, is to activate tun_ring_consume() /
> tap_ring_consume() before enabling tun_ring_produce(). Then we could see
> if this alone drops performance.
>
> For TCP benchmarks, you mean userspace performance like iperf3 between a
> host and a guest system?

Yes,

>
> >
> > 2) I see this:
> >
> >         if (unlikely(tun_ring_produce(&tfile->tx_ring, queue, skb))) {
> >                 drop_reason =3D SKB_DROP_REASON_FULL_RING;
> >                 goto drop;
> >         }
> >
> > So there could still be packet drop? Or is this related to the XDP path=
?
>
> Yes, there can be packet drops after a ptr_ring resize or a ptr_ring
> unconsume. Since those two happen so rarely, I figured we should just
> drop in this case.
>
> >
> > 3) The LLTX change would have performance implications, but the
> > benmark doesn't cover the case where multiple transmission is done in
> > parallel
>
> Do you mean multiple applications that produce traffic and potentially
> run on different CPUs?

Yes.

>
> >
> > 4) After the LLTX change, it seems we've lost the synchronization with
> > the XDP_TX and XDP_REDIRECT path?
>
> I must admit I did not take a look at XDP and cannot really judge if/how
> lltx has an impact on XDP. But from my point of view, __netif_tx_lock()
> instead of __netif_tx_acquire(), is executed before the tun_net_xmit()
> call and I do not see the impact for XDP, which calls its own methods.

Without LLTX tun_net_xmit is protected by tx lock but it is not the
case of tun_xdp_xmit. This is because, unlike other devices, tun
doesn't have a dedicated TX queue for XDP, so the queue is shared by
both XDP and skb. So XDP xmit path needs to be protected with tx lock
as well, and since we don't have queue discipline for XDP, it means we
could still drop packets when XDP is enabled. I'm not sure this would
defeat the whole idea or not.

> >
> > 5) The series introduces various ptr_ring helpers with lots of
> > ordering stuff which is complicated, I wonder if we first have a
> > simple patch to implement the zero packet loss
>
> I personally don't see how a simpler patch is possible without using
> discouraged practices like returning NETDEV_TX_BUSY in tun_net_xmit or
> spin locking between producer and consumer. But I am open for
> suggestions :)

I see NETDEV_TX_BUSY is used by veth:

static int veth_xdp_rx(struct veth_rq *rq, struct sk_buff *skb)
{
        if (unlikely(ptr_ring_produce(&rq->xdp_ring, skb)))
                return NETDEV_TX_BUSY; /* signal qdisc layer */

        return NET_RX_SUCCESS; /* same as NETDEV_TX_OK */
}

Maybe it would be simpler to start from that (probably with a new tun->flag=
s?).

Thanks

>
> >
> >>
> >> This patch series includes tun/tap, and vhost-net because they share
> >> logic. Adjusting only one of them would break the others. Therefore, t=
he
> >> patch series is structured as follows:
> >> 1+2: new ptr_ring helpers for 3
> >> 3: tun/tap: tun/tap: add synchronized ring produce/consume with queue
> >> management
> >> 4+5+6: tun/tap: ptr_ring wrappers and other helpers to be called by
> >> vhost-net
> >> 7: tun/tap & vhost-net: only now use the previous implemented function=
s to
> >> not break git bisect
> >> 8: tun/tap: drop get ring exports (not used anymore)
> >>
> >> Possible future work:
> >> - Introduction of Byte Queue Limits as suggested by Stephen Hemminger
> >
> > This seems to be not easy. The tx completion depends on the userspace b=
ehaviour.
>
> I agree, but I really would like to reduce the buffer bloat caused by the
> default 500 TUN / 1000 TAP packet queue without losing performance.
>
> >
> >> - Adaption of the netdev queue flow control for ipvtap & macvtap
> >>
> >> [1] Link: https://unix.stackexchange.com/questions/762935/traffic-shap=
ing-ineffective-on-tun-device
> >> [2] Link: https://cni.etit.tu-dortmund.de/storages/cni-etit/r/Research=
/Publications/2025/Gebauer_2025_VTCFall/Gebauer_VTCFall2025_AuthorsVersion.=
pdf
> >>
> >
> > Thanks
> >
>
> Thanks! :)
>

