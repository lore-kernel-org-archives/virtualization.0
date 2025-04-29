Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDF52D5599;
	Tue, 29 Apr 2025 23:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970803; cv=none; b=Ob87A6+1YQEDaC1rxRWTNZuFZzlPtYvMA0cgIkr2SzFassWsumVc3Zctj7nntjmSryAo5mJGuaWedncaJVT+7gB+mRfWCtOArZ6n/VX/t/qhEPIpDQ3/X15ISVF8vuZel1SCNrl0GEG6uexQ8sD5KlBskgPLYvw48efxp59K87Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970803; c=relaxed/simple;
	bh=OAD7ZFG1GUYz7hjEYbrtr+kwOWUj46bWbklNEQe66lY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t4e6tR0OfVf444Keo9eAKb3VL2cTxSQT/ODOuHI7qguyOsTA1VVsQvTxBeUeR3GRSfqkPOUXIGYqRdBu4GDP05TWHjqFmY2MG38OLFTVW3oJGrWE4IZuVgAO4WXEJ5ZiJMAJHM7PPrJImxFNfp+nTsnsPAl77Z+Kkpkhm9gHeTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnbDJdDg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnbDJdDg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4404C4CEEE;
	Tue, 29 Apr 2025 23:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970802;
	bh=OAD7ZFG1GUYz7hjEYbrtr+kwOWUj46bWbklNEQe66lY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mnbDJdDgBSbxNQMhA/qxNXKiKppL59kfZDvE+YqxvXQBGttrkLdigL4CO5l0Si6Tv
	 GW8yCtxu4oRdsSb8NDG7jqgCGCeXby7HXjDFpJwLgJn/fcEgHcdS2MphhiQOnTEFL4
	 NVpEMRBGmjKaGEXbRjNfv0/0elzpF//Tn+BVSNKPZEcbnuslaAiydZ8vmwpeT1pQzT
	 2ZZhdrBXIRbi944J6ybMPEDvTwTf81eey9qzQwP3B6+ZSAEYRErFyYYuiOWSzMBsu0
	 D1/IlyXqGPPPzwaCxALM+EJjG5fIf2AMJAS81bue4PFhY171yaRYZ4I1O0yglTT1RO
	 fAboD2LYEncHg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhongqiu Han <quic_zhonhan@quicinc.com>,
	syzbot+efe683d57990864b8c8e@syzkaller.appspotmail.com,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	virtualization@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 02/10] virtio_ring: Fix data race by tagging event_triggered as racy for KCSAN
Date: Tue, 29 Apr 2025 19:53:07 -0400
Message-Id: <20250429235316.538129-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235316.538129-1-sashal@kernel.org>
References: <20250429235316.538129-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.135
Content-Transfer-Encoding: 8bit

From: Zhongqiu Han <quic_zhonhan@quicinc.com>

[ Upstream commit 2e2f925fe737576df2373931c95e1a2b66efdfef ]

syzbot reports a data-race when accessing the event_triggered, here is the
simplified stack when the issue occurred:

==================================================================
BUG: KCSAN: data-race in virtqueue_disable_cb / virtqueue_enable_cb_delayed

write to 0xffff8881025bc452 of 1 bytes by task 3288 on cpu 0:
 virtqueue_enable_cb_delayed+0x42/0x3c0 drivers/virtio/virtio_ring.c:2653
 start_xmit+0x230/0x1310 drivers/net/virtio_net.c:3264
 __netdev_start_xmit include/linux/netdevice.h:5151 [inline]
 netdev_start_xmit include/linux/netdevice.h:5160 [inline]
 xmit_one net/core/dev.c:3800 [inline]

read to 0xffff8881025bc452 of 1 bytes by interrupt on cpu 1:
 virtqueue_disable_cb_split drivers/virtio/virtio_ring.c:880 [inline]
 virtqueue_disable_cb+0x92/0x180 drivers/virtio/virtio_ring.c:2566
 skb_xmit_done+0x5f/0x140 drivers/net/virtio_net.c:777
 vring_interrupt+0x161/0x190 drivers/virtio/virtio_ring.c:2715
 __handle_irq_event_percpu+0x95/0x490 kernel/irq/handle.c:158
 handle_irq_event_percpu kernel/irq/handle.c:193 [inline]

value changed: 0x01 -> 0x00
==================================================================

When the data race occurs, the function virtqueue_enable_cb_delayed() sets
event_triggered to false, and virtqueue_disable_cb_split/packed() reads it
as false due to the race condition. Since event_triggered is an unreliable
hint used for optimization, this should only cause the driver temporarily
suggest that the device not send an interrupt notification when the event
index is used.

Fix this KCSAN reported data-race issue by explicitly tagging the access as
data_racy.

Reported-by: syzbot+efe683d57990864b8c8e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/67c7761a.050a0220.15b4b9.0018.GAE@google.com/
Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
Message-Id: <20250312130412.3516307-1-quic_zhonhan@quicinc.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virtio/virtio_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 7d320f799ca1e..06a64c4adc987 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2415,7 +2415,7 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
 	if (vq->event_triggered)
-		vq->event_triggered = false;
+		data_race(vq->event_triggered = false);
 
 	return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(_vq) :
 				 virtqueue_enable_cb_delayed_split(_vq);
-- 
2.39.5

