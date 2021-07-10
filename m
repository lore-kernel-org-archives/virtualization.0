Return-Path: <SRS0=s3M2=MC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB70DC11F6F
	for <virtualization@archiver.kernel.org>; Sat, 10 Jul 2021 23:50:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69B5561154
	for <virtualization@archiver.kernel.org>; Sat, 10 Jul 2021 23:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69B5561154
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4B18783AC8;
	Sat, 10 Jul 2021 23:50:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FFmQn86y5RG3; Sat, 10 Jul 2021 23:50:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C287983AB5;
	Sat, 10 Jul 2021 23:50:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9933C0010;
	Sat, 10 Jul 2021 23:50:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E11AC000E
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Jul 2021 23:50:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1C23C404E0
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Jul 2021 23:50:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3F3iq6--b_IU
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Jul 2021 23:50:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E80D0404A0
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Jul 2021 23:50:12 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE14961355;
 Sat, 10 Jul 2021 23:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625961012;
 bh=HOxSyPrt04JCbP6msvV7QklAOcAnbKgXxpTQnRh46tI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JWCchJ8gB9juOrF6tEwdaMiiULSicP5443SSuV1DJZEdPfaIr8jSpEqFT1Vt9Uahk
 MHDaZTvu4ZTWwSaMxOcHvlpIuZle5+ThkLAoLwFT2QH7LO1g2jdSVcPy//u1frsPRI
 6QDpfQ7ZRuPu+dseFTxCU85+uOYCMPl2o0jfA+2xkR4ukuO5S4Z7IkIetPN1nXtGH7
 qZN3VFhTb6AGauxEVbfY0PvEj1HFpN67q9TfQS6+L+2UARAwEJBzp6uhF0y/EY3A32
 fuaUAHuWf+8gTOVmJfuMpVPaCDRyddkQAyMLrA33/o7zGyxd/ysHr/OYomLbFJ6T79
 lTRbJjOa7PAqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 41/43] virtio_console: Assure used length from
 device is limited
Date: Sat, 10 Jul 2021 19:49:13 -0400
Message-Id: <20210710234915.3220342-41-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710234915.3220342-1-sashal@kernel.org>
References: <20210710234915.3220342-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, Xie Yongji <xieyongji@bytedance.com>,
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

From: Xie Yongji <xieyongji@bytedance.com>

[ Upstream commit d00d8da5869a2608e97cfede094dfc5e11462a46 ]

The buf->len might come from an untrusted device. This
ensures the value would not exceed the size of the buffer
to avoid data corruption or loss.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Link: https://lore.kernel.org/r/20210525125622.1203-1-xieyongji@bytedance.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/virtio_console.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 1836cc56e357..673522874cec 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -475,7 +475,7 @@ static struct port_buffer *get_inbuf(struct port *port)
 
 	buf = virtqueue_get_buf(port->in_vq, &len);
 	if (buf) {
-		buf->len = len;
+		buf->len = min_t(size_t, len, buf->size);
 		buf->offset = 0;
 		port->stats.bytes_received += len;
 	}
@@ -1712,7 +1712,7 @@ static void control_work_handler(struct work_struct *work)
 	while ((buf = virtqueue_get_buf(vq, &len))) {
 		spin_unlock(&portdev->c_ivq_lock);
 
-		buf->len = len;
+		buf->len = min_t(size_t, len, buf->size);
 		buf->offset = 0;
 
 		handle_control_message(vq->vdev, portdev, buf);
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
