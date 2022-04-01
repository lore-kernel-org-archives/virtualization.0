Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E63C433F5
	for <virtualization@archiver.kernel.org>; Fri,  1 Apr 2022 14:44:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BC2D3405C4;
	Fri,  1 Apr 2022 14:44:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6my9d8whifgT; Fri,  1 Apr 2022 14:44:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6F0BA40517;
	Fri,  1 Apr 2022 14:44:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DAC8C002C;
	Fri,  1 Apr 2022 14:44:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CDB0C0082
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Apr 2022 14:44:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E65FF405C4
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Apr 2022 14:43:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YDj80hUd86v8
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Apr 2022 14:43:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E4C4640517
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Apr 2022 14:43:58 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 45EEDB824FC;
 Fri,  1 Apr 2022 14:43:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2569EC340EE;
 Fri,  1 Apr 2022 14:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1648824235;
 bh=aocFPkyzseOCNsdg1UrLaHgsgGvcR7I5oaXDD6AYLMw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=liOa8aoDyp/atrus9KEW+tK0dT3FIsK7lcBRHL2ROwlPECIHrfFJC8eVtB9mjRDq5
 LAPxSmHtCelW+5BUv5mP1GLjDP3zklnB8BfgH7RQvXZ7LJLO+UAotoI7E1uyq4ufZV
 Ko5YqH7UZpbUZ7qePARV5mCL2a5dyxqaif1m7qfyN9y0ScJ6vw+0YfmO51mGgVw1cQ
 gyYaSb/nN2T11bpqRsf1D9Pb0x0yv22B3ZlC83i0g9filY9BQ0F+Aclvt0irKdvp2h
 cttvaHxr2WNWX/+AyQflI5xxmKVOskDCMoSyUhEBllunMzSVTxXziBrhIrJbyUPLXK
 yJOAuvelfPPSA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 44/65] tuntap: add sanity checks about
 msg_controllen in sendmsg
Date: Fri,  1 Apr 2022 10:41:45 -0400
Message-Id: <20220401144206.1953700-44-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220401144206.1953700-1-sashal@kernel.org>
References: <20220401144206.1953700-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, daniel@iogearbox.net,
 Eric Dumazet <eric.dumazet@gmail.com>, mst@redhat.com, netdev@vger.kernel.org,
 john.fastabend@gmail.com, ast@kernel.org,
 virtualization@lists.linux-foundation.org,
 Harold Huang <baymaxhuang@gmail.com>, kvm@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org, pabeni@redhat.com,
 davem@davemloft.net, hawk@kernel.org
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

From: Harold Huang <baymaxhuang@gmail.com>

[ Upstream commit 74a335a07a17d131b9263bfdbdcb5e40673ca9ca ]

In patch [1], tun_msg_ctl was added to allow pass batched xdp buffers to
tun_sendmsg. Although we donot use msg_controllen in this path, we should
check msg_controllen to make sure the caller pass a valid msg_ctl.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fe8dd45bb7556246c6b76277b1ba4296c91c2505

Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Harold Huang <baymaxhuang@gmail.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Link: https://lore.kernel.org/r/20220303022441.383865-1-baymaxhuang@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/tap.c   | 3 ++-
 drivers/net/tun.c   | 3 ++-
 drivers/vhost/net.c | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index f549d3a8e59c..8f7bb15206e9 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -1202,7 +1202,8 @@ static int tap_sendmsg(struct socket *sock, struct msghdr *m,
 	struct xdp_buff *xdp;
 	int i;
 
-	if (ctl && (ctl->type == TUN_MSG_PTR)) {
+	if (m->msg_controllen == sizeof(struct tun_msg_ctl) &&
+	    ctl && ctl->type == TUN_MSG_PTR) {
 		for (i = 0; i < ctl->num; i++) {
 			xdp = &((struct xdp_buff *)ctl->ptr)[i];
 			tap_get_user_xdp(q, xdp);
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index ffbc7eda95ee..55ce141c93c7 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2499,7 +2499,8 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 	if (!tun)
 		return -EBADFD;
 
-	if (ctl && (ctl->type == TUN_MSG_PTR)) {
+	if (m->msg_controllen == sizeof(struct tun_msg_ctl) &&
+	    ctl && ctl->type == TUN_MSG_PTR) {
 		struct tun_page tpage;
 		int n = ctl->num;
 		int flush = 0;
diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index da02c3e96e7b..e303f6f073d2 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -472,6 +472,7 @@ static void vhost_tx_batch(struct vhost_net *net,
 		goto signal_used;
 
 	msghdr->msg_control = &ctl;
+	msghdr->msg_controllen = sizeof(ctl);
 	err = sock->ops->sendmsg(sock, msghdr, 0);
 	if (unlikely(err < 0)) {
 		vq_err(&nvq->vq, "Fail to batch sending packets\n");
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
