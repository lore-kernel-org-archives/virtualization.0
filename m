Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243BB390218
	for <virtualization@lists.linux.dev>; Thu, 26 Mar 2026 02:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774492906; cv=none; b=JxamdQ35ntjlfggW6MVhahLKquCdBjG0jdQb5WrV/SLdIkIAgBcKdiklqgncg9n1tfZlT69cwWkhiwDSyAuLx53YOg4KHhSKpjPVszbTTmF/ZuqN1yxJOaa1y5sceyp37sOWY/qRMb2eT/lVmIlk23aAXTHZqNii4uJKW9Jlnt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774492906; c=relaxed/simple;
	bh=NZuXp9OMgbMNwXIjDFC+3NSoAl7iWLz7wHWTMwoa3bQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdJNEpcxHTwYqdgONVa+4NAGeEQBe+e/65W2oMbO86IKX6fdUOQN47V8/z6s2QtbsneC69/pJbzweNf07MwP2sDQlITl87PXj6R73y1/nV5Db5kdmpA/JtmPwt0o2cxtKgU6YKSvoJuhxKKRnEZRCWFTgKjlaH+Z62R4vG8dTkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GftbzEJl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GftbzEJl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774492904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e03kIxAl55kIcXh5aMreNNyQExpmH90DzHI1x2EvTDI=;
	b=GftbzEJl8bGDF2KNSyw/ljiydj/CxAjBNMAD0JJv7PDvt0HiquY3z9IlTbm7EM8I4Q6HZQ
	GTK/AdCoYlxQhrpskHfhq/eClNi7IWnTCJo0g/TjTirhkZJazP5NCix90Vd39Am2iUwveW
	5BM+/U9qsadVUg/d7kfx9MZn04hXYOI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-D-P7A7c3NN2i5uGE7oOrcA-1; Wed, 25 Mar 2026 22:41:42 -0400
X-MC-Unique: D-P7A7c3NN2i5uGE7oOrcA-1
X-Mimecast-MFC-AGG-ID: D-P7A7c3NN2i5uGE7oOrcA_1774492901
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35ba237d2a1so368842a91.1
        for <virtualization@lists.linux.dev>; Wed, 25 Mar 2026 19:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774492901; x=1775097701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e03kIxAl55kIcXh5aMreNNyQExpmH90DzHI1x2EvTDI=;
        b=gQihtlZyrKn2lXgIP7Sxw87qAxreopdqn0YyTQdv/r8hlwih5SXwXw7Yp9Nbc5BG0m
         BTH7RGH5zoaD4UZ7drZZn/VCMCxAu8iKTHzmn0Tw8qgyfI60kJ7h7wKx2+EZngPaOX2f
         4zXDERo5Z2A0Ayt2I1iNn+jF/g/AJWizXRcfSZkQvGDeYdDlwcMRFvPbs3aBH9MmX/Wx
         Co4fcfzkwR3JGYXiWFkxgfAY4Rgli/KSy01tXggYNmDho3nIZoHDpMouj43NMLqtwY0+
         2CUxSEs6q35RGD8Kmy7WQrCCJcfzoRZaXbzxjYLWPSx9uNdKwWhLFYJjVMmHxfMRKu7f
         nOcg==
X-Forwarded-Encrypted: i=1; AJvYcCX6MalwUGkrm/7ldKzdlkCaCldQC2W6BQmdCjlF/Q1wT+uDs83OOZcP5iXpASsfsYM9QKLmII1VYY4SEIxGhQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxcPmsER52ZK5+EcPHX0ND+XiGv5UPjVREWRdehSjHuwAxQaWOu
	vSGz6uNg46zJNZHt5DQ/smVPScsGhN1qwBMfkCjMXUA/9SKCHsWLrBiHRkbX2ailiB0wYc+IgZr
	98vP9e+MYxUk9p9nyY+8rcNNrvkRMLc7MeZssCgwzllff3jFmAkbMeaeFc4BKA4nR4XGyCIM4FC
	/Z9HLDA7hh+l+xu+bpTVesESaKXpHQmp3rRbI8ipEkSZQ=
X-Gm-Gg: ATEYQzw2G6cm37VGSu1WN58cW7k/MAW+hI2ZnD24QS2W3EZgFfzecZoolDFgIzi90Oq
	IQGtaoXLK1pa7un2Y+z+xf1F9hophjJgpc9tWZI9y7nOAAI3LJIKpc2QlaB0JBoyA492V60sUxn
	45R4lFSfjhK60qQr6RwVTHyPpTlr0L9nv3FD3z7P21EhfJ26etTerbwlfRuCvLrT4BZejJ4Cg8O
	kvO
X-Received: by 2002:a17:90b:278e:b0:359:8f63:9a25 with SMTP id 98e67ed59e1d1-35c007b464emr8662454a91.3.1774492901091;
        Wed, 25 Mar 2026 19:41:41 -0700 (PDT)
X-Received: by 2002:a17:90b:278e:b0:359:8f63:9a25 with SMTP id
 98e67ed59e1d1-35c007b464emr8662429a91.3.1774492900454; Wed, 25 Mar 2026
 19:41:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260312130639.138988-1-simon.schippers@tu-dortmund.de>
 <20260312130639.138988-5-simon.schippers@tu-dortmund.de> <CACGkMEtN9XgYPGHQg4TEWEsa_UcMbcnzO=VaTFT=0Tn4BayMDw@mail.gmail.com>
 <0908392d-6314-4141-b908-6c9a880ba0a4@tu-dortmund.de> <cda710f8-033a-4772-b5ce-a2cfddf42bea@tu-dortmund.de>
In-Reply-To: <cda710f8-033a-4772-b5ce-a2cfddf42bea@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 26 Mar 2026 10:41:29 +0800
X-Gm-Features: AQROBzCWaeA2at0khp-5AihPvjzqWo4VROly4dD8VgJGx1hCknikvahWTNJja5M
Message-ID: <CACGkMEuLqxnz=GtdKp3-u0egkGT_eZUgBBwvvtHcgAYpLJv-UA@mail.gmail.com>
Subject: Re: [PATCH net-next v8 4/4] tun/tap & vhost-net: avoid ptr_ring
 tail-drop when a qdisc is present
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mst@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 88KIMCK-4aePlpwGG3De2TlxSvQCyWzBAUPpJtFwMEU_1774492901
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 10:48=E2=80=AFPM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> On 3/24/26 11:14, Simon Schippers wrote:
> > On 3/24/26 02:47, Jason Wang wrote:
> >> On Thu, Mar 12, 2026 at 9:07=E2=80=AFPM Simon Schippers
> >> <simon.schippers@tu-dortmund.de> wrote:
> >>>
> >>> This commit prevents tail-drop when a qdisc is present and the ptr_ri=
ng
> >>> becomes full. Once an entry is successfully produced and the ptr_ring
> >>> reaches capacity, the netdev queue is stopped instead of dropping
> >>> subsequent packets.
> >>>
> >>> If producing an entry fails anyways due to a race, tun_net_xmit retur=
ns
> >>> NETDEV_TX_BUSY, again avoiding a drop. Such races are expected becaus=
e
> >>> LLTX is enabled and the transmit path operates without the usual lock=
ing.
> >>>
> >>> The existing __tun_wake_queue() function wakes the netdev queue. Race=
s
> >>> between this wakeup and the queue-stop logic could leave the queue
> >>> stopped indefinitely. To prevent this, a memory barrier is enforced
> >>> (as discussed in a similar implementation in [1]), followed by a rech=
eck
> >>> that wakes the queue if space is already available.
> >>>
> >>> If no qdisc is present, the previous tail-drop behavior is preserved.
> >>
> >> I wonder if we need a dedicated TUN flag to enable this. With this new
> >> flag, we can even prevent TUN from using noqueue (not sure if it's
> >> possible or not).
> >>
> >
> > Except of the slight regressions because of this patchset I do not see
> > a reason for such a flag.
> >
> > I have never seen that the driver prevents noqueue. For example you can
> > set noqueue to your ethernet interface and under load you soon get
> >
> > net_crit_ratelimited("Virtual device %s asks to queue packet!\n",
> >                                            dev->name);
> >
> > followed by a -ENETDOWN. And this is not prevented even though it is
> > clearly not something a user wants.
> >
> >>>
> >>> Benchmarks:
> >>> The benchmarks show a slight regression in raw transmission performan=
ce,
> >>> though no packets are lost anymore.
> >>>
> >>> The previously introduced threshold to only wake after the queue stop=
ped
> >>> and half of the ring was consumed showed to be a descent choice:
> >>> Waking the queue whenever a consume made space in the ring strongly
> >>> degrades performance for tap, while waking only when the ring is empt=
y
> >>> is too late and also hurts throughput for tap & tap+vhost-net.
> >>> Other ratios (3/4, 7/8) showed similar results (not shown here), so
> >>> 1/2 was chosen for the sake of simplicity for both tun/tap and
> >>> tun/tap+vhost-net.
> >>>
> >>> Test setup:
> >>> AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU threads;
> >>> Average over 20 runs @ 100,000,000 packets. SRSO and spectre v2
> >>> mitigations disabled.
> >>>
> >>> Note for tap+vhost-net:
> >>> XDP drop program active in VM -> ~2.5x faster, slower for tap due to
> >>> more syscalls (high utilization of entry_SYSRETQ_unsafe_stack in perf=
)
> >>>
> >>> +--------------------------+--------------+----------------+---------=
-+
> >>> | 1 thread                 | Stock        | Patched with   | diff    =
 |
> >>> | sending                  |              | fq_codel qdisc |         =
 |
> >>> +------------+-------------+--------------+----------------+---------=
-+
> >>> | TAP        | Transmitted | 1.151 Mpps   | 1.139 Mpps     | -1.1%   =
 |
> >>> |            +-------------+--------------+----------------+---------=
-+
> >>> |            | Lost/s      | 3.606 Mpps   | 0 pps          |         =
 |
> >>> +------------+-------------+--------------+----------------+---------=
-+
> >>> | TAP        | Transmitted | 3.948 Mpps   | 3.738 Mpps     | -5.3%   =
 |
> >>> |            +-------------+--------------+----------------+---------=
-+
> >>> | +vhost-net | Lost/s      | 496.5 Kpps   | 0 pps          |         =
 |
> >>> +------------+-------------+--------------+----------------+---------=
-+
> >>>
> >>> +--------------------------+--------------+----------------+---------=
-+
> >>> | 2 threads                | Stock        | Patched with   | diff    =
 |
> >>> | sending                  |              | fq_codel qdisc |         =
 |
> >>> +------------+-------------+--------------+----------------+---------=
-+
> >>> | TAP        | Transmitted | 1.133 Mpps   | 1.109 Mpps     | -2.1%   =
 |
> >>> |            +-------------+--------------+----------------+---------=
-+
> >>> |            | Lost/s      | 8.269 Mpps   | 0 pps          |         =
 |
> >>> +------------+-------------+--------------+----------------+---------=
-+
> >>> | TAP        | Transmitted | 3.820 Mpps   | 3.513 Mpps     | -8.0%   =
 |
> >>> |            +-------------+--------------+----------------+---------=
-+
> >>> | +vhost-net | Lost/s      | 4.961 Mpps   | 0 pps          |         =
 |
> >>> +------------+-------------+--------------+----------------+---------=
-+
> >>>
> >>> [1] Link: https://lore.kernel.org/all/20250424085358.75d817ae@kernel.=
org/
> >>>
> >>> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >>> ---
> >>>  drivers/net/tun.c | 30 ++++++++++++++++++++++++++++--
> >>>  1 file changed, 28 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >>> index b86582cc6cb6..9b7daec69acd 100644
> >>> --- a/drivers/net/tun.c
> >>> +++ b/drivers/net/tun.c
> >>> @@ -1011,6 +1011,8 @@ static netdev_tx_t tun_net_xmit(struct sk_buff =
*skb, struct net_device *dev)
> >>>         struct netdev_queue *queue;
> >>>         struct tun_file *tfile;
> >>>         int len =3D skb->len;
> >>> +       bool qdisc_present;
> >>> +       int ret;
> >>>
> >>>         rcu_read_lock();
> >>>         tfile =3D rcu_dereference(tun->tfiles[txq]);
> >>> @@ -1063,13 +1065,37 @@ static netdev_tx_t tun_net_xmit(struct sk_buf=
f *skb, struct net_device *dev)
> >>>
> >>>         nf_reset_ct(skb);
> >>>
> >>> -       if (ptr_ring_produce(&tfile->tx_ring, skb)) {
> >>> +       queue =3D netdev_get_tx_queue(dev, txq);
> >>> +       qdisc_present =3D !qdisc_txq_has_no_queue(queue);
> >>> +
> >>> +       spin_lock(&tfile->tx_ring.producer_lock);
> >>> +       ret =3D __ptr_ring_produce(&tfile->tx_ring, skb);
> >>> +       if (__ptr_ring_produce_peek(&tfile->tx_ring) && qdisc_present=
) {
> >>
> >> So, it's possible that the administrator is switching between noqueue
> >> and another qdisc. So ptr_ring_produce() can fail here, do we need to
> >> check that or not?
> >>
> >
> > Do you mean that? My thoughts:
> >
> > Switching from noqueue to some qdisc can cause a
> >
> > net_crit_ratelimited("Virtual device %s asks to queue packet!\n",
> >                                            dev->name);
> >
> > followed by a return of -ENETDOWN in __dev_queue_xmit().
> > This is because tun_net_xmit detects some qdisc with
> >
> > qdisc_present =3D !qdisc_txq_has_no_queue(queue);
> >
> > and returns NETDEV_TX_BUSY even though __dev_queue_xmit() did still
> > detect noqueue.
> >
> > I am not sure how to solve this/if this has to be solved.
> > I do not see a proper way to avoid parallel execution of ndo_start_xmit
> > and a qdisc change (dev_graft_qdisc only takes qdisc_skb_head lock).
> >
> > And from my understanding the veth implementation faces the same issue.
>
> How about rechecking if a qdisc is connected?
> This would avoid -ENETDOWN.
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index f48dc299e4b2..2731a1a70732 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4845,10 +4845,17 @@ int __dev_queue_xmit(struct sk_buff *skb, struct =
net_device *sb_dev)
>                                 if (is_list)
>                                         rc =3D NETDEV_TX_OK;
>                         }
> +                       bool qdisc_present =3D !qdisc_txq_has_no_queue(tx=
q);
>                         HARD_TX_UNLOCK(dev, txq);
>                         if (!skb) /* xmit completed */
>                                 goto out;
>
> +                       /* Maybe a qdisc was connected in the meantime */
> +                       if (qdisc_present) {
> +                               kfree_skb(skb);
> +                               goto out;
> +                       }
> +
>                         net_crit_ratelimited("Virtual device %s asks to q=
ueue packet!\n",
>                                              dev->name);
>                         /* NETDEV_TX_BUSY or queue was stopped */
>

Probably not, and we likely won't hit this warning because qdisc could
not be changed during ndo_start_xmit().

I meant something like this:

1) set noqueue to tuntap
2) produce packets so tuntap is full
3) set e.g fq_codel to tuntap
4) then we can hit the failure of __ptr_ring_produce()

Rethink of the code, it looks just fine.

>
> >
> >
> > Switching from some qdisc to noqueue is no problem I think.
> >
> >>> +               netif_tx_stop_queue(queue);
> >>> +               /* Avoid races with queue wake-ups in __tun_wake_queu=
e by
> >>> +                * waking if space is available in a re-check.
> >>> +                * The barrier makes sure that the stop is visible be=
fore
> >>> +                * we re-check.
> >>> +                */
> >>> +               smp_mb__after_atomic();
> >>
> >> Let's document which barrier is paired with this.
> >>
> >
> > I am basically copying the (old) logic of veth [1] proposed by
> > Jakub Kicinski. I must admit I am not 100% sure what it pairs with.
> >
> > [1] Link: https://lore.kernel.org/all/20250424085358.75d817ae@kernel.or=
g/

So it looks like it implicitly tries to pair with tun_ring_consume():

1) spinlock(consumer_lock)
2) store NULL to ptr_ring // STORE
3) spinunlock(consumer_lock) // RELEASE
4) spinlock(consumer_lock) // ACQURE
5) check empty
6) spinunlock(consumer_lock)
7) netif_wakeup_queue() // test_and_set() which is an RMW

RELEASE + ACQUIRE implies a full barrier

I see several problems

1) Due to batch consumption, we may get spurious wakeups under heavy
load (we can try disabling batch consuming to see if it helps).
2) So the barriers don't help but would slow down the consuming
3) Two spinlocks were used instead of one, this is another reason we
will see a performance regression
4) Tricky code that needs to be understood or at least requires a comment t=
weak.

Note that due to ~IFF_TX_SKB_SHARING, pktgen can't clone skbs, so we
may not notice the real degradation.

> >
> >>> +               if (!__ptr_ring_produce_peek(&tfile->tx_ring))
> >>> +                       netif_tx_wake_queue(queue);
> >>> +       }
> >>> +       spin_unlock(&tfile->tx_ring.producer_lock);
> >>> +
> >>> +       if (ret) {
> >>> +               /* If a qdisc is attached to our virtual device,
> >>> +                * returning NETDEV_TX_BUSY is allowed.
> >>> +                */
> >>> +               if (qdisc_present) {
> >>> +                       rcu_read_unlock();
> >>> +                       return NETDEV_TX_BUSY;
> >>> +               }
> >>>                 drop_reason =3D SKB_DROP_REASON_FULL_RING;
> >>>                 goto drop;
> >>>         }
> >>>
> >>>         /* dev->lltx requires to do our own update of trans_start */
> >>> -       queue =3D netdev_get_tx_queue(dev, txq);
> >>>         txq_trans_cond_update(queue);
> >>>
> >>>         /* Notify and wake up reader process */
> >>> --
> >>> 2.43.0
> >>>
> >>
> >> Thanks
> >>
>

Thanks

