Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1B92C08C0
	for <virtualization@lists.linux.dev>; Thu, 27 Nov 2025 07:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764226927; cv=none; b=dSfRm78AFf1DIe/2wuCYUltBfcQOi5KpNcvuIvmFn2uZUmShDFq8nO6vFexb7HTMp2x71gRq6HJ8/z5a/xRhSjQUtJIFJy/0Hsn0xn99g9zRVj7lCh7v3ySpOIXLFGKuq8ObmiEdELbHTqU4C+LwRsRwM5AaE1hVxIkeS7Z/sUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764226927; c=relaxed/simple;
	bh=xjYmOYkC6hQCN6h0Wrd6wD3+n3RutDCKmgFu6vCgU3E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:Content-Disposition; b=qNYJCNxPpHcrgH+60Hfr5bQZnPrelmogRJxUdwe/uokLXZN3QPPDNgPTPiJz7w0TC/Q2GTJxbhlmliiHtVHBmSPVC4wcR0vZWTardETZbl54K9WsFv+xP83c1lFKtwyc5EsihupzMxjEI4yode6a9KPrMLF49/uSSAQKgLgvK7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hfnf3juB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hfnf3juB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764226924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=zSWWelL3VjQzbwp1FSCA4jXNnLH0PC4MUEaJbD9i6vM=;
	b=Hfnf3juBPkmeP7VdstvkZEPGyQPlTuGTMJX3AaOlTWZwZn+TFO52RDbzK6dYNDilntSs0F
	RcExJNgIXZsc2B2Cv9wwpL+mOkjmWK7YZhOaXqT0cs7zPbgMIJWPF2SO5w7STG1jdzCkIn
	niBOg18rXPRMNzcR70xKX0jql2Crw+0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-gAMjAOW3Nb6n5e8ouxVJ0w-1; Thu, 27 Nov 2025 02:02:02 -0500
X-MC-Unique: gAMjAOW3Nb6n5e8ouxVJ0w-1
X-Mimecast-MFC-AGG-ID: gAMjAOW3Nb6n5e8ouxVJ0w_1764226921
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4779da35d27so4934965e9.3
        for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 23:02:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764226921; x=1764831721;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSWWelL3VjQzbwp1FSCA4jXNnLH0PC4MUEaJbD9i6vM=;
        b=jHsL0Gba7TqxySTMtSgpi8wr4mAwsvhWMzW3JM87tMOJuHFLZXtdgDLegiHo0UbCgF
         iprsZ9Jc/du7IKhVb5e8nrvsdFAn9FPBCuFR2xqAmdKvrTqxvI+MTM0cgy38rF3wRCjU
         LMMw7ocxDQxudr0xo00G8gyZodvD+ZMt5xLbMfgK6bCxy4Rsd2nRtz1kg7hxbnVlu/FV
         4c6OdKzArk63hCV6uq6ByKPoXI1sMnsioToiZ5eh8isgOXQo6sZnRviETYp6ld6GJHnR
         zeFg2cDlfgKrgvba/XXDI5zGUhTAlKsGtKcgBKvtiKBWK7Z3eVku+ngTGi57iUC/D5tv
         KeWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMndlT+w3C3ByEOpkNHkb4WRpVK0ig2nZ+7QU8RmmVqgaPR6YYFRfkVL6mKi2NVE4xAbe0w4W5CoLcFEen6g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNHX0yLOO3/jk70gIoFEwtNNsivQRNMNGo0Pzb8I8OUkJNpCZ4
	S1CNpKaeFgRFeGvPtXpaK5peF+cgMc6SHWEDotjuznSSCQ2vvhDJFrV9fbywVyejgs3eP1LdVzC
	LMDOV1NLiRrmbuzCdniLawp54GI/48Ig8p6MNX9SmSj5j9OQ2qmsOXQe2VgSRcWUyfXXS
X-Gm-Gg: ASbGncspyY9048+ifP6pCWt/IiQEH6wNrJC3u/zveM4mo5uteE1jZwzON3NXbfljPFz
	N4oAJ7Fx0JyqODFRA2EhiMWLcn+Usc7XM23mZRwhbwsjqQ0G7VZ0QxxPhJ2GgVS1tqo2g1ZMhUL
	j7TkzkE2ThJ/w2rTFN+6vZRZy0Sr2zgKWlvAk7zI/jzM/X1fOMnBtEGQEnKpGoi8fQ0CaqBznb2
	xvQVPq93BMmTVO6jYC3tXusWdLtwIj2AH2VkfJSxXwrdtv806gtegOREKM/IjcfdnORbHhi4Fsn
	FhEu/t93foabv3Pvt/2a2ydSrY2e+pdJJ7pO6OYjhi6yWmAvfhNIsqpQpaAkvOONpyA86DZaiA/
	I8wAjfplEpQpCC3Qeyt3t2U3Ml55h7w==
X-Received: by 2002:a05:600c:4e91:b0:477:7a95:b971 with SMTP id 5b1f17b1804b1-47904b2c3dfmr100075785e9.31.1764226920839;
        Wed, 26 Nov 2025 23:02:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeJSq2o5Jh57pm1UqzfET6pe+NMDqgpP0OpHkh/lilO5EV4Yb7bQ/OQj6YpndJYbLTati9Ig==
X-Received: by 2002:a05:600c:4e91:b0:477:7a95:b971 with SMTP id 5b1f17b1804b1-47904b2c3dfmr100075365e9.31.1764226920341;
        Wed, 26 Nov 2025 23:02:00 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479111438b9sm17019475e9.2.2025.11.26.23.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 23:01:59 -0800 (PST)
Date: Thu, 27 Nov 2025 02:01:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Bui Quang Minh <minhquangbui99@gmail.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH RFC] virtio_net: gate delayed refill scheduling
Message-ID: <40af2b73239850e7bf1a81abb71ee99f1b563b9c.1764226734.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <526b5396-459d-4d02-8635-a222d07b46d7@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i6BZtxqnZ6WH6s_o0zLjNOsd6KINViMHXkA_9VRBUhg_1764226921
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Make the delayed refill worker honor the "refill_enabled" flag by
checking it under refill_lock before requeueing itself. This
prevents a window where virtnet_rx_pause[_all]() disables NAPI and
synchronously waits for the current refill_work instance to finish only
for that instance to immediately arm another run, which then deadlocks
when it tries to double-disable NAPI.

Add and use a helper that encapsulates the locking and flag check so all
refill scheduling paths behave consistently and we no longer replicate
the spin_lock/unlock pattern.

This fixes the deadlock triggered by the XDP selftests when XDP is toggled
and RX is paused/resumed quickly.

Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
Reported-by: Paolo Abeni <pabeni@redhat.com>
Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Lightly tested.

Paolo is there a way to confirm this actually fixes the bug?
Could you help with that?

 drivers/net/virtio_net.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 8855a994e12b..e2bfe8337f50 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -734,6 +734,15 @@ static void disable_delayed_refill(struct virtnet_info *vi)
 	spin_unlock_bh(&vi->refill_lock);
 }
 
+static void virtnet_schedule_refill_work(struct virtnet_info *vi,
+					 unsigned long delay)
+{
+	spin_lock_bh(&vi->refill_lock);
+	if (vi->refill_enabled)
+		schedule_delayed_work(&vi->refill, delay);
+	spin_unlock_bh(&vi->refill_lock);
+}
+
 static void enable_rx_mode_work(struct virtnet_info *vi)
 {
 	rtnl_lock();
@@ -2959,7 +2968,7 @@ static void refill_work(struct work_struct *work)
 		 * we will *never* try to fill again.
 		 */
 		if (still_empty)
-			schedule_delayed_work(&vi->refill, HZ/2);
+			virtnet_schedule_refill_work(vi, HZ/2);
 	}
 }
 
@@ -3026,12 +3035,8 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 		packets = virtnet_receive_packets(vi, rq, budget, xdp_xmit, &stats);
 
 	if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
-		if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
-			spin_lock(&vi->refill_lock);
-			if (vi->refill_enabled)
-				schedule_delayed_work(&vi->refill, 0);
-			spin_unlock(&vi->refill_lock);
-		}
+		if (!try_fill_recv(vi, rq, GFP_ATOMIC))
+			virtnet_schedule_refill_work(vi, 0);
 	}
 
 	u64_stats_set(&stats.packets, packets);
@@ -3216,7 +3221,7 @@ static int virtnet_open(struct net_device *dev)
 		if (i < vi->curr_queue_pairs)
 			/* Make sure we have some buffers: if oom use wq. */
 			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
-				schedule_delayed_work(&vi->refill, 0);
+				virtnet_schedule_refill_work(vi, 0);
 
 		err = virtnet_enable_queue_pair(vi, i);
 		if (err < 0)
@@ -3469,7 +3474,7 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
 		virtnet_napi_enable(rq);
 
 	if (schedule_refill)
-		schedule_delayed_work(&vi->refill, 0);
+		virtnet_schedule_refill_work(vi, 0);
 }
 
 static void virtnet_rx_resume_all(struct virtnet_info *vi)
@@ -3815,10 +3820,8 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 succ:
 	vi->curr_queue_pairs = queue_pairs;
 	/* virtnet_open() will refill when device is going to up. */
-	spin_lock_bh(&vi->refill_lock);
-	if (dev->flags & IFF_UP && vi->refill_enabled)
-		schedule_delayed_work(&vi->refill, 0);
-	spin_unlock_bh(&vi->refill_lock);
+	if (dev->flags & IFF_UP)
+		virtnet_schedule_refill_work(vi, 0);
 
 	return 0;
 }
-- 
MST

