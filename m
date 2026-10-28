Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793182494;
	b=44ik8OhvUQLJgr0guT19dj2wE93N0+sqoOtMzDaaz3T1O/Lcb3vL5y7CxS9k7jcsrCGl
	 WEddU9C/SZN6dCQyu9D0dIMve0MkwpLuC2j6KF7hRnB+UwaZnCGdgv8THkbRwscCNtehC
	 4O2e9m4MA233Ok+VVJOiuvH32pt66NmyMfv7UfBhzaQGWPcsuZI+uRZP473dlMMNkilNE
	 OHV/83p6iwBb6d/rpXaXsx5x90F4PyPmEm4eIj5kBhHsE7oTbC8FwwPsAUwrkSIpC/tqk
	 /6z8k8sN8EQ8eSfPdgqUUP6l5+TC6rK/ccIaayyd433yyIaB+dJp0EWzKibAVmJquAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793182494;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=m2ezrgnx3qlnWl7x3+zBbtpqohTAdPRWFCLkVX4gCyY=;
	b=Hp+t6J4od+/7H13obAIaUnnYW7ijM0e1W5vNk0iB7I0B4I9m+M/jn7LP3KeSJScayvle
	 cWfvvuVkMSyP9HjEUrgdB7PjUT67jUE2S/lvjVhAwxGDKgphYa2IzItVP8j9UiPS80fNo
	 FMBKGH6vCUYJavT8cg/BPKkidx3AWANrv/coD6TmFvh+oiMDYUwZkd8Hiw/iLIBTcf4b7
	 NRobMsVmAh1Y4ULPRVJKy3VT1ffziiMw8B732sNg4O1wlVonZ1LPTthprYj7ew7J2gDo0
	 tdd1XRan6gVDYZPH1GF1tvONw+37y0Ikdgy65v0NNPAeBk8/V9oKhUnlD2ELcQiZ93Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oUaQ3dko;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBF8606A31C;
	Wed, 28 Oct 2026 10:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oUaQ3dko
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3002D1F01825;
	Wed, 28 Oct 2026 10:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793182494;
	bh=m2ezrgnx3qlnWl7x3+zBbtpqohTAdPRWFCLkVX4gCyY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oUaQ3dko9rhf9ElABlLkBINpr9IDl63eNK7Q1hKPIC02UPQDeb/7wJxPx9dqQB7zn
	 PqtXGLlK2AnnV7Ceo14mfRptXjx0YqvfcBETDOw3a384wlAtnrO0HjA9dMU4dQbVtg
	 WlzNiD4h4K38+ovADA6VCtHQW8wDekjMx3+/1lxtXckKigE1E9ZhWOBFDv7fSlxize
	 VIPnqWCK2JQqKX875KHeuh9RUW0dHWLTaF7Fkr4/0Oso1U2y6NjCC9HZXFzm6U1hk8
	 9uQOOwUbb61p21chDzi3Iqy1ENsoLEUCPKzOyEL55CxMv9TlX46U26h+DjqMbX5X6n
	 TTy4IbvUA6PCw==
Message-ID: <sashiko-outbox-187737@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/16] ALSA: virtio: stage VZ capture and restart
 paused streams
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261028094132.20364-8-mynameisjune111@gmail.com>
References: <20261028094132.20364-1-mynameisjune111@gmail.com>
 <20261028094132.20364-8-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 10:14:53 +0000
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
- [Medium] ALSA: virtio: DMA cacheline sharing in virtsnd_pcm_capture_send()
- [Low] ALSA: virtio: 64-bit division and modulo on u64 capture counters br=
eak 32-bit builds
--

commit b45632282ebc50eaee6059eb5173344a95c32ede
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: stage VZ capture and restart paused streams

This patch adds opt-in capture staging using request-owned buffers with
response validation and ring accounting. It also introduces a pause
release and reprepare state machine for staged capture streams.

> diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
> index be3893de40a55..a3478fc8848db 100644
> --- a/sound/virtio/virtio_pcm.c
> +++ b/sound/virtio/virtio_pcm.c
> @@ -310,8 +310,94 @@ static void virtsnd_pcm_period_elapsed(struct work_s=
truct *work)
>  {

[ ... ]

> +		period_bytes =3D snd_pcm_lib_period_bytes(substream);
> +		if (vss->xfer_xrun) {
> +			notify =3D true;
> +		} else if (!period_bytes || period_bytes >=3D vss->buffer_bytes ||
> +			   !virtsnd_pcm_capture_counters_valid(vss) ||
> +			   vss->capture_notified_periods >
> +				vss->capture_copied_total / period_bytes) {
> +			vss->xfer_xrun =3D true;
> +			notify =3D true;
> +		} else {
> +			period_floor =3D vss->capture_copied_total / period_bytes;
> +			if (period_floor > vss->capture_notified_periods) {
> +				/* Reserve crossed boundaries before the callback. */
> +				vss->capture_notified_periods =3D period_floor;
> +				notify =3D true;
> +			}
> +		}

[ ... ]

> diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
> index 61faf7b13cbc1..e143a15592f05 100644
> --- a/sound/virtio/virtio_pcm.h
> +++ b/sound/virtio/virtio_pcm.h

[ ... ]

> +static inline bool
> +virtsnd_pcm_capture_counters_valid(const struct virtio_pcm_substream *vs=
s)
> +{
> +	return vss->buffer_bytes &&
> +	       vss->capture_copied_total >=3D vss->capture_acked_total &&
> +	       vss->capture_copied_total - vss->capture_acked_total =3D=3D
> +			(u64)vss->capture_ready &&
> +	       vss->capture_ready < vss->buffer_bytes &&
> +	       vss->capture_pointer_seen_total <=3D vss->capture_copied_total &&
> +	       vss->hw_ptr =3D=3D vss->capture_copied_total % vss->buffer_bytes=
 &&
> +	       (!vss->capture_callback_snapshot_active ||
> +		(vss->capture_callback_snapshot >=3D
> +			vss->capture_pointer_seen_total &&
> +		 vss->capture_callback_snapshot <=3D
> +			vss->capture_copied_total));
> +}

[Severity: Low]
Will these raw 64-bit divisions and modulo operations break 32-bit builds
with undefined references to __udivdi3 and __umoddi3?

Here in virtsnd_pcm_capture_counters_valid() (sound/virtio/virtio_pcm.h)
and virtsnd_pcm_period_elapsed() (sound/virtio/virtio_pcm.c), as well as in
virtsnd_pcm_capture_complete() (sound/virtio/virtio_pcm_msg.c):

	else if (vss->hw_ptr !=3D
		 vss->capture_copied_total % vss->buffer_bytes)
	...
	size_t ring_ptr =3D vss->capture_copied_total %
			  vss->buffer_bytes;
	...
	vss->hw_ptr =3D next_copied_total % vss->buffer_bytes;

and in virtsnd_pcm_cp_pointer() (sound/virtio/virtio_pcm_ops.c):

	hw_ptr =3D total % vss->buffer_bytes;

the u64 counters (capture_copied_total, next_copied_total, and total) are
divided by or taken modulo a size_t value (vss->buffer_bytes or
period_bytes).

On 32-bit architectures, usual arithmetic conversions promote the size_t
operand to u64, causing the compiler to emit __udivdi3 and __umoddi3 calls.
Should these use helpers from linux/math64.h such as div64_ul() or
div_u64_rem() instead?

> diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
> index b54642a9521db..795e52e09564b 100644
> --- a/sound/virtio/virtio_pcm_msg.c
> +++ b/sound/virtio/virtio_pcm_msg.c
> @@ -16,6 +17,7 @@
>   * @xfer: Request header payload.
>   * @status: Response header payload.
>   * @length: Data length in bytes.
> + * @data: Request-owned payload for staged capture.
>   * @data_offset: Offset in the driver-owned PCM buffer on NOMMU systems.
>   * @sgs: Payload scatter-gather table.
>   */
> @@ -24,6 +26,7 @@ struct virtio_pcm_msg {
>  	struct virtio_snd_pcm_xfer xfer;
>  	struct virtio_snd_pcm_status status;
>  	size_t length;
> +	u8 *data;
>  #ifndef CONFIG_MMU
>  	size_t data_offset;
>  #endif

[ ... ]

> +	for (i =3D 0; i < vss->nmsgs && vss->msg_count < request_limit; ++i) {
> +		struct virtio_pcm_msg *msg =3D vss->msgs[i];
> +		struct scatterlist *sgs[] =3D {
> +			&msg->sgs[PCM_MSG_SG_XFER],
> +			&msg->sgs[PCM_MSG_SG_DATA],
> +			&msg->sgs[PCM_MSG_SG_STATUS]
> +		};
> +		int rc;
> +
> +		if (msg->length)
> +			continue;
> +
> +		msg->xfer.stream_id =3D cpu_to_le32(vss->sid);
> +		/* Do not let an absent packed trailer reuse old PCM bytes. */
> +		memset(msg->data, 0, period_bytes);
> +		memset(&msg->status, 0, sizeof(msg->status));
> +		msg->status.status =3D cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> +		rc =3D virtqueue_add_sgs(vqueue, sgs, 1, 2, msg, GFP_ATOMIC);
> +		if (rc) {
> +			if (added && !(vss->features &
> +				       (1U << VIRTIO_SND_PCM_F_MSG_POLLING)) &&
> +			    virtqueue_kick_prepare(vqueue))
> +				virtqueue_notify(vqueue);
> +			return rc;
> +		}
> +
> +		msg->length =3D period_bytes;
> +		vss->msg_count++;
> +		added =3D true;
> +	}

[Severity: Medium]
Can touching msg->length after virtqueue_add_sgs() in
virtsnd_pcm_capture_send() corrupt DMA transfers on non-coherent platforms?

In struct virtio_pcm_msg, status, length, and data are adjacent fields in
the same slab allocation and share a CPU cacheline.

When virtsnd_pcm_capture_send() calls virtqueue_add_sgs(), msg->status is
mapped for device-to-driver DMA. Immediately after virtqueue_add_sgs()
returns, virtsnd_pcm_capture_send() writes msg->length =3D period_bytes, and
subsequent calls to virtsnd_pcm_capture_send() read msg->length while the
descriptor is still queued.

On non-coherent DMA systems where virtio uses the DMA API, dirtying the
cacheline containing msg->length after msg->status is mapped can cause a
later cacheline writeback to overwrite the device's DMA write to
msg->status, or cache invalidation during DMA unmap in virtqueue_get_buf()
can discard the write to msg->length so virtsnd_pcm_capture_complete() sees
msg->length =3D=3D 0 and triggers a false xfer_xrun.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028094132.2036=
4-1-mynameisjune111@gmail.com?part=3D7
