Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794267670;
	b=e7EqG3Lbce5fKC8o6O2uR+SQPz1AMVl6PUfIoLXWnQRke08YNIweDGEfIaxIDR78M3mm
	 BwQtbRg5M9hQxnV86ahLKEJLReGbJZ4OQoWKptF2DbJgX2e3LxAjG5c1R1pXCb6L9Rrgj
	 M8oLEVZdnrOAwEe70pXKlWMcJZ8hHqeeOTaKV78CLemBgIEWGHAlXwqD0BLns5NAa6JXD
	 FGoj0W6uZfbnXzMGANAJA/SspkvGrrmTWcWly+ZGZDy35FStyHJ8qVyp5E4AAUbji7CbU
	 GQZUIAuGMTMB8DkBpU+GbVJ7l8bENGGOrfzU8QDPSppt2NkVc+SKEzyShQ0EIaxZg0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794267670;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zmiIgqy4cjH0UGo3VGOzKAUEYd5iSjgfVUfTajSB4Yc=;
	b=rDwttWIFMHqqzaUxTuGpq50hIGPMWE1iZagAG6PiHp11++8kBj5cQvTj16qtKkoV5iFl
	 OA2ZDzjwhVYXN56DWPyJ9b98Xbhs5IacTtNUI9WTpg0s+pG1MnvRt59Xbjhj15yzdvR6F
	 UTMoTXYRN4Z9fl41+4mHh9KvP8+TBm5ZpTZimlf07m+LJOHLid1vOUivfh+cWPMKSMNPb
	 aQiuvGFR1qUhg3jN3fxUYWXKGEdSUHm4oS4ELaixoNzr3NSxanj7MLexSmFjdv2ST3vDu
	 EMDqYV6Q5XMvjNIxNH2CZk1Xm572VtlFe7RtBos+fGhXc4Vy791D+vE8mJC9L50bz4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bE8uYISw;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8E960A2602
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 23:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A8E960A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bE8uYISw
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3720addb068so2320694eec.1
        for <virtualization@lists.linux.dev>; Mon, 09 Nov 2026 15:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794267668; x=1794872468; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zmiIgqy4cjH0UGo3VGOzKAUEYd5iSjgfVUfTajSB4Yc=;
        b=bE8uYISwv7qmkVtdmWmVcJQSApqdMErampOKm91ilvkuavttIdgsIymnAqPAYMv1DV
         keepHf0fmZ0JWHtgNhngJufs+ks0uVL+U3+4/0/Vko1Dbo6qs4QNlbGkrYMA+E4/v2HH
         mvsr+ltKpMw6Jtl8lVdJOiNzfwUYfbELwC/QBc4wNX01EZ1aG75UbCMAusjqHLijY+EO
         T9NumF54nddyEvZ5orLd9qQLHo1kvxe/MAq6HE7Al8yNj+z+DicUMWHXC+zlKia/rD5Z
         +VQqElD3wUq8M6AKHMSEun1BFUaj4SC1dV4tF6rE6icbYhjwO9YciEMpbAFshYAyzikj
         cKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794267668; x=1794872468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zmiIgqy4cjH0UGo3VGOzKAUEYd5iSjgfVUfTajSB4Yc=;
        b=jStHYiod0fUzHEoXynen3lOlgMLm1oWnsfb0vXGod7nL21ElLqS7XIxsbn+Q6KGugy
         VIJMNlFTBWE8sS9v43w1Eg6Of29SYXGiyU5BrOIAK8+E7ddMnDIEMVlaZ/A20ZFcizLN
         wMQNDz5Xmq8YKg5X3dx0RLbF+LG+1zbdmBoj+FurT4bihfeRx0UwsEDTkE+LxYwY6FYA
         d/nm+uu1p4kJ9EeJlNy+ZDkwOAICWGyfvdKZvc//WiJf3LIA1glrH4AHu2AweTbD+qNE
         1EFPXY0a43pYsSQjtoyrCgIiVH9HYoMfK03ynrj7abhTAozZnITC0Hud7mVicRSJGm7S
         BkKw==
X-Forwarded-Encrypted: i=1; AL+hErEbLhEEQoOmR3l6DzeUgpcMMk6YNwdlAJPLK9FX73pyQI1gKAv1VyOu9nRL7ylUORMV+CcNhgmiPVvNSaHGfg==@lists.linux.dev
X-Gm-Message-State: APuU4Z90MBcRgfGNX7PJPwxOZpvQRZM3l4buYh5MbRxx1a94aK0M38N1
	gyRUa9Ns9XTdlOqFimblf5R1LEawccwtlPLKW0qpeASV2OIpAy5v8n0H
X-Gm-Gg: AYBFou35jr19pOt7sZsLIJ6erczypkuIQ3o3N6HasnrRjmo0Nx7UcRex0UQJkNBZYeA
	CEzNcL/3PMPPiUE42i+O1W32KnMcq9ycDupwG2UK8Z9Iia0plSn7wjYfMp1nVV4W4aCzH3X/rul
	OhbuPS2FEmGdLZSNuBCoMOZiz5LN2Kio0wokg27mhVyZuawbdCb7SWMQqeiq+s7HqdHIs1/h0Sb
	4wqcMQmLZlZkEB627zS8PYIebgp3NUZWAnVpAf8p+6jaoydz+4sl3m9b3j+qYD6O7YeYdbMFsSh
	uP/3rpxYIw1atvePQsLROc288pz+r5gwF8pc7BAMVdeGKKz0KayNDAU5CF0skcl5tl/8/islCtB
	wS1pgolnpLVR+SMyxJYNXmAdmMhW8mCACDIb/uBwlbUCE2tU8bh4V+GTU+I4cCcBWLXQ/EzHAmC
	lVPDjJkbC6jG8J2oCqNntYDlPqRypZCoANTV0ExImY/ktccMa1wbMGlbRjtc4IDXUrUlPp76zTU
	5YzdMTNlyVDQSNCjT12ykehzDB+A+BORYufWJw2SNNoXznKwYjVpkWLCXBNjVIwjvyo3Nli8nec
	/WOebXUDKW3wbMWOTXSVQKeajpPIxl5dilAgTbQJ4sl7/x6/4sbVXEOg/A29YZKRv679We/Oeyh
	DIYl1aV69fEVLXgn5YuPtFgHT8khuoMZpojF2ZbTStqAMRzY=
X-Received: by 2002:a05:7300:8184:b0:36d:7f5f:7e97 with SMTP id 5a478bee46e88-375219bd11fmr1389016eec.40.1794267668071;
        Mon, 09 Nov 2026 15:41:08 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe2ff5dsm1739049eec.5.2026.11.09.15.41.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 15:41:07 -0800 (PST)
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
Subject: [PATCH v23 04/14] ALSA: pcm: notify drivers after linked prepare completes
Date: Tue, 10 Nov 2026 08:40:39 +0900
Message-ID: <20261109234049.79534-5-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109234049.79534-1-mynameisjune111@gmail.com>
References: <20261109234049.79534-1-mynameisjune111@gmail.com>
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
