Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12C0314D26
	for <virtualization@lists.linux.dev>; Thu, 29 Jan 2026 01:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769649297; cv=none; b=fxvvK1Boeg3DGStN/EIWmioyKNV7F163Kl09Hi+gIyY5JkGyt4yRdBRQAkak5OKNllg7l1f+CFQnQ5psEkxC2HOWnn7ze/rXECVuIXH8kesOlQZCYB/yIaespGtEJTgsfciss+nIhoTavwhhhS66z+uH1UG3sO8WUg9+hdsiYlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769649297; c=relaxed/simple;
	bh=+IbLxvhwPxFYFSa1tzHStRrP5YAWBXPRpwrDnDNPDG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gfYggKh6I9UfpPjdDo0ZKeSCL1qv6VuegIGMQxqG7AjXfQMH1aRpIbUuaZmwtw89q8tullSRduBInBSbb0XQwIdR2KoRIyv/Xx1bWoBVjtg+uKETgw08WnlecrTZOS2e7uUfhUn0Sc/52w3p/M8csnPbqjQiSGK0MJUFIy++b4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QuHkU5XK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QuHkU5XK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769649294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AAyqH6SmWuOGsCC3JIASR5UfDF9EMKXo/TpQLggZqgQ=;
	b=QuHkU5XKrC3iSv3enpeXl0dIUoLLxV/1oOONpM3eJnYcvJWe//ffMzMoh5MZZ+ATsMVlLb
	QVhWPcD0gOtTXbfIRpe+pTCCUJbMsiPJzBPFzrxJHqzsJDcfd6oolTPQ+vO2mt96BATBF9
	mZYncfp4EXNBSS8oxVQESYczitOvyLk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-CTYn6oqxN2KPfX7COZvYxw-1; Wed, 28 Jan 2026 20:14:53 -0500
X-MC-Unique: CTYn6oqxN2KPfX7COZvYxw-1
X-Mimecast-MFC-AGG-ID: CTYn6oqxN2KPfX7COZvYxw_1769649292
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34ac819b2f2so587835a91.0
        for <virtualization@lists.linux.dev>; Wed, 28 Jan 2026 17:14:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769649291; x=1770254091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AAyqH6SmWuOGsCC3JIASR5UfDF9EMKXo/TpQLggZqgQ=;
        b=kbvfMJxUrfiw3a9TTsuuS84MgQ7N0ENXwjzxIgWESJlWGTkf+AJlznhEyZdt7Tk5fK
         CLOEO19g4y0rV6toRncpa9DiL0AV7MMZGdn3qd8d7aho/KPwRx/m2/LEGMYjl8C7hiGJ
         OmPPUzUO/KCEhL/Rr1tqFYOkSSlQagD3k0TXGhPCQ6ApJ0w0/LpfyoNW620dc9L0us5p
         a6XI7YTzhCnpgx+NM2AsjkhYt1yEDJM0XshNc6sJLncVIU3gmhHIqJu5GzHGxXnHAVYz
         A2VbVKYi0qpdwmeOv+uPgINcvaQurIaQCb5bAbWGRkgM9ybuEvXgV1vQBSDgPME51Ua3
         mCGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUt1ncww39rXP3h8in3kdeDxvO7xSC9we4M5VKAucDb+tiuGHVJYI56pslUKwLWI7YyxZp0CX2YuRvtwNY6XQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzES2ghjGFuaBqf3+wrqdyCpVOO1BR6kwL9Y0RdAaWEfe8GISbR
	TPJrFIsIH6TZuHpvVGrwHFLMgiBhagcVreGyN8qCXqACKN03Q3ESwxcifAqbEx+wAtPbgqkMKi7
	H2BEwOcoTOuruBTFw+LTFN6N4JsjTrKg7sASFyE8cJ+kpMep8Ie93t9EEpsuNFUsW/DJwWDJoP8
	fnjATnZ0tThmY80JwK4cl0qFqpGvv5D1BbdRZz/dikUd0=
X-Gm-Gg: AZuq6aJaaknotun3/h8MZry5LVVhDjz5XtlPMTS3BeqPNx+cSBPuN4eTvNpLmvNydhi
	BDtvef6BORreeSBGZq0yHFa+i6CA+8Q8y5eE3PLjeOBHSpjYr7XhP1F6pMyYhgt/OgeToqR+HOj
	dfTpzhIE2P9GHmXftX2bbew8y5a3/3Pl6zf1O0QyxRVZS8L8jDU3xndO4vmxWjeBEc
X-Received: by 2002:a17:90b:2705:b0:340:d06d:ea73 with SMTP id 98e67ed59e1d1-353fed74b1bmr6200871a91.19.1769649291239;
        Wed, 28 Jan 2026 17:14:51 -0800 (PST)
X-Received: by 2002:a17:90b:2705:b0:340:d06d:ea73 with SMTP id
 98e67ed59e1d1-353fed74b1bmr6200859a91.19.1769649290732; Wed, 28 Jan 2026
 17:14:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260107210448.37851-1-simon.schippers@tu-dortmund.de>
 <20260107210448.37851-4-simon.schippers@tu-dortmund.de> <CACGkMEuSiEcyaeFeZd0=RgNpviJgNvUDq_ctjeMLT5jZTgRkwQ@mail.gmail.com>
 <1e30464c-99ae-441e-bb46-6d0485d494dc@tu-dortmund.de> <CACGkMEtzD3ORJuJcc8VeqwASiGeVFdQmJowsK6PYVEF_Zkcn8Q@mail.gmail.com>
 <afa40345-acbe-42b0-81d1-0a838343792d@tu-dortmund.de> <CACGkMEtxRoavBMTXom8Z=FM-pvu3pHbsuwCs+e450b1B=V7iWA@mail.gmail.com>
 <CACGkMEsJKeEsH=G8H5RzMNHY4g3HNdciMDMhciShawh-9Xb9hg@mail.gmail.com>
 <bc1078e5-65fc-4de6-8475-517f626d8d96@tu-dortmund.de> <3a1d6232-efe4-4e79-a196-44794fdc0f33@tu-dortmund.de>
 <CACGkMEv71kn91FPAUrxJg=YB3+B0MRTgOidMPHjK7Qq0WEhGtw@mail.gmail.com> <260f48cd-caa1-4684-a235-8e1192722b3a@tu-dortmund.de>
In-Reply-To: <260f48cd-caa1-4684-a235-8e1192722b3a@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 29 Jan 2026 09:14:38 +0800
X-Gm-Features: AZwV_QhChibP1TQksxzISzzBmI4bS7flGPohL5vfvndiNnozn5EJ93__Ix-8njI
Message-ID: <CACGkMEsVMz+vS3KxykYBGXvyt3MZcstnYWUiYJZhLSMoHC5Smw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 3/9] tun/tap: add ptr_ring consume helper with
 netdev queue wakeup
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mst@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Gjemwf2hGjxdl1WCAOeKzPMUPa6lzEphE_A4aGEdbkY_1769649292
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 3:54=E2=80=AFPM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> On 1/28/26 08:03, Jason Wang wrote:
> > On Wed, Jan 28, 2026 at 12:48=E2=80=AFAM Simon Schippers
> > <simon.schippers@tu-dortmund.de> wrote:
> >>
> >> On 1/23/26 10:54, Simon Schippers wrote:
> >>> On 1/23/26 04:05, Jason Wang wrote:
> >>>> On Thu, Jan 22, 2026 at 1:35=E2=80=AFPM Jason Wang <jasowang@redhat.=
com> wrote:
> >>>>>
> >>>>> On Wed, Jan 21, 2026 at 5:33=E2=80=AFPM Simon Schippers
> >>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>
> >>>>>> On 1/9/26 07:02, Jason Wang wrote:
> >>>>>>> On Thu, Jan 8, 2026 at 3:41=E2=80=AFPM Simon Schippers
> >>>>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>>>
> >>>>>>>> On 1/8/26 04:38, Jason Wang wrote:
> >>>>>>>>> On Thu, Jan 8, 2026 at 5:06=E2=80=AFAM Simon Schippers
> >>>>>>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>>>>>
> >>>>>>>>>> Introduce {tun,tap}_ring_consume() helpers that wrap __ptr_rin=
g_consume()
> >>>>>>>>>> and wake the corresponding netdev subqueue when consuming an e=
ntry frees
> >>>>>>>>>> space in the underlying ptr_ring.
> >>>>>>>>>>
> >>>>>>>>>> Stopping of the netdev queue when the ptr_ring is full will be=
 introduced
> >>>>>>>>>> in an upcoming commit.
> >>>>>>>>>>
> >>>>>>>>>> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>>>>>>>>> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>>>>>>>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de=
>
> >>>>>>>>>> ---
> >>>>>>>>>>  drivers/net/tap.c | 23 ++++++++++++++++++++++-
> >>>>>>>>>>  drivers/net/tun.c | 25 +++++++++++++++++++++++--
> >>>>>>>>>>  2 files changed, 45 insertions(+), 3 deletions(-)
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> >>>>>>>>>> index 1197f245e873..2442cf7ac385 100644
> >>>>>>>>>> --- a/drivers/net/tap.c
> >>>>>>>>>> +++ b/drivers/net/tap.c
> >>>>>>>>>> @@ -753,6 +753,27 @@ static ssize_t tap_put_user(struct tap_qu=
eue *q,
> >>>>>>>>>>         return ret ? ret : total;
> >>>>>>>>>>  }
> >>>>>>>>>>
> >>>>>>>>>> +static void *tap_ring_consume(struct tap_queue *q)
> >>>>>>>>>> +{
> >>>>>>>>>> +       struct ptr_ring *ring =3D &q->ring;
> >>>>>>>>>> +       struct net_device *dev;
> >>>>>>>>>> +       void *ptr;
> >>>>>>>>>> +
> >>>>>>>>>> +       spin_lock(&ring->consumer_lock);
> >>>>>>>>>> +
> >>>>>>>>>> +       ptr =3D __ptr_ring_consume(ring);
> >>>>>>>>>> +       if (unlikely(ptr && __ptr_ring_consume_created_space(r=
ing, 1))) {
> >>>>>>>>>> +               rcu_read_lock();
> >>>>>>>>>> +               dev =3D rcu_dereference(q->tap)->dev;
> >>>>>>>>>> +               netif_wake_subqueue(dev, q->queue_index);
> >>>>>>>>>> +               rcu_read_unlock();
> >>>>>>>>>> +       }
> >>>>>>>>>> +
> >>>>>>>>>> +       spin_unlock(&ring->consumer_lock);
> >>>>>>>>>> +
> >>>>>>>>>> +       return ptr;
> >>>>>>>>>> +}
> >>>>>>>>>> +
> >>>>>>>>>>  static ssize_t tap_do_read(struct tap_queue *q,
> >>>>>>>>>>                            struct iov_iter *to,
> >>>>>>>>>>                            int noblock, struct sk_buff *skb)
> >>>>>>>>>> @@ -774,7 +795,7 @@ static ssize_t tap_do_read(struct tap_queu=
e *q,
> >>>>>>>>>>                                         TASK_INTERRUPTIBLE);
> >>>>>>>>>>
> >>>>>>>>>>                 /* Read frames from the queue */
> >>>>>>>>>> -               skb =3D ptr_ring_consume(&q->ring);
> >>>>>>>>>> +               skb =3D tap_ring_consume(q);
> >>>>>>>>>>                 if (skb)
> >>>>>>>>>>                         break;
> >>>>>>>>>>                 if (noblock) {
> >>>>>>>>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >>>>>>>>>> index 8192740357a0..7148f9a844a4 100644
> >>>>>>>>>> --- a/drivers/net/tun.c
> >>>>>>>>>> +++ b/drivers/net/tun.c
> >>>>>>>>>> @@ -2113,13 +2113,34 @@ static ssize_t tun_put_user(struct tun=
_struct *tun,
> >>>>>>>>>>         return total;
> >>>>>>>>>>  }
> >>>>>>>>>>
> >>>>>>>>>> +static void *tun_ring_consume(struct tun_file *tfile)
> >>>>>>>>>> +{
> >>>>>>>>>> +       struct ptr_ring *ring =3D &tfile->tx_ring;
> >>>>>>>>>> +       struct net_device *dev;
> >>>>>>>>>> +       void *ptr;
> >>>>>>>>>> +
> >>>>>>>>>> +       spin_lock(&ring->consumer_lock);
> >>>>>>>>>> +
> >>>>>>>>>> +       ptr =3D __ptr_ring_consume(ring);
> >>>>>>>>>> +       if (unlikely(ptr && __ptr_ring_consume_created_space(r=
ing, 1))) {
> >>>>>>>>>
> >>>>>>>>> I guess it's the "bug" I mentioned in the previous patch that l=
eads to
> >>>>>>>>> the check of __ptr_ring_consume_created_space() here. If it's t=
rue,
> >>>>>>>>> another call to tweak the current API.
> >>>>>>>>>
> >>>>>>>>>> +               rcu_read_lock();
> >>>>>>>>>> +               dev =3D rcu_dereference(tfile->tun)->dev;
> >>>>>>>>>> +               netif_wake_subqueue(dev, tfile->queue_index);
> >>>>>>>>>
> >>>>>>>>> This would cause the producer TX_SOFTIRQ to run on the same cpu=
 which
> >>>>>>>>> I'm not sure is what we want.
> >>>>>>>>
> >>>>>>>> What else would you suggest calling to wake the queue?
> >>>>>>>
> >>>>>>> I don't have a good method in my mind, just want to point out its=
 implications.
> >>>>>>
> >>>>>> I have to admit I'm a bit stuck at this point, particularly with t=
his
> >>>>>> aspect.
> >>>>>>
> >>>>>> What is the correct way to pass the producer CPU ID to the consume=
r?
> >>>>>> Would it make sense to store smp_processor_id() in the tfile insid=
e
> >>>>>> tun_net_xmit(), or should it instead be stored in the skb (similar=
 to the
> >>>>>> XDP bit)? In the latter case, my concern is that this information =
may
> >>>>>> already be significantly outdated by the time it is used.
> >>>>>>
> >>>>>> Based on that, my idea would be for the consumer to wake the produ=
cer by
> >>>>>> invoking a new function (e.g., tun_wake_queue()) on the producer C=
PU via
> >>>>>> smp_call_function_single().
> >>>>>> Is this a reasonable approach?
> >>>>>
> >>>>> I'm not sure but it would introduce costs like IPI.
> >>>>>
> >>>>>>
> >>>>>> More generally, would triggering TX_SOFTIRQ on the consumer CPU be
> >>>>>> considered a deal-breaker for the patch set?
> >>>>>
> >>>>> It depends on whether or not it has effects on the performance.
> >>>>> Especially when vhost is pinned.
> >>>>
> >>>> I meant we can benchmark to see the impact. For example, pin vhost t=
o
> >>>> a specific CPU and the try to see the impact of the TX_SOFTIRQ.
> >>>>
> >>>> Thanks
> >>>>
> >>>
> >>> I ran benchmarks with vhost pinned to CPU 0 using taskset -p -c 0 ...
> >>> for both the stock and patched versions. The benchmarks were run with
> >>> the full patch series applied, since testing only patches 1-3 would n=
ot
> >>> be meaningful - the queue is never stopped in that case, so no
> >>> TX_SOFTIRQ is triggered.
> >>>
> >>> Compared to the non-pinned CPU benchmarks in the cover letter,
> >>> performance is lower for pktgen with a single thread but higher with
> >>> four threads. The results show no regression for the patched version,
> >>> with even slight performance improvements observed:
> >>>
> >>> +-------------------------+-----------+----------------+
> >>> | pktgen benchmarks to    | Stock     | Patched with   |
> >>> | Debian VM, i5 6300HQ,   |           | fq_codel qdisc |
> >>> | 100M packets            |           |                |
> >>> | vhost pinned to core 0  |           |                |
> >>> +-----------+-------------+-----------+----------------+
> >>> | TAP       | Transmitted | 452 Kpps  | 454 Kpps       |
> >>> |  +        +-------------+-----------+----------------+
> >>> | vhost-net | Lost        | 1154 Kpps | 0              |
> >>> +-----------+-------------+-----------+----------------+
> >>>
> >>> +-------------------------+-----------+----------------+
> >>> | pktgen benchmarks to    | Stock     | Patched with   |
> >>> | Debian VM, i5 6300HQ,   |           | fq_codel qdisc |
> >>> | 100M packets            |           |                |
> >>> | vhost pinned to core 0  |           |                |
> >>> | *4 threads*             |           |                |
> >>> +-----------+-------------+-----------+----------------+
> >>> | TAP       | Transmitted | 71 Kpps   | 79 Kpps        |
> >>> |  +        +-------------+-----------+----------------+
> >>> | vhost-net | Lost        | 1527 Kpps | 0              |
> >>> +-----------+-------------+-----------+----------------+
> >
> > The PPS seems to be low. I'd suggest using testpmd (rxonly) mode in
> > the guest or an xdp program that did XDP_DROP in the guest.
>
> I forgot to mention that these PPS values are per thread.
> So overall we have 71 Kpps * 4 =3D 284 Kpps and 79 Kpps * 4 =3D 326 Kpps,
> respectively. For packet loss, that comes out to 1154 Kpps * 4 =3D
> 4616 Kpps and 0, respectively.
>
> Sorry about that!
>
> The pktgen benchmarks with a single thread look fine, right?

Still looks very low. E.g I just have a run of pktgen (using
pktgen_sample03_burst_single_flow.sh) without a XDP_DROP in the guest,
I can get 1Mpps.

>
> I'll still look into using an XDP program that does XDP_DROP in the
> guest.
>
> Thanks!

Thanks

>
> >
> >>>
> >>> +------------------------+-------------+----------------+
> >>> | iperf3 TCP benchmarks  | Stock       | Patched with   |
> >>> | to Debian VM 120s      |             | fq_codel qdisc |
> >>> | vhost pinned to core 0 |             |                |
> >>> +------------------------+-------------+----------------+
> >>> | TAP                    | 22.0 Gbit/s | 22.0 Gbit/s    |
> >>> |  +                     |             |                |
> >>> | vhost-net              |             |                |
> >>> +------------------------+-------------+----------------+
> >>>
> >>> +---------------------------+-------------+----------------+
> >>> | iperf3 TCP benchmarks     | Stock       | Patched with   |
> >>> | to Debian VM 120s         |             | fq_codel qdisc |
> >>> | vhost pinned to core 0    |             |                |
> >>> | *4 iperf3 client threads* |             |                |
> >>> +---------------------------+-------------+----------------+
> >>> | TAP                       | 21.4 Gbit/s | 21.5 Gbit/s    |
> >>> |  +                        |             |                |
> >>> | vhost-net                 |             |                |
> >>> +---------------------------+-------------+----------------+
> >>
> >> What are your thoughts on this?
> >>
> >> Thanks!
> >>
> >>
> >
> > Thanks
> >
>

