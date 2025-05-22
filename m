Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368D828B516
	for <virtualization@lists.linux.dev>; Thu, 22 May 2025 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747924596; cv=none; b=kYRQCXVUmcOFDHlSbc7g6UvmlTDqAB7xP/X/OdqQrMfWOKZO/seeZnnUdZ3N3IHZ39UElDtF6wS6AjIib7/oEwxUAA58NihcE3WerMSljsrinbpZ0EU8Zb40Aiqy64dOMXDDAPc3EWGZPJ7Vquk0ZAp/yYNHJncko0jXWIs1CG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747924596; c=relaxed/simple;
	bh=hjMDXompomdT07wCvFBZpFtruJvwktFdHUs/2Q0O7VA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPWCWItdTcpuxgqvfevHghrL7Est5+s3CXRtS8TXW98GP9r4Ma2yQd84XrbQf+d7Wnc9TQ4iawJ+E3oZs6p4UH+C+Ab0NAuYiYmaZDomLRgbueqxGmeG5W/o+yyHJbsRZ0cMZ0eFNTcaJNiVYRaGuswPYanjv2X2M7ubomAbA2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjIe4uLH; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjIe4uLH"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-601dbd75b74so7527189a12.1
        for <virtualization@lists.linux.dev>; Thu, 22 May 2025 07:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747924592; x=1748529392; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMpuUERD0otnom5mTOjs5MBvYsJ1hRyHhSqMmAzCudk=;
        b=BjIe4uLHomakbbQgkqnjwKzpqFf7LInDNmMR0/iAvHOFzRTZvTEV2r+oZZ1+RLbq4V
         Id2Imp7NSWujMzUcMNgep3f4rmqfWJ7lx5Snbd+jURWLhAvaB4sVFGuz5tLR0XcnjRtd
         fu+BMMKScGRFMiEamK9+0eXWFmOSCY4NJgt1ARq5bx3q2Ka54oK6VHT5SqN+sHWQRCVE
         L4VaAo7XZshon4lC7L3KTcY4aCdAnwbql1uJ8Vp2+6l9JcdroIJmfInyw3HtjWLjfd2D
         H2FAzt6rJ2FbrwP3iKV314XJOsdFRKz1FuGiV7yJjnEGYaBlDZWRgS9kIxePI2rmnxRl
         A7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747924592; x=1748529392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMpuUERD0otnom5mTOjs5MBvYsJ1hRyHhSqMmAzCudk=;
        b=n4qhMbtv+CIlI7q6mraRofRU2KIbUX8OfGJUAhn97mPu6uWIGQeTo5tBROkEZhmlt1
         yMbXpGrNQsp1k+UU6hoQRQ3z+zip+rrtpFay22apwgm15ep+hMkfEpCANxy46qP0wmPG
         auswwjkUuhwsJsTI6ZizD4lpHOndR/paxJE5PMEqexB0Mqc5UEftg14H7SJqItEmtgB7
         H+paqySA9jaahVsjdNZSscfLa9N3+xG+zq5JvOXnRYVcRejSca3h6o0K6M/2ajsC/4RE
         na5GrFjNlemohWKEEqFozbK4H87KMJ7vXI4rfNTiM28DKADjscFC7Iabh60V4tZsTuRa
         DNUg==
X-Forwarded-Encrypted: i=1; AJvYcCWyQ5ej4jwMh6U51aP+CpVbU5ULuFgs3hv8r4oBPxoqCZNA3uoCALl+ceZTJICQSamD+HEEK6V3qeFOCGAQMA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzyOH+G+zr90xfpYhJ1NyXhO2CX62CvgbJKQi3J2I/wqip1cg0z
	OCGaQgW25crO044iTu7kEjRC5ubciabJmgOjGtHFQR33Ijg6q/hpis4pMAo9I4gYOr6ANKB/3j4
	zuWHS+67AmJQFn/ixuzBUbBhFCjCpAR4=
X-Gm-Gg: ASbGncvMj176IKWsm5FsPqm1h76LLHhSMengI0pxUihkwiLIEWYkGiE8xaIgI10PQuO
	fCj01kTRE5UGh4HsX8CqxuIUC/qZjNWLZjfIGslke6mG5QZ3nHK/FSPVtRjACgfCf/2GhyrqZPC
	CxlRqJI+YWPmXX4qdfU0xJnRHEPKeoPOc=
X-Google-Smtp-Source: AGHT+IEVbRuUqCU+iqgBjw+TaWgbx2tIzgczBL5l/AjjK9wyN8bAKHExCEE5hoWSfCqKfaIhcjyYduO7+nrxkYfkb3Y=
X-Received: by 2002:a05:6402:40d2:b0:602:2e21:634e with SMTP id
 4fb4d7f45d1cf-6022e2167ecmr7301133a12.17.1747924592098; Thu, 22 May 2025
 07:36:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250521062744.1361774-1-parav@nvidia.com> <20250521145635.GA120766@fedora>
 <CY8PR12MB7195DE1F8F11675CD2584D22DC99A@CY8PR12MB7195.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB7195DE1F8F11675CD2584D22DC99A@CY8PR12MB7195.namprd12.prod.outlook.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 22 May 2025 10:36:19 -0400
X-Gm-Features: AX0GCFvXrPZQ5sB9s01EpTgI6VkuP4piXmnDsgQRV8Gsc3BZYQoomWKwefuwIY8
Message-ID: <CAJSP0QXxspELYnToMuP1w86rayQgPDRccVo892C258y9UbH_Hg@mail.gmail.com>
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

On Wed, May 21, 2025 at 10:57=E2=80=AFPM Parav Pandit <parav@nvidia.com> wr=
ote:
> > From: Stefan Hajnoczi <stefanha@redhat.com>
> > Sent: Wednesday, May 21, 2025 8:27 PM
> >
> > On Wed, May 21, 2025 at 06:37:41AM +0000, Parav Pandit wrote:
> > > When the PCI device is surprise removed, requests may not complete th=
e
> > > device as the VQ is marked as broken. Due to this, the disk deletion
> > > hangs.
> > >
> > > Fix it by aborting the requests when the VQ is broken.
> > >
> > > With this fix now fio completes swiftly.
> > > An alternative of IO timeout has been considered, however when the
> > > driver knows about unresponsive block device, swiftly clearing them
> > > enables users and upper layers to react quickly.
> > >
> > > Verified with multiple device unplug iterations with pending requests
> > > in virtio used ring and some pending with the device.
> > >
> > > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio
> > > pci device")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: lirongqing@baidu.com
> > > Closes:
> > > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b47=
4
> > > 1@baidu.com/
> > > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > ---
> > > changelog:
> > > v0->v1:
> > > - Fixed comments from Stefan to rename a cleanup function
> > > - Improved logic for handling any outstanding requests
> > >   in bio layer
> > > - improved cancel callback to sync with ongoing done()
> > >
> > > ---
> > >  drivers/block/virtio_blk.c | 95
> > > ++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 95 insertions(+)
> > >
> > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > index 7cffea01d868..5212afdbd3c7 100644
> > > --- a/drivers/block/virtio_blk.c
> > > +++ b/drivers/block/virtio_blk.c
> > > @@ -435,6 +435,13 @@ static blk_status_t virtio_queue_rq(struct
> > blk_mq_hw_ctx *hctx,
> > >     blk_status_t status;
> > >     int err;
> > >
> > > +   /* Immediately fail all incoming requests if the vq is broken.
> > > +    * Once the queue is unquiesced, upper block layer flushes any
> > pending
> > > +    * queued requests; fail them right away.
> > > +    */
> > > +   if (unlikely(virtqueue_is_broken(vblk->vqs[qid].vq)))
> > > +           return BLK_STS_IOERR;
> > > +
> > >     status =3D virtblk_prep_rq(hctx, vblk, req, vbr);
> > >     if (unlikely(status))
> > >             return status;
> > > @@ -508,6 +515,11 @@ static void virtio_queue_rqs(struct rq_list *rql=
ist)
> > >     while ((req =3D rq_list_pop(rqlist))) {
> > >             struct virtio_blk_vq *this_vq =3D get_virtio_blk_vq(req-
> > >mq_hctx);
> > >
> > > +           if (unlikely(virtqueue_is_broken(this_vq->vq))) {
> > > +                   rq_list_add_tail(&requeue_list, req);
> > > +                   continue;
> > > +           }
> > > +
> > >             if (vq && vq !=3D this_vq)
> > >                     virtblk_add_req_batch(vq, &submit_list);
> > >             vq =3D this_vq;
> > > @@ -1554,6 +1566,87 @@ static int virtblk_probe(struct virtio_device
> > *vdev)
> > >     return err;
> > >  }
> > >
> > > +static bool virtblk_request_cancel(struct request *rq, void *data) {
> > > +   struct virtblk_req *vbr =3D blk_mq_rq_to_pdu(rq);
> > > +   struct virtio_blk *vblk =3D data;
> > > +   struct virtio_blk_vq *vq;
> > > +   unsigned long flags;
> > > +
> > > +   vq =3D &vblk->vqs[rq->mq_hctx->queue_num];
> > > +
> > > +   spin_lock_irqsave(&vq->lock, flags);
> > > +
> > > +   vbr->in_hdr.status =3D VIRTIO_BLK_S_IOERR;
> > > +   if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq))
> > > +           blk_mq_complete_request(rq);
> > > +
> > > +   spin_unlock_irqrestore(&vq->lock, flags);
> > > +   return true;
> > > +}
> > > +
> > > +static void virtblk_broken_device_cleanup(struct virtio_blk *vblk) {
> > > +   struct request_queue *q =3D vblk->disk->queue;
> > > +
> > > +   if (!virtqueue_is_broken(vblk->vqs[0].vq))
> > > +           return;
> >
> > Can a subset of virtqueues be broken? If so, then this code doesn't han=
dle it.
> On device removal all the VQs are broken. This check only uses a VQ to de=
cide on.
> In future may be more elaborate API to have virtio_dev_broken() can be ad=
ded.
> Prefer to keep this patch without extending many APIs given it has Fixes =
tag.

virtblk_remove() is called not just when a PCI device is hot
unplugged. For example, removing the virtio_blk kernel module or
unbinding a specific virtio device instance also calls it.

My concern is that virtblk_broken_device_cleanup() is only intended
for the cases where all virtqueues are broken or none are broken. If
just the first virtqueue is broken then it completes requests on
operational virtqueues and they may still raise an interrupt.

The use-after-free I'm thinking about is when virtblk_request_cancel()
-> ... -> blk_mq_end_request() has been called on a virtqueue that is
not broken, followed by virtblk_done() using the struct request
obtained from blk_mq_rq_from_pdu().

Maybe just adding a virtqueue_is_broken() check in
virtblk_request_cancel() is enough to skip requests that are still
in-flight on operational virtqueues.

>
> >
> > > +
> > > +   /* Start freezing the queue, so that new requests keeps waitng at
> > > +the
> >
> > s/waitng/waiting/
> >
> Ack.
>
> > > +    * door of bio_queue_enter(). We cannot fully freeze the queue
> > because
> > > +    * freezed queue is an empty queue and there are pending requests=
,
> > so
> > > +    * only start freezing it.
> > > +    */
> > > +   blk_freeze_queue_start(q);
> > > +
> > > +   /* When quiescing completes, all ongoing dispatches have complete=
d
> > > +    * and no new dispatch will happen towards the driver.
> > > +    * This ensures that later when cancel is attempted, then are not
> > > +    * getting processed by the queue_rq() or queue_rqs() handlers.
> > > +    */
> > > +   blk_mq_quiesce_queue(q);
> > > +
> > > +   /*
> > > +    * Synchronize with any ongoing VQ callbacks, effectively quiesci=
ng
> > > +    * the device and preventing it from completing further requests
> > > +    * to the block layer. Any outstanding, incomplete requests will =
be
> > > +    * completed by virtblk_request_cancel().
> > > +    */
> > > +   virtio_synchronize_cbs(vblk->vdev);
> > > +
> > > +   /* At this point, no new requests can enter the queue_rq() and
> > > +    * completion routine will not complete any new requests either f=
or
> > the
> > > +    * broken vq. Hence, it is safe to cancel all requests which are
> > > +    * started.
> > > +    */
> > > +   blk_mq_tagset_busy_iter(&vblk->tag_set, virtblk_request_cancel,
> > > +vblk);
> >
> > Although virtio_synchronize_cbs() was called, a broken/malicious device=
 can
> > still raise IRQs. Would that lead to use-after-free or similar undefine=
d
> > behavior for requests that have been submitted to the device?
> >
> It shouldn't because vring_interrupt() also checks for the broken VQ befo=
re invoking the _done().
> Once the VQ is broken and even if _done() is invoked, it wont progress fu=
rther on get_buf().
> And VQs are freed later in del_vq() after the device is reset as you sugg=
ested.

See above about a scenario where a race can happen.

>
> > It seems safer to reset the device before marking the requests as faile=
d.
> >
> Such addition should be avoided because when the device is surprise remov=
ed, even reset will not complete.

The virtblk_remove() function modified by this patch calls
virtio_reset_device(). Is the expected behavior after this patch that
virtblk_remove() spins forever?

>
> > > +   blk_mq_tagset_wait_completed_request(&vblk->tag_set);
> > > +
> > > +   /* All pending requests are cleaned up. Time to resume so that di=
sk
> > > +    * deletion can be smooth. Start the HW queues so that when queue
> > is
> > > +    * unquiesced requests can again enter the driver.
> > > +    */
> > > +   blk_mq_start_stopped_hw_queues(q, true);
> > > +
> > > +   /* Unquiescing will trigger dispatching any pending requests to t=
he
> > > +    * driver which has crossed bio_queue_enter() to the driver.
> > > +    */
> > > +   blk_mq_unquiesce_queue(q);
> > > +
> > > +   /* Wait for all pending dispatches to terminate which may have be=
en
> > > +    * initiated after unquiescing.
> > > +    */
> > > +   blk_mq_freeze_queue_wait(q);
> > > +
> > > +   /* Mark the disk dead so that once queue unfreeze, the requests
> > > +    * waiting at the door of bio_queue_enter() can be aborted right
> > away.
> > > +    */
> > > +   blk_mark_disk_dead(vblk->disk);
> > > +
> > > +   /* Unfreeze the queue so that any waiting requests will be aborte=
d.
> > */
> > > +   blk_mq_unfreeze_queue_nomemrestore(q);
> > > +}
> > > +
> > >  static void virtblk_remove(struct virtio_device *vdev)  {
> > >     struct virtio_blk *vblk =3D vdev->priv; @@ -1561,6 +1654,8 @@ sta=
tic
> > > void virtblk_remove(struct virtio_device *vdev)
> > >     /* Make sure no work handler is accessing the device. */
> > >     flush_work(&vblk->config_work);
> > >
> > > +   virtblk_broken_device_cleanup(vblk);
> > > +
> > >     del_gendisk(vblk->disk);
> > >     blk_mq_free_tag_set(&vblk->tag_set);
> > >
> > > --
> > > 2.34.1
> > >
>
