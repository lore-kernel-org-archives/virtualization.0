Return-Path: <SRS0=ZGfu=K3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FFAC4708F
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 06:40:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEAAE610C9
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 06:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEAAE610C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7805040469;
	Tue,  1 Jun 2021 06:40:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V7iKF8zpotDl; Tue,  1 Jun 2021 06:40:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8310940465;
	Tue,  1 Jun 2021 06:40:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14A7AC0025;
	Tue,  1 Jun 2021 06:40:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ECC74C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 06:40:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CCB5B60A7A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 06:40:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ud_P7Mn9OUSE
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 06:40:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4B9536069A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 06:40:04 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=alimailimapcm10staff010182156082;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=12; SR=0;
 TI=SMTPD_---0UaqF-NH_1622529600; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0UaqF-NH_1622529600) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 01 Jun 2021 14:40:01 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>
Subject: [PATCH net v2 1/2] virtio-net: fix for unable to handle page fault
 for address
Date: Tue,  1 Jun 2021 14:39:59 +0800
Message-Id: <20210601064000.66909-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210601064000.66909-1-xuanzhuo@linux.alibaba.com>
References: <20210601064000.66909-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

In merge mode, when xdp is enabled, if the headroom of buf is smaller
than virtnet_get_headroom(), xdp_linearize_page() will be called but the
variable of "headroom" is still 0, which leads to wrong logic after
entering page_to_skb().

[   16.600944] BUG: unable to handle page fault for address: ffffecbfff7b43c8[   16.602175] #PF: supervisor read access in kernel mode
[   16.603350] #PF: error_code(0x0000) - not-present page
[   16.604200] PGD 0 P4D 0
[   16.604686] Oops: 0000 [#1] SMP PTI
[   16.605306] CPU: 4 PID: 715 Comm: sh Tainted: G    B             5.12.0+ #312
[   16.606429] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/04
[   16.608217] RIP: 0010:unmap_page_range+0x947/0xde0
[   16.609014] Code: 00 00 08 00 48 83 f8 01 45 19 e4 41 f7 d4 41 83 e4 03 e9 a4 fd ff ff e8 b7 63 ed ff 4c 89 e0 48 c1 e0 065
[   16.611863] RSP: 0018:ffffc90002503c58 EFLAGS: 00010286
[   16.612720] RAX: ffffecbfff7b43c0 RBX: 00007f19f7203000 RCX: ffffffff812ff359
[   16.613853] RDX: ffff888107778000 RSI: 0000000000000000 RDI: 0000000000000005
[   16.614976] RBP: ffffea000425e000 R08: 0000000000000000 R09: 3030303030303030
[   16.616124] R10: ffffffff82ed7d94 R11: 6637303030302052 R12: 7c00000afffded0f
[   16.617276] R13: 0000000000000001 R14: ffff888119ee7010 R15: 00007f19f7202000
[   16.618423] FS:  0000000000000000(0000) GS:ffff88842fd00000(0000) knlGS:0000000000000000
[   16.619738] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.620670] CR2: ffffecbfff7b43c8 CR3: 0000000103220005 CR4: 0000000000370ee0
[   16.621792] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   16.622920] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   16.624047] Call Trace:
[   16.624525]  ? release_pages+0x24d/0x730
[   16.625209]  unmap_single_vma+0xa9/0x130
[   16.625885]  unmap_vmas+0x76/0xf0
[   16.626480]  exit_mmap+0xa0/0x210
[   16.627129]  mmput+0x67/0x180
[   16.627673]  do_exit+0x3d1/0xf10
[   16.628259]  ? do_user_addr_fault+0x231/0x840
[   16.629000]  do_group_exit+0x53/0xd0
[   16.629631]  __x64_sys_exit_group+0x1d/0x20
[   16.630354]  do_syscall_64+0x3c/0x80
[   16.630988]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   16.631828] RIP: 0033:0x7f1a043d0191
[   16.632464] Code: Unable to access opcode bytes at RIP 0x7f1a043d0167.
[   16.633502] RSP: 002b:00007ffe3d993308 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[   16.634737] RAX: ffffffffffffffda RBX: 00007f1a044c9490 RCX: 00007f1a043d0191
[   16.635857] RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
[   16.636986] RBP: 0000000000000000 R08: ffffffffffffff88 R09: 0000000000000001
[   16.638120] R10: 0000000000000008 R11: 0000000000000246 R12: 00007f1a044c9490
[   16.639245] R13: 0000000000000001 R14: 00007f1a044c9968 R15: 0000000000000000
[   16.640408] Modules linked in:
[   16.640958] CR2: ffffecbfff7b43c8
[   16.641557] ---[ end trace bc4891c6ce46354c ]---
[   16.642335] RIP: 0010:unmap_page_range+0x947/0xde0
[   16.643135] Code: 00 00 08 00 48 83 f8 01 45 19 e4 41 f7 d4 41 83 e4 03 e9 a4 fd ff ff e8 b7 63 ed ff 4c 89 e0 48 c1 e0 065
[   16.645983] RSP: 0018:ffffc90002503c58 EFLAGS: 00010286
[   16.646845] RAX: ffffecbfff7b43c0 RBX: 00007f19f7203000 RCX: ffffffff812ff359
[   16.647970] RDX: ffff888107778000 RSI: 0000000000000000 RDI: 0000000000000005
[   16.649091] RBP: ffffea000425e000 R08: 0000000000000000 R09: 3030303030303030
[   16.650250] R10: ffffffff82ed7d94 R11: 6637303030302052 R12: 7c00000afffded0f
[   16.651394] R13: 0000000000000001 R14: ffff888119ee7010 R15: 00007f19f7202000
[   16.652529] FS:  0000000000000000(0000) GS:ffff88842fd00000(0000) knlGS:0000000000000000
[   16.653887] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.654841] CR2: ffffecbfff7b43c8 CR3: 0000000103220005 CR4: 0000000000370ee0
[   16.655992] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   16.657150] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   16.658290] Kernel panic - not syncing: Fatal exception
[   16.659613] Kernel Offset: disabled
[   16.660234] ---[ end Kernel panic - not syncing: Fatal exception ]---

Fixes: fb32856b16ad ("virtio-net: page_to_skb() use build_skb when there's sufficient tailroom")
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 9b6a4a875c55..6b929aca155a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -958,7 +958,8 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 				put_page(page);
 				head_skb = page_to_skb(vi, rq, xdp_page, offset,
 						       len, PAGE_SIZE, false,
-						       metasize, headroom);
+						       metasize,
+						       VIRTIO_XDP_HEADROOM);
 				return head_skb;
 			}
 			break;
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
