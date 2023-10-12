Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21BECDB482
	for <virtualization@archiver.kernel.org>; Thu, 12 Oct 2023 15:17:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 46BF941727;
	Thu, 12 Oct 2023 15:17:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 46BF941727
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PxA/id+l
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OwdQ9nxF1_S7; Thu, 12 Oct 2023 15:17:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E41214093B;
	Thu, 12 Oct 2023 15:17:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E41214093B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B45D7C0071;
	Thu, 12 Oct 2023 15:17:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FF09C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 15:17:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 14B9E4038B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 15:17:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 14B9E4038B
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PxA/id+l
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 160RUE7FNScn
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 15:17:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C6782400DC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 15:17:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C6782400DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697123822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N61O7dqOv5z704fPtB1xO3U6E0vm18ayN3uykalF+0E=;
 b=PxA/id+lmmjUxtjXBZ4+3sTCzrGUiOP1WRPvwDjN1Cs8QGC4jbjXoL57zTw6U8NPRWOt4k
 9L4ebmM2BVneVdCxrUFNcfpox7P58znwrBM6jyOk7f0Ish9C/oW4w6Rls/7itqMiGrSyN0
 sGaNApuezaNPwLK6f1B2+DUl0Ein3Wg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-3ociogMwOYqoOHnfJTfKPA-1; Thu, 12 Oct 2023 11:16:59 -0400
X-MC-Unique: 3ociogMwOYqoOHnfJTfKPA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4065ca278b3so7371685e9.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 08:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697123818; x=1697728618;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N61O7dqOv5z704fPtB1xO3U6E0vm18ayN3uykalF+0E=;
 b=VrHGBNtSeYgtsDMOL2J8igVjrsHa72aJLh7w2OPtxyGVzOPU6SCzg+em9T+Whl47fn
 wFBss6Qzheu6dLps7OWb2NOfqm/U5JkqwUffvJBiJhd7l+lHEvDZ84zpwS8hJcwDE65t
 2R0NikKV63bnKujjMPEQ1U5SkPCCFnwyI1aMGsuewsKxPM9rH8X1cUimtgMZQIysLFpr
 HWXrCF2G1R5UpZwgVv4b3LfYC7xr+LKEAqO+bR5WE0rmlamxZ+gEL3BaopXmx5uL3IlG
 xNuPSxR9v8INAsmpaki7LgsDopPS4UbpI0PEJJBu+xiXTrTyQ9t4vtZEJP7vDtPaM1c/
 fLfA==
X-Gm-Message-State: AOJu0Yx7PR0q4tSNkJy6ITCte0l1dGdvq38cl5ontGzYZA97tKpP3ano
 aobULQqF+hLuz56tO3LBmDmqOdHBendw1VHucXBup4Yr1790ZLhCbHQqibPZtHMPiSdNwD0MEks
 ae1rpnxZ41FpLYK55y9IzLndS4F7yVD1b7zBH5UtFeQ==
X-Received: by 2002:adf:ef8f:0:b0:31f:a718:4cb6 with SMTP id
 d15-20020adfef8f000000b0031fa7184cb6mr19319526wro.46.1697123818309; 
 Thu, 12 Oct 2023 08:16:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAFMy3JuuSbtpHzX18yLnNQpgdXSKnknNcM2R6XmpX/8dk97710VScPX4tGnGORP82f1D0NA==
X-Received: by 2002:adf:ef8f:0:b0:31f:a718:4cb6 with SMTP id
 d15-20020adfef8f000000b0031fa7184cb6mr19319482wro.46.1697123817569; 
 Thu, 12 Oct 2023 08:16:57 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 b5-20020a056000054500b00326dd5486dcsm18711740wrf.107.2023.10.12.08.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 08:16:56 -0700 (PDT)
Date: Thu, 12 Oct 2023 11:16:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Subject: Re: [RFC PATCH] ALSA: virtio: use copy and fill_silence callbacks
Message-ID: <20231012111525-mutt-send-email-mst@kernel.org>
References: <ZSgMeoMx6NX2zCx/@fedora>
MIME-Version: 1.0
In-Reply-To: <ZSgMeoMx6NX2zCx/@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: manos.pitsidianakis@linaro.org, alsa-devel@alsa-project.org,
 mripard@redhat.com, linux-kernel@vger.kernel.org, tiwai@suse.com,
 stefanha@redhat.com, perex@perex.cz, pbonzini@redhat.com,
 virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Oct 12, 2023 at 05:10:50PM +0200, Matias Ezequiel Vara Larsen wrote:
> This commit replaces the mmap mechanism with the copy() and
> fill_silence() callbacks for both capturing and playback for the
> virtio-sound driver. This change is required to prevent the updating of
> the content of a buffer that is already in the available ring.
> 
> The current mechanism splits a dma buffer into descriptors that are
> exposed to the device. This dma buffer is shared with the user
> application. When the device consumes a buffer, the driver moves the
> request from the used ring to available ring.
> 
> The driver exposes the buffer to the device without knowing if the
> content has been updated from the user. The section 2.8.21.1 of the
> virtio spec states that: "The device MAY access the descriptor chains
> the driver created and the memory they refer to immediately". If the
> device picks up buffers from the available ring just after it is
> notified, it happens that the content may be old.
> 
> By providing the copy() callback, the driver first updates the content
> of the buffer, and then, exposes the buffer to the device by enqueuing
> it in the available ring. Thus, device always picks up a buffer that is
> updated.
> 
> For capturing, the driver starts by exposing all the available buffers
> to device. After device updates the content of a buffer, it enqueues it
> in the used ring. It is only after the copy() for capturing is issued
> that the driver re-enqueues the buffer in the available ring.
> 
> Note that the copy() function assumes that user is always writing a
> period. Testing shows that this is true but I may be wrong. This RFC
> aims at clarifying this.
> 
> Signed-off-by: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>


Thank you for working on this!

> ---
>  sound/virtio/virtio_pcm.c     | 11 ++--
>  sound/virtio/virtio_pcm.h     |  9 +++-
>  sound/virtio/virtio_pcm_msg.c | 50 ++++++++++++++++---
>  sound/virtio/virtio_pcm_ops.c | 94 +++++++++++++++++++++++++++++++----
>  4 files changed, 137 insertions(+), 27 deletions(-)
> 
> diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
> index c10d91fff2fb..bfe982952303 100644
> --- a/sound/virtio/virtio_pcm.c
> +++ b/sound/virtio/virtio_pcm.c
> @@ -104,8 +104,6 @@ static int virtsnd_pcm_build_hw(struct virtio_pcm_substream *vss,
>  	 * only message-based transport.
>  	 */
>  	vss->hw.info =
> -		SNDRV_PCM_INFO_MMAP |
> -		SNDRV_PCM_INFO_MMAP_VALID |
>  		SNDRV_PCM_INFO_BATCH |
>  		SNDRV_PCM_INFO_BLOCK_TRANSFER |
>  		SNDRV_PCM_INFO_INTERLEAVED |
> @@ -471,12 +469,11 @@ int virtsnd_pcm_build_devs(struct virtio_snd *snd)
>  			for (kss = ks->substream; kss; kss = kss->next)
>  				vs->substreams[kss->number]->substream = kss;
>  
> -			snd_pcm_set_ops(vpcm->pcm, i, &virtsnd_pcm_ops);
> +			if (i == SNDRV_PCM_STREAM_CAPTURE)
> +				snd_pcm_set_ops(vpcm->pcm, i, &virtsnd_pcm_capture_ops);
> +			else
> +				snd_pcm_set_ops(vpcm->pcm, i, &virtsnd_pcm_playback_ops);
>  		}
> -
> -		snd_pcm_set_managed_buffer_all(vpcm->pcm,
> -					       SNDRV_DMA_TYPE_VMALLOC, NULL,
> -					       0, 0);
>  	}
>  
>  	return 0;
> diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
> index 062eb8e8f2cf..1c1106ec971f 100644
> --- a/sound/virtio/virtio_pcm.h
> +++ b/sound/virtio/virtio_pcm.h
> @@ -50,6 +50,8 @@ struct virtio_pcm_substream {
>  	struct work_struct elapsed_period;
>  	spinlock_t lock;
>  	size_t buffer_bytes;
> +	u8 *buffer;
> +	size_t buffer_sz;
>  	size_t hw_ptr;
>  	bool xfer_enabled;
>  	bool xfer_xrun;
> @@ -90,7 +92,8 @@ struct virtio_pcm {
>  	struct virtio_pcm_stream streams[SNDRV_PCM_STREAM_LAST + 1];
>  };
>  
> -extern const struct snd_pcm_ops virtsnd_pcm_ops;
> +extern const struct snd_pcm_ops virtsnd_pcm_playback_ops;
> +extern const struct snd_pcm_ops virtsnd_pcm_capture_ops;
>  
>  int virtsnd_pcm_validate(struct virtio_device *vdev);
>  
> @@ -117,7 +120,9 @@ int virtsnd_pcm_msg_alloc(struct virtio_pcm_substream *vss,
>  
>  void virtsnd_pcm_msg_free(struct virtio_pcm_substream *vss);
>  
> -int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss);
> +int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss, bool single);
> +
> +int virtsnd_pcm_msg_send_locked(struct virtio_pcm_substream *vss, bool single);
>  
>  unsigned int virtsnd_pcm_msg_pending_num(struct virtio_pcm_substream *vss);
>  
> diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
> index aca2dc1989ba..9a5f9814cb62 100644
> --- a/sound/virtio/virtio_pcm_msg.c
> +++ b/sound/virtio/virtio_pcm_msg.c
> @@ -132,7 +132,6 @@ static void virtsnd_pcm_sg_from(struct scatterlist *sgs, int nsgs, u8 *data,
>  int virtsnd_pcm_msg_alloc(struct virtio_pcm_substream *vss,
>  			  unsigned int periods, unsigned int period_bytes)
>  {
> -	struct snd_pcm_runtime *runtime = vss->substream->runtime;
>  	unsigned int i;
>  
>  	vss->msgs = kcalloc(periods, sizeof(*vss->msgs), GFP_KERNEL);
> @@ -142,7 +141,7 @@ int virtsnd_pcm_msg_alloc(struct virtio_pcm_substream *vss,
>  	vss->nmsgs = periods;
>  
>  	for (i = 0; i < periods; ++i) {
> -		u8 *data = runtime->dma_area + period_bytes * i;
> +		u8 *data = vss->buffer + period_bytes * i;
>  		int sg_num = virtsnd_pcm_sg_num(data, period_bytes);
>  		struct virtio_pcm_msg *msg;
>  
> @@ -186,10 +185,12 @@ void virtsnd_pcm_msg_free(struct virtio_pcm_substream *vss)
>  /**
>   * virtsnd_pcm_msg_send() - Send asynchronous I/O messages.
>   * @vss: VirtIO PCM substream.
> + * @single: true to enqueue a single message, false to enqueue all of them.
>   *
>   * All messages are organized in an ordered circular list. Each time the
> - * function is called, all currently non-enqueued messages are added to the
> - * virtqueue. For this, the function keeps track of two values:
> + * function is called, first non-enqueued message is added to the virtqueue.
> + * When single is True, only the first message is enqueued. When False, all the
> + * available messages are enqueued.  The function keeps track of two values:
>   *
>   *   msg_last_enqueued = index of the last enqueued message,
>   *   msg_count = # of pending messages in the virtqueue.
> @@ -198,7 +199,7 @@ void virtsnd_pcm_msg_free(struct virtio_pcm_substream *vss)
>   *          spinlocks to be held by caller.
>   * Return: 0 on success, -errno on failure.
>   */
> -int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss)
> +int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss, bool single)
>  {
>  	struct snd_pcm_runtime *runtime = vss->substream->runtime;
>  	struct virtio_snd *snd = vss->snd;
> @@ -211,6 +212,13 @@ int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss)
>  	i = (vss->msg_last_enqueued + 1) % runtime->periods;
>  	n = runtime->periods - vss->msg_count;
>  
> +	if (single) {
> +		if (n < 1)
> +			return -EFAULT;
> +
> +		n = 1;
> +	}
> +
>  	for (; n; --n, i = (i + 1) % runtime->periods) {
>  		struct virtio_pcm_msg *msg = vss->msgs[i];
>  		struct scatterlist *psgs[] = {
> @@ -250,6 +258,36 @@ int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss)
>  	return 0;
>  }
>  
> +/**
> + * virtsnd_pcm_msg_send_locked() - Send asynchronous I/O messages.
> + * @vss: VirtIO PCM substream.
> + * @single: true to enqueue a single message, false to enqueue all of them.
> + *
> + * This function holds the tx/rx queue and the VirtIO substream spinlocks
> + * before calling virtsnd_pcm_msg_send(). This is a wrapper function to ease
> + * the invocation of virtsnd_pcm_msg_send().
> + *
> + * Context: Any context.
> + * Return: 0 on success, -errno on failure.
> + */
> +
> +int virtsnd_pcm_msg_send_locked(struct virtio_pcm_substream *vss, bool single)
> +{
> +	struct virtio_snd_queue *queue;
> +	int rc;
> +	unsigned long flags;
> +
> +	queue = virtsnd_pcm_queue(vss);
> +
> +	spin_lock_irqsave(&queue->lock, flags);
> +	spin_lock(&vss->lock);
> +	rc = virtsnd_pcm_msg_send(vss, single);
> +	spin_unlock(&vss->lock);
> +	spin_unlock_irqrestore(&queue->lock, flags);
> +
> +	return rc;
> +}
> +
>  /**
>   * virtsnd_pcm_msg_pending_num() - Returns the number of pending I/O messages.
>   * @vss: VirtIO substream.
> @@ -320,8 +358,6 @@ static void virtsnd_pcm_msg_complete(struct virtio_pcm_msg *msg,
>  					le32_to_cpu(msg->status.latency_bytes));
>  
>  		schedule_work(&vss->elapsed_period);
> -
> -		virtsnd_pcm_msg_send(vss);
>  	} else if (!vss->msg_count) {
>  		wake_up_all(&vss->msg_empty);
>  	}
> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index f8bfb87624be..a208439dbff8 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c
> @@ -238,6 +238,11 @@ static int virtsnd_pcm_hw_params(struct snd_pcm_substream *substream,
>  	 */
>  	virtsnd_pcm_msg_free(vss);
>  
> +	vss->buffer_sz = params_buffer_bytes(hw_params);
> +	vss->buffer = alloc_pages_exact(vss->buffer_sz, GFP_KERNEL);
> +	if (!vss->buffer)
> +		return -ENOMEM;
> +
>  	return virtsnd_pcm_msg_alloc(vss, params_periods(hw_params),
>  				     params_period_bytes(hw_params));
>  }
> @@ -257,6 +262,11 @@ static int virtsnd_pcm_hw_free(struct snd_pcm_substream *substream)
>  	if (!virtsnd_pcm_msg_pending_num(vss))
>  		virtsnd_pcm_msg_free(vss);
>  
> +	if (vss->buffer) {
> +		free_pages_exact(vss->buffer, vss->buffer_sz);
> +		vss->buffer = NULL;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -331,15 +341,18 @@ static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream, int command)
>  	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>  		queue = virtsnd_pcm_queue(vss);
>  
> -		spin_lock_irqsave(&queue->lock, flags);
> -		spin_lock(&vss->lock);
> -		rc = virtsnd_pcm_msg_send(vss);
> -		if (!rc)
> -			vss->xfer_enabled = true;
> -		spin_unlock(&vss->lock);
> -		spin_unlock_irqrestore(&queue->lock, flags);
> -		if (rc)
> -			return rc;
> +		// The buffers should be exposed first during capturing so that
> +		// the device can consume them. Capturing cannot begin
> +		// otherwise.
> +		if (vss->direction == SNDRV_PCM_STREAM_CAPTURE) {
> +			rc = virtsnd_pcm_msg_send_locked(vss, false);
> +			if (rc)
> +				return rc;
> +		}
> +
> +		spin_lock_irqsave(&vss->lock, flags);
> +		vss->xfer_enabled = true;
> +		spin_unlock_irqrestore(&vss->lock, flags);
>  
>  		msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_START,
>  						GFP_KERNEL);
> @@ -450,8 +463,66 @@ virtsnd_pcm_pointer(struct snd_pcm_substream *substream)
>  	return hw_ptr;
>  }
>  
> -/* PCM substream operators map. */
> -const struct snd_pcm_ops virtsnd_pcm_ops = {
> +static int virtsnd_pcm_pb_copy(struct snd_pcm_substream *substream,
> +			       int channel, unsigned long pos, struct iov_iter
> +			       *src, unsigned long count)
> +{
> +	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
> +
> +	if (unlikely(pos + count > vss->buffer_sz))
> +		return -EINVAL;
> +
> +	if (copy_from_iter(vss->buffer + pos, count, src) != count)
> +		return -EFAULT;
> +
> +	return virtsnd_pcm_msg_send_locked(vss, true);
> +}
> +
> +static int virtsnd_pcm_cap_copy(struct snd_pcm_substream *substream,
> +				int channel, unsigned long pos, struct iov_iter
> +				*dst, unsigned long count)
> +{
> +	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
> +
> +	if (unlikely(pos + count > vss->buffer_sz))
> +		return -EINVAL;
> +
> +	if (copy_to_iter(vss->buffer + pos, count, dst) != count)
> +		return -EFAULT;
> +
> +	return virtsnd_pcm_msg_send_locked(vss, true);
> +}
> +
> +static int virtsnd_pcm_pb_silence(struct snd_pcm_substream *substream, int channel,
> +				  unsigned long pos, unsigned long count)
> +{
> +	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
> +
> +	if (unlikely(pos + count > vss->buffer_sz))
> +		return -EINVAL;
> +
> +	memset(vss->buffer + pos, 0, count);
> +
> +	return virtsnd_pcm_msg_send_locked(vss, true);
> +}
> +
> +/* PCM substream operators map for playback. */
> +const struct snd_pcm_ops virtsnd_pcm_playback_ops = {
> +	.open = virtsnd_pcm_open,
> +	.close = virtsnd_pcm_close,
> +	.ioctl = snd_pcm_lib_ioctl,
> +	.hw_params = virtsnd_pcm_hw_params,
> +	.hw_free = virtsnd_pcm_hw_free,
> +	.prepare = virtsnd_pcm_prepare,
> +	.trigger = virtsnd_pcm_trigger,
> +	.sync_stop = virtsnd_pcm_sync_stop,
> +	.pointer = virtsnd_pcm_pointer,
> +	.copy = virtsnd_pcm_pb_copy,
> +	.fill_silence = virtsnd_pcm_pb_silence,
> +};
> +
> +/* PCM substream operators map for capturing. */
> +const struct snd_pcm_ops virtsnd_pcm_capture_ops = {
>  	.open = virtsnd_pcm_open,
>  	.close = virtsnd_pcm_close,
>  	.ioctl = snd_pcm_lib_ioctl,
> @@ -461,4 +532,5 @@ const struct snd_pcm_ops virtsnd_pcm_ops = {
>  	.trigger = virtsnd_pcm_trigger,
>  	.sync_stop = virtsnd_pcm_sync_stop,
>  	.pointer = virtsnd_pcm_pointer,
> +	.copy = virtsnd_pcm_cap_copy,
>  };
> 
> base-commit: 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa
> -- 
> 2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
