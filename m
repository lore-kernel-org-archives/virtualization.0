Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6F8C433F5
	for <virtualization@archiver.kernel.org>; Tue, 12 Apr 2022 06:47:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 73DF08332A;
	Tue, 12 Apr 2022 06:47:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X26O2HWmyaWo; Tue, 12 Apr 2022 06:47:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4AA6E83E88;
	Tue, 12 Apr 2022 06:47:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1646CC0082;
	Tue, 12 Apr 2022 06:47:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25773C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 06:47:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0D98883E88
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 06:47:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zZf8aeEtGFdD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 06:47:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3704F8332A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 06:47:17 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7552860A6A;
 Tue, 12 Apr 2022 06:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8627DC385A1;
 Tue, 12 Apr 2022 06:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1649746035;
 bh=c/FQuSp0WYgo83djFo9gf3z2mIfroc8NZWvLZypCStU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=0+9c9xDExPyTjcpr4vKJ00DQGVtEKc5aqv1pGAHzIap6ixdUorkfCF5OoR88+OL/R
 MXubqDApMZeLWspcSHq2sxPEcXr8b3IcDNejgAoYJY67VMNSb+2tWDqnEh2aOu2ejg
 BB9kn5QrQd1Jt1+gIAg6vvmgWKmqDpDVRxNcZygg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 5.15 135/277] virtio_console: eliminate anonymous module_init
 & module_exit
Date: Tue, 12 Apr 2022 08:28:58 +0200
Message-Id: <20220412062945.943513195@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412062942.022903016@linuxfoundation.org>
References: <20220412062942.022903016@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Cc: Sasha Levin <sashal@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Amit Shah <amit@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit fefb8a2a941338d871e2d83fbd65fbfa068857bd ]

Eliminate anonymous module_init() and module_exit(), which can lead to
confusion or ambiguity when reading System.map, crashes/oops/bugs,
or an initcall_debug log.

Give each of these init and exit functions unique driver-specific
names to eliminate the anonymous names.

Example 1: (System.map)
 ffffffff832fc78c t init
 ffffffff832fc79e t init
 ffffffff832fc8f8 t init

Example 2: (initcall_debug log)
 calling  init+0x0/0x12 @ 1
 initcall init+0x0/0x12 returned 0 after 15 usecs
 calling  init+0x0/0x60 @ 1
 initcall init+0x0/0x60 returned 0 after 2 usecs
 calling  init+0x0/0x9a @ 1
 initcall init+0x0/0x9a returned 0 after 74 usecs

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Amit Shah <amit@kernel.org>
Cc: virtualization@lists.linux-foundation.org
Cc: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20220316192010.19001-3-rdunlap@infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/virtio_console.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 3adf04766e98..77bc993d7513 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -2236,7 +2236,7 @@ static struct virtio_driver virtio_rproc_serial = {
 	.remove =	virtcons_remove,
 };
 
-static int __init init(void)
+static int __init virtio_console_init(void)
 {
 	int err;
 
@@ -2271,7 +2271,7 @@ static int __init init(void)
 	return err;
 }
 
-static void __exit fini(void)
+static void __exit virtio_console_fini(void)
 {
 	reclaim_dma_bufs();
 
@@ -2281,8 +2281,8 @@ static void __exit fini(void)
 	class_destroy(pdrvdata.class);
 	debugfs_remove_recursive(pdrvdata.debugfs_dir);
 }
-module_init(init);
-module_exit(fini);
+module_init(virtio_console_init);
+module_exit(virtio_console_fini);
 
 MODULE_DESCRIPTION("Virtio console driver");
 MODULE_LICENSE("GPL");
-- 
2.35.1



_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
