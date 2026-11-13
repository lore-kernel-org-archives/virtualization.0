Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794552119;
	b=Xf/rdWEPjY3Uu5gKcgeM8iMNx2lYB/DAaYcdLlERxhYZBt7b+qtZf8HwkNrv4XhI/QZS
	 GpYx5OwaDsfTsbXGUYTpKWg/SQVBsoaTz1G4zi2j0qQbKeiXR3Bj0XAUg3ZQWNtaTxzUU
	 bKmmqwD1e7kSGly3dYInrkoyhCfMZMMOs0ymn5pqvI31vxFGG8cFMQkxoa6peKdM13u2u
	 LNQUD4mGdHCpxmg/8vhRvTM09mPbmc06Kz0oTPDKS3l04f6TywAqBRIR/GCmjvdqi2grW
	 qEQNfpvbRpPfQ2CLoREbRwNIOQz0sgH0wkoUj7f0esSktxJTL5ggCLd5aRKFXrC18tw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552119;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=m7mrPlKLdsgB1ebZ53UgPolKWenYjsNodqkdXpnYjd4=;
	b=03JZkGmptwjF+NrKkUajXg7naS1nJnX36787rAycqI068njy1a3XJ0l6lU3aXE3xNNhn
	 OwRIXxwi2HBJxi1hEziN33jyqHZjUGi5lY9Lx099Z3Xeus+7sxz7NEbXwuTljUhdxij4u
	 73enoIERg4eaBk+bv52twvQTmh6pb7uzsje/Oe+0Nmr/xKFtTllv+pV/7FXcl+cqwTnUx
	 XCJPs7GsG52iF1lfjxcpxlrsXCgt3C2H7MmBCHgv2Jjh+3GwUbRhxlqQyXg1pns28aZsW
	 DUEY0iZfTvQWxZd9szx0nRCvnVSO4yDJIadF6S7wqbiBa4UqWmbADvGqIiqSHaW3A0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bpM0XW9g;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA97606A327;
	Fri, 13 Nov 2026 06:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bpM0XW9g
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794552119;
	b=TPKcchr9dapamSyYAy/xRdABKsj/MBNL6DA9Zytfyp4y3SUbn5gig/WKcJDV83NIQzZk
	 Dtm50j26JaNRNyglLCc6jxW2BWeNgFw/wi+LzOh5LCMYlPFO4/8iXYB6yhQEWaARq22Ge
	 tA8vgUYov050xutRb/nlofWSsLUf/tiDj7Tf2ifWDp7EVcFesSgG6Umh2cOSvgfdP6Wev
	 D5cK45AFMrDeJY0axjOWNjXS0pqnRisMV1IZjP6+DWY/pyADONe+kpHRcdYU5qQKzvbPx
	 j8TAKwkKTLAkOdiWBG0bIRz/TxhMvkzkzP4WShTpEbJ7LN6ZUl26KvzuZZIadG59CFA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794552119;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=m7mrPlKLdsgB1ebZ53UgPolKWenYjsNodqkdXpnYjd4=;
	b=yoZxilU7/wDwxt5+at76jkwRjjhIxDxnZoTl/osr33P75U2ugcTwbMJQLWqnIT7ahqQY
	 1cPngm+yCKusmmW+qCSuT05snDzQAq/ciSjXfHBA2Ug1vwmVW+GosLPBDGT/3JnSBGFod
	 IuemVWLpwOtMbg3SPyO+xh6PBRQ9ma1CoAnjqwGHFhcSk59K9pHsHYl1LBv3T6lpZNbH1
	 NjVd7+KZ8SqwHkjqWVL38BeDDoNWcsr+LteVeLeXMU0YpaDTnYdPySTKJ04jaIClWybxy
	 eFWhaeAx40VIsEZAFXyS9ksy21kE89kITcIzitgJFSy+iILJ/OIp0Uqev2492ZZtffA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 31B3F1F000D2;
	Fri, 13 Nov 2026 06:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794552119;
	bh=m7mrPlKLdsgB1ebZ53UgPolKWenYjsNodqkdXpnYjd4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=bpM0XW9gVF4b7QI4rqtYY63WeJydKlILMysUo9VnavxQurJUB42DXWwQtcH7AC2ob
	 QP8gUAJk1UNUdPo/cfSuDxquixGYQDQb1QUCpIXRyD//UFA1Xhl91Z1oPBKskli494
	 5M2Tvxio2oaWeBnx09Jz0VbqJQIe/AYXp5GcJSbsEF2YrCibK6/q31OKvGn6PDeu6X
	 x6zDvX9ukxtrBdj5kTkGBngAI+rLWSgWtjG+T5CD0dAqaL4qTHiiu8wFiM/TBZ/IV7
	 AQ0WeJZpL1eEPSJyvoG6eTCDYlPhXLd0VqHQb/7JW6uXiXD+cUpI2DjO21M8hgfs6+
	 HTxgRe04hyWhg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2BE9C47676;
	Fri, 13 Nov 2026 06:41:53 +0000 (UTC)
From: Joonho Lee via B4 Relay <devnull+mynameisjune111.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 15:42:00 +0900
Subject: [PATCH v32 16/20] ALSA: pcm: add an explicit application pointer
 to indirect playback transfer
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
Message-Id: <20261113-fix-virtio-snd-recovery-final-v32-16-4e95979e312c@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.com, perex@perex.cz, mst@redhat.com, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
 linux-doc@vger.kernel.org, Joonho Lee <mynameisjune111@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794552109; l=2611;
 i=mynameisjune111@gmail.com; s=default; h=from:subject:message-id;
 bh=v6jytlFKn0liAYZD+sb6fcXHPlu1wdJ34Mi8Ld8kynM=;
 b=yeEdQYfZ2C0CZLI3u6A3ClLRkpTZOmuO0X5fpUiplLSSbGu5BeRvrzkkZJz3Iuva6glL9vPz+
 rO/YGkvxX/XAFyapj3OKDCsoLtIEvSshhnF8p0ymlCezNZ0IzehASI5
X-Developer-Key: i=mynameisjune111@gmail.com; a=ed25519;
 pk=wqkZdvfcC8g8fDi6f0Y58LlaXIo+ubf6Y/9Lr9yhshc=
X-Endpoint-Received: by B4 Relay for mynameisjune111@gmail.com/default with
 auth_id=1508
X-Original-From: Joonho Lee <mynameisjune111@gmail.com>
Reply-To: mynameisjune111@gmail.com
Content-Transfer-Encoding: 7bit

From: Joonho Lee <mynameisjune111@gmail.com>

The indirect playback transfer helper samples runtime->control->appl_ptr
internally. A driver that needs to refill already committed data from a
pointer callback cannot pass the application-pointer snapshot used for
ACK validation.

Add snd_pcm_indirect_playback_transfer_appl_ptr() so callers can supply
that snapshot. Keep snd_pcm_indirect_playback_transfer() as a wrapper
that samples the runtime pointer as before, preserving existing callers.

The explicit-pointer form lets virtio refill accepted data without
accepting new application progress while the ALSA buffer-access gate is
closed.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>
---
 include/sound/pcm-indirect.h | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/sound/pcm-indirect.h b/include/sound/pcm-indirect.h
index 98e06ea73b2b..ed73bf8ef423 100644
--- a/include/sound/pcm-indirect.h
+++ b/include/sound/pcm-indirect.h
@@ -28,15 +28,17 @@ typedef void (*snd_pcm_indirect_copy_t)(struct snd_pcm_substream *substream,
 					struct snd_pcm_indirect *rec, size_t bytes);
 
 /*
- * helper function for playback ack callback
+ * Playback transfer using a caller-supplied application pointer snapshot.
+ * Passing rec->appl_ptr refills previously accepted data without accepting
+ * additional application progress.
  */
 static inline int
-snd_pcm_indirect_playback_transfer(struct snd_pcm_substream *substream,
-				   struct snd_pcm_indirect *rec,
-				   snd_pcm_indirect_copy_t copy)
+snd_pcm_indirect_playback_transfer_appl_ptr(struct snd_pcm_substream *substream,
+					    struct snd_pcm_indirect *rec,
+					    snd_pcm_indirect_copy_t copy,
+					    snd_pcm_uframes_t appl_ptr)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	snd_pcm_uframes_t appl_ptr = runtime->control->appl_ptr;
 	snd_pcm_sframes_t diff = appl_ptr - rec->appl_ptr;
 	int qsize;
 
@@ -74,6 +76,18 @@ snd_pcm_indirect_playback_transfer(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+/* Preserve the application pointer sampling of the ordinary ACK helper. */
+static inline int
+snd_pcm_indirect_playback_transfer(struct snd_pcm_substream *substream,
+				   struct snd_pcm_indirect *rec,
+				   snd_pcm_indirect_copy_t copy)
+{
+	snd_pcm_uframes_t appl_ptr = substream->runtime->control->appl_ptr;
+
+	return snd_pcm_indirect_playback_transfer_appl_ptr(substream, rec, copy,
+							  appl_ptr);
+}
+
 /*
  * helper function for playback pointer callback
  * ptr = current byte pointer

-- 
Git-157)


