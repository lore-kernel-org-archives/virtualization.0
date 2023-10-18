Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F04CDB47E
	for <virtualization@archiver.kernel.org>; Wed, 18 Oct 2023 10:48:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 35AC341F43;
	Wed, 18 Oct 2023 10:48:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 35AC341F43
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hVQ+ce2y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id puVp_i88ysSE; Wed, 18 Oct 2023 10:48:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 346B441E27;
	Wed, 18 Oct 2023 10:48:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 346B441E27
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06F34C0039;
	Wed, 18 Oct 2023 10:48:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5345C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 10:48:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A0C4282089
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 10:48:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A0C4282089
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hVQ+ce2y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vI2k-PUaiXLE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 10:48:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1194B81426
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 10:48:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1194B81426
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697626115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=y/BxtA4C3nh2F9ZFU3/MLyV6d3jFBhZvUQYcdmVabkI=;
 b=hVQ+ce2ykPf2zGgkrFfyx6d9p9JNs22L23qG/f4i+P5Qcu87WRmNwDykd6JORPVTKx0+LX
 KRUHJCFoookZgDwIh7DgD0/dFJ8dl47u/TN0/VGEvhpVgCBcCtBPLnusQfgPypD6Dakli/
 Xij23ObySIU11Q2WFhCnWwGPBB2OjrY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-2GL7qGg3MgGAKqjAngAuSw-1; Wed, 18 Oct 2023 06:48:34 -0400
X-MC-Unique: 2GL7qGg3MgGAKqjAngAuSw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-66d1e755077so72556936d6.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 03:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697626114; x=1698230914;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y/BxtA4C3nh2F9ZFU3/MLyV6d3jFBhZvUQYcdmVabkI=;
 b=tylXXYSPIaZrrSrW56G8O8TTvCLDaJAvrCB2RfO30gRrWB7ddqj5TwseBNT6XO0//W
 B6XXeiCtYkNNOHp5VwyLlq3YL1hXberrqmupaTI0TC56ZYcOofE1XheTMqdnr3XOYGNC
 8eQ0X1Mge5wT3UAR3DfMss7cSbpIuXB1WSID0cpF3Jv9Ud/5m1J88KEiYvQ699cakths
 a6WQ+2HsiAyd5eg4yeg1AVwbQardql8xlSzdWGU4BkicyqL4idAkwf9nR0MwULWLbE9C
 I/akKSyD7C5u6bummh+SqIO2m+SsYCy9DeftJw3wCRlr8Kj468hAlgxmYBzfywr/BaqU
 ooTA==
X-Gm-Message-State: AOJu0YzuoShFCSx/jMFhiTrveqcEfdKR9k4xFQtOVVb3oXZEdYy2ujAi
 n6ODVefk+8POHUupwK6oEAaHGJ2uFSdlm5LOBUpi2pBC7e32ZVK52ydVCAd8MfIiauTtM9kiOZE
 9NfoUkf2jq+YlzYVBEBIKOsQkpmYLej/xkE2QKk7+iw==
X-Received: by 2002:ad4:574d:0:b0:66d:28a5:d153 with SMTP id
 q13-20020ad4574d000000b0066d28a5d153mr5840124qvx.47.1697626113830; 
 Wed, 18 Oct 2023 03:48:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY2x/imMpOAIHK0o2aLzigLkGid7MQzA7xXM7HSfwmKl52QvwedzXtszkIirkOvXFaE2iDXw==
X-Received: by 2002:ad4:574d:0:b0:66d:28a5:d153 with SMTP id
 q13-20020ad4574d000000b0066d28a5d153mr5840113qvx.47.1697626113548; 
 Wed, 18 Oct 2023 03:48:33 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
 by smtp.gmail.com with ESMTPSA id
 qf5-20020a0562144b8500b0065b24c08994sm1250382qvb.128.2023.10.18.03.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 03:48:33 -0700 (PDT)
Date: Wed, 18 Oct 2023 12:48:23 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: anton.yakovlev@opensynergy.com, mst@redhat.com
Subject: [PATCH v2] ALSA: virtio: use copy and fill_silence callbacks
Message-ID: <ZS+392ZzVIoEyv8n@fedora>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: alsa-devel@alsa-project.org, mripard@redhat.com, tiwai@suse.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com, pbonzini@redhat.com, perex@perex.cz
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

This commit replaces the mmap mechanism with the copy() and
fill_silence() callbacks for both capturing and playback for the
virtio-sound driver. This change is required to prevent the updating of
the content of a buffer that is already in the available ring.

The current mechanism splits a dma buffer into descriptors that are
exposed to the device. This dma buffer is shared with the user
application. When the device consumes a buffer, the driver moves the
request from the used ring to available ring.

The driver exposes the buffer to the device without knowing if the
content has been updated from the user. The section 2.8.21.1 of the
virtio spec states that: "The device MAY access the descriptor chains
the driver created and the memory they refer to immediately". If the
device picks up buffers from the available ring just after it is
notified, it happens that the content may be old.

By providing the copy() callback, the driver first updates the content
of the buffer, and then, exposes the buffer to the device by enqueuing
it in the available ring. Thus, device always picks up a buffer that is
updated. During copy(), the number of requests enqueued depends on the
"pos" and "bytes" arguments. The length of each request is period_size
bytes.

For capturing, the driver starts by exposing all the available buffers
to device. After device updates the content of a buffer, it enqueues it
in the used ring. It is only after the copy() for capturing is issued
that the driver re-enqueues the buffer in the available ring.

Co-developed-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Signed-off-by: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
---
Changelog:
v1 -> v2:
 * Use snd_pcm_set_managed_buffer_all()for buffer allocation/freeing.
 * Make virtsnd_pcm_msg_send() generic by specifying the offset and size
   for the modified part of the buffer; this way no assumptions need to
   be made.
 * Disable SNDRV_PCM_INFO_NO_REWINDS since now only sequential
   reading/writing of frames is supported.
 * Correct comment at virtsnd_pcm_msg_send().
 * v1 patch at:
   https://lore.kernel.org/lkml/20231016151000.GE119987@fedora/t/

 sound/virtio/virtio_pcm.c     |  7 ++-
 sound/virtio/virtio_pcm.h     |  9 ++--
 sound/virtio/virtio_pcm_msg.c | 93 ++++++++++++++++++++++-------------
 sound/virtio/virtio_pcm_ops.c | 81 +++++++++++++++++++++++++-----
 4 files changed, 137 insertions(+), 53 deletions(-)

diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
index c10d91fff2fb..66d67eef1bcc 100644
--- a/sound/virtio/virtio_pcm.c
+++ b/sound/virtio/virtio_pcm.c
@@ -104,12 +104,11 @@ static int virtsnd_pcm_build_hw(struct virtio_pcm_substream *vss,
 	 * only message-based transport.
 	 */
 	vss->hw.info =
-		SNDRV_PCM_INFO_MMAP |
-		SNDRV_PCM_INFO_MMAP_VALID |
 		SNDRV_PCM_INFO_BATCH |
 		SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		SNDRV_PCM_INFO_INTERLEAVED |
-		SNDRV_PCM_INFO_PAUSE;
+		SNDRV_PCM_INFO_PAUSE |
+		SNDRV_PCM_INFO_NO_REWINDS;
 
 	if (!info->channels_min || info->channels_min > info->channels_max) {
 		dev_err(&vdev->dev,
@@ -471,7 +470,7 @@ int virtsnd_pcm_build_devs(struct virtio_snd *snd)
 			for (kss = ks->substream; kss; kss = kss->next)
 				vs->substreams[kss->number]->substream = kss;
 
-			snd_pcm_set_ops(vpcm->pcm, i, &virtsnd_pcm_ops);
+			snd_pcm_set_ops(vpcm->pcm, i, &virtsnd_pcm_ops[i]);
 		}
 
 		snd_pcm_set_managed_buffer_all(vpcm->pcm,
diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
index 062eb8e8f2cf..8b42928a8e01 100644
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -57,7 +57,6 @@ struct virtio_pcm_substream {
 	bool suspended;
 	struct virtio_pcm_msg **msgs;
 	unsigned int nmsgs;
-	int msg_last_enqueued;
 	unsigned int msg_count;
 	wait_queue_head_t msg_empty;
 };
@@ -90,7 +89,7 @@ struct virtio_pcm {
 	struct virtio_pcm_stream streams[SNDRV_PCM_STREAM_LAST + 1];
 };
 
-extern const struct snd_pcm_ops virtsnd_pcm_ops;
+extern const struct snd_pcm_ops virtsnd_pcm_ops[];
 
 int virtsnd_pcm_validate(struct virtio_device *vdev);
 
@@ -117,7 +116,11 @@ int virtsnd_pcm_msg_alloc(struct virtio_pcm_substream *vss,
 
 void virtsnd_pcm_msg_free(struct virtio_pcm_substream *vss);
 
-int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss);
+int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss, unsigned long offset,
+			 unsigned long bytes);
+
+int virtsnd_pcm_msg_send_locked(struct virtio_pcm_substream *vss,
+				unsigned long offset, unsigned long bytes);
 
 unsigned int virtsnd_pcm_msg_pending_num(struct virtio_pcm_substream *vss);
 
diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
index aca2dc1989ba..c3d471088d9e 100644
--- a/sound/virtio/virtio_pcm_msg.c
+++ b/sound/virtio/virtio_pcm_msg.c
@@ -155,7 +155,6 @@ int virtsnd_pcm_msg_alloc(struct virtio_pcm_substream *vss,
 			    sizeof(msg->xfer));
 		sg_init_one(&msg->sgs[PCM_MSG_SG_STATUS], &msg->status,
 			    sizeof(msg->status));
-		msg->length = period_bytes;
 		virtsnd_pcm_sg_from(&msg->sgs[PCM_MSG_SG_DATA], sg_num, data,
 				    period_bytes);
 
@@ -189,58 +188,70 @@ void virtsnd_pcm_msg_free(struct virtio_pcm_substream *vss)
  *
  * All messages are organized in an ordered circular list. Each time the
  * function is called, all currently non-enqueued messages are added to the
- * virtqueue. For this, the function keeps track of two values:
- *
- *   msg_last_enqueued = index of the last enqueued message,
- *   msg_count = # of pending messages in the virtqueue.
+ * virtqueue. For this, the function uses offset and bytes to calculate the
+ * messages that need to be added.
  *
  * Context: Any context. Expects the tx/rx queue and the VirtIO substream
  *          spinlocks to be held by caller.
  * Return: 0 on success, -errno on failure.
  */
-int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss)
+int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss, unsigned long offset,
+			 unsigned long bytes)
 {
-	struct snd_pcm_runtime *runtime = vss->substream->runtime;
 	struct virtio_snd *snd = vss->snd;
 	struct virtio_device *vdev = snd->vdev;
 	struct virtqueue *vqueue = virtsnd_pcm_queue(vss)->vqueue;
-	int i;
-	int n;
+	unsigned long period_bytes = snd_pcm_lib_period_bytes(vss->substream);
+	unsigned long start, end, i;
+	unsigned int msg_count = vss->msg_count;
 	bool notify = false;
+	int rc;
 
-	i = (vss->msg_last_enqueued + 1) % runtime->periods;
-	n = runtime->periods - vss->msg_count;
+	start = offset / period_bytes;
+	end = (offset + bytes - 1) / period_bytes;
 
-	for (; n; --n, i = (i + 1) % runtime->periods) {
+	for (i = start; i <= end; i++) {
 		struct virtio_pcm_msg *msg = vss->msgs[i];
 		struct scatterlist *psgs[] = {
 			&msg->sgs[PCM_MSG_SG_XFER],
 			&msg->sgs[PCM_MSG_SG_DATA],
 			&msg->sgs[PCM_MSG_SG_STATUS]
 		};
-		int rc;
-
-		msg->xfer.stream_id = cpu_to_le32(vss->sid);
-		memset(&msg->status, 0, sizeof(msg->status));
-
-		if (vss->direction == SNDRV_PCM_STREAM_PLAYBACK)
-			rc = virtqueue_add_sgs(vqueue, psgs, 2, 1, msg,
-					       GFP_ATOMIC);
-		else
-			rc = virtqueue_add_sgs(vqueue, psgs, 1, 2, msg,
-					       GFP_ATOMIC);
-
-		if (rc) {
-			dev_err(&vdev->dev,
-				"SID %u: failed to send I/O message\n",
-				vss->sid);
-			return rc;
+		unsigned long n;
+
+		n = period_bytes - (offset % period_bytes);
+		if (n > bytes)
+			n = bytes;
+
+		msg->length += n;
+		if (msg->length == period_bytes) {
+			msg->xfer.stream_id = cpu_to_le32(vss->sid);
+			memset(&msg->status, 0, sizeof(msg->status));
+
+			if (vss->direction == SNDRV_PCM_STREAM_PLAYBACK)
+				rc = virtqueue_add_sgs(vqueue, psgs, 2, 1, msg,
+						       GFP_ATOMIC);
+			else
+				rc = virtqueue_add_sgs(vqueue, psgs, 1, 2, msg,
+						       GFP_ATOMIC);
+
+			if (rc) {
+				dev_err(&vdev->dev,
+					"SID %u: failed to send I/O message\n",
+					vss->sid);
+				return rc;
+			}
+
+			vss->msg_count++;
 		}
 
-		vss->msg_last_enqueued = i;
-		vss->msg_count++;
+		offset = 0;
+		bytes -= n;
 	}
 
+	if (msg_count == vss->msg_count)
+		return 0;
+
 	if (!(vss->features & (1U << VIRTIO_SND_PCM_F_MSG_POLLING)))
 		notify = virtqueue_kick_prepare(vqueue);
 
@@ -250,6 +261,22 @@ int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss)
 	return 0;
 }
 
+int virtsnd_pcm_msg_send_locked(struct virtio_pcm_substream *vss,
+				unsigned long offset, unsigned long bytes)
+{
+	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
+	unsigned long flags;
+	int rc;
+
+	spin_lock_irqsave(&queue->lock, flags);
+	spin_lock(&vss->lock);
+	rc = virtsnd_pcm_msg_send(vss, offset, bytes);
+	spin_unlock(&vss->lock);
+	spin_unlock_irqrestore(&queue->lock, flags);
+
+	return rc;
+}
+
 /**
  * virtsnd_pcm_msg_pending_num() - Returns the number of pending I/O messages.
  * @vss: VirtIO substream.
@@ -309,6 +336,8 @@ static void virtsnd_pcm_msg_complete(struct virtio_pcm_msg *msg,
 	if (vss->hw_ptr >= vss->buffer_bytes)
 		vss->hw_ptr -= vss->buffer_bytes;
 
+	msg->length = 0;
+
 	vss->xfer_xrun = false;
 	vss->msg_count--;
 
@@ -320,8 +349,6 @@ static void virtsnd_pcm_msg_complete(struct virtio_pcm_msg *msg,
 					le32_to_cpu(msg->status.latency_bytes));
 
 		schedule_work(&vss->elapsed_period);
-
-		virtsnd_pcm_msg_send(vss);
 	} else if (!vss->msg_count) {
 		wake_up_all(&vss->msg_empty);
 	}
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
index f8bfb87624be..4569b285f520 100644
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -282,7 +282,6 @@ static int virtsnd_pcm_prepare(struct snd_pcm_substream *substream)
 
 		vss->buffer_bytes = snd_pcm_lib_buffer_bytes(substream);
 		vss->hw_ptr = 0;
-		vss->msg_last_enqueued = -1;
 	} else {
 		struct snd_pcm_runtime *runtime = substream->runtime;
 		unsigned int buffer_bytes = snd_pcm_lib_buffer_bytes(substream);
@@ -324,7 +323,7 @@ static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream, int command)
 	struct virtio_snd_queue *queue;
 	struct virtio_snd_msg *msg;
 	unsigned long flags;
-	int rc;
+	int rc = 0;
 
 	switch (command) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -333,7 +332,8 @@ static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream, int command)
 
 		spin_lock_irqsave(&queue->lock, flags);
 		spin_lock(&vss->lock);
-		rc = virtsnd_pcm_msg_send(vss);
+		if (vss->direction == SNDRV_PCM_STREAM_CAPTURE)
+			rc = virtsnd_pcm_msg_send(vss, 0, vss->buffer_bytes);
 		if (!rc)
 			vss->xfer_enabled = true;
 		spin_unlock(&vss->lock);
@@ -450,15 +450,70 @@ virtsnd_pcm_pointer(struct snd_pcm_substream *substream)
 	return hw_ptr;
 }
 
+static int virtsnd_pcm_pb_silence(struct snd_pcm_substream *substream,
+				  int channel, unsigned long pos,
+				  unsigned long bytes)
+{
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	snd_pcm_format_set_silence(runtime->format, runtime->dma_area + pos,
+				   bytes_to_samples(runtime, bytes));
+
+	return virtsnd_pcm_msg_send_locked(vss, pos, bytes);
+}
+
+static int virtsnd_pcm_pb_copy(struct snd_pcm_substream *substream, int channel,
+			       unsigned long pos, struct iov_iter *iter,
+			       unsigned long bytes)
+{
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	if (copy_from_iter(runtime->dma_area + pos, bytes, iter) != bytes)
+		return -EFAULT;
+
+	return virtsnd_pcm_msg_send_locked(vss, pos, bytes);
+}
+
+static int virtsnd_pcm_cp_copy(struct snd_pcm_substream *substream, int channel,
+			       unsigned long pos, struct iov_iter *iter,
+			       unsigned long bytes)
+{
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	if (copy_to_iter(runtime->dma_area + pos, bytes, iter) != bytes)
+		return -EFAULT;
+
+	return virtsnd_pcm_msg_send_locked(vss, pos, bytes);
+}
+
 /* PCM substream operators map. */
-const struct snd_pcm_ops virtsnd_pcm_ops = {
-	.open = virtsnd_pcm_open,
-	.close = virtsnd_pcm_close,
-	.ioctl = snd_pcm_lib_ioctl,
-	.hw_params = virtsnd_pcm_hw_params,
-	.hw_free = virtsnd_pcm_hw_free,
-	.prepare = virtsnd_pcm_prepare,
-	.trigger = virtsnd_pcm_trigger,
-	.sync_stop = virtsnd_pcm_sync_stop,
-	.pointer = virtsnd_pcm_pointer,
+const struct snd_pcm_ops virtsnd_pcm_ops[] = {
+	{
+		.open = virtsnd_pcm_open,
+		.close = virtsnd_pcm_close,
+		.ioctl = snd_pcm_lib_ioctl,
+		.hw_params = virtsnd_pcm_hw_params,
+		.hw_free = virtsnd_pcm_hw_free,
+		.prepare = virtsnd_pcm_prepare,
+		.trigger = virtsnd_pcm_trigger,
+		.sync_stop = virtsnd_pcm_sync_stop,
+		.pointer = virtsnd_pcm_pointer,
+		.copy = virtsnd_pcm_pb_copy,
+		.fill_silence = virtsnd_pcm_pb_silence,
+	},
+	{
+		.open = virtsnd_pcm_open,
+		.close = virtsnd_pcm_close,
+		.ioctl = snd_pcm_lib_ioctl,
+		.hw_params = virtsnd_pcm_hw_params,
+		.hw_free = virtsnd_pcm_hw_free,
+		.prepare = virtsnd_pcm_prepare,
+		.trigger = virtsnd_pcm_trigger,
+		.sync_stop = virtsnd_pcm_sync_stop,
+		.pointer = virtsnd_pcm_pointer,
+		.copy = virtsnd_pcm_cp_copy,
+	},
 };

base-commit: 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa
-- 
2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
