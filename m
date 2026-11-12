Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466233;
	b=Z2+lNTvI+x9msOZ5BDk9CheZeSpQ/VPvNeu7lvfgd2WPqCBacZD3RVfoo9LxqpEcq9a5
	 m/VuvsbaNRYNpb2Bo+HJl+KXapQ9TDFrcJdwqAiUnbqoQ2+9ksSHNejniMl19GGO/qfdc
	 iDJ4Pr5H5XlvAmdcdEaCLUbNY7vP4t2Iv32ChhzIyISjGW6ueL2d1Av0flVB1p9+zcOZs
	 Rx38dUeGFhb96w1cj8/AxQVVnB4D3iR4JLPyNSTFg9HYKf72F3edyanw1uEGLHWX0V4+o
	 SA6JL6t62BbMCoaoR0I6TNYjd1QoHWaoyvJFDzmOzejMvJx0fN0vsq6MJlI6QGOS/Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466233;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=928OJa6yQ8fSO4+CgmYur7LQeG2ExiIpndY6iJl/WMw=;
	b=uBDcErANxZ7PxEaqAzBUc5H04Nt9eUxyl48QWcnvvGewsfqNnUyXdglNyIDck3HQd/sZ
	 YFy5j2LspiTaYFgxqw0JBP7c7robY7ag7CKDCGQPLGyYf1tx4PYd4nwb2eFRS4331Vr3t
	 qV73rwgzMVws3M2BVPhkjEUC3F2H4HLMTT5A6VXWjH9nMqtL3uoE3lTQbDIY23178HN4I
	 Yij9YA28iMymV/bGNTw/X5Zmxl/h9T0fmCJhHP2Hna5lRCPHFevbxcYli2HGcii/ky1XH
	 8Jiq4rm5T+jF8Mup5RU/nzpfT1SPuLPYnovMKYQ7r8oSwWSglgdfANShhRtsArJ+ErQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M7T386WS;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9576606A335
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 06:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9576606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M7T386WS
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8b5a6f2f27fso1562587b3a.3
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 22:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466232; x=1795071032; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=928OJa6yQ8fSO4+CgmYur7LQeG2ExiIpndY6iJl/WMw=;
        b=M7T386WS3nxFafJlOqEL+ezHfXJPX0hWDBXe/xL1JHRW5fKwfaVvLd+USSk612AhP8
         b9IFWJXq0IKWkD7LpfCOowaN82nEsryg3qnGp4S2PjxeT++4EvqJkzVocYgfDrsgq4uy
         M8badMbGN00TCh5jtUyjeo8cFJg4lCVnZVdYDOsQtG9+iwmUpbdcwNcqVmkb5qmidotU
         jAyrlDaeqzxp1t7pj3+z+BbGGerJncuh/il4f9P77Jd7LPrH5HVeCFivGsusylXsVOYM
         7H4qSt0vzoxlc84ytKzl7ZwGOY//oSGkO/yr2MwUOuBzh6TVq4hUpD2z4TtiWF7ssZ30
         JkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466232; x=1795071032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=928OJa6yQ8fSO4+CgmYur7LQeG2ExiIpndY6iJl/WMw=;
        b=1o99nNbefGOQ+KCDuvRH/5IYFwKoRYrxJCUa7eCn7pMnEAuwSDJ0QbTPcdMfmekHsr
         xmGM+ly41O0Nr4laQpoQkkuzVhIgSPX9Fh0vNqBiG6zssJq8L05nUKZPYvB56yyJeJf4
         fd3VSfjEspnSgmvL0EawjmQQpkrbtW1FLsPUi/a5i0SFSlbTWRmgZzFM1/y7y6DN90QC
         FzMcDBwrSk7EQKbX5nxucbNC5hu5tLpOeIDZwfyoM41QwVJQut03InxexZ1zRX7Mlurx
         278i4gRlAilCxa1Nft6y+Qld4KSXV28q/S7Feuqo99tZqdYbdPfjnjSOUu3vzztZXCrU
         zvfQ==
X-Forwarded-Encrypted: i=1; AL+hErEkxLgXsAr+Pu4zZ3KkudcfZmt2qK2eHOUOoCOOa3SY9SXFRomjl/p6XZmvFIkMNMcFzYnTF4Iy2M44P2AkMA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/+yRyPf+d9d7zSmAJbvjZVLEmXqP1L9Q63NWaLg1A0C0tY6J+J
	YOJ10D3VYxdyGAnL/s9Fret9UfFIO9J+gutGIQQ+OhFBXkWybfxq5ZBsqnCRjw==
X-Gm-Gg: AYBFou3EEle4Ufh9UUaJDDZBkn1364XhUg7vQSz+9+gxwfnmIkXMogm3bOkeUzZYef8
	PupJ0Qq07xyYuepQhXknhJChyh9cP9Z6GuNF7pr33Vz2QxSBBbXXJ7UVyl/dS1qrtMdAR7qFrdB
	L6qXX/zE093e3Fauba+ASDpkmyPQJr83sCv6olY/3os5ulbrhQ4fFLwuARawtw5vqmU6T+zD/6s
	BiXj3qb638THXfjK7BhP2vCLpGDM+MehjEPjDO7eNJ43QfyktHIUoedmzfimHlm6VzEvy8aeYT4
	FY0KtPT54hIj6ns0JaL+YR5PMBz7D1y4SbLCHfPgwxsLauAtE3eYRsdsKZpmcoDol9IM+PzrSFR
	9AyV0sJBv8U9amze7BlDUtoE3TXmmQyRf3CvnhFtmzaQXUhiulC4Qbf07uSVY5KFDB1SdHLwrNU
	7v7YA5OFjM0zimkS8Lc4EK2/MK3j+VQMm7NthPsPFUDbvl9N3qS750QsMXAotUTACshrenqmnaT
	0XuhfkoO7AXKc6otrSXBfGTlOiO6t1C3n6aNE5WoZXKM4qfnckmvmsBLzLdA2rJvaL6c6egigZ/
	XfHAsgplpQDMjXLG6ba52Mo61xByDkJ9ScDPvfOFlc8yGG+LFgncuCoeorUrdYr2dw7lbDb4F3g
	RWONw2P2fNaDl7+AOI+Dg3NjmVJH7eKhNt81vmDldQSexAcg=
X-Received: by 2002:a05:6a21:4ccb:b0:3e2:3222:2559 with SMTP id adf61e73a8af0-3f2ff7cafa4mr5180122637.62.1794466232303;
        Wed, 11 Nov 2026 22:50:32 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab1228e2sm3097511b3a.41.2026.11.11.22.50.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 22:50:31 -0800 (PST)
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
Subject: [PATCH v31 15/17] ALSA: virtio: reject invalid playback completions
Date: Thu, 12 Nov 2026 15:49:27 +0900
Message-ID: <20261112064929.11211-16-mynameisjune111@gmail.com>
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

A TX completion currently advances the hardware position even when the
used length is malformed or the device reports an error. Validate the
fixed status response before publishing progress. Retire the request
once, latch XRUN and schedule error delivery while preparation is
active. Keep malformed or failed transfers out of successful playback
byte accounting.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
sound/virtio/virtio_pcm_msg.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
--- a/sound/virtio/virtio_pcm_msg.c
+++ b/sound/virtio/virtio_pcm_msg.c
@@ -1011,6 +1011,17 @@
 
 	/* Playback requests point directly at the ALSA ring. */
 	guard(spinlock)(&vss->lock);
+	if (written_bytes != sizeof(*msg->status) ||
+	    le32_to_cpu(msg->status->status) != VIRTIO_SND_S_OK) {
+		vss->xfer_xrun = true;
+		msg->length = 0;
+		vss->msg_count--;
+		if (!vss->msg_count)
+			wake_up_all(&vss->msg_empty);
+		if (vss->prepared && !vss->preparing)
+			virtsnd_pcm_schedule_period_elapsed(vss);
+		return;
+	}
 	completed_bytes = msg->length;
 	latency_bytes = le32_to_cpu(msg->status->latency_bytes);
 	vss->hw_ptr += completed_bytes;
