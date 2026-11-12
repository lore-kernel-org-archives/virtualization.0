Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794464753;
	b=dJ1Cvu63jCcg9uVH3+YzVzYXAMRYUXHuvRrkrImGnx1W1wdcnQ41dCsuuaSzq3GyyBp0
	 /M48SDxNP4RI5yL/dxshDdw09O8bw4CGlFxbbzXPRvJ0O2LYFLYdCPDAvkmLy354yDpwm
	 /5CgR1oaSH3GR9SwiBYWTw7E5fTlChBWXEe7LupBnWts6MyeTLm4E+mf8XpgqMqd5tsdZ
	 b/2zKLwWpRLFA+SW0tLDxo7XBB0XzplTi+8InXroINk9URHBLXKHCXqReTMScrT0et/vi
	 NDWACNU74osqYPED0jmR/utuLHEM4SvS7HsS58aH0WBpWnqXpbAs4QlzRnRfWVf9PTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794464753;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AY2XF6wXATByYZO2AFbKnYp3v7psceGk44pj0mt46hI=;
	b=4cPKdoiQ0GG+2sJcdOGlVeCFY8Je6j5yh0AnZy8bn6DqVw98cpVbbEc9TgHfj1U/t9ro
	 Ba0+nfc02J3zsABkQGPi3IG1zCj7e4bVHmSsof2EZY4X8lty1KxmH+5lxIX2J4lDYa3lr
	 RWaYi53SDXgx/E+kdBE9jAx4Fo2ID2g2am7b2bv3rR7y5QLv4ofEnmq4mJLdW+qIrFuEP
	 AIJOlwxW0jJ9o3dFpNpdV0FpC1e2sMq9xVAnd2ZHcPzY9AhwinIlFYIortukCfAok++ES
	 uR4LeGsXOibhF87EISJ5CkdCws8wBR7UVrSvl16h9943pGt1OKIoqgPK+S1TIQUzRbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k8SpXDLh;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9A060A5BDA
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 06:25:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA9A060A5BDA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k8SpXDLh
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso24734905ad.1
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 22:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794464752; x=1795069552; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AY2XF6wXATByYZO2AFbKnYp3v7psceGk44pj0mt46hI=;
        b=k8SpXDLhw8mVVPjtq7ZpMFanChOQ7E7kRKTA7smBMZoz043N+Weq8ziOCh6vsGzf2A
         Waw1LPsNtOiihAHZrjE6H0SFAI652iqOiTHx5a3Zll8f7tlYk1Ekh+JIWXr2i+c8vdz0
         C9yWnSD0xd40ClJH0actJzURZVYlOgWX626cDlvPVA17+X7kL6/6UHrzfTXV2cxYob8P
         q1R6UL48Y57+YDKVQIuZiyxkzJcAyGMguKV+6jQojSUGgoEgEjIoiC5cvlfaP1p9HfuF
         YxUd9yBqmpKQWKIvm5LU6Jx2iiSG0xiBbskAt4Uu4J7AjCTw9WJmDOMHVnoDw/KUftR9
         gyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794464752; x=1795069552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AY2XF6wXATByYZO2AFbKnYp3v7psceGk44pj0mt46hI=;
        b=CV+1NWMlqW3xZZwz3tjmI1tND1yToCqZfUkjInd5pxuljIc/G8qNoep0t69e5DcmaE
         /dxzQRrAx2J9cyzVfFlgoqJECsPr73zMEIwV4pn7sRXKqFxbtUXvcSMs4i/nGZ64cD7+
         0tOzmfoQQCVGKSUSWYdoAUGIENh5J6xR+eaRyjogqlBIZxyucjdfY0LxgZwQ5spup1XX
         F0rb8n+La0XGVYtGqg3DgE7nTPqm1dtpvKoGP/8Epo//ks91WFiVqXy7aNCzSubZvVbD
         tfdcI3cGulXrdjBzdYo7PNnEGRjd+myg6VocGhX4EGEreR4fwINqPKMA7sJ+6Bd52fAN
         LZYw==
X-Forwarded-Encrypted: i=1; AL+hErEEf2F/JsmLDzRYXrJYZURDFX5IABthKQFVypgmUl6nweo623jolDwcJASJegrPy7Iu/M1OxFJfnzKcEEFAsQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+H/TT0lNTAJlaSwsm9dpYFxft5X4lNZhLitQXAOhkGDGqbZz0k
	iPQl5FlN8VBKX8zq5VFEwjdTg/y4SF3bRrOKX6VrdUylAwOf5g+uiRyQ
X-Gm-Gg: AYBFou3kzmWtVix65p9DjAy7ODy2o4C0tOq5/Lkg4vPV3HWwj8ogpzPfMYTVMNNnkk1
	6LVTjvbGc8IWXZZy+VtCtrjtD8ssqXo6rf9THOM8UaQOKBQdp2+uz0GTZADXGMdJiYIQbWCykRS
	3WkZsDxPkPs45BotGzLa9CRkacBwicTtBVwawbXE7r+EOiF/zJuZ/2XSFfPpFphxYlJ1OTBJ9Zl
	XQP6M+HKAGaHCv8LuKG8Kyd4sMnTgGm90vK82KExBC6Z74Jf75PoF468k2Zu7c1VT+nN2Lxasre
	b4ishDiP1VGKdFmQ3HRoe3XUXt/cpxiWoUIzr/bFFO9mtdZtvpGNub4tCnKpV15waQies4BozZD
	NVgRrARoK37wYoHZVuK6tNtTghmdjls1jf+0hLIibEtTqOnDQPS2/kFWQrqzlWfVVtyoWvRDG/o
	UAP1BHLKXeqIHXBrD6ouoe3cgb/nQ2aqFgN7f/jWd9C/xNeOQp55Y/Zh4RJJ7HI/wDqS8apJoHR
	MXPLaRRQBs3tMGyEQZEPNFkynySdoBcS6pVJ1R9sfbuGQBvbCf4pPEmcg/5oRJYZYIHNWFgEFt2
	dwBBl9ppOZMMlH5NDZnPOD1+UyDlhI9ZkMDh6+vh+yzGL0T8jIw6Qa2Hf/bL+E5KIpXhqMLbxRb
	qYknml3tCcoJoh8lkoN1SXD93bki1ydKqxi7KwQc73LJbQWI=
X-Received: by 2002:a17:902:f546:b0:2e7:e73e:7091 with SMTP id d9443c01a7336-2edd7a20edemr51204535ad.31.1794464752290;
        Wed, 11 Nov 2026 22:25:52 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6a3e61bsm26979965ad.11.2026.11.11.22.25.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 22:25:51 -0800 (PST)
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
Subject: [PATCH v30 16/17] ALSA: pcm: add an explicit application pointer to indirect playback transfer
Date: Thu, 12 Nov 2026 15:24:45 +0900
Message-ID: <20261112062446.159-17-mynameisjune111@gmail.com>
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
include/sound/pcm-indirect.h |   24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/sound/pcm-indirect.h b/include/sound/pcm-indirect.h
--- a/include/sound/pcm-indirect.h
+++ b/include/sound/pcm-indirect.h
@@ -28,15 +28,17 @@
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
 
@@ -72,6 +74,18 @@
 		rec->sw_ready -= bytes;
 	}
 	return 0;
+}
+
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
 }
 
 /*
