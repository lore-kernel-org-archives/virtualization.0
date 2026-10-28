Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793156023;
	b=baBWRGYRdJ5bbGQrcWw7xedUSClHzMfG2ERvXPE+vscr5rdw5GOkZxjAy5tMhpvqVS4V
	 ++AyituUP8WCvv07EFR9sWS/W1qjAvJejFHtvGZFQmRQm1QD39xH/U7ApFLm6gOAagq5+
	 x8ed/1+C58Giut2OKtebmhsUhhWnQ4SHiiv53kWu04hJlgrbeR8iIp/J2heFpwp+WbDlX
	 dtCpoJ5i78dO7wuA6lOlAqPZp8VkZiEmzKcPsOybLrbX9VV/8gsd6Y8ZW5DK3TUx54lzs
	 PjrDYw1rmPRDs3N0kGYmDbw/B0GHMx5ww5Q6O5GLjfnEmRaFLzmv20Lj0UGKeNL9xgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793156023;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=THGvSriruXU51ZqrJHmjnjtWkdka3P5vgj19t9/O78M=;
	b=aB20G8anBwXofcGbB/z+iImPDDx3OM+v7DP4lsV7+Bo5wH8s6qf++sGMjoA1kdLHweb6
	 LEQQqBfaEjWEmAG8U6u9TzzGqnasZzdx4PLfGNuxuBpB1j78Wp8/l6URK+7OATcfQofDN
	 vM3OcGk3VvBG4YahsplKDdlOB7hwlkpTPTRQt7Nm+5bn1MLbjg3fcgaUZ35d23oQAc44F
	 trPgOt1BNYeOsy05x8ax2zEzfDSrjJRO23c2kDTORrRCcy9l+zYV/0Pst5TPucY+ayZlX
	 wh6Gi+mVT2c6KOkLVu41WjyjjGPd1x42QCL2guYULEitTaPd3BAXwgCn4NoECSI9Z6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="pj/rtqmj";
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C7660A261A
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 02:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7C7660A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pj/rtqmj
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3514b90bb89so985338eec.1
        for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 19:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793156022; x=1793760822; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=THGvSriruXU51ZqrJHmjnjtWkdka3P5vgj19t9/O78M=;
        b=pj/rtqmjMOmOBlQZy6/znRnk16IXXLoL4pP4ifo+I/LkeB5xMjVHMCbWxRCeDIrdno
         BU2DbdFjLZCRqGQ8MdEskwpwhXmUTEA4GRSxkLnrPp8nSJIcdfigzywRicwSJBZP6oBM
         gghM9wsvD8w/K5Z/3kkXIfZd5M1WOVGLmjc7d/2Y4ICVr/n3OxXpSqwsCbSgPWC1bqZk
         UKF47v1wR60dXcTADTtIhVUMb2QLs7GUCL9XmjJYDll85QxXa3hT3X+I6RW5V01+DIth
         tQtoTWLHVBvW7tDV0nmdf9NHceVG1d/lJkwqChEmv+UJ6vZaBrO9GP0TbvkpRRPcckZ/
         ZBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793156022; x=1793760822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=THGvSriruXU51ZqrJHmjnjtWkdka3P5vgj19t9/O78M=;
        b=uTCtBLQbEPztZRlHrHfIMFkqnnmlbMscwiwc0w47EqqDUh9mwULR2nbPJeA4YY8FNC
         3a/pJDYwdqoDtnXJRQD/0Hc7HqU+4b2JBYKkA9fk/KRMkMO5flvc+Ab5OIvQ3B50FoqG
         XHfgYHsm83Dn1WUsJehRrwrXcPKj3B5nD4KCXp7bAD1LFHAvtsyI5ceBhHBhUdwh3wFB
         cJBbneu5zauSAPij4GLwsbCyxsi0wDpG6foyvISCIsOXg3yjJsF0ZjpuGUNSb2plW13d
         OykengiAzbSZLg/zUki3Vw7TqV5DaYyhUoKGXURkase1taDv2eoi0fWKU3VMSHmCwUlv
         nDug==
X-Forwarded-Encrypted: i=1; AKwUvBx16oYJcfqhXjAsL8vqpfkYZi7ARkGfqa6gEFxQmtI3H2+ku8+JzJIY3E9EpNEJbKFLoXqW8szKb/F2JGuH6w==@lists.linux.dev
X-Gm-Message-State: AFq9FYIlcHo+k2qybz6pcXsRRhOOQguYvMLwuu1oMNHtkRe+e3ghtdNN
	Ve4poFSQ+shfM7utj9anGFWKIpeHvipKtqJ7+Ptq1WQCKePjvRmbPMqm
X-Gm-Gg: AYBFou2IRlFdydIUDMMwUCEYxQODjf24Oh1W97mC99jFgrQJIueELv/Mri1tevPklD2
	Drm/yd060sEmtEI3nboqcXzK9FjGJzW9R3t0etIyWjNyuhdLDVDlfW/Hk/ReA/VOWnYQsu2/oZU
	IvEChdO33fFVaqUK7sA80cZouYykJsgPAJtEUOloJFwP/3mhroUDOf1Ia5ome/TfbmFv23AoI+u
	ULnbbFMz7y3L0ZoE4dROordqlazeKQ5s8ZL8tvtsr3zlrmc7ShvbhGCxT/bt7WcsbG0hd1/4aQK
	OaxAGfQgoWt8FeYqB4MHn9LroAiu0uAOH7EdEAZQksifXXlZQrJtZWk4SxKmWT29VyswqwfXEZd
	dXaeg2aw4wX2EtrvbrfbTcJtk7II4aVHO9IIkkjxPIF/anmctRnyLrifCtgwJr6/BetAvsXcuVF
	bjUrhuiBmgpLscMo8Odi+pWWjryrBicPBPV7cEt88OwYq7NLWclJEZI9Q0RBPmCRLthO9Ht2Uc7
	+PXuUoM6htzH2jg0ytRvTaJc9XAv8nCvTeVsW5SdUqf2wgwUNDkQMOKr008B5MXftTnunA74ioV
	5mlefznhsEyrhgO20L28uW7fcKwO5JQe42lh7CXQihNyDDy+DNmPXtDJy80KBnowvOtXK1b58mc
	5ljwjEBKDavBH2G8zWdzUSm05dyhIZinkZKmrOMoKRa1pyv8=
X-Received: by 2002:a05:7300:a95:b0:34d:7ae5:8d78 with SMTP id 5a478bee46e88-36a200febf0mr1531973eec.31.1793156021726;
        Tue, 27 Oct 2026 19:53:41 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a239644efsm1711914eec.23.2026.10.27.19.53.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 19:53:41 -0700 (PDT)
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
Subject: [PATCH v6 06/14] ALSA: virtio: wait through signals for PCM teardown
Date: Wed, 28 Oct 2026 11:53:09 +0900
Message-ID: <20261028025317.92450-7-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261028025317.92450-1-mynameisjune111@gmail.com>
References: <20261028025317.92450-1-mynameisjune111@gmail.com>
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
