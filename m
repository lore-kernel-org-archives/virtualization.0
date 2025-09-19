Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D54244693
	for <virtualization@lists.linux.dev>; Fri, 19 Sep 2025 02:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758248133; cv=none; b=uh+PjhFH/BAelhphLCuqNTvG7IexLg/fOUB3rzNfYnLq/Qpyuv4nyr07pfDaKlK5NeFm7pGJ7Wi2sSmEUcsWjuhyMC4QmgIemN+jSaZj+3KiNFEE4IEswU2yVeuYT8FRYr1+dw7JzJkjgijbXeqm4NGszJ7aT3VqUS0PTTWUlmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758248133; c=relaxed/simple;
	bh=16NKYgPcMTINaMZY744fmCRIxnMIIUCbOqQySGmcWGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EBinGNFXW4v32k85m9BsGxwzusPH6RBf27Birqb3L3kGYmxX86dOezA51BY8AHZwQzQdYgE4eXrsaR6mo+maDo2BXcI8tOGefhUBt+RqIjQAk4Q6uQeoMEBhryFr98+BnFhI6WYTVxJ/XL6Jb+QmIYQDZYxPlJLDJFn7ZVgJ+KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EUnmKQqe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EUnmKQqe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758248130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hon/WG0O/o4tQziEvEdouvMxGkU4PNeofyIC4EEXTHE=;
	b=EUnmKQqej49YE0KccjUj2JuA8QeZy6Cbp39KeScEnCDdfgQRcqBbthvIkjZuapl5urIxd2
	E0dfc5fCnpIlz6Ec0WSupLbr1nUar11DKyav1j9s8DQ0xSAbGxv3z5aDrHtl+gZy/zip/n
	3HYY+AmDauSei0qtMVvkexresfqu8H4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-WV2wIpg4O2Gouwq89U8FUQ-1; Thu, 18 Sep 2025 22:15:27 -0400
X-MC-Unique: WV2wIpg4O2Gouwq89U8FUQ-1
X-Mimecast-MFC-AGG-ID: WV2wIpg4O2Gouwq89U8FUQ_1758248126
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-323766e64d5so2164614a91.0
        for <virtualization@lists.linux.dev>; Thu, 18 Sep 2025 19:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758248126; x=1758852926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hon/WG0O/o4tQziEvEdouvMxGkU4PNeofyIC4EEXTHE=;
        b=a2KXkAWe4giTI4FUdzPPNTaiN0r8EaOKtXYIlDdfNq9s0G6kwrwlTaS17nfmdFKVue
         BfnEYWf513eIyuLq/mRnKahtO/wHvVQvokaQnn4iK6TfMwOZDgTGzOF73wJDsSSLcsQT
         3E3yoLQJl3YnzZnHHJZ+sQ8fVbPPh6gGurDksLqaKUp8ddNbCFPdw24FEQm+0+aNzrsk
         /D2WwayDQp0r1/O9uGWMPUxZnJLGbu1IeLsQZlbnsMHJMhDgCnY5sqPdzg384N6+QFXE
         ezmWABC8WrgxXpPptKXkH322jZCetd6f9H+C/w1novSMsC/tsYWaABKVyQg9Lm0G50do
         Cc9A==
X-Forwarded-Encrypted: i=1; AJvYcCV4lN05IVHIY4niOfkxbA+k1G+u8OVCPKn4hkMADuZM7JU+anDl4TxRVoWg8mfSnwnVBI4u/rD3qeni7bPp4A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHWuxVIjYhoSNGUFWFJ3KLUqfVMBCSmAqF/aAka5E1K1R2TYFZ
	9DdUW1IzfkWgh6P0OK9baIg7qHZEuHYg2EDUTIn3rHz2AzZWFphB/u4o/46+XFBRkv/fkrtx7ch
	8DRgdSEO0PylLY8UdCCJ6sJRiKjot/+TeeJ5wPz6G128EvDjGHa7IWT3ye8JMeDvd2Ihxhvqr0V
	0VXO00npRghyx9QtD5LDSdjYD4L8FIzQAzSxEFnW+wLsY=
X-Gm-Gg: ASbGncuIDbjxU6wrcp9nXNunr10rJiqhsDwpjuP7wXnei2Z0ppx0wCThu26eUgN2nDF
	gE64k8lRkj8euR5wQQ1R7DuKBKsNDZ888coSSt+X6XnnwWoamceThlILQzXrtMjxTt4hlGpprDr
	pYSee472tU0yt+6ZA4Cw==
X-Received: by 2002:a17:90b:3ec6:b0:32e:3592:581a with SMTP id 98e67ed59e1d1-33093d5630bmr2200622a91.17.1758248125856;
        Thu, 18 Sep 2025 19:15:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU3QigVP/CkFU0DUFTM5LxGNMjxHyqcwQHsW8IDna9AM7xjUdtB1ux6vI0hHWIZ2a8eLexcJHVSHpoHkdDW44=
X-Received: by 2002:a17:90b:3ec6:b0:32e:3592:581a with SMTP id
 98e67ed59e1d1-33093d5630bmr2200587a91.17.1758248125372; Thu, 18 Sep 2025
 19:15:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250916130833.329087-1-eperezma@redhat.com> <20250916130833.329087-7-eperezma@redhat.com>
 <CACGkMEu4F8Spw-=ve0w45CmJhEkBMtDdRCYNDorA6NxunkuDaw@mail.gmail.com>
 <CAJaqyWfqNX6E89Z4Yz373V6r1xLzJVNon5A_fCdU=79nAk6CRQ@mail.gmail.com>
 <CACGkMEurRDttMmrKzA8Wc4afBZi7T8wbLMfFS1wAEgabbVbAtA@mail.gmail.com> <CAJaqyWc725Ep6MJR8=7jJdqSnJs25X++qPx0tRfGOnQr=5H2yw@mail.gmail.com>
In-Reply-To: <CAJaqyWc725Ep6MJR8=7jJdqSnJs25X++qPx0tRfGOnQr=5H2yw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 19 Sep 2025 10:15:14 +0800
X-Gm-Features: AS18NWAYT-A4iOYLtH4jVpcpuIQrEeDENxE4N0RAkJxW5WeUNBPhrPNLezEW-8I
Message-ID: <CACGkMEsUXQEVZK52yEnD0rUumb4Sqeia=JGSjP0KnKX3=d0=1A@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] vduse: add vq group asid support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OZcgs1PMrRGcdHsLL_D9QUTp6c1gFK7A8kV1oNJmgEA_1758248126
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 2:58=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Thu, Sep 18, 2025 at 8:07=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Thu, Sep 18, 2025 at 12:41=E2=80=AFAM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Wed, Sep 17, 2025 at 10:56=E2=80=AFAM Jason Wang <jasowang@redhat.=
com> wrote:
> > > >
> > > > On Tue, Sep 16, 2025 at 9:09=E2=80=AFPM Eugenio P=C3=A9rez <eperezm=
a@redhat.com> wrote:
> > > > >
> > > > > Add support for assigning Address Space Identifiers (ASIDs) to ea=
ch VQ
> > > > > group.  This enables mapping each group into a distinct memory sp=
ace.
> > > > >
> > > > > Now that the driver can change ASID in the middle of operation, t=
he
> > > > > domain that each vq address point is also protected by domain_loc=
k.
> > > > >
> > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > ---
> > > > > v2:
> > > > > * Convert the use of mutex to rwlock.
> > > > >
> > > > > RFC v3:
> > > > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a=
 lower
> > > > >   value to reduce memory consumption, but vqs are already limited=
 to
> > > > >   that value and userspace VDUSE is able to allocate that many vq=
s.
> > > > > * Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl with
> > > > >   VDUSE_IOTLB_GET_INFO.
> > > > > * Use of array_index_nospec in VDUSE device ioctls.
> > > > > * Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
> > > > > * Move the umem mutex to asid struct so there is no contention be=
tween
> > > > >   ASIDs.
> > > > >
> > > > > RFC v2:
> > > > > * Make iotlb entry the last one of vduse_iotlb_entry_v2 so the fi=
rst
> > > > >   part of the struct is the same.
> > > > > ---
> > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 324 +++++++++++++++++++++--=
------
> > > > >  include/uapi/linux/vduse.h         |  51 ++++-
> > > > >  2 files changed, 284 insertions(+), 91 deletions(-)
> > > > >
> > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vd=
pa_user/vduse_dev.c
> > > > > index b45b1d22784f..06b7790380b7 100644
> > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > @@ -93,6 +93,7 @@ struct vduse_as {
> > > > >  };
> > > > >
> > > > >  struct vduse_vq_group_int {
> > > > > +       struct vduse_iova_domain *domain;
> > > > >         struct vduse_dev *dev;
> > > >
> > > > This confuses me, I think it should be an asid. And the vduse_dev
> > > > pointer seems to be useless here.
> > > >
> > >
> > > The *dev pointer is used to take the rwlock, in case the vhost driver
> > > calls VHOST_VDPA_SET_GROUP_ASID (or equivalent) at the same time
> > > vduse_dev_sync_single_for_device (or _for_cpu, or equivalent) run.
> >
> > Ok, but having it in a group seems odd. A better place is to move it to=
 the as?
> >
>
> If we move to the as, we need to take the lock this way:
>
> read_lock(vduse_vq_group->as->dev->domain_lock)
>
> But the lock is protecting the vduse_vq_group->as change itself, as
> other ioctls (SET_GROUP_ASID mainly) can modify it concurrently.
>
> We can assume that *as will always point to a valid as, its change
> will be atomic, and all the as->dev points to the exact same
> vduse_dev. I can buy that, but it is a race anyway.
>

I see, let's keep the struct vduse_dev *dev pointer as is.

Thanks

