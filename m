Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7062D0C9C
	for <virtualization@lists.linux.dev>; Wed, 28 Jan 2026 07:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769583815; cv=none; b=asn6qEcq2yjiEyNmlA5FzzwD1H6Qo4hAbz+SaCFhzO0B4r7wiPi5q9HhHbiW8mNTOyPVZuztPpgGQQlWdXe9VTQxlQkoV6tAL7q0mmn6JKdn4YZUYQmtuTP9/RB59wcFu7Y6PV8WBZ/K7bsrYOgUdYiJt3m/YFIejPZqaJP7hcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769583815; c=relaxed/simple;
	bh=Cg45hZ0q54h2bhG/P3fSulN0EvcFY+v0s3Ih49jJOI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ket6+AgtHvoql2GwtUyZDAWn+CJPT5ZvgjdEBLhOrYibaIJQq1Kf4V9QN4oSqhtNI3ArlVValnAuSLoYFgiCRq9Mz5lT5qs9wZRbbxYijUloZo75HShIhReeAgHOfOrX46Ei8By74NSt1JlEXTZ6N41UTQ8UJnb4Y3GBPBseDks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BeOb9bek; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BeOb9bek"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769583812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xuKStyX4gBGrd4NIad9hOrKnHqdXGE6jzr0Ewri1egY=;
	b=BeOb9bekh3Cemze6ouJA9pQGfrBwm18cZSccw9bPJSJtxi8UsGg2++WXXvfXatxKz75/Cn
	7FBimmBIbXTEjQTkqAdinu+s541T7bRCzHMIwo/nh3qQumhOG8WJ9pZFFb3dAXi9KnKGNw
	C9dRyZ/QlLE2+scvfL4y2ij7sKO3qE4=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-zN-zD4fNPAiSWuQlMpVGlQ-1; Wed, 28 Jan 2026 02:03:31 -0500
X-MC-Unique: zN-zD4fNPAiSWuQlMpVGlQ-1
X-Mimecast-MFC-AGG-ID: zN-zD4fNPAiSWuQlMpVGlQ_1769583810
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c613929d317so3712235a12.2
        for <virtualization@lists.linux.dev>; Tue, 27 Jan 2026 23:03:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769583807; x=1770188607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xuKStyX4gBGrd4NIad9hOrKnHqdXGE6jzr0Ewri1egY=;
        b=R1WF0jQcXhCnZKkm3PPWpVOlFlOBdM853OL7tTJu5qihqR2dOUPaNhTa4tOJLN0iuy
         Ml9KCuugTrOLQ9g9Z89QpaIJ44hghoTxvYL05DP9QoSMhO2tAbmzo9R3XtkF6Hpq6fVq
         1UyfVvHZEVipAUknAJdlYI0+7Zotq9/3Hx61d2ibpVhjLPMVEXwyETEDdFpRpjvrBWXB
         HK8WhnKCKtsPgIRBDDFWGiQdMmjinXhkBdmI6n59NUv9UoWxoEkskwx2gVVK2gNcOGup
         ZFEFBG9YwHJeSNjxOadrcfhDOzx6013VJhTUV/D2B4SL3JXInTiW1sU9FnZzGIn5QctN
         sDWA==
X-Forwarded-Encrypted: i=1; AJvYcCXfuyz1cTnnDhmzy82D3m1GVAuBLKLtYOogMfzTWu5dUjNUBMjVbztFUO1c0bUBaRPFX1vAQ6KqdpYThzS1iA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yycj0SWReTqZGyOOszcihF4HP0Lrc4kvJodj/6nqGv4LG8EhUk8
	kW0f1mGSeWZrv7s6u2EeDAZAEBR8xSUZbvDZxbWo4uP1eUgif343MtBl+U6uibJ11QsjyKKmLef
	SDzmdDzCEmpcbMtjb2Cg25hChkRafm522uzSyBC9UrVGtBacj8YCzAo2IpB9f5vTcPDh+DryU9S
	hpBtKodmyuE0KsvzpkEPrMPtv0QEoKtmc0JACRQKUNJZM=
X-Gm-Gg: AZuq6aIMrMgshyr5DedUqOasvQQXID/dbR77/9HkM/5I86BEtxg43IWolvl+NJLhNCA
	mt7kiJM7QsCsuYOfokXVXF0cWBrrAfJFVt4liGR3uzPd4W+5G9fYOY2EcVnU7gfeWr+5tTa1/oU
	Ul6NHLGd7ig5RV2FJxjEK9P/YnJeoof4g71/GxO4JC9b9jq60hidFHlxV1rjiHOcBk
X-Received: by 2002:a05:6a21:3388:b0:38d:ee4a:e833 with SMTP id adf61e73a8af0-38ec6549c19mr3702328637.62.1769583806895;
        Tue, 27 Jan 2026 23:03:26 -0800 (PST)
X-Received: by 2002:a05:6a21:3388:b0:38d:ee4a:e833 with SMTP id
 adf61e73a8af0-38ec6549c19mr3702286637.62.1769583806348; Tue, 27 Jan 2026
 23:03:26 -0800 (PST)
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
In-Reply-To: <3a1d6232-efe4-4e79-a196-44794fdc0f33@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 28 Jan 2026 15:03:11 +0800
X-Gm-Features: AZwV_QhDC_bWR-juret8NZb1IfXLfm23zEjia-LWh6nai9zCNajkiH0ao9SG7CE
Message-ID: <CACGkMEv71kn91FPAUrxJg=YB3+B0MRTgOidMPHjK7Qq0WEhGtw@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: E6FlfXYY6TR8QhJXGq5ffoSpkeVJynaQNR28O-KvU5w_1769583810
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 12:48=E2=80=AFAM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> On 1/23/26 10:54, Simon Schippers wrote:
> > On 1/23/26 04:05, Jason Wang wrote:
> >> On Thu, Jan 22, 2026 at 1:35=E2=80=AFPM Jason Wang <jasowang@redhat.co=
m> wrote:
> >>>
> >>> On Wed, Jan 21, 2026 at 5:33=E2=80=AFPM Simon Schippers
> >>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>
> >>>> On 1/9/26 07:02, Jason Wang wrote:
> >>>>> On Thu, Jan 8, 2026 at 3:41=E2=80=AFPM Simon Schippers
> >>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>
> >>>>>> On 1/8/26 04:38, Jason Wang wrote:
> >>>>>>> On Thu, Jan 8, 2026 at 5:06=E2=80=AFAM Simon Schippers
> >>>>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>>>
> >>>>>>>> Introduce {tun,tap}_ring_consume() helpers that wrap __ptr_ring_=
consume()
> >>>>>>>> and wake the corresponding netdev subqueue when consuming an ent=
ry frees
> >>>>>>>> space in the underlying ptr_ring.
> >>>>>>>>
> >>>>>>>> Stopping of the netdev queue when the ptr_ring is full will be i=
ntroduced
> >>>>>>>> in an upcoming commit.
> >>>>>>>>
> >>>>>>>> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>>>>>>> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>>>>>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >>>>>>>> ---
> >>>>>>>>  drivers/net/tap.c | 23 ++++++++++++++++++++++-
> >>>>>>>>  drivers/net/tun.c | 25 +++++++++++++++++++++++--
> >>>>>>>>  2 files changed, 45 insertions(+), 3 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> >>>>>>>> index 1197f245e873..2442cf7ac385 100644
> >>>>>>>> --- a/drivers/net/tap.c
> >>>>>>>> +++ b/drivers/net/tap.c
> >>>>>>>> @@ -753,6 +753,27 @@ static ssize_t tap_put_user(struct tap_queu=
e *q,
> >>>>>>>>         return ret ? ret : total;
> >>>>>>>>  }
> >>>>>>>>
> >>>>>>>> +static void *tap_ring_consume(struct tap_queue *q)
> >>>>>>>> +{
> >>>>>>>> +       struct ptr_ring *ring =3D &q->ring;
> >>>>>>>> +       struct net_device *dev;
> >>>>>>>> +       void *ptr;
> >>>>>>>> +
> >>>>>>>> +       spin_lock(&ring->consumer_lock);
> >>>>>>>> +
> >>>>>>>> +       ptr =3D __ptr_ring_consume(ring);
> >>>>>>>> +       if (unlikely(ptr && __ptr_ring_consume_created_space(rin=
g, 1))) {
> >>>>>>>> +               rcu_read_lock();
> >>>>>>>> +               dev =3D rcu_dereference(q->tap)->dev;
> >>>>>>>> +               netif_wake_subqueue(dev, q->queue_index);
> >>>>>>>> +               rcu_read_unlock();
> >>>>>>>> +       }
> >>>>>>>> +
> >>>>>>>> +       spin_unlock(&ring->consumer_lock);
> >>>>>>>> +
> >>>>>>>> +       return ptr;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>>  static ssize_t tap_do_read(struct tap_queue *q,
> >>>>>>>>                            struct iov_iter *to,
> >>>>>>>>                            int noblock, struct sk_buff *skb)
> >>>>>>>> @@ -774,7 +795,7 @@ static ssize_t tap_do_read(struct tap_queue =
*q,
> >>>>>>>>                                         TASK_INTERRUPTIBLE);
> >>>>>>>>
> >>>>>>>>                 /* Read frames from the queue */
> >>>>>>>> -               skb =3D ptr_ring_consume(&q->ring);
> >>>>>>>> +               skb =3D tap_ring_consume(q);
> >>>>>>>>                 if (skb)
> >>>>>>>>                         break;
> >>>>>>>>                 if (noblock) {
> >>>>>>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >>>>>>>> index 8192740357a0..7148f9a844a4 100644
> >>>>>>>> --- a/drivers/net/tun.c
> >>>>>>>> +++ b/drivers/net/tun.c
> >>>>>>>> @@ -2113,13 +2113,34 @@ static ssize_t tun_put_user(struct tun_s=
truct *tun,
> >>>>>>>>         return total;
> >>>>>>>>  }
> >>>>>>>>
> >>>>>>>> +static void *tun_ring_consume(struct tun_file *tfile)
> >>>>>>>> +{
> >>>>>>>> +       struct ptr_ring *ring =3D &tfile->tx_ring;
> >>>>>>>> +       struct net_device *dev;
> >>>>>>>> +       void *ptr;
> >>>>>>>> +
> >>>>>>>> +       spin_lock(&ring->consumer_lock);
> >>>>>>>> +
> >>>>>>>> +       ptr =3D __ptr_ring_consume(ring);
> >>>>>>>> +       if (unlikely(ptr && __ptr_ring_consume_created_space(rin=
g, 1))) {
> >>>>>>>
> >>>>>>> I guess it's the "bug" I mentioned in the previous patch that lea=
ds to
> >>>>>>> the check of __ptr_ring_consume_created_space() here. If it's tru=
e,
> >>>>>>> another call to tweak the current API.
> >>>>>>>
> >>>>>>>> +               rcu_read_lock();
> >>>>>>>> +               dev =3D rcu_dereference(tfile->tun)->dev;
> >>>>>>>> +               netif_wake_subqueue(dev, tfile->queue_index);
> >>>>>>>
> >>>>>>> This would cause the producer TX_SOFTIRQ to run on the same cpu w=
hich
> >>>>>>> I'm not sure is what we want.
> >>>>>>
> >>>>>> What else would you suggest calling to wake the queue?
> >>>>>
> >>>>> I don't have a good method in my mind, just want to point out its i=
mplications.
> >>>>
> >>>> I have to admit I'm a bit stuck at this point, particularly with thi=
s
> >>>> aspect.
> >>>>
> >>>> What is the correct way to pass the producer CPU ID to the consumer?
> >>>> Would it make sense to store smp_processor_id() in the tfile inside
> >>>> tun_net_xmit(), or should it instead be stored in the skb (similar t=
o the
> >>>> XDP bit)? In the latter case, my concern is that this information ma=
y
> >>>> already be significantly outdated by the time it is used.
> >>>>
> >>>> Based on that, my idea would be for the consumer to wake the produce=
r by
> >>>> invoking a new function (e.g., tun_wake_queue()) on the producer CPU=
 via
> >>>> smp_call_function_single().
> >>>> Is this a reasonable approach?
> >>>
> >>> I'm not sure but it would introduce costs like IPI.
> >>>
> >>>>
> >>>> More generally, would triggering TX_SOFTIRQ on the consumer CPU be
> >>>> considered a deal-breaker for the patch set?
> >>>
> >>> It depends on whether or not it has effects on the performance.
> >>> Especially when vhost is pinned.
> >>
> >> I meant we can benchmark to see the impact. For example, pin vhost to
> >> a specific CPU and the try to see the impact of the TX_SOFTIRQ.
> >>
> >> Thanks
> >>
> >
> > I ran benchmarks with vhost pinned to CPU 0 using taskset -p -c 0 ...
> > for both the stock and patched versions. The benchmarks were run with
> > the full patch series applied, since testing only patches 1-3 would not
> > be meaningful - the queue is never stopped in that case, so no
> > TX_SOFTIRQ is triggered.
> >
> > Compared to the non-pinned CPU benchmarks in the cover letter,
> > performance is lower for pktgen with a single thread but higher with
> > four threads. The results show no regression for the patched version,
> > with even slight performance improvements observed:
> >
> > +-------------------------+-----------+----------------+
> > | pktgen benchmarks to    | Stock     | Patched with   |
> > | Debian VM, i5 6300HQ,   |           | fq_codel qdisc |
> > | 100M packets            |           |                |
> > | vhost pinned to core 0  |           |                |
> > +-----------+-------------+-----------+----------------+
> > | TAP       | Transmitted | 452 Kpps  | 454 Kpps       |
> > |  +        +-------------+-----------+----------------+
> > | vhost-net | Lost        | 1154 Kpps | 0              |
> > +-----------+-------------+-----------+----------------+
> >
> > +-------------------------+-----------+----------------+
> > | pktgen benchmarks to    | Stock     | Patched with   |
> > | Debian VM, i5 6300HQ,   |           | fq_codel qdisc |
> > | 100M packets            |           |                |
> > | vhost pinned to core 0  |           |                |
> > | *4 threads*             |           |                |
> > +-----------+-------------+-----------+----------------+
> > | TAP       | Transmitted | 71 Kpps   | 79 Kpps        |
> > |  +        +-------------+-----------+----------------+
> > | vhost-net | Lost        | 1527 Kpps | 0              |
> > +-----------+-------------+-----------+----------------+

The PPS seems to be low. I'd suggest using testpmd (rxonly) mode in
the guest or an xdp program that did XDP_DROP in the guest.

> >
> > +------------------------+-------------+----------------+
> > | iperf3 TCP benchmarks  | Stock       | Patched with   |
> > | to Debian VM 120s      |             | fq_codel qdisc |
> > | vhost pinned to core 0 |             |                |
> > +------------------------+-------------+----------------+
> > | TAP                    | 22.0 Gbit/s | 22.0 Gbit/s    |
> > |  +                     |             |                |
> > | vhost-net              |             |                |
> > +------------------------+-------------+----------------+
> >
> > +---------------------------+-------------+----------------+
> > | iperf3 TCP benchmarks     | Stock       | Patched with   |
> > | to Debian VM 120s         |             | fq_codel qdisc |
> > | vhost pinned to core 0    |             |                |
> > | *4 iperf3 client threads* |             |                |
> > +---------------------------+-------------+----------------+
> > | TAP                       | 21.4 Gbit/s | 21.5 Gbit/s    |
> > |  +                        |             |                |
> > | vhost-net                 |             |                |
> > +---------------------------+-------------+----------------+
>
> What are your thoughts on this?
>
> Thanks!
>
>

Thanks

