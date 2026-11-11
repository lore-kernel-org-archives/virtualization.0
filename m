Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355566;
	b=4Xqv4Y+0X/0HexxWHv/7Cn+LPiYKszDceUIPc32jyw+/z/G+Xdtms/0Uu5FmbfyIi8iB
	 3l6cGE22OSeX25KbP+XdZQy5laRGfyIMv1CckmhVyIMjIMLCtby8lzyx/jNIq5mpXb0Zf
	 9LbxAA2GAUedeC7+qmYKxKwIvQQX/V2q4IiBk/eOhKpYpWgdT9clKHzM9um/Vl/3YvBBI
	 MTPRoyntPVBcV1C0TwyJSCQx236qO0rlReStlxTGH6/mjarozJp20pJhRXT/NkvHdMHjJ
	 EY6+w3zl7CmvfFqxFgSfmxjIcSQSEKBS9nFohtyq8H/GiAek062jPGV1kDzm6C9cLdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355566;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zmiIgqy4cjH0UGo3VGOzKAUEYd5iSjgfVUfTajSB4Yc=;
	b=wVKMUq4ZuqZhbjeMp4HejMRO+jjafztctF7scPw7N8B+jKMvRx66sw09baGg8RITJthB
	 /dxy/GgaA9WVMZcutNufOoyB974E1FW/Ece10ucFM/FWpRQokW+kQzFK7PiAeo++CUrLX
	 UC6NpOdN1qE4+RLwAoGB+aVmCm2zvhjevCSm0KZIRAPUJ+MPeEzAW5B7vH9gagv8EZ1ql
	 ZBYFGYqRaejScMJhec/KHPRAumpzfUexxEozbZ9OaexQaIbpCXvZ0r6YA6eqf7JnBxNth
	 5imWGqqW4cfaOfZV1gGF3IB025b4NSgZ2QOdpeiEXQGXtl6bDnfNZArUa5BQaoDbhnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G8dU7l9X;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0E260A262B
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 00:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE0E260A262B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G8dU7l9X
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso1372299a91.2
        for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 16:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794355565; x=1794960365; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zmiIgqy4cjH0UGo3VGOzKAUEYd5iSjgfVUfTajSB4Yc=;
        b=G8dU7l9XKar4uNFOHGMtieAXiwZwoPjbwdLKbN+enn8fpohEN1O1KjiV+jpoSRV8k5
         c9rSY/GYpAwephLnGsZ1gDwcrQqzVRkYlFrLWwk36xWYglsKVcqgEhR7iwHvy+AtZhKv
         KCELD8MtMMLHUmejL8Sd8yf6yDhefIvvblyWBMQKfEzByFxPTFFgQZp9j654T04P48t3
         oCZJ7Fl7Z0uX/+zqEMLXB1KrNqplnuOLycIkBFwriCLgfVzM8NpPUAJREPnb+0hPqtX2
         /udCH8eoFH+t90P1mzMUJC3+rkMW3V0Q4MBH3fGFL21HaRywPYfAkeLdOcnpKIX85Wec
         K8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794355565; x=1794960365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zmiIgqy4cjH0UGo3VGOzKAUEYd5iSjgfVUfTajSB4Yc=;
        b=qpQe8M+/uG5tuVw90lwFANqJumDqQvwBEY8jbr8btbCL9f06y9zBfmBerje+7cmgOP
         jez7FO8f0okAapHSnVgvQF5QR+glx7sWGx/9D8HM3HHXAQAgX2+tfKRYUj/m5TIWzkVS
         WyHhvuIg1tG7YMBSkIF80tuFD/52QimoXh5L8FpIHXJ9YpL4O0kwpnbl7GuxzW9S5+t7
         00GwQz08UVr2GntO8HISovyRrj3Tv1t7ZDlhWu1vmBHdWWqZPV9KgYeYV98/qFYuw8IB
         VaXmkmSCxFBH3Ik2k09QCaS7e/dfXRIjAWfVjNiAfxRhzZb88UHb4CvwYSfnKLw6QYUs
         SGbA==
X-Forwarded-Encrypted: i=1; AL+hErFiAZybwcmKPuOb9ZIIyL1gpCcg54cMJvwHBlCEyh8rhkXTnNYrfq73okFAhXvBMyjqRo0PGCY/B6fVFDb3EQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8DJCVdD9yUUbEB0KjMGS7G8+Zio59iyaIusfR96p+VKsSfNrXX
	dc6KZhgXfqultIlXmcFf1oleK7+q3mLwSJ/6WNmIRrGZnAqgdkAhat0S
X-Gm-Gg: AYBFou1qzhuKCKMqjhGvkIRIzzi7FDor66j71wWQTPqwiz8LxVoLrSLwxt/ks1S+qI2
	DpdXXPl5uC2knUg93PnsXmxzwEpISmWfDnrNaSnNhMyuMM+V4xR00fiqIawsv4vESIOLWS1GhGr
	tlCFzra/l+fHRBFtY7VzXpxLxCVBbTWANOvMugBbNNAWf0g1ekYCS78kMVqz/fnwhohrXxtTsr4
	/WWtddhbJLeELqe3VohcyL5NYx0it62dDS7Z4RrNC+hP1L6LkssNZklg82ROO/fwsJoHG8Igq5G
	tT/taFEPvtXQSlpVqQzWTVBR8KYoaVT4yf4dASCyylvHtULxJBb7pBrZ2cWJJaOtKvKZDDI0huS
	3puoyAv96EuX7HiEGt/k4qo3RAiCX2XnIBvrgXxigxssWurDP2wXn3X4ZKpY0O5iaGZE+jGTO/H
	Xcdjr3n+T1mXBP6NN3wxk/V/NIaxQpuBqS1ZV56OwgdsP/VHBS8z7vPmhvYK/Xv1b/eplj9UD5l
	ZdM9cX8xCHLhiuw/qg2qZeaPhCw8vL6UyiO0Y7uJKp9Psph4U/lFv5jKx/aRAbAfpG19xQX7BCb
	JacH3IFinvMQGt7DWQZy5yfQKYjZda6gy6LV7k2DpsgKGCOj0aW0W3S1FA04zObMMDfpy2OXpUt
	BeucHt1PSxix5CkXv2xUV7Be7bdgFn9cPaTwyb2wfvZ3h9zI=
X-Received: by 2002:a17:90b:562f:b0:3b0:b64e:1e34 with SMTP id 98e67ed59e1d1-3b183005a9emr637940a91.51.1794355565026;
        Tue, 10 Nov 2026 16:06:05 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1838e616dsm474361a91.4.2026.11.10.16.06.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 16:06:04 -0800 (PST)
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
Subject: [PATCH v24 04/16] ALSA: pcm: notify drivers after linked prepare completes
Date: Wed, 11 Nov 2026 09:05:31 +0900
Message-ID: <20261111000543.28550-5-mynameisjune111@gmail.com>
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
failing member. Opted-in members in that prefix return to SETUP. Leave
unreached members untouched. Preflight failures have no completion
callback. Preserve SUSPENDED and DISCONNECTED states if finalization
finds either in the affected group or prefix. Successful driver actions
canceled by such a state return -ESTRPIPE or -EBADFD, respectively. A
driver error keeps its original return value. DISCONNECTED takes
precedence when a linked group contains both terminal states.

Do not generate a stop-timer event while closing prepare admission.
Ordinary legacy drivers keep their existing successful preparation and
pointer rebasing. The new callback runs with the group and member locks
held and must neither sleep nor acquire another PCM stream lock.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
include/sound/pcm.h     |   17 +++++
 sound/core/pcm_native.c |  152 +++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 149 insertions(+), 20 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -77,6 +77,23 @@
 			     unsigned long offset);
 	int (*mmap)(struct snd_pcm_substream *substream, struct vm_area_struct *vma);
 	int (*ack)(struct snd_pcm_substream *substream);
+	/*
+	 * Optional prepare completion notification. Called while the core holds
+	 * all linked PCM stream locks, after prepare/reset actions succeed or stop
+	 * at the first error. On success, the core publishes PREPARED for every
+	 * member before calling this with true. If any member is DISCONNECTED or
+	 * SUSPENDED, all states are preserved and opted-in members receive false.
+	 * On failure, called with false for opted-in members whose action ran,
+	 * including the failing member. Their state becomes SETUP unless any member
+	 * in that prefix is DISCONNECTED or SUSPENDED; then all prefix states are
+	 * preserved. Members not reached and pre-action failures receive no
+	 * callback. Standalone RESET does not call this callback. It must not sleep
+	 * or acquire another PCM stream lock.
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
@@ -2089,20 +2113,108 @@
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
+	} else if (!success && !cancel) {
+		snd_pcm_group_for_each_entry(s, substream) {
+			struct snd_pcm_runtime *runtime = s->runtime;
+
+			if (s->ops->prepare_complete &&
+			    runtime->state != SNDRV_PCM_STATE_SETUP)
+				__snd_pcm_set_state(runtime, SNDRV_PCM_STATE_SETUP);
+			if (s == failed_substream)
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
