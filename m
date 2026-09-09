Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6BB3DCDA3
	for <virtualization@lists.linux.dev>; Wed,  9 Sep 2026 09:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946044; cv=none; b=T0LtsApI8INryGgYhBjbE9OF+sZfrkFIvCDDUQWwOlNvf4pWpo1oTR6MgcflnTOG4Utjb/i0x1Ax3jabEgNfSKPjgfexOWutj/JGSqdfFxlbf3/hkNlotsthN0+qqBOnsmckISoqSGKoFSDUbM0N0v336/DLgwTo/M3gb1/kuf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946044; c=relaxed/simple;
	bh=VK5762bVbRLxsHqLKL70ESwGT42KoBwcRYjhvrugRuw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mvLSaMZ8v5c9QM2vxfYaRxy5LmByqa3exoQLm0GkcHABw6Ao4HfbdNL5xWTEErxi3RRSk+6HAh1EAjAaOr8ZvnwqESGmvYtWoN6FWuc7T4vMj1ssErtOUpT4NJKMTV8rr3pamCGg4iDe6dgH0B/RneqCzC/iGeGm3mnNSwTRgX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hX4iL4RT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hX4iL4RT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904181F00A3E;
	Wed,  9 Sep 2026 09:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788946039;
	bh=1E6fR184sWLu8GTmOhpA3LXRHzFVMW0In0ucU0scTCs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hX4iL4RTQL1hYw1D0p+HXlcupg0KSxa26z6K0U0AgPg82ifgf+h4EnDT5f7qzaSiD
	 9ZY6a4AKYNkDiKaG16ESJA7PQ/gOSnFLcdYgtaQd89cB8nzqjY4pyAXvgrmksZb9GC
	 B4jX8EWpfjZJd0EFHujGCLIBzxkZE/ySwYtH8lYN0WWf2YV9J3WBam+fMVU31yNImy
	 JWlAOHnSl/I9AGSQciFOwge4eoLlh6qzR8AyN2sI+GwyfyxdZ3R3F1El/Rn5XQ1+uy
	 aiuVEgIxxOovZhZWGditRMjLE+QDS/NOeK4oOd6ImfPeLA6kLyJOnXScbXCGaXQpPp
	 l0EilyLyl+SDw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC RESEND 2/3] virtio_net: introduce an RX queue watchdog for
 stuck detection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Longjun Tang" <lange_tang@163.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260908092646.108865-3-lange_tang@163.com>
References: <20260908092646.108865-1-lange_tang@163.com>
 <20260908092646.108865-3-lange_tang@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:27:19 +0000
Message-Id: <20260909092719.904181F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing watchdog state initialization when dynamically increasin=
g receive queues, leading to immediate false stall warnings.
--

commit c9ed39984b2f85816232c0d723aba63e3a109800
Author: Longjun Tang <tanglongjun@kylinos.cn>

virtio_net: introduce an RX queue watchdog for stuck detection

This commit introduces a per-device watchdog to detect stalled RX queues in
virtio-net. The watchdog periodically scans queues and logs a warning if a
queue has a non-zero backlog but makes no progress and receives no interrup=
ts.

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e34c52d059d39..c28de03c177b3 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c

[ ... ]

> @@ -3046,6 +3058,77 @@ static int virtnet_poll(struct napi_struct *napi, =
int budget)
>  	return received;
>  }
> =20
> +/*
> + * This watchdog detects that state: a queue is considered stalled when
> + * it has a non-zero backlog, makes no consumption progress and receives
> + * no new interrupt for rx_watchdog_timeo seconds. On detection it logs
> + * a warning.
> + */
> +static void virtnet_rx_watchdog(struct timer_list *t)
> +{
> +	struct virtnet_info *vi =3D timer_container_of(vi, t, rx_watchdog);
> +	unsigned long timeout =3D rx_watchdog_timeo * HZ;
> +	int i;
> +
> +	if (!rx_watchdog_timeo)
> +		return;
> +
> +	for (i =3D 0; i < vi->curr_queue_pairs; i++) {
> +		struct receive_queue *rq =3D &vi->rq[i];
> +		u16 last_used =3D virtqueue_get_last_used_idx(rq->vq);
> +		u16 calls =3D rq->calls;
> +		bool backlog =3D virtqueue_poll(rq->vq, last_used);
> +
> +		if (!backlog || last_used !=3D rq->watchdog_last_used_idx ||
> +		    calls !=3D rq->watchdog_calls) {
> +			/* No pending data, or the queue made progress, or a
> +			 * new interrupt arrived: restart the window.
> +			 */
> +			rq->watchdog_last_used_idx =3D last_used;
> +			rq->watchdog_calls =3D calls;
> +			rq->watchdog_jiffies =3D jiffies;
> +			continue;
> +		}
> +
> +		if (time_after(jiffies, rq->watchdog_jiffies + timeout)) {

[Severity: Medium]
When receive queues are dynamically increased via ethtool, does this condit=
ion
falsely evaluate to true?

Looking at virtnet_set_queues(), it increases vi->curr_queue_pairs but does=
n't
initialize watchdog_jiffies for the newly added queues:

virtnet_set_queues() {
    ...
    vi->curr_queue_pairs =3D queue_pairs;
    if (dev->flags & IFF_UP) {
        local_bh_disable();
        for (int i =3D 0; i < vi->curr_queue_pairs; ++i)
            virtqueue_napi_schedule(&vi->rq[i].napi, vi->rq[i].vq);
        local_bh_enable();
    }
    ...
}

If the watchdog timer executes right after NAPI fills the new ring and a
packet is immediately received (making backlog true), the watchdog evaluates
the time_after() condition.

Since watchdog_jiffies remains 0 for the new queues, would this immediately
log a false positive "RX queue stalled" warning with a huge stall time?

> +			unsigned int stall_ms =3D
> +				jiffies_to_msecs(jiffies - rq->watchdog_jiffies);
> +
> +			netdev_warn(vi->dev, "RX queue %u stalled for %u ms\n",
> +				    i, stall_ms);
> +
> +			/* Rate-limit to one event per timeout. */
> +			rq->watchdog_jiffies =3D jiffies;
> +		}
> +	}
> +
> +	mod_timer(&vi->rx_watchdog, jiffies + HZ);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908092646.1088=
65-1-lange_tang@163.com?part=3D2
