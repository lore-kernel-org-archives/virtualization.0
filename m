Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA97A314B63
	for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 08:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791965741; cv=none; b=e35PY0VQWQFka9cn/R4nO0SixqvkGJ8mi7vEfydXE04tK9k68j2gbJgZiw69N8RsC0w+5bXIuvcpHGRPJJRtJXOTeqfo+/p4nyU3/l7ONoPukjcpkdPrMH1KVwFFMt+P5kqc+zbRczQWRBzUeye0XlgyJL2hbg4b21QBlaYyQnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791965741; c=relaxed/simple;
	bh=OFqdtS1oJTHFvjngsO4Nq8qXONJKrjQgc65t4eunTXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q0lJDlvVWF+WS246GTcsEl0NVDUJOChFUq7HuqzgCnOJKWQq5rsz2iktEX+qZ5x/BCys39PmzrnSqtXV0nngZ2A0rzZTZTWbB3LftsTsSgapDhoxhnd5+Mv79I/zkN+StEE58Zx/2PMLlFQwS3aCV5/3bB3ZVmqxd2c1mkJiIxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IY6GjTB8; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IY6GjTB8"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e915887d9dso10604835ad.1
        for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 01:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791965738; x=1792570538; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=THGvSriruXU51ZqrJHmjnjtWkdka3P5vgj19t9/O78M=;
        b=IY6GjTB8GfzHi+FmCCrC2jgde6493hFKs64tAvc4uPCnngraXc+bVnyfm8u1XFf0Hv
         ToSM+PtsrfqRvO0LpivnqEr1MU9tEI43is9LPgv4X1pVMlE5aSZMQjFRdqYlAqsFr3gM
         0N6vqnlEXwiQ3g5RmGf6Hk2fDb35TUJmIqmUCPocFnFN2cSKXHkXldnfAn3NtNeiXYIU
         hsH1HyMFP4INt/wpbkIy+Ad31ASl8Nb7goLDA9LLfUvuL1q3iQ6zZXGetuNLFE3LZV2Y
         BI7R70zka22GHtRWWmdQnxuf+UemHGyHZ12xFyBf0sj8UoT3+8UhiqSbFPAKew4SE3jo
         +Y5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791965738; x=1792570538;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=THGvSriruXU51ZqrJHmjnjtWkdka3P5vgj19t9/O78M=;
        b=AbPq6amLuWpnY4CsjEBtOIkTw8oTHSkqR4sumIwbpZMPcjS4Ny90Sq4af6BkWZHgnh
         pK2xbcTXtXjX1YJu0IgDMYWVQd0kr2YQYz7bKbL8ilSOAnXScv6ntiGa74FJl42TgoxU
         6h9j1XCfqA9BSNILUt4TQ98mheOwplBv96dLO99p/FTnGx9/74HchokIjJjzsI6QsvEo
         P+DrrnyCRfmJpA2bA0ObXjov+0f/gG6+you3wZ8ToQj7wgy74eDb4uCOljgpD2FFgx76
         YSGdEvFmBoz+eU5fG+R0R0JdplG7NWW88gGb92u3z60ewt68o8j9hD19akM8Sgr+EnxG
         RVsA==
X-Forwarded-Encrypted: i=1; AKwUvBwqCKWrBypRwH1R+adR+fXWqgyFeP4W7RGMUnLDJPsFxafg/XdVvfyb+nJ03oZ0jRG1TBN/TTtFE7+mF4s6HQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLheGfTmLkp2Em30xSpILrQ9qsN1jE04OFOtwgqt1K6rZDWygSZ
	s0b82hXtIs048uLXe9pxmkVvEQh4QqyU7DBSAl2vPwaTXwLUcwLL25SG
X-Gm-Gg: AYBFou3fkM0hwDc/tuiRumZqi4NA5qocHcCcagBZmivEjtetFfk0v/EaXYL9n1rmveR
	QIdY7Jo8/Md5kwniHHNq6LSb2+k0eL8iAZekrlvfnOEXkMLTo/hk5JF9OQZdHb90TQ7wbCuRbee
	irmQ9H9Mdm9FE2LQ42GGh6+dKwx8tzXnv4cryoMl/utQ/o4jEgkE2v3V/y2fT2CQihc7uVMjRhI
	+2Z0smYHfZIrehG/FBQtNMTMlJovlyDNByJWNdglc88bh+X9YgL1K6gfwtyA7AnF3OdyXNpvJys
	le1ZUKqK/ByZW3Yl7feTtJgjsLOPm5rx1hkDZp51tQ9YWb85ejgV55psDtwL/4X60FomL0heJTq
	LOG8e33ksqhnatvJFGxS2hAYS9WSfSze8sXyxfRaeVIyanCm24pj1hdVa0UChqYTjN9JS/N2JkB
	2iXnnK1Z479idWkfn4UMt6v3qUTqre3SahoDdC8gwj1SIzZf7IZNwn0Xuh4RiThNQFvdjpUiRVQ
	bWZb1B7kI8eh4SVXyZjMDozLVTSu2RTo6cdmVuWIAg9J8SpgqQSwKjF3jhlNGnUUMCe3EAHC/4d
	7w5eyqrOy6e7jfrx
X-Received: by 2002:a17:902:f550:b0:2e8:4bb0:21ff with SMTP id d9443c01a7336-2e84bb02397mr126394125ad.68.1791965737876;
        Wed, 14 Oct 2026 01:15:37 -0700 (PDT)
Received: from localhost.localdomain ([121.137.86.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e841a0002csm67533115ad.3.2026.10.14.01.15.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Oct 2026 01:15:37 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: Takashi Iwai <tiwai@suse.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 1/1] ALSA: virtio: wait through signals for PCM teardown
Date: Wed, 14 Oct 2026 17:15:32 +0900
Message-ID: <rfc-v2-generic-control-wait-1.2eddd58a796e497f@gmail.com>
In-Reply-To: <rfc-v2-generic-control-wait-0.2eddd58a796e497f@gmail.com>
References: <rfc-v2-generic-control-wait-0.2eddd58a796e497f@gmail.com>
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
