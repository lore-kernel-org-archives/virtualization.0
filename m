Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793758705;
	b=cxgOnRqGe/ygIfUdVdQopEITrEidMjm/2feQBKQEwflKWin7sUcC2EFWoSphAA5BODjq
	 tkFK/8mZ4qTcrp/jlw91J/E510kHOl7UKztqzbMPSZIE01J1NruLQ3ZUA+xpwTrf8LxLP
	 E1dMG03HbPDjtCJCACMBrBmR4/VhXP691mBXlP9pRl0INyVrHTfW0lSuI9zCUdyy2QfNf
	 Odjj0mIXOFnQ6Uh8vkrIQRiyLDPinHxKHs9dJhmFaA38SzgHhdtlcRn8pY5fKqa5OQTtA
	 5snhHfq8mbbBEi/fPoD9LkNfUDxzocltkwxQ2cd/XH3L/1bbJS1h8+ELbyquB//AJvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793758705;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Hy/84DnLRHSkLYr0y43NMukCMjMkWuzO7+IZ4PjZ4VU=;
	b=5XT6A9bzgIYQOi8bEunA4xt5ljguNOn8C93IjrmbK6ommCNH4SKvQS43PCkqhk3fAjtr
	 BAIifd3ENLCceBQZ52SiPCmAI3XfuInothSZmBIKaser34+BKZ6OOTkJXTmgwHqGPjAFE
	 zWJCjSySvNtsueCeG5tChiCn1uBT1bI8a07dHw0Zodo5sN2xxpYz/HAgM8vd6PgR/34Kl
	 8BBlt4FzQT1yG39Xrt71xjuTiQTKHggDd/6XVd3eVDZqs0Lb0V7v3qNrEYnnF6yh1SzcE
	 S7nqFCK0zuuIArD0o92oj8onAeA7Pg5JVNplHy6pmdAlRr9swT/QnybprVcJJpvOJiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ASNruR1n;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDFD606D808
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 02:18:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CDFD606D808
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ASNruR1n
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc147d86bebso71518a12.0
        for <virtualization@lists.linux.dev>; Tue, 03 Nov 2026 18:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793758704; x=1794363504; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hy/84DnLRHSkLYr0y43NMukCMjMkWuzO7+IZ4PjZ4VU=;
        b=ASNruR1n78tno/Cyfn41pBhxgl9tDC/BcmnN+qyusVyFEYbleVGDBr1rZHhtqfz1xW
         GZCS5v9fFJnAvIMwhGjyP8wVvP+bghkWBd0HZoqMcQG0P3bz15Pj1aaRMl11ewe/4PpE
         8jf4iNL7hfPfl8S3sR0TE3pv48umbaNj4zF56v7SQ8dlQIukOAMatKDzoxWa4iQeWODA
         Mg1PwIKailyj+HyhdNl4Q8SdcFyp6sL++pA98TSRHgJo6kh1Ysivj0aASaf6tX0wGn/X
         rwsQUk5NRP/+VPJxHs1leE6o6v02Rv8stzdyFqyWUhY6nn5zTPi3sWvw541EhUrLUqY8
         NZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793758704; x=1794363504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hy/84DnLRHSkLYr0y43NMukCMjMkWuzO7+IZ4PjZ4VU=;
        b=evhdK4SyEA3LvA7IMjkJ1GArbB+Qy7Bc63eFwmYqCZdoZfTOOsUnao9ERDzAbKkAtu
         +GRP2xIUYm0Fa5ttVbWizWmRULvn+9gttKlzioKIb4aiBCKZlPZF5JkqDe1ikTMiUq3B
         D3M9mmKzZ8QfG0EucRbeteHDX0ZUKe+9MO5uLrUViflU1bYq+x3IrTYBWvJrx8Blhxor
         FR/aWK4iLh0eNmaL3+WlikSKWUp3MfpIbHWXz92ccQFRGjhG2STp3PgqCjak9JmRoucm
         DFciIHPiscyW6UL0Ue9rMQJRx3T94eXkdlr5Cf0pa9Xkm9zEpFU40yCdnKK5oWMjylrV
         JnDw==
X-Forwarded-Encrypted: i=1; AKwUvBwXmX3ogj0Mq0PTsItMrszIfsvWb6Q3GfDWU52ec2aH77aPGKYk1hwyNuJD2QjO8rxSlRJ5TidB94ssUblT2g==@lists.linux.dev
X-Gm-Message-State: APuU4Z/THDv/CbnEQFj83bwuiTS7PEeD9BieGLemV8QTRQXPRofomgLM
	as/f8AX1nwiXZHE6XEdMiAQweLRtXwNyK9f7Eimvv0xQKfH3y3QMKZ7/
X-Gm-Gg: AYBFou0i8/0JZUqQkPCavgOvraBUc1Jc3zVUsLByCO1DAyfMqXwyILNpNXPKNtoPRn4
	ZrHNq4rXrPSSVeHqS6xO3XgFF3ABv7H60iCR8Jjp2d57kaMXzRu6UbIB4LCzInMp2GwpfJ3GSsD
	3VNKxDb2NPl2Dwdfj/WY3c7qXBBygu7a99QHnD7S5Ni0mOiBcodwypHZZCBw+VJ2BRoczBDbGxA
	QVKN5ANEg7QSJhzadUH7zDJp4I16TxPCTuLrA326CJbThVhsRB6DEskmd+V/RFNZ7wt/gEZBfWZ
	DrJUk4ejm2lP1zx4Zo7b7qRX/rvtD+50nTwNPT6F1BCxJuQLqQ5JTl1uHv0nH2VjIKgEmvAEm5i
	ek56yZgIeZSTXs2OjPdMPU1W/tweo/W/jU4FPhMLO9ifWJQnK/6wvwW/imMSXJ1vJz8eoHHrX6u
	iehfwYHS/zA682NnFyJUToo4GgZUX4UZIeAyAGsv5s0zsFxYLsRs/8KOOR7bIxJ0sELaQ53KPmh
	7BHT7/q/XXNEvjEW3uzTxwuF8ChX8IHxlhCm6hrbXuSzlpkW7+v/pe4iysMOOOtcuiMmmpgpqjp
	lhnVzLxN3Uw0qIj+RnY0CqtbXjTdxNwqWI7X7C00AyfAHdq62jeuut+RBYFFxS+F3sTTEO5sAx3
	VCUNFeG0+kETAZVXfldThYd1bW984Aba+IbO0pcELh8VDXEc=
X-Received: by 2002:a17:90b:3c08:b0:3a6:e159:a229 with SMTP id 98e67ed59e1d1-3ae6f0349b6mr11883081a91.49.1793758704355;
        Tue, 03 Nov 2026 18:18:24 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb46326f8bsm346131a12.0.2026.11.03.18.18.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 18:18:23 -0800 (PST)
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
Subject: [PATCH v14 09/12] ALSA: virtio: wait through signals for PCM teardown
Date: Wed,  4 Nov 2026 11:17:42 +0900
Message-ID: <20261104021745.57733-10-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104021745.57733-1-mynameisjune111@gmail.com>
References: <20261104021745.57733-1-mynameisjune111@gmail.com>
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
