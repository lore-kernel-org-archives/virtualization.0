Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817D3314B6A
	for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 12:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768825536; cv=none; b=KNysohlOUBGxZJpa85r9RlZdo8JWFIM2b3m87KHbmi7U3AsXCNPlygfv88LV1RBuS2410FxSWAkDVbp5gSDYb4yuNq71lHR/tbj51MUYcdcG+diDHRACn6596FP6Fa6YhlqjM6FzjAw8AUEtNKk/GbBpwLKzKQeIjJYi1+UMwHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768825536; c=relaxed/simple;
	bh=x2tya32T5ud6Njv8S5CvYJAn12K/oL7vj+wbyqjPawk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KkjSCoiFMytb00qq2XI9b6JJ8jZMZnVV+cr5CN25x+88DzF70IpI16V8tmmBb6JQ7ythYIqFWNcuykCMWzvvM2wCNr6gmnirzGkrUdcJy5cPJqUqeVD/5MCktSU/Jy2vkJj0OulSS9jMvlfjpSx23VkqHNLRpukWSq80GCS/R8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R2MtugTz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R2MtugTz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768825533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rSw7y3upc4AgVNmsptTH129octiJTx3PmTd4wjgwavo=;
	b=R2MtugTzYIV1CP/DG9OD8jI3DP+HUq5Iyg6+C7lpEnMhqTmM6Ls7K41vRw4B0v3M6QVuex
	+bsAJm+8xXZH7XZ7AWVOZ5mVA2QwfJOeRcemQmlSrHHpP/vLaEjLLJk+Hj8pqip2aGW2y9
	Bhw1uxickVWv86x97mCi9TDQ22SmbWI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-S1F_zHZgPG-OtRBthNoJPQ-1; Mon, 19 Jan 2026 07:25:32 -0500
X-MC-Unique: S1F_zHZgPG-OtRBthNoJPQ-1
X-Mimecast-MFC-AGG-ID: S1F_zHZgPG-OtRBthNoJPQ_1768825531
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34c43f8ef9bso5032943a91.1
        for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 04:25:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768825531; x=1769430331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rSw7y3upc4AgVNmsptTH129octiJTx3PmTd4wjgwavo=;
        b=m7GFFa/Yu6u80uJIuYFCaxk9uGTnxyWCx0357msodsGd/MQO7165m4OUwnXP71zHp8
         Hank36sK2Qn+FtCrmAdMq5KSUuyoEoveR7gMwsrr8s4gJgO8PaI/dlTt3+IpRVJEZSxo
         mnPf48ba10zFj0QWJmyNsHrvF3bxOAwMwcSx/6IWkerT4Xw32t0VySydarv/5yT79ZAc
         rj14Ah0/QPvSNbHJM2qT1R+VKo6OHEHrEtKEsyxs6rLS4CWRM9/h/CFpzti8FRC7x6G6
         2bVGbIGdeZeQXcN7hc0asSUdQaV6xgbzf6u5vAxzoZLaR4bH1jmAJVu0Vw6Dj7FRUynV
         8LYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDtwFv52Qfu1iAxxLjJx2vVdWs9AlYSzfKISdQ7EXFh50p3bWnj89gBf+7eMrqmOqMPz/+YvUDrWLPCXf4cg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw500Eck+afyy7+XO4CxaVPbDJSU8MN1myKxGgI+hzWTUBziyLq
	wrLf51A3uv2zgrFOSJaD8byp6fpR3xYN5TK+riuxyUvs1NQ3eo/BvdGiIsyvm3HnrgxBGNZ3lzg
	hEKgBCLUTbRgA77sT+/O4JpLdrUIuf6CjUda58ahd0bEttH2dLYM7WU6f185C9ZnSD8X+hD2pzl
	YA/BEL9UfQD62Fyib6BvborHDZADC1Vk30dfI/3mk5CsU=
X-Gm-Gg: AZuq6aK7l7o5zceMb2IZpgV4CEhfLQTFswwAxe5uB6h0jxsk2uRYHAuPJjWwpFtDLG9
	l7abXh3F3dVh9XYNXXbgF0wsL9iZ4PyeQ56lZfSx+Ct4h9sorCvvwkyz863wsD2hTIho8ycHPiu
	CleMzlMAJq0xyqdg2RCfHpwkxdkKSJ2SNjFiYjrtWazJda71M9/58/9zg4OiCJbKj0hw==
X-Received: by 2002:a17:90b:2b86:b0:34c:9cec:3898 with SMTP id 98e67ed59e1d1-352678d9b78mr11715679a91.13.1768825531006;
        Mon, 19 Jan 2026 04:25:31 -0800 (PST)
X-Received: by 2002:a17:90b:2b86:b0:34c:9cec:3898 with SMTP id
 98e67ed59e1d1-352678d9b78mr11715658a91.13.1768825530355; Mon, 19 Jan 2026
 04:25:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260116140455.1560491-1-eperezma@redhat.com> <20260116140455.1560491-12-eperezma@redhat.com>
 <CACGkMEvJB5uyNnxmr=rap14Tc-JSy4=XGAtDZu6rg3+nucXUOw@mail.gmail.com>
 <CAJaqyWf_37cwV6mK-_nj4GnwquSxUYCPFKUOkxCaPQkJ9iewLQ@mail.gmail.com>
 <CACGkMEtyyPJQ3t_ckwZyNRHW2_fqm=09DEe-__Rvz0pQoUqtsQ@mail.gmail.com> <CAJaqyWc6OQs9GP=CjSU1B1hU1K8yArzivo6aK3A7aTQ33Fjq6w@mail.gmail.com>
In-Reply-To: <CAJaqyWc6OQs9GP=CjSU1B1hU1K8yArzivo6aK3A7aTQ33Fjq6w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 19 Jan 2026 20:25:18 +0800
X-Gm-Features: AZwV_QiY9fo3rL3XYC2y9nsDkpI3UknKJo-O3GURjcze1lGKw6IShVU486kZWpU
Message-ID: <CACGkMEv_=U_xa=EyQDchGWHpPU7w=-m1Ag0N7RKLo+YtNWDL3A@mail.gmail.com>
Subject: Re: [PATCH v14 11/13] vduse: add vq group asid support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Cindy Lu <lulu@redhat.com>, virtualization@lists.linux.dev, 
	Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jWJ9SwGVJlRr5wMp8VfHSGuEQCQfd29lW7XWd9nRpjo_1768825531
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 6:29=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Mon, Jan 19, 2026 at 9:34=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Mon, Jan 19, 2026 at 4:10=E2=80=AFPM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Mon, Jan 19, 2026 at 8:17=E2=80=AFAM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Fri, Jan 16, 2026 at 10:05=E2=80=AFPM Eugenio P=C3=A9rez <eperez=
ma@redhat.com> wrote:
> > > > >
> > > > > Add support for assigning Address Space Identifiers (ASIDs) to ea=
ch VQ
> > > > > group.  This enables mapping each group into a distinct memory sp=
ace.
> > > > >
> > > > > The vq group to ASID association is protected by a rwlock now.  B=
ut the
> > > > > mutex domain_lock keeps protecting the domains of all ASIDs, as s=
ome
> > > > > operations like the one related with the bounce buffer size still
> > > > > requires to lock all the ASIDs.
> > > > >
> > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > >
> > > > > ---
> > > > > Future improvements can include performance optimizations on top =
like
> > > > > ore to RCU or thread synchronized atomics, or hardening by tracki=
ng ASID
> > > > > or ASID hashes on unused bits of the DMA address.
> > > > >
> > > > > Tested virtio_vdpa by adding manually two threads in vduse_set_st=
atus:
> > > > > one of them modifies the vq group 0 ASID and the other one map an=
d unmap
> > > > > memory continuously.  After a while, the two threads stop and the=
 usual
> > > > > work continues.  Test with version 0, version 1 with the old ioct=
l, and
> > > > > version 1 with the new ioctl.
> > > > >
> > > > > Tested with vhost_vdpa by migrating a VM while ping on OVS+VDUSE.=
  A few
> > > > > workaround were needed in some parts:
> > > > > * Do not enable CVQ before data vqs in QEMU, as VDUSE does not fo=
rward
> > > > >   the enable message to the userland device.  This will be solved=
 in the
> > > > >   future.
> > > > > * Share the suspended state between all vhost devices in QEMU:
> > > > >   https://lists.nongnu.org/archive/html/qemu-devel/2025-11/msg029=
47.html
> > > > > * Implement a fake VDUSE suspend vdpa operation callback that alw=
ays
> > > > >   returns true in the kernel.  DPDK suspend the device at the fir=
st
> > > > >   GET_VRING_BASE.
> > > > > * Remove the CVQ blocker in ASID.
> > > > >
> > > > > The driver vhost_vdpa was also tested with version 0, version 1 w=
ith the
> > > > > old ioctl, version 1 with the new ioctl but only one ASID, and ve=
rsion 1
> > > > > with many ASID.
> > > > >
> > > >
> > > > Looks good overall, but I spot a small issue:
> > > >
> > > > int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *do=
main,
> > > >                                        struct page **pages, int cou=
nt)
> > > > {
> > > >         struct vduse_bounce_map *map, *head_map;
> > > >         ...
> > > >
> > > >         /* Now we don't support partial mapping */
> > > >         if (count !=3D (domain->bounce_size >> PAGE_SHIFT))
> > > >                 return -EINVAL;
> > > >
> > > > Here we still use domain->bounce_size even if we support multiple a=
s,
> > > > this conflicts with the case without userspace memory.
> > > >
> > >
> > > I don't follow you. My understanding from the previous discussion is
> > > that the bounce size is distributed evenly per AS. Should we just hav=
e
> > > a global bounce buffer size and protect that the amount of added
> > > memory of all domains is less than that bounce size?
> >
> > I meant we require bounce_size / nas to be the size of the bounce
> > buffer size of each AS.
> >
> > But for userspace registered memory, it requires bounce_size per AS.
> >
>
> I still don't follow you, sorry :(.
>
> Can you explain in terms of "Previously, the VDUSE userspace could
> perform XXX ioctl and YYY action and now it is impossible", or "I
> expect future VDUSE applications to be able to do XXX action through
> YYY but it is not possible to do in the current series".
>
> I think we have three options for bounce_size regarding ASID:
> 1) We make all of the AS respect a total bounce size, like the firsts
> iterations of the series, and then we need total sync between them in
> calls like this. The userland application can only allocate user
> bounce pages in one AS with this code. I can modify it but it still
> requires synchronization across all domains.
> 2) We distribute the bounce pages evenly between AS,
> as the current
> version. As discussed, it may be a waste for CVQ for example but it
> seems reasonable to just not add user pages to CVQ and just bounce it
> in the kernel. Management can just expand the total size and live with
> it [1].
> 3) We expand the /sys attributes so the userland can specify bounce
> sizes per AS. I think we agreed it is overkill, and honestly I'd leave
> that for future improvements on top if we find we actually need it.
>
> [1] https://lore.kernel.org/lkml/CACGkMEsZiX-M-PNGX8W7GprBJmiGi9Gz1=3DayE=
=3DiMaP3WO3vr2Q@mail.gmail.com/

Apologize, I misread the code. I think the code is fine.

So

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

