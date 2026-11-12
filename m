Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794444487;
	b=ig4OrvvzxTY/uV1uB5KMT/EPL7KpqmjiVPwE2uzzwG1To/rahoDGULXOppO+n0gdcofL
	 /odVDW0cCeLkX+fF9AEpAFF5Ne+wykY553XKRJENuo0aNdadOJiBqeS9ELjTS0KwfTYiZ
	 IGkdh7Sb4z6P4FNEDjlmar0LtyhMSQKfUUXjJtr5ENxD4/PsMFY6nt6uYZJB9r0wH/iIj
	 /hX6iBzK70YlrEUQ01rXqYGRpZGBu4Je8mGG6PSMRv8BQGX/pULwJT7VPsQ4UH9LfA2sg
	 yhWWbvGZ5ZpkpSap4lyVH2AApE2lzZdKBLMKg70HovkpnyZBfJcUL5xCtuc7piVhKfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794444487;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AY2XF6wXATByYZO2AFbKnYp3v7psceGk44pj0mt46hI=;
	b=kiz8c1YPiBLty7klARO0T2g6mYOjC5l/R0m5Vpn2MVt8w7RpcIE7YkP9pIiyChtqAb6X
	 KfBxiJ6u6tt3nLW/Hr2dJx3T/ojRzcmfECIbxW/Bkdvf/uNvAzKd3/BQS6ha8tMZJzBYa
	 WSHbUx1BRjL0rZQWjla9ErGoy0jf70GD1Jt5OhOAlM12sAWKMYLyHvH4dSa1JqDDGm9YZ
	 a3OjzWaj9F82sVMX5CM2vhteLm3jfmWlENfQoLkJrfYGLQXQ2KINcjDB2gB5J1JOWVDi7
	 ZsxzASxrgGX8UQtzybwipn0N/nVE6SLsCQ9dnd7ZlyIY1OgrAHJ9xEVEbquBmcrQWpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JTdYiGHw;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C5C606A33B
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 00:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17C5C606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JTdYiGHw
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1ae58d17cd9so2927055c88.1
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 16:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794444486; x=1795049286; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AY2XF6wXATByYZO2AFbKnYp3v7psceGk44pj0mt46hI=;
        b=JTdYiGHwVsFNe2PCftTU/YFuobhgbVhWBxicK2xhSfp5okSkEBu8YToyHWELWTvkmi
         E1VQJbGkizjPegZ9YNHBDo4NLmq5gIgqpqhBD6sCQt5aY+PxMtVlOZcPBLYBh7mE3nJf
         IcJJ485KzCejMsT67IRahdDKUJJU7pRXOTsRwCiLBo//RdPehPxqawJ5xmx4jxY1hGyX
         21nO+FKEuroz3GuUonr2bp3DI3JVrLhdvqb/VSZDzyfu862eLRNJZQ9Vl9Hfu5+NIi0v
         he/DPa8IAxiCVURavlISdlVmfanlgcetbTtmyTUV6tGPXSE5tVSkN3AI17R6u00775DD
         xsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794444486; x=1795049286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AY2XF6wXATByYZO2AFbKnYp3v7psceGk44pj0mt46hI=;
        b=R/qT8DzoSkeW1JOH2bboB9JGIsNtkwA1JugzZEc3OZAjZTR44BapD7th43hXdoKrIX
         1PA5uwojANdQCiwn9KYE95yaUr+m4APmmFCdK3bddMHUamFTJL3az0lJF5Fiq89qo7lb
         bVFuQDYv12Rs9ny1fZduqC5mOBWRfWIcshn6V87AGBsUQ/QGO6EGSc0HaK+D87Bnoj4h
         L2Rv+Q+bSh2hCp3mFqaS7NpiFwUwXi/AHmm0/rrgcPukPqtSeR15Mhm//o65E6x224kS
         Nv+12IEPssmHg5EZzrWun1o0jslAhwM3d8XyrM5iJ2KsjlEf+MkZet8qXYdCJ1gHJn2K
         uZuQ==
X-Forwarded-Encrypted: i=1; AL+hErFf9pgO+3cn0Dw6pq5hfAiKxs49Lop4IDdaogfs70Dcq8n1Jbi7BLYk4WfVrU2u5JkDUXe6ej4Qd/6lQIaZRQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9C251jJ72bucVghHAdYLceAMpP7qjyTHBr3ALxMXwBl8uIExCR
	NB8JJMiIS8MXjtNGH4Zqv/GH9fpG3T40NcPK2pvMg279izHEKW5cej8r
X-Gm-Gg: AYBFou1k1u2St8OSmmLmRbN2KBTzLL1hGWVY6LpjYRpIl7OMWuDFO9gpSOtDi9q5KUa
	bP3iNc8H52NMyL4Rnhw9SRfqr1McbZDNXv8Py1Lcowq3rHryxNF0FQoANk9Hi4eqmxoPjKLQ5nl
	9If4N/02XHxrvLh9EoQdIDd9jFHo0/lQ6fok4vPC19ncg0oJRrGpYeFEAqQqOjX2ZGW6Y8GFEq6
	csmiTvFKgXKV5Hm90pRAMsuq6ALzOYrn6qgBgjZ+LZgk+9C6oAgOsMOEgyeiXS6CvYn0cMZb809
	aWknQGyPSLjIF4fP9gC+MU/Kvcfis0+NlOPlZMNbhXroIftFXhQZUl/xewT57i7vyvAjgy+OOzS
	AxCNUX3KxC5WJ1boq646bzcq5h4w2zPYnD3vNpjV57K2KbXd1ow1PpY9kW17szIvrAgH+e32LJ0
	L2+Vp9dPbjY9sfwcyn6j/2AQEvL2WVVLf5ypFTBAGM+h4lEYQtHovsJ7KfsKReV9TF8vira3PMo
	L7XD2UEGjksjXmTJ8l+95kEDtV3YGpvThVVBxenJOY1+Z8kUknGSD/j9NHcKBwrVGKmParMnL73
	P9mzRjpC99PC1VC22GYQ9Dx5kJXIZtNNBkdlm5Ff+B0lUthvHUjeHuaaWrXr4AQ3vUsUArOFm82
	k/EgssL95AToSPqypXADJyPOXtfb4BkoFWjtdTOaYsjULvyQ=
X-Received: by 2002:a05:701b:2504:b0:15e:9126:c60f with SMTP id a92af1059eb24-1b3c0342f23mr3517225c88.29.1794444485979;
        Wed, 11 Nov 2026 16:48:05 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2eeffsm20672163c88.9.2026.11.11.16.48.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 16:48:05 -0800 (PST)
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
Subject: [PATCH v27 16/17] ALSA: pcm: add an explicit application pointer to indirect playback transfer
Date: Thu, 12 Nov 2026 09:47:03 +0900
Message-ID: <20261112004704.49758-17-mynameisjune111@gmail.com>
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
