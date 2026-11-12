Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794464712;
	b=yvBBsoyuNP9QCSgJzPZldf6gj70NXxOy14wa+J4WDxnxDIDc1YVXmG/be0LaMmlOi6Pz
	 dw4CjG6oDKF3rs3r9uI43KWipaJrRQL/mqOI/5SUiw5J+ySofwKMJYJrmIcRs0SeA4LKu
	 nMtvscuGZ/KP2VQ2S6GnRQ/AmlfwIv8fhN5M4VL12mIFgIoK0EizXC3SINUS8+qExtvyo
	 K3AMDZy+7uwftVnj7XfSfUCIDewTopgZKUE4DD3EKkgqeamRuzybMRwg9Io8o4knjj/Ei
	 2u8M3IPKVF96uKqFdb5AqCYZy9UfVwvAqikFYAcqgnaNEfDn+LIBbd+a79sO8PUG7tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794464712;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OtghGc3glzazvzMgEzpK3BMJw5gebBch6JJrmP3FyrI=;
	b=St2kevwusl75ZjGwJ6exq5opk1bio1k6x82H8skWW1MyAyBgIEjcXwiUggTrn4xdr6n/
	 8FMnMdOgvMNFfqzZmI28S+BJ9a+tyU1Q+b53fHzEs++kmQC0dl/osttR8GT4zlcDOAQts
	 X1ct+JZT5Oq1gQscLLjuIHz+dRRDrPBtHnksjunN30Z+Njc5o71h3QMLqGXhdya4DWkGx
	 39Qo0yyoKgqsrHIlcljR+6QdO5QtpudxxwgT5zvQ/EI+KVGHQUAJ0zzKHTE6CDki+3O5K
	 6C8O1GXQL9TgzlhO++mbibnH1m44IXQCsmKPJs9/Io4JSAsk0bBa1pteV0KppCFIF9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WSkeLuNj;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31FD606A321
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 06:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A31FD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WSkeLuNj
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2eb18f4da15so14980055ad.1
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 22:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794464711; x=1795069511; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OtghGc3glzazvzMgEzpK3BMJw5gebBch6JJrmP3FyrI=;
        b=WSkeLuNjcLPUTYZmRj5hFyikUfUnbVPYVcBZWnj3SaE/Q4CwS4Pj1NrkTxDJOZ/23f
         y7/tGScVIei64xKHvg1kHtb7tSZTI4D6jfX+iYsrVMKq0ZSb16vmXO+AnwiNV11BSGm0
         9/jTMVjh54pchV+7ucdUNAKy0e0S8pudQ8rKNQnBR7JDwwCCzFHPauU5s6XEsvnQVcRR
         qNx4L6WYUzDlaXC8vH5RYzvUmF1jgQ1ans2IdPGlTpxxutxuP+HMqu7nrAwHukyb93O9
         P6ZO2wVQ8gheRLBt35Li2LJONqbZ5dA0hxUefNE7vPZ1rebf5PwD+Am8T8YjqyhZ2BBN
         OWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794464711; x=1795069511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OtghGc3glzazvzMgEzpK3BMJw5gebBch6JJrmP3FyrI=;
        b=v9rxMcpX5pAbzbse83K1HYd6j6XZhzBjIc4qsnvX7hHnQaj6lO8x+PhsiDeqCdccdJ
         WAf4ztgGOUGd3aoSbpFDsT10p3gOfoj+s401PkmxwyzsuGJukzfjdsEsDx5C3or146sG
         qbh128/PS20Rp+1AVxwKWkY2RMq8icHFB+t3sqwo3xmBTtwSyB4fY7xvcUMvBzMJHu+O
         eLyf+Sb1Bgd7litXLksMowQusERAyuGlREbwmBTOkvrsBf9M/P2jDo67SCQt95pAVOPC
         4EzPIugwb8sL2+lbReHsT4I+s8+C8YbxlON7P1C7malEglnVBoJnPNe1kiU15itvHk0Z
         RWDw==
X-Forwarded-Encrypted: i=1; AL+hErHtvaZIbBCAn8vyxaGHnEG2/PO2729WMRSpNcWpNbceYGotv1a2CVrTvBqExvfPhG+aDWk5v1U9orJwWpLR4Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z+xicmFx9mCFxs2lJtoQYV3RZNJFlM4k5DIkOq/TCUk0XJiN6qA
	96ib0DZJ6h9AkXdu3kjPdO/nzN5wNdfp+TwssQj5KOtZWwZW2fzFhmG0
X-Gm-Gg: AYBFou2+DRJoP5R88tHZRkrqpmeHdVjjBvt++iccZWQby4H6m2yfB5z+bl3etsp1Uz4
	U41UJIcbfHFfpAvyycqrIdIhjlGh/J0owDRHpAjgw8uobt3D0Pwh+M2LW2ucQJDWVSePBEBcCXn
	eN/FYDfjlzmYNcspspetAhKm2MdX2CWGV1ZUDOvNUuEiYjrxOigfbRmTg1ovdG73v6qYBFSj2+N
	jjKtN1IKVm4fMw1B4J5QcZfpfI4iNDXmCGEnPWEF4b8x/SCGqAVEf4lXdsFl+wN2SqBcfJNQSMi
	up0/DOyJ58kjaotDxHcxPEf2n1S8Q/19ijSIxGSl1VScil6fAJeqPcrT4eDEQTBBS4MxpOgedf/
	8riK5OBk5Tf22Z+2ecTanp/N7JpbI69tqJINfrRS1YbHsfZrBMvmQjs3fAriZej58jfyPkEII5Z
	OK6Ic8LzUWVTIJxTisH84ABv/c6I5vhOwm13BfcGt3yB9PwX7RGnAxDu9AvJ+t7JetQtHomYAGd
	/ciYA0bF6XMKeO5SR/9oS+9lbKhR0Sqocq6QNDP1+g9ILgGz1AvBEN+oIeSHW3FVlDXfzP9Q3q8
	8lJfusiP/pLI3St5gpcB9EKSKrcQoVtnoFtw+Gf2fnHyC/579NTE82ki/aElE1WmNWCKAiFbdHl
	PzkIGUzyC3O7iP+vJzxyPkVyu51PBBltMutslJULAa38v9+E=
X-Received: by 2002:a17:902:e54a:b0:2e9:5ed2:c393 with SMTP id d9443c01a7336-2edd7d3ae55mr45385565ad.60.1794464710958;
        Wed, 11 Nov 2026 22:25:10 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6a3e61bsm26979965ad.11.2026.11.11.22.25.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 22:25:10 -0800 (PST)
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
Subject: [PATCH v30 05/17] ALSA: pcm: serialize linked buffer actions
Date: Thu, 12 Nov 2026 15:24:34 +0900
Message-ID: <20261112062446.159-6-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112062446.159-1-mynameisjune111@gmail.com>
References: <20261112062446.159-1-mynameisjune111@gmail.com>
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
 
