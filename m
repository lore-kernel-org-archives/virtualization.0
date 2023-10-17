Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26EFACDB474
	for <virtualization@archiver.kernel.org>; Tue, 17 Oct 2023 12:54:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 877E340ABE;
	Tue, 17 Oct 2023 12:54:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 877E340ABE
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AK+1A5AS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fsWN5e_DJgAZ; Tue, 17 Oct 2023 12:54:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A52FB404B9;
	Tue, 17 Oct 2023 12:54:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A52FB404B9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77BD4C0071;
	Tue, 17 Oct 2023 12:54:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B519C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 12:54:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D83C660881
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 12:54:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D83C660881
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AK+1A5AS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IhYnBOKWP3Tw
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 12:54:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F3766607B0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 12:54:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F3766607B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697547278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mtqwwDHfSuV/Aup0aKWVCqv6MVXTO35tSDkNuMWMyuc=;
 b=AK+1A5AS5Mb7HPKMxzYs1MwfSYovrzUmXqBmDAMfRp1piEjhMElvK/fDnpzOYCw/xfFIB7
 v8+SQacVUAdoQRWBEggxupYIxiH1Os8xgkctvgHVjWW6TZZVcT74yaheibwOetRXDoD6AH
 UNpMsMtBmlGfecjCotA+Ez/83QXcPPk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-HGydOeAWOqCyvMnl6tNXMA-1; Tue, 17 Oct 2023 08:54:36 -0400
X-MC-Unique: HGydOeAWOqCyvMnl6tNXMA-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7788ce62d50so32483085a.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 05:54:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697547274; x=1698152074;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mtqwwDHfSuV/Aup0aKWVCqv6MVXTO35tSDkNuMWMyuc=;
 b=dXVWnXt5Hl/59CV0tFbtHwRPZtkRt9lhBiyo16MEtZNKA7eZ/PQo2wG3fXuRiisaQB
 uBs/CCd31eMKBptnYK63KjDr5Lq/yv3nGYTGGS+sBJr8AJV7BbqD6J4XzHICKa/+B/Q+
 FNYPu9Bz6ld5AOL9VTg7FCzwV6E8xFOSEZG0XgXjOaojgYHY1ZSGqMqY4XLu4yUkR4P7
 9GQhQUsdy0IyzlAjE17lgvRtrNX6AvKCaQHdQvQsRzSKGh3Aa3tHbTvGlIQgO4NnNlqR
 HD8pIOJ+n8Lo3k8zWduTVQULwLGNiUKYJl1DIqtbpjwiqgcPHz5EdcKRBSbk/scn5+tU
 6GUA==
X-Gm-Message-State: AOJu0YxliBNHd0OrzCKLuLx7rT9BU3hKovdKftkLs5VwM11Y7qObER6+
 ebnh/ELEwh8peGmtQhRmJsIx65mELkIJU4sLY8NSM9/E+Z8R5+eRfEgsk6cLYyLL0FMnHHhVNW/
 VTt3Ut9jQzc/tC0fMzkiJUf6Q4aLsm2ovNPrCzaUkfQ==
X-Received: by 2002:a05:620a:2944:b0:76d:aa23:f8e1 with SMTP id
 n4-20020a05620a294400b0076daa23f8e1mr2681594qkp.27.1697547274127; 
 Tue, 17 Oct 2023 05:54:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGMQypDyzRPZ0U1Nqsa9LnoS0LWOlKnef67VLQLdfuC3WqcpkdgcMD34r/9O0TzANciVJx6A==
X-Received: by 2002:a05:620a:2944:b0:76d:aa23:f8e1 with SMTP id
 n4-20020a05620a294400b0076daa23f8e1mr2681570qkp.27.1697547273748; 
 Tue, 17 Oct 2023 05:54:33 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
 by smtp.gmail.com with ESMTPSA id
 i9-20020a05620a144900b00767da10efb6sm614038qkl.97.2023.10.17.05.54.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 05:54:33 -0700 (PDT)
Date: Tue, 17 Oct 2023 14:54:29 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Subject: Re: [RFC PATCH] ALSA: virtio: use copy and fill_silence callbacks
Message-ID: <ZS6EBZ7oyGB9nhay@fedora>
References: <ZSgMeoMx6NX2zCx/@fedora>
 <6384c982-2b6d-474b-bf29-d495422aff20@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <6384c982-2b6d-474b-bf29-d495422aff20@opensynergy.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: alsa-devel@alsa-project.org, mripard@redhat.com, mst@redhat.com,
 tiwai@suse.com, linux-kernel@vger.kernel.org, perex@perex.cz,
 stefanha@redhat.com, pbonzini@redhat.com,
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

Hello Anton, 

Thanks for your help! I am going to send a second version of the patch
with your changes. Is it OK if I add you with the "Co-developed-by"
tag?.

Matias

On Tue, Oct 17, 2023 at 05:11:30PM +0900, Anton Yakovlev wrote:
> Hi Matias,
> 
> Thanks for your help! I updated and corrected your patch a little bit (see
> attachment). All changes were tested, there were no problems on my side.
> 
> See also a few inline comments.
> 
> 
> 
> On 13.10.2023 00:10, Matias Ezequiel Vara Larsen wrote:
> > This commit replaces the mmap mechanism with the copy() and
> > fill_silence() callbacks for both capturing and playback for the
> > virtio-sound driver. This change is required to prevent the updating of
> > the content of a buffer that is already in the available ring.
> > 
> > The current mechanism splits a dma buffer into descriptors that are
> > exposed to the device. This dma buffer is shared with the user
> > application. When the device consumes a buffer, the driver moves the
> > request from the used ring to available ring.
> > 
> > The driver exposes the buffer to the device without knowing if the
> > content has been updated from the user. The section 2.8.21.1 of the
> > virtio spec states that: "The device MAY access the descriptor chains
> > the driver created and the memory they refer to immediately". If the
> > device picks up buffers from the available ring just after it is
> > notified, it happens that the content may be old.
> > 
> > By providing the copy() callback, the driver first updates the content
> > of the buffer, and then, exposes the buffer to the device by enqueuing
> > it in the available ring. Thus, device always picks up a buffer that is
> > updated.
> > 
> > For capturing, the driver starts by exposing all the available buffers
> > to device. After device updates the content of a buffer, it enqueues it
> > in the used ring. It is only after the copy() for capturing is issued
> > that the driver re-enqueues the buffer in the available ring.
> > 
> > Note that the copy() function assumes that user is always writing a
> > period. Testing shows that this is true but I may be wrong. This RFC
> > aims at clarifying this.
> > 
> > Signed-off-by: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
> > ---
> >   sound/virtio/virtio_pcm.c     | 11 ++--
> >   sound/virtio/virtio_pcm.h     |  9 +++-
> >   sound/virtio/virtio_pcm_msg.c | 50 ++++++++++++++++---
> >   sound/virtio/virtio_pcm_ops.c | 94 +++++++++++++++++++++++++++++++----
> >   4 files changed, 137 insertions(+), 27 deletions(-)
> > 
> > diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
> > index c10d91fff2fb..bfe982952303 100644
> > --- a/sound/virtio/virtio_pcm.c
> > +++ b/sound/virtio/virtio_pcm.c
> > @@ -104,8 +104,6 @@ static int virtsnd_pcm_build_hw(struct virtio_pcm_substream *vss,
> >   	 * only message-based transport.
> >   	 */
> >   	vss->hw.info =
> > -		SNDRV_PCM_INFO_MMAP |
> > -		SNDRV_PCM_INFO_MMAP_VALID |
> >   		SNDRV_PCM_INFO_BATCH |
> >   		SNDRV_PCM_INFO_BLOCK_TRANSFER |
> >   		SNDRV_PCM_INFO_INTERLEAVED |
> 
> We need also necessary to disable rewinds, since now only sequential
> reading/writing of frames is supported.
> 
> 
> > @@ -471,12 +469,11 @@ int virtsnd_pcm_build_devs(struct virtio_snd *snd)
> >   			for (kss = ks->substream; kss; kss = kss->next)
> >   				vs->substreams[kss->number]->substream = kss;
> > -			snd_pcm_set_ops(vpcm->pcm, i, &virtsnd_pcm_ops);
> > +			if (i == SNDRV_PCM_STREAM_CAPTURE)
> > +				snd_pcm_set_ops(vpcm->pcm, i, &virtsnd_pcm_capture_ops);
> > +			else
> > +				snd_pcm_set_ops(vpcm->pcm, i, &virtsnd_pcm_playback_ops);
> >   		}
> > -
> > -		snd_pcm_set_managed_buffer_all(vpcm->pcm,
> > -					       SNDRV_DMA_TYPE_VMALLOC, NULL,
> > -					       0, 0);
> 
> It is not right. Buffer allocation/freeing is controlled by the kernel
> subsystem, so the driver doesn't have to worry about it.
> 
> 
> >   	}
> >   	return 0;
> > diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
> > index 062eb8e8f2cf..1c1106ec971f 100644
> > --- a/sound/virtio/virtio_pcm.h
> > +++ b/sound/virtio/virtio_pcm.h
> > @@ -50,6 +50,8 @@ struct virtio_pcm_substream {
> >   	struct work_struct elapsed_period;
> >   	spinlock_t lock;
> >   	size_t buffer_bytes;
> > +	u8 *buffer;
> > +	size_t buffer_sz;
> >   	size_t hw_ptr;
> >   	bool xfer_enabled;
> >   	bool xfer_xrun;
> > @@ -90,7 +92,8 @@ struct virtio_pcm {
> >   	struct virtio_pcm_stream streams[SNDRV_PCM_STREAM_LAST + 1];
> >   };
> > -extern const struct snd_pcm_ops virtsnd_pcm_ops;
> > +extern const struct snd_pcm_ops virtsnd_pcm_playback_ops;
> > +extern const struct snd_pcm_ops virtsnd_pcm_capture_ops;
> >   int virtsnd_pcm_validate(struct virtio_device *vdev);
> > @@ -117,7 +120,9 @@ int virtsnd_pcm_msg_alloc(struct virtio_pcm_substream *vss,
> >   void virtsnd_pcm_msg_free(struct virtio_pcm_substream *vss);
> > -int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss);
> > +int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss, bool single);
> > +
> > +int virtsnd_pcm_msg_send_locked(struct virtio_pcm_substream *vss, bool single);
> >   unsigned int virtsnd_pcm_msg_pending_num(struct virtio_pcm_substream *vss);
> > diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
> > index aca2dc1989ba..9a5f9814cb62 100644
> > --- a/sound/virtio/virtio_pcm_msg.c
> > +++ b/sound/virtio/virtio_pcm_msg.c
> > @@ -132,7 +132,6 @@ static void virtsnd_pcm_sg_from(struct scatterlist *sgs, int nsgs, u8 *data,
> >   int virtsnd_pcm_msg_alloc(struct virtio_pcm_substream *vss,
> >   			  unsigned int periods, unsigned int period_bytes)
> >   {
> > -	struct snd_pcm_runtime *runtime = vss->substream->runtime;
> >   	unsigned int i;
> >   	vss->msgs = kcalloc(periods, sizeof(*vss->msgs), GFP_KERNEL);
> > @@ -142,7 +141,7 @@ int virtsnd_pcm_msg_alloc(struct virtio_pcm_substream *vss,
> >   	vss->nmsgs = periods;
> >   	for (i = 0; i < periods; ++i) {
> > -		u8 *data = runtime->dma_area + period_bytes * i;
> > +		u8 *data = vss->buffer + period_bytes * i;
> >   		int sg_num = virtsnd_pcm_sg_num(data, period_bytes);
> >   		struct virtio_pcm_msg *msg;
> > @@ -186,10 +185,12 @@ void virtsnd_pcm_msg_free(struct virtio_pcm_substream *vss)
> >   /**
> >    * virtsnd_pcm_msg_send() - Send asynchronous I/O messages.
> >    * @vss: VirtIO PCM substream.
> > + * @single: true to enqueue a single message, false to enqueue all of them.
> >    *
> >    * All messages are organized in an ordered circular list. Each time the
> > - * function is called, all currently non-enqueued messages are added to the
> > - * virtqueue. For this, the function keeps track of two values:
> > + * function is called, first non-enqueued message is added to the virtqueue.
> > + * When single is True, only the first message is enqueued. When False, all the
> > + * available messages are enqueued.  The function keeps track of two values:
> >    *
> >    *   msg_last_enqueued = index of the last enqueued message,
> >    *   msg_count = # of pending messages in the virtqueue.
> > @@ -198,7 +199,7 @@ void virtsnd_pcm_msg_free(struct virtio_pcm_substream *vss)
> >    *          spinlocks to be held by caller.
> >    * Return: 0 on success, -errno on failure.
> >    */
> > -int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss)
> > +int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss, bool single)
> 
> I would propose to make this function more generic, specifing the offset and
> size for the modified part of the buffer. This way no assumptions need to be
> made. We can also guarantee that we only put fully written/read messages into
> the virtqueue.
> 
> 
> 
> >   {
> >   	struct snd_pcm_runtime *runtime = vss->substream->runtime;
> >   	struct virtio_snd *snd = vss->snd;
> > @@ -211,6 +212,13 @@ int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss)
> >   	i = (vss->msg_last_enqueued + 1) % runtime->periods;
> >   	n = runtime->periods - vss->msg_count;
> > +	if (single) {
> > +		if (n < 1)
> > +			return -EFAULT;
> > +
> > +		n = 1;
> > +	}
> > +
> >   	for (; n; --n, i = (i + 1) % runtime->periods) {
> >   		struct virtio_pcm_msg *msg = vss->msgs[i];
> >   		struct scatterlist *psgs[] = {
> > @@ -250,6 +258,36 @@ int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss)
> >   	return 0;
> >   }
> > +/**
> > + * virtsnd_pcm_msg_send_locked() - Send asynchronous I/O messages.
> > + * @vss: VirtIO PCM substream.
> > + * @single: true to enqueue a single message, false to enqueue all of them.
> > + *
> > + * This function holds the tx/rx queue and the VirtIO substream spinlocks
> > + * before calling virtsnd_pcm_msg_send(). This is a wrapper function to ease
> > + * the invocation of virtsnd_pcm_msg_send().
> > + *
> > + * Context: Any context.
> > + * Return: 0 on success, -errno on failure.
> > + */
> > +
> > +int virtsnd_pcm_msg_send_locked(struct virtio_pcm_substream *vss, bool single)
> > +{
> > +	struct virtio_snd_queue *queue;
> > +	int rc;
> > +	unsigned long flags;
> > +
> > +	queue = virtsnd_pcm_queue(vss);
> > +
> > +	spin_lock_irqsave(&queue->lock, flags);
> > +	spin_lock(&vss->lock);
> > +	rc = virtsnd_pcm_msg_send(vss, single);
> > +	spin_unlock(&vss->lock);
> > +	spin_unlock_irqrestore(&queue->lock, flags);
> > +
> > +	return rc;
> > +}
> > +
> >   /**
> >    * virtsnd_pcm_msg_pending_num() - Returns the number of pending I/O messages.
> >    * @vss: VirtIO substream.
> > @@ -320,8 +358,6 @@ static void virtsnd_pcm_msg_complete(struct virtio_pcm_msg *msg,
> >   					le32_to_cpu(msg->status.latency_bytes));
> >   		schedule_work(&vss->elapsed_period);
> > -
> > -		virtsnd_pcm_msg_send(vss);
> >   	} else if (!vss->msg_count) {
> >   		wake_up_all(&vss->msg_empty);
> >   	}
> > diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> > index f8bfb87624be..a208439dbff8 100644
> > --- a/sound/virtio/virtio_pcm_ops.c
> > +++ b/sound/virtio/virtio_pcm_ops.c
> > @@ -238,6 +238,11 @@ static int virtsnd_pcm_hw_params(struct snd_pcm_substream *substream,
> >   	 */
> >   	virtsnd_pcm_msg_free(vss);
> > +	vss->buffer_sz = params_buffer_bytes(hw_params);
> > +	vss->buffer = alloc_pages_exact(vss->buffer_sz, GFP_KERNEL);
> > +	if (!vss->buffer)
> > +		return -ENOMEM;
> > +
> >   	return virtsnd_pcm_msg_alloc(vss, params_periods(hw_params),
> >   				     params_period_bytes(hw_params));
> >   }
> > @@ -257,6 +262,11 @@ static int virtsnd_pcm_hw_free(struct snd_pcm_substream *substream)
> >   	if (!virtsnd_pcm_msg_pending_num(vss))
> >   		virtsnd_pcm_msg_free(vss);
> > +	if (vss->buffer) {
> > +		free_pages_exact(vss->buffer, vss->buffer_sz);
> > +		vss->buffer = NULL;
> > +	}
> > +
> >   	return 0;
> >   }
> > @@ -331,15 +341,18 @@ static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream, int command)
> >   	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> >   		queue = virtsnd_pcm_queue(vss);
> > -		spin_lock_irqsave(&queue->lock, flags);
> > -		spin_lock(&vss->lock);
> > -		rc = virtsnd_pcm_msg_send(vss);
> > -		if (!rc)
> > -			vss->xfer_enabled = true;
> > -		spin_unlock(&vss->lock);
> > -		spin_unlock_irqrestore(&queue->lock, flags);
> > -		if (rc)
> > -			return rc;
> > +		// The buffers should be exposed first during capturing so that
> > +		// the device can consume them. Capturing cannot begin
> > +		// otherwise.
> > +		if (vss->direction == SNDRV_PCM_STREAM_CAPTURE) {
> > +			rc = virtsnd_pcm_msg_send_locked(vss, false);
> > +			if (rc)
> > +				return rc;
> > +		}
> > +
> > +		spin_lock_irqsave(&vss->lock, flags);
> > +		vss->xfer_enabled = true;
> > +		spin_unlock_irqrestore(&vss->lock, flags);
> >   		msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_START,
> >   						GFP_KERNEL);
> > @@ -450,8 +463,66 @@ virtsnd_pcm_pointer(struct snd_pcm_substream *substream)
> >   	return hw_ptr;
> >   }
> > -/* PCM substream operators map. */
> > -const struct snd_pcm_ops virtsnd_pcm_ops = {
> > +static int virtsnd_pcm_pb_copy(struct snd_pcm_substream *substream,
> > +			       int channel, unsigned long pos, struct iov_iter
> > +			       *src, unsigned long count)
> > +{
> > +	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
> > +
> > +	if (unlikely(pos + count > vss->buffer_sz))
> > +		return -EINVAL;
> > +
> > +	if (copy_from_iter(vss->buffer + pos, count, src) != count)
> > +		return -EFAULT;
> > +
> > +	return virtsnd_pcm_msg_send_locked(vss, true);
> > +}
> > +
> > +static int virtsnd_pcm_cap_copy(struct snd_pcm_substream *substream,
> > +				int channel, unsigned long pos, struct iov_iter
> > +				*dst, unsigned long count)
> > +{
> > +	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
> > +
> > +	if (unlikely(pos + count > vss->buffer_sz))
> > +		return -EINVAL;
> > +
> > +	if (copy_to_iter(vss->buffer + pos, count, dst) != count)
> > +		return -EFAULT;
> > +
> > +	return virtsnd_pcm_msg_send_locked(vss, true);
> > +}
> > +
> > +static int virtsnd_pcm_pb_silence(struct snd_pcm_substream *substream, int channel,
> > +				  unsigned long pos, unsigned long count)
> > +{
> > +	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
> > +
> > +	if (unlikely(pos + count > vss->buffer_sz))
> > +		return -EINVAL;
> > +
> > +	memset(vss->buffer + pos, 0, count);
> > +
> > +	return virtsnd_pcm_msg_send_locked(vss, true);
> > +}
> > +
> > +/* PCM substream operators map for playback. */
> > +const struct snd_pcm_ops virtsnd_pcm_playback_ops = {
> > +	.open = virtsnd_pcm_open,
> > +	.close = virtsnd_pcm_close,
> > +	.ioctl = snd_pcm_lib_ioctl,
> > +	.hw_params = virtsnd_pcm_hw_params,
> > +	.hw_free = virtsnd_pcm_hw_free,
> > +	.prepare = virtsnd_pcm_prepare,
> > +	.trigger = virtsnd_pcm_trigger,
> > +	.sync_stop = virtsnd_pcm_sync_stop,
> > +	.pointer = virtsnd_pcm_pointer,
> > +	.copy = virtsnd_pcm_pb_copy,
> > +	.fill_silence = virtsnd_pcm_pb_silence,
> > +};
> > +
> > +/* PCM substream operators map for capturing. */
> > +const struct snd_pcm_ops virtsnd_pcm_capture_ops = {
> >   	.open = virtsnd_pcm_open,
> >   	.close = virtsnd_pcm_close,
> >   	.ioctl = snd_pcm_lib_ioctl,
> > @@ -461,4 +532,5 @@ const struct snd_pcm_ops virtsnd_pcm_ops = {
> >   	.trigger = virtsnd_pcm_trigger,
> >   	.sync_stop = virtsnd_pcm_sync_stop,
> >   	.pointer = virtsnd_pcm_pointer,
> > +	.copy = virtsnd_pcm_cap_copy,
> >   };
> > 
> > base-commit: 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa
> 
> -- 
> Anton Yakovlev
> Senior Software Engineer
> 
> OpenSynergy GmbH
> Rotherstr. 20, 10245 Berlin

> From c9019469c5689d860ee6ea5c4a9ea7caa5009daa Mon Sep 17 00:00:00 2001
> From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
> Date: Tue, 17 Oct 2023 16:34:28 +0900
> Subject: [PATCH] ALSA: virtio: use copy and fill_silence callbacks
> 
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
> ---
>  sound/virtio/virtio_pcm.c     |  7 ++-
>  sound/virtio/virtio_pcm.h     |  9 ++--
>  sound/virtio/virtio_pcm_msg.c | 87 +++++++++++++++++++++++------------
>  sound/virtio/virtio_pcm_ops.c | 81 ++++++++++++++++++++++++++------
>  4 files changed, 135 insertions(+), 49 deletions(-)
> 
> diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
> index c10d91fff2fb..66d67eef1bcc 100644
> --- a/sound/virtio/virtio_pcm.c
> +++ b/sound/virtio/virtio_pcm.c
> @@ -104,12 +104,11 @@ static int virtsnd_pcm_build_hw(struct virtio_pcm_substream *vss,
>  	 * only message-based transport.
>  	 */
>  	vss->hw.info =
> -		SNDRV_PCM_INFO_MMAP |
> -		SNDRV_PCM_INFO_MMAP_VALID |
>  		SNDRV_PCM_INFO_BATCH |
>  		SNDRV_PCM_INFO_BLOCK_TRANSFER |
>  		SNDRV_PCM_INFO_INTERLEAVED |
> -		SNDRV_PCM_INFO_PAUSE;
> +		SNDRV_PCM_INFO_PAUSE |
> +		SNDRV_PCM_INFO_NO_REWINDS;
>  
>  	if (!info->channels_min || info->channels_min > info->channels_max) {
>  		dev_err(&vdev->dev,
> @@ -471,7 +470,7 @@ int virtsnd_pcm_build_devs(struct virtio_snd *snd)
>  			for (kss = ks->substream; kss; kss = kss->next)
>  				vs->substreams[kss->number]->substream = kss;
>  
> -			snd_pcm_set_ops(vpcm->pcm, i, &virtsnd_pcm_ops);
> +			snd_pcm_set_ops(vpcm->pcm, i, &virtsnd_pcm_ops[i]);
>  		}
>  
>  		snd_pcm_set_managed_buffer_all(vpcm->pcm,
> diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
> index 062eb8e8f2cf..8b42928a8e01 100644
> --- a/sound/virtio/virtio_pcm.h
> +++ b/sound/virtio/virtio_pcm.h
> @@ -57,7 +57,6 @@ struct virtio_pcm_substream {
>  	bool suspended;
>  	struct virtio_pcm_msg **msgs;
>  	unsigned int nmsgs;
> -	int msg_last_enqueued;
>  	unsigned int msg_count;
>  	wait_queue_head_t msg_empty;
>  };
> @@ -90,7 +89,7 @@ struct virtio_pcm {
>  	struct virtio_pcm_stream streams[SNDRV_PCM_STREAM_LAST + 1];
>  };
>  
> -extern const struct snd_pcm_ops virtsnd_pcm_ops;
> +extern const struct snd_pcm_ops virtsnd_pcm_ops[];
>  
>  int virtsnd_pcm_validate(struct virtio_device *vdev);
>  
> @@ -117,7 +116,11 @@ int virtsnd_pcm_msg_alloc(struct virtio_pcm_substream *vss,
>  
>  void virtsnd_pcm_msg_free(struct virtio_pcm_substream *vss);
>  
> -int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss);
> +int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss, unsigned long offset,
> +			 unsigned long bytes);
> +
> +int virtsnd_pcm_msg_send_locked(struct virtio_pcm_substream *vss,
> +				unsigned long offset, unsigned long bytes);
>  
>  unsigned int virtsnd_pcm_msg_pending_num(struct virtio_pcm_substream *vss);
>  
> diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
> index aca2dc1989ba..3bc0a61a046d 100644
> --- a/sound/virtio/virtio_pcm_msg.c
> +++ b/sound/virtio/virtio_pcm_msg.c
> @@ -155,7 +155,6 @@ int virtsnd_pcm_msg_alloc(struct virtio_pcm_substream *vss,
>  			    sizeof(msg->xfer));
>  		sg_init_one(&msg->sgs[PCM_MSG_SG_STATUS], &msg->status,
>  			    sizeof(msg->status));
> -		msg->length = period_bytes;
>  		virtsnd_pcm_sg_from(&msg->sgs[PCM_MSG_SG_DATA], sg_num, data,
>  				    period_bytes);
>  
> @@ -198,49 +197,63 @@ void virtsnd_pcm_msg_free(struct virtio_pcm_substream *vss)
>   *          spinlocks to be held by caller.
>   * Return: 0 on success, -errno on failure.
>   */
> -int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss)
> +int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss, unsigned long offset,
> +			 unsigned long bytes)
>  {
> -	struct snd_pcm_runtime *runtime = vss->substream->runtime;
>  	struct virtio_snd *snd = vss->snd;
>  	struct virtio_device *vdev = snd->vdev;
>  	struct virtqueue *vqueue = virtsnd_pcm_queue(vss)->vqueue;
> -	int i;
> -	int n;
> +	unsigned long period_bytes = snd_pcm_lib_period_bytes(vss->substream);
> +	unsigned long start, end, i;
> +	unsigned int msg_count = vss->msg_count;
>  	bool notify = false;
> +	int rc;
>  
> -	i = (vss->msg_last_enqueued + 1) % runtime->periods;
> -	n = runtime->periods - vss->msg_count;
> +	start = offset / period_bytes;
> +	end = (offset + bytes - 1) / period_bytes;
>  
> -	for (; n; --n, i = (i + 1) % runtime->periods) {
> +	for (i = start; i <= end; i++) {
>  		struct virtio_pcm_msg *msg = vss->msgs[i];
>  		struct scatterlist *psgs[] = {
>  			&msg->sgs[PCM_MSG_SG_XFER],
>  			&msg->sgs[PCM_MSG_SG_DATA],
>  			&msg->sgs[PCM_MSG_SG_STATUS]
>  		};
> -		int rc;
> -
> -		msg->xfer.stream_id = cpu_to_le32(vss->sid);
> -		memset(&msg->status, 0, sizeof(msg->status));
> -
> -		if (vss->direction == SNDRV_PCM_STREAM_PLAYBACK)
> -			rc = virtqueue_add_sgs(vqueue, psgs, 2, 1, msg,
> -					       GFP_ATOMIC);
> -		else
> -			rc = virtqueue_add_sgs(vqueue, psgs, 1, 2, msg,
> -					       GFP_ATOMIC);
> -
> -		if (rc) {
> -			dev_err(&vdev->dev,
> -				"SID %u: failed to send I/O message\n",
> -				vss->sid);
> -			return rc;
> +		unsigned long n;
> +
> +		n = period_bytes - (offset % period_bytes);
> +		if (n > bytes)
> +			n = bytes;
> +
> +		msg->length += n;
> +		if (msg->length == period_bytes) {
> +			msg->xfer.stream_id = cpu_to_le32(vss->sid);
> +			memset(&msg->status, 0, sizeof(msg->status));
> +
> +			if (vss->direction == SNDRV_PCM_STREAM_PLAYBACK)
> +				rc = virtqueue_add_sgs(vqueue, psgs, 2, 1, msg,
> +						       GFP_ATOMIC);
> +			else
> +				rc = virtqueue_add_sgs(vqueue, psgs, 1, 2, msg,
> +						       GFP_ATOMIC);
> +
> +			if (rc) {
> +				dev_err(&vdev->dev,
> +					"SID %u: failed to send I/O message\n",
> +					vss->sid);
> +				return rc;
> +			}
> +
> +			vss->msg_count++;
>  		}
>  
> -		vss->msg_last_enqueued = i;
> -		vss->msg_count++;
> +		offset = 0;
> +		bytes -= n;
>  	}
>  
> +	if (msg_count == vss->msg_count)
> +		return 0;
> +
>  	if (!(vss->features & (1U << VIRTIO_SND_PCM_F_MSG_POLLING)))
>  		notify = virtqueue_kick_prepare(vqueue);
>  
> @@ -250,6 +263,22 @@ int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss)
>  	return 0;
>  }
>  
> +int virtsnd_pcm_msg_send_locked(struct virtio_pcm_substream *vss,
> +				unsigned long offset, unsigned long bytes)
> +{
> +	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
> +	unsigned long flags;
> +	int rc;
> +
> +	spin_lock_irqsave(&queue->lock, flags);
> +	spin_lock(&vss->lock);
> +	rc = virtsnd_pcm_msg_send(vss, offset, bytes);
> +	spin_unlock(&vss->lock);
> +	spin_unlock_irqrestore(&queue->lock, flags);
> +
> +	return rc;
> +}
> +
>  /**
>   * virtsnd_pcm_msg_pending_num() - Returns the number of pending I/O messages.
>   * @vss: VirtIO substream.
> @@ -309,6 +338,8 @@ static void virtsnd_pcm_msg_complete(struct virtio_pcm_msg *msg,
>  	if (vss->hw_ptr >= vss->buffer_bytes)
>  		vss->hw_ptr -= vss->buffer_bytes;
>  
> +	msg->length = 0;
> +
>  	vss->xfer_xrun = false;
>  	vss->msg_count--;
>  
> @@ -320,8 +351,6 @@ static void virtsnd_pcm_msg_complete(struct virtio_pcm_msg *msg,
>  					le32_to_cpu(msg->status.latency_bytes));
>  
>  		schedule_work(&vss->elapsed_period);
> -
> -		virtsnd_pcm_msg_send(vss);
>  	} else if (!vss->msg_count) {
>  		wake_up_all(&vss->msg_empty);
>  	}
> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index f8bfb87624be..4569b285f520 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c
> @@ -282,7 +282,6 @@ static int virtsnd_pcm_prepare(struct snd_pcm_substream *substream)
>  
>  		vss->buffer_bytes = snd_pcm_lib_buffer_bytes(substream);
>  		vss->hw_ptr = 0;
> -		vss->msg_last_enqueued = -1;
>  	} else {
>  		struct snd_pcm_runtime *runtime = substream->runtime;
>  		unsigned int buffer_bytes = snd_pcm_lib_buffer_bytes(substream);
> @@ -324,7 +323,7 @@ static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream, int command)
>  	struct virtio_snd_queue *queue;
>  	struct virtio_snd_msg *msg;
>  	unsigned long flags;
> -	int rc;
> +	int rc = 0;
>  
>  	switch (command) {
>  	case SNDRV_PCM_TRIGGER_START:
> @@ -333,7 +332,8 @@ static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream, int command)
>  
>  		spin_lock_irqsave(&queue->lock, flags);
>  		spin_lock(&vss->lock);
> -		rc = virtsnd_pcm_msg_send(vss);
> +		if (vss->direction == SNDRV_PCM_STREAM_CAPTURE)
> +			rc = virtsnd_pcm_msg_send(vss, 0, vss->buffer_bytes);
>  		if (!rc)
>  			vss->xfer_enabled = true;
>  		spin_unlock(&vss->lock);
> @@ -450,15 +450,70 @@ virtsnd_pcm_pointer(struct snd_pcm_substream *substream)
>  	return hw_ptr;
>  }
>  
> +static int virtsnd_pcm_pb_silence(struct snd_pcm_substream *substream,
> +				  int channel, unsigned long pos,
> +				  unsigned long bytes)
> +{
> +	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +
> +	snd_pcm_format_set_silence(runtime->format, runtime->dma_area + pos,
> +				   bytes_to_samples(runtime, bytes));
> +
> +	return virtsnd_pcm_msg_send_locked(vss, pos, bytes);
> +}
> +
> +static int virtsnd_pcm_pb_copy(struct snd_pcm_substream *substream, int channel,
> +			       unsigned long pos, struct iov_iter *iter,
> +			       unsigned long bytes)
> +{
> +	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +
> +	if (copy_from_iter(runtime->dma_area + pos, bytes, iter) != bytes)
> +		return -EFAULT;
> +
> +	return virtsnd_pcm_msg_send_locked(vss, pos, bytes);
> +}
> +
> +static int virtsnd_pcm_cp_copy(struct snd_pcm_substream *substream, int channel,
> +			       unsigned long pos, struct iov_iter *iter,
> +			       unsigned long bytes)
> +{
> +	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +
> +	if (copy_to_iter(runtime->dma_area + pos, bytes, iter) != bytes)
> +		return -EFAULT;
> +
> +	return virtsnd_pcm_msg_send_locked(vss, pos, bytes);
> +}
> +
>  /* PCM substream operators map. */
> -const struct snd_pcm_ops virtsnd_pcm_ops = {
> -	.open = virtsnd_pcm_open,
> -	.close = virtsnd_pcm_close,
> -	.ioctl = snd_pcm_lib_ioctl,
> -	.hw_params = virtsnd_pcm_hw_params,
> -	.hw_free = virtsnd_pcm_hw_free,
> -	.prepare = virtsnd_pcm_prepare,
> -	.trigger = virtsnd_pcm_trigger,
> -	.sync_stop = virtsnd_pcm_sync_stop,
> -	.pointer = virtsnd_pcm_pointer,
> +const struct snd_pcm_ops virtsnd_pcm_ops[] = {
> +	{
> +		.open = virtsnd_pcm_open,
> +		.close = virtsnd_pcm_close,
> +		.ioctl = snd_pcm_lib_ioctl,
> +		.hw_params = virtsnd_pcm_hw_params,
> +		.hw_free = virtsnd_pcm_hw_free,
> +		.prepare = virtsnd_pcm_prepare,
> +		.trigger = virtsnd_pcm_trigger,
> +		.sync_stop = virtsnd_pcm_sync_stop,
> +		.pointer = virtsnd_pcm_pointer,
> +		.copy = virtsnd_pcm_pb_copy,
> +		.fill_silence = virtsnd_pcm_pb_silence,
> +	},
> +	{
> +		.open = virtsnd_pcm_open,
> +		.close = virtsnd_pcm_close,
> +		.ioctl = snd_pcm_lib_ioctl,
> +		.hw_params = virtsnd_pcm_hw_params,
> +		.hw_free = virtsnd_pcm_hw_free,
> +		.prepare = virtsnd_pcm_prepare,
> +		.trigger = virtsnd_pcm_trigger,
> +		.sync_stop = virtsnd_pcm_sync_stop,
> +		.pointer = virtsnd_pcm_pointer,
> +		.copy = virtsnd_pcm_cp_copy,
> +	},
>  };
> -- 
> 2.42.0
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
