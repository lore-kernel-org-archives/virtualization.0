Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793845953;
	b=Z8OPALlWREc6YjWGaCoTt3hijTZ6hVy57Chuqzkb5xyBJSHbwLi8syHgKqy+Yv6tcQ3Z
	 X8c/MU2V0YRCyHxfRSKCU5ktW23nYmZ/JBeIhJJSfKJghNw6ccb8PsjCGC8Dgxh5ZAg7r
	 buzWMZtTKgVMrVgXnCO3ph2WYrA4mGAqsru0PSUCRMNJQtKmlaxgetCQLvQYfdjG9O3UM
	 EFiW6vx/7cMOe1eyy04dIhTfUS4HekwXL1R5rMw+6fbBXs8xRKc6dGJbeK574TsTz8REw
	 afDiocDRAHv4Uzu5U7xTRUNlyWRg+9Je/mOIwlh3r0Qm7lOl+njP61qQgJXsRwbV1lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793845953;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GCeNfDJOwvZXuY8dgM3rlag3FgqE7583M6Aa4tPPS8I=;
	b=47x2wA+33WbKbaFen9RxIYgZjTSNMvqZOb+f9YCSmSb8iue/l6CevjfU3bLzow3oGpyc
	 Mvtk1yWfF7QgnbwjxZ0eZBr2CfDMKk4HatIvdzFObBFu3zN+vUljgZ0GhsosAFFFWsrc4
	 BHPycZXCve4Wxz1RDAC806rRT+87S99/jSzri8QOV4wmI/xnUe3NuQbT5keGopOYrPilm
	 aa04a3a03B5+GzdZgjvO4DEu2EYDK/Wo5REMOIQjYrEC9toI6jK60H6l6i/rcnMO9nNeP
	 0X22LYNbiYe571HsMvrUq2fMpN19FJ2IUcyQc2XCH74jJ7KZe4ckqS0IMKzL2P72F+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bIFhjTrZ;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBBA606D822
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 02:32:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFBBA606D822
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bIFhjTrZ
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b09c07b3d2so801050a91.3
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 18:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793845952; x=1794450752; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GCeNfDJOwvZXuY8dgM3rlag3FgqE7583M6Aa4tPPS8I=;
        b=bIFhjTrZ+qVzJJVJWPYPS5x0JnkUF5wUK6lT+700L5TnzsPLy+25uJmENy7OGcKoQ4
         7PO+GhQKdFgVT5oOLddIpfxlfkO2Fsoe4u8o2p9FVd1TvOQISetqupsjGK2sYiaNO7Vs
         NnnDSuiaxGzQt8yNhw+l17GT6/+qfbHQcPTDSAKLsw5m813z+36uLKaoANHS/3ygbJjn
         LPcnT8ndQSkZmj3mE5KHz8/dvt/mG0vp2X6m070veND7HjsmOzVYVIe6r7lVRrzl2qAQ
         ErAGgHi1xZafFjSrQGJfRl+/1s7r2OF4xYMoUDhwxIXzJCZPn+SVuQ+h03V8rY/ad3CQ
         UZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793845952; x=1794450752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GCeNfDJOwvZXuY8dgM3rlag3FgqE7583M6Aa4tPPS8I=;
        b=VgRiWOYwpVuaKRe1/1sTFQtZiNVNMz+M3kOHjWWh314G17mxzoTZwoWRZYDonHXLhf
         mSlijwMWU1/dttKfvMn+ZxVm3PCan0EhgdYeFYo/YjiNzu+k8jk2gs2gnbt3ZEkKvAsf
         upW4OALLDLWvJA82zlAAQxXV9JIJE4pJhZqUk3LKk+gWutzq+MiNpBCI7J7/El7QVa0l
         EU3pCl4TK0huWHQVxkSeNnMv74jwe8V8smMfmLCzRez1fmIjRYBoLWfnlUqoLZyLGEGa
         snLW0BLprzpPuhj/9r5go2ztjTWPtzS4uemRDkHJD4MV8GVs7nSnge0t53mmI62qwat6
         3gXg==
X-Forwarded-Encrypted: i=1; AKwUvBzhfT9v+1yNBZxt/mrRUfxvUrX2Mct8sxkpFWx1BWASlUvF6CtgidlgNaxnMO+krls+27HOsoLuhcJPzdmQuA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+aVgKP1+qLEYby7RzlH/SeozqMHaPOp1KrSuegl/1UKxwgMFdy
	qK6NeTnHt18Tz64JwxI+LyU9LzWCb+6OvZFU9S0x5MXV5ofZrtkLBtYx
X-Gm-Gg: AYBFou0cT9yAnaT4w2sjDi6si0ZQj3hwYabxQl7OQ++gqfvOC3Mj5JGesvTMCSGe2B2
	LdSm5wdRjfOoo9Lt/NihX5gvDJQC+6iB9nbR+qpp08TPjXcnQPNcZiT89C0cSd7urKz2T8Eo+Eh
	kJmw5Pelm94dSp73LLLDw2fUmtNGlsjxSDytySKXl30FHYbF3G2Ov8NR5v6DkP7/bN4XrxCSycB
	+fkbZWyH+ppbLrqHbEdAM7queTE2aq7nbtov2lbXRopiZ+0SLwwYgK07QbohATszqVS8YxGtAyR
	mJ0DFMasAqeQFE669RF5gQVsUMHiXXoFDnJ2uecjFodLipCPFd3C9lOHm+5+hR6wkA8+YW6usmI
	ZwXVASF1tg2atY1otsIdOkr9riJivO+f22EIQHJqQcMWC1MAvpx/4Y09c2pi7Gwzm2RiEw8bhv1
	Dfxy/39GBo+9ldxvvHRGMevwS9ss5ecHx2Q4xwUHL9CAf7O+zdscL7PNWGGkrq9FblRkngvlbx/
	K0o9m7daYfZc0ZUmJgBItobsOga6dnfe8LPg1Ruy6zCxyaVFkIuGM/dONQmyCNrzHkKhuJKF5BX
	XkpQDc/MjNEKs1fWaX5B6nNp8KVShIPF4bsSPAVUnxtDnvoyk5LN7N4nlfjoa5zpxQaCIhyq4if
	L3likuBaPPO8fCgbjU+CATZEsVqGjPOWk6/irx2BXYjflmO1WIZ6Kudi2QXmSd96mXYLq
X-Received: by 2002:a17:90b:1845:b0:3ac:9d14:feb1 with SMTP id 98e67ed59e1d1-3ae8976dcfcmr14443930a91.43.1793845952031;
        Wed, 04 Nov 2026 18:32:32 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b323cd3csm1292775a91.3.2026.11.04.18.32.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 18:32:31 -0800 (PST)
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
Subject: [PATCH v16 12/12] docs: describe virtio-sound capture options
Date: Thu,  5 Nov 2026 11:31:40 +0900
Message-ID: <20261105023140.18373-13-mynameisjune111@gmail.com>
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

Document the five opt-in virtio_snd capture module parameters. State
that capture_allow_empty, capture_allow_short, capture_packed_status and
capture_pause_restart require capture_staging, and use the ALSA kernel
parameter restriction tag for each entry.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
Documentation/admin-guide/kernel-parameters.txt |   29 +++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -8344,6 +8344,35 @@
 
 			Can be used multiple times for multiple devices.
 
+	virtio_snd.capture_allow_empty= [HW,ALSA]
+			Retry a bounded number of empty startup capture replies
+			when virtio_snd.capture_staging=1.
+			Format: <bool>
+			Default: false. Validate with the target device.
+
+	virtio_snd.capture_allow_short= [HW,ALSA]
+			Accept non-empty, frame-aligned short capture replies
+			when virtio_snd.capture_staging=1.
+			Format: <bool>
+			Default: false. Validate with the target device.
+
+	virtio_snd.capture_packed_status= [HW,ALSA]
+			Read status immediately after the returned capture data
+			when virtio_snd.capture_staging=1.
+			Format: <bool>
+			Default: false. Validate with the target device.
+
+	virtio_snd.capture_pause_restart= [HW,ALSA]
+			Release and reprepare capture streams across pause when
+			virtio_snd.capture_staging=1.
+			Format: <bool>
+			Default: false. Validate with the target device.
+
+	virtio_snd.capture_staging= [HW,ALSA]
+			Enable staged capture using request-owned buffers.
+			Format: <bool>
+			Default: false. Validate with the target device.
+
 	vga=		[BOOT,X86-32] Select a particular video mode
 			See Documentation/arch/x86/boot.rst and
 			Documentation/admin-guide/svga.rst.
