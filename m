Return-Path: <SRS0=4Agt=JR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B7EC433B4
	for <virtualization@archiver.kernel.org>; Tue, 20 Apr 2021 09:43:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 712FC610A1
	for <virtualization@archiver.kernel.org>; Tue, 20 Apr 2021 09:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 712FC610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A0BD0402CA;
	Tue, 20 Apr 2021 09:43:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4lPw-sjlOcbh; Tue, 20 Apr 2021 09:43:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id D87A040204;
	Tue, 20 Apr 2021 09:43:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB43AC000E;
	Tue, 20 Apr 2021 09:43:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD545C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 09:43:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C4B9A83A6A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 09:43:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y96OZ8rT8Pus
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 09:43:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1A12883A60
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 09:43:48 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id
 nm3-20020a17090b19c3b029014e1bbf6c60so15946673pjb.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 02:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8zGycjEf+w5ATtSrKPNMDPKepC5i8j4NCy1WccYtrWo=;
 b=QqOpWHbt6U8N2elVbpSCNvzZXuOjgB9rFEjgBLcbbol//NpfpDX4uBQ7hJFYXHf/sR
 b9Bndqc5ia4cglVJSHXsuG1Pic44JZCtYzjoseI6ioscGu0bXioBJ+QP6KZC5xJrhscl
 o/YUdbHMWCrJKdbiQe/JGj3hzUoQ6HLC23goS0WQHE1hRD0ok6lwzbFXIkgBxY1ktLPk
 SPMsBpMCXtGhn8l0Agl7LhQiCCmdi/dMY+CWXkZ9Fnqs0OJdNgL1CgZ39QY/Qh6nKQ8a
 W3XmuzCJnIcWteB2f7/NMkO/MUZ1CnVkvRJvaQCVHtWdeoZjEnZybXm+ASgGtbCr8455
 g8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8zGycjEf+w5ATtSrKPNMDPKepC5i8j4NCy1WccYtrWo=;
 b=CWc0OlpFRvG2txKw5bUb6xqk4+dsu/7qu0rcNMAKgFib1iy3D0qhiY1zV2/cOHtGRJ
 bCtLlLNskRqFHQaXcswHE/tPqpoFdOluEfWSBWJxoINTTuh1I6VBUBOOLDURhk5fWqpg
 pI5wKpESuQBoXsn2CYF5RGizqEbUafKc0VHYx1MVjYQFmoMNYYws/kFTmramNGS7lizu
 k65T+mMjAg1+Lw0t2o4frGYWARKh53FS4ZOyS4saPEoD0mpaBH2uocB6TALKYuv1+vtC
 awwNA9mDRmZw/WcKj8gvYcW2Wj/9d+4+qA5iYta7FeMCi/krDTk1pxHbJF/FSd1tSYFT
 /xlA==
X-Gm-Message-State: AOAM533TtT4s3VZMY8AFQJm64NqSn6LS7ptE5H/38/Su2Lz+mteHTM7x
 k9uBlR+zmb9xwYGxRuvRkkU=
X-Google-Smtp-Source: ABdhPJwrpnp9YcLIIGqvPc+Gv1KTSyYxQkHFofF+TIndrIZ21eYxCcGBZ+x8KHLRLCC5ElfG0rLZLw==
X-Received: by 2002:a17:90a:1b4b:: with SMTP id
 q69mr3961950pjq.188.1618911827553; 
 Tue, 20 Apr 2021 02:43:47 -0700 (PDT)
Received: from edumazet1.svl.corp.google.com
 ([2620:15c:2c4:201:71c5:2f2b:f562:605b])
 by smtp.gmail.com with ESMTPSA id u1sm14783495pgg.11.2021.04.20.02.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Apr 2021 02:43:47 -0700 (PDT)
From: Eric Dumazet <eric.dumazet@gmail.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] virtio-net: fix use-after-free in page_to_skb()
Date: Tue, 20 Apr 2021 02:43:41 -0700
Message-Id: <20210420094341.3259328-1-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
MIME-Version: 1.0
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Eric Dumazet <eric.dumazet@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 syzbot <syzkaller@googlegroups.com>, Guenter Roeck <linux@roeck-us.net>
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

From: Eric Dumazet <edumazet@google.com>

KASAN/syzbot had 4 reports, one of them being:

BUG: KASAN: slab-out-of-bounds in memcpy include/linux/fortify-string.h:191 [inline]
BUG: KASAN: slab-out-of-bounds in page_to_skb+0x5cf/0xb70 drivers/net/virtio_net.c:480
Read of size 12 at addr ffff888014a5f800 by task systemd-udevd/8445

CPU: 0 PID: 8445 Comm: systemd-udevd Not tainted 5.12.0-rc8-next-20210419-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:233
 __kasan_report mm/kasan/report.c:419 [inline]
 kasan_report.cold+0x7c/0xd8 mm/kasan/report.c:436
 check_region_inline mm/kasan/generic.c:180 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:186
 memcpy+0x20/0x60 mm/kasan/shadow.c:65
 memcpy include/linux/fortify-string.h:191 [inline]
 page_to_skb+0x5cf/0xb70 drivers/net/virtio_net.c:480
 receive_mergeable drivers/net/virtio_net.c:1009 [inline]
 receive_buf+0x2bc0/0x6250 drivers/net/virtio_net.c:1119
 virtnet_receive drivers/net/virtio_net.c:1411 [inline]
 virtnet_poll+0x568/0x10b0 drivers/net/virtio_net.c:1516
 __napi_poll+0xaf/0x440 net/core/dev.c:6962
 napi_poll net/core/dev.c:7029 [inline]
 net_rx_action+0x801/0xb40 net/core/dev.c:7116
 __do_softirq+0x29b/0x9fe kernel/softirq.c:559
 invoke_softirq kernel/softirq.c:433 [inline]
 __irq_exit_rcu+0x136/0x200 kernel/softirq.c:637
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
 common_interrupt+0xa4/0xd0 arch/x86/kernel/irq.c:240

Fixes: fb32856b16ad ("virtio-net: page_to_skb() use build_skb when there's sufficient tailroom")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Reported-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org
---
 drivers/net/virtio_net.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 8cd76037c72481200ea3e8429e9fdfec005dad85..2e28c04aa6351d2b4016f7d277ce104c4970069d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -385,6 +385,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 	struct sk_buff *skb;
 	struct virtio_net_hdr_mrg_rxbuf *hdr;
 	unsigned int copy, hdr_len, hdr_padded_len;
+	struct page *page_to_free = NULL;
 	int tailroom, shinfo_size;
 	char *p, *hdr_p;
 
@@ -445,7 +446,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 		if (len)
 			skb_add_rx_frag(skb, 0, page, offset, len, truesize);
 		else
-			put_page(page);
+			page_to_free = page;
 		goto ok;
 	}
 
@@ -479,6 +480,8 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 		hdr = skb_vnet_hdr(skb);
 		memcpy(hdr, hdr_p, hdr_len);
 	}
+	if (page_to_free)
+		put_page(page_to_free);
 
 	if (metasize) {
 		__skb_pull(skb, metasize);
-- 
2.31.1.368.gbe11c130af-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
