Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793412572;
	b=hftPOKeGmgNejmfhver3Z+yCy3MdRw6XM9YUJFfFr0zwJHZAYpRmhsuFfkh28GlmTskG
	 QsqrFazt09U1cBK+x5SbgvrjJNkN4KiDNn/N7TyOTBeHndrDe9B/iUIprn7r7hs/YI3Qj
	 20VdTofrFf651n/MoyJmie/y/4myeDVdnbu2DhU8I9F9gDPZe4/PKFapHRdFVdx3tW+E0
	 RiB205g3/dOd1sAzM1TW9rcY5a2CUWDkcygpU6ygCJB5v5oeDOG1rLXbrvk/Y4AGgGn57
	 0RQ1yLVdxuq15bo0SEOhY445Y12CzEMo4fT7diWmj+p3xemGoGGx+5w2yCNDb/0d3sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793412572;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oVOqK+dUFrJ/HwUxLGBp4tSHQgucC63Ybu+Vcv9325E=;
	b=qcYuJjl3ackpXX4hS3VjbSTeDHsNcU8H3mK/OgMYNHDAI7i3Qe4jSJ04q5yKUWawMQB5
	 y1lQRY7ZUyBK9pwbQsBS6DnPdOGkBX19A1MZEv4FCxvxFhhJQR1Z2T3aBGJjpFQLthlI7
	 OvJR+QMANIrMAUbLAD9iDKHUGVe5YhIGbjADGSQTMZbGW2KA1ARP6i28iOtfD8Zrmyge4
	 leHjm2QJp+uEYlcDt0X2W+q9L4fdyxUJizVM9q19KpV6nxtKoiELbH1q0LNXUnCp51DK6
	 M9T0G+ZT9LpVPxwKhYw4GPIq0arncIAkWgsv4nHEzDaKkkrNAL0Yo8JW2jarKWmsbWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pJQD1nCN;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0F3606A32A
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 02:09:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C0F3606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pJQD1nCN
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so1917847eec.0
        for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 19:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793412571; x=1794017371; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oVOqK+dUFrJ/HwUxLGBp4tSHQgucC63Ybu+Vcv9325E=;
        b=pJQD1nCN1cFbFnjJ+rCpj/+n33TZUDfZ9vTmJMo0Grn8CwmBfiKphKTpBxzAkL4pWW
         TSGhsi2NdXFPUMn29rHzVKUDGx1RbZb9SEUJT1hnuhNyhKic8LnFtzpleKgc2F1pROQQ
         BuoReg+OES/cvly3dozAl4tOzJkav8h6H/5nGaofWykCQmgoqIu8iXbCGASxAWbp43uV
         ZIimEcKE0F1nLfmUkhWBw104zq1fEP7CrrsUJx1hUOxQYSn+qhM1IxWygOATEVjdBLdl
         qu9Jb9js7aHzIPP93CCSmJpmoz8bzZCAh+QV6Kng4q19GZ2FBamNa0UrMucPDCgccua2
         QNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793412571; x=1794017371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oVOqK+dUFrJ/HwUxLGBp4tSHQgucC63Ybu+Vcv9325E=;
        b=wdxEFaxSAeI1w3E1PNTUbaKPkJ7NNM/apyP11pky8dClQJUGtCxoxag7oJJqfHbRQY
         Su2wP8/t8ttcenTxbBYObQWmSMomwQ0lg0K7okCe3LFl6Xg+hfxaHRQqmAHQTS1OzWbr
         gNf03pQjuyMRxGIXu7B1sMC3YPCn5WNqV44qAXlp9LXxeFP6QQAs3GzIZnLMfJVQg6SO
         xVc9+6cIENc/eppPdR+tUAB6ZTXASJh4OGDr52koDj7w3PK38lI0FTs+awlBD9iUkinv
         XC0F4aV8/1zadKhKKkeiDFxw3hspSu5qIhSGeyftnhhwlm+qeNQAwkbEdvZzxT4z7uAy
         IOBQ==
X-Forwarded-Encrypted: i=1; AKwUvBwhv5yYZWRO1suN3VOD8l/0cpaDD0RfyRRiFH7arGubZExGVhjPI4NxnKM0wbC5B/ECVlX7Da8ypI7E/fNdTA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ+uxHwj4NTzJEAUxNOEx7uoTJnOuFPh+mAw1533pj1aNFBNDqZ
	bA/P3vP+i8uIhysXtwHW5v4nOy/Rnlcj/AJvC6+lqBSPCFdZfyfj+Ad3
X-Gm-Gg: AYBFou06jedHbnkDlKJU6R0aDH7FeW54mjxgZp6hRJhbQUnZUAe7+6JoinojpFbW84M
	Wxm8ynEuhpKp6CKOFY1BnrgWIPx5TXPz5fsjYcHvBtCt6l6BvnxE9gMShG/kUUZGeY+LDEbB1f1
	/eD/vgbwCVMbBJHuT9BcQCOb2CsuGIvsDYfr8b9TMWckA1taBD4+gh1j/tM5jJvC/ikQWdRJHjq
	ncJVJgLqQuljTgqLKcQmju2wEKztZC2axEoayQhtMJj+g+9VRFHzecYA5BV6LBTguXxG74Q4S/I
	GUc39CCLXc95fsreV3YvLf/hxehgpFIdmg3uaeaMFEa2GNcrRtOFc3MYhvsK8HCary9YPfw7w6Z
	PiUsisJ+uJSs1F/Ne93oVkIGbscTIneS5H6I4Ft7LuusVughZrxKAluPcxKNzMbYZRmosG3DyIg
	przvcjKkpvYlpQyHWEbx6Em5Nm1gD3zZYZcD6s1XEAQt/nUG67tDbiv6BzD9Mey2CmfdT7yht1U
	1MjdT/ob4p9rh+YqHchpsrLCLnj9PBmqj9e3IByP/Y2DXNuYXevqHefa5IAf/MVxe2c1kbQJE9q
	fYThJXmnLQbfqm6nz2Y5PujKCOTOaLBEEFNEvxSgGhsVIh/CdZ8DtqELzZs/40FA3brxlN95s62
	62jncMP+qdt0NZj09MmOBn6RgV35NKlTuhEf8v/QYs4FjQ0+v5XW8j6dTUeUmHzaPsaA=
X-Received: by 2002:a05:7300:f285:b0:367:50ee:f7e0 with SMTP id 5a478bee46e88-36a4244116fmr5219036eec.39.1793412571307;
        Fri, 30 Oct 2026 19:09:31 -0700 (PDT)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a77c0dsm13214096eec.26.2026.10.30.19.09.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 Oct 2026 19:09:30 -0700 (PDT)
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
Subject: [PATCH v11 10/14] ALSA: virtio: prioritize staged capture period work
Date: Sat, 31 Oct 2026 11:08:51 +0900
Message-ID: <20261031020855.2402-11-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261031020855.2402-1-mynameisjune111@gmail.com>
References: <20261031020855.2402-1-mynameisjune111@gmail.com>
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

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -161,6 +161,10 @@
 static inline bool
 virtsnd_pcm_schedule_period_elapsed(struct virtio_pcm_substream *vss)
 {
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
+	    vss->capture_staging)
+		return queue_work(system_highpri_wq, &vss->elapsed_period);
+
 	return schedule_work(&vss->elapsed_period);
 }
 
