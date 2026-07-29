Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A76C48B36A
	for <virtualization@lists.linux.dev>; Wed, 29 Jul 2026 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785351553; cv=none; b=NrU+Xx5C5LgQtnQwv9ZUHKHvjiLhcu3zk/7bIvMi0uGDefUv2zdbeW1pOHL/HK8tXu9G6awKm+3sEwNSeNU3K4JFstmJPJiL/sOdLwE1ZDx7lc5TaVhJ7K103tNWb3vSZzev0aLdPJnP5ol9HD8WpxEsfQkwgMbBeWYAsp+NfQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785351553; c=relaxed/simple;
	bh=LINqEAjhBd1g3ddyfQvwFEgKvXuCbYGwNsK5S7WkpgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YJhLOAuPlRr+Ap3By5bgRR9kKrHPi2+rRXaenYqvZhoeAFT2aNL6rOfRDGxOMMb9E/qCgHcFRV1m/vGb4cPTbyMeT6MniQ3g1jxBxsFfmHdIGb41chKDEXCcjclALd6ErDPMn595wDbHKfCyjPZChKNAoqwIVooyWP/sV7vQojg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpGosFyx; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpGosFyx"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84e507b079dso979650b3a.0
        for <virtualization@lists.linux.dev>; Wed, 29 Jul 2026 11:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785351552; x=1785956352; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o0V32/dXsc54OzyFlhNUR5QdyRJlD72q6lujfqiekg8=;
        b=DpGosFyxHr9pz4MmOvHvCWRt2jVShsuqTdyo8EscC4sfBx7IYFOVb8syF5UufBPcek
         5hrjr2RF80vkV1rJpA6tIV0NwnF/b9NxYWzdp0ncBm4CIPUO4zJteT/EFURDSVDPUt7v
         r6m2HZyZPjgO0eJlRCWakovuKFDzdEQ68Q+wuP17UqrzgGl/JKT/IN+lw0owwXrB76t2
         liwJlv6ZWVtwUTbGolbTSVtm3nAKDJj+ZFAmPCJAA16TE7+g5QlidLslCbhpEzH+mij9
         77aWv5+KeUKFpj7zjJ3A/SU5/KA+HhShtQRtLdbER2vKFQsLxc73YW1dHu7xbQToLO6K
         TbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785351552; x=1785956352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o0V32/dXsc54OzyFlhNUR5QdyRJlD72q6lujfqiekg8=;
        b=cA2EcbFaRrYhdrjj6oZlUt0zS/b8XTihLMKFLkoW1IxAA9LsHb9bVeeQXVgE6yGlr9
         AF07EZe/bNl5H5Pm2/Q33NF6xOVOC8q+LnDLlv+dLdCr/4ONEe6kwhRRqfMd2zmR0f09
         tt/8wyzlgkmD7oTc3AwCD6Yqy3n2AOe6iuqm+/R2YTbzN1auzImy49BX+smmzzk0blk4
         6NVZ7EGpmZVMjsU6cuN3MBbe74eV/VhEpC3I7ijutvIxc4iykFOSnqWpG/ZirSk58E7G
         XrHFljufU71rA0jP3QcksIUgN+Duiu2j6c+5NbHSiE7Xlf58XW89EbCGEmmXEhcZsMRk
         qzfw==
X-Gm-Message-State: AOJu0YzrRI4+F+HJfaDEekC7zL0C9smvCniGg1SXUFMlilvKxY2efiuG
	NjkGRFCAeBZGh8HshaqiVryTIa1Q9+O1VKbgQAPs0R93TNEa+cUQ9eML
X-Gm-Gg: AR+sD12n74mytex+MbKhelc7Y5ZzNnS9rpgbQ4xSbrSkER23WTFUMweqEd0Kka8xppp
	hgcukxfBy/I+jgb3sl4UrThUvFdnrnIFOJCthHxwYjBBX53NADtzSPuWLraQL9xatxO5cSSGv9Y
	YeYpCB3wXXPx6EnKIiHnGMP6rzJYuEpHSrg6iAmLuaThn9i2q7zAJugOk+l3bT0x8zzgyvc8scC
	pgWCVnwhjXqIFCFgDlsTXuDJ6LyKecukGmDwRi9Y57mncHVOtgeSusfjixzZQtMRWwCnHFB4Cjd
	QIYFVAGE2Pv7fG/HagYSrzRbSuDAAsRutuFOtSX52ula2C1WaAnR4U/VxuQbRJ7lTZcaxcNZkQY
	WxZxEwlW7k/Wqez9gV3eg2F8Wi7zuI9gPyYCyuq8ypCaejEIMrYKRE6t/MC+r6l1awlER8+P6t5
	S35t5PFBlSKUy5UW4PfHEx52biu6LGEg42xjA4QOPniDH+3EqIbzA9FExXKm7/jqxdVXuz
X-Received: by 2002:a05:6a20:d52b:b0:3c4:5f94:f22c with SMTP id adf61e73a8af0-3c8ba5d871fmr9455053637.43.1785351551927;
        Wed, 29 Jul 2026 11:59:11 -0700 (PDT)
Received: from bogon ([2408:8207:1832:1b44::c6b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdba447107sm1237829a12.21.2026.07.29.11.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 11:59:11 -0700 (PDT)
Sender: Weiming Shi <thebestswings@gmail.com>
From: Weiming Shi <bestswngs@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: [PATCH v2 1/2] vsock/virtio: read virtqueues under worker locks
Date: Wed, 29 Jul 2026 11:58:27 -0700
Message-ID: <20260729185831.3247971-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit bd50c5dc182b ("vsock/virtio: add support for device
suspend/resume") made the *_run flags transition from false to true when
restore installs replacement virtqueues.  The RX, TX and event workers
read their virtqueue before locking and checking the corresponding flag,
so a worker delayed across freeze and restore can observe the replacement
queue's running state while retaining a pointer to the deleted queue.

Read each virtqueue under its mutex after checking the run flag, keeping
the pointer and state in the same queue generation.

Fixes: bd50c5dc182b ("vsock/virtio: add support for device suspend/resume")
Cc: stable@vger.kernel.org
Reported-by: Xiang Mei <xmei5@asu.edu>
Link: https://lore.kernel.org/r/20260727035804.1860862-1-bestswngs@gmail.com
Assisted-by: OpenAI-Codex:gpt-5
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/vmw_vsock/virtio_transport.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 57f2d6ec3ffc..a8e1dd95ba8c 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -346,12 +346,13 @@ static void virtio_transport_tx_work(struct work_struct *work)
 	struct virtqueue *vq;
 	bool added = false;
 
-	vq = vsock->vqs[VSOCK_VQ_TX];
 	mutex_lock(&vsock->tx_lock);
 
 	if (!vsock->tx_run)
 		goto out;
 
+	vq = vsock->vqs[VSOCK_VQ_TX];
+
 	do {
 		struct sk_buff *skb;
 		unsigned int len;
@@ -451,13 +452,13 @@ static void virtio_transport_event_work(struct work_struct *work)
 		container_of(work, struct virtio_vsock, event_work);
 	struct virtqueue *vq;
 
-	vq = vsock->vqs[VSOCK_VQ_EVENT];
-
 	mutex_lock(&vsock->event_lock);
 
 	if (!vsock->event_run)
 		goto out;
 
+	vq = vsock->vqs[VSOCK_VQ_EVENT];
+
 	do {
 		struct virtio_vsock_event *event;
 		unsigned int len;
@@ -634,13 +635,13 @@ static void virtio_transport_rx_work(struct work_struct *work)
 		container_of(work, struct virtio_vsock, rx_work);
 	struct virtqueue *vq;
 
-	vq = vsock->vqs[VSOCK_VQ_RX];
-
 	mutex_lock(&vsock->rx_lock);
 
 	if (!vsock->rx_run)
 		goto out;
 
+	vq = vsock->vqs[VSOCK_VQ_RX];
+
 	do {
 		virtqueue_disable_cb(vq);
 		for (;;) {
-- 
2.55.0

