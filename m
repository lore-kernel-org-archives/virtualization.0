Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794461752;
	b=Q+w9RH33PfFT59ziUsQUoVqoInQQu1M4DJfkUv2tXgJm91P/fudvcZz9+FJfbXIlUeBj
	 /eJ14bHQR2wCslLn3k3wfriWhOukXf9EOGSfsy1Qtz/OnckkNtTrdwzxjFI8Gnvw7sP0R
	 8ok58RBS2esmQ3elRbXrkHpmiZDJ+V31hgTlsQ4X//AoMyBL7D7DDBOsPawpNNFx6D4wT
	 eY7t6nVIX0kC35x0sNNBVNcqFp3amNrOL+kfMsf0OrGHaZbdfD/8WXrq0VA81JHywE5ut
	 h0YAOBXYPGXIw2B5U73LgTuOGWJE+gpFz+wB8+9x5+QTIVl/qNXB+0w4TkAth6XIZMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794461752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AY2XF6wXATByYZO2AFbKnYp3v7psceGk44pj0mt46hI=;
	b=tcbXQRyBPvC1pE2zcan2bM2n/4JZ+efl5KRJXYTuXuknCC+yBvCBDS9bViOcT86KL3rq
	 crNIfM21jSFwJN7DHo14l55c0rPQWSmIkkXDWb9Iryhgin+xCpI6butasgJitRXxmumeE
	 RFO9XqutXF+OcTUGY1sQQNAQOfzXALoulIz6apqHDwoKa0jxdqAXOAQVKfBAmWUH1A2py
	 cV2J3RtjItiumokCUm7D5fQutcv/37LMnOs3kJIpTPSJpnViGp91pimU8l0QZtl1/dJJj
	 NsmcqTJqT+5tR6cNjYIu3aQK2ygmZLkHN8E6W8kgU3bTwNYxkWEzt8OcQKl/FZtLSYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ClLQhfEy;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7261C606A895
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 05:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7261C606A895
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ClLQhfEy
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1b24f4b15c4so166208c88.1
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 21:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794461751; x=1795066551; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AY2XF6wXATByYZO2AFbKnYp3v7psceGk44pj0mt46hI=;
        b=ClLQhfEylZ24Z9DofewPOOU9X21MPTqE9KtEnfsG39pCuGFzOhehCVkR+bwef4CaSm
         jsFLbGxWSXGg6VuTygjN5ZpL17vGqrrom2ENf8N2HgQ6CGUATHK3jtlxtYvwNFfl7rKs
         /1h+OLNjVB02pKoyrNqriFWt4iFylAf6i4WizjA12IB3iEJQI/VtQBgMIdYwKkOPB2ia
         OfDoBfxAq2+A29OWF9nz+QXNs8VnJ5U/FuETtSkLJ6ZMxMEWC0KJ538ujkUmPARvv02F
         G4IVq4pWAALbk3ZojmyB4vaWOYBHFpK+kV/G/FORayElZ8iwHLOSaiNGQ9mAmP2HgoVH
         VbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794461751; x=1795066551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AY2XF6wXATByYZO2AFbKnYp3v7psceGk44pj0mt46hI=;
        b=G5x25R2xtbckLmSGy0cR3+Fwl2GRC5CTC2Asq43Gg9BbNR/w8EL852S7g/EvLODke4
         XdSIea7VyC9K6yixRk7Pf2n8Xk2zJhZleUjybyPkOOlbibnk5Bfv9WwRVV4E2eSq/5A9
         FSGnI12jttVtLcMKqoL8bcs+BrIh/PDBUC2ytKWNOq1JomHJ8GF1vTD0/62xZIrzIILC
         NSInzuctA/aIz40OI+4LEDMuaW10jyovdnWk+3atms+mVfqzQhMPq1GlBdcxQtelPvKl
         hat/o0wMjd4TJnR3LC6v4wUTvoeSOtUXZTiSyKL6vrq9qDcqX4DED422pjdCRqmWhm3X
         uP0w==
X-Forwarded-Encrypted: i=1; AL+hErFBmhxx0bX80TZoPOIy2Pgft+EszvKEfFdvJKg5RYxOx+4b6FbL5lVwdf8CsvtV6M+V/GV59iKYZfN/ejAFJw==@lists.linux.dev
X-Gm-Message-State: APuU4Z81ZRGq8/7BYy4LzJCiOEzI7mvtfxg3PZUTQaNsR8v/PMM0icED
	Iuki5LWOLKddgLwL4kFxbl4qt3+PW0mkIqWMagQyfEDAAB3d9GhTikqN
X-Gm-Gg: AYBFou14fNvPtMLiLMH0gCiciyDNySr9hxh5LakpFIBRnpHnBTzg17mibRPg0hD24pZ
	jnzF2Y+OgdbQBFiCRM05uE/8+PmdaDHO9vf5Jz5auh6OaMo0GCmI2qB1TriQA1dg1dlihlW351/
	vMaBbwPXQZEiYbCLwdCel6gm5d7Cy1SiXgGTl8y0unsxMPoPPPTnh2gK15SN3mXOPyr7hyPOsv7
	N0E2jquGyL/Uzx87PoBLlBApX+tnxN2IpfVJs5Wii/dJDSNpc1NM7b/1qTDKoUGlxt1w9UPqF4i
	KyoxLHV+3eX54qlhRYRNmFBXKar2bVbGuml2onWP9hPttaA1yY0B/DeEYf9bK2sSX7Inr/nP191
	is0SEHGnZDiIhOk3lS68VQstBNFntGvV8tjoE2+d1eUS+rOG0+5zOKuoZQbZossuvVtxjBu19Bt
	y9jS4Y/x6YkxJ/088VAIgjznl+H0JLu20qhsW21At35+FtxNbH4Ft/752CE8MtDOwRq7LriQu7t
	AQZlYcJeNuIyirzT7b7z/Xm4wuKhNw6Fxpb7AfL2YS7Wms5MDPqm/dO0z6xsmgBJVFA7+UgtDNF
	36dHPiTPvze9gU9RHvmYw5yW1llN4reXAHdLKQhtoe45950XO4WrXFWOOYgcYNpsEhxZBuNe1Nk
	4pvXBXYMMO17MeEfhGZ3ht8Pe9fYbUAlgkJ/KanYJ3PRsc7M=
X-Received: by 2002:a05:7022:e881:b0:182:d0a8:d1a9 with SMTP id a92af1059eb24-1b4f5dbddb6mr1543438c88.0.1794461750617;
        Wed, 11 Nov 2026 21:35:50 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5890c0esm21953240c88.1.2026.11.11.21.35.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 21:35:50 -0800 (PST)
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
Subject: [PATCH v29 16/17] ALSA: pcm: add an explicit application pointer to indirect playback transfer
Date: Thu, 12 Nov 2026 14:34:45 +0900
Message-ID: <20261112053446.73504-17-mynameisjune111@gmail.com>
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
