Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794444446;
	b=d65PsYspcLw/VDjcvdQawakEO5WuNkkDzOHbD3PJHpftrT94tLNNfLK1DS0Xwif+piqC
	 l9T4bIXRevtj+yXo9VeCCE6i2sPJPZJJ11SG67voej2E5VpgHNnHDRgBBHYTLPD1VDedV
	 ku/iM6uxJMigFBgq3HfNoYRSpbflhoY9tRVNfYzVIFmsJ1iEuNnz/Nt+Ks7O/1tTwlyrg
	 2VwS2LonJ+j3eqOz3WF/0wSNcQ+vCxql3XqEHXDNEQxE3ExTnqVgTQCb8jcxbNJYgeMzi
	 ODkjfmlzIddJl+GpA+tt+UtQj95tZAX4An2JPFgd8Tc7YpelSkf8U64ZqmZhLxlcyCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794444446;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6WXLhdA9GsEkrddx60iks/fOWkdskBmQv8j22OOgMQQ=;
	b=wuWgtOSgrn8fKiUne7gPdNvuBRsKgf6nyleKd++FnBaWVJlyibn28uYEHcdgR/S+wXeH
	 E1Sytn/6d9sisS0Cloz1+V71xSRF0uTloWi1Sv58p36MP0sew4tfDMYF6IoJAZPJdXXUT
	 PhXnQc7CDbkIzG5xeQtS3s+z0lL3zck1JHCEqGKcdG2fhJsyrFsasJXl58wvgm13Vm+Va
	 EMQu+azyitHN/xEwWq/uD8p5sS5XduC/zATai3f+ZyaPuWVVgoCQ3AHTBvUC5vQqB2bVt
	 U0OtY8CvQrSab83wzVEPBSgIqkGyZl1yy6KMm+ZvDPd9ykB2UfLAaIyASUpW63r4bQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fQtzZ+ZW;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C1860A3827
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 00:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99C1860A3827
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fQtzZ+ZW
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1b3acec6677so5592137c88.1
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 16:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794444445; x=1795049245; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6WXLhdA9GsEkrddx60iks/fOWkdskBmQv8j22OOgMQQ=;
        b=fQtzZ+ZWhFJwPhSmIZaYQBgyqyffEedp39BT92c9KFvVpBFzfGCbCijuhY2RDAc6Cf
         gGUumi80JobzMQNpMinzmqAW1d1oHPmkxtpV+TXMT3yqbVp+kXKoAJA4AqOvJSsw3jyQ
         mGcyBGSOaPLntcgf3pytfsY+YIzbASs9gchLz64OaGouIehoUhOCgYncmBuUsUTmm4i4
         /dz9aTTZk/WLP+CuzKpyzXYIPmukEtuw4T4TUG5bxYZmcOYSvsmFTLfLxkRpt+xhS/ua
         T+Ry6ez3Lx8o6u17qVKMEzwejTKjJgx6l6lddYFkVCMoxi3AbQtXBAJ5eYMn65szdw4g
         mxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794444445; x=1795049245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6WXLhdA9GsEkrddx60iks/fOWkdskBmQv8j22OOgMQQ=;
        b=Ia5qLR7QotO9018hetUtPBVKe+6DUbNMf28XcKP8LGNkOV31sV5pn6ge06vr9ao15g
         zcT9lVZK+vrCp1OBotIFkdi8Ld380rcL61U4TlvdLaVnOuxxx+kDBvwPZ+9fxT0v9r/+
         nubm2N84vj0JxD9SbII3lcv4uBl7gGOjwMBQV2lu4lcsBuE0oRmki9YC3nXV930U5i46
         PCfr4CDLG/ZoFrYbiKS4Ax7NZ28NmM0WzcLTWlwAuFgWhtfAZT2bYcKP5zH1WIeOlkl/
         wFbui1H4gAs0YS8s7N8tJDTPBeZRq7GqzwIXcB+fV+bTJ2lZRr+kuIx36v9+/6Dd0u21
         fC8g==
X-Forwarded-Encrypted: i=1; AL+hErEQUEco49Bevc7hPMn5fflAc4duaFOv2PRjjXf7HRSrxD6K/RlyFJiAVtkXLQ68BsNUO689Af7vk9+xpoV9sQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/Y60RBjOWxBzfRakf4DqGjETeKPlOqX/GFuNGTfv0BG5cudYHD
	TWq8WdUfIQuZmYqaV9/jq8Q+w7Z5jXsOwllHK/Vjn5pDW7Uu0xRLBwB7
X-Gm-Gg: AYBFou3548vZe4SLuDQCdJEyL0QfiXqAUM8TCNBuAoWc1F8uJOnGcn3RZ8p0HTN99fA
	ywdWT4qOiT6hjeAkQhvxIXqv4NmJN93Xs336k4CXLQHGQlpB4y9rYWCLDVscIRTKl+ZCLUq83R5
	j8w/NLVfMKIaJLaT2/JvHYYh3FZVbBiXeliv6km7laGKGwVNNdWk1iEwjVWoPFVkOxx3sxDdyAT
	Yk5evpVyt5K3mk5J2KhtF0ex/TnEUgH88oFGmqKUYwZsiFJ9ZBPBUq6I5BatB9HlALh/Axbex7V
	3SbMxxz8IEXellcBTOuaBvWEea5qYy5qwiAQQmd8UTcl62rR+3UBRS+uqtPC5L35nunmI7PVztS
	LiaUyqzV1kiB5B1FWFhSaxXLC+PorechEMrP1atsPqBcnrpUp7zGV9tXPrrM2oMpEBytzUz3qyx
	h8ZAd7i5IYFDRh+eXo17BKRkoC+PfcN/56jDHLw3HbX+o3FMaufHWZsjZE3Jt6MLjPRp4KAZYbb
	m93kUTN4HtII4cg51mHWDmEahE2R5RqTkGWwfgNfYCqs6I9bDliooa1avk8SAzAtgWQfmlPGmE5
	FpsDk0i9QoHX8dHWftKexwKemekX83l+kzR3+mExjjZlKqVjmUAm6Tz+kaM+cynKFFFB5KObTHd
	Wk0ZQzCHXUJ0kFG9HLM2t05aq8mff9AH+JLpGiEjHnbsPbZg=
X-Received: by 2002:a05:701b:4506:10b0:1b2:4f97:27d7 with SMTP id a92af1059eb24-1b3c034d7ecmr3276956c88.36.1794444444510;
        Wed, 11 Nov 2026 16:47:24 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2eeffsm20672163c88.9.2026.11.11.16.47.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 16:47:24 -0800 (PST)
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
Subject: [PATCH v27 04/17] ALSA: pcm: notify drivers after linked prepare completes
Date: Thu, 12 Nov 2026 09:46:51 +0900
Message-ID: <20261112004704.49758-5-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112004704.49758-1-mynameisjune111@gmail.com>
References: <20261112004704.49758-1-mynameisjune111@gmail.com>
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
