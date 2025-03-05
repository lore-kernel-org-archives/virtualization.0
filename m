Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5385103F
	for <virtualization@lists.linux.dev>; Wed,  5 Mar 2025 05:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741151534; cv=none; b=EQDgF6fYHcTZgpYIOFaaoFwRkI555kIkrtt/exZUYBoEE1/mY2RXbwqnC/NJrZF70UUujG8EGNYNYUZqRbQZFLFn9zleLGU/wyfmy6Wmtow1V7q6xu3Gw7J5LGLt9k1HUKxhMSGbev5huEiz+aOcynwqF4KCv1owPE53ZUXIYlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741151534; c=relaxed/simple;
	bh=CfwmeBhi7xvo6WZWBaowlCH0XYczkdoGhtIg86fxDKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=MExYkxc5WiymVBnQiKN17l6Yrgwqo8Yny24Av/HZFYarcKZ6AmcShi7dqxM/7ubPAW0ZWleN1QUyR4zieOUspPTp1Sr7fLd9pv2WIk/X0+fedwi6670ryn8YUes1kHHFuKMWGXYs/LZj4dOOm1Q0Dn7Q8IFP6qwJj/RQzicNd/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DUdghxzh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUdghxzh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741151531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eKER1pFGFjikEAnNCNXBpJMTxeI/ofA+XLS16uxxVuw=;
	b=DUdghxzhe3zPYzPU7b4woAHLtt+3Z07/XvKTOwjyitmwLUwWoIqeUc82OeIvazFMZQ/cLF
	jo7bBz2+qteIblU6JRBrH0wMfWCRx4C67Sax+Zv6ZZxDcKxZick4mm7OzEjK1I0Ar99w/e
	xEnTgaIElg0rCUHOiNIRfbvnnse8W1Y=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-6OD1ip3uN1ySIaAtkwQMtw-1; Wed, 05 Mar 2025 00:12:10 -0500
X-MC-Unique: 6OD1ip3uN1ySIaAtkwQMtw-1
X-Mimecast-MFC-AGG-ID: 6OD1ip3uN1ySIaAtkwQMtw_1741151529
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fe9527c041so12582081a91.0
        for <virtualization@lists.linux.dev>; Tue, 04 Mar 2025 21:12:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741151529; x=1741756329;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKER1pFGFjikEAnNCNXBpJMTxeI/ofA+XLS16uxxVuw=;
        b=sJKY7+L+hR6+CpKd3hnb8whBOTAK/YEDiCdGGCJdoY9v4nFn10rBl1535bjfrJKjwn
         x24mkxuXSgUuLtCahwJFaGmZijH7C2wGEl6iLE27YqQeq/8Er7X3u5iBBlD40MWCc1y3
         CJz4FFoazaO06uYw2rL44Yw1sJK67Prsceb5TqZz1EE6IgXptVLQtIvDO4CRsiWZ4WJt
         +0jQPHvNPJvWzziYFaeooJlDY1l52NJloBbMwKuLc+Vxzbw0IGRd+8MkekNoEGEOpLP1
         amrppyPPSHiZXOrY+ypKkhyk/jMRk1P9dWBgTawyOkU981mjqAbkaMRtxHf5B2oyiYIO
         FmdA==
X-Forwarded-Encrypted: i=1; AJvYcCWn7yNCQbwzC2/u3bj2EJQrXf70IcRrdngeiq2U8enyt9AUL+4ywFKkE5FPpMLVTUAf2K9zod7vJRlYMzlsng==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJR4jUr1lhKKFYykqiplJ9Rr5R5MwyT4EmlJwMwpsO+/czCKKC
	I2vNzQXAu2dbGlPUwGJXrMPWDeb2veipFeSSGrYQ6JezV1ZfW68ynezUPTyMnsVOu8qj8r9/OZL
	iPKuy7lvPT4OJodjitor4a7ioJiBxhZzbqD1I0lWA12LILmx3RbuaRAQUNkjYD5NplPVMJsUpj/
	LRqR6V6rWg0Svz8iguuEueJjfoubNiUCHv3QRAt34=
X-Gm-Gg: ASbGncuLMM/qA2NNISwypXUaKdLQYhJLC4atB0cJR81Dy+P0PcpVje3c53siRb4wRtj
	ipUXtyCkmSSazSuzr0+TAs+dXoVR+0ngwvE0tpFvNmoXP8Fl0JMmWNz6hTIMBxOqGtTOP1tw5/Q
	==
X-Received: by 2002:a17:90b:4a42:b0:2fe:b5d1:dbf4 with SMTP id 98e67ed59e1d1-2ff497c37e0mr3665281a91.33.1741151529250;
        Tue, 04 Mar 2025 21:12:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwoTZpCDXZkQN3+w+8fH27hU4eingYXDiIkwh+yrUc9B+d0J180VQppV6nfoxu0TePQBVI+utB2XeDswtDOWc=
X-Received: by 2002:a17:90b:4a42:b0:2fe:b5d1:dbf4 with SMTP id
 98e67ed59e1d1-2ff497c37e0mr3665239a91.33.1741151528845; Tue, 04 Mar 2025
 21:12:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250227185017.206785-1-jdamato@fastly.com> <20250227185017.206785-4-jdamato@fastly.com>
 <20250228182759.74de5bec@kernel.org> <Z8Xc0muOV8jtHBkX@LQ3V64L9R2>
 <Z8XgGrToAD7Bak-I@LQ3V64L9R2> <Z8X15hxz8t-vXpPU@LQ3V64L9R2>
 <20250303160355.5f8d82d8@kernel.org> <Z8cXh43GJq2lolxE@LQ3V64L9R2>
In-Reply-To: <Z8cXh43GJq2lolxE@LQ3V64L9R2>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 5 Mar 2025 13:11:55 +0800
X-Gm-Features: AQ5f1JoNaFI6XmMuO_pCqrh6RtY2sOjnpKaruYcRus0Q59xqFrHV28gVCLfLvsc
Message-ID: <CACGkMEug5+zjTjEiaUtvU6XtTe+tc7MEBaQSFbXG5YP_7tcPiQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 3/4] virtio-net: Map NAPIs to queues
To: Joe Damato <jdamato@fastly.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	mkarsten@uwaterloo.ca, gerhard@engleder-embedded.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, mst@redhat.com, leiyang@redhat.com, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BzIRWEDnBe5LvkkHXi3MgJebiL7xsDXeyj_G2-4fELk_1741151529
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 11:09=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> On Mon, Mar 03, 2025 at 04:03:55PM -0800, Jakub Kicinski wrote:
> > On Mon, 3 Mar 2025 13:33:10 -0500 Joe Damato wrote:
> > > > > @@ -2880,6 +2880,13 @@ static void refill_work(struct work_struct=
 *work)
> > > > >         bool still_empty;
> > > > >         int i;
> > > > >
> > > > > +       spin_lock(&vi->refill_lock);
> > > > > +       if (!vi->refill_enabled) {
> > > > > +               spin_unlock(&vi->refill_lock);
> > > > > +               return;
> > > > > +       }
> > > > > +       spin_unlock(&vi->refill_lock);
> > > > > +
> > > > >         for (i =3D 0; i < vi->curr_queue_pairs; i++) {
> > > > >                 struct receive_queue *rq =3D &vi->rq[i];
> > > > >
> > > >
> > > > Err, I suppose this also doesn't work because:
> > > >
> > > > CPU0                       CPU1
> > > > rtnl_lock                  (before CPU0 calls disable_delayed_refil=
l)
> > > >   virtnet_close            refill_work
> > > >                              rtnl_lock()
> > > >   cancel_sync <=3D deadlock
> > > >
> > > > Need to give this a bit more thought.
> > >
> > > How about we don't use the API at all from refill_work?
> > >
> > > Patch 4 adds consistent NAPI config state and refill_work isn't a
> > > queue resize maybe we don't need to call the netif_queue_set_napi at
> > > all since the NAPI IDs are persisted in the NAPI config state and
> > > refill_work shouldn't change that?
> > >
> > > In which case, we could go back to what refill_work was doing
> > > before and avoid the problem entirely.
> > >
> > > What do you think ?
> >
> > Should work, I think. Tho, I suspect someone will want to add queue API
> > support to virtio sooner or later, and they will run into the same
> > problem with the netdev instance lock, as all of ndo_close() will then
> > be covered with netdev->lock.
> >
> > More thorough and idiomatic way to solve the problem would be to cancel
> > the work non-sync in ndo_close, add cancel with _sync after netdev is
> > unregistered (in virtnet_remove()) when the lock is no longer held, the=
n
> > wrap the entire work with a relevant lock and check if netif_running()
> > to return early in case of a race.
>
> Thanks for the guidance. I am happy to make an attempt at
> implementing this in a future, separate series that follows this
> one (probably after netdev conf in a few weeks :).
>
> > Middle ground would be to do what you suggested above and just leave
> > a well worded comment somewhere that will show up in diffs adding queue
> > API support?
>
> Jason, Michael, et. al.:  what do you think ? I don't want to spin
> up a v6 if you are opposed to proceeding this way. Please let me
> know.
>

Maybe, but need to make sure there's no use-after-free (etc.
virtnet_close() has several callers).

Thanks

