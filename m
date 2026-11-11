Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794369657;
	b=zgQxn2IB5Peb+6OWGeDEX2q1/etOuLD/C0hI7rPkyYkQPBORfJc2z/+V1a2kILTdm/Qw
	 ulkSv8zcuxqnl/rlQ39tQ2dOE8qJNriqJinEmkd7maXf7hAEHkx1zPsZsuq8aE8m8jrCu
	 054x6t2VjUeTAHgeGAJzg0vZpXW4llDSjVDxJ4CBBM+wxNA6+H8m9yrYtfXb+SlXPCwLg
	 EM4zTmSeQzRFDgfZStyn6sBVmpe096U+SxL2N0KTgmOn9V/NotKE9fSIuobJP+Ml3WzrY
	 chQZX+zLz3bCis6412tkmrvstfFPOsecZqUIY9iuzQBavYxgv7RgjUbgSHqwr6tAjOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794369657;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=K9ldJI6Sc3140zxVlPO/JQPZGBufuU0MVqGHMP2kssE=;
	b=Y4v8laPgUNN4FTeP0KiPT2oa1fD5Qym8eZZt6rlo06P+Zf63oSK5PqvEYqdLOokH+H9o
	 OitrHQKb5CWzWUi577Q6kp2nq1O3pUKhL+aPQZNomldEEkIA2eYgj4PZwB65DafJXcDf8
	 Pe8/nrulnhzJpd84mfRm55uxZQtOyxgvBusDcKESamPUZ8Vgsg/NlNpqGs+OT+s1W0kpz
	 5ny9rcMWgTefwDtlk4Z4LJiGZ4Eo4xU5z6iO7xsvbzsxB7015esqlOUDkkJLYQlQP6Wt/
	 XB/6STMeeQhSFmglnOdHucZVLQtoDW7fTsezyAxwWKYPvRZcV49ca9/6gsMvYU5yTXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="iQw/60W2";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505EC606A324;
	Wed, 11 Nov 2026 04:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iQw/60W2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35AA1F0089F;
	Wed, 11 Nov 2026 04:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794369656;
	bh=K9ldJI6Sc3140zxVlPO/JQPZGBufuU0MVqGHMP2kssE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iQw/60W2zh/NXGngHPpikbsji4fqt4IlowstSTCXZ4IuRE/fXBpksiO41qx1y4nBe
	 +EqlYFf7O+zA24WwqGHZc5Oxa6BnnJ7CzIjRDvMrKY62h2+PqJJo/lzp3aRJhwzrGd
	 1le0pHurTY3J38/fu0fziFB3ptbSbN+aUmIxsjoeTEhWMwBS5UYtKAxwcm5F5Cl6QL
	 CdcDvw4mexubnXyvWMeHAtyzx9hdVE+0qt046LsUyVbBcD6OEiTHUx+/p1Gz1UKRVH
	 wIyHg1OPYbmtPF7mxRE1k6ak2tzPqV4o+CNAX3T1GgxaINVU5YOg0NkQc0Sz94MxDN
	 CWtcQqz1QFj9A==
Message-ID: <sashiko-outbox-208251@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v25 04/16] ALSA: pcm: notify drivers after linked
 prepare completes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261111025655.63951-5-mynameisjune111@gmail.com>
References: <20261111025655.63951-1-mynameisjune111@gmail.com>
 <20261111025655.63951-5-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 04:00:56 +0000
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
- [Medium] ALSA: pcm: state desync on opted-in streams in
  snd_pcm_finish_prepare()
--

commit a91218e64a7e783b333a467d7102781bb84f7f64
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: pcm: notify drivers after linked prepare completes

This commit adds an optional prepare_complete callback to snd_pcm_ops and
defers publishing SNDRV_PCM_STATE_PREPARED until all linked prepare and
reset actions finish under the stream locks.

> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index a547ac720b518..f98eb3329f2de 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
[ ... ]
> @@ -2089,20 +2113,108 @@ static int snd_pcm_do_prepare(struct snd_pcm_sub=
stream *substream,
>  	return snd_pcm_reset_substream(substream, true);
>  }
> =20
> -static void snd_pcm_post_prepare(struct snd_pcm_substream *substream,
> -				 snd_pcm_state_t state)
> +static int snd_pcm_finish_prepare(struct snd_pcm_substream *substream,
> +				  snd_pcm_state_t state, bool success,
> +				  struct snd_pcm_substream *failed_substream,
> +				  bool stream_lock)
>  {
[ ... ]
> +	/* Preserve terminal states instead of publishing a partial group commi=
t. */
> +	snd_pcm_group_for_each_entry(s, substream) {
> +		struct snd_pcm_runtime *runtime =3D s->runtime;
> +
> +		if (runtime->state =3D=3D SNDRV_PCM_STATE_DISCONNECTED) {
> +			cancel =3D true;
> +			cancel_err =3D -EBADFD;
> +		} else if (runtime->state =3D=3D SNDRV_PCM_STATE_SUSPENDED) {
> +			cancel =3D true;
> +			if (!cancel_err)
> +				cancel_err =3D -ESTRPIPE;
> +		}
> +		if (!success && s =3D=3D failed_substream)
> +			break;
> +	}
> +
> +	if (success && !cancel) {
> +		snd_pcm_group_for_each_entry(s, substream) {
> +			struct snd_pcm_runtime *runtime =3D s->runtime;
> +
> +			/* The reset callback path already completed this rebase. */
> +			if (!s->ops->reset)
> +				runtime->control->appl_ptr =3D runtime->status->hw_ptr;
> +			__snd_pcm_set_state(runtime, SNDRV_PCM_STATE_PREPARED);
> +		}
> +	} else if (!success && !cancel) {
> +		snd_pcm_group_for_each_entry(s, substream) {
> +			struct snd_pcm_runtime *runtime =3D s->runtime;
> +
> +			if (s->ops->prepare_complete &&
> +			    runtime->state !=3D SNDRV_PCM_STATE_SETUP)
> +				__snd_pcm_set_state(runtime, SNDRV_PCM_STATE_SETUP);
> +			if (s =3D=3D failed_substream)
> +				break;
> +		}
> +	}
> +
> +	if (!success || cancel) {
> +		snd_pcm_group_for_each_entry(s, substream) {
> +			wake_up(&s->runtime->sleep);
> +			wake_up(&s->runtime->tsleep);
> +			if (!success && s =3D=3D failed_substream)
> +				break;
> +		}
> +	}
> +
> +	/* Publish all states before any driver observes completion. */
> +	snd_pcm_group_for_each_entry(s, substream) {
> +		if (s->ops->prepare_complete)
> +			s->ops->prepare_complete(s, success && !cancel);
> +		if (!success && s =3D=3D failed_substream)
> +			break;
> +	}

[Severity: Medium]
Can gating the SNDRV_PCM_STATE_SETUP rollback on !cancel leave healthy
opted-in streams in SNDRV_PCM_STATE_PREPARED after calling
prepare_complete(s, false)?

When a linked group is re-prepared from SNDRV_PCM_STATE_PREPARED and one
member's PCM device disconnects during snd_pcm_do_prepare(),
snd_pcm_dev_disconnect() marks only that device's substreams as
SNDRV_PCM_STATE_DISCONNECTED because the streams are not running.
snd_pcm_finish_prepare() then sets cancel =3D true, skips resetting the oth=
er
opted-in members to SNDRV_PCM_STATE_SETUP, and still calls
s->ops->prepare_complete(s, false) on them.

That revokes driver preparation while runtime->state (or
runtime->suspended_state if the stream was suspended during
snd_pcm_do_prepare()) remains SNDRV_PCM_STATE_PREPARED in the ALSA core,
so once the disconnected sibling is unlinked or closed, later START or ACK
calls pass core state checks and fail in the driver.  Should each opted-in
member in the affected group or prefix that is not itself DISCONNECTED or
SUSPENDED be reset to SNDRV_PCM_STATE_SETUP whenever !success || cancel
(and have runtime->suspended_state updated to SNDRV_PCM_STATE_SETUP if
suspended)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111025655.6395=
1-1-mynameisjune111@gmail.com?part=3D4
