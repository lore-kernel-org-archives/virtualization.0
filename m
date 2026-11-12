Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794458140;
	b=TJb7J/UAkjfOiI+rrFiMdja96ffLo7XSUH0ARp4DGhPScENtlPfvnadqwoWtBXo6/iLa
	 u4KOz1aw20qTGR+7bLz8VKs7S5Ihjim91dcUekNO1sVdt972qfrgWAsLV2c6CVP3mdk33
	 bHI3FrZcqhCwm2lS//IX6YKgIuuMuWFmnVHC6ieaLA0naJNb+Oul+Ed3BFh54skq9JZwk
	 YdE3u5DKOqrHZiABwyUhAoJQHSIML+g5xHNCT5qBf0GvUZ++25D6UPkIdIGwxyBKny4ca
	 /0G4rjWOSIg8W9onAYlf2gL/gNHqayWWLpWpUtilQf4qUc3Zb6KBCelWG122VRfuBpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458140;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OtghGc3glzazvzMgEzpK3BMJw5gebBch6JJrmP3FyrI=;
	b=mSm0OaX2B/wiAwRy1P4SzIBCzXOX/1TnQRtsrSpzeHWe/Ot90Xi3S6yMSo/osZKveWqM
	 IewdIUnfbqKwqxdjX1frMq7qjdt/Ivhhrz2VuWN1admxXqt/rbd6g3T9D0ouDPMXwUgGo
	 EX8OoTLElpnMnzfdq4Le+ECksis0GQexupGXIHMRVsgMi8iwK8bcZIrk3KVrTCoC1d8E7
	 9gZ/a/cfV2pcP9Pxb8IChx45MS3956Q9FZqR2iA9NCDoLrEepn/Gghvy+ZCQAdBX2GvmW
	 +CsNoGut+77Au9GnBZHU9VJDhOoGWVqozqgWHHwXzSIhnOdjHabGUM/hwaEJ45mezdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HczN89Dl;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA67F60A261F
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 04:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA67F60A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HczN89Dl
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3adac5b29ebso2336053a91.2
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 20:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794458139; x=1795062939; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OtghGc3glzazvzMgEzpK3BMJw5gebBch6JJrmP3FyrI=;
        b=HczN89DlE2RIPCvE3aNUcekNx0bNRtSUQgtC+RtQNVpzWScIvevYK3Y3GPMeF/RWm6
         tXEkZNAED8oDBviNfwgEXoeleAaPsNjOA02E8utCuFGuBw3NXJnKmk8Qb6NLgbGIbbDQ
         BmZL3+6E+VT55ySJrDYaYsihV2mNKW7NiLEN25DCmRl7HYDND6EPrCNAF6av1vISocci
         8z7dIN6WuT1eZ9F5NmDzO4MpT/5oTYjbMimwNI5OR2ECn3wZuhTzclAeptkq+NKq+TiY
         FydQZjpufaGlI3EvqR/twa4SozVsxbDSJt3rCmFk+YQDYjZs4PeFJH+7USjbPEZhlARg
         mx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794458139; x=1795062939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OtghGc3glzazvzMgEzpK3BMJw5gebBch6JJrmP3FyrI=;
        b=HrT1mHezoKdRJKdwZm3cWHu0h2kWRtvFaeVLNI7PvR6wbnBVaeBvYUUcoETMYe1P1l
         3bcE8vgfemi3ahRKFejMFp06uLVBrainmX8ewqECnbTrBYs3TQEopWAtVXuUauyEeep6
         RiaFQT0Q6mCrp4N9GJfdvTF2o3H2gwWq2g+3iEyMBd+mux+Ev7wY7V8cL2G3AN4+q9Ld
         WlW8n9+dgt6F3B9KWqCccMhb7nCobuRDp3UWuTHmXeHy+sq0QJEEB5jj8dYwArQK6pH1
         /NQwtz8uEQg63JEGsFFGoExoahiXnI+8naSdgzdMkgXFyxOyV1wQUkrz5jP7FwDl84D3
         g/eA==
X-Forwarded-Encrypted: i=1; AL+hErGJ3GSM4Dz/yxyTlqUfwQAZ1o5yhOUihk2d7WkrYLeINDTNUxkErH+PAXs881HA0F63VOzdWxvTWMih7DN8Mg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9aGWHWugfwA+VdiSAVUPHFaY5yJ/9IsFfnAR2YzkHByLYTo+Fg
	4KchfTx3oT9KLvssH7/7smrwTRR22CPsmJNJv2bdtKKaO1KWdF5SiOoR
X-Gm-Gg: AYBFou01Wckq3061eRWZ0Shxr408F0Ktlb1Q5+FR6/0vk+tOUHDBCEqHJG1iMiFHJR7
	tKYaa0KOroZd+mKzobKbirbw1MFyjkNc8l/wECeZ/IuRmjCEgteBIdlReg94Ai2jTwECfJXJC7I
	Trb53eKxvvK2AHr1iBJ/wFAOjHO91Dwr2AOmTu2lbWS5tkWAuNnGuRCD8y892mRD2BOv76quhfv
	LDwmg36PbeEbVje55xjx/SaS2MpinpqqNtUgAqLgWZIyJEiMnfZY8pKS66oWR2xP0ZaiE3L3wsg
	9u19fyR1wcYj5HeEZDDw6ALzzrnCbewBOiyhlQHXzw6DXlr3w+ig3FsaMfxle9Aa1SJZsoqeZI8
	liJnHX3zjSQjsiFE9qjDtSEhCiqY0ouiV/MfVkGuuMGoEyilBuhJbaspEa/Gy/pAfbHgJEgil6h
	7b75RXeCBtadPUEOCv+bNMbeUkfaPE+c2nnSRkID2GJ2caN/mzxAFU7pja9u+ruBPKGqc6PAFCG
	ZYl8QBiGNW/2DNAZ2j3ugRYMJJYpoYKhBrggv4jGfYTS6aV7Hb6qR+lyYntewO3KDscfTX/Xo7c
	p13kvYk/r5VItNyTsF+p4gGm0sq1ZQAeJwL2TvVFTwqy/Wqc+/avnVB0YISXfdPF8R1T71vQL6L
	wfk7ZhCO85JBYhzGo7RUrxdlMNQKTFwGz+nTy0tGrwajXjFY=
X-Received: by 2002:a17:90b:46:b0:3ac:7f4c:a68c with SMTP id 98e67ed59e1d1-3b182eee78fmr4576779a91.49.1794458139239;
        Wed, 11 Nov 2026 20:35:39 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c8b287sm2470466a91.15.2026.11.11.20.35.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 20:35:38 -0800 (PST)
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
Subject: [PATCH v28 05/17] ALSA: pcm: serialize linked buffer actions
Date: Thu, 12 Nov 2026 13:35:04 +0900
Message-ID: <20261112043516.37010-6-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112043516.37010-1-mynameisjune111@gmail.com>
References: <20261112043516.37010-1-mynameisjune111@gmail.com>
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
 
