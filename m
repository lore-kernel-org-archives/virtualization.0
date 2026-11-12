Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794461711;
	b=4BDcjm4ufUbv9wMEyJNQ3HiAYP8T+NxCixLqMk86BVfzXN/WBbeTUUd1ahoyQXTBCtXq
	 EOegtJ0GsuBSusv2SSZD3uuvfiHUHTLGjgfX8Bc6pMTpVgt7HkKU5HbIPAgu82j4vr9t8
	 +lx8rJgrL/caMZeaByzhaliJfq6If5SohgkviGT9mCElKDU6aKdNtDPO5YohQprqvx4dJ
	 OhMtZNWTj2TiZpV6/fEvRjcEtNFkp2dC+mWZny4fy4IxBhY8eJiuA8glcgAnFQ5ra57kS
	 ENy1giRqBN4rnYtU36m9saxhpBvHYb4JObRYyIGJ+3t2Su+VwdWZScBd6BakF+pZMYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794461711;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OtghGc3glzazvzMgEzpK3BMJw5gebBch6JJrmP3FyrI=;
	b=cE2nc89+cfI3Dc35BIQpHejzkxWa4jIIGM0V6X19iTHfQnjKUlFcqe2aGPtlAgN9a26R
	 gSC7QG4ueBbaR5Vc6QhiRNPkKjLmV2IUoyWl/l01Jl/OiUS3K7L4FctkHH04o1DoxpEHs
	 pzUz++vGPeZHw9tQgKDUw6oEYJ2xaMDcq2qpMBZJsx74Ff9IZAnrSQE1IuXMIDw38BxWB
	 x2bpw0zlFYLTCMeXXl9Dfrp5TBWWhj1s/YewesQUB9dF0uXsjNEJ6y3KPuBUZ7O7RRGKa
	 LhkK/pP2/TL61l72WQoOqvdMCpGsOLFnGwdVwiZj8B80VWF/PK++mhSnU6kACoeojiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MuQQjIls;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131FB60A2606
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 05:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 131FB60A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MuQQjIls
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1a2761c69fbso6798373c88.0
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 21:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794461710; x=1795066510; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OtghGc3glzazvzMgEzpK3BMJw5gebBch6JJrmP3FyrI=;
        b=MuQQjIls1O9gJjZVr6xT1ul1iHrOsjClNyyzbYwIOD2fS76Xxku95G4EzcZcE0BgQM
         FYarAkzFXZX+jwtgQTNAcZ1/2m3cXD2jp7TfpGaD5o01VSltEHo4kcpHnpDaDvzL9Zze
         zHGQAnTas1xMDWAWQ6HgHZ4oz1fof5WSN5UrfBQ/pfRAoqIasIaFsugl+uLskKn9YSmt
         b4FvtPL1CkpJ+igcZXcdTus+L8XdWCd0vS4DWArGBp5reTi8kSFyKuZngK5+bStePHKW
         Kyw3l9HNTluFskLBA+n754VGOKKAQlg14YPHwsGKIJuam4F8qkslGKf1vlKzbzL0AJ5z
         cL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794461710; x=1795066510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OtghGc3glzazvzMgEzpK3BMJw5gebBch6JJrmP3FyrI=;
        b=i31NtAkRXyIdg9naYuv9cAC2XLmHUv7gXzvsu4fRblVwhBMUL8YuyHti/HolZAzukV
         8/w+eKQkAfl2+9pskMXr7rSpPOV7QQrdYWOZfkVj3pInjAmlPe/sCHlKo21piS45lnSZ
         ujFKuOAx2iYtHHYGm/2SGm0ySVDmVcqOTnI5L6p4pt3XQ9NVOjCo9H/2kUWgNmlzAoIR
         8IUaV/Wn/oTmlti6F6L0zsKE94aNFQPldRw1wNiZcBOc+pdVtQzuQnqF4sLN4ZtfeJq7
         t+AJIAaU5Aq1ZlM6wMirvvBJbbM348PTRqOo3MQ0uYpmCHNTxeWeqF/5QlZ7D7GjeAqQ
         WI+g==
X-Forwarded-Encrypted: i=1; AL+hErFQ3J0+9vBAdpuw9AausNYf5rF6Hb9zCKpWJuHSXpsz9kSJTvljVSlaqhAuH0TO2Qk2gQI10l0fV6Svphx+YQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8yVEDuA73hZ+57IySme01dE+5+VcmBk4znQ9f9v88bppxCDxYE
	C7nmIb2d8N0aaj2MOiCVr3bnKQHe4MGNcO5RlVKSoGwHwtSyDSIWHdeN
X-Gm-Gg: AYBFou0E1k3Z3xasKkvCoCKqIya66LF1sGBU6euebkW4TqEI26bxui/2cOFVWYq9DZc
	8jWjv+ItgQE5ee0hzIjWPGZ9gMwkKluj6L1uPDEsiHGnKfEIAQvubJyoOoGUHDZ7alBIjG3nt+M
	VUdSTlesK2V7PeTKWraT3QhMCAu8DXP2oB2jzyqdwzAy5LTIXuEjUcIZ7y3tsW+G6y/HlqvERRu
	R8G66/MOn7jHFLXL0cGSg8IuC91DuS9zRdXVC71heKfzgEwX80hOiq0WMG7nxxheSf6UW9yppDC
	Cl1qZk28xZ8KX95zG6BKENBXxe2lXh5+kk3aZNE9/iGqovaO+DuYwlg3cDfSVG+l4ah0uuZR4hw
	QTnxI9cenycXn3To6+hC35JsWXHb2RRHUnkxEkHLaYzhv0uT+9oxBW7hAuBxsBrKj6PfjOR/PEY
	kMtI9JgywayOhm6+bhKSQz88jw3VFPiK44FoTjAt/VzQ0HcJ93DubaLfwXrpDKGv4aaOJNNykBv
	Ki1rg4IQRnKTnpcU7eyW6lExEDRdwcy9AumbYbqgPDOIEGFC0Kl+4dFHJSre8hDYR+0E8SNJlE+
	ZaWGJT+iiHnxz0OQD21avhAQVA2AB2P1n7vg5qDjN4gG9FrJ5ZaaO8m+U12BJ1FIekxfKsZ53mu
	NOzMGdmFYMVZErsE1PVKU9As1S+7q+SNu6ke8z71CeNecy8E=
X-Received: by 2002:a05:7022:b0c5:b0:1b4:fa58:9d8 with SMTP id a92af1059eb24-1b4fa580c0fmr962783c88.20.1794461709986;
        Wed, 11 Nov 2026 21:35:09 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5890c0esm21953240c88.1.2026.11.11.21.35.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 21:35:09 -0800 (PST)
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
Subject: [PATCH v29 05/17] ALSA: pcm: serialize linked buffer actions
Date: Thu, 12 Nov 2026 14:34:34 +0900
Message-ID: <20261112053446.73504-6-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112053446.73504-1-mynameisjune111@gmail.com>
References: <20261112053446.73504-1-mynameisjune111@gmail.com>
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
 
