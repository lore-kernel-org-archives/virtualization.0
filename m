Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD23205AC5
	for <virtualization@lists.linux.dev>; Thu, 10 Apr 2025 07:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744268767; cv=none; b=NRxf0BNrU6iWlXbcqXNc0kuq5FCdSUO9h8twcxTYpQwJ6B6Q8/Ad0S4mAbxiEpMMzT+mx+gleH0IkFlMBj7wwPM0HYhlMKnL7/nmBgphjyxY3K+qO+qAWsBy+clanqrUPU9YiyrMSIj3+z1Aw9m8tBDiAHns641RRSFcggdlrYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744268767; c=relaxed/simple;
	bh=H29HGz5dCVdWsyu4NNvoXXnk11dPJ6OVdf1MoeVHmj0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ywcy8/hz52umtMsmr0QJF/1o6lsc4T+vdl2Eox/eNLkVsj841XUYSyxdFh7iPizqjC7wS1svO/GoQk8q8XoaSJFZkdCiFWU4EBwHHAuIjm389DdyjMYSD+b7U290nbabY/0Ph1dG1gUMDPooWOj8aB5ZFjgvdb5QmgeLEIxXje4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMWXHJLt; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMWXHJLt"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-af51596da56so473426a12.0
        for <virtualization@lists.linux.dev>; Thu, 10 Apr 2025 00:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744268765; x=1744873565; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mtO4Cd3eyEjzyUiq+HOYkzpvu70Qjvaf96k0H5Kwoi8=;
        b=lMWXHJLtBZsAbl0ikqpd0NEi0M9QTqBL96BNf+h6W1W3UBMYIhSbMrf5Z7hZs0b74t
         aBt+zMBqbtj0Q/YBRmGz6OWyrvyW93vIhX+O6tO6HDp9UoZP+PVFUKABZVEp2/TE3Mfb
         TrNk4+k95JOUHfjdhhMNgyYwmOhSj8dzqeEmuQ7tS71PIfdSTArHhzWx/kF3lXRT+rwU
         Rn7rmd/IB7kh5hcZaNTZi7Tn/0nNZbqIGCDfEMxbc4BL0cLAesETIbXJ2x29Jd98jVKf
         g2bf1636b8ymMrmMzbsu3/+PivaCsH+HPNml1YIM1uORVIIm1Xmlrv6omsgXZqIDrq22
         a55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744268765; x=1744873565;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mtO4Cd3eyEjzyUiq+HOYkzpvu70Qjvaf96k0H5Kwoi8=;
        b=pxaxNQdcIhctDnbuuiAnztZ4OUgatrN+pwhlOxsfMk5o2DV5Q81tYuymTqUQCjzwdz
         a2VIr8DF1PDBVrFMLbp3eN1AFkih9y5HDpvVTPuAOimHdKhl9kj74k32i7rE9/KqmF31
         JfmO8TV1CP9kM3UuZPoz20gvfh3N+sCSWocpNJUsqLt2u7KvTVLsJ9aZW8vNjg6BbjD3
         bTIBtU6X6+aKjZB10rOhBnBYcrxSul2MreWLJaDsDLE+yQRmsrEWKrlQ2hPGJkU3pI1Z
         k0LPPIu8zC6kHeMBggI4BH57EL6+oSWX7eZLoxUq/9J1BfQ9P5gp2leqvHdf4hqMUzNi
         A7iA==
X-Forwarded-Encrypted: i=1; AJvYcCXCs+MKGQwiQS2GCENpv6iOXiYwSswYWJuMfp/3/gM369CelvkJBFGR8Oe+GydhlOdrk0pxOnTWdvQk3ipBlA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywzrg+/tLd+k8FXOOm1pqdQ7bD92hfbRjAglI7zkHXqOVxt288S
	YCdwjOwXbsNEdzro0x9WTWuC18IAHfQc9E4fLlcXE2zaxRDO7i0j
X-Gm-Gg: ASbGnctZMVNcBurs1MayWHq773ThmiYFEevemHjRXSQPjCmqUTHiJ/DinEa4yDFiA44
	NpLxJUG9hogCkk51tIoljGTUh+F+zoDIp2QlaonvuXmr9ypdNXd8UJJG+GGx8moAuldEkngqMjq
	fvjFqqUQ45UrkjjOSyYh01K/SWq0uKBYSOM4w1pNlm/Ifg5pWgyUq2U7+ElC0mgk3AhWJ2NoNRk
	ovK8VfHbrHnCd1mZtIkQtqeDEQs7vJneXMf00WdpKRPNwyA6zoHc0n/L1JXvifgc7UVmToYkgl+
	1+XU78lcktGpUmJSYEPyfZGzX+57nvqzxH/Lj0UzaC2zUxhfWejkwDsOFQiZsRQ2nKnSYiWYDHM
	xx7wGBUE/zTYfUyTC+JY=
X-Google-Smtp-Source: AGHT+IFC012ePYdg9YU5IJdv9OMsXwY8Yly4PrymASzDBwjSbXzE/FE47Ok1P78B+yqAZ9Z6q4iZ6w==
X-Received: by 2002:a05:6a21:9007:b0:1f5:93b1:6a58 with SMTP id adf61e73a8af0-2016cc5eedbmr2153249637.8.1744268765300;
        Thu, 10 Apr 2025 00:06:05 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:959f:bd4a:33b6:cab1? ([2001:ee0:4f0e:fb30:959f:bd4a:33b6:cab1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a322117bsm1978174a12.64.2025.04.10.00.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 00:06:04 -0700 (PDT)
Message-ID: <4d3a1478-b6fc-47a3-8d77-7eca6a973a06@gmail.com>
Date: Thu, 10 Apr 2025 14:05:57 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] virtio-net: hold netdev_lock when pausing rx
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20250404093903.37416-1-minhquangbui99@gmail.com>
 <1743987836.9938157-1-xuanzhuo@linux.alibaba.com>
 <30419bd6-13b1-4426-9f93-b38b66ef7c3a@gmail.com>
 <CACGkMEs7O7D5sztwJVn45c+1pap20Oi5f=02Sy_qxFjbeHuYiQ@mail.gmail.com>
 <4195db62-db43-4d61-88c3-7a7fbb164726@gmail.com>
 <b7b1f5de-7003-4960-a9d1-883bf2f1aa77@gmail.com>
Content-Language: en-US
In-Reply-To: <b7b1f5de-7003-4960-a9d1-883bf2f1aa77@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

When pausing rx (e.g. set up xdp, xsk pool, rx resize), we call
napi_disable() on the receive queue's napi. In delayed refill_work, it
also calls napi_disable() on the receive queue's napi. When
napi_disable() is called on an already disabled napi, it will sleep in
napi_disable_locked while still holding the netdev_lock. As a result,
later napi_enable gets stuck too as it cannot acquire the netdev_lock.
This leads to refill_work and the pause-then-resume tx are stuck
altogether.

This scenario can be reproducible by binding a XDP socket to virtio-net
interface without setting up the fill ring. As a result, try_fill_recv
will fail until the fill ring is set up and refill_work is scheduled.

This commit makes the pausing rx path hold the netdev_lock until
resuming, prevent any napi_disable() to be called on a temporarily
disabled napi.

Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
  drivers/net/virtio_net.c | 74 +++++++++++++++++++++++++---------------
  1 file changed, 47 insertions(+), 27 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7e4617216a4b..74bd1065c586 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2786,9 +2786,13 @@ static void skb_recv_done(struct virtqueue *rvq)
  }

  static void virtnet_napi_do_enable(struct virtqueue *vq,
-                   struct napi_struct *napi)
+                   struct napi_struct *napi,
+                   bool netdev_locked)
  {
-    napi_enable(napi);
+    if (netdev_locked)
+        napi_enable_locked(napi);
+    else
+        napi_enable(napi);

      /* If all buffers were filled by other side before we napi_enabled, we
       * won't get another interrupt, so process any outstanding packets 
now.
@@ -2799,16 +2803,16 @@ static void virtnet_napi_do_enable(struct 
virtqueue *vq,
      local_bh_enable();
  }

-static void virtnet_napi_enable(struct receive_queue *rq)
+static void virtnet_napi_enable(struct receive_queue *rq, bool 
netdev_locked)
  {
      struct virtnet_info *vi = rq->vq->vdev->priv;
      int qidx = vq2rxq(rq->vq);

-    virtnet_napi_do_enable(rq->vq, &rq->napi);
+    virtnet_napi_do_enable(rq->vq, &rq->napi, netdev_locked);
      netif_queue_set_napi(vi->dev, qidx, NETDEV_QUEUE_TYPE_RX, &rq->napi);
  }

-static void virtnet_napi_tx_enable(struct send_queue *sq)
+static void virtnet_napi_tx_enable(struct send_queue *sq, bool 
netdev_locked)
  {
      struct virtnet_info *vi = sq->vq->vdev->priv;
      struct napi_struct *napi = &sq->napi;
@@ -2825,11 +2829,11 @@ static void virtnet_napi_tx_enable(struct 
send_queue *sq)
          return;
      }

-    virtnet_napi_do_enable(sq->vq, napi);
+    virtnet_napi_do_enable(sq->vq, napi, netdev_locked);
      netif_queue_set_napi(vi->dev, qidx, NETDEV_QUEUE_TYPE_TX, napi);
  }

-static void virtnet_napi_tx_disable(struct send_queue *sq)
+static void virtnet_napi_tx_disable(struct send_queue *sq, bool 
netdev_locked)
  {
      struct virtnet_info *vi = sq->vq->vdev->priv;
      struct napi_struct *napi = &sq->napi;
@@ -2837,18 +2841,24 @@ static void virtnet_napi_tx_disable(struct 
send_queue *sq)

      if (napi->weight) {
          netif_queue_set_napi(vi->dev, qidx, NETDEV_QUEUE_TYPE_TX, NULL);
-        napi_disable(napi);
+        if (netdev_locked)
+            napi_disable_locked(napi);
+        else
+            napi_disable(napi);
      }
  }

-static void virtnet_napi_disable(struct receive_queue *rq)
+static void virtnet_napi_disable(struct receive_queue *rq, bool 
netdev_locked)
  {
      struct virtnet_info *vi = rq->vq->vdev->priv;
      struct napi_struct *napi = &rq->napi;
      int qidx = vq2rxq(rq->vq);

      netif_queue_set_napi(vi->dev, qidx, NETDEV_QUEUE_TYPE_RX, NULL);
-    napi_disable(napi);
+    if (netdev_locked)
+        napi_disable_locked(napi);
+    else
+        napi_disable(napi);
  }

  static void refill_work(struct work_struct *work)
@@ -2875,9 +2885,11 @@ static void refill_work(struct work_struct *work)
           *     instance lock)
           *   - check netif_running() and return early to avoid a race
           */
-        napi_disable(&rq->napi);
+        netdev_lock(vi->dev);
+        napi_disable_locked(&rq->napi);
          still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
-        virtnet_napi_do_enable(rq->vq, &rq->napi);
+        virtnet_napi_do_enable(rq->vq, &rq->napi, true);
+        netdev_unlock(vi->dev);

          /* In theory, this can happen: if we don't get any buffers in
           * we will *never* try to fill again.
@@ -3074,8 +3086,8 @@ static int virtnet_poll(struct napi_struct *napi, 
int budget)

  static void virtnet_disable_queue_pair(struct virtnet_info *vi, int 
qp_index)
  {
-    virtnet_napi_tx_disable(&vi->sq[qp_index]);
-    virtnet_napi_disable(&vi->rq[qp_index]);
+    virtnet_napi_tx_disable(&vi->sq[qp_index], false);
+    virtnet_napi_disable(&vi->rq[qp_index], false);
      xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
  }

@@ -3094,8 +3106,8 @@ static int virtnet_enable_queue_pair(struct 
virtnet_info *vi, int qp_index)
      if (err < 0)
          goto err_xdp_reg_mem_model;

-    virtnet_napi_enable(&vi->rq[qp_index]);
-    virtnet_napi_tx_enable(&vi->sq[qp_index]);
+    virtnet_napi_enable(&vi->rq[qp_index], false);
+    virtnet_napi_tx_enable(&vi->sq[qp_index], false);

      return 0;

@@ -3347,7 +3359,8 @@ static void virtnet_rx_pause(struct virtnet_info 
*vi, struct receive_queue *rq)
      bool running = netif_running(vi->dev);

      if (running) {
-        virtnet_napi_disable(rq);
+        netdev_lock(vi->dev);
+        virtnet_napi_disable(rq, true);
          virtnet_cancel_dim(vi, &rq->dim);
      }
  }
@@ -3359,8 +3372,10 @@ static void virtnet_rx_resume(struct virtnet_info 
*vi, struct receive_queue *rq)
      if (!try_fill_recv(vi, rq, GFP_KERNEL))
          schedule_delayed_work(&vi->refill, 0);

-    if (running)
-        virtnet_napi_enable(rq);
+    if (running) {
+        virtnet_napi_enable(rq, true);
+        netdev_unlock(vi->dev);
+    }
  }

  static int virtnet_rx_resize(struct virtnet_info *vi,
@@ -3389,7 +3404,7 @@ static void virtnet_tx_pause(struct virtnet_info 
*vi, struct send_queue *sq)
      qindex = sq - vi->sq;

      if (running)
-        virtnet_napi_tx_disable(sq);
+        virtnet_napi_tx_disable(sq, false);

      txq = netdev_get_tx_queue(vi->dev, qindex);

@@ -3423,7 +3438,7 @@ static void virtnet_tx_resume(struct virtnet_info 
*vi, struct send_queue *sq)
      __netif_tx_unlock_bh(txq);

      if (running)
-        virtnet_napi_tx_enable(sq);
+        virtnet_napi_tx_enable(sq, false);
  }

  static int virtnet_tx_resize(struct virtnet_info *vi, struct 
send_queue *sq,
@@ -5961,9 +5976,10 @@ static int virtnet_xdp_set(struct net_device 
*dev, struct bpf_prog *prog,

      /* Make sure NAPI is not using any XDP TX queues for RX. */
      if (netif_running(dev)) {
+        netdev_lock(dev);
          for (i = 0; i < vi->max_queue_pairs; i++) {
-            virtnet_napi_disable(&vi->rq[i]);
-            virtnet_napi_tx_disable(&vi->sq[i]);
+            virtnet_napi_disable(&vi->rq[i], true);
+            virtnet_napi_tx_disable(&vi->sq[i], true);
          }
      }

@@ -6000,11 +6016,14 @@ static int virtnet_xdp_set(struct net_device 
*dev, struct bpf_prog *prog,
          if (old_prog)
              bpf_prog_put(old_prog);
          if (netif_running(dev)) {
-            virtnet_napi_enable(&vi->rq[i]);
-            virtnet_napi_tx_enable(&vi->sq[i]);
+            virtnet_napi_enable(&vi->rq[i], true);
+            virtnet_napi_tx_enable(&vi->sq[i], true);
          }
      }

+    if (netif_running(dev))
+        netdev_unlock(dev);
+
      return 0;

  err:
@@ -6016,9 +6035,10 @@ static int virtnet_xdp_set(struct net_device 
*dev, struct bpf_prog *prog,

      if (netif_running(dev)) {
          for (i = 0; i < vi->max_queue_pairs; i++) {
-            virtnet_napi_enable(&vi->rq[i]);
-            virtnet_napi_tx_enable(&vi->sq[i]);
+            virtnet_napi_enable(&vi->rq[i], true);
+            virtnet_napi_tx_enable(&vi->sq[i], true);
          }
+        netdev_unlock(dev);
      }
      if (prog)
          bpf_prog_sub(prog, vi->max_queue_pairs - 1);
-- 
2.43.0


