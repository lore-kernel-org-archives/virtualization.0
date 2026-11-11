Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355614;
	b=VawKCAF8kAnxgAGQ3zj6bWiSo0wmFtP91RBxprR3mMvMaYrG+9gckt6RTzet+8qFztSI
	 1d4PRYYkZ0hJIU1IRm5hlr38e5k3JY3/J4lxE0dac00Vx+sRXYRFRhsne+jfjCD9PkLXU
	 NKHI1jHCwAXToMj+KxPWtz7Zem8i9EyVRQnR0j+XKy8YrfkVWDTDF2omYhrtenqskCFOq
	 6lgnnuGvQbKSQilDku8RSprgeC01OR84dVBdrGG25Ztox6QMocwX/BPFvNXQtoVkcVvgq
	 +wK9k7SuwYtx/hNyhg057nCsdMuZgd+tPSsLueCJuoKfmPowTREEnwvM44euWxnY0QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355614;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bI2qMwtSokUZoL5Zm53kc3fAF8wxP+z1vLTf3dEo/cQ=;
	b=tV2lLpTba4u2dJuRqB9CqSEifZ28v1x4AsEAeJY+lwkfvqSPMzqsh1QunwmMztJQY7Fq
	 8jH40bytmJtmqVDSR3PqZfETs8iUPBYYTEFAbn03fSf9Zj1exxCm0n2mxSHq5UDaifC+d
	 UpTc6Qa0BK5OQJDgWsrvrflJO2WbV5uJfbM6mOTLBj3nKylfsurtKdu5N3bjib+gBbAlr
	 g5j7y4F6SEsr1N3Zy0aSlqm/M+IiDh3/5nWquzj1Z/1pPKc/p3KL+nqaONZbfZTUfiMwb
	 68iARCeMQA282C1bqh4/N2cxGFNFh5iaPKl7ADDB3PGddNNSXwwInSvQlr1sJ112OGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RF77Vbml;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52818607000F
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 00:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52818607000F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RF77Vbml
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e987b4a710so12338775ad.1
        for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 16:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794355614; x=1794960414; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bI2qMwtSokUZoL5Zm53kc3fAF8wxP+z1vLTf3dEo/cQ=;
        b=RF77VbmlUrU9QeUPf+zlDPyK17+yFv2S3GdXGrh7oitBNJ1B6EQxjbbbxy6LLgcCpn
         wtR00z9HZIJUCsvA4zICOIlwnIlFi2vJUBzobSt2CRfbbMztXFwnbwbO/necFXHMqblO
         fXCbJ4wG3MM6vrkZRLNQLk4M7rneysAPuRxth6Ybfl6o8kdXlZZQT8wUzzFIg0oaEpiJ
         PVQ+K9ebOHijESrHgs2Fv79VKs2Juw9pFqlLhUSPIrRHl1T1h4A3ku3yETpDb75hSUUx
         MOqmxrhQuGhrIqyB2Fw7fx/sDfl4VrC0uqV7EC71+rfrNQInxjoOvlQbGpxUlLk9oA7P
         4SaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794355614; x=1794960414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bI2qMwtSokUZoL5Zm53kc3fAF8wxP+z1vLTf3dEo/cQ=;
        b=Q6RR/V4NKqw8sK6zdxR6o3wE4ash5SWygikkg5BIqT5p/T/7DsOr5Gp0xSQ+DcEVCP
         ThFGGUsSu2uFR9/xzjdhz+zaAtepIc1VaDd37bsl0koADqhbozXI1/OE4u9DqSUz1YY5
         uQCgXgSV/wAZg/YwgijoKK890T8iZk2yjnVMnNnn3kxXOhMBMACVkbcCxJdGQ2Fv0/pM
         9Ae129jeAe7A/046eIEWQk1lt9RfGQ+n40rtuRgdStZ/rMeJmY8x6ynT4B/eNeFy7sfi
         K3gaQUYzcFYKCGvhllNmcI+Eqpq73w4mEmSfeZkXF0IxMs3WppUASRJnXrV1cc1Uh7xu
         yvsw==
X-Forwarded-Encrypted: i=1; AL+hErGizjOgjo8g89SgJrqH9joeWNgFVhGpxS4C01lPPU5hJcfFu3OcUkfwzwQc6MhoVZNQp6wwMxeOexeFQ1Xegg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+6+DaCpSQPCDWGtjidq7FRDns2r0S5vXbhaKk/833Lw/t+XYL3
	tq4eFs+14mL2x2z6BTUbaC0TWFKBSuo4TB9YGhee0SQCegVmDFnkw1aL
X-Gm-Gg: AYBFou1IJYH0PpEfO2v5kqw4qlNSLGqvX3ma+yBfYEj/s7ogeP/NuiTfpCi0H+Ou6rc
	xGz8QHo9eM5q49bsPJTBGb0Q/awz8YlctuiN4Sfgc2Yt0w6MzNqEOO+/+p4EQ7ydK/XXMt+66Mi
	LZbqDZSLIVIsu0AWUk8/4x4XPAJVRIYi0t5/Rvf8yyRcC+xilasqszOuSQXLp6JI0rx5PAISdcX
	rpl4UvBTkKJ2xGQKRPkKePaTVauXFvfms7m2VYWQh5Pn+MGFoAeeMYs6CzXIRayMDDxin7RjnOW
	e/2oM8fZf0ErrqvbqjJjDILCNB0sY1gk11Q9i3JulWhVP0r20+klDdU3MNM0GI3seFdUEH0cIlN
	yVd5+D1UC3q0vLhr0/KF6tlpMiOeK7iWMUray9l2ZzCLgLydddtBnL54LCGucCSHrQs5DlCNBoC
	vi1m1slygMaI/ourEIudOJ5+eooH1laNNRB8Q8Nu4PQwLvFYqUL+Vh2Ea+YV6vYFM4U4f2VDcXQ
	JN3sKbmOLObebfLai1hyFpWT+DJdGjRIx5qGuKxSqV9V44goxGJ+Oom3yrS3BTJneFV/aXrMfdK
	pE7ny0Twd7UVe7o00Aa6ggjcQpN+fcLYcGXTP2i/ukuQFL6u0keGUo+fTuodxMVhQc1vsmlX+a1
	GcCCC4lSYrnaICOH+SD0CfRk2bL74MNHNX9OlX216MQIz0cQ=
X-Received: by 2002:a17:90a:e7cd:b0:3ae:3e9b:5265 with SMTP id 98e67ed59e1d1-3b182f2b5ebmr413417a91.26.1794355613529;
        Tue, 10 Nov 2026 16:06:53 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1838e616dsm474361a91.4.2026.11.10.16.06.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 16:06:51 -0800 (PST)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.com,
	perex@perex.cz,
	anton.yakovlev@opensynergy.com,
	mst@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org,
	Joonho Lee <mynameisjune111@gmail.com>
Subject: [PATCH v24 16/16] ALSA: virtio: preserve playback progress across pause
Date: Wed, 11 Nov 2026 09:05:43 +0900
Message-ID: <20261111000543.28550-17-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111000543.28550-1-mynameisjune111@gmail.com>
References: <20261111000543.28550-1-mynameisjune111@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TX completions can arrive after PAUSE closes transfer admission.
Preserve that progress and schedule catch-up when the stream resumes or
a rejected pause restores RUNNING. Cache device latency in stream-owned
state so a late completion does not need to dereference the ALSA
runtime. Clear the cache on prepare and RESET.

Use the existing indirect hw_queue_size to keep outstanding TX below one
physical ring: buffer_bytes - period_bytes. Equal modulo cursors then
mean no unobserved completion, and a non-interrupt HWSYNC cannot consume
a hidden full-ring wrap before deferred period work. Continue using the
ordinary ALSA pointer update for silence, drain, stop-threshold and
wakeup policy.

This also reduces queued buffering by one period. With two periods, only
one period can be queued. The minimum geometry and pause/reopen cases
pass in QEMU, but worst-case scheduling tolerance has not been
qualified.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
sound/virtio/virtio_pcm.h     |    2 ++
 sound/virtio/virtio_pcm_msg.c |    8 +++-----
 sound/virtio/virtio_pcm_ops.c |   25 ++++++++++++++++++++++---
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -53,6 +53,7 @@
  *        substream operators, including @stopped.
  * @buffer_bytes: Current buffer size in bytes.
  * @hw_ptr: Substream hardware pointer value in bytes [0 ... buffer_bytes).
+ * @playback_latency_bytes: Device delay cached independently of the ALSA runtime.
  * @capture_ready: Managed-mode bytes copied but not yet acknowledged by ALSA;
  *                 always zero in free-running mode.
  * @capture_boundary: ALSA boundary captured for this prepared epoch.
@@ -113,6 +114,7 @@
 	bool resetting;
 	size_t buffer_bytes;
 	size_t hw_ptr;
+	u32 playback_latency_bytes;
 	size_t capture_ready;
 	snd_pcm_uframes_t capture_boundary;
 	u64 capture_copied_total;
diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
--- a/sound/virtio/virtio_pcm_msg.c
+++ b/sound/virtio/virtio_pcm_msg.c
@@ -1002,12 +1002,10 @@
 	/* Keep latched errors until prepare establishes a fresh epoch. */
 	vss->msg_count--;
 
-	if (vss->xfer_enabled) {
-		struct snd_pcm_runtime *runtime = vss->substream->runtime;
-
-		runtime->delay = bytes_to_frames(runtime, latency_bytes);
+	/* A queued request can outlive the ALSA runtime after hw_free. */
+	vss->playback_latency_bytes = latency_bytes;
+	if (vss->prepared && !vss->preparing)
 		virtsnd_pcm_schedule_period_elapsed(vss);
-	}
 	if (!vss->msg_count)
 		wake_up_all(&vss->msg_empty);
 }
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -770,6 +770,12 @@
 		memset(&vss->pcm_indirect, 0, sizeof(vss->pcm_indirect));
 		vss->pcm_indirect.sw_buffer_size = vss->buffer_bytes;
 		vss->pcm_indirect.hw_buffer_size = vss->buffer_bytes;
+		if (vss->direction == SNDRV_PCM_STREAM_PLAYBACK) {
+			/* Keep unobserved completions below one physical ring. */
+			vss->pcm_indirect.hw_queue_size = vss->buffer_bytes -
+				snd_pcm_lib_period_bytes(substream);
+			vss->playback_latency_bytes = 0;
+		}
 		if (vss->direction == SNDRV_PCM_STREAM_CAPTURE) {
 			vss->capture_boundary = substream->runtime->boundary;
 			rc = virtsnd_pcm_capture_refresh_mode_locked(vss,
@@ -1143,6 +1149,14 @@
 	return rc;
 }
 
+/* The queue capacity keeps equal cursors unambiguous for playback. */
+static bool
+virtsnd_pcm_playback_progress_pending(struct virtio_pcm_substream *vss)
+{
+	guard(spinlock_irqsave)(&vss->lock);
+	return vss->xfer_xrun || vss->hw_ptr != vss->pcm_indirect.hw_io;
+}
+
 /**
  * virtsnd_pcm_trigger_inner() - Process command for the PCM substream.
  * @substream: Kernel ALSA substream.
@@ -1197,7 +1211,8 @@
 		}
 
 		if (running) {
-			if (vss->direction == SNDRV_PCM_STREAM_CAPTURE)
+			if (vss->direction == SNDRV_PCM_STREAM_CAPTURE ||
+			    virtsnd_pcm_playback_progress_pending(vss))
 				virtsnd_pcm_schedule_period_elapsed(vss);
 			return 0;
 		}
@@ -1219,7 +1234,8 @@
 				return -ECANCELED;
 			vss->device_running = true;
 		}
-		if (!rc && (vss->direction == SNDRV_PCM_STREAM_CAPTURE))
+		if (!rc && (vss->direction == SNDRV_PCM_STREAM_CAPTURE ||
+			    virtsnd_pcm_playback_progress_pending(vss)))
 			virtsnd_pcm_schedule_period_elapsed(vss);
 		return rc;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
@@ -1260,7 +1276,8 @@
 				virtsnd_pcm_trigger_failed(vss, epoch);
 			} else if (virtsnd_pcm_start_queue(vss, epoch)) {
 				virtsnd_pcm_trigger_failed(vss, epoch);
-			} else if (vss->direction == SNDRV_PCM_STREAM_CAPTURE) {
+			} else if (vss->direction == SNDRV_PCM_STREAM_CAPTURE ||
+				   virtsnd_pcm_playback_progress_pending(vss)) {
 				virtsnd_pcm_schedule_period_elapsed(vss);
 			}
 		}
@@ -1610,6 +1627,7 @@
 		}
 		if (!paused_pointer)
 			hw_ptr = vss->hw_ptr;
+		runtime->delay = bytes_to_frames(runtime, vss->playback_latency_bytes);
 	}
 	if (paused_pointer) {
 		if (defer_work)
@@ -2226,6 +2244,7 @@
 	vss->pcm_indirect.hw_data = position;
 	vss->pcm_indirect.sw_io = position;
 	vss->pcm_indirect.sw_data = position;
+	vss->playback_latency_bytes = 0;
 	vss->pcm_indirect.hw_ready = 0;
 	vss->pcm_indirect.sw_ready = 0;
 	vss->pcm_indirect.appl_ptr = runtime->status->hw_ptr;
