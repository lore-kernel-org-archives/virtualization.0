Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794444449;
	b=fQmp8WZ3Qb8bzpYaAsmpadur2I9tvGHPiP1mXJv4eWxezN2BVaf2vfKR8Z67ba3nm9xj
	 A+4wEQHq/enzez4+QI0Tpre0be64gCa8AGWm2gfGjF8hMGCtMUO25kO5vU+Cw7gwVULrZ
	 3XQv3ElqVfcyfDizKkF3QWmufVGpK4K36ARGur2VWPrnST9IF4YYy8zaPthiXs8yTaoFi
	 u6ue/+s5M+0MTWifl+LVv1H7rrgLYMXrwIGOD6ZPLXMCNd+cWys+hzvVz5JxKecwP/lY2
	 WZ2mLU4bknC6d2JybaNoxYQ7YwB5JHUxJEXOya1FIOGzRmCRFcExQj0DXJGkvRhhTKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794444449;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OtghGc3glzazvzMgEzpK3BMJw5gebBch6JJrmP3FyrI=;
	b=Ged72c+mm4fQ7va5omDK42bvVfzq+4Wd5GSGfZ8mtvF98Xh0In5FEF3dZRG7N/Srp7c/
	 wKVhZi5ckltrQtoawDp6ixpomuy/OeY7wN3ts8tYOrH/VqA6POUFAXGFdf4Z5aMoyGGRM
	 reYb0sD+5TfjU5e4YbI+SSfH8Sh8DfXhCCr9FSfOl2zWegeO686FxOnARu7EcN+5xsGEf
	 3g/i8n0zQU6+ciCe3jOJQUhkZchWFWoVtXp8PrnAm+vUkrjYNbQAwX074lexvmui3w3rv
	 NFuamAO6MSlOrnUGZragGvVFU3shwWs8Lrq1OLiBL2OK069fpHciLxYTel/c1sMEQww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sq3G8dQu;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F054560A5BE6
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 00:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F054560A5BE6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sq3G8dQu
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-15ea896ddc8so5704258c88.0
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 16:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794444448; x=1795049248; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OtghGc3glzazvzMgEzpK3BMJw5gebBch6JJrmP3FyrI=;
        b=Sq3G8dQuULCZ83E7gs6v6AEGy9H0pLGRZgksTgrl/qiacWWF+CRpGBp8wIvrd84u86
         jBxu12evl7GYy4Trk4HNwLDAbRcQnwMZcWwUDuaN3vTV4d6cp9ZZWHpSwfbskS0+d8m2
         87WlagRvOSwvs10JhRiKBaBqmWGSuxc+lzZo01xs/CQcdjpE5GhAqNcuWavgHaytoEF3
         oXHyCQSvSuTg9fdyP3lwZ7bDsvnchZlroeV8aBLYDKzUTiUsBDOG1/9TjezreTWuI0JH
         rMk08quuQI7scKDGQAWaoo8Q19F7INPti6Xy5WQJ6eqGYESCf1MNmthb3YaXq9y1Yn9+
         3VOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794444448; x=1795049248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OtghGc3glzazvzMgEzpK3BMJw5gebBch6JJrmP3FyrI=;
        b=gJBBeAtM/qjF8JoxkSyug7z3AZXQMJTKxAHulM5HWzz1V22jfZrjc4COHns5w1gMyM
         ErxLhAvWQvq5yKCxcdHod8m4MrueFqPve6VFbVYi8sOlRdsHvufTfMuEVogsErRPa1u9
         2JuNAwMSJPX71+bwhkE0HB+lItRZ/+UlWt3SBGfjtrMK4d+W+/ZG77f28bsRNg+1+jEr
         Uq0kgLWlOXaMKr/fBMZYB+bkaTqhWkF1/Z0CrQDG1ESk0c+eAJs0of3Gl/IXn9bS//am
         CKiQ2YOnOeiP3UCVUuXQc/xm7WspLHfaU5lUU1szqvWoM6fI+XPAJsrCinpdWSwvSDvb
         adiA==
X-Forwarded-Encrypted: i=1; AL+hErFgpfHdQi8mKiTAfD0vz1NBll0cQDtKKkLvigEp6f97XzpaxrhC9s+HEjw7OBzK2+u3K6r+Uay1IGMqrdHmPQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8hueW+mYJdGquFusjy4N8fBGKlYcSS7W/LrpjqzUAQn3pfq2oJ
	8Fue/+PP5+IpxPVUgXkV2AOhXe8AZ9dln+3xYTDO1CMKFwBbXYzQkEnT
X-Gm-Gg: AYBFou3KedD5BxV0V3UhevyHiPTvhyK5SjAahvNjbKA5/sdEuw1VI7t4Jm4kfjUn9HK
	VSD/t3A3r40uxFYOHaGhqvM04u3GXV83mt6ZLbMYl8M0AV+KwlXMqt9FsNL07LaZYZFGMROeqZ/
	Z2uTVKdJcyH7ra/5Bnbb1yJ257oGDSjww9awtt66Ccu9e6+UIiiPG5kcbrMXJBDI63X7GzFcKcA
	ek1G+JJ2UEZhTdK6uZIsb9Nsd2jqmS81pHITMWS7Q5LWcgd/b5Utmb41ym+WnrCtNg/dxcisaGj
	q+mPXMNlvDKo4xfvrn6bQw9INZ3dyzzoluJl7OCzz+JR9rCTpm0VHvHmHGPrm69ao0dzoQD1hVc
	Px3wtF8EBqi+emB0lmF2Rqk2T6ZcPlb6SOLxNGcWZiuh/zFPo633KDNND19iqoClDe1UuGeV1zH
	XuYTHFF3bKPUSYNI21OC6iSNTN1B0nGZ4S8oiMJeAN0MVN1uJGhIYPMF/67dtwuvj4LT9phdA/2
	u1qOtd5+WZz8B9GNMIHKiNhFA5st2NOt3KzOaI+kAjrP4AsdUWLdW+/W0YCr3yLOk7DculGGDVy
	6Ta+YYeT0oARvXHMv1Hfbao7IC4pHwonJ4bzsyLhLQf3qU2mBVWkTHQDTEkIobuinftGW347oqm
	G/91SpSrr3WnH1bFzQzip7yaIfUPe6LP/eG2L3Fw1AzD68YY=
X-Received: by 2002:a05:701b:2608:b0:169:bef5:f445 with SMTP id a92af1059eb24-1b3c024096cmr2938338c88.4.1794444447838;
        Wed, 11 Nov 2026 16:47:27 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2eeffsm20672163c88.9.2026.11.11.16.47.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 16:47:27 -0800 (PST)
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
Subject: [PATCH v27 05/17] ALSA: pcm: serialize linked buffer actions
Date: Thu, 12 Nov 2026 09:46:52 +0900
Message-ID: <20261112004704.49758-6-mynameisjune111@gmail.com>
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
 
