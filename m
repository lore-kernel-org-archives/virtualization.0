Return-Path: <SRS0=N2Rq=H5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5F9C433E0
	for <virtualization@archiver.kernel.org>; Sat, 27 Feb 2021 09:00:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42FAE64EBC
	for <virtualization@archiver.kernel.org>; Sat, 27 Feb 2021 09:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42FAE64EBC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensynergy.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 10FBD43452;
	Sat, 27 Feb 2021 09:00:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0nx813ofcDJk; Sat, 27 Feb 2021 09:00:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 948EF42FB7;
	Sat, 27 Feb 2021 09:00:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 713F8C000A;
	Sat, 27 Feb 2021 09:00:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34B13C0001
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 Feb 2021 09:00:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 15C8A8431D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 Feb 2021 09:00:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=opensynergy.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LnlybRBZSA_Q
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 Feb 2021 09:00:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx1.opensynergy.com (mx1.opensynergy.com [217.66.60.4])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3886684326
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 Feb 2021 09:00:46 +0000 (UTC)
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain
 [127.0.0.1])
 by mx1.opensynergy.com (Proxmox) with ESMTP id 547D9A1765;
 Sat, 27 Feb 2021 10:00:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=srmailgate02; bh=zLcadKSiDEB2
 5euoNy23WAsizIICsggTnRBQxLzaEyk=; b=Xlopr/eWd8YAOS0Eq0Z5K60FlzOz
 bU5/TBb1pB5ZKQL4nQdWmOfb4CP8BVBaKMiRUTizHmrAdIZ/j41753zNj8Ya8IFN
 +aNd+oaKAF1PoeDzX3i1Ybxhqrxcqnx+4ig6A65sDmwh819Yui1/WE9CNDLlv+oI
 cUYRdXgwk9edgYAj6XgRyHQ43LYBBSDVh1yzPewBV+Ck0ImSleEZM11HYhOajP25
 EST9S6ndRwNVuws6+ZYtl4+oyZv/5ydv/L0Dzhic+/oeQ2vah+3kGSG5LISIUC98
 XOMN/S9asSSsEUf+plIANnLVAOny61yBt0NwquFfJ5AERcOVGZh13JH1xQ==
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
To: <virtualization@lists.linux-foundation.org>,
 <alsa-devel@alsa-project.org>, <virtio-dev@lists.oasis-open.org>
Subject: [PATCH v6 9/9] ALSA: virtio: introduce device suspend/resume support
Date: Sat, 27 Feb 2021 09:59:56 +0100
Message-ID: <20210227085956.1700687-10-anton.yakovlev@opensynergy.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210227085956.1700687-1-anton.yakovlev@opensynergy.com>
References: <20210227085956.1700687-1-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
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
 sound/virtio/virtio_pcm.c     |  1 +
 sound/virtio/virtio_pcm_ops.c | 41 ++++++++++++++++++++-----
 3 files changed, 90 insertions(+), 8 deletions(-)

diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
index 59455a562018..c7ae8801991d 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -323,6 +323,58 @@ static void virtsnd_remove(struct virtio_device *vdev)
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
+
+	virtsnd_ctl_msg_cancel_all(snd);
+
+	vdev->config->del_vqs(vdev);
+	vdev->config->reset(vdev);
+
+	kfree(snd->event_msgs);
+
+	/*
+	 * If the virtsnd_restore() fails before re-allocating events, then we
+	 * get a dangling pointer here.
+	 */
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
@@ -335,6 +387,10 @@ static struct virtio_driver virtsnd_driver = {
 	.validate = virtsnd_validate,
 	.probe = virtsnd_probe,
 	.remove = virtsnd_remove,
+#ifdef CONFIG_PM_SLEEP
+	.freeze = virtsnd_freeze,
+	.restore = virtsnd_restore,
+#endif
 };
 
 static int __init init(void)
diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
index 3605151860f2..4a4a6583b002 100644
--- a/sound/virtio/virtio_pcm.c
+++ b/sound/virtio/virtio_pcm.c
@@ -109,6 +109,7 @@ static int virtsnd_pcm_build_hw(struct virtio_pcm_substream *vss,
 		SNDRV_PCM_INFO_BATCH |
 		SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		SNDRV_PCM_INFO_INTERLEAVED |
+		SNDRV_PCM_INFO_RESUME |
 		SNDRV_PCM_INFO_PAUSE;
 
 	if (!info->channels_min || info->channels_min > info->channels_max) {
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
index d02d79bd94f3..03a7e2666cfb 100644
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -167,7 +167,8 @@ static int virtsnd_pcm_hw_params(struct snd_pcm_substream *substream,
 	int vrate = -1;
 	int rc;
 
-	if (virtsnd_pcm_msg_pending_num(vss)) {
+	if (runtime->status->state != SNDRV_PCM_STATE_SUSPENDED &&
+	    virtsnd_pcm_msg_pending_num(vss)) {
 		dev_err(&vdev->dev, "SID %u: invalid I/O queue state\n",
 			vss->sid);
 		return -EBADFD;
@@ -231,6 +232,10 @@ static int virtsnd_pcm_hw_params(struct snd_pcm_substream *substream,
 	if (rc)
 		return rc;
 
+	/* If messages have already been allocated before, do nothing. */
+	if (runtime->status->state == SNDRV_PCM_STATE_SUSPENDED)
+		return 0;
+
 	/* Free previously allocated messages (if any). */
 	virtsnd_pcm_msg_free(vss);
 
@@ -267,20 +272,24 @@ static int virtsnd_pcm_hw_free(struct snd_pcm_substream *substream)
  */
 static int virtsnd_pcm_prepare(struct snd_pcm_substream *substream)
 {
+	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 	struct virtio_device *vdev = vss->snd->vdev;
 	struct virtio_snd_msg *msg;
 
-	if (virtsnd_pcm_msg_pending_num(vss)) {
-		dev_err(&vdev->dev, "SID %u: invalid I/O queue state\n",
-			vss->sid);
-		return -EBADFD;
+	if (runtime->status->state != SNDRV_PCM_STATE_SUSPENDED) {
+		if (virtsnd_pcm_msg_pending_num(vss)) {
+			dev_err(&vdev->dev, "SID %u: invalid I/O queue state\n",
+				vss->sid);
+			return -EBADFD;
+		}
+
+		vss->buffer_bytes = snd_pcm_lib_buffer_bytes(substream);
+		vss->hw_ptr = 0;
+		vss->msg_last_enqueued = -1;
 	}
 
-	vss->buffer_bytes = snd_pcm_lib_buffer_bytes(substream);
-	vss->hw_ptr = 0;
 	vss->xfer_xrun = false;
-	vss->msg_last_enqueued = -1;
 	vss->msg_count = 0;
 
 	msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_PREPARE,
@@ -309,6 +318,21 @@ static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream, int command)
 	int rc;
 
 	switch (command) {
+	case SNDRV_PCM_TRIGGER_RESUME: {
+		/*
+		 * We restart the substream by executing the standard command
+		 * sequence.
+		 */
+		rc = virtsnd_pcm_hw_params(substream, NULL);
+		if (rc)
+			return rc;
+
+		rc = virtsnd_pcm_prepare(substream);
+		if (rc)
+			return rc;
+
+		fallthrough;
+	}
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE: {
 		struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
@@ -335,6 +359,7 @@ static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream, int command)
 
 		return virtsnd_ctl_msg_send_sync(snd, msg);
 	}
+	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH: {
 		spin_lock_irqsave(&vss->lock, flags);
-- 
2.30.1


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
