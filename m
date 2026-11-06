Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793925370;
	b=1gsMBxP7iMbx8HZ0B6/eTkTHiqmvj2BcaEYhAOe10UCx4s683YEycx0dd+rtbVGpp4BM
	 eqD9kczSK+Eufe6M/K/dxpZ6NmOYtUwWWSyL83YuoArTiOiO8u4RcMp3DRZUXEheUzUVw
	 NU7Us67aX9ZRJy8pVP/RFoK9u6Ue3zqePy79mKRFElqWxGAhVh/Y1ULJOSDyGWJqZT1+y
	 FqlwlA5FqKcmxy9HLRl4OnkIRTUjeNQkDP22XdXuDLz5ipebFQqZANmpCrqU0L+s/8OqE
	 vJyn1KWkGnCaOqwF6wdbqRlRjQgqHD2NNu5tkpuNQkZ/6ka7TVMLcgO8Aw479KcpIBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793925370;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=G7EHYORUbI/Od6bP41K+8SbHrG8XXKOBiTMtAO5OmAk=;
	b=lS4AOvI5gkgRB3OWn5gbEN/Ypf/lDRAKS/PmXGBlKLt+xlhvWLN9ldg2k5TaSe4hN8v/
	 9ze30N4ChExNp7nJLjY9Te3nq3NSpjpGdIE767U0fWRi47DpypguCpzK2EU5O1BkAZ7gE
	 nrU+W7ibSMEGEMmkqRsNloGZiD0q41vAlaD0UTrq0jfQI9gPaVzW+jIq5k+LbVlh3SgSA
	 Rx5QApSFkg6R1263wXtWRdQw5Hgw3O0IVU5oJ/G8ypSrBrnAD6n/14g7pgBjQJjGiiCrL
	 l3JbqzlOCMnA88QmcEFI8EDy2s7QdyRvXGVt7la7mnoMSCORz8nXPtHj/Wx2B5jf9NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GpMM9Eiu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B0D606A331;
	Fri,  6 Nov 2026 00:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GpMM9Eiu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C371F008A1;
	Fri,  6 Nov 2026 00:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793925369;
	bh=G7EHYORUbI/Od6bP41K+8SbHrG8XXKOBiTMtAO5OmAk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GpMM9Eiu0PoCQh//bheA1MsZTxewtU9opVC2FGwo1Akx79BWlE80ooZZS4fHlCk4q
	 f8zmwpU/Y7wEI0Oy66yE1EhamHtUHyCI3RBjoRl/JBOOdSzZrX7Kt2wg0k7QcT6YVd
	 lbo20kbSAKtkbGUgLu7YtfcTeJnhTAv4uvRfZvsAr1pRShrtFGLb3nMaUVFBBpKsoZ
	 QfiAc5XGTwy2e26dL2QmRymmUuT+29ThRkVsiYmmvTG64uIwJkmm7tQb4ZRnVva9Jh
	 jQyuOq7eaG9WY9m7v4zaEII0SC0lGSbeCjtFOXf1ccMzAuRKISjNvClDGX9a0cehc0
	 Xv2cq3xHXaYTw==
Message-ID: <sashiko-outbox-200452@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 07/12] ALSA: virtio: retain PCM DMA pages and
 validate capture ring ownership
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261106000644.20460-8-mynameisjune111@gmail.com>
References: <20261106000644.20460-1-mynameisjune111@gmail.com>
 <20261106000644.20460-8-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 00:36:08 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] ALSA: virtio: sw_ready desynchronization in virtsnd_pcm_cp_ack()
--

commit b314c942dc53f8c652b76808e69e1ee4418c9e8e
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: retain PCM DMA pages and validate capture ring ownership

This commit retains references to ALSA PCM DMA pages (or uses driver-owned
buffers on NOMMU systems) until queued I/O messages are freed, and adds
validation for period boundaries and fixed-slot capture completions. It also
seeds the ordinary capture ring once per prepare and reserves the RX ring v=
ia
sw_ready until appl_ptr consumes the captured data.

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index 343700ec50476..bf9dafe149dac 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c

[ ... ]

> @@ -433,8 +446,15 @@ static int virtsnd_pcm_trigger(struct snd_pcm_substr=
eam *substream, int command)
>  				substream->runtime->stop_operating =3D true;
>  				return -EBADFD;
>  			}
> -			if (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE)
> +			if (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE &&
> +			    !vss->capture_rx_seeded) {
>  				rc =3D virtsnd_pcm_msg_send(vss, 0, vss->buffer_bytes);
> +				if (!rc) {
> +					/* The full RX ring is reserved until userspace reads it. */
> +					vss->pcm_indirect.sw_ready =3D vss->buffer_bytes;
> +					vss->capture_rx_seeded =3D true;
> +				}
> +			}
>  			if (rc) {
>  				vss->stopped =3D true;
>  				substream->runtime->stop_operating =3D true;

[Severity: High]
Can userspace desynchronize or underflow vss->pcm_indirect.sw_ready via
SNDRV_PCM_IOCTL_SYNC_PTR in virtsnd_pcm_cp_ack()?

In sound/virtio/virtio_pcm_ops.c, virtsnd_pcm_ack_state() allows ACK in
SNDRV_PCM_STATE_PREPARED, and virtsnd_pcm_cp_ack() does not check
vss->capture_rx_seeded before calling snd_pcm_indirect_capture_transfer():

sound/virtio/virtio_pcm_ops.c:virtsnd_pcm_cp_ack() {
	...
	scoped_guard(spinlock_irqsave, &queue->lock) {
		guard(spinlock)(&vss->lock);
		if (vss->preparing || !vss->prepared)
			return -EBADFD;
		/* Keep only the post-STOP capture tail available during drain. */
		if (vss->stopped &&
		    (vss->xfer_xrun ||
		     substream->runtime->state !=3D SNDRV_PCM_STATE_DRAINING))
			return -EBADFD;
		if (vss->xfer_xrun) {
			rc =3D -EPIPE;
		} else {
			transfer.indirect =3D vss->pcm_indirect;
			rc =3D snd_pcm_indirect_capture_transfer(substream,
							       &transfer.indirect,
							       virtsnd_pcm_trans_copy);
	...
}

If userspace invokes SNDRV_PCM_IOCTL_SYNC_PTR (without
SNDRV_PCM_SYNC_PTR_APPL) while the capture stream is in
SNDRV_PCM_STATE_PREPARED before SNDRV_PCM_TRIGGER_START,
pcm_lib_apply_appl_ptr() invokes virtsnd_pcm_cp_ack() ->
snd_pcm_indirect_capture_transfer(), which updates vss->pcm_indirect.appl_p=
tr
and decrements vss->pcm_indirect.sw_ready below zero while sw_data and
hw_data remain 0. When virtsnd_pcm_trigger() later handles
SNDRV_PCM_TRIGGER_START, it sets vss->pcm_indirect.sw_ready =3D
vss->buffer_bytes while vss->pcm_indirect.appl_ptr is already non-zero,
leaving sw_ready and sw_data out of sync with appl_ptr.

Similarly, after SNDRV_PCM_TRIGGER_START in SNDRV_PCM_STATE_RUNNING,
pcm_lib_apply_appl_ptr() only bounds each appl_ptr advance to
runtime->buffer_size rather than the unread captured frames. If userspace
uses SNDRV_PCM_IOCTL_SYNC_PTR to advance appl_ptr ahead of captured bytes
(for example when hw_ready is 0 before completions arrive),
snd_pcm_indirect_capture_transfer() subtracts frames_to_bytes(runtime, diff)
from rec->sw_ready without transferring anything.

Wouldn't subsequent period completions in virtsnd_pcm_cp_pointer() then see
rec->sw_ready < rec->sw_buffer_size and prematurely re-queue capture
descriptors before userspace reads them, or allow repeated SYNC_PTR calls to
underflow rec->sw_ready so (int)(rec->sw_buffer_size - rec->sw_ready) wraps
negative and calls virtsnd_pcm_msg_send() on already-queued descriptors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106000644.2046=
0-1-mynameisjune111@gmail.com?part=3D7
