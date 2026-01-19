Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED0133987B
	for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 08:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768810221; cv=none; b=n+2itwXSyNrtbxWUruQSioE0jNwqEvhb8tmFa6RDqEQq7JoYL5u8TQ8b3BWIiqBa6gzknRRjfYmOqyEjzfxowNFgATd3ZwVhP91vJj/eEpCEz+G2AdKqSmhyfgEqpAzYnVJOCkRKvLb8vdEKKJnOFGpc0zZEuS4zUuNs83yoFyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768810221; c=relaxed/simple;
	bh=eSSfq6Rc1PeFehs3stDBcfGUjIge+zA6CVd2c65760U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QT2CdOuHjReBD0uviV8AJGN0k3xLsXSaeeo0TbZx4JhOmLvzxkIJfV3+tfm64T2s+uFSr3AhACqY9DedOtL/+xMotiyjQwBXY/xrLRSM1CDTDXL5x2rzRO7CBIkV4euMRD+yRGIlAvKQ3rM3PfnQYK5jhIQFpYcfF+a5J+Vfhh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GP4afcVH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GP4afcVH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768810219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NiFJD5PzgI7Rff884xgJnduEZD/g9NyAah8X9rySYIg=;
	b=GP4afcVH6oDMXlNYp63bV/E3RgoT0iLZpuoxyQ+uozLNUvYYAmy/qdIdPOaDriPeZZhMtY
	SfuKwLXB4y04eRCRSNT/5Rva4zQZTkY9RO1a+G9miAZTgg8LgGHjiwMRvs1Gfa5h3ftYOZ
	I03CcO0XaPEskvYznovLX0bNBlDhdPQ=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-EHFFsaa9O3-zYDzWFCSZGw-1; Mon, 19 Jan 2026 03:10:16 -0500
X-MC-Unique: EHFFsaa9O3-zYDzWFCSZGw-1
X-Mimecast-MFC-AGG-ID: EHFFsaa9O3-zYDzWFCSZGw_1768810215
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-78fc790162bso45086487b3.1
        for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 00:10:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768810215; x=1769415015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NiFJD5PzgI7Rff884xgJnduEZD/g9NyAah8X9rySYIg=;
        b=S4sWS75q1/IOJVi4qPOzwqQlPZj6DSvywtaDw4hTbyZI7m5Iej1jF1W98kQbo7024Y
         Qu7cRbojuaDbuqr7cBL1LmpnMmhD++mE8zOut9UYFSMbYfNtDmAan3RvjEa5bk/+pKO1
         TmO5RtL5RhLDDMvpuNBGTsERHDOtrGVv8EIx/OiB4whA46of6zZT6nPqbBI5ZtxjfthO
         rvZjoO/fHoGgxeGcx5hTlFY2D58fk4rGRF6d5JG1sGiDqLQ4GFFhUjbEtewmxsHLFiY8
         lS9Ex+cKdtJu75CuUfqS04r6bcqHQpTacVxTp3iIpUr41h5JTzYTFhBAq+nTYB1iLC93
         XL5w==
X-Forwarded-Encrypted: i=1; AJvYcCViWk+DtI4GAl3TYtmewVfZg/G6Sv7QcpwfSB+kZnU+xF3ZfPoBrI0VaQVz+BGr3Ehv5D0wklxOi/11u/aLPA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+MFT94PtbgW9gg9EJZ8sMERxOqXk9BlAoRpm47FyCckjuMf+1
	/DUb96ys17ePvanJwUr4kRNb93+AT5+d4GgwxMckn9+HQWE4n3CdCT7lgZhVuDbANiTlEkToDWl
	HiSuSiLwnGoKOKbgarVfUDoTD8fp7am/N9yD7HaXGi74rJlsLgvLmntFYgz5N2L6G/AstmlY1rV
	8dDJ+SbjvgRJP/xxa+RRXiM0k4mqqxg/Xm7Mh1oH85bco=
X-Gm-Gg: AZuq6aJqRqRGn24s//gBFejSUIJR3wxHJMyyNa+3dncq/l53opxm+c5H/nI3EQiALyK
	VxKEB/0LiDoNQW7o3Srhs8X64O4n5mlQz072J1G/NavBh7gm93gthYOaK2hMEzzAydqFU7Qjzfj
	7v1yAjrKGODDXlb/txdRSecedQqQCiqxPmXrefnguhTVmDJ6t+o8zZIP9hwFYtHNmCYQ==
X-Received: by 2002:a05:690c:9c0b:b0:793:b353:9dd7 with SMTP id 00721157ae682-793c683524bmr89785257b3.53.1768810215529;
        Mon, 19 Jan 2026 00:10:15 -0800 (PST)
X-Received: by 2002:a05:690c:9c0b:b0:793:b353:9dd7 with SMTP id
 00721157ae682-793c683524bmr89785047b3.53.1768810215113; Mon, 19 Jan 2026
 00:10:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260116140455.1560491-1-eperezma@redhat.com> <20260116140455.1560491-12-eperezma@redhat.com>
 <CACGkMEvJB5uyNnxmr=rap14Tc-JSy4=XGAtDZu6rg3+nucXUOw@mail.gmail.com>
In-Reply-To: <CACGkMEvJB5uyNnxmr=rap14Tc-JSy4=XGAtDZu6rg3+nucXUOw@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 19 Jan 2026 09:09:38 +0100
X-Gm-Features: AZwV_QgpEMyt61duS9J1Dtm3TxOILQEQM_kXZqRmG2nop8VeR5MDjHbqP31zz_Q
Message-ID: <CAJaqyWf_37cwV6mK-_nj4GnwquSxUYCPFKUOkxCaPQkJ9iewLQ@mail.gmail.com>
Subject: Re: [PATCH v14 11/13] vduse: add vq group asid support
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Cindy Lu <lulu@redhat.com>, virtualization@lists.linux.dev, 
	Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aoKAkCEbAZnUk_ACCcvTDU8VEY4j_QS-bIcRkorA4t8_1768810215
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 8:17=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, Jan 16, 2026 at 10:05=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@red=
hat.com> wrote:
> >
> > Add support for assigning Address Space Identifiers (ASIDs) to each VQ
> > group.  This enables mapping each group into a distinct memory space.
> >
> > The vq group to ASID association is protected by a rwlock now.  But the
> > mutex domain_lock keeps protecting the domains of all ASIDs, as some
> > operations like the one related with the bounce buffer size still
> > requires to lock all the ASIDs.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >
> > ---
> > Future improvements can include performance optimizations on top like
> > ore to RCU or thread synchronized atomics, or hardening by tracking ASI=
D
> > or ASID hashes on unused bits of the DMA address.
> >
> > Tested virtio_vdpa by adding manually two threads in vduse_set_status:
> > one of them modifies the vq group 0 ASID and the other one map and unma=
p
> > memory continuously.  After a while, the two threads stop and the usual
> > work continues.  Test with version 0, version 1 with the old ioctl, and
> > version 1 with the new ioctl.
> >
> > Tested with vhost_vdpa by migrating a VM while ping on OVS+VDUSE.  A fe=
w
> > workaround were needed in some parts:
> > * Do not enable CVQ before data vqs in QEMU, as VDUSE does not forward
> >   the enable message to the userland device.  This will be solved in th=
e
> >   future.
> > * Share the suspended state between all vhost devices in QEMU:
> >   https://lists.nongnu.org/archive/html/qemu-devel/2025-11/msg02947.htm=
l
> > * Implement a fake VDUSE suspend vdpa operation callback that always
> >   returns true in the kernel.  DPDK suspend the device at the first
> >   GET_VRING_BASE.
> > * Remove the CVQ blocker in ASID.
> >
> > The driver vhost_vdpa was also tested with version 0, version 1 with th=
e
> > old ioctl, version 1 with the new ioctl but only one ASID, and version =
1
> > with many ASID.
> >
>
> Looks good overall, but I spot a small issue:
>
> int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *domain,
>                                        struct page **pages, int count)
> {
>         struct vduse_bounce_map *map, *head_map;
>         ...
>
>         /* Now we don't support partial mapping */
>         if (count !=3D (domain->bounce_size >> PAGE_SHIFT))
>                 return -EINVAL;
>
> Here we still use domain->bounce_size even if we support multiple as,
> this conflicts with the case without userspace memory.
>

I don't follow you. My understanding from the previous discussion is
that the bounce size is distributed evenly per AS. Should we just have
a global bounce buffer size and protect that the amount of added
memory of all domains is less than that bounce size?

