Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183C141684D
	for <virtualization@lists.linux.dev>; Fri,  4 Sep 2026 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518688; cv=none; b=mbiU9iVWgyqiBGnjptRrTOUVYH5sOV4tzzH2vvlpqD1xecao0xFZPF/K8Lf1Qllw6M6+Wxkn9bcP5ubMja4H4Hy95Qy+T42jDCsgYkbVxQ+XThnX2PbzArUvU8kRgoYNoyddwBjkW+oH98f52/Te662Y8sQIID34yMzDNvgtHp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518688; c=relaxed/simple;
	bh=aCZI/bKF4IfBOjZomgaf4OVJCx79HLjieFqaXmTmwRU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AMdG1VDLCldYfELyVubH5LV8praXlpta5FdNYOdGEaT3ERxF3fa+u22CoSzHSNPAjPcecTwFqlHCbKCRnfBVRoIfd2geCixHOma9v9FW0NneLm6l+M+X8XQ5TAUd9dWMAujSUExvTQu5e3YK4lMShsSTtJ4DiBHqrgL0V1iJJDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmNQ5OoC; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmNQ5OoC"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d9b60c652aso9877605ad.1
        for <virtualization@lists.linux.dev>; Fri, 04 Sep 2026 03:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788518686; x=1789123486; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q2oylo4lO8YGRmOoQjP9bx3ZB6WFdgtp12zD5Jx2P20=;
        b=NmNQ5OoCLNqbFQgrDvGt4ajWQaAm8T4cZcX0vThpSDegbYeQqe8cQxnqv+rFoQbiSq
         +/S6Mg3nWPY3Z2tQwqN7h1oQFM1OzII6NpDMM2PZUUa8ZNcMgdumz7WWGFmS4EY2FB/U
         bE6+7boE1JmzAvzbGomAThokK+dDayVSpB0Fl5m9wEhoIrmUeyLi1r4U7sduZRjdXxOX
         wpvhej/+Bj8m/1tGFwTdanYgA1wBhR8UG53EXnL/dFeZb6rEBaxjQKnnzVcYq5MrKhRf
         RWwh1ScIwCxGpOx3qab9/fS9KN5cuBR4nmn3CYt9yhhUNaB1ibllwbXbfZ6SDlVOnB50
         uwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788518686; x=1789123486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q2oylo4lO8YGRmOoQjP9bx3ZB6WFdgtp12zD5Jx2P20=;
        b=lvb/hnusx6wcaY4vH86ov6IidDs70cUWJyjEbLXYDiGReUyxsXxjtvpnt+JnzWCYKq
         7kD902yi/rzAZ2mA1/7BYMV9Sj3x/arUMDRJ/kzpA2umq0bGtFNB51fbvSFXbO/tUYal
         9648ShF2DN9gpvOKLKLRS0rlx+XT9G7IuKzi3kxN1lfqU7rmMgSXKCBvBsnhVsoYMt4a
         BJ1M7KErSLaAOoPvuhdtveiNBBbGMUUc/LZJxQ+pvoSdIxIPytp9ryqwSQNHOE6szfra
         iSYGOgeKxXkPEw89hmUZib3AWYurooloUbg46x/03tUjM4ZkxmsCK6BGqoR7RBN2Yli8
         nMZw==
X-Forwarded-Encrypted: i=1; AKwUvBxaobA6BpbTqGk/u37bF66/BAUGeIw7eOsAz6384kZyK1fmuHfj5Pkx4t5oZma8ZOyCjBllmGoa4UsYZSsL/Q==@lists.linux.dev
X-Gm-Message-State: AFuF++nDmxn0RhO53sJZiwuz7xS6WaPNDWgV/w3my5tmyk3hLRfF9nGG
	FIFF+Gxrnlr7S32sRdXPvJFd196oj8jBpTIHj2ykgEZpe3NJv4jlZUVQ
X-Gm-Gg: AYBFou1m0InIrp9zF2irRiGZdj1a68cHNpIvUC12uRog6R0QEcZooaq+5DD9wSpsP4f
	lpS3OTnBqTBy60DyfVKIVpJ89TlxIS6ESDIVCvQvcxONcCZ3QrLHUdG5NBDYHz8Vv3DErmUqwjn
	ZBHrCz0jYDuCHSwpPIfFg0v4GdI+YdUYzsIq1Bf7rN7XaY9lDYsGrMNMREsafoEh4+KfCG8E2Zh
	6O0K1rRGPA8ggVg7mdQj+1MptqNPnUTJvCdTKDpBgVuI/neQ9Z24mlNc4WITIA4bxKRzRIEDdZv
	oxJdZ+4XRTpykwAH3TEiE6ofYx2G8RESNpByLpuO5USqkDuQD4KPLTUiaQrkU71qZMqNMSlfz5m
	KuVLKX+GCvaAHY6FWmXHf8BpYy/1aFMsdgylpsas/SXmqRRN25XrD56UPrrodKeTw3DXzdQg4NB
	GnpfxlkK4o5PAClHEidXomXycI56sceTOw4yJBc4ETVIQrQqQhvbtQmqS1wwjL1NS8uwyJd4S1+
	QHf9RUeqIPvFD8=
X-Received: by 2002:a17:903:704:b0:2d8:d4cc:be64 with SMTP id d9443c01a7336-2db128764acmr53818985ad.17.1788518686191;
        Fri, 04 Sep 2026 03:44:46 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-333c9db92b1sm5064676eec.9.2026.09.04.03.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:44:45 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH] vdpa: fix typos in comments
Date: Fri,  4 Sep 2026 16:14:38 +0530
Message-ID: <20260904104440.18772-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/vdpa/alibaba/eni_vdpa.c | 2 +-
 include/uapi/linux/virtio_net.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
index fd6fdba46094..6bb5f6ef57cf 100644
--- a/drivers/vdpa/alibaba/eni_vdpa.c
+++ b/drivers/vdpa/alibaba/eni_vdpa.c
@@ -273,7 +273,7 @@ static int eni_vdpa_set_vq_state(struct vdpa_device *vdpa, u16 qid,
 	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
 	const struct vdpa_vq_state_split *split = &state->split;
 
-	/* ENI is build upon virtio-pci specfication which not support
+	/* ENI is build upon virtio-pci specification which not support
 	 * to set state of virtqueue. But if the state is equal to the
 	 * device initial state by chance, we can let it go.
 	 */
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 1db45b01532b..4a458ebb2567 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -316,7 +316,7 @@ struct virtio_net_ctrl_mac {
  * Control link announce acknowledgement
  *
  * The command VIRTIO_NET_CTRL_ANNOUNCE_ACK is used to indicate that
- * driver has recevied the notification; device would clear the
+ * driver has received the notification; device would clear the
  * VIRTIO_NET_S_ANNOUNCE bit in the status field after it receives
  * this command.
  */
-- 
2.48.1

