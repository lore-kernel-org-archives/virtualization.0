Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794201397;
	b=qyCihdI3TbvRLfk+0676lvvfv0j3OrSvv9WmeSeMa5KNnFVSEYOsYkvp4PXYlCcCZWMt
	 lmMRO+iVlYdt5QkO3D2VSFNg/2ymmt1zbF+O1DKGxVppRg/0Uf8+4oXByMWcclCn3xPPR
	 9yy4m+abvJ8F7aKUAr9GC4HatKsPJ0GTJqt7MWGAKL0lnI91rxaKGr0rYS6Ka4uIhtHbU
	 Oj5lb7pJJFhWvj7D6Y8zBf9yP9/qJt3LE1W+omENyevtGdDzq5JqmXtwrGTikId/0Rukw
	 MSVXLnjj2FXgsXU0IYQ49C2UqBpPzQNU109FDZy0+R22xcaUBvwdf8CQPzajR40Z/hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794201397;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/yZv+FlQaxcsDVary0KlmlSKRtVotcqEgIEwFNW1qws=;
	b=dBDIPtccvU4rHNm8/0XhKTVbKs5sdKMEBaH+QEep/ozKKlMtr+EzjqVNAPH8NjVE8VFc
	 59q+D94oCqiKStzBKi+/PoGWIsvreem5SfGhZFW+8lpZPLGJD+eDSa4XMQfjOUCIBb0IK
	 BaZY0VWcmLO3nyprJ5DlTD/r+N1yta3s75hXgizMuc1D9/0qKP0zd6uU7IXU9Q4FmoBWt
	 kkj8VulW7tPcDr+nSmEoJXyRBOWfsTi+e0LAo9Ue+gDKEayrktk6K88P51HErDcbfkHZh
	 +UC9C1MIod0wpyYUFOiMm2fNHESPEL5ZyXklIY0evp2/6+BpA+0Qj+x0gZ7hzZukt4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mUj4FqfN;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92497606D80E
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 05:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92497606D80E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mUj4FqfN
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-15dd124bbe7so941569c88.1
        for <virtualization@lists.linux.dev>; Sun, 08 Nov 2026 21:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794201397; x=1794806197; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/yZv+FlQaxcsDVary0KlmlSKRtVotcqEgIEwFNW1qws=;
        b=mUj4FqfNDU4phtwngprG59APYjac1Dp1UTOEsm7XOE5QNDR4VtzpUCLS0GAEga3huG
         Kaz8OyGlG5OfzsvXgGcjM9IYIm2V8l11PMmdFi9uinOXJonVNGlMggToA+p0BE97cS9z
         HWbU88mqMFv8dQElpZ6LGE3KoT7HXFbylmtHWcBVxcsL1nyo9lvjAoXbyXZoHoAnLb9Q
         +dhUhrwApPb/b0HpLKtOSn6ShyWqwuOXYJCWy0pi8Ut0kLyXZmgAQrX13WfyX9yrXt3Y
         9q0B4+74h0Tt6zcOOn/UDna9Rl525n1eSwNbC9kKghbIEkIFWvjhbCDq+EkqkJUwew3H
         6HXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794201397; x=1794806197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/yZv+FlQaxcsDVary0KlmlSKRtVotcqEgIEwFNW1qws=;
        b=LSOxvsv1ZeYT+OUXcoRYws6QKg49T9n9tZjxxz/5ZphIrjzl8sXU9vUbLatGwNZwGQ
         DNhpl2tCaG8bhC23LDnmk8znMkoSRot/RelSqI6JNdcsoR4Cmhwp0BtrFuIDYqfASKGC
         hUgqJVDTBxbLSELPuYwKlilroJ9hjt+uniOLPc+BtyvkUl1UlyRuIfRUtqByyVuBX5QY
         N82DA58zf4Br2Jbz/K8MvNh+bLvzrWnBIvMUKB+W2rE3p5aEiAu4xAhKmlJ/RF2lPZsP
         hWSiHCfxRXS1hqUVtjPRACHD0AGRnS/iW/+hacdq3kmjjfry2ytEjxQWEkOZsYaIsCtM
         ExEw==
X-Forwarded-Encrypted: i=1; AL+hErG8giEp+ThCFdxKd9HoL+GXIwtQ/rtqFT1gJrooVcu/P8jh5iEY8p2Xr1m8kxm+ohWOm9Xqnt1eU6JOntaSRg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8UhjNc7v5FLC8MRpCcawxewggp8uufDZohp2QCIoxSK8n/8hI6
	fh/5/qd1DDkOAXEHXJdCWzd162ZEVKc0ubnUEPvoC/8tFiPsMdvd7+26
X-Gm-Gg: AYBFou2WxwNlNpZuMvdUgKDiqSlLpXe06aiMOBq545eN1oGMOCa7yf/M0c2AuwVrC86
	QHscov3aKJNS8vDOs6R+uYn6dlvywWwlQoxs2hj61PXKc6VkSZqHFuUO2s7aRWFbsO9CD0tWJ1T
	gqkKh8xB9eaUp1lyubBRpC6FAdfMwfldWmVoiwXIlP8Zyc5VR7VoP+6AUlECIdiJ9e9CYPVdg8F
	fNrrjbLZ4XxUOF3z7cc4W4mE+1REL0qzEN/LyHodY8T1a1cE33VqGVi/2bpS0aKw+pWLFhT34PT
	2nFSZEKkh1V9qr3bie5F+UEG3jQscJoThjlHSDx+Fjc3N5BBIiLLPcA/7IP9RX5aJ38CP+AaVHA
	P37fyDH3e9seU9156xx1RShJKJeKlr31dxR2pQHULwjkbv1QQflJWvyH+PQWF+HxJvAzR/zl9zA
	3Iow152k9g96I2eRoYqmHKSd+691YvRmiYi2NdDDsk8XAm/siQ+G2vr9ij4NVO8V0GR2waOHhM3
	QBDdYTdla+mr7Kj0bZUydfgSChwhjKxVLI2v7zuM6hKnNrOp6W4o5zVYL/Dc+6Bt0WhqwIAgand
	7MGiInSHFLsBUpSk3Bxc13x0D6Yby2/wAaoMCRMbcQ0BGtIS8DWIL9LyW23eStpn4ph+ENvBZTQ
	PcUWQJ2r+pFWz9CCcYi8UvGs9YFyjU+i9irjWpzYG4E7ov88=
X-Received: by 2002:a05:701b:2504:b0:1ac:91b6:8dfd with SMTP id a92af1059eb24-1b39febe7c0mr4786250c88.31.1794201396615;
        Sun, 08 Nov 2026 21:16:36 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b37314826asm11395635c88.3.2026.11.08.21.16.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Nov 2026 21:16:36 -0800 (PST)
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
Subject: [PATCH v22 04/13] ALSA: pcm: notify drivers after linked prepare completes
Date: Mon,  9 Nov 2026 14:16:09 +0900
Message-ID: <20261109051618.22506-5-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109051618.22506-1-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
 <20261109051618.22506-1-mynameisjune111@gmail.com>
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

A linked prepare action can run the driver callback and pointer reset
for one stream before the other members finish. A driver that closes ACK
admission during prepare must not reopen it from that per-stream reset
callback.

Add an optional prepare completion callback after all linked prepare
actions and post actions finish. On an action failure, notify each
member whose action ran, including the failing member, after moving
opted-in members back to SETUP. Pre-action failures and standalone RESET
do not call this hook. The callback runs under the PCM stream lock and
must not sleep.

Drivers without the callback keep the existing prepare failure behavior.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
include/sound/pcm.h     |   10 ++++++++++
 sound/core/pcm_native.c |   46 ++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -77,6 +77,16 @@
 			     unsigned long offset);
 	int (*mmap)(struct snd_pcm_substream *substream, struct vm_area_struct *vma);
 	int (*ack)(struct snd_pcm_substream *substream);
+	/*
+	 * Optional prepare completion notification. Called with the PCM stream
+	 * lock held after prepare and optional reset succeed for every linked
+	 * member. On failure, called for members whose prepare action ran,
+	 * including the failing member; the core first changes their state to
+	 * SETUP. Members not reached and pre-action failures receive no callback.
+	 * Standalone RESET does not call this callback. It must not sleep.
+	 */
+	void (*prepare_complete)(struct snd_pcm_substream *substream,
+				 bool success);
 	/*
 	 * Optional RESET operation, also used after a successful prepare.
 	 * Called with this substream's PCM lock held; atomic streams must not
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1310,6 +1310,8 @@
 			    snd_pcm_state_t state);
 	void (*post_action)(struct snd_pcm_substream *substream,
 			    snd_pcm_state_t state);
+	void (*complete_action)(struct snd_pcm_substream *substream,
+				snd_pcm_state_t state, bool success);
 };
 
 /*
@@ -1350,12 +1352,23 @@
 					ops->undo_action(s1, state);
 				}
 			}
+			if (ops->complete_action) {
+				snd_pcm_group_for_each_entry(s1, substream) {
+					ops->complete_action(s1, state, false);
+					if (s1 == s)
+						break;
+				}
+			}
 			s = NULL; /* unlock all */
 			goto _unlock;
 		}
 	}
 	snd_pcm_group_for_each_entry(s, substream) {
 		ops->post_action(s, state);
+	}
+	if (ops->complete_action) {
+		snd_pcm_group_for_each_entry(s, substream)
+			ops->complete_action(s, state, true);
 	}
  _unlock:
 	/* unlock streams */
@@ -1387,10 +1400,16 @@
 	if (res < 0)
 		return res;
 	res = ops->do_action(substream, state);
-	if (res == 0)
+	if (res == 0) {
 		ops->post_action(substream, state);
-	else if (ops->undo_action)
-		ops->undo_action(substream, state);
+		if (ops->complete_action)
+			ops->complete_action(substream, state, true);
+	} else {
+		if (ops->undo_action)
+			ops->undo_action(substream, state);
+		if (ops->complete_action)
+			ops->complete_action(substream, state, false);
+	}
 	return res;
 }
 
@@ -2099,10 +2118,29 @@
 	snd_pcm_set_state(substream, SNDRV_PCM_STATE_PREPARED);
 }
 
+static void snd_pcm_complete_prepare(struct snd_pcm_substream *substream,
+				     snd_pcm_state_t state, bool success)
+{
+	if (!substream->ops->prepare_complete)
+		return;
+
+	guard(pcm_stream_lock_irq)(substream);
+	if (!success && substream->runtime->state != SNDRV_PCM_STATE_DISCONNECTED) {
+		if (substream->runtime->state != SNDRV_PCM_STATE_SETUP) {
+			__snd_pcm_set_state(substream->runtime, SNDRV_PCM_STATE_SETUP);
+			snd_pcm_timer_notify(substream, SNDRV_TIMER_EVENT_MSTOP);
+		}
+		wake_up(&substream->runtime->sleep);
+		wake_up(&substream->runtime->tsleep);
+	}
+	substream->ops->prepare_complete(substream, success);
+}
+
 static const struct action_ops snd_pcm_action_prepare = {
 	.pre_action = snd_pcm_pre_prepare,
 	.do_action = snd_pcm_do_prepare,
-	.post_action = snd_pcm_post_prepare
+	.post_action = snd_pcm_post_prepare,
+	.complete_action = snd_pcm_complete_prepare
 };
 
 /**
