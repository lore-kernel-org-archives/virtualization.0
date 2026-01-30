Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE54D311952
	for <virtualization@lists.linux.dev>; Fri, 30 Jan 2026 01:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769737918; cv=none; b=pOQQ8Qb8cdzCSrMwdzrJb+tFIC9uLLVwxH8jcxOs2+ag//A+y6lBUpQcQtyBJOkptU35EFpcqPm/rP4HhPJpiu9JKWK3eG3z41Dy/0e5AqrD+z/pMJtdTNCWYtx4WiTckTk28AeijuHfDHhtPdoHmvNR1PkRHdDrzy29DdWI9xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769737918; c=relaxed/simple;
	bh=ZLnDVfbWp/yZQBLKJOM2wdtYK6QMsNWA7K7ktPJ3oPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K26fhksppSATbXmPbv/qJcMuajCIjQeodYzjl44XwdGtYhviNgijTXGhQ5Ecs0KuI3A7d3wmJYhZItKfpyjoxkEWoqs6HEx1yw/X4HBh+JIstqKablPsF8zZZRC5hh9clmRc0wSc20c6c52uh0232tuKGv8LlZPWv3HUjdE5lUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SRADJncI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SRADJncI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769737915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TL9UBP+wqsd8u+8sOecgy4UpsaP/ze6U3wGWd/ji2ro=;
	b=SRADJncI8BJVgn41kKvOt5paebyEp/xJ7DK+89aRqLU30Gu+IX0YZKok/3QM9Jcx7kPVqx
	4KCF8NI9QioW5wJMKLBZrkf68Iq+jck5TH6DX6BH4RqUZ6IbvKECeXGTb4eJwUzYl1upFh
	XJ3BNWvL0B6hVAvxJ5MXyYXITw720fc=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-uGpABFXaMCyXl06kaIkESA-1; Thu, 29 Jan 2026 20:51:54 -0500
X-MC-Unique: uGpABFXaMCyXl06kaIkESA-1
X-Mimecast-MFC-AGG-ID: uGpABFXaMCyXl06kaIkESA_1769737913
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0d058fc56so11985805ad.3
        for <virtualization@lists.linux.dev>; Thu, 29 Jan 2026 17:51:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769737908; x=1770342708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TL9UBP+wqsd8u+8sOecgy4UpsaP/ze6U3wGWd/ji2ro=;
        b=P+CyH2AP/490nluthmKGOpf8mZALTzpaYBGMof6u02nPZGBzVfjMO/33T731DtZ8yA
         nZeXQovMsjP5FeUKw5Q+CfA3A32fliKaluYoNXdc67D/yy+po4sHjlIGJotAWGt8ESC6
         0H6vLfjkZYCMV1i7RVmbk5iOfUyHc263E/4jT7F1h5n8wrVNuJ+W01hr6T28pYd8qPja
         Kq6q9KNNMCnch5QCIq2FgI9rLIasUu1h5BszU20MRIS1cPOGzTDlYe3nXvSS6l/b2AXg
         FUErYmny4Q+mbiodBF8Ew6+O96Kf0X0tiMQRUG6ltDihLMPLxU93PQHDtNIOSZyip4mL
         y1ug==
X-Forwarded-Encrypted: i=1; AJvYcCWlg0vU0WFDCHZ+J9iucIbgDjEa+zUJdiBagNFvFp3t5wq+iQkdlbzsi2oiQx0gBFRZyRtT5iBWqPCGK/8kvw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzRTFWjHqOY6weFSNagO5ZwYWCx4WRoLr9QmHCgRb0e+QJIexFx
	WgD5RMRYO/5JpzgT+YvemgO7V+ASP4QZJx4pJSuJtrDDjV5hHGB+3PnMQjUCm8aMeZZI29FYSZM
	74JM0xlIdkMAzMJfyV5uuuMpkWAd2p6LoehQEH5B0yHMvlTZNPjHhjM+BGDmFSNNwL0vVUiNE/N
	iAr15Zjo/mKXwJajwggN3Kbod9Zl59ZUKOy54g5DKtieQ=
X-Gm-Gg: AZuq6aKSP8pY8bQ+xF11i2XplurmRrKoqm1nXKZSBNX5IqO7w4Peh7JoeuC8AAqGzmL
	1iHEQOBSeJj65+Ct6/VfXR8QDOvoioXXoIxFcA7lHYW26REVPaO13ZkTnsTJDgqc0xu4FIcZaxd
	/sGpRnV3VlrPhx/j34sNmZggIDVULod3jjkwyJBplkg12RTQCdqhFrKhYkkjAOdDQn
X-Received: by 2002:a17:903:2f8a:b0:2a7:5171:9221 with SMTP id d9443c01a7336-2a8d99440eamr10390055ad.42.1769737908128;
        Thu, 29 Jan 2026 17:51:48 -0800 (PST)
X-Received: by 2002:a17:903:2f8a:b0:2a7:5171:9221 with SMTP id
 d9443c01a7336-2a8d99440eamr10389845ad.42.1769737907549; Thu, 29 Jan 2026
 17:51:47 -0800 (PST)
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
 <CACGkMEv71kn91FPAUrxJg=YB3+B0MRTgOidMPHjK7Qq0WEhGtw@mail.gmail.com>
 <260f48cd-caa1-4684-a235-8e1192722b3a@tu-dortmund.de> <CACGkMEsVMz+vS3KxykYBGXvyt3MZcstnYWUiYJZhLSMoHC5Smw@mail.gmail.com>
 <ba17ba38-9f61-4a10-b375-d0da805e6b73@tu-dortmund.de>
In-Reply-To: <ba17ba38-9f61-4a10-b375-d0da805e6b73@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 30 Jan 2026 09:51:32 +0800
X-Gm-Features: AZwV_Qi_PeONPHTRd6Y8HlCZeAvUd6JxPD2mSyJe2b7JddIysyP7Df22_cIJF48
Message-ID: <CACGkMEtnLw2b8iDysQzRbXxTj2xbgzKqEZUbhmZz9tXPLTE6Sw@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: pV5ElivGpNGqgX8IMFJ44ug1mn7PMfhcPyyi-KAqjdo_1769737913
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 5:25=E2=80=AFPM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> On 1/29/26 02:14, Jason Wang wrote:
> > On Wed, Jan 28, 2026 at 3:54=E2=80=AFPM Simon Schippers
> > <simon.schippers@tu-dortmund.de> wrote:
> >>
> >> On 1/28/26 08:03, Jason Wang wrote:
> >>> On Wed, Jan 28, 2026 at 12:48=E2=80=AFAM Simon Schippers
> >>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>
> >>>> On 1/23/26 10:54, Simon Schippers wrote:
> >>>>> On 1/23/26 04:05, Jason Wang wrote:
> >>>>>> On Thu, Jan 22, 2026 at 1:35=E2=80=AFPM Jason Wang <jasowang@redha=
t.com> wrote:
> >>>>>>>
> >>>>>>> On Wed, Jan 21, 2026 at 5:33=E2=80=AFPM Simon Schippers
> >>>>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>>>
> >>>>>>>> On 1/9/26 07:02, Jason Wang wrote:
> >>>>>>>>> On Thu, Jan 8, 2026 at 3:41=E2=80=AFPM Simon Schippers
> >>>>>>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On 1/8/26 04:38, Jason Wang wrote:
> >>>>>>>>>>> On Thu, Jan 8, 2026 at 5:06=E2=80=AFAM Simon Schippers
> >>>>>>>>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> Introduce {tun,tap}_ring_consume() helpers that wrap __ptr_r=
ing_consume()
> >>>>>>>>>>>> and wake the corresponding netdev subqueue when consuming an=
 entry frees
> >>>>>>>>>>>> space in the underlying ptr_ring.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Stopping of the netdev queue when the ptr_ring is full will =
be introduced
> >>>>>>>>>>>> in an upcoming commit.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>>>>>>>>>>> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>>>>>>>>>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.=
de>
> >>>>>>>>>>>> ---
> >>>>>>>>>>>>  drivers/net/tap.c | 23 ++++++++++++++++++++++-
> >>>>>>>>>>>>  drivers/net/tun.c | 25 +++++++++++++++++++++++--
> >>>>>>>>>>>>  2 files changed, 45 insertions(+), 3 deletions(-)
> >>>>>>>>>>>>
> >>>>>>>>>>>> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> >>>>>>>>>>>> index 1197f245e873..2442cf7ac385 100644
> >>>>>>>>>>>> --- a/drivers/net/tap.c
> >>>>>>>>>>>> +++ b/drivers/net/tap.c
> >>>>>>>>>>>> @@ -753,6 +753,27 @@ static ssize_t tap_put_user(struct tap_=
queue *q,
> >>>>>>>>>>>>         return ret ? ret : total;
> >>>>>>>>>>>>  }
> >>>>>>>>>>>>
> >>>>>>>>>>>> +static void *tap_ring_consume(struct tap_queue *q)
> >>>>>>>>>>>> +{
> >>>>>>>>>>>> +       struct ptr_ring *ring =3D &q->ring;
> >>>>>>>>>>>> +       struct net_device *dev;
> >>>>>>>>>>>> +       void *ptr;
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +       spin_lock(&ring->consumer_lock);
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +       ptr =3D __ptr_ring_consume(ring);
> >>>>>>>>>>>> +       if (unlikely(ptr && __ptr_ring_consume_created_space=
(ring, 1))) {
> >>>>>>>>>>>> +               rcu_read_lock();
> >>>>>>>>>>>> +               dev =3D rcu_dereference(q->tap)->dev;
> >>>>>>>>>>>> +               netif_wake_subqueue(dev, q->queue_index);
> >>>>>>>>>>>> +               rcu_read_unlock();
> >>>>>>>>>>>> +       }
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +       spin_unlock(&ring->consumer_lock);
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +       return ptr;
> >>>>>>>>>>>> +}
> >>>>>>>>>>>> +
> >>>>>>>>>>>>  static ssize_t tap_do_read(struct tap_queue *q,
> >>>>>>>>>>>>                            struct iov_iter *to,
> >>>>>>>>>>>>                            int noblock, struct sk_buff *skb)
> >>>>>>>>>>>> @@ -774,7 +795,7 @@ static ssize_t tap_do_read(struct tap_qu=
eue *q,
> >>>>>>>>>>>>                                         TASK_INTERRUPTIBLE);
> >>>>>>>>>>>>
> >>>>>>>>>>>>                 /* Read frames from the queue */
> >>>>>>>>>>>> -               skb =3D ptr_ring_consume(&q->ring);
> >>>>>>>>>>>> +               skb =3D tap_ring_consume(q);
> >>>>>>>>>>>>                 if (skb)
> >>>>>>>>>>>>                         break;
> >>>>>>>>>>>>                 if (noblock) {
> >>>>>>>>>>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >>>>>>>>>>>> index 8192740357a0..7148f9a844a4 100644
> >>>>>>>>>>>> --- a/drivers/net/tun.c
> >>>>>>>>>>>> +++ b/drivers/net/tun.c
> >>>>>>>>>>>> @@ -2113,13 +2113,34 @@ static ssize_t tun_put_user(struct t=
un_struct *tun,
> >>>>>>>>>>>>         return total;
> >>>>>>>>>>>>  }
> >>>>>>>>>>>>
> >>>>>>>>>>>> +static void *tun_ring_consume(struct tun_file *tfile)
> >>>>>>>>>>>> +{
> >>>>>>>>>>>> +       struct ptr_ring *ring =3D &tfile->tx_ring;
> >>>>>>>>>>>> +       struct net_device *dev;
> >>>>>>>>>>>> +       void *ptr;
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +       spin_lock(&ring->consumer_lock);
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +       ptr =3D __ptr_ring_consume(ring);
> >>>>>>>>>>>> +       if (unlikely(ptr && __ptr_ring_consume_created_space=
(ring, 1))) {
> >>>>>>>>>>>
> >>>>>>>>>>> I guess it's the "bug" I mentioned in the previous patch that=
 leads to
> >>>>>>>>>>> the check of __ptr_ring_consume_created_space() here. If it's=
 true,
> >>>>>>>>>>> another call to tweak the current API.
> >>>>>>>>>>>
> >>>>>>>>>>>> +               rcu_read_lock();
> >>>>>>>>>>>> +               dev =3D rcu_dereference(tfile->tun)->dev;
> >>>>>>>>>>>> +               netif_wake_subqueue(dev, tfile->queue_index)=
;
> >>>>>>>>>>>
> >>>>>>>>>>> This would cause the producer TX_SOFTIRQ to run on the same c=
pu which
> >>>>>>>>>>> I'm not sure is what we want.
> >>>>>>>>>>
> >>>>>>>>>> What else would you suggest calling to wake the queue?
> >>>>>>>>>
> >>>>>>>>> I don't have a good method in my mind, just want to point out i=
ts implications.
> >>>>>>>>
> >>>>>>>> I have to admit I'm a bit stuck at this point, particularly with=
 this
> >>>>>>>> aspect.
> >>>>>>>>
> >>>>>>>> What is the correct way to pass the producer CPU ID to the consu=
mer?
> >>>>>>>> Would it make sense to store smp_processor_id() in the tfile ins=
ide
> >>>>>>>> tun_net_xmit(), or should it instead be stored in the skb (simil=
ar to the
> >>>>>>>> XDP bit)? In the latter case, my concern is that this informatio=
n may
> >>>>>>>> already be significantly outdated by the time it is used.
> >>>>>>>>
> >>>>>>>> Based on that, my idea would be for the consumer to wake the pro=
ducer by
> >>>>>>>> invoking a new function (e.g., tun_wake_queue()) on the producer=
 CPU via
> >>>>>>>> smp_call_function_single().
> >>>>>>>> Is this a reasonable approach?
> >>>>>>>
> >>>>>>> I'm not sure but it would introduce costs like IPI.
> >>>>>>>
> >>>>>>>>
> >>>>>>>> More generally, would triggering TX_SOFTIRQ on the consumer CPU =
be
> >>>>>>>> considered a deal-breaker for the patch set?
> >>>>>>>
> >>>>>>> It depends on whether or not it has effects on the performance.
> >>>>>>> Especially when vhost is pinned.
> >>>>>>
> >>>>>> I meant we can benchmark to see the impact. For example, pin vhost=
 to
> >>>>>> a specific CPU and the try to see the impact of the TX_SOFTIRQ.
> >>>>>>
> >>>>>> Thanks
> >>>>>>
> >>>>>
> >>>>> I ran benchmarks with vhost pinned to CPU 0 using taskset -p -c 0 .=
..
> >>>>> for both the stock and patched versions. The benchmarks were run wi=
th
> >>>>> the full patch series applied, since testing only patches 1-3 would=
 not
> >>>>> be meaningful - the queue is never stopped in that case, so no
> >>>>> TX_SOFTIRQ is triggered.
> >>>>>
> >>>>> Compared to the non-pinned CPU benchmarks in the cover letter,
> >>>>> performance is lower for pktgen with a single thread but higher wit=
h
> >>>>> four threads. The results show no regression for the patched versio=
n,
> >>>>> with even slight performance improvements observed:
> >>>>>
> >>>>> +-------------------------+-----------+----------------+
> >>>>> | pktgen benchmarks to    | Stock     | Patched with   |
> >>>>> | Debian VM, i5 6300HQ,   |           | fq_codel qdisc |
> >>>>> | 100M packets            |           |                |
> >>>>> | vhost pinned to core 0  |           |                |
> >>>>> +-----------+-------------+-----------+----------------+
> >>>>> | TAP       | Transmitted | 452 Kpps  | 454 Kpps       |
> >>>>> |  +        +-------------+-----------+----------------+
> >>>>> | vhost-net | Lost        | 1154 Kpps | 0              |
> >>>>> +-----------+-------------+-----------+----------------+
> >>>>>
> >>>>> +-------------------------+-----------+----------------+
> >>>>> | pktgen benchmarks to    | Stock     | Patched with   |
> >>>>> | Debian VM, i5 6300HQ,   |           | fq_codel qdisc |
> >>>>> | 100M packets            |           |                |
> >>>>> | vhost pinned to core 0  |           |                |
> >>>>> | *4 threads*             |           |                |
> >>>>> +-----------+-------------+-----------+----------------+
> >>>>> | TAP       | Transmitted | 71 Kpps   | 79 Kpps        |
> >>>>> |  +        +-------------+-----------+----------------+
> >>>>> | vhost-net | Lost        | 1527 Kpps | 0              |
> >>>>> +-----------+-------------+-----------+----------------+
> >>>
> >>> The PPS seems to be low. I'd suggest using testpmd (rxonly) mode in
> >>> the guest or an xdp program that did XDP_DROP in the guest.
> >>
> >> I forgot to mention that these PPS values are per thread.
> >> So overall we have 71 Kpps * 4 =3D 284 Kpps and 79 Kpps * 4 =3D 326 Kp=
ps,
> >> respectively. For packet loss, that comes out to 1154 Kpps * 4 =3D
> >> 4616 Kpps and 0, respectively.
> >>
> >> Sorry about that!
> >>
> >> The pktgen benchmarks with a single thread look fine, right?
> >
> > Still looks very low. E.g I just have a run of pktgen (using
> > pktgen_sample03_burst_single_flow.sh) without a XDP_DROP in the guest,
> > I can get 1Mpps.
>
> Keep in mind that I am using an older CPU (i5-6300HQ). For the
> single-threaded tests I always used pktgen_sample01_simple.sh, and for
> the multi-threaded tests I always used pktgen_sample02_multiqueue.sh.
>
> Using pktgen_sample03_burst_single_flow.sh as you did fails for me (even
> though the same parameters work fine for sample01 and sample02):
>
> samples/pktgen/pktgen_sample03_burst_single_flow.sh -i tap0 -m
> 52:54:00:12:34:56 -d 10.0.0.2 -n 100000000
> /samples/pktgen/functions.sh: line 79: echo: write error: Operation not
> supported
> ERROR: Write error(1) occurred
> cmd: "burst 32 > /proc/net/pktgen/tap0@0"
>
> ...and I do not know what I am doing wrong, even after looking at
> Documentation/networking/pktgen.rst. Every burst size except 1 fails.
> Any clues?

Please use -b 0, and I'm Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz.

Another thing I can think of is to disable

1) mitigations in both guest and host
2) any kernel debug features in both host and guest

Thanks

>
> Thanks!
>
> >
> >>
> >> I'll still look into using an XDP program that does XDP_DROP in the
> >> guest.
> >>
> >> Thanks!
> >
> > Thanks
> >
> >>
> >>>
> >>>>>
> >>>>> +------------------------+-------------+----------------+
> >>>>> | iperf3 TCP benchmarks  | Stock       | Patched with   |
> >>>>> | to Debian VM 120s      |             | fq_codel qdisc |
> >>>>> | vhost pinned to core 0 |             |                |
> >>>>> +------------------------+-------------+----------------+
> >>>>> | TAP                    | 22.0 Gbit/s | 22.0 Gbit/s    |
> >>>>> |  +                     |             |                |
> >>>>> | vhost-net              |             |                |
> >>>>> +------------------------+-------------+----------------+
> >>>>>
> >>>>> +---------------------------+-------------+----------------+
> >>>>> | iperf3 TCP benchmarks     | Stock       | Patched with   |
> >>>>> | to Debian VM 120s         |             | fq_codel qdisc |
> >>>>> | vhost pinned to core 0    |             |                |
> >>>>> | *4 iperf3 client threads* |             |                |
> >>>>> +---------------------------+-------------+----------------+
> >>>>> | TAP                       | 21.4 Gbit/s | 21.5 Gbit/s    |
> >>>>> |  +                        |             |                |
> >>>>> | vhost-net                 |             |                |
> >>>>> +---------------------------+-------------+----------------+
> >>>>
> >>>> What are your thoughts on this?
> >>>>
> >>>> Thanks!
> >>>>
> >>>>
> >>>
> >>> Thanks
> >>>
> >>
> >
>

