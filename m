Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF09313293
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 06:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788156604; cv=none; b=jsmdjG+ULQfZM2I4T1ggZ8Jx9XzPNsYk8f1yAGwos53u7ZANPlXnjICwFD8KfJdvaE4oqvI+UZkdJO2l4dU8ag4kJAWhAOMMAzIExHO7gEHGLo2I35YY0oy+hu91vDPhsqx8wZzeuv6Ht4mnjQ4agrunceRv9RBcombJkMFVUO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788156604; c=relaxed/simple;
	bh=pwulQUv9gZsC/GJfP2VzbiSF0sxinrqd2Wl9IhDEGYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bnIB6zOKxaARQRbJejRnRuZ5pjpzR750vAc6Yn/TZTEDH2odQ7FPpyeqEkFvpYYO9iQ3ZB3cpYADoLtzABtJynGBGPJRiTiElKTBfu9WrstuKFVe0wK7e7tL+e50YVraY6jZDvWnsZO3yXlBacm1dwcyWCx6helZogwSkkXS80E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bdf8ieAP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bdf8ieAP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788156601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5aju6BdZ5xAFpYdgophff3vv4nrJMZLqTEjhajzjNvs=;
	b=Bdf8ieAPwAhzf1wZjg+jBhaOTUc199scPh/GGm5ZJGdfDhKFVIbx9qBWTMHqhrDBbj3Eha
	eHCtU4Ss39qAtTiRt1ltg4+YYqJaueLpIYWP5ryQ5rDMT04Kp3/XJSrEVTc5RoVLmcYU5K
	mdLYClJLsFcunOqksj3WrmMrLdBU+s8=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-Wo9MrZanOTiPlTy4ocSDww-1; Mon, 31 Aug 2026 02:09:59 -0400
X-MC-Unique: Wo9MrZanOTiPlTy4ocSDww-1
X-Mimecast-MFC-AGG-ID: Wo9MrZanOTiPlTy4ocSDww_1788156599
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5c664914e69so3409137e0c.3
        for <virtualization@lists.linux.dev>; Sun, 30 Aug 2026 23:09:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788156598; x=1788761398;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5aju6BdZ5xAFpYdgophff3vv4nrJMZLqTEjhajzjNvs=;
        b=suS/Ke94tn9RS4/GuMm2i38E4vxI/xUPoErE96pwzDxiJ4gyMKn18SGYHMZBzMJ1rV
         nh79/MXhxQq1QfwM1ozGI5FrUnMdEpB96QlPIqoddR4AJBml0KgXV7oAAhVXwmi0Xlob
         6cGARNOpychqh/pKtoO2ZRfMWaleaPGqIvGFsgdIhvYMghhV1Ga8H2AHeCvEbJSlJsXf
         lEkSxwo5+hx13H5Nj8wYoiJ48JaJUIY6f6/BZyUrxtBq3cPXTKmi+qTRkXQunlxxC+ux
         tKFdP0alDi5W09jcUkna4BXjkJszg0mI6bf7E6X9WHAjv0hTxG3yUsv+IPC05mtG0uuM
         qS7Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp5sJVmfEZpRnAWwkevWq0YfjxBnLbIprU38BtLvt7NIqIlmaszhEW5yX010yxiAsQAZCgQ+jjGmi3pxwC1cQ==@lists.linux.dev
X-Gm-Message-State: AFuF++m733qTuJHbgEemd4wLlk6rBgbB8aUn2Ij4qwyt1/Ek3LgBIbw2
	FVsmrswkb7XZhGG/5jbM04GD7oDPLzAd8lGc1q/rWID4sS+lEw2bxXgsWNuxlMA4p1Lo0nlySGe
	hzEDcNMKK3rLllENLcR6dludj4R57LRT54+wFz6PhU4jufnRYyqgPPX7lRqWIp/drDheXoBiqSN
	9blrdfRMGf9VJshIMH9o3L9iRXebu3wAX+WttwTfxuXjP9aEeP8ePwGA==
X-Gm-Gg: AR+sD11sD0Li9Czbphk5nFFIM0Hqs15moX/yzCwO1zZUhGTyGM1v08jPS8fxXsuqU/G
	KntD28Cu609t/5CEJwcksKW0W30ni8EXOEQM9Ue4xRq4UNAL8CfSlfXr3XY4LxbRP2PY4buJUIn
	hfGzSq/wuGOFLFdcj9kSBQuG6caucar2Ee16qsX2vTQhGttkuWY00TbgOUi2NSII63DPr1XlmkL
	gfKEYO+fvFIcTkmPBnwkwrXMKdrxlE1kY8kPxBFoDA/QAM6nnYe1CQPNf0=
X-Received: by 2002:a05:6122:da3:b0:5bb:eebe:7ffd with SMTP id 71dfb90a1353d-5c7b4b86f1amr1372670e0c.8.1788156598416;
        Sun, 30 Aug 2026 23:09:58 -0700 (PDT)
X-Received: by 2002:a05:690c:a5c6:b0:820:b24:27c7 with SMTP id
 00721157ae682-85d6781d12fmr77480637b3.14.1788156104475; Sun, 30 Aug 2026
 23:01:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260818211425.91009-1-graf@amazon.com> <20260818211425.91009-5-graf@amazon.com>
 <CAJaqyWeGaoamHzYRd1ZVUJ+6fx_4RWDim+jLO964qKtgZ=zogQ@mail.gmail.com>
In-Reply-To: <CAJaqyWeGaoamHzYRd1ZVUJ+6fx_4RWDim+jLO964qKtgZ=zogQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 31 Aug 2026 08:00:00 +0200
X-Gm-Features: AcwNN1WLAReXxpXSMD_jxVe_A_ReDuw9NQ79ameMLXkVS-IUg_KF2QZWm084ooc
Message-ID: <CAJaqyWe1fKBwBXXxHqDV676Uw03Pvr0uLizPmHKqm+sqmY_LgA@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] virtio_ring: return -ENOMEM when a packed ring
 mapping fails
To: Alexander Graf <graf@amazon.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, nh-open-source@amazon.com, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Halil Pasic <pasic@linux.ibm.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -ZfEJ9doZY3LNLK4K6A6HvuyP6LDnFQ6CZEVslwETlk_1788156599
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 2:47=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Tue, Aug 18, 2026 at 11:15=E2=80=AFPM Alexander Graf <graf@amazon.com>=
 wrote:
> >
> > Commit f7728002c1c7 ("virtio_ring: fix return code on DMA mapping
> > fails") moved virtqueue_add_split() and virtqueue_add_indirect_packed()
> > to -ENOMEM, because virtio_queue_rq() maps -EIO to BLK_STS_IOERR and
> > the request fails. We still return -EIO from virtqueue_add_packed(),
> > and virtqueue_add_packed_in_order() copied that when it was added later=
.
> >
> > Guests that bounce their I/O through swiotlb (SEV-SNP, TDX, s390 secure
> > execution) run the pool out with enough I/O in flight. On a split ring
> > virtio_queue_rq() reports BLK_STS_RESOURCE and the block layer requeues
> > the request. On a packed ring virtio_queue_rq() reports BLK_STS_IOERR
> > instead and the error reaches the filesystem.
> >
> > Return -ENOMEM from the packed unmap_release paths too. Both are reache=
d
> > from a single goto on a failed mapping, which is where
> > vring_map_one_sg() already produces -ENOMEM.
> >
> > That way every ring layout reports the same errno, and the block layer
> > requeues the request instead of failing it.
> >
> > Fixes: f7728002c1c7 ("virtio_ring: fix return code on DMA mapping fails=
")
> > Fixes: f6a15d854986 ("virtio_ring: add in order support")
>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>

Even if I'd like to see this merged, I'm having second thoughts
because it introduces userland visible changes in some drivers. Are
them acceptable?

---
1. virtio_crypto (skcipher) =E2=80=94 errno changes via AF_ALG socket

userspace: socket(AF_ALG, SOCK_SEQPACKET, 0)
           bind(fd, {ALG_SET_KEY, "cbc(aes)"}, ...)
           sendmsg(fd, plaintext, ...)     =E2=86=90 submits data
           recvmsg(fd, ciphertext, ...)    =E2=86=90 triggers encryption,
waits for result

The kernel path:
recvmsg()
  =E2=86=92 skcipher_recvmsg()           [crypto/algif_skcipher.c:180]
      =E2=86=92 _skcipher_recvmsg()      [crypto/algif_skcipher.c:84]
          =E2=86=92 crypto_skcipher_encrypt(&areq->cra_u.skcipher_req)
              =E2=86=92 virtio_crypto_skcipher_encrypt()
                  =E2=86=92 crypto_transfer_skcipher_request_to_engine()
                  [enqueues req; engine kthread picks it up]
          =E2=86=92 crypto_wait_req(err, &ctx->wait)
              waits on completion

In the crypto engine kthread:
crypto_pump_requests()           [crypto/crypto_engine.c:~100]
  =E2=86=92 op->do_one_request(engine, async_req)
      =3D virtio_crypto_skcipher_crypt_req()  [virtio_crypto_skcipher_algs.=
c:530]
          =E2=86=92 __virtio_crypto_skcipher_do_req()
              =E2=86=92 virtqueue_add_sgs(data_vq->vq, ...)
                  =E2=86=92 virtqueue_add_packed()   =E2=86=90 changed here

Error propagation =E2=80=94 before commit:
virtqueue_add_packed()                returns -EIO
  __virtio_crypto_skcipher_do_req()   returns -EIO (err propagated
directly)
  virtio_crypto_skcipher_crypt_req()  returns -EIO
  crypto_engine.c:155:  crypto_request_complete(async_req, -EIO)
    =E2=86=92 crypto_req_done(wait, -EIO)
    =E2=86=92 wait->err =3D -EIO; complete(&wait->completion)
  crypto_wait_req() returns -EIO
  _skcipher_recvmsg() returns -EIO
  skcipher_recvmsg() returns -EIO
  userspace recvmsg() returns -1, errno =3D EIO (5)

Error propagation =E2=80=94 after commit:
virtqueue_add_packed()                returns -ENOMEM
  ... same chain ...
  userspace recvmsg() returns -1, errno =3D ENOMEM (12)

---
2. spi-virtio =E2=80=94 errno changes via spidev ioctl

A userspace SPI application using /dev/spidevX.Y:

userspace: ioctl(fd, SPI_IOC_MESSAGE(n), &xfer)
  =E2=86=92 spidev_ioctl()           [drivers/spi/spidev.c]
      =E2=86=92 spidev_message()
          =E2=86=92 spi_sync(spi, &msg)
              =E2=86=92 __spi_sync()       [drivers/spi/spi.c:4687]
                  =E2=86=92 __spi_transfer_message_noqueue()
                      =E2=86=92 spi_transfer_one_message()
[drivers/spi/spi.c:~1603]
                          =E2=86=92 ctlr->transfer_one(ctlr, msg->spi, xfer=
)
                              =3D virtio_spi_transfer_one()
[drivers/spi/spi-virtio.c:148]
                                  =E2=86=92 virtqueue_add_sgs(priv->vq, ...=
)
                                      =E2=86=92 virtqueue_add_packed()   =
=E2=86=90
changed here

Error propagation:

Inside virtio_spi_transfer_one() at line 251=E2=80=93253:
msg_done:
    if (ret)
        ctrl->cur_msg->status =3D ret;
    return ret;

In spi_transfer_one_message() at line 1637=E2=80=931655:
ret =3D ctlr->transfer_one(ctlr, msg->spi, xfer);
if (ret < 0) {
    ...goto out;
}
// out: msg->status =3D ret  (line 1708)

Back in __spi_sync() at line 4723: return message->status;

The errno from virtqueue_add_packed() propagates all the way to the
ioctl() return value: before the commit, ioctl() returns -EIO; after,
-ENOMEM. Any spidev userspace code that checks errno would observe the
difference.
---

Claude also found another issue in gpio but the code has more
ramifications and I couldn't verify it:

3. gpio-virtio =E2=80=94 errno changes via GPIO character device ioctl

A userspace GPIO application using the character device API (/dev/gpiochipX=
):

userspace: ioctl(fd, GPIO_V2_GET_LINE_VALUES_IOCTL, &data)
  =E2=86=92 linereq_ioctl()          [drivers/gpio/gpiolib-cdev.c]
      =E2=86=92 linereq_get_values()
          =E2=86=92 gpiod_get_value_cansleep(line->desc)
              =E2=86=92 gpio_chip_get_value()   [drivers/gpio/gpiolib.c:341=
2]
                  =E2=86=92 gpiochip_get(gc, offset)  [drivers/gpio/gpiolib=
.c:3394]
                      =E2=86=92 gc->get(gc, offset)
                          =3D virtio_gpio_get()   [drivers/gpio/gpio-virtio=
.c:194]
                              =E2=86=92 virtio_gpio_req(vgpio, ...)
                                  =E2=86=92 _virtio_gpio_req()
                                      =E2=86=92
virtqueue_add_sgs(vgpio->request_vq, ...)
                                          =E2=86=92 virtqueue_add_packed() =
  =E2=86=90
changed here

_virtio_gpio_req() at line 100=E2=80=93104:
ret =3D virtqueue_add_sgs(vgpio->request_vq, sgs, 1, 1, line, GFP_KERNEL);
if (ret) {
    ...
    goto out;
}
// out: return ret

Apart from that, Claude also detected a change in behavior worth
checking, regardless of whether this patch is applied.
drivers/scsi/virtio_scsi.c:virtscsi_queuecommand will complete the
command if the return of virtscsi_add_cmd is -EIO, but it will not do
it if ret is different than 0 and -EIO.

> > Assisted-by: Kiro:claude-opus-5 checkpatch sparse
> > Signed-off-by: Alexander Graf <graf@amazon.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index ea8e774b6d8e..b7b03166a301 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -1810,7 +1810,7 @@ static inline int virtqueue_add_packed(struct vri=
ng_virtqueue *vq,
> >         }
> >
> >         END_USE(vq);
> > -       return -EIO;
> > +       return -ENOMEM;
> >  }
> >
> >  static inline int virtqueue_add_packed_in_order(struct vring_virtqueue=
 *vq,
> > @@ -1966,7 +1966,7 @@ static inline int virtqueue_add_packed_in_order(s=
truct vring_virtqueue *vq,
> >         }
> >
> >         END_USE(vq);
> > -       return -EIO;
> > +       return -ENOMEM;
> >  }
> >
> >  static bool virtqueue_kick_prepare_packed(struct vring_virtqueue *vq)
> >

