Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793146418;
	b=Czo5YF5uHH3XEyJD1ZxfSA4/d6lJ5WW8gREbn+Tea6bUmpr0+u5PgsjQzgvTe4nXPbRR
	 uie+H473BdqzJBWIPG++T67B9toJYwRlpUXjJ/EHyvqlHCw+6j4vBOxqO/Ag3xFQ78I6j
	 yk63xmRYG9y80uEogDKZ4C67BFuKyTB9y3JhrO8sSfABpVddIdMYbfx0yDVOmvtGhFuBK
	 XDMcElCaw6sz1G7VEQji8IEdfzvPFflMCH77b6fBShzEuXN88rVp736R/1bVKAaMN436D
	 uucRR9KMqLg2D3vh7gwRwVn/bpJLs1G2a/xKYkrMT1mAK74Rw0Yf7Tr6Qlb/NHS0TQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793146418;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AOXQq+96hBcR5m2vk1Elo8rGwS0ZeHXmEGQ3KS8mQr8=;
	b=VpOL2nKPqTgfXX8ge6qx+t6iCjNwDepPBR883chwfkeC42TxndCxMOqT2B6SbbvvAgeh
	 aNO9wa2JHKZHlsHiG1nQ1WaBc2oeSyoOp9Cth4NVhp2PsPGlcWy/0eOKvas2++DvFntBD
	 03W1/YR5QwToBxePAHgl1bcqxdH4pGJGOVLhUcR2bgrmgpXuJ92WsrA09869iCP3v9g6Q
	 RLztjdpg6PmomMWP8QnRBOSMoDlsM7EGB6jnFLP8icwJlGmeUuvoGRR0Op4NH/IihMvc2
	 VEksACE9uxC0061dFiChrf9Bn7pq0n+q5iHy4L8fbFqFHveXwY3jkoWnzpOnpyQNgeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZXFH3cM4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80552606A31A;
	Wed, 28 Oct 2026 00:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZXFH3cM4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF97E1F01825;
	Wed, 28 Oct 2026 00:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793146418;
	bh=AOXQq+96hBcR5m2vk1Elo8rGwS0ZeHXmEGQ3KS8mQr8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZXFH3cM4k2cX6efb90IPUS+nx42mVW2cjW+oTPq9gRn30jUDxHGZ1ZCeFVPbwszD3
	 HNWGXmDMzCGEuK9W9+a66zJeYfbV7pCz+wT/7FosYLk9B1Wu0P/pb1CB5SW90r3hN4
	 HRaiuGvO7HD9jEAAJtz3rzkALnVWEMDMdCebuiBHfsRYLdSTDk9xSxkksp0T3WjyzB
	 DK3yRldz+yaO5wHRszzkDzrd88nAUKtBl/Xyfyhin+yAtVpDMPWY3/DBgkRMeMzCfz
	 vbQgndYVZQFYZO4CkZD+Trh5FuXi6Y8aYjRiua40mSAoDIgYyiPrIerSqU+vCmadrw
	 bgS0Pe/gI2Lmg==
Message-ID: <sashiko-outbox-187263@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/11] ALSA: virtio-snd: fix dsnoop capture with
 staged buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261027234334.32551-12-mynameisjune111@gmail.com>
References: <20261027234334.32551-1-mynameisjune111@gmail.com>
 <20261027234334.32551-12-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 00:13:37 +0000
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
- [Medium] ALSA: virtio-snd: un-armed paused stop on read XRUN in virtsnd_p=
cm_cp_ack()
--

commit ceb71ae8baa14854bd1fb36ae47981ac52e944e5
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio-snd: fix dsnoop capture with staged buffers

This commit adds free-running capture mode support for staged capture buffe=
rs
when stop_threshold equals the boundary, allowing dsnoop clients to consume
the mmap ring without triggering capacity rejections. It also handles trans=
itions
back to bounded capture and arms synchronous stop on paused XRUN paths.

> diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
> index 663f7695b5be8..e7258bce2e6f0 100644
> --- a/sound/virtio/virtio_pcm_msg.c
> +++ b/sound/virtio/virtio_pcm_msg.c
[ ... ]
> @@ -508,24 +511,54 @@ int virtsnd_pcm_msg_send(struct virtio_pcm_substrea=
m *vss, unsigned long offset,
>  	return 0;
>  }
> =20
[ ... ]
> +/* Caller holds vss->lock. */
> +int virtsnd_pcm_capture_refresh_mode_locked(struct virtio_pcm_substream =
*vss,
> +					    bool *free_running)
> +{
> +	struct snd_pcm_runtime *runtime;
> +	snd_pcm_uframes_t stop_threshold;
> +	u64 outstanding;
> +	bool new_free_running;
> +
> +	if (!vss->capture_staging || !vss->runtime_active || !vss->substream)
> +		return -EBADFD;
> +
> +	runtime =3D vss->substream->runtime;
> +	if (!runtime || !vss->buffer_bytes || !vss->capture_boundary)
> +		return -EBADFD;
> +
> +	/* Validate the currently committed policy before observing a transitio=
n. */
> +	if (!virtsnd_pcm_capture_counters_valid(vss))
> +		return -EIO;
> +
> +	stop_threshold =3D READ_ONCE(runtime->stop_threshold);
> +	new_free_running =3D stop_threshold =3D=3D vss->capture_boundary;
> +	if (new_free_running !=3D vss->capture_free_running) {
> +		outstanding =3D vss->capture_copied_total -
> +			      vss->capture_acked_total;
> +		if (new_free_running) {
> +			vss->capture_ready =3D 0;
> +		} else {
> +			if (outstanding >=3D vss->buffer_bytes)
> +				return -EPIPE;
> +			vss->capture_ready =3D outstanding;
> +		}
> +		vss->capture_free_running =3D new_free_running;
> +	}
> +
> +	*free_running =3D new_free_running;
> +	return 0;
> +}
[ ... ]
> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index d50924b792f65..cbf4e479d295f 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c
[ ... ]
> @@ -1314,8 +1348,14 @@ static int virtsnd_pcm_cp_ack(struct snd_pcm_subst=
ream *substream)
>  	struct virtsnd_pcm_transfer transfer =3D {};
>  	int rc;
> =20
> -	if (vss->capture_staging)
> -		return virtsnd_pcm_capture_staged_ack(vss, runtime);
> +	if (vss->capture_staging) {
> +		rc =3D virtsnd_pcm_capture_staged_ack(vss, runtime);
> +		if (rc =3D=3D -EPIPE) {
> +			guard(spinlock_irqsave)(&vss->lock);
> +			virtsnd_pcm_capture_arm_paused_stop(vss);
> +		}
> +		return rc;
> +	}

[Severity: Medium]
Can a paused staged-capture stream still enter SNDRV_PCM_STATE_XRUN during a
partial read without arming vss->stopped and runtime->stop_operating?

If a staged-capture stream is paused in SNDRV_PCM_STATE_PAUSED with unread
frames in the ring (where outstanding < vss->buffer_bytes), and userspace
lowers runtime->stop_threshold via snd_pcm_sw_params() from boundary to a
bounded threshold smaller than the frames that will remain after a partial
read, snd_pcm_sw_params() does not call snd_pcm_update_state() because
snd_pcm_running(substream) is false while paused.

When userspace then performs a partial read through __snd_pcm_lib_xfer() th=
at
leaves remaining avail >=3D runtime->stop_threshold:

  __snd_pcm_lib_xfer()
    pcm_lib_apply_appl_ptr()
      virtsnd_pcm_cp_ack()
        virtsnd_pcm_capture_staged_ack()
          virtsnd_pcm_capture_refresh_mode_locked()

virtsnd_pcm_capture_refresh_mode_locked() in sound/virtio/virtio_pcm_msg.c
only checks outstanding >=3D vss->buffer_bytes when transitioning from
free-running to bounded mode, so virtsnd_pcm_capture_staged_ack() succeeds
with rc =3D=3D 0. Because virtsnd_pcm_cp_ack() in sound/virtio/virtio_pcm_o=
ps.c
only calls virtsnd_pcm_capture_arm_paused_stop(vss) when rc =3D=3D -EPIPE, =
it
returns 0 without setting vss->stopped or runtime->stop_operating.

Immediately afterward at the end of __snd_pcm_lib_xfer() in
sound/core/pcm_lib.c:

  _end_unlock:
    runtime->twake =3D 0;
    if (xfer > 0 && err >=3D 0)
        snd_pcm_update_state(substream, runtime);

snd_pcm_update_state() sees avail >=3D runtime->stop_threshold and calls
__snd_pcm_xrun() -> snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN). Because
snd_pcm_running() is false in SNDRV_PCM_STATE_PAUSED, snd_pcm_do_stop() ski=
ps
trigger(STOP) and does not set runtime->stop_operating =3D true.

On the subsequent recovery call to snd_pcm_prepare(), snd_pcm_sync_stop() is
skipped and virtsnd_pcm_prepare() in sound/virtio/virtio_pcm_ops.c fails wi=
th
-EBADFD on vss->stopped (in pause-restart mode) or
virtsnd_pcm_msg_pending_num(vss) (in native pause mode):

  scoped_guard(spinlock_irqsave, &vss->lock)
      stopped =3D vss->stopped;
  if (stopped) {
      dev_err(&vdev->dev, "SID %u: stream release failed\n",
              vss->sid);
      substream->runtime->stop_operating =3D true;
      return -EBADFD;
  }

  if (!vss->suspended) {
      if (virtsnd_pcm_msg_pending_num(vss)) {
          dev_err(&vdev->dev, "SID %u: invalid I/O queue state\n",
                  vss->sid);
          return -EBADFD;
      }

Should virtsnd_pcm_cp_ack() also check whether a paused stream has remaining
capture avail >=3D runtime->stop_threshold (or check stop_threshold in
virtsnd_pcm_capture_staged_ack()) so virtsnd_pcm_capture_arm_paused_stop() =
is
armed before snd_pcm_update_state() moves the paused stream to
SNDRV_PCM_STATE_XRUN?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027234334.3255=
1-1-mynameisjune111@gmail.com?part=3D11
