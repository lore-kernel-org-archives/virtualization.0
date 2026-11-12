Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794458174;
	b=NhLf0oGCGXcoqVfN41rxJSFS7ygG4HN9dwZ4APmnFyoIplmPL9DHWyXKREHOcBC8mGxf
	 JZ+ZP6tL/zlhBsaKMsdYT+e/MIB3lBhickS2klAxKIKkGM/MHQJ7zXAACwcngHz7zpavD
	 6JC69XUS+86+0t8D9HW+4NN18FczaCnIcxPoP7j4jVImxvYyD67dXDaNWI5yEAS3/+1Pj
	 YxHBVIbyPaQ8VgiwPdz374T0KzxLOvo7ohyPfBApWTwN8s6FM6MJ0YFX+VmaNVKtp4Sls
	 AJYqzfNLueXAx3wG7idq0eEfOzLAkC46KSKbuuyMujLaznoe0KQnBzKTDXD+PXY1ZyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458174;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=928OJa6yQ8fSO4+CgmYur7LQeG2ExiIpndY6iJl/WMw=;
	b=uMOeC9TuCCYQ5oUWMp1cfEuikcLp68KLsRQAz4vP2p2FJWPTiF5dL/V/E0tYKyUskr5U
	 1F8H0Dql13mcmAxIIlPPSFYXrAcq5HukwJ/VTvTvfDJyxQihjgotW1YnYGXMrolsjo85b
	 AXPhq3XOUba6uNl5CxHQFQ3OJOTYFAG314jQnl6pQQgpufjlzCcVIdWEetrwp3xu1+8rd
	 +YoWOMzi1meYnRT4ZxpUCcMKov8kFGwjS9cCgWAPvUmYY9K3kmq0ankYVgayIvXjvz68L
	 2PxCNEcqO2chX+y7mqi2nubIQ+xkmnhgGHlhd/eOm8HNAGZ4+TAPKxHN2dmw1gaswXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zDmMbIHL;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8710B606A883
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 04:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8710B606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zDmMbIHL
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so1838165a12.0
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 20:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794458174; x=1795062974; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=928OJa6yQ8fSO4+CgmYur7LQeG2ExiIpndY6iJl/WMw=;
        b=zDmMbIHLNHfjeLSKV9XhAL3YUEr7siiU8D4KkdnFvJUmErfvi3JVsSKxcbeDa/mlXe
         ceB7fiNyqh/ogpWl0IwZUGwfJMArHXNfiCyR8NGzz5YtINmGEWFGMCT7xwcyW1knx5a7
         +fRoz7fJi03iTTRqTmsbnyhGbjj42+uwSyRgyaud5WfTAST9Qm1YmGScFzPbJfZ9ZX0l
         uNKdZkNzYc+tg4323HclG5xJm8ci8OFBllnOLlCTYJMcRwsbbStx9yQEQxP4Y65+iKf6
         l0vxMYkJ9OHsb3o4wwDMMt0X4t3MU+iRPcrCapfwBno8yzVP72JBlfsbiwE/NRjdYjc/
         zIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794458174; x=1795062974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=928OJa6yQ8fSO4+CgmYur7LQeG2ExiIpndY6iJl/WMw=;
        b=GgJL7dxZ7t8uROFiHDtrLRdCecQXo8vZKEDO+vjA0StJH10sLotolEiLPnff95GTJe
         Hy928pXzybs3wAiW/UFfHQ8ndHfqYUF6fVKU3YpH9bxZJJtbzFHsIK+6mBAN/CCnZT7N
         dP7WV4wdHE8xHWbl6mdLCQa2AFZY+BlV3AETkTdEqSzG5w3RpHqnszYQmSFIwPnFISK4
         gGLj9EsFFDyliOQFIVKrOmj+T3baE+BPo+J2ERBpM+/9qLwQvZuLIcBU2uOIBDJ8oQXH
         YmWRMPyJpq/kaoi04j1xngU66M58aSfOYi2ZWl4o3FrLy+b/5noPaUkgSHtYUVEdCRDR
         6e1Q==
X-Forwarded-Encrypted: i=1; AL+hErEC+Tmp/SeimDSSWO9a886wL49IWx5j0dbcbIy2ZMVldd+JHHrFx3EVb+3sWIyEA9i9ZeCKBx/JlvkItVCV9Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z8MYb0GLcMoD5pBMnOsY1GVFg3Q3WboOgxgoyrXdQx9V8HvB8h5
	nVZ4IQzsW0c8auS0bCM+zsfRsZFADtDFltbfk6xD1JEy5XCp73KBuqqr
X-Gm-Gg: AYBFou3Wvna8PJ0i5z80ii5VfBQG7f/z3Rh/Hk3qfMhhZZhZUbrIVLPN3OT+lBxPnsa
	hUZy6dq+P+GjqSGEhUHnKxzgbq6BmAwHHo/iIXVjEp/yzAJSERw2Z27EKIXWVo938KTe7UWGvvT
	NKHR5q+2X+jER0Y6wrbOu54bIhbYQwwEmCOGJVPHlu/rrmyuQL4P42WrUH+tXXbr7wKFOtOcKAk
	30/pi2mSD9/3xNwrKEuQXvkSWh0L+dKQCSyzkb7NojGZiwcbQES9Mw+RoDZJEjWgZghW+/Ktpo1
	01EsLO9K/kvWqk7SNrlLjnDfo4qACDhdDKOXT5k0r6t9APr8q9X2YoaHPvnJp6VOGLRuXMkvDH3
	a/L9lt4PoBIz/4D1AsAsa8sesNOP9vUheO8mYRXEGcA+RCHFIUidFX2TtSCrnKzESZKRDy4Y/u/
	B+2Y6kIniDwzWKY1EGSF1wYvyhllL069QuCxdTpAcghuR14j0DrjhRvBbldhilVmMnFmW9uX/U1
	YqHfBj59amjar6bTJOs2Ev7+czNHd1hJEzB7V1oKYijg7oO9dWsjwtYs/Z1igIHESaTYrSMtleK
	e6dZJEw8+SQH91jf82vLKR/gIcgAeOTSeOn6yTA3rjj+AoRtqS3hpsD1Bu3jWhq/QrX1zWhgtNn
	NzIyEZIe9wRs3GsUMeftvKPjFoD8YSOnVqLyLW59uB5hrP+MpRZcWLaUV3czHcUy2Hwh5
X-Received: by 2002:a17:90b:2649:b0:3b0:d070:3c4b with SMTP id 98e67ed59e1d1-3b182f235c3mr3670927a91.33.1794458173944;
        Wed, 11 Nov 2026 20:36:13 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c8b287sm2470466a91.15.2026.11.11.20.36.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 20:36:13 -0800 (PST)
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
Subject: [PATCH v28 15/17] ALSA: virtio: reject invalid playback completions
Date: Thu, 12 Nov 2026 13:35:14 +0900
Message-ID: <20261112043516.37010-16-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112043516.37010-1-mynameisjune111@gmail.com>
References: <20261112043516.37010-1-mynameisjune111@gmail.com>
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
