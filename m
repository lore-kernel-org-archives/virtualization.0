Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793412566;
	b=MfiDPnmBVfbG4balSv2yKoJ33PGaK/9D+STkATNHwmw612T6z6l/z8GCVItyIIWdsigm
	 VVpSKcE6kOEipbVHmY/5U0zU6mpHv6qhiTisymeQiZq71oUSpJrPgoQGjktO0yB5P/fZL
	 dL42YT3RoGVubw2b2EgQLN6e0O/5Zbyk41s+aUGo4CzebzGbLCfIIA9Ez+xjWI1ofjV75
	 hjc0AqNCke1ekARD8EU/0f74Y0ntgzmf9aSuOj4cB+2IDBw0x5CVtu+XkX4vGzhmuWfh7
	 Tkfznx1e1DCUbulaO7JI5oH5AxmV2CEvWHmmlVqQ/viOPLfv2IhRqRpflaiAtGJFtIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793412566;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Fg09ZFCWTllm0zs9cO5j/8sPKkdAt+oDDHh3GBuogaI=;
	b=rUchY9m/IJUGuaDks0QoOd1Z5zOBZfkulBTKhZIkPlKcRtZ6NmRkUSACfS7FhtFgv9Ic
	 DK11dAXowdD2tjyu6KeknXqTyczE5O8bt0X/aUy78p5z2za+9zpyQ9FFKh7woy84TJlsi
	 rl+Y3Qf1N8c1s1lIh4VOvmY1coKcYDyFSIf7jZkH/kDB850vuUBljmeCUIDDvMUolMIC4
	 Bmj/d0imk6/I3/S/GbCUyQxf1eCvh4OF6TCRBEzajSGosIw/epu8jKkNivyshE/CWbmj/
	 Mm/1nMZnXzrFAMPXInDF4irBmpXuQCX2JTARCDfOO5BsswgIIENNmlvEQJImOuarULw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o8muYxsN;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52F2606A336
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 02:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E52F2606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o8muYxsN
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso2217891eec.0
        for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 19:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793412565; x=1794017365; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fg09ZFCWTllm0zs9cO5j/8sPKkdAt+oDDHh3GBuogaI=;
        b=o8muYxsNOmV/BPv889IjkTIIjNmTppkkUb0tdT2Rf2/rfqUeR9sdmx//pACMyisimN
         SgRAghrAzro1hWpViHhz6huN5fp9o99tfOJzmUZd1+KLyUwmTCRLUpwKKgPja7VKTxkU
         C9qxeWPERqtBxXxVPXC5ri+zXuZuwG939eUmEhhopvXAjYDCMCioxsGWAcxZ3zR5QmaX
         BjKfUyb5cNHLALCcjXhnwJdZ/y7k6SeoI295xQpGJhvwALnWpFOHY5pLkuJGqM7ngclA
         QknX0BES2eayV7yBMKCB/C4LIr6oSnIFMgQdpeAzGBL7tifJ/OtnmzIQ1+/5Ul3WkYAo
         K0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793412565; x=1794017365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fg09ZFCWTllm0zs9cO5j/8sPKkdAt+oDDHh3GBuogaI=;
        b=q1OfFuBAmybMiO9MvJaVCb25M+agG+gc5nBj/vB76kNIvdML3hHkrERnANstbDFmXy
         Jw2mJ9wonSPYRQFsOHRq4hbFyf1qLP+QQFVck60XeTocr4umGY/dpgQyXzE7Si2Zq8Ib
         T+jX+k58LnzKy5Z5+6+uuvF3Q/HzgfwEEf9GN0Ai7bChDnlbDLh3BC2u+i/eHJEChVrC
         kc6d++MnnAzvYB2RYKmqWuMAz0qgxGk5Vh9DEfduqNBietw34E3j/OyQ92X3ed2cvNH1
         kZi3dl0QhAcVNkXQIG+e9/W9+2JrOl09hffzwVw5V0oBWO8qPRM6YK21zesZBLuyBZVp
         0mUg==
X-Forwarded-Encrypted: i=1; AKwUvBxYCKmrbIV5cMbydjBD6Rk9UW1m7v/3ihc2wCbkwK0zXgzYMzvus8Z2T6W355CGTYmg1ggWFSkziWammlitMw==@lists.linux.dev
X-Gm-Message-State: AFq9FYLn+64i8+paNLTslAW7wVewaQntRLTRgYVfIbg/71rd5z87SSAe
	fZ4BAeske8bj0iOHSNvtkB7MXMOwgO9dIa1PR1zN2ZhAgqpgVB02sxq+
X-Gm-Gg: AYBFou3L4TXL0GyE20aeOTDSU+TET8otnhOab/yT5PaMLpRFgrplmKpUEUdOXbgMWCB
	85GvkDxrtGc0JqegZ+7IC9aWQB+IDHZ7N+zxanWl0nnk3IlSWmMdIrm5vgXDcpxLwGN8KVsSR8l
	o7PdXy05foVpdUS2cRvzDFg9ywg4+ktsJ4Kw1NCcGRkiCBJOD9Bd4tgEm/M6hk4+1AzqkclPEmc
	fqwxytXPGCRxsK3YtyW5PNh79W/t+OMbMrrOz0dQsCle+W5Ul2uGAkYBOz2hTG2T9uK04lKncn+
	tpSPsF7H+CtK6zPsVMOFzLN5EAiU03dx2c0nkutUbpfVwUz2jA+lQ7RJEih39kTotVIBXPnGFH1
	PAWVv0U2jq4vUU6Pz8iwZVk8bI0BYyw7szgDkeHx5qTWUtukyORwHRV9kows9LJr9+fFtqdPjKW
	EESvNXyWeY3TuxonNlzDaVFwUvUdBCKS8kGPNPoKShj3Cr14Syxmxpy8my5YB7X21uGiJ9+Tvx/
	Hcj94kU1+B4n1YeacGehKLu5AcfEgnV6g+TV6phfOpJ0j3Y0CWE5fGjiphVJl0CYv+nU6OzvyP3
	9fyZw4pB+35DKGmXAYftGB8p1zUPpAiw1MjJvAU3SvyvAHDWNVDa2a5yosf2r77+XB/iq79CXjl
	Oi7DVCfzLW+eeMLDCW1nRG5EFE/C+UTxqcaLY0GPDM1zb3g==
X-Received: by 2002:a05:7300:c00e:20b0:36a:2289:c599 with SMTP id 5a478bee46e88-36a4243a674mr7312950eec.29.1793412564948;
        Fri, 30 Oct 2026 19:09:24 -0700 (PDT)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a77c0dsm13214096eec.26.2026.10.30.19.09.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 Oct 2026 19:09:24 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.de,
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
Subject: [PATCH v11 08/14] ALSA: pcm: report partial progress under the stream lock
Date: Sat, 31 Oct 2026 11:08:49 +0900
Message-ID: <20261031020855.2402-9-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261031020855.2402-1-mynameisjune111@gmail.com>
References: <20261031020855.2402-1-mynameisjune111@gmail.com>
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

Staged capture can make readable data available before a complete period
has elapsed. Skipping notification leaves a blocked reader asleep, while
using the period-interrupt path for this event can infer a false ring wrap
when the notification is delayed.

Add snd_pcm_progress_under_stream_lock() to update the hardware pointer
through the non-interrupt path and notify readers and fasync listeners.
It runs under the caller's PCM stream lock and does not tick the PCM timer.
The driver must release its pointer and trigger locks before calling it.
Existing period notification callers keep their current behavior.

Atomic and nonatomic synthetic PCM tests reproduced the missing wakeup
and false-wrap alternatives. The new helper delivered 64 final frames and
reported four available frames after delayed partial progress without XRUN.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
diff --git a/include/sound/pcm.h b/include/sound/pcm.h
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -1182,6 +1182,7 @@
 int snd_pcm_lib_ioctl(struct snd_pcm_substream *substream,
 		      unsigned int cmd, void *arg);                      
 void snd_pcm_period_elapsed_under_stream_lock(struct snd_pcm_substream *substream);
+void snd_pcm_progress_under_stream_lock(struct snd_pcm_substream *substream);
 void snd_pcm_period_elapsed(struct snd_pcm_substream *substream);
 snd_pcm_sframes_t __snd_pcm_lib_xfer(struct snd_pcm_substream *substream,
 				     void *buf, bool interleaved,
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1919,6 +1919,25 @@
 EXPORT_SYMBOL(snd_pcm_period_elapsed_under_stream_lock);
 
 /**
+ * snd_pcm_progress_under_stream_lock - Report progress without a period IRQ
+ * @substream: PCM substream
+ *
+ * Context: PCM stream lock held, with no driver pointer or trigger locks held.
+ * Updates the pointer and wakes readers for partial-period transfers. Unlike
+ * a period notification, this does not imply an elapsed period or tick the PCM
+ * timer. The same pointer, trigger and timestamp callbacks may be invoked.
+ */
+void snd_pcm_progress_under_stream_lock(struct snd_pcm_substream *substream)
+{
+	if (PCM_RUNTIME_CHECK(substream) || !snd_pcm_running(substream))
+		return;
+	snd_pcm_update_hw_ptr(substream);
+	snd_kill_fasync(substream->runtime->fasync, SIGIO, POLL_IN);
+}
+EXPORT_SYMBOL_GPL(snd_pcm_progress_under_stream_lock);
+
+
+/**
  * snd_pcm_period_elapsed() - update the status of runtime for the next period by acquiring lock of
  *			      PCM substream.
  * @substream: the instance of PCM substream.
