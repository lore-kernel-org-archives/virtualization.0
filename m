Return-Path: <SRS0=LnXi=IA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF001C433DB
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 16:48:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EAFE64F0D
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 16:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EAFE64F0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensynergy.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D33F83AC3;
	Tue,  2 Mar 2021 16:48:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YJe99jmmgej5; Tue,  2 Mar 2021 16:48:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7B59483AC6;
	Tue,  2 Mar 2021 16:48:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52F65C000A;
	Tue,  2 Mar 2021 16:48:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C49B8C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 16:48:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B3B1A83AC6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 16:48:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gusc5rkCOPOY
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 16:48:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx1.opensynergy.com (mx1.opensynergy.com [217.66.60.4])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D6AD483AC3
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 16:48:03 +0000 (UTC)
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain
 [127.0.0.1])
 by mx1.opensynergy.com (Proxmox) with ESMTP id D10B9A17C5;
 Tue,  2 Mar 2021 17:48:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=srmailgate02; bh=Iq2O+faTDVb2
 vlZ2E3J4cQ1DqJ4S6FQ6CtKxj20OPQk=; b=GQmy+uqTDKQMXUfXaTOMxHbzM90U
 Xc12b7KSYDXBgpIBWyic2EXqMqnCUxPk524Jtg+/ttlnits6oevMe0UEhs0kZ3G6
 fLPxvbCMKlqGQREzs8NC4Tf2vDS8VuvGUqdtoXqyNOXlbP7ZJrxFDdMoY8UNQ1Jf
 Gom5ot4aEZLMb/yVb4I0vThpupY/Ubn3h//xuliIuM8i9XZLjKy8rx8lIG/RkBzz
 wr0TSgASOkRarqr3Q7H2EsUEdDgxVD2os7bIJzQ/hfmdrIOc1JLQ6IhxAGO3b6QY
 ynoyIAXC/u5I3NueXPuwGKyOPVbXdH1mvIopY8o+efoknKEN8NMq/4hhsQ==
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
To: <virtualization@lists.linux-foundation.org>,
 <alsa-devel@alsa-project.org>, <virtio-dev@lists.oasis-open.org>
Subject: [PATCH v7 9/9] ALSA: virtio: introduce device suspend/resume support
Date: Tue, 2 Mar 2021 17:47:09 +0100
Message-ID: <20210302164709.3142702-10-anton.yakovlev@opensynergy.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302164709.3142702-1-anton.yakovlev@opensynergy.com>
References: <20210302164709.3142702-1-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
X-ClientProxiedBy: SR-MAIL-02.open-synergy.com (10.26.10.22) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
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

All running PCM substreams are stopped on device suspend and restarted
on device resume.

Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
---
 sound/virtio/virtio_card.c    | 56 +++++++++++++++++++++++++++++++++++
 sound/virtio/virtio_pcm.h     |  3 ++
 sound/virtio/virtio_pcm_ops.c | 33 ++++++++++++++++-----
 3 files changed, 85 insertions(+), 7 deletions(-)

diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
index 1c03fcc41c3b..ae9128063917 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -362,6 +362,58 @@ static void virtsnd_remove(struct virtio_device *vdev)
 	kfree(snd->event_msgs);
 }
 
+#ifdef CONFIG_PM_SLEEP
+/**
+ * virtsnd_freeze() - Suspend device.
+ * @vdev: VirtIO parent device.
+ *
+ * Context: Any context.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_freeze(struct virtio_device *vdev)
+{
+	struct virtio_snd *snd = vdev->priv;
+	unsigned int i;
+
+	virtsnd_disable_event_vq(snd);
+	virtsnd_ctl_msg_cancel_all(snd);
+
+	vdev->config->del_vqs(vdev);
+	vdev->config->reset(vdev);
+
+	for (i = 0; i < snd->nsubstreams; ++i)
+		cancel_work_sync(&snd->substreams[i].elapsed_period);
+
+	kfree(snd->event_msgs);
+	snd->event_msgs = NULL;
+
+	return 0;
+}
+
+/**
+ * virtsnd_restore() - Resume device.
+ * @vdev: VirtIO parent device.
+ *
+ * Context: Any context.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_restore(struct virtio_device *vdev)
+{
+	struct virtio_snd *snd = vdev->priv;
+	int rc;
+
+	rc = virtsnd_find_vqs(snd);
+	if (rc)
+		return rc;
+
+	virtio_device_ready(vdev);
+
+	virtsnd_enable_event_vq(snd);
+
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
 static const struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_SOUND, VIRTIO_DEV_ANY_ID },
 	{ 0 },
@@ -374,6 +426,10 @@ static struct virtio_driver virtsnd_driver = {
 	.validate = virtsnd_validate,
 	.probe = virtsnd_probe,
 	.remove = virtsnd_remove,
+#ifdef CONFIG_PM_SLEEP
+	.freeze = virtsnd_freeze,
+	.restore = virtsnd_restore,
+#endif
 };
 
 static int __init init(void)
diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
index 1353fdc9bd69..062eb8e8f2cf 100644
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -31,6 +31,8 @@ struct virtio_pcm_msg;
  * @xfer_xrun: Data underflow/overflow state (0 - no xrun, 1 - xrun).
  * @stopped: True if the substream is stopped and must be released on the device
  *           side.
+ * @suspended: True if the substream is suspended and must be reconfigured on
+ *             the device side at resume.
  * @msgs: Allocated I/O messages.
  * @nmsgs: Number of allocated I/O messages.
  * @msg_last_enqueued: Index of the last I/O message added to the virtqueue.
@@ -52,6 +54,7 @@ struct virtio_pcm_substream {
 	bool xfer_enabled;
 	bool xfer_xrun;
 	bool stopped;
+	bool suspended;
 	struct virtio_pcm_msg **msgs;
 	unsigned int nmsgs;
 	int msg_last_enqueued;
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
index 0682a2df6c8c..f8bfb87624be 100644
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -115,6 +115,7 @@ static int virtsnd_pcm_open(struct snd_pcm_substream *substream)
 				      SNDRV_PCM_HW_PARAM_PERIODS);
 
 	vss->stopped = !!virtsnd_pcm_msg_pending_num(vss);
+	vss->suspended = false;
 
 	/*
 	 * If the substream has already been used, then the I/O queue may be in
@@ -272,16 +273,31 @@ static int virtsnd_pcm_prepare(struct snd_pcm_substream *substream)
 	struct virtio_device *vdev = vss->snd->vdev;
 	struct virtio_snd_msg *msg;
 
-	if (virtsnd_pcm_msg_pending_num(vss)) {
-		dev_err(&vdev->dev, "SID %u: invalid I/O queue state\n",
-			vss->sid);
-		return -EBADFD;
+	if (!vss->suspended) {
+		if (virtsnd_pcm_msg_pending_num(vss)) {
+			dev_err(&vdev->dev, "SID %u: invalid I/O queue state\n",
+				vss->sid);
+			return -EBADFD;
+		}
+
+		vss->buffer_bytes = snd_pcm_lib_buffer_bytes(substream);
+		vss->hw_ptr = 0;
+		vss->msg_last_enqueued = -1;
+	} else {
+		struct snd_pcm_runtime *runtime = substream->runtime;
+		unsigned int buffer_bytes = snd_pcm_lib_buffer_bytes(substream);
+		unsigned int period_bytes = snd_pcm_lib_period_bytes(substream);
+		int rc;
+
+		rc = virtsnd_pcm_dev_set_params(vss, buffer_bytes, period_bytes,
+						runtime->channels,
+						runtime->format, runtime->rate);
+		if (rc)
+			return rc;
 	}
 
-	vss->buffer_bytes = snd_pcm_lib_buffer_bytes(substream);
-	vss->hw_ptr = 0;
 	vss->xfer_xrun = false;
-	vss->msg_last_enqueued = -1;
+	vss->suspended = false;
 	vss->msg_count = 0;
 
 	msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_PREPARE,
@@ -336,6 +352,9 @@ static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream, int command)
 		}
 
 		return virtsnd_ctl_msg_send_sync(snd, msg);
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		vss->suspended = true;
+		fallthrough;
 	case SNDRV_PCM_TRIGGER_STOP:
 		vss->stopped = true;
 		fallthrough;
-- 
2.30.1


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
