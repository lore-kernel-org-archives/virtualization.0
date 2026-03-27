Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CC13D8102
	for <virtualization@lists.linux.dev>; Fri, 27 Mar 2026 08:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774601292; cv=none; b=NhBYtBGjvAC+63lLWxWJC2VHx/ESZTKix7QUEskhYJWYtMbsnOcmi2Nfw+FuTTPJlJ6RIIcApV13AexJdwqfGT7DQ9WlH5jtc6Umys/ZeNs52E20r5dveSOHYpjTvXymXZHdN0NcSrnRXJPJW3gxMCbvtEsMD2zZ7PjQFsoqY64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774601292; c=relaxed/simple;
	bh=aRgZ/HLn9oeB1niH5ejb6mC5uLbstyAg2vsrBcznv+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ldxgUxjg1BT4psDJ3R8r4xy9MLjOLhDHghpuzKpiTiqS6YR9JZ+PBn1P8eDOzFkS/RxxcFTI+Q/lQg0hdwAsaVAPmZZxMGlD7mU06DKGr9dAdv1VlLxsxxOaajBfjE8LOxASw2Z0W/qZjgmfdx51AnA+ZtOyhqOt3QRH/jqLF20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cWPt+9OV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cWPt+9OV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774601289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k+S/zVltfSGpq+zXMiBguLfMzBi5E+EXDjK3b7dwn54=;
	b=cWPt+9OVIHlcc6VHzbGUOTk7va3K02OC+2TYh8/7bNiDgmWao7K6H9/Z4HChgjyCYCm7aq
	2GmgXWMn1AfwjqQ/LXq5sudQPYpxMW9paO+lamhQezr2FhSS+oQYXMor9M3c+phiDXylIv
	D6K5bHybdk2MsWw/PdBDxn6f951DPtA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-rYEWcr2SN22NjeczdYEaVA-1; Fri, 27 Mar 2026 04:48:06 -0400
X-MC-Unique: rYEWcr2SN22NjeczdYEaVA-1
X-Mimecast-MFC-AGG-ID: rYEWcr2SN22NjeczdYEaVA_1774601285
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-439cbc5fb4fso1743954f8f.0
        for <virtualization@lists.linux.dev>; Fri, 27 Mar 2026 01:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774601285; x=1775206085;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k+S/zVltfSGpq+zXMiBguLfMzBi5E+EXDjK3b7dwn54=;
        b=k8PG3UwD/B3pOkMAxZtWY2zFUC3mts/QH41+jcqRTd/gxaAT4XCdnwmkyXCIFlMybt
         SPfRPeL0F26G0MU1yDwNByhgwKEVvhttyRsT+R1OugVm55fJnaZPiyie3z/bw/8OsWta
         3pjsO4K3BvVTLL3fO6WQIhNTfnTxZICvduuuWvsw7RaODHbAP45XAHWhQtRlpgegxW1H
         yIEuuSTHD5lbaHVmlgxlu4m+f7yMMz9ZHqWpRlqh8OcPlMpG777SZA1jRVPNoKehtmXz
         Mh7oRs8BOaSn8djFxCKXoSaD0c1Tbo5PmZGY+mtdxTwsnQrmnEeaaMwbALNRVvoj3wiR
         wqgw==
X-Forwarded-Encrypted: i=1; AJvYcCXB8FnKJ+MSdH8sWp0Q2krLQ7GSy0alfKW9GwbrrDqw/OVXYVL/HZUAoY0/rxfRBgkVyp/7KvUzwNAlggAMyA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2RTUzIloktohlfIBPRHnNF7xKgMzx7f0XlUAwy/PrcFrUWBx+
	PMT0c34STgEitnqQWXxOhTDZ/zDV1wmTn/IfRPHulUm6W6T6NhwZ/bGJ/16uerdZsfEzLMfny8g
	DxTohT9hnC8Air+UaGdWU2E1n4bHX0oWOK75P7YDomrcb27Jox3scg6x/J5RzpDy2zGAb
X-Gm-Gg: ATEYQzwDz4xXtTIggXayks8jdjlhCmryMDajXCYgz1K8O7jHdj9UvznxbQTt/gVT5GK
	Imh8W4jpCmz87agBJ7ZsNw+fzGCsf6dHA/Zw8KJOgbcB9blX2Bkq956v1P0JDCGZ4y2MJs2J9jC
	gDwSiYBm0+8yUwj3igp7BxxyviGQcAjBeWZJoujtBgMQ64MiOfcYtdC72ojRNoAD15DyUMsEQRj
	Zn69hU5pykNY5dJHGyTuSMV9Y4vMuJvxvMbFgBpOZzJ4Wm9UDKWxQEhCNN9AdBd0S/nXaxjPlDT
	v6dkXqXJtMD0gBD93PZ5pAsGjlhTYQk6NSH84PhtaakQm/wFCS0/+VjdniPkmcx2ihEmnA/1Bra
	Y36HJbXXzbsK8RmVq
X-Received: by 2002:a05:600c:6287:b0:486:fc3b:3e61 with SMTP id 5b1f17b1804b1-48727ef67edmr25939915e9.18.1774601284749;
        Fri, 27 Mar 2026 01:48:04 -0700 (PDT)
X-Received: by 2002:a05:600c:6287:b0:486:fc3b:3e61 with SMTP id 5b1f17b1804b1-48727ef67edmr25939525e9.18.1774601283966;
        Fri, 27 Mar 2026 01:48:03 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4872714ef38sm11441385e9.21.2026.03.27.01.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 01:48:03 -0700 (PDT)
Date: Fri, 27 Mar 2026 04:47:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>,
	willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, eperezma@redhat.com, leiyang@redhat.com,
	stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v8 4/4] tun/tap & vhost-net: avoid ptr_ring
 tail-drop when a qdisc is present
Message-ID: <20260327044731-mutt-send-email-mst@kernel.org>
References: <20260312130639.138988-1-simon.schippers@tu-dortmund.de>
 <20260312130639.138988-5-simon.schippers@tu-dortmund.de>
 <CACGkMEtN9XgYPGHQg4TEWEsa_UcMbcnzO=VaTFT=0Tn4BayMDw@mail.gmail.com>
 <0908392d-6314-4141-b908-6c9a880ba0a4@tu-dortmund.de>
 <cda710f8-033a-4772-b5ce-a2cfddf42bea@tu-dortmund.de>
 <CACGkMEuLqxnz=GtdKp3-u0egkGT_eZUgBBwvvtHcgAYpLJv-UA@mail.gmail.com>
 <3d3274b4-f274-4cf9-9d0f-989d05148604@tu-dortmund.de>
 <CACGkMEsUag4zNZG+aYipHv_PirbKb_rs7DzSOr-NF8ckhUaJOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsUag4zNZG+aYipHv_PirbKb_rs7DzSOr-NF8ckhUaJOQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xNZC9134P2nZoZuOd6CRuWge41AP4PiPcm5MC_RvpVI_1774601285
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Mar 27, 2026 at 09:13:44AM +0800, Jason Wang wrote:
> On Thu, Mar 26, 2026 at 11:31 PM Simon Schippers
> <simon.schippers@tu-dortmund.de> wrote:
> >
> > On 3/26/26 03:41, Jason Wang wrote:
> > > On Wed, Mar 25, 2026 at 10:48 PM Simon Schippers
> > > <simon.schippers@tu-dortmund.de> wrote:
> > >>
> > >> On 3/24/26 11:14, Simon Schippers wrote:
> > >>> On 3/24/26 02:47, Jason Wang wrote:
> > >>>> On Thu, Mar 12, 2026 at 9:07 PM Simon Schippers
> > >>>> <simon.schippers@tu-dortmund.de> wrote:
> > >>>>>
> > >>>>> This commit prevents tail-drop when a qdisc is present and the ptr_ring
> > >>>>> becomes full. Once an entry is successfully produced and the ptr_ring
> > >>>>> reaches capacity, the netdev queue is stopped instead of dropping
> > >>>>> subsequent packets.
> > >>>>>
> > >>>>> If producing an entry fails anyways due to a race, tun_net_xmit returns
> > >>>>> NETDEV_TX_BUSY, again avoiding a drop. Such races are expected because
> > >>>>> LLTX is enabled and the transmit path operates without the usual locking.
> > >>>>>
> > >>>>> The existing __tun_wake_queue() function wakes the netdev queue. Races
> > >>>>> between this wakeup and the queue-stop logic could leave the queue
> > >>>>> stopped indefinitely. To prevent this, a memory barrier is enforced
> > >>>>> (as discussed in a similar implementation in [1]), followed by a recheck
> > >>>>> that wakes the queue if space is already available.
> > >>>>>
> > >>>>> If no qdisc is present, the previous tail-drop behavior is preserved.
> > >>>>
> > >>>> I wonder if we need a dedicated TUN flag to enable this. With this new
> > >>>> flag, we can even prevent TUN from using noqueue (not sure if it's
> > >>>> possible or not).
> > >>>>
> > >>>
> > >>> Except of the slight regressions because of this patchset I do not see
> > >>> a reason for such a flag.
> > >>>
> > >>> I have never seen that the driver prevents noqueue. For example you can
> > >>> set noqueue to your ethernet interface and under load you soon get
> > >>>
> > >>> net_crit_ratelimited("Virtual device %s asks to queue packet!\n",
> > >>>                                            dev->name);
> > >>>
> > >>> followed by a -ENETDOWN. And this is not prevented even though it is
> > >>> clearly not something a user wants.
> > >>>
> > >>>>>
> > >>>>> Benchmarks:
> > >>>>> The benchmarks show a slight regression in raw transmission performance,
> > >>>>> though no packets are lost anymore.
> > >>>>>
> > >>>>> The previously introduced threshold to only wake after the queue stopped
> > >>>>> and half of the ring was consumed showed to be a descent choice:
> > >>>>> Waking the queue whenever a consume made space in the ring strongly
> > >>>>> degrades performance for tap, while waking only when the ring is empty
> > >>>>> is too late and also hurts throughput for tap & tap+vhost-net.
> > >>>>> Other ratios (3/4, 7/8) showed similar results (not shown here), so
> > >>>>> 1/2 was chosen for the sake of simplicity for both tun/tap and
> > >>>>> tun/tap+vhost-net.
> > >>>>>
> > >>>>> Test setup:
> > >>>>> AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU threads;
> > >>>>> Average over 20 runs @ 100,000,000 packets. SRSO and spectre v2
> > >>>>> mitigations disabled.
> > >>>>>
> > >>>>> Note for tap+vhost-net:
> > >>>>> XDP drop program active in VM -> ~2.5x faster, slower for tap due to
> > >>>>> more syscalls (high utilization of entry_SYSRETQ_unsafe_stack in perf)
> > >>>>>
> > >>>>> +--------------------------+--------------+----------------+----------+
> > >>>>> | 1 thread                 | Stock        | Patched with   | diff     |
> > >>>>> | sending                  |              | fq_codel qdisc |          |
> > >>>>> +------------+-------------+--------------+----------------+----------+
> > >>>>> | TAP        | Transmitted | 1.151 Mpps   | 1.139 Mpps     | -1.1%    |
> > >>>>> |            +-------------+--------------+----------------+----------+
> > >>>>> |            | Lost/s      | 3.606 Mpps   | 0 pps          |          |
> > >>>>> +------------+-------------+--------------+----------------+----------+
> > >>>>> | TAP        | Transmitted | 3.948 Mpps   | 3.738 Mpps     | -5.3%    |
> > >>>>> |            +-------------+--------------+----------------+----------+
> > >>>>> | +vhost-net | Lost/s      | 496.5 Kpps   | 0 pps          |          |
> > >>>>> +------------+-------------+--------------+----------------+----------+
> > >>>>>
> > >>>>> +--------------------------+--------------+----------------+----------+
> > >>>>> | 2 threads                | Stock        | Patched with   | diff     |
> > >>>>> | sending                  |              | fq_codel qdisc |          |
> > >>>>> +------------+-------------+--------------+----------------+----------+
> > >>>>> | TAP        | Transmitted | 1.133 Mpps   | 1.109 Mpps     | -2.1%    |
> > >>>>> |            +-------------+--------------+----------------+----------+
> > >>>>> |            | Lost/s      | 8.269 Mpps   | 0 pps          |          |
> > >>>>> +------------+-------------+--------------+----------------+----------+
> > >>>>> | TAP        | Transmitted | 3.820 Mpps   | 3.513 Mpps     | -8.0%    |
> > >>>>> |            +-------------+--------------+----------------+----------+
> > >>>>> | +vhost-net | Lost/s      | 4.961 Mpps   | 0 pps          |          |
> > >>>>> +------------+-------------+--------------+----------------+----------+
> > >>>>>
> > >>>>> [1] Link: https://lore.kernel.org/all/20250424085358.75d817ae@kernel.org/
> > >>>>>
> > >>>>> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > >>>>> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > >>>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> > >>>>> ---
> > >>>>>  drivers/net/tun.c | 30 ++++++++++++++++++++++++++++--
> > >>>>>  1 file changed, 28 insertions(+), 2 deletions(-)
> > >>>>>
> > >>>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > >>>>> index b86582cc6cb6..9b7daec69acd 100644
> > >>>>> --- a/drivers/net/tun.c
> > >>>>> +++ b/drivers/net/tun.c
> > >>>>> @@ -1011,6 +1011,8 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
> > >>>>>         struct netdev_queue *queue;
> > >>>>>         struct tun_file *tfile;
> > >>>>>         int len = skb->len;
> > >>>>> +       bool qdisc_present;
> > >>>>> +       int ret;
> > >>>>>
> > >>>>>         rcu_read_lock();
> > >>>>>         tfile = rcu_dereference(tun->tfiles[txq]);
> > >>>>> @@ -1063,13 +1065,37 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
> > >>>>>
> > >>>>>         nf_reset_ct(skb);
> > >>>>>
> > >>>>> -       if (ptr_ring_produce(&tfile->tx_ring, skb)) {
> > >>>>> +       queue = netdev_get_tx_queue(dev, txq);
> > >>>>> +       qdisc_present = !qdisc_txq_has_no_queue(queue);
> > >>>>> +
> > >>>>> +       spin_lock(&tfile->tx_ring.producer_lock);
> > >>>>> +       ret = __ptr_ring_produce(&tfile->tx_ring, skb);
> > >>>>> +       if (__ptr_ring_produce_peek(&tfile->tx_ring) && qdisc_present) {
> > >>>>
> > >>>> So, it's possible that the administrator is switching between noqueue
> > >>>> and another qdisc. So ptr_ring_produce() can fail here, do we need to
> > >>>> check that or not?
> > >>>>
> > >>>
> > >>> Do you mean that? My thoughts:
> > >>>
> > >>> Switching from noqueue to some qdisc can cause a
> > >>>
> > >>> net_crit_ratelimited("Virtual device %s asks to queue packet!\n",
> > >>>                                            dev->name);
> > >>>
> > >>> followed by a return of -ENETDOWN in __dev_queue_xmit().
> > >>> This is because tun_net_xmit detects some qdisc with
> > >>>
> > >>> qdisc_present = !qdisc_txq_has_no_queue(queue);
> > >>>
> > >>> and returns NETDEV_TX_BUSY even though __dev_queue_xmit() did still
> > >>> detect noqueue.
> > >>>
> > >>> I am not sure how to solve this/if this has to be solved.
> > >>> I do not see a proper way to avoid parallel execution of ndo_start_xmit
> > >>> and a qdisc change (dev_graft_qdisc only takes qdisc_skb_head lock).
> > >>>
> > >>> And from my understanding the veth implementation faces the same issue.
> > >>
> > >> How about rechecking if a qdisc is connected?
> > >> This would avoid -ENETDOWN.
> > >>
> > >> diff --git a/net/core/dev.c b/net/core/dev.c
> > >> index f48dc299e4b2..2731a1a70732 100644
> > >> --- a/net/core/dev.c
> > >> +++ b/net/core/dev.c
> > >> @@ -4845,10 +4845,17 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
> > >>                                 if (is_list)
> > >>                                         rc = NETDEV_TX_OK;
> > >>                         }
> > >> +                       bool qdisc_present = !qdisc_txq_has_no_queue(txq);
> > >>                         HARD_TX_UNLOCK(dev, txq);
> > >>                         if (!skb) /* xmit completed */
> > >>                                 goto out;
> > >>
> > >> +                       /* Maybe a qdisc was connected in the meantime */
> > >> +                       if (qdisc_present) {
> > >> +                               kfree_skb(skb);
> > >> +                               goto out;
> > >> +                       }
> > >> +
> > >>                         net_crit_ratelimited("Virtual device %s asks to queue packet!\n",
> > >>                                              dev->name);
> > >>                         /* NETDEV_TX_BUSY or queue was stopped */
> > >>
> > >
> > > Probably not, and we likely won't hit this warning because qdisc could
> > > not be changed during ndo_start_xmit().
> >
> > Okay.
> >
> > >
> > > I meant something like this:
> > >
> > > 1) set noqueue to tuntap
> > > 2) produce packets so tuntap is full
> > > 3) set e.g fq_codel to tuntap
> > > 4) then we can hit the failure of __ptr_ring_produce()
> > >
> > > Rethink of the code, it looks just fine.
> >
> > Yes, in this case it just returns NETDEV_TX_BUSY which is fine with a
> > qdisc attached.
> >
> > >
> > >>
> > >>>
> > >>>
> > >>> Switching from some qdisc to noqueue is no problem I think.
> > >>>
> > >>>>> +               netif_tx_stop_queue(queue);
> > >>>>> +               /* Avoid races with queue wake-ups in __tun_wake_queue by
> > >>>>> +                * waking if space is available in a re-check.
> > >>>>> +                * The barrier makes sure that the stop is visible before
> > >>>>> +                * we re-check.
> > >>>>> +                */
> > >>>>> +               smp_mb__after_atomic();
> > >>>>
> > >>>> Let's document which barrier is paired with this.
> > >>>>
> > >>>
> > >>> I am basically copying the (old) logic of veth [1] proposed by
> > >>> Jakub Kicinski. I must admit I am not 100% sure what it pairs with.
> > >>>
> > >>> [1] Link: https://lore.kernel.org/all/20250424085358.75d817ae@kernel.org/
> > >
> > > So it looks like it implicitly tries to pair with tun_ring_consume():
> > >
> > > 1) spinlock(consumer_lock)
> > > 2) store NULL to ptr_ring // STORE
> > > 3) spinunlock(consumer_lock) // RELEASE
> > > 4) spinlock(consumer_lock) // ACQURE
> > > 5) check empty
> > > 6) spinunlock(consumer_lock)
> > > 7) netif_wakeup_queue() // test_and_set() which is an RMW
> > >
> > > RELEASE + ACQUIRE implies a full barrier
> >
> > Thanks.
> >
> > >
> > > I see several problems
> > >
> > > 1) Due to batch consumption, we may get spurious wakeups under heavy
> > > load (we can try disabling batch consuming to see if it helps).
> >
> > I assume that you mean the waking in the recheck of the producer happens
> > too often and then wakes too often. But this would just take slightly
> > more producer cpu as the SOFTIRQ runs on the producer cpu and not slow
> > down the consumer?
> >
> > Why would disabling batch consume help here?
> 
> We could end up with.
> 
> 1) consumer wakes up the producer but the slot is not cleaned
> 2) producer is woken up but see the ring is full, so it need to drop the packet
> 
> This probably defeat the goal of zero packet loss.

if this is rare enough, it might not matter.


> > Wouldn't it just decrease the consumer speed?
> 
> Not sure, we probably need a benchmark.
> 
> >
> > Apart from that I do not see a different method to do this recheck.
> > The ring producer is only safely able to do a !produce_peek (so a check
> > for !full).
> >
> > The normal waking (after consuming half of the ring) should be fine IMO.
> >
> > > 2) So the barriers don't help but would slow down the consuming
> > > 3) Two spinlocks were used instead of one, this is another reason we
> > > will see a performance regression
> >
> > You are right, I can change it to a single spin_lock. Apart from that
> > I do not see how the barriers/locking could be reduced further.
> >
> > > 4) Tricky code that needs to be understood or at least requires a comment tweak.
> > >
> > > Note that due to ~IFF_TX_SKB_SHARING, pktgen can't clone skbs, so we
> > > may not notice the real degradation.
> >
> > So run pktgen with pg_set SHARED?
> 
> Probably (as a workaround).
> 
> > I am pretty sure that the vhost
> > thread was always at 100% CPU so pktgen was not the bottleneck. And when
> > I had perf enabled I always saw that in my patched version not the
> > creation of SKB's took most CPU in pktgen but a different unnamed
> > function (I assume this is a waiting function).
> 
> Let's try and see.
> 
> Thanks
> 
> >
> >
> > Thank you!
> >
> > >
> > >>>
> > >>>>> +               if (!__ptr_ring_produce_peek(&tfile->tx_ring))
> > >>>>> +                       netif_tx_wake_queue(queue);
> > >>>>> +       }
> > >>>>> +       spin_unlock(&tfile->tx_ring.producer_lock);
> > >>>>> +
> > >>>>> +       if (ret) {
> > >>>>> +               /* If a qdisc is attached to our virtual device,
> > >>>>> +                * returning NETDEV_TX_BUSY is allowed.
> > >>>>> +                */
> > >>>>> +               if (qdisc_present) {
> > >>>>> +                       rcu_read_unlock();
> > >>>>> +                       return NETDEV_TX_BUSY;
> > >>>>> +               }
> > >>>>>                 drop_reason = SKB_DROP_REASON_FULL_RING;
> > >>>>>                 goto drop;
> > >>>>>         }
> > >>>>>
> > >>>>>         /* dev->lltx requires to do our own update of trans_start */
> > >>>>> -       queue = netdev_get_tx_queue(dev, txq);
> > >>>>>         txq_trans_cond_update(queue);
> > >>>>>
> > >>>>>         /* Notify and wake up reader process */
> > >>>>> --
> > >>>>> 2.43.0
> > >>>>>
> > >>>>
> > >>>> Thanks
> > >>>>
> > >>
> > >
> > > Thanks
> > >
> >

