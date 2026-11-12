Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466236;
	b=5lszijDC/THB+Hu9f6QUFLADcutGYIY4q2ph6RxpvoTRsGWAmtEgGicp3SByOc9e0WCl
	 Y9HUmkKntAbTgrNJmmbyrWoUthJVYyabaYW9CR6GDqc8Xxxc4Yh79laqJXf8CE8i76gml
	 dJMCTC+Zk6HrOBe8aPrRURQkbYMe34ncSLQSrhyTTyZ06LX6KZVjn22AwGiGR9GZMltj7
	 XXUkcGvrDfOrkXUHUNo/H/o+eDqew4jce9MibchaZ5ORyVdF7rS5LCdiIptSGQAdLhTW9
	 6H+pjaQyPubciH1Aogqb5YVALRgHPRP1BujUXS+yGyZ5Z3CeXK+UoNkyy+S/lJ2L+Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AY2XF6wXATByYZO2AFbKnYp3v7psceGk44pj0mt46hI=;
	b=CHN8fwWhAhbuNteztFE3f7JaB9fRjvDQWj8eIieL9KEyQ+EMtJEzlDTlp3EaWv84DoSL
	 qot/JJ3TEHGY62cUL442f0tHpNU7VgXKrV5Cns8RPnPr3Ui+74TJjSguU4W9l/4/gdqqW
	 j5cvgrvf7MoK50tqcQssDKe1dUL8TbY0Ux/A5Cy75pjtx60Q5CCdf6PHVPf3JrPoQ3zsw
	 8TFT0HjZ2/YIgbFsx+hwOsYnyuq8cyLG197HQksvUR+3+9S89ur/PGxAYUrwOPCA813tI
	 CY7TRHfMpotcbXJCP2oRsws3F41RZTUhM4nKMZGiVjM8BkbMO5K0pam6A86wCilz0Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Mt7/vCV2";
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AAE606AE45
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 06:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94AAE606AE45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mt7/vCV2
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cdb2893531bso2273419a12.1
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 22:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466236; x=1795071036; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AY2XF6wXATByYZO2AFbKnYp3v7psceGk44pj0mt46hI=;
        b=Mt7/vCV2f87xCMs8PNmCImadzw5xyLAkRo7ASOiAuQzNnHOgdGl+CRhtuLqYtkJcdt
         bI6AcmnOuB8o57l7wDDJp3/7XOIPY/HTLPSyYvGkBskpuabiK2fF5+aEgVbbT0sD82MG
         2N9y1DIMWMVzBLExA3soLLCKc8CBBRqK+r8yfzs4iEeMpJ/bP/KSSyDYyCZB1nLXUVwM
         sPl0Bw1K0PxMF1HA6H9eNBX2P2c6inK+UZctfCG2QASJL82radh2dstfH9vFM+PXujBF
         GqfwEAdsfM3OtcpCM8+vq7jQGOsbwn+XjU724OOZaHa+CkMePzExU8JKATh2gawEQM3n
         Mj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466236; x=1795071036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AY2XF6wXATByYZO2AFbKnYp3v7psceGk44pj0mt46hI=;
        b=rEonkgRuylWiFJGdttuTi3h1rKynpvMiGBLp+yQ3RnQolfvwfoJCuzm/kAf2wjYDsE
         uKRqvTtalF8yVMtCgZ92S4uHWx1bOC74BiZzSYPaI0ZK3oKC2UWEfSJ4lUhi+eIaQVVh
         +RstgDKvxe/3aKIicYyy9Yxfd4jkPMbc9wYZPKyQPcQOZlv4YHWXnupA7S+cBXkNac/q
         BSh+d1kKyCYlo7O+mllZWv+K9TYu/CRo5rUGdq/HRcrbK3X0TtM0NRlZeT9mNa0XfB9E
         /ig4UmgnaLi3JWboyA4WTF6QyQVsDcIHhmjsKWGDYt6zUY8nHlb2oLSyEBUPRxdaOuE8
         h/Bw==
X-Forwarded-Encrypted: i=1; AL+hErG4VDFOHH4gZV9NSH+UqLzNLKKU6EwfLlBScly49UPBJRI3XJkafDdDt9HJzTXt5MBU1ix0NRnF/VYmpPpTzg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/9d1jZb0S5qGWbq6QAXI0d7OEJvplqEHcpb3Mc18qPl7lgUeAM
	5qCvbdYXyB2KRFEhi6jBPgG7iW1s2Dje0RMqdGoy6GcMcPuKcuDiYH/kBvAllg==
X-Gm-Gg: AYBFou1ucxGZSTchMFqUeORQ076Vyw+V3x03uOqHGvDhSmcQggSCCCYLVYxQSRv5hTy
	atPou+71ojszzKUVzp/rWD9do6wUivSqbQE2tido/zs4CP8Cb8Qkt+DJs9S+EGKpDWcLAb8nS6F
	WuozTZSvmJQK4X1v7iziMpV/HPQ9rsYaJATbqi6R4OKf7kYwjn6J8oygl7epcCh/q7hptVcZz7B
	khLCJPecBLcPE1DNV/6XZfGimzB/d0nUSlhJ11M2JZHl4xgFow5fN1YsJl+4VEd/UATZ+aotzJW
	KJDWQPWopJT3+64i6gXfNmdrsI9CQmUoykUz8UmsgXimBH98y4QtSoxKt6taCW4czL8ndPCDgFH
	48NXNSwiOjCPywmX5KprNT1QNGP5cpMkUHg/fj3p8KaGjXo1NqufPqkEtDc6NX4FmyMJKc7J/a+
	trZLJBfVlCVyFJMihGLsc6h9euul7XuRtOBHPTFxqYGHqkWSenIydc+LkhDedTUbxwQaFuK+mgO
	qfgBe6kjyZgKQsVbYs4cJOyaFIWIGk3jMva6nNYfB3QPVls4RxsWek8kEay2/h/SDUZCnbAPkh7
	DX14VEZ/7FWrqlxYMQfVV+NafA0MTkjQroNr6PMyJAjlM/JY4uhpHfOm6s2KFJ4+HH839agHNm8
	CQO3UdozmV2C7VLFATcgdIvV4FUdpetMo0cbdu13K/hPNBCA=
X-Received: by 2002:a05:6a20:2583:b0:3e1:8563:2a2c with SMTP id adf61e73a8af0-3f2fdd9da05mr5074381637.40.1794466235997;
        Wed, 11 Nov 2026 22:50:35 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab1228e2sm3097511b3a.41.2026.11.11.22.50.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 22:50:35 -0800 (PST)
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
Subject: [PATCH v31 16/17] ALSA: pcm: add an explicit application pointer to indirect playback transfer
Date: Thu, 12 Nov 2026 15:49:28 +0900
Message-ID: <20261112064929.11211-17-mynameisjune111@gmail.com>
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
