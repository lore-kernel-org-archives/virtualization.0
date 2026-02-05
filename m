Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E28275844
	for <virtualization@lists.linux.dev>; Thu,  5 Feb 2026 06:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770273088; cv=none; b=mQwe5P83gVrKEzJA8w2dw37MyaX5bx686FT1swTCfoLTuV2eDKdCEC8LFLrD01PKQJLlWnfuWhPkWA2B+WQzXfj2YwXDFV/n2n0qeGLvdhB3HOSnc5IQtWfc+OD7DgtthRaQ5LYO3yBfE5xewKf6a+Ia1PhevFWOAXegUIhgr9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770273088; c=relaxed/simple;
	bh=00MBHUIHq4AthotC1LwOWuWpSnWDEDl7Gdbv0O1p+js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HBcXsflzdwYo+Q8tpdmAmBOioKuTPP25PdZmGPm/78RcIS0w9wZAkMiheUZNu9kmR5BOpRz6wHLsyTf3iZCYmjbNm8hpOYNT65h+Clp34AoutwALPStbfRVSwFkurbsk6yYlaqUvIFXtVU+8mSfuRrlS2U7PyLTW05FAstUFh/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i5TdSiWZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i5TdSiWZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770273087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ns1cKsYAaKnF1Sk0Obiqqsu06GButcLOC+YVM11I5fw=;
	b=i5TdSiWZarM1Jz3uRW9we9kZyLEs1+zpuUv755CLODZYGx2WbQcsqbZaBIEoZobbSzPTcz
	I3e2axQSobF8XBkZ7ZJR13ggTW6lIuAB2BJvIiFrtX2D2e9JMsjR/WdiSuERM+LiWxLv5k
	RDaZ+aGpx4QFlpYvVztWQaql0y++4o4=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-J-WXUFA-NDaYvMlPvbzAMA-1; Thu, 05 Feb 2026 01:31:25 -0500
X-MC-Unique: J-WXUFA-NDaYvMlPvbzAMA-1
X-Mimecast-MFC-AGG-ID: J-WXUFA-NDaYvMlPvbzAMA_1770273085
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7949310b90cso8217557b3.2
        for <virtualization@lists.linux.dev>; Wed, 04 Feb 2026 22:31:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770273085; x=1770877885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ns1cKsYAaKnF1Sk0Obiqqsu06GButcLOC+YVM11I5fw=;
        b=OxO3SER8UB+jtamvPSagIWrST5PhR2x8OiSrrptDMQcis/x4Dq2s1YQgPCR0jF9w20
         IZEtQ8tb/WtjoE2xFAcyyBP3eJBfB0G9jfZMuY+ildQTzNOxSHsv8v4iEAJjI+mD6MhI
         4azHYf2vNr7vtnBaWTXcKFopkpu+7SDOk3wRskV9m5VzvUHMFx7QfHLMkNsheS1MFA/h
         8dgDATwv5FF54BWSu0W0H1siy5NO7ThwUjpxFpSFTGZNtN5xWRkWewJiJnoMhpzNtdDQ
         8p9gB92fp3kCHCdFVxR84aI2T9m+0HN0tGyWFofym7LJPW9+IMFKDjoJGrOhG/UuwZx+
         NU5w==
X-Forwarded-Encrypted: i=1; AJvYcCX3aMPTuezMmZp5/X7cnA7CLfv0yTIeKuWzig1LX89+WLvdoscVXHxSJOQGmrtcLj5fUclyZMGg5F0a97dAUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yybg1okama7QwTrsR8OPWU8xh9Jg2u14Qav9YrmrLlzr9w2UGEs
	mIyV5a4K8I4RBESL+mxv5WS43PWIaIFNftt8+Y2QBBLG8gn8C7FktjxXRSOw+EWkQeGTJKWsMOT
	c/j/jMl26Lc5HTCuQSDya1OvNZ2IskXUwVcoIoztQUfl/GPtbDAVlSTt2U4KgN824G8fGXN2Vx9
	3AWs5Hd2CPgfOCwilJzHGIp7C/R+HASW5SVNunP9aeREg=
X-Gm-Gg: AZuq6aLo/z8e+064B0qOyzkP3tzScwHqmd7pTYZI65NYtfudY4cujF0PPDpf6fLgNM9
	9QUgczegfYRzT4cSbTxJpbunWAmoMV53HJoD55o5UgXL63BuWiPXE6ZO8Xlz9u6xsVPCxM90tcG
	Q7vvdkKDp2Gkju1Zj95d/FHiKAQGuEZKxRo2iXgLJTk1g2ugxv+l6sB4MCrIsxDZV3Pg==
X-Received: by 2002:a05:690c:968b:b0:788:1f66:4cc2 with SMTP id 00721157ae682-794fe6ca352mr51499757b3.8.1770273085112;
        Wed, 04 Feb 2026 22:31:25 -0800 (PST)
X-Received: by 2002:a05:690c:968b:b0:788:1f66:4cc2 with SMTP id
 00721157ae682-794fe6ca352mr51499577b3.8.1770273084721; Wed, 04 Feb 2026
 22:31:24 -0800 (PST)
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
 <CACGkMEtBerHiU7EpjOqkJQxgCv2f3MsUURD6AF9663DELETsYQ@mail.gmail.com>
 <CAJaqyWcq73v_v6OoxWnwkOY5gxHV+kL+4eDDjor_rP=OzrBrvg@mail.gmail.com> <CACGkMEv9XApkhiA8qSO27duw-7e9obWYO=fzFJ5FTh91L3Tttg@mail.gmail.com>
In-Reply-To: <CACGkMEv9XApkhiA8qSO27duw-7e9obWYO=fzFJ5FTh91L3Tttg@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 5 Feb 2026 07:30:48 +0100
X-Gm-Features: AZwV_QgLd-Ipz53vILQOIWyJOQgQL3vQuOxSwraeAMLr-9xI-vYnQghv5udGzrU
Message-ID: <CAJaqyWc6L2Swu3cg2Bx1sUtH_=GnUy+xUEWWNW5X5JzXcXg5TQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] vduse: ensure vq->ready access is smp safe
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: E8_mIg-hayD08I7QfXg-sn2j96PQltdCJVMeZoHdAr4_1770273085
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 5:04=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Wed, Feb 4, 2026 at 4:54=E2=80=AFPM Eugenio Perez Martin <eperezma@red=
hat.com> wrote:
> >
> > On Wed, Feb 4, 2026 at 3:48=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> > >
> > > On Tue, Feb 3, 2026 at 6:35=E2=80=AFPM Eugenio Perez Martin <eperezma=
@redhat.com> wrote:
> > > >
> > > > On Tue, Feb 3, 2026 at 5:05=E2=80=AFAM Jason Wang <jasowang@redhat.=
com> wrote:
> > > > >
> > > > > On Fri, Jan 30, 2026 at 3:56=E2=80=AFPM Eugenio Perez Martin
> > > > > <eperezma@redhat.com> wrote:
> > > > > >
> > > > > > On Fri, Jan 30, 2026 at 3:18=E2=80=AFAM Jason Wang <jasowang@re=
dhat.com> wrote:
> > > > > > >
> > > > > > > On Thu, Jan 29, 2026 at 2:21=E2=80=AFPM Eugenio Perez Martin
> > > > > > > <eperezma@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Jan 29, 2026 at 2:17=E2=80=AFAM Jason Wang <jasowan=
g@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Jan 28, 2026 at 8:45=E2=80=AFPM Eugenio P=C3=A9re=
z <eperezma@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > The vduse_vdpa_set_vq_ready can be called in the lifeti=
me of the device
> > > > > > > > > > well after initial setup, and the device can read it af=
terwards.
> > > > > > > > > >
> > > > > > > > > > Ensure that reads and writes to vq->ready are SMP safe =
so that the
> > > > > > > > > > caller can trust that virtqueue kicks and calls behave =
as expected
> > > > > > > > > > immediately after the operation returns.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > > > > > ---
> > > > > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 34 ++++++++++++++=
+++++++++-------
> > > > > > > > > >  1 file changed, 26 insertions(+), 8 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drive=
rs/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > > index 73d1d517dc6c..a4963aaf9332 100644
> > > > > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > > @@ -460,6 +460,24 @@ static __poll_t vduse_dev_poll(str=
uct file *file, poll_table *wait)
> > > > > > > > > >         return mask;
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > +static bool vduse_vq_get_ready(const struct vduse_virt=
queue *vq)
> > > > > > > > > > +{
> > > > > > > > > > +       /*
> > > > > > > > > > +        * Paired with vduse_vq_set_ready smp_store, as=
 the driver may modify
> > > > > > > > > > +        * it while the VDUSE instance is reading it.
> > > > > > > > > > +        */
> > > > > > > > > > +       return smp_load_acquire(&vq->ready);
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +static void vduse_vq_set_ready(struct vduse_virtqueue =
*vq, bool ready)
> > > > > > > > > > +{
> > > > > > > > > > +       /*
> > > > > > > > > > +        * Paired with vduse_vq_get_ready smp_load, as =
the driver may modify
> > > > > > > > > > +        * it while the VDUSE instance is reading it.
> > > > > > > > > > +        */
> > > > > > > > > > +       smp_store_release(&vq->ready, ready);
> > > > > > > > >
> > > > > > > > > Assuming this is not used in the datapath, I wonder if we=
 can simply
> > > > > > > > > use vq_lock mutex.
> > > > > > > > >
> > > > > > > >
> > > > > > > > The function vduse_vq_set/get_ready are not in the datapath=
, but
> > > > > > > > vduse_vq_kick and vduse_vq_signal_irqfd are.  I'm ok if you=
 want to
> > > > > > > > switch to vq_mutex if you want though, maybe it's even comp=
arable with
> > > > > > > > the cost of the ioctls or eventfd signaling.
> > > > > > >
> > > > > > > I'd like to use mutex for simplicity.
> > > > > > >
> > > > > >
> > > > > > I cannot move it to a mutex, as we need to take it in the criti=
cal
> > > > > > sections of the kick_lock and irq_lock spinlocks.
> > > > > >
> > > > > > I can move it to a spinlock, but it seems more complicated to m=
e. We
> > > > > > need to make sure we always take these kick_lock and irq_lock i=
n the
> > > > > > same order as the ready_lock, to not create deadlocks, and they=
 always
> > > > > > protect just the ready boolean. But sure, I'll send the spinloc=
k
> > > > > > version for V2.
> > > > >
> > > > > Thinking about this, I'm not sure I understand the issue.
> > > > >
> > > > > Maybe you can give me an example of the race.
> > > > >
> > > >
> > > > It's the same issue as you describe with set_group_asid on cpu1 and
> > > > dma_map and dma_unmap in cpu1 in this mail [0], but now the functio=
ns
> > > > are set_vq_ready in the vdpa driver side and VDUSE_VQ_GET_INFO in t=
he
> > > > VDUSE instance.
> > > >
> > > > To me, the barriers should be in the driver and the VDUSE instance,
> > > > and the VDUSE instance should use the VDUSE_SET_VQ_READY message to
> > > > know when a VQ is ready. But I don't expect all the VDUSE instances=
 to
> > > > opt-in for that, so the flow without smp barriers is:
> > > >
> > > > [cpu0] .set_vq_ready(vq, true)
> > > > [cpu1] VDUSE_VQ_GET_INFO(vq)
> > > > [cpu1] check vq->ready, and it races with the set_vq_ready from cpu=
0.
> > > >
> > >
> > > Are there any side effects of this race? I meant the driver can do
> > > set_vq_ready() at any time. And there would be message for notifying
> > > the usersapce in this series.
> > >
> >
> > Actually I'm moving to a semaphore for the moment. SMP barrier is not e=
nough.
> >
> > The message works for the driver to know that the device vq is ready
> > and it can send kicks. But there is a race for the device where it has
> > replied to the message but vq->ready is still not true:
> >
> > static void vduse_vdpa_set_vq_ready(struct vdpa_device *vdpa,
> >                                         u16 idx, bool ready)
> > {
> >         [...]
> >         r =3D vduse_dev_msg_sync(dev, &msg);
> >         // The device could try to call() from here...
> >
> >         [...]
> > out:
> >         // to here
> >         vduse_vq_set_ready(vq, ready);
> > }
> >
> > To be honest, I'd prefer to just set ready =3D true at
> > vduse_dev_write_iter before returning success to the VDUSE userland.
>
> I think you meant:
>
> vduse_vq_set_ready(vq, ready);

Since this function's error path is to break the device, I think it
can work, yes. I'm sending the V2 with this.

Thanks!

> r =3D vduse_dev_msg_sync(dev, &msg);
>
> > This way the synchronization struct is omitted entirely. But let me
> > know if you prefer otherwise.
>
> Let's go this way.
>
> Thanks
>
> >
> > Thanks!
> >
>
>

