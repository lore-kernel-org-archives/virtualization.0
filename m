Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DCEC433EF
	for <virtualization@archiver.kernel.org>; Mon, 25 Apr 2022 10:38:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8EB8840492;
	Mon, 25 Apr 2022 10:38:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vZtVx41Lhl2G; Mon, 25 Apr 2022 10:38:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C0C0540483;
	Mon, 25 Apr 2022 10:38:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EC84C0032;
	Mon, 25 Apr 2022 10:38:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 854F8C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 10:38:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 722984048D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 10:38:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sDI8CBDzBBLv
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 10:38:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CEF3E40483
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 10:38:24 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id g6so5909141ejw.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 03:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZbP2FugB9zFhX6R6mZeh2vBUHQUVMWz1J+UPHyhCYHM=;
 b=drgAxf1kf/IIFktp7tyWvSHK7vS8QZ9HZZCW0Lb0G/W2NpbnJMWJtxG0INdS68SYj4
 WPe5gF3MfgRxoFiR1JPxuSYPh4LqUMo9eom1jXlL9LZt6eRUoseum3SMmd/XE395si+c
 tOGLRD+X1uo06iWuAVNftI/iVbYwfVkJbTBuV/AK340JcIMzMmOwo9jHLK2+7zjn8I2Q
 mAQB0+5Rr2+RAZ+MWWrA0MmfLjXdjdsCo/dOCeAqygn7Yv0xpyMVu8WTbcc3JEjuq5wM
 Lq1dmC3SWm/lWsXUGzmDrByBxWYOBaUV+gDqy8O1JDLFFIqC6Sr3xk6phZB+AjdyX3Kn
 +2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZbP2FugB9zFhX6R6mZeh2vBUHQUVMWz1J+UPHyhCYHM=;
 b=lrIm1Kr+90ex1rztinTKN0wcGkeBIAFsI69XH9BTPqkhJEAwTkWrgmChVuPNOd65eu
 1FC+JLZUDcp7znIl9qs5Bk7DBNHY59DqWYjKU93PzsEYgH1G89qfvOVnaq8uV8ptQPPK
 SC1FQbM8zmKPZdrbdRUzyqzSPWTMqnojQbW53JwMQ2dnWdnK5LhpkBW90FBRAlEEwp8b
 N+t9bjepKoNuNu6XF36xW1q0tUmS6fVe7yRBiwKqdyiQZrriW1tLyIG9WEW1hX2QcI2L
 yuAaT85v9rJQ8jWuBJSje6rSv6s0+9ZkWw/oHICVfrVNKzG51UNisPf5KcjSsXmaKqJP
 p/9A==
X-Gm-Message-State: AOAM530jw7NOsNA0seFnhS6bM9oO9LeWKigB62DsekzYTF66kCxcl2ik
 NkidoShoE0Rl+24mv3H9Q5MG/A==
X-Google-Smtp-Source: ABdhPJz5i/tB9ZtaHGLLhiXEAXDWA77KreY33JfMg9/eZ1T8WVizpzcl9UkhRMC1QedJ65x6zs/1hA==
X-Received: by 2002:a17:907:33c2:b0:6f3:9aff:d532 with SMTP id
 zk2-20020a17090733c200b006f39affd532mr2773335ejb.394.1650883102709; 
 Mon, 25 Apr 2022 03:38:22 -0700 (PDT)
Received: from debil.. (87-243-81-1.ip.btc-net.bg. [87.243.81.1])
 by smtp.gmail.com with ESMTPSA id
 y18-20020a1709063a9200b006f022c00fa6sm3407362ejd.165.2022.04.25.03.38.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Apr 2022 03:38:22 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Subject: [PATCH net v3] virtio_net: fix wrong buf address calculation when
 using xdp
Date: Mon, 25 Apr 2022 13:37:03 +0300
Message-Id: <20220425103703.3067292-1-razor@blackwall.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, stable@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org,
 virtualization@lists.linux-foundation.org,
 Nikolay Aleksandrov <razor@blackwall.org>
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

We received a report[1] of kernel crashes when Cilium is used in XDP
mode with virtio_net after updating to newer kernels. After
investigating the reason it turned out that when using mergeable bufs
with an XDP program which adjusts xdp.data or xdp.data_meta page_to_buf()
calculates the build_skb address wrong because the offset can become less
than the headroom so it gets the address of the previous page (-X bytes
depending on how lower offset is):
 page_to_skb: page addr ffff9eb2923e2000 buf ffff9eb2923e1ffc offset 252 headroom 256

This is a pr_err() I added in the beginning of page_to_skb which clearly
shows offset that is less than headroom by adding 4 bytes of metadata
via an xdp prog. The calculations done are:
 receive_mergeable():
 headroom = VIRTIO_XDP_HEADROOM; // VIRTIO_XDP_HEADROOM == 256 bytes
 offset = xdp.data - page_address(xdp_page) -
          vi->hdr_len - metasize;

 page_to_skb():
 p = page_address(page) + offset;
 ...
 buf = p - headroom;

Now buf goes -4 bytes from the page's starting address as can be seen
above which is set as skb->head and skb->data by build_skb later. Depending
on what's done with the skb (when it's freed most often) we get all kinds
of corruptions and BUG_ON() triggers in mm[2]. We have to recalculate
the new headroom after the xdp program has run, similar to how offset
and len are recalculated. Headroom is directly related to
data_hard_start, data and data_meta, so we use them to get the new size.
The result is correct (similar pr_err() in page_to_skb, one case of
xdp_page and one case of virtnet buf):
 a) Case with 4 bytes of metadata
 [  115.949641] page_to_skb: page addr ffff8b4dcfad2000 offset 252 headroom 252
 [  121.084105] page_to_skb: page addr ffff8b4dcf018000 offset 20732 headroom 252
 b) Case of pushing data +32 bytes
 [  153.181401] page_to_skb: page addr ffff8b4dd0c4d000 offset 288 headroom 288
 [  158.480421] page_to_skb: page addr ffff8b4dd00b0000 offset 24864 headroom 288
 c) Case of pushing data -33 bytes
 [  835.906830] page_to_skb: page addr ffff8b4dd3270000 offset 223 headroom 223
 [  840.839910] page_to_skb: page addr ffff8b4dcdd68000 offset 12511 headroom 223

Offset and headroom are equal because offset points to the start of
reserved bytes for the virtio_net header which are at buf start +
headroom, while data points at buf start + vnet hdr size + headroom so
when data or data_meta are adjusted by the xdp prog both the headroom size
and the offset change equally. We can use data_hard_start to compute the
new headroom after the xdp prog (linearized / page start case, the
virtnet buf case is similar just with bigger base offset):
 xdp.data_hard_start = page_address + vnet_hdr
 xdp.data = page_address + vnet_hdr + headroom
 new headroom after xdp prog = xdp.data - xdp.data_hard_start - metasize

An example reproducer xdp prog[3] is below.

[1] https://github.com/cilium/cilium/issues/19453

[2] Two of the many traces:
 [   40.437400] BUG: Bad page state in process swapper/0  pfn:14940
 [   40.916726] BUG: Bad page state in process systemd-resolve  pfn:053b7
 [   41.300891] kernel BUG at include/linux/mm.h:720!
 [   41.301801] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
 [   41.302784] CPU: 1 PID: 1181 Comm: kubelet Kdump: loaded Tainted: G    B   W         5.18.0-rc1+ #37
 [   41.304458] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1.fc35 04/01/2014
 [   41.306018] RIP: 0010:page_frag_free+0x79/0xe0
 [   41.306836] Code: 00 00 75 ea 48 8b 07 a9 00 00 01 00 74 e0 48 8b 47 48 48 8d 50 ff a8 01 48 0f 45 fa eb d0 48 c7 c6 18 b8 30 a6 e8 d7 f8 fc ff <0f> 0b 48 8d 78 ff eb bc 48 8b 07 a9 00 00 01 00 74 3a 66 90 0f b6
 [   41.310235] RSP: 0018:ffffac05c2a6bc78 EFLAGS: 00010292
 [   41.311201] RAX: 000000000000003e RBX: 0000000000000000 RCX: 0000000000000000
 [   41.312502] RDX: 0000000000000001 RSI: ffffffffa6423004 RDI: 00000000ffffffff
 [   41.313794] RBP: ffff993c98823600 R08: 0000000000000000 R09: 00000000ffffdfff
 [   41.315089] R10: ffffac05c2a6ba68 R11: ffffffffa698ca28 R12: ffff993c98823600
 [   41.316398] R13: ffff993c86311ebc R14: 0000000000000000 R15: 000000000000005c
 [   41.317700] FS:  00007fe13fc56740(0000) GS:ffff993cdd900000(0000) knlGS:0000000000000000
 [   41.319150] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 [   41.320152] CR2: 000000c00008a000 CR3: 0000000014908000 CR4: 0000000000350ee0
 [   41.321387] Call Trace:
 [   41.321819]  <TASK>
 [   41.322193]  skb_release_data+0x13f/0x1c0
 [   41.322902]  __kfree_skb+0x20/0x30
 [   41.343870]  tcp_recvmsg_locked+0x671/0x880
 [   41.363764]  tcp_recvmsg+0x5e/0x1c0
 [   41.384102]  inet_recvmsg+0x42/0x100
 [   41.406783]  ? sock_recvmsg+0x1d/0x70
 [   41.428201]  sock_read_iter+0x84/0xd0
 [   41.445592]  ? 0xffffffffa3000000
 [   41.462442]  new_sync_read+0x148/0x160
 [   41.479314]  ? 0xffffffffa3000000
 [   41.496937]  vfs_read+0x138/0x190
 [   41.517198]  ksys_read+0x87/0xc0
 [   41.535336]  do_syscall_64+0x3b/0x90
 [   41.551637]  entry_SYSCALL_64_after_hwframe+0x44/0xae
 [   41.568050] RIP: 0033:0x48765b
 [   41.583955] Code: e8 4a 35 fe ff eb 88 cc cc cc cc cc cc cc cc e8 fb 7a fe ff 48 8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 20 48 8b 44 24 08 0f 05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 28 ff ff ff ff 48 c7 44 24 30
 [   41.632818] RSP: 002b:000000c000a2f5b8 EFLAGS: 00000212 ORIG_RAX: 0000000000000000
 [   41.664588] RAX: ffffffffffffffda RBX: 000000c000062000 RCX: 000000000048765b
 [   41.681205] RDX: 0000000000005e54 RSI: 000000c000e66000 RDI: 0000000000000016
 [   41.697164] RBP: 000000c000a2f608 R08: 0000000000000001 R09: 00000000000001b4
 [   41.713034] R10: 00000000000000b6 R11: 0000000000000212 R12: 00000000000000e9
 [   41.728755] R13: 0000000000000001 R14: 000000c000a92000 R15: ffffffffffffffff
 [   41.744254]  </TASK>
 [   41.758585] Modules linked in: br_netfilter bridge veth netconsole virtio_net

 and

 [   33.524802] BUG: Bad page state in process systemd-network  pfn:11e60
 [   33.528617] page ffffe05dc0147b00 ffffe05dc04e7a00 ffff8ae9851ec000 (1) len 82 offset 252 metasize 4 hroom 0 hdr_len 12 data ffff8ae9851ec10c data_meta ffff8ae9851ec108 data_end ffff8ae9851ec14e
 [   33.529764] page:000000003792b5ba refcount:0 mapcount:-512 mapping:0000000000000000 index:0x0 pfn:0x11e60
 [   33.532463] flags: 0xfffffc0000000(node=0|zone=1|lastcpupid=0x1fffff)
 [   33.532468] raw: 000fffffc0000000 0000000000000000 dead000000000122 0000000000000000
 [   33.532470] raw: 0000000000000000 0000000000000000 00000000fffffdff 0000000000000000
 [   33.532471] page dumped because: nonzero mapcount
 [   33.532472] Modules linked in: br_netfilter bridge veth netconsole virtio_net
 [   33.532479] CPU: 0 PID: 791 Comm: systemd-network Kdump: loaded Not tainted 5.18.0-rc1+ #37
 [   33.532482] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1.fc35 04/01/2014
 [   33.532484] Call Trace:
 [   33.532496]  <TASK>
 [   33.532500]  dump_stack_lvl+0x45/0x5a
 [   33.532506]  bad_page.cold+0x63/0x94
 [   33.532510]  free_pcp_prepare+0x290/0x420
 [   33.532515]  free_unref_page+0x1b/0x100
 [   33.532518]  skb_release_data+0x13f/0x1c0
 [   33.532524]  kfree_skb_reason+0x3e/0xc0
 [   33.532527]  ip6_mc_input+0x23c/0x2b0
 [   33.532531]  ip6_sublist_rcv_finish+0x83/0x90
 [   33.532534]  ip6_sublist_rcv+0x22b/0x2b0

[3] XDP program to reproduce(xdp_pass.c):
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>

 SEC("xdp_pass")
 int xdp_pkt_pass(struct xdp_md *ctx)
 {
          bpf_xdp_adjust_head(ctx, -(int)32);
          return XDP_PASS;
 }

 char _license[] SEC("license") = "GPL";

 compile: clang -O2 -g -Wall -target bpf -c xdp_pass.c -o xdp_pass.o
 load on virtio_net: ip link set enp1s0 xdpdrv obj xdp_pass.o sec xdp_pass

CC: stable@vger.kernel.org
CC: Jason Wang <jasowang@redhat.com>
CC: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: Daniel Borkmann <daniel@iogearbox.net>
CC: "Michael S. Tsirkin" <mst@redhat.com>
CC: virtualization@lists.linux-foundation.org
Fixes: 8fb7da9e9907 ("virtio_net: get build_skb() buf by data ptr")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
v3: Add a comment explaining why offset and headroom are equal,
    no code changes
v2: Recalculate headroom based on data, data_hard_start and data_meta

 drivers/net/virtio_net.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 87838cbe38cf..cbba9d2e8f32 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1005,6 +1005,24 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 			 * xdp.data_meta were adjusted
 			 */
 			len = xdp.data_end - xdp.data + vi->hdr_len + metasize;
+
+			/* recalculate headroom if xdp.data or xdp_data_meta
+			 * were adjusted, note that offset should always point
+			 * to the start of the reserved bytes for virtio_net
+			 * header which are followed by xdp.data, that means
+			 * that offset is equal to the headroom (when buf is
+			 * starting at the beginning of the page, otherwise
+			 * there is a base offset inside the page) but it's used
+			 * with a different starting point (buf start) than
+			 * xdp.data (buf start + vnet hdr size). If xdp.data or
+			 * data_meta were adjusted by the xdp prog then the
+			 * headroom size has changed and so has the offset, we
+			 * can use data_hard_start, which points at buf start +
+			 * vnet hdr size, to calculate the new headroom and use
+			 * it later to compute buf start in page_to_skb()
+			 */
+			headroom = xdp.data - xdp.data_hard_start - metasize;
+
 			/* We can only create skb based on xdp_page. */
 			if (unlikely(xdp_page != page)) {
 				rcu_read_unlock();
@@ -1012,7 +1030,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 				head_skb = page_to_skb(vi, rq, xdp_page, offset,
 						       len, PAGE_SIZE, false,
 						       metasize,
-						       VIRTIO_XDP_HEADROOM);
+						       headroom);
 				return head_skb;
 			}
 			break;
-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
