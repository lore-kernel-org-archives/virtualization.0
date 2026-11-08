Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794182166;
	b=VPqXY7n63GhCtfrWjVX7PesmgtohLul6gkhlusoraXJU9H2HaeohgqCY97NhfZe5BOBs
	 w0HBasAx/kSPmJ29w/LKVwyEL4yl/tRKaevq5eMhrZtPuOLl3krIyhnKX8acjmZVbKQeE
	 cgclGJAwsT1NdX3B8igqtD7YkcnVTpbhQoGWYpNy4OUNJs7URnyaQL7oPFFbb8PK7/NY5
	 r3G28I6vxWMa1kMgvy3dmai43QLDNAFyW/Gl/o7eWW+Aag4HolcIpaJ+nuv2/bOTADGaF
	 O1G6bge9LIS66I52AYNT/aXrSmYRYaU+YFT+fzBFYKQs/iU3rLB31Nhru6RGZLnysxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794182166;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FnXDhydnb2ccBc+HkqfRuBRFsa8PxXuzWixMqzpGlMU=;
	b=WgLi70hFzHLF+T80lCne/9h8aRJapr6syV/fQcLM+3Hsysw7IqPFFCHTe053+TBXwe8V
	 V/Zv17HvU7Port1eTf3i6ldZ1JKFZgvDgvzw9q6MPptK+qAAfrkJge0PjQ36IQb62jaEh
	 eSK5y6VriYE4jMxznS6r2io3YQlycBvAbfVuF72/1irkWX0rozDHU/YLeqITYggTHT0UI
	 vXsMVJjx/gqldCvquxZW+gKeeG4wy/dWXSkFxWY8hye5wdFVNQmyWRVnMrsPzTGYMhKnu
	 Cb9JYKLSvJfrDN/9YDbMwYPuyAWoyDadwIx86M20xkDrLFvbYSkj0HnFFOgNBV/qRhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Hc/qZAPg";
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8BD606A321
	for <virtualization@lists.linux.dev>; Sun,  8 Nov 2026 23:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E8BD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hc/qZAPg
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e96502e447so2981275ad.1
        for <virtualization@lists.linux.dev>; Sun, 08 Nov 2026 15:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794182165; x=1794786965; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FnXDhydnb2ccBc+HkqfRuBRFsa8PxXuzWixMqzpGlMU=;
        b=Hc/qZAPgzILXTbDrqKeYqi0EXfwaiOgDehDncvAJlEysOyJNB1lVPcC8TNBtgg4g+j
         Cz54xo6b8K5ZpdYZbnjNHs9yXqjexdewKTt+T61zGAD8RXJajva9YamU8JK5/w0+FxRf
         AtnyCAimjle993WTn/4z+6aVHRMqhoc4Xqtwht7wbWhqhtoY7CneeROoIijZH+a33WM2
         fcbVEvxpVkCh0B+H/tTAABrdlx/4W02yLg1tUWSzEPDJm39QJqbOs3XNAOZB9IMf7ceI
         B6DwEZcCWyf7RqqGaBsDshMZ7M5uidEwRf6nhXLh5BTf8lxMjmTrwE4C6NxuTPzdGbYW
         dYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794182165; x=1794786965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FnXDhydnb2ccBc+HkqfRuBRFsa8PxXuzWixMqzpGlMU=;
        b=MWNrX96jQqOu/FozTLPa6JM9kh2xf0cJToVQHG3j59Bdj1WYL05SesXUEcNkeUZRCm
         rWJbB1I8vaPxq8FJTaCewGgjxpcQjZNvjtj+VOa/blo7kjyulft8gh8fslUvJpyHcf+A
         GWepNnSgaSiaKCa8xNiE6ZZ5zgM8nmEwIr5BQS6i/IKYuXoeJ4EIq+2VEbkS1Li9NGAK
         4JoQB6dAMKEnvHcoZuxQdT3rGFqRufRZlP1yqdYk1v0ZKqm/6igYEs8I8+KXOQjxa8uG
         DPIhVw0qkE5CqjT3xI5dhPy3apnKb0odp8xTHK8cg8oNbYGcCDP42nyZdM5bK6mpuWHA
         aBCg==
X-Forwarded-Encrypted: i=1; AL+hErEj3kOC/bCycalLZO2pLFVOhd0ul8iSbJ/c+UbonyAzdk/fQYhAF1beVyTNSEofuOpVD1P+Q150CaRfXhcBqQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+EsZCwn9vB1cGq/B4boPmwc/G/LXN2LWNav/D7uQsBY7KINacV
	4xHW+pz2UTRyMP/W1UZHYknu/zp+l1Ac33NFf5LfKD8uGzBhPh/kwonH
X-Gm-Gg: AYBFou2cuxl7wvQ1CX0dBEsV0KWI3q7qLu/L+VMjGEJv3BnP14kxs2z/ZFbitzFz0ag
	OCeqsprlu8f/RIRW4xsN9U6ok3sCl7ZJd++SVP6KziNDkld7Exg1/DpgOLHl9HpuW05vN/Ub0cx
	R2kjKGoD4SycmAKGyvE+LILIp1LPEebnIx3t2VgsD+vOcq+jNlKogDsqQnzOchGmGCTu9VxkTli
	ujACc25PG0aM2tkaKGdK/CD+LUbRqRppn9QoWdjxeXnxRcm0TQi9BtnM80eD1/4Wu9eDoLwIdPe
	YQwzEiXHQxAPsCzK0EBsXrlM3OqjtBHscS51ykaibWEipV4scL2cZBepf4WJhJ8V4Isk23IghTD
	My7Za0WwM92b3CIlfLMaS4HT07ufg78zjtJhztGp4RjVtzAp3HBwCq4pzotVMyoFUHFjf/Cs/ux
	xgWzZEXcveHtKfqJ3unUzg8vfaKrRmZoZVPEde5yx8nVUsTM3cx+LTVLk++xGkLBM4TmozRz3wF
	HWpbXcsoWOm7oYMFvl+wITtrRGSCE73URC7B+RWamy6J9cDLM3UpnFeMrAYVQx9Bs+SXRRtUCIE
	Y90a0WAGytfd+zQp55e00slrCKG2jv+aSH7EzK3XVtvdXolbGtn2WBIDTyXG0d88Y6V9Vdrgi1X
	qPcEPQQLXRiGK5jXtROPoqNHop8k/e9FLkOHcTjxdEVE6PxQ=
X-Received: by 2002:a17:902:ec85:b0:2eb:4a05:4b4b with SMTP id d9443c01a7336-2ed837a9da8mr24182705ad.49.1794182164926;
        Sun, 08 Nov 2026 15:56:04 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed81722edesm6095215ad.55.2026.11.08.15.55.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Nov 2026 15:56:03 -0800 (PST)
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
Subject: [PATCH v21 11/12] ALSA: virtio: prioritize staged capture period work
Date: Mon,  9 Nov 2026 08:54:56 +0900
Message-ID: <20261108235457.12688-12-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261108235457.12688-1-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
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

Queue staged capture period notifications on system_highpri_wq through
the common scheduling helper. This allows capture notifications to make
progress when ordinary workqueue workers are delayed by CPU contention.
Playback and ordinary capture keep schedule_work().

This preserves the existing priority proposal without mixing RESET or
lifecycle changes into it. It provides no hard real-time deadline and
cannot prevent a userspace reader from overrunning its buffer.
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
sound/virtio/virtio_pcm.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -168,6 +168,10 @@
 static inline bool
 virtsnd_pcm_schedule_period_elapsed(struct virtio_pcm_substream *vss)
 {
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
+	    vss->capture_staging)
+		return queue_work(system_highpri_wq, &vss->elapsed_period);
+
 	return schedule_work(&vss->elapsed_period);
 }
 
