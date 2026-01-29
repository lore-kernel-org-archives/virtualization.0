Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F065369973
	for <virtualization@lists.linux.dev>; Thu, 29 Jan 2026 06:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769667684; cv=none; b=ju8XWJMQiYD6PfVOMbLXzNVwrF9Wy4ZXOVRjapqIjoZOFTK92oHwbeE49+5FYI1f8E3/iT2RlWZQifCI3B8NFA0o/IJcX6Kufp0JIREtzHHewWdeccNcbAxBggw9cmNWE3Woy2pdlnMPH4Y2ikfFpSl3ho6mCcSlkcAarNAqGug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769667684; c=relaxed/simple;
	bh=2l+nyXsadU4uMdG4FM805fGEtBlNz/Drt9L1hO+Jg/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aRZhcvCVsdYuXyGGbXuYDnYyXkTPw0TMZpGXnWnrJIN7AucCS4T+olXdlHuAr1kPG06CvcEATCkbepVbq2ZjukH91hTDlfI2QBtIZpwNSYJR2J9rXl8WangZd/Q56jdOjSRl8WZrK3MmETEOlNu08oLZtf9B5IJW3/Gh8I5mn80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VTu1po3Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VTu1po3Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769667681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lcffixwGmSB5qTikU+v8skwhRDmRog/uwEHsQqyXtEI=;
	b=VTu1po3Z01pRtbU+lyz9ZV38XHtfBXJuHTSrPdWT5h5yt0lE8O+lC6r7uOUTyR3Kc5V+Nh
	wr5UBX5xAVq23KPatm88RQZQDZaQfpV1IvtztFrrFDFYReJ/iC0X+b8Hjz5nnXJa543ZEm
	pEbBSt4I91TEn1HLPiTrZ7hVnaEtuvI=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-O46-dfe0PrODMnPCJjR14w-1; Thu, 29 Jan 2026 01:21:20 -0500
X-MC-Unique: O46-dfe0PrODMnPCJjR14w-1
X-Mimecast-MFC-AGG-ID: O46-dfe0PrODMnPCJjR14w_1769667680
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-78e7aadfbbfso7177897b3.0
        for <virtualization@lists.linux.dev>; Wed, 28 Jan 2026 22:21:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769667680; x=1770272480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lcffixwGmSB5qTikU+v8skwhRDmRog/uwEHsQqyXtEI=;
        b=h+NonWcmaNDB97kVnRFYB4P6dyM0iL6AC4IQHhpoyvPEAce54C51Pway7iA6oWqER3
         /OQ6d3eXs78RtT1MDKMpkNLLaQ4WhSpWj/OGidO1kvNsdpbgZsg16ULOi6d0NjLM4JFZ
         3IVa0Lxi0SxcKsrMWJBqWr/7UQMr1T+uXq1vR3sgLOgiq4+i+2FkxZt+7PeNaEswhhd0
         KSUOabI+Dn5pc1HzxmIZoFKF3FONkyxjEe9z4TOHQVtkEkeuD2JDkQ5yKdOaMM18QuBU
         ICSObPA7j0wyl5GRbtTBu2FMg9qBHCJw+2ZzmYpz1AoinLu5HhwcbouekAe7Td2GU7qv
         enSw==
X-Forwarded-Encrypted: i=1; AJvYcCUXA4txJ6+3kA9vc2gUpI0hDDb60sab5jV/jMhcwYGFF/WsW+r7z37Wpub5cgGZM0xon0GpQMagIkJBgnHCvg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7ckENawbwqZkcpvUJhbpIuh75hNxUa6iYfqfUOuWHVaDh+zXR
	RkzLAn5dhvELZRSTqkrsf+ptVG5cgF6TfmCqv4+pcAR7WXlHhCUwYob/JLD6QxMZ5k55tVHxkm/
	xAyNMNOJdfUW1/Uo6WssciGWQD70z7U2lBH17GPoTgFjXN7qWt4OHqUpU3mvvFASx8LSw56O89T
	cSrv0j4EKYmCiXZquqkUVdzbwoKoiZ8SvkK2BAYX9DY0k=
X-Gm-Gg: AZuq6aIcY/5GanbjMedPa6lGqDV56CtBnS8BIkTHPZAHVbHtFZrnh9VwrWQ/Qikp1mh
	g/IP60GOipBmhq29hV4NQmFHYxGtRqFpz0LkiwBNPgEbHrxXXP5PVo3Q7POSyTqJxpBK+x6Air/
	F1A4BT1ekRp2GnwCEuBQF+mCVE8oAOsUEEuLTSNag+Tu2yTpM5klkXHCP586ajKMbuqw==
X-Received: by 2002:a05:690c:3390:b0:794:2014:1170 with SMTP id 00721157ae682-7947ab2ed29mr66082717b3.25.1769667679869;
        Wed, 28 Jan 2026 22:21:19 -0800 (PST)
X-Received: by 2002:a05:690c:3390:b0:794:2014:1170 with SMTP id
 00721157ae682-7947ab2ed29mr66082607b3.25.1769667679569; Wed, 28 Jan 2026
 22:21:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260128124524.875271-1-eperezma@redhat.com> <20260128124524.875271-2-eperezma@redhat.com>
 <CACGkMEuDPgkEVzpu0c+oKvOqgaSR5=CnHMe9iZDi_PFQan0m6g@mail.gmail.com>
In-Reply-To: <CACGkMEuDPgkEVzpu0c+oKvOqgaSR5=CnHMe9iZDi_PFQan0m6g@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 29 Jan 2026 07:20:43 +0100
X-Gm-Features: AZwV_Qhu_tslHJgfUEeVCGbf654ko21Go3vdnm4msZbWEMkxXJdGHPG8qYnV7Uo
Message-ID: <CAJaqyWf5sC38oT2ZkmfR_MkiYWjLsuyF4Z4opSmgS1nG8BZhgw@mail.gmail.com>
Subject: Re: [PATCH 1/6] vduse: ensure vq->ready access is smp safe
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BlvKK7RmrkHJQX9Xqlj4fpuUlcZKaleOSUoHTLPhccA_1769667680
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 2:17=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Jan 28, 2026 at 8:45=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redh=
at.com> wrote:
> >
> > The vduse_vdpa_set_vq_ready can be called in the lifetime of the device
> > well after initial setup, and the device can read it afterwards.
> >
> > Ensure that reads and writes to vq->ready are SMP safe so that the
> > caller can trust that virtqueue kicks and calls behave as expected
> > immediately after the operation returns.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 34 +++++++++++++++++++++++-------
> >  1 file changed, 26 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 73d1d517dc6c..a4963aaf9332 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -460,6 +460,24 @@ static __poll_t vduse_dev_poll(struct file *file, =
poll_table *wait)
> >         return mask;
> >  }
> >
> > +static bool vduse_vq_get_ready(const struct vduse_virtqueue *vq)
> > +{
> > +       /*
> > +        * Paired with vduse_vq_set_ready smp_store, as the driver may =
modify
> > +        * it while the VDUSE instance is reading it.
> > +        */
> > +       return smp_load_acquire(&vq->ready);
> > +}
> > +
> > +static void vduse_vq_set_ready(struct vduse_virtqueue *vq, bool ready)
> > +{
> > +       /*
> > +        * Paired with vduse_vq_get_ready smp_load, as the driver may m=
odify
> > +        * it while the VDUSE instance is reading it.
> > +        */
> > +       smp_store_release(&vq->ready, ready);
>
> Assuming this is not used in the datapath, I wonder if we can simply
> use vq_lock mutex.
>

The function vduse_vq_set/get_ready are not in the datapath, but
vduse_vq_kick and vduse_vq_signal_irqfd are.  I'm ok if you want to
switch to vq_mutex if you want though, maybe it's even comparable with
the cost of the ioctls or eventfd signaling.

