Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184120;
	b=NWoAT23UHNRxh7j97H9PuIZUb0Nyi+YDZiv76ObSJ+s9YfvAh04KKiA+0u5U43kVD1OW
	 tGfikYpHkiGa4Nho4LY8PGLgdtjS6UHnZuVmI/+3tbtv8sWnyIKXucZwrDTqAIOlvsbKP
	 0VQekFnreNlivGCZeW9zKK+VkCxT/dazChA51weM3ex60kl8u/n9Ju1tc+XHea0Rmt181
	 jKRvQgJXK2wdLB1iKpLKB1MJ96Sab/PSsUOKkiNPf9Eb/2qzQ+HP65q45GlpsckJT0T5t
	 2GI2Fzb4GNDjC1MinI+1fzNHw3RDA/5A20+amGPbFIZaR38QOFdFxZRAWIqVuy/8GEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184120;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bKyWamdEIolnZg07QC6cKycTPopp0OVasiB8UP8Nij4=;
	b=fmxeT0+0BYP+gIeIS696FjseyBNqCpGxpQIrCFMOHnyWjSbgmNgh1ws1xbbspkxFU9xB
	 vPCbUrrcNEOuwAQj4Olq+ZCMww0PySVeyvjdXaiKGiaPZbIKeryx0RxDCu2q00KJMwqGQ
	 o9UeeQ5fX8/Ut5bKUFGa1J2JQs9xMi1OQjeNVnZMe9TA5zRVS6lvYvirKat4E+PZh4kuZ
	 irXHuB1FlzDFoh83rf+oKX1NYTUNcI6OyQP2/98cvDBk0Z/Kl01z8DDGm88yOZCfrWitk
	 CTTYbTQ/RxeKDPs/NtmwgFlhJvtQAqVB8OllrTQkYfw9taY3+aMOh2KuLhDkZlP+qZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=frtTYfzf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA40606A31C;
	Mon,  9 Nov 2026 00:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=frtTYfzf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2311F008A2;
	Mon,  9 Nov 2026 00:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794184120;
	bh=bKyWamdEIolnZg07QC6cKycTPopp0OVasiB8UP8Nij4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=frtTYfzfkL7JsIb1JDrAGMGAX59QtWZCE/NKfhD9eWWBCqwRYG3ybKA6YhQ+NA8OB
	 YmL4XTy9px79mAQLq4iyo7e+oPOtNttgUBmIcz3VooUnEQgQpOZ9Ldd1AWe70yczgB
	 4f7jMa3RlCq+c0fYncZ2H3P6E4qOXeL/uBCsCdn8PcX4sREmq8f2pVxg4+Cblk4uUo
	 Vf5IFDoaT3tgX0JRw3t9ajJof3idjJtgGcThaE3m90XUqBK3Ka+WjQhjEIgG/6erFm
	 snN2ui0d8vqwub/C9h3xT1EIJYTYFVo2dUjhxcCD3FExaemP/HoqB97b1qXOyNyREY
	 h97qhq22aPKZQ==
Message-ID: <sashiko-outbox-204211@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 04/12] ALSA: virtio: Propagate PCM send failures
 through ACK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261108235457.12688-5-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
 <20261108235457.12688-5-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 00:28:39 +0000
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
- [Medium] ALSA: virtio: premature ACK admission in virtsnd_pcm_reset()
  during prepare
- [Low] ALSA: virtio: misplaced Fixes trailer and inaccurate commit
  message
--

commit d7d32fabac0905c34c390dcb86edfd7a2dc6b2c7
Author: Joonho Lee <mynameisjune111@gmail.com>

> ALSA: virtio: Propagate PCM send failures through ACK
>=20
> virtsnd_pcm_msg_send() can fail while queueing a transfer. Restore the
> failed message's length and notify the device about earlier messages
> queued by the same call, so they do not remain stranded.
>=20
> Propagate errors through the indirect transfer callback and commit its
> private cursor only after successful submission. Genuine transfer errors
> arm stop_operating and return -EPIPE so ALSA can retire the stream.
>=20
> Close ACK admission under the PCM stream lock before sleeping teardown.
> Keep the prepared state protected by the substream lock and reject ACK
> through prepare and parameter changes. Reopen admission in the reset
> callback while the core holds the PCM lock for its pointer rebase. An
> ACK racing with teardown returns -EBADFD and preserves stop state.
>=20
> Keep the polling feature path unchanged.
>=20
> Fixes: fe981e67568c ("ALSA: virtio: use ack callback")
>=20
> Reject a stopped playback ACK before the XRUN path can rearm
> stop_operating. For capture, allow the ordinary stopped tail only during
> DRAINING and only while no transfer XRUN is latched.
>=20
> Latch a transfer failure before stopping PCM work. Once core reports the =
member XRUN, ACK returns -EBADFD to avoid another linked XRUN. ACK during p=
repare remains rejected until the core state reaches PREPARED.
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

[Severity: Low]
This isn't a runtime bug, but the Fixes: trailer sits in the middle of the
commit message rather than in the trailer block above Signed-off-by:, and
the final paragraph states that ACK returns -EBADFD once the core reports
XRUN whereas virtsnd_pcm_ack_state() returns -EPIPE for
SNDRV_PCM_STATE_XRUN in this patch.

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index 1091100a4c982..983c6f83d1231 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c

[ ... ]

> @@ -461,41 +530,168 @@ virtsnd_pcm_cp_pointer(struct snd_pcm_substream *s=
ubstream)
> =20
> +/* The caller holds the PCM lock, also used by DROP and state transition=
s. */
> +static int virtsnd_pcm_ack_state(struct snd_pcm_substream *substream)
> +{
> +	switch (substream->runtime->state) {
> +	case SNDRV_PCM_STATE_XRUN:
> +		return -EPIPE;
> +	case SNDRV_PCM_STATE_PREPARED:
> +	case SNDRV_PCM_STATE_RUNNING:
> +	case SNDRV_PCM_STATE_PAUSED:
> +	case SNDRV_PCM_STATE_DRAINING:
> +		if (atomic_read(&substream->runtime->buffer_accessing) < 0)
> +			return -EBADFD;
> +		return 0;
> +	default:
> +		return -EBADFD;
> +	}
> +}

[ ... ]

> +static int virtsnd_pcm_cp_ack(struct snd_pcm_substream *substream)
> +{
> +	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
> +	struct virtio_snd_queue *queue =3D virtsnd_pcm_queue(vss);
> +	struct virtsnd_pcm_transfer transfer =3D {};
> +	int rc;
> +
> +	rc =3D virtsnd_pcm_ack_state(substream);
> +	if (rc)
> +		return rc;
> +
> +	scoped_guard(spinlock_irqsave, &queue->lock) {
> +		guard(spinlock)(&vss->lock);
> +		if (vss->preparing || !vss->prepared)
> +			return -EBADFD;
> +		/* Keep only the post-STOP capture tail available during drain. */
> +		if (vss->stopped &&
> +		    (vss->xfer_xrun ||
> +		     substream->runtime->state !=3D SNDRV_PCM_STATE_DRAINING))
> +			return -EBADFD;
> +		if (vss->xfer_xrun) {
> +			rc =3D -EPIPE;
> +		} else {
> +			transfer.indirect =3D vss->pcm_indirect;
> +			rc =3D snd_pcm_indirect_capture_transfer(substream,
> +							       &transfer.indirect,
> +							       virtsnd_pcm_trans_copy);
> +			if (!rc)
> +				rc =3D transfer.error;
> +		}
> +		if (rc)
> +			virtsnd_pcm_transfer_failed(vss);
> +		else
> +			vss->pcm_indirect =3D transfer.indirect;
> +	}
> +	if (rc) {
> +		dev_err(&vss->snd->vdev->dev,
> +			"SID %u: capture ACK transfer failed: %d\n",
> +			vss->sid, rc);
> +		return -EPIPE;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * virtsnd_pcm_reset() - Reset PCM pointers and complete prepare admissi=
on.
> + * @substream: Kernel ALSA substream.
> + *
> + * Context: PCM stream lock held.
> + * Return: 0 on success, -errno on failure.
> + */
> +static int virtsnd_pcm_reset(struct snd_pcm_substream *substream)
> +{
> +	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
> +	int rc;
> +
> +	rc =3D snd_pcm_lib_reset(substream);
> +	scoped_guard(spinlock_irqsave, &vss->lock) {
> +		if (vss->preparing) {
> +			vss->prepared =3D !rc;
> +			vss->preparing =3D false;
> +		}
> +	}
> =20
> -	return snd_pcm_indirect_capture_transfer(substream, &vss->pcm_indirect,
> -						 virtsnd_pcm_trans_copy);
> +	return rc;
>  }

[Severity: Medium]
Can virtsnd_pcm_reset() reopen ACK admission on a substream before
snd_pcm_post_prepare() transitions the group to SNDRV_PCM_STATE_PREPARED?

CPU0                                  CPU1
snd_pcm_prepare(s0)
  snd_pcm_action_nonatomic(...)
    snd_pcm_do_prepare(s1)
      virtsnd_pcm_sync_stop(s1)
        vss1->stopped =3D false
      virtsnd_pcm_prepare(s1)
      snd_pcm_reset_substream(s1, ...)
        virtsnd_pcm_reset(s1)
          vss1->prepared =3D true
          vss1->preparing =3D false
    snd_pcm_do_prepare(s2)
      ... (sleeps or fails)
                                      snd_pcm_sync_ptr(s1)
                                        pcm_lib_apply_appl_ptr(s1, ...)
                                          virtsnd_pcm_pb_ack(s1) /
                                          virtsnd_pcm_cp_ack(s1)
                                            <-- accepted before post_prepare

In snd_pcm_action_group(), snd_pcm_do_prepare() runs sequentially on each
linked member before snd_pcm_post_prepare() runs on any of them, and
snd_pcm_action_nonatomic() only sets runtime->buffer_accessing to -1 on
the ioctl target substream (and snd_pcm_sync_ptr() does not check
buffer_accessing at all).  If a linked member s1 entered prepare from
PREPARED, PAUSED, or capture DRAINING, virtsnd_pcm_reset(s1) sets
vss1->prepared =3D true and vss1->preparing =3D false and releases s1's PCM
stream lock before s2 completes snd_pcm_do_prepare(s2).

While s2 sleeps in snd_pcm_do_prepare(s2) (or permanently if s2 fails
prepare, since snd_pcm_action_prepare has no undo_action), playback ACKs
on s1 queue new TX buffers to the virtqueue before prepare completes.  In
addition, because virtsnd_pcm_cp_ack() only checks runtime->state !=3D
SNDRV_PCM_STATE_DRAINING when vss->stopped is true, a capture substream
re-prepared from DRAINING has vss1->stopped =3D=3D false after
virtsnd_pcm_sync_stop(s1) and accepts capture ACKs while runtime->state is
still DRAINING, driving vss1->pcm_indirect.sw_ready negative.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108235457.1268=
8-1-mynameisjune111@gmail.com?part=3D4
