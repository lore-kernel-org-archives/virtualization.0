Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E52D2BE621
	for <virtualization@lists.linux.dev>; Tue,  3 Feb 2026 04:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770091525; cv=none; b=Z/BfizBbHHLf/HEZMxsKYQK0PQde87qqUFuWX2ctCTK0ztup8PruF91XVzGRjwGcWeUE/KIWX0U9XjtkNgn9c9H9qJ5X/ToUqeEj1j2QEbhDgRf4+HDnAhZq/N/xbJtJWVDQhOqd1oUrXxeshjYOBS2vJd0QmzHUYclV3nddTz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770091525; c=relaxed/simple;
	bh=7kM53nQmY4NYFCiULIbvgbNlzcMAkRj4iEbNoi0zXYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HDp6kj3DGXQQOqXetGoR0Am/L8B5Y/GduKRD/awK8JQ59D74r8Iu207aLJ2hOCDb184gDUbGD2whLNGgbKZ3/jYPUolKzEQ+NA1yyHBI428+mcL5rzp64ZJIF2RCmNwe16cGjylSnFduEJYcGTBG6YyuPAbC0h11VrQPKSoeAP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O7Fer+Wf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7Fer+Wf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770091523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMHrWmMfsKk1PgjkcEy0TIZr4o+xIg9B4FGbnvfETlM=;
	b=O7Fer+Wfhlv4v4DSOb10tVl4LajKvyKOt7BHyIOmEMFrRZ9hOUKSeFKQTrKv0Nu2Uzt3Au
	wBoKyW5OnPJjfSm61/cJ76tBbWw03vTPLxmnZhMOWFk+/NxJQdcYj2MGYA1HEerFgeoEZf
	Q00kU/GhKmM+HZmFdakmU/ntf849eYA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-bb4BHsw7Nv65SK9a6DKYlg-1; Mon, 02 Feb 2026 23:05:20 -0500
X-MC-Unique: bb4BHsw7Nv65SK9a6DKYlg-1
X-Mimecast-MFC-AGG-ID: bb4BHsw7Nv65SK9a6DKYlg_1770091519
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-352e195f662so4429649a91.2
        for <virtualization@lists.linux.dev>; Mon, 02 Feb 2026 20:05:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770091519; x=1770696319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TMHrWmMfsKk1PgjkcEy0TIZr4o+xIg9B4FGbnvfETlM=;
        b=MDfysGjm7z+4gYWcvkUj9CAbNbm36tC6OINgwtPNwH3lbH+/OBC1leLuQHSPpZK+Om
         mArAnRbmyLiSmREZWkEGbi9njiXGVX0L+IRoMlP2feqE3ckWNCkVdoxeSVHCSNKUrjzD
         HzKcvZCrAISAhZ++BklRq8PTqzxg6jqoRO4ZVmsMHzSO+tWfwffIHMVk2ASL7cjSPIOt
         xR0biSia8Ks/Hsv0JYH1Urp6juPT1nqbC/dv2HTfbWUnWmLmmbj/PjF2jvL15gSk8AGb
         OB0eWS5WUp6mtUDckYwvN1EnYPDfu8hIyZ+XixbgG/jMBLtgzaUTr0By8azgIDL2hpy3
         JuKQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9KFoceVbK8J70xOIJPU/ml6DQNLl0JnliASO8dQoouJbLqZPOkXFLcwKB1EjIXjb0aIbKLvWbBg4KAU5XMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCuN9m67QplCMjaK/JCHm8im2qDFkCU82anQl5q9R1V1rHRCWM
	ytQoIAF4FmzShWbqf+RjxZtb2B475M0dRKauqiKDxNjb7DoG4OzTJdsrJhG0OyqnNdWdrmRR4Ht
	i+v8Sxs8U5BHEwvLaLoc+8i1KAA9XtGeCZg6GACFpkBgMLO8k+D8G+agcawuZPI7mesyMmnCRXp
	/1G4e90/SiRvj04Gh5AW7FsgPpRmTrzMaODLHwLQi8qtw=
X-Gm-Gg: AZuq6aLjk/H0RHAQLrH0uCGhKxu9osooSgxSXuazohYRbUa35rVltzdv4474wAkNPMQ
	nPJHOXBjGi2xT00c7BGbaZnSDV3avBFjoHHfPLFQua9rSv0V+ziDKs8JxF9HRSSHcoiclaIu65W
	RNvxS+9B/0U6UMsfy5RlADwm8ocFmv6jCTk57BARbmUx25M+IhEoAt6d5e+FmBWY7FGOQ=
X-Received: by 2002:a17:90a:d604:b0:340:d511:e164 with SMTP id 98e67ed59e1d1-3543b3ad3b1mr12760706a91.19.1770091518878;
        Mon, 02 Feb 2026 20:05:18 -0800 (PST)
X-Received: by 2002:a17:90a:d604:b0:340:d511:e164 with SMTP id
 98e67ed59e1d1-3543b3ad3b1mr12760681a91.19.1770091518462; Mon, 02 Feb 2026
 20:05:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260128124524.875271-1-eperezma@redhat.com> <20260128124524.875271-2-eperezma@redhat.com>
 <CACGkMEuDPgkEVzpu0c+oKvOqgaSR5=CnHMe9iZDi_PFQan0m6g@mail.gmail.com>
 <CAJaqyWf5sC38oT2ZkmfR_MkiYWjLsuyF4Z4opSmgS1nG8BZhgw@mail.gmail.com>
 <CACGkMEsr_cx-xR85wZ5c=QfegLfG5j0wHTjokEADpgn37gQRJQ@mail.gmail.com> <CAJaqyWcVdMc+xQ=oq4ipu_sGh4uMJGidC8CFYSaa+5ZcwiKZ7g@mail.gmail.com>
In-Reply-To: <CAJaqyWcVdMc+xQ=oq4ipu_sGh4uMJGidC8CFYSaa+5ZcwiKZ7g@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 3 Feb 2026 12:05:07 +0800
X-Gm-Features: AZwV_QgsKxXDwrx96aTOaHfwcVmUzosvMmXgGfZNuIfpiO4MpGzA3IFLws0f6wA
Message-ID: <CACGkMEuNZzDVccF_yiinJowrfGgWRAR_-ZvOqNmFz=cLVKN-+w@mail.gmail.com>
Subject: Re: [PATCH 1/6] vduse: ensure vq->ready access is smp safe
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TT2lGZy-FeiAu-pZrF8f2p3sV8EV0pKVD93Z5Q4S2BI_1770091519
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 3:56=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Fri, Jan 30, 2026 at 3:18=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Thu, Jan 29, 2026 at 2:21=E2=80=AFPM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Thu, Jan 29, 2026 at 2:17=E2=80=AFAM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Wed, Jan 28, 2026 at 8:45=E2=80=AFPM Eugenio P=C3=A9rez <eperezm=
a@redhat.com> wrote:
> > > > >
> > > > > The vduse_vdpa_set_vq_ready can be called in the lifetime of the =
device
> > > > > well after initial setup, and the device can read it afterwards.
> > > > >
> > > > > Ensure that reads and writes to vq->ready are SMP safe so that th=
e
> > > > > caller can trust that virtqueue kicks and calls behave as expecte=
d
> > > > > immediately after the operation returns.
> > > > >
> > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > ---
> > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 34 +++++++++++++++++++++++-=
------
> > > > >  1 file changed, 26 insertions(+), 8 deletions(-)
> > > > >
> > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vd=
pa_user/vduse_dev.c
> > > > > index 73d1d517dc6c..a4963aaf9332 100644
> > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > @@ -460,6 +460,24 @@ static __poll_t vduse_dev_poll(struct file *=
file, poll_table *wait)
> > > > >         return mask;
> > > > >  }
> > > > >
> > > > > +static bool vduse_vq_get_ready(const struct vduse_virtqueue *vq)
> > > > > +{
> > > > > +       /*
> > > > > +        * Paired with vduse_vq_set_ready smp_store, as the drive=
r may modify
> > > > > +        * it while the VDUSE instance is reading it.
> > > > > +        */
> > > > > +       return smp_load_acquire(&vq->ready);
> > > > > +}
> > > > > +
> > > > > +static void vduse_vq_set_ready(struct vduse_virtqueue *vq, bool =
ready)
> > > > > +{
> > > > > +       /*
> > > > > +        * Paired with vduse_vq_get_ready smp_load, as the driver=
 may modify
> > > > > +        * it while the VDUSE instance is reading it.
> > > > > +        */
> > > > > +       smp_store_release(&vq->ready, ready);
> > > >
> > > > Assuming this is not used in the datapath, I wonder if we can simpl=
y
> > > > use vq_lock mutex.
> > > >
> > >
> > > The function vduse_vq_set/get_ready are not in the datapath, but
> > > vduse_vq_kick and vduse_vq_signal_irqfd are.  I'm ok if you want to
> > > switch to vq_mutex if you want though, maybe it's even comparable wit=
h
> > > the cost of the ioctls or eventfd signaling.
> >
> > I'd like to use mutex for simplicity.
> >
>
> I cannot move it to a mutex, as we need to take it in the critical
> sections of the kick_lock and irq_lock spinlocks.
>
> I can move it to a spinlock, but it seems more complicated to me. We
> need to make sure we always take these kick_lock and irq_lock in the
> same order as the ready_lock, to not create deadlocks, and they always
> protect just the ready boolean. But sure, I'll send the spinlock
> version for V2.

Thinking about this, I'm not sure I understand the issue.

Maybe you can give me an example of the race.

THanks

>

