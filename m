Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB426224B12
	for <virtualization@lists.linux.dev>; Thu, 28 Aug 2025 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398988; cv=none; b=EpMZL1+LojCNiktmaxmkWbscHIR1q8pDvO89aspykf0QI6F1ma/1o8jI07EMNE40TmIFgq5rrVjNXw0VCQjemugVG325+X3juQCf4IyiIxtG+wSMSxTumb/pPkOGXVFmYId+T/PkWuv60RnMBSY4L3bIxiy+odQHlgsL1m7UeXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398988; c=relaxed/simple;
	bh=JfmHNKv6fRRctbyWAbALohUHBx6noYvrxSlvIRgrcfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=giaUY+QyaveBuNJUNqvpiE1HpaoWilvMOLrsyKggzBL4c8bgfK0r4GzO3SnFbupHmV5Nxiy9Fwx3rIUxnEG99mowL3CVwRuKyFASYNjWa9LYnPDMJL8rM9Hu5YrIfUUyNOwMWKAigY3jUsLU7ontmtjxoxgApt7JMHDaED3hcgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RaJL3l4L; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaJL3l4L"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61cf0901a72so646785a12.1
        for <virtualization@lists.linux.dev>; Thu, 28 Aug 2025 09:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756398984; x=1757003784; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qfjvek//ENAEgL2FKgX59bx4t0OTeCHfKIX7r7gIqYY=;
        b=RaJL3l4LqbnW+boL3HXpY5ZkEbfnbo9LM/w9Y6aRk1wrZEkNkI1r0F8s11VD5vaJns
         a0b+3HWaN6Zou/v2766TIQm1YPzXAfLX1gzx/QCy9n1B0zcyVOoC2u2UbCmL/9427rer
         k0SFw9M0t+MqMdNBFWctkyUwPCluR3CN0TorLd1KZX7pMp0vC3SZsNYzRYdLzqTy9Axu
         YkcmrhgJeDQNrR8yR4QlH0SKxVAucrBRnMXTSFq0KqFOK9guT3/3nPj6T5nNmsZZ1Q4K
         hw1LgqabMHtlHcCui8CQZXygpb+n5G/THf7eSfK9sYYrzirgT7Ss4NqnqsCqCBNsJhJe
         kQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756398984; x=1757003784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qfjvek//ENAEgL2FKgX59bx4t0OTeCHfKIX7r7gIqYY=;
        b=DuUPyJVcy+VG52LcWa6Y1H1hwaoaD/OKPvLP+psLLavi97YEqD/mmMR4QMoA9qJJ8d
         NbcaqHGHbh6VoJfCbXVP34/9lb6cCr01HjlRK3tJ1yAt5rS7+RqH+XJGozGQ14c6uS8E
         +lBvGvk69QZvC5I7Tk7Mm+LCAPezLA2//0RK0QD4RJfp4a1UzXxYjvpNCbqKAaJ6jDms
         5JPilPCGgT0dpCGqHIdL55r7c2vn6xtixwE+hyOSfTA5DA7Dp96hWsi9iPSue+CyTyxA
         Ij5o3yJVoFlSQs8CLL/sz7+bML+IJ8NkSpbQgwPB63MOsgizho3ONKKuT//87AufDMhm
         QBLQ==
X-Gm-Message-State: AOJu0YzAD8aFjwj6Kgm9rONGL5YzhpY/xQ9Doh/e65fqzWjDVZFNX9Bm
	QANMLITIy/KnobjyMw6mCT8adwhjkb8bRZyvgbCku48tZpeQeuh+G18Dn9exWfE2Pxm8XQ==
X-Gm-Gg: ASbGncv9BRt62QHf8/DCVbIq/tIgIr97eAVd/kJjjxW8oDDtN4sBnKgnhpwZa8ikL3m
	0b3tpW2XB3vKbL6PUeO+lDj4DsPjoHlQRwsq8NIzpLutoUQQ2jSFTon8ReKuoriS37enRo+oIwX
	cqemcjPmaeYkSWm2imkcrCVilxnEdLtXSDbOWHmKtYsAu1iCFQhWgppzLQqL92NylTVKOD8bVAc
	krScM3ZC7DhSMHYNh+LWuy26mH8/04QzOA3x7mDSLR5aXfa94WXnJRtmX/bqTFQBMe8duV3s7v+
	skNXQHzdhWhAneJDejeaqzKcK0PK3ZOrMqqpSBrjslFYQVRB0x5jOdPR+ovLaFVLbkXNOy9FQqR
	5+QlDc2b1q4Iv6mnOCkHE5em9JC8bkiQ3dK9KC5UfVvpu8ZY+ghC1OfnmlqYKQ7jChGl4lR7Eo4
	TnboUums2SkPps2Y/5FlcSaXzmNiO//4u9smvX+4Aq0+lilpcm8uSgdkI51fWu7wSyQe/hgaGvM
	kb/dz2fNGJSIzjJu4RVL4aymBqvSQ==
X-Google-Smtp-Source: AGHT+IFe/hXcuH4AtiAKvjVUFlgCKrqqvJR25IyTeSY2Pjjx/C6Tzii4v9S5DZvkLNq7zohXjkV0JQ==
X-Received: by 2002:a17:907:1c13:b0:afe:d62a:f04b with SMTP id a640c23a62f3a-afed62af6dbmr401965966b.3.1756398983612;
        Thu, 28 Aug 2025 09:36:23 -0700 (PDT)
Received: from local.station (net-93-148-93-71.cust.dsl.teletu.it. [93.148.93.71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afef7ae440dsm58069466b.15.2025.08.28.09.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 09:36:23 -0700 (PDT)
From: Alessio Attilio <alessio.attilio.dev@gmail.com>
X-Google-Original-From: Alessio Attilio <226562783+SigAttilio@users.noreply.github.com>
To: virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Junnan Wu <junnan01.wu@samsung.com>,
	Ying Xu <ying123.xu@samsung.com>
Subject: [PATCH] virtio_net: adjust the execution order of function `virtnet_close` during freeze
Date: Thu, 28 Aug 2025 18:36:18 +0200
Message-ID: <20250828163618.86177-1-226562783+SigAttilio@users.noreply.github.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Junnan Wu <junnan01.wu@samsung.com>

"Use after free" issue appears in suspend once race occurs when
napi poll scheduls after `netif_device_detach` and before napi disables.

For details, during suspend flow of virtio-net,
the tx queue state is set to "__QUEUE_STATE_DRV_XOFF" by CPU-A.

And at some coincidental times, if a TCP connection is still working,
CPU-B does `virtnet_poll` before napi disable.
In this flow, the state "__QUEUE_STATE_DRV_XOFF"
of tx queue will be cleared. This is not the normal process it expects.

After that, CPU-A continues to close driver then virtqueue is removed.

Sequence likes below:
--------------------------------------------------------------------------
              CPU-A                            CPU-B
              -----                            -----
         suspend is called                  A TCP based on
                                        virtio-net still work
 virtnet_freeze
 |- virtnet_freeze_down
 | |- netif_device_detach
 | | |- netif_tx_stop_all_queues
 | |  |- netif_tx_stop_queue
 | |   |- set_bit
 | |     (__QUEUE_STATE_DRV_XOFF,...)
 | |                                     softirq rasied
 | |                                    |- net_rx_action
 | |                                     |- napi_poll
 | |                                      |- virtnet_poll
 | |                                       |- virtnet_poll_cleantx
 | |                                        |- netif_tx_wake_queue
 | |                                         |- test_and_clear_bit
 | |                                          (__QUEUE_STATE_DRV_XOFF,...)
 | |- virtnet_close
 |  |- virtnet_disable_queue_pair
 |   |- virtnet_napi_tx_disable
 |- remove_vq_common
--------------------------------------------------------------------------

When TCP delayack timer is up, a cpu gets softirq and irq handler
`tcp_delack_timer_handler` will be called, which will finally call
`start_xmit` in virtio net driver.
Then the access to tx virtq will cause panic.

The root cause of this issue is that napi tx
is not disable before `netif_tx_stop_queue`,
once `virnet_poll` schedules in such coincidental time,
the tx queue state will be cleared.

To solve this issue, adjusts the order of
function `virtnet_close` in `virtnet_freeze_down`.

Co-developed-by: Ying Xu <ying123.xu@samsung.com>
Signed-off-by: Ying Xu <ying123.xu@samsung.com>
Signed-off-by: Junnan Wu <junnan01.wu@samsung.com>
Message-Id: <20250812090817.3463403-1-junnan01.wu@samsung.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d14e6d602273..975bdc5dab84 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5758,14 +5758,15 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
 	disable_rx_mode_work(vi);
 	flush_work(&vi->rx_mode_work);
 
-	netif_tx_lock_bh(vi->dev);
-	netif_device_detach(vi->dev);
-	netif_tx_unlock_bh(vi->dev);
 	if (netif_running(vi->dev)) {
 		rtnl_lock();
 		virtnet_close(vi->dev);
 		rtnl_unlock();
 	}
+
+	netif_tx_lock_bh(vi->dev);
+	netif_device_detach(vi->dev);
+	netif_tx_unlock_bh(vi->dev);
 }
 
 static int init_vqs(struct virtnet_info *vi);
-- 
2.48.1

