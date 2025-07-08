Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0124CBA36
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Jul 2025 00:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751932944; cv=none; b=RVtDdwlWo8CyrK3BB/SGmKYpiB7gu/FGtw38zF5/qj1AZhY3riP6cGvTqi/QtfTb3a3SVozibpfG3kD9/fnIrMva9kqSUEVIn1b+5+pig3gWwefyRbKE2T1B8kKjVs/aPEmTjk1AW2Ct/1/4bHfVuOUXWtshICQ7GwcrLc8Jiws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751932944; c=relaxed/simple;
	bh=t5zmAG5UEvVd4XtHi1/WfmDFoTa8UUYg8Lwk7/npk3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PIjaOZUgw4BS/GpqDiUaU/iIQnK+aXhSXJ76Eayh6UhNUROuSkTYHXMp91Kx88+iOAfaD27n3L9DULdJ0o+xFAFDRws404jVlO5xKo2O9Z5GAsb6TM1XEAUfIFzUm5tKen/Djj9qj0tFpAvx7cdG0o8FBlJ9AtZ76I48YURHnxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNGAtzut; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNGAtzut"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 914598416F
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Jul 2025 00:02:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AhYKTf4jbtUe for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jul 2025 00:02:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashal@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A41CC8416C
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A41CC8416C
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pNGAtzut
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A41CC8416C
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Jul 2025 00:02:21 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1BB9C61120;
	Tue,  8 Jul 2025 00:02:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B14C4CEF1;
	Tue,  8 Jul 2025 00:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751932939;
	bh=t5zmAG5UEvVd4XtHi1/WfmDFoTa8UUYg8Lwk7/npk3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pNGAtzutSGSI+5bIJhYypmZDUmt9LdZkF5xEV5qZNofmWNSepe44I5Dn69u8Uzhdh
	 C9sKubCf6ph512z8wQTMmI4UFeGEhpdZQpuENi2DhRtvSVOA+QoBw55820BCSBZ0VB
	 JfwtmcSigjz1QeIk7HH1Mq2TxrqsqNj/K+ZgYSlxIT2dHo0zE1LQQA2rykfAsjWA4I
	 tryCMH98jAg5OZ8aSpKgEGofXo+BRbbssF2rtlRrQXBYHVPl/xxwdyd5Yenm3frJiF
	 a69nsERhDd3DzoXaIvTgwok1yJ7BtO28c81dFpomJFa51R2iGnXXHJLQtvdHABayJN
	 emUf0wW1PVuTA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Laurent Vivier <lvivier@redhat.com>,
	Lei Yang <leiyang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.15 2/8] virtio_net: Enforce minimum TX ring size for reliability
Date: Mon,  7 Jul 2025 20:02:09 -0400
Message-Id: <20250708000215.793090-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250708000215.793090-1-sashal@kernel.org>
References: <20250708000215.793090-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15.5
Content-Transfer-Encoding: 8bit

From: Laurent Vivier <lvivier@redhat.com>

[ Upstream commit 24b2f5df86aaebbe7bac40304eaf5a146c02367c ]

The `tx_may_stop()` logic stops TX queues if free descriptors
(`sq->vq->num_free`) fall below the threshold of (`MAX_SKB_FRAGS` + 2).
If the total ring size (`ring_num`) is not strictly greater than this
value, queues can become persistently stopped or stop after minimal
use, severely degrading performance.

A single sk_buff transmission typically requires descriptors for:
- The virtio_net_hdr (1 descriptor)
- The sk_buff's linear data (head) (1 descriptor)
- Paged fragments (up to MAX_SKB_FRAGS descriptors)

This patch enforces that the TX ring size ('ring_num') must be strictly
greater than (MAX_SKB_FRAGS + 2). This ensures that the ring is
always large enough to hold at least one maximally-fragmented packet
plus at least one additional slot.

Reported-by: Lei Yang <leiyang@redhat.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Link: https://patch.msgid.link/20250521092236.661410-4-lvivier@redhat.com
Tested-by: Lei Yang <leiyang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES**

This commit should be backported to stable kernel trees. Here's my
extensive analysis:

## 1. **Critical Bug Fix**
The commit fixes a severe bug where TX queues can become permanently
stopped, causing complete network transmission failure. Looking at the
code change, it adds a crucial validation in `virtnet_tx_resize()`:

```c
if (ring_num <= MAX_SKB_FRAGS + 2) {
    netdev_err(vi->dev, "tx size (%d) cannot be smaller than %d\n",
               ring_num, MAX_SKB_FRAGS + 2);
    return -EINVAL;
}
```

This prevents a configuration that would make the network interface
essentially unusable.

## 2. **Root Cause Analysis**
The bug occurs because the `tx_may_stop()` logic (used throughout
virtio_net for flow control) stops the TX queue when free descriptors
fall below `MAX_SKB_FRAGS + 2`. If the total ring size is not strictly
greater than this threshold, the queue can:
- Stop after transmitting just one packet
- Never have enough free slots to wake up again
- Result in a permanently stalled TX queue

## 3. **User Impact**
This affects real users who:
- Use virtio_net in virtualized environments (very common in cloud/VM
  deployments)
- Configure TX ring sizes via ethtool or other management tools
- May unknowingly set ring sizes that trigger this bug

The commit message explicitly mentions a report from Lei Yang at Red
Hat, indicating this was discovered through real-world usage.

## 4. **Minimal and Safe Fix**
The fix is:
- **Small**: Only 6 lines of code added
- **Contained**: Only affects ring resize operations
- **Safe**: Adds validation without changing existing behavior for valid
  configurations
- **Clear**: Returns -EINVAL with a descriptive error message

## 5. **Meets Stable Criteria**
According to stable kernel rules, this commit qualifies because it:
- Fixes a bug that affects users (network stalls)
- Is relatively small and contained
- Has no major side effects
- Doesn't introduce new features
- Has been tested (by Lei Yang) and reviewed by maintainers (Jason Wang,
  Michael S. Tsirkin)

## 6. **Comparison with Similar Commits**
Looking at the historical commits:
- Similar commit #3 (virtio_net: ensure netdev_tx_reset_queue) was
  backported because it fixed TX queue handling issues
- This commit is even more critical as it prevents complete TX failure
- The fix is simpler than commit #3 (just validation vs. callback
  handling)

## 7. **No Architectural Changes**
Unlike commits #1 and #2 which made architectural changes to ring
sizing, this commit:
- Only adds input validation
- Doesn't change data structures
- Doesn't modify existing workflows
- Simply prevents an invalid configuration

The fact that experienced maintainers like Jason Wang and Michael S.
Tsirkin acked this change further supports its importance for stable
backporting. This is a textbook example of a fix that should go to
stable: it addresses a real bug with minimal risk.

 drivers/net/virtio_net.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e53ba600605a5..3054b2b4f6a0c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3481,6 +3481,12 @@ static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
 {
 	int qindex, err;
 
+	if (ring_num <= MAX_SKB_FRAGS + 2) {
+		netdev_err(vi->dev, "tx size (%d) cannot be smaller than %d\n",
+			   ring_num, MAX_SKB_FRAGS + 2);
+		return -EINVAL;
+	}
+
 	qindex = sq - vi->sq;
 
 	virtnet_tx_pause(vi, sq);
-- 
2.39.5

