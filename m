Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7684483B9
	for <virtualization@lists.linux.dev>; Sun, 11 Oct 2026 12:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791723276; cv=none; b=d+S8GAmm/6UoAd7r7ZCkdOn7fjU4zezN+PkquFEFR/wGmG5uR/Pl4W4v1lsYS0MRcEShnW/5OibYKz4nQsW99vTitUPlwhv8cYpDig3fSHWRgXPPZavVKXy1bIYGcXOeTOwbQmbgYEz2n3L0oYl2UOdpVW2X8+EAcIVzsmY5Wrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791723276; c=relaxed/simple;
	bh=BljPXRps8xjbLho6X1ZoNVOk6CUa6vnUVpwHPT+7JbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k8+t6V+UFfFlLoq1di01Fc5lKpn32l6p6Z+Y++LfZxAq3yKIfalmFufhyE3ErHdq2g5Ct2DDucew1b3Jn+1QxFQ/9d0QmxzNx2ITiZhJG+nzJ+HDmWt9gs2r2jMsqXFYYcihPEHwIplhazFYX2U13V9GJtPanlByDXPIAL0U6dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sg26WUS3; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sg26WUS3"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-89a595332c7so229873b3a.0
        for <virtualization@lists.linux.dev>; Sun, 11 Oct 2026 05:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791723273; x=1792328073; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MwkyR+d13Yt35PeifZJYjSerizH5kaNtuABNu7XQY84=;
        b=sg26WUS3EVmm9wzpnHyB3QZ+RaPJMzqISUS01y0AB9tV+SBO0nN8/v5elX5d4vuzlB
         rdEqv+njEapSPMGPRoYNPN1+qC87hoc1gF/FKa0cp4ts1t8OPA46FR5HhuoZXuenzsMW
         iC+GWSgFjhgJ/gVtZIdFTxRNzV5Nr69M1/yYiH9DR9mfuY9p7bn3wXDiXTQvxLFrm6sy
         WzenqhL9TEbDieHfNzwye3h3yW8f5o3RamA5hDKaDu2DcKwnlhKfsZ0qwP3XykM9ufXs
         Bh2TMXq/Q4dNe6pg9/UkoaEdBAZjAKyx7VLmB8Ax8tKe2BF1us79OQSuWPX+ZmpUPSCN
         uYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791723274; x=1792328074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MwkyR+d13Yt35PeifZJYjSerizH5kaNtuABNu7XQY84=;
        b=MpsWm8tDkdB8kONDzFRmxG3dexM+Os/jvWW3Ct8zEEph2yPmvpmgaWUPtohEGa5JaB
         PTpRdeG2ySziEi8GhgzW7eo+SYE331GmvMEPWM8tdfa1cUg7ZScx8BKnqoRZiuUwByUK
         YHfquEAnmPcqEw+7GVOBjpjwEuApwMWubxg1zb1Nmx/M1XuSBO1WvGP3YG3wKxkCA+aA
         fhKbpZ8uyGYmPRHdbmnvxKsaoe4fTtOZakJKpepzt3hBOQe+s3LuDN68Ny9Ga6tFwFcX
         /Fg0iCsO5OEiif3UyKMHDPaoC/npbYftuyeb96ghVPRS9ASv29P/UcJ243uPPeg2W+EX
         Ro9Q==
X-Forwarded-Encrypted: i=1; AKwUvBz7LNG+SdKqFHtK8cccOsux1b6xqlKlNAn7ZLAmF2ihGYXijy10nriCpzc4FbTI2drnREvt9aC84Ehz2vot+w==@lists.linux.dev
X-Gm-Message-State: AFq9FYJjkvqDdMSqXFpxdnfzqfFFwBJhGyxiWeRHD/c4/3ZwP4v/ScFh
	9NGZKmATgFKIXqy5fiSoXS6SRggR1Px0JTXMCrT2QF5g5a/+AUlSu7vi
X-Gm-Gg: AYBFou3QODfnWFQ2H5OlNaYHkboqwfyMVQj3sYrzPubbuZrvAlK1OUw3fYdqXstA3yb
	AkBzlJho49uohJXeLFT2KrqhHnx4ELs0DHdVq85e3fQmvgZN7iM/Zyq21LK7xRMjLZ43DvWlG5H
	xujPfHCRe4M/mgZ4biwGHtEP5yrWPiGfiL8Q21n6g/jGx0tTrSzlnstaU/UmhmNml9+Lf3TVFc3
	t4Iyd3p4RkeDcaiKgSX8nWXcVCa1NDXQBv1RNXLqL8ehkjjxxdka3R+MtHb01wTTgkBhmGtn3GR
	i4xhvZK676FS2qcQj0fgSQzSUTZj9DRGAk2j1Wngd/RK3ByRnf3KSgd8rUoXVXRsdyM73ViBGHV
	3iwO1s/b0qmO6Wlm0osFc6MmAN1VqsiZKK+61up0lhO1Kw7DumPk0VqGQRpB2uv6E9zhXHCrtdm
	vlar5VCp0KUmFVaxaFlc+/UHg6Jjgi9tz5UpWChVFDEoJjwCYd/AQlaNZGIhPaYyf1plqLxCJ91
	Cg4QCkbA08LF+odIYDNHPh/Q25DQF/pS0iCrh02gP4i0GnUQst5k6Qhw1GVTvgZfjgRHchDZ6OT
	r1wWicq019fTnzKa3EFsZydOkl/A1TyFYHMOKlACSHdaYryTOXl4d5n0n4g6ZYfzJAtD2PAh0/q
	7qehYXePNKTJXmLHItA/lWI1fw50uUQ43zMmbZC3uAwM3QS2VGb5u0esoN0SZzTmn1yAKNhw2
X-Received: by 2002:a05:6a00:23c8:b0:87d:dc3c:1b5e with SMTP id d2e1a72fcca58-897c634d89fmr5838569b3a.26.1791723273443;
        Sun, 11 Oct 2026 05:54:33 -0700 (PDT)
Received: from desktophank.localdomain (111-242-217-19.dynamic-ip.hinet.net. [111.242.217.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-899b738d03bsm929232b3a.41.2026.10.11.05.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 05:54:32 -0700 (PDT)
From: Ting-Han Hou <ue081723@gmail.com>
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Takashi Iwai <tiwai@suse.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
	virtualization@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: virtio: reset I/O message fill level on prepare
Date: Sun, 11 Oct 2026 20:54:26 +0800
Message-ID: <20261011125426.35745-1-ue081723@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit fe981e67568c ("ALSA: virtio: use ack callback"), an I/O
message is only queued to the device once the application has filled
the whole period: virtsnd_pcm_msg_send() accumulates the transferred
bytes in msg->length and queues the message when it reaches
period_bytes.  msg->length is reset to 0 only when the device completes
the message.

If the substream is stopped (e.g. snd_pcm_drop()) while a period is
only partially filled, the corresponding message is never queued and
keeps its partial length.  virtsnd_pcm_prepare() resets msg_count,
hw_ptr and the indirect PCM state, but not msg->length.  After the
next start, the stale length is added to the new data, the sum never
equals period_bytes, and the message is never sent again.  Playback
then stalls once hw_ptr reaches that period: writes fail with -EIO
("DMA or IRQ trouble") and drain fails with -EIO.  Capture is affected the
same way after a partial read.

Clear the fill level of all messages in prepare.  Outside of the resume
path, virtsnd_pcm_prepare() already refuses to run while I/O messages
are pending, so no message is owned by the device at this point and the
reset does not race with message completion.

Reproduced in QEMU (virtio-sound-pci, wav audiodev): prepare, write 1.5
periods, drop, prepare, write 16 full periods, drain.  Without this
patch WRITEI returns -EIO after 14 periods and DRAIN fails; with it all
16 periods are played and DRAIN succeeds.  Period-aligned prefill works
in both cases.  The same sequence on capture (read 1.5 periods, drop,
prepare, read 16 periods) fails with -EIO after 10 periods without this
patch and reads all 16 with it.

Found by code inspection, confirmed with the reproducer above.

Fixes: fe981e67568c ("ALSA: virtio: use ack callback")
Assisted-by: LLM
Signed-off-by: Ting-Han Hou <ue081723@gmail.com>
---
Testing notes:
- Tested only with QEMU's virtio-sound-pci (wav and none audiodevs) on
  x86_64 with KASAN enabled, using a raw-ioctl ALSA test program;
  not tested with other device implementations (e.g. crosvm,
  vhost-user-sound) or with alsa-lib based players.
- Suspend/resume during playback (pm_test=devices) was also tried in
  QEMU and works with and without this patch.
- Lockdep was not enabled.

 sound/virtio/virtio_pcm.h     |  2 ++
 sound/virtio/virtio_pcm_msg.c | 19 +++++++++++++++++++
 sound/virtio/virtio_pcm_ops.c |  1 +
 3 files changed, 22 insertions(+)

diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
index 368dafa5df3f..8837dfc12828 100644
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -118,6 +118,8 @@ int virtsnd_pcm_msg_alloc(struct virtio_pcm_substream *vss,
 
 void virtsnd_pcm_msg_free(struct virtio_pcm_substream *vss);
 
+void virtsnd_pcm_msg_reset(struct virtio_pcm_substream *vss);
+
 int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss, unsigned long offset,
 			 unsigned long bytes);
 
diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
index a5c4e7027717..72103f606716 100644
--- a/sound/virtio/virtio_pcm_msg.c
+++ b/sound/virtio/virtio_pcm_msg.c
@@ -182,6 +182,25 @@ void virtsnd_pcm_msg_free(struct virtio_pcm_substream *vss)
 	vss->nmsgs = 0;
 }
 
+/**
+ * virtsnd_pcm_msg_reset() - Reset the fill level of all I/O messages.
+ * @vss: VirtIO PCM substream.
+ *
+ * Messages that were only partially filled by the application when the
+ * substream was stopped are never sent to the device, so their length must be
+ * cleared before the substream is started again.
+ *
+ * Context: Any context. Takes and releases the VirtIO substream spinlock.
+ */
+void virtsnd_pcm_msg_reset(struct virtio_pcm_substream *vss)
+{
+	unsigned int i;
+
+	guard(spinlock_irqsave)(&vss->lock);
+	for (i = 0; vss->msgs && i < vss->nmsgs; ++i)
+		vss->msgs[i]->length = 0;
+}
+
 /**
  * virtsnd_pcm_msg_send() - Send asynchronous I/O messages.
  * @vss: VirtIO PCM substream.
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
index 1105e7ff3523..1091100a4c98 100644
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -299,6 +299,7 @@ static int virtsnd_pcm_prepare(struct snd_pcm_substream *substream)
 	vss->xfer_xrun = false;
 	vss->suspended = false;
 	vss->msg_count = 0;
+	virtsnd_pcm_msg_reset(vss);
 
 	memset(&vss->pcm_indirect, 0, sizeof(vss->pcm_indirect));
 	vss->pcm_indirect.sw_buffer_size =
-- 
2.53.0

