Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698626;
	b=ncLWmchipmYobEq5Ynt5Lbo3K4Oe7LkYyGezrXvUxuygxc3O+bCbxb52kNr2kieFd1ch
	 1WhFYb2K7XXkMGm3Lm2eyvx3w4Ry1n/fN0ZqJRioew1O7+Fz3tb2iWaATNlCT4A0j6Jp3
	 7UXzdLSDCM5mPn0jgXpxTO8zDCbhvKt66zHswpS0RXuKgRTh3zXydrfRC6khywjSSFD7O
	 hJyDRh/cJ2GiHjf04EtjykBH1wnf1SFLDXskJBTZayE25ZnxFxyDTPo0PfntC40HURil7
	 jndhwLS5rijD2TC+Cn2VvFZQ1D+MiJW+upbVP2C3CJGqW5f024+1rjHvXya50a+pubA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698626;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=mhbekvYvf/VcPDAp6AWk4T9uCuPGyMlX9BkrPLgsRjo=;
	b=JV3qibITzNHmW0MQ3+kfZXJTYJbrGw7gLoD7Xn4KIxswPZJ4gvR4GYhFN41IFhnBwdSS
	 pnVaMFolNCkpZhKMzeNKPIKgqt9CqnraCE8zyNRxvDR+E5gvAO2A97CvhJXqOd2nSkB3G
	 MAkgogkDU0+3RzoZfLB2jqIjFMzF1qfp/G57ZBJPGBbjpNHZEThRMPn7smdvmG8xDMzGj
	 q2PKe0JQP6qEp2huzqaxQBSzi3Bu7pVhBRlvzLUSaLVFt/dmYexOk44OF+FaX6my5JjZB
	 Vnb1A3z3RU8LxMup/DvibwwWUYgbu75JHGVc2zc/m6BZuO05nsicirLSkrVnXbMz1rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YM8KNHny;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500E7606A332
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 09:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 500E7606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YM8KNHny
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793698625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mhbekvYvf/VcPDAp6AWk4T9uCuPGyMlX9BkrPLgsRjo=;
	b=YM8KNHnyG77Iv3RkA9AXv25QxTTAkfp2RjPPOaq766dd24cP1M0oSJ+t34H7uKmIS0E43A
	mkjMqipdUldA9GD2ATKe3P0E8ngIqlacSoPp4W86H/12o/fln4tf/OEZmLvmrn0F6qvfBj
	ttIlf9fUBB2++O3HD/4StHipQZ0ANYc=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-30DFDYbkO1SEYJ3zqcsr5w-1; Tue, 03 Nov 2026 04:37:03 -0500
X-MC-Unique: 30DFDYbkO1SEYJ3zqcsr5w-1
X-Mimecast-MFC-AGG-ID: 30DFDYbkO1SEYJ3zqcsr5w_1793698623
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-8ab43f7f5faso69409097b3.2
        for <virtualization@lists.linux.dev>; Tue, 03 Nov 2026 01:37:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793698623; x=1794303423;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mhbekvYvf/VcPDAp6AWk4T9uCuPGyMlX9BkrPLgsRjo=;
        b=dbdDx9MxKS/aJS7wDGBW5ks+mfiXpRlc4l3cLTOZH4EghRNFPNQH7vRgBqjlsFJiZ+
         IOXvA8Br6zNgMWSdBYYP2LnLbDpfK3rXLtGXdU+T+85qW6bpngGLXAnLwE6fHzYOVbjH
         yQ6VsRdeRJEAkhOfv8BHk2T5k7dr3YZW7nU9wI/cpRP3DqoLZBvowEy806cO+YfeQKLP
         hBbugQw8vtNmobXpVcdQgNcgoWbBZzXhzF/0vfjxjIPDZYOjmCetK0XMFTfS537PkmHR
         WE9auCD371gXbnZG0vFTgmAYElAu1cWaIN/qqVXQarTvcPL6FVockhUeL4yDNkYdfIhn
         TK6w==
X-Forwarded-Encrypted: i=1; AKwUvBwWRS7FSb+czMaF4+KxICxx8cuSt8QxoOCFNUVRj/U/9Vmim6FIy7gqYIZK6DUeO+uuYL2yPBi7HQl2rK0WtA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/ivTf5bHMUkf0+xzHOyKoXWB+9iRKzyEWvVuXX0nEO7971dxAf
	b/0EnVWr5RvYr8XiGBJs0ZlRTo3BFxWInwfjwSV1ROUD0YhJoHE4Gg+caITZo0Dy1BBgWoyUY6Z
	pS4zAI7EbAa1l+ESIDZsC4+846NnXQJzMcOKXdJ/NuY8YvII+DrP8aymVM3cV4O4sS9FUj5JUuR
	fCIjP3kreJS3U1U8jhm9WfBxb5/6bDURkgC0cCGIUVb2c=
X-Gm-Gg: AYBFou1qQmpVq39/bJVt+5/rMoxuYDALNYVfZ5fGkQCrzGgfPiKVIkcLzFhLEg8dYOZ
	PaMfLIFQlIkb+2EoEc2yaXvjhiS7voofQkzX6RD7dwx1gDh7V0H25MEtH9ZNywohrViWME+Wopp
	xPFYGG5hsNYjXHOCrQyYqMTKCPe5nXX5T5KHFNH+lwonixvJg3Ure8GtTZqS/dCLPDxr6v0Cnav
	h8VM0rPCCUlhJ0pjLh7rifq97PNGx06OwpBc7afDQYiypl7+Lp9Rbc1qiM=
X-Received: by 2002:a05:690c:6b01:b0:8b1:691f:aaf8 with SMTP id 00721157ae682-8b2b67d25c7mr65056167b3.65.1793698623275;
        Tue, 03 Nov 2026 01:37:03 -0800 (PST)
X-Received: by 2002:a05:690c:6b01:b0:8b1:691f:aaf8 with SMTP id
 00721157ae682-8b2b67d25c7mr65055947b3.65.1793698622686; Tue, 03 Nov 2026
 01:37:02 -0800 (PST)
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
 <fe5e4fb1b68d4203812e253d722cbe69@baidu.com>
In-Reply-To: <fe5e4fb1b68d4203812e253d722cbe69@baidu.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 3 Nov 2026 10:36:26 +0100
X-Gm-Features: AclHuK8UC18carL_1XitgmWfN_M9_0x8flqyKuWRSZ5lwlwQ6wfohwWQCS9BJYk
Message-ID: <CAJaqyWc6OzMF2yvrSjOfRE8g4-Y=JD50iq42zPuXWKjb00FdCg@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFvlpJbpg6jpgq7ku7ZdIFJlOiBbUEFUQ0hdIHZpcnRpb19yaW5nOiByZXNldCBJTg==?=
	=?UTF-8?B?X09SREVSIHN0YXRlIGluIHZpcnRxdWV1ZV9pbml0KCk=?=
To: "Li,Rongqing" <lirongqing@baidu.com>
Cc: Jason Wang <jasowangio@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jXB276jrMBw25uiT34gde0p3816IT6VF02fUSKP2sGc_1793698623
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 8:05=E2=80=AFAM Li,Rongqing <lirongqing@baidu.com> =
wrote:
>
> > >
> > > The IN_ORDER feature uses additional software state to track the next
> > > available descriptor and in-flight descriptor batches.
> > >
> > > virtqueue_init() resets the common virtqueue state, but free_head and
> > > batch_last.id are initialized only when the virtqueue is created. Whe=
n
> > > an IN_ORDER virtqueue is reset, these fields can retain state from th=
e
> > > previous queue instance.
> > >
> > > Reset free_head and invalidate batch_last when initializing an
> > > IN_ORDER virtqueue. Keep this in virtqueue_init() so the state is
> > > initialized consistently for both newly created and reset virtqueues.
> > >
> > > Fixes: f6a15d854986 ("virtio_ring: add in order support")
> >
> > I think this is needed for -stable.
> >
> > > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c
> > > b/drivers/virtio/virtio_ring.c index db678f5..d0dc464 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -559,6 +559,11 @@ static void virtqueue_init(struct vring_virtqueu=
e *vq,
> > u32 num)
> > >         vq->in_use =3D false;
> > >         vq->last_add_time_valid =3D false;  #endif
> > > +
> > > +       if (virtqueue_is_in_order(vq)) {
> > > +               vq->free_head =3D 0;
> > > +               vq->batch_last.id =3D UINT_MAX;
> > > +       }
> >
> > I would try to reuse or refactor virtqueue_vring_attach_split() to redu=
ce code
> > duplication.
> >
> > Btw have you checked Qemu shadow virtqueue as it might suffer from the =
same
> > issue.
> >
>
> I checked QEMU's shadow virtqueue implementation. batch_last is reinitial=
ized in vhost_svq_start(),
> but free_head is not. Since the SVQ object can be reused across stop/star=
t, free_head may retain stale
> state. So a corresponding fix should be needed
>
> void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
>                       VirtQueue *vq, VhostIOVATree *iova_tree)
>  {
>      ...
>      svq->shadow_avail_idx =3D 0;
>      svq->shadow_used_idx =3D 0;
> +    svq->free_head =3D 0;
>      memset(&svq->batch_last, 0, sizeof(svq->batch_last));
>      svq->last_used =3D 0;
>      svq->last_used_idx =3D 0;
>

I'll ack this patch if it is sent to the QEMU mailing list, but the
guest is not able to reset a virtqueue without deallocating it as far
as I know. Do you have a reproducer or something similar?

