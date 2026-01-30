Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B7D244665
	for <virtualization@lists.linux.dev>; Fri, 30 Jan 2026 07:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769759805; cv=none; b=ftQw5j3vXpV0JE37VCFRWDaulzLYVjkImwAAbM5i/ibKpBXIo164dIlPYxazUHm81iGCZwogzIp6MTuC7jJ/nezPsFmun9GRCzB4HWhWrpaRoQqZVy5Be3zOYGDGuzw0kSobRLk5Uj5/Grs3w/37H33tOx/6O+4kCtTOQ6E8tTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769759805; c=relaxed/simple;
	bh=fE8RqfdeT8n2cj9Kr8G8OzS1dK7J7ieEZZVC8rS0dS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sCsITng37h3IZb0/KdYmMjDYLcREYqR3Dnd4EpzPF+RU3AaJC3IG9qsSSonF+piO7y7jBNGi+lR8B4ADvlqmP9pJp541jRzLnJuvIk0ZchVCxBaKnq6eyUgzGiZIED9vykKO5hvdIcYaLynwfTkD5KoqiO3MrQmd0k+bReQeEoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RAG15B05; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RAG15B05"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769759803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EWSsnngUAxQZNYuSUD32175ZT9aMPq2aue7wOMEswgs=;
	b=RAG15B05MtWn/WtLXsQxK9NmYrGJoZSmmHt43mBvJqFI+DLeyQWIxlOyLjpjRVEUXwtzwR
	8/ojnVAKxBrssttXyZckVi6DvtV1g06EohQOxyFsnGwRsRy8xixCAX5AgUa5FpcRk4QO35
	0e97uOP+BiGBxGLJFI3QweRT1Erck3o=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-34FrAVoeO3udVLOhJQeEfw-1; Fri, 30 Jan 2026 02:56:41 -0500
X-MC-Unique: 34FrAVoeO3udVLOhJQeEfw-1
X-Mimecast-MFC-AGG-ID: 34FrAVoeO3udVLOhJQeEfw_1769759801
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-78fc63a4637so28042397b3.3
        for <virtualization@lists.linux.dev>; Thu, 29 Jan 2026 23:56:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769759801; x=1770364601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EWSsnngUAxQZNYuSUD32175ZT9aMPq2aue7wOMEswgs=;
        b=fOy3f3jJijqohln6yx/jr1/U9CTsY++uz0G+hyNNZU9+vCiqS9laQy91FQO2HRDbMI
         o4la+Up8eVX5ii18iKNP2YPQWs58HWSdHhhY8bQD/OGb8BzSSUKnIzg3iT0skMWZM/P4
         8HBWgNV9A69hvzqWrtJjv0IWL/O+Xp/pIGbjExVdTpFKBlFomh+jlMnemphuXakG+2SX
         IC1HeduYhx3cFNVUc+fh9o/+hJLTawH1KV51Sh/FkFknfOtQs5n826+LB7jQYAFwpBM2
         ekprzVy/OCESG2cAU7f5lBcXyd7k5J6zafJjGByrLM2j8ecTq9sqteOmGrANs8PHW0Fd
         /JXg==
X-Forwarded-Encrypted: i=1; AJvYcCWGJ4mSnQ7jiT3ldA4Nn8tq5Rj6doIG84UOqRss8Kz5pmFDDsM48mWeHJv8zDIPwXGsLxQAqQOoiomymqjTwQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyqeBDvT6UIEA1YgVSoYWMaN8h0WGu+fsPbRAussSo1I3oUnUWv
	cUaIcHbpb4QhLp6XJLt+tX/z0SjAjrvT5gy9+B/B4a3D2Uk4WMfxOTiasxblORo2vFAlR2sPx9g
	ap1hIIenKxga3Q/BdI0LnZNL8BNMGurCqg1Ts63pr2+DlnvclZO2wvy5vnXsWNTAha1ASim0C31
	nIOS5v956yyN0JeSgJovLNZpQKKisD1LpLxC+36P5k264=
X-Gm-Gg: AZuq6aL/lbZ8QXffr3Fq9OrD21EM0zjZErBCZaV0iSrnBMTuTeImKLedn3xiiR9PPaL
	/iXUts8J3Hz4V4aJZ9tEcC8T028aQvi5Ow+T4060wEt6tX+5hFsY68nOCW5Jgt195F6BnMCYc8h
	NkMYu1F2RLQceBVFXhkufcDh5y1u+gHx0eyO7d38tec2HUarKLefeFTZct9iiak/tAEA==
X-Received: by 2002:a05:690c:22c6:b0:78c:69ce:c430 with SMTP id 00721157ae682-7949deb6985mr20920107b3.21.1769759800950;
        Thu, 29 Jan 2026 23:56:40 -0800 (PST)
X-Received: by 2002:a05:690c:22c6:b0:78c:69ce:c430 with SMTP id
 00721157ae682-7949deb6985mr20919957b3.21.1769759800561; Thu, 29 Jan 2026
 23:56:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260128124524.875271-1-eperezma@redhat.com> <20260128124524.875271-2-eperezma@redhat.com>
 <CACGkMEuDPgkEVzpu0c+oKvOqgaSR5=CnHMe9iZDi_PFQan0m6g@mail.gmail.com>
 <CAJaqyWf5sC38oT2ZkmfR_MkiYWjLsuyF4Z4opSmgS1nG8BZhgw@mail.gmail.com> <CACGkMEsr_cx-xR85wZ5c=QfegLfG5j0wHTjokEADpgn37gQRJQ@mail.gmail.com>
In-Reply-To: <CACGkMEsr_cx-xR85wZ5c=QfegLfG5j0wHTjokEADpgn37gQRJQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 30 Jan 2026 08:56:04 +0100
X-Gm-Features: AZwV_Qhc9FWSqH7mbHoItRc6it2kMfiJuDaFTdnjeJmh1fMOvkyj0L62SYFnfv0
Message-ID: <CAJaqyWcVdMc+xQ=oq4ipu_sGh4uMJGidC8CFYSaa+5ZcwiKZ7g@mail.gmail.com>
Subject: Re: [PATCH 1/6] vduse: ensure vq->ready access is smp safe
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RAFhihZPubwkdfMkEDPzaBAQ735T_phbCNmf59BoEe0_1769759801
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 3:18=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Jan 29, 2026 at 2:21=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Thu, Jan 29, 2026 at 2:17=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Wed, Jan 28, 2026 at 8:45=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@=
redhat.com> wrote:
> > > >
> > > > The vduse_vdpa_set_vq_ready can be called in the lifetime of the de=
vice
> > > > well after initial setup, and the device can read it afterwards.
> > > >
> > > > Ensure that reads and writes to vq->ready are SMP safe so that the
> > > > caller can trust that virtqueue kicks and calls behave as expected
> > > > immediately after the operation returns.
> > > >
> > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > ---
> > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 34 +++++++++++++++++++++++---=
----
> > > >  1 file changed, 26 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa=
_user/vduse_dev.c
> > > > index 73d1d517dc6c..a4963aaf9332 100644
> > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > @@ -460,6 +460,24 @@ static __poll_t vduse_dev_poll(struct file *fi=
le, poll_table *wait)
> > > >         return mask;
> > > >  }
> > > >
> > > > +static bool vduse_vq_get_ready(const struct vduse_virtqueue *vq)
> > > > +{
> > > > +       /*
> > > > +        * Paired with vduse_vq_set_ready smp_store, as the driver =
may modify
> > > > +        * it while the VDUSE instance is reading it.
> > > > +        */
> > > > +       return smp_load_acquire(&vq->ready);
> > > > +}
> > > > +
> > > > +static void vduse_vq_set_ready(struct vduse_virtqueue *vq, bool re=
ady)
> > > > +{
> > > > +       /*
> > > > +        * Paired with vduse_vq_get_ready smp_load, as the driver m=
ay modify
> > > > +        * it while the VDUSE instance is reading it.
> > > > +        */
> > > > +       smp_store_release(&vq->ready, ready);
> > >
> > > Assuming this is not used in the datapath, I wonder if we can simply
> > > use vq_lock mutex.
> > >
> >
> > The function vduse_vq_set/get_ready are not in the datapath, but
> > vduse_vq_kick and vduse_vq_signal_irqfd are.  I'm ok if you want to
> > switch to vq_mutex if you want though, maybe it's even comparable with
> > the cost of the ioctls or eventfd signaling.
>
> I'd like to use mutex for simplicity.
>

I cannot move it to a mutex, as we need to take it in the critical
sections of the kick_lock and irq_lock spinlocks.

I can move it to a spinlock, but it seems more complicated to me. We
need to make sure we always take these kick_lock and irq_lock in the
same order as the ready_lock, to not create deadlocks, and they always
protect just the ready boolean. But sure, I'll send the spinlock
version for V2.

