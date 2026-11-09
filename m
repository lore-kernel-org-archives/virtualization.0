Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794194195;
	b=c/IDSQWXIJh34BTz8U+hOnpIcczCTbO1h5VNTFAkraG2M/iTfp8wGOq6CQWd2tXgjp9S
	 Pqvs73CAJIaaSwwIG8d86zZGr3NBUTY+oGH2OlKqMw+7RmS0JWOOH7nrgdGSw0Gq1m/2T
	 /37qurSL/vE9rVeIFDK+sj7DuHpMRAyEsg3fYTJ8A7dY6COKDJQIaEnJj6S6kGlcifF4X
	 8PtuEA1/zmZxCUbg252n8PkM1blRw6FnRnQNUpPssDmrqGAW1H++CMfdxvtmP73nPsLxZ
	 dqEtYZY4Oijr3AwN+4g7dW54X1+pOsqUu8aJLiEmxrCWGv7rBgzs1SnvKix9zS+LyWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794194195;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=svytfCjHGMy1hV5X4FeHFnhOup3ChNLOMu4Em+CuoAE=;
	b=e5528uvuAqMVCxGGNItN/c0b/89dHHuRAoKgcUHnP38+ECS1mz+Dv9b7tZ5WnwTzhSa/
	 alFKsZ1JIh7PkrKLZSSR026woHt77Xju1z+pYyJ6JSDGjsZVoY1Ld8ecq4DwnHsOPgCVM
	 VHourFmNxJDsAf6tLion57RearP+QWdbjb0uvE4nXMVTa0BEGvbbLPgtzQQ8KgMCVLrRW
	 bbGRUs+ybr9mACwafiT/VN7T4LVRM6F7Xq3GQ/2t2GwavnlQV1PxwqxLIFvJLAFhDpfLf
	 XFLCs9CU/KtUo1f9ZNSEIgQ9vj1qtgZir5BgkEGW7nxFvcbFKTmfJCpiv5j9VC5w0Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nbpEdmNZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC6C606A326
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 03:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nbpEdmNZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494921F0089F;
	Mon,  9 Nov 2026 03:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794194194;
	bh=svytfCjHGMy1hV5X4FeHFnhOup3ChNLOMu4Em+CuoAE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nbpEdmNZE1nIYciHLmdk9eSHnnZssSDM7NbiWc506wjssG1kg50teHj14fMfJwoSN
	 SuQnw4eZ0gSTDqOEcEpSy6AVOj2voPz3549GHdi73kbNGttNwAGCF2JYKQO4d5hNEa
	 nTQ3swmuagRvqa5LVeH6R5wyVge97vVN/xRnB0j41O0ziL5WxXT4eSkxt5mL1VltcJ
	 3kDZN9NIkJg5NzKbJBYuoAuEfcPN3OV6OBS++fUm7fuXU4CLWiGgCloT5TPgpgGYft
	 XKeGIA8TB60VzQALGeByb8XO0rGTQ8D+Cq3NzZLdhARw0quRCCrCjIv2xd0raca823
	 Gyu0Xl2JmjLVw==
Message-ID: <sashiko-outbox-204365@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] fuse: virtio-fs: stop new requests before draining
 queues
Reply-To: sashiko-reviews@lists.linux.dev
To: Qihang <q.h.hack.winter@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261109023957.34500-1-q.h.hack.winter@gmail.com>
References: <20261109023957.34500-1-q.h.hack.winter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 03:16:33 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] fuse: virtio-fs: hang in virtio_fs_drain_queue() on stranded
  queued_reqs
--

commit 01cb846c58c4f5ed59cf9d9ee391ec0c2e114c82
Author: Qihang <q.h.hack.winter@gmail.com>

fuse: virtio-fs: stop new requests before draining queues

This commit adds a per-virtqueue aborting flag to reject new requests
(other than FUSE_DESTROY) before draining queues during teardown, and
offloads blocking request end callbacks from the dispatch worker.

> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index ba8d79c4bcac6..a46536c9fdc8e 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
[ ... ]
> @@ -593,9 +633,17 @@ static void virtio_fs_request_dispatch_work(struct w=
ork_struct *work)
>  		if (ret < 0) {
>  			if (ret =3D=3D -ENOSPC) {
>  				spin_lock(&fsvq->lock);
> -				list_add_tail(&req->list, &fsvq->queued_reqs);
> -				spin_unlock(&fsvq->lock);
> -				return;
> +				if (!fsvq->connected ||
> +				    (fsvq->aborting &&
> +				     req->in.h.opcode !=3D FUSE_DESTROY)) {
> +					spin_unlock(&fsvq->lock);
> +					ret =3D -ENOTCONN;
> +				} else {
> +					list_add_tail(&req->list,
> +						      &fsvq->queued_reqs);
> +					spin_unlock(&fsvq->lock);
> +					return;
> +				}
>  			}
[ ... ]
> @@ -1226,6 +1274,28 @@ static void virtio_fs_stop_all_queues(struct virti=
o_fs *fs)
>  	}
>  }
> =20
> +/*
> + * Stop admitting new requests before draining the queues.  Admission and
> + * virtqueue submission are serialized by fsvq->lock, so a request is
> + * either rejected before reaching the device or accounted in in_flight
> + * and covered by the drain.
> + *
> + * FUSE_DESTROY is exempt because fuse_conn_destroy() sends it after the
> + * first drain and waits for its completion before aborting the channel.
> + */
> +static void virtio_fs_stop_new_requests(struct virtio_fs *fs)
> +{
> +	struct virtio_fs_vq *fsvq;
> +	int i;
> +
> +	for (i =3D 0; i < fs->nvqs; i++) {
> +		fsvq =3D &fs->vqs[i];
> +		spin_lock(&fsvq->lock);
> +		fsvq->aborting =3D true;
> +		spin_unlock(&fsvq->lock);
> +	}
> +}
[ ... ]
> @@ -1551,12 +1622,22 @@ static void virtio_fs_send_req(struct fuse_iqueue=
 *fiq, struct fuse_req *req)
>  			/*
>  			 * Virtqueue full. Retry submission from worker
>  			 * context as we might be holding fc->chan->bg_lock.
> +			 * Re-check admission under the same lock that
> +			 * increments in_flight: teardown may have started
> +			 * between enqueue_req() dropping its lock and here.
>  			 */
>  			spin_lock(&fsvq->lock);
> -			list_add_tail(&req->list, &fsvq->queued_reqs);
> -			inc_in_flight_req(fsvq);
> -			spin_unlock(&fsvq->lock);
> -			return;
> +			if (!fsvq->connected ||
> +			    (fsvq->aborting &&
> +			     req->in.h.opcode !=3D FUSE_DESTROY)) {
> +				spin_unlock(&fsvq->lock);
> +				ret =3D -ENOTCONN;
> +			} else {
> +				list_add_tail(&req->list, &fsvq->queued_reqs);
> +				inc_in_flight_req(fsvq);
> +				spin_unlock(&fsvq->lock);
> +				return;
> +			}
>  		}

[Severity: Medium]
Can a request added to fsvq->queued_reqs on -ENOSPC still be stranded with
fsvq->in_flight > 0 and hang virtio_fs_drain_queue()?

virtio_fs_enqueue_req() drops fsvq->lock before returning -ENOSPC, and
neither virtio_fs_send_req() nor virtio_fs_request_dispatch_work()
schedules fsvq->dispatch_work when placing req on fsvq->queued_reqs; they
rely on virtio_fs_requests_done_work() seeing a non-empty queued_reqs when
in-flight virtqueue requests complete.

If the virtqueue drains during the window where fsvq->lock is dropped,
and the caller then re-acquires fsvq->lock before teardown sets
fsvq->aborting, nothing kicks fsvq->dispatch_work:

CPU0                              CPU1 (kworker)
virtio_fs_send_req()
  virtio_fs_enqueue_req()
    spin_lock(&fsvq->lock)
    virtqueue_add_sgs() -> -ENOSPC
    spin_unlock(&fsvq->lock)
                                  virtio_fs_requests_done_work()
                                    spin_lock(&fsvq->lock)
                                    /* drains all vq buffers */
                                    !list_empty(&fsvq->queued_reqs) -> false
                                    spin_unlock(&fsvq->lock)
  spin_lock(&fsvq->lock)
  /* connected && !aborting */
  list_add_tail(..., &fsvq->queued_reqs)
  inc_in_flight_req(fsvq)
  spin_unlock(&fsvq->lock)

When virtio_fs_conn_destroy() then runs virtio_fs_stop_new_requests() and
virtio_fs_drain_all_queues(), fsvq->vq is already empty so
virtio_fs_requests_done_work() never runs again, and virtio_fs_drain_queue()
waits forever in wait_for_completion(&fsvq->in_flight_zero) before
reaching flush_work(&fsvq->dispatch_work).  (The same window exists in
virtio_fs_request_dispatch_work() after it removes req from queued_reqs,
and against virtio_fs_stop_all_queues() in virtio_fs_remove().)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109023957.3450=
0-1-q.h.hack.winter@gmail.com?part=3D1
