Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8DD14A91
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 06:29:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 08793813DC
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 06:29:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 08793813DC
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.899
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jgIxVhHKc8Rw
	for <virtualization@lists.linux-foundation.org>;
	Thu,  7 Dec 2023 06:29:28 +0000 (UTC)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 01D1A81392
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 06:29:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 01D1A81392
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vy-mJp0_1701930560;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0Vy-mJp0_1701930560)
          by smtp.aliyun-inc.com;
          Thu, 07 Dec 2023 14:29:21 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Cc: jasowang@redhat.com,
	mst@redhat.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	yinjun.zhang@corigine.com,
	edumazet@google.com,
	davem@davemloft.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	ast@kernel.org,
	horms@kernel.org,
	xuanzhuo@linux.alibaba.com
Subject: [PATCH net-next v7 0/4] virtio-net: support dynamic coalescing moderation
Date: Thu,  7 Dec 2023 14:29:16 +0800
Message-Id: <cover.1701929854.git.hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now, virtio-net already supports per-queue moderation parameter
setting. Based on this, we use the linux dimlib to support
dynamic coalescing moderation for virtio-net.

Due to some scheduling issues, we only support and test the rx dim.

Some test results:

I. Sockperf UDP
=================================================
1. Env
rxq_0 with affinity to cpu_0.

2. Cmd
client: taskset -c 0 sockperf tp -p 8989 -i $IP -t 10 -m 16B
server: taskset -c 0 sockperf sr -p 8989

3. Result
dim off: 1143277.00 rxpps, throughput 17.844 MBps, cpu is 100%.
dim on:  1124161.00 rxpps, throughput 17.610 MBps, cpu is 83.5%.
=================================================

II. Redis
=================================================
1. Env
There are 8 rxqs, and rxq_i with affinity to cpu_i.

2. Result
When all cpus are 100%, ops/sec of memtier_benchmark client is
dim off:  978437.23
dim on:  1143638.28
=================================================

III. Nginx
=================================================
1. Env
There are 8 rxqs and rxq_i with affinity to cpu_i.

2. Result
When all cpus are 100%, requests/sec of wrk client is
dim off:  877931.67
dim on:  1019160.31
=================================================

IV. Latency of sockperf udp
=================================================
1. Rx cmd
taskset -c 0 sockperf sr -p 8989

2. Tx cmd
taskset -c 0 sockperf pp -i ${ip} -p 8989 -t 10

After running this cmd 5 times and averaging the results,

3. Result
dim off: 17.7735 usec
dim on:  18.0110 usec
=================================================

Changelog:
v6->v7:
- Drop the patch titled "spin lock for ctrl cmd access"
- Use rtnl_trylock to avoid the deadlock.

v5->v6:
- Add patch(4/5): spin lock for ctrl cmd access
- Patch(5/5):
   - Use spin lock and cancel_work_sync to synchronize

v4->v5:
- Patch(4/4):
   - Fix possible synchronization issues with cancel_work_sync.
   - Reduce if/else nesting levels

v3->v4:
- Patch(5/5): drop.

v2->v3:
- Patch(4/5): some minor modifications.

v1->v2:
- Patch(2/5): a minor fix.
- Patch(4/5):
   - improve the judgment of dim switch conditions.
   - Cancel the work when vq reset. 
- Patch(5/5): drop the tx dim implementation.

Heng Qi (4):
  virtio-net: returns whether napi is complete
  virtio-net: separate rx/tx coalescing moderation cmds
  virtio-net: extract virtqueue coalescig cmd for reuse
  virtio-net: support rx netdim

 drivers/net/virtio_net.c | 297 ++++++++++++++++++++++++++++++++-------
 1 file changed, 248 insertions(+), 49 deletions(-)

-- 
2.19.1.6.gb485710b

