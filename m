Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0CE2C17B3
	for <virtualization@lists.linux.dev>; Fri,  9 Jan 2026 06:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767938993; cv=none; b=ROgNoxC4P5nfl74CxBCIgvVE+CS7RIuvuw++tMpgoU60M5hhM2j619QIJd98gVqBSJs5ru8uqtI4HL0uNpjyO99UnQGBu3n7u+/ukjAq6u5IMHnC/UPtvFcnPFYmBI2tbUi+Gufgqgur5qjHIHhTTB1R9CuuLcaztlPu9v4m8Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767938993; c=relaxed/simple;
	bh=/Whxa26upJUenWNr2ZsZaRmoZUHwHeEOLf+P/McVcP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZyzlrgdIdHbhc9D4E8go6b1mSqRv7b/68XrwLFQ7WufNUFcQc8oa8SY3DmcQcVIC0+pi2infWsQByb8++6d9DXGCHC5UIyMDcf9BHTxcyWze7sE73bmN2GVBIG3kcVWtSevcLvQQtP725sC+WhqlGA2jdW/Ic4maDdWe69//grc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iyzUeis3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iyzUeis3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767938988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UsTn3TvI9UsxAE5f1Ok27om1Z5aK/et/A9uoT4IK01s=;
	b=iyzUeis3hv7/LbblWWmHIJTGh8dx76JrruOMexGelNOEkTubeviihqxR7N0v/1Rofy3jvV
	kxeEcHLAe8dzvan7N2UscNLRkziTN+l0Y/dODY/udYOe8yKIOitbeHHVj1xZD5VXAChZwM
	8MCGBY388iOP1+iJSpMZWD7mhaC5eho=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-yJlVSOh5NLOqdZaYtZ_Q7A-1; Fri, 09 Jan 2026 01:09:47 -0500
X-MC-Unique: yJlVSOh5NLOqdZaYtZ_Q7A-1
X-Mimecast-MFC-AGG-ID: yJlVSOh5NLOqdZaYtZ_Q7A_1767938986
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34cc8bf226cso5339217a91.3
        for <virtualization@lists.linux.dev>; Thu, 08 Jan 2026 22:09:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767938986; x=1768543786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UsTn3TvI9UsxAE5f1Ok27om1Z5aK/et/A9uoT4IK01s=;
        b=MTVl2Zsp4WIg2U0LyOyAhLdZHPA49kY824mP3CTXGP05L4dbDcULY79V5ZLdQp0+2C
         aggR4wkByRPQ4CXPkks9VnJ1eJHokPYkddV2GVifR1y2+5eYOmZYW/Jb6jYnP3YKNB5Y
         /zwkHNAswOsdNyUUBLd8ByD4ZReV/Ym24RPjmMs6vL3XeHDZfmYECDCki9B9zirPCXu8
         3Tii0WknyWr5ipJZQXkGk5YpMwSW3m0W8Qw7UXaiwUdP6Y3j8aIRYRkdCXTZRFhAshEW
         JSop7xIAuET8h7r5Eyvvh0wyKdObeIwgYFIpQ7+aqIs9x6GFmeK9j6vScj3RyroX7X+B
         mLcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXInJQagr69q2MwDb8LZLRAK4JzQefgXUPeVLp+zuAd04rHFWGbsMEoO9e6oHuHzb1bdZQ26XIpoGVKALL7zA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxUY0QnTZ5ovXsVlon2kI0aBPFX0G5JFow+ftX4283qbWcL7UcU
	/AlKSi0HMklET+urWug4gbnQA+r3PSQrmfRyCpxPR50FHOxUhwxywocLKwbNT4dS2Ve29zQQnVH
	nAgIrZObOK4exfbqXO+ERS/OCyXqy8jkJqeapXt0Gap1hV4iNCr3sIkU9lzUZUus6zO/tV7OhAA
	r+AAMS03l//5lTQAlDn+50vo8W5/yK3QZVP1U6rUo7wqQ=
X-Gm-Gg: AY/fxX7D9jku2l+RLCC7SYjdF5GoRGyXioE71/vPO8nxQ9b9TXJ+G8onrY2329PIJRE
	B9Hgtcxnq6Oag+GOfXpAZo/W0/umCc87/jGWybGQv0/DP6KSiOM7aRKIAjq4jswkDFqxsMuT/ec
	CZCtesOA7U5mFhZuhRVEx6S9BNpzUiKNdrhNH/3BlHIKh8NBBk+snq42LFeDTT0o0=
X-Received: by 2002:a17:90b:1c87:b0:34c:a35d:de16 with SMTP id 98e67ed59e1d1-34f68c282c6mr8200199a91.11.1767938986159;
        Thu, 08 Jan 2026 22:09:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwd/+ri/7IRW9go6ZEYvBIdoZ0mcrieqtY+k0sd20Yk2cfAv4k30KxCjCWEGVfJYZgJ6AXw+vCl3L0aSy822U=
X-Received: by 2002:a17:90b:1c87:b0:34c:a35d:de16 with SMTP id
 98e67ed59e1d1-34f68c282c6mr8200176a91.11.1767938985646; Thu, 08 Jan 2026
 22:09:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260107210448.37851-1-simon.schippers@tu-dortmund.de>
 <20260107210448.37851-10-simon.schippers@tu-dortmund.de> <CACGkMEuQikCsHn9cdhVxxHbjKAyW288SPNxAyXQ7FWNxd7Qenw@mail.gmail.com>
 <bd41afae-cf1e-46ab-8948-4c7fa280b20f@tu-dortmund.de>
In-Reply-To: <bd41afae-cf1e-46ab-8948-4c7fa280b20f@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 9 Jan 2026 14:09:34 +0800
X-Gm-Features: AQt7F2pltZRUg0ITK9mA3g-3JDbVoNoxDdcEgN4kSv6FJ9EIKXkiqcx-w4p6MXg
Message-ID: <CACGkMEs8VHGjiLqn=-Gt5=WPMzqAXNM2GcK73dLarP9CQw3+rw@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: -WEhV0emvnQupMfK-Q2Kh-d7GBwh-m3ymKz1agwFPxE_1767938986
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 4:02=E2=80=AFPM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> On 1/8/26 05:37, Jason Wang wrote:
> > On Thu, Jan 8, 2026 at 5:06=E2=80=AFAM Simon Schippers
> > <simon.schippers@tu-dortmund.de> wrote:
> >>
> >> This commit prevents tail-drop when a qdisc is present and the ptr_rin=
g
> >> becomes full. Once an entry is successfully produced and the ptr_ring
> >> reaches capacity, the netdev queue is stopped instead of dropping
> >> subsequent packets.
> >>
> >> If producing an entry fails anyways, the tun_net_xmit returns
> >> NETDEV_TX_BUSY, again avoiding a drop. Such failures are expected beca=
use
> >> LLTX is enabled and the transmit path operates without the usual locki=
ng.
> >> As a result, concurrent calls to tun_net_xmit() are not prevented.
> >>
> >> The existing __{tun,tap}_ring_consume functions free space in the
> >> ptr_ring and wake the netdev queue. Races between this wakeup and the
> >> queue-stop logic could leave the queue stopped indefinitely. To preven=
t
> >> this, a memory barrier is enforced (as discussed in a similar
> >> implementation in [1]), followed by a recheck that wakes the queue if
> >> space is already available.
> >>
> >> If no qdisc is present, the previous tail-drop behavior is preserved.
> >>
> >> +-------------------------+-----------+---------------+---------------=
-+
> >> | pktgen benchmarks to    | Stock     | Patched with  | Patched with  =
 |
> >> | Debian VM, i5 6300HQ,   |           | noqueue qdisc | fq_codel qdisc=
 |
> >> | 10M packets             |           |               |               =
 |
> >> +-----------+-------------+-----------+---------------+---------------=
-+
> >> | TAP       | Transmitted | 196 Kpps  | 195 Kpps      | 185 Kpps      =
 |
> >> |           +-------------+-----------+---------------+---------------=
-+
> >> |           | Lost        | 1618 Kpps | 1556 Kpps     | 0             =
 |
> >> +-----------+-------------+-----------+---------------+---------------=
-+
> >> | TAP       | Transmitted | 577 Kpps  | 582 Kpps      | 578 Kpps      =
 |
> >> |  +        +-------------+-----------+---------------+---------------=
-+
> >> | vhost-net | Lost        | 1170 Kpps | 1109 Kpps     | 0             =
 |
> >> +-----------+-------------+-----------+---------------+---------------=
-+
> >>
> >> [1] Link: https://lore.kernel.org/all/20250424085358.75d817ae@kernel.o=
rg/
> >>
> >> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >> ---
> >>  drivers/net/tun.c | 31 +++++++++++++++++++++++++++++--
> >>  1 file changed, 29 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >> index 71b6981d07d7..74d7fd09e9ba 100644
> >> --- a/drivers/net/tun.c
> >> +++ b/drivers/net/tun.c
> >> @@ -1008,6 +1008,8 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *=
skb, struct net_device *dev)
> >>         struct netdev_queue *queue;
> >>         struct tun_file *tfile;
> >>         int len =3D skb->len;
> >> +       bool qdisc_present;
> >> +       int ret;
> >>
> >>         rcu_read_lock();
> >>         tfile =3D rcu_dereference(tun->tfiles[txq]);
> >> @@ -1060,13 +1062,38 @@ static netdev_tx_t tun_net_xmit(struct sk_buff=
 *skb, struct net_device *dev)
> >>
> >>         nf_reset_ct(skb);
> >>
> >> -       if (ptr_ring_produce(&tfile->tx_ring, skb)) {
> >> +       queue =3D netdev_get_tx_queue(dev, txq);
> >> +       qdisc_present =3D !qdisc_txq_has_no_queue(queue);
> >> +
> >> +       spin_lock(&tfile->tx_ring.producer_lock);
> >> +       ret =3D __ptr_ring_produce(&tfile->tx_ring, skb);
> >> +       if (__ptr_ring_produce_peek(&tfile->tx_ring) && qdisc_present)=
 {
> >> +               netif_tx_stop_queue(queue);
> >> +               /* Avoid races with queue wake-up in
> >> +                * __{tun,tap}_ring_consume by waking if space is
> >> +                * available in a re-check.
> >> +                * The barrier makes sure that the stop is visible bef=
ore
> >> +                * we re-check.
> >> +                */
> >> +               smp_mb__after_atomic();
> >> +               if (!__ptr_ring_produce_peek(&tfile->tx_ring))
> >> +                       netif_tx_wake_queue(queue);
> >
> > I'm not sure I will get here, but I think those should be moved to the
> > following if(ret) check. If __ptr_ring_produce() succeed, there's no
> > need to bother with those queue stop/wake logic?
>
> There is a need for that. If __ptr_ring_produce_peek() returns -ENOSPC,
> we stop the queue proactively.

This seems to conflict with the following NETDEV_TX_BUSY. Or is
NETDEV_TX_BUSY prepared for the xdp_xmit?

>
> I believe what you are aiming for is to always stop the queue if(ret),
> which I can agree with. In that case, I would simply change the condition
> to:
>
> if (qdisc_present && (ret || __ptr_ring_produce_peek(&tfile->tx_ring)))
>
> >
> >> +       }
> >> +       spin_unlock(&tfile->tx_ring.producer_lock);
> >> +
> >> +       if (ret) {
> >> +               /* If a qdisc is attached to our virtual device,
> >> +                * returning NETDEV_TX_BUSY is allowed.
> >> +                */
> >> +               if (qdisc_present) {
> >> +                       rcu_read_unlock();
> >> +                       return NETDEV_TX_BUSY;
> >> +               }
> >>                 drop_reason =3D SKB_DROP_REASON_FULL_RING;
> >>                 goto drop;
> >>         }
> >>
> >>         /* dev->lltx requires to do our own update of trans_start */
> >> -       queue =3D netdev_get_tx_queue(dev, txq);
> >>         txq_trans_cond_update(queue);
> >>
> >>         /* Notify and wake up reader process */
> >> --
> >> 2.43.0
> >>
> >
> > Thanks
> >
>

Thanks

