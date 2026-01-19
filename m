Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098231A3172
	for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 10:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768818591; cv=none; b=nfwCmMgDe9fL+ha0RfSsHhwiGIOLUCA++7VqQLTkiIn1pwNisIKqzRCNz2THkSGJHE1Qj6NdY7SsbL3N2Fqyze4+GMknYyH24eznbwjKkgaM9szfBL9179jjoagHft9TEhjCJw0I8a4Rrvru0XnDTm649Wfu5XwNZ9ozJ/GJefI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768818591; c=relaxed/simple;
	bh=Z6XfI9FOPPcFM29gf1tqly748orVR9FG0LPBTmo8RRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VD3SYc+/tw9XuwfSXvH6lyKIgz8gUlg9STqBHyNtGPsWDoJZrqnHepIl9W2Y+DIyeOFSqAEUOSw9ndtLdFVkgjFcF4FBM1TLncl4boWl2GNokpR7mOofK097uVyC/Iy7u8hMFeO0k+/wMoEGR88GIEj6853DO1GCIDk2jKUpFu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IG/AEsWh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IG/AEsWh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768818588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ajes01Yq83jgP8fFStZIQyRqCQYuRrjDmY2+wlbovpM=;
	b=IG/AEsWh74sM6lHHOGNvCCipNuPdclI18py/4Scv0GDyaMhQoiEEBRc6dZEVGja5zFptMG
	CSQ5Ys0hV4uc0xTOfJ0YiLSBlCplcKskSdnzkEiOVF0JCfwZ9EO6DJZ8Xu+QeAGvRLQle1
	3a29GGipmx46NRFkpoYd4Dej0chGyiU=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-q0fgM576O5-4rMNRnOdvEw-1; Mon, 19 Jan 2026 05:29:46 -0500
X-MC-Unique: q0fgM576O5-4rMNRnOdvEw-1
X-Mimecast-MFC-AGG-ID: q0fgM576O5-4rMNRnOdvEw_1768818586
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-792738a717fso48471617b3.1
        for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 02:29:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768818586; x=1769423386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ajes01Yq83jgP8fFStZIQyRqCQYuRrjDmY2+wlbovpM=;
        b=pOHOC6y/GxLVqirfqq2TH3AimyPGqrl4hmDrLfIbAD9o1H+EWRux0xwE+jzzuL2nUY
         KC7o8SYtdeZUInOtgzQ9qnNdH3FUCmArY4jN7EuGtX9h/ACcdRvezhGa0gBazX8XOTQ8
         O7YqYJzuyS6IxNkowGILH/fjO1lyipm8bIYaJs0r5ca7ubxPGdfOkaYCDbZoQzSdFacw
         GJ0jQlfsxZnTm7rGaqMccbFtG4dZFfpxgmzmPvqsyZoXMVgLRb8uBWZMOqLy14NKd17m
         eCAs6vfTsbpX3joSHtEJdJ3NqiIieMbRr1HDnxbHLU6XMWVDu2iG1yN8yudXORpIcFRv
         psaw==
X-Forwarded-Encrypted: i=1; AJvYcCUewTtHDwDgJYekhSwDfxbL//HgjTd++wVioZPjQZsyajjPm+MSCGwoV2Pb9zdJxiu/CH6Ltu01naQPOu6Wmw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxWF7wC5TG+RrVb88zCGGnlClSyEB1VkRmyQ4Rc/FoNJLi/0izs
	xi0F05tQdAVlVkHOiGAJ6BYiFd4U3MvWqhQA6EdW21KKdS+Lh+5oHYW7qHZzDZyzR3K0tV8Crh6
	x/m9cISOyMq3NBvBddt1yyAa60P+7PVvb68nma7Svol6KAol12jmnH6hEUAivH0lH7DPzVHn8yL
	5XpD/KUZ1XMGDjq9gngvCGskTf276fXJVLHhLk+ZyLofQ=
X-Gm-Gg: AZuq6aJ/vP4HSDd0uUPpiAtxgM0zOSSASja9HmULzcJu0hqeJPRs4pYz78k65vN1atl
	qBgVguy29P6aEOeSvKy2MOtnoN4Pzop8YW2xq4S7gzkIlDVPKnep/PlnPI5YIRwq5z67LDIHviX
	gp7CjHvxRP+enSFtJCabKYr7XhYeGJ+dPH0UKbIzrikTPCt5N+LTOjs8JeXwVHWOxE6g==
X-Received: by 2002:a05:690c:60c7:b0:78f:c2f3:141 with SMTP id 00721157ae682-793c544d6c3mr93161527b3.35.1768818586294;
        Mon, 19 Jan 2026 02:29:46 -0800 (PST)
X-Received: by 2002:a05:690c:60c7:b0:78f:c2f3:141 with SMTP id
 00721157ae682-793c544d6c3mr93161307b3.35.1768818585911; Mon, 19 Jan 2026
 02:29:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260116140455.1560491-1-eperezma@redhat.com> <20260116140455.1560491-12-eperezma@redhat.com>
 <CACGkMEvJB5uyNnxmr=rap14Tc-JSy4=XGAtDZu6rg3+nucXUOw@mail.gmail.com>
 <CAJaqyWf_37cwV6mK-_nj4GnwquSxUYCPFKUOkxCaPQkJ9iewLQ@mail.gmail.com> <CACGkMEtyyPJQ3t_ckwZyNRHW2_fqm=09DEe-__Rvz0pQoUqtsQ@mail.gmail.com>
In-Reply-To: <CACGkMEtyyPJQ3t_ckwZyNRHW2_fqm=09DEe-__Rvz0pQoUqtsQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 19 Jan 2026 11:29:09 +0100
X-Gm-Features: AZwV_Qjhe8a58Jifqm8SbUozk8eG3UbtPpWhCybJYjJdo4gTHn8X8a3UJCV2Clc
Message-ID: <CAJaqyWc6OQs9GP=CjSU1B1hU1K8yArzivo6aK3A7aTQ33Fjq6w@mail.gmail.com>
Subject: Re: [PATCH v14 11/13] vduse: add vq group asid support
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Cindy Lu <lulu@redhat.com>, virtualization@lists.linux.dev, 
	Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kMFkiPTGo_9UUwa4WRVfpD37Dx89G4xiyNCjnJgcMzI_1768818586
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 9:34=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Mon, Jan 19, 2026 at 4:10=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Mon, Jan 19, 2026 at 8:17=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Fri, Jan 16, 2026 at 10:05=E2=80=AFPM Eugenio P=C3=A9rez <eperezma=
@redhat.com> wrote:
> > > >
> > > > Add support for assigning Address Space Identifiers (ASIDs) to each=
 VQ
> > > > group.  This enables mapping each group into a distinct memory spac=
e.
> > > >
> > > > The vq group to ASID association is protected by a rwlock now.  But=
 the
> > > > mutex domain_lock keeps protecting the domains of all ASIDs, as som=
e
> > > > operations like the one related with the bounce buffer size still
> > > > requires to lock all the ASIDs.
> > > >
> > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > >
> > > > ---
> > > > Future improvements can include performance optimizations on top li=
ke
> > > > ore to RCU or thread synchronized atomics, or hardening by tracking=
 ASID
> > > > or ASID hashes on unused bits of the DMA address.
> > > >
> > > > Tested virtio_vdpa by adding manually two threads in vduse_set_stat=
us:
> > > > one of them modifies the vq group 0 ASID and the other one map and =
unmap
> > > > memory continuously.  After a while, the two threads stop and the u=
sual
> > > > work continues.  Test with version 0, version 1 with the old ioctl,=
 and
> > > > version 1 with the new ioctl.
> > > >
> > > > Tested with vhost_vdpa by migrating a VM while ping on OVS+VDUSE.  =
A few
> > > > workaround were needed in some parts:
> > > > * Do not enable CVQ before data vqs in QEMU, as VDUSE does not forw=
ard
> > > >   the enable message to the userland device.  This will be solved i=
n the
> > > >   future.
> > > > * Share the suspended state between all vhost devices in QEMU:
> > > >   https://lists.nongnu.org/archive/html/qemu-devel/2025-11/msg02947=
.html
> > > > * Implement a fake VDUSE suspend vdpa operation callback that alway=
s
> > > >   returns true in the kernel.  DPDK suspend the device at the first
> > > >   GET_VRING_BASE.
> > > > * Remove the CVQ blocker in ASID.
> > > >
> > > > The driver vhost_vdpa was also tested with version 0, version 1 wit=
h the
> > > > old ioctl, version 1 with the new ioctl but only one ASID, and vers=
ion 1
> > > > with many ASID.
> > > >
> > >
> > > Looks good overall, but I spot a small issue:
> > >
> > > int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *doma=
in,
> > >                                        struct page **pages, int count=
)
> > > {
> > >         struct vduse_bounce_map *map, *head_map;
> > >         ...
> > >
> > >         /* Now we don't support partial mapping */
> > >         if (count !=3D (domain->bounce_size >> PAGE_SHIFT))
> > >                 return -EINVAL;
> > >
> > > Here we still use domain->bounce_size even if we support multiple as,
> > > this conflicts with the case without userspace memory.
> > >
> >
> > I don't follow you. My understanding from the previous discussion is
> > that the bounce size is distributed evenly per AS. Should we just have
> > a global bounce buffer size and protect that the amount of added
> > memory of all domains is less than that bounce size?
>
> I meant we require bounce_size / nas to be the size of the bounce
> buffer size of each AS.
>
> But for userspace registered memory, it requires bounce_size per AS.
>

I still don't follow you, sorry :(.

Can you explain in terms of "Previously, the VDUSE userspace could
perform XXX ioctl and YYY action and now it is impossible", or "I
expect future VDUSE applications to be able to do XXX action through
YYY but it is not possible to do in the current series".

I think we have three options for bounce_size regarding ASID:
1) We make all of the AS respect a total bounce size, like the firsts
iterations of the series, and then we need total sync between them in
calls like this. The userland application can only allocate user
bounce pages in one AS with this code. I can modify it but it still
requires synchronization across all domains.
2) We distribute the bounce pages evenly between AS, as the current
version. As discussed, it may be a waste for CVQ for example but it
seems reasonable to just not add user pages to CVQ and just bounce it
in the kernel. Management can just expand the total size and live with
it [1].
3) We expand the /sys attributes so the userland can specify bounce
sizes per AS. I think we agreed it is overkill, and honestly I'd leave
that for future improvements on top if we find we actually need it.

[1] https://lore.kernel.org/lkml/CACGkMEsZiX-M-PNGX8W7GprBJmiGi9Gz1=3DayE=
=3DiMaP3WO3vr2Q@mail.gmail.com/

