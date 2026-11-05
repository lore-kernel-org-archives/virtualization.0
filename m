Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793864504;
	b=SVykdciVIK4Sl90drdLSXXA098xq87dkz5ba6H9ugmISk//STP2xi4uOvieVk1MBxj04
	 QZYCgdizGqKh+CBEbOLSEnabkObqjtDD0kE7VBGhtIVRxiGhXfcnSgYZFSsEpeJyZCqNP
	 K54H9QaoePBzok2Yee0D10Xg9a/CH2mSPwxqGRsI3SM9b5phUjK4+nfhHupcS6D4NUyBv
	 JXOSAGvdqESu4oQHv0QA2Li3oQGseuUj5X4ypqqE3sCbCKWe/34gFK8diiaegoNNPI+0B
	 pGQ0jq3z3O8KSlCLY3jh8MxgMuGU41lqKYNufutMrasg2n1MqqjteK5iRzdA8RpcLNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793864504;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pulwbw7qG/v/rr704NDhtCZTkJsuZkYhPclW6BW2VJw=;
	b=Mdc3Z0T8M1wp8HiTn+/3a1ZCK0nNleDgA3G35yqtrKyBc3SfqH/l43/ox6SOYR/NqL1Z
	 b4Zo5Z9ngqgwSIo/myjrN9CJ7tZR5hqEJHN9/O8Kj1PNgDsn8sIdL1itaNZlSGIfQtXgB
	 BgHwe0CNMOOghNtYFPjOyEjWla+p2o/kMyhZTkLqWeJFRyFZA6iElFdCYm7LdcCHTIlgU
	 T1wvax7osqEqjmoCvOIWunUAOOWAKSNGs8QLawP3mT0CZSSbq1AeIPmXZ/t17ibChXgK0
	 Wj/N9TSO1Qn3bKZ0Oi2z5bM5h6l/f0oe8FWFU6b+RUsYLKnayOX1pC3EUfzEA/amG3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dRe4iAWr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605B5606A31B;
	Thu,  5 Nov 2026 07:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dRe4iAWr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2171F000C1;
	Thu,  5 Nov 2026 07:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793864504;
	bh=pulwbw7qG/v/rr704NDhtCZTkJsuZkYhPclW6BW2VJw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dRe4iAWr5WgmE18uI25Ydr++CnKDf14KemaZiszbkBCQHUCE5q01hixugfxlMtHAi
	 P0YRMSnH8SG3cXgCk/TSqCYq+8dXGT2mRcnvhFwJytzGOBcaUBFAKAEx/ulu3gDOEc
	 FD3/7x5/4kg4Niyd6om66FwSgiD/ySre0fOHSgabuAEiqxkZp6PHEZyUpb/Tw0asVk
	 NKAmblHCkfqjAbXEuQt3/+alCllmTEECgg9Exw+bFBwazXaKN28vWOvSGP22FSLgQB
	 yDD9olJ60kBSsTPFFZ3Xy3oizEX828FEuZKFXJQWaDXYlYUaqFkePvgn/mTTtYOaP3
	 7JUpe8daJDPkw==
Message-ID: <sashiko-outbox-198691@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 10/12] ALSA: virtio: serialize staged capture
 lifecycle and defer paused XRUNs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105070845.6449-11-mynameisjune111@gmail.com>
References: <20261105070845.6449-1-mynameisjune111@gmail.com>
 <20261105070845.6449-11-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 07:41:43 +0000
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
- [Medium] ALSA: virtio: missing xfer_xrun latch in virtsnd_pcm_transfer_fa=
iled()
--

commit 42ba5fb421db3215b1318325133b70f45151e844
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: serialize staged capture lifecycle and defer paused XRUNs

This commit introduces request-owned RX staging for capture streams,
serializes PCM lifecycle operations with lifecycle_lock, and defers XRUN
handling for paused linked streams until resume.

> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index 706d59d8c7201..36f8128a3f30c 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c

[ ... ]

> @@ -637,132 +1739,515 @@ static void virtsnd_pcm_transfer_failed(struct v=
irtio_pcm_substream *vss)
>  	vss->substream->runtime->stop_operating =3D true;
>  }
> =20
> +/* Caller holds vss->lock; a paused ACK must not trigger linked XRUN. */
> +static int virtsnd_pcm_ack_xrun_locked(struct virtio_pcm_substream *vss,
> +				       struct snd_pcm_runtime *runtime)
> +{
> +	vss->xfer_xrun =3D true;
> +	if (runtime->state =3D=3D SNDRV_PCM_STATE_PAUSED) {
> +		vss->xfer_enabled =3D false;
> +		runtime->stop_operating =3D true;
> +		virtsnd_pcm_schedule_period_elapsed(vss);
> +		return -EBADFD;
> +	}
> +	return -EPIPE;
> +}
> +
> +static int virtsnd_pcm_pb_ack_locked(struct snd_pcm_substream *substream)
> +{
> +	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
> +	struct snd_pcm_runtime *runtime =3D substream->runtime;
> +	struct virtio_snd_queue *queue =3D virtsnd_pcm_queue(vss);
> +	struct virtsnd_pcm_transfer transfer =3D {};
> +	bool paused;
> +	int rc;
> +
> +	scoped_guard(spinlock_irqsave, &queue->lock) {
> +		guard(spinlock)(&vss->lock);
> +		paused =3D runtime->state =3D=3D SNDRV_PCM_STATE_PAUSED;
> +		if (vss->preparing)
> +			return -EBADFD;
> +		/* A latched XRUN must not re-arm sync_stop once teardown began. */
> +		if (vss->stopped && vss->xfer_xrun)
> +			return -EBADFD;
> +		if (vss->xfer_xrun) {
> +			rc =3D virtsnd_pcm_ack_xrun_locked(vss, runtime);
> +		} else {
> +			if (!vss->prepared || vss->stopped)
> +				return -EBADFD;
> +			transfer.indirect =3D vss->pcm_indirect;
> +			rc =3D snd_pcm_indirect_playback_transfer(substream,
> +								&transfer.indirect,
> +								virtsnd_pcm_trans_copy);
> +		}
> +		if (!rc)
> +			rc =3D transfer.error;
> +		if (rc) {
> +			if (paused)
> +				rc =3D virtsnd_pcm_ack_xrun_locked(vss, runtime);
> +			else
> +				virtsnd_pcm_transfer_failed(vss);
> +		} else {
> +			vss->pcm_indirect =3D transfer.indirect;
> +		}
> +	}

[ ... ]

> +static int virtsnd_pcm_cp_ack_locked(struct snd_pcm_substream *substream)
> +{
> +	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
> +	struct virtio_snd_queue *queue =3D virtsnd_pcm_queue(vss);
> +	struct snd_pcm_runtime *runtime =3D substream->runtime;
> +	struct virtsnd_pcm_transfer transfer =3D {};
> +	bool paused;
> +	int rc;
> +
> +	if (vss->capture_staging) {
> +		rc =3D virtsnd_pcm_capture_staged_ack(vss, runtime);
> +		if (rc =3D=3D -EPIPE) {
> +			guard(spinlock_irqsave)(&vss->lock);
> +			virtsnd_pcm_transfer_failed(vss);
> +		}
> +		return rc;
> +	}
> +
> +	scoped_guard(spinlock_irqsave, &queue->lock) {
> +		guard(spinlock)(&vss->lock);
> +		paused =3D runtime->state =3D=3D SNDRV_PCM_STATE_PAUSED;
> +		if (vss->preparing)
> +			return -EBADFD;
> +		/* A latched XRUN must not re-arm sync_stop once teardown began. */
> +		if (vss->stopped && vss->xfer_xrun)
> +			return -EBADFD;
> +		if (vss->xfer_xrun) {
> +			rc =3D virtsnd_pcm_ack_xrun_locked(vss, runtime);
> +		} else {
> +			if (!vss->prepared ||
> +			    (vss->stopped &&
> +			     runtime->state !=3D SNDRV_PCM_STATE_DRAINING))
> +				return -EBADFD;
> +			transfer.indirect =3D vss->pcm_indirect;
> +			rc =3D snd_pcm_indirect_capture_transfer(substream,
> +							       &transfer.indirect,
> +							       virtsnd_pcm_trans_copy);
> +		}
> +		if (!rc)
> +			rc =3D transfer.error;
> +		if (rc) {
> +			if (paused)
> +				rc =3D virtsnd_pcm_ack_xrun_locked(vss, runtime);
> +			else
> +				virtsnd_pcm_transfer_failed(vss);
> +		} else {
> +			vss->pcm_indirect =3D transfer.indirect;
> +		}
> +	}

[Severity: Medium]
Should virtsnd_pcm_transfer_failed() in sound/virtio/virtio_pcm_ops.c also
latch vss->xfer_xrun =3D true?

When a non-paused indirect playback or capture ACK transfer fails in
virtsnd_pcm_pb_ack_locked() or virtsnd_pcm_cp_ack_locked() (for example,
when snd_pcm_indirect_playback_transfer() or
snd_pcm_indirect_capture_transfer() returns -EPIPE on a negative appl_ptr
diff, or virtsnd_pcm_msg_send() sets transfer.error), the error path calls
virtsnd_pcm_transfer_failed():

    static void virtsnd_pcm_transfer_failed(struct virtio_pcm_substream *vs=
s)
    {
            vss->xfer_enabled =3D false;
            vss->stopped =3D true;
            vss->substream->runtime->stop_operating =3D true;
    }

Unlike the paused path (which calls virtsnd_pcm_ack_xrun_locked()) and the
staged capture path (where virtsnd_pcm_capture_staged_ack() calls
virtsnd_pcm_ack_xrun_locked() before virtsnd_pcm_transfer_failed()),
virtsnd_pcm_transfer_failed() leaves vss->xfer_xrun false while vss->prepar=
ed
and vss->stopped are true.

Because vss->xfer_xrun is not set:

1. In sound/virtio/virtio_pcm_msg.c, in-flight non-empty RX completions
arriving in virtsnd_pcm_msg_complete() for a non-staged capture stream bypa=
ss
the early retirement check:

    if (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE &&
        (!vss->prepared || vss->xfer_xrun ||
         (vss->stopped && written_bytes <=3D sizeof(*msg->status)))) {

and continue copying data and advancing vss->hw_ptr and
vss->capture_copied_total after the failed ACK rolled back vss->pcm_indirect
and appl_ptr.

2. If the capture stream is in SNDRV_PCM_STATE_DRAINING, the stopped-plus-X=
RUN
admission check (if (vss->stopped && vss->xfer_xrun) return -EBADFD) in
virtsnd_pcm_cp_ack_locked() is not armed.

3. Any call to virtsnd_pcm_pb_pointer() or virtsnd_pcm_cp_pointer() before
teardown (such as across the stream lock drop when locking a linked group in
__snd_pcm_xrun()) does not see vss->xfer_xrun set, so it invokes
snd_pcm_indirect_playback_pointer() or snd_pcm_indirect_capture_pointer()
instead of returning SNDRV_PCM_POS_XRUN.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105070845.6449=
-1-mynameisjune111@gmail.com?part=3D10
