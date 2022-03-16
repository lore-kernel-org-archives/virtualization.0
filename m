Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E9FC433F5
	for <virtualization@archiver.kernel.org>; Wed, 16 Mar 2022 19:21:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 82AB7841EB;
	Wed, 16 Mar 2022 19:21:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IBdDiKZovE7A; Wed, 16 Mar 2022 19:21:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0372C841B0;
	Wed, 16 Mar 2022 19:21:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9CC7C0012;
	Wed, 16 Mar 2022 19:21:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0CCE0C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 19:21:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DB328417D7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 19:21:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xQdPeyvKDez6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 19:21:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9919C417CF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 19:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=eCnVY7uQehwpOm+/i+ja6QzAKTO0vo8Gbh+yXOb+Gg8=; b=m6A+Wfto0x/+asj1wMXe6zUSoZ
 VW5gB9LD8p4BZS/fH+G1DjKRf3HJg9qcRbrRBBDIf4xPZl6DdNvFnd6c68IC5/fMVAQFBK3WmkBZA
 b1YgQZgXNEa2sjTW4NsgVsBFL+UlE4F6iZn8e9REQQmC6G1ejP6tabyS/AVW/K/MUTr/tJFQ04Tm3
 7t6qa5bO1NyCGn3r6ypp7kK+AgAqgg4M8dV9+q06bvu0XOTlt5wUoD3YAbcznwzzHiizxoy8balfP
 1W/HSRRJTvQsHB24y9B/CI3cWIlYos50+150upEuzFMLrTvzpxBYw0wPNMtDbdaVK0lksct7M2Hah
 I/B++NZA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUZC0-00EArp-6Y; Wed, 16 Mar 2022 19:20:20 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] net: mlx5: eliminate anonymous module_init & module_exit
Date: Wed, 16 Mar 2022 12:20:04 -0700
Message-Id: <20220316192010.19001-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220316192010.19001-1-rdunlap@infradead.org>
References: <20220316192010.19001-1-rdunlap@infradead.org>
MIME-Version: 1.0
Cc: linux-usb@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 nouveau@lists.freedesktop.org, Dave Hansen <dave.hansen@linux.intel.com>,
 Valentina Manea <valentina.manea.m@gmail.com>,
 virtualization@lists.linux-foundation.org,
 Krzysztof Opasiak <k.opasiak@samsung.com>, Eli Cohen <eli@mellanox.com>,
 netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Arnd Bergmann <arnd@arndb.de>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, coreteam@netfilter.org,
 Jakub Kicinski <kuba@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 Joachim Fritschi <jfritschi@freenet.de>,
 Felipe Balbi <felipe.balbi@linux.intel.com>, Amit Shah <amit@kernel.org>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
 linux-block@vger.kernel.org, Pekka Paalanen <ppaalanen@gmail.com>,
 Borislav Petkov <bp@alien8.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Jussi Kivilinna <jussi.kivilinna@mbnet.fi>,
 Herbert Xu <herbert@gondor.apana.org.au>, Jens Axboe <axboe@kernel.dk>,
 x86@kernel.org, linux-scsi@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Florian Westphal <fw@strlen.de>,
 Karol Herbst <karolherbst@gmail.com>, netfilter-devel@vger.kernel.org,
 linux-crypto@vger.kernel.org, Igor Kotrasinski <i.kotrasinsk@samsung.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>
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

Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Eli Cohen <eli@mellanox.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>
Cc: netdev@vger.kernel.org
Cc: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- lnx-517-rc8.orig/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ lnx-517-rc8/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1893,7 +1893,7 @@ static void mlx5_core_verify_params(void
 	}
 }
 
-static int __init init(void)
+static int __init mlx5_init(void)
 {
 	int err;
 
@@ -1929,7 +1929,7 @@ err_debug:
 	return err;
 }
 
-static void __exit cleanup(void)
+static void __exit mlx5_cleanup(void)
 {
 	mlx5e_cleanup();
 	mlx5_sf_driver_unregister();
@@ -1937,5 +1937,5 @@ static void __exit cleanup(void)
 	mlx5_unregister_debugfs();
 }
 
-module_init(init);
-module_exit(cleanup);
+module_init(mlx5_init);
+module_exit(mlx5_cleanup);
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
