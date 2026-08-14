Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E216E47AF6B
	for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718774; cv=none; b=JYBNO2Ol4Um05OPxrEhR6GW+N51p46T3iRIE4wQ7L/nxS5CkrfPd9EVTiNn661dW2K9erGcRYqpkaMi5CjMymS010xNmj0Z11q51LfC/Xvgi8jWzbGKP+tRezAIWCOvU/J9q9RrIqxImfyWcepmOQtbXTQKsKyTxR5b/oMIg7/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718774; c=relaxed/simple;
	bh=j/48CqOv5Aa/AgwEHKe/KPlAizt7dHvsChDRKjlkCf4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j+srU55RDKXWqV2Anl7/O9SVoBRNplqvQb5Cs8btRVEdp9l7L8Yhu0tF3LaiF2MnUY1lvDjkcvdKQA1VP1OTgEH1kNHGBTizRFF/MPfIOXxNnVyKa6VbSedssmp8s3RUuxrP6hS5/k/fk4/f7dHTyhbxONYdsNtw8Nk0twau+7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qcbcO7x2; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qcbcO7x2"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cbb7926836eso756707a12.3
        for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 07:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786718772; x=1787323572; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ktbN0mlbgnTk1vGFkp72jrY6OVL4246SkIwlC5oRky4=;
        b=qcbcO7x2rMXUn9dSL5zYNpRfwbOtGjMCN3PghZaxAHf3xp4IdmqtLWSp+U6VxiiyOW
         KCUTwv7tIjp6Kj6B93jmVUi8UgTCH/cWJkV1BPg91Sq/GS1uW8eYbo55Z0PddJJ6CeXL
         12PvryFfsrEaG444gkPtFoJkqv9ACUjVPC01OyguAblUsF6g27eDKUC8kAENfQC8AsQZ
         8exVThOSrfnxrdYbycYpAM8dLFPBlJUb15vJ1bXImkKp2TeLvJsbbt++9dxtjffhmy55
         2CJp54+CJ5Z08mDTrCfcz1rom4WCWvoBgqEitmBmiHR4wm8bxI+eLKUwoCNnkDTOcdIA
         jshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786718772; x=1787323572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ktbN0mlbgnTk1vGFkp72jrY6OVL4246SkIwlC5oRky4=;
        b=KUZngg2r0t9CLpV6GjJ0K3RsyAQftewuQ6M3bMaDWdiAZHD14KjXW9ZMYHuCpQoBKI
         AzuKucSWR7G9L9weA1wh7bMgG5Mrsalf3NtildqcGLH1ie+oov59RdMs5oBQJnWSvli4
         R+1xvQAV2LfYyCvXHLA7GcZ1pAlDn5mArqnFmjvLjmI2Tv87GwBwfCDhbiH0dPrfbGzV
         I9S5U2GN1g4aCnImNOCyH6UsBBYTXJCBzSh8oUDL9B14giIYUB1UZdOgNGiWubTjv+e2
         zQYirAxaVUcupw4IGZyMps4jweky3jlLI27W/8G1ukvP8TxNY5MtnfQcdU3++uw4WItb
         pn7w==
X-Forwarded-Encrypted: i=1; AHgh+RoWqioH2GI4YftqHc+PEHxDoimmnBh+x6iQd4yov9rZoHHdtujJEhzE8hyKqMjjtU1fYq3WXRrOYWwWpa84HQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwR6voOaP9TuGwzG+TbLUIWLmH52KOldlaytqJt9P8uaBEOZ+k2
	IIgpSzS1q+SV9REAcMfNYOMNahViwvvEkmwiN1Qj2YADWfyhAwP+ouEy
X-Gm-Gg: AR+sD10XLzzhrWP5I81RaLLhnENGbtVcbmFBOD7sd8SnsB61jKT9MtqwZghbUU4KYWE
	17C66ZVDhCwwG/RAggwq+V2r35JVOmeRq58aFodHEEpUexypLMAwBHtUWW4KCe1kGGKFi3BMgIA
	PTq2ofur5I+/KaOs06D5DevdK7h0EuqvJAwE58ChHiLQDWw6r4CnnsPv/dtPfbSQuVg9BTxUcij
	xvMrBMlTDK9th36+ibyNxI0vg6e+pg8k+ez4N7fR0cTBcXR7YlLTalsgEMb8Ft5bmfKTMpzs6mW
	LEDwbTHFCXCNnnJnD3AaTfiCNWdc12H56gNkYQCNIrcCULGiUiSt8bjto/phpTJClFFWA0SCKDt
	+SkFvGq9qVLHjj4SJXKWc5WVedOCiUzahiJBGVXHQG6pEnxXjMHiNogc1kZ+hUxVXhGzP1YSvB/
	zrGxeK9GoDt3qCnRqxE3lgifKz8Pq3spEWjji01i/Whf1Ehlv+jrl26yahqysXZhU=
X-Received: by 2002:a05:6a20:4325:b0:3bf:7eb5:9459 with SMTP id adf61e73a8af0-3cc71fa8cd1mr7381930637.20.1786718771362;
        Fri, 14 Aug 2026 07:46:11 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320d60eb8eesm5547344eec.10.2026.08.14.07.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 07:46:10 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com,
	jasowangio@gmail.com
Cc: eperezma@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] vhost: fix device IOTLB feature lifecycle
Date: Fri, 14 Aug 2026 22:45:55 +0800
Message-Id: <20260814144558.134314-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both vhost-vsock and vhost-net can leave the device IOTLB attached when
userspace clears VIRTIO_F_ACCESS_PLATFORM. They also replace an existing
IOTLB with a new empty table when a later feature update keeps
ACCESS_PLATFORM enabled, for example when updating logging.

The stale IOTLB can keep old translations active after a memory table
change, while replacing an existing table discards valid translations and
causes avoidable IOTLB misses.

Patch 1 makes device IOTLB initialization idempotent and adds a common
teardown helper. The helper detaches the table from every virtqueue,
resets metadata caches, clears queued IOTLB miss messages, and frees the
old table after the virtqueue handoff. It is a no-op when no device IOTLB
is installed.

Patches 2 and 3 use the common helper when vhost-vsock and vhost-net clear
ACCESS_PLATFORM. The backend-specific code continues to update
acked_features in its own virtqueue loop.

Changes since v4:
- move the existing-IOTLB check into vhost_init_device_iotlb()
- remove the vhost-vsock-specific keep-IOTLB patch
- add the corresponding ACCESS_PLATFORM teardown to vhost-net
- make vhost_clear_device_iotlb() handle an absent device IOTLB

Jia Jia (3):
  vhost: add helpers for device IOTLB lifecycle
  vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
  vhost/net: discard IOTLB when ACCESS_PLATFORM is cleared

 drivers/vhost/net.c   |  4 ++++
 drivers/vhost/vhost.c | 28 ++++++++++++++++++++++++++++
 drivers/vhost/vhost.h |  1 +
 drivers/vhost/vsock.c |  4 ++++
 4 files changed, 36 insertions(+), 3 deletions(-)

-- 
2.34.1
