Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793156033;
	b=vXmbKZTV9q6AQZvBdQ1pqnMDVMkh95jip7g8O2CARL4dcNXZRdchtdp8Fs1sVDgSNm/X
	 VnSXQzXIc+fX6zWkhVw/MnbSKlHifnWA/YQmvgXt8LC+dnvTQh6zfjw4rYx5DwxoopOKr
	 4RZerkPljwtsopdf8o3lgppgJD57uF577pe6fhXCLlCsZ6a4urhsS2sRbrH7NH1TFDE7w
	 mR6hBE6PjBxgrfelnpWXKisDD55+fawlx6yh6jVuS/YBzYbH0utaPjCbSRDpssbA/6YW4
	 PwvVrXFE4b0xiguIKsWaTkyrOngrD9JQ/4XybGuxWcy2fRNmpYwxHNnIrGNgBPr4A8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793156033;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1SSKD9R3/tZDll832XAf/4iUolviOcI2RSxt/Z/hu94=;
	b=vSQs/5FmEJOqP+gBh40ntX6cv3J9Iby4IctB4s9z5s3uzf/aVXXn3x9HNm2sj5r23AIZ
	 L3hL1pj0R7yEjnpHBmimc/4/a20uaYDJc9owX2fSkJB2yWXJTKXmZXmfgjTmjfnobJ0eZ
	 x2OjOl/J/Dsy5yUqnrZl7que+maCYyHbqVyyhHjKRuPnzJpXTSyrBLUPFSBy5q/Hkd5vK
	 ytmFZ9YvBIL4xYOsy1D5DaQbLukmrDJcw/2qtyaDA9vygjRqmojsxQuLmsYgcydCgKL/k
	 HGjjSjd9IWKk0vCZce7GWKl3Wk5cg40s+EYp+WL72ipw9rfrXURy2tq6RF+5PcoxXDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dHoWP+FL;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62F060A2636
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 02:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B62F060A2636
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dHoWP+FL
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso895370eec.0
        for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 19:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793156032; x=1793760832; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1SSKD9R3/tZDll832XAf/4iUolviOcI2RSxt/Z/hu94=;
        b=dHoWP+FL0dDwsWWGqU72DapFck3uMT835UuSCjb/+NpEKom+9K1zlbSzhpYtObkZ9m
         XZLGYfi46PrDfjTv7jZ9rqfSjubdFtqMlJ9laTX47U5jSCCTFejsxhxVB5PbEO7YjIIQ
         f8RShiNeyTV3KfMwyXJkbtC9pRBoPaIEPx8/zoPmuzLKKtOVSFwVmmLGux6DjHY9btRc
         +kKG/m/ODm6yB/g7QzgjrekbhDYdbqC4IgBxzs3RQY1e28DYKbvtR86/k5HQADZb+4UV
         SK7YibEEeB3Usf5TSlgyIA2mKa5hYGHh7RBY9tbDtNOTHcb6Dlz0JytcGy3trTEcUjYK
         w+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793156032; x=1793760832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1SSKD9R3/tZDll832XAf/4iUolviOcI2RSxt/Z/hu94=;
        b=dDCXoTAQLuMcqvWiz9Fp6Jt2UVr/vBgjs39+LemXJErSiRnVQNjJ/nNN3CjLlb6U6V
         hayjWxMldxuTyZSDJs9kcpgohTwSsjS7OVHMkpph3gJn7Jn7rbfhjOA88pOZ/NbkJdH0
         O+JmTBerdBgdzjO6EUxJLW7Rehfo98azCwOjULUisUOqvcZuSq0vQQtmw8h8Mu5zwih2
         004q6wIxmLMnZs8LyqQsZx7njezZcZaSartsaSdYxdQ4gLfA4n8oYZzw2OxBaqNJ5gbM
         oWUwLS8kZoT9MpTO5DxpB6uQZJzkrv8nm2FfmCws/PSMsejQXcowfonAcnCZbafbVrXw
         byEQ==
X-Forwarded-Encrypted: i=1; AKwUvBxf4CYKtFyYcaSdDxLq1neqCb8MFB5kIOwzsnHtV1qlbLTaCsZ9pcSQ1y9K4SlUX87eGoZlcwMvFpXQl2KUhw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJPo/daZY3qB1OR+n1+KiSvWqRu7O5IMhs92R1/BZT9ym5roKoG
	3qUm1S01rZskU9RMx7XuwwdN+Kc2tIzEUg3krK6hxLlVFa5krG6Dzitn
X-Gm-Gg: AYBFou1PHsDUhqTNtIrPJONDVmyJAsgiSe6XgwLNGkBrB7zbCK8twBUycqutnngjZMd
	ZEf+ghcY7V2WfBmsibBujeOVM7L8YVEv7JmFj5D4r6ipSiZKI85TEN4DGh3GYkCr4gsOWPJk19e
	tqBwRofd5CDQlDzEt80vfVAe/NzFquSYYmGTnYbd+0lQhUSqkgOXMJgv5tX7s7h+lugYySB+Kef
	tK+mS9WMEFd9OkFXgTZ3EgWEF9ThIQbtTy0J898H8Dw1Mci908fKRZFfkQFN8uPd7VYWHnaVd6K
	1zk1pDcArMVB9AfUJ9JsVsTAc++tVIdEgfPAK7LcgH53FXNg1M+yoX/e4dRpSeLxyhGHaLr/Kim
	3O46HoSpRzGP8tPNWRO6AgvDh9SYlOvuUSB5Mr+uHWi+99V8RwHDQ39Io8//vOpcszhz/GGji/1
	n1wj+QOIbpx1OUmEZedf6w8ZiFqEkZOPVZf+U3grfEY9VmS5mlX//By+r8fO8r2qpiPaTkMTm94
	SLPKOMegvWQ+SpuzYmj+jZmu1ql/Z9qjIz8d9O3sSlc6FbP7oWI2IqAqn0tddv0Tn1wqx++chP6
	Hr8BLrv9/kfCuaXeU+dbBj9PLA5AP+Z1wXduR4B4oOMcWBwe9VWQKVP83U0BmUQXL+7Ffy1EmMR
	Eg+ecRy8GjAObqVOqhAgR/I41OwnfliMu6ZdLOXbemvpm4l0=
X-Received: by 2002:a05:7300:3a9d:b0:35c:85fa:5a61 with SMTP id 5a478bee46e88-36a201eb246mr1662143eec.38.1793156031765;
        Tue, 27 Oct 2026 19:53:51 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a239644efsm1711914eec.23.2026.10.27.19.53.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 19:53:51 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.de,
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
Subject: [PATCH v6 09/14] ALSA: virtio: prioritize staged capture period work
Date: Wed, 28 Oct 2026 11:53:12 +0900
Message-ID: <20261028025317.92450-10-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261028025317.92450-1-mynameisjune111@gmail.com>
References: <20261028025317.92450-1-mynameisjune111@gmail.com>
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

CPU contention can delay staged capture period notifications while RX
completions continue filling the unread ring. In a two-vCPU VZ guest with
16 nice-0 CPU workers, the ACK-fixed baseline stopped with ring_capacity
and EPIPE in three runs, after 11.74, 30.77 and 30.33 seconds of audio.

Route staged capture period work through system_highpri_wq with a common
helper at all ten producers, including ACK errors and self-requeue. Keep
playback and non-staged streams on the normal workqueue. Initialization,
cancellation, buffer geometry and capture accounting remain unchanged.

With the same kernel, input, geometry and userspace priority, the candidate
completed three 70-second captures and immediate reopens. Its maximum
matched queue-to-start delay was 20.366 ms, versus 108.112 ms in the first
baseline failure. The other baseline failures had pending work without
matching execution, so matched-only statistics do not bound that delay.

Reader scheduling delays were also present. Both arms passed a separate
nice -10 reader control, and host load varied between runs. These results
support the change for the tested workload without isolating a kernel-only
cause or guaranteeing lossless capture under arbitrary CPU load.
KASAN/lockdep QEMU regressions passed with the unchanged candidate source.

This follows the staged ACK fix and pending VZ capture support. The
introducing staged-capture patch has no upstream Fixes commit ID yet.

Link: https://lore.kernel.org/all/rfc-v2-vz-capture-compat-1.b9ab4c1540dc4691@gmail.com/
Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>
---
 sound/virtio/virtio_pcm.c     |  4 ++--
 sound/virtio/virtio_pcm.h     | 12 ++++++++++++
 sound/virtio/virtio_pcm_msg.c |  6 +++---
 sound/virtio/virtio_pcm_ops.c | 10 +++++-----
 4 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
index a3478fc8848db..d8515b2144a14 100644
--- a/sound/virtio/virtio_pcm.c
+++ b/sound/virtio/virtio_pcm.c
@@ -397,7 +397,7 @@ static void virtsnd_pcm_period_elapsed(struct work_struct *work)
 	}
 
 	if (requeue)
-		schedule_work(&vss->elapsed_period);
+		virtsnd_pcm_schedule_period_elapsed(vss);
 }
 
 /**
@@ -606,7 +606,7 @@ void virtsnd_pcm_event(struct virtio_snd *snd, struct virtio_snd_event *event)
 			if (vss->xfer_enabled) {
 				vss->xfer_xrun = true;
 				if (vss->capture_staging)
-					schedule_work(&vss->elapsed_period);
+					virtsnd_pcm_schedule_period_elapsed(vss);
 			}
 		}
 		break;
diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
index e143a15592f05..5d1d88f2823b2 100644
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -8,6 +8,7 @@
 
 #include <linux/atomic.h>
 #include <linux/virtio_config.h>
+#include <linux/workqueue.h>
 #include <sound/pcm.h>
 #include <sound/pcm-indirect.h>
 
@@ -114,6 +115,17 @@ struct virtio_pcm_substream {
 	wait_queue_head_t msg_empty;
 };
 
+/* Keep non-staged PCM notifications on schedule_work()'s normal queue. */
+static inline bool
+virtsnd_pcm_schedule_period_elapsed(struct virtio_pcm_substream *vss)
+{
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
+	    vss->capture_staging)
+		return queue_work(system_highpri_wq, &vss->elapsed_period);
+
+	return schedule_work(&vss->elapsed_period);
+}
+
 /*
  * ALSA may observe a subperiod tail before its period callback. Keep actual
  * unread occupancy separate from pointer observations and notification state.
diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
index 795e52e09564b..663f7695b5be8 100644
--- a/sound/virtio/virtio_pcm_msg.c
+++ b/sound/virtio/virtio_pcm_msg.c
@@ -627,7 +627,7 @@ static void virtsnd_pcm_capture_xrun_locked(struct virtio_pcm_substream *vss)
 {
 	if (!vss->xfer_xrun) {
 		vss->xfer_xrun = true;
-		schedule_work(&vss->elapsed_period);
+		virtsnd_pcm_schedule_period_elapsed(vss);
 	}
 }
 
@@ -720,7 +720,7 @@ static void virtsnd_pcm_capture_complete(struct virtio_pcm_msg *msg,
 			virtsnd_pcm_capture_xrun_locked(vss);
 		}
 		if (got_audio && !vss->xfer_xrun)
-			schedule_work(&vss->elapsed_period);
+			virtsnd_pcm_schedule_period_elapsed(vss);
 	} else if (!vss->msg_count) {
 		wake_up_all(&vss->msg_empty);
 	}
@@ -858,7 +858,7 @@ static void virtsnd_pcm_msg_complete(struct virtio_pcm_msg *msg,
 		runtime->delay =
 			bytes_to_frames(runtime,
 					le32_to_cpu(msg->status.latency_bytes));
-		schedule_work(&vss->elapsed_period);
+		virtsnd_pcm_schedule_period_elapsed(vss);
 	} else if (!vss->msg_count) {
 		wake_up_all(&vss->msg_empty);
 	}
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
index 85e7576903d56..d50924b792f65 100644
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -232,7 +232,7 @@ virtsnd_pcm_pause_restart_fail(struct virtio_pcm_substream *vss,
 				VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED;
 	}
 	if (notify_xrun)
-		schedule_work(&vss->elapsed_period);
+		virtsnd_pcm_schedule_period_elapsed(vss);
 	vss->substream->runtime->stop_operating = true;
 }
 
@@ -1253,7 +1253,7 @@ static int virtsnd_pcm_capture_staged_ack(struct virtio_pcm_substream *vss,
 			return -EPIPE;
 		if (!virtsnd_pcm_capture_counters_valid(vss)) {
 			vss->xfer_xrun = true;
-			schedule_work(&vss->elapsed_period);
+			virtsnd_pcm_schedule_period_elapsed(vss);
 			return -EPIPE;
 		}
 
@@ -1264,7 +1264,7 @@ static int virtsnd_pcm_capture_staged_ack(struct virtio_pcm_substream *vss,
 		if (diff < 0 ||
 		    (snd_pcm_uframes_t)diff > runtime->buffer_size) {
 			vss->xfer_xrun = true;
-			schedule_work(&vss->elapsed_period);
+			virtsnd_pcm_schedule_period_elapsed(vss);
 			return -EPIPE;
 		}
 
@@ -1275,7 +1275,7 @@ static int virtsnd_pcm_capture_staged_ack(struct virtio_pcm_substream *vss,
 				       &next_acked_total) ||
 		    next_acked_total > vss->capture_copied_total) {
 			vss->xfer_xrun = true;
-			schedule_work(&vss->elapsed_period);
+			virtsnd_pcm_schedule_period_elapsed(vss);
 			return -EPIPE;
 		}
 
@@ -1292,7 +1292,7 @@ static int virtsnd_pcm_capture_staged_ack(struct virtio_pcm_substream *vss,
 			rc = virtsnd_pcm_capture_send(vss);
 			if (rc) {
 				vss->xfer_xrun = true;
-				schedule_work(&vss->elapsed_period);
+				virtsnd_pcm_schedule_period_elapsed(vss);
 			}
 		}
 	}
