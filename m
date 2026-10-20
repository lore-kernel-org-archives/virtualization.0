Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505362;
	b=cux5erfefnNR2CkAxbyzdwVk62xQzdaNUg7XeRMoHg+kDV/wdHuQruV/6yRDS0wsndLb
	 9Rm8BKsCnFeKT2nzx6piVui2KMp1p5jISxbF79PZzHQv68ftm0jVmsDoZnwSrwSNhTbWX
	 pVFarJzTVyho4o2Z4gdI/N7lslwvr+V7Zw2rEZwfznhLPZV4XIMQ/OEajf1vni1YVE4/M
	 QCM+G8ilN5M9TNDtVK90TclVyBrqgADe5bDjXiwPB+SSolEW8wFBWVzjgcVCai2oJzy/H
	 4wk66k8w9B0bV1s7b7FjlpUIY0bUO2biH/I7dczXZijLx+aklFWyRypJWdZ5FuwsZbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505362;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UUHwmadkI7QkcbUi78pJONj24e7+aHhbx5/mWnjQMXM=;
	b=xJ284sh387Ypz1gVn6UsSzEWTYhOwFJ9+QYerzpxdiIeAE9RLLU8XwHw92BDvrvP0tvM
	 KFdYPQUklo8dDP5pWrItYuaZ2yYFKJTwiL1Wsqq5q4Xocoaa/kSYAkUT+Lay50sd0RcOp
	 mDdxFsqOHWHrzra47gDfBqD3wdSJQ+QMclikvve8ZIW5H9JKs/i8BbPne6lkAAXJwCCMq
	 IoqEmldsQy3O6Zf1838mn9pwN/obn0bAU/Y5UQzmzII27bVL0VPsi3ythsYvO7p0V388o
	 dh4zic+m3cap4qVHeIeiZ67lYZc1GsqUIgK8pPV5gLudp8D2E3uIYkoC16NHRKcBmEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LpEWN77M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14368606A31A
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LpEWN77M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C801F000C4;
	Tue, 20 Oct 2026 14:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792505361;
	bh=UUHwmadkI7QkcbUi78pJONj24e7+aHhbx5/mWnjQMXM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LpEWN77Mgj99jwDfNexyjbameVTz2V1lpw9qZqh3kRwVJJ0MbamHV1QzJ3GHm9ZGw
	 jzVimKiIBUBkg/RK9UIG7eDue1IgOL4mBtMBnCwIDfIkqIaaoEIt/gLmNzZlujBLIg
	 Hz68tVxKw904VSxmNNKzCECSKpv6FsR2sDECVlcEI63xzGL5ceqQVbs9td/dw6ArBE
	 C/cs1kW3Md1DFRQfDvZEGbSwHeb/JiclHdyeDUPxWr/pZV+86V+DMlo5p5OKFrtZcJ
	 zZJGfhePiBsZcdCx2WBcxQLfQRshJj78OlKlbJ9mWJO6I5GVCmjCu7Wgiv+6K+vxan
	 WdnMXsxCoAMZw==
Message-ID: <sashiko-outbox-179086@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fuse: virtio-fs: don't process completions of aborted
 requests
Reply-To: sashiko-reviews@lists.linux.dev
To: Qihang <q.h.hack.winter@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261020135350.7751-1-q.h.hack.winter@gmail.com>
References: <20261020135350.7751-1-q.h.hack.winter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 14:09:21 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] fuse: virtio-fs: DMA use-after-free on aborted requests in fus=
e_chan_abort()
- [High] fuse: virtio-fs: fsvq->aborted never cleared in virtio_fs_start_al=
l_queues()
- [High] fuse: virtio-fs: queued_reqs not aborted or drained in virtio_fs_a=
bort()
- [Medium] fuse: virtio-fs: req->argbuf leak on aborted requests in done_wo=
rk
--

commit 0a788f32822f61f6e1ab378f337037e0c6397f67
Author: Qihang <q.h.hack.winter@gmail.com>

fuse: virtio-fs: don't process completions of aborted requests

This commit adds an abort callback to struct fuse_iqueue_ops so virtio-fs c=
an
mark its virtqueues as aborted when fuse_chan_abort() runs. In
virtio_fs_requests_done_work(), completions on an aborted virtqueue are
skipped after decrementing in_flight to avoid dereferencing requests already
freed by fuse_chan_abort().

> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index ba8d79c4bcac6..ae4a14aaaba98 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -55,6 +55,7 @@ struct virtio_fs_vq {
>  	struct work_struct dispatch_work;
>  	struct fuse_dev *fud;
>  	bool connected;
> +	bool aborted;
>  	long in_flight;
>  	struct completion in_flight_zero; /* No inflight requests */
>  	struct kobject *kobj;
> @@ -871,6 +872,15 @@ static void virtio_fs_requests_done_work(struct work=
_struct *work)
>  		virtqueue_disable_cb(vq);
> =20
>  		while ((req =3D virtqueue_get_buf(vq, &len)) !=3D NULL) {
> +			if (fsvq->aborted) {
> +				/*
> +				 * fuse_chan_abort() ended every request this
> +				 * queue still owns; the token may already be
> +				 * freed, do not touch it.
> +				 */
> +				dec_in_flight_req(fsvq);
> +				continue;
> +			}

[Severity: Critical]
Can this still result in a DMA use-after-free on struct fuse_req and
ap->folios before virtqueue_get_buf() even returns?

In virtio_fs_enqueue_req(), the scatter-gather list passed to
virtqueue_add_sgs() maps &req->in.h, req->argbuf, and input ap->folios as
device-readable buffers, and maps &req->out.h (embedded inside struct
fuse_req), req->argbuf + argbuf_used, and output ap->folios as
device-writable buffers:

fs/fuse/virtio_fs.c:virtio_fs_enqueue_req() {
	...
	/* Request elements */
	sg_init_one(&sg[out_sgs++], &req->in.h, sizeof(req->in.h));
	out_sgs +=3D sg_init_fuse_args(&sg[out_sgs], req,
				     (struct fuse_arg *)args->in_args,
				     args->in_numargs, args->in_pages,
				     req->argbuf, &argbuf_used);

	/* Reply elements */
	if (test_bit(FR_ISREPLY, &req->flags)) {
		sg_init_one(&sg[out_sgs + in_sgs++],
			    &req->out.h, sizeof(req->out.h));
		in_sgs +=3D sg_init_fuse_args(&sg[out_sgs + in_sgs], req,
					    args->out_args, args->out_numargs,
					    args->out_pages,
					    req->argbuf + argbuf_used, NULL);
	}
	...
}

When fuse_chan_abort() runs while a request is in flight in the virtqueue,
virtio_fs_abort() sets fsvq->aborted =3D true without resetting the virtio
device, and fuse_chan_abort() immediately splices fpq->processing onto
to_end and calls fuse_dev_end_requests() -> fuse_request_end(). That invokes
req->args->end() (unlocking and releasing ap->folios) and frees struct
fuse_req back to fuse_req_cachep via fuse_request_free() while the
descriptor chain remains active in the virtqueue.

When the host later completes the stalled descriptor, won't the device (and
any DMA unmapping in virtqueue_get_buf()) write into &req->out.h inside the
already-freed struct fuse_req and into the released ap->folios before
reaching the fsvq->aborted check here?

[Severity: Medium]
Does skipping virtio_fs_request_complete() here also leak req->argbuf for
every aborted in-flight request?

When virtio_fs_enqueue_req() prepares a request, copy_args_to_argbuf()
allocates req->argbuf:

fs/fuse/virtio_fs.c:copy_args_to_argbuf() {
	...
	req->argbuf =3D kmalloc(len, gfp);
	if (!req->argbuf)
		return -ENOMEM;
	...
}

Normally req->argbuf is freed in copy_args_from_argbuf() called from
virtio_fs_request_complete(). When fuse_chan_abort() ends requests on
fpq->processing via fuse_dev_end_requests() -> fuse_request_end() ->
fuse_put_request() -> fuse_request_free(), struct fuse_req is freed to
fuse_req_cachep without freeing req->argbuf:

fs/fuse/dev.c:fuse_request_free() {
	WARN_ON(!list_empty(&req->intr_entry));
	kmem_cache_free(fuse_req_cachep, req);
}

Since virtio_fs_requests_done_work() skips virtio_fs_request_complete() when
fsvq->aborted is true (and req is already freed at that point), where is
req->argbuf freed for aborted requests?

>  			if (!virtio_fs_verify_response(req, len)) {
>  				req->out.h.error =3D -EIO;
>  				req->out.h.len =3D sizeof(struct fuse_out_header);
> @@ -1570,10 +1580,26 @@ static void virtio_fs_send_req(struct fuse_iqueue=
 *fiq, struct fuse_req *req)
>  	}
>  }
> =20
> +static void virtio_fs_abort(struct fuse_iqueue *fiq)
> +{
> +	struct virtio_fs *fs =3D fiq->priv;
> +	int i;
> +
> +	for (i =3D 0; i < fs->nvqs; i++) {
> +		struct virtio_fs_vq *fsvq =3D &fs->vqs[i];
> +
> +		spin_lock(&fsvq->lock);
> +		fsvq->connected =3D false;
> +		fsvq->aborted =3D true;
> +		spin_unlock(&fsvq->lock);
> +	}
> +}

[Severity: High]
Will setting fsvq->aborted =3D true here without clearing it when queues are
restarted break subsequent mounts of the same virtio-fs filesystem?

A struct virtio_fs instance and its fs->vqs[] array persist across mounts
for the lifetime of the virtio_device. On a normal unmount,
virtio_kill_sb() -> virtio_fs_conn_destroy() -> fuse_conn_destroy() calls
fuse_chan_abort(fc->chan, false):

fs/fuse/inode.c:fuse_conn_destroy() {
	...
	fuse_chan_abort(fc->chan, false);
	fuse_chan_wait_aborted(fc->chan);
	...
}

Because fch->connected is still set during a normal unmount,
fuse_chan_abort() invokes fiq->ops->abort(fiq) -> virtio_fs_abort(fiq),
which sets fsvq->aborted =3D true on every queue in fs->vqs[].

When the same virtio-fs tag is mounted again, virtio_fs_get_tree() ->
virtio_fs_fill_super() calls virtio_fs_start_all_queues(fs), which sets
fsvq->connected =3D true but never clears fsvq->aborted:

fs/fuse/virtio_fs.c:virtio_fs_start_all_queues() {
	struct virtio_fs_vq *fsvq;
	int i;

	for (i =3D 0; i < fs->nvqs; i++) {
		fsvq =3D &fs->vqs[i];
		spin_lock(&fsvq->lock);
		fsvq->connected =3D true;
		spin_unlock(&fsvq->lock);
	}
}

On the new mount, won't virtio_fs_requests_done_work() see fsvq->aborted =
=3D=3D
true and drop all completions (starting with FUSE_INIT from
fuse_send_init()), leaking req->argbuf and hanging the mount?

[Severity: High]
What happens to requests on fsvq->queued_reqs when virtio_fs_abort() runs?

When a virtqueue is full, virtio_fs_enqueue_req() drops fsvq->lock and
returns -ENOSPC without adding req to fpq->processing. Both
virtio_fs_send_req() and virtio_fs_request_dispatch_work() then re-acquire
fsvq->lock and place req onto fsvq->queued_reqs without checking
fsvq->connected:

fs/fuse/virtio_fs.c:virtio_fs_send_req() {
	...
	fsvq =3D &fs->vqs[queue_id];
	ret =3D virtio_fs_enqueue_req(fsvq, req, false, GFP_ATOMIC);
	if (ret < 0) {
		if (ret =3D=3D -ENOSPC) {
			/*
			 * Virtqueue full. Retry submission from worker
			 * context as we might be holding fc->chan->bg_lock.
			 */
			spin_lock(&fsvq->lock);
			list_add_tail(&req->list, &fsvq->queued_reqs);
			inc_in_flight_req(fsvq);
			spin_unlock(&fsvq->lock);
			return;
		}
	...
}

Because FR_PENDING was already cleared in virtio_fs_send_req() and req is
not on fpq->processing, fuse_chan_abort() will not find these requests. In
addition, a racing virtio_fs_send_req() that saw fsvq->connected =3D=3D true
inside virtio_fs_enqueue_req() and got -ENOSPC can acquire fsvq->lock after
virtio_fs_abort() has finished and still add req to fsvq->queued_reqs.

Since virtio_fs_abort() does not drain fsvq->queued_reqs or schedule
fsvq->dispatch_work (which is otherwise only scheduled from
virtio_fs_requests_done_work() when completions arrive), won't requests left
on fsvq->queued_reqs when the host stalls never be ended, hanging tasks in
request_wait_answer(), fuse_chan_wait_aborted(), and
virtio_fs_drain_queue()?

[ ... ]

=E0=AE=B5=E0=AE=BF=E0=AE=B0=E0=AF=81=E0=AE=AE=E0=AF=8D=E0=AE=AA=E0=AE=BF=E0=
=AE=AF=E0=AE=AA=E0=AE=9F=E0=AE=BF, =E0=AE=87=D9=8A=D9=85=E0=AF=86=E0=AE=AF=
=E0=AE=BF=E0=AE=B2=E0=AF=8D =E0=AE=AA=E0=AE=A4=E0=AE=BF=E0=AE=B2=E0=AF=88 =
=E0=AE=AE=E0=AF=87=E0=AE=B2=E0=AF=87 =E0=AE=89=E0=AE=B0=E0=AF=81=E0=AE=B5=
=E0=AE=BE=E0=AE=95=E0=AF=8D=E0=AE=95=E0=AE=BF=E0=AE=AF=E0=AF=81=E0=AE=B3=E0=
=AF=8D=E0=AE=B3=E0=AF=87=E0=AE=A9=E0=AF=8D.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020135350.7751=
-1-q.h.hack.winter@gmail.com?part=3D1
