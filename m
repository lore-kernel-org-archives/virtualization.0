Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A1329D266
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781109178; cv=pass; b=noC05Xsv/rmoVI0C+DYcq4P3dpb+Eoppptkt8xUBPhDx8Sj9DcTO/T1LyqfhcPNj0Yi8+05WJ4lXm5W5wsrC18xIfhoWf1HyXnKDk4awEbc8uLlZ5DtnGfzqZUUnJm8j1pRb3yZd7rAsEjtEL7upfrmAWY9ZNgpLxkxGy4XeTgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781109178; c=relaxed/simple;
	bh=lEGsg4Ef6JV88L4XrwTApsrxs3N9lWsculGPycQBOwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fx6ablEsqDZLa64L8UPUEVWs2rnveyclZVNearOyUuWqaZPt5Dhexxec6YwHwaGQIys11Io8WxQ1YTa8ZRmb8CJKbOmZFY+tBTsmdcDU16S+zLzsKbcHIIFeDkIpnLGmgbyqsTTrAQtX4SZoO5dEvLUyTh4uqPgmUO90V0pAtvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=samsara.com; spf=pass smtp.mailfrom=samsara.com; dkim=pass (2048-bit key) header.d=samsara.com header.i=@samsara.com header.b=FszQE361; arc=pass smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=samsara.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsara.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=samsara.com header.i=@samsara.com header.b="FszQE361"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-69de16f5e80so3136692eaf.0
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 09:32:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781109174; cv=none;
        d=google.com; s=arc-20240605;
        b=FiOBn/lriFDXmbvciyapNXXZ/z/wGQBzPAjbcUheeVZHIgnzAvtpJrQ/N10XwRiajK
         tKby3/BCWaiklsfcyOquzreUBay8ElZwyEEwh3s9X8NJfdn6GegaRpzhSeOnSF4YxEf8
         Z5LVsNYoCF1Yv1oCGF9jOqV8qTZMmEY4n2pbKXoaGvb9pLhRHje2bK70f0uqnwlUaXrj
         R/70k03SmxiKZIPRj3+NEQ7PsMVPokR/JJV+4CtmikPsVBWXMFoQZSUtUVlnAYQPci0k
         xEaM3zgJX/P0l78O5YqobdzAhgO7q/sy7/zq41OmkMiv5tVKeKC43LXDvLTR+FDfJrD0
         IPBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kgwmfnTPQFofMrUEygFBvRIMLGtwyJWuCqa0szVcAj0=;
        fh=keTj5A769xqt8Fy09HlQ1qe1dqh0e/cFibwjTfFBkGQ=;
        b=EVJfP17DxrGrKscDKzV18uRAupaVN7tiP/lCJfcAycZ9ZEnT/aBYrK0+UkxYbtvFXT
         4WCCvxgEOKru34ymH3vhz8xfSAxNzi5FBT10ZzbKwYLFo5Nlok69WoQlUXP17pBFNCbV
         8MAQhO06+IIxReVEsmdAmN6OvxOIQb+iqXb6nXWqx5KxEhXeeXBVCSsyafEb7FEyWuq2
         jSf1PjXZ08cvByxuMJzvVGfjbAPkGsQxHxCkJTryI8Q/wlA6BRgY5Ojw4dbS3PIFSHfD
         7W77BWXZy8jTjpkSwDXM0E+yZlsYxNcGFBWgBAF62UuU4R61eeCK43tMPvXEkD1IjHUJ
         OFAA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=samsara.com; s=google; t=1781109174; x=1781713974; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgwmfnTPQFofMrUEygFBvRIMLGtwyJWuCqa0szVcAj0=;
        b=FszQE361am8Ay1c5mbFg4u5l8ZkqANuz92PBP1ZQ+McTCh0mGO0CyYEJUOHPIxUq+D
         pqf8XO6o5fP6ojKWRVKeffHrnePPb5Dns4CXMeq2ghlHml5woMo4ZKx1uU8p3I4W/1fU
         Mi3O7MlpswsX75HasARcM6069pKCXglATpUrPrSxQKlVZyIAfOCqS2ZJChLbBkIadEsk
         OS9EFMBLzQAAEydPV5XASag4eXNTyAbdU/RWpfVCe1BuPxnPtGtRIhYCkSWqfC70Kh6G
         oTOUCmNsvsUow1kkwWvCCrO2TXE6fXxaHviaR39g1P6DL4yRERyjW6LIuyUZ7PRh1h7Y
         lojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781109174; x=1781713974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kgwmfnTPQFofMrUEygFBvRIMLGtwyJWuCqa0szVcAj0=;
        b=EKXQAQT+fnn4UlfqrJIZMYp/Rgbq5VDxVOZkSRFXTmZdCRDErOKxDK+xmTIbfMfizI
         5zvWd0OaHaMpKzmxii9Yl8qsHkXusEo2pneoxpHogG3Kh7kWLMp/s17IhAS87mGpj4Br
         9ytnaaEWH6d2Yh9Rxoc7kA1p/YsnsY6ZxcyopILlmY5teULpJBFOwN1jQze6N73EXf7b
         Ilm/rw6zy4vHd3yRTIgjSoPYWqR2AhGearWG9WQwftxqmbJV7xokhME7L13GE8AF7F9W
         KW8kfBXtmHFrbyJuNHzuZ0B5DTeulv3KCkT6r5CsFrl5wtok7uQqTXZcq66BULviBBoG
         aCcQ==
X-Forwarded-Encrypted: i=1; AFNElJ/eI0L889wyPCK00Egs7C8QqaZC7YDdGa8OHMg6gRtpMuK18RJNocLw9V8upJBENe2S12mGQFEMW/NO2RZzNw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxaUMR1eEmoImNrLMydsxpe9zwqAVP70Ex5Zai4TGYhij945j0h
	tPJzlkRhY5cbJBaHr51Wvv5KivMJcVZBHX754GGWg9oiLH/jvv3xjSfqBsNyoGCkvHDTeeebPuD
	HlXtK+wFPK3SQW6JdVzHh1mUQCYWHy/wo8M7o+h5F
X-Gm-Gg: Acq92OFCYAeFza3in+sXdjmiNrwWy+g/C+4A2Ry3GtKDh5CtorHI1l5xJw9jcLOt7sY
	xygYNTEy9+ZLrbNu97t3dLlk4mvLfhkdRNoi9DqeXaEHlqIc4Cfmnq9o5MWTEIpyA+EjcMALe0+
	bL8G0DUI8WlYzspW7MyzOUkrEYm4sJ0oMxgd9PflaGWTf9gaZPwnpVlHfu0a2WfBUCu+zslfUJH
	ZbAkUvkP1Yvbd7nzUGXhewGzDr/xXdlRV3fisAZUdpTeCqFxrJnmR7jE9veqfXN8vVH7DUKoqNB
	klKwh01c/vLSWlGHSv138z9osWRzzDb0ZPvAGl+bj+agE65f
X-Received: by 2002:a05:6820:c2d1:20b0:69d:7b82:3ce8 with SMTP id
 006d021491bc7-69e68c0bdadmr11053922eaf.32.1781109173661; Wed, 10 Jun 2026
 09:32:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260610155834.79207-1-gavin.li@samsara.com> <20260610120606-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260610120606-mutt-send-email-mst@kernel.org>
From: Gavin Li <gavin.li@samsara.com>
Date: Wed, 10 Jun 2026 12:32:42 -0400
X-Gm-Features: AVVi8Cc56XQHEN4U5Pe9ooj9GB66gTMYMKZzRCMwfa8aKWRJeaaVg7RyC876RsM
Message-ID: <CAKvMnUW-3b=cqHcozydnc6K1vD06FGk1ZO_q7S6SqhA5d8eR2g@mail.gmail.com>
Subject: Re: [PATCH v5] i2c: virtio: retain xfer with kref to fix UAF on
 interrupted wait
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-i2c@vger.kernel.org, viresh.kumar@linaro.org, 
	"Chen, Jian Jun" <jian.jun.chen@intel.com>, andi.shyti@kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On qemu, queue reset is only supported by virtio-net. If a queue reset
is requested, the vhost backend is never notified, and as a result it's
still at the device's discretion to write to the potentially freed buffer.

As for device reset, I really don't want to initiate a device reset just
because a userspace process was signaled (it seems a little extreme).
I can implement this if you think it is the best path forward.

Compared to the original patch of making the wait uninterruptible,
I feel like this patch has become much larger than I originally wanted.
The commit a663b3c47ab1 ("i2c: virtio: Avoid hang by using interruptible
completion wait") that introduced the UAF mentioned that it was originally
done because a transfer could hang, but IMO this should really be fixed
in the vhost backend rather than in the driver, mostly since virtio-i2c
doesn't provide a way to cancel an in-flight request.

On Wed, Jun 10, 2026 at 12:07=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Wed, Jun 10, 2026 at 11:58:34AM -0400, Gavin Li wrote:
> > commit a663b3c47ab1 ("i2c: virtio: Avoid hang by using interruptible
> > completion wait") switched virtio_i2c_complete_reqs() to
> > wait_for_completion_interruptible() so a stuck device cannot hang a
> > task forever. That left a use-after-free: if the wait returns early on
> > a signal, virtio_i2c_xfer() frees reqs and DMA bounce buffers while the
> > device may still hold virtqueue tokens pointing at &reqs[i] and DMA
> > into read buffers. When those requests complete later,
> > virtio_i2c_msg_done() calls complete() on freed memory.
> >
> > Waiting uninterruptibly for every completion before freeing avoids the
> > UAF but can hang the caller indefinitely if the virtio side never
> > completes the request. Performing a queue reset / device reset is
> > possible in this scenario, but adds complexity.
> >
> > This commit manages the freeing of the xfer allocations via kref, and
> > ensures that each in-flight request holds a reference. This fixes the
> > use-after-free by ensuring that the virtio device has a valid location
> > to write to until the request completes. This will cause a memory leak
> > in cases where the device hangs, but that is much preferable to memory
> > corruption.
> >
> > Additionally, force usage of a bounce buffer even if the i2c_msg buf is
> > DMA-safe, since the buffer passed to the virtqueue must remain valid
> > even if the transfer is interrupted. Remove usage of
> > i2c_get_dma_safe_msg_buf() since it may pass through msg->buf directly.
> > All bounce buffers are part of the single xfer allocation, so there is
> > no additional allocation overhead.
> >
> > Signed-off-by: Gavin Li <gavin.li@samsara.com>
>
> But maybe, if queue reset is supported, we could use that?
>
> Is that problematic?
>
>
> And maybe fallback on device reset on interrupt even?
>
> > ---
> >
> > Changes in v5:
> > - DMA-align all bounce buffers
> >
> > Changes in v4:
> > - Pack bounce buffers into a single allocation after reqs[]
> > - Remove per-request buf pointer and xfer->num
> > - Remove req.msg, track message direction with req->read
> > - Simplify xfer release to a single kfree()
> > - Restore using j to track successful transfers in _complete_xfer()
> > ---
> >  drivers/i2c/busses/i2c-virtio.c | 135 +++++++++++++++++++++++++-------
> >  1 file changed, 108 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-v=
irtio.c
> > index 5da6fef92bec3..a5602865102d9 100644
> > --- a/drivers/i2c/busses/i2c-virtio.c
> > +++ b/drivers/i2c/busses/i2c-virtio.c
> > @@ -10,10 +10,13 @@
> >
> >  #include <linux/acpi.h>
> >  #include <linux/completion.h>
> > +#include <linux/dma-mapping.h>
> >  #include <linux/err.h>
> >  #include <linux/i2c.h>
> >  #include <linux/kernel.h>
> > +#include <linux/kref.h>
> >  #include <linux/module.h>
> > +#include <linux/overflow.h>
> >  #include <linux/virtio.h>
> >  #include <linux/virtio_ids.h>
> >  #include <linux/virtio_config.h>
> > @@ -31,39 +34,80 @@ struct virtio_i2c {
> >       struct virtqueue *vq;
> >  };
> >
> > +struct virtio_i2c_xfer;
> > +
> >  /**
> >   * struct virtio_i2c_req - the virtio I2C request structure
> > + * @xfer: owning transfer
> >   * @completion: completion of virtio I2C message
> > + * @read: true if this is a read message (I2C_M_RD is set)
> >   * @out_hdr: the OUT header of the virtio I2C message
> > - * @buf: the buffer into which data is read, or from which it's writte=
n
> >   * @in_hdr: the IN header of the virtio I2C message
> >   */
> >  struct virtio_i2c_req {
> > +     struct virtio_i2c_xfer *xfer;
> >       struct completion completion;
> > +     bool read;
> >       struct virtio_i2c_out_hdr out_hdr       ____cacheline_aligned;
> > -     uint8_t *buf                            ____cacheline_aligned;
> >       struct virtio_i2c_in_hdr in_hdr         ____cacheline_aligned;
> >  };
> >
> > +/**
> > + * struct virtio_i2c_xfer - a queued I2C transfer
> > + * @ref: one ref for the caller, plus one per in-flight virtqueue requ=
est
> > + * @bounce_buf_base: start of bounce buffer region
> > + * @reqs: the virtio I2C requests
> > + *
> > + * Allocation layout:
> > + * - struct virtio_i2c_xfer xfer
> > + * - struct virtio_i2c_req reqs[num]
> > + * - padding to dma_get_cache_alignment()
> > + * - u8 bounce_buf[virtio_i2c_bounce_size(msgs[0].len)]
> > + *   ...
> > + * - u8 bounce_buf[virtio_i2c_bounce_size(msgs[num-1].len)]
> > + */
> > +struct virtio_i2c_xfer {
> > +     struct kref ref;
> > +     u8 *bounce_buf_base;
> > +     struct virtio_i2c_req reqs[];
> > +};
> > +
> > +static size_t virtio_i2c_bounce_size(unsigned int len)
> > +{
> > +     return ALIGN(len, dma_get_cache_alignment());
> > +}
> > +
> > +static void virtio_i2c_xfer_release(struct kref *ref)
> > +{
> > +     struct virtio_i2c_xfer *xfer =3D container_of(ref, struct virtio_=
i2c_xfer, ref);
> > +     kfree(xfer);
> > +}
> > +
> >  static void virtio_i2c_msg_done(struct virtqueue *vq)
> >  {
> >       struct virtio_i2c_req *req;
> >       unsigned int len;
> >
> > -     while ((req =3D virtqueue_get_buf(vq, &len)))
> > +     while ((req =3D virtqueue_get_buf(vq, &len))) {
> >               complete(&req->completion);
> > +             kref_put(&req->xfer->ref, virtio_i2c_xfer_release);
> > +     }
> >  }
> >
> > -static int virtio_i2c_prepare_reqs(struct virtqueue *vq,
> > -                                struct virtio_i2c_req *reqs,
> > +static int virtio_i2c_prepare_xfer(struct virtqueue *vq,
> > +                                struct virtio_i2c_xfer *xfer,
> >                                  struct i2c_msg *msgs, int num)
> >  {
> >       struct scatterlist *sgs[3], out_hdr, msg_buf, in_hdr;
> > +     struct virtio_i2c_req *reqs =3D xfer->reqs;
> > +     u8 *bounce_buf =3D xfer->bounce_buf_base;
> >       int i;
> >
> >       for (i =3D 0; i < num; i++) {
> >               int outcnt =3D 0, incnt =3D 0;
> >
> > +             reqs[i].xfer =3D xfer;
> > +             reqs[i].read =3D !!(msgs[i].flags & I2C_M_RD);
> >               init_completion(&reqs[i].completion);
> >
> >               /*
> > @@ -82,23 +126,31 @@ static int virtio_i2c_prepare_reqs(struct virtqueu=
e *vq,
> >               sgs[outcnt++] =3D &out_hdr;
> >
> >               if (msgs[i].len) {
> > -                     reqs[i].buf =3D i2c_get_dma_safe_msg_buf(&msgs[i]=
, 1);
> > -                     if (!reqs[i].buf)
> > -                             break;
> > +                     /*
> > +                      * Even if msg->flags has I2C_M_DMA_SAFE set, a b=
ounce
> > +                      * buffer is required because the transfer may be
> > +                      * interrupted, after which msg->buf is no longer=
 valid.
> > +                      */
> > +                     if (!(msgs[i].flags & I2C_M_RD))
> > +                             memcpy(bounce_buf, msgs[i].buf, msgs[i].l=
en);
> >
> > -                     sg_init_one(&msg_buf, reqs[i].buf, msgs[i].len);
> > +                     sg_init_one(&msg_buf, bounce_buf, msgs[i].len);
> >
> >                       if (msgs[i].flags & I2C_M_RD)
> >                               sgs[outcnt + incnt++] =3D &msg_buf;
> >                       else
> >                               sgs[outcnt++] =3D &msg_buf;
> >               }
> > +             bounce_buf +=3D virtio_i2c_bounce_size(msgs[i].len);
> >
> >               sg_init_one(&in_hdr, &reqs[i].in_hdr, sizeof(reqs[i].in_h=
dr));
> >               sgs[outcnt + incnt++] =3D &in_hdr;
> >
> > +             /* This reference is released in virtio_i2c_msg_done(). *=
/
> > +             kref_get(&xfer->ref);
> > +
> >               if (virtqueue_add_sgs(vq, sgs, outcnt, incnt, &reqs[i], G=
FP_KERNEL)) {
> > -                     i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], f=
alse);
> > +                     kref_put(&xfer->ref, virtio_i2c_xfer_release);
> >                       break;
> >               }
> >       }
> > @@ -106,26 +158,38 @@ static int virtio_i2c_prepare_reqs(struct virtque=
ue *vq,
> >       return i;
> >  }
> >
> > -static int virtio_i2c_complete_reqs(struct virtqueue *vq,
> > -                                 struct virtio_i2c_req *reqs,
> > -                                 struct i2c_msg *msgs, int num)
> > +static int virtio_i2c_complete_xfer(struct virtio_i2c_xfer *xfer,
> > +                                 struct i2c_msg *msgs,
> > +                                 int num)
> >  {
> > +     struct virtio_i2c_req *reqs =3D xfer->reqs;
> > +     u8 *bounce_buf =3D xfer->bounce_buf_base;
> >       bool failed =3D false;
> >       int i, j =3D 0;
> >
> >       for (i =3D 0; i < num; i++) {
> >               struct virtio_i2c_req *req =3D &reqs[i];
> > +             struct i2c_msg *msg =3D &msgs[i];
> > +
> > +             if (wait_for_completion_interruptible(&req->completion))
> > +                     return -EINTR;
> > +
> > +             if (req->in_hdr.status !=3D VIRTIO_I2C_MSG_OK) {
> > +                     /*
> > +                      * Don't break yet. Try to wait until all request=
s
> > +                      * complete to ensure that the virtqueue has enou=
gh
> > +                      * descriptor slots for the next transfer.
> > +                      */
> > +                     failed =3D true;
> > +             }
> >
> >               if (!failed) {
> > -                     if (wait_for_completion_interruptible(&req->compl=
etion))
> > -                             failed =3D true;
> > -                     else if (req->in_hdr.status !=3D VIRTIO_I2C_MSG_O=
K)
> > -                             failed =3D true;
> > -                     else
> > -                             j++;
> > +                     if (req->read)
> > +                             memcpy(msg->buf, bounce_buf, msg->len);
> > +                     j++;
> >               }
> >
> > -             i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], !failed);
> > +             bounce_buf +=3D virtio_i2c_bounce_size(msg->len);
> >       }
> >
> >       return j;
> > @@ -136,14 +200,31 @@ static int virtio_i2c_xfer(struct i2c_adapter *ad=
ap, struct i2c_msg *msgs,
> >  {
> >       struct virtio_i2c *vi =3D i2c_get_adapdata(adap);
> >       struct virtqueue *vq =3D vi->vq;
> > -     struct virtio_i2c_req *reqs;
> > -     int count;
> > +     struct virtio_i2c_xfer *xfer;
> > +     size_t alloc_size;
> > +     int i, count;
> > +
> > +     alloc_size =3D struct_size(xfer, reqs, num);
> > +     if (check_add_overflow(alloc_size,
> > +                            dma_get_cache_alignment() - 1,
> > +                            &alloc_size)) /* padding for PTR_ALIGN() *=
/
> > +             return -EOVERFLOW;
> > +     for (i =3D 0; i < num; i++) {
> > +             if (check_add_overflow(alloc_size,
> > +                                    virtio_i2c_bounce_size(msgs[i].len=
),
> > +                                    &alloc_size))
> > +                     return -EOVERFLOW;
> > +     }
> >
> > -     reqs =3D kzalloc_objs(*reqs, num);
> > -     if (!reqs)
> > +     xfer =3D kzalloc(alloc_size, GFP_KERNEL);
> > +     if (!xfer)
> >               return -ENOMEM;
> >
> > -     count =3D virtio_i2c_prepare_reqs(vq, reqs, msgs, num);
> > +     kref_init(&xfer->ref);
> > +     xfer->bounce_buf_base =3D PTR_ALIGN((u8 *)(xfer->reqs + num),
> > +                                       dma_get_cache_alignment());
> > +
> > +     count =3D virtio_i2c_prepare_xfer(vq, xfer, msgs, num);
> >       if (!count)
> >               goto err_free;
> >
> > @@ -157,10 +238,10 @@ static int virtio_i2c_xfer(struct i2c_adapter *ad=
ap, struct i2c_msg *msgs,
> >        */
> >       virtqueue_kick(vq);
> >
> > -     count =3D virtio_i2c_complete_reqs(vq, reqs, msgs, count);
> > +     count =3D virtio_i2c_complete_xfer(xfer, msgs, count);
> >
> >  err_free:
> > -     kfree(reqs);
> > +     kref_put(&xfer->ref, virtio_i2c_xfer_release);
> >       return count;
> >  }
> >
> > --
> > 2.54.0
>
