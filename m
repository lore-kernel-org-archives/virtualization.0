Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794552114;
	b=datu1CBXmO3bHehYTSvxWqNek0hljKHuu7mmo+Lx5a8vgol/Se1UUfJkjtMfjLXOkcFk
	 AhqWv9UOIxO4ZqJ2ZJTL8cTsMolOp2cbULt/TFrCBUT5tQ6GGvISryISpfSJmdPi2di9j
	 dIXyS+nXM8JAYBMbuVf7HgZNs/cq+hvUNM2W/XUS0hhoeUr8XGrE36w/lMG0rs+txGlRc
	 q1KzNjcqtX7PhqkmbwMGwQ1Zyv05yzuZbD0V8AJZzTUE66iyHTh0NG960fcm+g6ZZQnSL
	 jkyVNOBwdCY7YNde/DNUTvL6XQHcmOrf3nbx95GZ5L3P/s2q0ttmTB4CPOxNaobONDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552114;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=glq2ZALJM3tncuo4er4/ALGa3/gqzOszxTJigU11xw8=;
	b=xDvCO/VCrre1KIwZkd5ec8b1CVnbknUWCqamiQQifQP0aYfwrIrdJ4Ol9H//rIFVOzD2
	 TkE1WFCRE5ozoBSbqD/f6d3T73lPa/9VDjolTRRRO193TZ8lUIhIi8exVvSn0gse48sGR
	 jrioBiBPYpPwEZQrqr/yEVaCmzbaKr+9HcWs5Q5CEbOZ+9u2lmyzHo/pPHh4MsHfbt8KL
	 kPxYskHx9BkDVSw3VPuGLEWFbLKLuh0i0wEgVCbXYvx3hYPVUJ7gMtXk2pdmzMk9RBCJJ
	 BnGGqoU5/Xk9mA1LfPPt3oNLmxCdEYn955RzYD12aPRrXSNMi0h+N+QZuthorqYE2ng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bG28QUbb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA32E606A332;
	Fri, 13 Nov 2026 06:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bG28QUbb
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794552114;
	b=JTJgavC2672VtqlPJ6zwLcqQ1PjXvOOeP44gWirrY62MHqe2/XaOMf2aQVGTZ+zmQe3Q
	 ksBkeutDcgdzEsV5a0ZV+qiC996+g+4BuNmhiWP7Fwo8bU9gcYCId5hpwYOHGZfh+VVrP
	 IpZVk54HXoF/D0ByTGLhlRIlxslhaaciq5brwDnmVqMDEKY4HQVGfYRd4q6gev3xAFtdt
	 REnhIKzixDvbTucjo3ByXhO+7aqNcf7jhnihddPzBZsZiMguOO/4iImgXv1yuWH/hxr24
	 imNi7qg85RDrJOravhVbONLBe+tmqha5Q1w5erUW1pJx0u0/+duzoa9ElRCblRztBWw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794552114;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=glq2ZALJM3tncuo4er4/ALGa3/gqzOszxTJigU11xw8=;
	b=q5kI7q06nPpPT6laQ6FMeOoAXMYdKWyAWsJKzYS0ybYnL2UQq0oDUdbcleVkKjB0ocZh
	 rHQG3VJK8paF/axFc4J/cuQPuS1stJvEe5EFfItfM61288Knpgf03Egfc/+eeIFV+PI7H
	 KfAEvkgL/QiB+UryCJKLyVEZdwoPXiuuwBYl/6GLbXImkIS6NkZzHP9qbAWRfr2FoMI7f
	 55qpYW2GjMIpqWWhI5sJH2D/3++3TOSyyyNaJmSEJJL3nEg8vqcgo/73LZfVrpqR+0nP9
	 q9COENEqnXOh0M2W3CsNXvoYapv4c1Eh0gTGkriOXcge1vMfi9d2Un1lw4yTH8hKGQA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A69E71F000C5;
	Fri, 13 Nov 2026 06:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794552114;
	bh=glq2ZALJM3tncuo4er4/ALGa3/gqzOszxTJigU11xw8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=bG28QUbbGkFUjhOyE8VTXObZZ6u1J68NtM2yQwyfBRUBcYC5/OrNOUHUGTaxE0DY5
	 JjKdGgisfaq9Eha8kohDV7VpHtxSBR9R2Qxeoo2fnzPnrqZlBBD2dBh8Ls5a8AaeSt
	 NrMwXEymVV8OnvgmxBvOmOgISvW4UAAE19v4iUTYy3a1FV6lKGzHd69EjxMADqQmks
	 44ibL8auUeNrM6qycifP/S9K8YEvEgz2a0YFGpkIyKd3IQREcrzun3WvuSTM92WPr/
	 9q2ljybuhSCD09lreavWyE+OWIr6kQNwYBxXmMIxkxV0ZfdIEFj+SkbIsV08ukcfzS
	 uML6qiqCLcZxw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 40C074764A;
	Fri, 13 Nov 2026 06:41:52 +0000 (UTC)
From: Joonho Lee via B4 Relay <devnull+mynameisjune111.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 15:41:49 +0900
Subject: [PATCH v32 05/20] ALSA: pcm: serialize linked buffer actions
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
Message-Id: <20261113-fix-virtio-snd-recovery-final-v32-5-4e95979e312c@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.com, perex@perex.cz, mst@redhat.com, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
 linux-doc@vger.kernel.org, Joonho Lee <mynameisjune111@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794552109; l=5268;
 i=mynameisjune111@gmail.com; s=default; h=from:subject:message-id;
 bh=7Es390OR9nIw9rLXIpGbdhwc1LeQYoEinLF6dUjisUk=;
 b=zbXFlEfc6Bkh2glYn2Pb1ffs+2KRPlWl08IzqBAs3m4Mdfb+ecQ39v7XKXR+esVMc0QGTyQPP
 Kzz9SybD5z5AEO72yS5ndCSaq5NPzi2SKQ70N6fo7I019XvUOaW2RSA
X-Developer-Key: i=mynameisjune111@gmail.com; a=ed25519;
 pk=wqkZdvfcC8g8fDi6f0Y58LlaXIo+ubf6Y/9Lr9yhshc=
X-Endpoint-Received: by B4 Relay for mynameisjune111@gmail.com/default with
 auth_id=1508
X-Original-From: Joonho Lee <mynameisjune111@gmail.com>
Reply-To: mynameisjune111@gmail.com
Content-Transfer-Encoding: 7bit

From: Joonho Lee <mynameisjune111@gmail.com>

Concurrent non-atomic actions on different members of a linked PCM group
currently lock their own buffer first, then the other members. That
acquisition order can differ between callers. Sibling buffer mutexes
also do not close their buffer-access admission counters.

Close buffer access for every member before taking any buffer mutex, and
acquire those mutexes in the stable linked-list order while group
membership is protected. Release every access gate on success and on
failure, including when a member already has an active buffer access.
The group action then uses the buffers already held by its caller.

The PCM stream and group locks are not held across sleeping driver
prepare callbacks. Single-stream non-atomic actions keep their existing
buffer-access locking path.

Fixes: 3c3201f8c7bb ("ALSA: pcm: Fix races among concurrent prepare and hw_params/hw_free calls")
Fixes: bc55cfd5718c ("ALSA: pcm: Fix potential AB/BA lock with buffer_mutex and mmap_lock")
Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>
---
 sound/core/pcm_native.c | 71 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 56 insertions(+), 15 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 0a8dd1bbc4c9..8131a7be5dfd 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -733,6 +733,44 @@ static void snd_pcm_buffer_access_unlock(struct snd_pcm_runtime *runtime)
 	atomic_inc(&runtime->buffer_accessing);
 }
 
+/* Gate all linked buffers before taking their mutexes in group-list order. */
+static int snd_pcm_group_buffer_access_lock(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_substream *s, *s1;
+	int depth = 0;
+
+	snd_pcm_group_for_each_entry(s, substream) {
+		if (!atomic_dec_unless_positive(&s->runtime->buffer_accessing)) {
+			snd_pcm_group_for_each_entry(s1, substream) {
+				if (s1 == s)
+					break;
+				atomic_inc(&s1->runtime->buffer_accessing);
+			}
+			return -EBUSY;
+		}
+	}
+
+	snd_pcm_group_for_each_entry(s, substream) {
+		if (depth == 0)
+			mutex_lock(&s->runtime->buffer_mutex);
+		else
+			mutex_lock_nested(&s->runtime->buffer_mutex, depth);
+		depth++;
+	}
+
+	return 0;
+}
+
+static void snd_pcm_group_buffer_access_unlock(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_substream *s;
+
+	list_for_each_entry_reverse(s, &substream->group->substreams, link_list)
+		mutex_unlock(&s->runtime->buffer_mutex);
+	snd_pcm_group_for_each_entry(s, substream)
+		atomic_inc(&s->runtime->buffer_accessing);
+}
+
 /* fill the PCM buffer with the current silence format; called from pcm_oss.c */
 int snd_pcm_runtime_buffer_set_silence(struct snd_pcm_runtime *runtime)
 {
@@ -1317,9 +1355,9 @@ struct action_ops {
 };
 
 /*
- *  this functions is core for handling of linked stream
- *  Note: the stream state might be changed also on failure
- *  Note2: call with calling stream lock + link lock
+ * Handle an action on all linked streams.
+ * When stream_lock is true, the caller holds the calling stream and group
+ * locks. Otherwise, the caller holds link_rwsem and every group buffer_mutex.
  */
 static int snd_pcm_action_group(const struct action_ops *ops,
 				struct snd_pcm_substream *substream,
@@ -1331,10 +1369,8 @@ static int snd_pcm_action_group(const struct action_ops *ops,
 	int res = 0, depth = 1;
 
 	snd_pcm_group_for_each_entry(s, substream) {
-		if (s != substream) {
-			if (!stream_lock)
-				mutex_lock_nested(&s->runtime->buffer_mutex, depth);
-			else if (s->pcm->nonatomic)
+		if (s != substream && stream_lock) {
+			if (s->pcm->nonatomic)
 				mutex_lock_nested(&s->self_group.mutex, depth);
 			else
 				spin_lock_nested(&s->self_group.lock, depth);
@@ -1371,10 +1407,8 @@ static int snd_pcm_action_group(const struct action_ops *ops,
  _unlock:
 	/* unlock streams */
 	snd_pcm_group_for_each_entry(s1, substream) {
-		if (s1 != substream) {
-			if (!stream_lock)
-				mutex_unlock(&s1->runtime->buffer_mutex);
-			else if (s1->pcm->nonatomic)
+		if (s1 != substream && stream_lock) {
+			if (s1->pcm->nonatomic)
 				mutex_unlock(&s1->self_group.mutex);
 			else
 				spin_unlock(&s1->self_group.lock);
@@ -1512,18 +1546,25 @@ static int snd_pcm_action_nonatomic(const struct action_ops *ops,
 				    struct snd_pcm_substream *substream,
 				    snd_pcm_state_t state)
 {
+	bool linked;
 	int res;
 
 	/* Guarantee the group members won't change during non-atomic action */
 	guard(rwsem_read)(&snd_pcm_link_rwsem);
-	res = snd_pcm_buffer_access_lock(substream->runtime);
+	linked = snd_pcm_stream_linked(substream);
+	if (linked)
+		res = snd_pcm_group_buffer_access_lock(substream);
+	else
+		res = snd_pcm_buffer_access_lock(substream->runtime);
 	if (res < 0)
 		return res;
-	if (snd_pcm_stream_linked(substream))
+	if (linked) {
 		res = snd_pcm_action_group(ops, substream, state, false);
-	else
+		snd_pcm_group_buffer_access_unlock(substream);
+	} else {
 		res = snd_pcm_action_single(ops, substream, state, false);
-	snd_pcm_buffer_access_unlock(substream->runtime);
+		snd_pcm_buffer_access_unlock(substream->runtime);
+	}
 	return res;
 }
 

-- 
Git-157)


