Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793664270;
	b=jfqotGIM4+4Y1xot8dCt8n9ZauXFph3/wWzUpU2PtRAhXkTEnTOQy/kdh5Gzn5Zsraac
	 YqZJyd7cL6xLhnIcJvI3aLIyQZXhowHbbS+xUMfzpvBXeIiV7/2ffT/Ifd/fWCZtwNKTr
	 h5ZilS0ApjLDg0UToawFObw1zyhRYMP0NfRhlzFFktNrfFFt7WLuRXw+/RY5fcIbJ08k3
	 MhtoMl7T8Kx6W2tMVNsbXo27KpzrDGfjU1YOM6oCqvOVGoOeoe8jpxxL3qv2urqrCJVJV
	 gV4ydHWIY7+cuIpKVe87iFICgLaxSz7dRpumqKc70NXzPa8q70i6SN2XUFLmygEWkuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793664270;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xyRi7XDKpXV1gU6ovNhxbTiviMkA7YCbmNrm8NAAe74=;
	b=SgRJ9azsGVWsE138WuFh+2ruhHpPs/fJWHKb5ntBsXZ0OR98SuUvjarOJdwAPHlD4m9c
	 5G45znO7uJeOTEmt81SpQaol7UqXlZuDqAuUOlnbRd7KJjy908zoU7ZQnmuUfe0SAr1oN
	 vAuELxBj/CWEVK1bv9sfFWBfTwt90+uGCAx6/Ze9gmVnnF5cvAR6Oy0CFyBQVWA2QUG+g
	 srMOHbw1WE93rcgVlFhLdR84yxgFz+c6o399mTmnpjZ60QAWmzuuu+kGXLH03bCwTkwEe
	 iaAYrQL2z0+kM38DxZPUw+pvvG1PzQHqcuc1O9zQuR0JS/6G3oAMaB8FX+4eQfreNhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xlPhxdg4;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128D2606EE83
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 00:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 128D2606EE83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xlPhxdg4
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3acb512a7a0so2238939a91.1
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 16:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793664269; x=1794269069; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xyRi7XDKpXV1gU6ovNhxbTiviMkA7YCbmNrm8NAAe74=;
        b=xlPhxdg4DlGgl3owKFr4FljdWzfyGF4gNz4B5KJKtcAaJPhmGnpkWEQLpHHjTQyn3O
         oU2Y9yjJVfZ9sM50HHS3VL4sswqlLFHW1J+0oiy3eurNAGNcWun3ze1w03R01i2YFexH
         ub+6H1sZz9dvAh0nj0YX9YX8i2CgenD1AlQS5cRNsoG717X/yLvVhiQq3r++i5OtkhKs
         3ssh8V+lLPILTOL9V9LQeTO1AUZeNYg2JSnGryhTatmG4WshGbHQq/lTeFaYgHSsi8Mm
         qX3okKHCWSs3wwvqocoHx/iPd+SECgo6xnGaXuPrgnDp0PbdXVp4uMKKccwVTMRw8WaJ
         28rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793664269; x=1794269069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xyRi7XDKpXV1gU6ovNhxbTiviMkA7YCbmNrm8NAAe74=;
        b=tOLdzST8Nw3XJH5EXow0Hh9JHvOHo+q33pfxfGXZf2uZnFJnuc88CH4jduaAfQvPIL
         5xqjidApE/YzPjBALQ0gHGaIHWOhGYEuwuCpMCk8e4driWjdi9LlVTyAPJwV16cwmQhK
         iN9882LCrO7byRgatYmY7c6bEI0iDA1d+R3MmkbpWH/dr982nQHbC/Y95+F8T8EeM3Wt
         yNOBHyvcFR002xXw1C9+04jmFKabRy3C1kAkyxESq8/+F+XxKJYTxj2d4Hu+AnXkhZWA
         5+ThWBmr71nKMAG0gvxa98OGih802O+XNL3WmYwVnJzDpYtahP1gQ3eEmYk6hvLtH/nH
         2YBQ==
X-Forwarded-Encrypted: i=1; AKwUvBx4SfAwJ/owBkpqywt6nq4XfaStGfWka1G7oxEzIqvAR44HuAygTEg6iuRUpBf0m9zQFZufbfBZcYtXev+log==@lists.linux.dev
X-Gm-Message-State: APuU4Z/hcmn2eaDfXvsKvwIsLURjzwXmxrUVIUIgxfzRS8LjfvAo4/8b
	13/iDWh+a8dTUTkgJ2OohsG5djpIHUP/ih1TBA4JK6yrOfg6Ab46g4R+
X-Gm-Gg: AYBFou1Ur5iefoqbrU4RsXxWlBNX8cjJvUVqmWKY1NcxRaJpkSOcHwFcWKRjq6un6DQ
	7MK2/u2GlFkgCNL6R0ZwJ02/ROV8vLfMhlP6W5PbkA3Y/AyijDMzG3lwE+Auks52vMcMt9hNxAS
	Bvex9D2NRhIe3X1Jpsz3Of2+lG3QDQ2axKsKWFwxc8GITGNkMqOK2GtJFsn5vKuRXo+B6vtslgi
	ytL7SWSnSixfLhdtB4ncxlXD5QLMMD9lbkWuLQlT5FCa+otcM8GEKD+C3fKuVhbJXvxXJSUCb5U
	biztci6DDMCJyLVRVCkrFxN+h3i8UKMbqKhqZbLENP7QxPhQ2R+VbU5CWkidrEn05bbx5+EBgsz
	kFoebIfMclcDIHr3ev3fk9y60ER7BkMUY+ldTX9LlV65nQ8GFTKDRzf/uiREJD+/Xe5zW0Xi52Z
	9mJTHSFMHF7Hq9uzrzsEVyuOQkrOqVXSfNRUdqbqeIjBjY7BOqclFbD0VpF6UgWnfTH1ZXpT/Tl
	CAgk7oGsMDqXyWJOQUYHnRKivNczmyLX7jI0kqfAVO47TIaYWsuWP/RajaS22/gnLOkzgKnA1fa
	sF4leHISwUI+hxsfIfu2Usp22rPG2nQg+JJ8pC9yjd4sJ+0L0J5LIpsWO/6rDq1C0ThiAJhMFaP
	62DMYpgnIub6pkXhjJwyV7fEYTOlHmggZhMMj/ZJNbP30IWVFtD5UBuAbV5MsOTkUv7e8
X-Received: by 2002:a17:90b:2b47:b0:3a2:b16d:928b with SMTP id 98e67ed59e1d1-3ae897a5c58mr9348377a91.46.1793664269378;
        Mon, 02 Nov 2026 16:04:29 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c6b3493sm1339225a91.13.2026.11.02.16.04.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 16:04:28 -0800 (PST)
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
Subject: [PATCH v12 06/12] ALSA: virtio: wait through signals for PCM teardown
Date: Tue,  3 Nov 2026 09:03:57 +0900
Message-ID: <20261103000403.67106-7-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103000403.67106-1-mynameisjune111@gmail.com>
References: <20261103000403.67106-1-mynameisjune111@gmail.com>
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
