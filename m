Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEABF1AC427
	for <virtualization@lists.linux.dev>; Wed, 14 Aug 2024 12:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723638306; cv=none; b=Pla6qyS1CdYWI669vWojdlBCjMkHyxcj096CmvjV6MLbfE07QU9vQ8QXEJHY/eGxj38dNyvf3PRAva/U9w/zLYZVPob4athWNz4wZ+8nNfpNnH8WWUSBTI1Bbe0QxAmkLb19uVEotSXqh+B+ECGPfTi94k8G5xCgIDP9aek9gOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723638306; c=relaxed/simple;
	bh=1Dw/j48UdxRDqJKRYgj7q5HM2ueiFlcoZJrZv7kr8R8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lh2xn99VQrShtd0iMk4vmOC0Ap/1tgD4wcm/Wkn6P4zI9cjFED8EligEC8NwL+Lh+nGqchAC+PwzyENl+mO5QZEdmOibZ6HGuYU8lmTEEPA/Z/FWScK1ATYGIqgzNtBMs3fUBSlxkz1KKiO8NaIHVWbHfoxJ7S1KrU9mD6QLsDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=cCenA7zq; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="cCenA7zq"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eeb1ba0468so85554861fa.0
        for <virtualization@lists.linux.dev>; Wed, 14 Aug 2024 05:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723638303; x=1724243103; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S52UQmtDve2GuTElWtVNw+jnkE+3Yi7VlI9NDRrdB1o=;
        b=cCenA7zqnIU2gCk6dZ1gOyP2cjHWQ9whHynP5yYW7vhiZPn1rERVQFg+7OtKf01/kK
         br0Mjb0hMogQm19ICSszkFvVQwSxeYF7RYIERT/Vq/un1XOzKp8L2CC7Bo2VVJSJBn1Q
         v+m5X219fQileL3+FA/H9aPzNxwK3rp7voC/2JLWTCXortciayyyVF1DLSqh6EsM3rBy
         3B9bfVPJFdKVjOUbr/D+LQvQHVlX3oUrlQY+EV76bzRhgZNtSOxxUDOu3G7dbWXxwf8g
         r4LLC8IA3mYvnUff+ZNfDOBf4NGHeZNKd/wW5xUhu+Bcd/qrUy75oWQc//lsCDIGsQy9
         gmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723638303; x=1724243103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S52UQmtDve2GuTElWtVNw+jnkE+3Yi7VlI9NDRrdB1o=;
        b=DL56dtIRee93n4+0jCCOySLTqOxq6I8ekmUjXHgpuNu0oTWSu/SC1ek5ILlTYnA+hi
         0ogqYPN1ctqgXHLtcwEIHQP3SQayjwdT7qebrLIx8nYKnjx6d5K1EC+l6etCSDpj+nWP
         /uWt5LACoBFcmP3EGT2dfXfFLHDShkmIfm4+pFwE8/dZWvv+xRAcG6zXxzsvSlZB4ZEl
         mcB4XOLD/VQ7ANDt+tLtAnE9jpOlpZIksLcFz5Zy1NpYFolQoc/AkG457bneW28g1O1+
         vGrIA058ubpbi7gRq5tmJr16zC/150KVsBUp/2o/OEn3mAr4GMwNFQo01NRyFFdzN/br
         KR6w==
X-Gm-Message-State: AOJu0YyyKeF5cG0E/uNQZgr2wOymXASFbEe9+0H3E7GNZJ4l2hrIrhsI
	lJZEOAcniYdaQDwBNSDMr2Ngse+pAzmPeup2cuVnM4lHKjnF/rFyMpjBTZ675BBJ3vqsQedMN3G
	C
X-Google-Smtp-Source: AGHT+IEsZ0P/ZcT2HxlkYnhBvlv1QO6SpbzJkP/w0g8jQhP4RXna1e4c1UXP9w6/4buI86ihzkqYMg==
X-Received: by 2002:a2e:9804:0:b0:2ef:22e6:233f with SMTP id 38308e7fff4ca-2f3aa1d178amr16435061fa.21.1723638302429;
        Wed, 14 Aug 2024 05:25:02 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd1a6031f0sm3818678a12.85.2024.08.14.05.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 05:25:01 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	m.szyprowski@samsung.com
Subject: [PATCH net] virtio_net: move netdev_tx_reset_queue() call before RX napi enable
Date: Wed, 14 Aug 2024 14:25:00 +0200
Message-ID: <20240814122500.1710279-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

During suspend/resume the following BUG was hit:
------------[ cut here ]------------
kernel BUG at lib/dynamic_queue_limits.c:99!
Internal error: Oops - BUG: 0 [#1] SMP ARM
Modules linked in: bluetooth ecdh_generic ecc libaes
CPU: 1 PID: 1282 Comm: rtcwake Not tainted
6.10.0-rc3-00732-gc8bd1f7f3e61 #15240
Hardware name: Generic DT based system
PC is at dql_completed+0x270/0x2cc
LR is at __free_old_xmit+0x120/0x198
pc : [<c07ffa54>]    lr : [<c0c42bf4>]    psr: 80000013
...
Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 43a4406a  DAC: 00000051
...
Process rtcwake (pid: 1282, stack limit = 0xfbc21278)
Stack: (0xe0805e80 to 0xe0806000)
...
Call trace:
  dql_completed from __free_old_xmit+0x120/0x198
  __free_old_xmit from free_old_xmit+0x44/0xe4
  free_old_xmit from virtnet_poll_tx+0x88/0x1b4
  virtnet_poll_tx from __napi_poll+0x2c/0x1d4
  __napi_poll from net_rx_action+0x140/0x2b4
  net_rx_action from handle_softirqs+0x11c/0x350
  handle_softirqs from call_with_stack+0x18/0x20
  call_with_stack from do_softirq+0x48/0x50
  do_softirq from __local_bh_enable_ip+0xa0/0xa4
  __local_bh_enable_ip from virtnet_open+0xd4/0x21c
  virtnet_open from virtnet_restore+0x94/0x120
  virtnet_restore from virtio_device_restore+0x110/0x1f4
  virtio_device_restore from dpm_run_callback+0x3c/0x100
  dpm_run_callback from device_resume+0x12c/0x2a8
  device_resume from dpm_resume+0x12c/0x1e0
  dpm_resume from dpm_resume_end+0xc/0x18
  dpm_resume_end from suspend_devices_and_enter+0x1f0/0x72c
  suspend_devices_and_enter from pm_suspend+0x270/0x2a0
  pm_suspend from state_store+0x68/0xc8
  state_store from kernfs_fop_write_iter+0x10c/0x1cc
  kernfs_fop_write_iter from vfs_write+0x2b0/0x3dc
  vfs_write from ksys_write+0x5c/0xd4
  ksys_write from ret_fast_syscall+0x0/0x54
Exception stack(0xe8bf1fa8 to 0xe8bf1ff0)
...
---[ end trace 0000000000000000 ]---

After virtnet_napi_enable() is called, the following path is hit:
  __napi_poll()
    -> virtnet_poll()
      -> virtnet_poll_cleantx()
        -> netif_tx_wake_queue()

That wakes the TX queue and allows skbs to be submitted and accounted by
BQL counters.

Then netdev_tx_reset_queue() is called that resets BQL counters and
eventually leads to the BUG in dql_completed().

Move virtnet_napi_tx_enable() what does BQL counters reset before RX
napi enable to avoid the issue.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Closes: https://lore.kernel.org/netdev/e632e378-d019-4de7-8f13-07c572ab37a9@samsung.com/
Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3f10c72743e9..c6af18948092 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2867,8 +2867,8 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
 	if (err < 0)
 		goto err_xdp_reg_mem_model;
 
-	virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
 	netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, qp_index));
+	virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
 	virtnet_napi_tx_enable(vi, vi->sq[qp_index].vq, &vi->sq[qp_index].napi);
 
 	return 0;
-- 
2.45.2

