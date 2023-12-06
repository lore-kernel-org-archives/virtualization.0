Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C062D033
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Dec 2023 13:03:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A13081414
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Dec 2023 13:03:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0A13081414
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.899
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ytnLRHmnf18x
	for <virtualization@lists.linux-foundation.org>;
	Wed,  6 Dec 2023 13:03:43 +0000 (UTC)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 00FC9813D2
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Dec 2023 13:03:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 00FC9813D2
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VxyAbfg_1701867815;
Received: from 30.221.145.130(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VxyAbfg_1701867815)
          by smtp.aliyun-inc.com;
          Wed, 06 Dec 2023 21:03:36 +0800
Message-ID: <fbea1040-cf84-45e0-b0f5-1d7752339479@linux.alibaba.com>
Date: Wed, 6 Dec 2023 21:03:31 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 4/5] virtio-net: add spin lock for ctrl cmd
 access
To: Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 mst@redhat.com, kuba@kernel.org, yinjun.zhang@corigine.com,
 edumazet@google.com, davem@davemloft.net, hawk@kernel.org,
 john.fastabend@gmail.com, ast@kernel.org, horms@kernel.org,
 xuanzhuo@linux.alibaba.com
References: <cover.1701762688.git.hengqi@linux.alibaba.com>
 <245ea32fe5de5eb81b1ed8ec9782023af074e137.1701762688.git.hengqi@linux.alibaba.com>
 <CACGkMEurTAGj+mSEtAiYtGfqy=6sU33xVskAZH47qUi+GcyvWA@mail.gmail.com>
 <ad02f02a-b08f-4061-9aba-cadef02641c8@linux.alibaba.com>
 <f36e686e13142d885a6e34f0a4dc2e33567ef287.camel@redhat.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <f36e686e13142d885a6e34f0a4dc2e33567ef287.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2023/12/6 下午8:27, Paolo Abeni 写道:
> On Tue, 2023-12-05 at 19:05 +0800, Heng Qi wrote:
>> 在 2023/12/5 下午4:35, Jason Wang 写道:
>>> On Tue, Dec 5, 2023 at 4:02 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>>> Currently access to ctrl cmd is globally protected via rtnl_lock and works
>>>> fine. But if dim work's access to ctrl cmd also holds rtnl_lock, deadlock
>>>> may occur due to cancel_work_sync for dim work.
>>> Can you explain why?
>> For example, during the bus unbind operation, the following call stack
>> occurs:
>> virtnet_remove -> unregister_netdev -> rtnl_lock[1] -> virtnet_close ->
>> cancel_work_sync -> virtnet_rx_dim_work -> rtnl_lock[2] (deadlock occurs).
>>
>>>> Therefore, treating
>>>> ctrl cmd as a separate protection object of the lock is the solution and
>>>> the basis for the next patch.
>>> Let's don't do that. Reasons are:
>>>
>>> 1) virtnet_send_command() may wait for cvq commands for an indefinite time
>> Yes, I took that into consideration. But ndo_set_rx_mode's need for an
>> atomic
>> environment rules out the mutex lock.
>>
>>> 2) hold locks may complicate the future hardening works around cvq
>> Agree, but I don't seem to have thought of a better way besides passing
>> the lock.
>> Do you have any other better ideas or suggestions?
> What about:
>
> - using the rtnl lock only
> - virtionet_close() invokes cancel_work(), without flushing the work
> - virtnet_remove() calls flush_work() after unregister_netdev(),
> outside the rtnl lock
>
> Should prevent both the deadlock and the UaF.


Hi, Paolo and Jason!

Thank you very much for your effective suggestions, but I found another 
solution[1],
based on the ideas of rtnl_trylock and refill_work, which works very well:

[1]
+static void virtnet_rx_dim_work(struct work_struct *work)
+{
+    struct dim *dim = container_of(work, struct dim, work);
+    struct receive_queue *rq = container_of(dim,
+            struct receive_queue, dim);
+    struct virtnet_info *vi = rq->vq->vdev->priv;
+    struct net_device *dev = vi->dev;
+    struct dim_cq_moder update_moder;
+    int i, qnum, err;
+
+    if (!rtnl_trylock())
+        return;
+
+    for (i = 0; i < vi->curr_queue_pairs; i++) {
+        rq = &vi->rq[i];
+        dim = &rq->dim;
+        qnum = rq - vi->rq;
+
+        if (!rq->dim_enabled)
+            continue;
+
+        update_moder = net_dim_get_rx_moderation(dim->mode, 
dim->profile_ix);
+        if (update_moder.usec != rq->intr_coal.max_usecs ||
+            update_moder.pkts != rq->intr_coal.max_packets) {
+            err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, qnum,
+                                   update_moder.usec,
+                                   update_moder.pkts);
+            if (err)
+                pr_debug("%s: Failed to send dim parameters on rxq%d\n",
+                     dev->name, qnum);
+            dim->state = DIM_START_MEASURE;
+        }
+    }
+
+    rtnl_unlock();
+}


In addition, other optimizations[2] have been tried, but it may be due 
to the sparsely
scheduled work that the retry condition is always satisfied, affecting 
performance,
so [1] is the final solution:

[2]

+static void virtnet_rx_dim_work(struct work_struct *work)
+{
+    struct dim *dim = container_of(work, struct dim, work);
+    struct receive_queue *rq = container_of(dim,
+            struct receive_queue, dim);
+    struct virtnet_info *vi = rq->vq->vdev->priv;
+    struct net_device *dev = vi->dev;
+    struct dim_cq_moder update_moder;
+    int i, qnum, err, count;
+
+    if (!rtnl_trylock())
+        return;
+retry:
+    count = vi->curr_queue_pairs;
+    for (i = 0; i < vi->curr_queue_pairs; i++) {
+        rq = &vi->rq[i];
+        dim = &rq->dim;
+        qnum = rq - vi->rq;
+        update_moder = net_dim_get_rx_moderation(dim->mode, 
dim->profile_ix);
+        if (update_moder.usec != rq->intr_coal.max_usecs ||
+            update_moder.pkts != rq->intr_coal.max_packets) {
+            --count;
+            err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, qnum,
+                                   update_moder.usec,
+                                   update_moder.pkts);
+            if (err)
+                pr_debug("%s: Failed to send dim parameters on rxq%d\n",
+                     dev->name, qnum);
+            dim->state = DIM_START_MEASURE;
+        }
+    }
+
+    if (need_resched()) {
+        rtnl_unlock();
+        schedule();
+    }
+
+    if (count)
+        goto retry;
+
+    rtnl_unlock();
+}

Thanks a lot!

>
> Side note: for this specific case any functional test with a
> CONFIG_LOCKDEP enabled build should suffice to catch the deadlock
> scenario above.
>
> Cheers,
>
> Paolo

