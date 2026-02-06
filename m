Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9B0330668
	for <virtualization@lists.linux.dev>; Fri,  6 Feb 2026 03:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770348124; cv=none; b=OdqMgUaHdWOs0icnee7QfqD4pEsSCUu6GBAUx1e/rKs1OfqMHF7XAWpGn6sYksiMUn9A09dpWjiPJ1Ko4BMh/+kSc0+TYnJEGfNKwM1F/ajC22+cklRtMBkFKXSYHiEa6+kFhcAzUVrtVNShURY3kdtkLGD9AAOoOM5vChP2wd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770348124; c=relaxed/simple;
	bh=lZZW9Vii1VFpI4TDAMDWIaqryqjNDiZqJ7sty/QtAcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=si4RmHd1k9LkvUnzFrPEltEWWJeQv19fSUiD7oRmWjDF/GHkRdAa7zRdZTDsEO8I7CY7irXxhwf9qCMDYMVaNG/xeyh29htvYQuxQi2IXrlF8w/eEEI8jEfP5/Bwaysuxz7sRWXz2cLIOkcmz6OqKq/ivR3vwbl/PI/pEjIfWKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EJz5rrJ+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJz5rrJ+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770348122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M99Mi95Zasa6bhoPuEBTbJnUVbxC5rglrURO50gNl2A=;
	b=EJz5rrJ+ieCHqnEASbkjnDZKVdWzKVZWDxPlKzdz4vcA4fquMZeRwfCyUKXB4kz/IlICUp
	uDEIjNlkaehhAg8+E/b5XSRu1Mpvk3NLit5qvhJ+9UVI9LfLTDxpuk9/Il61QkRTqjLRzt
	owlGEg4AJ/Ik2/6pT/d6CGP6D5RzjJ0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-vqAsYlH6PTatVhPh9FQkiw-1; Thu, 05 Feb 2026 22:22:01 -0500
X-MC-Unique: vqAsYlH6PTatVhPh9FQkiw-1
X-Mimecast-MFC-AGG-ID: vqAsYlH6PTatVhPh9FQkiw_1770348121
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a945ba5553so2684575ad.0
        for <virtualization@lists.linux.dev>; Thu, 05 Feb 2026 19:22:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770348116; x=1770952916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M99Mi95Zasa6bhoPuEBTbJnUVbxC5rglrURO50gNl2A=;
        b=Q2uiDvPIuFr49yAUq3JqZkljIUTmzcIj59KyUzjuRA/OU9EWY3PELubVmApTCmDtHS
         CbmFFfmuvYNwmXA0u+pnQZ14XtOoyKjgdnhXaT8Pdh7/EbQWFg5K2n947YOF4hlp6mZU
         8WNob7VVHQ8EOBAOFl13jxBanlhpKqHys/OgI9+a4hjmdMTobB7Mk7HR4IX6wWKCJ/V+
         1JCbPhoVel4nVInaJPg1wh0cZ9HHpIqFxaHyu7LYW3AxjDExLSSl/bZ6aCyY6rfsuQaI
         0RGPJFSwA2dTHu4+E+F5FtV1HYcdfgjrHkfoe33qry4QClWhU30yDO6KH5b2D9WTIkzO
         vj4A==
X-Forwarded-Encrypted: i=1; AJvYcCXSGLECe8DBwOZdxuTWiMDtg5MJ9x+RlXA0FjPzW/FApkrrSDmL0QvtaXba7bB8YcCeQ518g65wvLDPlctiMw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwBbyf0ohoEDoCvdN4HBPbpHLJG10d4vswZ8DzUD27wGWp8EYPQ
	1/p5DZuvgl8BdXN5TveisGSd8dW4B7mNbEbHTkaYroJDqjmKdXrUAIkcAPpoKtZEV8XILS2t/eo
	brIE78oxZWB7NgYY+DopLOxEd2a1lJz/QxWUg25FCrjKH5T4fXftm6WNUd86zfI4qteTplB+Dz8
	EzrCnf8FpNpUPFNI1/e3MGChSQ6UGUlSa9a/C1DkS2bv4=
X-Gm-Gg: AZuq6aKFtrsqZ/5xxZcAv3guZzUBuknQU2psalabDbGB6MD97BChbndfiqImgV6qKIy
	5SFgVV7YVOSfsYnJMgpmzJ9TQ88LtsRAPFO20dbp4yS3ApgvYP4c01fFy36gO1R4XwPWWElnJfi
	rCr/r+rulHUv4/gv6PaasWx/cUxNd9+WG8DXiL/WAAMPnIsgxKbWcQPNL/zFd88lIggA==
X-Received: by 2002:a17:902:ecd2:b0:29d:9f5a:e0d1 with SMTP id d9443c01a7336-2a9516c183cmr14970715ad.27.1770348116113;
        Thu, 05 Feb 2026 19:21:56 -0800 (PST)
X-Received: by 2002:a17:902:ecd2:b0:29d:9f5a:e0d1 with SMTP id
 d9443c01a7336-2a9516c183cmr14970275ad.27.1770348115508; Thu, 05 Feb 2026
 19:21:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260107210448.37851-1-simon.schippers@tu-dortmund.de>
 <CACGkMEtzD3ORJuJcc8VeqwASiGeVFdQmJowsK6PYVEF_Zkcn8Q@mail.gmail.com>
 <afa40345-acbe-42b0-81d1-0a838343792d@tu-dortmund.de> <CACGkMEtxRoavBMTXom8Z=FM-pvu3pHbsuwCs+e450b1B=V7iWA@mail.gmail.com>
 <CACGkMEsJKeEsH=G8H5RzMNHY4g3HNdciMDMhciShawh-9Xb9hg@mail.gmail.com>
 <bc1078e5-65fc-4de6-8475-517f626d8d96@tu-dortmund.de> <3a1d6232-efe4-4e79-a196-44794fdc0f33@tu-dortmund.de>
 <CACGkMEv71kn91FPAUrxJg=YB3+B0MRTgOidMPHjK7Qq0WEhGtw@mail.gmail.com>
 <260f48cd-caa1-4684-a235-8e1192722b3a@tu-dortmund.de> <CACGkMEsVMz+vS3KxykYBGXvyt3MZcstnYWUiYJZhLSMoHC5Smw@mail.gmail.com>
 <ba17ba38-9f61-4a10-b375-d0da805e6b73@tu-dortmund.de> <CACGkMEtnLw2b8iDysQzRbXxTj2xbgzKqEZUbhmZz9tXPLTE6Sw@mail.gmail.com>
 <0ebc00ba-35e7-4570-a44f-b0ae634f2316@tu-dortmund.de> <CACGkMEsJtE3RehWQ8BaDL2HdFPK=iW+ZaEAN1TekAMWwor5tjQ@mail.gmail.com>
 <197573a1-df52-4928-adb9-55a7a4f78839@tu-dortmund.de> <CACGkMEveEXky_rTrvRrfi7qix12GG91GfyqnwB6Tu-dnjqAm9A@mail.gmail.com>
 <0c776172-2f02-47fc-babf-2871adca42cb@tu-dortmund.de>
In-Reply-To: <0c776172-2f02-47fc-babf-2871adca42cb@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 6 Feb 2026 11:21:43 +0800
X-Gm-Features: AZwV_QhOOvxaUaSKQoSsZxYqMN518rDjxRQhhRg2CKYw_iMZKX9o_lAS42RxkDg
Message-ID: <CACGkMEte=LwvkxPh-tesJHLVYQV1YZF4is1Yamokhkzaf5GOWw@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: qGX1hCaJSUJIM8_CVVnEojhMLiPQWqfu3RRe-ajJJeE_1770348121
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 6:28=E2=80=AFAM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> On 2/5/26 04:59, Jason Wang wrote:
> > On Wed, Feb 4, 2026 at 11:44=E2=80=AFPM Simon Schippers
> > <simon.schippers@tu-dortmund.de> wrote:
> >>
> >> On 2/3/26 04:48, Jason Wang wrote:
> >>> On Mon, Feb 2, 2026 at 4:19=E2=80=AFAM Simon Schippers
> >>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>
> >>>> On 1/30/26 02:51, Jason Wang wrote:
> >>>>> On Thu, Jan 29, 2026 at 5:25=E2=80=AFPM Simon Schippers
> >>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>
> >>>>>> On 1/29/26 02:14, Jason Wang wrote:
> >>>>>>> On Wed, Jan 28, 2026 at 3:54=E2=80=AFPM Simon Schippers
> >>>>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>>>
> >>>>>>>> On 1/28/26 08:03, Jason Wang wrote:
> >>>>>>>>> On Wed, Jan 28, 2026 at 12:48=E2=80=AFAM Simon Schippers
> >>>>>>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On 1/23/26 10:54, Simon Schippers wrote:
> >>>>>>>>>>> On 1/23/26 04:05, Jason Wang wrote:
> >>>>>>>>>>>> On Thu, Jan 22, 2026 at 1:35=E2=80=AFPM Jason Wang <jasowang=
@redhat.com> wrote:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> On Wed, Jan 21, 2026 at 5:33=E2=80=AFPM Simon Schippers
> >>>>>>>>>>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> On 1/9/26 07:02, Jason Wang wrote:
> >>>>>>>>>>>>>>> On Thu, Jan 8, 2026 at 3:41=E2=80=AFPM Simon Schippers
> >>>>>>>>>>>>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> On 1/8/26 04:38, Jason Wang wrote:
> >>>>>>>>>>>>>>>>> On Thu, Jan 8, 2026 at 5:06=E2=80=AFAM Simon Schippers
> >>>>>>>>>>>>>>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> Introduce {tun,tap}_ring_consume() helpers that wrap _=
_ptr_ring_consume()
> >>>>>>>>>>>>>>>>>> and wake the corresponding netdev subqueue when consum=
ing an entry frees
> >>>>>>>>>>>>>>>>>> space in the underlying ptr_ring.
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> Stopping of the netdev queue when the ptr_ring is full=
 will be introduced
> >>>>>>>>>>>>>>>>>> in an upcoming commit.
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.=
de>
> >>>>>>>>>>>>>>>>>> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de=
>
> >>>>>>>>>>>>>>>>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dor=
tmund.de>
> >>>>>>>>>>>>>>>>>> ---
> >>>>>>>>>>>>>>>>>>  drivers/net/tap.c | 23 ++++++++++++++++++++++-
> >>>>>>>>>>>>>>>>>>  drivers/net/tun.c | 25 +++++++++++++++++++++++--
> >>>>>>>>>>>>>>>>>>  2 files changed, 45 insertions(+), 3 deletions(-)
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> >>>>>>>>>>>>>>>>>> index 1197f245e873..2442cf7ac385 100644
> >>>>>>>>>>>>>>>>>> --- a/drivers/net/tap.c
> >>>>>>>>>>>>>>>>>> +++ b/drivers/net/tap.c
> >>>>>>>>>>>>>>>>>> @@ -753,6 +753,27 @@ static ssize_t tap_put_user(struc=
t tap_queue *q,
> >>>>>>>>>>>>>>>>>>         return ret ? ret : total;
> >>>>>>>>>>>>>>>>>>  }
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> +static void *tap_ring_consume(struct tap_queue *q)
> >>>>>>>>>>>>>>>>>> +{
> >>>>>>>>>>>>>>>>>> +       struct ptr_ring *ring =3D &q->ring;
> >>>>>>>>>>>>>>>>>> +       struct net_device *dev;
> >>>>>>>>>>>>>>>>>> +       void *ptr;
> >>>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>>> +       spin_lock(&ring->consumer_lock);
> >>>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>>> +       ptr =3D __ptr_ring_consume(ring);
> >>>>>>>>>>>>>>>>>> +       if (unlikely(ptr && __ptr_ring_consume_created=
_space(ring, 1))) {
> >>>>>>>>>>>>>>>>>> +               rcu_read_lock();
> >>>>>>>>>>>>>>>>>> +               dev =3D rcu_dereference(q->tap)->dev;
> >>>>>>>>>>>>>>>>>> +               netif_wake_subqueue(dev, q->queue_inde=
x);
> >>>>>>>>>>>>>>>>>> +               rcu_read_unlock();
> >>>>>>>>>>>>>>>>>> +       }
> >>>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>>> +       spin_unlock(&ring->consumer_lock);
> >>>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>>> +       return ptr;
> >>>>>>>>>>>>>>>>>> +}
> >>>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>>>  static ssize_t tap_do_read(struct tap_queue *q,
> >>>>>>>>>>>>>>>>>>                            struct iov_iter *to,
> >>>>>>>>>>>>>>>>>>                            int noblock, struct sk_buff=
 *skb)
> >>>>>>>>>>>>>>>>>> @@ -774,7 +795,7 @@ static ssize_t tap_do_read(struct =
tap_queue *q,
> >>>>>>>>>>>>>>>>>>                                         TASK_INTERRUPT=
IBLE);
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>                 /* Read frames from the queue */
> >>>>>>>>>>>>>>>>>> -               skb =3D ptr_ring_consume(&q->ring);
> >>>>>>>>>>>>>>>>>> +               skb =3D tap_ring_consume(q);
> >>>>>>>>>>>>>>>>>>                 if (skb)
> >>>>>>>>>>>>>>>>>>                         break;
> >>>>>>>>>>>>>>>>>>                 if (noblock) {
> >>>>>>>>>>>>>>>>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >>>>>>>>>>>>>>>>>> index 8192740357a0..7148f9a844a4 100644
> >>>>>>>>>>>>>>>>>> --- a/drivers/net/tun.c
> >>>>>>>>>>>>>>>>>> +++ b/drivers/net/tun.c
> >>>>>>>>>>>>>>>>>> @@ -2113,13 +2113,34 @@ static ssize_t tun_put_user(st=
ruct tun_struct *tun,
> >>>>>>>>>>>>>>>>>>         return total;
> >>>>>>>>>>>>>>>>>>  }
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> +static void *tun_ring_consume(struct tun_file *tfile)
> >>>>>>>>>>>>>>>>>> +{
> >>>>>>>>>>>>>>>>>> +       struct ptr_ring *ring =3D &tfile->tx_ring;
> >>>>>>>>>>>>>>>>>> +       struct net_device *dev;
> >>>>>>>>>>>>>>>>>> +       void *ptr;
> >>>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>>> +       spin_lock(&ring->consumer_lock);
> >>>>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>>>> +       ptr =3D __ptr_ring_consume(ring);
> >>>>>>>>>>>>>>>>>> +       if (unlikely(ptr && __ptr_ring_consume_created=
_space(ring, 1))) {
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> I guess it's the "bug" I mentioned in the previous patc=
h that leads to
> >>>>>>>>>>>>>>>>> the check of __ptr_ring_consume_created_space() here. I=
f it's true,
> >>>>>>>>>>>>>>>>> another call to tweak the current API.
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> +               rcu_read_lock();
> >>>>>>>>>>>>>>>>>> +               dev =3D rcu_dereference(tfile->tun)->d=
ev;
> >>>>>>>>>>>>>>>>>> +               netif_wake_subqueue(dev, tfile->queue_=
index);
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> This would cause the producer TX_SOFTIRQ to run on the =
same cpu which
> >>>>>>>>>>>>>>>>> I'm not sure is what we want.
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> What else would you suggest calling to wake the queue?
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> I don't have a good method in my mind, just want to point=
 out its implications.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> I have to admit I'm a bit stuck at this point, particularl=
y with this
> >>>>>>>>>>>>>> aspect.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> What is the correct way to pass the producer CPU ID to the=
 consumer?
> >>>>>>>>>>>>>> Would it make sense to store smp_processor_id() in the tfi=
le inside
> >>>>>>>>>>>>>> tun_net_xmit(), or should it instead be stored in the skb =
(similar to the
> >>>>>>>>>>>>>> XDP bit)? In the latter case, my concern is that this info=
rmation may
> >>>>>>>>>>>>>> already be significantly outdated by the time it is used.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Based on that, my idea would be for the consumer to wake t=
he producer by
> >>>>>>>>>>>>>> invoking a new function (e.g., tun_wake_queue()) on the pr=
oducer CPU via
> >>>>>>>>>>>>>> smp_call_function_single().
> >>>>>>>>>>>>>> Is this a reasonable approach?
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> I'm not sure but it would introduce costs like IPI.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> More generally, would triggering TX_SOFTIRQ on the consume=
r CPU be
> >>>>>>>>>>>>>> considered a deal-breaker for the patch set?
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> It depends on whether or not it has effects on the performa=
nce.
> >>>>>>>>>>>>> Especially when vhost is pinned.
> >>>>>>>>>>>>
> >>>>>>>>>>>> I meant we can benchmark to see the impact. For example, pin=
 vhost to
> >>>>>>>>>>>> a specific CPU and the try to see the impact of the TX_SOFTI=
RQ.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Thanks
> >>>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> I ran benchmarks with vhost pinned to CPU 0 using taskset -p =
-c 0 ...
> >>>>>>>>>>> for both the stock and patched versions. The benchmarks were =
run with
> >>>>>>>>>>> the full patch series applied, since testing only patches 1-3=
 would not
> >>>>>>>>>>> be meaningful - the queue is never stopped in that case, so n=
o
> >>>>>>>>>>> TX_SOFTIRQ is triggered.
> >>>>>>>>>>>
> >>>>>>>>>>> Compared to the non-pinned CPU benchmarks in the cover letter=
,
> >>>>>>>>>>> performance is lower for pktgen with a single thread but high=
er with
> >>>>>>>>>>> four threads. The results show no regression for the patched =
version,
> >>>>>>>>>>> with even slight performance improvements observed:
> >>>>>>>>>>>
> >>>>>>>>>>> +-------------------------+-----------+----------------+
> >>>>>>>>>>> | pktgen benchmarks to    | Stock     | Patched with   |
> >>>>>>>>>>> | Debian VM, i5 6300HQ,   |           | fq_codel qdisc |
> >>>>>>>>>>> | 100M packets            |           |                |
> >>>>>>>>>>> | vhost pinned to core 0  |           |                |
> >>>>>>>>>>> +-----------+-------------+-----------+----------------+
> >>>>>>>>>>> | TAP       | Transmitted | 452 Kpps  | 454 Kpps       |
> >>>>>>>>>>> |  +        +-------------+-----------+----------------+
> >>>>>>>>>>> | vhost-net | Lost        | 1154 Kpps | 0              |
> >>>>>>>>>>> +-----------+-------------+-----------+----------------+
> >>>>>>>>>>>
> >>>>>>>>>>> +-------------------------+-----------+----------------+
> >>>>>>>>>>> | pktgen benchmarks to    | Stock     | Patched with   |
> >>>>>>>>>>> | Debian VM, i5 6300HQ,   |           | fq_codel qdisc |
> >>>>>>>>>>> | 100M packets            |           |                |
> >>>>>>>>>>> | vhost pinned to core 0  |           |                |
> >>>>>>>>>>> | *4 threads*             |           |                |
> >>>>>>>>>>> +-----------+-------------+-----------+----------------+
> >>>>>>>>>>> | TAP       | Transmitted | 71 Kpps   | 79 Kpps        |
> >>>>>>>>>>> |  +        +-------------+-----------+----------------+
> >>>>>>>>>>> | vhost-net | Lost        | 1527 Kpps | 0              |
> >>>>>>>>>>> +-----------+-------------+-----------+----------------+
> >>>>>>>>>
> >>>>>>>>> The PPS seems to be low. I'd suggest using testpmd (rxonly) mod=
e in
> >>>>>>>>> the guest or an xdp program that did XDP_DROP in the guest.
> >>>>>>>>
> >>>>>>>> I forgot to mention that these PPS values are per thread.
> >>>>>>>> So overall we have 71 Kpps * 4 =3D 284 Kpps and 79 Kpps * 4 =3D =
326 Kpps,
> >>>>>>>> respectively. For packet loss, that comes out to 1154 Kpps * 4 =
=3D
> >>>>>>>> 4616 Kpps and 0, respectively.
> >>>>>>>>
> >>>>>>>> Sorry about that!
> >>>>>>>>
> >>>>>>>> The pktgen benchmarks with a single thread look fine, right?
> >>>>>>>
> >>>>>>> Still looks very low. E.g I just have a run of pktgen (using
> >>>>>>> pktgen_sample03_burst_single_flow.sh) without a XDP_DROP in the g=
uest,
> >>>>>>> I can get 1Mpps.
> >>>>>>
> >>>>>> Keep in mind that I am using an older CPU (i5-6300HQ). For the
> >>>>>> single-threaded tests I always used pktgen_sample01_simple.sh, and=
 for
> >>>>>> the multi-threaded tests I always used pktgen_sample02_multiqueue.=
sh.
> >>>>>>
> >>>>>> Using pktgen_sample03_burst_single_flow.sh as you did fails for me=
 (even
> >>>>>> though the same parameters work fine for sample01 and sample02):
> >>>>>>
> >>>>>> samples/pktgen/pktgen_sample03_burst_single_flow.sh -i tap0 -m
> >>>>>> 52:54:00:12:34:56 -d 10.0.0.2 -n 100000000
> >>>>>> /samples/pktgen/functions.sh: line 79: echo: write error: Operatio=
n not
> >>>>>> supported
> >>>>>> ERROR: Write error(1) occurred
> >>>>>> cmd: "burst 32 > /proc/net/pktgen/tap0@0"
> >>>>>>
> >>>>>> ...and I do not know what I am doing wrong, even after looking at
> >>>>>> Documentation/networking/pktgen.rst. Every burst size except 1 fai=
ls.
> >>>>>> Any clues?
> >>>>>
> >>>>> Please use -b 0, and I'm Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz.
> >>>>
> >>>> I tried using "-b 0", and while it worked, there was no noticeable
> >>>> performance improvement.
> >>>>
> >>>>>
> >>>>> Another thing I can think of is to disable
> >>>>>
> >>>>> 1) mitigations in both guest and host
> >>>>> 2) any kernel debug features in both host and guest
> >>>>
> >>>> I also rebuilt the kernel with everything disabled under
> >>>> "Kernel hacking", but that didn=E2=80=99t make any difference either=
.
> >>>>
> >>>> Because of this, I ran "pktgen_sample01_simple.sh" and
> >>>> "pktgen_sample02_multiqueue.sh" on my AMD Ryzen 5 5600X system. The
> >>>> results were about 374 Kpps with TAP and 1192 Kpps with TAP+vhost_ne=
t,
> >>>> with very similar performance between the stock and patched kernels.
> >>>>
> >>>> Personally, I think the low performance is to blame on the hardware.
> >>>
> >>> Let's double confirm this by:
> >>>
> >>> 1) make sure pktgen is using 100% CPU
> >>> 2) Perf doesn't show anything strange for pktgen thread
> >>>
> >>> Thanks
> >>>
> >>
> >> I ran pktgen using pktgen_sample01_simple.sh and, in parallel, started=
 a
> >> 100 second perf stat measurement covering all kpktgend threads.
> >>
> >> Across all configurations, a single CPU was fully utilized.
> >>
> >> Apart from that, the patched variants show a higher branch frequency a=
nd
> >> a slightly increased number of context switches.
> >>
> >>
> >> The detailed results are provided below:
> >>
> >> Processor: Ryzen 5 5600X
> >>
> >> pktgen command:
> >> sudo perf stat samples/pktgen/pktgen_sample01_simple.sh -i tap0 -m
> >> 52:54:00:12:34:56 -d 10.0.0.2 -n 10000000000
> >>
> >> perf stat command:
> >> sudo perf stat --timeout 100000 -p $(pgrep kpktgend | tr '\n' ,) -o X.=
txt
> >>
> >>
> >> Results:
> >> Stock TAP:
> >>             46.997      context-switches                 #    467,2 cs=
/sec  cs_per_second
> >>                  0      cpu-migrations                   #      0,0 mi=
grations/sec  migrations_per_second
> >>                  0      page-faults                      #      0,0 fa=
ults/sec  page_faults_per_second
> >>         100.587,69 msec task-clock                       #      1,0 CP=
Us  CPUs_utilized
> >>      8.491.586.483      branch-misses                    #     10,9 % =
 branch_miss_rate         (50,24%)
> >>     77.734.761.406      branches                         #    772,8 M/=
sec  branch_frequency     (66,85%)
> >>    382.420.291.585      cpu-cycles                       #      3,8 GH=
z  cycles_frequency       (66,85%)
> >>    377.612.185.141      instructions                     #      1,0 in=
structions  insn_per_cycle  (66,85%)
> >>     84.012.185.936      stalled-cycles-frontend          #     0,22 fr=
ontend_cycles_idle        (66,35%)
> >>
> >>      100,100414494 seconds time elapsed
> >>
> >>
> >> Stock TAP+vhost-net:
> >>             47.087      context-switches                 #    468,1 cs=
/sec  cs_per_second
> >>                  0      cpu-migrations                   #      0,0 mi=
grations/sec  migrations_per_second
> >>                  0      page-faults                      #      0,0 fa=
ults/sec  page_faults_per_second
> >>         100.594,09 msec task-clock                       #      1,0 CP=
Us  CPUs_utilized
> >>      8.034.703.613      branch-misses                    #     11,1 % =
 branch_miss_rate         (50,24%)
> >>     72.477.989.922      branches                         #    720,5 M/=
sec  branch_frequency     (66,86%)
> >>    382.218.276.832      cpu-cycles                       #      3,8 GH=
z  cycles_frequency       (66,85%)
> >>    349.555.577.281      instructions                     #      0,9 in=
structions  insn_per_cycle  (66,85%)
> >>     83.917.644.262      stalled-cycles-frontend          #     0,22 fr=
ontend_cycles_idle        (66,35%)
> >>
> >>      100,100520402 seconds time elapsed
> >>
> >>
> >> Patched TAP:
> >>             47.862      context-switches                 #    475,8 cs=
/sec  cs_per_second
> >>                  0      cpu-migrations                   #      0,0 mi=
grations/sec  migrations_per_second
> >>                  0      page-faults                      #      0,0 fa=
ults/sec  page_faults_per_second
> >>         100.589,30 msec task-clock                       #      1,0 CP=
Us  CPUs_utilized
> >>      9.337.258.794      branch-misses                    #      9,4 % =
 branch_miss_rate         (50,19%)
> >>     99.518.421.676      branches                         #    989,4 M/=
sec  branch_frequency     (66,85%)
> >>    382.508.244.894      cpu-cycles                       #      3,8 GH=
z  cycles_frequency       (66,85%)
> >>    312.582.270.975      instructions                     #      0,8 in=
structions  insn_per_cycle  (66,85%)
> >>     76.338.503.984      stalled-cycles-frontend          #     0,20 fr=
ontend_cycles_idle        (66,39%)
> >>
> >>      100,101262454 seconds time elapsed
> >>
> >>
> >> Patched TAP+vhost-net:
> >>             47.892      context-switches                 #    476,1 cs=
/sec  cs_per_second
> >>                  0      cpu-migrations                   #      0,0 mi=
grations/sec  migrations_per_second
> >>                  0      page-faults                      #      0,0 fa=
ults/sec  page_faults_per_second
> >>         100.581,95 msec task-clock                       #      1,0 CP=
Us  CPUs_utilized
> >>      9.083.588.313      branch-misses                    #     10,1 % =
 branch_miss_rate         (50,28%)
> >>     90.300.124.712      branches                         #    897,8 M/=
sec  branch_frequency     (66,85%)
> >>    382.374.510.376      cpu-cycles                       #      3,8 GH=
z  cycles_frequency       (66,85%)
> >>    340.089.181.199      instructions                     #      0,9 in=
structions  insn_per_cycle  (66,85%)
> >>     78.151.408.955      stalled-cycles-frontend          #     0,20 fr=
ontend_cycles_idle        (66,31%)
> >>
> >>      100,101212911 seconds time elapsed
> >
> > Thanks for sharing. I have more questions:
> >
> > 1) The number of CPU and vCPUs
>
> qemu runs with a single core. And my host system is now a Ryzen 5 5600x
> with 6 cores, 12 threads.
> This is my command for TAP+vhost-net:
>
> sudo qemu-system-x86_64 -hda debian.qcow2
> -netdev tap,id=3Dmynet0,ifname=3Dtap0,script=3Dno,downscript=3Dno,vhost=
=3Don
> -device virtio-net-pci,netdev=3Dmynet0 -m 1024 -enable-kvm
>
> For TAP only it is the same but without vhost=3Don.
>
> > 2) If you pin vhost or vCPU threads
>
> Not in the previous shown benchmark. I pinned vhost in other benchmarks
> but since there is only minor PPS difference I omitted for the sake of
> simplicity.
>
> > 3) what does perf top looks like or perf top -p $pid_of_vhost
>
> The perf reports for the pid_of_vhost from pktgen_sample01_simple.sh
> with TAP+vhost-net (not pinned, pktgen single queue, fq_codel) are shown
> below. I can not see a huge difference between stock and patched.
>
> Also I included perf reports from the pktgen_pids. I find them more
> intersting because tun_net_xmit shows less overhead for the patched.
> I assume that is due to the stopped netdev queue.
>
> I have now benchmarked pretty much all possible combinations (with a
> script) of TAP/TAP+vhost-net, single/multi-queue pktgen, vhost
> pinned/not pinned, with/without -b 0, fq_codel/noqueue... All of that
> with perf records..
> I could share them if you want but I feel this is getting out of hand.
>
>
> Stock:
> sudo perf record -p "$vhost_pid"
> ...
> # Overhead  Command          Shared Object               Symbol
> # ........  ...............  ..........................  ................=
..........................
> #
>      5.97%  vhost-4874       [kernel.kallsyms]           [k] _copy_to_ite=
r
>      2.68%  vhost-4874       [kernel.kallsyms]           [k] tun_do_read
>      2.23%  vhost-4874       [kernel.kallsyms]           [k] native_write=
_msr
>      1.93%  vhost-4874       [kernel.kallsyms]           [k] __check_obje=
ct_size

Let's disable CONFIG_HARDENED_USERCOPY and retry.

>      1.61%  vhost-4874       [kernel.kallsyms]           [k] __slab_free.=
isra.0
>      1.56%  vhost-4874       [kernel.kallsyms]           [k] __get_user_n=
ocheck_2
>      1.54%  vhost-4874       [kernel.kallsyms]           [k] iov_iter_zer=
o
>      1.45%  vhost-4874       [kernel.kallsyms]           [k] kmem_cache_f=
ree
>      1.43%  vhost-4874       [kernel.kallsyms]           [k] tun_recvmsg
>      1.24%  vhost-4874       [kernel.kallsyms]           [k] sk_skb_reaso=
n_drop
>      1.12%  vhost-4874       [kernel.kallsyms]           [k] srso_alias_s=
afe_ret
>      1.07%  vhost-4874       [kernel.kallsyms]           [k] native_read_=
msr
>      0.76%  vhost-4874       [kernel.kallsyms]           [k] simple_copy_=
to_iter
>      0.75%  vhost-4874       [kernel.kallsyms]           [k] srso_alias_r=
eturn_thunk
>      0.69%  vhost-4874       [vhost]                     [k] 0x0000000000=
002e70
>      0.59%  vhost-4874       [kernel.kallsyms]           [k] skb_release_=
data
>      0.59%  vhost-4874       [kernel.kallsyms]           [k] __skb_datagr=
am_iter
>      0.53%  vhost-4874       [vhost]                     [k] 0x0000000000=
002e5f
>      0.51%  vhost-4874       [kernel.kallsyms]           [k] slab_update_=
freelist.isra.0
>      0.46%  vhost-4874       [kernel.kallsyms]           [k] kfree_skbmem
>      0.44%  vhost-4874       [kernel.kallsyms]           [k] skb_copy_dat=
agram_iter
>      0.43%  vhost-4874       [kernel.kallsyms]           [k] skb_free_hea=
d
>      0.37%  qemu-system-x86  [unknown]                   [k] 0xffffffffba=
898b1b
>      0.35%  vhost-4874       [vhost]                     [k] 0x0000000000=
002e6b
>      0.33%  vhost-4874       [vhost_net]                 [k] 0x0000000000=
00357d
>      0.28%  vhost-4874       [kernel.kallsyms]           [k] __check_heap=
_object
>      0.27%  vhost-4874       [vhost_net]                 [k] 0x0000000000=
0035f3
>      0.26%  vhost-4874       [vhost_net]                 [k] 0x0000000000=
0030f6
>      0.26%  vhost-4874       [kernel.kallsyms]           [k] __virt_addr_=
valid
>      0.24%  vhost-4874       [kernel.kallsyms]           [k] iov_iter_adv=
ance
>      0.22%  vhost-4874       [kernel.kallsyms]           [k] perf_event_u=
pdate_userpage
>      0.22%  vhost-4874       [kernel.kallsyms]           [k] check_stack_=
object
>      0.19%  qemu-system-x86  [unknown]                   [k] 0xffffffffba=
2a68cd
>      0.19%  vhost-4874       [kernel.kallsyms]           [k] dequeue_enti=
ties
>      0.19%  vhost-4874       [vhost_net]                 [k] 0x0000000000=
003237
>      0.18%  vhost-4874       [vhost_net]                 [k] 0x0000000000=
003550
>      0.18%  vhost-4874       [kernel.kallsyms]           [k] x86_pmu_del
>      0.18%  vhost-4874       [vhost_net]                 [k] 0x0000000000=
0034a0
>      0.17%  vhost-4874       [kernel.kallsyms]           [k] x86_pmu_disa=
ble_all
>      0.16%  vhost-4874       [vhost_net]                 [k] 0x0000000000=
003523
>      0.16%  vhost-4874       [kernel.kallsyms]           [k] amd_pmu_addr=
_offset
> ...
>
>
> sudo perf record -p "$kpktgend_pids":
> ...
> # Overhead  Command      Shared Object      Symbol
> # ........  ...........  .................  .............................=
..................
> #
>     10.98%  kpktgend_0   [kernel.kallsyms]  [k] tun_net_xmit
>     10.45%  kpktgend_0   [kernel.kallsyms]  [k] memset
>      8.40%  kpktgend_0   [kernel.kallsyms]  [k] __alloc_skb
>      6.31%  kpktgend_0   [kernel.kallsyms]  [k] kmem_cache_alloc_node_nop=
rof
>      3.13%  kpktgend_0   [kernel.kallsyms]  [k] srso_alias_safe_ret
>      2.40%  kpktgend_0   [kernel.kallsyms]  [k] sk_skb_reason_drop
>      2.11%  kpktgend_0   [kernel.kallsyms]  [k] srso_alias_return_thunk

This is a hint that SRSO migitaion is enabled.

Have you disabled CPU_MITIGATIONS via either Kconfig or kernel command
line (mitigations =3D off) for both host and guest?

Thanks

