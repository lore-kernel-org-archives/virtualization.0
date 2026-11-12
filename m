Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794464749;
	b=JtFmZTuPigDAVAedzsrP0YW8nNEmsR/1bP7umreDuBPb05HMLXgCSiPnTAp1BRF2dXgi
	 SFGv5HEatwlsVVdhHAMyyi0NiFI7v59JOqORRGJyEK9bXCJHc2fjMAsNIpWRB1f/Jwe9R
	 7EhXKEIVsKed9HnHkWsgI3adJXOh1NXkWR9epGy2mdz+IZ/fdtO7M1Xo6p8cV6mFEVpNf
	 NLho4yfCIoe7ez7fhb4EeSeqYBgBJKvRsGdnQOnqo7ryA3ykO6wOlSfVrpjedOxK3ksJX
	 id0VwCHo9Tb7ktuw0wKqrQaLoYXr8CXyf/dqxkVYclAbiLIE7gmvhITx0miKJmYwhyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794464749;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=928OJa6yQ8fSO4+CgmYur7LQeG2ExiIpndY6iJl/WMw=;
	b=r9t3xmDHtuLnrgDWFZ+kiazOm8+FFBhy7eoRT8ifDHTWg+Ti9KB3HTxaPM+HhFmVQDpR
	 /B8L4G43NDDoWVpRNDTxShmo+43BZBomkAEkMK91M7RP0GROpWkwJ5Qr/9DQ3ne/DcKZg
	 w6hkOAehJ8zCJHb2mnU58JhJTw3fXME36kQq85ddvqiziHC4n2ajNvuMOEvbe57uTMsjQ
	 5yTtQEXczE1+DxPILp77hw++qQX4pUSuUzHTilVBHd3jxaRqI+6A00ndzSdeuSAvOSAJ5
	 V/NZX8qzSekgj6R/d+emi2nCfG4bzjWEBZJZd7kn6HJ0o2z4TDDGzrRZTARBTTzbkZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qWqIxXg8;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5881A60A5BC2
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 06:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5881A60A5BC2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qWqIxXg8
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e987a2ba0cso22766095ad.3
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 22:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794464749; x=1795069549; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=928OJa6yQ8fSO4+CgmYur7LQeG2ExiIpndY6iJl/WMw=;
        b=qWqIxXg82fGRBonKyYGQiBafmsl61LCdc3BIFXjCc/nSMj3udexg8dQP4FbyvI010b
         JqVbdiS7jbg+dl4dMOIcJYpIJ4dhaDxw0xnwrK9y5dfbmpWZmtefeB16njjEdo1HYsAz
         aaXyy+8KQ9ngsbwIE7DpdPsTvhzbGSQhcJ1mFtsdItHibQbvT53+O+EDd+jw4Ywu+tV3
         3sczju61Nhtff1wgFvagzhxfX3K/Bej+2DeveVA4xrF7YGluSxIu7rT3S3VdQkMzcez+
         p9+AXKfHT7Y8w/BVuLQ8YePJDesOVVBme/Q10uNOyYw0IZk5pOplyYFtZzSBJEMAbDjh
         axyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794464749; x=1795069549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=928OJa6yQ8fSO4+CgmYur7LQeG2ExiIpndY6iJl/WMw=;
        b=fl/hkMP8pIh97Bkl8SaqgQc8NFAeCv552gKUCiSFarNYgybUKEI/zB/319CtZ96Ekq
         /vmBmzDwgnn2JeFsh5o1XhbPBfTt0NbPNIV7YDU5jdVCCKUCmAS8NENdy33/4U7twmPt
         y9yu4z053FpTYuFOw4lz9bRAeFoErx4ZA5nUP04wgZqlDRN/xxi2bMBOZo9hdo7fWte2
         HBXArjZGSEAfYrFWVB//nDztwDaY24XSVAV4hPWR+QuqrqaCuRKIAO3o83mhUk085gjQ
         EraGrd/dINwbzUUnnwXyP6nq7IIXufL7T+inCwzZ3+REScslUBkd/mj7YE2qup8dBJZc
         HxXQ==
X-Forwarded-Encrypted: i=1; AL+hErEKRYwVg2rp5RSukh82KAXvP69HBJdP9pkJN4RZpsbnq/yNPfi7t0geajHVXROgFKqCt/DxFilB8LeMTG+6gQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+8K8rT+4IUgW1CVTr7iIf40uHzu8fNIp2iTGHrRHEOPBaqO0Xr
	e9h4xvjKW8+Jq+w1TRZ3fDYFOystNnOZbrNnM4Gr4+FDy8jetvtxa+i1
X-Gm-Gg: AYBFou1mmIon4Qf+kdG/Y0r9a6HQ/DtITuPgDDW8m+xTqlejtJBkvMuTeIWMSdmAeCJ
	owbUxDi4jz03kTzpJpy/OBeaT9DzN5+e9Mko4Y/fPTS8HrzQ/mfUUqbmarO8za3UExhBlOOfKZ1
	dEJAHbRbZwat8DkuPQyxwK8lWxr15c1sOUegVCX+IHhwAoGICCWSkvre/ouPVgzRw8EXbJtkPA0
	Lpja3HMXi+/jYfDlbnFh1ARLh3HUYU6m8Ht5CfFBYAD6VeR9tM1nozwR/2suNPk7ZyTApPo2ow2
	bNxz3wi5kRtTCpzQDdkQ1+T5WqL6DybnLQj2S+mphSZTgwpJoKvjmCxg6sD3kX1YNHnnyLKT+2T
	2UDzkRLux6k3dDqrBUFcA5dUlCLgS5vGSgXmBEer4G1ckbEx7pKmZ2dl4WhgYKkYlYP8TQW0rn4
	jJVbUU4xOqnNOrj88I6x9GOE4iLHXskkwrctsJx/UB8mGii2QlASmp/VODTisGGBYfBSE69bxbP
	82QUjgTKp6v1SGSSnvbnHmgkng8OIbZ4ecVGregR0md7unRrc5lU8vT6JWX1NyhKVyJXjglpDQ4
	Yo1DbjVF0wd3XvN1ubAx9ki/2qDNt+xcQnrDWmjigNWZWO9PRODBadAa9/54qMjmT/wVplOHjB/
	eGoQ10abJq3B04tdJO+TTANq3jxVNnNaekMk3r2qdoww0KCE=
X-Received: by 2002:a17:902:ea12:b0:2e9:6352:6c61 with SMTP id d9443c01a7336-2edd76c1e80mr55285125ad.19.1794464748634;
        Wed, 11 Nov 2026 22:25:48 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6a3e61bsm26979965ad.11.2026.11.11.22.25.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 22:25:48 -0800 (PST)
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
Subject: [PATCH v30 15/17] ALSA: virtio: reject invalid playback completions
Date: Thu, 12 Nov 2026 15:24:44 +0900
Message-ID: <20261112062446.159-16-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112062446.159-1-mynameisjune111@gmail.com>
References: <20261112062446.159-1-mynameisjune111@gmail.com>
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
