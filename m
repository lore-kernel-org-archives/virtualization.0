Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E46B3C199A
	for <virtualization@lists.linux.dev>; Sat, 22 Aug 2026 16:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787417168; cv=none; b=cPK0S9zIpMqlHZOIKZCp+WqOjA2xq1ZPt9gCkjVodySB8Z27wDu9EnhAio9zO2pGPHDrppcnI52qyLuLeiZhv+eTijulio7bOW34tXPDfu35ICDSWb6hBylqZ3rjq9Ry+9a4RjySw1H7P8wku9+Nnb25L6P6HQTzWHeKAXY9qUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787417168; c=relaxed/simple;
	bh=RZnSBXG7H5IfVESK5dV+papTZf4bB2+5pFdMF6y80Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G6l+ojrHvnB4wiwAKeFcvy1VSdPVr2wUVe8GzHmuvUt7HRtOQypDAjbbjsntIFaqUVkEMvPmRh8ho5WDKF6hBKsWzvy+7A2qYjmaA9OYPT6GHizG+GR9GckivNbx7TxaTFX+EMPHAbjcCP3n96koo5dtdlU7wiE2X3+9PUiag5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9gU3UxM; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9gU3UxM"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cbe4c537ad6so239585a12.0
        for <virtualization@lists.linux.dev>; Sat, 22 Aug 2026 09:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787417165; x=1788021965; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zxjo65j0/PC8LNmS95fdZuou6hT1feMI3IHbQQyBjIE=;
        b=R9gU3UxMqdkK9pqdi12+38Xf0a/6BHuo77kVYgLkS1HP7aZYa6/NXGXBXmMY2y1did
         zqc6hMWt4Afll+5pnIPkbrFFPOel73al8VcFQ1rono7FBwk9o5BtTAhvp2N47LvVK6Qe
         C7Ra7DqqT1iwV9PeSdjPHeMoYPLoBgJDAv4EZDcnqBTH1ob4E7bRgQ6StJWKlTfujQFX
         Sf4oNYsHFim2F9j/YPRcWXl8kRBC8qe6pFdOFVKEAoCo2+pdmVrtXKGylQV4ycToEilj
         QWwKMTcFe1m6IlTaOtdJIUhzMmPvKExIdd5lm14X032GAdoNghLgZceMu0yM2eT44eQ5
         qPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787417165; x=1788021965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zxjo65j0/PC8LNmS95fdZuou6hT1feMI3IHbQQyBjIE=;
        b=MqQo6/rKY/C6O2z6qvOIs9NH7wIug1oIhaNeS5y3/F90VaT3CtJOq8dXbNPYvErUnk
         DY1rml4Rg4k1iFxIefzpSrmbXqcGM9UdeHtriKLTszT8xt1PldSUnc0tiqyD+qfKJ4Sy
         YqtwH2x44QP6IE6MEl6Ft+iIHiuU2DI/07g+RTQc93N9qV8U0rPL6+Ug+1uUSOTBGhen
         /Pl3TCmSISNZ8JIO/zLXPcZuDxYYURESI5r5g+D4qkPAz8BTG5UjLdqKB1Y11je/wqGj
         FvZcT5+JvtRA141huzlrQK7k/wOhyt+mNSa6TeA1a0hI/lXHocy9VjS7DpoDnITSyx2N
         CCzQ==
X-Forwarded-Encrypted: i=1; AHgh+RpX/N9KvU7fez0vaKydKHAbtSCB5esLfOZ4G7pY90bA3oHxD40ai/sPmB7I1B49MRML0ZDAo0H7lm+8C1HDGQ==@lists.linux.dev
X-Gm-Message-State: AFuF++k/7zuCoij6lcuKrXlknW+4tRZOpUS3XvUpR79KFjIMaPcsnL4h
	oDCYoPTbw6DEB0Ba+TMejdLXRImOAB7/mknoAb/ztX/x3Dg5B3wG+Da/
X-Gm-Gg: AR+sD112w4V7yZvqQahphci1cVOXfKyPxXRyYQNuzcEGgauk7NOB+YgxMQU3atLdsFq
	T8D2NTftCq1zluALMHCiQXuh/auDcvoytum/vBW8MSsQ3+Y67GHQyg8+3uWpKTcOJiSJIsw4HSv
	T3FSmh4OkApkl+bN1NymwFEqQb/paJPz0NWYwaFYp/ICXn1xV+5zmfT78Gd0sJKeKQgQDm7HBHP
	/2Ldr00EC1f2mb8ox8cQElSaM9RBkpDD1ZrmmSdFlonHzMK0ouWKhQw9G3akyxNGsdN4QkFgxig
	cOk1Dnyw1W7Gk0f/TKsdDghhyrFnWi2zu4fFFHUj27qibsnqcqgTFGkb9c/w/WIs6rzQAyWn1yp
	1wPpHY00JfaTXtOtAt/sn3i6eRPdO/opCQvnlqWrj/yPO41gXXpm9glLH72R7e5WYbTy4wnHpw4
	2XGgaFOE3H4iKwppJ6mwKAnaWV7gT2CFy+j45lhSKBJ1HqeqgEXFyxutMSF4sPZQAO2XwaXxJaS
	ee81CiNcFA+YHDvihH9qXlCWT+JYVdNjFerien5Xdkbo8Y+MX3d7fk=
X-Received: by 2002:a17:903:b43:b0:2d2:a952:2628 with SMTP id d9443c01a7336-2d64b0d7b26mr129424855ad.2.1787417164695;
        Sat, 22 Aug 2026 09:46:04 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f9209fafsm15623986eec.23.2026.08.22.09.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 09:46:04 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Asias He <asias@redhat.com>
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] vsock/virtio: flush works in dependency order
Date: Sun, 23 Aug 2026 00:45:56 +0800
Message-ID: <20260822164556.3750959-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_vsock_remove() stops the virtqueues and then flushes each work
item before freeing the enclosing virtio_vsock.  The current order does
not account for dependencies between those items: tx_work may queue
send_pkt_work, and send_pkt_work may queue rx_work.

In particular, send_pkt_work can set restart_rx and release tx_lock.
The remove path can then stop the queues and flush rx_work before
send_pkt_work queues it.  Although the later send_pkt_work flush waits
for that producer to finish, nothing waits for the newly queued rx_work,
so kfree(vsock) can race with it.

KASAN reported:

  BUG: KASAN: slab-use-after-free in
  virtio_transport_rx_work+0x487/0x4b0
  Read of size 8 at addr ffff888114c2b008 by task kworker/1:1/47
  Workqueue: virtio_vsock virtio_transport_rx_work
  Call Trace:
   virtio_transport_rx_work+0x487/0x4b0
   process_one_work+0x688/0x1120
   worker_thread+0x45b/0xd10
  Allocated by task 1:
   virtio_vsock_probe+0xef/0x6b0
  Freed by task 84:
   kfree+0x131/0x3c0
   virtio_vsock_remove+0xd1/0x100

Flush the works in producer-to-consumer order.  virtio_vsock_vqs_del()
has already disabled the queue callbacks and cleared the run flags, so
after tx_work and send_pkt_work are drained, no source remains that can
queue rx_work after its flush.

Fixes: 0ea9e1d3a9e3 ("VSOCK: Introduce virtio_transport.ko")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/vmw_vsock/virtio_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 96c9fe8d357c..4f9aa9c4c3aa 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -872,10 +872,10 @@ static void virtio_vsock_remove(struct virtio_device *vdev)
 	/* Other works can be queued before 'config->del_vqs()', so we flush
 	 * all works before to free the vsock object to avoid use after free.
 	 */
-	flush_work(&vsock->rx_work);
 	flush_work(&vsock->tx_work);
 	flush_work(&vsock->event_work);
 	flush_work(&vsock->send_pkt_work);
+	flush_work(&vsock->rx_work);
 
 	mutex_unlock(&the_virtio_vsock_mutex);
 
-- 
2.43.0

