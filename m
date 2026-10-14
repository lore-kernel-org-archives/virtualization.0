Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC1C377A8E
	for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 03:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791948649; cv=none; b=FiAT3VqHIII70ZpdI6l9Owd0Lvfb+7i2Yqb9qkiSzQ0yuISwc/HwFIwI7AM6Y60zcru/9ws1Hz833hI/lFEAiqPOl8LQt1S+h7z5SYd7NMb8nN1yN4aIbn1x0sFa5ojp4tEyoAwp3XpfArpFIqvnzI1Eg9p1IgcG6ZL2GRPwAoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791948649; c=relaxed/simple;
	bh=OFqdtS1oJTHFvjngsO4Nq8qXONJKrjQgc65t4eunTXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pSKGuu+hnhe5J+moOkGMGjbF3ZdVgIoGhgp6W6PoGUTfwvJvBzerJhW7+rwdPIYuabxnPOvHuHmx/VVs8emmBFzch3kpc5DVizm/9BE+lDn10D817AygwQqobt3xYdAQTepCkfxhWJL610JDYV+sAHYlXy5C+pLUZan5MIPQ6DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNX/NcxS; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNX/NcxS"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e8662d5e95so3676695ad.0
        for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 20:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791948647; x=1792553447; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=THGvSriruXU51ZqrJHmjnjtWkdka3P5vgj19t9/O78M=;
        b=ZNX/NcxSxqeCBGG1zvAF+z3qgcmTwvz4DWmKzeZ4dTa99OFtfvGv8OUMQjuMtJIHq0
         1O3U5nrebl2uhhwvQrJr6qbey3HUola2k6s+cwpthcoVKfIwmuNUAm10b+egO5DB62vw
         Qk1/kJcsa/nRvyTQrPJORTEhRib1RBuU/19v6ulj+faeh4hACxhCX/Z7+iGs30Nk96+g
         WvchdFnq61p+TDvqepYcJwyFisFgSTQCQJ/e2RXgYF0KKF4CTte4QNL+EWj5/JY2kgJ/
         wY1TOd+5cnyAt/RoMtUVDiNMcRxmvCj3/wlGwZvvyWjEHYw1oyUqEa5pAeUB2srrdMFp
         3VBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791948647; x=1792553447;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=THGvSriruXU51ZqrJHmjnjtWkdka3P5vgj19t9/O78M=;
        b=esS7xmvCKxqjBVM+jDc7ErMlAwbn1ZW8V3Hswm7SyztsVxg+J7wkmk3FLjDtuOmupD
         EXMu5qPvEsHfgAsW6wyDsiRVyYWZASNF0FjKED68KoQfe1646gGJqVfgjAZ5KuS6v064
         rlekqM/0I1pXYq1owQBDOmDXwaNazUm6hzmHHR8oHa0abPq2tq78gvkzPOBSkZYG/TR4
         m/To6IPUzIrarHhqZm9zYfAvYOf9+uzAdep3tokZVt05ZUUjptVgeYjRr/P+iP9vUDnO
         eldq1Tfg8BLrXDCjClXJg0TQdsw0TKeHLdYn9+KiG+QQy/bjjfJDgzitix5ftzhZvr46
         qPBg==
X-Forwarded-Encrypted: i=1; AKwUvByauctcDd+R63yPW01paKgecry9NQhuAeLLzaWBJrMZOO8dwlmuUuD/XDNLfM/m/eb+Tsayql9kHl2k2hOafg==@lists.linux.dev
X-Gm-Message-State: AFq9FYICtbMYV14EoNene+E+4MTcdJAkhk+aTCHW4QAOkobrZk3IHjvp
	v4djDdySM5GDkZDew/KC1wFGNOtlVZhrQ7WQLZtrTZ4Qju2w2JHfRtyb
X-Gm-Gg: AYBFou0A6DhNbbDiBhdE6Uq3uILJar0h7Jlnb7xzUv4R9UQ8XTU6ANXQZn6Pr1KxucU
	VfmjwUyAAg1/hOt8ai+6PimRtjMXe5udiqagDJT/BDTtbWqi9msUEYqb4IOy1vAkBv4UegU0vn8
	5R0oXJmiauEHZ6CiAx45yD4SD3Butcu3vMDUEhUhn0553vbm88QVMCorPgzmrwXSJZQDD/J0TEK
	Vozx2DOh1AabWpAuJqk557k8f6W5ZLBTqfX32NY9PGb6UoUzU6CGqofjnAh/oDUnWiJGdjgk/ss
	9l0Xj9Kxu6EwLN1LlognDXJepKuBU1brfvCbJbMLmmBIs198vu456am2KAYHWDjddjb9XrYfmuk
	EOvKEky05XzG+EuYWjFCtyDWPLs4sTaCmRg/7s37/upHf+jv+GyfQL76LGMkgwjqSgbOEXs8Kkh
	D5RPZuCYO0m2NoTVmFaHUZIbllPve+uAKdxd8S2xqzlwGEi+iPAGmFs/je4sDFQZpvW997hq2tU
	xcpt7Sd6LJNnFQlx3RTVYsdZhrlS+bekA0YoxyZCzbg68XgBZRcz8cTbFo50aniHUgZlbS7wGOC
	BTOOCOi39d9Gsota7g==
X-Received: by 2002:a17:902:d4cb:b0:2e9:3dd2:a904 with SMTP id d9443c01a7336-2e93dd2c08dmr4245535ad.16.1791948646992;
        Tue, 13 Oct 2026 20:30:46 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e841a0124csm63352505ad.5.2026.10.13.20.30.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Oct 2026 20:30:46 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: Takashi Iwai <tiwai@suse.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/1] ALSA: virtio: wait through signals for PCM teardown
Date: Wed, 14 Oct 2026 12:30:42 +0900
Message-ID: <rfc-generic-control-wait-1.112c40f0e9284eaa@gmail.com>
In-Reply-To: <rfc-generic-control-wait-0.112c40f0e9284eaa@gmail.com>
References: <rfc-generic-control-wait-0.112c40f0e9284eaa@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 sound/virtio/virtio_ctl_msg.c | 15 ++++++++++++++-
 sound/virtio/virtio_ctl_msg.h |  3 +++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/sound/virtio/virtio_ctl_msg.c b/sound/virtio/virtio_ctl_msg.c
index 2e0ff15e729d..e50e6c7f3b8d 100644
--- a/sound/virtio/virtio_ctl_msg.c
+++ b/sound/virtio/virtio_ctl_msg.c
@@ -314,7 +314,20 @@ int virtsnd_ctl_msg_send(struct virtio_snd *snd, struct virtio_snd_msg *msg,
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
index f867b9b9233d..d84f0740fcb0 100644
--- a/sound/virtio/virtio_ctl_msg.h
+++ b/sound/virtio/virtio_ctl_msg.h
@@ -47,6 +47,9 @@ int virtsnd_ctl_msg_send(struct virtio_snd *snd, struct virtio_snd_msg *msg,
  * The msg_timeout_ms module parameter defines the message completion timeout.
  * If the message is not completed within this time, the function will return an
  * error.
+ * PCM STOP and RELEASE wait through pending signals within this timeout.
+ * Other requests remain interruptible. Device reset cancels and wakes either
+ * kind of waiter.
  *
  * Context: Any context that permits to sleep.
  * Return: 0 on success, -errno on failure.
