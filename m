Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB652EC0A7
	for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 05:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111871; cv=none; b=W9NmZ2FdujGbg/OYrXYM/fgsccaeUgTvr9rhcZbTg0AGoZxuehH/P32fCLdSJSH9pbzysb7XQaiPrIoIZsUKZ3v60KIU4BiJVVvtqEKHCph7mU03MK9mHUYquHtb3AhclvdI8bPQqRZa7ENwDpVPafn/vRRROkN3JaKVjO1bAdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111871; c=relaxed/simple;
	bh=jmByzIvyAMZeLV+wtG8rPMReTA4JZzhcWHtX39WBB6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MaUEfves4jjHAnylc3MELl41JkyEQmo5FKiKg8nyHDfu2wU2MW4kMdLvqyPi9W//DbStg1gY6IphTO6Fx+2TWmGbKeYeCYvI0jnwNTFrzMz2moQ8OxCGOWUIH5rWLr5sMr1mB+f47oy54DNePlNdZWwxAs82/H/BTpysz3zqk34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UwylesEr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UwylesEr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761111868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v6cdA2aJ7ieWhAWAgXBTiUs2hf+dl3MLq/XdzHHs4TM=;
	b=UwylesErsLixPy6CZIIRWIhSJZz0zVSDEe0Xe/SKNXoNrj8b0a9g9nsMSVIw5ZYWlhKPjn
	HQ8zhNaeg+X7Byr3eSfdKwEGwzBmAthOWx6/kyS7j2OTvVWDIqtavqCGa9R8wq8LYPdkcx
	62etXgVGmv3RzxYk2MPqty/sF63bUBI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-FeXeo4kpM42g7C0fOKk-DQ-1; Wed, 22 Oct 2025 01:44:27 -0400
X-MC-Unique: FeXeo4kpM42g7C0fOKk-DQ-1
X-Mimecast-MFC-AGG-ID: FeXeo4kpM42g7C0fOKk-DQ_1761111866
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-475c422fd70so3651805e9.2
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 22:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761111866; x=1761716666;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v6cdA2aJ7ieWhAWAgXBTiUs2hf+dl3MLq/XdzHHs4TM=;
        b=va0Eh0waOmJCSwlYA47a/vTaow+HT9diSWzdHY7n4a1CIuaId0qqLCwqOaQjUGUSOC
         Pmpammr5fDHjwakpanBBpuUpJ5N/HrnkGP6eHecR5uSiy7jrQ+UTEAKafR+MG3Id6uVN
         WDzZh8HQc6XQOFkP7XIlssvyBcBN8Cs+4TO3ZQyCCJdjhgBLFSWVJKJUHNKjkyXMsiDt
         f+tRwMTLqpEUNfTpSJ7/KbWw8DCfA7nl5Y3FEqUqfjaKWvYkQqR/LWbtmkQsfw6ayft0
         OS3xmfAGXV0HErWHSk1zxWScUD5k8n11BSGekB25CrPsQ9J8b5nFiaY/viK7AmMjMdP2
         yK2A==
X-Forwarded-Encrypted: i=1; AJvYcCWqV4HIPvQEDg7lX5VYQRDGYVnaZEpFxsmyhigntPgzRzZWVN9FPSxiLbqpbZm4Yh1jSSDOHcvgU20AsYDcQQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWqtToGvc6D+5n4DjGRX96DjBhAycm78pE96oY64OZ3s2Nv1HX
	MtrpmykaEFZX2Mp2gHuFKRpAHL9BvNsJ9VEAxM+JReAGlJkXohLSx2d+AnymXguKnQdA2jP3m2C
	PDuL0pIZzvPfyj91W3l9WjU8dJEP6LvibNQOmqazE7LbkoBEcXTmbMrZUka5TvqjBl8jUFw6C8l
	ie
X-Gm-Gg: ASbGncu0BY9F/7gpH+n4Jo+rpiZdpSsk7p2wTFg/TVbmy3HqEPOAvFXfjSYTuCAhe2U
	Wkfln5NML4Vdesay8zcIeDNHvJHO/3HFb3Mhoj1G9KZJdozRs7jimBqc/1uUOkOB7lbXlQeIAqo
	+kPsJW1xXHMc3SEg/hhQDpmPOmrnBlpncj+aFeYBAD8sBAkczQrhwsKp1+7ndZ8o7T0s3pNl9rA
	5DI2oAyuPFrO12rWGbFJQmt8dLW0qN0i+JjKqijQy6Th/FjIfXNHbOLdqQUIRWvzazEwnwFb3m8
	/yr0O5m6UesbyD7fInls8/SS9H2cNw+C7gx2Jqj091Q6DSaBR/bia07mKUnjIUBkRxtc
X-Received: by 2002:a05:600c:681b:b0:45f:2ed1:d1c5 with SMTP id 5b1f17b1804b1-47117925e39mr149599215e9.36.1761111866094;
        Tue, 21 Oct 2025 22:44:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBq1miswWQ2JCO8xHuPt/netB6Eb5sGpcEeZAGKbvglwUn+sN/OhElR3T7xQtx3Z99OyygIA==
X-Received: by 2002:a05:600c:681b:b0:45f:2ed1:d1c5 with SMTP id 5b1f17b1804b1-47117925e39mr149599085e9.36.1761111865601;
        Tue, 21 Oct 2025 22:44:25 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c428dafesm25481835e9.6.2025.10.21.22.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 22:44:25 -0700 (PDT)
Date: Wed, 22 Oct 2025 01:44:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 18/19] virtio_ring: factor out split detaching logic
Message-ID: <20251022014109-mutt-send-email-mst@kernel.org>
References: <20251020071003.28834-1-jasowang@redhat.com>
 <20251020071003.28834-19-jasowang@redhat.com>
 <20251020111413-mutt-send-email-mst@kernel.org>
 <CACGkMEsRmkaBiU2WCQTepayhrhR18M1+bDQJXxTVxOUDG4sZyg@mail.gmail.com>
 <20251021042325-mutt-send-email-mst@kernel.org>
 <CACGkMEskSf-mLZPaSYxkACu1z_hH_jXTKawzW1yZwZZOnSAFAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEskSf-mLZPaSYxkACu1z_hH_jXTKawzW1yZwZZOnSAFAg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NTRBQ9GdMfafjWGevb8zShJszT5wQ406nyQDXy7xIZc_1761111866
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Oct 22, 2025 at 12:00:53PM +0800, Jason Wang wrote:
> On Tue, Oct 21, 2025 at 4:27 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Oct 21, 2025 at 11:36:12AM +0800, Jason Wang wrote:
> > > On Mon, Oct 20, 2025 at 11:18 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, Oct 20, 2025 at 03:10:02PM +0800, Jason Wang wrote:
> > > > > This patch factors out the split core detaching logic that could be
> > > > > reused by in order feature into a dedicated function.
> > > > >
> > > > > Acked-by: Eugenio Pérez <eperezma@redhat.com>
> > > > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > ---
> > > > >  drivers/virtio/virtio_ring.c | 18 ++++++++++++++----
> > > > >  1 file changed, 14 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > index 0f07a6637acb..96d7f165ec88 100644
> > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > @@ -802,8 +802,9 @@ static void detach_indirect_split(struct vring_virtqueue *vq,
> > > > >       vq->split.desc_state[head].indir_desc = NULL;
> > > > >  }
> > > > >
> > > > > -static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> > > > > -                          void **ctx)
> > > > > +static unsigned detach_buf_split_in_order(struct vring_virtqueue *vq,
> > > > > +                                       unsigned int head,
> > > > > +                                       void **ctx)
> > > >
> > > >
> > > > Well not really _inorder, right? This is a common function.
> > >
> > > Yes, but inorder is a subset for ooo so I use this name.
> >
> > Can't say it is consistent. I suggest for example:
> >         _in_order -> specific to in order
> >         _ooo -> specific to ooo
> >         no suffix - common
> >
> > or some other scheme where it's clear which is which.
> 
> Will do that.
> 
> >
> >
> >
> > > > You want to call it __detach_buf_split or something maybe.
> > > >
> > > > Additionally the very first line in there is:
> > > >
> > > >         __virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
> > > >
> > > > and the byte swap is not needed for inorder.
> > >
> > > I don't see why?
> >
> > To be more precise we do need a swap we do not need it
> > conditional.
> >
> >
> > No, I mean inorder is a modern only feature. So we do not
> > need a branch in the inorder path,
> > you can use __cpu_to_virtio16 with true flag,
> > not cpu_to_virtio16.
> 
> The problem is that the core logic will be reused by the ooo as well.
> I'm not sure it's worthwhile to introduce a new flag parameter for the
> logic like:
> 
> detach_buf_split_in_order()
> {
>         __virtio16 nextflag = __cpu_to_virtio16(true, VRING_DESC_F_NEXT);
>         detach_buf_split(..., nextflag);
> }
> 
> ?

If it's common code then no.


> >
> > > > you could just do __cpu_to_virtio16(true, VRING_DESC_F_NEXT)
> > >
> > > Probably you mean a leftover for hardening? E.g should we check
> > > desc_extra.flag instead of desc.flag here?
> > >
> > > while (vq->split.vring.desc[i].flags & nextflag) {
> > >                 vring_unmap_one_split(vq, &extra[i]);
> > >         i = vq->split.desc_extra[i].next;
> > >                 vq->vq.num_free++;
> > >         }
> > >
> > > Thanks
> >
> > If it is not exploitable we do not care.
> 
> It looks like it can be triggered by the device as the descriptor ring
> is writable. Will post a fix.
> 
> Thanks

question is if the guest is exploitable as a result.

> >
> > --
> > MST
> >
> >

