Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D60633C19A
	for <virtualization@lists.linux.dev>; Tue,  3 Feb 2026 12:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770120153; cv=none; b=pbZriJF0rAeV1min+YOcwt1iORD3oXK8bhEVP62FcGlafX5HV5DZTdS6sbQ10PsBVtUPVjAJMk+kArddTIOrl5HONwaJLbAdhge8k3JNMXjkWkNM1pi/vdjWY8RsbkOq/XAU5YGaoZZaipPM8DolE/Zur0FyYwQSc47vqky4DEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770120153; c=relaxed/simple;
	bh=Hwhc4x2WfdwOZK+OJPmSWLUnsjg35OvmJI9yzaMB7UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=twx7xvAVzgqckDOJREbCtAbCBOk51ua+94r/jEkbYboHhpaSpLz/a+V3voeUTHG/QyWAmjhAHnUhZKyp5tvylYZ2PS9i1WSw4eZ+xBzq+HUO/E2Ja0elb0LVtveVwT0fgrdZHjaA/9r50UdO2qVNvAqNUukhaJ3CqxDq/j4TWis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A02VYRAc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A02VYRAc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770120150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bsFb6G89eaHJioHtnihfU+Eir4eP2AJ6k/uAy6FwbCc=;
	b=A02VYRAckUUH6G906mKLpaEALs7JIBkqewAA0zgJKfz9XPAllmOYUHn+TW/HDavRDxYjmg
	G7frrxV6f+GlPmwKyZjJ4p/zrJhy8k70OBipEntbIyKOHFcbDmsVSWh68z/Jt4iSK7x+df
	GuvZY80aHD9ABP+EIWmgEtp2rKiTOu4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-fnM7_p6bNjKUfpoXFvTR_Q-1; Tue, 03 Feb 2026 07:02:29 -0500
X-MC-Unique: fnM7_p6bNjKUfpoXFvTR_Q-1
X-Mimecast-MFC-AGG-ID: fnM7_p6bNjKUfpoXFvTR_Q_1770120148
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-435a2de6ec0so3333804f8f.0
        for <virtualization@lists.linux.dev>; Tue, 03 Feb 2026 04:02:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770120148; x=1770724948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bsFb6G89eaHJioHtnihfU+Eir4eP2AJ6k/uAy6FwbCc=;
        b=togKes/0Hn8O4yHDKH0YK09ttas834mYzzOWWGKyBoWlDphG2LLB1+5jKFUiwahcsT
         XZdzo+Z/EFPk2gWsvwAnEM/HTQEh9+m+aea5q9SgbQWUfKLeK9iKiA25PixWyfMhKwed
         SEgRog4r1HnvGBb30vU9Efs4yv3y+74qmUtgmWybusxI8VuCrpblGbMETboTkjwlxmGn
         0a+gSnIrTqdxpM94J4wwEshR6sqp25p+BkHLaBU0Yi8Ej6DiuGsQZbvUWKpimeMsTSbo
         JkYLadAQlY3LgNYIzsSjb6P50YXiUhzaRaF5EGbcAcKhPd4AdrUGuvT2dpQplmfkxdU+
         J6SQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIRBbG0AqzMv1KM0wEqjVxFa+81ZlX0lPtxh4I5iLmeHM9QdJjX4h06dTb5QYyXwBCQxG+Oybj07+oEOi3ww==@lists.linux.dev
X-Gm-Message-State: AOJu0YwR4uPTlb4msHe9dalUHW6h07t+lvcnk009+DaE0RPD+GyTyDoc
	8wx2B7sMDG+y1JMPd6T/CmrdUepcnxJ1YZpfMi6gSEabtOzAYFOG6IQ8OObzHiTazqTWc35pBe3
	dXWxNe7yJzvDKJ4gKugYsAcKbCSLB6x/ces9IxXxfF9d5htBVd2Hd3SPvxi88NZOX12gB
X-Gm-Gg: AZuq6aKXeKn/Xjoha+K0Z++RSPG9T2RFjSYnO4YQbw1SsvXFukNGpWwre9GcvnH5eKX
	6b7xmHH7GfA3AYNRd6UKVMNMtJwcik0hlVmH7bY7BXAjTLzay3kogboPTyGf9hjjdmfZrzfG/VA
	gLWrKSkgt8v/cRPby2bfO3Ae33TiDYmmuiitiuJg7iFTVKKyOw4tjEXE7+Q7Mym7wbye8QEwika
	7r9D7J7QWfSj1dxuoMYaOcTedffNgg2K8HNtEZ5Lzyj3UXWW26cxYEtrjNzFk13GZhQCw2XZlBY
	oxU9rE/cKk8tudRxUiZK0y6tRlhWKWre3J6Q1qskWF1OMXn/bREg+83LoP+oi8iYy4UaKy4bIEU
	p9mHOOLtgaXbOcnu/6nM3LDEU1+/Z9iq6TA==
X-Received: by 2002:a05:600c:348b:b0:47e:e779:36d with SMTP id 5b1f17b1804b1-482db4d826dmr165148975e9.23.1770120147811;
        Tue, 03 Feb 2026 04:02:27 -0800 (PST)
X-Received: by 2002:a05:600c:348b:b0:47e:e779:36d with SMTP id 5b1f17b1804b1-482db4d826dmr165148425e9.23.1770120147195;
        Tue, 03 Feb 2026 04:02:27 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482e256f639sm114827355e9.13.2026.02.03.04.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 04:02:26 -0800 (PST)
Date: Tue, 3 Feb 2026 07:02:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Alexander Graf <graf@amazon.com>, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"open list:VIRTIO CORE" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] virtio_ring: Add READ_ONCE annotations for
 device-writable fields
Message-ID: <20260203065312-mutt-send-email-mst@kernel.org>
References: <20260131102810.1254845-1-johannes.thumshirn@wdc.com>
 <1770107244.8746088-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1770107244.8746088-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cHYkahIoR4E-SWqFjRyHxIqLI76CroBCFX9D59Oc59U_1770120148
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 03, 2026 at 04:27:24PM +0800, Xuan Zhuo wrote:
> On Sat, 31 Jan 2026 11:28:09 +0100, Johannes Thumshirn <johannes.thumshirn@wdc.com> wrote:
> > From: Alexander Graf <graf@amazon.com>
> >
> > KCSAN reports data races when accessing virtio ring fields that are
> > concurrently written by the device (host). These are legitimate
> > concurrent accesses where the CPU reads fields that the device updates
> > via DMA-like mechanisms.
> >
> > Add accessor functions that use READ_ONCE() to properly annotate these
> > device-writable fields and prevent compiler optimizations that could in
> > theory break the code. This also serves as documentation showing which
> > fields are shared with the device.
> >
> > The affected fields are:
> > - Split ring: used->idx, used->ring[].id, used->ring[].len
> > - Packed ring: desc[].flags, desc[].id, desc[].len
> >
> > This patch was partially written using the help of Kiro, an
> > AI coding assistant, to automate the mechanical work of generating the
> > inline function definition.
> >
> > Signed-off-by: Alexander Graf <graf@amazon.com>
> > [jth: Add READ_ONCE in virtqueue_kick_prepare_split ]
> > Co-developed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > Reviewed-by: Alexander Graf <graf@amazon.com>
> > ---
> > Changes to v2:
> > - Add AI statement (agraf)
> > - Add R-b from agraf
> > - Update comment (mst)
> > - Add split to function names handling split rings (mst)
> > - Add vring_read_split_avail_event() (mst)
> >
> > Changes to v1:
> > - Updated comments (mst, agraf)
> > - Moved _read suffix to prefix in newly introduced functions (mst)
> > - Update my minor contribution to Co-developed-by (agraf)
> > - Add "in theory" to changelog
> > ---
> >  drivers/virtio/virtio_ring.c | 72 +++++++++++++++++++++++++++++-------
> >  1 file changed, 58 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index ddab68959671..53d5334576bc 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -222,6 +222,55 @@ struct vring_virtqueue {
> >  #endif
> >  };
> >
> > +/*
> > + * Accessors for device-writable fields in virtio rings.
> > + * These fields are concurrently written by the device and read by the driver.
> > + * Use READ_ONCE() to prevent compiler optimizations, document the
> > + * intentional data race and prevent KCSAN warnings.
> > + */
> > +static inline u16 vring_read_split_used_idx(const struct vring_virtqueue *vq)
> 
> "inline" is not recommended in *.c files.

why would it be? it's a compiler hint. given this is the hottest path,
it makes sense.


> Ohters LGTM.
> 
> Thanks.




> 
> > +{
> > +	return virtio16_to_cpu(vq->vq.vdev,
> > +			       READ_ONCE(vq->split.vring.used->idx));
> > +}
> > +
> > +static inline u32 vring_read_split_used_id(const struct vring_virtqueue *vq,
> > +					   u16 idx)
> > +{
> > +	return virtio32_to_cpu(vq->vq.vdev,
> > +			       READ_ONCE(vq->split.vring.used->ring[idx].id));
> > +}
> > +
> > +static inline u32 vring_read_split_used_len(const struct vring_virtqueue *vq, u16 idx)
> > +{
> > +	return virtio32_to_cpu(vq->vq.vdev,
> > +			       READ_ONCE(vq->split.vring.used->ring[idx].len));
> > +}
> > +
> > +static inline u16 vring_read_split_avail_event(const struct vring_virtqueue *vq)
> > +{
> > +	return virtio16_to_cpu(vq->vq.vdev,
> > +			       READ_ONCE(vring_avail_event(&vq->split.vring)));
> > +}
> > +
> > +static inline u16 vring_read_packed_desc_flags(const struct vring_virtqueue *vq,
> > +					       u16 idx)
> > +{
> > +	return le16_to_cpu(READ_ONCE(vq->packed.vring.desc[idx].flags));
> > +}
> > +
> > +static inline u16 vring_read_packed_desc_id(const struct vring_virtqueue *vq,
> > +				            u16 idx)
> > +{
> > +	return le16_to_cpu(READ_ONCE(vq->packed.vring.desc[idx].id));
> > +}
> > +
> > +static inline u32 vring_read_packed_desc_len(const struct vring_virtqueue *vq,
> > +				             u16 idx)
> > +{
> > +	return le32_to_cpu(READ_ONCE(vq->packed.vring.desc[idx].len));
> > +}
> > +
> >  static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num);
> >  static void vring_free(struct virtqueue *_vq);
> >
> > @@ -736,8 +785,7 @@ static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
> >  	LAST_ADD_TIME_INVALID(vq);
> >
> >  	if (vq->event) {
> > -		needs_kick = vring_need_event(virtio16_to_cpu(_vq->vdev,
> > -					vring_avail_event(&vq->split.vring)),
> > +		needs_kick = vring_need_event(vring_read_split_avail_event(vq),
> >  					      new, old);
> >  	} else {
> >  		needs_kick = !(vq->split.vring.used->flags &
> > @@ -808,8 +856,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> >
> >  static bool more_used_split(const struct vring_virtqueue *vq)
> >  {
> > -	return vq->last_used_idx != virtio16_to_cpu(vq->vq.vdev,
> > -			vq->split.vring.used->idx);
> > +	return vq->last_used_idx != vring_read_split_used_idx(vq);
> >  }
> >
> >  static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> > @@ -838,10 +885,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> >  	virtio_rmb(vq->weak_barriers);
> >
> >  	last_used = (vq->last_used_idx & (vq->split.vring.num - 1));
> > -	i = virtio32_to_cpu(_vq->vdev,
> > -			vq->split.vring.used->ring[last_used].id);
> > -	*len = virtio32_to_cpu(_vq->vdev,
> > -			vq->split.vring.used->ring[last_used].len);
> > +	i = vring_read_split_used_id(vq, last_used);
> > +	*len = vring_read_split_used_len(vq, last_used);
> >
> >  	if (unlikely(i >= vq->split.vring.num)) {
> >  		BAD_RING(vq, "id %u out of range\n", i);
> > @@ -923,8 +968,7 @@ static bool virtqueue_poll_split(struct virtqueue *_vq, unsigned int last_used_i
> >  {
> >  	struct vring_virtqueue *vq = to_vvq(_vq);
> >
> > -	return (u16)last_used_idx != virtio16_to_cpu(_vq->vdev,
> > -			vq->split.vring.used->idx);
> > +	return (u16)last_used_idx != vring_read_split_used_idx(vq);
> >  }
> >
> >  static bool virtqueue_enable_cb_delayed_split(struct virtqueue *_vq)
> > @@ -1701,10 +1745,10 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
> >  static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
> >  				       u16 idx, bool used_wrap_counter)
> >  {
> > -	bool avail, used;
> >  	u16 flags;
> > +	bool avail, used;
> >
> > -	flags = le16_to_cpu(vq->packed.vring.desc[idx].flags);
> > +	flags = vring_read_packed_desc_flags(vq, idx);
> >  	avail = !!(flags & (1 << VRING_PACKED_DESC_F_AVAIL));
> >  	used = !!(flags & (1 << VRING_PACKED_DESC_F_USED));
> >
> > @@ -1751,8 +1795,8 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> >  	last_used_idx = READ_ONCE(vq->last_used_idx);
> >  	used_wrap_counter = packed_used_wrap_counter(last_used_idx);
> >  	last_used = packed_last_used(last_used_idx);
> > -	id = le16_to_cpu(vq->packed.vring.desc[last_used].id);
> > -	*len = le32_to_cpu(vq->packed.vring.desc[last_used].len);
> > +	id = vring_read_packed_desc_id(vq, last_used);
> > +	*len = vring_read_packed_desc_len(vq, last_used);
> >
> >  	if (unlikely(id >= vq->packed.vring.num)) {
> >  		BAD_RING(vq, "id %u out of range\n", id);
> > --
> > 2.52.0
> >

