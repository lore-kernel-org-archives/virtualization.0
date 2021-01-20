Return-Path: <SRS0=zQmE=GX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD50DC433DB
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 08:36:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67DDA22573
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 08:36:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67DDA22573
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E3D4586797;
	Wed, 20 Jan 2021 08:36:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KPXKbepqJYSY; Wed, 20 Jan 2021 08:36:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9ED4B86742;
	Wed, 20 Jan 2021 08:36:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84430C08A1;
	Wed, 20 Jan 2021 08:36:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD96CC013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 08:36:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id AB6D785B55
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 08:36:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ngL-EuaoM5nK
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 08:36:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 02C2985C62
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 08:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611131808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zwS404B1Dcmsx4Tsw8dtJy/TCAa1KdbUtsl+N+yEyqE=;
 b=P357rAXHoyA18Mc8xGR9+dx6jHt+QKwRsn6d3Bzd1TsWkQsysxfBBNXcm9yZQOzUBpcKn4
 C/8CAFzB0KT4seIezbJ66gLa6cxIPbTBecp/iVocJEHlwBW9SBTxsP1DML9dlEEiH5nQ+D
 AFNiyjvnk1N5vCImfdkARDbk3t8eXEI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-h8lQfnNtOgugqAKRgVnlqQ-1; Wed, 20 Jan 2021 03:36:46 -0500
X-MC-Unique: h8lQfnNtOgugqAKRgVnlqQ-1
Received: by mail-wr1-f71.google.com with SMTP id z8so11119325wrh.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 00:36:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zwS404B1Dcmsx4Tsw8dtJy/TCAa1KdbUtsl+N+yEyqE=;
 b=lHz8WYAbg2IgnlZS7OHZjUluWAxMncQ6ErbXzIaG5ukomntb9TgqA47626jQUDIq5k
 pxngDBqtEfYlJFhAa5o9zXFZl7FhvXAIApVR74KvbGXe2M1tx0xGtWkAmyXnqNLYkVDk
 4fvDkkp/iMcQTJmLd7Msq+Bo/VAGhQ84rMTMfJ0WTbWm4FUPD6iAr/WCHPg47HG0GUHl
 3YdVh3FzHXCN6F3KcX+YfiFi6CaERRHB8AomN8qkv/DZ+gpmxt73QDPeXkLgNmKklYa9
 cNGUGB/zO/wRwk45KWWZ8q7DjsyiRI9FiL+H4bei7gFP7LH3rXDYpivqeD7uv0Sq/YlC
 UadA==
X-Gm-Message-State: AOAM532YCHVgHt2xxgEdPRYHAFiAsMAJlTT7yR0L0n7ZZKsWzgJVGDCf
 nN1lzr/aa3bK0Szyj2cSOaKpMFdyIWqnEppvAfsBd9HtDxrHCnXK9UYIDPuctmNGXVbCzC2nGCr
 qOzjJ1O4p/jFFJIPIr5oPDCNzZRMMcyOJWrLayTMoiA==
X-Received: by 2002:a7b:c188:: with SMTP id y8mr3044846wmi.173.1611131805453; 
 Wed, 20 Jan 2021 00:36:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxgS9tc/3Xpal7nfL8cFydPCCTxJcrfIF0ATbB4E4i1/qKDYzUvPJd43uFwbYr4k7Y4maLMwQ==
X-Received: by 2002:a7b:c188:: with SMTP id y8mr3044826wmi.173.1611131805086; 
 Wed, 20 Jan 2021 00:36:45 -0800 (PST)
Received: from redhat.com (bzq-79-177-39-148.red.bezeqint.net. [79.177.39.148])
 by smtp.gmail.com with ESMTPSA id z6sm2494010wrw.58.2021.01.20.00.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Jan 2021 00:36:44 -0800 (PST)
Date: Wed, 20 Jan 2021 03:36:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Subject: Re: [PATCH 5/7] ALSA: virtio: PCM substream operators
Message-ID: <20210120033334-mutt-send-email-mst@kernel.org>
References: <20210120003638.3339987-1-anton.yakovlev@opensynergy.com>
 <20210120003638.3339987-6-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <20210120003638.3339987-6-anton.yakovlev@opensynergy.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtio-dev@lists.oasis-open.org, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
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

On Wed, Jan 20, 2021 at 01:36:33AM +0100, Anton Yakovlev wrote:
> Introduce the operators required for the operation of substreams.
> 
> Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> ---
>  sound/virtio/Makefile         |   3 +-
>  sound/virtio/virtio_pcm.c     |   5 +-
>  sound/virtio/virtio_pcm.h     |   2 +
>  sound/virtio/virtio_pcm_ops.c | 509 ++++++++++++++++++++++++++++++++++
>  4 files changed, 517 insertions(+), 2 deletions(-)
>  create mode 100644 sound/virtio/virtio_pcm_ops.c
> 
> diff --git a/sound/virtio/Makefile b/sound/virtio/Makefile
> index 626af3cc3ed7..34493226793f 100644
> --- a/sound/virtio/Makefile
> +++ b/sound/virtio/Makefile
> @@ -6,5 +6,6 @@ virtio_snd-objs := \
>  	virtio_card.o \
>  	virtio_ctl_msg.o \
>  	virtio_pcm.o \
> -	virtio_pcm_msg.o
> +	virtio_pcm_msg.o \
> +	virtio_pcm_ops.o
>  
> diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
> index 1ab50dcc88c8..6a1ca6b2c3ca 100644
> --- a/sound/virtio/virtio_pcm.c
> +++ b/sound/virtio/virtio_pcm.c
> @@ -121,7 +121,8 @@ static int virtsnd_pcm_build_hw(struct virtio_pcm_substream *substream,
>  		SNDRV_PCM_INFO_MMAP_VALID |
>  		SNDRV_PCM_INFO_BATCH |
>  		SNDRV_PCM_INFO_BLOCK_TRANSFER |
> -		SNDRV_PCM_INFO_INTERLEAVED;
> +		SNDRV_PCM_INFO_INTERLEAVED |
> +		SNDRV_PCM_INFO_PAUSE;
>  
>  	if (!info->channels_min || info->channels_min > info->channels_max) {
>  		dev_err(&vdev->dev,
> @@ -503,6 +504,8 @@ int virtsnd_pcm_build_devs(struct virtio_snd *snd)
>  				if (rc)
>  					return rc;
>  			}
> +
> +			snd_pcm_set_ops(pcm->pcm, i, &virtsnd_pcm_ops);
>  		}
>  
>  	return 0;
> diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
> index d011b7e1d18d..fe467bc05d8b 100644
> --- a/sound/virtio/virtio_pcm.h
> +++ b/sound/virtio/virtio_pcm.h
> @@ -90,6 +90,8 @@ struct virtio_pcm {
>  	struct virtio_pcm_stream streams[SNDRV_PCM_STREAM_LAST + 1];
>  };
>  
> +extern const struct snd_pcm_ops virtsnd_pcm_ops;
> +
>  int virtsnd_pcm_validate(struct virtio_device *vdev);
>  
>  int virtsnd_pcm_parse_cfg(struct virtio_snd *snd);
> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> new file mode 100644
> index 000000000000..8d26c1144ad6
> --- /dev/null
> +++ b/sound/virtio/virtio_pcm_ops.c
> @@ -0,0 +1,509 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Sound card driver for virtio
> + * Copyright (C) 2020  OpenSynergy GmbH
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +#include <sound/pcm_params.h>
> +
> +#include "virtio_card.h"
> +
> +/*
> + * Our main concern here is maintaining the correct state of the underlying I/O
> + * virtqueues. Thus, operators are implemented to support all of the following
> + * possible control paths (excluding all trivial ones):
> + *
> + *                        +---------+
> + *                        | open()  |<------------------+
> + *                        +----+----+                   |
> + *                             v                        |
> + *                      +------+------+                 |
> + *       +------------->| hw_params() |<-------------+  |
> + *       |              +-------------+              |  |
> + *       |                     v                     |  |
> + *       |               +-----------+               |  |
> + *       |               | prepare() |<-----------+  |  |
> + *       |               +-----------+            |  |  |
> + *       |                     v                  |  |  |
> + *       |        +-------------------------+     |  |  |
> + * +-----------+  | trigger(START/          |     |  |  |
> + * | restore() |  |         PAUSE_RELEASE/  |<-+  |  |  |
> + * +-----------+  |         RESUME)         |  |  |  |  |
> + *       ^        +-------------------------+  |  |  |  |
> + *       |                     v               |  |  |  |
> + *       |               +-----------+         |  |  |  |
> + *       |               | pointer() |         |  |  |  |
> + *       |               +-----------+         |  |  |  |
> + *       |                     v               |  |  |  |
> + *       |          +---------------------+    |  |  |  |
> + * +-----------+    | trigger(STOP/       |----+  |  |  |
> + * | freeze()  |<---|         PAUSE_PUSH/ |-------+  |  |
> + * +-----------+    |         SUSPEND)    |          |  |
> + *                  +---------------------+          |  |
> + *                             v                     |  |
> + *                       +-----------+               |  |
> + *                       | hw_free() |---------------+  |
> + *                       +-----------+                  |
> + *                             v                        |
> + *                        +---------+                   |
> + *                        | close() |-------------------+
> + *                        +---------+
> + */
> +
> +/* Map for converting ALSA format to VirtIO format. */
> +struct virtsnd_a2v_format {
> +	unsigned int alsa_bit;
> +	unsigned int vio_bit;
> +};
> +
> +static const struct virtsnd_a2v_format g_a2v_format_map[] = {
> +	{ SNDRV_PCM_FORMAT_IMA_ADPCM, VIRTIO_SND_PCM_FMT_IMA_ADPCM },
> +	{ SNDRV_PCM_FORMAT_MU_LAW, VIRTIO_SND_PCM_FMT_MU_LAW },
> +	{ SNDRV_PCM_FORMAT_A_LAW, VIRTIO_SND_PCM_FMT_A_LAW },
> +	{ SNDRV_PCM_FORMAT_S8, VIRTIO_SND_PCM_FMT_S8 },
> +	{ SNDRV_PCM_FORMAT_U8, VIRTIO_SND_PCM_FMT_U8 },
> +	{ SNDRV_PCM_FORMAT_S16_LE, VIRTIO_SND_PCM_FMT_S16 },
> +	{ SNDRV_PCM_FORMAT_U16_LE, VIRTIO_SND_PCM_FMT_U16 },
> +	{ SNDRV_PCM_FORMAT_S18_3LE, VIRTIO_SND_PCM_FMT_S18_3 },
> +	{ SNDRV_PCM_FORMAT_U18_3LE, VIRTIO_SND_PCM_FMT_U18_3 },
> +	{ SNDRV_PCM_FORMAT_S20_3LE, VIRTIO_SND_PCM_FMT_S20_3 },
> +	{ SNDRV_PCM_FORMAT_U20_3LE, VIRTIO_SND_PCM_FMT_U20_3 },
> +	{ SNDRV_PCM_FORMAT_S24_3LE, VIRTIO_SND_PCM_FMT_S24_3 },
> +	{ SNDRV_PCM_FORMAT_U24_3LE, VIRTIO_SND_PCM_FMT_U24_3 },
> +	{ SNDRV_PCM_FORMAT_S20_LE, VIRTIO_SND_PCM_FMT_S20 },
> +	{ SNDRV_PCM_FORMAT_U20_LE, VIRTIO_SND_PCM_FMT_U20 },
> +	{ SNDRV_PCM_FORMAT_S24_LE, VIRTIO_SND_PCM_FMT_S24 },
> +	{ SNDRV_PCM_FORMAT_U24_LE, VIRTIO_SND_PCM_FMT_U24 },
> +	{ SNDRV_PCM_FORMAT_S32_LE, VIRTIO_SND_PCM_FMT_S32 },
> +	{ SNDRV_PCM_FORMAT_U32_LE, VIRTIO_SND_PCM_FMT_U32 },
> +	{ SNDRV_PCM_FORMAT_FLOAT_LE, VIRTIO_SND_PCM_FMT_FLOAT },
> +	{ SNDRV_PCM_FORMAT_FLOAT64_LE, VIRTIO_SND_PCM_FMT_FLOAT64 },
> +	{ SNDRV_PCM_FORMAT_DSD_U8, VIRTIO_SND_PCM_FMT_DSD_U8 },
> +	{ SNDRV_PCM_FORMAT_DSD_U16_LE, VIRTIO_SND_PCM_FMT_DSD_U16 },
> +	{ SNDRV_PCM_FORMAT_DSD_U32_LE, VIRTIO_SND_PCM_FMT_DSD_U32 },
> +	{ SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE,
> +	  VIRTIO_SND_PCM_FMT_IEC958_SUBFRAME }
> +};
> +
> +/* Map for converting ALSA frame rate to VirtIO frame rate. */
> +struct virtsnd_a2v_rate {
> +	unsigned int rate;
> +	unsigned int vio_bit;
> +};
> +
> +static const struct virtsnd_a2v_rate g_a2v_rate_map[] = {
> +	{ 5512, VIRTIO_SND_PCM_RATE_5512 },
> +	{ 8000, VIRTIO_SND_PCM_RATE_8000 },
> +	{ 11025, VIRTIO_SND_PCM_RATE_11025 },
> +	{ 16000, VIRTIO_SND_PCM_RATE_16000 },
> +	{ 22050, VIRTIO_SND_PCM_RATE_22050 },
> +	{ 32000, VIRTIO_SND_PCM_RATE_32000 },
> +	{ 44100, VIRTIO_SND_PCM_RATE_44100 },
> +	{ 48000, VIRTIO_SND_PCM_RATE_48000 },
> +	{ 64000, VIRTIO_SND_PCM_RATE_64000 },
> +	{ 88200, VIRTIO_SND_PCM_RATE_88200 },
> +	{ 96000, VIRTIO_SND_PCM_RATE_96000 },
> +	{ 176400, VIRTIO_SND_PCM_RATE_176400 },
> +	{ 192000, VIRTIO_SND_PCM_RATE_192000 }
> +};
> +
> +/**
> + * virtsnd_pcm_release() - Release the PCM substream on the device side.
> + * @substream: VirtIO substream.
> + *
> + * The function waits for all pending I/O messages to complete.
> + *
> + * Context: Any context that permits to sleep.
> + * Return: 0 on success, -errno on failure.
> + */
> +static inline bool virtsnd_pcm_released(struct virtio_pcm_substream *substream)
> +{
> +	return atomic_read(&substream->msg_count) == 0;

All this use of atomic_read/atomic_set all over the place makes me pause.
Could you add documentation explaining the use rules for these atomic fields?

> +}
> +
> +static int virtsnd_pcm_release(struct virtio_pcm_substream *substream)
> +{
> +	struct virtio_snd *snd = substream->snd;
> +	struct virtio_snd_msg *msg;
> +	unsigned int js = msecs_to_jiffies(msg_timeout_ms);
> +	int rc;
> +
> +	msg = virtsnd_pcm_ctl_msg_alloc(substream, VIRTIO_SND_R_PCM_RELEASE,
> +					GFP_KERNEL);
> +	if (IS_ERR(msg))
> +		return PTR_ERR(msg);
> +
> +	rc = virtsnd_ctl_msg_send_sync(snd, msg);
> +	if (rc)
> +		return rc;
> +
> +	return wait_event_interruptible_timeout(substream->msg_empty,
> +						virtsnd_pcm_released(substream),
> +						js);
> +}
> +
> +/**
> + * virtsnd_pcm_open() - Open the PCM substream.
> + * @substream: Kernel ALSA substream.
> + *
> + * Context: Any context.
> + * Return: 0 on success, -errno on failure.
> + */
> +static int virtsnd_pcm_open(struct snd_pcm_substream *substream)
> +{
> +	struct virtio_pcm *pcm = snd_pcm_substream_chip(substream);
> +	struct virtio_pcm_substream *ss = NULL;
> +
> +	if (pcm) {
> +		switch (substream->stream) {
> +		case SNDRV_PCM_STREAM_PLAYBACK:
> +		case SNDRV_PCM_STREAM_CAPTURE: {
> +			struct virtio_pcm_stream *stream =
> +				&pcm->streams[substream->stream];
> +
> +			if (substream->number < stream->nsubstreams)
> +				ss = stream->substreams[substream->number];
> +			break;
> +		}
> +		}
> +	}
> +
> +	if (!ss)
> +		return -EBADFD;
> +
> +	substream->runtime->hw = ss->hw;
> +	substream->private_data = ss;
> +
> +	return 0;
> +}
> +
> +/**
> + * virtsnd_pcm_close() - Close the PCM substream.
> + * @substream: Kernel ALSA substream.
> + *
> + * Context: Any context.
> + * Return: 0.
> + */
> +static int virtsnd_pcm_close(struct snd_pcm_substream *substream)
> +{
> +	return 0;
> +}
> +
> +/**
> + * virtsnd_pcm_hw_params() - Set the parameters of the PCM substream.
> + * @substream: Kernel ALSA substream.
> + * @hw_params: Hardware parameters (can be NULL).
> + *
> + * The function can be called both from the upper level (in this case,
> + * @hw_params is not NULL) or from the driver itself (in this case, @hw_params
> + * is NULL, and the parameter values are taken from the runtime structure).
> + *
> + * In all cases, the function:
> + *   1. checks the state of the virtqueue and, if necessary, tries to fix it,
> + *   2. sets the parameters on the device side,
> + *   3. allocates a hardware buffer and I/O messages.
> + *
> + * Context: Any context that permits to sleep.
> + * Return: 0 on success, -errno on failure.
> + */
> +static int virtsnd_pcm_hw_params(struct snd_pcm_substream *substream,
> +				 struct snd_pcm_hw_params *hw_params)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct virtio_pcm_substream *ss = snd_pcm_substream_chip(substream);
> +	struct virtio_device *vdev = ss->snd->vdev;
> +	struct virtio_snd_msg *msg;
> +	struct virtio_snd_pcm_set_params *request;
> +	snd_pcm_format_t format;
> +	unsigned int channels;
> +	unsigned int rate;
> +	unsigned int buffer_bytes;
> +	unsigned int period_bytes;
> +	unsigned int periods;
> +	unsigned int i;
> +	int vformat = -1;
> +	int vrate = -1;
> +	int rc;
> +
> +	/*
> +	 * If we got here after ops->trigger() was called, the queue may
> +	 * still contain messages. In this case, we need to release the
> +	 * substream first.
> +	 */
> +	if (atomic_read(&ss->msg_count)) {
> +		rc = virtsnd_pcm_release(ss);
> +		if (rc) {
> +			dev_err(&vdev->dev,
> +				"SID %u: invalid I/O queue state\n",
> +				ss->sid);
> +			return rc;
> +		}
> +	}
> +
> +	/* Set hardware parameters in device */
> +	if (hw_params) {
> +		format = params_format(hw_params);
> +		channels = params_channels(hw_params);
> +		rate = params_rate(hw_params);
> +		buffer_bytes = params_buffer_bytes(hw_params);
> +		period_bytes = params_period_bytes(hw_params);
> +		periods = params_periods(hw_params);
> +	} else {
> +		format = runtime->format;
> +		channels = runtime->channels;
> +		rate = runtime->rate;
> +		buffer_bytes = frames_to_bytes(runtime, runtime->buffer_size);
> +		period_bytes = frames_to_bytes(runtime, runtime->period_size);
> +		periods = runtime->periods;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(g_a2v_format_map); ++i)
> +		if (g_a2v_format_map[i].alsa_bit == format) {
> +			vformat = g_a2v_format_map[i].vio_bit;
> +
> +			break;
> +		}
> +
> +	for (i = 0; i < ARRAY_SIZE(g_a2v_rate_map); ++i)
> +		if (g_a2v_rate_map[i].rate == rate) {
> +			vrate = g_a2v_rate_map[i].vio_bit;
> +
> +			break;
> +		}
> +
> +	if (vformat == -1 || vrate == -1)
> +		return -EINVAL;
> +
> +	msg = virtsnd_pcm_ctl_msg_alloc(ss, VIRTIO_SND_R_PCM_SET_PARAMS,
> +					GFP_KERNEL);
> +	if (IS_ERR(msg))
> +		return PTR_ERR(msg);
> +
> +	request = sg_virt(&msg->sg_request);
> +
> +	request->buffer_bytes = cpu_to_virtio32(vdev, buffer_bytes);
> +	request->period_bytes = cpu_to_virtio32(vdev, period_bytes);
> +	request->channels = channels;
> +	request->format = vformat;
> +	request->rate = vrate;
> +
> +	if (ss->features & (1U << VIRTIO_SND_PCM_F_MSG_POLLING))
> +		request->features |=
> +			cpu_to_virtio32(vdev,
> +					1U << VIRTIO_SND_PCM_F_MSG_POLLING);
> +
> +	if (ss->features & (1U << VIRTIO_SND_PCM_F_EVT_XRUNS))
> +		request->features |=
> +			cpu_to_virtio32(vdev,
> +					1U << VIRTIO_SND_PCM_F_EVT_XRUNS);
> +
> +	rc = virtsnd_ctl_msg_send_sync(ss->snd, msg);
> +	if (rc)
> +		return rc;
> +
> +	/* If the buffer was already allocated earlier, do nothing. */
> +	if (runtime->dma_area)
> +		return 0;
> +
> +	/* Allocate hardware buffer */
> +	rc = snd_pcm_lib_malloc_pages(substream, buffer_bytes);
> +	if (rc < 0)
> +		return rc;
> +
> +	/* Allocate and initialize I/O messages */
> +	rc = virtsnd_pcm_msg_alloc(ss, periods, runtime->dma_area,
> +				   period_bytes);
> +	if (rc)
> +		snd_pcm_lib_free_pages(substream);
> +
> +	return rc;
> +}
> +
> +/**
> + * virtsnd_pcm_hw_free() - Reset the parameters of the PCM substream.
> + * @substream: Kernel ALSA substream.
> + *
> + * The function does the following:
> + *   1. tries to release the PCM substream on the device side,
> + *   2. frees the hardware buffer.
> + *
> + * Context: Any context that permits to sleep.
> + * Return: 0 on success, -errno on failure.
> + */
> +static int virtsnd_pcm_hw_free(struct snd_pcm_substream *substream)
> +{
> +	struct virtio_pcm_substream *ss = snd_pcm_substream_chip(substream);
> +	int rc;
> +
> +	rc = virtsnd_pcm_release(ss);
> +
> +	/*
> +	 * Even if we failed to send the RELEASE message or wait for the queue
> +	 * flush to complete, we can safely delete the buffer. Because after
> +	 * receiving the STOP command, the device must stop all I/O message
> +	 * processing. If there are still pending messages in the queue, the
> +	 * next ops->hw_params() call should deal with this.
> +	 */
> +	snd_pcm_lib_free_pages(substream);
> +
> +	return rc;
> +}
> +
> +/**
> + * virtsnd_pcm_hw_params() - Prepare the PCM substream.
> + * @substream: Kernel ALSA substream.
> + *
> + * The function can be called both from the upper level or from the driver
> + * itself.
> + *
> + * In all cases, the function:
> + *   1. checks the state of the virtqueue and, if necessary, tries to fix it,
> + *   2. prepares the substream on the device side.
> + *
> + * Context: Any context that permits to sleep. May take and release the tx/rx
> + *          queue spinlock.
> + * Return: 0 on success, -errno on failure.
> + */
> +static int virtsnd_pcm_prepare(struct snd_pcm_substream *substream)
> +{
> +	struct virtio_pcm_substream *ss = snd_pcm_substream_chip(substream);
> +	struct virtio_snd_queue *queue = virtsnd_pcm_queue(ss);
> +	struct virtio_snd_msg *msg;
> +	unsigned long flags;
> +	int rc;
> +
> +	/*
> +	 * If we got here after ops->trigger() was called, the queue may
> +	 * still contain messages. In this case, we need to reset the
> +	 * substream first.
> +	 */
> +	if (atomic_read(&ss->msg_count)) {
> +		rc = virtsnd_pcm_hw_params(substream, NULL);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	spin_lock_irqsave(&queue->lock, flags);
> +	ss->msg_last_enqueued = -1;
> +	spin_unlock_irqrestore(&queue->lock, flags);
> +
> +	/*
> +	 * Since I/O messages are asynchronous, they can be completed
> +	 * when the runtime structure no longer exists. Since each
> +	 * completion implies incrementing the hw_ptr, we cache all the
> +	 * current values needed to compute the new hw_ptr value.
> +	 */
> +	ss->frame_bytes = substream->runtime->frame_bits >> 3;
> +	ss->period_size = substream->runtime->period_size;
> +	ss->buffer_size = substream->runtime->buffer_size;
> +
> +	atomic_set(&ss->hw_ptr, 0);
> +	atomic_set(&ss->xfer_xrun, 0);
> +	atomic_set(&ss->msg_count, 0);
> +
> +	msg = virtsnd_pcm_ctl_msg_alloc(ss, VIRTIO_SND_R_PCM_PREPARE,
> +					GFP_KERNEL);
> +	if (IS_ERR(msg))
> +		return PTR_ERR(msg);
> +
> +	return virtsnd_ctl_msg_send_sync(ss->snd, msg);
> +}
> +
> +/**
> + * virtsnd_pcm_trigger() - Process command for the PCM substream.
> + * @substream: Kernel ALSA substream.
> + * @command: Substream command (SNDRV_PCM_TRIGGER_XXX).
> + *
> + * Depending on the command, the function does the following:
> + *   1. enables/disables data transmission,
> + *   2. starts/stops the substream on the device side.
> + *
> + * Context: Atomic context. May take and release the tx/rx queue spinlock.
> + * Return: 0 on success, -errno on failure.
> + */
> +static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream, int command)
> +{
> +	struct virtio_pcm_substream *ss = snd_pcm_substream_chip(substream);
> +	struct virtio_snd *snd = ss->snd;
> +	struct virtio_snd_queue *queue = virtsnd_pcm_queue(ss);
> +	struct virtio_snd_msg *msg;
> +
> +	switch (command) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE: {
> +		int rc;
> +
> +		spin_lock(&queue->lock);
> +		rc = virtsnd_pcm_msg_send(ss);
> +		spin_unlock(&queue->lock);
> +		if (rc)
> +			return rc;
> +
> +		atomic_set(&ss->xfer_enabled, 1);
> +
> +		msg = virtsnd_pcm_ctl_msg_alloc(ss, VIRTIO_SND_R_PCM_START,
> +						GFP_ATOMIC);
> +		if (IS_ERR(msg))
> +			return PTR_ERR(msg);
> +
> +		return virtsnd_ctl_msg_send(snd, msg);
> +	}
> +	case SNDRV_PCM_TRIGGER_STOP:
> +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH: {
> +		atomic_set(&ss->xfer_enabled, 0);
> +
> +		msg = virtsnd_pcm_ctl_msg_alloc(ss, VIRTIO_SND_R_PCM_STOP,
> +						GFP_ATOMIC);
> +		if (IS_ERR(msg))
> +			return PTR_ERR(msg);
> +
> +		return virtsnd_ctl_msg_send(snd, msg);
> +	}
> +	default: {
> +		return -EINVAL;
> +	}
> +	}
> +}
> +
> +/**
> + * virtsnd_pcm_pointer() - Get the current hardware position for the PCM
> + *                         substream.
> + * @substream: Kernel ALSA substream.
> + *
> + * Context: Atomic context.
> + * Return: Hardware position in frames inside [0 ... buffer_size) range.
> + */
> +static snd_pcm_uframes_t
> +virtsnd_pcm_pointer(struct snd_pcm_substream *substream)
> +{
> +	struct virtio_pcm_substream *ss = snd_pcm_substream_chip(substream);
> +
> +	if (atomic_read(&ss->xfer_xrun))
> +		return SNDRV_PCM_POS_XRUN;
> +
> +	return (snd_pcm_uframes_t)atomic_read(&ss->hw_ptr);
> +}
> +
> +/* PCM substream operators map. */
> +const struct snd_pcm_ops virtsnd_pcm_ops = {
> +	.open = virtsnd_pcm_open,
> +	.close = virtsnd_pcm_close,
> +	.ioctl = snd_pcm_lib_ioctl,
> +	.hw_params = virtsnd_pcm_hw_params,
> +	.hw_free = virtsnd_pcm_hw_free,
> +	.prepare = virtsnd_pcm_prepare,
> +	.trigger = virtsnd_pcm_trigger,
> +	.pointer = virtsnd_pcm_pointer,
> +};
> -- 
> 2.30.0
> 
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
