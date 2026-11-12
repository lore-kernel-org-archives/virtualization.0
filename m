Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466195;
	b=xDLpGc0Nv/fqz4wzvqOsUkP+QDTxalqhSNEpradpLNPiSv5pdjCh/1z2p8X+cL99XE75
	 6QkHWDy/3N/69luEi1SsbGAsi4hAdefPmUNzEnHm0p1Gd/uNgkVVPI9vWHZghxs5hPFTn
	 oxgTKBsoZyCbjN7xamYlb+gzl6OtJT35GdDxZtDFXmc/LF1gVpA9FlDlNxWIoRVZqqdnM
	 O1Y9Ug83qnw6ZCmar8KxkYTesohCAjMPyT9kvURn8Dkyc1llhPQbn4ZAANYEOGrU2//T6
	 G3NLqTX84krLD8/Om3T4tKStxv2uc+hwntcAyIJHJRwBvudMk8qQ0xSbOxlThcCyzgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OtghGc3glzazvzMgEzpK3BMJw5gebBch6JJrmP3FyrI=;
	b=kCT5HHqgT4k26PB36mEXHFbByu0fUSdzqCvZ5Jv/2jjA2MJuOUeKLjHV0D2hW89i0Dre
	 6QA6UKecwZcOCUIK7j0uMlUQeziFPfPVMZekoBJ6efBLXFmqTKmHW6q86wjh8MIWlM01P
	 jInpXJtaaq/i9TYajcPSB13zWlGz8rZASyA63oGGS+AllnCd5ieKf6/XmG6ASkI2qbyXN
	 j5QJuQ6Fwa603k1wJlzYgRMrTx+Fhn6s8Zv69INZKDadNbJ4QJ2m6s40UJ0tYW9fiSz9v
	 uYaEgxCji0JvzPK+pq1KE7SWPw8JJlx33ijt6aIWqZKJrQ70fNuysaReg7v4vKCIWGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kB8pSas4;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC29606A8BA
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 06:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBC29606A8BA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kB8pSas4
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a0880a46e7so323088b3a.1
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 22:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466194; x=1795070994; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OtghGc3glzazvzMgEzpK3BMJw5gebBch6JJrmP3FyrI=;
        b=kB8pSas4IYPeyqTOM8NqgSBbuV8BV23oCukiLJAsRlzppvGKOqN6Vi+jU1+osDHLaR
         PqM/IjjCwrc+F3ThjTTExJS9+OrupqW9UUwa0bK93/hRPcttbJc0k/G8V3som/FImb9I
         gg5EtLx2AH1N95auE6VjLy2Qw9Y+t+x9kmBn18M9O4p0RXrbvGpoTqxVvc3s0YRMQT/+
         6k0c6L/hMZaB2IyRa0wWKzQ9Q7L3uCwtRtkPCpT28QNyea3NoiKHygbrFkXrukbWdI22
         fOnWmo29pmfWz0x2DvbUlq7LKeT4zsqwYuxxydNBDYu39/EOX7aZTgzKTSMqIGrs4j1x
         Codg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466194; x=1795070994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OtghGc3glzazvzMgEzpK3BMJw5gebBch6JJrmP3FyrI=;
        b=UxQ65rmC1QoGFVb9+9GxHG7jd0a/JKZBYXyJKQ3cMQJDBQNM7KrGHcBL0XUfSYdSrx
         ZI8FRUtc+UpaVSCUiPfh4so1Q6QrkTh+yf531X0eE5SqP+5l6zS1h+c7hiRlW/Yr2j1k
         h0agCz6Fyyu/MkUip2V/VZdTaglTpjH2IPwKVw5us88Lqfpq3mLxm/9cmVg5v7ME5ttZ
         RgtB1rVdKhtlzuaT/6i6Vo2GXxlAarvmulDHrxG/d49ikeJvtvVUPhqm9N6XpZUtxDih
         zvhy1PX4p/dTbabHAdia3RRdtuE475lMPl02ozyBEqkpuMJwUrbifCtAaxvb1CQyLwAI
         +Q0A==
X-Forwarded-Encrypted: i=1; AL+hErE0bl5gvHaVCY86qHPlFeRcitMRfKiD6fMonCmHG4GakiWgcPcZ87XKL1tqyluHiJDS/OsOJNc6e6v1973hdA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8RZOi8JmUenxgfZEd/f3lnJeorO6YbeUc4wKptRKb5omZz3cY+
	NifJCbNET5JELyHYaA3csHlh1ytRtsByjKb4CQo6E/XMrCX0PPVxcGvW
X-Gm-Gg: AYBFou2Kxm//+CIsghBRtPE2ZOvbLdyIuWK9mg5TOeO8H/1uEUwY3uLBOGjLjv2q7o+
	csrrNzNIEEFdq8ZrEsPlT4CQf6phXNtvzRRMmS9ajhPulhylyOtOnCc89JaKrfaAVFZzIPi/myE
	yhziJuh71SXO6FNcg7Mj0v5N7MJbcVKmoO+KOf/6qTZMDEzOvP8lC0EOsERkYp8jqyny4Yja+kR
	H6ZEl7spewjz1lfoTQXBkKdBDKxNpvIJPQcqQZzlYk7dT4wstpOpuZmop0oj7+C9xdv6jkW+9P2
	6IMRf1y6Nh0TViaJL1HJicegfOB7yo3ps+HBoQZGD069bVSdw1x+mUzjLLo7hfhKma+b4HrWSur
	sR9DhapW1ChHW4wJwU67kgvtK3uv/I3rmnLZHmBs638il0d59IwnXZwl2vM/Ek7+223uc4Tnvi8
	Lo8Fnj/D9kpagq/aabR5IZ9slcBwVVXfToGElehxgsEIAEZUvHWKqzbc2gEE7o5PmFmj8N8IRrW
	GUXsGbgispNOph3Tc5pElEV+AyrlBDZ4WSskqD/5hEykAe154KJHKpTw6z+R1vRzdmtpHI2qy4s
	PUX6Ny77LmJw1+EHE0xgM9KRkyFenju939PVd5TYA1+A72MTz59PNSAvAg/IEzn3AGJZEAdcm5M
	o0zzzX4mEkJGiDP7BHJQKfQ92oMcNZ3jeII1UUFVmHzyha0E=
X-Received: by 2002:a05:6a00:950a:b0:8a0:4d37:660d with SMTP id d2e1a72fcca58-8bd5c1b4c28mr1199288b3a.2.1794466194139;
        Wed, 11 Nov 2026 22:49:54 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab1228e2sm3097511b3a.41.2026.11.11.22.49.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 22:49:53 -0800 (PST)
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
Subject: [PATCH v31 05/17] ALSA: pcm: serialize linked buffer actions
Date: Thu, 12 Nov 2026 15:49:17 +0900
Message-ID: <20261112064929.11211-6-mynameisjune111@gmail.com>
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
 
