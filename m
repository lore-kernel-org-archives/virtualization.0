Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDA42DB783
	for <virtualization@lists.linux.dev>; Tue,  3 Feb 2026 10:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770114943; cv=none; b=USfySAqqFK9d24b6y9Uefcb1uVLAEropqTz42lhXFGyCPpIXaoBLTA0H5YgiI+K0ajBZM3UeOyLl2g9tRybBN/J2An92L+pe0FxgPqBeNTjCqtJWZl60RDD7wAyePkAMUuCLuwMfk2zWck8RmjCmKqFpiOLq+FM11J5hXNhkelw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770114943; c=relaxed/simple;
	bh=nI1HcJP7gMO08+++hMShU+M5QpgIMH/WDWRUhgc9uRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M68/A+YMOaMuAGRNRqDj+F+WZ/L1sjXJY1SVPmBmv5VuiP28CoX0iMfAZJfnfqwNCV8xyH22bs2n7gOyunvAXn7EB9mDotT/QI02vcmDHh27Sp2shznHRZefA9uvI8YhSxFtLs9YYkWik/QCgX4MGVSV0SDlOMAM7MNKPlnwQfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hff4WWwP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hff4WWwP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770114940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D7Uy/io/DTucHPQrrClIQq+8Z7bSLhtESQLZZO7tH/I=;
	b=hff4WWwP3XSZVaE0vGbztKX95CoVQtnThAZECezNE3U0ZQa17fnYgPM2sV/V4aXoyqVIId
	GOA/znShr2r64iDNdaecxJt1+QyS0t5v8Jl6yvXAMlybWNdZ8yU2PfeOZNyQ1uEoMlRp64
	sn5YELuYBRk2mgAyfA1DV/oLrIaI8rE=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-lTQj7001PauffD_sI7hE_w-1; Tue, 03 Feb 2026 05:35:39 -0500
X-MC-Unique: lTQj7001PauffD_sI7hE_w-1
X-Mimecast-MFC-AGG-ID: lTQj7001PauffD_sI7hE_w_1770114938
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-794f00a879eso8122977b3.0
        for <virtualization@lists.linux.dev>; Tue, 03 Feb 2026 02:35:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770114938; x=1770719738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D7Uy/io/DTucHPQrrClIQq+8Z7bSLhtESQLZZO7tH/I=;
        b=GqCAxuZw0T47erQNw26agzQHQNKWMxWcuhFsEYqknC5qHP9nO2fuUmj1hmrkqYZ8jQ
         Y8cEnRCDjAlPg1hJTG6kzSijaCEWsy0o1HwAKpmod4C+wErRO8aBKFIdzNztM5K2MHQe
         oes6FwInCZyG9HuNmgmp2s8chDa6oV5EhukPpvFhvXTur0Om8w2tt3egEHDOBB06SJHY
         PNce3jCb3TvzYuM/sWkCWwbuIEEX7ByJ2dihWrKEClddarfzs7PzaMfWSfBKs8YuEh3k
         tiGKanaO0rmJzMnQbg2DRwbr3w8apLaybGQENn03QLzdPW0TFr/czDc9IvpR1sd5QWgv
         RAIg==
X-Forwarded-Encrypted: i=1; AJvYcCVAOXHsaCnwQF0/6kMi/zuGdEYwFD7kIXhxTHrE/sq85+W5xu6pDCg4QszgklecczzHdFENKmShQ4aEf0SdBg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyX2lBCIrJLL8grNsFro8BjAJjWheU+fNwzafaGjQS58yUOkiMy
	z/5UpYav0Wnuovt/p3+5W87Ue4Ki1hTaJMXyI/X2IsJ5T+plGmOihem/tPuiKnRoZ+AiBQPX3tc
	sx96MShgvxUvb97Ld9dnh8z8zLJU5MjN9bM711lIBYrumwPnsn9pFG+DHO+NMLGwrBlIOb1TjYt
	vG7N8LlmtDTmxhS/e25S5rjniPBkA1kHx6WAhJVqdqRqE=
X-Gm-Gg: AZuq6aJWppj/d+vr41mK9sT9Zieb+kjhuyzanqS1fx4O7m0rF9XZZcJyGcOJLGZ2vdG
	zaikGRJapDL0m716pECpkxf0wVwiCW4HA7Focelj1qzq7Oq15sxXVGczDOTC3x/6qat/O3phqSH
	MgQ67gVJ7zKqYnvIiCFtV3c5BdnpJ839+vi/bQR1wHis3vWponj/kqe3x9kL+VfyTJww==
X-Received: by 2002:a05:690c:30b:b0:78d:6657:fd01 with SMTP id 00721157ae682-7949de6db2dmr132886537b3.12.1770114938639;
        Tue, 03 Feb 2026 02:35:38 -0800 (PST)
X-Received: by 2002:a05:690c:30b:b0:78d:6657:fd01 with SMTP id
 00721157ae682-7949de6db2dmr132886327b3.12.1770114938252; Tue, 03 Feb 2026
 02:35:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260128124524.875271-1-eperezma@redhat.com> <20260128124524.875271-2-eperezma@redhat.com>
 <CACGkMEuDPgkEVzpu0c+oKvOqgaSR5=CnHMe9iZDi_PFQan0m6g@mail.gmail.com>
 <CAJaqyWf5sC38oT2ZkmfR_MkiYWjLsuyF4Z4opSmgS1nG8BZhgw@mail.gmail.com>
 <CACGkMEsr_cx-xR85wZ5c=QfegLfG5j0wHTjokEADpgn37gQRJQ@mail.gmail.com>
 <CAJaqyWcVdMc+xQ=oq4ipu_sGh4uMJGidC8CFYSaa+5ZcwiKZ7g@mail.gmail.com> <CACGkMEuNZzDVccF_yiinJowrfGgWRAR_-ZvOqNmFz=cLVKN-+w@mail.gmail.com>
In-Reply-To: <CACGkMEuNZzDVccF_yiinJowrfGgWRAR_-ZvOqNmFz=cLVKN-+w@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 3 Feb 2026 11:35:01 +0100
X-Gm-Features: AZwV_Qi2OhqdIqST7lX4q9BPGuvmFCxUSd6uR6xWowi7K-WM0nHukVzaTICj9nk
Message-ID: <CAJaqyWfpJxPYKtUcncpbEvn_wi-Rc3VRyLE5f=0Md9HAksr6Dg@mail.gmail.com>
Subject: Re: [PATCH 1/6] vduse: ensure vq->ready access is smp safe
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rO2BsNS5ABi9WyKikRvesNQHLLYeOQpDiJx32jBgGt4_1770114938
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 5:05=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Fri, Jan 30, 2026 at 3:56=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Fri, Jan 30, 2026 at 3:18=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Thu, Jan 29, 2026 at 2:21=E2=80=AFPM Eugenio Perez Martin
> > > <eperezma@redhat.com> wrote:
> > > >
> > > > On Thu, Jan 29, 2026 at 2:17=E2=80=AFAM Jason Wang <jasowang@redhat=
.com> wrote:
> > > > >
> > > > > On Wed, Jan 28, 2026 at 8:45=E2=80=AFPM Eugenio P=C3=A9rez <epere=
zma@redhat.com> wrote:
> > > > > >
> > > > > > The vduse_vdpa_set_vq_ready can be called in the lifetime of th=
e device
> > > > > > well after initial setup, and the device can read it afterwards=
.
> > > > > >
> > > > > > Ensure that reads and writes to vq->ready are SMP safe so that =
the
> > > > > > caller can trust that virtqueue kicks and calls behave as expec=
ted
> > > > > > immediately after the operation returns.
> > > > > >
> > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > ---
> > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 34 ++++++++++++++++++++++=
+-------
> > > > > >  1 file changed, 26 insertions(+), 8 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/=
vdpa_user/vduse_dev.c
> > > > > > index 73d1d517dc6c..a4963aaf9332 100644
> > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > @@ -460,6 +460,24 @@ static __poll_t vduse_dev_poll(struct file=
 *file, poll_table *wait)
> > > > > >         return mask;
> > > > > >  }
> > > > > >
> > > > > > +static bool vduse_vq_get_ready(const struct vduse_virtqueue *v=
q)
> > > > > > +{
> > > > > > +       /*
> > > > > > +        * Paired with vduse_vq_set_ready smp_store, as the dri=
ver may modify
> > > > > > +        * it while the VDUSE instance is reading it.
> > > > > > +        */
> > > > > > +       return smp_load_acquire(&vq->ready);
> > > > > > +}
> > > > > > +
> > > > > > +static void vduse_vq_set_ready(struct vduse_virtqueue *vq, boo=
l ready)
> > > > > > +{
> > > > > > +       /*
> > > > > > +        * Paired with vduse_vq_get_ready smp_load, as the driv=
er may modify
> > > > > > +        * it while the VDUSE instance is reading it.
> > > > > > +        */
> > > > > > +       smp_store_release(&vq->ready, ready);
> > > > >
> > > > > Assuming this is not used in the datapath, I wonder if we can sim=
ply
> > > > > use vq_lock mutex.
> > > > >
> > > >
> > > > The function vduse_vq_set/get_ready are not in the datapath, but
> > > > vduse_vq_kick and vduse_vq_signal_irqfd are.  I'm ok if you want to
> > > > switch to vq_mutex if you want though, maybe it's even comparable w=
ith
> > > > the cost of the ioctls or eventfd signaling.
> > >
> > > I'd like to use mutex for simplicity.
> > >
> >
> > I cannot move it to a mutex, as we need to take it in the critical
> > sections of the kick_lock and irq_lock spinlocks.
> >
> > I can move it to a spinlock, but it seems more complicated to me. We
> > need to make sure we always take these kick_lock and irq_lock in the
> > same order as the ready_lock, to not create deadlocks, and they always
> > protect just the ready boolean. But sure, I'll send the spinlock
> > version for V2.
>
> Thinking about this, I'm not sure I understand the issue.
>
> Maybe you can give me an example of the race.
>

It's the same issue as you describe with set_group_asid on cpu1 and
dma_map and dma_unmap in cpu1 in this mail [0], but now the functions
are set_vq_ready in the vdpa driver side and VDUSE_VQ_GET_INFO in the
VDUSE instance.

To me, the barriers should be in the driver and the VDUSE instance,
and the VDUSE instance should use the VDUSE_SET_VQ_READY message to
know when a VQ is ready. But I don't expect all the VDUSE instances to
opt-in for that, so the flow without smp barriers is:

[cpu0] .set_vq_ready(vq, true)
[cpu1] VDUSE_VQ_GET_INFO(vq)
[cpu1] check vq->ready, and it races with the set_vq_ready from cpu0.

[0] https://patchew.org/linux/20251113115558.1277981-1-eperezma@redhat.com/=
20251113115558.1277981-6-eperezma@redhat.com/#CACGkMEtMyte91bbdb0hfUo+YgSpZ=
djoWe0meKwbDc18CfWdATA@mail.gmail.com

