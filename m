Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEB21A3151
	for <virtualization@lists.linux.dev>; Thu, 22 May 2025 18:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747937578; cv=none; b=V17A7VE8+zoTrETgIcgmHNTaQvPUcZIwexhwTkUV9xV1OtJuzaM01t/Kou+Hha6I0X+lSzRv71hfan2FmeFqhlQRpYyLbiBdd+zD7FQBP3SkVzIOUl+bh1YVKtoWrLdvpJwTI6XnS/1XMuXvCOt/NMneF24v6dEJ4YcakYodeas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747937578; c=relaxed/simple;
	bh=pLD0Zz0+CKiuObDgQgIr8qMKcbFofLrMv4/l/GL/UQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eub52xvW5WJSBt+BfaSj2O6SLsWynXhVVkP4N9WII6n720tGMWMwLQWmJIqDWzaxC1gkPU+mqixx8+38ZC9zFp3Gb0eZNmqCAeUlpzb9mUBjQWLeFb4QjUggUIcnyYWf5LxrmZuLC+idu5GG5eu4ktulaSPVJE21HTnDEV4ixXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNu59S0g; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNu59S0g"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-601609043cfso10120514a12.0
        for <virtualization@lists.linux.dev>; Thu, 22 May 2025 11:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747937575; x=1748542375; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mi5as4pLIeSTHb4ODq9ZbfkgOejgMnWqt7s48dSoFP0=;
        b=WNu59S0g44NkFKZqkQ0TAgqZQdt94NRmqDwcR6Dn8eHLNEjuvuWloln/Bv84xQ7DGT
         Mts6lmVwJxFMFJNJS0Ou27FI6LEj7UEpr3+KJAMtt6Y8qyZkGzAldMoLauVPUgPi3z+a
         wvCJyux5so4g/3AVhBK+vrUpbETzBLl4Z4tHNmvsGYfOS2u47TRYjMCLbjtRmvpDxdmq
         yqYX7QE15+jXEQuFSsoJdxltfsaTlvyMuYUK/qv+D27Lxpq2qvfE0PxClUMyGB35ksMG
         JxiO7p9A0hSnwgXHwlM7uoeolDUC8fI61242LIWSG+vEELKR796MHJSGSKAQ/maGnIVW
         tHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747937575; x=1748542375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mi5as4pLIeSTHb4ODq9ZbfkgOejgMnWqt7s48dSoFP0=;
        b=ff9/6Npg5+NHmouv7Tq2SRiYzwoz6X+9+rMCmmUgvPP/YcsE0nCgWJAyEs9KYZ7N1m
         nu+vHgzm19QGPoCTu3h9JYtXMtatG03pILLjP0+zvBAMFS7wU13H7NwmvCOiEI2n3fkb
         DYalN6QqAsnwcxtv91R+CTReyuVmcDVHH/vW15EyBLlfy5IKft7qPpll3fhW1bJAWbC1
         xPcpV9uFhC0Uw+83qwOkzo2NH5lHeGa0Ac9TWHHEMdfPTDhI8hpu/KMyoBv2xW445VY1
         UD5iBEOipj2EP8yPkxrrElmJGtlB16ytaeBAWMCzfUsDQGCOfj+i1XMKTztK1MN3yk9V
         daVg==
X-Forwarded-Encrypted: i=1; AJvYcCWsWuHwBoBB/ulD6rRjYtpY0qHTTkH2BXSHgu7SrFFFDKlHKo5sytj04XZ1sPx9qr+/E6ofzuRFfFw96+4JlA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwpkzbQ/Cp0UgF2GpjGh+TdGSrXBgGFRHFD0ikeP39AU1p3BH1V
	xzuqFfnZTOHC+hPb24n4Lg0+gFNLqnuhEC15R+WGPeH5xrIiYNc1YVIzJJgBU8BEtsGpvn8G8Zg
	jc26BdHlmLXXM26mghPA99ANsySbU1P99htGw
X-Gm-Gg: ASbGncvlPSLPyUeUqLDNG7YKRNxgvefCaVWwUSNxfh4SoyS8ytfU2ajvecNDbHuN+jh
	U5REWvB9G7s/VGREANze8ZAU8M10g11/vvECeGR8Vt8L8IIT/28hQoqsevMFtWaB/WJicSJXERV
	OzNH6PifXQWifJ3znmhAYUmAxuj6feT1c=
X-Google-Smtp-Source: AGHT+IHAo2Q3RB63kh4X4xKSSzOsP/Q+DVoZ8xtib0s08KYkYmK0p67EX9EdXeI/OUfJqIjA6/8jM5bV9cy/HFwyF5I=
X-Received: by 2002:a05:6402:210d:b0:602:352a:37da with SMTP id
 4fb4d7f45d1cf-60291612167mr63085a12.29.1747937574559; Thu, 22 May 2025
 11:12:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250521062744.1361774-1-parav@nvidia.com> <20250521145635.GA120766@fedora>
 <CY8PR12MB7195DE1F8F11675CD2584D22DC99A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <CAJSP0QXxspELYnToMuP1w86rayQgPDRccVo892C258y9UbH_Hg@mail.gmail.com> <CY8PR12MB71958DFA8D0043DA3842B93ADC99A@CY8PR12MB7195.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB71958DFA8D0043DA3842B93ADC99A@CY8PR12MB7195.namprd12.prod.outlook.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 22 May 2025 14:12:42 -0400
X-Gm-Features: AX0GCFsKPjkqEkOibjBnSVUKhn8g_8n1qv46GUsdgJtXXtiQ3ubpHY_LMW0NtLM
Message-ID: <CAJSP0QWKuUvEZcDPR0notPsqv3_-eNk1E1YT0zUA3JKYhp9+Fw@mail.gmail.com>
Subject: Re: [PATCH v1] virtio_blk: Fix disk deletion hang on device surprise removal
To: Parav Pandit <parav@nvidia.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "mst@redhat.com" <mst@redhat.com>, 
	"axboe@kernel.dk" <axboe@kernel.dk>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"jasowang@redhat.com" <jasowang@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, 
	Israel Rukshin <israelr@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 10:56=E2=80=AFAM Parav Pandit <parav@nvidia.com> wr=
ote:
>
>
> > From: Stefan Hajnoczi <stefanha@gmail.com>
> > Sent: Thursday, May 22, 2025 8:06 PM
> >
> > On Wed, May 21, 2025 at 10:57=E2=80=AFPM Parav Pandit <parav@nvidia.com=
> wrote:
> > > > From: Stefan Hajnoczi <stefanha@redhat.com>
> > > > Sent: Wednesday, May 21, 2025 8:27 PM
> > > >
> > > > On Wed, May 21, 2025 at 06:37:41AM +0000, Parav Pandit wrote:
> > > > > When the PCI device is surprise removed, requests may not complet=
e
> > > > > the device as the VQ is marked as broken. Due to this, the disk
> > > > > deletion hangs.
> > > > >
> > > > > Fix it by aborting the requests when the VQ is broken.
> > > > >
> > > > > With this fix now fio completes swiftly.
> > > > > An alternative of IO timeout has been considered, however when th=
e
> > > > > driver knows about unresponsive block device, swiftly clearing
> > > > > them enables users and upper layers to react quickly.
> > > > >
> > > > > Verified with multiple device unplug iterations with pending
> > > > > requests in virtio used ring and some pending with the device.
> > > > >
> > > > > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of
> > > > > virtio pci device")
> > > > > Cc: stable@vger.kernel.org
> > > > > Reported-by: lirongqing@baidu.com
> > > > > Closes:
> > > > > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca=
9
> > > > > b474
> > > > > 1@baidu.com/
> > > > > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> > > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > > > ---
> > > > > changelog:
> > > > > v0->v1:
> > > > > - Fixed comments from Stefan to rename a cleanup function
> > > > > - Improved logic for handling any outstanding requests
> > > > >   in bio layer
> > > > > - improved cancel callback to sync with ongoing done()
> > > > >
> > > > > ---
> > > > >  drivers/block/virtio_blk.c | 95
> > > > > ++++++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 95 insertions(+)
> > > > >
> > > > > diff --git a/drivers/block/virtio_blk.c
> > > > > b/drivers/block/virtio_blk.c index 7cffea01d868..5212afdbd3c7
> > > > > 100644
> > > > > --- a/drivers/block/virtio_blk.c
> > > > > +++ b/drivers/block/virtio_blk.c
> > > > > @@ -435,6 +435,13 @@ static blk_status_t virtio_queue_rq(struct
> > > > blk_mq_hw_ctx *hctx,
> > > > >     blk_status_t status;
> > > > >     int err;
> > > > >
> > > > > +   /* Immediately fail all incoming requests if the vq is broken=
.
> > > > > +    * Once the queue is unquiesced, upper block layer flushes an=
y
> > > > pending
> > > > > +    * queued requests; fail them right away.
> > > > > +    */
> > > > > +   if (unlikely(virtqueue_is_broken(vblk->vqs[qid].vq)))
> > > > > +           return BLK_STS_IOERR;
> > > > > +
> > > > >     status =3D virtblk_prep_rq(hctx, vblk, req, vbr);
> > > > >     if (unlikely(status))
> > > > >             return status;
> > > > > @@ -508,6 +515,11 @@ static void virtio_queue_rqs(struct rq_list
> > *rqlist)
> > > > >     while ((req =3D rq_list_pop(rqlist))) {
> > > > >             struct virtio_blk_vq *this_vq =3D get_virtio_blk_vq(r=
eq-
> > > > >mq_hctx);
> > > > >
> > > > > +           if (unlikely(virtqueue_is_broken(this_vq->vq))) {
> > > > > +                   rq_list_add_tail(&requeue_list, req);
> > > > > +                   continue;
> > > > > +           }
> > > > > +
> > > > >             if (vq && vq !=3D this_vq)
> > > > >                     virtblk_add_req_batch(vq, &submit_list);
> > > > >             vq =3D this_vq;
> > > > > @@ -1554,6 +1566,87 @@ static int virtblk_probe(struct
> > > > > virtio_device
> > > > *vdev)
> > > > >     return err;
> > > > >  }
> > > > >
> > > > > +static bool virtblk_request_cancel(struct request *rq, void *dat=
a) {
> > > > > +   struct virtblk_req *vbr =3D blk_mq_rq_to_pdu(rq);
> > > > > +   struct virtio_blk *vblk =3D data;
> > > > > +   struct virtio_blk_vq *vq;
> > > > > +   unsigned long flags;
> > > > > +
> > > > > +   vq =3D &vblk->vqs[rq->mq_hctx->queue_num];
> > > > > +
> > > > > +   spin_lock_irqsave(&vq->lock, flags);
> > > > > +
> > > > > +   vbr->in_hdr.status =3D VIRTIO_BLK_S_IOERR;
> > > > > +   if (blk_mq_request_started(rq) && !blk_mq_request_completed(r=
q))
> > > > > +           blk_mq_complete_request(rq);
> > > > > +
> > > > > +   spin_unlock_irqrestore(&vq->lock, flags);
> > > > > +   return true;
> > > > > +}
> > > > > +
> > > > > +static void virtblk_broken_device_cleanup(struct virtio_blk *vbl=
k) {
> > > > > +   struct request_queue *q =3D vblk->disk->queue;
> > > > > +
> > > > > +   if (!virtqueue_is_broken(vblk->vqs[0].vq))
> > > > > +           return;
> > > >
> > > > Can a subset of virtqueues be broken? If so, then this code doesn't=
 handle
> > it.
> > > On device removal all the VQs are broken. This check only uses a VQ t=
o decide
> > on.
> > > In future may be more elaborate API to have virtio_dev_broken() can b=
e
> > added.
> > > Prefer to keep this patch without extending many APIs given it has Fi=
xes tag.
> >
> > virtblk_remove() is called not just when a PCI device is hot unplugged.=
 For
> > example, removing the virtio_blk kernel module or unbinding a specific =
virtio
> > device instance also calls it.
> >
> This is ok.
>
> > My concern is that virtblk_broken_device_cleanup() is only intended for=
 the
> > cases where all virtqueues are broken or none are broken. If just the f=
irst
> > virtqueue is broken then it completes requests on operational virtqueue=
s and
> > they may still raise an interrupt.
> >
> I see that vq broken is extended for each reset scenario too lately in vp=
_modern_enable_vq_after_reset().
> So yes, this patch which was intended for original surprise removal bug w=
here vq broken was not done for reset cases.
>
> I believe for fixing the cited patch, device->broken flag should be used.
> Max indicated this in an internal review, but I was inclined to avoid add=
ing many changes.
> And hence reuse vq broken.
>
> So one option is to extend,
>
> virtio_break_device() to have a flag like below and check during remove()=
.
>   dev->broken =3D true;
>
> or to revert the patch, 43bb40c5b926, which Michael was not linking.
>
> > The use-after-free I'm thinking about is when virtblk_request_cancel()
> > -> ... -> blk_mq_end_request() has been called on a virtqueue that is
> > not broken, followed by virtblk_done() using the struct request obtaine=
d from
> > blk_mq_rq_from_pdu().
> >
> This can happen for case when nonsurprise removal is done possibly.
>
> > Maybe just adding a virtqueue_is_broken() check in
> > virtblk_request_cancel() is enough to skip requests that are still in-f=
light on
> > operational virtqueues.
> Well, the idea of calling request_cancel() iterator only if the VQ is bro=
ken.
> So in regular remove() this should not be called. Existing flow is better=
.
>
> >
> > >
> > > >
> > > > > +
> > > > > +   /* Start freezing the queue, so that new requests keeps waitn=
g
> > > > > +at the
> > > >
> > > > s/waitng/waiting/
> > > >
> > > Ack.
> > >
> > > > > +    * door of bio_queue_enter(). We cannot fully freeze the queu=
e
> > > > because
> > > > > +    * freezed queue is an empty queue and there are pending
> > > > > + requests,
> > > > so
> > > > > +    * only start freezing it.
> > > > > +    */
> > > > > +   blk_freeze_queue_start(q);
> > > > > +
> > > > > +   /* When quiescing completes, all ongoing dispatches have comp=
leted
> > > > > +    * and no new dispatch will happen towards the driver.
> > > > > +    * This ensures that later when cancel is attempted, then are=
 not
> > > > > +    * getting processed by the queue_rq() or queue_rqs() handler=
s.
> > > > > +    */
> > > > > +   blk_mq_quiesce_queue(q);
> > > > > +
> > > > > +   /*
> > > > > +    * Synchronize with any ongoing VQ callbacks, effectively qui=
escing
> > > > > +    * the device and preventing it from completing further reque=
sts
> > > > > +    * to the block layer. Any outstanding, incomplete requests w=
ill be
> > > > > +    * completed by virtblk_request_cancel().
> > > > > +    */
> > > > > +   virtio_synchronize_cbs(vblk->vdev);
> > > > > +
> > > > > +   /* At this point, no new requests can enter the queue_rq() an=
d
> > > > > +    * completion routine will not complete any new requests
> > > > > + either for
> > > > the
> > > > > +    * broken vq. Hence, it is safe to cancel all requests which =
are
> > > > > +    * started.
> > > > > +    */
> > > > > +   blk_mq_tagset_busy_iter(&vblk->tag_set,
> > > > > +virtblk_request_cancel, vblk);
> > > >
> > > > Although virtio_synchronize_cbs() was called, a broken/malicious
> > > > device can still raise IRQs. Would that lead to use-after-free or
> > > > similar undefined behavior for requests that have been submitted to=
 the
> > device?
> > > >
> > > It shouldn't because vring_interrupt() also checks for the broken VQ =
before
> > invoking the _done().
> > > Once the VQ is broken and even if _done() is invoked, it wont progres=
s
> > further on get_buf().
> > > And VQs are freed later in del_vq() after the device is reset as you =
suggested.
> >
> > See above about a scenario where a race can happen.
> >
> > >
> > > > It seems safer to reset the device before marking the requests as f=
ailed.
> > > >
> > > Such addition should be avoided because when the device is surprise
> > removed, even reset will not complete.
> >
> > The virtblk_remove() function modified by this patch calls
> > virtio_reset_device(). Is the expected behavior after this patch that
> > virtblk_remove() spins forever?
> If the PCI device is truly removed physically, then yes.
> This patch is not addressing such problem that existed even before the pa=
tch in fixes tag.
>
> I have experienced this already. Adding that support is relatively bigger=
 change (than this fix).

Perhaps a full solution rather than a partial solution would end up
being simpler and cleaner. Instead of cutting out a special code path
for the virtio-blk PCI surprise unplug case, tackling how the core
virtio subsystem should handle PCI surprise unplug may give
virtio_blk.c more helpful virtio APIs that make it less complex. It's
up to you.

Stefan

>
> >
> > >
> > > > > +   blk_mq_tagset_wait_completed_request(&vblk->tag_set);
> > > > > +
> > > > > +   /* All pending requests are cleaned up. Time to resume so tha=
t disk
> > > > > +    * deletion can be smooth. Start the HW queues so that when
> > > > > + queue
> > > > is
> > > > > +    * unquiesced requests can again enter the driver.
> > > > > +    */
> > > > > +   blk_mq_start_stopped_hw_queues(q, true);
> > > > > +
> > > > > +   /* Unquiescing will trigger dispatching any pending requests =
to the
> > > > > +    * driver which has crossed bio_queue_enter() to the driver.
> > > > > +    */
> > > > > +   blk_mq_unquiesce_queue(q);
> > > > > +
> > > > > +   /* Wait for all pending dispatches to terminate which may hav=
e been
> > > > > +    * initiated after unquiescing.
> > > > > +    */
> > > > > +   blk_mq_freeze_queue_wait(q);
> > > > > +
> > > > > +   /* Mark the disk dead so that once queue unfreeze, the reques=
ts
> > > > > +    * waiting at the door of bio_queue_enter() can be aborted
> > > > > + right
> > > > away.
> > > > > +    */
> > > > > +   blk_mark_disk_dead(vblk->disk);
> > > > > +
> > > > > +   /* Unfreeze the queue so that any waiting requests will be ab=
orted.
> > > > */
> > > > > +   blk_mq_unfreeze_queue_nomemrestore(q);
> > > > > +}
> > > > > +
> > > > >  static void virtblk_remove(struct virtio_device *vdev)  {
> > > > >     struct virtio_blk *vblk =3D vdev->priv; @@ -1561,6 +1654,8 @@
> > > > > static void virtblk_remove(struct virtio_device *vdev)
> > > > >     /* Make sure no work handler is accessing the device. */
> > > > >     flush_work(&vblk->config_work);
> > > > >
> > > > > +   virtblk_broken_device_cleanup(vblk);
> > > > > +
> > > > >     del_gendisk(vblk->disk);
> > > > >     blk_mq_free_tag_set(&vblk->tag_set);
> > > > >
> > > > > --
> > > > > 2.34.1
> > > > >
> > >
