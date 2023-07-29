Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F288C001DC
	for <virtualization@archiver.kernel.org>; Sat, 29 Jul 2023 12:41:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 69B814017B;
	Sat, 29 Jul 2023 12:41:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 69B814017B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ds0u3zV5FCgj; Sat, 29 Jul 2023 12:41:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EA107400C8;
	Sat, 29 Jul 2023 12:41:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EA107400C8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8C87C0072;
	Sat, 29 Jul 2023 12:41:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 283F9C0032
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jul 2023 12:41:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F376C4017B
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jul 2023 12:41:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F376C4017B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2xAMuHQDVkpP
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jul 2023 12:41:06 +0000 (UTC)
X-Greylist: delayed 1192 seconds by postgrey-1.37 at util1.osuosl.org;
 Sat, 29 Jul 2023 12:41:06 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 491D6400C8
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 491D6400C8
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jul 2023 12:41:05 +0000 (UTC)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RCk952wBdzrRft;
 Sat, 29 Jul 2023 20:20:09 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 29 Jul
 2023 20:21:06 +0800
To: <bryantan@vmware.com>, <vdasa@vmware.com>, <pv-drivers@vmware.com>,
 <sgarzare@redhat.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <yuehaibing@huawei.com>
Subject: [PATCH net-next] vsock: Remove unused function declarations
Date: Sat, 29 Jul 2023 20:20:36 +0800
Message-ID: <20230729122036.32988-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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
From: Yue Haibing via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Yue Haibing <yuehaibing@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

These are never implemented since introduction in
commit d021c344051a ("VSOCK: Introduce VM Sockets")

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/vmw_vsock/vmci_transport.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/vmw_vsock/vmci_transport.h b/net/vmw_vsock/vmci_transport.h
index b7b072194282..dbda3ababa14 100644
--- a/net/vmw_vsock/vmci_transport.h
+++ b/net/vmw_vsock/vmci_transport.h
@@ -116,9 +116,6 @@ struct vmci_transport {
 	spinlock_t lock; /* protects sk. */
 };
 
-int vmci_transport_register(void);
-void vmci_transport_unregister(void);
-
 int vmci_transport_send_wrote_bh(struct sockaddr_vm *dst,
 				 struct sockaddr_vm *src);
 int vmci_transport_send_read_bh(struct sockaddr_vm *dst,
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
