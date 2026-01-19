Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0C333F8A7
	for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 08:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768811669; cv=none; b=MkfdKh8xaUmbnEZeDT4pSItPLYYETij7lAziCwk2ooU9aLaeragXLt02Y8edA8GDHMKllip1pJZKbBYfJmpSmn0XAWKDC0CpuTYnGbkdJFmg3mZrx1FObCmdCZ2SsIutaGW0EO88M7aqqkYDpR795q7yb1G8YTROz7BIEkDRxdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768811669; c=relaxed/simple;
	bh=QIsLQCf3yaTWXao6arEjV8ikDuZvMxcsgDYOEFbsWBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=asZbvqoAglyoircBLiV3MMWqYf9U7DRbYlAyTKgpzOT3F3NMr3Ssv/J2MFxHJ5hB/NU3786z/UDpZtmfw5FyPM9/lpDmZhqzO/8en2HQmca0iOvlPUR2KcQtYT3agN/h6C+HAOnchCit8G6mMbfQDuUlGf/VSM2dF19h9H3/l5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fCZEAkql; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCZEAkql"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768811667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i4U+z6eEfyjVV6ul10oFSUf43cKF5xSi7Ry0R1sK+Qg=;
	b=fCZEAkqlpnYnESDTBjQp0EzftaHXqs/FfRl64Vhinquu3sEBQRJCown/X2NFB7obbEKg3p
	JtaRzBfARXAddXUhLwUcQAvezCotAZYiDfYLWSs4H17Q9yNob+klgyZr1DymzpfXXcpXfO
	C7AluEOvsMc9cInFzwAmNKynCkH7YVk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-tM9yXUczO9anrKgCu9w1sg-1; Mon, 19 Jan 2026 03:34:24 -0500
X-MC-Unique: tM9yXUczO9anrKgCu9w1sg-1
X-Mimecast-MFC-AGG-ID: tM9yXUczO9anrKgCu9w1sg_1768811663
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34c66cb671fso4214336a91.3
        for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 00:34:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768811663; x=1769416463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i4U+z6eEfyjVV6ul10oFSUf43cKF5xSi7Ry0R1sK+Qg=;
        b=fD9dqOo4VWAznnS4b2pKWbXiCaab9kfF/7N7ubJd3kchzFhqvIXZZIjExb5/3PZ4eT
         +okc8TSDYVMRiaq2h5tR6plNciyykZNgb0FrRxlLfzb+/3l2KPBJ+KV5kKceyrarDVQm
         gCyhH31qEgc3pKx3AvHyr63Xjl6KUrbLemNBHX8nZqrbOIB8XMZ7ZdEGvm+OmWxr5cPL
         QoI++YyeWF5mOo3mp9iv35IItTRNnNDFp17uGVtVrM/MEmbEybqMFvp5YnZ8+I2eIROZ
         9B8e4p0zkG0mskVo144h9nCl5lIbh8K5riImtrksROWM7IdJPpQIyFsvZMHUFs92fliC
         kh7g==
X-Forwarded-Encrypted: i=1; AJvYcCUUXzCwI08Spi4/epYRRc+DR8p7IOwQk4jyjAJAU6/rj1F+OUjrg5twXmC0l7fh1lUeDm42hEtpJKsT8xih+A==@lists.linux.dev
X-Gm-Message-State: AOJu0YygP/w+hmPXYGo8A+8vrjPMhJtls4mPEE5MNfV01N7pAzdlvqlB
	sxfYtvB8DJeXA2g/x7TXFLqU2JVnY3Dz8FEsyLgXvt0evgjBDlpy5l0RVjFmYT9XZN7QRwgFsPq
	WHxvpGsLfpqshER1WDe4XNCWlC7BXjsHgCgVNhhCgYsWlewLmROZP1XMivGIM0FDZu5G6XEzSSA
	1vTNzpgCN1SEqALJIMJkUiORY66C2CLBMCpj2DjlANgPE=
X-Gm-Gg: AZuq6aKL9Tow6NbdaGmi+hYvxC1eyuBem4kqo7xAXqoOyqJDI/Mwh51II6USRyLD7en
	wIFMHexS6wkQazpqFzdiob/VZKAxhqahVTHrqWpICiZqg7B7ThY9ICFaIn/CeFb5N41JlZYBr6X
	7Wq7wck0Ul0fnNe57BVVGchI9JWU6Ak2FeWf+f2XbtIW1IqFA5r43aJ3aRzMmv/nAXyP8=
X-Received: by 2002:a17:90b:3c89:b0:343:7714:4caa with SMTP id 98e67ed59e1d1-35272ebb8dcmr8875888a91.3.1768811663388;
        Mon, 19 Jan 2026 00:34:23 -0800 (PST)
X-Received: by 2002:a17:90b:3c89:b0:343:7714:4caa with SMTP id
 98e67ed59e1d1-35272ebb8dcmr8875869a91.3.1768811662999; Mon, 19 Jan 2026
 00:34:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260116140455.1560491-1-eperezma@redhat.com> <20260116140455.1560491-12-eperezma@redhat.com>
 <CACGkMEvJB5uyNnxmr=rap14Tc-JSy4=XGAtDZu6rg3+nucXUOw@mail.gmail.com> <CAJaqyWf_37cwV6mK-_nj4GnwquSxUYCPFKUOkxCaPQkJ9iewLQ@mail.gmail.com>
In-Reply-To: <CAJaqyWf_37cwV6mK-_nj4GnwquSxUYCPFKUOkxCaPQkJ9iewLQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 19 Jan 2026 16:34:11 +0800
X-Gm-Features: AZwV_QjHB8sga3BFcjykwBPok9D54PtTf3FOHlkEqERkj9qFlvlfVAzFsKsgNU4
Message-ID: <CACGkMEtyyPJQ3t_ckwZyNRHW2_fqm=09DEe-__Rvz0pQoUqtsQ@mail.gmail.com>
Subject: Re: [PATCH v14 11/13] vduse: add vq group asid support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Cindy Lu <lulu@redhat.com>, virtualization@lists.linux.dev, 
	Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nXw0zN7KPTJb9uru6GCpxoamiKVcUVqUhDOIbB6wJtY_1768811663
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 4:10=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Mon, Jan 19, 2026 at 8:17=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Fri, Jan 16, 2026 at 10:05=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@r=
edhat.com> wrote:
> > >
> > > Add support for assigning Address Space Identifiers (ASIDs) to each V=
Q
> > > group.  This enables mapping each group into a distinct memory space.
> > >
> > > The vq group to ASID association is protected by a rwlock now.  But t=
he
> > > mutex domain_lock keeps protecting the domains of all ASIDs, as some
> > > operations like the one related with the bounce buffer size still
> > > requires to lock all the ASIDs.
> > >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > >
> > > ---
> > > Future improvements can include performance optimizations on top like
> > > ore to RCU or thread synchronized atomics, or hardening by tracking A=
SID
> > > or ASID hashes on unused bits of the DMA address.
> > >
> > > Tested virtio_vdpa by adding manually two threads in vduse_set_status=
:
> > > one of them modifies the vq group 0 ASID and the other one map and un=
map
> > > memory continuously.  After a while, the two threads stop and the usu=
al
> > > work continues.  Test with version 0, version 1 with the old ioctl, a=
nd
> > > version 1 with the new ioctl.
> > >
> > > Tested with vhost_vdpa by migrating a VM while ping on OVS+VDUSE.  A =
few
> > > workaround were needed in some parts:
> > > * Do not enable CVQ before data vqs in QEMU, as VDUSE does not forwar=
d
> > >   the enable message to the userland device.  This will be solved in =
the
> > >   future.
> > > * Share the suspended state between all vhost devices in QEMU:
> > >   https://lists.nongnu.org/archive/html/qemu-devel/2025-11/msg02947.h=
tml
> > > * Implement a fake VDUSE suspend vdpa operation callback that always
> > >   returns true in the kernel.  DPDK suspend the device at the first
> > >   GET_VRING_BASE.
> > > * Remove the CVQ blocker in ASID.
> > >
> > > The driver vhost_vdpa was also tested with version 0, version 1 with =
the
> > > old ioctl, version 1 with the new ioctl but only one ASID, and versio=
n 1
> > > with many ASID.
> > >
> >
> > Looks good overall, but I spot a small issue:
> >
> > int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *domain=
,
> >                                        struct page **pages, int count)
> > {
> >         struct vduse_bounce_map *map, *head_map;
> >         ...
> >
> >         /* Now we don't support partial mapping */
> >         if (count !=3D (domain->bounce_size >> PAGE_SHIFT))
> >                 return -EINVAL;
> >
> > Here we still use domain->bounce_size even if we support multiple as,
> > this conflicts with the case without userspace memory.
> >
>
> I don't follow you. My understanding from the previous discussion is
> that the bounce size is distributed evenly per AS. Should we just have
> a global bounce buffer size and protect that the amount of added
> memory of all domains is less than that bounce size?

I meant we require bounce_size / nas to be the size of the bounce
buffer size of each AS.

But for userspace registered memory, it requires bounce_size per AS.

Thanks

>

