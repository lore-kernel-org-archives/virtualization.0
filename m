Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794552114;
	b=oeeUzkwd+67VVWyQmKPle/5QnlbwGkmPAjCutUK1CqPSjoIIDO/wSDtjCFFUsf7X3soU
	 5q/HPNia/eVhKr7/a1cJrSE4NwgUTb4cS99y+hYwW+hScd1O1JKckcVwtirAjR8ykH6tk
	 50UIKf0nEMtRMDx3DgBHvzrDMTHkVfOGlcRadi/v/VDA8Tq8SVgzlg+K99DBPsKwd7sdW
	 Chuw8hyxjXMqUfStB5Hg/7cx7784b4byRQX9MZzaE6q/wk0S8QwHFvFicVpf9SHHFMWo4
	 af1f9eOXI6dO62kGqzvGBX4FmUUU9rg3v2aacSn4uuIH6xUavzyt7E0MU/8KH9nbhRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552114;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DVebRu1v4OO4QL+7ku/WdY7B/huJ6M6Knj4iG74/0uc=;
	b=1sLJRzBi0bOMMF1KUyC2/eiAh3oPSTCcCTB4LpmjP7Fliu6L0RUW4D8mkKVWRC5m7X/J
	 FTtV+tIqEuOw+e6tvCRdtu++JTiy00OAcWlxltynB8yTkBdgCr0GDhcYvzQEzm1UnTCrc
	 mw4sQQ3gQw5YfeK3cR8Wkb935bFbRQvc1S8JO1BLC0twzrcWO8ewLQeEvqiCp1p/N8i/e
	 eYXx0H30PEJkzJc97DSwzwhnz+gmiCQt7ZMSDQhI3P5nIrZfrGp0hSHaPA8tDIXy4SZ5X
	 4DVDFcN7B6fjM4nSYK6qS8K/xzKn5HrAlKmg0L90XcNRm2JtcrJFLviuXS0AIxHiuIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A12Uzh4a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E976F606A885;
	Fri, 13 Nov 2026 06:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A12Uzh4a
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794552113;
	b=WqeULoVdesnndrcGPstrZ0TDEOYE9mDeJvQznO9TcftJ/ZKxML1i0IZ56WKiGsqfoXn7
	 +OD30B6YbIb1DingsY680FE2pKr3olOQDkplIhrtIgPRh0q5zzYB79iNrVAzoLRaQey5G
	 WULbXjTNZKvVDHokfyvDFKeSJ7IatZ7wYXG3RPdfdMZSa01Y4TSOBTf9ARVH3cmfEQd63
	 ZPzn3Ntn/qPkkp1sV7hy/fnNDrNEHNzE9PdVXS7IFWzcLBx1zF3xuUO2csZm/8HA8AE6T
	 FVigcQVtJZuLJfUycRGPJn7BkKFjQnqlE5MJzW3Id2qYhAxCKxgwHT2wp+DynPNhr5A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794552113;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DVebRu1v4OO4QL+7ku/WdY7B/huJ6M6Knj4iG74/0uc=;
	b=F4lacSXaG0qpm76f+IZHbwiLgwBAxmci8Sat5JA7q7YapJxf8l2qFEtXfJUJQRaeQSRe
	 d7KT5rgIyL+wLlHKGZSib0JaAVqkCDBZZw5B03em9uS9fKJSh1Z4d180IUPCF5zScU065
	 u9m8PyROdxdO/kOvQZpZhQenfNk3iSkJQt1u+cSUzeByQ5/H/q5NUKsjRkm9sFSZ1edov
	 TJsvywXUyWLvgyn+qZNjOCAa8G1dXFzJwYK2qVDo01t/pVJyo7UzfoqmtIO83bZrCGkDa
	 /Qc4BHcCqPgWiMz0gb6m8Zm5VJj08kEayZWyG6Ao/J4Me7h6n7HVkX+Hp98wXFX8MMQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7562A1F000CC;
	Fri, 13 Nov 2026 06:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794552113;
	bh=DVebRu1v4OO4QL+7ku/WdY7B/huJ6M6Knj4iG74/0uc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=A12Uzh4aLZ4QBf4v1LQ6YL05J6MewVPVI8b0b2EUCf7DyvkHNWzdWIVOA58zhXGCK
	 ejPwOqVribk1q2aSqebmQ4HpY57YxkgehZvP9dfTIOQbf8QYeqGKLVOyWkbQNfS8/V
	 7LsM/k8R6ZohwsS2HqL9CVKqlFTH0aexBkQwC7Jiln8HHhEoWZvkINJyeAc5Cpt0QV
	 uzLQcSrTGNjjHDlLgqBxaDHQiHr4Zrmn70GKzEeCKLHDTPCOZPKRbmPmfQgBxHy/7S
	 jbJH9qITSSxWGnzK22amjr4hJq8h/nDTGCHktcfM8rCHnEVrMziBqpY39nq8ClsSLH
	 Ndw/KQVoq6iuw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 045C14763E;
	Fri, 13 Nov 2026 06:41:52 +0000 (UTC)
From: Joonho Lee via B4 Relay <devnull+mynameisjune111.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 15:41:46 +0900
Subject: [PATCH v32 02/20] ALSA: pcm: report partial progress under the
 stream lock
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-fix-virtio-snd-recovery-final-v32-2-4e95979e312c@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.com, perex@perex.cz, mst@redhat.com, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
 linux-doc@vger.kernel.org, Joonho Lee <mynameisjune111@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794552109; l=4346;
 i=mynameisjune111@gmail.com; s=default; h=from:subject:message-id;
 bh=HpylXpYeW9r250CjHH8kIzFSPpkw6sWYLTiZ2SJMKC4=;
 b=3WQcHuIaYDZUWnwHCPzWH7l3F2mJNMq0RuGriyyev+kK2GXvXmjSkEJLnBSw2sfzyvDb4cmng
 oe0J+R1ayLaBg96d4KAaXpO2Wo3aDvXMWf1KzH5hgLYqjTpDcP3s+EF
X-Developer-Key: i=mynameisjune111@gmail.com; a=ed25519;
 pk=wqkZdvfcC8g8fDi6f0Y58LlaXIo+ubf6Y/9Lr9yhshc=
X-Endpoint-Received: by B4 Relay for mynameisjune111@gmail.com/default with
 auth_id=1508
X-Original-From: Joonho Lee <mynameisjune111@gmail.com>
Reply-To: mynameisjune111@gmail.com
Content-Transfer-Encoding: 7bit

From: Joonho Lee <mynameisjune111@gmail.com>

Allow a driver to publish subperiod progress under the PCM stream lock
without generating a period timer notification. Use the ordinary pointer
update, XRUN and wakeup path. Capture DRAINING can publish its final
tail while playback and other inactive states retain their existing
behavior.

Handle capture DRAINING separately in the state update: a full buffer is
still readable capture data, while progress beyond the buffer capacity
is an overrun. Playback continues to finish draining when its buffer is
empty.

Refresh capture availability after the unlocked copy and application
pointer commit while DRAINING. A final tail can arrive during the copy;
subtracting only the copied frames from the earlier snapshot can
otherwise finish draining with unread samples left in the ring.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>
---
 include/sound/pcm.h  |  1 +
 sound/core/pcm_lib.c | 40 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 1cf511f8d880..965be5603729 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -1182,6 +1182,7 @@ static inline void snd_pcm_set_sync(struct snd_pcm_substream *substream)
 int snd_pcm_lib_ioctl(struct snd_pcm_substream *substream,
 		      unsigned int cmd, void *arg);                      
 void snd_pcm_period_elapsed_under_stream_lock(struct snd_pcm_substream *substream);
+void snd_pcm_progress_under_stream_lock(struct snd_pcm_substream *substream);
 void snd_pcm_period_elapsed(struct snd_pcm_substream *substream);
 snd_pcm_sframes_t __snd_pcm_lib_xfer(struct snd_pcm_substream *substream,
 				     void *buf, bool interleaved,
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index bb16738bb591..4fb581b03480 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -215,8 +215,14 @@ int snd_pcm_update_state(struct snd_pcm_substream *substream,
 	if (avail > runtime->avail_max)
 		runtime->avail_max = avail;
 	if (runtime->state == SNDRV_PCM_STATE_DRAINING) {
-		if (avail >= runtime->buffer_size) {
-			snd_pcm_drain_done(substream);
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			if (avail >= runtime->buffer_size) {
+				snd_pcm_drain_done(substream);
+				return -EPIPE;
+			}
+		} else if (avail > runtime->buffer_size) {
+			/* A full capture buffer remains readable while draining. */
+			__snd_pcm_xrun(substream);
 			return -EPIPE;
 		}
 	} else {
@@ -1918,6 +1924,30 @@ void snd_pcm_period_elapsed_under_stream_lock(struct snd_pcm_substream *substrea
 }
 EXPORT_SYMBOL(snd_pcm_period_elapsed_under_stream_lock);
 
+/**
+ * snd_pcm_progress_under_stream_lock - Report progress without a period IRQ
+ * @substream: PCM substream
+ *
+ * Context: PCM stream lock held, with no driver pointer or trigger locks held.
+ * Updates the pointer and wakes readers for partial-period transfers. Capture
+ * streams may report their final tail while DRAINING. Unlike a period
+ * notification, this does not imply an elapsed period or tick the PCM timer.
+ * The same pointer, trigger and timestamp callbacks may be invoked.
+ */
+void snd_pcm_progress_under_stream_lock(struct snd_pcm_substream *substream)
+{
+	if (PCM_RUNTIME_CHECK(substream))
+		return;
+	if (!snd_pcm_running(substream) &&
+	    !(substream->stream == SNDRV_PCM_STREAM_CAPTURE &&
+	      substream->runtime->state == SNDRV_PCM_STATE_DRAINING))
+		return;
+	snd_pcm_update_hw_ptr(substream);
+	snd_kill_fasync(substream->runtime->fasync, SIGIO, POLL_IN);
+}
+EXPORT_SYMBOL_GPL(snd_pcm_progress_under_stream_lock);
+
+
 /**
  * snd_pcm_period_elapsed() - update the status of runtime for the next period by acquiring lock of
  *			      PCM substream.
@@ -2405,7 +2435,11 @@ snd_pcm_sframes_t __snd_pcm_lib_xfer(struct snd_pcm_substream *substream,
 		offset += frames;
 		size -= frames;
 		xfer += frames;
-		avail -= frames;
+		if (!is_playback &&
+		    runtime->state == SNDRV_PCM_STATE_DRAINING)
+			avail = snd_pcm_avail(substream);
+		else
+			avail -= frames;
 		if (is_playback &&
 		    runtime->state == SNDRV_PCM_STATE_PREPARED &&
 		    snd_pcm_playback_hw_avail(runtime) >= (snd_pcm_sframes_t)runtime->start_threshold) {

-- 
Git-157)


