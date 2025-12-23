Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED04334D3BD
	for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766503640; cv=none; b=EiCN93IYrrVoK7QMA1FBGg2S4R0Wz1KXYSiIR4R9H56huhFdonOn1d26PA9czsdKwtdV6mfE11mZFVCYylIi/OiKxm0u1yaC+ISPfg7+o+bngA2DCLForGoP5txT+4EyVBvJ6cwoAb7T2timvVVqRJkOpYAC7mRyAQtSRE3rqMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766503640; c=relaxed/simple;
	bh=dqAVCd406spP927ct6RgvB4a8I1dOdU+v808mOA7XuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gLO4dd/MTPMoLiI6HqJw3D82tyBWUICIRRqv0eb7EccfivGdhVSN2clG4sfURpFk8tdrRU9BRV3c5qrstX49ECNzv+p9ABH/87aCr4nPhFIUFSw8/6zipdUNHMu2NBvnL7B6lkVB5ayv8/bNYsTGcZTKRK651RZe4/ri74PJfDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVa5gvON; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVa5gvON"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34c363eb612so5042995a91.0
        for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 07:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766503638; x=1767108438; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ze9XAlqzMbfmN07PhRbHKjr9BLXv6+joNuOst0RuStI=;
        b=BVa5gvONBrFEV529JR9mcG1R2JhbhpJKe0Y+MvKlJOArAHewOQjakbRN0Yrwds72f3
         /GiKzakNG3fsMEDLIozmJ5xG5eFozw1Ep9/6kYTuWvE8lwBWfYMnJRtZVHuahMr3wUi4
         nkZS344jWEyZj4KrsTU/5ZAHNjbW4tVfrG765u+cwJLw+chqbbcpQupnokusFwvF/2nv
         g/41aQLBTuGn8rjay11O5wb6aGJXmyqqZQCo4FY0wey3q4oS0OujFFtD14aSYP8HpQJo
         1xNRjnOLMWvJJEaKtWL29xhx6wIw/+eLKCGvGZmUdksHkmRQOcXCvr+TBxJH6p1g00SG
         m9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766503638; x=1767108438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ze9XAlqzMbfmN07PhRbHKjr9BLXv6+joNuOst0RuStI=;
        b=C439Z2X6WUe2qjGo6lT32O2xlcyh//qkdsghjAtdRlkKkUVPD7Kq8PdZ8oXlOM2Mc7
         6i5szruiaTHl9WH6wUTQwKVn50wlEFmAW+skKlVWOghftTPU2pD5bOhRdIYqbHyynX0T
         eVrmSby9Z+4ZFsar5lEZ7AJ9j0NBNnvkm4apNFnkqgI2GaV+kTGbJ7BDSWIPaehWkzcx
         kYBODt6+n5alxwePYI+zRFDOEN9g3Zh/XIxXIxwyfpuJS1aoUxyAGXXOne+3KaeeLRd1
         TASDDNBGNeEbIDnxgPGGFxd0rpoyW2lsALFIeGY9SfOBUTJsDfXErKIpwSon4joofZjD
         arag==
X-Forwarded-Encrypted: i=1; AJvYcCWBTbXF3lDK+A/HChAcU/IBqZeS+l6lxJeM2BkSDHIJ7+NofAHE0SAD9wmNFI6CkDNm/5NIT7Z41drQae32Mg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyqJlaluTiyiSnrmvNDzdAxrZ6mQMGBWjlsPc15VlDfwW2E5q26
	XG2fiUXEWhIUHlbydKD6UZL20iog4GNEKgnIJOOmWKuKSQXf+RJktk6e
X-Gm-Gg: AY/fxX6UtH+vKOmmKkmYnYyVKG6+TQzY938e8t8uWOCj+JKbN35b7IkdT3f3fIcB/K6
	UZA6LQ83BIzmpnhPXs1F4ECtFH/XnWshruiCCPpVtbTyM7a0IEkdUW5xjsEp7cRCvmMQH2nPvQe
	XcJTyTXC5fOc0e0Dmq4J+B8Jv75fKDmeQZ5n5R9Axn20tjqqBxd0LmLHpQ5JM0SNRV7kgHHww+8
	DRkFv39Xmi8+Uc4ovZgHuEeCs5vNb9wWB0GOsgfrxJsMVI0j206S4DBBXF7cG7oIKjK+FW6H9rZ
	qKBfoWuuv/y9Hwg4B2AKDOwareRZLl1HfFVfBLmH6HlQQNgCRPh2awFpBATprMUthDRukJgC5KZ
	U6J09uEmmtQenYjcHz0v1ymGZCMisexgo7bg3ueZSz5whQ5kZy8KHhhzXFCKW4btrr+z/ox1G+z
	k1vXi/UqFodNEvJoV/aYkxKt3C
X-Google-Smtp-Source: AGHT+IEk5kNaKT2vsTzXqOJuqMCa8BgC7mYYuynqk5le798li0SZVD/6VGOpORiTUPiHf0D9J/Vgsw==
X-Received: by 2002:a17:90b:3ccf:b0:349:162d:ae1e with SMTP id 98e67ed59e1d1-34e921f7eb0mr11071309a91.33.1766503638325;
        Tue, 23 Dec 2025 07:27:18 -0800 (PST)
Received: from minh.192.168.1.1 ([2001:ee0:4f4c:210:3523:f373:4d1d:e7f0])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-34e76ae7618sm8006138a91.1.2025.12.23.07.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 07:27:17 -0800 (PST)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net 3/3] virtio-net: schedule the pending refill work after being enabled
Date: Tue, 23 Dec 2025 22:25:33 +0700
Message-ID: <20251223152533.24364-4-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251223152533.24364-1-minhquangbui99@gmail.com>
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As we need to move the enable_delayed_refill after napi_enable, it's
possible that a refill work needs to be scheduled in virtnet_receive but
it cannot. This can make the receive side stuck because if we don't have
any receive buffers, there will be nothing trigger the refill logic. So
in case it happens, in virtnet_receive, set the rx queue's
refill_pending, then when the refill work is enabled again, a refill
work will be scheduled.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 8016d2b378cf..ddc62dab2f9a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -383,6 +383,9 @@ struct receive_queue {
 	/* Is delayed refill enabled? */
 	bool refill_enabled;
 
+	/* A refill work needs to be scheduled when delayed refill is enabled */
+	bool refill_pending;
+
 	/* The lock to synchronize the access to refill_enabled */
 	spinlock_t refill_lock;
 
@@ -720,10 +723,13 @@ static void virtnet_rq_free_buf(struct virtnet_info *vi,
 		put_page(virt_to_head_page(buf));
 }
 
-static void enable_delayed_refill(struct receive_queue *rq)
+static void enable_delayed_refill(struct receive_queue *rq,
+				  bool schedule_refill)
 {
 	spin_lock_bh(&rq->refill_lock);
 	rq->refill_enabled = true;
+	if (rq->refill_pending || schedule_refill)
+		schedule_delayed_work(&rq->refill, 0);
 	spin_unlock_bh(&rq->refill_lock);
 }
 
@@ -3032,6 +3038,8 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 			spin_lock(&rq->refill_lock);
 			if (rq->refill_enabled)
 				schedule_delayed_work(&rq->refill, 0);
+			else
+				rq->refill_pending = true;
 			spin_unlock(&rq->refill_lock);
 		}
 	}
@@ -3228,11 +3236,8 @@ static int virtnet_open(struct net_device *dev)
 		if (err < 0)
 			goto err_enable_qp;
 
-		if (i < vi->curr_queue_pairs) {
-			enable_delayed_refill(&vi->rq[i]);
-			if (schedule_refill)
-				schedule_delayed_work(&vi->rq[i].refill, 0);
-		}
+		if (i < vi->curr_queue_pairs)
+			enable_delayed_refill(&vi->rq[i], schedule_refill);
 	}
 
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
@@ -3480,9 +3485,7 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
 	if (running)
 		virtnet_napi_enable(rq);
 
-	enable_delayed_refill(rq);
-	if (schedule_refill)
-		schedule_delayed_work(&rq->refill, 0);
+	enable_delayed_refill(rq, schedule_refill);
 }
 
 static void virtnet_rx_resume_all(struct virtnet_info *vi)
-- 
2.43.0

