Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D85E366571
	for <virtualization@lists.linux.dev>; Tue, 13 Jan 2026 06:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768285600; cv=none; b=QQLFk2ENjE6BjZt8+ohzNeKzsxNbBjz0/KmAxTOuvgF4bSmnGpZK2YewXy7EPyC93cUTIFd8eJmKRW0x1/ODl2dveWWSqVhQ1W27syCwmaer/DWyy25UKAPUfXBY6zrz7uWgFEYg8NYYs7SncZzUVQuLDUA13jBLPDopX2N0lhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768285600; c=relaxed/simple;
	bh=2KJOX7Y1h6Sza8SV2r3yloVs1Dz7199qc4bMzJHHhMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=clvIzOkxUD+onKdHvqMTs8HuEg3V9F9f+jNdQQxtTKyP11yIkm4KRwFJWlFL7FFRABvUoquLy0tFLFw4aQmpZISf836zP6Eto68yXStR/1Gvveiekx0Ic7WqMOEP55IL6VgmvTfFhWhCNpEq4IjN1Pm80npPhfP68AbN3/5dNGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FRaF8bb+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FRaF8bb+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768285597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=spmIztd2EKRamvoD/LZmM+FSW3z8/AEEzT5gP8xnhtI=;
	b=FRaF8bb+8ZC5whHUgST2yRQoIWeACqMNT1ls9AItmgfj5NvSjVWm0CQGlV8tM6+6C5NTle
	q7PHxE+VAWqwWFnqSR6vskkjmPTGfQNPCPqFr9vdskernVZjN6RAQkDRZo8U6ZUPdT5e/8
	kRz6LzrPomA0/17Fi1WMjchySieWKdA=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622--Q-VQiHKNTqhMmDKoT43GA-1; Tue, 13 Jan 2026 01:26:36 -0500
X-MC-Unique: -Q-VQiHKNTqhMmDKoT43GA-1
X-Mimecast-MFC-AGG-ID: -Q-VQiHKNTqhMmDKoT43GA_1768285595
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a58c1c74a3so5173625ad.2
        for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 22:26:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768285595; x=1768890395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=spmIztd2EKRamvoD/LZmM+FSW3z8/AEEzT5gP8xnhtI=;
        b=a7KbzFUE+TkmYwGnj/Dz0DDd5Q2rnNsMQnQbEqVbGor3aDWewpInm6wpEZGFjuikq5
         R1+TCI4KrXtE2v4aI7PL9fRk/E36RxRHK8QwxaZlP0jg4z/uxOEZXE6WPANAg11t//W6
         UtS1bVFoDd/S+cm6IU3HxFOqwD65ZZaEmfFaFBMGVhFEGBA7jnOphKECarR/tUxteVa4
         MLhvw8JADZE9JVrK2h6Mp1C++ZNAXe+0Mm77GVCuRZl6tIAp/qWZy1URDJfk/swPSIsO
         lf0QXXU22bRYEbu1c/yb7mqMGg/sbOukw/2iLrifP0paOwetTmWvu93+deBknUK510eF
         Qwdg==
X-Forwarded-Encrypted: i=1; AJvYcCVYsPNeYoY7xq2SJHbaAU/S8Ck8QcwS2wxDfU5LGAmi4WWiJPm339XhENuP+KE9HlzrSUd99mBHqy8WhSPs+A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx1q6jz5UDi3FaqSLkx5pMYxOZgQ/euExl12gRtmGCxbetW3OI5
	L+UAE/Ue5ZM5mn76ZnBcyQu5vmHqQRGsiOZDJMELJOeIg+hCCyEdQkzSBOQ1DUGLeDwynyzBY/B
	koHYtCcxNwny+5Jj/r0Snc4lcbCKy44umkci8wOY2nuU6NsBaB0GJQN6NjH/wQ4v/bPqFfyb/Ro
	KXCm5GSyoekAYXnuRBlMFeZX/1ayBJXIUnTC9H6pRddLk=
X-Gm-Gg: AY/fxX6XzgM06feIKMwQNS75F/6Glj+EvPHZbP28huhBsIz+oeG0Yc6ZdvZTfl9x2KK
	1/FEqHrHTQKWZiX48zmhlIzsg3SDYAfcXleEshj0n5Ft9JEOuiENrkrkQXUAMccnZiAjYStewOX
	05T0XAfiIAz6NZ7kJkdNU7De4VPma94ryxBFc37+q9uV1gFaWpQnKjCnzfIn8STkBz50Q=
X-Received: by 2002:a17:903:2309:b0:2a1:1f28:d7ee with SMTP id d9443c01a7336-2a3ee4e7b36mr210661675ad.57.1768285595145;
        Mon, 12 Jan 2026 22:26:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkrFx7g5uPp/RVCdWIKCbFMZKKQEX7QrKp7mlNw23iQIFZMsd+pNgwa63opXK27IJ+KJs7xwsgiZ/pqlR/VE8=
X-Received: by 2002:a17:903:2309:b0:2a1:1f28:d7ee with SMTP id
 d9443c01a7336-2a3ee4e7b36mr210661285ad.57.1768285594667; Mon, 12 Jan 2026
 22:26:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260107210448.37851-1-simon.schippers@tu-dortmund.de>
 <20260107210448.37851-10-simon.schippers@tu-dortmund.de> <CACGkMEuQikCsHn9cdhVxxHbjKAyW288SPNxAyXQ7FWNxd7Qenw@mail.gmail.com>
 <bd41afae-cf1e-46ab-8948-4c7fa280b20f@tu-dortmund.de> <CACGkMEs8VHGjiLqn=-Gt5=WPMzqAXNM2GcK73dLarP9CQw3+rw@mail.gmail.com>
 <900c364b-f5ca-4458-a711-bf3e0433b537@tu-dortmund.de> <CACGkMEvqoxSiM65ectKaF=UQ6PJn6+FQyJ=_YjgCo+QBCj1umg@mail.gmail.com>
 <9aaf2420-089d-4fd9-824d-24982a86a70d@tu-dortmund.de>
In-Reply-To: <9aaf2420-089d-4fd9-824d-24982a86a70d@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 13 Jan 2026 14:26:20 +0800
X-Gm-Features: AZwV_QjHXGnkpFliLh_wH6DUhN9nDzDN7okYZwH3wTHNoiHdG1zRFgliI6b-EAo
Message-ID: <CACGkMEvpb-kAhC7hB2SOtBZ6L6O9SVGK3J9e0pN-XJmpztr2CA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 9/9] tun/tap & vhost-net: avoid ptr_ring
 tail-drop when qdisc is present
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mst@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jdxbvOcfIjN_u6XMK9eUxqTS4ehRbXzsGHf0GSdjE6o_1768285595
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 7:08=E2=80=AFPM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> On 1/12/26 03:22, Jason Wang wrote:
> > On Fri, Jan 9, 2026 at 6:15=E2=80=AFPM Simon Schippers
> > <simon.schippers@tu-dortmund.de> wrote:
> >>
> >> On 1/9/26 07:09, Jason Wang wrote:
> >>> On Thu, Jan 8, 2026 at 4:02=E2=80=AFPM Simon Schippers
> >>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>
> >>>> On 1/8/26 05:37, Jason Wang wrote:
> >>>>> On Thu, Jan 8, 2026 at 5:06=E2=80=AFAM Simon Schippers
> >>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>
> >>>>>> This commit prevents tail-drop when a qdisc is present and the ptr=
_ring
> >>>>>> becomes full. Once an entry is successfully produced and the ptr_r=
ing
> >>>>>> reaches capacity, the netdev queue is stopped instead of dropping
> >>>>>> subsequent packets.
> >>>>>>
> >>>>>> If producing an entry fails anyways, the tun_net_xmit returns
> >>>>>> NETDEV_TX_BUSY, again avoiding a drop. Such failures are expected =
because
> >>>>>> LLTX is enabled and the transmit path operates without the usual l=
ocking.
> >>>>>> As a result, concurrent calls to tun_net_xmit() are not prevented.
> >>>>>>
> >>>>>> The existing __{tun,tap}_ring_consume functions free space in the
> >>>>>> ptr_ring and wake the netdev queue. Races between this wakeup and =
the
> >>>>>> queue-stop logic could leave the queue stopped indefinitely. To pr=
event
> >>>>>> this, a memory barrier is enforced (as discussed in a similar
> >>>>>> implementation in [1]), followed by a recheck that wakes the queue=
 if
> >>>>>> space is already available.
> >>>>>>
> >>>>>> If no qdisc is present, the previous tail-drop behavior is preserv=
ed.
> >>>>>>
> >>>>>> +-------------------------+-----------+---------------+-----------=
-----+
> >>>>>> | pktgen benchmarks to    | Stock     | Patched with  | Patched wi=
th   |
> >>>>>> | Debian VM, i5 6300HQ,   |           | noqueue qdisc | fq_codel q=
disc |
> >>>>>> | 10M packets             |           |               |           =
     |
> >>>>>> +-----------+-------------+-----------+---------------+-----------=
-----+
> >>>>>> | TAP       | Transmitted | 196 Kpps  | 195 Kpps      | 185 Kpps  =
     |
> >>>>>> |           +-------------+-----------+---------------+-----------=
-----+
> >>>>>> |           | Lost        | 1618 Kpps | 1556 Kpps     | 0         =
     |
> >>>>>> +-----------+-------------+-----------+---------------+-----------=
-----+
> >>>>>> | TAP       | Transmitted | 577 Kpps  | 582 Kpps      | 578 Kpps  =
     |
> >>>>>> |  +        +-------------+-----------+---------------+-----------=
-----+
> >>>>>> | vhost-net | Lost        | 1170 Kpps | 1109 Kpps     | 0         =
     |
> >>>>>> +-----------+-------------+-----------+---------------+-----------=
-----+
> >>>>>>
> >>>>>> [1] Link: https://lore.kernel.org/all/20250424085358.75d817ae@kern=
el.org/
> >>>>>>
> >>>>>> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>>>>> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>>>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >>>>>> ---
> >>>>>>  drivers/net/tun.c | 31 +++++++++++++++++++++++++++++--
> >>>>>>  1 file changed, 29 insertions(+), 2 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >>>>>> index 71b6981d07d7..74d7fd09e9ba 100644
> >>>>>> --- a/drivers/net/tun.c
> >>>>>> +++ b/drivers/net/tun.c
> >>>>>> @@ -1008,6 +1008,8 @@ static netdev_tx_t tun_net_xmit(struct sk_bu=
ff *skb, struct net_device *dev)
> >>>>>>         struct netdev_queue *queue;
> >>>>>>         struct tun_file *tfile;
> >>>>>>         int len =3D skb->len;
> >>>>>> +       bool qdisc_present;
> >>>>>> +       int ret;
> >>>>>>
> >>>>>>         rcu_read_lock();
> >>>>>>         tfile =3D rcu_dereference(tun->tfiles[txq]);
> >>>>>> @@ -1060,13 +1062,38 @@ static netdev_tx_t tun_net_xmit(struct sk_=
buff *skb, struct net_device *dev)
> >>>>>>
> >>>>>>         nf_reset_ct(skb);
> >>>>>>
> >>>>>> -       if (ptr_ring_produce(&tfile->tx_ring, skb)) {
> >>>>>> +       queue =3D netdev_get_tx_queue(dev, txq);
> >>>>>> +       qdisc_present =3D !qdisc_txq_has_no_queue(queue);
> >>>>>> +
> >>>>>> +       spin_lock(&tfile->tx_ring.producer_lock);
> >>>>>> +       ret =3D __ptr_ring_produce(&tfile->tx_ring, skb);
> >>>>>> +       if (__ptr_ring_produce_peek(&tfile->tx_ring) && qdisc_pres=
ent) {
> >>>>>> +               netif_tx_stop_queue(queue);
> >>>>>> +               /* Avoid races with queue wake-up in
> >>>>>> +                * __{tun,tap}_ring_consume by waking if space is
> >>>>>> +                * available in a re-check.
> >>>>>> +                * The barrier makes sure that the stop is visible=
 before
> >>>>>> +                * we re-check.
> >>>>>> +                */
> >>>>>> +               smp_mb__after_atomic();
> >>>>>> +               if (!__ptr_ring_produce_peek(&tfile->tx_ring))
> >>>>>> +                       netif_tx_wake_queue(queue);
> >>>>>
> >>>>> I'm not sure I will get here, but I think those should be moved to =
the
> >>>>> following if(ret) check. If __ptr_ring_produce() succeed, there's n=
o
> >>>>> need to bother with those queue stop/wake logic?
> >>>>
> >>>> There is a need for that. If __ptr_ring_produce_peek() returns -ENOS=
PC,
> >>>> we stop the queue proactively.
> >>>
> >>> This seems to conflict with the following NETDEV_TX_BUSY. Or is
> >>> NETDEV_TX_BUSY prepared for the xdp_xmit?
> >>
> >> Am I not allowed to stop the queue and then return NETDEV_TX_BUSY?
> >
> > No, I mean I don't understand why we still need to peek since we've
> > already used NETDEV_TX_BUSY.
>
> Yes, if __ptr_ring_produce() returns -ENOSPC, there is no need to check
> __ptr_ring_produce_peek(). I agree with you on this point and will update
> the code accordingly. In all other cases, checking
> __ptr_ring_produce_peek() is still required in order to proactively stop
> the queue.
>
> >
> >> And I do not understand the connection with xdp_xmit.
> >
> > Since there's we don't modify xdp_xmit path, so even if we peek next
> > ndo_start_xmit can still hit ring full.
>
> Ah okay. Would you apply the same stop-and-recheck logic in
> tun_xdp_xmit when __ptr_ring_produce() fails to produce it, or is that
> not permitted there?

I think it won't work as there's no qdsic logic implemented in the XDP
xmit path. NETDEV_TX_BUSY for tun_net_xmit() should be sufficient.

>
> Apart from that, as noted in the commit message, since we are using LLTX,
> hitting a full ring is still possible anyway. I could see that especially
> at multiqueue tests with pktgen by looking at the qdisc requeues.
>
> Thanks

Thanks

>
> >
> > Thanks
> >
> >>
> >>>
> >>>>
> >>>> I believe what you are aiming for is to always stop the queue if(ret=
),
> >>>> which I can agree with. In that case, I would simply change the cond=
ition
> >>>> to:
> >>>>
> >>>> if (qdisc_present && (ret || __ptr_ring_produce_peek(&tfile->tx_ring=
)))
> >>>>
> >>>>>
> >>>>>> +       }
> >>>>>> +       spin_unlock(&tfile->tx_ring.producer_lock);
> >>>>>> +
> >>>>>> +       if (ret) {
> >>>>>> +               /* If a qdisc is attached to our virtual device,
> >>>>>> +                * returning NETDEV_TX_BUSY is allowed.
> >>>>>> +                */
> >>>>>> +               if (qdisc_present) {
> >>>>>> +                       rcu_read_unlock();
> >>>>>> +                       return NETDEV_TX_BUSY;
> >>>>>> +               }
> >>>>>>                 drop_reason =3D SKB_DROP_REASON_FULL_RING;
> >>>>>>                 goto drop;
> >>>>>>         }
> >>>>>>
> >>>>>>         /* dev->lltx requires to do our own update of trans_start =
*/
> >>>>>> -       queue =3D netdev_get_tx_queue(dev, txq);
> >>>>>>         txq_trans_cond_update(queue);
> >>>>>>
> >>>>>>         /* Notify and wake up reader process */
> >>>>>> --
> >>>>>> 2.43.0
> >>>>>>
> >>>>>
> >>>>> Thanks
> >>>>>
> >>>>
> >>>
> >>> Thanks
> >>>
> >>
> >
>

