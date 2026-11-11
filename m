Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365841;
	b=4im9872/gXm80yOoCAXWwW0+Tt5Aw6/jmG49a54Udlv7Y4xU/HZ89swS8o+RMG5A7vyY
	 rU5PEWlHYTl/RVUBJNmpfCMGQA+QCIhQDQ0DbSK904p3CGLrI1pR8UPwTM/ioch2gAUcP
	 C/2xE4+UucQYLqTBC3qwNoWD2sxRbJG3QlqsVSgH7A6Mo/5/91jgn0+AEizO3exPuxfdL
	 DMZ4qyJZ18Ns752Pa2UTe2lNt02BkZoNE/CCsCABWHYYTNuRpC+Ny3G3OcJJP6DnzP2EC
	 /Lfhct4Vb5ViiAh3WQqko1e0me5S3XnSSY95LIsEeoD1nLHnVVm18rDUte06AeLgeZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365841;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OtghGc3glzazvzMgEzpK3BMJw5gebBch6JJrmP3FyrI=;
	b=xSIJqxwcy3u+uKkPJLU7qdkd/nK2RedfXX0Mu+7krS/R4gqrxXdEacrPJ/x4n4+ojKd8
	 6NZUjrc6ZZINSUFMG0HZGThwXBA+KNh0hcjEQvFEgvn22hTKX4mtT33QYzvDjgfS0RkFl
	 a8iPfZkDiIskhp0JssaXHOhrmxcxD7m6qSbJVPogPopXnWCLVdxp9J7msnwgbVq6KTyX4
	 5BcQxbiJcunzoq/cBCe7HKjbySPbmLnRlzDy7Uv2Toi6it6JX6mbq77CmfgNqz6lbKY0P
	 WUol3vM2giQlb9HL1QZtP7nxTerfJf4C+qN60f+7oUJRroFyrIXRo+F3ZRRIKdYt8jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zA7ieec9;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98989606A331
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 02:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98989606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zA7ieec9
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso5555450eec.0
        for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 18:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794365840; x=1794970640; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OtghGc3glzazvzMgEzpK3BMJw5gebBch6JJrmP3FyrI=;
        b=zA7ieec9DC0uyo6STwQxwunxdp2vpW5+GIgnn3F8dwse2hU/RPznZQg/qfKGfY035H
         fm04QamCw9po+2NOh0hiwR2eEn2pVOmzNYDG79lS0+aFsaDTxhRNVG4+lYTrQbKrHqIg
         8t3Z/G3yDQgw0rAs0mx7QjAq/sN9joGaTeOpuL8vRhTX2UOEJ3C80EsxLzndZ8IVbCYz
         L9Ih5F5A8XkDS/aB8vFPZN4MyKjpLB0EdJMmKKhDN1iMhsPYdZX5sVxaX4lWrIzYrZkz
         jLRGcMPhImBNqaaH1rzfSuTKL4xaWt7VTrQvNoJvkGJJIOL+N+3y7gaF5NMZpJYzCIwB
         zAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794365840; x=1794970640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OtghGc3glzazvzMgEzpK3BMJw5gebBch6JJrmP3FyrI=;
        b=LVTvZvJbWvz7NTXVMz3B3/mWjmwb/BoWsKHUytgQzAC6XgiFJ4XA5eEcRJXrz9unca
         SJbQ5MYjRxoy3Vwh8HkHcFzV+Uf7ZkjtK9OK9Q2lgffzGWFWDXjSNndjuDthX6LfTjgw
         N0X8vA1dkIL3PQUPh5fb/UKZ7Es7PmR+1bVwrEzpK/s943rZNBSrPApRka1/Ykm7D8W5
         u2ARLYNaCkXfyqPk8st31ojNoEe8IGEBaiXQD363ZYZ/JU5bU00DInz9AGRXoyxULEDa
         d5wTiClLM4Wl73lqX4+Mg92kkcMpEW6mR1qrsx4J1Ui7wAa5IY/c1lh6tugrxQOO/GI+
         wjVA==
X-Forwarded-Encrypted: i=1; AL+hErEBSjqm8S2TSRaIz0xnWkFeEOuETEf+uu+ESyHEQMlz9Hwla7cxWAKPHZThOQRNyxe9XGk2gnUscaZq5841VA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9HEmKacYDvGxTaoTfIRBB0LyR5UzUyczGQmp4bQ3ZhIHl9cLyX
	w/xBM9t88FVcgsergOMRlXbfls0AS3NGqEorJ8xMJ5OhdtqPBEl4f0SX
X-Gm-Gg: AYBFou3Ky9MNouJeTE5VMUJQOJJb5UwDpn3y2UPRtdFjHrFMdy8sQIdeZBaQo2lM6wC
	jIa+JCJQ91dxWbJvUXEUCXr8DjDu/l05zXsOt4NHbSd1h/vnWvRBHCTHif3m22BxEIKjGDlGEN+
	+iMLJfxokdX5Ea0+8j8cayznlmzJ1M/7BCUXlCy/CUZpP6SIog6uru0m6SGoXDFtfwCoIp8xqcf
	WugdlIXMrnxOJIVnKIhCcDPe30jFiWnqIXe4ymS0bRJfK6hkmf9K+w/LWyfEVC+WfHZwSGeUD1h
	guacenNvX/QWdGAQNqW9Oe51vjdcFRJH1ITqzZ0q1MImd/6QBH5vloHaJGePmOzx3U3kqbQ3EWJ
	r/7lAgEUiTruJmvcEuBVJR9L7GeIidNkQ8pG7dzhvNmGk3RdnpE4HmCg/Ha9Sn24Iy8WN2gf8Of
	PyLlHCrkFyTf32pM3STS1Cg7xYB0uxpOjlrfeyFLKJIOfqBA7wVuZtEXvtHziK1AKGl7c6dvjfh
	DkiQSHbbxv8pymsi3IBbC+exMuqvzxwqFfRmwLX4bmGFZTrNAYjxRbL9ws+lwwRN/PS6JOo7j0r
	iUXWwvCsbxvZV8xXVh5NFIQKFNashpJuof7Jp+EmCbRZ4L+ChZnVkC1JYXaPhFHJ4Jhm7bD1alm
	Xp4pLafV6TbNltQjdIUX1mFLk6x8HGmNNKy9Et2+XadO9LfMtcEIo0R+EOaXrudJ5I8FW
X-Received: by 2002:a05:693c:66d9:20b0:376:682d:bf1c with SMTP id 5a478bee46e88-37686b42abamr1754725eec.41.1794365839352;
        Tue, 10 Nov 2026 18:57:19 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfc6sm12390018eec.17.2026.11.10.18.57.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 18:57:18 -0800 (PST)
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
Subject: [PATCH v25 05/16] ALSA: pcm: serialize linked buffer actions
Date: Wed, 11 Nov 2026 11:56:44 +0900
Message-ID: <20261111025655.63951-6-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111025655.63951-1-mynameisjune111@gmail.com>
References: <20261111025655.63951-1-mynameisjune111@gmail.com>
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
sound/core/pcm_native.c |   71 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 56 insertions(+), 15 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -731,6 +731,44 @@
 {
 	mutex_unlock(&runtime->buffer_mutex);
 	atomic_inc(&runtime->buffer_accessing);
+}
+
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
 }
 
 /* fill the PCM buffer with the current silence format; called from pcm_oss.c */
@@ -1317,9 +1355,9 @@
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
@@ -1331,10 +1369,8 @@
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
@@ -1371,10 +1407,8 @@
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
@@ -1512,18 +1546,25 @@
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
 
