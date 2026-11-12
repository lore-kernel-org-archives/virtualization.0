Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466191;
	b=W3HJQMNV8QoLr+uz59XQFBo+qlhoFzgbfHGBZ0nD9SwK1t/0iKxEirps6w6Ch5fAphI2
	 voEWCNjbxt6IlfHj3iI6EqboW4WwdEXYlBhlynpjqDJ+ZKCH8abw9GyKtcOvhBcdNaGjK
	 lvbtU14jS9mzRNHqiJJdWm6jYDM9GYqwt8HakYwHSuOT24P8wfun9MjFwPahsGA1SAQ19
	 lIDSwsPCa5bSzyHDHulfxmQi3KQKDnAf49pomgJfEZU7XQ1BTXbRFTwDZYwZy7Kqjghh2
	 xN0fHQiUCjxsaxRczgbWf1bXW/LSIH2TODjZfH6fxZv9hdqnxiVl0JEWAiT+HsQLdkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466191;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6WXLhdA9GsEkrddx60iks/fOWkdskBmQv8j22OOgMQQ=;
	b=ulx/r+Uz7xi1kWZurQJwYIgF017UuJj5jRtjhdavouprn4wEtJro38Yrhqw3Zo3zgj6f
	 YnjljcCvcbOll0DL59P1RgTPagVY2F5E7mYxA/8Ef++xfpEIk1+SYQU5gMBo37WX4qZoz
	 mS+p7QktmX7da1+sId5VXKsW2zKvXo+VGEf7+IkAnXJ+5R2JnbBYb/8cv4BtKAd+9QWlY
	 Y/FcroHnUMohfJ2b4qjgacqU+kUZQfzot34FM0nT4xMr5YsmMNw2Lfc74Hj1IlPTa2+o2
	 YhLut2clQQKPGet9O9uFFiHwYKT9r1/s1+0dSwtvXgVwBVKlBOZcxq/6P80VoWhR21Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P0eQzIWO;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20571606A8AE
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 06:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20571606A8AE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P0eQzIWO
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8b904d10882so1766614b3a.0
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 22:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466190; x=1795070990; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6WXLhdA9GsEkrddx60iks/fOWkdskBmQv8j22OOgMQQ=;
        b=P0eQzIWO7HlYjI8rPKWyWnqgDSNrXlcqoSwW97te8srQW0JGwxvyOYrYGU9J8PZLaJ
         /uQ3YdnbNEOtCDu7vkPATYXF0IbnXOeCWfGEENM264fpZQLCc8U/PAN9jpcs9LZ5i6mX
         sfT8oWJzgA/RWP/Ky7431blvwvmhJGQxXLUe1RtasRp9OCxX+1tDds0E1ppaaKHYV8l0
         uXKLGPUJia1yn3+nr+90DHY1Bf0eSAE0CEqcYIbV2S0ww4VZvINoTIWcZG/RLnfFVn1y
         MDNOgTngAo5iUaE6EvjbefLQCztUR5Q8XmL4RtJsIqcCozviGDgoZaFdYtsbqdpArPdq
         jvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466190; x=1795070990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6WXLhdA9GsEkrddx60iks/fOWkdskBmQv8j22OOgMQQ=;
        b=d/u2N9dazT9pIcxGUg9FXTc4lfASrIQHmuZ2k1bML61qD5pCpZC+Zufq4xuqDRGBHu
         ugUEE+jSHXSs/Qvdu76Af9dTvuCZDJjqu8UX7CwndHZ3XDVksHV3iV3bW886Wx6DbZL5
         5SLXV4DG9MHVmOrhTj2/bwlKr1Vs4ORMgWhDUYUGKHjduItAsjLidGiarZpwNU9GPvwG
         qRu+kbdyxxXOyQ+sXDc13F/8v02sxbmcv+x40LyYsn6++UEZyhkto3lrk7gr1b2UUaJj
         iN0/iVVh2DdVhLYE7EQyJgQN7VIytlYIxysS5AD5cQVH82WbEy5YuyfD0p8ehoLBxf7h
         FwAA==
X-Forwarded-Encrypted: i=1; AL+hErFYrwDeO6rxflGoi64ih0b0FDCORQqRCckWHpZ7L+dKxPqxKOKE75byiR4GpajPlhNW2CTnsUXV/7yLUEUuQw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8kc9OHwkryMjvfB8VTVXbE45uBB6VBfXx3ilUw1V6wyCL2MtEC
	if6KM66yo2Xs2hW884nyM+dFCeG1BYi4nlWhOc7gk6tYBSmV+adtANTm
X-Gm-Gg: AYBFou0xrbsSIXkoVkgRIYiDAiCnvvXERABy3E5RGMY3rsocshjUBf3TKgX5xHAF9Z8
	q9MMenGoVy3UaX0jRB2V223a2B/rW0oIwNrGDVrCtc9cozMByuSVnDDecHpwzX0vfusk3DzVvJ2
	TkwVKTF2nj/40gWYeP1QU12hK2srzdC8Wn95PsmxPTgFjgq5oTkIyPdLzAY33lFiwHuJOtE0MDS
	ZUzCrofmD07h8epvB53VRnjfNjU6/UgJf50DW6P0FAUnloWjxVVfPEYzVfV8eeF5CF0D0OiYfI4
	Y+CG8kvSFKCnbn3s0AkVSDZILs8AsdxI4PqKd3lC3s+OeQA3U3uS/S894jtFfRt/KxO/m9saU0R
	HN/DxlP4S1apQcB+VvsEkVa6xNtkA7NiV2Bfa1FTjt0aFaRXRaB01qTMDygyi1ndn8yKEzLHoL8
	fL9Cvs/mtEZHEXRH4iL4PSV3YWj1K9W4EWgvsm3vEPX88QvCSj9tSb94RdiTsLL6BOztOvXPK7o
	EY9V4HmfqsWyZrBAqd5DtG8qbWOmBYtUML6dt0DQRFRNQlDv+xTYj9QpIg+J3cUmWAD0ACmJbRN
	CR7bHiNhIP9CTiz0IOrmkqTOS/HAzmlPTP5yQD2/pY2R3FWW09KXe34d4TLOGRROCigUC1YEmtu
	Gsydud9YtcLlP3Pq1JVCvH/S6JKt2FhinyyoXh6PifzHOZUo=
X-Received: by 2002:a05:6a21:498d:b0:3de:79fe:13f with SMTP id adf61e73a8af0-3f2fe0a34f9mr3925552637.38.1794466190304;
        Wed, 11 Nov 2026 22:49:50 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab1228e2sm3097511b3a.41.2026.11.11.22.49.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 22:49:49 -0800 (PST)
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
Subject: [PATCH v31 04/17] ALSA: pcm: notify drivers after linked prepare completes
Date: Thu, 12 Nov 2026 15:49:16 +0900
Message-ID: <20261112064929.11211-5-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112064929.11211-1-mynameisjune111@gmail.com>
References: <20261112064929.11211-1-mynameisjune111@gmail.com>
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

A linked prepare can finish one member before another member's driver
prepare or reset fails. Drivers that admit transfers after their own
prepare callback can then accept an ACK while the group action is still
incomplete.

Add an optional prepare_complete callback. After all sleeping prepare
and reset actions have succeeded, take the group and member PCM locks,
publish every PREPARED state, and notify opted-in drivers before
releasing those locks. Keep the buffer locks and access gates held
throughout the operation. A concurrent DROP observes the group before or
after this commit point.

On a driver error, notify only the attempted prefix, including the
failing member. On any revoked prepare, opted-in members in the affected
prefix or group return to SETUP. Preserve DISCONNECTED members and keep
SUSPENDED members suspended, but set both saved suspended-state fields
to SETUP so a later prepare can recover. Leave unreached members
untouched after a driver error. Preflight failures have no completion
callback. A successful driver action canceled by a terminal state
returns -ESTRPIPE or -EBADFD, respectively. A driver error keeps its
original return value. DISCONNECTED takes precedence when a linked group
contains both terminal states.

Do not generate a stop-timer event while closing prepare admission.
Ordinary legacy drivers keep their existing successful preparation and
pointer rebasing. The new callback runs with the group and member locks
held and must neither sleep nor acquire another PCM stream lock.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
include/sound/pcm.h     |   18 +++++
 sound/core/pcm_native.c |  162 +++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 160 insertions(+), 20 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -77,6 +77,24 @@
 			     unsigned long offset);
 	int (*mmap)(struct snd_pcm_substream *substream, struct vm_area_struct *vma);
 	int (*ack)(struct snd_pcm_substream *substream);
+	/*
+	 * Optional prepare completion notification. Called while the core holds
+	 * all linked PCM stream locks, after prepare/reset actions succeed or stop
+	 * at the first error. On success, the core publishes PREPARED for every
+	 * member before calling this with true. If any member is DISCONNECTED or
+	 * SUSPENDED, opted-in members in the affected group receive false.
+	 * Nonterminal opted-in members become SETUP. DISCONNECTED members remain
+	 * DISCONNECTED. SUSPENDED members remain SUSPENDED with both saved
+	 * suspended-state fields set to SETUP. On a driver failure, called with false
+	 * for opted-in members whose action ran, including the failing member.
+	 * Members not reached and pre-action failures receive no callback. Standalone
+	 * RESET does not call this callback. It must not sleep or acquire another PCM
+	 * stream lock.
+	 * A terminal-state cancellation returns -EBADFD for DISCONNECTED or
+	 * -ESTRPIPE for SUSPENDED.
+	 */
+	void (*prepare_complete)(struct snd_pcm_substream *substream,
+				 bool success);
 	/*
 	 * Optional RESET operation, also used after a successful prepare.
 	 * Called with this substream's PCM lock held; atomic streams must not
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1310,6 +1310,10 @@
 			    snd_pcm_state_t state);
 	void (*post_action)(struct snd_pcm_substream *substream,
 			    snd_pcm_state_t state);
+	int (*finish_action)(struct snd_pcm_substream *substream,
+			     snd_pcm_state_t state, bool success,
+			     struct snd_pcm_substream *failed_substream,
+			     bool stream_lock);
 };
 
 /*
@@ -1350,12 +1354,19 @@
 					ops->undo_action(s1, state);
 				}
 			}
+			if (ops->finish_action) {
+				ops->finish_action(substream, state, false, s,
+						   stream_lock);
+			}
 			s = NULL; /* unlock all */
 			goto _unlock;
 		}
 	}
-	snd_pcm_group_for_each_entry(s, substream) {
-		ops->post_action(s, state);
+	if (ops->finish_action) {
+		res = ops->finish_action(substream, state, true, NULL, stream_lock);
+	} else {
+		snd_pcm_group_for_each_entry(s, substream)
+			ops->post_action(s, state);
 	}
  _unlock:
 	/* unlock streams */
@@ -1379,7 +1390,8 @@
  */
 static int snd_pcm_action_single(const struct action_ops *ops,
 				 struct snd_pcm_substream *substream,
-				 snd_pcm_state_t state)
+				 snd_pcm_state_t state,
+				 bool stream_lock)
 {
 	int res;
 	
@@ -1387,10 +1399,19 @@
 	if (res < 0)
 		return res;
 	res = ops->do_action(substream, state);
-	if (res == 0)
-		ops->post_action(substream, state);
-	else if (ops->undo_action)
-		ops->undo_action(substream, state);
+	if (res == 0) {
+		if (ops->finish_action)
+			res = ops->finish_action(substream, state, true, NULL,
+						 stream_lock);
+		else
+			ops->post_action(substream, state);
+	} else {
+		if (ops->undo_action)
+			ops->undo_action(substream, state);
+		if (ops->finish_action)
+			ops->finish_action(substream, state, false, substream,
+					   stream_lock);
+	}
 	return res;
 }
 
@@ -1469,7 +1490,7 @@
 	if (group)
 		res = snd_pcm_action_group(ops, substream, state, true);
 	else
-		res = snd_pcm_action_single(ops, substream, state);
+		res = snd_pcm_action_single(ops, substream, state, true);
 	snd_pcm_group_unref(group, substream);
 	return res;
 }
@@ -1501,7 +1522,7 @@
 	if (snd_pcm_stream_linked(substream))
 		res = snd_pcm_action_group(ops, substream, state, false);
 	else
-		res = snd_pcm_action_single(ops, substream, state);
+		res = snd_pcm_action_single(ops, substream, state, false);
 	snd_pcm_buffer_access_unlock(substream->runtime);
 	return res;
 }
@@ -1660,7 +1681,7 @@
 int snd_pcm_drain_done(struct snd_pcm_substream *substream)
 {
 	return snd_pcm_action_single(&snd_pcm_action_stop, substream,
-				     SNDRV_PCM_STATE_SETUP);
+				     SNDRV_PCM_STATE_SETUP, true);
 }
 
 /**
@@ -2063,9 +2084,12 @@
 static int snd_pcm_pre_prepare(struct snd_pcm_substream *substream,
 			       snd_pcm_state_t state)
 {
-	snd_pcm_state_t cur_state = snd_pcm_get_state(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	snd_pcm_state_t cur_state;
 	int f_flags = state;
 
+	guard(pcm_stream_lock_irq)(substream);
+	cur_state = runtime->state;
 	if (cur_state == SNDRV_PCM_STATE_OPEN ||
 	    cur_state == SNDRV_PCM_STATE_DISCONNECTED)
 		return -EBADFD;
@@ -2089,20 +2113,118 @@
 	return snd_pcm_reset_substream(substream, true);
 }
 
-static void snd_pcm_post_prepare(struct snd_pcm_substream *substream,
-				 snd_pcm_state_t state)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	/* The reset callback path already completed this rebase under the lock. */
-	if (!substream->ops->reset)
-		runtime->control->appl_ptr = runtime->status->hw_ptr;
-	snd_pcm_set_state(substream, SNDRV_PCM_STATE_PREPARED);
+static int snd_pcm_finish_prepare(struct snd_pcm_substream *substream,
+				  snd_pcm_state_t state, bool success,
+				  struct snd_pcm_substream *failed_substream,
+				  bool stream_lock)
+{
+	struct snd_pcm_substream *s;
+	struct snd_pcm_group *group = NULL;
+	bool cancel = false;
+	int cancel_err = 0;
+	int depth = 1;
+
+	if (!stream_lock) {
+		snd_pcm_stream_lock_irq(substream);
+		group = snd_pcm_stream_group_ref(substream);
+		if (group) {
+			snd_pcm_group_for_each_entry(s, substream) {
+				if (s == substream)
+					continue;
+				if (s->pcm->nonatomic)
+					mutex_lock_nested(&s->self_group.mutex, depth);
+				else
+					spin_lock_nested(&s->self_group.lock, depth);
+				depth++;
+			}
+		}
+	}
+
+	/* Preserve terminal states instead of publishing a partial group commit. */
+	snd_pcm_group_for_each_entry(s, substream) {
+		struct snd_pcm_runtime *runtime = s->runtime;
+
+		if (runtime->state == SNDRV_PCM_STATE_DISCONNECTED) {
+			cancel = true;
+			cancel_err = -EBADFD;
+		} else if (runtime->state == SNDRV_PCM_STATE_SUSPENDED) {
+			cancel = true;
+			if (!cancel_err)
+				cancel_err = -ESTRPIPE;
+		}
+		if (!success && s == failed_substream)
+			break;
+	}
+
+	if (success && !cancel) {
+		snd_pcm_group_for_each_entry(s, substream) {
+			struct snd_pcm_runtime *runtime = s->runtime;
+
+			/* The reset callback path already completed this rebase. */
+			if (!s->ops->reset)
+				runtime->control->appl_ptr = runtime->status->hw_ptr;
+			__snd_pcm_set_state(runtime, SNDRV_PCM_STATE_PREPARED);
+		}
+	} else if (!success || cancel) {
+		snd_pcm_group_for_each_entry(s, substream) {
+			struct snd_pcm_runtime *runtime = s->runtime;
+
+			if (s->ops->prepare_complete) {
+				if (runtime->state == SNDRV_PCM_STATE_SUSPENDED) {
+					runtime->suspended_state =
+						SNDRV_PCM_STATE_SETUP;
+					runtime->status->suspended_state =
+						SNDRV_PCM_STATE_SETUP;
+				} else if (runtime->state !=
+					   SNDRV_PCM_STATE_DISCONNECTED &&
+					   runtime->state != SNDRV_PCM_STATE_SETUP) {
+					__snd_pcm_set_state(runtime,
+							    SNDRV_PCM_STATE_SETUP);
+				}
+			}
+			if (!success && s == failed_substream)
+				break;
+		}
+	}
+
+	if (!success || cancel) {
+		snd_pcm_group_for_each_entry(s, substream) {
+			wake_up(&s->runtime->sleep);
+			wake_up(&s->runtime->tsleep);
+			if (!success && s == failed_substream)
+				break;
+		}
+	}
+
+	/* Publish all states before any driver observes completion. */
+	snd_pcm_group_for_each_entry(s, substream) {
+		if (s->ops->prepare_complete)
+			s->ops->prepare_complete(s, success && !cancel);
+		if (!success && s == failed_substream)
+			break;
+	}
+
+	if (!stream_lock) {
+		if (group) {
+			snd_pcm_group_for_each_entry(s, substream) {
+				if (s == substream)
+					continue;
+				if (s->pcm->nonatomic)
+					mutex_unlock(&s->self_group.mutex);
+				else
+					spin_unlock(&s->self_group.lock);
+			}
+			snd_pcm_group_unref(group, substream);
+		}
+		snd_pcm_stream_unlock_irq(substream);
+	}
+	return success && cancel ? cancel_err : 0;
 }
 
 static const struct action_ops snd_pcm_action_prepare = {
 	.pre_action = snd_pcm_pre_prepare,
 	.do_action = snd_pcm_do_prepare,
-	.post_action = snd_pcm_post_prepare
+	.finish_action = snd_pcm_finish_prepare
 };
 
 /**
