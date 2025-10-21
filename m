Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992E0298CB7
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 08:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035246; cv=none; b=D9wvx3AxjlOrowXByo8jh1RYYnYZo/YWnq2H90R0XFfORHw14v1e069qXGJPwXL4XtpM2KdFs3DTEHYlq7Rd1v5wHLDfo7bqcYIk27trQRUxkmRrYiZZbdXKqhdL61ejfRNrskXe0ckhqDtak576uBbx/WBhS3agIg0hv6XX09w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035246; c=relaxed/simple;
	bh=t2mdVcUzy/XjJodPiuVo495NKZRMRDvPH2ytiObfVjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=F/ZW3Yzu74ep3dwmFjPpPZb1iJMRmwAmXrx0TxN4U3qyqm2WPZPpuJP9HrFGYBFac+f2vs1znXBI/o/+mZT2lMgll0glwxY2rzAomEOEb4gMdjNp/e4x/WdbXPQiucRQYRVYj+Gw9rIwnwe1uvxnljdg4nc7bg9gljKHsC7drQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZjwyKdGK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZjwyKdGK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761035243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L1e8p2ZQEtizyg+PS9dT60UpnUFBVXwHz4TUTukZ+CY=;
	b=ZjwyKdGKeXQw391QSsSbIDnRayj2Ukl0IdVjg557/qPnr3eQhMriOvfRV6D/mn2YcPiR6l
	5xIPZz9Anmba5Kn9B84qmBcalSVmKvFFV5KZeuZjT35mY8rOkNLr8E7oaBewbAFFvdemKH
	6haPt6B0Hz6R3ayAmlVe486sAQ/bWIw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-XhNrKD1xPguw4zf-QORyPg-1; Tue, 21 Oct 2025 04:27:22 -0400
X-MC-Unique: XhNrKD1xPguw4zf-QORyPg-1
X-Mimecast-MFC-AGG-ID: XhNrKD1xPguw4zf-QORyPg_1761035241
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-471168953bdso38071175e9.1
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 01:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761035241; x=1761640041;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L1e8p2ZQEtizyg+PS9dT60UpnUFBVXwHz4TUTukZ+CY=;
        b=ORM5J68nQc6Db8S8REDj3d3RoGVe4600PjwGy/GPo/zcljs4TcE5BmT+0Ivr9ZcRU4
         Mg1P+QBOmOjQs2c3N6HWVlG/RQYFX58Ozilso/EDP01XZjiIqdEMhNbBohBYyeD5skuA
         y5jjCF03aQjNrMPdWehzDxQ2L7EL1SjPtDWyjgmkT6A4wUf39v/+XDU/8EzQ/j6zXSZM
         BsRrVKmXpY0TNsD1d7l2D1jY/+C+9CertUt5BEkxPy1syAn2Z2iQY0WnTuvk/o0RDCno
         yWVFmd27onqj85NfxUor7aoYje9QIT2cKWU0MSN4LceaiKdCflVA2+1OGN0dDmFKiho2
         r+BA==
X-Forwarded-Encrypted: i=1; AJvYcCWs/8HyChmizA360sg1O76n2dOqKHz9DHcJylQL4Xfa7lJG66xgtDBK2xwNJwnV4gpt593vWfjPBVgoQSc1vA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwLx0vYtBYOobYqaeDdkI+DmaGs1YP6/Li3YdKNTc/dF5ODvETl
	sDgEIbmjaSecBnw0GpyJqZHkNpOsvp/XUCkTxp/eqv/WZpNTwjmyV/PHz5n6LYClgyJKGJwUzVn
	DnzQJfchjf/idDHSvFkE4hHkpVTGC3kPIbqPBBcoeQvU6Dcs58MyCrgjzpJzDPoxt4EBE
X-Gm-Gg: ASbGncs44ApqBmkMUtzxPQH1s6jI4YDEAIXsbe+xjqfhLeDJs8LytyPV+gQxcHBkAVN
	Ky11hvzKo1Vv7yr+eyHaxpnMXUMyHQeltIeEbXA8mBlndZF34WNFssz32PIURQJ/laEWdeNKLfF
	NMwMqulQjPunnDZPsa0JH17gyMEK5k3Q6f0c7raAfv3mYLEMUu1VAkdr0GRzVA30zZEowZwhXv6
	ix5z6/pbnK/h2bLGphp8/LFjTUUO3b3+6+7fM+F4tBHy5b6xJG6eH9fp8acVKNCmHXbRtHAR9rf
	3IyOVTbQi2/tA1I40Zj8iWjSeJwi8L1kZFRtDZb5MNjvnAjIu9fKtd2r3YEOGax68ZIM
X-Received: by 2002:a05:600c:8284:b0:46e:5302:7751 with SMTP id 5b1f17b1804b1-4711726487cmr123240845e9.9.1761035240893;
        Tue, 21 Oct 2025 01:27:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH322GIzHud8+Zk6YhVuSrk7l11dKyN5tL5ceBP4N2vRjXfS0GtBIlO+kW4owHEZHDfN1x6Nw==
X-Received: by 2002:a05:600c:8284:b0:46e:5302:7751 with SMTP id 5b1f17b1804b1-4711726487cmr123240655e9.9.1761035240467;
        Tue, 21 Oct 2025 01:27:20 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce678sm19391712f8f.51.2025.10.21.01.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 01:27:20 -0700 (PDT)
Date: Tue, 21 Oct 2025 04:27:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 18/19] virtio_ring: factor out split detaching logic
Message-ID: <20251021042325-mutt-send-email-mst@kernel.org>
References: <20251020071003.28834-1-jasowang@redhat.com>
 <20251020071003.28834-19-jasowang@redhat.com>
 <20251020111413-mutt-send-email-mst@kernel.org>
 <CACGkMEsRmkaBiU2WCQTepayhrhR18M1+bDQJXxTVxOUDG4sZyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsRmkaBiU2WCQTepayhrhR18M1+bDQJXxTVxOUDG4sZyg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tpRijlWWxQtnVuEM-ga0fIYb0v6ZOHvd3s2t1cSoahA_1761035241
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Oct 21, 2025 at 11:36:12AM +0800, Jason Wang wrote:
> On Mon, Oct 20, 2025 at 11:18 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Oct 20, 2025 at 03:10:02PM +0800, Jason Wang wrote:
> > > This patch factors out the split core detaching logic that could be
> > > reused by in order feature into a dedicated function.
> > >
> > > Acked-by: Eugenio Pérez <eperezma@redhat.com>
> > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 18 ++++++++++++++----
> > >  1 file changed, 14 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index 0f07a6637acb..96d7f165ec88 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -802,8 +802,9 @@ static void detach_indirect_split(struct vring_virtqueue *vq,
> > >       vq->split.desc_state[head].indir_desc = NULL;
> > >  }
> > >
> > > -static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> > > -                          void **ctx)
> > > +static unsigned detach_buf_split_in_order(struct vring_virtqueue *vq,
> > > +                                       unsigned int head,
> > > +                                       void **ctx)
> >
> >
> > Well not really _inorder, right? This is a common function.
> 
> Yes, but inorder is a subset for ooo so I use this name.

Can't say it is consistent. I suggest for example:
	_in_order -> specific to in order
	_ooo -> specific to ooo
	no suffix - common

or some other scheme where it's clear which is which.



> > You want to call it __detach_buf_split or something maybe.
> >
> > Additionally the very first line in there is:
> >
> >         __virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
> >
> > and the byte swap is not needed for inorder.
> 
> I don't see why?

To be more precise we do need a swap we do not need it
conditional.


No, I mean inorder is a modern only feature. So we do not
need a branch in the inorder path,
you can use __cpu_to_virtio16 with true flag,
not cpu_to_virtio16.

> > you could just do __cpu_to_virtio16(true, VRING_DESC_F_NEXT)
> 
> Probably you mean a leftover for hardening? E.g should we check
> desc_extra.flag instead of desc.flag here?
> 
> while (vq->split.vring.desc[i].flags & nextflag) {
>                 vring_unmap_one_split(vq, &extra[i]);
>         i = vq->split.desc_extra[i].next;
>                 vq->vq.num_free++;
>         }
> 
> Thanks

If it is not exploitable we do not care.

-- 
MST

