Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355570;
	b=wcGu17BzbV3F0tFjIrXu4citFOWTUnMrES+ybgKF+YzMmqBCOonOJ6cR6x7TT3vZZnZ5
	 9QcVu1FFvMXonZJwKfye/V9U8FYB8iXgo0huwFlzvuuumgOPgSIMKlu/Nyz/hFuULxy0y
	 nS5dBN4ZV6jb2J+bsv5J1m0eEDOwv4nKecjLMI47lkgxKvMfaAZcAMWTzcZwB37Pozco2
	 6obfG1RlRjsMNe6lyARiBTkA9xBjqSQcgwB3c2wEbjJTaaw3DfXYJYK+C/GjAmYb4U5lc
	 LWsDLmwaVAywv02ZU78CJCuuevmdaV7XD9X7zWjBUaEOcCpqG3X0nYadri9x8sNKJzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OtghGc3glzazvzMgEzpK3BMJw5gebBch6JJrmP3FyrI=;
	b=VGnhR463qjYtd9y3/i6VE81XcM3AKpNxV9Ymnex3hxdLlcVXA4pjq/2M6Wi6TEchEgok
	 itj+cyZ8m6jKg8PnSd3VVkrkw/pUId8mnaYvVqF0CpkxQueKTwyAafFmg9xFKDaLUStkr
	 H3Hopai36NGcrHQKAoCP288huQ+o/JP3PXxaPcmAu3zh7R2YJHaUOhO8Eq8nIhqy9tKpp
	 6HDL/y7Uy+KW4tzFbjRWEA3HAUjoo6AunbFKtfq9tvLuZnYyCoR56g0w0XGDtBL+bYSqw
	 PD6TM50V2YXjVIG2bpugaZ57ioi3fKRwYd+MsAxBaOEULlJ0/KPh+FVLk7k4qHi4utg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tL7QFCfx;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FF3606A339
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 00:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14FF3606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tL7QFCfx
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8b8ecfa886bso1219357b3a.0
        for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 16:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794355569; x=1794960369; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OtghGc3glzazvzMgEzpK3BMJw5gebBch6JJrmP3FyrI=;
        b=tL7QFCfx64AXnRHpVoy+0JBk50mp1wD+e7TAno0BQxqZL0/n4cqyJU+LDI9lmqc9cN
         OOTddmRJUC73/q9X5boCaZQy2TSzUkabUWGeiJxKjoghKDUyIGc6qO9pAGT5GHIrab8C
         33OzWZ7gblr4tc9wvQPNLNs3moqKt63depJV8HbV2JOVTlX1Qk+uHT9PZ//6dWH7Emm8
         DYhXlA8lcx3tJPpb8rYWhn7HF5265rlmaZ4LD4LdALxufzKifSZV0oYbaPLlUqEhWUOG
         1tq8ik8aePd8qR7KdBRx/6MGM4Fa1ADVuJ0nqwrFZSLy9R0ZJ0tZuPfXV2V6ZPsesVYE
         E80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794355569; x=1794960369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OtghGc3glzazvzMgEzpK3BMJw5gebBch6JJrmP3FyrI=;
        b=1GFX3RlpF1GtwsmwBqtsE2qVFXisKMyxt1XhefRD9durgTRNFyyC50MtY+CllAbI1S
         48LUtntTL2VHMZM6YRkZjnJ4VRr3jzf7d3VYneC9thTly7tViKmD8ikVeJEUlJQyvWWv
         QF1uslnFVnJZupUqRP4+nWkoFIarHX0gAVcmSbuoU7l18Sfx8TR+z2WNSyP9UcKUNnW5
         X/kpffLc+Ect75AKL4I/srcwLlB+x+hAE8lzQWurUADEWYEwKNjIuwlY70lpGoYxJpy6
         9HvsHVXElq2PM7GygnmQHKI+MhBOwk6CWAmPtMcHjc03hJ2nIChZBAexIt5dhnrEpAjh
         FFrQ==
X-Forwarded-Encrypted: i=1; AL+hErH72rgwm7FWrStSJWcfCzwrpZkPFNoQmog2+Vm2ZDeF9YX80qjKtOSrS45x8fEblRxJbiH9inO6ao3LGdGSoA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8qKGNdzaSYadtSjrKLGgAk/VFZ9319faykYX5GwpUaEpsfRsOx
	MUeTTc3Jab4W1xef/cvcD8q/BIlgsjh6DxliYHmrb5rOahW+DjbHJ1ZX
X-Gm-Gg: AYBFou2ozrmevnVA/p6yq8z9xSsMg1K7bkkqCPnZtg1h7FzaPys9r4SmIo5AJjMSaz7
	iyefEmU5MAlkjGJtxndeP2D6PbSfvApeBQcDZ5dvj0DeMplhOHN98JrWL2TvRqKGSsQtGzETFrw
	jy7A355cU3J3q3H09ICigU9djNNL9/Q8PypDN/lfH1z+EE2WMBowdLmfUM6qKWL4uzGvC6zg4Sw
	HTaZEElCupZ7aIM5T+gQqFlXrzOfNleGynsHWMamN0w1cicHksz/4EY+hMN5DPxdJbsCAvmVZjE
	P3fmFsSIQ3Hu2Lx+jXexbRqs+Cl0HDWlMc478Crb2r+kaoirG7GOjyEiyfSSXgHpD5G/KZgSKq6
	BgxTz64u0jSJRbZyGilHwkDvANTmvprz2xiTC3h6+FYQnH07c+rNuUd28F1/wYBWLz+qKIXOkmd
	HKtfROgLBII8D9N6qRXQfDCvI05qnE8Bh7a9++quJpDXUexISY9DQMsWoYfsll7q+PSfRHYyaEP
	6ps7aEthE08NgzB58d6qdDc8mBpWgtFC4bz0XOip4WdNzYtRsZ3NShK1EhJyQ4dulHORz2qM7q7
	DN0ZR0L40vJLVfA3A4tQSxaCg9UYQ1jfn2t6GcgNPf0mgi18j7cz7LrT3QkO9rb/IZsLv9S2N4s
	3A13aPgXCS8o4w5BcIoSXmD7pVP5HHjxQDlICli+PO7jcZ1VBGrlrZDFymGJXSHMhLUp4
X-Received: by 2002:a17:90b:4c50:b0:3b1:6e2:3693 with SMTP id 98e67ed59e1d1-3b182efdd53mr527004a91.17.1794355569317;
        Tue, 10 Nov 2026 16:06:09 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1838e616dsm474361a91.4.2026.11.10.16.06.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 16:06:07 -0800 (PST)
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
Subject: [PATCH v24 05/16] ALSA: pcm: serialize linked buffer actions
Date: Wed, 11 Nov 2026 09:05:32 +0900
Message-ID: <20261111000543.28550-6-mynameisjune111@gmail.com>
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
 
