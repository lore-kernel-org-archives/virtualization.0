Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793923640;
	b=pk6FkdNc/L3dpCYR/TpzinTaLcV8klG2xKucWuu1W/8eJ7GksK0IumpBKQtOtdgy3UNe
	 vH4ITIaaIpNRsyGDohVP5ULWiXJWhJKN3SAVxfg+uK2zUye3gYAwwLkpku2AL0gJB/il6
	 Y2LSxHhn3J1Qw1xfHwQk7GnPrtR3i9LTpH/7Wvz59YeKAdm5xR3ZtxE4Te9VzC2EPuFvA
	 ysgTatn7/dIfuesRkzpIA1nA/wWqR0IofJ8XUtSJjlBBQCLUQc65skumqWdkdFUvXLGO+
	 f4j7W7QgdN10ALwrxQ/qQk3KGkdU9w6FF9+Pm9WAOr8vrUh/wziUlIoJ0Cf8micEj7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793923640;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XF2VmCDJnpXIgiFaGUBtPdUTCN/KhchAk0nVPRL7Ydc=;
	b=O7ecEcIhIr0GEwx/Xz3FSk0T7hkVTNqCdxHuQp6/id3ACBVXqrizU1q1d56YqGZGDRYy
	 1fb8M1jelkUIllZJoBKCZ7ST8D09n5xR+uwz5FPD/1KyG9nEGfR/YTLprS8i2adkzWW3q
	 ggq35H4HQ7TN1RxfnLGBJErUtgCKzVg04JfGNDwrBFqhJVs4bZqaauQs+GKvawGwqgqEs
	 eqJDBMN7ItXwnzSN0H3CRmbsgBTXmKqh8RkftY0qwBdtX0HRblsnqsrKHXxNP4yGUiFHE
	 4v0h4KZnOtZ/ShZLJELu9BBFqFmG6LPEdnmwlre71EuXlb/gQLKBm6b+Svxxqc9wvjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DyqBzTc1;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C13606A338
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 00:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59C13606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DyqBzTc1
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1a2af4c8d00so282040c88.0
        for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 16:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793923639; x=1794528439; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XF2VmCDJnpXIgiFaGUBtPdUTCN/KhchAk0nVPRL7Ydc=;
        b=DyqBzTc1LjMmdg2kX+xeZwj9jQOs1/8QmLQisDr25HP/4BaC41nlKN13NgFn/vzigI
         KIoGknfD0dyZi/jyQmB2fo13qDk5EEHIIXRTLHM1Y0/jpSSMJU/oHD+N7auHVQWHPmNy
         9V/ejH/I0y0DFFZY/P66zaumsGOWkb0L7czar/cEjpLIYNptD9kEcnSuiRjd1h5mVH1A
         SaVvHS7OkPJdmABQBbHbI8Cv2uiYdu4Ax9exkTa0iBasSi2UYrAQ0fwANDmIbBm/uCwc
         NRd/XwdS4Y0WrijI59L77D+3CwGny0LhSbDHUCkHxPz2U+zqhmp9Zo+9O1otjo2iOu29
         jz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793923639; x=1794528439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XF2VmCDJnpXIgiFaGUBtPdUTCN/KhchAk0nVPRL7Ydc=;
        b=kpmlw0tB1RbPPWoCpPG+bL2DumyHllqPg7vwVXPrkBVu0DWz8ekFyPlkLFCmQMN0FB
         OYhoxasGkpt+VX6yBZw23xxTnh+Kl4tkxtKVOVkenIGq1OvOlK/1MjfMblIh5LsqSQN5
         i7fGs2sEmKP7gxdD5XrVZy4S8awlB+IajIjVXbF8BNwISZt6lRX/rnJScFUB+DQz0W/r
         3LPblan6yWb3QtrubujOZrThkhBIZfsaaJnkSoL0m+a8MZ7eqt3uoBV5fEHTYM3szA0A
         ynv4ZjJxzaa4YB4IwUMjBvDhChM6glzdTzi0ESHleaRwbXOC4Z1xCyZqoEDDvp0Y2SJ1
         EGeA==
X-Forwarded-Encrypted: i=1; AKwUvByp3pJyNF4qUjpFFvKwodNo2iDeCb8ROLQ00Pz3gvz+OPedPUyAr1b4Zy39cO3f2zgkA/o5pITEAPNJ3DFQKg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+PoP82eVO9TC0QjSc8E94qyIbNilwzeeP6AC1g/EploW7Bsj+c
	4QTFa35IeSYMHur+IMvBCQU6Yq0EPvSSdinZZaVujnSxfXdEoPT7w8Na
X-Gm-Gg: AYBFou1chHotRmHkMSW+SJBtMqPHIsXUfDs34Dy3QlyR7CNLa9O9qThXOkztqGS6hxr
	TjWEjv1UWjriPxsCbTy+S7gmxqd8VjE4fkZktIa+2ftVv2ix0Hf3UTmfT2QmWFgTm6Na2fUIByc
	4D9x3lh6hqLrlC6jpHBoGQiWC+SCd4yYxQVv7zTACGFJB6tPdlOCSErDkvfqTyXk69ecmS9IQMQ
	RevuboAAAWKGEM/HunZ/2Qyhe2/8RtQk/7UkWFGkCTWjDMRXOvjgY+NQJHtHbwVQtQQsDVwK3pk
	WLSaU6WEx0P8lOBO/kyD7xk9/f0Dq0K8TGKXZfwkvIZEvDz+OZuvass0FucUzpWLth6z0ElFbnX
	uXVh2MxdLH7IL1qfSbUl5pm7GLBrSN10j9HMv6ahmEYQu+Te7fHS3m/gHqsr0kWHDOxutgtt45I
	aQMyR0Pe/7IsP79ZlXhYXDw3XT0Pex71Ry3guX8PUp0TfFOQffqjfvuS46j5qWHkzaahJaZ6Hhr
	r83AfxMj3bjE1eMIHQLxP0I8MoJ36EIY3FLW9aA8sVmo0L/lnxKfGpcAetuVTa1pxQ5i4ag1Q1b
	IF8jysOrRBlY6MqIUWdDAghWp385kilCXS/+sRYMtidUzWmnyAXwDDcsic/D3uOYtP7ZrvbZ/j6
	XHlhDGA4NZfGmMn9kBboTczIwKaQMmc5MNxx+kgUtwEs4K1U=
X-Received: by 2002:a05:7022:6983:b0:14d:baf5:c415 with SMTP id a92af1059eb24-1b25d30ad8dmr1158836c88.7.1793923639260;
        Thu, 05 Nov 2026 16:07:19 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4e079esm371165c88.19.2026.11.05.16.07.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Nov 2026 16:07:18 -0800 (PST)
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
Subject: [PATCH v18 09/12] ALSA: virtio: wait through signals for PCM teardown
Date: Fri,  6 Nov 2026 09:06:41 +0900
Message-ID: <20261106000644.20460-10-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261106000644.20460-1-mynameisjune111@gmail.com>
References: <20261106000644.20460-1-mynameisjune111@gmail.com>
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

Keep timeout and wait results in the types returned by the kernel wait APIs.
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
sound/virtio/virtio_ctl_msg.c |   19 ++++++++++++++++---
 sound/virtio/virtio_ctl_msg.h |    3 +++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/sound/virtio/virtio_ctl_msg.c b/sound/virtio/virtio_ctl_msg.c
--- a/sound/virtio/virtio_ctl_msg.c
+++ b/sound/virtio/virtio_ctl_msg.c
@@ -265,7 +265,7 @@
 {
 	struct virtio_device *vdev = snd->vdev;
 	struct virtio_snd_queue *queue = virtsnd_control_queue(snd);
-	unsigned int js = msecs_to_jiffies(virtsnd_msg_timeout_ms);
+	unsigned long js = msecs_to_jiffies(virtsnd_msg_timeout_ms);
 	struct virtio_snd_hdr *request = virtsnd_ctl_msg_request(msg);
 	struct virtio_snd_hdr *response = virtsnd_ctl_msg_response(msg);
 	unsigned int nouts = 0;
@@ -273,7 +273,7 @@
 	struct scatterlist *psgs[4];
 	bool notify = false;
 	unsigned long flags;
-	int rc;
+	long rc;
 
 	virtsnd_ctl_msg_ref(msg);
 	/* This reference stays with the queue until completion or teardown. */
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
