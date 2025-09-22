Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACDA2EB10
	for <virtualization@lists.linux.dev>; Mon, 22 Sep 2025 00:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758502093; cv=none; b=MJ48xwj+V71S75On5SYDmQQMAdOVE1rDnG5d4TQN79ijfRSRKU7HiLeNgIxyJLLJCeQd0eMVWRn8zqeLhXcn2cuXLxNI/q19Tjb+KOtUNbyAgiwQWBRT48seBTm4sQfY9xMJOkvuZPxaBmRG/3Vgzh/54KtcukkzYdMeumWNXOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758502093; c=relaxed/simple;
	bh=qVPCp62WxI+kbLKhs5z+BTZcbzSr+rBFRsXqbMc6F0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gOGUNY/NqMQCcC8tPz45muKVdKMR9M9Nb2Fr3cpPhH3drlCE3jnspZw8nedpuVTS9aO9uOria+KoMIXhDlykPhF+IUeJ0yXKXrnNjveja5VRs/49EJQCF3VmCCQi66CTvnBLM/B4qMe2gu+/yyvfuAv8IMh9uxoulqPePbDRmGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hIM+mORN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hIM+mORN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758502090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LbPwmKep4da7lPYIc/oo7zqSVxp8j3jQIYQS30XuZPE=;
	b=hIM+mORNJ4t6wYtZGQFTh6EMqET5lo0hYTiFR9ZUbR0GGtEQ/YozYfltin7RTO9d1jNQt0
	wHA6LZgfloTfv3JSSHXJyLxaF0yZDpOOa1IjmPUkhHjMKFzHY/C+FJyDeP0wSEue6XHmRW
	Fl4PB8CYpMvkQcxXgvu7kJQ/ryXFOUQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-OHZBrmfUNvePL4m4iRgyfA-1; Sun, 21 Sep 2025 20:48:09 -0400
X-MC-Unique: OHZBrmfUNvePL4m4iRgyfA-1
X-Mimecast-MFC-AGG-ID: OHZBrmfUNvePL4m4iRgyfA_1758502088
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32ee62ed6beso5295120a91.2
        for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 17:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758502088; x=1759106888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LbPwmKep4da7lPYIc/oo7zqSVxp8j3jQIYQS30XuZPE=;
        b=LF6oqfRi+YpR0VP6gpSshp2uWTLN+S1MaBMZYfAtYYTsAaG9AQEMIsZf9Mw3SPSVR0
         5vD/VDrsMPBhSIw3cJ0nu/Kll4px92zN3UPqcRgI9jhar9YZ+CxnSaBwDuj3sxfsEiuf
         0US7Zu0lDSBjcFFkBNZ0155F+aIR43rkkiDAtu4ACaup13l1wRP0mYU4I8fkff8uWGwJ
         KZT7cKgtES6i5oE/dm42O53XGsMLKjx5oU8KcltNjkS4eBeUoKuUc8gRv/MP5DBzJl1m
         kFOOzZrwDPp29Z2DoQgzgAa5w3GG9KTUtcZzZHam0bbEK28+fHi5DeTePzmtnuZk47+K
         N/Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXylYEBj0VcJduML8l2rM/ptyzE8RbuQnJxNMNM/MshFNGAU6Z/OZFdTdK4shXs2uP32bcZLjbhF6TjEvn/rQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwRAHgO4StPa1/jcM/ITn/SgFy8TYwIO83uzeSgeOb7x4iAHsRG
	cXF1kDIeKOafqtPQNfpjRJKKo5Ef1DhhoFY/u1LpEhKt2/bsK4/Bpz3lRqB0KfjA+6wtMloNqoP
	mAD//ENg01RUUjAJ4qAw+vz2z+++hyMpy0nm9Ci7+OeolE3lzwJD6qjmaKlsfxzN20t2YNKGUs6
	G1J5tIzy1nQcUMIxZQJqzlxJ3ZP9/lBycO3xtdDBetWOo=
X-Gm-Gg: ASbGncuVT05cPY+g8vvAv3dor/lhyuPHRgd7vDd1ZFL86xnrAehi9114JaJzEa4oDRc
	1MC11GoQIWWYKAbWn3JCNaAhc7BVnNegupNxgf4SuGic0Z/0bCKMnlJKCmWnUgx7Oxk4RYY1Cn9
	lh5oY6a9DnzXPrmVOrawJzCQ==
X-Received: by 2002:a17:90b:5109:b0:32e:38b0:15f4 with SMTP id 98e67ed59e1d1-33097fdc40fmr12833055a91.7.1758502087824;
        Sun, 21 Sep 2025 17:48:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkm5MDcRGeCr7nM+CSsyiG44BMWORo+SsipMUYwLJVGzVYlDRGII4SLozGaCEYUt93SA5qzvehujesp1OuAIg=
X-Received: by 2002:a17:90b:5109:b0:32e:38b0:15f4 with SMTP id
 98e67ed59e1d1-33097fdc40fmr12833035a91.7.1758502087416; Sun, 21 Sep 2025
 17:48:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250919073154.49278-1-jasowang@redhat.com> <20250919073154.49278-15-jasowang@redhat.com>
 <20250921134323-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250921134323-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Sep 2025 08:47:54 +0800
X-Gm-Features: AS18NWBgmQjVtxf86n4hCuuhNQ_XkG6yIIQsnnd8doULk1KSD6QGgdlq07528fQ
Message-ID: <CACGkMEscRcBQVMUx1gNoWMQ7EUx6XE0-O0fgJm-8EUt96DrhGw@mail.gmail.com>
Subject: Re: [PATCH V6 14/19] virtio_ring: determine descriptor flags at one time
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LLsWeo4ImkjspMJlbEhoaQjqOMsQ2avq3wTATFDTi58_1758502088
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 1:44=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Sep 19, 2025 at 03:31:49PM +0800, Jason Wang wrote:
> > Let's determine the last descriptor by counting the number of sg. This
> > would be consistent with packed virtqueue implementation and ease the
> > future in-order implementation.
> >
> > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 21 ++++++++-------------
> >  1 file changed, 8 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index 1045c553ee65..0949675a3d12 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -574,7 +574,7 @@ static inline int virtqueue_add_split(struct vring_=
virtqueue *vq,
> >       struct vring_desc_extra *extra;
> >       struct scatterlist *sg;
> >       struct vring_desc *desc;
> > -     unsigned int i, n, avail, descs_used, prev, err_idx;
> > +     unsigned int i, n, avail, descs_used, err_idx, c =3D 0;
> >       int head;
> >       bool indirect;
> >
> > @@ -631,6 +631,7 @@ static inline int virtqueue_add_split(struct vring_=
virtqueue *vq,
> >       }
> >
> >       for (n =3D 0; n < out_sgs; n++) {
> > +             sg =3D sgs[n];
> >               for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> >                       dma_addr_t addr;
> >                       u32 len;
>
> How does this make any sense?

Let me drop this unnecessary assignment.

Thanks.

