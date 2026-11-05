Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793845915;
	b=e0nv90mRV+ibCDajKHKYU8RlVwYsjkvXvf4FZ1/dRSVCwABWcxBM1Ijy/kMf0X0BU7rW
	 DyOjArb4dTM/BzKa38r6BZso8Cw4xqoTQ8qSqbWy8Byc5QwE3w00zwRIRwhtAeXFtppQ8
	 wzdFqHpo1Qzm3wJImgw3tRC6K/qiNWM/fkeOQOBj9DI1W+1MCPqy7jtFmrH6shQODxBZf
	 f86LlkIpHnT28R8Gl0+9SFoGmvJHOgVHsJixcT2rO05SmJCXNvBVWgC5TNJj/IC/0L9GX
	 eTDrzqpv+920qQ7gfaTLICLjt6FTNOtBq7ok2+/2tsN+sIeZHgovuqt0R328UOHOKIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793845915;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8Unix0qGxH+DyR8DqZn4KwW8PFLSBTwhIEWxnFX5DnY=;
	b=xhO9rlERQ8k//jM62wcFul0mVhl0KnOphOFlNx6Aie4AjAHQErybuCgqE1aywbKbcwEv
	 RrV/fR7kMv/8AlsOH4k/0nWb9W4Etvaiy5/H89QQPu/KUCH+rmKE12Um0YN58343Krubq
	 VQvFfO6YnclDw22dWi/PN9BH8pSv3PwHCXt9y4JMzBFIF1f/7iqwCgEDIe0A6BG8yT0MY
	 XFj63RclHJXnaMwQva2P0XAMI1bIcpJc0bl6AA+3kRe//FR3e7oN3j8wjGWmGiE8uoVMO
	 ZJrU7pami6zFVYyfzj7P8V4pAjq7oeHN6/jyBvzO4g9kBft0s32o5BUhEBw06udQiew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KyLPhzXA;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63366606D805
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 02:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63366606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KyLPhzXA
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso955849a91.3
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 18:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793845915; x=1794450715; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Unix0qGxH+DyR8DqZn4KwW8PFLSBTwhIEWxnFX5DnY=;
        b=KyLPhzXAM1gjbzDdDbIM/+S2RRuKJSb55jFKsS6DXr0NaxUzPXWKQAXEOWZKNK9wmQ
         S9KQ09c5gF5yFzz9o7aly9lS2Xb4/V1tyT6BFMdY69OhdjTLGR0xSv1Dfdbdzb+/LUX/
         Dqfna2FV3rH9xK+0dxvhm4x+CTKD9uuK/6STq1cRhXujzPsHfEI0ZmXC+ahS0UxzyVEz
         BSlIYzLqUlWFLc44d1cUn+FZPGeRIsH3KhoScWbZk/OxrO6u89eL9Y/ugjOOObbjDt7i
         JW/NOtqTlW1M+4VQ7fxtaHHrFhKghC1kKy3NSp36aGOEz1kmppadURV1WMRnlRQji4je
         mI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793845915; x=1794450715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Unix0qGxH+DyR8DqZn4KwW8PFLSBTwhIEWxnFX5DnY=;
        b=VWxZoe/KCWQS3blC5uXMTQDBMOPtXn71HfXA/DNszxiIkTNgWQvj5Dfo0rMad1cr2K
         y2mxJFm3RMRMVui7FqKBqYzRSZbUxkZ4z4n74R4GXzcIeJIjdZ3JF1HnvIYOuHRXB65Y
         pPUt4Hm9TKDc0QHsdrpwVVa8sMg3IDZ3UYU0txpdSpw1OCb+kQA2/C9XfflMQfYy6DsT
         qpaz3P4Pz8Nv+kYdPJOXT0o8fcHy13EgfUl/nva7jbig0AtspXYLMaTm0brNeJvjlKy6
         UqrfYdpPkzkXXUTAOOWToHIFHeb3b84PVK0JO2UXEN7neSA3Hi8UpLrfiXFsXosJDoDc
         0jiA==
X-Forwarded-Encrypted: i=1; AKwUvBzODXKi1Ypd78RdrFQQCjzNB2R3wypiadkcfOWuqbHJ4vjeLyZZ1VZyVS8/9LSAr2At75NSIjQEL+pktfWeLg==@lists.linux.dev
X-Gm-Message-State: APuU4Z99dYyX4Cujq+m6U5Ikg2wBRGHZ7IWB0AvvcxVg9rYE1MQRxf3r
	GlkVWXE/rLWHUim0ro0Ebpku03CUUbCq5qeqI4i5WpIvx585NVO8ynY3
X-Gm-Gg: AYBFou18OPowlLZwhcFo0/Dx+vHBW6xcQc7KGjTWnZVe8Z5OMrO7uRL22zkVXcNxa0J
	qmbZ4crdLUUlCUaFwrKXr99+meLhZzmFQL19xkntvVd8HZrI5P/GCESTZXpH5uHvR02BNdur08o
	IfiGzWPwAdYerxh3YwC3ABM6UiUwGOyioAH0eu3WGW8N3OkfbF5wzqN3s5SkwdRRuTYjaBKcyAr
	jS1akYUWIohTQ8uP1qZANXImccwtkrtTBI0G0qoGO18DqurYzxYrjQimE1DFhxpNGB2HPgpLNaY
	eRZzGZ4by4exSamcN6VzKFlUSMkd07mlboWBcu49u6OvGB4tJUH/J2tLoR7SQczm8/j4eFBac7m
	X7SkvDOBQwpl98xvu+Ehq+QlVlRG+LxdY1xzTpWsGrs9ncQUyeJPCPELquZUP4SBvWxDtJxYwHm
	a3FgNz6R6+SFqu0jjMqX/IxMnJlQtpf3dAtuJzwPRWk3RgY37J/HafQaBZaUIyZ7R0W4/cN4C1h
	ZInaC6hkGRMajNQAyxA6LZSJMLhQ5qGUUPCbOrhc+xXciI2hjWPmqbaI9OxuEZQ6k7XYuzJNL6H
	U3BtuP5JzJBK/AKJApWK7j98j7N8Vhga9PwvUEeJN96CAycABO/ZNAZSQvMgbHycqq5J5T/JG+J
	YNrwojsamGYMyNSm1NhIrJnaBWgSuTWAGn8u0F49rIMRphHs=
X-Received: by 2002:a17:90b:1e47:b0:3b0:a651:a7c3 with SMTP id 98e67ed59e1d1-3b0a651a96emr2175878a91.43.1793845914479;
        Wed, 04 Nov 2026 18:31:54 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b323cd3csm1292775a91.3.2026.11.04.18.31.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 18:31:53 -0800 (PST)
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
Subject: [PATCH v16 02/12] ALSA: pcm: report partial progress under the stream lock
Date: Thu,  5 Nov 2026 11:31:30 +0900
Message-ID: <20261105023140.18373-3-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105023140.18373-1-mynameisjune111@gmail.com>
References: <20261105023140.18373-1-mynameisjune111@gmail.com>
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
using the period-interrupt path for this event can infer a false ring
wrap when the notification is delayed.

Add snd_pcm_progress_under_stream_lock() to update the hardware pointer
through the non-interrupt path and notify readers and fasync listeners.
It runs under the caller's PCM stream lock and does not tick the PCM
timer. The driver must release its pointer and trigger locks before
calling it. Existing period notification callers keep their current
behavior.

Atomic and nonatomic synthetic PCM tests reproduced the missing wakeup
and false-wrap alternatives. The new helper delivered 64 final frames
and reported four available frames after delayed partial progress
without XRUN.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
include/sound/pcm.h  |    1 +
 sound/core/pcm_lib.c |   19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

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
