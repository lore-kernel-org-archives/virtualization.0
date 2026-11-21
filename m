Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795245539;
	b=uCvFmAyyIfgwy46xqYagk7rafW9DnOuTtMic/uu09PEmQI8sjtIKA80nBa6ZDtPTU+lp
	 rvSy3p64004B+qiLjR5gx/XBWY41xo1jIL7bCUF79ohT8l3nKpHHxkY7tbEpcbRgKJ/QU
	 16kaz8zngKpXoYZ5OwzuDkgNHZM4GxO3Lykaaai7XwwKaxbSRnF+iQ7gv5stHY2/eznn0
	 qin9Txbe2Cdwuk4u2j8YOJTFezqpXmOOL3qq77XwIcLkuhRge+UNHfEi6T25NtV51rAYz
	 FqACp/6kKLPxRvJHxHNiHWeddLe8t9yoV+mh+a0EcTJcqUK/LCYEz7ND3Trtxe3xvsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795245539;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6sQ0kY1t1mQbU5qRN33P/LcMNiM6EaGS4rajwo9cxJw=;
	b=IkU/xBb+nbQyjgAAoJyygOrF+1lowWDEPfT2oDV844Djk7+ZgM9Vq1oUUeTffEsCAzfk
	 RrCYfNTEJap3YJwWsPDp9rQob5NTZWKlS/hmEp39+6WDk3mtfGZFWiJ3yOsRfFmqdrRcO
	 3/vn3G07AIIDHnbInyG4Nd6t/P3NRkIoWXhs3tkUKfehRyhVIyWjD0fQ2DovJGxJElZwi
	 B/1VyyHSlBqFGIVDIKvkNqngXqt0JBvq07S/P0MZx9tZbjBtQKVwX9c+GLf9D3C3eiWvU
	 aeK6g5mGmZK3X08atJDh2ZI9twpYnN2bMfFwjTRLmJRVUmaCsOHGYzNbgH9VDSJ4n5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jg8mXBBP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F47606A334
	for <virtualization@lists.linux.dev>; Sat, 21 Nov 2026 07:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jg8mXBBP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE151F000C4;
	Sat, 21 Nov 2026 07:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795245539;
	bh=6sQ0kY1t1mQbU5qRN33P/LcMNiM6EaGS4rajwo9cxJw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jg8mXBBPhlxtaptxTmNwkZg/0poW1pqOeyNLoYE0uVo+w3bgG3gYnVxaelmXaCZ/7
	 0+WCxXcp6bJCLTzbVaroIdXAUD1HIRQNcMwHvbY7mFdjA0N2hviOzpHAx7/X1LdO2M
	 90ZA7OBDUfiBbyPQmSvUQRETLnZsWz6RA8+dSP4rn34BV+w8FxWGtkhr8JbChiQPHJ
	 jqRcTMcttR8SEQU11fAeL/ZDa4SdFnkQN7XRmKCo3Oru5whLTDX0Zj73z2DhDoKdL/
	 79vzIHwGaYQ52QK3jzjxJ9XB2bCD8TvU5ZXX3pdngsYDlQbH8yoe2vk8+bh//IwHOv
	 DaQp9pKPzOBXg==
Message-ID: <sashiko-outbox-226758@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] virtio_net: add stalls per-queue statistic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Longjun Tang" <lange_tang@163.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261120071826.198604-4-lange_tang@163.com>
References: <20261120071826.198604-1-lange_tang@163.com>
 <20261120071826.198604-4-lange_tang@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 07:18:59 +0000
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
- [Medium] virtio_net: race between virtnet_rx_watchdog() and RX queue
  pause/reset
--

commit fd9c9353e0dbe0759e73fd91a8963232b76ecc1c
Author: Longjun Tang <tanglongjun@kylinos.cn>

virtio_net: add stalls per-queue statistic

This commit adds a per-queue RX stalls statistic to virtio_net and exposes
it via ethtool when NAPI poll recovers a stalled RX queue.

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7f21fe4f96a2b..0b95fa10734d2 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c

[ ... ]

> @@ -3005,6 +3007,12 @@ static int virtnet_receive(struct receive_queue *r=
q, int budget,
>  		u64_stats_add(item, u64_stats_read(src));
>  	}
> =20
> +	/* Count a stall recovered by this poll. */
> +	if (rq->watchdog.stalled) {
> +		u64_stats_inc(&rq->stats.stalls);
> +		rq->watchdog.stalled =3D false;
> +	}

[Severity: Medium]
Can virtnet_rx_watchdog() race with an RX queue resize or reset while the
interface is up, causing a use-after-free on the vring and false
rq->stats.stalls increments?

Commit "virtio_net: introduce an RX queue watchdog for stuck detection"
starts vi->rx_watchdog in virtnet_open() and only stops it in
virtnet_close().  When virtnet_rx_resize() or virtnet_rq_bind_xsk_pool()
pauses an active RX queue via virtnet_rx_pause(), it disables NAPI and DIM
but does not stop or synchronize with vi->rx_watchdog:

CPU0                                  CPU1 (<softirq>)
virtnet_rx_resize()
  virtnet_rx_pause(vi, rq)
  virtqueue_resize(rq->vq, ...)
                                      virtnet_rx_watchdog()
                                        last_used =3D
                                          virtqueue_get_last_used_idx(...)
    vring_free(&vq->vq)
                                        virtqueue_poll(rq->vq, last_used)
                                          <-- use-after-free

In addition, virtqueue_resize() and virtqueue_reset() reset
vq->last_used_idx, but neither path calls
virtnet_rx_watchdog_init_queue(rq).  Any stale rq->watchdog.last_used or
rq->watchdog.stalled state persists across the reset and causes
virtnet_receive() to falsely increment rq->stats.stalls after the queue is
resumed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120071826.1986=
04-1-lange_tang@163.com?part=3D3
