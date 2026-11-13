Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794561694;
	b=i7HBiSf5g8sI0keKMyFUL/oH5CMDqEmFn/fZ5AkbateRA+otmdZ5jSxi3b9/BCmuVaLe
	 9am5n1tVmwzIye3lp1SVtaWN2qxCTO93n8Hq366wu1mKpDa6oEZZ+Nb1FejdBf2jpMxGr
	 ELj71dlbLt9UGVMhsYbV62/FRbPn/Qk4kskys1ttT1/bwOPDnoy8BOHirfFs2w9Uts09Y
	 SFhCupfjzGReJNqbdMBGw0QAUBb6BL7BK96mBegicymV3Q8/eYv/Fpxo0EABgJCsBQt/7
	 KNn2Q0b8Qi5G4FumUEOgw6xW+SJGQjWJ3hw7DUFGUAmNDyqmU2FXhu/23Yk6Vd+LYIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794561694;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DVebRu1v4OO4QL+7ku/WdY7B/huJ6M6Knj4iG74/0uc=;
	b=suPzRNBxBgkzadACFnzrbE7sArpbanB1a29gT3W5E1O41MS1U7fq+/2+VLDithsOIfk6
	 sHA2c7gGFIbS54kYtvWTVF1nd+gS7GZnGH1DmYQxTl8bPXvxbkqYedwUsMCu8rNbXjVke
	 t53eL1cNQaOi4cjKYsr9lq/G3+BGcT87W1dwH57hzCXSo/m8EzuVMxLmbew1pr3ESiRCP
	 vE5p0xN1ET/uc9A482o5M0XmA1QnAE79Yacx1oXdGrWu3De661y69q1sdfLnfY7K2yxtI
	 MafdKjK9ZHL9hhEM57PWtZtwp5E2T1cN3hKhcd7ZZL/cP/BGlWRyJJmMXdcgA7Yt+zA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YGhXw4mE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C27606A31C;
	Fri, 13 Nov 2026 09:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YGhXw4mE
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794561693;
	b=1NbGX/5KFofX0BoTNaI0K7Luh32KVf5j2G9VamAvG7exFy6THYaHDj36wwrMWn+QTAj+
	 GaRmszuCCeDd+dx8NgfAepicoeWcG80UZK+X/KFDhLu422Z4Px6dXc4YKHXRX+oZGOCgy
	 jfiUPb4BobOveJdr/+JaruJASH+Ym978vlH8f+dzqMAnu5eB1W/4IYEhXChucjCCBSj6c
	 JOwYNTmLCH4/tYZgYhcriNvvSxR4BlRRbGVyP5RjYH7qpSHPueml13AP1b0sAyOzu81sD
	 RqHJ1XpMuLxBSwuIhR+c463WkduokuZk3FpUN+ECcxCYceZBGcMzJfe0HIRfVQBJ5oA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794561693;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DVebRu1v4OO4QL+7ku/WdY7B/huJ6M6Knj4iG74/0uc=;
	b=TZrQVyONGE5p/icGUbnI7jolBVjFlYq3y9gzfjIBlDWrynAA9SqZT9oYAobdHUbRgqoR
	 anxfal/IM/DbzWcHAsxBrr+8gccvxOLNWhroMrZmKysMkdwJgHan0+5GD0c3a1EoKiyEd
	 ETURuwtDvGbnAfYvbqxyqHddetuI2CCW/AzLub7vfKYWbAe9AjN8dZwwFPOki7giZKiwa
	 1948KtbzL+0mIc2s8xUuTIHhuui5WFXWtPoR0v63t2SFTPcd2rSrRlzqFBYCDOXy8WFv7
	 5nI2zPd0Xi3t665FohkKffOXrnnZ3lbBWPWGMC6HuTTXDxMJEwmg67k5/b3pR6HRojw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D74D71F000C5;
	Fri, 13 Nov 2026 09:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794561693;
	bh=DVebRu1v4OO4QL+7ku/WdY7B/huJ6M6Knj4iG74/0uc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=YGhXw4mEO8fWge3aTwOQESl/2GTqItmP4daWa7Bb4zoL6zp31pU78GEvw6AR/pgUB
	 lnt4NWr0VpxP9TIPjtmDUbo67fby1SKuqj3uDhi3pqH9X4uCJAeXH5qQSUQWY5oZKG
	 i5W69V+56mWt6DQW2OZGuZZUl9ANoz9wTP+swnpnj0rvPKkGVUWw0nxuE7Jikc06n7
	 lyFh86kF2u5xoiJRMr20Y5nzwyofVO8PvaGn/DJF4mhm9UbRnlStVlXG5z1qPhA9Gl
	 vT4JMQW3zNVN2H725k+x/KxeOqwxchb/yPO7Bww3JV6zNAZwJgPb/xIFPjXvj2w8fs
	 zVCxRCVLEm5cA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 65731476F6;
	Fri, 13 Nov 2026 09:21:32 +0000 (UTC)
From: Joonho Lee via B4 Relay <devnull+mynameisjune111.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 18:21:26 +0900
Subject: [PATCH v33 02/18] ALSA: pcm: report partial progress under the
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
Message-Id: <20261113-fix-virtio-snd-recovery-final-v33-2-13a934ad5ece@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v33-0-13a934ad5ece@gmail.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v33-0-13a934ad5ece@gmail.com>
To: linux-sound@vger.kernel.org, 
 Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: tiwai@suse.com, perex@perex.cz, mst@redhat.com, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
 linux-doc@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, 
 Joonho Lee <mynameisjune111@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794561687; l=4346;
 i=mynameisjune111@gmail.com; s=default; h=from:subject:message-id;
 bh=HpylXpYeW9r250CjHH8kIzFSPpkw6sWYLTiZ2SJMKC4=;
 b=TI3bqMmDgfRFrYf8zWILf6C5OF3EEcIwmC8G/Coiwwo1uiQagrwJUT4wCI0yoQi/LW4beqr4O
 O0gmJyWyhxCAzMSLWqEsqrO9Y2Qk4Y1UKxo8vr6xzucz/bm1sCY2p7H
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


