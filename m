Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794267672;
	b=wK1zi4Uh0vNdqWaSzLwx4Kp5p1YgjmLoMXgw14drYkvlV4ZBpb5iBKUjMmPEoOnjjODI
	 OEABgw1fay6LJXhViUO20HNAEzKm57mo0Y5pwkn06UbZ2xw5vjPL7J3eL3DR8I1bBzMmQ
	 EpbRkWRvN5tYDKYAqfkTy04RYMO2SXtz4pGAC4tGd7UvrE10xXDegiFXmDzi7sT9wIEE7
	 FI48+R2dqekVlJLka9Z55nP/poylqhnx1KBZ+k9jz5U1FKg/ppVf5Jd6iVOhWFVs9FwVj
	 0+F4OjIijDaU35DEIsGcg32ev1zUxjX3X+v7mjqjbG+BFdPgbw933Zge/YproFg+SlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794267672;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OtghGc3glzazvzMgEzpK3BMJw5gebBch6JJrmP3FyrI=;
	b=xAqo87cSMQfnW3f5axyuOvPqAjkWcARjIKRyyCpALCEcmQAM86U3Y8LsR11DjJVd1MyD
	 LV37qY0f6B7f5gjGDvdKeM27jYPy30cIqLArlOc/YZEtVDVda9Dw2ieQ2fvjcdNaaNDzs
	 JI8OCq49+OSR1u+Z43216NR6teikwH+tdCJFSwVCrbLNkJBuiD/B+FrxY6eiIAQiTufQp
	 crEy4jbQFoy3Kn4LFf5gjqi3fS0I0fEQTDTV20QdwO9S1Xm9FlJa/REFWA8IamcCL4l/N
	 N/XkB6Tdb6zXF8//6Zsd5YE1lLCE4EMQCGOPuHWME5o/yQehA0eUdpflnXp+dcMptEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zBEaEw+r;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2991660A2610
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 23:41:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2991660A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zBEaEw+r
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3282db206d3so2884318eec.0
        for <virtualization@lists.linux.dev>; Mon, 09 Nov 2026 15:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794267671; x=1794872471; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OtghGc3glzazvzMgEzpK3BMJw5gebBch6JJrmP3FyrI=;
        b=zBEaEw+rDFPPF0fmTqopnvs/pd2LDa7GeDimZjKnxrihMXJgsOlfoaB2I8MZ8gF6bz
         7kHa01JhcXw7bXIr3DV4ZhafFcapjz71f1rhKDxafdlO5OSEKdgo/EL/mxLmMG30//2A
         UnwkmSQBIN3WOmJZD2ebnxyXKCXjPIWbpeA3UMwQfW9yQSXKGoe9KXqb33f/PoYX0TU0
         kLv9SKeiBGbEF4xjwBD1LxbxIVCouSXmhUdc+61BqCl0eEyYoWC3wJmD+Zwoqk8eu+MW
         aHQdI1cRC4uj7vmOuYFetljPA1mK/z4jga+PKbO+nTvMMe+/cHokYRo4uiXhfCLK4KeN
         VNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794267671; x=1794872471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OtghGc3glzazvzMgEzpK3BMJw5gebBch6JJrmP3FyrI=;
        b=gcGS8Wvf2Ww9W2WMoK+xz+hCq1i7mIKYvBFMZavZoGTeVkpSaslTRO2KV2yd2OOL7M
         I0q2z3Xmtw5rGU4v8GQ9W1khuw1cydXcwh/zInee9CDPGL2VtLfMYMYyfglgLpIjKFqN
         Vab7n1uUIbiNH90kPus9dgMaDCbvEcW9R6vIkRiGnAR/Mf/A4Ta2e8zVzFz/zSF6Dy3z
         fZwZAMprEJpASWf3Oaz9xMbIEmJPwiNKv5Wh9/DICXPSEA/DuXnl/ZPiCN6ldStqLnFC
         RZztlL00nyT3E+pDHXD7xd8CiXOzl0V59ZO1Tcaatu5kfvMWihAWn6FrG4hktrWzE6Rk
         2aDA==
X-Forwarded-Encrypted: i=1; AL+hErF3GEd8vsOYn1ve79pqG2/zAbrA1wODZKqMj5iogLIjVaUcZRw1j06ucE0L+aFG6ksJJa9XHtdmFLIuL4k1jQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+68mC0L8+W6w96GT9D8jm6+4Nk8ptdDzh/5bN1iGX3RH1r4tJP
	XkKDE4sKqcXwhERqPe/EmcJWovDnL6jr7kToRm2SSWwjMsiEL2EhvU9c
X-Gm-Gg: AYBFou3kQhqsL/x0/brLDNrtes+ZBMAzTdBmwZQoSUnrKTUemdl10XrREOb4VzPDes8
	l/aUGvsUYWkTJWPts+LCJ4AMrsoi55INsp5p6+hgroOuuj6IKKKWE7qCtNXmnZchMnKWl0qYmGH
	eajaNzAkcDpqhXXONv3aRkGv2Nor0vPhcCjd1h8Roq0UgFI5f/PgQQMsk3HlArn8DCZtAfAoeRS
	w7I9923v9XMGht3h79W7HmeQEMqgCUbLW35yGP+YC+gHRL9D9NvztUvtX4UQUdFmyEjObfaBs+H
	xPsi67qhd4+1s+/mkejkchESxsYV1Ocw6kqfVnoisnmIGoRldG6x5gD2GT5GLdXsTTARziwSKVn
	2gua6z5CJTzqzdulDuO8NXKQ3T9FliMdE1n8n3QF+iL5CtfXJ1TQ2eaN181QoaqqeNew3gACIoS
	IuAji4g6fzLofRxWejklqcCPdJQHK67u1jLIku/2qeHxEphrYSK6HiIUA5RCVdZ0GSWCgEN8u4U
	ztiv6pqNso7GfsoR3rZHWOhS/6ZO4hs02abxzFumdYn02CpEnA4xHqir/xn5OqM8ebvVRRahgGC
	qfN8j5+RA+5L4SapFeD+bUaLZt3rlrQ63VEnV5MbI7hsaAcakoj8Mg0s00nfkJAl33/j0tWDCuE
	znXVT7x7sf029/1QcpQdvDl6qes9dv9X1fr2sQnPBMUonPds=
X-Received: by 2002:a05:7300:8186:b0:36c:3b8a:8089 with SMTP id 5a478bee46e88-37520216bbcmr1562365eec.36.1794267671108;
        Mon, 09 Nov 2026 15:41:11 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe2ff5dsm1739049eec.5.2026.11.09.15.41.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 15:41:10 -0800 (PST)
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
Subject: [PATCH v23 05/14] ALSA: pcm: serialize linked buffer actions
Date: Tue, 10 Nov 2026 08:40:40 +0900
Message-ID: <20261109234049.79534-6-mynameisjune111@gmail.com>
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
 
