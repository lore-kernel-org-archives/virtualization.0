Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE341D618E
	for <virtualization@lists.linux.dev>; Tue, 29 Jul 2025 02:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753756448; cv=none; b=DelGZah0ECfJ/LKXaRtgDTHeoIWYfEjw280Gn/dqDRJ8b7C56MUE1FJDO99hyekflnVWcuRANnWsKCR2VFLJQX5vCBPRwrz0vX6gcsjomVufaJzNaFjLYmL7175BGrJmMD0RlDRvjk76BlFQvTp+SHcqid7mr2KKcpW9+EgpGT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753756448; c=relaxed/simple;
	bh=k5U5VmbuGzYR74UVukpio0gv9VhzkjaKJEuIUXMfpxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mejBDa9KaTr67EaPvLuaZ0no3Y/tvz1mt4jFcmpQuV//yUoYpjYm3qLFLwWtK1hORMm2lOip6PE7Y9O+20cUsZa1B6z4zAMrLP0k1FxYHiidCOqMkZK/PUxxtzVqMWGJqobzLzsstah4TKLgb2vDURPT5NT6gEIcy8Wo6b14uRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fpcD8hPn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fpcD8hPn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753756445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KW4aZUOhIexvSWl8+uNp7V0TRuoHBCBJYexWHVg0orU=;
	b=fpcD8hPnG95VT3plxpuJv5nWjqOzMnhh/pFVULj8xRov2QMNciaRPFo8I6XLd8QfzbPyPV
	GJtWYmmTjSnqMgZhYChncFVtE6oMzt6NYF8ibGbTe5BFJRZoMD3x1OGN6336b2xL9nLsx6
	xBe1IoA6Q8hgluL+UcNKytzY6v6uW/M=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-wTHj25cDMPWHzyDBX-gfSQ-1; Mon, 28 Jul 2025 22:34:01 -0400
X-MC-Unique: wTHj25cDMPWHzyDBX-gfSQ-1
X-Mimecast-MFC-AGG-ID: wTHj25cDMPWHzyDBX-gfSQ_1753756441
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-31f2dd307d4so414229a91.0
        for <virtualization@lists.linux.dev>; Mon, 28 Jul 2025 19:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753756440; x=1754361240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KW4aZUOhIexvSWl8+uNp7V0TRuoHBCBJYexWHVg0orU=;
        b=QcoABWHf1DpPDzL0DR+EqjwikKqainwrw6m4HgbcX80jz6XyiM/CVanRbszX1658w+
         saiHGVEf551RcBhmgFXcD9IsA96TCVAx2QLA/O471qimTc/qmyZ0L8/V/pOB2Q984PK/
         tp+MkvZHfjEegCo1Y328JEUj/NvHnZLPZWIVHVOZSn8uPG/82lHRxLMCphCyw76CwG+I
         VxTawj0eNcvWslcJ+wQUeM+MZar6zWEIzdr/1egR6t6AqkPEhxccyNIa7oiogsCmSQve
         KEFD/XA6ef081BEjhWki/UlWiFscVxZNlyh2lTJqsolGvX5MfyS8xAgZzZn+18ZV384t
         hF+w==
X-Forwarded-Encrypted: i=1; AJvYcCWeLYDiA9ypWHYwuTfMKM8eGHmw67PQJllaXeTVqxGBX5CuywDd7FJQhVTTdkSZcm64nQfec82BNmPmzcDlXA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywgv2oSG9wuYGsFtZfOOLTa7bZBPPeLbaznTrqjApifuN1Mf02a
	SwcI9t6h59nXCqsQqJLGZpPUmO1WmEUlIzNYV1Y/qUPIbzOe2Ry518OIbDWF2H2D05VIJmJEuZ4
	+oW6ZNJ2RJzvjgcQtPMSzHAmAIQ0sGEiZpD/PxmF/SPPotHEBFPcIfXo1A2ziFDazkY9FyBmwCd
	f2/DSaFDinwQZmPzqycF9nqRvmB/PR8Tn4ByZWxSJ98QI=
X-Gm-Gg: ASbGnctzRzx8XmCI6DoDWH9aTSkrD010N8tA3KSQ677Bin727RgLDBKJ3SIVUzuTpkq
	AwRTO5YHku9hQ5MjRloNLOOJq4rBHg1PgCUdZwD9gaA0+KgD8nxsLXI45BoXmZqZAj+AKvB5QK5
	tVWC3M2xyT68KfIv4dkgE=
X-Received: by 2002:a17:90b:55ce:b0:31f:2ef4:bc22 with SMTP id 98e67ed59e1d1-31f2ef4bd3cmr1457376a91.27.1753756440486;
        Mon, 28 Jul 2025 19:34:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8/Fduu/xXUr5+Bmt1whH0ZCQThYGyCL7nZ4J4nWhDYbZdR62iA3aAlOA2tWURjzzQBbvItNJhU5LR6Afh+5A=
X-Received: by 2002:a17:90b:55ce:b0:31f:2ef4:bc22 with SMTP id
 98e67ed59e1d1-31f2ef4bd3cmr1457349a91.27.1753756439979; Mon, 28 Jul 2025
 19:33:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250728064129.32382-1-jasowang@redhat.com> <20250728060823-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250728060823-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 29 Jul 2025 10:33:48 +0800
X-Gm-Features: Ac12FXyO-5aY1nzF0VIfrZ-HUDqqbfQfNDQkv0NFgyHvypnE0_tK5xFbEwqjiOU
Message-ID: <CACGkMEsX9=MAT=pg+MG-5_0PN7DYGNv8G9E2ZLgtZ1TmCLV-0g@mail.gmail.com>
Subject: Re: [PATCH V5] virtio_ring: add in order support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: S9s0c5C8-K4qzIywKwh1KSaB9pHVgJW_aTUI6EvQMBM_1753756441
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 6:17=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Jul 28, 2025 at 02:41:29PM +0800, Jason Wang wrote:
> > This patch implements in order support for both split virtqueue and
> > packed virtqueue. Perfomance could be gained for the device where the
> > memory access could be expensive (e.g vhost-net or a real PCI device):
> >
> > Benchmark with KVM guest:
> >
> > Vhost-net on the host: (pktgen + XDP_DROP):
> >
> >          in_order=3Doff | in_order=3Don | +%
> >     TX:  5.20Mpps     | 6.20Mpps    | +19%
> >     RX:  3.47Mpps     | 3.61Mpps    | + 4%
> >
> > Vhost-user(testpmd) on the host: (pktgen/XDP_DROP):
> >
> > For split virtqueue:
> >
> >          in_order=3Doff | in_order=3Don | +%
> >     TX:  5.60Mpps     | 5.60Mpps    | +0.0%
> >     RX:  9.16Mpps     | 9.61Mpps    | +4.9%
> >
> > For packed virtqueue:
> >
> >          in_order=3Doff | in_order=3Don | +%
> >     TX:  5.60Mpps     | 5.70Mpps    | +1.7%
> >     RX:  10.6Mpps     | 10.8Mpps    | +1.8%
> >
> > Benchmark also shows no performance impact for in_order=3Doff for queue
> > size with 256 and 1024.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > Changes since V4:
> > - Fix build error when DEBUG is enabled
> > - Fix function duplications
> > - Remove unnecessary new lines
> > ---
> > drivers/virtio/virtio_ring.c | 421 +++++++++++++++++++++++++++++++++--
> >  1 file changed, 401 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index e675d8305dbf..c6558e271f97 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -70,11 +70,14 @@
> >  enum vq_layout {
> >       SPLIT =3D 0,
> >       PACKED,
> > +     SPLIT_IN_ORDER,
> > +     PACKED_IN_ORDER,
> >       VQ_TYPE_MAX,
> >  };
>
>
> how about specifying the #s here?
>         SPLIT =3D 0,
>         PACKED =3D 1,
>         IN_ORDER =3D 2,
>         SPLIT_IN_ORDER =3D 2,
>         PACKED_IN_ORDER =3D 3,
>         VQ_TYPE_MAX,
>
> and then
>
>   static inline bool virtqueue_is_packed(const struct vring_virtqueue *vq=
)
>   {
>         return vq->layout & PACKED;
>  }
>
>  static inline bool virtqueue_is_in_order(const struct vring_virtqueue *v=
q)
>  {
>         return vq->layout & IN_ORDER;
>   }
>
> which is a tiny bit less code.
>
> worth doing?

Probably not, for example it would introduce branches. As we
discussed, once we have sufficient optimizations, most of the branches
could be saved.

>
> >
> >  struct vring_desc_state_split {
> >       void *data;                     /* Data for callback. */
> > +     u32 total_len;                  /* Buffer Length */
> >
> >       /* Indirect desc table and extra table, if any. These two will be
> >        * allocated together. So we won't stress more to the memory allo=
cator.
>
>
> this is only used for in_order, and it increases the struct size
> by half due to padding. why not a separate struct?
> Or if you like, reuse vring_desc_state_packed - it is same
> size with this addition.
>
>
> > @@ -84,6 +87,7 @@ struct vring_desc_state_split {
> >
> >  struct vring_desc_state_packed {
> >       void *data;                     /* Data for callback. */
> > +     u32 total_len;                  /* Buffer Length */
> >
> >       /* Indirect desc table and extra table, if any. These two will be
> >        * allocated together. So we won't stress more to the memory allo=
cator.
>
> there's empty space at the end of this struct.
> struct vring_desc_state_packed {
>         void *data;                     /* Data for callback. */
>         u32 total_len;                  /* Buffer Length */
>
>         /* Indirect desc table and extra table, if any. These two will be
>          * allocated together. So we won't stress more to the memory allo=
cator.
>          */
>         struct vring_packed_desc *indir_desc;
>         u16 num;                        /* Descriptor list length. */
>         u16 last;                       /* The last desc state in a list.=
 */
> };
>
> why not put it there?
>

Fine.

Thanks

