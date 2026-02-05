Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BB5155C82
	for <virtualization@lists.linux.dev>; Thu,  5 Feb 2026 04:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770264273; cv=none; b=lLVJBpPfFr+EV23ahSfe6IZ+enMhiN3/tRQVueJtohTrYe+nL28fe3mLovDuAT/u1r2DLEA7pJDcWXJdjg0s75iTpp2/EjFZVhUJi72FK5F3qmq3Zpidy7hpc5MLUgpYCJcZvBjkS5/Z+e9pcd3YVFJIz1QrsIq/W+LdTsVLYH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770264273; c=relaxed/simple;
	bh=/HWBixcwEn0P7tiUNJ0HNgTi2TUa5qdMmI2qDnxZwR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msQCa9LfuwRhyfuANhNBrHNpOo9hlvD7Zl8BVi9GOq13jc7xReqH8a8mUN0B9d5lUoYI/S2YfI3dEJHYsgBtMuRfZhEQIPH523xVA6BAFni2++8mv85BR0uKnuqGri86//AHdWvnE4sYatff0i0ZLWcM7ibf3yx7cB/Jn1lZb/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i0vadk2G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i0vadk2G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770264271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2NXxzzrK69GPp81IR6EjWMRRqAgqOsVRDvTEdweBiF4=;
	b=i0vadk2G+T0HP6PDt1MywW7TPKZ51yVBuvbNLlJGae2XvmtecRZOI7LneUlCHN3TANvfZv
	aXBCVNo1jx8TDcCpQeR1irvwwlBI/HSPdxEnCdrhVKh+q8UpFhXVHHgvVt3Av6OYargLJX
	no6C1oFXLUmlwoVgnu5m08qC1MraSO4=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-8710ZT9vNnOc47yWUHkqKQ-1; Wed, 04 Feb 2026 23:04:30 -0500
X-MC-Unique: 8710ZT9vNnOc47yWUHkqKQ-1
X-Mimecast-MFC-AGG-ID: 8710ZT9vNnOc47yWUHkqKQ_1770264270
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a8c54bbe46so11305725ad.2
        for <virtualization@lists.linux.dev>; Wed, 04 Feb 2026 20:04:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770264270; x=1770869070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2NXxzzrK69GPp81IR6EjWMRRqAgqOsVRDvTEdweBiF4=;
        b=G4V7kWapDcb7l2l+k2Far++QLYZwrzjfnRo4uJAIQnTQWxzgNOMg3/x0FtyANGAGv/
         kh2gOod4a4sTcn+ef1Ek9+GjpbagHT+lTIjvhZpJJtBvRtZLzmWj1QrXlgAx72oktelU
         HiznwV5WQoSqtbmBX3BhqBVVKwE7gRBDsAbtEL5AjbJy6U/+ZFPBk5Z+Vld1mfGF29rJ
         IoqrRlwyoFn7jdzrKTLhiZQ38kSilIhYycwBfe0zral/WQ5PWWH4RwGbNNYLoue8BD7u
         UKHva/SJyQbVZ5ki7AybG1yq1rotr4sakrF6r6z3DIK5z8g6+p59yR15W1bRohGeiwGC
         PZcg==
X-Forwarded-Encrypted: i=1; AJvYcCVh31Xvf3ZbdfiHXnrchIXjzmCZwwy2fCUZKNQpFFOcxaUnrsGkfCWWzay8ZEVmC7TKnZnam4bUdNub/F3seA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzEF8q4ms5fllszeGfxwuKSRo0nWRLx1VncaI96Cpzj4C71l03B
	seiTqm7NH4+OTiU4G7GOymMV9ezjiRzAhco15Fo/NUzsgqZmGwMo814vjuEaFzFW5c5W6o7PYmE
	XGYgYvvoX/5oH6SNntOq/I+HjWMN6TcLhUQYE5ej6+4QxhvPB/mDPwj+5igw+AycNQfzHAsULVP
	Y1ReKW7wCNIpS7/L93HYDdnkE6QnkZ9OH18hZEpvkCpPA=
X-Gm-Gg: AZuq6aLHcOyJG/T+90lkXFT8DN+tPWhtTbaBBwNFOipMErZdHmt9TFg/2/ELnLR7nH4
	jLP3NxbQpSZCMWMnn4JG42iZNPk3QebqgKrf+BRF8tr2kj3TFfORLZsTxRanCRMFsYNU9fxTlt0
	DIjV+0M0sAipzav6lAFwIkUAq4pnjf1n8O8Q8DsNZFi/48wr3RiNgTIvv3k1EZKGSTQg==
X-Received: by 2002:a05:6a21:4d07:b0:392:e583:b766 with SMTP id adf61e73a8af0-39372405418mr5214101637.42.1770264269681;
        Wed, 04 Feb 2026 20:04:29 -0800 (PST)
X-Received: by 2002:a05:6a21:4d07:b0:392:e583:b766 with SMTP id
 adf61e73a8af0-39372405418mr5214067637.42.1770264269211; Wed, 04 Feb 2026
 20:04:29 -0800 (PST)
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
 <CAJaqyWcVdMc+xQ=oq4ipu_sGh4uMJGidC8CFYSaa+5ZcwiKZ7g@mail.gmail.com>
 <CACGkMEuNZzDVccF_yiinJowrfGgWRAR_-ZvOqNmFz=cLVKN-+w@mail.gmail.com>
 <CAJaqyWfpJxPYKtUcncpbEvn_wi-Rc3VRyLE5f=0Md9HAksr6Dg@mail.gmail.com>
 <CACGkMEtBerHiU7EpjOqkJQxgCv2f3MsUURD6AF9663DELETsYQ@mail.gmail.com> <CAJaqyWcq73v_v6OoxWnwkOY5gxHV+kL+4eDDjor_rP=OzrBrvg@mail.gmail.com>
In-Reply-To: <CAJaqyWcq73v_v6OoxWnwkOY5gxHV+kL+4eDDjor_rP=OzrBrvg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Feb 2026 12:04:17 +0800
X-Gm-Features: AZwV_QguRTg_NZyLmRTK3FPvKDru6A_cpJC6oLPMonC-PSxPhz8cpfcoKiP9yYg
Message-ID: <CACGkMEv9XApkhiA8qSO27duw-7e9obWYO=fzFJ5FTh91L3Tttg@mail.gmail.com>
Subject: Re: [PATCH 1/6] vduse: ensure vq->ready access is smp safe
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: edw9aXRqGYJjvYUsr2BL5z7FDuPRIaDl0G9ruxxdBXc_1770264270
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 4:54=E2=80=AFPM Eugenio Perez Martin <eperezma@redha=
t.com> wrote:
>
> On Wed, Feb 4, 2026 at 3:48=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Tue, Feb 3, 2026 at 6:35=E2=80=AFPM Eugenio Perez Martin <eperezma@r=
edhat.com> wrote:
> > >
> > > On Tue, Feb 3, 2026 at 5:05=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > > >
> > > > On Fri, Jan 30, 2026 at 3:56=E2=80=AFPM Eugenio Perez Martin
> > > > <eperezma@redhat.com> wrote:
> > > > >
> > > > > On Fri, Jan 30, 2026 at 3:18=E2=80=AFAM Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > >
> > > > > > On Thu, Jan 29, 2026 at 2:21=E2=80=AFPM Eugenio Perez Martin
> > > > > > <eperezma@redhat.com> wrote:
> > > > > > >
> > > > > > > On Thu, Jan 29, 2026 at 2:17=E2=80=AFAM Jason Wang <jasowang@=
redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Jan 28, 2026 at 8:45=E2=80=AFPM Eugenio P=C3=A9rez =
<eperezma@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > The vduse_vdpa_set_vq_ready can be called in the lifetime=
 of the device
> > > > > > > > > well after initial setup, and the device can read it afte=
rwards.
> > > > > > > > >
> > > > > > > > > Ensure that reads and writes to vq->ready are SMP safe so=
 that the
> > > > > > > > > caller can trust that virtqueue kicks and calls behave as=
 expected
> > > > > > > > > immediately after the operation returns.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > > > > ---
> > > > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 34 ++++++++++++++++=
+++++++-------
> > > > > > > > >  1 file changed, 26 insertions(+), 8 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers=
/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > index 73d1d517dc6c..a4963aaf9332 100644
> > > > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > @@ -460,6 +460,24 @@ static __poll_t vduse_dev_poll(struc=
t file *file, poll_table *wait)
> > > > > > > > >         return mask;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +static bool vduse_vq_get_ready(const struct vduse_virtqu=
eue *vq)
> > > > > > > > > +{
> > > > > > > > > +       /*
> > > > > > > > > +        * Paired with vduse_vq_set_ready smp_store, as t=
he driver may modify
> > > > > > > > > +        * it while the VDUSE instance is reading it.
> > > > > > > > > +        */
> > > > > > > > > +       return smp_load_acquire(&vq->ready);
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static void vduse_vq_set_ready(struct vduse_virtqueue *v=
q, bool ready)
> > > > > > > > > +{
> > > > > > > > > +       /*
> > > > > > > > > +        * Paired with vduse_vq_get_ready smp_load, as th=
e driver may modify
> > > > > > > > > +        * it while the VDUSE instance is reading it.
> > > > > > > > > +        */
> > > > > > > > > +       smp_store_release(&vq->ready, ready);
> > > > > > > >
> > > > > > > > Assuming this is not used in the datapath, I wonder if we c=
an simply
> > > > > > > > use vq_lock mutex.
> > > > > > > >
> > > > > > >
> > > > > > > The function vduse_vq_set/get_ready are not in the datapath, =
but
> > > > > > > vduse_vq_kick and vduse_vq_signal_irqfd are.  I'm ok if you w=
ant to
> > > > > > > switch to vq_mutex if you want though, maybe it's even compar=
able with
> > > > > > > the cost of the ioctls or eventfd signaling.
> > > > > >
> > > > > > I'd like to use mutex for simplicity.
> > > > > >
> > > > >
> > > > > I cannot move it to a mutex, as we need to take it in the critica=
l
> > > > > sections of the kick_lock and irq_lock spinlocks.
> > > > >
> > > > > I can move it to a spinlock, but it seems more complicated to me.=
 We
> > > > > need to make sure we always take these kick_lock and irq_lock in =
the
> > > > > same order as the ready_lock, to not create deadlocks, and they a=
lways
> > > > > protect just the ready boolean. But sure, I'll send the spinlock
> > > > > version for V2.
> > > >
> > > > Thinking about this, I'm not sure I understand the issue.
> > > >
> > > > Maybe you can give me an example of the race.
> > > >
> > >
> > > It's the same issue as you describe with set_group_asid on cpu1 and
> > > dma_map and dma_unmap in cpu1 in this mail [0], but now the functions
> > > are set_vq_ready in the vdpa driver side and VDUSE_VQ_GET_INFO in the
> > > VDUSE instance.
> > >
> > > To me, the barriers should be in the driver and the VDUSE instance,
> > > and the VDUSE instance should use the VDUSE_SET_VQ_READY message to
> > > know when a VQ is ready. But I don't expect all the VDUSE instances t=
o
> > > opt-in for that, so the flow without smp barriers is:
> > >
> > > [cpu0] .set_vq_ready(vq, true)
> > > [cpu1] VDUSE_VQ_GET_INFO(vq)
> > > [cpu1] check vq->ready, and it races with the set_vq_ready from cpu0.
> > >
> >
> > Are there any side effects of this race? I meant the driver can do
> > set_vq_ready() at any time. And there would be message for notifying
> > the usersapce in this series.
> >
>
> Actually I'm moving to a semaphore for the moment. SMP barrier is not eno=
ugh.
>
> The message works for the driver to know that the device vq is ready
> and it can send kicks. But there is a race for the device where it has
> replied to the message but vq->ready is still not true:
>
> static void vduse_vdpa_set_vq_ready(struct vdpa_device *vdpa,
>                                         u16 idx, bool ready)
> {
>         [...]
>         r =3D vduse_dev_msg_sync(dev, &msg);
>         // The device could try to call() from here...
>
>         [...]
> out:
>         // to here
>         vduse_vq_set_ready(vq, ready);
> }
>
> To be honest, I'd prefer to just set ready =3D true at
> vduse_dev_write_iter before returning success to the VDUSE userland.

I think you meant:

vduse_vq_set_ready(vq, ready);
r =3D vduse_dev_msg_sync(dev, &msg);

> This way the synchronization struct is omitted entirely. But let me
> know if you prefer otherwise.

Let's go this way.

Thanks

>
> Thanks!
>

