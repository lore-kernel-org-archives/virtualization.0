Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00622320A33
	for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 16:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767112141; cv=none; b=aIuMeseBJoO+Y6ZW9kYJ0SmtpkZ+VWLkC4I0FgJ8FItN7sj0w0Td8pcCXmuBFr/9ozle1IiHE2rYQXL/IOGamimDDGqfFJf3QysSve5jgtI207NVp8L8gdau9iATsC/ROrE8D0QYxlpDuyT1JTiYpyfPg2ucF3pD3zil7tSbEp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767112141; c=relaxed/simple;
	bh=KKpqZbEtskgb5NBKeJlGWbLifno9PTy5moTyS5l7PDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DOUpD0oMMhw6xuRuV9opTUUHGqTyC/dmHgx6XjwNOKAygEcmq8caTkFWcDjjKF+n7do/Zk9230eRsY8lsLTp4yDsgpFdHQQ3rgV529VD5VFg/7Jr4IgMUZdcK8h7fZds7PeE10VDHqdMdJ0DttgDllFajrKj1zv7fT/PTpuch50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5y8ec/G; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5y8ec/G"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7f651586be1so4831756b3a.1
        for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 08:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767112138; x=1767716938; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=avaMKZupKtJgQKOisKq5Lh5/+7xstw6Aa+YwOZ+A+Sg=;
        b=Y5y8ec/G2hpBGBnHtLJo8lh49+s/AUQS5p4UgplV6wYl1pfsYJzOplMFT02Y4Pt7UK
         uJTh15SIEi+kM4YIg0xH3LDKsO706CTjWEl/A40ykMtNjlPUPI21s5+DlegbXGSUPzTt
         W3GOfxpQNskwdaREl4LsRn9VgsU09zj8qxCZTp5H71AFWLowbWR/inpzm3NtN4su9kYk
         drPUhyHyx1mtO/rx6ten6P78G3X70Su+u5VS9aKOxE1gYgHAYnp2vyDk+NXP2QmYSlVp
         FRxzHn8uX7LfQeO/GOs8zrWiH3P9hSnyHnVtO3FXzWdB7ZZoFP/O19nhqw5Ez6Qv2N05
         aqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767112138; x=1767716938;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=avaMKZupKtJgQKOisKq5Lh5/+7xstw6Aa+YwOZ+A+Sg=;
        b=QB4oUGZ7z1wRrnm+Y1zIN+2/b1e9ifoZk3CAbxnR00GkKcrUO6GleQEhsGMBZ+/4rw
         u4w+RX9JRri8f9JXnOKw1yMRu6qOubCCJsHtO3IX/WjahULtsJtIN+k+jKEd+G8Evx0Y
         dqjs9taE3QCEsNwqMRqp5fNmuSsLZqxepjTWl0kAHnobvI/jXal1X29RIQqcpi3PCKFw
         y6geEsytZ9TOVrqLkKH3c/+D+defmk2NgS55WirfEcuwZ8PgYz50swzx1gClGrPu8Sfw
         0aHAXppa3QOyxslslerBZPhU0iHNbo82VMkiQy22UID+aEgs6utOFKVSNl8M61iHVZsg
         Z51A==
X-Forwarded-Encrypted: i=1; AJvYcCUnE+Q3eJxouqqeVVPj97ADgYwzcEJbZvc1ql8yebif8dN7fH7Y8JCT2ULznptoWoP8G3MM2Rlelb/5NvK0ZA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx93PiZBRFROc5DtBBBz0xxfRLLO5sLbG1SqbhLwQxm4UHvXb25
	KGAdTaQqFYaN8ozActha5AUnK6lyHMOMluk3pzbeLFUSRpi9RS1kPLfc
X-Gm-Gg: AY/fxX7YX3KfL9+RS+lmM0OBr4zzv8P7VdlpwynUN+kCtO+N07i2aq9/nIaVmGstapI
	bmQ99cxD3d5hbw3inIXHWR5b+2SaaWeQMGNSuihJOoL+5xwvIEtZXzpBidbR2GxD0ULnC27WgjX
	hUOXt3rzRFHvsN4yjpXQAQzNOhMAwh+oAYGIUVN08GD2btJWGwrjqt0pKFxAzIv5kjplNbHIJTF
	ZhPV2XWN11M06MOqJdfg+9BwbXdDWMZCzV8IcckND42jn7qEctwiVq9TSBjnXfWto43Dk4MOLAO
	Jj2ZmIpSWhu0877AfN0GvsRF5J0hu6jmdwYBXeiOKIV+J5XgihUsBd/qYt974+g1dH8n4nuBC0E
	0V/hmZKk3lRmLOvpU9lb9DVPVzaINnI7EdbKcSyIn8/4jQOcLnbXVlKeoN/2iCDDI5k2QsuFGMn
	EgLjEbaZiGqrhE805cDWojhlqYICMDJdnNJyaH22JzicF4MQnNxrIvXqjS9+ztA0l3tHsRXC8s
X-Google-Smtp-Source: AGHT+IEeIFcn942167d2Oa9jA5JH71Kb7EInHlhV/HyENTzZnTajimLC14AMzvcWvH9NUqaWmckHDQ==
X-Received: by 2002:a05:6a20:1588:b0:366:14b0:4b18 with SMTP id adf61e73a8af0-3769ff1a89amr35543258637.35.1767112138052;
        Tue, 30 Dec 2025 08:28:58 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:f996:1f74:6f8f:2cf2? ([2001:ee0:4f4c:210:f996:1f74:6f8f:2cf2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7aa328basm33010825b3a.11.2025.12.30.08.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 08:28:57 -0800 (PST)
Message-ID: <7143657a-a52f-4cff-acbc-e89f4c713cc4@gmail.com>
Date: Tue, 30 Dec 2025 23:28:50 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue
 work
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com>
 <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
 <1766540234.3618076-1-xuanzhuo@linux.alibaba.com>
 <20251223204555-mutt-send-email-mst@kernel.org>
 <CACGkMEs7_-=-8w=7gW8R_EhzfWOwuDoj4p-iCPQ7areOa9uaUw@mail.gmail.com>
 <20251225112729-mutt-send-email-mst@kernel.org>
 <CACGkMEt33BAWGmeFfHWYrjQLOT4+JB7HsWWVMKUn6yFxQ9y2gg@mail.gmail.com>
 <20251226022727-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20251226022727-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/26/25 14:37, Michael S. Tsirkin wrote:
> On Fri, Dec 26, 2025 at 09:31:26AM +0800, Jason Wang wrote:
>> On Fri, Dec 26, 2025 at 12:27 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>>> On Thu, Dec 25, 2025 at 03:33:29PM +0800, Jason Wang wrote:
>>>> On Wed, Dec 24, 2025 at 9:48 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>> On Wed, Dec 24, 2025 at 09:37:14AM +0800, Xuan Zhuo wrote:
>>>>>> Hi Jason,
>>>>>>
>>>>>> I'm wondering why we even need this refill work. Why not simply let NAPI retry
>>>>>> the refill on its next run if the refill fails? That would seem much simpler.
>>>>>> This refill work complicates maintenance and often introduces a lot of
>>>>>> concurrency issues and races.
>>>>>>
>>>>>> Thanks.
>>>>> refill work can refill from GFP_KERNEL, napi only from ATOMIC.
>>>>>
>>>>> And if GFP_ATOMIC failed, aggressively retrying might not be a great idea.
>>>> Btw, I see some drivers are doing things as Xuan said. E.g
>>>> mlx5e_napi_poll() did:
>>>>
>>>> busy |= INDIRECT_CALL_2(rq->post_wqes,
>>>>                                  mlx5e_post_rx_mpwqes,
>>>>                                  mlx5e_post_rx_wqes,
>>>>
>>>> ...
>>>>
>>>> if (busy) {
>>>>           if (likely(mlx5e_channel_no_affinity_change(c))) {
>>>>                  work_done = budget;
>>>>                  goto out;
>>>> ...
>>>
>>> is busy a GFP_ATOMIC allocation failure?
>> Yes, and I think the logic here is to fallback to ksoftirqd if the
>> allocation fails too much.
>>
>> Thanks
>
> True. I just don't know if this works better or worse than the
> current design, but it is certainly simpler and we never actually
> worried about the performance of the current one.
>
>
> So you know, let's roll with this approach.
>
> I do however ask that some testing is done on the patch forcing these OOM
> situations just to see if we are missing something obvious.
>
>
> the beauty is the patch can be very small:
> 1. patch 1 do not schedule refill ever, just retrigger napi
> 2. remove all the now dead code
>
> this way patch 1 will be small and backportable to stable.

I've tried 1. with this patch

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1bb3aeca66c6..9e890aff2d95 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3035,7 +3035,7 @@ static int virtnet_receive_packets(struct virtnet_info *vi,
  }

  static int virtnet_receive(struct receive_queue *rq, int budget,
-               unsigned int *xdp_xmit)
+               unsigned int *xdp_xmit, bool *retry_refill)
  {
      struct virtnet_info *vi = rq->vq->vdev->priv;
      struct virtnet_rq_stats stats = {};
@@ -3047,12 +3047,8 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
          packets = virtnet_receive_packets(vi, rq, budget, xdp_xmit, &stats);

      if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
-        if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
-            spin_lock(&vi->refill_lock);
-            if (vi->refill_enabled)
-                schedule_delayed_work(&vi->refill, 0);
-            spin_unlock(&vi->refill_lock);
-        }
+        if (!try_fill_recv(vi, rq, GFP_ATOMIC))
+            *retry_refill = true;
      }

      u64_stats_set(&stats.packets, packets);
@@ -3129,18 +3125,18 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
      struct send_queue *sq;
      unsigned int received;
      unsigned int xdp_xmit = 0;
-    bool napi_complete;
+    bool napi_complete, retry_refill = false;

      virtnet_poll_cleantx(rq, budget);

-    received = virtnet_receive(rq, budget, &xdp_xmit);
+    received = virtnet_receive(rq, budget, &xdp_xmit, &retry_refill);
      rq->packets_in_napi += received;

      if (xdp_xmit & VIRTIO_XDP_REDIR)
          xdp_do_flush();

      /* Out of packets? */
-    if (received < budget) {
+    if (received < budget && !retry_refill) {
          napi_complete = virtqueue_napi_complete(napi, rq->vq, received);
          /* Intentionally not taking dim_lock here. This may result in a
           * spurious net_dim call. But if that happens virtnet_rx_dim_work
@@ -3230,9 +3226,11 @@ static int virtnet_open(struct net_device *dev)

      for (i = 0; i < vi->max_queue_pairs; i++) {
          if (i < vi->curr_queue_pairs)
-            /* Make sure we have some buffers: if oom use wq. */
-            if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
-                schedule_delayed_work(&vi->refill, 0);
+            /* If this fails, we will retry later in
+             * NAPI poll, which is scheduled in the below
+             * virtnet_enable_queue_pair
+             */
+            try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);

          err = virtnet_enable_queue_pair(vi, i);
          if (err < 0)
@@ -3473,15 +3471,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
                  bool refill)
  {
      bool running = netif_running(vi->dev);
-    bool schedule_refill = false;

-    if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
-        schedule_refill = true;
+    if (refill)
+        /* If this fails, we will retry later in NAPI poll, which is
+         * scheduled in the below virtnet_napi_enable
+         */
+        try_fill_recv(vi, rq, GFP_KERNEL);
+
      if (running)
          virtnet_napi_enable(rq);
-
-    if (schedule_refill)
-        schedule_delayed_work(&vi->refill, 0);
  }

  static void virtnet_rx_resume_all(struct virtnet_info *vi)
@@ -3777,6 +3775,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
      struct virtio_net_rss_config_trailer old_rss_trailer;
      struct net_device *dev = vi->dev;
      struct scatterlist sg;
+    int i;

      if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ))
          return 0;
@@ -3829,11 +3828,8 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
      }
  succ:
      vi->curr_queue_pairs = queue_pairs;
-    /* virtnet_open() will refill when device is going to up. */
-    spin_lock_bh(&vi->refill_lock);
-    if (dev->flags & IFF_UP && vi->refill_enabled)
-        schedule_delayed_work(&vi->refill, 0);
-    spin_unlock_bh(&vi->refill_lock);
+    for (i = 0; i < vi->curr_queue_pairs; i++)
+        try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);

      return 0;
  }


But I got an issue with selftests/drivers/net/hw/xsk_reconfig.py. This
test sets up XDP zerocopy (Xsk) but does not provide any descriptors to
the fill ring. So xsk_pool does not have any descriptors and
try_fill_recv will always fail. The RX NAPI keeps polling. Later, when
we want to disable the xsk_pool, in virtnet_xsk_pool_disable path,

virtnet_xsk_pool_disable
-> virtnet_rq_bind_xsk_pool
   -> virtnet_rx_pause
     -> __virtnet_rx_pause
       -> virtnet_napi_disable
         -> napi_disable

We get stuck in napi_disable because the RX NAPI is still polling.

In drivers/net/ethernet/mellanox/mlx5, AFAICS, it uses state bit for
synchronization between xsk setup (mlx5e_xsk_setup_pool) with RX NAPI
(mlx5e_napi_poll) without using napi_disable/enable. However, in
drivers/net/ethernet/intel/ice,

ice_xsk_pool_setup
-> ice_qp_dis
   -> ice_qvec_toggle_napi
     -> napi_disable

it still uses napi_disable. Did I miss something in the above patch?
I'll try to look into using another synchronization instead of
napi_disable/enable in xsk_pool setup path too.

Thanks,
Quang Minh.

