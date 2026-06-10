Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B44C287263
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 17:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781112864; cv=pass; b=bFrAe2pzFTuMnFUT3t9ikcYrHi2mZi/BqQOB9xzFnuvH/DYWU6+RX7iNsTe9TsQBinGdGpHb0smr7VNKT6ibf6G3j6X+0LObTXpc7wJAGgYTwQ9yEnUnrN4gZD+gg+Ge2J/O1DZKmocsBn/WRog4+2Mi1bJ6kzCTVvjhPQ+9E5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781112864; c=relaxed/simple;
	bh=zqVddmWYFpMCjqrVl3tjXDKTE4Y/s45Q+Ecv8jypYws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uNDS+kuQbspLLWAzb8LZ3Ga6ICG4DSRpOSXXxswHtfjSybHdQIyZVXdnr6vdAgTWlbKWuMPgyxIUGfJntUjXCLxrzSY4sfmbkAcNfu5hcm20vsKm5tUFo+eUT4+7txcMS6gS30VIriSJIRTbdWf7+LdOTkzVAR4+Fr1PqEYMshA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=samsara.com; spf=pass smtp.mailfrom=samsara.com; dkim=pass (2048-bit key) header.d=samsara.com header.i=@samsara.com header.b=YM41bciG; arc=pass smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=samsara.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsara.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=samsara.com header.i=@samsara.com header.b="YM41bciG"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-69e4d51b15dso4695403eaf.2
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 10:34:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781112862; cv=none;
        d=google.com; s=arc-20240605;
        b=SLQbwUideszZX2nxaRNcX5mT6RmFaVL6vCFF+83KQqv/P2/IAyZji+UZpGidibBTjb
         eSmB5zPTGtKeEX7vJ1dw5BwJUkj6TXe/2IElKshzRKXIW9Qn+x+JModm4dkDTOsvV6yC
         3f4z1Mow+fIoQ7eOxk/rPuSsivuiaGfbWLbNFtpM7aOcsbxJIhHi+7/CaB2VvjJg3X6z
         GOdjmn/8zRsNU/jvpyOdThM/4E7F7H2Cjvaq3qOPei4SSeWya4R2dOfePmhcDx212Rml
         H5waiZcCTNhvAZHhitwN13KQLjtQVMWtpdVGE/Hc8iHQirU/xRWeKiw+bENa5y46Jc3D
         UeBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bFnA867y1C23vLO7vRZbQpcirJBray5H6kopg3UQYyU=;
        fh=qTHZgs5EYZPFArQNgMwdyDN3UYjCHegxDDcC5AyHZfI=;
        b=LiwbyMOl23KmsLTJjU8su3lEureeqrW5yXeTPAWIxFliPVSH7DW5wZQL7XlQnc8jsY
         FKt3T4mHlFMLo/oCra2nFemYY9eaSZOnlUXIh76tThbKGYSBPNskzXIwnBhLgzIyWjKw
         5KSWBMixZFJYoBPW7dO4w2pO1UNbncD0l0heNeY6olscxgEY4fzQxMmpaiUYf4ur4/IG
         MEhvMLj+ptrW+CWy+Ds6XIFtGVgB+LcOJAC2Y9hw0t0Xi9+OU22IqvwL8ouEd3WhBqaR
         COvvkz+7xIH2efvpD/GFWO2uFSXs5YYfjbwjqaW+kkMkJK2gZoQpXZGsPvePeJX8jEBB
         HiWA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=samsara.com; s=google; t=1781112862; x=1781717662; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFnA867y1C23vLO7vRZbQpcirJBray5H6kopg3UQYyU=;
        b=YM41bciGS80+ZOtOJT3resv4okfSIXwxUq62Xk0nc/p+qQgCWXg1RnSRfVL/B5he75
         PzzDEdDzSskyE1AgKFqKSFR6q8vVCQgE/hVNMWiNoz2kqtIU5BdFNZfY5mxY8hMH/VVX
         YWJGfy6+olCaAlqm3rYbXPXXBvcXBOlnFePIq8xFrlv6RVTWlyvIH9ctfiHOdh0Njnpi
         JBEwiQ62ijmKKxQ1CyPMVve/pMMbIYmG3oR0Qc+uegAvVT0odOdv3ze9jeO0HJnGOBGk
         4elumSX9rIcKGr8lxH6RydJx06LkVSEN7SJ6wyxQoCLlEgECOmnPzwUijdtN/fdoLEmf
         g0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781112862; x=1781717662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bFnA867y1C23vLO7vRZbQpcirJBray5H6kopg3UQYyU=;
        b=Yc7vexc0oWr+g8XtBFX/GTccFjX2qgR4v0gNpHtHwfcZkz9X2Lc3f2zhV65d/puYFn
         5FNqoChTaXCbPFNpWx7G0UQu7Jhjet8LTj5IEVDo/5sMRhXDkkbZvGLsFwSQD0seVD1w
         a5NVHDkRpySOmhB2hTr4qYvH6xRwYFm0i+Pkx8L2CoZPWm9AVTyPyRlZksQ0PthL8nQI
         aXKK/RN/AziWHKZkaOl4SAxrM+yIFsNEd8v1Zi4zqrQa8bHxc89U6GXHWUnmVw8AS/J2
         KHRsmW8TWlohRxdVuURB2+zHiRaT0HlIS2kWpwzc/mizglVMjnHOtJJd+DuHPXiJr6tj
         VPRQ==
X-Forwarded-Encrypted: i=1; AFNElJ+vGsBeNm9SUmJkhNfOaca7nv7dCwC1KVpGB8k37UIS5AcYjXb8q7n+ZI7FviiWBuXIFBL+dXkWHU1MGrHboA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxd+sxuZnVWSUeIaOdWfDM0ez9qxPpdpsgZr2k64ln/cbnYsFcD
	r/Hx7YnLuVe/zE+pdskaGCV6nem1AyyTRBxuDd0B6jf9hl8UBmWQGjBbFm9ylwfY8u/9Nhq+nVQ
	PEwRx4kMlFt7D7SKLfV455jQ/2FPo9iDVcGdRzd1P
X-Gm-Gg: Acq92OGyDRhtOThzKUrJADQBdtJ2mbOJWaKwrEu+Ldlyua2KnxxiaF3GPUdnTb+nWAi
	JTEScefW2hZsN0tT09UNZbeL/MzP8J1gy0x/lSjdwfKAMvM3AeTFpr5LNmrRmn5B8vnELYIx7qc
	zSUIHNEwouWH73AiU9tjLm+9PwpknYNPPuud38mbBs7Lt8Eag0pEUXIdGUNtffVAOJsUhDhvaH5
	9I9/5BPABOzsSODDE9kxs7cgw5aE5ic52gHPaWJ1rMapV6DMXgQxGJ97mUcPnj7BUorz/2fPHxg
	U0w9XEzP/l/N2hXJDztIlxmb7Dr8RHANxnOuZEJ38swlqe7O
X-Received: by 2002:a05:6820:859b:20b0:696:29c5:452e with SMTP id
 006d021491bc7-69e68c58c7cmr11644427eaf.45.1781112861903; Wed, 10 Jun 2026
 10:34:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260610155834.79207-1-gavin.li@samsara.com> <20260610120606-mutt-send-email-mst@kernel.org>
 <CAKvMnUW-3b=cqHcozydnc6K1vD06FGk1ZO_q7S6SqhA5d8eR2g@mail.gmail.com>
In-Reply-To: <CAKvMnUW-3b=cqHcozydnc6K1vD06FGk1ZO_q7S6SqhA5d8eR2g@mail.gmail.com>
From: Gavin Li <gavin.li@samsara.com>
Date: Wed, 10 Jun 2026 13:34:10 -0400
X-Gm-Features: AVVi8Cf33f3q02NE7RSwMyqZZjsXmv1O6aGi6A8--UfH9RoRnYO0gnjNPZwO0Ms
Message-ID: <CAKvMnUXk0GrYNNYOHvME6FYRdKik-7fV5B-NgvRM+i5yYKTmvw@mail.gmail.com>
Subject: Re: [PATCH v5] i2c: virtio: retain xfer with kref to fix UAF on
 interrupted wait
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-i2c@vger.kernel.org, viresh.kumar@linaro.org, 
	"Chen, Jian Jun" <jian.jun.chen@intel.com>, andi.shyti@kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Another option I am considering:

- Uninterruptible wait with timeout, timeout based on adap->timeout
- Upon timeout, reset the device with
  virtio_i2c_del_vqs() + virtio_i2c_setup_vqs() + virtio_device_ready()

This behavior more closely mirrors what other I2C bus drivers do.
The device should be completely quiesced when virtio_i2c_del_vqs()
returns, avoiding the UAF.

On Wed, Jun 10, 2026 at 12:32=E2=80=AFPM Gavin Li <gavin.li@samsara.com> wr=
ote:
>
> On qemu, queue reset is only supported by virtio-net. If a queue reset
> is requested, the vhost backend is never notified, and as a result it's
> still at the device's discretion to write to the potentially freed buffer=
.
>
> As for device reset, I really don't want to initiate a device reset just
> because a userspace process was signaled (it seems a little extreme).
> I can implement this if you think it is the best path forward.
>
> Compared to the original patch of making the wait uninterruptible,
> I feel like this patch has become much larger than I originally wanted.
> The commit a663b3c47ab1 ("i2c: virtio: Avoid hang by using interruptible
> completion wait") that introduced the UAF mentioned that it was originall=
y
> done because a transfer could hang, but IMO this should really be fixed
> in the vhost backend rather than in the driver, mostly since virtio-i2c
> doesn't provide a way to cancel an in-flight request.
>
> On Wed, Jun 10, 2026 at 12:07=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> >
> > On Wed, Jun 10, 2026 at 11:58:34AM -0400, Gavin Li wrote:
> > > commit a663b3c47ab1 ("i2c: virtio: Avoid hang by using interruptible
> > > completion wait") switched virtio_i2c_complete_reqs() to
> > > wait_for_completion_interruptible() so a stuck device cannot hang a
> > > task forever. That left a use-after-free: if the wait returns early o=
n
> > > a signal, virtio_i2c_xfer() frees reqs and DMA bounce buffers while t=
he
> > > device may still hold virtqueue tokens pointing at &reqs[i] and DMA
> > > into read buffers. When those requests complete later,
> > > virtio_i2c_msg_done() calls complete() on freed memory.
> > >
> > > Waiting uninterruptibly for every completion before freeing avoids th=
e
> > > UAF but can hang the caller indefinitely if the virtio side never
> > > completes the request. Performing a queue reset / device reset is
> > > possible in this scenario, but adds complexity.
> > >
> > > This commit manages the freeing of the xfer allocations via kref, and
> > > ensures that each in-flight request holds a reference. This fixes the
> > > use-after-free by ensuring that the virtio device has a valid locatio=
n
> > > to write to until the request completes. This will cause a memory lea=
k
> > > in cases where the device hangs, but that is much preferable to memor=
y
> > > corruption.
> > >
> > > Additionally, force usage of a bounce buffer even if the i2c_msg buf =
is
> > > DMA-safe, since the buffer passed to the virtqueue must remain valid
> > > even if the transfer is interrupted. Remove usage of
> > > i2c_get_dma_safe_msg_buf() since it may pass through msg->buf directl=
y.
> > > All bounce buffers are part of the single xfer allocation, so there i=
s
> > > no additional allocation overhead.
> > >
> > > Signed-off-by: Gavin Li <gavin.li@samsara.com>
> >
> > But maybe, if queue reset is supported, we could use that?
> >
> > Is that problematic?
> >
> >
> > And maybe fallback on device reset on interrupt even?
> >
> > > ---
> > >
> > > Changes in v5:
> > > - DMA-align all bounce buffers
> > >
> > > Changes in v4:
> > > - Pack bounce buffers into a single allocation after reqs[]
> > > - Remove per-request buf pointer and xfer->num
> > > - Remove req.msg, track message direction with req->read
> > > - Simplify xfer release to a single kfree()
> > > - Restore using j to track successful transfers in _complete_xfer()
> > > ---
> > >  drivers/i2c/busses/i2c-virtio.c | 135 +++++++++++++++++++++++++-----=
--
> > >  1 file changed, 108 insertions(+), 27 deletions(-)
> > >
> > > diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c=
-virtio.c
> > > index 5da6fef92bec3..a5602865102d9 100644
> > > --- a/drivers/i2c/busses/i2c-virtio.c
> > > +++ b/drivers/i2c/busses/i2c-virtio.c
> > > @@ -10,10 +10,13 @@
> > >
> > >  #include <linux/acpi.h>
> > >  #include <linux/completion.h>
> > > +#include <linux/dma-mapping.h>
> > >  #include <linux/err.h>
> > >  #include <linux/i2c.h>
> > >  #include <linux/kernel.h>
> > > +#include <linux/kref.h>
> > >  #include <linux/module.h>
> > > +#include <linux/overflow.h>
> > >  #include <linux/virtio.h>
> > >  #include <linux/virtio_ids.h>
> > >  #include <linux/virtio_config.h>
> > > @@ -31,39 +34,80 @@ struct virtio_i2c {
> > >       struct virtqueue *vq;
> > >  };
> > >
> > > +struct virtio_i2c_xfer;
> > > +
> > >  /**
> > >   * struct virtio_i2c_req - the virtio I2C request structure
> > > + * @xfer: owning transfer
> > >   * @completion: completion of virtio I2C message
> > > + * @read: true if this is a read message (I2C_M_RD is set)
> > >   * @out_hdr: the OUT header of the virtio I2C message
> > > - * @buf: the buffer into which data is read, or from which it's writ=
ten
> > >   * @in_hdr: the IN header of the virtio I2C message
> > >   */
> > >  struct virtio_i2c_req {
> > > +     struct virtio_i2c_xfer *xfer;
> > >       struct completion completion;
> > > +     bool read;
> > >       struct virtio_i2c_out_hdr out_hdr       ____cacheline_aligned;
> > > -     uint8_t *buf                            ____cacheline_aligned;
> > >       struct virtio_i2c_in_hdr in_hdr         ____cacheline_aligned;
> > >  };
> > >
> > > +/**
> > > + * struct virtio_i2c_xfer - a queued I2C transfer
> > > + * @ref: one ref for the caller, plus one per in-flight virtqueue re=
quest
> > > + * @bounce_buf_base: start of bounce buffer region
> > > + * @reqs: the virtio I2C requests
> > > + *
> > > + * Allocation layout:
> > > + * - struct virtio_i2c_xfer xfer
> > > + * - struct virtio_i2c_req reqs[num]
> > > + * - padding to dma_get_cache_alignment()
> > > + * - u8 bounce_buf[virtio_i2c_bounce_size(msgs[0].len)]
> > > + *   ...
> > > + * - u8 bounce_buf[virtio_i2c_bounce_size(msgs[num-1].len)]
> > > + */
> > > +struct virtio_i2c_xfer {
> > > +     struct kref ref;
> > > +     u8 *bounce_buf_base;
> > > +     struct virtio_i2c_req reqs[];
> > > +};
> > > +
> > > +static size_t virtio_i2c_bounce_size(unsigned int len)
> > > +{
> > > +     return ALIGN(len, dma_get_cache_alignment());
> > > +}
> > > +
> > > +static void virtio_i2c_xfer_release(struct kref *ref)
> > > +{
> > > +     struct virtio_i2c_xfer *xfer =3D container_of(ref, struct virti=
o_i2c_xfer, ref);
> > > +     kfree(xfer);
> > > +}
> > > +
> > >  static void virtio_i2c_msg_done(struct virtqueue *vq)
> > >  {
> > >       struct virtio_i2c_req *req;
> > >       unsigned int len;
> > >
> > > -     while ((req =3D virtqueue_get_buf(vq, &len)))
> > > +     while ((req =3D virtqueue_get_buf(vq, &len))) {
> > >               complete(&req->completion);
> > > +             kref_put(&req->xfer->ref, virtio_i2c_xfer_release);
> > > +     }
> > >  }
> > >
> > > -static int virtio_i2c_prepare_reqs(struct virtqueue *vq,
> > > -                                struct virtio_i2c_req *reqs,
> > > +static int virtio_i2c_prepare_xfer(struct virtqueue *vq,
> > > +                                struct virtio_i2c_xfer *xfer,
> > >                                  struct i2c_msg *msgs, int num)
> > >  {
> > >       struct scatterlist *sgs[3], out_hdr, msg_buf, in_hdr;
> > > +     struct virtio_i2c_req *reqs =3D xfer->reqs;
> > > +     u8 *bounce_buf =3D xfer->bounce_buf_base;
> > >       int i;
> > >
> > >       for (i =3D 0; i < num; i++) {
> > >               int outcnt =3D 0, incnt =3D 0;
> > >
> > > +             reqs[i].xfer =3D xfer;
> > > +             reqs[i].read =3D !!(msgs[i].flags & I2C_M_RD);
> > >               init_completion(&reqs[i].completion);
> > >
> > >               /*
> > > @@ -82,23 +126,31 @@ static int virtio_i2c_prepare_reqs(struct virtqu=
eue *vq,
> > >               sgs[outcnt++] =3D &out_hdr;
> > >
> > >               if (msgs[i].len) {
> > > -                     reqs[i].buf =3D i2c_get_dma_safe_msg_buf(&msgs[=
i], 1);
> > > -                     if (!reqs[i].buf)
> > > -                             break;
> > > +                     /*
> > > +                      * Even if msg->flags has I2C_M_DMA_SAFE set, a=
 bounce
> > > +                      * buffer is required because the transfer may =
be
> > > +                      * interrupted, after which msg->buf is no long=
er valid.
> > > +                      */
> > > +                     if (!(msgs[i].flags & I2C_M_RD))
> > > +                             memcpy(bounce_buf, msgs[i].buf, msgs[i]=
.len);
> > >
> > > -                     sg_init_one(&msg_buf, reqs[i].buf, msgs[i].len)=
;
> > > +                     sg_init_one(&msg_buf, bounce_buf, msgs[i].len);
> > >
> > >                       if (msgs[i].flags & I2C_M_RD)
> > >                               sgs[outcnt + incnt++] =3D &msg_buf;
> > >                       else
> > >                               sgs[outcnt++] =3D &msg_buf;
> > >               }
> > > +             bounce_buf +=3D virtio_i2c_bounce_size(msgs[i].len);
> > >
> > >               sg_init_one(&in_hdr, &reqs[i].in_hdr, sizeof(reqs[i].in=
_hdr));
> > >               sgs[outcnt + incnt++] =3D &in_hdr;
> > >
> > > +             /* This reference is released in virtio_i2c_msg_done().=
 */
> > > +             kref_get(&xfer->ref);
> > > +
> > >               if (virtqueue_add_sgs(vq, sgs, outcnt, incnt, &reqs[i],=
 GFP_KERNEL)) {
> > > -                     i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i],=
 false);
> > > +                     kref_put(&xfer->ref, virtio_i2c_xfer_release);
> > >                       break;
> > >               }
> > >       }
> > > @@ -106,26 +158,38 @@ static int virtio_i2c_prepare_reqs(struct virtq=
ueue *vq,
> > >       return i;
> > >  }
> > >
> > > -static int virtio_i2c_complete_reqs(struct virtqueue *vq,
> > > -                                 struct virtio_i2c_req *reqs,
> > > -                                 struct i2c_msg *msgs, int num)
> > > +static int virtio_i2c_complete_xfer(struct virtio_i2c_xfer *xfer,
> > > +                                 struct i2c_msg *msgs,
> > > +                                 int num)
> > >  {
> > > +     struct virtio_i2c_req *reqs =3D xfer->reqs;
> > > +     u8 *bounce_buf =3D xfer->bounce_buf_base;
> > >       bool failed =3D false;
> > >       int i, j =3D 0;
> > >
> > >       for (i =3D 0; i < num; i++) {
> > >               struct virtio_i2c_req *req =3D &reqs[i];
> > > +             struct i2c_msg *msg =3D &msgs[i];
> > > +
> > > +             if (wait_for_completion_interruptible(&req->completion)=
)
> > > +                     return -EINTR;
> > > +
> > > +             if (req->in_hdr.status !=3D VIRTIO_I2C_MSG_OK) {
> > > +                     /*
> > > +                      * Don't break yet. Try to wait until all reque=
sts
> > > +                      * complete to ensure that the virtqueue has en=
ough
> > > +                      * descriptor slots for the next transfer.
> > > +                      */
> > > +                     failed =3D true;
> > > +             }
> > >
> > >               if (!failed) {
> > > -                     if (wait_for_completion_interruptible(&req->com=
pletion))
> > > -                             failed =3D true;
> > > -                     else if (req->in_hdr.status !=3D VIRTIO_I2C_MSG=
_OK)
> > > -                             failed =3D true;
> > > -                     else
> > > -                             j++;
> > > +                     if (req->read)
> > > +                             memcpy(msg->buf, bounce_buf, msg->len);
> > > +                     j++;
> > >               }
> > >
> > > -             i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], !failed=
);
> > > +             bounce_buf +=3D virtio_i2c_bounce_size(msg->len);
> > >       }
> > >
> > >       return j;
> > > @@ -136,14 +200,31 @@ static int virtio_i2c_xfer(struct i2c_adapter *=
adap, struct i2c_msg *msgs,
> > >  {
> > >       struct virtio_i2c *vi =3D i2c_get_adapdata(adap);
> > >       struct virtqueue *vq =3D vi->vq;
> > > -     struct virtio_i2c_req *reqs;
> > > -     int count;
> > > +     struct virtio_i2c_xfer *xfer;
> > > +     size_t alloc_size;
> > > +     int i, count;
> > > +
> > > +     alloc_size =3D struct_size(xfer, reqs, num);
> > > +     if (check_add_overflow(alloc_size,
> > > +                            dma_get_cache_alignment() - 1,
> > > +                            &alloc_size)) /* padding for PTR_ALIGN()=
 */
> > > +             return -EOVERFLOW;
> > > +     for (i =3D 0; i < num; i++) {
> > > +             if (check_add_overflow(alloc_size,
> > > +                                    virtio_i2c_bounce_size(msgs[i].l=
en),
> > > +                                    &alloc_size))
> > > +                     return -EOVERFLOW;
> > > +     }
> > >
> > > -     reqs =3D kzalloc_objs(*reqs, num);
> > > -     if (!reqs)
> > > +     xfer =3D kzalloc(alloc_size, GFP_KERNEL);
> > > +     if (!xfer)
> > >               return -ENOMEM;
> > >
> > > -     count =3D virtio_i2c_prepare_reqs(vq, reqs, msgs, num);
> > > +     kref_init(&xfer->ref);
> > > +     xfer->bounce_buf_base =3D PTR_ALIGN((u8 *)(xfer->reqs + num),
> > > +                                       dma_get_cache_alignment());
> > > +
> > > +     count =3D virtio_i2c_prepare_xfer(vq, xfer, msgs, num);
> > >       if (!count)
> > >               goto err_free;
> > >
> > > @@ -157,10 +238,10 @@ static int virtio_i2c_xfer(struct i2c_adapter *=
adap, struct i2c_msg *msgs,
> > >        */
> > >       virtqueue_kick(vq);
> > >
> > > -     count =3D virtio_i2c_complete_reqs(vq, reqs, msgs, count);
> > > +     count =3D virtio_i2c_complete_xfer(xfer, msgs, count);
> > >
> > >  err_free:
> > > -     kfree(reqs);
> > > +     kref_put(&xfer->ref, virtio_i2c_xfer_release);
> > >       return count;
> > >  }
> > >
> > > --
> > > 2.54.0
> >
