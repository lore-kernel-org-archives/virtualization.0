Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A5044BC8C
	for <virtualization@lists.linux.dev>; Thu, 22 Jan 2026 05:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769060178; cv=none; b=gz9PoV+03i3vQEUm8dteBqAx/oTpt+0if+TCuuREj3hV46/bo2sQR053tgby+hX5QkR/nLc+WWzyNmFJACTnxDsOl2AE2vRwUNGJLo9eyQxuGtNHilqtMdSN3/q0+1vwxloEPMTZ66JqASFxiwDf0ryyzcJcEKjjV8gY2W/jdoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769060178; c=relaxed/simple;
	bh=4u7RqhYyUxDdVXDwJ31YEx+CsrnO+8ttQ47Alq+R+iI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DYaqKhjYMTYw/xmv0Zko5+LtvyXoNPBdsKD962iNWARFDwyDVUVpyxb8YRuBIwersgdVksRAkB2uvqP3OuCM4wO4Y5QAtuc69YWPpej46GWGdLc6izi5PhgJbC3mmn5k/Iop3Ku77PPJqpMHLTHaXwKODb/k9alhiRPdrCsP8w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fIqyA4T4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fIqyA4T4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769060174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ED7l/hs/bCd8Y3NS4tIwlZAqaShpZQlaHK2896w0TZ8=;
	b=fIqyA4T4CTpewq4nU32SX+w7S4XSNv4rpGk2vHByY0H3NTCqb743/ZUmCfaCDEAeo7wfkW
	iCK+DOoBuEbBJ7HSdDlM+rZhBPKIIUjRVuwG6irnXFVoMrU4xGVhge6XO2IiYazGGHOlhs
	qzazjW8MfD8qrrobMwH5HpMi1HY5ufU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-xnaAhOsMPA2B2Tr8V_aPzQ-1; Thu, 22 Jan 2026 00:36:12 -0500
X-MC-Unique: xnaAhOsMPA2B2Tr8V_aPzQ-1
X-Mimecast-MFC-AGG-ID: xnaAhOsMPA2B2Tr8V_aPzQ_1769060172
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34c704d5d15so1177167a91.1
        for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 21:36:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769060170; x=1769664970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ED7l/hs/bCd8Y3NS4tIwlZAqaShpZQlaHK2896w0TZ8=;
        b=JFp2FJkTWA4tVx27+ZV2BQ0eZS75crae/Nd/ngyxaJ0lvNIdSPm1uNNkZVi32tAqhs
         XPeI/H6YOuhmU8IhlASh+WcAnbCXc+MAb/fadqL+7y4Sf6J2FjloNLhxxCNVr5WLYBnD
         RDXgEHBiB1Yempar7l8VzVjfECIzx1fckQBX9kcjp1MLtUyR3HiRTyoiE1364k9C9oTG
         Plmh/ROqwGYc8P6+IRj9ouvcM8q18opxxbKw1V/VhblyXXjwbMiotcPMgbjAWAQs5LMV
         Fyg/GEkNwP7Z6KKC+lS0wU/fnWPcjrCtYNdZLA0L32yJS8Bi4Cv5AotsEN43SueMERv+
         eKkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsWh9h3wpZPsX5OYD1LXj3bHbVZyxltyUcfTdE3sHZmT1t2SLvdCEvgeL3fAdoc8K77fuzY1JUfXAH/Wx+gg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyDgbxAi7eBW2Agk0q5+J254tLkT/q8LsNT5WEMFpdWMw0gHTYF
	RQhkfwVWJqKBO0gxQ/4368schvtHM66s+NtLwB000KRrrpTOJNVpSM+0rlM8mYToDep7xBgtwnS
	RGBDyVfAA+zqilS8aOsQyR4pK/iwx7EehJV5tPlclo6kyeogpSCq8fq9hO1DkNGSPTjHeqYv3VQ
	AzomSC23ot4TdjRd4T9f/Wi21/+N7VzkUFSQa/6LwkNsU=
X-Gm-Gg: AZuq6aLOGeQ07MXIm3n91mR7tEQDdWYGQM0mBBoeKqRpq8ptNsbv5zWZM1GHbh58pnG
	Q1wlBrJ+TLL3kHi7ro/I2zYQg4+DpOypXwrsVcLtFUzhl4X4htdgbZHT6G9tftvXvHLVis+A59S
	uOT61jrDtzrhiHiz6c7NuDcHhDb6SD55ZntKEKvhjUFJUP/xmnzbt25Pi36Q07qr/FBUI=
X-Received: by 2002:a17:90b:51:b0:353:41e:1f51 with SMTP id 98e67ed59e1d1-353041e787cmr3670052a91.32.1769060170503;
        Wed, 21 Jan 2026 21:36:10 -0800 (PST)
X-Received: by 2002:a17:90b:51:b0:353:41e:1f51 with SMTP id
 98e67ed59e1d1-353041e787cmr3670034a91.32.1769060170061; Wed, 21 Jan 2026
 21:36:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260107210448.37851-1-simon.schippers@tu-dortmund.de>
 <20260107210448.37851-4-simon.schippers@tu-dortmund.de> <CACGkMEuSiEcyaeFeZd0=RgNpviJgNvUDq_ctjeMLT5jZTgRkwQ@mail.gmail.com>
 <1e30464c-99ae-441e-bb46-6d0485d494dc@tu-dortmund.de> <CACGkMEtzD3ORJuJcc8VeqwASiGeVFdQmJowsK6PYVEF_Zkcn8Q@mail.gmail.com>
 <afa40345-acbe-42b0-81d1-0a838343792d@tu-dortmund.de>
In-Reply-To: <afa40345-acbe-42b0-81d1-0a838343792d@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 22 Jan 2026 13:35:57 +0800
X-Gm-Features: AZwV_Qj0WIKFoTOn0eU2tLMfUdJil-HIikNxIFlK3wwyEXYRVe6obOMN0rB6aW0
Message-ID: <CACGkMEtxRoavBMTXom8Z=FM-pvu3pHbsuwCs+e450b1B=V7iWA@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: wC_14zOK5JkG1a7cuUM6XtR46yJ1Uu5gdCwHvj0O3OU_1769060172
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 5:33=E2=80=AFPM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> On 1/9/26 07:02, Jason Wang wrote:
> > On Thu, Jan 8, 2026 at 3:41=E2=80=AFPM Simon Schippers
> > <simon.schippers@tu-dortmund.de> wrote:
> >>
> >> On 1/8/26 04:38, Jason Wang wrote:
> >>> On Thu, Jan 8, 2026 at 5:06=E2=80=AFAM Simon Schippers
> >>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>
> >>>> Introduce {tun,tap}_ring_consume() helpers that wrap __ptr_ring_cons=
ume()
> >>>> and wake the corresponding netdev subqueue when consuming an entry f=
rees
> >>>> space in the underlying ptr_ring.
> >>>>
> >>>> Stopping of the netdev queue when the ptr_ring is full will be intro=
duced
> >>>> in an upcoming commit.
> >>>>
> >>>> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>>> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >>>> ---
> >>>>  drivers/net/tap.c | 23 ++++++++++++++++++++++-
> >>>>  drivers/net/tun.c | 25 +++++++++++++++++++++++--
> >>>>  2 files changed, 45 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> >>>> index 1197f245e873..2442cf7ac385 100644
> >>>> --- a/drivers/net/tap.c
> >>>> +++ b/drivers/net/tap.c
> >>>> @@ -753,6 +753,27 @@ static ssize_t tap_put_user(struct tap_queue *q=
,
> >>>>         return ret ? ret : total;
> >>>>  }
> >>>>
> >>>> +static void *tap_ring_consume(struct tap_queue *q)
> >>>> +{
> >>>> +       struct ptr_ring *ring =3D &q->ring;
> >>>> +       struct net_device *dev;
> >>>> +       void *ptr;
> >>>> +
> >>>> +       spin_lock(&ring->consumer_lock);
> >>>> +
> >>>> +       ptr =3D __ptr_ring_consume(ring);
> >>>> +       if (unlikely(ptr && __ptr_ring_consume_created_space(ring, 1=
))) {
> >>>> +               rcu_read_lock();
> >>>> +               dev =3D rcu_dereference(q->tap)->dev;
> >>>> +               netif_wake_subqueue(dev, q->queue_index);
> >>>> +               rcu_read_unlock();
> >>>> +       }
> >>>> +
> >>>> +       spin_unlock(&ring->consumer_lock);
> >>>> +
> >>>> +       return ptr;
> >>>> +}
> >>>> +
> >>>>  static ssize_t tap_do_read(struct tap_queue *q,
> >>>>                            struct iov_iter *to,
> >>>>                            int noblock, struct sk_buff *skb)
> >>>> @@ -774,7 +795,7 @@ static ssize_t tap_do_read(struct tap_queue *q,
> >>>>                                         TASK_INTERRUPTIBLE);
> >>>>
> >>>>                 /* Read frames from the queue */
> >>>> -               skb =3D ptr_ring_consume(&q->ring);
> >>>> +               skb =3D tap_ring_consume(q);
> >>>>                 if (skb)
> >>>>                         break;
> >>>>                 if (noblock) {
> >>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >>>> index 8192740357a0..7148f9a844a4 100644
> >>>> --- a/drivers/net/tun.c
> >>>> +++ b/drivers/net/tun.c
> >>>> @@ -2113,13 +2113,34 @@ static ssize_t tun_put_user(struct tun_struc=
t *tun,
> >>>>         return total;
> >>>>  }
> >>>>
> >>>> +static void *tun_ring_consume(struct tun_file *tfile)
> >>>> +{
> >>>> +       struct ptr_ring *ring =3D &tfile->tx_ring;
> >>>> +       struct net_device *dev;
> >>>> +       void *ptr;
> >>>> +
> >>>> +       spin_lock(&ring->consumer_lock);
> >>>> +
> >>>> +       ptr =3D __ptr_ring_consume(ring);
> >>>> +       if (unlikely(ptr && __ptr_ring_consume_created_space(ring, 1=
))) {
> >>>
> >>> I guess it's the "bug" I mentioned in the previous patch that leads t=
o
> >>> the check of __ptr_ring_consume_created_space() here. If it's true,
> >>> another call to tweak the current API.
> >>>
> >>>> +               rcu_read_lock();
> >>>> +               dev =3D rcu_dereference(tfile->tun)->dev;
> >>>> +               netif_wake_subqueue(dev, tfile->queue_index);
> >>>
> >>> This would cause the producer TX_SOFTIRQ to run on the same cpu which
> >>> I'm not sure is what we want.
> >>
> >> What else would you suggest calling to wake the queue?
> >
> > I don't have a good method in my mind, just want to point out its impli=
cations.
>
> I have to admit I'm a bit stuck at this point, particularly with this
> aspect.
>
> What is the correct way to pass the producer CPU ID to the consumer?
> Would it make sense to store smp_processor_id() in the tfile inside
> tun_net_xmit(), or should it instead be stored in the skb (similar to the
> XDP bit)? In the latter case, my concern is that this information may
> already be significantly outdated by the time it is used.
>
> Based on that, my idea would be for the consumer to wake the producer by
> invoking a new function (e.g., tun_wake_queue()) on the producer CPU via
> smp_call_function_single().
> Is this a reasonable approach?

I'm not sure but it would introduce costs like IPI.

>
> More generally, would triggering TX_SOFTIRQ on the consumer CPU be
> considered a deal-breaker for the patch set?

It depends on whether or not it has effects on the performance.
Especially when vhost is pinned.

Thanks

>
> Thanks!
>
> >
> >>
> >>>
> >>>> +               rcu_read_unlock();
> >>>> +       }
> >>>
> >>> Btw, this function duplicates a lot of logic of tap_ring_consume() we
> >>> should consider to merge the logic.
> >>
> >> Yes, it is largely the same approach, but it would require accessing t=
he
> >> net_device each time.
> >
> > The problem is that, at least for TUN, the socket is loosely coupled
> > with the netdev. It means the netdev can go away while the socket
> > might still exist. That's why vhost only talks to the socket, not the
> > netdev. If we really want to go this way, here, we should at least
> > check the existence of tun->dev first.
> >
> >>
> >>>
> >>>> +
> >>>> +       spin_unlock(&ring->consumer_lock);
> >>>> +
> >>>> +       return ptr;
> >>>> +}
> >>>> +
> >>>>  static void *tun_ring_recv(struct tun_file *tfile, int noblock, int=
 *err)
> >>>>  {
> >>>>         DECLARE_WAITQUEUE(wait, current);
> >>>>         void *ptr =3D NULL;
> >>>>         int error =3D 0;
> >>>>
> >>>> -       ptr =3D ptr_ring_consume(&tfile->tx_ring);
> >>>> +       ptr =3D tun_ring_consume(tfile);
> >>>
> >>> I'm not sure having a separate patch like this may help. For example,
> >>> it will introduce performance regression.
> >>
> >> I ran benchmarks for the whole patch set with noqueue (where the queue=
 is
> >> not stopped to preserve the old behavior), as described in the cover
> >> letter, and observed no performance regression. This leads me to concl=
ude
> >> that there is no performance impact because of this patch when the que=
ue
> >> is not stopped.
> >
> > Have you run a benchmark per patch? Or it might just be because the
> > regression is not obvious. But at least this patch would introduce
> > more atomic operations or it might just because the TUN doesn't
> > support burst so pktgen can't have the best PPS.
> >
> > Thanks
> >
> >
> >>
> >>>
> >>>>         if (ptr)
> >>>>                 goto out;
> >>>>         if (noblock) {
> >>>> @@ -2131,7 +2152,7 @@ static void *tun_ring_recv(struct tun_file *tf=
ile, int noblock, int *err)
> >>>>
> >>>>         while (1) {
> >>>>                 set_current_state(TASK_INTERRUPTIBLE);
> >>>> -               ptr =3D ptr_ring_consume(&tfile->tx_ring);
> >>>> +               ptr =3D tun_ring_consume(tfile);
> >>>>                 if (ptr)
> >>>>                         break;
> >>>>                 if (signal_pending(current)) {
> >>>> --
> >>>> 2.43.0
> >>>>
> >>>
> >>> Thanks
> >>>
> >>
> >
>

