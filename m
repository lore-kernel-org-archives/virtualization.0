Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795245539;
	b=IqgOVgfDbgVylQfJv7j67noJIXvGAQpaOiRbgUxPMRhWgXSlPcsUfkRfCaP8ncel4bdn
	 hIlbaUDTZci+VYPG8S7Ft7lIwPfItXw+NR2oyFDiXiOBY/HadmeLEs/kob/DuvieqAgj2
	 MuomAZHQuIDSMTOEhxlg77/lW3om5+Jtmf1xw9GiYWBVqWpXkKwD3lbi7KF0GjNklb5rT
	 XwI/o0UZnmW3ixI/LQ3WRDJXj8qxuHYRpWNLl4I8CXiZ2nKKlLhFXqxLsuEiua1UNWX3h
	 XXR/VTIMczjB74z1nBDD4xMlhXS0GZFIreNY0Ah4ug/0BsxpOUtbc1pX1jTVHMcIgMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795245539;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=d1l8MgpvV28ZMQXb6/mPW4wmJmUAXTmhJW0ynm2/x1g=;
	b=bCelr/IDM6ilDAOjrXU8H7dPwR7SzkNcsXps9pH8ntaRLpBVIPxrqwbj+O7awE52/0BN
	 Qt+tSw4kdJTz4yJLk9fd/WrAL6DX7ASHiMP8ro2wtKfiKv+qBJFmYeP/doRVZh7XBt7Se
	 hY32sEuqg2PMZ8znPNT9gldPgvFp46hugxnViPCRT/DmJtp9S2HsdpMSCymENzaRSBKKB
	 UglTFrfQ+Zxuy5bvOEjBXn0nfMcwYlFVFW+NIBkDbSlYz/rJDHzKag3GqclNBVxq32zuf
	 x5vtOCziD0t+SOVWL19WGYU1K4Zf3sKAr77vz/drZBxzkVR83UXgBSFFWSJUSgjrx4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c7BU5lgO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B444606A331
	for <virtualization@lists.linux.dev>; Sat, 21 Nov 2026 07:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c7BU5lgO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24E11F000C0;
	Sat, 21 Nov 2026 07:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795245538;
	bh=d1l8MgpvV28ZMQXb6/mPW4wmJmUAXTmhJW0ynm2/x1g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c7BU5lgOiB5NOqrD23cEmfgZhwqc2oS0WUEP4lDRkaPXIgwcbUlBPLF29ZS4d1beB
	 5d3CWt9BK7inYtEmeHdHvNBrwU62CB4kjls0LGlFm9eYkgtLVKnbqPKWkh1fnCN/Te
	 rlNTURl8hywz4Vg70qTTqBmP9UH4YoXcPo05AdIWLshcESQXxoSlCUQsFJqpzc1d2E
	 2ly4FF3BudcwLijx5TM1D0dmb4xJCqGl88Fxv8tzswYoy1B12eVX1eogUf944H/F/5
	 y3rs5BtHxo3lnP6H6fPmoJGKrJTeDry2OhZz90q8W27BTKu47k9nylRj0IAlKZdbvq
	 cuWjYn4T85org==
Message-ID: <sashiko-outbox-226757@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] virtio_net: introduce an RX queue watchdog for
 stuck detection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Longjun Tang" <lange_tang@163.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261120071826.198604-3-lange_tang@163.com>
References: <20261120071826.198604-1-lange_tang@163.com>
 <20261120071826.198604-3-lange_tang@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 07:18:58 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] virtio_net: virtnet_rx_watchdog() races with
  virtqueue_resize() and reset
- [Low] virtio_net: unsynchronized watchdog init in virtnet_set_queues()
--

commit 093ca3617532e988a9fe20901b18a2e6a86aca17
Author: Longjun Tang <tanglongjun@kylinos.cn>

virtio_net: introduce an RX queue watchdog for stuck detection

This commit adds a per-device 1 Hz watchdog timer that checks active RX
queues for 5-second consumption stalls and reschedules NAPI when a queue
is stuck with a non-zero backlog.

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1cd64f9e12e74..7f21fe4f96a2b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c

[ ... ]

> @@ -3090,6 +3106,74 @@ static int virtnet_poll(struct napi_struct *napi, =
int budget)
>  	return received;
>  }
> =20
> +/*
> + * An RX queue is stalled if it has a backlog but makes no progress and
> + * gets no new interrupt for VIRTNET_RX_WATCHDOG_TIMEO seconds, usually
> + * because an interrupt was lost.  Mark it stalled and reschedule NAPI to
> + * drain the ring and refill the buffers.
> + */
> +static void virtnet_rx_watchdog(struct timer_list *t)
> +{
> +	struct virtnet_info *vi =3D timer_container_of(vi, t, rx_watchdog);
> +	unsigned long timeout =3D VIRTNET_RX_WATCHDOG_TIMEO * HZ;
> +	int i;
> +
> +	for (i =3D 0; i < vi->curr_queue_pairs; i++) {
> +		struct receive_queue *rq =3D &vi->rq[i];
> +		u16 last_used =3D virtqueue_get_last_used_idx(rq->vq);
> +		u16 calls =3D rq->calls;
> +		bool backlog =3D virtqueue_poll(rq->vq, last_used);

[Severity: Medium]
Can virtnet_rx_watchdog() race with virtqueue_resize() or
virtqueue_reset() and read freed vring memory?

When an RX ring is resized via virtnet_rx_resize() (or reset for AF_XDP in
virtnet_rq_bind_xsk_pool()) while the interface is up, virtnet_rx_pause()
disables NAPI and cancels DIM, but vi->rx_watchdog keeps firing:

drivers/net/virtio_net.c:virtnet_rx_pause() {
	bool running =3D netif_running(vi->dev);

	if (running) {
		virtnet_napi_disable(rq);
		virtnet_cancel_dim(vi, &rq->dim);
	}
}

Inside virtqueue_resize_split() and virtqueue_resize_packed(),
vring_free() frees the old vring before virtqueue_vring_attach_split() or
virtqueue_vring_attach_packed() installs the new ring pointers:

CPU0                                  CPU1 (<softirq>)
virtnet_rx_resize()
  virtnet_rx_pause(vi, rq)
  virtqueue_resize(rq->vq, ...)
    vring_free(&vq->vq)
                                      virtnet_rx_watchdog()
                                        last_used =3D
                                          virtqueue_get_last_used_idx(...)
                                        virtqueue_poll(rq->vq, last_used)
                                          <-- use-after-free
    virtqueue_init(vq, ...)
    virtqueue_vring_attach_split(...)

On packed virtqueues, if virtnet_rx_resize() shrinks the ring and
virtnet_rx_watchdog() reads last_used from the old ring right before
virtqueue_init() resets vq->last_used_idx and attaches the smaller
descriptor array, virtqueue_poll_packed() also indexes
vq->packed.vring.desc[used_idx] out of bounds.

In addition, both virtqueue_resize() and virtqueue_reset() reset
vq->last_used_idx in virtqueue_init(), but virtnet_rx_resume() does not
call virtnet_rx_watchdog_init_queue(rq) to resynchronize rq->watchdog.

[ ... ]

> @@ -3839,7 +3926,14 @@ static int virtnet_set_queues(struct virtnet_info =
*vi, u16 queue_pairs)
>  	if (vi->has_rss)
>  		vi->rss_trailer.max_tx_vq =3D cpu_to_le16(queue_pairs);
>  succ:
> +	if (dev->flags & IFF_UP) {
> +		/* Init new queues */
> +		for (int i =3D old_queue_pairs; i < queue_pairs; i++)
> +			virtnet_rx_watchdog_init_queue(&vi->rq[i]);
> +	}
> +
>  	vi->curr_queue_pairs =3D queue_pairs;

[Severity: Low]
Can virtnet_rx_watchdog() observe the updated vi->curr_queue_pairs before
the rq->watchdog fields initialized by virtnet_rx_watchdog_init_queue()?

virtnet_set_queues() runs while vi->rx_watchdog is active and uses plain
stores to initialize rq->watchdog and update vi->curr_queue_pairs.  By the
time execution reaches the succ label, the CVQ command has already allowed
the device to steer RX packets to the new queues:

CPU0                                  CPU1 (<softirq>)
virtnet_set_queues()
  virtnet_rx_watchdog_init_queue(rq)
    rq->watchdog.last_used =3D ...
    rq->watchdog.calls =3D ...
  vi->curr_queue_pairs =3D queue_pairs
                                      virtnet_rx_watchdog()
                                        i < vi->curr_queue_pairs
                                        time_after(jiffies,
                                          rq->watchdog.jiffies + timeout)
                                          <-- stale jiffies, false stall
    rq->watchdog.jiffies =3D jiffies

If a newly activated queue already has a buffer in its used ring and
virtnet_rx_watchdog() reads a stale rq->watchdog.jiffies (0 from initial
allocation or an old timestamp from before the queue count was lowered),
it logs a false RX stall warning and marks rq->watchdog.stalled.  If
vi->curr_queue_pairs is lowered and raised again while
virtnet_rx_watchdog() is mid-loop, both functions can also read and write
rq->watchdog concurrently.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120071826.1986=
04-1-lange_tang@163.com?part=3D2
