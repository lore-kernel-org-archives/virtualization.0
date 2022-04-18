Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F654C43219
	for <virtualization@archiver.kernel.org>; Mon, 18 Apr 2022 13:12:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9912340B57;
	Mon, 18 Apr 2022 13:12:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SrsnWeNgkp63; Mon, 18 Apr 2022 13:12:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B97B4400BF;
	Mon, 18 Apr 2022 13:12:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69CD8C002F;
	Mon, 18 Apr 2022 13:12:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58B20C002C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 13:11:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 30A45400DA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 13:11:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KM9hFG3ZjLd7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 13:11:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3C527400BF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 13:11:55 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5ED0E60AAD;
 Mon, 18 Apr 2022 13:11:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662E8C385A8;
 Mon, 18 Apr 2022 13:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1650287513;
 bh=3yzvAodLOE8G2QKyg5PZZsSv/bFd6eznMK/fTDThLUA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QCYOhFDn5cKtG1b5JOHgoex4gcrBMkbcZxP0FBtguJSZL2g03QuVgPghqVHGqPQ8h
 EOU3hW4xQnfKx+W32k80TNmL5WrDNg4GU7tK1NfLNzQxctmHzOWX0/FudquOkxxsOg
 XMkx7LAWmGhLOp8mmGm3mvRM31EmBRKq2yruzWh0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4.9 185/218] virtio_console: eliminate anonymous module_init &
 module_exit
Date: Mon, 18 Apr 2022 14:14:11 +0200
Message-Id: <20220418121206.380989124@linuxfoundation.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220418121158.636999985@linuxfoundation.org>
References: <20220418121158.636999985@linuxfoundation.org>
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
index a6b6dc204c1f..ba4c546db756 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -2284,7 +2284,7 @@ static struct virtio_driver virtio_rproc_serial = {
 	.remove =	virtcons_remove,
 };
 
-static int __init init(void)
+static int __init virtio_console_init(void)
 {
 	int err;
 
@@ -2321,7 +2321,7 @@ static int __init init(void)
 	return err;
 }
 
-static void __exit fini(void)
+static void __exit virtio_console_fini(void)
 {
 	reclaim_dma_bufs();
 
@@ -2331,8 +2331,8 @@ static void __exit fini(void)
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
