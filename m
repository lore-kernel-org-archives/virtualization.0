Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D210F319610
	for <virtualization@lists.linux.dev>; Fri, 23 Jan 2026 03:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769137536; cv=none; b=GvCZFrxNvui4lS3NutAflkl6iQY6yovYA8S31zhgAMT7PAHXl8DkBfW4SAbHTi4Un8e1P1D4t4p1jUdLd8VfiixC18Y4wooNGax926vfWhn1AVazVB7Vn4rcCB3QqBar29haXWO2rs7g2KiItyGOehdXgNJ0EQewLtMQJRbdu8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769137536; c=relaxed/simple;
	bh=aHgjChBg5ZuuLmXn1MuuJOyiw447ndFIGhoil8tVmQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=irsj+BAOQSPni7jvozCewj2DASepjvks/T4OUrtAEsViDYFbDEpNaxWFTOUOyqYooBt91pYqmyqDRzZJxslSAHIHhUiOqnJhlff96Npnsl3ucdvP5q5Y50pDcRbsDmk1R1tsrRaT1oQseYpQOwz5lz8NilawoM78IJUE7Bpp7nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X9+RVLvr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X9+RVLvr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769137519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jlpwSkdal7tGYPivZ2DxNYklI4++k5PPeAgE7brzBDw=;
	b=X9+RVLvrXFepilVbpYfO75nvCvsPAwUZ7vWd7RCNedQ62vdGLfDx8AxZWzExNZ6S9MlmGl
	j92nCT7CaSGi8b6Q9GbWQ7YekZVk/CiGPLLiXD99a6ZCSs0uvcsFHQiFwhfMvmk6ftigCy
	zi7w0l0z+UEW+awHiQ7XkdqeuarAz2s=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-h4VE1ZcQPrKBgzZAzbqEvQ-1; Thu, 22 Jan 2026 22:05:18 -0500
X-MC-Unique: h4VE1ZcQPrKBgzZAzbqEvQ-1
X-Mimecast-MFC-AGG-ID: h4VE1ZcQPrKBgzZAzbqEvQ_1769137518
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29f29ae883bso11888985ad.3
        for <virtualization@lists.linux.dev>; Thu, 22 Jan 2026 19:05:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769137513; x=1769742313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jlpwSkdal7tGYPivZ2DxNYklI4++k5PPeAgE7brzBDw=;
        b=f174rZqljd3vWYWfFPKNyi6P6VYtIS9tQPNvD8H63GNYcFSZmwKX6A52nAQAyP85X2
         UOhgFZlNhF/yYxMhlDYjs+FCq9RzdaVR+0c7y6Fx4kU4G2ddjofdOZfIPZWtPMOnvEl4
         cXNP6N+i0H2SmPP3nOXjz9ItlTJEZQ6KMRrdUw9jKmM9gpeWL/7deiXl3JIL+LEGDTdH
         jljG3SM3PIOe266EANUuR1R6ATbr16hqov3R/xCCFR77/oyW0fhpdObooydJUrlmrz/V
         +526TaRankmstX+c5DOrimkFNai8a6EJLTzQWGdcz1Bk5SRRU6lm0M4YBrwl3EwGv813
         p0TA==
X-Forwarded-Encrypted: i=1; AJvYcCV8uSwYNuHg7y+LpiXUUk6cRbU6eyiYROspCemL3PLGJdz8/fJ9FOsm5CDE6GBW7cYpvaOcZV6G9bcbqXtfuw==@lists.linux.dev
X-Gm-Message-State: AOJu0YycfK2peuHselvrZCVUfKcbo8rZXFgclvWBIwix0oOc1SPaOwH7
	/aMVPqfXYsIIU8Heq/g7WzXv+8X5lQtELzJ7MSYNldvLNjREPFztKEL4q86xzpyT9ujbhL8CRvE
	fP2lMFLjRTg6nrCvzRJ8c0LRcMaNOF/Imhlz+fTZxW/pbrPlfGPr15f88ny353IoRPj7HyOeeWa
	u/Ps2SzNu4lV7pf3Tf5S00LjBHT72Qtx8lq09tYMvSWag=
X-Gm-Gg: AZuq6aLF7B1BBzj5MZW21ilTStEHWp/uTkiufoi219hfiE0t4/S4yJD3nqBwznw/yl6
	OdBEU2+gw1k5rzL1ieFGSnqXq04l6+B+50RZ19s9OcEoSaG2/ThWyb8SanP1r+cnkHZbEahw6Im
	USm0UZhbwZRwSC5KSqaMGzH2aR2QxWz2VGrLeMC2N+YmLFlQRZMDi8gIuUYaJ2jPs8yjI=
X-Received: by 2002:a17:902:f745:b0:2a7:afca:fd1d with SMTP id d9443c01a7336-2a7fe57ddc8mr14979955ad.14.1769137512990;
        Thu, 22 Jan 2026 19:05:12 -0800 (PST)
X-Received: by 2002:a17:902:f745:b0:2a7:afca:fd1d with SMTP id
 d9443c01a7336-2a7fe57ddc8mr14979705ad.14.1769137512538; Thu, 22 Jan 2026
 19:05:12 -0800 (PST)
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
In-Reply-To: <CACGkMEtxRoavBMTXom8Z=FM-pvu3pHbsuwCs+e450b1B=V7iWA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 23 Jan 2026 11:05:01 +0800
X-Gm-Features: AZwV_QhfJpNa-qyRW4HkPU0pltcsmh5NSX3tjMBQH3mbBHwnwdX2N3ZeHrsOtZM
Message-ID: <CACGkMEsJKeEsH=G8H5RzMNHY4g3HNdciMDMhciShawh-9Xb9hg@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: Uzv6f6ujnFe_XU3-MCTcRjAA8HiCVeENstl_w19xw50_1769137518
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 1:35=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Jan 21, 2026 at 5:33=E2=80=AFPM Simon Schippers
> <simon.schippers@tu-dortmund.de> wrote:
> >
> > On 1/9/26 07:02, Jason Wang wrote:
> > > On Thu, Jan 8, 2026 at 3:41=E2=80=AFPM Simon Schippers
> > > <simon.schippers@tu-dortmund.de> wrote:
> > >>
> > >> On 1/8/26 04:38, Jason Wang wrote:
> > >>> On Thu, Jan 8, 2026 at 5:06=E2=80=AFAM Simon Schippers
> > >>> <simon.schippers@tu-dortmund.de> wrote:
> > >>>>
> > >>>> Introduce {tun,tap}_ring_consume() helpers that wrap __ptr_ring_co=
nsume()
> > >>>> and wake the corresponding netdev subqueue when consuming an entry=
 frees
> > >>>> space in the underlying ptr_ring.
> > >>>>
> > >>>> Stopping of the netdev queue when the ptr_ring is full will be int=
roduced
> > >>>> in an upcoming commit.
> > >>>>
> > >>>> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > >>>> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > >>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> > >>>> ---
> > >>>>  drivers/net/tap.c | 23 ++++++++++++++++++++++-
> > >>>>  drivers/net/tun.c | 25 +++++++++++++++++++++++--
> > >>>>  2 files changed, 45 insertions(+), 3 deletions(-)
> > >>>>
> > >>>> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> > >>>> index 1197f245e873..2442cf7ac385 100644
> > >>>> --- a/drivers/net/tap.c
> > >>>> +++ b/drivers/net/tap.c
> > >>>> @@ -753,6 +753,27 @@ static ssize_t tap_put_user(struct tap_queue =
*q,
> > >>>>         return ret ? ret : total;
> > >>>>  }
> > >>>>
> > >>>> +static void *tap_ring_consume(struct tap_queue *q)
> > >>>> +{
> > >>>> +       struct ptr_ring *ring =3D &q->ring;
> > >>>> +       struct net_device *dev;
> > >>>> +       void *ptr;
> > >>>> +
> > >>>> +       spin_lock(&ring->consumer_lock);
> > >>>> +
> > >>>> +       ptr =3D __ptr_ring_consume(ring);
> > >>>> +       if (unlikely(ptr && __ptr_ring_consume_created_space(ring,=
 1))) {
> > >>>> +               rcu_read_lock();
> > >>>> +               dev =3D rcu_dereference(q->tap)->dev;
> > >>>> +               netif_wake_subqueue(dev, q->queue_index);
> > >>>> +               rcu_read_unlock();
> > >>>> +       }
> > >>>> +
> > >>>> +       spin_unlock(&ring->consumer_lock);
> > >>>> +
> > >>>> +       return ptr;
> > >>>> +}
> > >>>> +
> > >>>>  static ssize_t tap_do_read(struct tap_queue *q,
> > >>>>                            struct iov_iter *to,
> > >>>>                            int noblock, struct sk_buff *skb)
> > >>>> @@ -774,7 +795,7 @@ static ssize_t tap_do_read(struct tap_queue *q=
,
> > >>>>                                         TASK_INTERRUPTIBLE);
> > >>>>
> > >>>>                 /* Read frames from the queue */
> > >>>> -               skb =3D ptr_ring_consume(&q->ring);
> > >>>> +               skb =3D tap_ring_consume(q);
> > >>>>                 if (skb)
> > >>>>                         break;
> > >>>>                 if (noblock) {
> > >>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > >>>> index 8192740357a0..7148f9a844a4 100644
> > >>>> --- a/drivers/net/tun.c
> > >>>> +++ b/drivers/net/tun.c
> > >>>> @@ -2113,13 +2113,34 @@ static ssize_t tun_put_user(struct tun_str=
uct *tun,
> > >>>>         return total;
> > >>>>  }
> > >>>>
> > >>>> +static void *tun_ring_consume(struct tun_file *tfile)
> > >>>> +{
> > >>>> +       struct ptr_ring *ring =3D &tfile->tx_ring;
> > >>>> +       struct net_device *dev;
> > >>>> +       void *ptr;
> > >>>> +
> > >>>> +       spin_lock(&ring->consumer_lock);
> > >>>> +
> > >>>> +       ptr =3D __ptr_ring_consume(ring);
> > >>>> +       if (unlikely(ptr && __ptr_ring_consume_created_space(ring,=
 1))) {
> > >>>
> > >>> I guess it's the "bug" I mentioned in the previous patch that leads=
 to
> > >>> the check of __ptr_ring_consume_created_space() here. If it's true,
> > >>> another call to tweak the current API.
> > >>>
> > >>>> +               rcu_read_lock();
> > >>>> +               dev =3D rcu_dereference(tfile->tun)->dev;
> > >>>> +               netif_wake_subqueue(dev, tfile->queue_index);
> > >>>
> > >>> This would cause the producer TX_SOFTIRQ to run on the same cpu whi=
ch
> > >>> I'm not sure is what we want.
> > >>
> > >> What else would you suggest calling to wake the queue?
> > >
> > > I don't have a good method in my mind, just want to point out its imp=
lications.
> >
> > I have to admit I'm a bit stuck at this point, particularly with this
> > aspect.
> >
> > What is the correct way to pass the producer CPU ID to the consumer?
> > Would it make sense to store smp_processor_id() in the tfile inside
> > tun_net_xmit(), or should it instead be stored in the skb (similar to t=
he
> > XDP bit)? In the latter case, my concern is that this information may
> > already be significantly outdated by the time it is used.
> >
> > Based on that, my idea would be for the consumer to wake the producer b=
y
> > invoking a new function (e.g., tun_wake_queue()) on the producer CPU vi=
a
> > smp_call_function_single().
> > Is this a reasonable approach?
>
> I'm not sure but it would introduce costs like IPI.
>
> >
> > More generally, would triggering TX_SOFTIRQ on the consumer CPU be
> > considered a deal-breaker for the patch set?
>
> It depends on whether or not it has effects on the performance.
> Especially when vhost is pinned.

I meant we can benchmark to see the impact. For example, pin vhost to
a specific CPU and the try to see the impact of the TX_SOFTIRQ.

Thanks

