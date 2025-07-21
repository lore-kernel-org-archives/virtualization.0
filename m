Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B41218DB2A
	for <virtualization@lists.linux.dev>; Mon, 21 Jul 2025 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753109589; cv=none; b=BxHQpgbLSnjd3sM0VyTezOfDmMyAOfEC8Rin7YChyLyPsEG7TavM3/zF3/KqVa71PSAMWsBx7IyJQEY5ILNjf4qCHsSQxLccafHgOdd37LyDOfItWAa3cGd9+uaKtFY+r9vVos9iq3aHCeLM3DqnX4YjQfSbmyIwAfk6xoWHfzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753109589; c=relaxed/simple;
	bh=tcfwFJ4EktzzgXpSdU1DvdV/q0S1GXlOhJS5PeJEXl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLZ8nvcO1lWAwXNehOZzHSbaMi7cl3jrJtncJtrleS0D6kSVJVC9sFnxDO3mc8Z9UPDtVqkmTfrorf7cSxnudJFyZRaK+IQ66+4YHh8UaEoscuke44FTkCo3mX8eKRD0MXmSsG4cJ0PeRcOOwQv+f/iBNR0vSS4be+mrTxBExXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hoWwoByC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hoWwoByC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753109586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hKl0qlxBFtF+elpbFDCnFWXhN5Owf8cmvWXhHgmzstM=;
	b=hoWwoByCdaSrmTAzyGrdRtjc20LDyTM9GpAVLyNeM9V03nPDx1iuxGEM/cp3kYGHEQ1etD
	7FR8wSapPuoD9n2S12FUtgH6afOS+5XeU5mJQKnZ5efio4i6EWygaunRI4OoGGZw+R57CF
	/qi08/w7WXndJxb/EWdjOm0qC8+aSLo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-4VdwhKKnPqyariok28ewBw-1; Mon, 21 Jul 2025 10:53:04 -0400
X-MC-Unique: 4VdwhKKnPqyariok28ewBw-1
X-Mimecast-MFC-AGG-ID: 4VdwhKKnPqyariok28ewBw_1753109584
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ae6c9aa2c93so393179366b.1
        for <virtualization@lists.linux.dev>; Mon, 21 Jul 2025 07:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753109584; x=1753714384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hKl0qlxBFtF+elpbFDCnFWXhN5Owf8cmvWXhHgmzstM=;
        b=dr8jF+5Wi53255FDskcHUyQEub7P2SrC3zHfNspAMNXKS9wQunywHZKuM2rcW1ZGAR
         5B9EEHXo7J/fh7/FmQnr2GCrAR+VL1FxlldEgAjDYyTbSfurL6o2SKGgT9f3Og8za3uf
         tto6bOJISes8DPXgqAUOmFgg6tvj5UXDWaQhbzxiMAvzX5pAABuwWN4JNBzd4ANQUg7d
         A1WcP+5PbodjUMqTYubUf6OxsO+U9IrbJ3l626biJJbX9N0fTFP+1eINcJ7occik6Frh
         4egjVng0JABw9z27TSazkjkfFIqS/i1lfZfAtw4+A/pvk5BO7PifH5Hx4nFKuiowtiHv
         ptEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4WJBBU4F1JJBBmGyGNIb7c5SKx7cBdEkAOh1UTwrTiwk0C0IqpRUBmi739JO4u81jrqUZkOnN/uAmTrS5QQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxf08SrJc1naU5bmNHX7TOn2dOWk0sIJH7m0i9bJuPxzNldHGV1
	ctYoeixDqQQYw9utS5gzTe0Wg0jJWV/1gseSP0O2Vd3Wti3tNH65tx7FEVm4TNbiFmHJYw38anJ
	dOL4xBTLTNR9b+IKK4l4Z3l8k1m72RimAb2aoXxM7ReDFTSudak8thiOFeb/6aW0aGUT4DxVHG/
	wSZSQwbpQu+bHY4TV6u376u5UnDeAg4RgcJdQjXTgCMbw=
X-Gm-Gg: ASbGnctTHom/CRfHJGVZ6+nRRvXe/IgircOEQN9daItpCdcLzvwugjv6sKKJdC/58B2
	lVh0XsDAu663pEUS6XxajQG/FrFBf2f8Gdr09MZxDoHAjJep+e9/Lkf8aYFY+c/qk4gIgZpkMut
	vIFrJtKsYwch1mmSu2Yw7u
X-Received: by 2002:a17:907:1b83:b0:ae7:1c2b:b715 with SMTP id a640c23a62f3a-ae9ce1116efmr1421067066b.49.1753109583665;
        Mon, 21 Jul 2025 07:53:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOOJUafiFo7E/wyrY3scKMXKkSfYzzMl3NxuY0FmLUADkytL9Dvho2Sh2vvfmv9jTzKOz9fVCpgCvesbMjmzI=
X-Received: by 2002:a17:907:1b83:b0:ae7:1c2b:b715 with SMTP id
 a640c23a62f3a-ae9ce1116efmr1421065066b.49.1753109583268; Mon, 21 Jul 2025
 07:53:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250718110355.1550454-1-kniv@yandex-team.ru> <20250718230356.2459-1-hdanton@sina.com>
 <20250720121256-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250720121256-mutt-send-email-mst@kernel.org>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 21 Jul 2025 22:52:25 +0800
X-Gm-Features: Ac12FXxplqk-i8a6XMwuR5LTrYQ5xXpv4vZNeT7esH9BtgJxmgO_jrGFoDJGq4M
Message-ID: <CAPpAL=whwmwGqoxZ3M8y+fpnOXEHum+z9-Krs6ZOBLu4o8COZw@mail.gmail.com>
Subject: Re: [PATCH v2] vhost/net: Replace wait_queue with completion in ubufs reference
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: Hillf Danton <hdanton@sina.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio Perez <eperezma@redhat.com>, 
	Andrey Ryabinin <arbn@yandex-team.com>, Andrey Smetanin <asmetanin@yandex-team.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XGzf50nEgW3BiR5bJf6ZLwEkw082y78sQWZGr-fG6ug_1753109584
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this patch's V2 with the virtio-net regression test, everything
works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Mon, Jul 21, 2025 at 12:13=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Sat, Jul 19, 2025 at 07:03:23AM +0800, Hillf Danton wrote:
> > On Fri, 18 Jul 2025 14:03:55 +0300 Nikolay Kuratov wrote:
> > > When operating on struct vhost_net_ubuf_ref, the following execution
> > > sequence is theoretically possible:
> > > CPU0 is finalizing DMA operation                   CPU1 is doing VHOS=
T_NET_SET_BACKEND
> > >                              // &ubufs->refcount =3D=3D 2
> > > vhost_net_ubuf_put()                               vhost_net_ubuf_put=
_wait_and_free(oldubufs)
> > >                                                      vhost_net_ubuf_p=
ut_and_wait()
> > >                                                        vhost_net_ubuf=
_put()
> > >                                                          int r =3D at=
omic_sub_return(1, &ubufs->refcount);
> > >                                                          // r =3D 1
> > > int r =3D atomic_sub_return(1, &ubufs->refcount);
> > > // r =3D 0
> > >                                                       wait_event(ubuf=
s->wait, !atomic_read(&ubufs->refcount));
> > >                                                       // no wait occu=
rs here because condition is already true
> > >                                                     kfree(ubufs);
> > > if (unlikely(!r))
> > >   wake_up(&ubufs->wait);  // use-after-free
> > >
> > > This leads to use-after-free on ubufs access. This happens because CP=
U1
> > > skips waiting for wake_up() when refcount is already zero.
> > >
> > > To prevent that use a completion instead of wait_queue as the ubufs
> > > notification mechanism. wait_for_completion() guarantees that there w=
ill
> > > be complete() call prior to its return.
> > >
> > Alternatively rcu helps.
> >
> > --- x/drivers/vhost/net.c
> > +++ y/drivers/vhost/net.c
> > @@ -96,6 +96,7 @@ struct vhost_net_ubuf_ref {
> >       atomic_t refcount;
> >       wait_queue_head_t wait;
> >       struct vhost_virtqueue *vq;
> > +     struct rcu_head rcu;
> >  };
> >
> >  #define VHOST_NET_BATCH 64
> > @@ -247,9 +248,13 @@ vhost_net_ubuf_alloc(struct vhost_virtqu
> >
> >  static int vhost_net_ubuf_put(struct vhost_net_ubuf_ref *ubufs)
> >  {
> > -     int r =3D atomic_sub_return(1, &ubufs->refcount);
> > +     int r;
> > +
> > +     rcu_read_lock();
> > +     r =3D atomic_sub_return(1, &ubufs->refcount);
> >       if (unlikely(!r))
> >               wake_up(&ubufs->wait);
> > +     rcu_read_unlock();
> >       return r;
> >  }
> >
> > @@ -262,7 +267,7 @@ static void vhost_net_ubuf_put_and_wait(
> >  static void vhost_net_ubuf_put_wait_and_free(struct vhost_net_ubuf_ref=
 *ubufs)
> >  {
> >       vhost_net_ubuf_put_and_wait(ubufs);
> > -     kfree(ubufs);
> > +     kfree_rcu(ubufs, rcu);
> >  }
> >
> >  static void vhost_net_clear_ubuf_info(struct vhost_net *n)
>
> I like that.
>
> --
> MST
>

