Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793845941;
	b=dGdP+LUypGqCJoQ28dDNGEIUJiJVjozzuIctjYXb5B0ycdwDTCaS0mfuriX9luqAHh+1
	 daX/KXKYEIWtKD8BJJqNjQ8TAATSInwa0e9cRlKTRd/d1rSNxSdIcj8/K//w6x3l/EhTA
	 WlGZMdEFevjPKNg6jWbQlTwnLW+dsmcSzETw/oHbALuit+sy2OP0YAFOqbwn2s/B54uLO
	 F6Vd6aNc2ESr+egL5/JrJSwY/YxAkF8uLlOZYqonT1fNEKEE+jpOYnNfS6BRzVFJb17d2
	 FJaQ2Bta2Qsb6yyFflNjqhiy7+U+NbPOt8hbxArlWxkd637bGKQWq2OCXyv4M5ZyLoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793845941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+MrFgURXGVOlsfMgOcHhXpqYFBlUXyLFf4QG/xpHN8w=;
	b=ilKd/5JD0gdIBJYJtUjVtjfDgwFh80p7lhbmN2kbc782pViXJ8jMLyo1kXN9NosidKeM
	 +EyR4Zy638yXDO0566hLwbT/l5bhQ92e9z+ixXyAoVfoS5jBH5ijzyqMwFGfz84Oep3DI
	 ioO2FZK9LLwo8Z5NE0Svp3cn3w6K0djcgcrhHtXo659jzdzGIY04Kz9Y+CbSblrslzwQv
	 GY+rQ4HNalW9uinAKJ5ZMUOUhXZ6AIsFXoPbeVJo4AWZXFQCqOzDWQx0VekJkg+lthFsg
	 y/IThCOwksv/n9aKwKijJt4m2gkgdZMjbycT1o3SZR1gxeJAoXQ+kuqIP6snu6M258w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CaN0Xnfd;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AEF606EE8C
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 02:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60AEF606EE8C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CaN0Xnfd
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b0b3438540so256090a91.0
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 18:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793845940; x=1794450740; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+MrFgURXGVOlsfMgOcHhXpqYFBlUXyLFf4QG/xpHN8w=;
        b=CaN0XnfdjBa/TlZyJ1sMkKzS7RQQw13c5xDUBuLjf23wRAF2l3CJ/LZgjd0LN1Bdsb
         Hx26gQBQv5uaZ0pITa92CQ89bc+SKiBFamUxq7bOkoLgyyPbB9TKkp3E8fMUZu0WUatK
         drwk3ybEMkUrpzqeKUV7Sb4PpNLWbXhZ5ohrW4rrHfkz+V/xYQtwXidhZR99I2CyNj0b
         GK5/osOFqNafapNcy+AblHAX/3XsYoVEBrlGYqCbRISWNzMRtbKDC806AtW2IGrwpHOH
         Zdx0V70K35uSNy1zzMDlU4jAW7XE+sCbBY9P4HxnlLqJy4Hb+7mcbg5S2vC/bPOlTcy+
         JnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793845940; x=1794450740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+MrFgURXGVOlsfMgOcHhXpqYFBlUXyLFf4QG/xpHN8w=;
        b=zSV2wNyEBQFglp96EQv+3auy8xv7fpJzQ4TY0lIWkYWYZNDpfIFxcLTdRsR5hImwh4
         ybBLLBC6BPWGEUJ5U0s7E0V+o2KUNDO+eURFzWcFJoy4B+clE8DRb/l2fXKcHSUtsDmg
         QMSl12vlezWk3XlB47vchiHTBtkcOuec8n/EomyIKB85/AVT8o/12lioONm0FzlGGopZ
         PMDmqypJqZPLALOUAnBoQcdlmjlYCcuePcEnk+hHECEpGgNHV0GJ6nYKz9Ig08UJzCVY
         DUIQEJhG0qajjtFk2zCrSOmSIW+3VFRL86nfjnZXrm1e+9fj4JEtlPfwC/aeFnifW42e
         X5gA==
X-Forwarded-Encrypted: i=1; AKwUvBwZihdVdc4EoSPVEqLzJkRviyaYaVfn7fvumMtsMnTB92U6RXuNMEeHVLI5BR123m4vlnzkl+UK1mMdbIDMKw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/r6NHmuZ4/laCefC7W12LeJUNscGreKxlmGMLVUe78Mba9tkqG
	aTtVQOn7XXaA7nUqxU05HP6vroz53Kg7+VX/05IWH3hzlE/mxmsiIegL
X-Gm-Gg: AYBFou1hZaAncAWrhsEMwGXBPbJOIXf3unyT6bIOG5KIKmPizLYEGRy6wDYJveAtzYv
	k2STNEvOYWGXinhJEQZeG4TgWv6QoT5jR0dJ0cxZ13RRU5iqLV6PmtxCL8zQvVKQvCJiTnIejRE
	ZwAGVOlJnzCzyEcsa05t6K8YZghKwpwPUC+4OL93QnkKdy08ePPYZE12L5concoKKRmpk325oLr
	gU1Xxgwpvo4RmiIQbBQR6dOQr8kjrVC8q9F9vj98Rw3pak1JiWqrAJnwFiGG6puIpjY3/MFXgCU
	ju5QbxKG0ZYnwMjArubfiCwz3Jz3P8mMbAewD9cHGJ72I6xmm86M9hxmERgTJ0E7Rx6YuUPEYv/
	8cBeb+V0jcB89hrUetKL5cuI6HDDk+zT11Je3k5qWhVWdB/HIcEuyoQwzTjv8lzZ/L3JVBW7f80
	cWHYzemSEWBVKhRIjTSYYbS3WK++2fFqTk+Q2+UM1vSR0DVbU1GycNgoCkzxofL5eHjQlMgkAvN
	kKzIyouQTHtsHxltidx+Tbvh8YNjnLmM8YK5o4vkPZXyuG7rGchpfn7aZh7JZtcBXuNkna/yyHV
	V+1X+qeaVPGvxs+uV8Hk1u63oALqKr1T7edMabWPY/8GUadHokUpROjtr6Gb01H6L3ZiU2k4oN2
	7wxGEgwvfz4EXcXTPdN82NubOxKCBwe+M9AyO07gCj3+6es8/yzF9ctT22bbrqR3AHhTE
X-Received: by 2002:a17:90b:35c8:b0:3ac:9a5e:9ce7 with SMTP id 98e67ed59e1d1-3ae897aa7aemr15044527a91.49.1793845939762;
        Wed, 04 Nov 2026 18:32:19 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b323cd3csm1292775a91.3.2026.11.04.18.32.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 18:32:19 -0800 (PST)
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
Subject: [PATCH v16 09/12] ALSA: virtio: wait through signals for PCM teardown
Date: Thu,  5 Nov 2026 11:31:37 +0900
Message-ID: <20261105023140.18373-10-mynameisjune111@gmail.com>
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

A signal can end the interruptible wait while a STOP or RELEASE request
is still pending. A later teardown may then submit another RELEASE
before the first request completes.

Keep both waits non-interruptible and use the existing message timeout.
Other control requests remain interruptible. Device reset still cancels
the pending request and wakes the waiter.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
sound/virtio/virtio_ctl_msg.c |   15 ++++++++++++++-
 sound/virtio/virtio_ctl_msg.h |    3 +++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/sound/virtio/virtio_ctl_msg.c b/sound/virtio/virtio_ctl_msg.c
--- a/sound/virtio/virtio_ctl_msg.c
+++ b/sound/virtio/virtio_ctl_msg.c
@@ -314,7 +314,20 @@
 		 */
 		virtsnd_ctl_msg_unref(msg);
 	} else if (!nowait) {
-		rc = wait_for_completion_interruptible_timeout(&msg->notify, js);
+		/*
+		 * Teardown must observe completion even with a pending signal.
+		 * Otherwise a subsequent open can retry RELEASE while the device
+		 * is still processing the previous teardown request.
+		 */
+		switch (le32_to_cpu(request->code)) {
+		case VIRTIO_SND_R_PCM_STOP:
+		case VIRTIO_SND_R_PCM_RELEASE:
+			rc = wait_for_completion_timeout(&msg->notify, js);
+			break;
+		default:
+			rc = wait_for_completion_interruptible_timeout(&msg->notify, js);
+			break;
+		}
 		if (!rc) {
 			dev_err(&vdev->dev,
 				"control message (0x%08x) timeout\n",
diff --git a/sound/virtio/virtio_ctl_msg.h b/sound/virtio/virtio_ctl_msg.h
--- a/sound/virtio/virtio_ctl_msg.h
+++ b/sound/virtio/virtio_ctl_msg.h
@@ -47,6 +47,9 @@
  * The msg_timeout_ms module parameter defines the message completion timeout.
  * If the message is not completed within this time, the function will return an
  * error.
+ * PCM STOP and RELEASE wait through pending signals within this timeout.
+ * Other requests remain interruptible. Device reset cancels and wakes either
+ * kind of waiter.
  *
  * Context: Any context that permits to sleep.
  * Return: 0 on success, -errno on failure.
