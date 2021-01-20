Return-Path: <SRS0=zQmE=GX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63629C433DB
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 00:45:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 077DB22C9E
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 00:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 077DB22C9E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensynergy.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CFDEF20427;
	Wed, 20 Jan 2021 00:45:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TL1CtlLCrmEB; Wed, 20 Jan 2021 00:45:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7BCD520500;
	Wed, 20 Jan 2021 00:45:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7046BC1DA7;
	Wed, 20 Jan 2021 00:45:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27414C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 00:45:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 16B598562A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 00:45:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u12CSGmMYWFZ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 00:45:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.opensynergy.com (mx1.opensynergy.com [217.66.60.4])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 48D148562D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 00:45:23 +0000 (UTC)
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain
 [127.0.0.1])
 by mx1.opensynergy.com (Proxmox) with ESMTP id BE49CA13C8;
 Wed, 20 Jan 2021 01:37:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=srmailgate02; bh=IJVMtXqnax96
 B9/YfAGeu75vBiqA/iJNNymrA78P9nQ=; b=ty+ShAziBuJICni1SkcU8Qcvek+n
 3NwIzK1K+A9duaF1EwGWBZtgp57yrxGFdu7kfolEEah7huhg+Q1P/BEqQcHceO/Q
 lr1SOQRgjgKdISUtib7EyZB1VHj06vKHoGgf9i0rPO8hpIpsniVjkkqUGzSfsHRl
 w0uMO8GSKiIutCe1zLJQn6GOA7tHYBoilSqfXI5+20CwqOg7TDOOL2HGqiYWS68y
 58hBRkWiQQMAkWF7kvfTs4ikFJqnRHHEDMLysGd3W/qDeGRpZtNGIymQcy1yEmxP
 29xaOGR1QpfR3O4F5UqfRzDmYKh/lvL5X5SKy9EwRVpAqtc5wgvPeslfOQ==
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
To: <virtualization@lists.linux-foundation.org>,
 <alsa-devel@alsa-project.org>, <virtio-dev@lists.oasis-open.org>
Subject: [PATCH 6/7] ALSA: virtio: introduce jack support
Date: Wed, 20 Jan 2021 01:36:34 +0100
Message-ID: <20210120003638.3339987-7-anton.yakovlev@opensynergy.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210120003638.3339987-1-anton.yakovlev@opensynergy.com>
References: <20210120003638.3339987-1-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
X-ClientProxiedBy: SR-MAIL-02.open-synergy.com (10.26.10.22) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
Cc: linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Jaroslav Kysela <perex@perex.cz>
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

Enumerate all available jacks and create ALSA controls.

At the moment jacks have a simple implementation and can only be used
to receive notifications about a plugged in/out device.

Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
---
 sound/virtio/Makefile       |   2 +
 sound/virtio/virtio_card.c  |  33 +++++
 sound/virtio/virtio_card.h  |  20 +++
 sound/virtio/virtio_chmap.c | 237 +++++++++++++++++++++++++++++++++
 sound/virtio/virtio_jack.c  | 255 ++++++++++++++++++++++++++++++++++++
 sound/virtio/virtio_pcm.h   |   4 +
 6 files changed, 551 insertions(+)
 create mode 100644 sound/virtio/virtio_chmap.c
 create mode 100644 sound/virtio/virtio_jack.c

diff --git a/sound/virtio/Makefile b/sound/virtio/Makefile
index 34493226793f..2742bddb8874 100644
--- a/sound/virtio/Makefile
+++ b/sound/virtio/Makefile
@@ -4,7 +4,9 @@ obj-$(CONFIG_SND_VIRTIO) += virtio_snd.o
 
 virtio_snd-objs := \
 	virtio_card.o \
+	virtio_chmap.o \
 	virtio_ctl_msg.o \
+	virtio_jack.o \
 	virtio_pcm.o \
 	virtio_pcm_msg.o \
 	virtio_pcm_ops.o
diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
index dc703fc662f5..02814c3932ab 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -94,6 +94,11 @@ static void virtsnd_event_notify_cb(struct virtqueue *vqueue)
 				break;
 
 			switch (le32_to_cpu(event->hdr.code)) {
+			case VIRTIO_SND_EVT_JACK_CONNECTED:
+			case VIRTIO_SND_EVT_JACK_DISCONNECTED: {
+				virtsnd_jack_event(snd, event);
+				break;
+			}
 			case VIRTIO_SND_EVT_PCM_PERIOD_ELAPSED:
 			case VIRTIO_SND_EVT_PCM_XRUN: {
 				virtsnd_pcm_event(snd, event);
@@ -322,16 +327,36 @@ static int virtsnd_build_devs(struct virtio_snd *snd)
 	strscpy(snd->card->longname, "VirtIO Sound Card",
 		sizeof(snd->card->longname));
 
+	rc = virtsnd_jack_parse_cfg(snd);
+	if (rc)
+		return rc;
+
 	rc = virtsnd_pcm_parse_cfg(snd);
 	if (rc)
 		return rc;
 
+	rc = virtsnd_chmap_parse_cfg(snd);
+	if (rc)
+		return rc;
+
+	if (snd->njacks) {
+		rc = virtsnd_jack_build_devs(snd);
+		if (rc)
+			return rc;
+	}
+
 	if (snd->nsubstreams) {
 		rc = virtsnd_pcm_build_devs(snd);
 		if (rc)
 			return rc;
 	}
 
+	if (snd->nchmaps) {
+		rc = virtsnd_chmap_build_devs(snd);
+		if (rc)
+			return rc;
+	}
+
 	return snd_card_register(snd->card);
 }
 
@@ -439,14 +464,22 @@ static void virtsnd_remove(struct virtio_device *vdev)
 
 			if (stream->substreams)
 				devm_kfree(&vdev->dev, stream->substreams);
+			if (stream->chmaps)
+				devm_kfree(&vdev->dev, stream->chmaps);
 		}
 
 		devm_kfree(&vdev->dev, pcm);
 	}
 
+	if (snd->jacks)
+		devm_kfree(&vdev->dev, snd->jacks);
+
 	if (snd->substreams)
 		devm_kfree(&vdev->dev, snd->substreams);
 
+	if (snd->chmaps)
+		devm_kfree(&vdev->dev, snd->chmaps);
+
 	devm_kfree(&vdev->dev, snd);
 
 	vdev->priv = NULL;
diff --git a/sound/virtio/virtio_card.h b/sound/virtio/virtio_card.h
index b11c09984882..09c6e9ab80ca 100644
--- a/sound/virtio/virtio_card.h
+++ b/sound/virtio/virtio_card.h
@@ -26,6 +26,7 @@
 #include "virtio_ctl_msg.h"
 #include "virtio_pcm.h"
 
+struct virtio_jack;
 struct virtio_pcm_substream;
 
 /**
@@ -47,8 +48,12 @@ struct virtio_snd_queue {
  * @ctl_msgs: Pending control request list.
  * @event_msgs: Device events.
  * @pcm_list: VirtIO PCM device list.
+ * @jacks: VirtIO jacks.
+ * @njacks: Number of jacks.
  * @substreams: VirtIO PCM substreams.
  * @nsubstreams: Number of PCM substreams.
+ * @chmaps: VirtIO channel maps.
+ * @nchmaps: Number of channel maps.
  */
 struct virtio_snd {
 	struct virtio_device *vdev;
@@ -58,8 +63,12 @@ struct virtio_snd {
 	struct list_head ctl_msgs;
 	struct virtio_snd_event *event_msgs;
 	struct list_head pcm_list;
+	struct virtio_jack *jacks;
+	unsigned int njacks;
 	struct virtio_pcm_substream *substreams;
 	unsigned int nsubstreams;
+	struct virtio_snd_chmap_info *chmaps;
+	unsigned int nchmaps;
 };
 
 /* Message completion timeout in milliseconds (module parameter). */
@@ -98,4 +107,15 @@ virtsnd_pcm_queue(struct virtio_pcm_substream *substream)
 		return virtsnd_rx_queue(substream->snd);
 }
 
+int virtsnd_jack_parse_cfg(struct virtio_snd *snd);
+
+int virtsnd_jack_build_devs(struct virtio_snd *snd);
+
+void virtsnd_jack_event(struct virtio_snd *snd,
+			struct virtio_snd_event *event);
+
+int virtsnd_chmap_parse_cfg(struct virtio_snd *snd);
+
+int virtsnd_chmap_build_devs(struct virtio_snd *snd);
+
 #endif /* VIRTIO_SND_CARD_H */
diff --git a/sound/virtio/virtio_chmap.c b/sound/virtio/virtio_chmap.c
new file mode 100644
index 000000000000..8a2ddc4dcffb
--- /dev/null
+++ b/sound/virtio/virtio_chmap.c
@@ -0,0 +1,237 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Sound card driver for virtio
+ * Copyright (C) 2020  OpenSynergy GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/virtio_config.h>
+
+#include "virtio_card.h"
+
+/* VirtIO->ALSA channel position map */
+static const u8 g_v2a_position_map[] = {
+	[VIRTIO_SND_CHMAP_NONE] = SNDRV_CHMAP_UNKNOWN,
+	[VIRTIO_SND_CHMAP_NA] = SNDRV_CHMAP_NA,
+	[VIRTIO_SND_CHMAP_MONO] = SNDRV_CHMAP_MONO,
+	[VIRTIO_SND_CHMAP_FL] = SNDRV_CHMAP_FL,
+	[VIRTIO_SND_CHMAP_FR] = SNDRV_CHMAP_FR,
+	[VIRTIO_SND_CHMAP_RL] = SNDRV_CHMAP_RL,
+	[VIRTIO_SND_CHMAP_RR] = SNDRV_CHMAP_RR,
+	[VIRTIO_SND_CHMAP_FC] = SNDRV_CHMAP_FC,
+	[VIRTIO_SND_CHMAP_LFE] = SNDRV_CHMAP_LFE,
+	[VIRTIO_SND_CHMAP_SL] = SNDRV_CHMAP_SL,
+	[VIRTIO_SND_CHMAP_SR] = SNDRV_CHMAP_SR,
+	[VIRTIO_SND_CHMAP_RC] = SNDRV_CHMAP_RC,
+	[VIRTIO_SND_CHMAP_FLC] = SNDRV_CHMAP_FLC,
+	[VIRTIO_SND_CHMAP_FRC] = SNDRV_CHMAP_FRC,
+	[VIRTIO_SND_CHMAP_RLC] = SNDRV_CHMAP_RLC,
+	[VIRTIO_SND_CHMAP_RRC] = SNDRV_CHMAP_RRC,
+	[VIRTIO_SND_CHMAP_FLW] = SNDRV_CHMAP_FLW,
+	[VIRTIO_SND_CHMAP_FRW] = SNDRV_CHMAP_FRW,
+	[VIRTIO_SND_CHMAP_FLH] = SNDRV_CHMAP_FLH,
+	[VIRTIO_SND_CHMAP_FCH] = SNDRV_CHMAP_FCH,
+	[VIRTIO_SND_CHMAP_FRH] = SNDRV_CHMAP_FRH,
+	[VIRTIO_SND_CHMAP_TC] = SNDRV_CHMAP_TC,
+	[VIRTIO_SND_CHMAP_TFL] = SNDRV_CHMAP_TFL,
+	[VIRTIO_SND_CHMAP_TFR] = SNDRV_CHMAP_TFR,
+	[VIRTIO_SND_CHMAP_TFC] = SNDRV_CHMAP_TFC,
+	[VIRTIO_SND_CHMAP_TRL] = SNDRV_CHMAP_TRL,
+	[VIRTIO_SND_CHMAP_TRR] = SNDRV_CHMAP_TRR,
+	[VIRTIO_SND_CHMAP_TRC] = SNDRV_CHMAP_TRC,
+	[VIRTIO_SND_CHMAP_TFLC] = SNDRV_CHMAP_TFLC,
+	[VIRTIO_SND_CHMAP_TFRC] = SNDRV_CHMAP_TFRC,
+	[VIRTIO_SND_CHMAP_TSL] = SNDRV_CHMAP_TSL,
+	[VIRTIO_SND_CHMAP_TSR] = SNDRV_CHMAP_TSR,
+	[VIRTIO_SND_CHMAP_LLFE] = SNDRV_CHMAP_LLFE,
+	[VIRTIO_SND_CHMAP_RLFE] = SNDRV_CHMAP_RLFE,
+	[VIRTIO_SND_CHMAP_BC] = SNDRV_CHMAP_BC,
+	[VIRTIO_SND_CHMAP_BLC] = SNDRV_CHMAP_BLC,
+	[VIRTIO_SND_CHMAP_BRC] = SNDRV_CHMAP_BRC
+};
+
+/**
+ * virtsnd_chmap_parse_cfg() - Parse the channel map configuration.
+ * @snd: VirtIO sound device.
+ *
+ * This function is called during initial device initialization.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+int virtsnd_chmap_parse_cfg(struct virtio_snd *snd)
+{
+	struct virtio_device *vdev = snd->vdev;
+	unsigned int i;
+	int rc;
+
+	virtio_cread(vdev, struct virtio_snd_config, chmaps, &snd->nchmaps);
+	if (!snd->nchmaps)
+		return 0;
+
+	snd->chmaps = devm_kcalloc(&vdev->dev, snd->nchmaps,
+				   sizeof(*snd->chmaps), GFP_KERNEL);
+	if (!snd->chmaps)
+		return -ENOMEM;
+
+	rc = virtsnd_ctl_query_info(snd, VIRTIO_SND_R_CHMAP_INFO, 0,
+				    snd->nchmaps, sizeof(*snd->chmaps),
+				    snd->chmaps);
+	if (rc)
+		return rc;
+
+	/* Count the number of channel maps per each PCM device/stream. */
+	for (i = 0; i < snd->nchmaps; ++i) {
+		struct virtio_snd_chmap_info *info = &snd->chmaps[i];
+		unsigned int nid = le32_to_cpu(info->hdr.hda_fn_nid);
+		struct virtio_pcm *pcm;
+		struct virtio_pcm_stream *stream;
+
+		pcm = virtsnd_pcm_find_or_create(snd, nid);
+		if (IS_ERR(pcm))
+			return PTR_ERR(pcm);
+
+		switch (info->direction) {
+		case VIRTIO_SND_D_OUTPUT: {
+			stream = &pcm->streams[SNDRV_PCM_STREAM_PLAYBACK];
+			break;
+		}
+		case VIRTIO_SND_D_INPUT: {
+			stream = &pcm->streams[SNDRV_PCM_STREAM_CAPTURE];
+			break;
+		}
+		default: {
+			dev_err(&vdev->dev,
+				"chmap #%u: unknown direction (%u)\n", i,
+				info->direction);
+			return -EINVAL;
+		}
+		}
+
+		stream->nchmaps++;
+	}
+
+	return 0;
+}
+
+/**
+ * virtsnd_chmap_add_ctls() - Create an ALSA control for channel maps.
+ * @pcm: ALSA PCM device.
+ * @direction: PCM stream direction (SNDRV_PCM_STREAM_XXX).
+ * @stream: VirtIO PCM stream.
+ *
+ * Context: Any context.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_chmap_add_ctls(struct snd_pcm *pcm, int direction,
+				  struct virtio_pcm_stream *stream)
+{
+	unsigned int i;
+	int max_channels = 0;
+
+	for (i = 0; i < stream->nchmaps; i++)
+		if (max_channels < stream->chmaps[i].channels)
+			max_channels = stream->chmaps[i].channels;
+
+	return snd_pcm_add_chmap_ctls(pcm, direction, stream->chmaps,
+				      max_channels, 0, NULL);
+}
+
+/**
+ * virtsnd_chmap_build_devs() - Build ALSA controls for channel maps.
+ * @snd: VirtIO sound device.
+ *
+ * Context: Any context.
+ * Return: 0 on success, -errno on failure.
+ */
+int virtsnd_chmap_build_devs(struct virtio_snd *snd)
+{
+	struct virtio_device *vdev = snd->vdev;
+	struct virtio_pcm *pcm;
+	struct virtio_pcm_stream *stream;
+	unsigned int i;
+	int rc;
+
+	/* Allocate channel map elements per each PCM device/stream. */
+	list_for_each_entry(pcm, &snd->pcm_list, list) {
+		for (i = 0; i < ARRAY_SIZE(pcm->streams); ++i) {
+			stream = &pcm->streams[i];
+
+			if (!stream->nchmaps)
+				continue;
+
+			stream->chmaps = devm_kcalloc(&vdev->dev,
+						      stream->nchmaps + 1,
+						      sizeof(*stream->chmaps),
+						      GFP_KERNEL);
+			if (!stream->chmaps)
+				return -ENOMEM;
+
+			stream->nchmaps = 0;
+		}
+	}
+
+	/* Initialize channel maps per each PCM device/stream. */
+	for (i = 0; i < snd->nchmaps; ++i) {
+		struct virtio_snd_chmap_info *info = &snd->chmaps[i];
+		unsigned int nid = le32_to_cpu(info->hdr.hda_fn_nid);
+		unsigned int channels = info->channels;
+		unsigned int ch;
+		struct snd_pcm_chmap_elem *chmap;
+
+		pcm = virtsnd_pcm_find(snd, nid);
+		if (IS_ERR(pcm))
+			return PTR_ERR(pcm);
+
+		if (info->direction == VIRTIO_SND_D_OUTPUT)
+			stream = &pcm->streams[SNDRV_PCM_STREAM_PLAYBACK];
+		else
+			stream = &pcm->streams[SNDRV_PCM_STREAM_CAPTURE];
+
+		chmap = &stream->chmaps[stream->nchmaps++];
+
+		if (channels > ARRAY_SIZE(chmap->map))
+			channels = ARRAY_SIZE(chmap->map);
+
+		chmap->channels = channels;
+
+		for (ch = 0; ch < channels; ++ch) {
+			u8 position = info->positions[ch];
+
+			if (position >= ARRAY_SIZE(g_v2a_position_map))
+				return -EINVAL;
+
+			chmap->map[ch] = g_v2a_position_map[position];
+		}
+	}
+
+	/* Create an ALSA control per each PCM device/stream. */
+	list_for_each_entry(pcm, &snd->pcm_list, list) {
+		if (!pcm->pcm)
+			continue;
+
+		for (i = 0; i < ARRAY_SIZE(pcm->streams); ++i) {
+			stream = &pcm->streams[i];
+
+			if (!stream->nchmaps)
+				continue;
+
+			rc = virtsnd_chmap_add_ctls(pcm->pcm, i, stream);
+			if (rc)
+				return rc;
+		}
+	}
+
+	return 0;
+}
diff --git a/sound/virtio/virtio_jack.c b/sound/virtio/virtio_jack.c
new file mode 100644
index 000000000000..83593c59f6bf
--- /dev/null
+++ b/sound/virtio/virtio_jack.c
@@ -0,0 +1,255 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Sound card driver for virtio
+ * Copyright (C) 2020  OpenSynergy GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/virtio_config.h>
+#include <sound/jack.h>
+#include <sound/hda_verbs.h>
+
+#include "virtio_card.h"
+
+/**
+ * DOC: Implementation Status
+ *
+ * At the moment jacks have a simple implementation and can only be used to
+ * receive notifications about a plugged in/out device.
+ *
+ * VIRTIO_SND_R_JACK_REMAP
+ *   is not supported
+ */
+
+/**
+ * struct virtio_jack - VirtIO jack.
+ * @jack: Kernel jack control.
+ * @nid: Functional group node identifier.
+ * @features: Jack virtio feature bit map (1 << VIRTIO_SND_JACK_F_XXX).
+ * @defconf: Pin default configuration value.
+ * @caps: Pin capabilities value.
+ * @connected: Current jack connection status.
+ * @type: Kernel jack type (SND_JACK_XXX).
+ */
+struct virtio_jack {
+	struct snd_jack *jack;
+	unsigned int nid;
+	unsigned int features;
+	unsigned int defconf;
+	unsigned int caps;
+	bool connected;
+	int type;
+};
+
+/**
+ * virtsnd_jack_get_label() - Get the name string for the jack.
+ * @jack: VirtIO jack.
+ *
+ * Returns the jack name based on the default pin configuration value (see HDA
+ * specification).
+ *
+ * Context: Any context.
+ * Return: Name string.
+ */
+static const char *virtsnd_jack_get_label(struct virtio_jack *jack)
+{
+	unsigned int defconf = jack->defconf;
+	unsigned int device =
+		(defconf & AC_DEFCFG_DEVICE) >> AC_DEFCFG_DEVICE_SHIFT;
+	unsigned int location =
+		(defconf & AC_DEFCFG_LOCATION) >> AC_DEFCFG_LOCATION_SHIFT;
+
+	switch (device) {
+	case AC_JACK_LINE_OUT:
+		return "Line Out";
+	case AC_JACK_SPEAKER:
+		return "Speaker";
+	case AC_JACK_HP_OUT:
+		return "Headphone";
+	case AC_JACK_CD:
+		return "CD";
+	case AC_JACK_SPDIF_OUT:
+	case AC_JACK_DIG_OTHER_OUT:
+		if (location == AC_JACK_LOC_HDMI)
+			return "HDMI Out";
+		else
+			return "SPDIF Out";
+	case AC_JACK_LINE_IN:
+		return "Line";
+	case AC_JACK_AUX:
+		return "Aux";
+	case AC_JACK_MIC_IN:
+		return "Mic";
+	case AC_JACK_SPDIF_IN:
+		return "SPDIF In";
+	case AC_JACK_DIG_OTHER_IN:
+		return "Digital In";
+	default:
+		return "Misc";
+	}
+}
+
+/**
+ * virtsnd_jack_get_type() - Get the type for the jack.
+ * @jack: VirtIO jack.
+ *
+ * Returns the jack type based on the default pin configuration value (see HDA
+ * specification).
+ *
+ * Context: Any context.
+ * Return: SND_JACK_XXX value.
+ */
+static int virtsnd_jack_get_type(struct virtio_jack *jack)
+{
+	unsigned int defconf = jack->defconf;
+	unsigned int device =
+		(defconf & AC_DEFCFG_DEVICE) >> AC_DEFCFG_DEVICE_SHIFT;
+
+	switch (device) {
+	case AC_JACK_LINE_OUT:
+	case AC_JACK_SPEAKER:
+		return SND_JACK_LINEOUT;
+	case AC_JACK_HP_OUT:
+		return SND_JACK_HEADPHONE;
+	case AC_JACK_SPDIF_OUT:
+	case AC_JACK_DIG_OTHER_OUT:
+		return SND_JACK_AVOUT;
+	case AC_JACK_MIC_IN:
+		return SND_JACK_MICROPHONE;
+	default:
+		return SND_JACK_LINEIN;
+	}
+}
+
+/**
+ * virtsnd_jack_parse_cfg() - Parse the jack configuration.
+ * @snd: VirtIO sound device.
+ *
+ * This function is called during initial device initialization.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+int virtsnd_jack_parse_cfg(struct virtio_snd *snd)
+{
+	struct virtio_device *vdev = snd->vdev;
+	struct virtio_snd_jack_info *info;
+	unsigned int i;
+	int rc;
+
+	virtio_cread(vdev, struct virtio_snd_config, jacks, &snd->njacks);
+	if (!snd->njacks)
+		return 0;
+
+	snd->jacks = devm_kcalloc(&vdev->dev, snd->njacks, sizeof(*snd->jacks),
+				  GFP_KERNEL);
+	if (!snd->jacks)
+		return -ENOMEM;
+
+	info = devm_kcalloc(&vdev->dev, snd->njacks, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	rc = virtsnd_ctl_query_info(snd, VIRTIO_SND_R_JACK_INFO, 0, snd->njacks,
+				    sizeof(*info), info);
+	if (rc)
+		return rc;
+
+	for (i = 0; i < snd->njacks; ++i) {
+		struct virtio_jack *jack = &snd->jacks[i];
+		struct virtio_pcm *pcm;
+
+		jack->nid = le32_to_cpu(info[i].hdr.hda_fn_nid);
+		jack->features = le32_to_cpu(info[i].features);
+		jack->defconf = le32_to_cpu(info[i].hda_reg_defconf);
+		jack->caps = le32_to_cpu(info[i].hda_reg_caps);
+		jack->connected = info[i].connected;
+
+		pcm = virtsnd_pcm_find_or_create(snd, jack->nid);
+		if (IS_ERR(pcm))
+			return PTR_ERR(pcm);
+	}
+
+	devm_kfree(&vdev->dev, info);
+
+	return 0;
+}
+
+/**
+ * virtsnd_jack_build_devs() - Build ALSA controls for jacks.
+ * @snd: VirtIO sound device.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+int virtsnd_jack_build_devs(struct virtio_snd *snd)
+{
+	unsigned int i;
+	int rc;
+
+	for (i = 0; i < snd->njacks; ++i) {
+		struct virtio_jack *jack = &snd->jacks[i];
+
+		jack->type = virtsnd_jack_get_type(jack);
+
+		rc = snd_jack_new(snd->card, virtsnd_jack_get_label(jack),
+				  jack->type, &jack->jack, true, true);
+		if (rc)
+			return rc;
+
+		if (!jack->jack)
+			continue;
+
+		jack->jack->private_data = jack;
+
+		snd_jack_report(jack->jack,
+				jack->connected ? jack->type : 0);
+	}
+
+	return 0;
+}
+
+/**
+ * virtsnd_jack_event() - Handle the jack event notification.
+ * @snd: VirtIO sound device.
+ * @event: VirtIO sound event.
+ *
+ * Context: Interrupt context.
+ */
+void virtsnd_jack_event(struct virtio_snd *snd, struct virtio_snd_event *event)
+{
+	unsigned int jack_id = le32_to_cpu(event->data);
+	struct virtio_jack *jack;
+
+	if (jack_id >= snd->njacks)
+		return;
+
+	jack = &snd->jacks[jack_id];
+
+	switch (le32_to_cpu(event->hdr.code)) {
+	case VIRTIO_SND_EVT_JACK_CONNECTED: {
+		jack->connected = true;
+		break;
+	}
+	case VIRTIO_SND_EVT_JACK_DISCONNECTED: {
+		jack->connected = false;
+		break;
+	}
+	default: {
+		return;
+	}
+	}
+
+	snd_jack_report(jack->jack, jack->connected ? jack->type : 0);
+}
diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
index fe467bc05d8b..a326b921b947 100644
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -70,10 +70,14 @@ struct virtio_pcm_substream {
  * struct virtio_pcm_stream - VirtIO PCM stream.
  * @substreams: Virtio substreams belonging to the stream.
  * @nsubstreams: Number of substreams.
+ * @chmaps: Kernel channel maps belonging to the stream.
+ * @nchmaps: Number of channel maps.
  */
 struct virtio_pcm_stream {
 	struct virtio_pcm_substream **substreams;
 	unsigned int nsubstreams;
+	struct snd_pcm_chmap_elem *chmaps;
+	unsigned int nchmaps;
 };
 
 /**
-- 
2.30.0


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
