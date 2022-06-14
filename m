Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F993C43334
	for <virtualization@archiver.kernel.org>; Tue, 14 Jun 2022 02:10:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CC19A81A34;
	Tue, 14 Jun 2022 02:10:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JlwmL9W74uOU; Tue, 14 Jun 2022 02:10:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7AB7882C5E;
	Tue, 14 Jun 2022 02:10:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51AA1C0039;
	Tue, 14 Jun 2022 02:10:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF98BC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 02:10:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BBA9A41697
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 02:10:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UIL-8OqFdAHp
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 02:10:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 07C2641677
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 02:10:36 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 420066114C;
 Tue, 14 Jun 2022 02:10:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01113C341C0;
 Tue, 14 Jun 2022 02:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1655172635;
 bh=9ua7Tv8ngKzIg90avnelbsiLM5arPoUfgpVVXD8P87k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SgNm+QWjOjt1WrrO8MasWHbZ8nXrI6GlP6x211ZSPnHMSxTGSb8tRxsmXo6RUZ2qp
 uGq6t+YPD0EBfwJkdvlQt4z3NZZnRBkFlLurVvN3IuN7VZQ//q/rJQmN7wxO4iWq4k
 a7Jav1oyyogQcFlTsrjhbkqYgvzFUovX5ni8Y3Da0aOj4urz19fs8Kb92Z7RBNS5Lk
 jsupxFQM/C/HollDZcg2j2cLexPBMU+cv3QTsQi50S+a5TOe/nKA2AVL53YIIOLpRM
 45nQeTAIXkCUC7pxAJluZSxr0INmng1Je19B+SSaoGae5OfgOL/ujPRevK8DVGHRVT
 pejbjHVgbY99A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 11/14] virtio-mmio: fix missing put_device() when
 vm_cmdline_parent registration failed
Date: Mon, 13 Jun 2022 22:10:16 -0400
Message-Id: <20220614021019.1100929-11-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220614021019.1100929-1-sashal@kernel.org>
References: <20220614021019.1100929-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, virtualization@lists.linux-foundation.org,
 chengkaitao <pilgrimtao@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>
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

From: chengkaitao <pilgrimtao@gmail.com>

[ Upstream commit a58a7f97ba11391d2d0d408e0b24f38d86ae748e ]

The reference must be released when device_register(&vm_cmdline_parent)
failed. Add the corresponding 'put_device()' in the error handling path.

Signed-off-by: chengkaitao <pilgrimtao@gmail.com>
Message-Id: <20220602005542.16489-1-chengkaitao@didiglobal.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virtio/virtio_mmio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 74dc7170fd35..181386e06cb7 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -635,6 +635,7 @@ static int vm_cmdline_set(const char *device,
 	if (!vm_cmdline_parent_registered) {
 		err = device_register(&vm_cmdline_parent);
 		if (err) {
+			put_device(&vm_cmdline_parent);
 			pr_err("Failed to register parent device!\n");
 			return err;
 		}
-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
