Return-Path: <SRS0=djY9=HY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7D9C433E0
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 15:36:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 573B164E20
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 15:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573B164E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensynergy.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 12C8B6F593;
	Mon, 22 Feb 2021 15:36:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yqp_YDRcMjhw; Mon, 22 Feb 2021 15:36:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id BBAB76F592;
	Mon, 22 Feb 2021 15:36:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90AF9C000A;
	Mon, 22 Feb 2021 15:36:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57DCBC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 15:36:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 468BE83A5B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 15:36:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7Bsouf62Z0pQ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 15:36:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx1.opensynergy.com (mx1.opensynergy.com [217.66.60.4])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DDBF583A4D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 15:36:16 +0000 (UTC)
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain
 [127.0.0.1])
 by mx1.opensynergy.com (Proxmox) with ESMTP id 33789A14A7;
 Mon, 22 Feb 2021 16:36:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=srmailgate02; bh=tuDb2fy+F9pm
 lwl+XuHxd5FvHF35SjkQIHk2gLHS0Pg=; b=3KNlTEK0J87x2tmzqa58gXnJvizb
 ebtmJu0f4DBp5rHdnq1BfO7AjvFm3YXJNAHJNAMS5tqHYOtorWHWsMDGKTtJaOF1
 HHd9uzcLKRW6BXAvDz5oMlTNBGVRMbD5LsSjbF2TzNJba/B646MzajV8njhJNPNH
 JKuNmv5kNviIw19R2lfLh63vwoZ6xJfxi7in+A1Di0XWF1CH/3GQvCCxkqZFX5ZB
 OGynfnKcafpUL5fYyJt9eLRwQPOvNUBrBA0ynAOUnumE2qheMlt/FDVGAY8YLvQE
 Y2jdRjJbx5kYvU0ArYIjJEQRuNpvDXnBX8HZsnghg3azgIviQ5QMmbfSXw==
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
To: <virtualization@lists.linux-foundation.org>,
 <alsa-devel@alsa-project.org>, <virtio-dev@lists.oasis-open.org>
Subject: [PATCH v5 7/9] ALSA: virtio: introduce jack support
Date: Mon, 22 Feb 2021 16:34:42 +0100
Message-ID: <20210222153444.348390-8-anton.yakovlev@opensynergy.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210222153444.348390-1-anton.yakovlev@opensynergy.com>
References: <20210222153444.348390-1-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
 SR-MAIL-02.open-synergy.com (10.26.10.22)
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>
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
 sound/virtio/Makefile      |   1 +
 sound/virtio/virtio_card.c |  14 +++
 sound/virtio/virtio_card.h |  12 ++
 sound/virtio/virtio_jack.c | 233 +++++++++++++++++++++++++++++++++++++
 4 files changed, 260 insertions(+)
 create mode 100644 sound/virtio/virtio_jack.c

diff --git a/sound/virtio/Makefile b/sound/virtio/Makefile
index 34493226793f..09f485291285 100644
--- a/sound/virtio/Makefile
+++ b/sound/virtio/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_SND_VIRTIO) += virtio_snd.o
 virtio_snd-objs := \
 	virtio_card.o \
 	virtio_ctl_msg.o \
+	virtio_jack.o \
 	virtio_pcm.o \
 	virtio_pcm_msg.o \
 	virtio_pcm_ops.o
diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
index a845978111d6..4578d0ce0726 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -67,6 +67,10 @@ static void virtsnd_event_notify_cb(struct virtqueue *vqueue)
 		virtqueue_disable_cb(vqueue);
 		while ((event = virtqueue_get_buf(vqueue, &length))) {
 			switch (le32_to_cpu(event->hdr.code)) {
+			case VIRTIO_SND_EVT_JACK_CONNECTED:
+			case VIRTIO_SND_EVT_JACK_DISCONNECTED:
+				virtsnd_jack_event(snd, event);
+				break;
 			case VIRTIO_SND_EVT_PCM_PERIOD_ELAPSED:
 			case VIRTIO_SND_EVT_PCM_XRUN:
 				virtsnd_pcm_event(snd, event);
@@ -210,10 +214,20 @@ static int virtsnd_build_devs(struct virtio_snd *snd)
 			 VIRTIO_SND_CARD_NAME " at %s/%s",
 			 dev_name(dev->parent), dev_name(dev));
 
+	rc = virtsnd_jack_parse_cfg(snd);
+	if (rc)
+		return rc;
+
 	rc = virtsnd_pcm_parse_cfg(snd);
 	if (rc)
 		return rc;
 
+	if (snd->njacks) {
+		rc = virtsnd_jack_build_devs(snd);
+		if (rc)
+			return rc;
+	}
+
 	if (snd->nsubstreams) {
 		rc = virtsnd_pcm_build_devs(snd);
 		if (rc)
diff --git a/sound/virtio/virtio_card.h b/sound/virtio/virtio_card.h
index 3d8f5ad92f79..37896a030e10 100644
--- a/sound/virtio/virtio_card.h
+++ b/sound/virtio/virtio_card.h
@@ -18,6 +18,7 @@
 #define VIRTIO_SND_CARD_NAME	"VirtIO SoundCard"
 #define VIRTIO_SND_PCM_NAME	"VirtIO PCM"
 
+struct virtio_jack;
 struct virtio_pcm_substream;
 
 /**
@@ -39,6 +40,8 @@ struct virtio_snd_queue {
  * @ctl_msgs: Pending control request list.
  * @event_msgs: Device events.
  * @pcm_list: VirtIO PCM device list.
+ * @jacks: VirtIO jacks.
+ * @njacks: Number of jacks.
  * @substreams: VirtIO PCM substreams.
  * @nsubstreams: Number of PCM substreams.
  */
@@ -50,6 +53,8 @@ struct virtio_snd {
 	struct list_head ctl_msgs;
 	struct virtio_snd_event *event_msgs;
 	struct list_head pcm_list;
+	struct virtio_jack *jacks;
+	u32 njacks;
 	struct virtio_pcm_substream *substreams;
 	u32 nsubstreams;
 };
@@ -90,4 +95,11 @@ virtsnd_pcm_queue(struct virtio_pcm_substream *vss)
 		return virtsnd_rx_queue(vss->snd);
 }
 
+int virtsnd_jack_parse_cfg(struct virtio_snd *snd);
+
+int virtsnd_jack_build_devs(struct virtio_snd *snd);
+
+void virtsnd_jack_event(struct virtio_snd *snd,
+			struct virtio_snd_event *event);
+
 #endif /* VIRTIO_SND_CARD_H */
diff --git a/sound/virtio/virtio_jack.c b/sound/virtio/virtio_jack.c
new file mode 100644
index 000000000000..c69f1dcdcc84
--- /dev/null
+++ b/sound/virtio/virtio_jack.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * virtio-snd: Virtio sound device
+ * Copyright (C) 2021 OpenSynergy GmbH
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
+	u32 nid;
+	u32 features;
+	u32 defconf;
+	u32 caps;
+	bool connected;
+	int type;
+};
+
+/**
+ * virtsnd_jack_get_label() - Get the name string for the jack.
+ * @vjack: VirtIO jack.
+ *
+ * Returns the jack name based on the default pin configuration value (see HDA
+ * specification).
+ *
+ * Context: Any context.
+ * Return: Name string.
+ */
+static const char *virtsnd_jack_get_label(struct virtio_jack *vjack)
+{
+	unsigned int defconf = vjack->defconf;
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
+ * @vjack: VirtIO jack.
+ *
+ * Returns the jack type based on the default pin configuration value (see HDA
+ * specification).
+ *
+ * Context: Any context.
+ * Return: SND_JACK_XXX value.
+ */
+static int virtsnd_jack_get_type(struct virtio_jack *vjack)
+{
+	unsigned int defconf = vjack->defconf;
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
+	u32 i;
+	int rc;
+
+	virtio_cread_le(vdev, struct virtio_snd_config, jacks, &snd->njacks);
+	if (!snd->njacks)
+		return 0;
+
+	snd->jacks = devm_kcalloc(&vdev->dev, snd->njacks, sizeof(*snd->jacks),
+				  GFP_KERNEL);
+	if (!snd->jacks)
+		return -ENOMEM;
+
+	info = kcalloc(snd->njacks, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	rc = virtsnd_ctl_query_info(snd, VIRTIO_SND_R_JACK_INFO, 0, snd->njacks,
+				    sizeof(*info), info);
+	if (rc)
+		goto on_exit;
+
+	for (i = 0; i < snd->njacks; ++i) {
+		struct virtio_jack *vjack = &snd->jacks[i];
+
+		vjack->nid = le32_to_cpu(info[i].hdr.hda_fn_nid);
+		vjack->features = le32_to_cpu(info[i].features);
+		vjack->defconf = le32_to_cpu(info[i].hda_reg_defconf);
+		vjack->caps = le32_to_cpu(info[i].hda_reg_caps);
+		vjack->connected = info[i].connected;
+	}
+
+on_exit:
+	kfree(info);
+
+	return rc;
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
+	u32 i;
+	int rc;
+
+	for (i = 0; i < snd->njacks; ++i) {
+		struct virtio_jack *vjack = &snd->jacks[i];
+
+		vjack->type = virtsnd_jack_get_type(vjack);
+
+		rc = snd_jack_new(snd->card, virtsnd_jack_get_label(vjack),
+				  vjack->type, &vjack->jack, true, true);
+		if (rc)
+			return rc;
+
+		if (vjack->jack)
+			vjack->jack->private_data = vjack;
+
+		snd_jack_report(vjack->jack,
+				vjack->connected ? vjack->type : 0);
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
+	u32 jack_id = le32_to_cpu(event->data);
+	struct virtio_jack *vjack;
+
+	if (jack_id >= snd->njacks)
+		return;
+
+	vjack = &snd->jacks[jack_id];
+
+	switch (le32_to_cpu(event->hdr.code)) {
+	case VIRTIO_SND_EVT_JACK_CONNECTED:
+		vjack->connected = true;
+		break;
+	case VIRTIO_SND_EVT_JACK_DISCONNECTED:
+		vjack->connected = false;
+		break;
+	default:
+		return;
+	}
+
+	snd_jack_report(vjack->jack, vjack->connected ? vjack->type : 0);
+}
-- 
2.30.0


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
