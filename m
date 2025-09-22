Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C4E3C01
	for <virtualization@lists.linux.dev>; Mon, 22 Sep 2025 01:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758502864; cv=none; b=a7EYFoinMy08uIihbzVYTFalzUtWUouN9asonLpQOu4zUVx/uzDgBDdRZCcu+/VavNqRO5EGy2vtbdTpw4kb2xY1NrsC8/l7zqAvh2H+bjTnxUWaUohuavVDRh8xTrbufSicY8pT7QN5Rwcldg3M3UDhEdTAR+PiwJuooSdNlC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758502864; c=relaxed/simple;
	bh=mAJwI4282ZDPMPK+aaLEUg17n0kAO3+PXNVRWl5r/aU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWk+ceygdDbUqksmp1uX+oKYt3prVvKnZ4wKmeA5bRJlgWTJ6KrepmnYksPaj+vpJ9GA4jEmpZaTXdnfkLvep9QSwqPUAJ90jLeEyrZeclSzyN+b8FZPLNTzy5hGy+3i4YDPNUMtJ3JQyHBNzD3Jqj7AmW+kg1aLiFDTg+jczAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OsSP1qEM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OsSP1qEM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758502862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bKfB0/QKjYa5EHj4yXuFIM6ZFlGsSX0BgKB57pXFWGA=;
	b=OsSP1qEMEztGN2sRi5mExwBKBgeivZabhxvVRaipf4KHLVFc9OTSVzBVxUcoM3Qu3ooz1c
	WqR8D2GTFXkg6ezf2QTPKOujEawDntXLPbYG3ho2ilIhec3MEf6d7m9uclZfNmub9Oe69C
	HfUyRfYTyMRAvsj/F4i7oCs2qPD2CoM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-z7Naqw86NGK3KQ0c7_MZSw-1; Sun, 21 Sep 2025 21:00:59 -0400
X-MC-Unique: z7Naqw86NGK3KQ0c7_MZSw-1
X-Mimecast-MFC-AGG-ID: z7Naqw86NGK3KQ0c7_MZSw_1758502858
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3324538ceb0so1671325a91.1
        for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 18:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758502858; x=1759107658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bKfB0/QKjYa5EHj4yXuFIM6ZFlGsSX0BgKB57pXFWGA=;
        b=sxNccb+evQHJaV45z9OEgJmrc/kB2m2McYqtT4fRtPN8A8CdUsKkwauyu/t49llkZu
         C1w8LWoqFureY6ukrqiV5lB7dRdH/uWQST+xDR9qfs/d4aCvHHmvht7paAQefI97f1/8
         XHWeWWFM7b9P75qsJJgn7EiT/mtlj9tbkvq5pgX1XTib3s0rGJ2qfvEcFOxABekThIXQ
         ECO9mk1w6XGbLEnQXObxG4hrrJ+n1acaXw541J15mV1DPUHR3JhXvot8qKU4mpMAj4Ez
         JCwsvjVAUWzKYSOzYhbYw2aaYZf20DQb+Dkw6N4qvRYMUslTzxF4t22LZBH8Mwx28xVz
         2Enw==
X-Forwarded-Encrypted: i=1; AJvYcCUtC1EPMYMIh8uLRJhvR3wzM8s540vKVRy6DmVPReqfAfxGsS48fHY9g9oLOwTl1ybWyXGaKyktx6c3cmQo8w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzGDz9k7pC+Q3CmM5x6IYxInhW0yasVn4K1ZU+edhMw7bzoY3AF
	lckwtE9cWVre/6cWeX7/yPQ+vvp321BNFKTY3G9EDMcPqTR4qFzJVQ8t2EgJiAccMMMUDKOZyCv
	+Grii5tCuh0q9Tqwr+rRWJWdGFrqOt0W6rx0Eo10hWGL0h1U+fm0uFR10Wgd5udQBGDPfug6gcd
	fEfmQg6HcQG/rA8XtE702Oyric2x0inYKebHy1YzHOpJ0=
X-Gm-Gg: ASbGncuvlQP5s8fozij9aO1u1hzDWxe4vGv1RFAVsvUlr2lh9SGwFYFRpiEB+6SVRrD
	r4ntNwqDNFT2FZyy8SBpAoIaCQE43KPkUoIzL5it4Q0jIXRvzJrrvWDor+kHsn5vFdgwdH9Eb80
	d6bRafq4CijAZahq2tzJzAFA==
X-Received: by 2002:a17:90b:3a48:b0:32e:a650:3ed5 with SMTP id 98e67ed59e1d1-330983817aemr12058379a91.31.1758502858141;
        Sun, 21 Sep 2025 18:00:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLZz+Qc8bnkgDeBSLJdsDeUY71+Q67GmWu7okPrXkBs2XjlOs5L4tIZeAfED1wye0qrXWSxp6okx514jPYN/8=
X-Received: by 2002:a17:90b:3a48:b0:32e:a650:3ed5 with SMTP id
 98e67ed59e1d1-330983817aemr12058335a91.31.1758502857615; Sun, 21 Sep 2025
 18:00:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250919073154.49278-1-jasowang@redhat.com> <20250919073154.49278-14-jasowang@redhat.com>
 <20250921143217-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250921143217-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Sep 2025 09:00:45 +0800
X-Gm-Features: AS18NWAcZG3mF30zT9ro015BT23AMPKeqQ63N5iOYfT0LpuxO_G50-YKXCOjPgA
Message-ID: <CACGkMEtfDr7v2HECZMSSrR97eZjwbT_wTuDtcX312ObqgE=Jhg@mail.gmail.com>
Subject: Re: [PATCH V6 13/19] virtio_ring: introduce virtqueue ops
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ta-jGuNmXoPmXtIcOIkb3p2faGPFbsGlaHB7e9bZV5s_1758502858
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 2:33=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Sep 19, 2025 at 03:31:48PM +0800, Jason Wang wrote:
> > This patch introduces virtqueue ops which is a set of the callbacks
> > that will be called for different queue layout or features. This would
> > help to avoid branches for split/packed and will ease the future
> > implementation like in order.
> >
> > Note that in order to eliminate the indirect calls this patch uses
> > global array of const ops to allow compiler to avoid indirect
> > branches.
> >
> > Tested with CONFIG_MITIGATION_RETPOLINE, no performance differences
> > were noticed.
> >
> > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 173 ++++++++++++++++++++++++++---------
> >  1 file changed, 130 insertions(+), 43 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index b1b6af297061..1045c553ee65 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -67,6 +67,12 @@
> >  #define LAST_ADD_TIME_INVALID(vq)
> >  #endif
> >
> > +enum vq_layout {
> > +     SPLIT =3D 0,
> > +     PACKED,
> > +     VQ_TYPE_MAX,
> > +};
> > +
> >  struct vring_desc_state_split {
> >       void *data;                     /* Data for callback. */
> >
> > @@ -159,12 +165,28 @@ struct vring_virtqueue_packed {
> >       size_t event_size_in_bytes;
> >  };
> >
> > +struct vring_virtqueue;
> > +
> > +struct virtqueue_ops {
> > +     int (*add)(struct vring_virtqueue *_vq, struct scatterlist *sgs[]=
,
> > +                unsigned int total_sg, unsigned int out_sgs,
> > +                unsigned int in_sgs, void *data,
> > +                void *ctx, bool premapped, gfp_t gfp);
>
> Why is it _vq here?

Fixed.

>
>
> > +     void *(*get)(struct vring_virtqueue *vq, unsigned int *len, void =
**ctx);
> > +     bool (*kick_prepare)(struct vring_virtqueue *vq);
> > +     void (*disable_cb)(struct vring_virtqueue *vq);
> > +     bool (*enable_cb_delayed)(struct vring_virtqueue *vq);
> > +     unsigned int (*enable_cb_prepare)(struct vring_virtqueue *vq);
> > +     bool (*poll)(const struct vring_virtqueue *vq, u16 last_used_idx)=
;
> > +     void *(*detach_unused_buf)(struct vring_virtqueue *vq);
> > +     bool (*more_used)(const struct vring_virtqueue *vq);
> > +     int (*resize)(struct vring_virtqueue *vq, u32 num);
> > +     void (*reset)(struct vring_virtqueue *vq);
> > +};
> > +
> >  struct vring_virtqueue {
> >       struct virtqueue vq;
> >
> > -     /* Is this a packed ring? */
> > -     bool packed_ring;
> > -
> >       /* Is DMA API used? */
> >       bool use_map_api;
> >
> > @@ -180,6 +202,8 @@ struct vring_virtqueue {
> >       /* Host publishes avail event idx */
> >       bool event;
> >
> > +     enum vq_layout layout;
> > +
> >       /* Head of free buffer list. */
> >       unsigned int free_head;
> >       /* Number we've added since last sync. */
> > @@ -231,6 +255,12 @@ static void vring_free(struct virtqueue *_vq);
> >
> >  #define to_vvq(_vq) container_of_const(_vq, struct vring_virtqueue, vq=
)
> >
> > +
>
> why the extra empty line?
>

And fix this.

Thanks

