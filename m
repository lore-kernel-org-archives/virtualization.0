Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794148165;
	b=Gr9tQPJI9nQ2lR7hvkuW9ABi5S318nvcDihs6AY/4qm+JzTEBk6SJ5qglbHu2VQp7ci2
	 Klo9YCODAEqndNyfhbA42oHaW3u6aeVmLO4wzcFA4Eriha/GCK1P1iXFKflBWK9ld8rcs
	 wbyrV8/1RR4+UOsLfsg6KZhPSe2+CRc05kZ7CQHYnFJmqp829Fr0VNyJqnWG1iMU1FPyj
	 0L0k9zQat5lwVtDBHLxCr8LJbPjODfdVdqRRIYOftSg+U9QlZLV8yUIG4BWI8eip6sbnK
	 AEIyHWWGtI3zptGfSArsGxMfm/qC6EFh0xNGVvG/BL8PG8FqH8zOQ3vagzp1akqakwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794148165;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6t7txhfjDz8fNResp9F5ilLL3XickUiTTLKcBRMDy/o=;
	b=Efbkxx2KE25gHNlbmdDyF1f4ZcuVI5m5ibiKP6PmBLkskIc0IMGoH+amk07Xru4hLov0
	 HVgJUhe1TF2mvmDBsoiwipQ5DIB5vK0Eo448gkp5Jgkdl+Jz42tlxEh+o4QXaYu+iNCxs
	 40RqCiCNkFfhtvtUo9eoV70OU1obqDVtOA9CKht55b0NDKK80+82Z3MunYw2yjjId7tri
	 JQkwBGFRIAgACqB+wUDPlQqN2T6UgmSo9WIn3jYK0bBxOsLPHV1yUl9tD3CLHn2tpRqLm
	 JAWUFwLCvrp6VY3B31zxdLseg6QYghvDAGlhcyQ2hMNJUBEEgOMTpVEV0uIn6KQJdDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eJkyPhhc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE5A606A31C
	for <virtualization@lists.linux.dev>; Sun,  8 Nov 2026 14:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eJkyPhhc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316F61F0089F;
	Sun,  8 Nov 2026 14:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794148164;
	bh=6t7txhfjDz8fNResp9F5ilLL3XickUiTTLKcBRMDy/o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eJkyPhhcMkRxDlBaXrEQbXpJKJVE6HqvaajBnul20XAlxt6jjOMojYnAiOxwySIBM
	 zYgmg8Fg+mFhP1olVkTVHhx5a+dx1XZQYBbAIT4FahxsNe/31ZfGKOvoMHBwWRJ6/+
	 edWcvy5+1SwatMRAXtcL9owMvm3SmxkKcxrL+yzqIVkEgtKJpuoJDnsCyGIvp+9N6b
	 lo7d8pgw6kzXiY7+o2sZNo/N1vpT85Z7ECUn4x/eJFD9wiRSkUPRKMfJ45JvHPN0ex
	 5kFo9trRgH8UWcUMdgN40MEGtdKucP+bMY5otrTMsE0iSFJCtzWDhTeDIJsqh0LYDl
	 64VxAqEf1ul2Q==
Message-ID: <sashiko-outbox-203803@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] fuse: virtio-fs: stop new requests before draining
 queues
Reply-To: sashiko-reviews@lists.linux.dev
To: Qihang <q.h.hack.winter@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261108135830.29924-1-q.h.hack.winter@gmail.com>
References: <20261108135830.29924-1-q.h.hack.winter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 14:29:22 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] fuse: virtio-fs: race on -ENOSPC in virtio_fs_send_req()
  bypasses aborting
- [Medium] fuse: virtio-fs: self-deadlock in
  virtio_fs_request_dispatch_work()
- [Low] fuse: virtio-fs: missing Fixes trailer for unmount teardown race
  fix
--

commit 183d70093cd447a74de7ef9f20f4895fc3aef144
Author: Qihang <q.h.hack.winter@gmail.com>

> fuse: virtio-fs: stop new requests before draining queues
>
> virtio_fs_conn_destroy() drains the virtqueues and then calls
> fuse_conn_destroy(), which aborts the connection.  The abort ends every
> request the fuse device still owns, and each ended request is freed as
> soon as its waiter wakes up.
>
> The drain only covers the requests that were already counted in
> fsvq->in_flight when it started.  A request submitted after it returns is
> not covered, but is still handed to the device before the abort runs:
>
>   CPU 0 (umount)                     CPU 1
>   ---------------------------------  --------------------------------
>   virtio_fs_drain_all_queues()
>     /* in_flight drops to 0 and
>        the drain returns */
>                                      virtio_fs_enqueue_req()
>                                        virtqueue_add_sgs()
>                                        inc_in_flight_req() -> 1
>   fuse_conn_destroy()
>     fuse_send_destroy()
>     fuse_chan_abort()
>       /* ends and frees the
>          request above */
>     fuse_chan_wait_aborted()
>                                      /* the device still owns the
>                                         virtqueue descriptors and
>                                         DMA-writes into the freed
>                                         request and its argbuf */
>
> Stop admitting requests on each queue before that queue is drained.
> The flag is set per queue, but that is sufficient: each queue is
> drained after its own flag is set, and request admission,
> virtqueue_add_sgs() and, on the submission path, the in_flight
> increment are serialized by the same fsvq->lock.  A request is
> therefore either rejected before the device can see it, or already
> counted in fsvq->in_flight and covered by the drain.  There is no
> window in between.
>
> Rejected requests use the existing -ENOTCONN error path and are ended by
> virtio_fs_request_dispatch_work() through end_reqs, so no new request
> completion or ownership state is introduced.  Nothing has to be
> discarded in the completion path, and fsvq->in_flight remains the only
> state that has to be tracked.
>
> The new state is not folded into fsvq->connected because the request
> queues have to stay usable: fuse_conn_destroy() sends FUSE_DESTROY
> through them, with args.force set so that fuse_simple_request() waits
> for the reply.  Clearing fsvq->connected would make that request fail
> with -ENOTCONN and the server would never see the destroy.
>
> FUSE_DESTROY is the sole exception while aborting is set.  It is sent
> only after the first drain, and its completion is waited for before
> fuse_chan_abort() can end requests, so the destroy is the only request
> the device sees after the drain.  virtio-fs exposes no userspace
> /dev/fuse fd (and no_control disables the fusectl interface), so
> userspace cannot inject another request.
>
> virtio_fs_start_all_queues() clears the flag, so a mount that follows an
> unmount starts with admission enabled again.
>
> Signed-off-by: Qihang <q.h.hack.winter@gmail.com>

[Severity: Low]
Since this fixes the unmount teardown race present since virtio-fs was
introduced, should it include a Fixes: tag?

  Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")

> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index ba8d79c4bcac6..c6d2120157340 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c

[ ... ]

> @@ -1479,7 +1503,8 @@ static int virtio_fs_enqueue_req(struct virtio_fs_v=
q *fsvq,
> =20
>  	spin_lock(&fsvq->lock);
> =20
> -	if (!fsvq->connected) {
> +	if (!fsvq->connected ||
> +	    (fsvq->aborting && req->in.h.opcode !=3D FUSE_DESTROY)) {
>  		spin_unlock(&fsvq->lock);
>  		ret =3D -ENOTCONN;
>  		goto out;

[Severity: Medium]
Can a request that hits -ENOSPC in virtqueue_add_sgs() bypass fsvq->aborting
and hang unmount?

When virtqueue_add_sgs() returns -ENOSPC, virtio_fs_enqueue_req() drops
fsvq->lock without incrementing fsvq->in_flight or queueing req onto
fsvq->queued_reqs, and virtio_fs_send_req() re-acquires fsvq->lock in a
separate critical section without re-checking fsvq->aborting:

fs/fuse/virtio_fs.c:virtio_fs_send_req() {
    ...
	ret =3D virtio_fs_enqueue_req(fsvq, req, false, GFP_ATOMIC);
	if (ret < 0) {
		if (ret =3D=3D -ENOSPC) {
			spin_lock(&fsvq->lock);
			list_add_tail(&req->list, &fsvq->queued_reqs);
			inc_in_flight_req(fsvq);
			spin_unlock(&fsvq->lock);
			return;
		}
    ...
}

If the remaining in-flight requests complete and the queue is drained in
that unlocked window, req is stranded on fsvq->queued_reqs:

CPU0                              CPU1 (umount)
virtio_fs_send_req()
  virtio_fs_enqueue_req()
    spin_lock(&fsvq->lock)
    /* fsvq->aborting is false */
    virtqueue_add_sgs() -> -ENOSPC
    spin_unlock(&fsvq->lock)
                                  /* in-flight reqs complete;
                                     done_work sees queued_reqs
                                     empty, in_flight =3D=3D 0 */
                                  virtio_fs_stop_new_requests()
                                    fsvq->aborting =3D true
                                  virtio_fs_drain_all_queues()
  spin_lock(&fsvq->lock)
  list_add_tail(&req->list,
                &fsvq->queued_reqs)
  inc_in_flight_req(fsvq) -> 1
  spin_unlock(&fsvq->lock)
                                  fuse_conn_destroy()
                                    fuse_chan_wait_aborted()
                                      <-- hangs waiting for req

Because fuse_chan_abort() does not walk fsvq->queued_reqs and nothing
schedules fsvq->dispatch_work again on that queue, req is never ended,
hanging fuse_chan_wait_aborted() or the second virtio_fs_drain_all_queues().
A similar unlocked window exists in virtio_fs_request_dispatch_work() when
virtio_fs_enqueue_req() returns -ENOSPC and req is re-added to
fsvq->queued_reqs without re-checking fsvq->aborting.

> @@ -1669,6 +1694,9 @@ static void virtio_fs_conn_destroy(struct fuse_moun=
t *fm)
>  	spin_lock(&fsvq->lock);
>  	fsvq->connected =3D false;
>  	spin_unlock(&fsvq->lock);
> +
> +	/* Nothing may be queued after the drain below */
> +	virtio_fs_stop_new_requests(vfs);
>  	virtio_fs_drain_all_queues(vfs);
> =20
>  	fuse_conn_destroy(fm);

[Severity: Medium]
Can setting fsvq->aborting before fuse_chan_abort() clears fch->connected
cause virtio_fs_request_dispatch_work() to deadlock on itself?

When virtio_fs_enqueue_req() rejects an asynchronous FUSE_RELEASE for an
unlinked DAX inode with -ENOTCONN while SB_ACTIVE and fch->connected are
still set, virtio_fs_request_dispatch_work() ends it directly instead of
offloading req->args->may_block requests to a separate worker the way
virtio_fs_requests_done_work() does:

virtio_fs_request_dispatch_work()
  fuse_request_end(req)
    fuse_release_end()
      iput()
        ...
          fuse_evict_inode()
            fuse_vdax_inode_cleanup()
              ...
                fuse_send_removemapping()
                  fuse_simple_request()
                    virtio_fs_send_req()
                      virtio_fs_enqueue_req() -> -ENOTCONN
                      list_add_tail(&req->list, &fsvq->end_reqs)
                      schedule_work(&fsvq->dispatch_work)
                    request_wait_answer()  <-- waits for dispatch_work

Because fuse_simple_request() blocks inside virtio_fs_request_dispatch_work=
()
waiting for fsvq->dispatch_work to process fsvq->end_reqs, the work item can
never run again and unmount deadlocks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108135830.2992=
4-1-q.h.hack.winter@gmail.com?part=3D1
