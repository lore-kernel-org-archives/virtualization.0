Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794303835;
	b=ry8477IcBgYna5AB+t1FDtGjt3BoCpVSh9itGlsfMhCrkiqtdMLrmfj2J7avp6LG5uU3
	 UNaoMgVy7C+w/idv0h2XwGzmYvfVo2lpY5X2n9nBNTTBIDJsm2IpIBuHRefYx/eM0OtqM
	 DCahh/dT/WeVCf68Kb6mFPF5MGV8oZ7r3QReAUgLycFmWeYynDKj+cQ3sQ7xXqsgNQGJF
	 BHzBO9KoMxxwRFItunKAuEfvb8FaYiedkAmy6lvMKQOYdu/eqQqnfVUmsaL2AHLYQwr8g
	 XWSBdRBAZhYSlbmdb7fe0OX6tMbNp0MwCEugMXUVbVIMdmIetmRuuSUHGreenj5i7jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794303835;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=auJk7Aoyx/zAAhdUA/PRMYr7VWRte89D5FD9GIGZ0eY=;
	b=YQ8xpS5RZLV/bYe1AC+jb1mqJ3h8UvosNGOxp2akVG82m4SSomJhTtizAw3cP8+6tO4E
	 GK5N/IC9z1YOdyu+j4ZgyU/n6RHSNYQC7VL22HA3zAbRxx/e0v+wXBj1kBRaFnVqWopq6
	 u7riF2AsgFoWOgXPmYSU7UaPq7tdkcTHhNR5dG0tOtUvgzvCxX7e+lHM8DHpEPArE661O
	 4Rc45bNvsWviKiiQuieB8DkPcrN+HEJkzxwGY8qZURidJAXFldZueCIdUROYDhmlecvQ0
	 /jZbOQBT55A5pffTu6iMMrPAENKQ6L4N/S5vnUMOBnrfsDaXm3Wk3787qe+J7CxFJhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OJkpq+cB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A34606BF0A
	for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 09:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OJkpq+cB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB211F0089F;
	Tue, 10 Nov 2026 09:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794303835;
	bh=auJk7Aoyx/zAAhdUA/PRMYr7VWRte89D5FD9GIGZ0eY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OJkpq+cBCXvEGBRxkEAg0hqJ4trx8SeRGbjXGSB5cO20Xb7dKuWCEtz79ZtrLUMIx
	 iNwT/U9NpPufkIMjYtgg348QTulHWqY9rJEaTCwyhkGHXUIX0GRyGRFrGY0nCyec2n
	 EsVvSTVmXUo/FWJEFzzzwkcdD+fynhJxpyjW6sd92Qf9sOpj3DEd37sPKm+Shp5sQI
	 Sta4b6ZeqnpSaZ5lPmN4zy7p3e3CGFORLDIrWjqFZ7Q597YHbdjXqxvwgwnH13Mjbx
	 TrLdiRNNURb5d5njDRkHWsEKP+xFzy5/aLgtIfMSmLu6VQOVUnF+zIiCGPKzdm8DBZ
	 Yz0/qtEXtvA6g==
Message-ID: <sashiko-outbox-206799@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] virtio_net: add rx_timeouts per-queue statistic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Longjun Tang" <lange_tang@163.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261109094310.103979-4-lange_tang@163.com>
References: <20261109094310.103979-1-lange_tang@163.com>
 <20261109094310.103979-4-lange_tang@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:43:54 +0000
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
- [Medium] virtio_net: data race and lost rx_timeouts events via
  rq->watchdog.stalled
- [Medium] virtio_net: race between virtnet_rx_watchdog() and RX queue
  pause/reset
--

commit 4a62fe0fe638e28583b6ebe514a0626f687513ee
Author: Longjun Tang <tanglongjun@kylinos.cn>

virtio_net: add rx_timeouts per-queue statistic

This commit adds an rx_timeouts per-queue RX statistic exposed via ethtool
that is incremented in virtnet_receive() when rq->watchdog.stalled is set.

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index ec7c248080c57..feb6bfbb1c5a8 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c

[ ... ]

> @@ -2983,6 +2985,12 @@ static int virtnet_receive(struct receive_queue *r=
q, int budget,
>  		u64_stats_add(item, u64_stats_read(src));
>  	}
> =20
> +	/* Count a stall recovered by this poll. */
> +	if (rq->watchdog.stalled) {
> +		u64_stats_inc(&rq->stats.rx_timeouts);
> +		rq->watchdog.stalled =3D false;
> +	}
> +
>  	u64_stats_add(&rq->stats.packets, u64_stats_read(&stats.packets));
>  	u64_stats_add(&rq->stats.bytes, u64_stats_read(&stats.bytes));
>  	u64_stats_add(&rq->stats.alloc_fail, u64_stats_read(&stats.alloc_fail));

[Severity: Medium]
Does passing timeout events through the plain boolean rq->watchdog.stalled
race with virtnet_rx_watchdog() and lose rx_timeouts increments?

CPU0 (timer softirq)              CPU1 (NAPI poll)
virtnet_rx_watchdog()             virtnet_receive()
                                    if (rq->watchdog.stalled)
                                      u64_stats_inc(&rq->stats.rx_timeouts)
  rq->watchdog.stalled =3D true;
                                      rq->watchdog.stalled =3D false;
                                        <-- data race / lost timeout

Because virtnet_rx_watchdog() writes rq->watchdog.stalled =3D true on each
timeout and virtnet_receive() reads and clears it without atomic operations,
concurrent execution triggers a KCSAN data race and can clobber a newly
detected stall.  Counting in virtnet_receive() also leaves rx_timeouts at 0
while NAPI remains wedged, collapses multiple watchdog expirations before a
poll into a single increment, loses the count if the device is reopened via
virtnet_rx_watchdog_init_queue() before NAPI runs, and clears stalled even
when virtnet_poll() is called with budget =3D=3D 0 (such as via netpoll) wi=
thout
draining packets.

[Severity: Medium]
Can virtnet_rx_watchdog() also race with RX queue pause, resize, and reset?

CPU0                              CPU1 (timer softirq)
virtnet_rx_resize()               virtnet_rx_watchdog()
  virtnet_rx_pause(vi, rq)
  virtqueue_resize(rq->vq, ...)
    virtqueue_resize_split()
      vring_free(&vq->vq)
                                    virtqueue_poll(rq->vq, last_used)
                                      <-- use-after-free / OOB read
      virtqueue_vring_attach_split()

commit "virtio_net: introduce an RX queue watchdog for stuck detection"
starts vi->rx_watchdog in virtnet_open() and only stops it in
virtnet_close(), while virtnet_rx_pause() only disables rq->napi and cancels
rq->dim:

drivers/net/virtio_net.c:virtnet_rx_pause() {
	bool running =3D netif_running(vi->dev);

	if (running) {
		virtnet_napi_disable(rq);
		virtnet_cancel_dim(vi, &rq->dim);
	}
}

When virtnet_rx_resize() or virtnet_rq_bind_xsk_pool() pauses a queue to
resize or reset rq->vq, virtnet_rx_watchdog() continues polling rq->vq every
second and can read freed vring memory or index past a newly shrunk packed
descriptor ring, or call virtqueue_napi_schedule() while rq->vq is being
reset.  Because neither path reinitializes rq->watchdog after resetting
vq->last_used_idx, any rq->watchdog.stalled state left from before the
reset is also consumed by virtnet_receive() on resume and falsely increments
rq->stats.rx_timeouts.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109094310.1039=
79-1-lange_tang@163.com?part=3D3
