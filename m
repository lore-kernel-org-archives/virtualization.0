Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987E62E9EBB
	for <virtualization@lists.linux.dev>; Fri, 30 Jan 2026 02:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769739507; cv=none; b=lfWG3rN1m1brcoA4qt/+ofm+yCf6EcArwN5UBl3agTFqANQBALTRk+E+rEy4n92kx82F9Cg7uPtZReU19RSvCuguXrm09j3WtIPSnLo2UFbANkMiBlpQFlJbmMS1J9Iq/LbbRHjMg+fpSAag9UuoJHdMJQxKLqTDJbZ+Jyls2Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769739507; c=relaxed/simple;
	bh=mrpQtLk1R5+OG6/V/G92amIvMLs+JqEhyGMwc2buiZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g2xL8WkdCA6tYOMVU4FTfm6g924gKdRAT/YqBFE9YRtq8ddgj/geKZ1klo1+yhbG9cYmwMa5crdHUKZJW6ezm2pQ7R9bKKPq4xWQa8IB7QanEt32vznhqrJl6Ff/Bx278OL1vTQ24c9i0wvKS6RQe02GK6r70tMMAOD0SzYBmZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SWgSBiwi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWgSBiwi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769739504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Egu9RvD0k5vFxbxbn9sFHniUT4+/LCiXs7656c5wtj8=;
	b=SWgSBiwiG52n4l7orJbYitYMYcPWuWt/7UJAk2RKPwgPFXupBlOhX4DTuMzHnudN5ZA3ut
	hFzqvWMoMq9VJaUW0diur1yT6x+a7UrUZx0HRls6u8IcY0tZGCIvyVyNVu7QBRuQw3FggZ
	ntNyOg8FZDKrCoho1G0Pk6ewBfwXI5g=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-AxQbcI0AOiatmzaDwSG5mg-1; Thu, 29 Jan 2026 21:18:21 -0500
X-MC-Unique: AxQbcI0AOiatmzaDwSG5mg-1
X-Mimecast-MFC-AGG-ID: AxQbcI0AOiatmzaDwSG5mg_1769739500
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-352e1a8603bso1734259a91.1
        for <virtualization@lists.linux.dev>; Thu, 29 Jan 2026 18:18:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769739500; x=1770344300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Egu9RvD0k5vFxbxbn9sFHniUT4+/LCiXs7656c5wtj8=;
        b=ZheYbguEDcFTyI4BsTVVo+6BeGY84MkvUmAmw/7oqV+W87UVs1uhWr+exLTNL5cZ7V
         VhfXEMcUTf/sNbzL4qdszz47qDw2GlSf4rg4Gy13/eAYh8tJWtyEwQd//lMRmctYq5Lt
         xPzalNtwE7T1fo8JoKLSwgjynOtGXeW6Lp0hb6p4rwH9QJSjnpfYYVHXVmSnqmHZgGYU
         h7U7Vl0YfhZ7HMmV4UEUhwhr4G20sKWdjpUR+Kpkz5HdB6HMJdC/Jdvy6+sK+6uHR0jx
         DWgqvepoV3fDWMbIwXhXZFOj3f4xOUnBB09uMXOmJD0LR4wdWw3XpDGTj+XKELVkQsLM
         h8rw==
X-Forwarded-Encrypted: i=1; AJvYcCUkSgyA1WfClG0Ip46OhoppR9IDZdhZwSvpevPE27qaeCYk3/zrtduMWSQ9psDcnXq2ZL7FYHYwKbS3LXmwZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzU5028n1nbq9OffCRnwo4qlhTWyJu1Z1aSw1F9MfJL+c/wJXFd
	5K5WkHjWs5oUNWhbc4xi7N5W4xiyNLh+gzihb0P1X2z2+3UQCbOGrGv6XfcT/WYnaUzdUMsS5eD
	6QM68NtMCjY1K8Ga1jas9T7/1Lh6hs/8zOKHfYa+PCUXwKh/Ef5Py9CUNxPr8iP0MSS3iEkhFUE
	xB8PtYe175cDLffs+Ni0vmQAuHm9FFl7CkdCPT7kfmi78=
X-Gm-Gg: AZuq6aKoVN153oNzvyx4IgXu0gQyaXNDjJ4Nc+AzUxKHfd17NnBfOMn18OqjZzMGgFN
	nW738QVvlMrkZsDfKQgeWDQhRZzyBSs6s9lr75EcpVzfwJjxK+SpGot7qRT7wwEWQRUgtyTxFOl
	lIa2KT2FXR6ldlewGO5dc/3PT1PrYS/F4c0xI4KLgDpAnJwnbkTMu02TPaNUXuJQoO
X-Received: by 2002:a17:90b:580b:b0:340:9d52:44c1 with SMTP id 98e67ed59e1d1-3543b3cf6bfmr1315016a91.35.1769739499942;
        Thu, 29 Jan 2026 18:18:19 -0800 (PST)
X-Received: by 2002:a17:90b:580b:b0:340:9d52:44c1 with SMTP id
 98e67ed59e1d1-3543b3cf6bfmr1314993a91.35.1769739499514; Thu, 29 Jan 2026
 18:18:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260128124524.875271-1-eperezma@redhat.com> <20260128124524.875271-2-eperezma@redhat.com>
 <CACGkMEuDPgkEVzpu0c+oKvOqgaSR5=CnHMe9iZDi_PFQan0m6g@mail.gmail.com> <CAJaqyWf5sC38oT2ZkmfR_MkiYWjLsuyF4Z4opSmgS1nG8BZhgw@mail.gmail.com>
In-Reply-To: <CAJaqyWf5sC38oT2ZkmfR_MkiYWjLsuyF4Z4opSmgS1nG8BZhgw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 30 Jan 2026 10:18:06 +0800
X-Gm-Features: AZwV_Qi3u9pH48cwXeOn5iuHntrJxYcJcVribdruopbeMtyVOZmOj_ClOiQog4U
Message-ID: <CACGkMEsr_cx-xR85wZ5c=QfegLfG5j0wHTjokEADpgn37gQRJQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] vduse: ensure vq->ready access is smp safe
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZePZq1lRiDBL2i8GfZEy0XPVskmcfwOCgPgVPnNieac_1769739500
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 2:21=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Thu, Jan 29, 2026 at 2:17=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Wed, Jan 28, 2026 at 8:45=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@re=
dhat.com> wrote:
> > >
> > > The vduse_vdpa_set_vq_ready can be called in the lifetime of the devi=
ce
> > > well after initial setup, and the device can read it afterwards.
> > >
> > > Ensure that reads and writes to vq->ready are SMP safe so that the
> > > caller can trust that virtqueue kicks and calls behave as expected
> > > immediately after the operation returns.
> > >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 34 +++++++++++++++++++++++-----=
--
> > >  1 file changed, 26 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_u=
ser/vduse_dev.c
> > > index 73d1d517dc6c..a4963aaf9332 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -460,6 +460,24 @@ static __poll_t vduse_dev_poll(struct file *file=
, poll_table *wait)
> > >         return mask;
> > >  }
> > >
> > > +static bool vduse_vq_get_ready(const struct vduse_virtqueue *vq)
> > > +{
> > > +       /*
> > > +        * Paired with vduse_vq_set_ready smp_store, as the driver ma=
y modify
> > > +        * it while the VDUSE instance is reading it.
> > > +        */
> > > +       return smp_load_acquire(&vq->ready);
> > > +}
> > > +
> > > +static void vduse_vq_set_ready(struct vduse_virtqueue *vq, bool read=
y)
> > > +{
> > > +       /*
> > > +        * Paired with vduse_vq_get_ready smp_load, as the driver may=
 modify
> > > +        * it while the VDUSE instance is reading it.
> > > +        */
> > > +       smp_store_release(&vq->ready, ready);
> >
> > Assuming this is not used in the datapath, I wonder if we can simply
> > use vq_lock mutex.
> >
>
> The function vduse_vq_set/get_ready are not in the datapath, but
> vduse_vq_kick and vduse_vq_signal_irqfd are.  I'm ok if you want to
> switch to vq_mutex if you want though, maybe it's even comparable with
> the cost of the ioctls or eventfd signaling.

I'd like to use mutex for simplicity.

Thanks

>

