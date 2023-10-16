Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D62CDB465
	for <virtualization@archiver.kernel.org>; Mon, 16 Oct 2023 15:10:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BBD7340A06;
	Mon, 16 Oct 2023 15:10:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BBD7340A06
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HOPYqSEN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T-vgWYUPsrjw; Mon, 16 Oct 2023 15:10:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1579740108;
	Mon, 16 Oct 2023 15:10:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1579740108
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D48C8C0039;
	Mon, 16 Oct 2023 15:10:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35DCDC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 15:10:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F2C4D81097
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 15:10:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F2C4D81097
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HOPYqSEN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RT7cYDvQt8L2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 15:10:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6DAD881076
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 15:10:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6DAD881076
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697469007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WTW0Rivv2CDIEeQzaLmCKM27EeQ8yJt+yTxxIuYzeAI=;
 b=HOPYqSENE7pOoxvUGizHwhX2zq+53FfiKzHzGqC8LLt/4fC/cx1/YMoOdDAVUqIPvhH1u2
 JMko9dX/sLY3S8hiCPPn2HtpWRzCv/C2tCMRQ6ao7lG/vt1LG6qp1gtg94hp4xm3eri0xR
 m9XG2ZGBLrUTNFWN5r2H12l/9k4muYU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-0wo0sAQFPrK79Tqz-173vA-1; Mon, 16 Oct 2023 11:10:03 -0400
X-MC-Unique: 0wo0sAQFPrK79Tqz-173vA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC1F9185A7B9;
 Mon, 16 Oct 2023 15:10:02 +0000 (UTC)
Received: from localhost (unknown [10.39.195.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E095B63F45;
 Mon, 16 Oct 2023 15:10:01 +0000 (UTC)
Date: Mon, 16 Oct 2023 11:10:00 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [RFC PATCH] ALSA: virtio: use copy and fill_silence callbacks
Message-ID: <20231016151000.GE119987@fedora>
References: <ZSgMeoMx6NX2zCx/@fedora>
MIME-Version: 1.0
In-Reply-To: <ZSgMeoMx6NX2zCx/@fedora>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Cc: alsa-devel@alsa-project.org, mripard@redhat.com, mst@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 pbonzini@redhat.com
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
Content-Type: multipart/mixed; boundary="===============3183575302044078470=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============3183575302044078470==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2bIKyQX3Vt+C2epg"
Content-Disposition: inline


--2bIKyQX3Vt+C2epg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 05:10:50PM +0200, Matias Ezequiel Vara Larsen wrote:
> This commit replaces the mmap mechanism with the copy() and
> fill_silence() callbacks for both capturing and playback for the
> virtio-sound driver. This change is required to prevent the updating of
> the content of a buffer that is already in the available ring.
>=20
> The current mechanism splits a dma buffer into descriptors that are
> exposed to the device. This dma buffer is shared with the user
> application. When the device consumes a buffer, the driver moves the
> request from the used ring to available ring.
>=20
> The driver exposes the buffer to the device without knowing if the
> content has been updated from the user. The section 2.8.21.1 of the
> virtio spec states that: "The device MAY access the descriptor chains
> the driver created and the memory they refer to immediately". If the
> device picks up buffers from the available ring just after it is
> notified, it happens that the content may be old.
>=20
> By providing the copy() callback, the driver first updates the content
> of the buffer, and then, exposes the buffer to the device by enqueuing
> it in the available ring. Thus, device always picks up a buffer that is
> updated.
>=20
> For capturing, the driver starts by exposing all the available buffers
> to device. After device updates the content of a buffer, it enqueues it
> in the used ring. It is only after the copy() for capturing is issued
> that the driver re-enqueues the buffer in the available ring.
>=20
> Note that the copy() function assumes that user is always writing a
> period. Testing shows that this is true but I may be wrong. This RFC
> aims at clarifying this.

This sounds like an ALSA driver API question.

Jaroslav and Takashi: Any thoughts?

Stefan

>=20
> Signed-off-by: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
> ---
>  sound/virtio/virtio_pcm.c     | 11 ++--
>  sound/virtio/virtio_pcm.h     |  9 +++-
>  sound/virtio/virtio_pcm_msg.c | 50 ++++++++++++++++---
>  sound/virtio/virtio_pcm_ops.c | 94 +++++++++++++++++++++++++++++++----
>  4 files changed, 137 insertions(+), 27 deletions(-)
>=20
> diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
> index c10d91fff2fb..bfe982952303 100644
> --- a/sound/virtio/virtio_pcm.c
> +++ b/sound/virtio/virtio_pcm.c
> @@ -104,8 +104,6 @@ static int virtsnd_pcm_build_hw(struct virtio_pcm_sub=
stream *vss,
>  	 * only message-based transport.
>  	 */
>  	vss->hw.info =3D
> -		SNDRV_PCM_INFO_MMAP |
> -		SNDRV_PCM_INFO_MMAP_VALID |
>  		SNDRV_PCM_INFO_BATCH |
>  		SNDRV_PCM_INFO_BLOCK_TRANSFER |
>  		SNDRV_PCM_INFO_INTERLEAVED |
> @@ -471,12 +469,11 @@ int virtsnd_pcm_build_devs(struct virtio_snd *snd)
>  			for (kss =3D ks->substream; kss; kss =3D kss->next)
>  				vs->substreams[kss->number]->substream =3D kss;
> =20
> -			snd_pcm_set_ops(vpcm->pcm, i, &virtsnd_pcm_ops);
> +			if (i =3D=3D SNDRV_PCM_STREAM_CAPTURE)
> +				snd_pcm_set_ops(vpcm->pcm, i, &virtsnd_pcm_capture_ops);
> +			else
> +				snd_pcm_set_ops(vpcm->pcm, i, &virtsnd_pcm_playback_ops);
>  		}
> -
> -		snd_pcm_set_managed_buffer_all(vpcm->pcm,
> -					       SNDRV_DMA_TYPE_VMALLOC, NULL,
> -					       0, 0);
>  	}
> =20
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
> =20
> -extern const struct snd_pcm_ops virtsnd_pcm_ops;
> +extern const struct snd_pcm_ops virtsnd_pcm_playback_ops;
> +extern const struct snd_pcm_ops virtsnd_pcm_capture_ops;
> =20
>  int virtsnd_pcm_validate(struct virtio_device *vdev);
> =20
> @@ -117,7 +120,9 @@ int virtsnd_pcm_msg_alloc(struct virtio_pcm_substream=
 *vss,
> =20
>  void virtsnd_pcm_msg_free(struct virtio_pcm_substream *vss);
> =20
> -int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss);
> +int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss, bool single);
> +
> +int virtsnd_pcm_msg_send_locked(struct virtio_pcm_substream *vss, bool s=
ingle);
> =20
>  unsigned int virtsnd_pcm_msg_pending_num(struct virtio_pcm_substream *vs=
s);
> =20
> diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
> index aca2dc1989ba..9a5f9814cb62 100644
> --- a/sound/virtio/virtio_pcm_msg.c
> +++ b/sound/virtio/virtio_pcm_msg.c
> @@ -132,7 +132,6 @@ static void virtsnd_pcm_sg_from(struct scatterlist *s=
gs, int nsgs, u8 *data,
>  int virtsnd_pcm_msg_alloc(struct virtio_pcm_substream *vss,
>  			  unsigned int periods, unsigned int period_bytes)
>  {
> -	struct snd_pcm_runtime *runtime =3D vss->substream->runtime;
>  	unsigned int i;
> =20
>  	vss->msgs =3D kcalloc(periods, sizeof(*vss->msgs), GFP_KERNEL);
> @@ -142,7 +141,7 @@ int virtsnd_pcm_msg_alloc(struct virtio_pcm_substream=
 *vss,
>  	vss->nmsgs =3D periods;
> =20
>  	for (i =3D 0; i < periods; ++i) {
> -		u8 *data =3D runtime->dma_area + period_bytes * i;
> +		u8 *data =3D vss->buffer + period_bytes * i;
>  		int sg_num =3D virtsnd_pcm_sg_num(data, period_bytes);
>  		struct virtio_pcm_msg *msg;
> =20
> @@ -186,10 +185,12 @@ void virtsnd_pcm_msg_free(struct virtio_pcm_substre=
am *vss)
>  /**
>   * virtsnd_pcm_msg_send() - Send asynchronous I/O messages.
>   * @vss: VirtIO PCM substream.
> + * @single: true to enqueue a single message, false to enqueue all of th=
em.
>   *
>   * All messages are organized in an ordered circular list. Each time the
> - * function is called, all currently non-enqueued messages are added to =
the
> - * virtqueue. For this, the function keeps track of two values:
> + * function is called, first non-enqueued message is added to the virtqu=
eue.
> + * When single is True, only the first message is enqueued. When False, =
all the
> + * available messages are enqueued.  The function keeps track of two val=
ues:
>   *
>   *   msg_last_enqueued =3D index of the last enqueued message,
>   *   msg_count =3D # of pending messages in the virtqueue.
> @@ -198,7 +199,7 @@ void virtsnd_pcm_msg_free(struct virtio_pcm_substream=
 *vss)
>   *          spinlocks to be held by caller.
>   * Return: 0 on success, -errno on failure.
>   */
> -int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss)
> +int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss, bool single)
>  {
>  	struct snd_pcm_runtime *runtime =3D vss->substream->runtime;
>  	struct virtio_snd *snd =3D vss->snd;
> @@ -211,6 +212,13 @@ int virtsnd_pcm_msg_send(struct virtio_pcm_substream=
 *vss)
>  	i =3D (vss->msg_last_enqueued + 1) % runtime->periods;
>  	n =3D runtime->periods - vss->msg_count;
> =20
> +	if (single) {
> +		if (n < 1)
> +			return -EFAULT;
> +
> +		n =3D 1;
> +	}
> +
>  	for (; n; --n, i =3D (i + 1) % runtime->periods) {
>  		struct virtio_pcm_msg *msg =3D vss->msgs[i];
>  		struct scatterlist *psgs[] =3D {
> @@ -250,6 +258,36 @@ int virtsnd_pcm_msg_send(struct virtio_pcm_substream=
 *vss)
>  	return 0;
>  }
> =20
> +/**
> + * virtsnd_pcm_msg_send_locked() - Send asynchronous I/O messages.
> + * @vss: VirtIO PCM substream.
> + * @single: true to enqueue a single message, false to enqueue all of th=
em.
> + *
> + * This function holds the tx/rx queue and the VirtIO substream spinlocks
> + * before calling virtsnd_pcm_msg_send(). This is a wrapper function to =
ease
> + * the invocation of virtsnd_pcm_msg_send().
> + *
> + * Context: Any context.
> + * Return: 0 on success, -errno on failure.
> + */
> +
> +int virtsnd_pcm_msg_send_locked(struct virtio_pcm_substream *vss, bool s=
ingle)
> +{
> +	struct virtio_snd_queue *queue;
> +	int rc;
> +	unsigned long flags;
> +
> +	queue =3D virtsnd_pcm_queue(vss);
> +
> +	spin_lock_irqsave(&queue->lock, flags);
> +	spin_lock(&vss->lock);
> +	rc =3D virtsnd_pcm_msg_send(vss, single);
> +	spin_unlock(&vss->lock);
> +	spin_unlock_irqrestore(&queue->lock, flags);
> +
> +	return rc;
> +}
> +
>  /**
>   * virtsnd_pcm_msg_pending_num() - Returns the number of pending I/O mes=
sages.
>   * @vss: VirtIO substream.
> @@ -320,8 +358,6 @@ static void virtsnd_pcm_msg_complete(struct virtio_pc=
m_msg *msg,
>  					le32_to_cpu(msg->status.latency_bytes));
> =20
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
> @@ -238,6 +238,11 @@ static int virtsnd_pcm_hw_params(struct snd_pcm_subs=
tream *substream,
>  	 */
>  	virtsnd_pcm_msg_free(vss);
> =20
> +	vss->buffer_sz =3D params_buffer_bytes(hw_params);
> +	vss->buffer =3D alloc_pages_exact(vss->buffer_sz, GFP_KERNEL);
> +	if (!vss->buffer)
> +		return -ENOMEM;
> +
>  	return virtsnd_pcm_msg_alloc(vss, params_periods(hw_params),
>  				     params_period_bytes(hw_params));
>  }
> @@ -257,6 +262,11 @@ static int virtsnd_pcm_hw_free(struct snd_pcm_substr=
eam *substream)
>  	if (!virtsnd_pcm_msg_pending_num(vss))
>  		virtsnd_pcm_msg_free(vss);
> =20
> +	if (vss->buffer) {
> +		free_pages_exact(vss->buffer, vss->buffer_sz);
> +		vss->buffer =3D NULL;
> +	}
> +
>  	return 0;
>  }
> =20
> @@ -331,15 +341,18 @@ static int virtsnd_pcm_trigger(struct snd_pcm_subst=
ream *substream, int command)
>  	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>  		queue =3D virtsnd_pcm_queue(vss);
> =20
> -		spin_lock_irqsave(&queue->lock, flags);
> -		spin_lock(&vss->lock);
> -		rc =3D virtsnd_pcm_msg_send(vss);
> -		if (!rc)
> -			vss->xfer_enabled =3D true;
> -		spin_unlock(&vss->lock);
> -		spin_unlock_irqrestore(&queue->lock, flags);
> -		if (rc)
> -			return rc;
> +		// The buffers should be exposed first during capturing so that
> +		// the device can consume them. Capturing cannot begin
> +		// otherwise.
> +		if (vss->direction =3D=3D SNDRV_PCM_STREAM_CAPTURE) {
> +			rc =3D virtsnd_pcm_msg_send_locked(vss, false);
> +			if (rc)
> +				return rc;
> +		}
> +
> +		spin_lock_irqsave(&vss->lock, flags);
> +		vss->xfer_enabled =3D true;
> +		spin_unlock_irqrestore(&vss->lock, flags);
> =20
>  		msg =3D virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_START,
>  						GFP_KERNEL);
> @@ -450,8 +463,66 @@ virtsnd_pcm_pointer(struct snd_pcm_substream *substr=
eam)
>  	return hw_ptr;
>  }
> =20
> -/* PCM substream operators map. */
> -const struct snd_pcm_ops virtsnd_pcm_ops =3D {
> +static int virtsnd_pcm_pb_copy(struct snd_pcm_substream *substream,
> +			       int channel, unsigned long pos, struct iov_iter
> +			       *src, unsigned long count)
> +{
> +	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
> +
> +	if (unlikely(pos + count > vss->buffer_sz))
> +		return -EINVAL;
> +
> +	if (copy_from_iter(vss->buffer + pos, count, src) !=3D count)
> +		return -EFAULT;
> +
> +	return virtsnd_pcm_msg_send_locked(vss, true);
> +}
> +
> +static int virtsnd_pcm_cap_copy(struct snd_pcm_substream *substream,
> +				int channel, unsigned long pos, struct iov_iter
> +				*dst, unsigned long count)
> +{
> +	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
> +
> +	if (unlikely(pos + count > vss->buffer_sz))
> +		return -EINVAL;
> +
> +	if (copy_to_iter(vss->buffer + pos, count, dst) !=3D count)
> +		return -EFAULT;
> +
> +	return virtsnd_pcm_msg_send_locked(vss, true);
> +}
> +
> +static int virtsnd_pcm_pb_silence(struct snd_pcm_substream *substream, i=
nt channel,
> +				  unsigned long pos, unsigned long count)
> +{
> +	struct virtio_pcm_substream *vss =3D snd_pcm_substream_chip(substream);
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
> +const struct snd_pcm_ops virtsnd_pcm_playback_ops =3D {
> +	.open =3D virtsnd_pcm_open,
> +	.close =3D virtsnd_pcm_close,
> +	.ioctl =3D snd_pcm_lib_ioctl,
> +	.hw_params =3D virtsnd_pcm_hw_params,
> +	.hw_free =3D virtsnd_pcm_hw_free,
> +	.prepare =3D virtsnd_pcm_prepare,
> +	.trigger =3D virtsnd_pcm_trigger,
> +	.sync_stop =3D virtsnd_pcm_sync_stop,
> +	.pointer =3D virtsnd_pcm_pointer,
> +	.copy =3D virtsnd_pcm_pb_copy,
> +	.fill_silence =3D virtsnd_pcm_pb_silence,
> +};
> +
> +/* PCM substream operators map for capturing. */
> +const struct snd_pcm_ops virtsnd_pcm_capture_ops =3D {
>  	.open =3D virtsnd_pcm_open,
>  	.close =3D virtsnd_pcm_close,
>  	.ioctl =3D snd_pcm_lib_ioctl,
> @@ -461,4 +532,5 @@ const struct snd_pcm_ops virtsnd_pcm_ops =3D {
>  	.trigger =3D virtsnd_pcm_trigger,
>  	.sync_stop =3D virtsnd_pcm_sync_stop,
>  	.pointer =3D virtsnd_pcm_pointer,
> +	.copy =3D virtsnd_pcm_cap_copy,
>  };
>=20
> base-commit: 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa
> --=20
> 2.41.0
>=20

--2bIKyQX3Vt+C2epg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUtUkgACgkQnKSrs4Gr
c8h2MggAmu4aWu/BxOEggrXE29NyIVj/q1baCcKeGZ4dJceL5iQqH1XP9Ous2adH
ewJYeAJ57MvB50OahXwIOTV4iKgVvL+s28jbxRaZo6AQYQu6zpM4Q6e1O0iey1YO
F9ID3WOWLKlr6amDK1l6Pnr6QrdPhCvyJZ0UpBa5jxAOH3qVJ2FWbX26eIXHPjRW
7jFFqJo9o4hpQ/RDlf87k3CSogRqAstOma39FlQPiPPP7Xwx90Eu7RcyURMRhAGd
RGb7RYaPCw/PpOQd24mHo/ZLI5ChkRKaeuMLVMFsWxGGi7NObSAkpA0BDA4Fo4WK
0gP2/IEgW/cRSOY6j2qW9lzTsXcS4Q==
=Sm0W
-----END PGP SIGNATURE-----

--2bIKyQX3Vt+C2epg--


--===============3183575302044078470==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3183575302044078470==--

