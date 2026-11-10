Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794303835;
	b=KMkq7/W+lJb7TenZ60z7BGjQ5xwK0XNfUb1XyowaQr7/SqU9TU1mQBeI1JdYKBLq3FIF
	 8UXArSpyOBr15vorIBWksB9Ijbi0I0UmaZr5JpoW/ExQOIWGpC/o7c0ipgkSL79XyhPRd
	 w823X8pKCcmRXrWyzu94PsU8ylDbxzrPmtonIIQMsmafjQ8T1mvavEEPIW93tWFtxHO0l
	 ybc30TaRVJ4DaleSLC/MuaaoRWYRiP/jOU1qRNsag11Cd+lYE4Q2ZOTzV8u56ZXXjuh13
	 0HXuh6QeKHjweg7pg46QwwjEIJcye10fUq4iNQzKHkCOQKhm+YQjHmyt8gZ5aBxA60g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794303835;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gJr6mxpWnjgrlMtZdi3suD6cYGTd+5tw0Dafn+NCukw=;
	b=sqqSSTRhwtIST6Wnu38RK9vpog3S1ZWNJQ4QSw8tq++japZNrF+9jc6F3yrBdljiSE9U
	 Oe1g2SfdAuXZbPfRtzU6qcQCY3zMtk2RZxWo58pJB/wuqKD+i5rcCJBT6+lb8fooMYGCW
	 pYrMluS3FntyiZQo6d0ngYVVspU5tNBR/h+j53Ku9llFu8r3hCMauzl0k0LSuRkS3cfju
	 3lxwRBe4GvM9ihUKmxC+iVrxseVkBcq9bzWCuJTJnP/V+epS+4BvUPE2oB8Ot/TULolpF
	 4cW1Tc/6rsEGCKsH8Y8f7X/VZd7QDJO3cTiPEa8f8gkxAYYaNOtmqY4woHLz+MDszAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O5XWRPGd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3342606BF07
	for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 09:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O5XWRPGd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151CA1F008A1;
	Tue, 10 Nov 2026 09:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794303834;
	bh=gJr6mxpWnjgrlMtZdi3suD6cYGTd+5tw0Dafn+NCukw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O5XWRPGdIRnN6sQDMAevMpnSW/XEvKUhvqv0gyNasBRSoaZjP8xR6XlU4VdBq27L9
	 XHCM2MJ8WdExEwcmXU+Zekc4ayFvATjaXSCnPy1DxhAgMq4CLoHRxikRBnYA0V7e2J
	 raw5IuDkBT4O/QTBN+GqRwHAXvdLePu8gealU85HZD5Iq0EyshBnkKrCtvVcZ0Zvyp
	 szrPD8IsmR1KgCHF7mRYt9egXJwzRzrqrPxAUOaeMa+v6Xy7Y9QVNN7m0ue7ILfvDA
	 FJMdyvaozr+ITJbyt6duUt+qAfKFKwYV1/OwekMGISJgygytGAk8dB1yu6u+lgiThB
	 leJzUxwM0DrQw==
Message-ID: <sashiko-outbox-206798@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] virtio_net: introduce an RX queue watchdog for
 stuck detection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Longjun Tang" <lange_tang@163.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261109094310.103979-3-lange_tang@163.com>
References: <20261109094310.103979-1-lange_tang@163.com>
 <20261109094310.103979-3-lange_tang@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:43:53 +0000
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
- [Medium] virtio_net: virtnet_rx_watchdog() races with
  virtqueue_resize() and reset
- [Low] virtio_net: broken runtime re-enable and overflow of
  rx_watchdog_timeo
- [Low] virtio_net: virtnet_rx_watchdog() counts idle time toward stall
  timeout
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Medium] virtio_net: memory leak in virtnet_probe() [1]
--

commit 8f4864b7d541d6a73ad04b5a7ad25842595fc1aa
Author: Longjun Tang <tanglongjun@kylinos.cn>

virtio_net: introduce an RX queue watchdog for stuck detection

This commit adds a per-device periodic timer that checks active RX queues
for unconsumed used buffers without progress or new interrupts for
rx_watchdog_timeo seconds, and reschedules NAPI when a stall is detected.

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index dd2c41ef6fbe7..ec7c248080c57 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -36,6 +36,10 @@ module_param(csum, bool, 0444);
>  module_param(gso, bool, 0444);
>  module_param(napi_tx, bool, 0644);
> =20
> +/* RX queue stall timeout in seconds; 0 disables the watchdog. */
> +static unsigned int rx_watchdog_timeo =3D 5;
> +module_param(rx_watchdog_timeo, uint, 0644);

[ ... ]

> @@ -3067,6 +3084,80 @@ static int virtnet_poll(struct napi_struct *napi, =
int budget)
>  	return received;
>  }
> =20
> +/*
> + * An RX queue is stalled if it has a backlog but makes no progress and
> + * gets no new interrupt for rx_watchdog_timeo seconds, usually because
> + * an interrupt was lost.  Mark it stalled and reschedule NAPI to drain
> + * the ring, refill the buffers.
> + */
> +static void virtnet_rx_watchdog(struct timer_list *t)
> +{
> +	struct virtnet_info *vi =3D timer_container_of(vi, t, rx_watchdog);
> +	unsigned long timeout =3D rx_watchdog_timeo * HZ;
> +	int i;
> +
> +	if (!rx_watchdog_timeo)
> +		return;

[Severity: Low]
If rx_watchdog_timeo is set to 0 at boot or via sysfs (0644) and later
written back to a non-zero value while the interface is up, how does
vi->rx_watchdog get started again?  Both virtnet_rx_watchdog_start() and
virtnet_rx_watchdog() return without arming the timer when
rx_watchdog_timeo is 0, and there is no module parameter callback to
restart it on open devices.

Also, virtnet_rx_watchdog() reads rx_watchdog_timeo twice without
READ_ONCE() and multiplies rx_watchdog_timeo * HZ in 32-bit unsigned int
arithmetic before widening to unsigned long.  A concurrent update from 0
to non-zero can compute timeout =3D 0 while passing the zero check, and a
large value can wrap 32-bit multiplication, causing immediate false stall
warnings.

> +
> +	for (i =3D 0; i < vi->curr_queue_pairs; i++) {
> +		struct receive_queue *rq =3D &vi->rq[i];
> +		u16 last_used =3D virtqueue_get_last_used_idx(rq->vq);
> +		u16 calls =3D rq->calls;
> +		bool backlog =3D virtqueue_poll(rq->vq, last_used);

[Severity: Medium]
Can virtnet_rx_watchdog() race with virtnet_rx_resize() or
virtnet_rq_bind_xsk_pool() while the interface is up?

virtnet_rx_pause() disables NAPI and DIM before resizing or resetting
rq->vq, but it does not stop vi->rx_watchdog.  virtqueue_resize_split()
and virtqueue_resize_packed() free the old vring before attaching the new
one, and virtqueue_poll() only checks vq->broken:

CPU0                                  CPU1 (<softirq>)
virtnet_set_ringparam()
  virtnet_rx_resize()
    virtnet_rx_pause(vi, rq)
    virtqueue_resize(rq->vq, ...)
      vring_free(&vq->vq)
                                      virtnet_rx_watchdog()
                                        virtqueue_poll(rq->vq, last_used)
                                          <-- use-after-free of vring
      virtqueue_init(...)
      virtqueue_vring_attach_*(...)

On packed virtqueues, if virtnet_rx_resize() shrinks the ring after
virtnet_rx_watchdog() reads last_used, is_used_desc_packed() can also
index vq->packed.vring.desc[used_idx] out of bounds.  In addition,
virtqueue_resize() and virtqueue_reset() reset vq->last_used_idx to 0,
but virtnet_rx_resume() does not call virtnet_rx_watchdog_init_queue(rq),
leaving stale state in rq->watchdog.

> +		bool progress =3D last_used !=3D rq->watchdog.last_used;
> +
> +		if (!backlog || progress || calls !=3D rq->watchdog.calls) {
> +			rq->watchdog.last_used =3D last_used;
> +			rq->watchdog.calls =3D calls;
> +			rq->watchdog.jiffies =3D jiffies;
> +			continue;
> +		}
> +
> +		if (time_after(jiffies, rq->watchdog.jiffies + timeout)) {

[Severity: Low]
Does the first timer tick that sees backlog =3D=3D true count the preceding
idle second toward timeout?

When a queue is idle (!backlog), rq->watchdog.jiffies is updated to the
idle tick's jiffies and the timer is re-armed for jiffies + HZ.  If a
packet arrives just before the next tick and has not been consumed yet,
backlog is true, progress is false, and calls =3D=3D rq->watchdog.calls, so
virtnet_rx_watchdog() immediately compares jiffies against the timestamp
from the previous idle tick.  When rx_watchdog_timeo is 1 (or the timer
softirq is delayed), time_after(jiffies, rq->watchdog.jiffies + timeout)
can trigger on the very first observation of a backlog and report an
inflated stall_ms.

Furthermore, sampling last_used and calls before virtqueue_poll() means
that if an interrupt arrives and NAPI drains the packet between reading
last_used/calls and calling virtqueue_poll(rq->vq, last_used),
virtqueue_poll() compares the new used index against the stale last_used
and sees a false backlog with no apparent progress.

[ ... ]

> @@ -6900,6 +7003,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
>  	INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
>  	disable_work(&vi->rx_mode_work);
> +	timer_setup(&vi->rx_watchdog, virtnet_rx_watchdog, 0);

[Severity: Medium]
This problem wasn't introduced by this patch, but can a failed
virtnet_cpu_notif_add() in virtnet_probe() leak queued RX buffers and DMA
mappings if the device was opened concurrently [1]?

Once virtnet_probe() drops rtnl_unlock(), userspace can open the device
and populate the receive queues via virtnet_open() -> try_fill_recv():

CPU0                                  CPU1
virtnet_probe()
  register_netdevice(dev)
  rtnl_unlock()
                                      virtnet_open()
                                        try_fill_recv()
  virtnet_cpu_notif_add(vi) -> fails
  unregister_netdev(dev)
  ...
  virtio_reset_device(vdev)
  virtnet_del_vqs(vi)  <-- leaks unused buffers

Unlike remove_vq_common(), the free_unregister_netdev error path resets
the device and deletes the virtqueues without calling free_unused_bufs().

[1] https://sashiko.dev/#/bug/linux-701d943e-275e-4959-aa9f-bafbe242f070

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109094310.1039=
79-1-lange_tang@163.com?part=3D2
