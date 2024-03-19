Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4961B57885
	for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 08:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710838195; cv=none; b=oX4LYfthkBXtoSsMCmyrZxQO6IghHmlukAUZxcRiNUnUIHuJpnzlIr7Lzb81cKxzkmxML20GwYoLPAVH179XVzHUVaMIVDJHc99EHAiSfIh658FcBYqsMvXewVvOVdBSg1pt+29+XjYhxTaVw3hG5uZCz/1GiXgTNv/2wWGsPUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710838195; c=relaxed/simple;
	bh=k20h/gra/8Yp7OXx8XlMFpX1tZP75XML8xy6RbIIqDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=vAG3fMGBnQ+fpkfMSY96BLDyg6YccuyVOeslH9Jx5F9kYT4Hhp8FIqhKehbgfB8A3EGilJZouI2a0OqcvEZfeW09OX+k8oBfoXom7ytkTJ36sX+r0hijoyM4EhyeiJNiqKR/ri80uNv702l/89AaGc72KzhxDT5TkRuH9Cc718U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GC9i5oKR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GC9i5oKR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710838192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/WohdgPgBQLxOCq0Jnnwxvvgxi6wjhKyeRiLGXAYd2s=;
	b=GC9i5oKRsdW3Zw7uzsrNbs/JFMvPqzp6wjMSwJGsvX7tNHH/bkQMTl9lVy0kVNr6xiuJvS
	4WH39JskGrnUxiILHXqQKQC2Iigu7iDtVL4QW9/lSLfs7hbenfehGVzFh2K6F1yLpc9pVQ
	6ugNwqDjL7leK2WNc2Ur8HHH2amUWHQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-R5VSLjl5O3atDOZv7fi7dw-1; Tue, 19 Mar 2024 04:49:50 -0400
X-MC-Unique: R5VSLjl5O3atDOZv7fi7dw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4140edcb197so11461625e9.1
        for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 01:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710838189; x=1711442989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WohdgPgBQLxOCq0Jnnwxvvgxi6wjhKyeRiLGXAYd2s=;
        b=K7pKbxz3y8/cnM7BQBms7xxgfp3bEuKOIg5EJ+4xfV42kHgRQAqIpARBfEkogRGpq6
         g+HQFrlMP+LRT8mnY6U5SqAFZzVDdcDU7Orz85EoVQlv3IYMUKvUEeg64yKGOZ7VlVlc
         ApOGVoaCoC94p/Fki5EXPeQr3grpZttXsanv6pf+nhKwMpnOnRKBYGMqBj6QlkYFi0vz
         mho9NoCTqu/lg/adyuecufwzutv3eNX4+WPszrCgg2YtUcm4q/70qeLKTvff2eKxj1a1
         +jrSiPaeL519mANltGz+R8pdyrQNhOfiJS6HN46dtoOKQoJarqYQxiuDpoO6XIH6bPu8
         IEyw==
X-Forwarded-Encrypted: i=1; AJvYcCXFCVEPcIVEk/zi5ryTLQP/ccMSpHin/V51OnjIfqnw+sQ6r4tn5j3ZIeKTHyuvUUL47Advydj6YfYkoc36OSadqF+WkUwtCNZ6cdBE+5k=
X-Gm-Message-State: AOJu0Yw38yxCkXL7jRTZYrmxXpKOnqJL70YrnLd2oZBPWWwFt3olFeM2
	WUmbwUAQGrYay6D8OryPFL0o2A3gJ0Zzi/aIrdP09c9zvm3bg8OT/RgBxnOkmU0fl9LdG+EPo7U
	WdOVbb5cflEcFdNQFof4BdLy+yn7mYPDIZFfOc5zoLTtOruHg7ZuBF2swlAiaJcYi
X-Received: by 2002:a05:600c:4f0e:b0:414:1363:53a4 with SMTP id l14-20020a05600c4f0e00b00414136353a4mr2982559wmq.15.1710838189084;
        Tue, 19 Mar 2024 01:49:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2vmirEEIpmgvouK03uixipQW7NF0Cv3jiRA56Jl0MaFtjCJ6YaTZjGRO7zI4YB0gF25PTYw==
X-Received: by 2002:a05:600c:4f0e:b0:414:1363:53a4 with SMTP id l14-20020a05600c4f0e00b00414136353a4mr2982539wmq.15.1710838188518;
        Tue, 19 Mar 2024 01:49:48 -0700 (PDT)
Received: from redhat.com ([2.52.6.254])
        by smtp.gmail.com with ESMTPSA id l12-20020a05600c4f0c00b0041409d4841dsm9292994wmq.33.2024.03.19.01.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 01:49:47 -0700 (PDT)
Date: Tue, 19 Mar 2024 04:49:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Will Deacon <will@kernel.org>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, yihyu@redhat.com, shan.gavin@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>, mochs@nvidia.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <20240319043045-mutt-send-email-mst@kernel.org>
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240318165924.GA1824@willie-the-truck>
 <35a6bcef-27cf-4626-a41d-9ec0a338fe28@redhat.com>
 <20240319020905-mutt-send-email-mst@kernel.org>
 <9b3030d1-cb2c-4ce0-8b24-1074b616fc84@redhat.com>
 <20240319024025-mutt-send-email-mst@kernel.org>
 <d8387677-7025-4daa-b8b5-5a8f24a671d5@redhat.com>
 <20240319030505-mutt-send-email-mst@kernel.org>
 <e582f248-28e9-4d0b-aa5d-26b82cd96a68@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <e582f248-28e9-4d0b-aa5d-26b82cd96a68@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 19, 2024 at 06:08:27PM +1000, Gavin Shan wrote:
> On 3/19/24 17:09, Michael S. Tsirkin wrote:
> > On Tue, Mar 19, 2024 at 04:49:50PM +1000, Gavin Shan wrote:
> > > 
> > > On 3/19/24 16:43, Michael S. Tsirkin wrote:
> > > > On Tue, Mar 19, 2024 at 04:38:49PM +1000, Gavin Shan wrote:
> > > > > On 3/19/24 16:09, Michael S. Tsirkin wrote:
> > > > > 
> > > > > > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > > > > > index 49299b1f9ec7..7d852811c912 100644
> > > > > > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > > > > > @@ -687,9 +687,15 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > > > > > > > >      	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> > > > > > > > >      	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> > > > > > > > > -	/* Descriptors and available array need to be set before we expose the
> > > > > > > > > -	 * new available array entries. */
> > > > > > > > > -	virtio_wmb(vq->weak_barriers);
> > > > > > > > > +	/*
> > > > > > > > > +	 * Descriptors and available array need to be set before we expose
> > > > > > > > > +	 * the new available array entries. virtio_wmb() should be enough
> > > > > > > > > +	 * to ensuere the order theoretically. However, a stronger barrier
> > > > > > > > > +	 * is needed by ARM64. Otherwise, the stale data can be observed
> > > > > > > > > +	 * by the host (vhost). A stronger barrier should work for other
> > > > > > > > > +	 * architectures, but performance loss is expected.
> > > > > > > > > +	 */
> > > > > > > > > +	virtio_mb(false);
> > > > > > > > >      	vq->split.avail_idx_shadow++;
> > > > > > > > >      	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
> > > > > > > > >      						vq->split.avail_idx_shadow);
> > > > > > > > 
> > > > > > > > Replacing a DMB with a DSB is _very_ unlikely to be the correct solution
> > > > > > > > here, especially when ordering accesses to coherent memory.
> > > > > > > > 
> > > > > > > > In practice, either the larger timing different from the DSB or the fact
> > > > > > > > that you're going from a Store->Store barrier to a full barrier is what
> > > > > > > > makes things "work" for you. Have you tried, for example, a DMB SY
> > > > > > > > (e.g. via __smb_mb()).
> > > > > > > > 
> > > > > > > > We definitely shouldn't take changes like this without a proper
> > > > > > > > explanation of what is going on.
> > > > > > > > 
> > > > > > > 
> > > > > > > Thanks for your comments, Will.
> > > > > > > 
> > > > > > > Yes, DMB should work for us. However, it seems this instruction has issues on
> > > > > > > NVidia's grace-hopper. It's hard for me to understand how DMB and DSB works
> > > > > > > from hardware level. I agree it's not the solution to replace DMB with DSB
> > > > > > > before we fully understand the root cause.
> > > > > > > 
> > > > > > > I tried the possible replacement like below. __smp_mb() can avoid the issue like
> > > > > > > __mb() does. __ndelay(10) can avoid the issue, but __ndelay(9) doesn't.
> > > > > > > 
> > > > > > > static inline int virtqueue_add_split(struct virtqueue *_vq, ...)
> > > > > > > {
> > > > > > >        :
> > > > > > >            /* Put entry in available array (but don't update avail->idx until they
> > > > > > >             * do sync). */
> > > > > > >            avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> > > > > > >            vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> > > > > > > 
> > > > > > >            /* Descriptors and available array need to be set before we expose the
> > > > > > >             * new available array entries. */
> > > > > > >            // Broken: virtio_wmb(vq->weak_barriers);
> > > > > > >            // Broken: __dma_mb();
> > > > > > >            // Work:   __mb();
> > > > > > >            // Work:   __smp_mb();
> > > > > > >            // Work:   __ndelay(100);
> > > > > > >            // Work:   __ndelay(10);
> > > > > > >            // Broken: __ndelay(9);
> > > > > > > 
> > > > > > >           vq->split.avail_idx_shadow++;
> > > > > > >            vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
> > > > > > >                                                    vq->split.avail_idx_shadow);
> > > > > > 
> > > > > > What if you stick __ndelay here?
> > > > > > 
> > > > > 
> > > > >          /* Put entry in available array (but don't update avail->idx until they
> > > > >            * do sync). */
> > > > >           avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> > > > >           vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> > > > > 
> > > > >           /* Descriptors and available array need to be set before we expose the
> > > > >            * new available array entries. */
> > > > >           virtio_wmb(vq->weak_barriers);
> > > > >           vq->split.avail_idx_shadow++;
> > > > >           vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
> > > > >                                                   vq->split.avail_idx_shadow);
> > > > >           /* Try __ndelay(x) here as Michael suggested
> > > > >            *
> > > > >            * Work:      __ndelay(200);    possiblly make it hard to reproduce
> > > > >            * Broken:    __ndelay(100);
> > > > >            * Broken:    __ndelay(20);
> > > > >            * Broken:    __ndelay(10);
> > > > >            */
> > > > >           __ndelay(200);
> > > > 
> > > > So we see that just changing the timing masks the race.
> > > > What are you using on the host side? vhost or qemu?
> > > > 
> > > 
> > > __ndelay(200) may make the issue harder to be reproduce as I understand.
> > > More delays here will give vhost relief, reducing the race.
> > > 
> > > The issue is only reproducible when vhost is turned on. Otherwise, we
> > > aren't able to hit the issue.
> > > 
> > >     -netdev tap,id=vnet0,vhost=true,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown \
> > >     -device virtio-net-pci,bus=pcie.8,netdev=vnet0,mac=52:54:00:f1:26:b0
> > 
> > 
> > Given it's vhost, it's also possible that the issue is host side.
> > I wonder what happens if we stick a delay or a stronger barrier
> > in vhost.c - either here:
> > 
> >          /* Make sure buffer is written before we update index. */
> >          smp_wmb();
> > 
> > 
> > or here:
> > 
> >                  /* Only get avail ring entries after they have been
> >                   * exposed by guest.
> >                   */
> >                  smp_rmb();
> > 
> > ?
> > 
> 
> It's possible. However, I still can hit the issue after both of them are
> replaed with '__mb()'. So the issue seems on the guest side, where the
> written data isn't observed in time by the CPU on far end (for vhost worker).
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 045f666b4f12..327b68d21b02 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2529,7 +2529,8 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
>                 /* Only get avail ring entries after they have been
>                  * exposed by guest.
>                  */
> -               smp_rmb();
> +               // smp_rmb();
> +               __mb();
>         }
>         /* Grab the next descriptor number they're advertising, and increment
> @@ -2703,7 +2704,9 @@ int vhost_add_used_n(struct vhost_virtqueue *vq, struct vring_used_elem *heads,
>         r = __vhost_add_used_n(vq, heads, count);
>         /* Make sure buffer is written before we update index. */
> -       smp_wmb();
> +       // smp_wmb();
> +       __mb();
> +
> 
> From the guest:
> 
> [   14.102608] virtio_net virtio0: output.0:id 80 is not a head!


You realize however that for that to happen, first vhost has to
use the wrong index?
Again the fact tweaking code helps is suggestive but does
not lead us to the root cause.

So you should be able to detect the bad index when vhost gets it.
Here's a suggestion: stick a valid flag in desc.
then vhost should notice if it gets a desc with that flag clear.
Like this maybe?


diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 6f7e5010a673..2789e51b57e6 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -524,7 +524,7 @@ static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq,
 	struct vring_desc_extra *extra = vring->split.desc_extra;
 	u16 next;
 
-	desc[i].flags = cpu_to_virtio16(vq->vdev, flags);
+	desc[i].flags = cpu_to_virtio16(vq->vdev, flags | (0x1 << 5)); /* Mark it valid */
 	desc[i].addr = cpu_to_virtio64(vq->vdev, addr);
 	desc[i].len = cpu_to_virtio32(vq->vdev, len);
 
@@ -721,6 +721,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 			i = virtio16_to_cpu(_vq->vdev, desc[i].next);
 		} else
 			i = vring_unmap_one_split(vq, i);
+		desc[i].flags = 0x0;
 	}
 
 free_indirect:
@@ -775,11 +776,13 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 	i = head;
 
 	while (vq->split.vring.desc[i].flags & nextflag) {
+		vq->split.vring.desc[i].flags = 0x0;
 		vring_unmap_one_split(vq, i);
 		i = vq->split.desc_extra[i].next;
 		vq->vq.num_free++;
 	}
 
+	vq->split.vring.desc[i].flags = 0x0;
 	vring_unmap_one_split(vq, i);
 	vq->split.desc_extra[i].next = vq->free_head;
 	vq->free_head = head;

