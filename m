Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143862750ED
	for <virtualization@lists.linux.dev>; Thu, 18 Sep 2025 06:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758175470; cv=none; b=IIYw24D3yHPu9CkZbLQRD2OWIrQkkwHSaYAQF7Et73gCHU4bjyCFr6ZInOtWNAe4QGwP117k/VFMqPY9gKttFpTtve6NSDgUtDhADWUOMzPntUaDr+lCesu5xZ1jIYGCDYUVbDw35T6b8s+UfiR6eG+rNla3bFJsJueAZZ2Wns8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758175470; c=relaxed/simple;
	bh=Jywi48PU4d2DZTBGf6Cnjih4mf6Z3UgV12fYwEc0Nso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dukGrLiD3+N0aNQO/QrBPmxj+B8n4Zgb4Fb4elC8paxdzGoMLhsoLJmd3lVDNbhmesqdYl8An0hna/FhTZUFzQSPJ3To06d/bLmjDoqEzdgOe2P0uUVJ0eCP9GQ7GsO7/SVfwwoW/COlMGxF/booG8oYMRa9IeTAwWQg7U3A7b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X3HRC/fC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3HRC/fC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758175467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p/QgS8HOi26kvO1Lv87IGYaGcFOWHc7Jaoo1F8SVjP4=;
	b=X3HRC/fCDHjXm/0Nc+fKlAplKUNAwXU3TjXu2BsQp+4TManOFNShQxZFCJLNULwZSTXbQb
	rR7ayA8yqIg7t8SigIn4lNKc5KXFq2ncXQxfuWF0Q8BtD3az4c5chQxzRm32TfqCjPpKbg
	lLGdJttHMOVwhnHZ2JnVWQC7WggQ9Dg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-0KjPcE6kPAuwFDlOOrzQNg-1; Thu, 18 Sep 2025 02:04:26 -0400
X-MC-Unique: 0KjPcE6kPAuwFDlOOrzQNg-1
X-Mimecast-MFC-AGG-ID: 0KjPcE6kPAuwFDlOOrzQNg_1758175465
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32e09eaf85dso686741a91.1
        for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 23:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758175465; x=1758780265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/QgS8HOi26kvO1Lv87IGYaGcFOWHc7Jaoo1F8SVjP4=;
        b=TrnloMmyI/Hkf0iZ4tedf5bu9Bkz/e/s6j0r4MRXPJoeH6dXR3qbJkDpbOpMFMNbwS
         ueOUAHsgZWpTQ9Vy2OK+g7iu+aVP6Wqv9guuJ6MD9/jhprK9uVmt1ya1nFix6Kh8b9Mf
         55b0AUL0HuevLwZNwy/Fsl+S8Rnctr4MC4sX1F2K+Mw75HpdtAf3QjcoQSVwd66DhiyI
         V3LdOGKLZNs1+MwVmCk2OzNCx7cTzdsKh7dUqs9Q4DrqgSUCSNu9wPg8ERVbvFXLWpOa
         81Y2H4do6EB6zlMDBNZOnfvTivu8Pa19OjfBcbSrpBq8o/qQGZ0Mbn6uWZfBKmeKzln/
         jaKA==
X-Forwarded-Encrypted: i=1; AJvYcCVZEJq1tZOK3y15+nS7dQOM1Cail9mYpfjkeqfp7SE4PBT6hZZtInn5Jn35Ii3uW6cXaNAUJ0GaFOT/V9SzBg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxqVRqz936nF7lLV4+KH8ZptrmgfWIWQbzvFXjmzuBCDxsgyHYW
	RjVu/W1y6VK3bmksD8EYWtTLPZOJnAmy0vZ4u+M7fS3xPh1+gAJO/qbysms0U0SWsN4i6Mxv/j2
	l8Q2FmqBk+dsmASmk6BzMdcfwWbSz/tJzmK8ZQziQvpd2XCugk6cWncJFx2BExDXDOXK4lWsKcr
	hVb6ObXYBVdSxlMgETYRjv18byUHkvHzCYX9QCTEC6Ft0=
X-Gm-Gg: ASbGnctokZWWyqyd0bm0FDACFq8CU7yqmh6jkMqMXCEWMZ+9fuQ7Gj1Cbjwj/JlEPrY
	zO4vRzMbaRR76aHLI/H7kbXUoEYsVA4WNomxqFXE8KB1txazJkOWokOpjbkZnilIWNRMwB7wCUj
	iuCaKrLKORoZnM2DHsan8JYg==
X-Received: by 2002:a17:90a:d605:b0:32e:a60d:93e2 with SMTP id 98e67ed59e1d1-32ee3f0091amr5561305a91.11.1758175464826;
        Wed, 17 Sep 2025 23:04:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF74BNn62n0fCPpYrN19sazfjg3lw3RFSdYOhWEwIFAbxay07InGj0/AE3xU3ArCc/qZ6HXLFS6Jeu2ve2W34Q=
X-Received: by 2002:a17:90a:d605:b0:32e:a60d:93e2 with SMTP id
 98e67ed59e1d1-32ee3f0091amr5561274a91.11.1758175464423; Wed, 17 Sep 2025
 23:04:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250916130833.329087-1-eperezma@redhat.com> <20250916130833.329087-6-eperezma@redhat.com>
 <CACGkMEtp61-OB2EpuMY+SWd2b1yShGwfTCNuw9xtMC5YdkpQkQ@mail.gmail.com> <CAJaqyWdu9O_q7dzXk98XcUE=wT1J3gA89j_3DAEJ7y1p_V+c5w@mail.gmail.com>
In-Reply-To: <CAJaqyWdu9O_q7dzXk98XcUE=wT1J3gA89j_3DAEJ7y1p_V+c5w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Sep 2025 14:04:13 +0800
X-Gm-Features: AS18NWDBdO22KtYZ3g_3p0_7NDuMDIxSVKlBfzpM64iTVt8a4bYvOuUSrXtXEhI
Message-ID: <CACGkMEt6fdud4t5k_veh_jr+4BGmvgZzMyWUP8JA5ki3gVt5DQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] vduse: create vduse_as to make it an array
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1AGzAoQ1r-RRhV4JSonUy6O08KczGI0qBbioNYpn4ZM_1758175465
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 12:35=E2=80=AFAM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Wed, Sep 17, 2025 at 10:46=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> >
> > On Tue, Sep 16, 2025 at 9:09=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@re=
dhat.com> wrote:
> > >
> > > This is a first step so we can make more than one different address
> > > spaces.  No change on the colde flow intended.
> > >
> > > Acked-by: Jason Wang <jasowang@redhat.com>
> >
> > Sorry, I think I found something new.
> >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 114 +++++++++++++++------------=
--
> > >  1 file changed, 59 insertions(+), 55 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_u=
ser/vduse_dev.c
> > > index 9c12ae72abc2..b45b1d22784f 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -86,6 +86,12 @@ struct vduse_umem {
> > >         struct mm_struct *mm;
> > >  };
> > >
> > > +struct vduse_as {
> > > +       struct vduse_iova_domain *domain;
> > > +       struct vduse_umem *umem;
> > > +       struct mutex mem_lock;
> > > +};
> > > +
> > >  struct vduse_vq_group_int {
> > >         struct vduse_dev *dev;
> >
> > I would expect this has an indirection for as. E.g unsigned int as;
> >
>
> This is a change from the previous commit and *dev is needed for
> taking the rwlock of the vq_group -> asid relation anyway, as function
> like vduse_dev_sync_single_for_cpu could run at the same time as
> VHOST_VDPA_SET_GROUP_ASID.
>
> I'm ok with adding the "unsigned int as" indirection but it involves
> memory walking that is not needed.

I think it should be fine unless we can notice it during the
benchmark. What's more we can refactor vduse as without caring much
about the group in the future.

>
> > >  };
> > > @@ -94,7 +100,7 @@ struct vduse_dev {
> > >         struct vduse_vdpa *vdev;
> > >         struct device *dev;
> > >         struct vduse_virtqueue **vqs;
> > > -       struct vduse_iova_domain *domain;
> > > +       struct vduse_as as;
> >
> > This needs to be an array per title:
> >
> > "vduse: create vduse_as to make it an array"
> >
>
> I meant "to make it an array in next patches". Would it work if I just
> change the patch subject to:
>
> "create vduse_as to contain per-as members"
>
> And then specify that it will be converted to an array later in the
> patch message? Or do you prefer me just to squash the patches?

I would prefer either:

1) make it an array in this patch
or
2) squash this patch into the next one

to avoid unnecessary changes.

>
> > >         char *name;
> > >         struct mutex lock;
> > >         spinlock_t msg_lock;
> > > @@ -122,9 +128,7 @@ struct vduse_dev {
> > >         u32 vq_num;
> > >         u32 vq_align;
> > >         u32 ngroups;
> > > -       struct vduse_umem *umem;
> > >         struct vduse_vq_group_int *groups;
> > > -       struct mutex mem_lock;
> > >         unsigned int bounce_size;
> > >         rwlock_t domain_lock;
> > >  };
> > > @@ -439,7 +443,7 @@ static __poll_t vduse_dev_poll(struct file *file,=
 poll_table *wait)
> > >  static void vduse_dev_reset(struct vduse_dev *dev)
> > >  {
> > >         int i;
> > > -       struct vduse_iova_domain *domain =3D dev->domain;
> > > +       struct vduse_iova_domain *domain =3D dev->as.domain;
> >
> > This should be an iteration of all address spaces?
> >
>
> Yes, it will be in next patches.
>
> The rest of the comments have the same reply actually, as this patch
> just prepares the struct to make it an array in patches as small as
> possible.

Right.

Thanks

