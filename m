Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72AE8F48
	for <virtualization@lists.linux.dev>; Fri,  9 Jan 2026 06:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767938573; cv=none; b=taMKcIAJDLH+jXUX12rV5llKePCTjcgPBjHlLeLXY/vx04KenGEoRtf1wx+bqsTtbHzkAo6YcG53sMsuJ1F8DFpDHc71dEOVqqnz7HbafoJgFE6iYu2k4ghAVGWlX87tuv2gX72ut6xVDxTaF4KlZcO25LNFHp3inbdGyTZJArM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767938573; c=relaxed/simple;
	bh=YnFTIdi4PfaMQlpxKfShCgMWDg6rF+C/fBvVfeSfgPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mlKKFBBDvuuywsVPvFi0IlMjANzItxuXGtShx/0Wtpc6cMThVLfGc8TkyROWhXHcRVCgsWUXuBrDR1GEimTA11PaI+X+5Jirf5tbqfVttZ75LtqZrnd4RSw+CjsgfHcMj/a35f/T2vYD0yED6willutGflLRREOn7bIECZqAWtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N6aAs86b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N6aAs86b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767938569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p2hMlpnvLYoRWhhofMpO/2lLV9HUsoZryYZGZueCrTY=;
	b=N6aAs86btc1DmiBBozEF8sQxt63bk5nLBlZORlmnwIcGI5NfvXIB1Kxa8Fapi6tZERfFMt
	UGuJ7zUIqVqRaoEzjQzo0Mkuun6JXG4Mjoh/g5MwiGAIr18PL1b7EhdKDdMDCZIbdy9Q48
	ZgirZbyJgDNOd84Femcd6zilNj7TZUk=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-_0dUGNYROx2QsB0nLyOcLg-1; Fri, 09 Jan 2026 01:02:47 -0500
X-MC-Unique: _0dUGNYROx2QsB0nLyOcLg-1
X-Mimecast-MFC-AGG-ID: _0dUGNYROx2QsB0nLyOcLg_1767938566
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c503d6be76fso3782843a12.0
        for <virtualization@lists.linux.dev>; Thu, 08 Jan 2026 22:02:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767938565; x=1768543365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p2hMlpnvLYoRWhhofMpO/2lLV9HUsoZryYZGZueCrTY=;
        b=XHBXD0oL1u+VrFY6i4DKhAqc2z/I+rXKrBxtgyfZ0aviqZeWX2NkcmtdhNwve6ti6M
         NmVjMaZLTPHSVwzE0envWDri6CUh92IB/VV0fuFA+LfR2P8xb41tg1jNGxt842V2yMag
         tevVKUqujQvLv2lNg38UPakAIt1x5v8O8EojhOAzHGyQx/hLzDJpFVM24tyIvNzfQN6b
         P0NhzbyHF7XSIezX4csyjybrkbBi5jp04q2oVREnx5OFIs/32GMkuHSocrSD4HQKY60V
         jkTWPVQV2J2HMbm+j8oFTOgsM3n/aU/uMOlAxyZlgS74ZU7XZ/pBbcWiv5zwldBCZhtJ
         fH6A==
X-Forwarded-Encrypted: i=1; AJvYcCVUfgfXbz0aL7xDWM5ZueH1NhNc/BZDbcQ3wXMgt6HFExVdlGB6EvUFai+xhcWmRkpJaNjjAsBG0OcLDgRGDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzdoj70kugin/CsBpzgpxLINkJziYeDPHPhkLByOFbaB8KYaLlb
	iLhjZN+h23+nwbGZoVAqXczgC6A8lSrN0MlK0X4n7NCM8g/A5tByqWRCMSFMYJyZjGrY3x1RTRc
	KSEW8wqPMfOsjhjBMY7W4HMa2i3veq9EtG8lxIClP4FnD77MU/7o0Jaedzg4qc3n9Vd0uCRlQ38
	Eg9f627MQjde0iiNk3eQurg6NsyyJGVsKFcyR1O5+Uomk=
X-Gm-Gg: AY/fxX7yuKK5v5EwVxE3UptpJIFBqj9V6ff+wdDgq71sjPSmcFf4E1fiCxeWX190VCv
	lopRgPpCCosa+SdGlmWXdvOzOI7QCsMhRTsjkZfm2Jkx3q9h9oZAWPHT0guwg7mekui+ljTocUO
	q1m/lVhD0+I/hOHA8ynXLPZ3eGQF370MjrB2xNIterGxaNnaFk8vho7oc2xShcSl8=
X-Received: by 2002:a05:6300:218a:b0:361:28dd:a9ff with SMTP id adf61e73a8af0-3898f991455mr7732759637.38.1767938564991;
        Thu, 08 Jan 2026 22:02:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrS63ctwaE/IB5vtnIB6hwxDOGodoN9HgUdD+0c8gMXe3jRJxxejS1yrmIdyI0s2U9RWy26VSaHfjh6vcmneo=
X-Received: by 2002:a05:6300:218a:b0:361:28dd:a9ff with SMTP id
 adf61e73a8af0-3898f991455mr7732725637.38.1767938564493; Thu, 08 Jan 2026
 22:02:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260107210448.37851-1-simon.schippers@tu-dortmund.de>
 <20260107210448.37851-4-simon.schippers@tu-dortmund.de> <CACGkMEuSiEcyaeFeZd0=RgNpviJgNvUDq_ctjeMLT5jZTgRkwQ@mail.gmail.com>
 <1e30464c-99ae-441e-bb46-6d0485d494dc@tu-dortmund.de>
In-Reply-To: <1e30464c-99ae-441e-bb46-6d0485d494dc@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 9 Jan 2026 14:02:32 +0800
X-Gm-Features: AQt7F2qdsvdsydCjiqne5rbrvnwgfREUOtYyZEbAt_1uB3BziRw5-zQdeYgLgS8
Message-ID: <CACGkMEtzD3ORJuJcc8VeqwASiGeVFdQmJowsK6PYVEF_Zkcn8Q@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: UuIljt1PCoIvV1XOQGvozxDPMZmhsne_AJfpj_hC-Yc_1767938566
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 3:41=E2=80=AFPM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> On 1/8/26 04:38, Jason Wang wrote:
> > On Thu, Jan 8, 2026 at 5:06=E2=80=AFAM Simon Schippers
> > <simon.schippers@tu-dortmund.de> wrote:
> >>
> >> Introduce {tun,tap}_ring_consume() helpers that wrap __ptr_ring_consum=
e()
> >> and wake the corresponding netdev subqueue when consuming an entry fre=
es
> >> space in the underlying ptr_ring.
> >>
> >> Stopping of the netdev queue when the ptr_ring is full will be introdu=
ced
> >> in an upcoming commit.
> >>
> >> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >> ---
> >>  drivers/net/tap.c | 23 ++++++++++++++++++++++-
> >>  drivers/net/tun.c | 25 +++++++++++++++++++++++--
> >>  2 files changed, 45 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> >> index 1197f245e873..2442cf7ac385 100644
> >> --- a/drivers/net/tap.c
> >> +++ b/drivers/net/tap.c
> >> @@ -753,6 +753,27 @@ static ssize_t tap_put_user(struct tap_queue *q,
> >>         return ret ? ret : total;
> >>  }
> >>
> >> +static void *tap_ring_consume(struct tap_queue *q)
> >> +{
> >> +       struct ptr_ring *ring =3D &q->ring;
> >> +       struct net_device *dev;
> >> +       void *ptr;
> >> +
> >> +       spin_lock(&ring->consumer_lock);
> >> +
> >> +       ptr =3D __ptr_ring_consume(ring);
> >> +       if (unlikely(ptr && __ptr_ring_consume_created_space(ring, 1))=
) {
> >> +               rcu_read_lock();
> >> +               dev =3D rcu_dereference(q->tap)->dev;
> >> +               netif_wake_subqueue(dev, q->queue_index);
> >> +               rcu_read_unlock();
> >> +       }
> >> +
> >> +       spin_unlock(&ring->consumer_lock);
> >> +
> >> +       return ptr;
> >> +}
> >> +
> >>  static ssize_t tap_do_read(struct tap_queue *q,
> >>                            struct iov_iter *to,
> >>                            int noblock, struct sk_buff *skb)
> >> @@ -774,7 +795,7 @@ static ssize_t tap_do_read(struct tap_queue *q,
> >>                                         TASK_INTERRUPTIBLE);
> >>
> >>                 /* Read frames from the queue */
> >> -               skb =3D ptr_ring_consume(&q->ring);
> >> +               skb =3D tap_ring_consume(q);
> >>                 if (skb)
> >>                         break;
> >>                 if (noblock) {
> >> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >> index 8192740357a0..7148f9a844a4 100644
> >> --- a/drivers/net/tun.c
> >> +++ b/drivers/net/tun.c
> >> @@ -2113,13 +2113,34 @@ static ssize_t tun_put_user(struct tun_struct =
*tun,
> >>         return total;
> >>  }
> >>
> >> +static void *tun_ring_consume(struct tun_file *tfile)
> >> +{
> >> +       struct ptr_ring *ring =3D &tfile->tx_ring;
> >> +       struct net_device *dev;
> >> +       void *ptr;
> >> +
> >> +       spin_lock(&ring->consumer_lock);
> >> +
> >> +       ptr =3D __ptr_ring_consume(ring);
> >> +       if (unlikely(ptr && __ptr_ring_consume_created_space(ring, 1))=
) {
> >
> > I guess it's the "bug" I mentioned in the previous patch that leads to
> > the check of __ptr_ring_consume_created_space() here. If it's true,
> > another call to tweak the current API.
> >
> >> +               rcu_read_lock();
> >> +               dev =3D rcu_dereference(tfile->tun)->dev;
> >> +               netif_wake_subqueue(dev, tfile->queue_index);
> >
> > This would cause the producer TX_SOFTIRQ to run on the same cpu which
> > I'm not sure is what we want.
>
> What else would you suggest calling to wake the queue?

I don't have a good method in my mind, just want to point out its implicati=
ons.

>
> >
> >> +               rcu_read_unlock();
> >> +       }
> >
> > Btw, this function duplicates a lot of logic of tap_ring_consume() we
> > should consider to merge the logic.
>
> Yes, it is largely the same approach, but it would require accessing the
> net_device each time.

The problem is that, at least for TUN, the socket is loosely coupled
with the netdev. It means the netdev can go away while the socket
might still exist. That's why vhost only talks to the socket, not the
netdev. If we really want to go this way, here, we should at least
check the existence of tun->dev first.

>
> >
> >> +
> >> +       spin_unlock(&ring->consumer_lock);
> >> +
> >> +       return ptr;
> >> +}
> >> +
> >>  static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *=
err)
> >>  {
> >>         DECLARE_WAITQUEUE(wait, current);
> >>         void *ptr =3D NULL;
> >>         int error =3D 0;
> >>
> >> -       ptr =3D ptr_ring_consume(&tfile->tx_ring);
> >> +       ptr =3D tun_ring_consume(tfile);
> >
> > I'm not sure having a separate patch like this may help. For example,
> > it will introduce performance regression.
>
> I ran benchmarks for the whole patch set with noqueue (where the queue is
> not stopped to preserve the old behavior), as described in the cover
> letter, and observed no performance regression. This leads me to conclude
> that there is no performance impact because of this patch when the queue
> is not stopped.

Have you run a benchmark per patch? Or it might just be because the
regression is not obvious. But at least this patch would introduce
more atomic operations or it might just because the TUN doesn't
support burst so pktgen can't have the best PPS.

Thanks


>
> >
> >>         if (ptr)
> >>                 goto out;
> >>         if (noblock) {
> >> @@ -2131,7 +2152,7 @@ static void *tun_ring_recv(struct tun_file *tfil=
e, int noblock, int *err)
> >>
> >>         while (1) {
> >>                 set_current_state(TASK_INTERRUPTIBLE);
> >> -               ptr =3D ptr_ring_consume(&tfile->tx_ring);
> >> +               ptr =3D tun_ring_consume(tfile);
> >>                 if (ptr)
> >>                         break;
> >>                 if (signal_pending(current)) {
> >> --
> >> 2.43.0
> >>
> >
> > Thanks
> >
>

