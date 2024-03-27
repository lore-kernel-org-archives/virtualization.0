Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50F7208A9
	for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 02:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711506892; cv=none; b=KKJY52e3Afuw+zuYRP8onVHSDHrhZzQiwnn5M3E4C4UBtL1fwO2cIgx5iT7h3T/MSBB+Eryyq98Txq5rcBtRHvnY4w6y+e4ZQNuYNpwGBJia9OYkF1mFZdPmw82otX5nCVZnyPmXDZzVVHO5LfnXq6b357XebFn00VN7uOoL5Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711506892; c=relaxed/simple;
	bh=Qqzod6RnevlfYYey7LaLzZkHboMKdV2B1HONW9tD7FM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XqtLGjIsV9JpOES/QLpjX7vF96GKQVGJNyYDOdeYEhApKKl6FieaHqQ9nWzFihQCqaJu53DyiYO1v7XQNgVzxCs1jHC+wXwchHHj5IXoed7rlFobaWoEOy7lrP7J6ILr5K+rSCXPo6SumlVQN1dJwe05qSC6jsGtYNvaAihcHdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gY6BHbTs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gY6BHbTs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711506889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=daSGAK1vKPtHioOKtIUSXnIE1GcZiKLKNEvMx3yD3SY=;
	b=gY6BHbTszOmv9My8BTXkWskCA1PYZeYyySb0ef52REvQs51aVaTYxu81fyiu1Mpx/nsnpH
	HE9t/IxaKFxCziD8Z7SSFvHwBhoN8PhZ1LqMPAVlvZPb7GXZcyj8wBddJlHwoWnuerglf+
	Pt5vANcFqHkVEteMB5K18yPNfKih6ok=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-GA3yfQoONA-rQ8LXRKdn0A-1; Tue, 26 Mar 2024 22:34:47 -0400
X-MC-Unique: GA3yfQoONA-rQ8LXRKdn0A-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6e70785d542so267476b3a.0
        for <virtualization@lists.linux.dev>; Tue, 26 Mar 2024 19:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711506886; x=1712111686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=daSGAK1vKPtHioOKtIUSXnIE1GcZiKLKNEvMx3yD3SY=;
        b=xLCOMuUw/ztkxHVp1geAJKqUxeDUe0eotTGBsOgn5Y8HiFwHdrO+Axf218d3zAv7Yl
         xlCKjd4YHwD0omEA5egiobF4ICirjmGElFhi8Ne61AqRYTj4o3yN7Nagjtai0jqwMwdh
         e6nkcuqP8QkztJPFBIog5m9RN2pRrXEZSgeOKgFYMdH/zF9OjOhvdJps/eyZabmh4IW6
         yJDD1LGkIWJrlKQL4uHk3+bUSNRIqUuKkhbQmLE+TL2gY0epvqKBA+jIaZjBRwyKdVaG
         z5A/5WrLZLsiaZPiNkuSlbTmYbP72a3aMrPXZ7ek6OMyKj1CZZtpk/FZRR5cnbOWXnot
         ukDQ==
X-Gm-Message-State: AOJu0Yw1e6xuwtqIvWX308TuqtLSuxtDYh9oRRpPLzBbH/LO4HWZyzpA
	RRgkPjN1Z3sQiE4961V/2T9v/4VrkwR1TjpzHVvWXxxRNaU4QwCANmQsuZCDbLqnVcz7B9VbAmS
	9+YD4hYzceO4C+55tyW1lIUNaXLkjl46jtPxfhIRyuGd9N7o1aHhbZ3VoSuomdp8oR7xRXzPEWC
	esX+0BRsqn1MGIZcMqp7yRwy4Ei9fK0rrpsskZ9eQ=
X-Received: by 2002:a05:6a20:4325:b0:1a3:c6aa:ec7d with SMTP id h37-20020a056a20432500b001a3c6aaec7dmr4759152pzk.16.1711506886121;
        Tue, 26 Mar 2024 19:34:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2D17wf0XSecst4P0/CFvwY7g59bOHZlulOhr1pJevDkqh9TDzQlOYW1mV3flIFMZC5OA53NXcrZin2v4MLZU=
X-Received: by 2002:a05:6a20:4325:b0:1a3:c6aa:ec7d with SMTP id
 h37-20020a056a20432500b001a3c6aaec7dmr4759138pzk.16.1711506885767; Tue, 26
 Mar 2024 19:34:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240326233846.1086253-1-gshan@redhat.com> <20240326233846.1086253-2-gshan@redhat.com>
In-Reply-To: <20240326233846.1086253-2-gshan@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 27 Mar 2024 10:34:34 +0800
Message-ID: <CACGkMEtyEo2QQSEh0ZnZDUJSXMMhzeO97Jp0wF4_rhzUBGk4Zg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] vhost: Add smp_rmb() in vhost_vq_avail_empty()
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	mst@redhat.com, davem@davemloft.net, stefanha@redhat.com, sgarzare@redhat.com, 
	keirf@google.com, yihyu@redhat.com, shan.gavin@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 7:39=E2=80=AFAM Gavin Shan <gshan@redhat.com> wrote=
:
>
> A smp_rmb() has been missed in vhost_vq_avail_empty(), spotted by
> Will Deacon <will@kernel.org>. Otherwise, it's not ensured the
> available ring entries pushed by guest can be observed by vhost
> in time, leading to stale available ring entries fetched by vhost
> in vhost_get_vq_desc(), as reported by Yihuang Yu on NVidia's
> grace-hopper (ARM64) platform.
>
>   /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64      \
>   -accel kvm -machine virt,gic-version=3Dhost -cpu host          \
>   -smp maxcpus=3D1,cpus=3D1,sockets=3D1,clusters=3D1,cores=3D1,threads=3D=
1 \
>   -m 4096M,slots=3D16,maxmem=3D64G                                 \
>   -object memory-backend-ram,id=3Dmem0,size=3D4096M                \
>    :                                                           \
>   -netdev tap,id=3Dvnet0,vhost=3Dtrue                              \
>   -device virtio-net-pci,bus=3Dpcie.8,netdev=3Dvnet0,mac=3D52:54:00:f1:26=
:b0
>    :
>   guest# netperf -H 10.26.1.81 -l 60 -C -c -t UDP_STREAM
>   virtio_net virtio0: output.0:id 100 is not a head!
>
> Add the missed smp_rmb() in vhost_vq_avail_empty(). Note that it
> should be safe until vq->avail_idx is changed by commit 275bf960ac697
> ("vhost: better detection of available buffers").
>
> Fixes: 275bf960ac697 ("vhost: better detection of available buffers")
> Cc: <stable@kernel.org> # v4.11+
> Reported-by: Yihuang Yu <yihyu@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  drivers/vhost/vhost.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 045f666b4f12..00445ab172b3 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2799,9 +2799,18 @@ bool vhost_vq_avail_empty(struct vhost_dev *dev, s=
truct vhost_virtqueue *vq)
>         r =3D vhost_get_avail_idx(vq, &avail_idx);
>         if (unlikely(r))
>                 return false;
> +
>         vq->avail_idx =3D vhost16_to_cpu(vq, avail_idx);
> +       if (vq->avail_idx !=3D vq->last_avail_idx) {
> +               /* Similar to what's done in vhost_get_vq_desc(), we need
> +                * to ensure the available ring entries have been exposed
> +                * by guest.
> +                */

We need to be more verbose here. For example, which load needs to be
ordered with which load.

The rmb in vhost_get_vq_desc() is used to order the load of avail idx
and the load of head. It is paired with e.g virtio_wmb() in
virtqueue_add_split().

vhost_vq_avail_empty() are mostly used as a hint in
vhost_net_busy_poll() which is under the protection of the vq mutex.

An exception is the tx_can_batch(), but in that case it doesn't even
want to read the head.

Thanks


> +               smp_rmb();
> +               return false;
> +       }
>
> -       return vq->avail_idx =3D=3D vq->last_avail_idx;
> +       return true;
>  }
>  EXPORT_SYMBOL_GPL(vhost_vq_avail_empty);
>
> --
> 2.44.0
>

