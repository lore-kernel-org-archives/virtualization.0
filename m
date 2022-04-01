Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E6EEC4332F
	for <virtualization@archiver.kernel.org>; Fri,  1 Apr 2022 14:31:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE84884533;
	Fri,  1 Apr 2022 14:31:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jbRuMa5zArEz; Fri,  1 Apr 2022 14:31:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5CD388452F;
	Fri,  1 Apr 2022 14:31:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 344A8C0082;
	Fri,  1 Apr 2022 14:31:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D988FC002C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Apr 2022 14:31:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C76F6424F9
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Apr 2022 14:31:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8FvRLp0awEDf
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Apr 2022 14:31:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8B76441ECD
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Apr 2022 14:31:31 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id C016EB824D5;
 Fri,  1 Apr 2022 14:31:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB95C3410F;
 Fri,  1 Apr 2022 14:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1648823487;
 bh=kcrTbfdM5LBcgXC2gmjAIGHsb9PqftTcUxe7Aqph+Qo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Sf2sJIPe21r9juNheQ75xb9L5sfnhtiulIs3A+PPSwExoec1c6W2iGV6ijyHUxalW
 TZamdghhVcmVyg811B8SiZGErAJXo75Ba12NpdSRptdx/3DEH/qz7nh96PqfRUJ703
 FfwkG8qn8EWxJW1r1SMiEGtRXDG1RxIrN1T+rTTqoyuIoMzwT65ztA4hS82RUe6aj8
 jfUSRVHUHWa6krxc61ioVw347eNUWt2t+yubUKAfRPc1wtXaHlCCCjbtXs6liN2wDa
 aodXWsb5BG/lq9x3U8YcEZDDDxXLeBTLMb4jwFhatTu/fIKWNrdSb0SazzLXBnASll
 f5Z0yfL+lvYsg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.17 114/149] tuntap: add sanity checks about
 msg_controllen in sendmsg
Date: Fri,  1 Apr 2022 10:25:01 -0400
Message-Id: <20220401142536.1948161-114-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220401142536.1948161-1-sashal@kernel.org>
References: <20220401142536.1948161-1-sashal@kernel.org>
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
index 8e3a28ba6b28..ba2ef5437e16 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -1198,7 +1198,8 @@ static int tap_sendmsg(struct socket *sock, struct msghdr *m,
 	struct xdp_buff *xdp;
 	int i;
 
-	if (ctl && (ctl->type == TUN_MSG_PTR)) {
+	if (m->msg_controllen == sizeof(struct tun_msg_ctl) &&
+	    ctl && ctl->type == TUN_MSG_PTR) {
 		for (i = 0; i < ctl->num; i++) {
 			xdp = &((struct xdp_buff *)ctl->ptr)[i];
 			tap_get_user_xdp(q, xdp);
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index fed85447701a..de999e0fedbc 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2489,7 +2489,8 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 	if (!tun)
 		return -EBADFD;
 
-	if (ctl && (ctl->type == TUN_MSG_PTR)) {
+	if (m->msg_controllen == sizeof(struct tun_msg_ctl) &&
+	    ctl && ctl->type == TUN_MSG_PTR) {
 		struct tun_page tpage;
 		int n = ctl->num;
 		int flush = 0;
diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 28ef323882fb..792ab5f23647 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -473,6 +473,7 @@ static void vhost_tx_batch(struct vhost_net *net,
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
