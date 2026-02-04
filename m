Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90A939A808
	for <virtualization@lists.linux.dev>; Wed,  4 Feb 2026 08:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770195239; cv=none; b=uI7nvLvBUGJoPPnY/E58A3UoWbeICksbpuYIYHTrEVfgOkmURW3UG8HanzHWlncb1IjGHVMKAXImkcDlR38/8wWLryenYK1e1jvmUl7sCOeiTWWA0q6Mg3k3s5VqBhEMQ8cmkm7ExJVgf2fBPXWqpZ7LH2NdQ2+OoB9nuOiYFec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770195239; c=relaxed/simple;
	bh=MvCJzaB2WKjkhJiXn8IVOb+h5L62wsMT18XhFArT01M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FWYwLVdvQAYQB1ywHF1vgZsFBvs8uoiSiZoAF/eqWZUOwFmik1Zwo1F3N6Ff6DPw2irh1F/gcHP2N3jW1s4zHBIOqdIn4PJIqcvVRKymqH9C06lOuSNTXtkCIwk18A/gUv3By/ePJN65iWPMwL8zzSWmV6DVWyg6jjtQ4NbkPN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M5WrxLQZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5WrxLQZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770195237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iw1yhHJiAv53b7DMB9m3leCwsoYzYTVEEz5Jb6pNb4E=;
	b=M5WrxLQZ1GJzU0ggsEgpWQPr4tWYlzy16BHOUBWmmSMzNI9LtfOH436NvxI950KlkyKKj1
	xa0KrL2LMUuGtmwIDqbrDWntlxCVQxP3Rz7Amg3uhDK+ZEmET5/sdFm2T9jHLy9PI1m3H7
	ic4d/vw4ytuhhN79W+kkieyXB1QlMuE=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-h-qY9GO2NlS4y9SHsal1mA-1; Wed, 04 Feb 2026 03:53:56 -0500
X-MC-Unique: h-qY9GO2NlS4y9SHsal1mA-1
X-Mimecast-MFC-AGG-ID: h-qY9GO2NlS4y9SHsal1mA_1770195236
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-794d726efa5so6700607b3.3
        for <virtualization@lists.linux.dev>; Wed, 04 Feb 2026 00:53:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770195236; x=1770800036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iw1yhHJiAv53b7DMB9m3leCwsoYzYTVEEz5Jb6pNb4E=;
        b=AjedGV4xuDBSPX6wjWqxvPdmwLLidXEAOTLtuZGJWVBdiR+ZTk6kqaV8LNzv5Zl/cN
         LriiJCq0yzInlDrkcXjvTfFEukHWB9kaU7Z+PNpXs0Wufo1Nf4sf8EezeifhKEluK44E
         wcwqqDxSYnvfZPMbUej7VonZtrwa5Wopvtaivj/q8OEpBElqL3GCtl62ZrjOsur/iYE2
         xeokdH7kWCYBhUD/n28I4s9uMFKCTrVedV3353oe9dbyT/Nqtv4d7bRPNzGNV26pGM6A
         epYqHVQwyeQ+Z1WcW1HcwF1PBAEJHp/9KegQNJmYt6zNlSuyYwUj+Z+RBxYug0pp9t3V
         7KGg==
X-Forwarded-Encrypted: i=1; AJvYcCVlMpgGRbCPe1sX8mZy/eOJJoqanejbFkhZngRg2+Sy1UFT5zJAEMRHRq1tzw8zRTgPfYvtFrF4M0vZNtkwdQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKj7TSK5pMPVaBqJ0qAQcVgT7BmQrKbiCmMzI5U2AdowYVsiNS
	OVVGXN7e+eFCW9Lb6Yng1elj644XOBhvgTWvjZbu5aJ6l349U1DtYcVuEZC3tkIZteP0+RbSjig
	xY8SrZC9HYu7iOHlwJqsy2HZvF1KajR/CH3Hmplz0V12coO5GnzIH4DmVIBu4ILvQWt2zAaz6hQ
	wwXi1RcLoeXtAcw2jQovLSw+j2SSXSiirBojjB5YOhCZ0=
X-Gm-Gg: AZuq6aI1fLwobBmc+W2008nPPangseDAQMhBl4j65OCbRfHeJnU2ducb4rAcpX75yCr
	zwjYMRkGF5RdhYXpCULjRpZUBQRzC8OYWqaEVsyJvxVSeN8+V1aa+QEUZKQ58AFz/KMMuWdlt6+
	YT7mEp0K3d/yTmEkaB/6+hgWc6jolk90FIUueXJ2d65SFYyCEMtTXnJ4e30yDDMCYmww==
X-Received: by 2002:a05:690c:62c7:b0:794:24b8:1a66 with SMTP id 00721157ae682-794fe75fb74mr21579347b3.37.1770195236125;
        Wed, 04 Feb 2026 00:53:56 -0800 (PST)
X-Received: by 2002:a05:690c:62c7:b0:794:24b8:1a66 with SMTP id
 00721157ae682-794fe75fb74mr21579317b3.37.1770195235758; Wed, 04 Feb 2026
 00:53:55 -0800 (PST)
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
 <CAJaqyWfpJxPYKtUcncpbEvn_wi-Rc3VRyLE5f=0Md9HAksr6Dg@mail.gmail.com> <CACGkMEtBerHiU7EpjOqkJQxgCv2f3MsUURD6AF9663DELETsYQ@mail.gmail.com>
In-Reply-To: <CACGkMEtBerHiU7EpjOqkJQxgCv2f3MsUURD6AF9663DELETsYQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 4 Feb 2026 09:53:19 +0100
X-Gm-Features: AZwV_QhSj6yrtsYhhB1xbQsx8W3ff9PfvxowobyCDAjw0AMDNvLDVdA2W8pXnYY
Message-ID: <CAJaqyWcq73v_v6OoxWnwkOY5gxHV+kL+4eDDjor_rP=OzrBrvg@mail.gmail.com>
Subject: Re: [PATCH 1/6] vduse: ensure vq->ready access is smp safe
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ghlbcdxx3YjhvHqlNJ2HtByHFjmUO2yekadoBtwIDuo_1770195236
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 3:48=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Tue, Feb 3, 2026 at 6:35=E2=80=AFPM Eugenio Perez Martin <eperezma@red=
hat.com> wrote:
> >
> > On Tue, Feb 3, 2026 at 5:05=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> > >
> > > On Fri, Jan 30, 2026 at 3:56=E2=80=AFPM Eugenio Perez Martin
> > > <eperezma@redhat.com> wrote:
> > > >
> > > > On Fri, Jan 30, 2026 at 3:18=E2=80=AFAM Jason Wang <jasowang@redhat=
.com> wrote:
> > > > >
> > > > > On Thu, Jan 29, 2026 at 2:21=E2=80=AFPM Eugenio Perez Martin
> > > > > <eperezma@redhat.com> wrote:
> > > > > >
> > > > > > On Thu, Jan 29, 2026 at 2:17=E2=80=AFAM Jason Wang <jasowang@re=
dhat.com> wrote:
> > > > > > >
> > > > > > > On Wed, Jan 28, 2026 at 8:45=E2=80=AFPM Eugenio P=C3=A9rez <e=
perezma@redhat.com> wrote:
> > > > > > > >
> > > > > > > > The vduse_vdpa_set_vq_ready can be called in the lifetime o=
f the device
> > > > > > > > well after initial setup, and the device can read it afterw=
ards.
> > > > > > > >
> > > > > > > > Ensure that reads and writes to vq->ready are SMP safe so t=
hat the
> > > > > > > > caller can trust that virtqueue kicks and calls behave as e=
xpected
> > > > > > > > immediately after the operation returns.
> > > > > > > >
> > > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > > > ---
> > > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 34 ++++++++++++++++++=
+++++-------
> > > > > > > >  1 file changed, 26 insertions(+), 8 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/v=
dpa/vdpa_user/vduse_dev.c
> > > > > > > > index 73d1d517dc6c..a4963aaf9332 100644
> > > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > @@ -460,6 +460,24 @@ static __poll_t vduse_dev_poll(struct =
file *file, poll_table *wait)
> > > > > > > >         return mask;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +static bool vduse_vq_get_ready(const struct vduse_virtqueu=
e *vq)
> > > > > > > > +{
> > > > > > > > +       /*
> > > > > > > > +        * Paired with vduse_vq_set_ready smp_store, as the=
 driver may modify
> > > > > > > > +        * it while the VDUSE instance is reading it.
> > > > > > > > +        */
> > > > > > > > +       return smp_load_acquire(&vq->ready);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static void vduse_vq_set_ready(struct vduse_virtqueue *vq,=
 bool ready)
> > > > > > > > +{
> > > > > > > > +       /*
> > > > > > > > +        * Paired with vduse_vq_get_ready smp_load, as the =
driver may modify
> > > > > > > > +        * it while the VDUSE instance is reading it.
> > > > > > > > +        */
> > > > > > > > +       smp_store_release(&vq->ready, ready);
> > > > > > >
> > > > > > > Assuming this is not used in the datapath, I wonder if we can=
 simply
> > > > > > > use vq_lock mutex.
> > > > > > >
> > > > > >
> > > > > > The function vduse_vq_set/get_ready are not in the datapath, bu=
t
> > > > > > vduse_vq_kick and vduse_vq_signal_irqfd are.  I'm ok if you wan=
t to
> > > > > > switch to vq_mutex if you want though, maybe it's even comparab=
le with
> > > > > > the cost of the ioctls or eventfd signaling.
> > > > >
> > > > > I'd like to use mutex for simplicity.
> > > > >
> > > >
> > > > I cannot move it to a mutex, as we need to take it in the critical
> > > > sections of the kick_lock and irq_lock spinlocks.
> > > >
> > > > I can move it to a spinlock, but it seems more complicated to me. W=
e
> > > > need to make sure we always take these kick_lock and irq_lock in th=
e
> > > > same order as the ready_lock, to not create deadlocks, and they alw=
ays
> > > > protect just the ready boolean. But sure, I'll send the spinlock
> > > > version for V2.
> > >
> > > Thinking about this, I'm not sure I understand the issue.
> > >
> > > Maybe you can give me an example of the race.
> > >
> >
> > It's the same issue as you describe with set_group_asid on cpu1 and
> > dma_map and dma_unmap in cpu1 in this mail [0], but now the functions
> > are set_vq_ready in the vdpa driver side and VDUSE_VQ_GET_INFO in the
> > VDUSE instance.
> >
> > To me, the barriers should be in the driver and the VDUSE instance,
> > and the VDUSE instance should use the VDUSE_SET_VQ_READY message to
> > know when a VQ is ready. But I don't expect all the VDUSE instances to
> > opt-in for that, so the flow without smp barriers is:
> >
> > [cpu0] .set_vq_ready(vq, true)
> > [cpu1] VDUSE_VQ_GET_INFO(vq)
> > [cpu1] check vq->ready, and it races with the set_vq_ready from cpu0.
> >
>
> Are there any side effects of this race? I meant the driver can do
> set_vq_ready() at any time. And there would be message for notifying
> the usersapce in this series.
>

Actually I'm moving to a semaphore for the moment. SMP barrier is not enoug=
h.

The message works for the driver to know that the device vq is ready
and it can send kicks. But there is a race for the device where it has
replied to the message but vq->ready is still not true:

static void vduse_vdpa_set_vq_ready(struct vdpa_device *vdpa,
                                        u16 idx, bool ready)
{
        [...]
        r =3D vduse_dev_msg_sync(dev, &msg);
        // The device could try to call() from here...

        [...]
out:
        // to here
        vduse_vq_set_ready(vq, ready);
}

To be honest, I'd prefer to just set ready =3D true at
vduse_dev_write_iter before returning success to the VDUSE userland.
This way the synchronization struct is omitted entirely. But let me
know if you prefer otherwise.

Thanks!

