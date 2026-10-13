Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7EF3ADBA5
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 05:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791869439; cv=none; b=T75fyhn7Q62vdnsa2QRbWixNrJ1dw4CPfb6fOSTFHDs7JOYC1hnWC3kMYxlu6sYcyd5jvGL1QOW6U5BCvk6ORuobwPptNp6PA+BdxYWYl+AOIQVPIREQEoDaImUXcaXv9UEmKj2QwV8+6PV4bQhQZ3B/DwMY8LityKo37KNJM8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791869439; c=relaxed/simple;
	bh=//JVc5042SnZ4J1QXXHRBNb2grzQD9C+5eviInwfEK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJoyR3gkLO7OVKTtdJI1kJ2sUq551GzUhE0yA9+uh++XwS9Lc/i5ZdmPybdHTzZMNZirggGaA2SW8qoKH38WoCIH9xLHRAKR0SxaYBXir8ZONmddAl7yHnE4+HePVV/BFboBF+BAu1mck8Be0gCQHvg6aX6yWGiABlvDjKyFkP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnpKPttZ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnpKPttZ"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e4af975346so14940215ad.0
        for <virtualization@lists.linux.dev>; Mon, 12 Oct 2026 22:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791869437; x=1792474237; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BAdT0WoMnU7Kn2Xlp7z7rIayKbwBnbkOfvghprU0fMA=;
        b=NnpKPttZQw7OF1kAbpAHt8TboQt15CVPE7BIJnT4Hd0UpsV6HAHL6MtqmT5pSHCBkC
         sB65hUz2TzzQbZyD6B/4GM2Zx1sJCliFZMNJ31a0HpV48WyUKizqUnZgxDkc/rU3szVt
         NFUbc9eltl2bf8GGaGMj1vwFN7hLDfurRe4OtUhYDXl2rHM18J4oA3SSzYrmIGTPS5P6
         UGwIFiaFT9qIN4PREFwcjpM/uBEhCAbB1CKhgy9cIuPdTDP5456jD9HNS9yPjYJW0Ih5
         aHG8xKQAS/SLzmYvFbQoFtL9ThoIak2ItPFR53kL08QatPhjQuuhRpm6F4qbU2scgToM
         xhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791869437; x=1792474237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BAdT0WoMnU7Kn2Xlp7z7rIayKbwBnbkOfvghprU0fMA=;
        b=z8dIaIV7QvMsgM7BF6eRdMMCRHz4gGZA71S85mydN8iijL9zcnpQTYE0BIRJbQolKY
         YSpo6iRMsdBPGu6v8qfqJ83tG0sWZm00N0ctaBhK5abJJLr44tkjlMx5a0XRBkXbGu4o
         OeFH8odgxDSf0UHAVheU5SESMWQWeh3zmqGXLR/kzhaHbZn0JPOH5keIqWd8UlIWBpIM
         yaqd1loJV8HOSeyKKlOnv49ZVE4rMeGTDBct/soUeKf40qlEr0t7bmVeMr3LD6SK6sQU
         9PvUPlwNqfNLn/PSDFy6CWZSkS6XoETUfeKWVFxkWQv3IrpZFNhC0ist/OXJJsTucuC+
         zBsg==
X-Forwarded-Encrypted: i=1; AKwUvBwZJ2xlEPrpfIEnQ4Yl2ISF08ayDxglRd+dIH8u9Y/+cs4lyiHwybKfNHJFR+N6iYQMmc5O1ALbnjf611wbkg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ+4gm20iq3dCtTm8fi5vA3AHUtdX6paNfxgNSSbL2jyKiaa2s+
	b57Q+Bo7H2ybBIjt7fOwJF30QvKmLZhsJUONWdeVVMe1NYefP1GVm7hu
X-Gm-Gg: AYBFou3JL4Y5k87+nKrru/JzLIiKpk1ynVMVyXCxd6Q3SMzQ4MPAN7f3H2pCgr9BUtF
	rNWKHxuHsC92jknWdJhTUkKPQN4rg8XIgLIZ20uBbZJPVfhLusmw1oqyZa68NblR3zfcOe+SM/k
	dH0WTFrIHFxjSRjYFkLi9ctSK2qFKJaeR9NAYPLiQW1mk3E9PX0DuErHdF5ggUgPyfJ1ee7CzAL
	uTFyiSv45PUykoqdZZiljR6mhzLsK55qgyXvlRGPCV0Mdl0viLNU7XmNiIK82JUxnIyy1Rs/Hy6
	3uTcd+fd3WQcRdZr7j0W8lZzifFcGtz1IhRvUwwX8fy5p/dGo/bUwvPk08C95G9CvsFM8LR8xz4
	vKLLLpAZmksWdV7SBtSevsNfmnXpPYy74I70nxEitL96PieRHEJrGSYZXkjUdz/24dIttTz93hI
	VMl60kW6+5ABXknfVtXwjsvescX94Fr3N+kbaEU3mIg4pgfrdYdBOBJ9Wgomz4Yf+SQIijkgzTr
	HcHHhG/JSjXyaR2Nf3adnueOJyv92eBFpxxY/0Z9hzqAkd5cd3peDuBcU5BL/FzHWLGbZnkE7/k
	P7Bxm1kYQ3L7zvL+
X-Received: by 2002:a17:902:ccca:b0:2e8:486b:104c with SMTP id d9443c01a7336-2e8486b1346mr97312665ad.30.1791869437352;
        Mon, 12 Oct 2026 22:30:37 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8cb6sm50820915ad.60.2026.10.12.22.30.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 12 Oct 2026 22:30:34 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	Takashi Iwai <tiwai@suse.com>
Cc: Joonho Lee <mynameisjune111@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jaroslav Kysela <perex@perex.cz>,
	virtualization@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Subject: [PATCH v1 1/5] ALSA: virtio: Notify queued PCM messages after send errors
Date: Tue, 13 Oct 2026 14:30:22 +0900
Message-ID: <01fd635f9ccd48594864e6e3858389060cdf2aa2.1791867377.git.mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791867377.git.mynameisjune111@gmail.com>
References: <cover.1791867377.git.mynameisjune111@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtsnd_pcm_msg_send() advances a message length before adding it to
the virtqueue. If a later add fails, the error path returns without
restoring that length or notifying the device about earlier messages
added by the same call. The device can therefore leave successfully
queued messages unprocessed, while the failed message appears
already submitted.

Restore the failed message's length increment and notify the device
about any earlier messages added by this call before returning the
error. Keep the polling feature path unchanged.

Fixes: fe981e67568c ("ALSA: virtio: use ack callback")
Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>
---
Validation: source-extracted ASan/UBSan partial-enqueue and polling
checks; included in the W=1 builds through patches 3 and 5. This commit
was not separately kernel-built.

 sound/virtio/virtio_pcm_msg.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
index 72103f606716..5371f4985fd0 100644
--- a/sound/virtio/virtio_pcm_msg.c
+++ b/sound/virtio/virtio_pcm_msg.c
@@ -260,6 +260,18 @@ int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss, unsigned long offset,
 				dev_err(&vdev->dev,
 					"SID %u: failed to send I/O message\n",
 					vss->sid);
+				msg->length -= n;
+
+				/*
+				 * Do not leave earlier messages queued without notifying
+				 * the device when a later message could not be added.
+				 */
+				if (msg_count != vss->msg_count &&
+				    !(vss->features &
+				      (1U << VIRTIO_SND_PCM_F_MSG_POLLING)) &&
+				    virtqueue_kick_prepare(vqueue))
+					virtqueue_notify(vqueue);
+
 				return rc;
 			}
 
-- 
2.54.0 (Apple Git-157)

