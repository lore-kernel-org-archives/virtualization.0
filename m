Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF391974FA
	for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720636780; cv=none; b=Ai2Sh7O0VVWieAv4J2cUmZikzJzlmAU+n0jlqEDMaWISJwgMVfE3BIYZSglBLmpSzjxYcr6b72G93lJCZHer2KNBRU3by7OvrqV021fHLa8Kxb6w4IFYEr7rAQLpPYqhz6eF47Vfu9s/yvbL4Q8VFzSRRBaFlIgw7bT/iymQvzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720636780; c=relaxed/simple;
	bh=jl/G74jU3/LJKTndyg9Ir8ZK6ZCpRMd0UXIwTJV5u7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mkVE47gh9Dqap+WprY5hKCjyFRBJK8EO0E4UKPyWvzdZ/64TNU+X+/FExDArr7EJr4H2y4KXC+GaDfc8qFOAWpSz1XLnVDhBFwXwbS6YmNKjYdz+C/dJ4Se4+ahDE9clRpXwcMsgtWq3gM/sjaJ6EFeABCy5bl2LyCLCpZDTYQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jSmaqxqz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jSmaqxqz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720636777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Wa91XRdvflqoUl4ERsLfqpwV8EWmy2Wo2L5wqHiP4U=;
	b=jSmaqxqzg/ScCgZ5PGH3OrZtYgzWZ75rrhmNt0ez+D0RTaEFbwcuwEhIw7fP/294DZjhu/
	eU9QSax91TiznGck3rZAD83ymRFCc3ipUcvdnt39E654q4W6demosPcWDAZpBJp/aEXhLW
	8tILncGZMhdYjDumW6OwT7iQgarhOKg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-Kaw7JVpcNu2uEykfdJjjqA-1; Wed, 10 Jul 2024 14:39:34 -0400
X-MC-Unique: Kaw7JVpcNu2uEykfdJjjqA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42725d3ae3eso430985e9.3
        for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 11:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720636773; x=1721241573;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Wa91XRdvflqoUl4ERsLfqpwV8EWmy2Wo2L5wqHiP4U=;
        b=HM5PYPckmtK3whofhp+8cdEXHvEcKTBJxYkVVb/sezm2yNZL7yJuZmA5azokbRBkAm
         Me/QSTgNLPXO8+a6y7luALN9IYCKwzBxpidKOViQCa8XDqMTF/s3sp2K6GCMTuxqqQWl
         BwwlGK/8eO/o3jf5MHCJBYNNfYB3qQAKUvok3Z8/B79+hsaXJdvxbqeqE//M+GR4dz3b
         +xo+oMPKh3otWvMXI8eY7/GoqYyeQ/BQaB9FpVQ0jgpJRHw6QNxCPbavP2wy4XZv17T5
         HsB8LmQO+vintGAkIStSDOdAf+8H3Y5Lei9khbcPr20Qr/DA1SLNNeU2LWoDm1ZBMesV
         ANSw==
X-Forwarded-Encrypted: i=1; AJvYcCXGeuBHF/MQV8Azi2sN0QqwTuCB0skpuMoTHOxbc3iFxouVlkDLRFudxGPoDO1N+JPsJ/+K8E+veWLLyuT5kNh/vdae1elwrVuEZx+0Lbw=
X-Gm-Message-State: AOJu0YwUORRU9IvKEVcoQTf9vK8lNsd6hs1dn2a8iPN5Pm+ZYBSty69i
	kOdgoylyqlAFt2qJrXcGeoIzTaFIg3LjRRrD61Zui3P7VqSNQK1hKNJRXQfRTYGNtIf6bh4pjwW
	9QGoYUHn5T33Q/N13rhb3g/2bIpDh68137DcoHyMGlVZsqLU2bbX60GiuQWxaZJVA
X-Received: by 2002:a7b:c458:0:b0:426:64f5:b10d with SMTP id 5b1f17b1804b1-426707db59bmr38554145e9.14.1720636773021;
        Wed, 10 Jul 2024 11:39:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG74ZhHPUOEWOdKZQANHlo67lTxvcQgP6YunxBETGdCT6l5hx3iAl/9nDeoE0ZV+lKH4kLIVQ==
X-Received: by 2002:a7b:c458:0:b0:426:64f5:b10d with SMTP id 5b1f17b1804b1-426707db59bmr38553905e9.14.1720636772416;
        Wed, 10 Jul 2024 11:39:32 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:f6ae:a6e3:8cbc:2cbd:b8ff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427270238a6sm57772915e9.20.2024.07.10.11.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 11:39:31 -0700 (PDT)
Date: Wed, 10 Jul 2024 14:39:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Verkamp <dverkamp@chromium.org>
Cc: linux-kernel@vger.kernel.org,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	linux-um@lists.infradead.org, linux-remoteproc@vger.kernel.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] virtio: fix vq # for balloon
Message-ID: <20240710142239-mutt-send-email-mst@kernel.org>
References: <cover.1720611677.git.mst@redhat.com>
 <3d655be73ce220f176b2c163839d83699f8faf43.1720611677.git.mst@redhat.com>
 <CABVzXAnjAdQqVNtir_8SYc+2dPC-weFRxXNMBLRcmFsY8NxBhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CABVzXAnjAdQqVNtir_8SYc+2dPC-weFRxXNMBLRcmFsY8NxBhQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jul 10, 2024 at 11:12:34AM -0700, Daniel Verkamp wrote:
> On Wed, Jul 10, 2024 at 4:43 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > virtio balloon communicates to the core that in some
> > configurations vq #s are non-contiguous by setting name
> > pointer to NULL.
> >
> > Unfortunately, core then turned around and just made them
> > contiguous again. Result is that driver is out of spec.
> 
> Thanks for fixing this - I think the overall approach of the patch looks good.
> 
> > Implement what the API was supposed to do
> > in the 1st place. Compatibility with buggy hypervisors
> > is handled inside virtio-balloon, which is the only driver
> > making use of this facility, so far.
> 
> In addition to virtio-balloon, I believe the same problem also affects
> the virtio-fs device, since queue 1 is only supposed to be present if
> VIRTIO_FS_F_NOTIFICATION is negotiated, and the request queues are
> meant to be queue indexes 2 and up. From a look at the Linux driver
> (virtio_fs.c), it appears like it never acks VIRTIO_FS_F_NOTIFICATION
> and assumes that request queues start at index 1 rather than 2, which
> looks out of spec to me, but the current device implementations (that
> I am aware of, anyway) are also broken in the same way, so it ends up
> working today. Queue numbering in a spec-compliant device and the
> current Linux driver would mismatch; what the driver considers to be
> the first request queue (index 1) would be ignored by the device since
> queue index 1 has no function if F_NOTIFICATION isn't negotiated.


Oh, thanks a lot for pointing this out!

I see so this patch is no good as is, we need to add a workaround for
virtio-fs first.

QEMU workaround is simple - just add an extra queue. But I did not
reasearch how this would interact with vhost-user.

From driver POV, I guess we could just ignore queue # 1 - would that be
ok or does it have performance implications?
Or do what I did for balloon here: try with spec compliant #s first,
if that fails then assume it's the spec issue and shift by 1.


> [...]
> > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > index 7d82facafd75..fa606e7321ad 100644
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -293,7 +293,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
> >         struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> >         struct virtqueue_info *vqi;
> >         u16 msix_vec;
> > -       int i, err, nvectors, allocated_vectors, queue_idx = 0;
> > +       int i, err, nvectors, allocated_vectors;
> >
> >         vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
> >         if (!vp_dev->vqs)
> > @@ -332,7 +332,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
> >                         msix_vec = allocated_vectors++;
> >                 else
> >                         msix_vec = VP_MSIX_VQ_VECTOR;
> > -               vqs[i] = vp_setup_vq(vdev, queue_idx++, vqi->callback,
> > +               vqs[i] = vp_setup_vq(vdev, i, vqi->callback,
> >                                      vqi->name, vqi->ctx, msix_vec);
> >                 if (IS_ERR(vqs[i])) {
> >                         err = PTR_ERR(vqs[i]);
> > @@ -368,7 +368,7 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
> >                             struct virtqueue_info vqs_info[])
> >  {
> >         struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > -       int i, err, queue_idx = 0;
> > +       int i, err;
> >
> >         vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
> >         if (!vp_dev->vqs)
> > @@ -388,8 +388,13 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
> >                         vqs[i] = NULL;
> >                         continue;
> >                 }
> > +<<<<<<< HEAD
> >                 vqs[i] = vp_setup_vq(vdev, queue_idx++, vqi->callback,
> >                                      vqi->name, vqi->ctx,
> > +=======
> > +               vqs[i] = vp_setup_vq(vdev, i, callbacks[i], names[i],
> > +                                    ctx ? ctx[i] : false,
> > +>>>>>>> f814759f80b7... virtio: fix vq # for balloon
> 
> This still has merge markers in it.
> 
> Thanks,
> -- Daniel

