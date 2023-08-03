Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8759C001DF
	for <virtualization@archiver.kernel.org>; Thu,  3 Aug 2023 13:45:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 515C34012A;
	Thu,  3 Aug 2023 13:45:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 515C34012A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ExVPZTYrmd_E; Thu,  3 Aug 2023 13:45:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E45744023D;
	Thu,  3 Aug 2023 13:45:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E45744023D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BEDC2C0072;
	Thu,  3 Aug 2023 13:45:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C223C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Aug 2023 13:45:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EBB3D8144A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Aug 2023 13:45:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EBB3D8144A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0QCJiPvhWS1c
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Aug 2023 13:45:28 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BA7A180C7B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Aug 2023 13:45:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BA7A180C7B
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.56])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RGqnv0s6Rz1KC9j;
 Thu,  3 Aug 2023 21:44:19 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 21:45:22 +0800
To: <sgarzare@redhat.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <bobby.eshleman@bytedance.com>,
 <yuehaibing@huawei.com>
Subject: [PATCH -next] af_vsock: Remove unused declaration
 vsock_release_pending()/vsock_init_tap()
Date: Thu, 3 Aug 2023 21:45:07 +0800
Message-ID: <20230803134507.22660-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
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
From: Yue Haibing via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Yue Haibing <yuehaibing@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Commit d021c344051a ("VSOCK: Introduce VM Sockets") declared but never implemented
vsock_release_pending(). Also vsock_init_tap() never implemented since introduction
in commit 531b374834c8 ("VSOCK: Add vsockmon tap functions").

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/net/af_vsock.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 0e7504a42925..b01cf9ac2437 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -201,7 +201,6 @@ static inline bool __vsock_in_connected_table(struct vsock_sock *vsk)
 	return !list_empty(&vsk->connected_table);
 }
 
-void vsock_release_pending(struct sock *pending);
 void vsock_add_pending(struct sock *listener, struct sock *pending);
 void vsock_remove_pending(struct sock *listener, struct sock *pending);
 void vsock_enqueue_accept(struct sock *listener, struct sock *connected);
@@ -225,7 +224,6 @@ struct vsock_tap {
 	struct list_head list;
 };
 
-int vsock_init_tap(void);
 int vsock_add_tap(struct vsock_tap *vt);
 int vsock_remove_tap(struct vsock_tap *vt);
 void vsock_deliver_tap(struct sk_buff *build_skb(void *opaque), void *opaque);
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
