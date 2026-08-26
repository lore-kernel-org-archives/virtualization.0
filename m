Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D353EDAC9
	for <virtualization@lists.linux.dev>; Wed, 26 Aug 2026 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787748493; cv=none; b=b71y7Bv2Qk/irlsGyA6X2KtIgWBGLbejIdB+5KeaCSdZPjHU6qoEKxNNWpFDcotqcTI3BUA9BGWtbm4S8bZeOnTdFPIL/WYQuegJHP1xxnBI+H36OZJSJ4e4nF2Q7zbQNfZWtUK3b3PA8h7Hy1ETAvGi2I85zebJBlWe+1clZzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787748493; c=relaxed/simple;
	bh=mkg4QtfwwYq+ORlh9nX9VTEW1ZKT45yMar29IcyWmQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qy8jporycraYax/3TU901bAtT5U9Zeb7R+c/NjrtRpne9b+kx92WxUuYRDTBFagRKe4bZlJL4Srihh1L0UCcxiArth/Yc37Y4uvxC4PmabdmDMOn1qvr6NQ13cia2xKXWjjqlZ18yIIS0trRtM0ZprfA7W8SFhPHhyY8sZIW5ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BOn/Puhg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BOn/Puhg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787748490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oXf2T/BqatZTg+2wDJYVSXJ3LOzaGDIbEOiIluWNByM=;
	b=BOn/PuhgvvgdA3amw9yIBpD89ovCfj8UYrPhxeMigLWjxYV/3vG/WFy0RJptXp7WzkID7Q
	0kzy44QjqsxISOJ0wu77UUzEA0jywuY1TOkNZuKMQoZTEsauKTkA0ZiwSe9+UdAFy+pQwx
	5QmQPw0nqDj75cVhtXtVWWYnfktyPtA=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-n5dFLszEPWOIIjUBQMRTEA-1; Wed, 26 Aug 2026 08:48:08 -0400
X-MC-Unique: n5dFLszEPWOIIjUBQMRTEA-1
X-Mimecast-MFC-AGG-ID: n5dFLszEPWOIIjUBQMRTEA_1787748488
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-836d23866bcso16337367b3.2
        for <virtualization@lists.linux.dev>; Wed, 26 Aug 2026 05:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787748488; x=1788353288;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oXf2T/BqatZTg+2wDJYVSXJ3LOzaGDIbEOiIluWNByM=;
        b=jIZ7tpcGi0rFUqRRYaY3aCBCUGQV42PQUk57dSHJD5vUS5NNKIXsGu24mY2/fIZBGZ
         HxMRpSLamh7LFdp2UwJEtDpxLlf4JIa0ZVlb5PLrXWwRxXtnLcSUYweBkyYRk6peWnQa
         farJaaqjKpGjaTc08zj/HVjL1WC+J3xZAvCpA2xmtXBp3YGcqpXYMUwAbQSqBQWW0bto
         5FOjCUK2Slh6YLoMuVrdLLSqQuIjtR8iqILV/D0WQQLl8qABPkEpjBpL7WAT7CIDGkRq
         YOD2nKqWA6ytK6hifKzE0sSfKsiqq+zEqmfnMyCdqvPBbRd+t+dEVrDUZSPFglp8PQjy
         du0Q==
X-Forwarded-Encrypted: i=1; AHgh+RoRN68e1ZY8D7TuHy7t95WFIM6eJxmVRvC7G06+o4qI7XNb6RGCiGZcyLOxXr9anIDCJDE/Y0N43akrI2MvTQ==@lists.linux.dev
X-Gm-Message-State: AFuF++n0Z8wovy3bTX7bgYYybhKt8Grt/I0dKdIKlEQ1vgP2pnGFNTan
	r+Y2E43PdNvNTQo3Dx0bOBeevbTOMd05lHg/Sdy5z/VbdCyOsGmdlzWDIaZFYWNJ4orIKRWfP7e
	97o/4UvwG48aU5pzIBvEmgn8OlUz9E24sSnfAjxdiyuQRk4JXfeKYOcejAQ/kbyMkac19k1g+dm
	Pjh4CidDwilUfrnqlQv+UX19g3FZgvkXc/o4SHGQ5xqyg=
X-Gm-Gg: AR+sD10J62N3j1TN4gjQtL3EYZm2NtjEFxCm/9fEKoUoN5c2E65rPh31GB7g+h/EbwR
	H/BVGNtkYqW9oPAS6yxREHR+lfxOJCIemxGKcIOEs2b7HbKx1W9AdsRGpUTBqkt50n6NnU4UqaK
	2i1zk8WVbTJvFodg5kGZydEtdu/l5s2qaVSqWLTp1aZpobmbCFc1n9IWJr2eLYm0aUMBhzY+TT5
	VHnrF5Q2/kf1rLEcKg1p9RQZln4IFzhmnVFbdoQ/ioVX12kUaAgdEJ7u5Y=
X-Received: by 2002:a53:b1c3:0:b0:667:a284:2280 with SMTP id 956f58d0204a3-66d257553bbmr1814815d50.31.1787748487983;
        Wed, 26 Aug 2026 05:48:07 -0700 (PDT)
X-Received: by 2002:a53:b1c3:0:b0:667:a284:2280 with SMTP id
 956f58d0204a3-66d257553bbmr1814777d50.31.1787748487508; Wed, 26 Aug 2026
 05:48:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260818211425.91009-1-graf@amazon.com> <20260818211425.91009-5-graf@amazon.com>
In-Reply-To: <20260818211425.91009-5-graf@amazon.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Aug 2026 14:47:30 +0200
X-Gm-Features: AcwNN1W8ysCimXnJZvwZvGr-gYddX4GyUVQdS7mpv4OZzTkI-4qi7uKvuCVZlWA
Message-ID: <CAJaqyWeGaoamHzYRd1ZVUJ+6fx_4RWDim+jLO964qKtgZ=zogQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] virtio_ring: return -ENOMEM when a packed ring
 mapping fails
To: Alexander Graf <graf@amazon.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, nh-open-source@amazon.com, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Halil Pasic <pasic@linux.ibm.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: F4UzEkgG_Mthv6i8Ti1dR5k-KDm7uPDJ4yo4yhWz5Us_1787748488
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 11:15=E2=80=AFPM Alexander Graf <graf@amazon.com> w=
rote:
>
> Commit f7728002c1c7 ("virtio_ring: fix return code on DMA mapping
> fails") moved virtqueue_add_split() and virtqueue_add_indirect_packed()
> to -ENOMEM, because virtio_queue_rq() maps -EIO to BLK_STS_IOERR and
> the request fails. We still return -EIO from virtqueue_add_packed(),
> and virtqueue_add_packed_in_order() copied that when it was added later.
>
> Guests that bounce their I/O through swiotlb (SEV-SNP, TDX, s390 secure
> execution) run the pool out with enough I/O in flight. On a split ring
> virtio_queue_rq() reports BLK_STS_RESOURCE and the block layer requeues
> the request. On a packed ring virtio_queue_rq() reports BLK_STS_IOERR
> instead and the error reaches the filesystem.
>
> Return -ENOMEM from the packed unmap_release paths too. Both are reached
> from a single goto on a failed mapping, which is where
> vring_map_one_sg() already produces -ENOMEM.
>
> That way every ring layout reports the same errno, and the block layer
> requeues the request instead of failing it.
>
> Fixes: f7728002c1c7 ("virtio_ring: fix return code on DMA mapping fails")
> Fixes: f6a15d854986 ("virtio_ring: add in order support")

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Assisted-by: Kiro:claude-opus-5 checkpatch sparse
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>  drivers/virtio/virtio_ring.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index ea8e774b6d8e..b7b03166a301 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1810,7 +1810,7 @@ static inline int virtqueue_add_packed(struct vring=
_virtqueue *vq,
>         }
>
>         END_USE(vq);
> -       return -EIO;
> +       return -ENOMEM;
>  }
>
>  static inline int virtqueue_add_packed_in_order(struct vring_virtqueue *=
vq,
> @@ -1966,7 +1966,7 @@ static inline int virtqueue_add_packed_in_order(str=
uct vring_virtqueue *vq,
>         }
>
>         END_USE(vq);
> -       return -EIO;
> +       return -ENOMEM;
>  }
>
>  static bool virtqueue_kick_prepare_packed(struct vring_virtqueue *vq)
>

