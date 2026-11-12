Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794444484;
	b=WwkcV5wMVpsX7a25qHp9uz954LGi/oFtEt8roH5usXJxpZNz+qbANByJOAV7kACPclby
	 8iq+glZ3LxT+BsJO4Abl4vog/Buzc3QEcO7hCmhtN4/QtQlRTKtBBE+d9OSB/Qtx7Qx6A
	 ELa021UTBu2tbuvHp2jcLcSvFzaeTELGNbgsJNp00FQ/OJDYDhYUyt8yXYKR1sIOHcbYL
	 +cn7pCFkh8H/ZmpzrijlK2dSuz+tI1awF1TFEhg7XRshcMScNZw7tiMUdZtVZ8X6k7+dF
	 wlwv+skSxCCGzY37nn5c65sqZt9D3lfpG7/DGnrVAsrIC+r47nhnJjQD+XbdziPNT7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794444484;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cedV0+mBiOhhOlmQFuEFj3GrQxb4hXlX2OGeB7wX9RQ=;
	b=YBy/5K6vTt41+DXO+NlsDr2diFVlPYlq0DQC/mwuOEsXqUMoSumXN7ygP0TQaw6aPMZK
	 9A3dHkoAsWuCo2OLKLe/czHlGCXE3kyKMqgpuWcmkNp6ISSmGjbcDDX1VxOBfBiuVNOWM
	 fsvnN/XnFnm4smqijrxfXQfMB9yKJ0io5uZbW+u5/KKG+XlaNUVkESo+NxlfXQQ4mqrdQ
	 I5/I809OrWF0VwiG0Uq6KAjrk96yWPG8s91dL2dUdy5TrfzJuw0sr1h9/JytLtgh44NDJ
	 drGDdKPe98kJL7ICl94VLt6oOpSp1pE64jB8YjGxdXcqcVr6jRvIJn8jI9T/RykzkxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NTygkeHN;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B91606A338
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 00:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7B91606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NTygkeHN
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1931ff67a29so6592672c88.1
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 16:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794444483; x=1795049283; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cedV0+mBiOhhOlmQFuEFj3GrQxb4hXlX2OGeB7wX9RQ=;
        b=NTygkeHNO+j9VrWB4kCEbDtdK9j+/slOfMLLF2xcUd7/fPGZrdMO4vKjV8eKvmbd4s
         AsR30geIxnp+rirS0uabn2kRyIIhdgcKeW9J2kYOEL6tEVeUQz72MfDwxjV5vB9d2TcZ
         qGkDFSo6KXaJDgQktXTyDgN1yOnsz7t3GrY0uMjp+g5vgPDnnNBRSR58TCt2AKdG9nf0
         E4kvu/tdwodlgW5ZDcAnRKnz4AHwKoYp3dONGHmHDoKjMkMNDQOGjDY0d4dLgjRixZC6
         u8ipamCA8hsUt9Dbzg+p1AJHfz99i0gecwHPf7AOWeuIiw1ZdFteD2ibHQRfsY0Kt0HQ
         Salg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794444483; x=1795049283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cedV0+mBiOhhOlmQFuEFj3GrQxb4hXlX2OGeB7wX9RQ=;
        b=ZNAL9lGBzFhLtue4FxFDezZXJScVa+E4HgHklk4sqG2e2UUgNOMU6AW2z34XI9SCop
         dvAwtZPykNvrBrMbluY+MFL9xJk8FGRwbc+Q3iPDSue/jpoJzkTnHXdnku2Xfu5KghuA
         ejhGzyf0eA4svrsDdavi9HZg2Xgk4lilXZ94n1S58Him0q0ptpwMyig3J91EHprjd/yR
         SywgFuHvecsUlZXh+L5M8qFICVxip75kuVPbowugDY/UHz+3chigPN7gP4gRSsJGteqr
         BnnWkQ2z4IaQC3Mz+bOgIS7+DMsPDJz2InBq02/JFswbuIb6OCYaQP+XC4/qPZDNK2Rh
         xC/w==
X-Forwarded-Encrypted: i=1; AL+hErGQjetS380TDQBg1zXJpAcd125SvR27Y7JCznPJowOMm024tu3NsqQtSwWTCLWMTzZ3DgHY2jvQJqaJnkzIBQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8zNQaKY6UPUAD+vhkKBe4I6Qsg/cJvcU6k0AmD7weefQdSHnsp
	IyA/Q64f8J/nCChQ74JEwe/9ZRQ0csVDGghH/j023tkPzpipV9qmL4Ry
X-Gm-Gg: AYBFou260k6LNyuZfBoos4N+q5M69ctzn8LGy6s0Z4iLMGxLGe0sRIH29TFITp3IMkY
	TiGroTFTDfDe29MzqxX66dGsMFx7jMczpap/5pYaTjPPWkn2ICyQy/65I1fW5R5BoJA8sWaw6Ht
	fbT5t3nhpiA7HIjb+Cz+eRFwGEahar/4/zqKOOantvZbRayRPOiZBRENPvOFWcoakMNZaNjIQ7G
	pR4clpZE5nfFgRuX8QfMFgVfySWVSczG8Q8cQpPxpXoxbEzHIlWOjIaLxImdFGtQLLg/Q02ZQ9u
	QPce8fsORVyaJthYwN26R3DkYAyUOZerM+xwJUPjGOpDmuC+MOOWQgnAwP4t/Scr3Tcn0im4Q8W
	vQDk8CTK4FbfRtwlTk52Ic8Qdzfz+I44HCGfk/8oBpghu4VqNOBCIiOG0WxT3xmpWvVEEvbGnf4
	qexsaJZ/xg61WbDXhUuSpGiHoP7UDYpLM8+AJ+veXlked/LQd47SdEd1OqgmOexhIXpHjUjp75x
	4KJrnUrfUoqA0IutZy3fmDaBlx168oKMJyUCDY7dk3ZorGVRWCDaZuJvnMFrUMrVjL2JbMMR7W+
	7IpNYLa/86o1ALn2P6vzPGFViuqT8NQrZzskZovAhJdwF/8kx54r2l6+M3JOsCv4HeTc9wI1dMq
	md5BnRVBZDsXpMNzPQ97yJ1Mx6XQ6pnYcQPVHR2IoB47W+hI=
X-Received: by 2002:a05:7022:1706:b0:1b3:bdd9:cc6d with SMTP id a92af1059eb24-1b3c034619amr3483867c88.32.1794444482628;
        Wed, 11 Nov 2026 16:48:02 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2eeffsm20672163c88.9.2026.11.11.16.47.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 16:48:02 -0800 (PST)
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
Subject: [PATCH v27 15/17] ALSA: virtio: reject invalid playback completions
Date: Thu, 12 Nov 2026 09:47:02 +0900
Message-ID: <20261112004704.49758-16-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112004704.49758-1-mynameisjune111@gmail.com>
References: <20261112004704.49758-1-mynameisjune111@gmail.com>
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
@@ -980,6 +980,17 @@
 
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
