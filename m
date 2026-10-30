Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793329779;
	b=hL0tCx1i7DLmI6WEW6kpiuNc16j5FRKMOu+FNqpGGjwJMRX83+dzyrDHXcVhCjmAzBnK
	 rkmYLgkQ3GO747O+masGe7nJOYHCPBobSiXGJdyDY+RJqE9RFc//FZsyaW6tGFCK4y7yh
	 FVFUqiJtM4r7Aao6QqWYbdiPcO0pENgQoQLWNJZXtxheN5ZFjarQmhndqj+CiSsJBhf1e
	 vyMF0iWByOr9KnhgSXPnwITQP5PxM9K5SqUWc7m6mzwVw35jCLSLMPhyJFUbNgnuiV87y
	 9wr83qRt06601MiZUzt7o+PAFROcWj+ss9ZLlbpj0zWT8Ihh2m4oZoeeWJdD8Kbrorw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793329779;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gdMAh91itrtXTvGYKOgm16uNRE3AoWN3UlNNO6KHysc=;
	b=wyBc/FxM/EfTCJoxLtyQIJB/IdKTF9/CatLPGnuFB8OTTN3djNH6S+mV8wij2zCCVMCB
	 SZ7AcFaOmtRkQynmJoJOU07IN8z0p5rZqRxivw0Egx6U6SNnyHfqIp9LpSbOvCJZpLFQA
	 OWyee798giHt8UyzeOgiirfOo2mPM5i7mw0c9DhDbUhnt/8EvuF6dEnd1kMIFS5sopiwB
	 1SwQsU2u6vlyLK1EfM2wCNX34/Fw9gRDjuJGJLHReJxAndqNNq8Wpkq4e1wDOHktG7JDH
	 V/b76I4ePFeE35M6sy5quF+bZn4EEzMh5grfwbR4iBAWu2F8AV76JvJCD0xC+RpuKag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JDEZh9oh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AA6606A31F
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 03:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JDEZh9oh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27081F000C1;
	Fri, 30 Oct 2026 03:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793329778;
	bh=gdMAh91itrtXTvGYKOgm16uNRE3AoWN3UlNNO6KHysc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JDEZh9ohBcqhJayn+oWp5BOuwfmfTfgtOYmN0Vlc7kRIUThP3Ghg5+CI91jaqHiJx
	 Tl6XXIluZzRLosglfmUpfIIgcfEyetPCscMsSnPqWJwQBFR9gSp/b41Mt9jswFgqAv
	 xFJOfZsNAVkIFpekn0uRyY/8820kEGEJPXU1NH61+JlT87YqaFTBt4DtR2E739zXWY
	 sL+z7FCEOeyts2yVyiVsbSV5+9VC5AK4kCHRAApJyLjxywR0TEgQpEZwUgIX+50N3b
	 juBMlwhv6n4Zp7KAar+64NaNNkSYclu7KYIbWOg2mPrYdhHHj3JOB/BmT3sKtahIDq
	 vMDzzSpg9NnFQ==
Message-ID: <sashiko-outbox-190212@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] virtio_balloon: add tracepoints for free page
 hinting and migration
Reply-To: sashiko-reviews@lists.linux.dev
To: liuqiangneo@163.com
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261030025834.19160-4-liuqiangneo@163.com>
References: <20261030025834.19160-1-liuqiangneo@163.com>
 <20261030025834.19160-4-liuqiangneo@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 03:09:37 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] virtio_balloon: inaccurate hint tracepoint in virtio_balloon_rep=
ort_free_page()
- [Low] virtio_balloon: unguarded virtio_balloon_migrate tracepoint definit=
ion
--

commit 366e84eaf1398af638dddd244580ba2505eef10a
Author: Qiang Liu <liuqiang@kylinos.cn>

virtio_balloon: add tracepoints for free page hinting and migration

This commit adds trace_virtio_balloon_free_page_hint and
trace_virtio_balloon_migrate tracepoints to record free page hinting rounds
and balloon page migration attempts.

> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ball=
oon.c
> index c4fdc6815b41b..faf78c639f3c1 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -803,6 +803,7 @@ static void virtio_balloon_report_free_page(struct vi=
rtio_balloon *vb)
>  {
>  	int err;
>  	struct device *dev =3D &vb->vdev->dev;
> +	unsigned int cmd_id =3D virtio_balloon_cmd_id_received(vb);
> =20
>  	/* Start by sending the received cmd id to host with an outbuf. */
>  	err =3D send_cmd_id_start(vb);
> @@ -817,6 +818,9 @@ static void virtio_balloon_report_free_page(struct vi=
rtio_balloon *vb)
>  	err =3D send_cmd_id_stop(vb);
>  	if (unlikely(err))
>  		dev_err(dev, "Failed to send a stop id, err =3D %d\n", err);
> +
> +	trace_virtio_balloon_free_page_hint(cmd_id,
> +					    READ_ONCE(vb->num_free_page_blocks));
>  }

[Severity: Medium]
Can reading cmd_id via a separate virtio_balloon_cmd_id_received(vb) call
before send_cmd_id_start(vb) record a different command ID than the one
actually used for the round, and does vb->num_free_page_blocks match the
documented semantics of outstanding_blocks?

First, virtio_balloon_cmd_id_received(vb) tests and clears
VIRTIO_BALLOON_CONFIG_READ_CMD_ID before reading config space:

drivers/virtio/virtio_balloon.c:send_cmd_id_start() {
	...
	vb->cmd_id_active =3D cpu_to_virtio32(vb->vdev,
					virtio_balloon_cmd_id_received(vb));
	...
}

If a config interrupt arrives between the virtio_balloon_cmd_id_received(vb)
call in virtio_balloon_report_free_page() and the second call inside
send_cmd_id_start(vb), cmd_id in the tracepoint will not match the
vb->cmd_id_active sent to the host.

Second, the comment in include/trace/events/virtio_balloon.h for
virtio_balloon_free_page_hint states that outstanding_blocks is the number
of hint blocks handed to the host but not yet reclaimed via a DONE/STOP
command at the end of the reporting round, and that a high value means the
host did not fully drain the round.

However, in report_free_page_func() -> virtio_balloon_report_free_page():

drivers/virtio/virtio_balloon.c:report_free_page_func() {
	cmd_id_received =3D virtio_balloon_cmd_id_received(vb);
	if (cmd_id_received =3D=3D VIRTIO_BALLOON_CMD_ID_DONE) {
		/* Pass ULONG_MAX to give back all the free pages */
		return_free_pages_to_mm(vb, ULONG_MAX);
	} else if (cmd_id_received !=3D VIRTIO_BALLOON_CMD_ID_STOP &&
		   cmd_id_received !=3D
		   virtio32_to_cpu(vb->vdev, vb->cmd_id_active)) {
		virtio_balloon_report_free_page(vb);
	}
}

While send_free_pages() and send_cmd_id_stop() detach used buffers from
free_page_vq via virtqueue_get_buf(), the allocated pages remain on
vb->free_page_list and counted in vb->num_free_page_blocks until the host
later sends VIRTIO_BALLOON_CMD_ID_DONE and triggers a subsequent
report_free_page_func() run calling return_free_pages_to_mm(). Receiving
VIRTIO_BALLOON_CMD_ID_STOP also does not reclaim blocks from
vb->free_page_list.

As a result, at the end of virtio_balloon_report_free_page(), isn't
vb->num_free_page_blocks simply the total number of blocks accumulated on
vb->free_page_list so far, rather than blocks the host failed to drain from
the virtqueue?

> =20
>  static void report_free_page_func(struct work_struct *work)
> @@ -869,8 +873,11 @@ static int virtballoon_migratepage(struct balloon_de=
v_info *vb_dev_info,
>  	 * recursion in the case it ends up triggering memory compaction
>  	 * while it is attempting to inflate the ballon.
>  	 */
> -	if (!mutex_trylock(&vb->balloon_lock))
> +	if (!mutex_trylock(&vb->balloon_lock)) {
> +		trace_virtio_balloon_migrate(page_to_pfn(page),
> +					     page_to_pfn(newpage), -EAGAIN);
>  		return -EAGAIN;
> +	}
> =20
>  	/* balloon's page migration 1st step  -- inflate "newpage" */
>  	vb->num_pfns =3D VIRTIO_BALLOON_PAGES_PER_PAGE;
> @@ -883,6 +890,8 @@ static int virtballoon_migratepage(struct balloon_dev=
_info *vb_dev_info,
>  	tell_host(vb, vb->deflate_vq);
> =20
>  	mutex_unlock(&vb->balloon_lock);
> +
> +	trace_virtio_balloon_migrate(page_to_pfn(page), page_to_pfn(newpage), 0=
);
>  	return 0;
>  }
>  #endif /* CONFIG_BALLOON_MIGRATION */
> diff --git a/include/trace/events/virtio_balloon.h b/include/trace/events=
/virtio_balloon.h
> index 559deb997e885..c29f833fa1889 100644
> --- a/include/trace/events/virtio_balloon.h
> +++ b/include/trace/events/virtio_balloon.h

[ ... ]

> +TRACE_EVENT(virtio_balloon_migrate,
> +
> +	TP_PROTO(unsigned long old_pfn, unsigned long new_pfn, long ret),
> +
> +	TP_ARGS(old_pfn, new_pfn, ret),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned long, old_pfn)
> +		__field(unsigned long, new_pfn)
> +		__field(long, ret)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->old_pfn =3D old_pfn;
> +		__entry->new_pfn =3D new_pfn;
> +		__entry->ret =3D ret;
> +	),
> +
> +	TP_printk("old_pfn=3D0x%lx new_pfn=3D0x%lx ret=3D%ld",
> +		  __entry->old_pfn, __entry->new_pfn, __entry->ret)
> +);

[Severity: Low]
Should TRACE_EVENT(virtio_balloon_migrate, ...) in
include/trace/events/virtio_balloon.h be guarded by #ifdef
CONFIG_BALLOON_MIGRATION?

In drivers/virtio/virtio_balloon.c, virtballoon_migratepage() and both call
sites of trace_virtio_balloon_migrate() are compiled only when
CONFIG_BALLOON_MIGRATION is enabled. When building with
CONFIG_VIRTIO_BALLOON enabled and CONFIG_BALLOON_MIGRATION disabled, the
tracepoint has no callers, which triggers an unused tracepoint build warning
when CONFIG_WARN_ON_UNUSED_TRACEPOINTS is enabled and emits unreachable
trace event definitions into the image.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030025834.1916=
0-1-liuqiangneo@163.com?part=3D3
