Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693328;
	b=YTtaI89oO5m2nDcsg+Yx++dxhW5NNsS7pcFBZ76FrL/b3QknNv+hYAOVR21a0jxC1iu6
	 u9R+XP/Vrf+1R+K+rBiAIX9mkkLRT7YpVld/nS7lH0fVEiyTM7VQRh/Eu/x7d2ANdv+TL
	 fmgvMjkeuPO2veAlzupve1hi9aKrzI060udkGatMKDDleksQgMuYCj7DufNhfV8I9CrRR
	 azD0H82OqMID9oEmH5lvFKmh3iriHkC5eyNrq09pZgthaG4/TYJT85hooVEom8AgzaZJ+
	 +ElOj7AH8s90JkRg6cVoUzpxNUijTqdPAfIVVLBrjE060UeSd2odlqGcCzLI6sQOOsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693328;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=v+nhGD2zjLwLi9y1syT+X5YMbxWrSCy0fEer5oAGFXI=;
	b=lX5jd1ZQ+0DvLGak3tkODKR8gHsGa52DYp0kQElgjtNA0dIHTEvYqO7OHdy0TKHjNVFH
	 nTXm94jNsnBtI5NZoNImVO4Cd+oGQb3WE+3B+dICPXi5jaw/YK2CQjFKM3GjPMp71pPYc
	 thoqnRffp0YbU1xm3qlmFZAPS9mPyDDxwCcE9axiymAs0fwq/CpJd52upXlOO2S53u0xR
	 qh2/Wt1fsgLtGTFCOZZCjpenpVDoIcxafrtTWZFQPrLR1mdPbW5mxKVg0x/I3l+Z45fnj
	 5LKhdun65qWfn6LzJCvVo5ksxGYlkkZm0bjJWILMT1QehM8A8evG6SvVUYQQlATdccA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MlLd1dXp;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C744606D810
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 08:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C744606D810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MlLd1dXp
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-369f33df08eso7513471eec.0
        for <virtualization@lists.linux.dev>; Tue, 03 Nov 2026 00:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793693328; x=1794298128; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v+nhGD2zjLwLi9y1syT+X5YMbxWrSCy0fEer5oAGFXI=;
        b=MlLd1dXpACe9ozc5yRE/1mJxv0MJ4jdqUgMf+jNxwcCs48AxKm7n2I3vQve+B7S/m+
         4WduUV976hiQrt2ZyiQjhMs7igSpS4a9J2bRIfqlldKbkCqFpY0ICrcJmIBE0nXio+Cg
         hvWN+5mVpaofiBJYm3vBAs+3wcTAuSjLhA4xjxn36GfK0fjZjdkxF2vNX7VMFgvF8gvQ
         hxKzk20arEVSYMZOdlhwT0jXku6QiOxtUoyyuz/FO06Ilz/WJdScxY3RuRKsJwXW7tKL
         OQBb3/x/FvllR4lTwJR8rzCFEVWkTR1z7aZC2rDzrLy0Vpn3vjlw4zyhJPbf5BZYjJjl
         tekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793693328; x=1794298128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v+nhGD2zjLwLi9y1syT+X5YMbxWrSCy0fEer5oAGFXI=;
        b=um4EVTqB7nr0kmqyjCzTSWuNCs/yH8JE71sVAn8huJCsTBijtm2xkhvHPRYb/keKkY
         uGh0s2AKKfhTUcBZspquL/ywoq8hLa+sudiJG19M9RRUSAaYBt3TyzLZnult/Xn5ssL2
         LwYB3faleLS8UUE/V32XgED5QCXuLpIvtppgseOuzcGXIyUl5hFGb4LpuP7dVhhUTQGw
         kK+ulOLNgjx4hJH3CpvJefD+qgHHbSGkuXyNXoPdgqPpntEv2/mBeaRjZVMeXGEtaSIf
         2jux2y2ZRz0YDRraUJzOAp0cyadQa18KL7pqZcS0rUMPU7XfzI9y2xce57BTtWdGJVLK
         pnSw==
X-Forwarded-Encrypted: i=1; AKwUvByGPGKFW3EZp+IxVtSRCE0dpZKxIWVXj0ol5zCdahhFmmVLA5HqQn8Tp9A8J0oqhaAMix0Cjb2ssQUacTw78A==@lists.linux.dev
X-Gm-Message-State: APuU4Z9ePNXqDFDWvEPPulyKahVqRTPiG+I9kB9KAnBPEBBqR5ibpi0j
	+kqDzywe8Cu9+zrOrslJHxsS1fYbgqEmn0t4yNI60d7AfJDuO81tZtgS
X-Gm-Gg: AYBFou03hr3CnLkV6WfOUZH/5er5d0wjxKLvuqYFJT1q9N/suMbBFap7jMCqv3qJ7TS
	X5yFIohW0lKK77pP2Xuho3YTiIfcBS2+cBsB4FhaoNlxfmJPqOfE3mECBNOuN7YtrMYi4zjszul
	JKMkQHysiXfWVKbNfz4QrDwHTXu9ZeUS2zPP5s5M9Sn9WO0gmwztMcUQWsuxEqgYOIKSkp7Jf7N
	VRxTvTQnUmgARv9drr9UYr3n5kdLw3ngNvxu5pqqP4658cP5O/YuedyBxYkiuUP1NLNVo3mEMIP
	ge6lNSS/+zr7OK2M4/Ekgudboji7orMtd9TwMMEtk+yweBrispi4FzLzdWistAomWxu84iLWitE
	JMQ1Kpnee0lhLUCHeRZXgSpSuovwTiL+VlQtjjLTUfaOGwuzdpJNoQzlBYY9ViP4ydjwQ+aDnjw
	qQKqMwNVt6wHq5jgO1e+Xl2k7Sr4mRS54H0FDd7fZvoDn8bu3AxD6j5P09+CdYmjES9ZI81dero
	sGqg0tJ2/Fws2PGV9p8btXbAv6g6UbeuZrJSRUDpKAjWspKhtGAR5Rrd7S6TJG/mwBS/CuXma/2
	KEtdY4yhEGtoPLKGUl8TbLM9GfjHR1TK/6waN7dHtMP3s+pMdtiPj1LwhYFN5jTs5Y8U5NR/CnT
	d3gvA5dE8rOgaK3EQB0dhLuj7tyJf8RSOgRDtdOE65xw6gVZWjZOyroGl9R0M5xHlnl2b
X-Received: by 2002:a05:7301:fa4:b0:36a:713:a76b with SMTP id 5a478bee46e88-36a4236a5c5mr20255970eec.6.1793693327465;
        Tue, 03 Nov 2026 00:08:47 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428fa380sm41468466eec.12.2026.11.03.00.08.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 00:08:46 -0800 (PST)
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
Subject: [PATCH v13 06/12] ALSA: virtio: wait through signals for PCM teardown
Date: Tue,  3 Nov 2026 17:08:15 +0900
Message-ID: <20261103080821.16983-7-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103080821.16983-1-mynameisjune111@gmail.com>
References: <20261103080821.16983-1-mynameisjune111@gmail.com>
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

A signal can end the interruptible wait while a STOP or RELEASE request is
still pending. A later teardown may then submit another RELEASE before the
first request completes.

Keep both waits non-interruptible and use the existing message timeout.
Other control requests remain interruptible. Device reset still cancels the
pending request and wakes the waiter.

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
