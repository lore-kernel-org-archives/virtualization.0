Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706295;
	b=BEG2LUOwEciRST0vhOCpJUTrZhOrp+dwQpw3nS+F55tiOEm26l0HCV/aBAeQ5lfugPLO
	 1agGWFrtCrB1K81fXooPzlH8sqE0Rm4GgPk1ZLd70VTqWpPqkr2Vspw1mgo+yC/w9X6yO
	 lnLLvYYkLogpqyEqvl1GKL7u+fa4eAlOtfNZ70ob/7mlNs4cPg4bWMsMnu7AIccc4nyJL
	 bmNGaIakTRFMDXenqi4ePofYkTnhL9RvLjMu4A/aCBOh+vI4sJ1ILN9PyAgHOnQMJXznZ
	 FMjIa4hr6qfeCs/WLjPEeAAquYi6NtJ8iVgEcVjHYY+LPxwMHD0bBybKFDTqv7FdZFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706295;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=RuFn4W6phgVUBUCM7NSjX2wTX8POdULpQTYDzkp30Zk=;
	b=VL7hXnqy7cVjHYgQ7QXvltrLGHpCaHQbflkXpTyeSXgV3MTGthYE59XyH7Or2ikmaBmX
	 dutNBmhwBgbuKxuydJCAZx2MWQwk/Qtc1ZImsSxlrwPpDOtGyewS8GANI8XtlHBOeOWyO
	 5UZgFXLZV6PyPCpZyNPkybwK+FyR0xaEKiX3SkfoKS9G7hdLHiIo37tyrCEk5Vm5gNAZj
	 N6h5k2hksqUkRqz/46BKyAN7cF7ykXbchr23ASB0mT8EZeMkhiuoIHcxm/egT2AMhwTuU
	 90LTA0Jc8mReqAMYODGKSwtMTzVccvXozhBEKBNUmZ7rVRmOMDqBNozjK/BpFfR7e/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dzsmIKRQ;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F30606A334
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 11:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7F30606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dzsmIKRQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793706294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RuFn4W6phgVUBUCM7NSjX2wTX8POdULpQTYDzkp30Zk=;
	b=dzsmIKRQIzYnhq20+cX9oQCM/cFdr9uIZla1EucXBzaojeNINZB4sqw8MRFgyAar/pKYbZ
	9ygV0lrZhV9Kl7MmJe2QheXvSTdj0iKe8k0CK/hJx0klhhT16UTFHy08QYDl3gwmvzRvYN
	OTquVmRQ+PEaxOI46szug5tqRA+x+0o=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-myKyP-0fO-CQK1GUhFULOw-1; Tue, 03 Nov 2026 06:44:51 -0500
X-MC-Unique: myKyP-0fO-CQK1GUhFULOw-1
X-Mimecast-MFC-AGG-ID: myKyP-0fO-CQK1GUhFULOw_1793706290
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-8b300e5bbacso2910797b3.0
        for <virtualization@lists.linux.dev>; Tue, 03 Nov 2026 03:44:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793706290; x=1794311090;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RuFn4W6phgVUBUCM7NSjX2wTX8POdULpQTYDzkp30Zk=;
        b=fobGeMUf2PMcgTP4GSvuHlYXdoJEWpdTm9Mh6C9fd27KMSZlht9gtN8+dKMEF/I3KC
         vptst2hvAWEpIypH6aH7IB39Aequ+k3NhB9NRNUcpC/0/irGPdNrJSkyyMRsLpmFHQCg
         bBpJh2UJ6Z9ATje8cuI/H0nW20/PNJDVZ/nOdrZ1pfgmBZ0evfRbA84/ZkUyVb6FeZpa
         vB6mrwvz+BsMIt6hi67bBG+/QgnpsF8q03vHKcKyvDsP8hmLMNfksp7g7akWZV9NaSml
         6CRF8KcNDk/ky3EIg2NM7wHX7Xxn7xEUPNjRA7RCEHLiy3bi2pVYHP0aBWX+W0VRhu01
         VlJw==
X-Forwarded-Encrypted: i=1; AKwUvBxZ6IdBUKcf+zXScNPwuNXw+0Np7YzZS44n6sdcJxblkdgf0BTIdKVgqo0qBPzwBBgber+O9HzX5DO4CnGVCg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9IG3B41KALrl+awixAKLmjN4hJ7s5VWMXm3EHE4KruB8e9q73g
	jI4S+C6ozxtcDFaEER0OJnpttuUFaYVYfWJK4PdBSAt/nLxrw4HN7Ni/PAXZ+MhHmC3fhEwV6m/
	T1sT0sEKfYPmNoAsuLJIqjJwX90bExY3FjnTt8IfNvZT5/HZ1iNPV7ePlSfdMS+FtS7IYIUv2x6
	wBBZbzuOoItssrqukTn7F77eOkBqbAJ6UTtTktj4t+Y8Y=
X-Gm-Gg: AYBFou2iCG8guhGtZ8YioeTjhxJmgEK7WYHYFb/v6YqOONA4ygz66uioMHK2yYWgXrE
	XleLm1nx6wMu+U+h/XG0wI47C0T5nM5s2bzctwNuArcWneMZysMVYR5DXk7wb0U8SHHRPHwXjWF
	T1ZOL4CwfdFDbTGCpPbiGRsdBiRQ0HxXk3sZ+gVltnVRW0KS093yp3gXrUTvM9PYT6yFkMzFzpj
	4xskejTYSPm3tcCaIb8rXXoc7eXwCJUPq4bTtpbVdA2FSDAkOkOAA2LKV8=
X-Received: by 2002:a05:690c:6609:b0:8b0:bc8e:9d75 with SMTP id 00721157ae682-8b2b6756fb4mr93647187b3.22.1793706290284;
        Tue, 03 Nov 2026 03:44:50 -0800 (PST)
X-Received: by 2002:a05:690c:6609:b0:8b0:bc8e:9d75 with SMTP id
 00721157ae682-8b2b6756fb4mr93647097b3.22.1793706289728; Tue, 03 Nov 2026
 03:44:49 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20260910123903.1717-1-lirongqing@baidu.com> <CAAf7B_M=tfyL33WGkxSX68FwPaRRRBcASVx92EGwPMXaFtUdzQ@mail.gmail.com>
 <fe5e4fb1b68d4203812e253d722cbe69@baidu.com> <CAJaqyWc6OzMF2yvrSjOfRE8g4-Y=JD50iq42zPuXWKjb00FdCg@mail.gmail.com>
 <20261103044056-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261103044056-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 3 Nov 2026 12:44:12 +0100
X-Gm-Features: AclHuK-F8To7UGQU7Iu1DNSDfs2cRh-mK5wzoN11M5svVnnNyzaiwQ7PTsM9EcE
Message-ID: <CAJaqyWdVpXPU=JpgsqrdAvjwdx+L_aUxUJpp4DmjHjWNiTCCZw@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFvlpJbpg6jpgq7ku7ZdIFJlOiBbUEFUQ0hdIHZpcnRpb19yaW5nOiByZXNldCBJTg==?=
	=?UTF-8?B?X09SREVSIHN0YXRlIGluIHZpcnRxdWV1ZV9pbml0KCk=?=
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Li,Rongqing" <lirongqing@baidu.com>, Jason Wang <jasowangio@gmail.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5_-uFf1GZE14oi82trM_30KjOyu3Q0gF_7uAqrKbu8Q_1793706290
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 10:41=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Nov 03, 2026 at 10:36:26AM +0100, Eugenio Perez Martin wrote:
> > On Fri, Sep 11, 2026 at 8:05=E2=80=AFAM Li,Rongqing <lirongqing@baidu.c=
om> wrote:
> > >
> > > > >
> > > > > The IN_ORDER feature uses additional software state to track the =
next
> > > > > available descriptor and in-flight descriptor batches.
> > > > >
> > > > > virtqueue_init() resets the common virtqueue state, but free_head=
 and
> > > > > batch_last.id are initialized only when the virtqueue is created.=
 When
> > > > > an IN_ORDER virtqueue is reset, these fields can retain state fro=
m the
> > > > > previous queue instance.
> > > > >
> > > > > Reset free_head and invalidate batch_last when initializing an
> > > > > IN_ORDER virtqueue. Keep this in virtqueue_init() so the state is
> > > > > initialized consistently for both newly created and reset virtque=
ues.
> > > > >
> > > > > Fixes: f6a15d854986 ("virtio_ring: add in order support")
> > > >
> > > > I think this is needed for -stable.
> > > >
> > > > > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > > > > ---
> > > > >  drivers/virtio/virtio_ring.c | 5 +++++
> > > > >  1 file changed, 5 insertions(+)
> > > > >
> > > > > diff --git a/drivers/virtio/virtio_ring.c
> > > > > b/drivers/virtio/virtio_ring.c index db678f5..d0dc464 100644
> > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > @@ -559,6 +559,11 @@ static void virtqueue_init(struct vring_virt=
queue *vq,
> > > > u32 num)
> > > > >         vq->in_use =3D false;
> > > > >         vq->last_add_time_valid =3D false;  #endif
> > > > > +
> > > > > +       if (virtqueue_is_in_order(vq)) {
> > > > > +               vq->free_head =3D 0;
> > > > > +               vq->batch_last.id =3D UINT_MAX;
> > > > > +       }
> > > >
> > > > I would try to reuse or refactor virtqueue_vring_attach_split() to =
reduce code
> > > > duplication.
> > > >
> > > > Btw have you checked Qemu shadow virtqueue as it might suffer from =
the same
> > > > issue.
> > > >
> > >
> > > I checked QEMU's shadow virtqueue implementation. batch_last is reini=
tialized in vhost_svq_start(),
> > > but free_head is not. Since the SVQ object can be reused across stop/=
start, free_head may retain stale
> > > state. So a corresponding fix should be needed
> > >
> > > void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
> > >                       VirtQueue *vq, VhostIOVATree *iova_tree)
> > >  {
> > >      ...
> > >      svq->shadow_avail_idx =3D 0;
> > >      svq->shadow_used_idx =3D 0;
> > > +    svq->free_head =3D 0;
> > >      memset(&svq->batch_last, 0, sizeof(svq->batch_last));
> > >      svq->last_used =3D 0;
> > >      svq->last_used_idx =3D 0;
> > >
> >
> > I'll ack this patch if it is sent to the QEMU mailing list, but the
> > guest is not able to reset a virtqueue without deallocating it
>
> what would "deallocating" mean here? who's doing the deallocating?
>

I meant that QEMU free the shadow virtqueue members on vring stop, but
I was wrong about free_head. What QEMU actually free is each
descriptor state (and the queue itself), as it could be resized on
each reset. free_head member should be set to 0 too. Li RongQing,
would you mind sending a patch to the QEMU mailing list with that?

Thanks!

