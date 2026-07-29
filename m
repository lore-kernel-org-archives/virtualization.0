Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19083B19C4
	for <virtualization@lists.linux.dev>; Wed, 29 Jul 2026 19:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352652; cv=none; b=WICbvwekCBzrbC5afRGBXR9/p9lgQHTyUTZg+j+n5f3kHblIBc2XVa8VFSRwTmQC4ezmnJVbe2FnbxFmgN0PyoOi37/M2dD75QZTquw2+axPBvkevN2e9ENiVcaIGWWiTKqwpnOBeWVy3Bo8akiEZRhkM1Y98wMgQX3NOJKddEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352652; c=relaxed/simple;
	bh=LINqEAjhBd1g3ddyfQvwFEgKvXuCbYGwNsK5S7WkpgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFmk5auF1oULmZ/3R1dpW4LgtpxU0aE/HxYsp2F5HyFiu46kPx3sAJua9fPy6MvoRMZhzzlskgiOIivjLlhx22rCdENqwJoSuOeRrx5nALYFFnw6Lnpo8y/XtVkLn17uNbWZD4W2Dl0/6Zsnbh6WhyyrFi5TW0wL/0K0doZ81uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEnn5Qyz; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEnn5Qyz"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so1327592a91.0
        for <virtualization@lists.linux.dev>; Wed, 29 Jul 2026 12:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785352650; x=1785957450; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o0V32/dXsc54OzyFlhNUR5QdyRJlD72q6lujfqiekg8=;
        b=jEnn5Qyzs5mu8WTLo1YJhCujlenYglvgLgvO0Io7iRnOHqJCX1Pbo7sc9FyKJ3R+v2
         6oSYAO8nJLeZUgzjpit5QGNuJcdAGrfkgDPh4Gyx+W8IXRy42ZgbbPUGh073KCQrcbWL
         TgJC2wZB0PTLz1MtGo4oAhA6hqTFeONmLRMMICYXefaFJGhN09lSQwD744gCkqFOweKB
         otlR2mtqhIcJK4SC4uJVQwlidhRiT2L1h9lnO+gCUUZ7mTXcSb8zeJYW7utb8OEIORzX
         DN4VsKqVCZW1Npj8sooi0BwrvQ9TKqeGEio9igkoOF/l6fuNaZ2X2fdqm+nCHiOEYG6U
         NzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785352650; x=1785957450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o0V32/dXsc54OzyFlhNUR5QdyRJlD72q6lujfqiekg8=;
        b=ToQWrMtYFesEwOWYgMmwQGPDlPijkWKj+FelkNMJFoMnoEbl71yZhX6JB/R6HogutA
         0XE5ntZSB9xmxfIDIKeSmki98UsTukffewLPtRN93jzepYmSrlr/X6aVXo213XqR8zzZ
         AM5LBPseXbf8l5Xgsgw+uADfwnNrs9qkTa+7kCR5CAJqD+K5TqSe5U02cykhmo/MrB3Q
         TxeASLzcQijt770Gf2hFwtRQqgjdWAW3wj6B7IH0HBPjugHgySA18IBPYlA3PPqwzFMH
         c/NoHGcmCHL9XcVoY0Mr5fYH1A5YS2AL9KWlxGlpBiwqW/N8FTlSZYwscAcDof1Qd3Xq
         Cu7w==
X-Gm-Message-State: AOJu0YzVPoXVjOql5B3R+KhALKRHsjLADAVFsiNlaDO1u0ujKXZqSp9t
	cEtT5Vr67ci3lyc3e/fbI+gqPkeRBt+w7U2bGfigZY/+HsaSPVTzAgqc
X-Gm-Gg: AR+sD100oDyzIJoXNHHFYwWysk1DGfyJ89YS79XsOzu/LUBh0Fnv2GLbjv1KpF5pSK0
	D4z77CP03gK0hD7sL/x+E3q78TbbDgbjNzAHVC70issgIQZ4WBRnYwC6WTpJ8hIwTqij4eTtXrx
	80aJQPB0kw5jfj/bM9s8zGwUNcieDGR6ANcGV3M3JpLTkREqEFvXETfUBPgQRVwXuyciRWaHIgN
	aGAewPYAx+SADN1gl4CPH2a469g/mJOYUeWXu4ANb/FQt9HXTGslvSjAPwFYuf0JsPRKwr9QfBi
	MG4+wxXmn+T2Ck9oKzPmHAiaLXTIGZ368wrVHovy9ukCuTkR5p6G0cwFvbxpxlqmuJdSq0cj9uZ
	GLJJPWQIRRjZ6Bm04nLYXKsP6u9NDOPjyO6TcnoRj9SanjMK7PyTSFWCf0oz2zVdsXbqK5gY6s/
	wCQ0I4ZWkuWqVXgqpZ3afSLioiIOFfR/YyxQk6HqGDd9CLX3hoa/hLaNpHtvq6rK2rYJMv
X-Received: by 2002:a17:90b:37c7:b0:37f:f4ae:5f25 with SMTP id 98e67ed59e1d1-38f99253d52mr124443a91.20.1785352650000;
        Wed, 29 Jul 2026 12:17:30 -0700 (PDT)
Received: from bogon ([2408:8207:1832:1b44::c6b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f81543abfsm833349a91.4.2026.07.29.12.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 12:17:28 -0700 (PDT)
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
Subject: [PATCH v3 1/2] vsock/virtio: read virtqueues under worker locks
Date: Wed, 29 Jul 2026 12:16:54 -0700
Message-ID: <e79f68ad9284c983364fc3ac46904b6d9ef50231.1785352330.git.bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785352330.git.bestswngs@gmail.com>
References: <20260729185831.3247971-1-bestswngs@gmail.com> <cover.1785352330.git.bestswngs@gmail.com>
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

