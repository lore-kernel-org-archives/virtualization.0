Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7489C121
	for <virtualization@lists.linux.dev>; Fri, 22 Mar 2024 05:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711084948; cv=none; b=GunJDRW2vZOxgtZvI8qizgjYzhQmWzA3TqEXEyYrEJoniAYjm3I6xcUhU9Og8tGniECCd9gUTyS1R6CDixwspMEjXsgxNstxlhm16b9A09eg1ccyitdcRJhc0jUMXYNljj10ziCWHc1cGdupAVapZIwOZCY69SfLeqRtFFY0Vbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711084948; c=relaxed/simple;
	bh=QytD35JuDlG+En/9t6sSJpgNDREt9E94XyMto3Rpa+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMkzMAXkJImo68ECUVaqp93oYLHWWMUr9v6AWDJHWmn14iAmZpYHUHMdLIEghUqZ3ce6WxYnAx4nOgHgPyGbxK1EDDgdJmJkSkrlWDL0A8eYKtfVPdp1XVeeZVEJTbk+AWI3JWBIreOEJ0gAQ0qHxphY6COhr97UKIlhR+o+mAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zvsl87vY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zvsl87vY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711084945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f64uD3ctRKLKxfrmn6XfohoQXF2Xm9nnpbY3kz4u4o4=;
	b=Zvsl87vYoJl/3qdgF1jcc77QIpp8muIe4dBHVI+ukG0w/xIGZ4E0VW30aI5xG4ULXFUai7
	36OWM7ZIXYQQ5XCB84pHB1+VAlFsvZ0KpM+0kfG0qFuPCFlIYdGEjGcioNm6APNt5GX4eh
	ADqvgq+e4ZzCDrQ12WcpftT1rrtCdmc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-YKa7kckGPw-tDSue7S7klg-1; Fri, 22 Mar 2024 01:22:24 -0400
X-MC-Unique: YKa7kckGPw-tDSue7S7klg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6962767b1e7so29242726d6.1
        for <virtualization@lists.linux.dev>; Thu, 21 Mar 2024 22:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711084943; x=1711689743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f64uD3ctRKLKxfrmn6XfohoQXF2Xm9nnpbY3kz4u4o4=;
        b=s+rydIGcgI5YIF/1mebAfPnc+tnZhg1Qzk1JYyPYMEkUdLLMD5Ze2SCicNlRkVPC7/
         2j9IJT2U0Li54TG6dqT/pXDi/zeDfaObiSARUTGwskJHTMAJzrHVV1Wf2qD3+yFhflDo
         BUhT2XHj95pUtqasZ9UvKNqynJRRqwIJplvgpstk88mo0leRIlKYNfbnnrjpa6pxl/Lq
         re0ZggpEMKHwENNjBeb5r2rIZ/WcdAJkn8KW3S9p2GhGjyLUNWSChFA5J0a5RAiWr8Os
         HaIKHbEzKEGg2D7GBP8ts+hHWjlJ4BsGMjGDvYDq3knWkxmjCM28iUB2O3NvX5Tve9b+
         oJ5g==
X-Gm-Message-State: AOJu0YzJ0ovxt+xgR5g2X7aSZ4Sc6ZeXCm+jX2WOcOoOnfYpFpNUi6gQ
	Y76yxmbfT67lbpkzBFpWLTIfs0i8fMnU+EdElRbL5IMhribqqGQ4qFlwWmjUwtNLb41bseYztrY
	N94BJGkPkXOtlgE92WOqjJc50hjdEfBrsj1BS8NzMlkdWg1Pe/jNpgZ8F+qMmxKOaqKjAIFY5zy
	JtwamK/I0N21e5qkor+4JbQoo3FvVUafL0JCXBUoL/3D48U8VfyeQz
X-Received: by 2002:a05:6214:2388:b0:691:5655:f571 with SMTP id fw8-20020a056214238800b006915655f571mr1359979qvb.37.1711084943687;
        Thu, 21 Mar 2024 22:22:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5yXn3+w5s6+ehppU+kKXkeJABGiiv8v0yk9v5XPd/nmqIS5A83FzmMfiZGNHonIsnis37fDEgTrVhYHLvbiI=
X-Received: by 2002:a05:6a20:4f23:b0:1a3:69f8:b6eb with SMTP id
 gi35-20020a056a204f2300b001a369f8b6ebmr1346699pzb.14.1711084521278; Thu, 21
 Mar 2024 22:15:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240312033557.6351-1-xuanzhuo@linux.alibaba.com>
 <20240312033557.6351-4-xuanzhuo@linux.alibaba.com> <CACGkMEs_DT1309_hj8igcvX7H1sU+-s_OP6Jnp-c=0kmu+ia_g@mail.gmail.com>
 <1711009465.784253-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1711009465.784253-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Mar 2024 13:15:10 +0800
Message-ID: <CACGkMEvimfmQRUZ04CykZs-6cOkASF8S02n2N7caJ4XivR8hNw@mail.gmail.com>
Subject: Re: [PATCH vhost v4 03/10] virtio_ring: packed: structure the
 indirect desc table
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 4:29=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Thu, 21 Mar 2024 12:47:18 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Tue, Mar 12, 2024 at 11:36=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alib=
aba.com> wrote:
> > >
> > > This commit structure the indirect desc table.
> > > Then we can get the desc num directly when doing unmap.
> > >
> > > And save the dma info to the struct, then the indirect
> > > will not use the dma fields of the desc_extra. The subsequent
> > > commits will make the dma fields are optional. But for
> > > the indirect case, we must record the dma info.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 66 +++++++++++++++++++++-------------=
--
> > >  1 file changed, 38 insertions(+), 28 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index 0dfbd17e5a87..22a588bba166 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -72,9 +72,16 @@ struct vring_desc_state_split {
> > >         struct vring_desc *indir_desc;  /* Indirect descriptor, if an=
y. */
> > >  };
> > >
> > > +struct vring_packed_desc_indir {
> > > +       dma_addr_t addr;                /* Descriptor Array DMA addr.=
 */
> > > +       u32 len;                        /* Descriptor Array length. *=
/
> > > +       u32 num;
> > > +       struct vring_packed_desc desc[];
> > > +};
> > > +
> > >  struct vring_desc_state_packed {
> > >         void *data;                     /* Data for callback. */
> > > -       struct vring_packed_desc *indir_desc; /* Indirect descriptor,=
 if any. */
> > > +       struct vring_packed_desc_indir *indir_desc; /* Indirect descr=
iptor, if any. */
> >
> > Maybe it's better just to have a vring_desc_extra here.
>
>
> Do you mean replacing vring_packed_desc_indir by vring_desc_extra?

Just add a vring_desc_extra in vring_desc_state_packed.

>
> I am ok for that. But vring_desc_extra has two extra items:
>
>         u16 flags;                      /* Descriptor flags. */
>         u16 next;                       /* The next desc state in a list.=
 */
>
> vring_packed_desc_indir has "desc". I think that is more convenient.
>
> So, I think vring_packed_desc_indir is appropriate.

It reuses the existing structure so we had the chance to reuse the
helper. And it could be used for future chained indirect (if it turns
out to be necessary).

Thanks

> Or I missed something.
>
>
> Thanks.
>
>
> >
> > Thanks
> >
>

