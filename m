Return-Path: <SRS0=LeNA=B6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE66C433DF
	for <virtualization@archiver.kernel.org>; Thu, 20 Aug 2020 00:01:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80105208E4
	for <virtualization@archiver.kernel.org>; Thu, 20 Aug 2020 00:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0zWo7fq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80105208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 617AC87F53;
	Thu, 20 Aug 2020 00:01:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rsvFNMzJddj4; Thu, 20 Aug 2020 00:01:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BD44087F34;
	Thu, 20 Aug 2020 00:01:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2651C0889;
	Thu, 20 Aug 2020 00:01:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CCD82C0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Aug 2020 00:01:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A15C02036B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Aug 2020 00:01:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0Jd9+I3qx6UG
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Aug 2020 00:01:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id B429D22713
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Aug 2020 00:01:45 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8AA29208E4;
 Thu, 20 Aug 2020 00:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597881705;
 bh=iXmAtY7BG2mwDIC/wHHpkcNbC6q/kDidRTK1GVKOgL8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=0zWo7fq0cLrHlElAtTb9Mim3elpKxPdzj7sstxaldL62Tf98esOKMPiX/hsY25XPU
 tg3voCtEG+HzE35Ia07OebvxiX5lg3ufkuOF56W+pYzX65II3KNbVcwAefR8mEmvHf
 a7ezah4k4u3aRLYoKEGTnBihjHeBkujXaEamoVbI=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 21/27] virtio_ring: Avoid loop when vq is broken
 in virtqueue_poll
Date: Wed, 19 Aug 2020 20:01:10 -0400
Message-Id: <20200820000116.214821-21-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820000116.214821-1-sashal@kernel.org>
References: <20200820000116.214821-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, Mao Wenan <wenan.mao@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org,
 "Michael S . Tsirkin" <mst@redhat.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

From: Mao Wenan <wenan.mao@linux.alibaba.com>

[ Upstream commit 481a0d7422db26fb63e2d64f0652667a5c6d0f3e ]

The loop may exist if vq->broken is true,
virtqueue_get_buf_ctx_packed or virtqueue_get_buf_ctx_split
will return NULL, so virtnet_poll will reschedule napi to
receive packet, it will lead cpu usage(si) to 100%.

call trace as below:
virtnet_poll
	virtnet_receive
		virtqueue_get_buf_ctx
			virtqueue_get_buf_ctx_packed
			virtqueue_get_buf_ctx_split
	virtqueue_napi_complete
		virtqueue_poll           //return true
		virtqueue_napi_schedule //it will reschedule napi

to fix this, return false if vq is broken in virtqueue_poll.

Signed-off-by: Mao Wenan <wenan.mao@linux.alibaba.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Link: https://lore.kernel.org/r/1596354249-96204-1-git-send-email-wenan.mao@linux.alibaba.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virtio/virtio_ring.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 58b96baa8d488..4f7c73e6052f6 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1960,6 +1960,9 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned last_used_idx)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
+	if (unlikely(vq->broken))
+		return false;
+
 	virtio_mb(vq->weak_barriers);
 	return vq->packed_ring ? virtqueue_poll_packed(_vq, last_used_idx) :
 				 virtqueue_poll_split(_vq, last_used_idx);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
