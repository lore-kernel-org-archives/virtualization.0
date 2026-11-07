Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794062075;
	b=WXaVdOobmSXg7tlTEW8cwBEsK39WSNRBHYZG91RTeQKzE8lrCqvIg28fhvZt/eTQno9n
	 Pdc522d6ALMBqxG2aFwFPD9lkP53vmGKz+W6TsJGVPcqfp7/gfpDQtHcsW7jMTD68ven9
	 yq65uW/rmOJuIvH4UvPKer3e9vMWXD2STudV+3sjn+SiFtVGqO9dEvACZ3bFR5ILcPCAq
	 Aye0jmeMH0zpdNzJWyqykydF+fxlOHmAyYwQrjdUKeYiyvD6lvHFdzTeNxfvBWi5O4ng7
	 Vea69m/hEVZpNAJKrTrYvFPe0OPuIHp2yXfsFUYDiPxASa3ip6/s5IlCVreZt0Y0P0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794062075;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ipAq0GFpqeILnCbmHOCNtPSgE8BRxRY1/yFPd6rARKE=;
	b=u4fn/mV+s+m9T8RrHfq8GYbwX2IWLSpyqxnaodY4o9NpuUflzbybmi2deHBltbeRtdwJ
	 Sf+v18Z8DsQFRT7Si9jjSVR8ZAnE/gXOJij67m/ZVsm2IvDRUxZuguFu5nR7ze4itS+yw
	 lhobR5O+S1+wTrhBTqtDyGOnETT4OeFF6Y3waKXraWzXofrBybz2Oc2t7MyeRg7uk8ddm
	 ghY9c/SIOteP+3R1E4hsvoXR+d6luX7wmjdnbPIqnLjPKdsR7ixGbmU4GVcgqo45+qxUv
	 dz/Jb6X3c8zIhyoy8hAXnWFxGaIVPf9OXbMmCm95CSEtHUH6wFTL+4bBjdTvE2SrZqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ttUnS0Kb;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45C2606D80F
	for <virtualization@lists.linux.dev>; Sat,  7 Nov 2026 14:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E45C2606D80F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ttUnS0Kb
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-33fb4680717so3171665eec.1
        for <virtualization@lists.linux.dev>; Sat, 07 Nov 2026 06:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794062074; x=1794666874; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ipAq0GFpqeILnCbmHOCNtPSgE8BRxRY1/yFPd6rARKE=;
        b=ttUnS0Kb3KK7C0jWMVQfqgMtfA2KZ3lX5VFxOg7ykw9Zr77ww1pk75qBIHEehbT6/d
         0tsAwm6LxrbGvvQmPKy5McVH8i9+ZqOLR3WtnuHNMytONYZioTFZsq+hkpUy5ne4e+p/
         OifIXxTko+kkHzmJG5po2qMhgzQBbRgslN1OuEqikdoy/WCs9E1ufxvdC0erxvdpQKnv
         L5y7QA+q9ZAxo4DcSs21G9Yn9A6iWTH3RRKUTRVNUsClGt3qqbb7pzV00yT6U3tKSLgG
         HXtPuDEFl/2z1M1LzkyG7cwZViVa6yYtKJnSBhXYI1PRJUtx+MmcEERKqtfxNr0lQKfb
         jH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794062074; x=1794666874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ipAq0GFpqeILnCbmHOCNtPSgE8BRxRY1/yFPd6rARKE=;
        b=hHugEM7nvwF+DzwGpoIw+EmPyH4+dyzGGd4EuD0t+Ik5baSIO5sNr3x8KLek8OP9DI
         f5U0XyYhWuvA5/QJIslQG9pteXDZJJDr96P+qz4x6X/59haXnRfRJRYN/wWxbWE4qYBp
         i+PJgUZbv89d180FERhxcixh7SnmsW5c1V+N8FJO2Spe2s7AKfJ5vKr7ilTAT/aiKGux
         Gtcfb7PieZMfZUPd1W38w7A0r4TBP0bud8XJ12W/CTjZCGioqxP+iO+gSmwSqsD15XOj
         Wn7UBO4ObyEjiPWwZMs1IMs83Mw3Mp57ZWlWqwVQsjGc6rRMgjb4CjQv84uGh6L/0svv
         K0sQ==
X-Forwarded-Encrypted: i=1; AL+hErFJxk8rdWf0PMjgLUHR9lkRAkO4/GnPcHGlYWIyB1vv74raX6bQoAnNjhmnhJ04xh2V/D+v5t2JfX59/Jl+lQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9DQD8HusNyy/i2z1UTDNsBvMApsu/5DHMhb5JPu7mW0kYmpchN
	SGXZtEOL7guTMMMlbkd4atEvd9vX9XF71KNxPBjl6XkBVwKbUQf3YpMB
X-Gm-Gg: AYBFou1ZlWLCL02+J+5eEhKK+IJYwnhirxIgqqQRMvn2G06gEDv6VEYdr8KmzdP59Ks
	CJk3t38lB499QEhE6FMJJIuFW6OmdzluMJom4b78evetrzkI21U7aKd+nDqnMHkmCB8CZXfURW1
	JEz9T6lBOXEUPjD4Ny2+SDxnh0CgK2pGVbXpa7YBZ0VnUedWu7Zc6CyI/y6H5DjdiDUcZQ0Npex
	1A+UydQQHPm/V9zw6bh2AHxNpK0haQSoIk9GcU/Ruchq+Z2i3KNBWXNPLAe3IbfIMdt87CXAK62
	vMu5VVhvHw9HngHOjLekTg4aGoZwokOxzi1dvaacLCiDqA7en0Y2/W3lAY2visNCtMgYLOLYYVS
	/J2tWTNiuM8oDSvnRBgKNSpUObv1isE/+WnrCZy1fjFRn81AF0N/KJuTkoaH1DQssTCcO2IM+La
	ZbbcGXwXefBqsitYpTF1JlB0gRcbgdU+JgyVlSwRLZYK2R+7KqtpOBXQ30P7lOvWMR/s01AhEnq
	2AYAHiz0CYcI+hbOR3pKYJU2v/83N3tQkEaAnZlSfX6wUx8TzwcELHwqJ7ALbvm0a3nMfbnjr+5
	Jtuw5MKU7o6m373PLbgG286jbTf5qjfnX3Q7xh+JqwnhsGkmKw4mSYL3pOC+QnvTrve5JwSuNJC
	pkDIUCUJpu8TQtkRbFTL0QpEmOm18twgm/C92l/11h9jsWA==
X-Received: by 2002:a05:693c:6096:b0:36a:1b62:da with SMTP id 5a478bee46e88-36f75440a42mr9647838eec.12.1794062074059;
        Sat, 07 Nov 2026 06:34:34 -0800 (PST)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9aea75fsm27881873eec.15.2026.11.07.06.34.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 06:34:33 -0800 (PST)
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
Subject: [PATCH v20 02/12] ALSA: pcm: report partial progress under the stream lock
Date: Sat,  7 Nov 2026 23:34:12 +0900
Message-ID: <20261107143422.29319-3-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261107143422.29319-1-mynameisjune111@gmail.com>
References: <20261107143422.29319-1-mynameisjune111@gmail.com>
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
