Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794561699;
	b=OmG6T7spk2CkhGQm7SSVpWI/MMmfqMh8W7Xv49HKaqbGMQQXcnaCkQsCy/cssIUCg352
	 ci+Xu1mwCc8dtQDqpobSKtI76t7Qbo4pGHfbE2KGkmTIE/CYUDlWRuuTy1pB94inzF98t
	 bVFBeg87AFuKOgzScDMrEHBHRukkRwdk/w5yC5rEhTNZ9ih8UVUHwbPYJcxR5IareQgL7
	 G/GpH7mgj6YkG9KwLtIbPQt8sIoZxXdZmi9xHnYqz//5egxafCOC27X8ewRLjDQBvZwTc
	 qWqnFyhqo3yqqMu9td156ennkME8RGAK0FufSlLWRDW5A4g7Qwk/wKpZ15gB9i6cJ9w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794561699;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=m7mrPlKLdsgB1ebZ53UgPolKWenYjsNodqkdXpnYjd4=;
	b=Bo5ZczaazH7zdZxA63IS8FhUt3DIqvqEuMzoScEoiege+Z9UwCsYzQV8oBfgEyxt3QwW
	 9MZAiNJQD3dO54pVZmK4DAsIuyDM4K7PwHQqyJjIIJtm8p2eI0HkDjt2EI1Ou2Dvwifyw
	 z21dHa6cIe0Qvt2VKRehNq/rxs2UEVJM2pOEckH4oSb22T/2pl00RyXdNDyBy/zv4+NQs
	 cHtJsNfgRlGDW3cO6oTzE960nCucXDxBSRvUdFu2l+z7EIb9h6ZCRBD5pSe1DH5VFGbgO
	 I1yAj2uZneV+vmQdHXXmCE9orm2Q7p3geQIynx1rmBaMxzqUWHEwF5ksadIHvxVEmLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aVq5jA1R;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E0C60A382A;
	Fri, 13 Nov 2026 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aVq5jA1R
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794561699;
	b=cNlNQs+EGK0QOoC+Ba6L1F/PVkB9NT1gChVM6Qqnq60NDQDFFUkyyuKksDIxXsYvqJRF
	 bOw2FzrQjttRIIS5VA3eLs4IH/hBOUih+nklbI7ZXaKSsMc07WqfP2GY5ZDAg0MrNhVng
	 pl0IeqrOhQIaZA6YP+JBwKn5tmSSfiaCg/UrKdL3tg5lL6KplH26om46v0uO0kw7Ft21B
	 BTxSAlltt5t/jU4k5dfMPLWPocUX1kH/jx3I8WqfpYJvy9I6hvsuO4ZgQ5TNYEInHV5nK
	 /Hq2ir1P3eRmSigQpkvZbl9bqsgCl+ImRy3tYRIvHn9gBgJe3U2BBP3jRW8ZNALtz1g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794561699;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=m7mrPlKLdsgB1ebZ53UgPolKWenYjsNodqkdXpnYjd4=;
	b=y7CXXbQzcba4s51gCXAKv7BeD+WH4rfAJJm7ix2H1uFDrVUbu5rfeTwQMH1lBJi5pVKn
	 4hP4R7TBtUSM6R57FjE9OmFBggfgSHThtnO4FbRSWQuwNi5IPwWJSWXwKeFKdZPom9agi
	 /iESTm38vBEiFF3T6q0MnWq+gy45HMUJBD8t6es9ngrH0Av9KKaxmsBTQwab3k1kuopM3
	 jlUAK4fvWpAef7h2ePdTGeX5yIReZPUbe3Q3HJxG7CTb0ZkuKqeClq5YNJtNtoSN9wAVG
	 Ec3GJySjRs2M342P7zbbV2XAwlcOL92qM25+6PWbHOdUbhaJYDTG2m0ERLABn76kcYQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 17D291F000D1;
	Fri, 13 Nov 2026 09:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794561699;
	bh=m7mrPlKLdsgB1ebZ53UgPolKWenYjsNodqkdXpnYjd4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=aVq5jA1Rnbd3bvMjKjCYdFn3ejTJjebbr7d9AYybakG4PZgXpgseRAgqufU3dS5YT
	 oSvUMKPL1CylhGWeIflw/AkUkoj0UaKnoJPnE3CjfFAAYMAOoYfXQ8mDu/9OslKXHn
	 2wiu33HH54/tPGPSIUzWyPKNSdIAVnRLBwDw2vSmdambPgyX1+qX2D2YCg/Qy7o681
	 /ooT3EnYgW+4B+AVj8c0kE9vOme6FOwcUYdF1kKvbnrdOmf2s/1Drhxq67RahNYIsd
	 D0J+Hin9FpG/tqzZ9Y9EOhvGzo8tm41RI3LJ1k0ALGRdtwanRZm74deoKm7xspBPdF
	 CaIJLTRI6I5Bg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 94F7047744;
	Fri, 13 Nov 2026 09:21:33 +0000 (UTC)
From: Joonho Lee via B4 Relay <devnull+mynameisjune111.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 18:21:40 +0900
Subject: [PATCH v33 16/18] ALSA: pcm: add an explicit application pointer
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
Message-Id: <20261113-fix-virtio-snd-recovery-final-v33-16-13a934ad5ece@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v33-0-13a934ad5ece@gmail.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v33-0-13a934ad5ece@gmail.com>
To: linux-sound@vger.kernel.org, 
 Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: tiwai@suse.com, perex@perex.cz, mst@redhat.com, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
 linux-doc@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, 
 Joonho Lee <mynameisjune111@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794561688; l=2611;
 i=mynameisjune111@gmail.com; s=default; h=from:subject:message-id;
 bh=v6jytlFKn0liAYZD+sb6fcXHPlu1wdJ34Mi8Ld8kynM=;
 b=4hECvXQb6S6pwQHBgWa1e74CQDq/g9/iqyt9feVX6toeOhwFDBib5ckoo0dMo/2h13ZaF366K
 /aMbE3N2f79B6lfiOzhFRnNGn3sNjIjfZWubbrFBqdMM/3VuYbgB1qb
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


