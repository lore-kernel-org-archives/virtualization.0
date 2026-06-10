Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EFD3ED5AE
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781107349; cv=pass; b=RG8GSTICf7cVnYzfSee28/Z5mHT2fvPMKH722O/Rsy+Zf6O9wapBI97G/E2jHyLZ8+EYq50VTG8rjd4Mh1Y3iuc8MO4qlSqS2agOSpuVYF4rZh4BObCdN+ozxWm1AHu7cAWIR2wz6SH50CNdMt25UNEKxVeP5ToHtpgJJh8inG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781107349; c=relaxed/simple;
	bh=XW/zdIH1jd0YK9POQLWXZU7mF56vtO4Q+YPZDqiFjn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NwjPqZAdT6q7vMuFoS1tf6QAdknw1UJ1ZtcFfA/tqspSUoXw9DjRfbGyO+1/Hj6YX9w1esW5Kzgdb2+lUcByHKKJcnorcLJRwmEbUmTHiIqcm1SWjSAIK517gRv7+NJr8WqKMWnnAVwowXs08ziQEqlgBBBpSYGux7PqJgsEwts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=samsara.com; spf=pass smtp.mailfrom=samsara.com; dkim=pass (2048-bit key) header.d=samsara.com header.i=@samsara.com header.b=Ny5OEcrG; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=samsara.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsara.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=samsara.com header.i=@samsara.com header.b="Ny5OEcrG"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c85c531d4a9so2821641a12.2
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 09:02:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781107347; cv=none;
        d=google.com; s=arc-20240605;
        b=Q5NQWcJ+hLd9Al5ft94zV5wqdnc/VkamIaQTEDPX4Dkx5nqu7P+heprtwlYwymBoa/
         6ObGutMLGgkYrRPPwcolNCn96uQq8a52VXQjbN2WE0UgD3HoC3hbog19NFyYYYY8gq9H
         w473NHycrIINCk5Ohx/3DIOfdp0BYtDGRpAfrrkeO+kAICm+3+xtp9pF6tTVCcIblHb+
         mvQstdHB52TqCh69O8SB+mrRU5HH7KuAlrNWTOsg78zr37CVTDOxaBLrLi6fEak76iO9
         XNW0meJXtq2ig74DqBLBB1EX5MCmuWy3MOHC1BNY7A3sEzm+CKFBEO/nZRdYP8tn8NS7
         3PNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ik9ubpqIpHCfwse+uzzpimbdG6sMrImZdqjLeVwND3I=;
        fh=t9T3EAoMhNal2FqiGMParxFK7FD4AqBq0nehq5i898c=;
        b=JF9r+/fqPhUcE3ojmia7LKAVhmVQjE1FSYPV4X/H+dYzIe4bGOV7xZIdnBFtKFHyYI
         Zf/V+lBVpYEukcC7KD8uYm6uvBpHyMqxXi5JjjYTkYIKCE6EtkbKa1iQViIIWMh/n0Dr
         gu1CzoNZitrepvCcctSvA4jVxG0MRjRtsjCPNf1jo1d5ZQNt+723XBvv2UZrELCA/+pu
         j1M99wD/aKR/DPrX47mJO/88rbdCbCzfjopeaoXnYLiftXIyrDKav1pJIpMgUqrH9XMb
         NTv0H1y05Ck0WjRI9bSZD3VmDxQ26LvmqdMOPfjbCXxFLdQB+IUq1BV5wuodUAa5Vwxf
         JIzQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=samsara.com; s=google; t=1781107347; x=1781712147; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ik9ubpqIpHCfwse+uzzpimbdG6sMrImZdqjLeVwND3I=;
        b=Ny5OEcrG9c8EZCgdiJzPnVv8nNF///GacNrtOB/HRwRBrTZYwbx9v0zA/D4ZY74veD
         qW4cp+3Ij+RG7BmAhZeWtLnfYmXAxGInIjIawjO2qPp/xDuQbs4o5kpRyC1Iq78mtD23
         FKX1U8A1Kyk1B9oY0DghEaw3I0ZXV0R+RQskQaPhj8xoMxdv33AQRD9HDHzmk6g6vrTO
         Z7PIKRzJJWSqFpW0yHStht5yej4mTBJ5keqh9yWnMsKxBVGJ04gBpFRjB4S/RkzVZASR
         jEbBFrp64WWX2KnnTCMr+3oFnAVgYVPU+72KvxTxbnmH9/V0mLII9shkbUmxsa0YBJA2
         FqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781107347; x=1781712147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ik9ubpqIpHCfwse+uzzpimbdG6sMrImZdqjLeVwND3I=;
        b=d38mET9j6Z5RQqTh9dVpwDuriJi0OkwUjIILxoXlzOJSRlJwFg7jugN/2+P1AAHPna
         Iowv1W+dpBQ8BT6wB2P2xebSUbQIo38018CTl8KMqxjaI9nRCs0ViLu/dsdQJTC/MntO
         osFsVQyWUGo4Jz6XQ03YeiInBx5hhoGMjjamXRVrbHlLu2mxudUxzNeN+9MuoufYEg5l
         DHU2PxMb9aBEz5RBNzW7AaG22hep8lLizdPCgCf6xT5a94gutbjgzZwFl5DpqC82+e7U
         LUmizrFX2Lm/ZuHNe71utiT2pOPPVJKqt/g+NjTYcvi8JVMnc5GgtvPXIUZHtiov/w67
         5NjA==
X-Forwarded-Encrypted: i=1; AFNElJ/cmm8s/hfmGIlpQ6lpfXIgf1s8XSKlHLhOJNgVo2UYuTky/O2o4wSrd2HgoldKAWtBMCl/HnsQlkeakbySlw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLsoHVyEOz/N9t+UDHdDhleJjCyJ95Prm3msHCKh5vuZw1qcUw
	cvXIP9xzSF5B0oLzGccUbNVP/I9jK7GRNq9ySdcVBBrScaQ6ojb5vujKEyGmAM7BBG/HV1QbON2
	uCSeOx8jvcgj6iTNU39jN3g6oJgM38Y2TIaloM1M9
X-Gm-Gg: Acq92OE0sAzibwtjYYrenINKftOaHSSs4fZLBoTmKmuvxnepiq+OyVT3EVbK9Uww3E9
	Xmh6lEtGI5gyAsWl7qt9g/qSErbEi5Gl365xOrnHeuA28XVLZitrHtMBfG0CACTJ8eF+mFu/Ygz
	rN5/SSa8aHHJk+s9+yRRErvMio1xMpf3WDP07Pof+pVk9RyAnicPKS+BHzO021jOWvcrkDhjDpn
	2jc1KwAbR00bijhpbM+TPKfQfCxrb81IozCm8fVIARvZ8jAXBE0nHQCUZKIz4lu8DJxlH8gM1d9
	1d/7NPr5sloeyfqqKhfREHCg/aAaFJrE9IxbWIWeQgPGtgx3
X-Received: by 2002:a05:6a20:3d1f:b0:3a1:ed2a:1a4f with SMTP id
 adf61e73a8af0-3b4ccd6ac48mr30806076637.16.1781107346376; Wed, 10 Jun 2026
 09:02:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260610150232.24834-1-gavin.li@samsara.com> <20260610110532-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260610110532-mutt-send-email-mst@kernel.org>
From: Gavin Li <gavin.li@samsara.com>
Date: Wed, 10 Jun 2026 12:02:15 -0400
X-Gm-Features: AVVi8CdXSAQK9-qruS06Z11Qbz6vk2rHyGkXj4zlBkiIrfI0J-Cmpz20rqKB0F0
Message-ID: <CAKvMnUUN9DHwrDePh+ODE2gwa9yn-C6BC6yqJ4AuZPmwpQq88Q@mail.gmail.com>
Subject: Re: [PATCH v4] i2c: virtio: retain xfer with kref to fix UAF on
 interrupted wait
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-i2c@vger.kernel.org, viresh.kumar@linaro.org, 
	"Chen, Jian Jun" <jian.jun.chen@intel.com>, andi.shyti@kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for pointing that out.

The v5 patch fixes the DMA alignment. I've tested it with
CONFIG_DMA_API_DEBUG=3Dy and CONFIG_DMA_API_DEBUG_SG=3Dy
and everything seems to be working with no log warnings.

On Wed, Jun 10, 2026 at 11:08=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Wed, Jun 10, 2026 at 11:02:32AM -0400, Gavin Li wrote:
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
> >
> > ---
> >
> > Changes in v4:
> > - Pack bounce buffers into a single allocation after reqs[]
> > - Remove per-request buf pointer and xfer->num
> > - Remove req.msg, track message direction with req->read
> > - Simplify xfer release to a single kfree()
> > - Restore using j to track successful transfers in _complete_xfer()
> > ---
> >  drivers/i2c/busses/i2c-virtio.c | 121 +++++++++++++++++++++++++-------
> >  1 file changed, 94 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-v=
irtio.c
> > index 5da6fef92bec3..33b469ca39d4b 100644
> > --- a/drivers/i2c/busses/i2c-virtio.c
> > +++ b/drivers/i2c/busses/i2c-virtio.c
> > @@ -13,7 +13,9 @@
> >  #include <linux/err.h>
> >  #include <linux/i2c.h>
> >  #include <linux/kernel.h>
> > +#include <linux/kref.h>
> >  #include <linux/module.h>
> > +#include <linux/overflow.h>
> >  #include <linux/virtio.h>
> >  #include <linux/virtio_ids.h>
> >  #include <linux/virtio_config.h>
> > @@ -31,39 +33,74 @@ struct virtio_i2c {
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
> > + * - u8 bounce_buf[msgs[0].len]
> > + *   ...
> > + * - u8 bounce_buf[msgs[num-1].len]
>
> You seems to be ignoring DMA alignment requirements here.
> Did you try running with DMA debugging enabled?
>
>
> > + */
> > +struct virtio_i2c_xfer {
> > +     struct kref ref;
> > +     u8 *bounce_buf_base;
> > +     struct virtio_i2c_req reqs[];
> > +};
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
> > @@ -82,23 +119,31 @@ static int virtio_i2c_prepare_reqs(struct virtqueu=
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
> > +             bounce_buf +=3D msgs[i].len;
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
> > @@ -106,26 +151,38 @@ static int virtio_i2c_prepare_reqs(struct virtque=
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
> > +             bounce_buf +=3D msg->len;
> >       }
> >
> >       return j;
> > @@ -136,14 +193,24 @@ static int virtio_i2c_xfer(struct i2c_adapter *ad=
ap, struct i2c_msg *msgs,
> >  {
> >       struct virtio_i2c *vi =3D i2c_get_adapdata(adap);
> >       struct virtqueue *vq =3D vi->vq;
> > -     struct virtio_i2c_req *reqs;
> > -     int count;
> > +     struct virtio_i2c_xfer *xfer;
> > +     size_t alloc_size;
> > +     int i, count;
> >
> > -     reqs =3D kzalloc_objs(*reqs, num);
> > -     if (!reqs)
> > +     alloc_size =3D struct_size(xfer, reqs, num);
> > +     for (i =3D 0; i < num; i++) {
> > +             if (check_add_overflow(alloc_size, msgs[i].len, &alloc_si=
ze))
> > +                     return -EOVERFLOW;
> > +     }
> > +
> > +     xfer =3D kzalloc(alloc_size, GFP_KERNEL);
> > +     if (!xfer)
> >               return -ENOMEM;
> >
> > -     count =3D virtio_i2c_prepare_reqs(vq, reqs, msgs, num);
> > +     kref_init(&xfer->ref);
> > +     xfer->bounce_buf_base =3D (u8 *)(xfer->reqs + num);
> > +
> > +     count =3D virtio_i2c_prepare_xfer(vq, xfer, msgs, num);
> >       if (!count)
> >               goto err_free;
> >
> > @@ -157,10 +224,10 @@ static int virtio_i2c_xfer(struct i2c_adapter *ad=
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
