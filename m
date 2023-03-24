Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B21FC6FD20
	for <virtualization@archiver.kernel.org>; Fri, 24 Mar 2023 11:55:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6455E41F4E;
	Fri, 24 Mar 2023 11:55:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6455E41F4E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BvrFAyZd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NwF9TNoAozC2; Fri, 24 Mar 2023 11:55:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 62C8241F4A;
	Fri, 24 Mar 2023 11:55:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 62C8241F4A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22E33C0035;
	Fri, 24 Mar 2023 11:55:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05E1AC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 11:55:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CED4481FEA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 11:55:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CED4481FEA
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BvrFAyZd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sF6t9xqcCwvr
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 11:55:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EC79F81FDA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EC79F81FDA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 11:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679658900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=o+NGktWMseNGfUqMMOZXVUXPZfRBI2cuMMXpzSQXhTs=;
 b=BvrFAyZdrzOqD6nbLzI2P/nGvS4jIi2bC2ZfikBGe9O8F98hMjCuoyBxttxyZ39XJ8XDT3
 aCdr1vKnkBfe/y7bWWOM9Ha/ngdnM4j/qEb0drNF80CROVAQrJlkBcygtu2wGbMiPn1uga
 f4YLy0fmKolPuL1F6Mw2zU9Fyv7drac=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-QyTD-zFkM8GERkspEb3FCA-1; Fri, 24 Mar 2023 07:54:59 -0400
X-MC-Unique: QyTD-zFkM8GERkspEb3FCA-1
Received: by mail-ed1-f71.google.com with SMTP id
 f15-20020a50a6cf000000b0050050d2326aso2785465edc.18
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 04:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679658898;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o+NGktWMseNGfUqMMOZXVUXPZfRBI2cuMMXpzSQXhTs=;
 b=taceIEfYnwT0YhAlAkGOptXt2yvWfDCXCmWrRgf1nbMTe+uZ8sAkyPhlozsQMgKBMG
 IdvfpSgmUu/aov9MpIFR3em760tkKuVgWSrsm8cPBeV6H0icPxcUF1lNvYsBqK/Mb5cH
 aBFVh2wBZuBygLBgd1F9/7RJrMw+eVWGEgP0eoJ9X+gJXTIJ1wzTzszqpn8RJajfVUGj
 ZDEQyZCntRlWGf6hpfZdlu/xvwjhYjCyeuMOcq0YNqSKgg5V9dpLlU5LEM8Apd2z2X6h
 nwqpR0JBz11g0odnRaU9kKLCYgaTFOHwygCDrI0lTh0eTVMbG/gUfnJunCV06txS5wBG
 xQEg==
X-Gm-Message-State: AAQBX9d1PrEKN6cmILsgspJueBrt6JQpabQOPZlTXhWc9tALRNnqlPuV
 N+iRDffUrTG3QmIMqGCdtThy01eUQWy59KU46UwCLC+AEY7KxLdNLVU7ImsXlj94LrAJ+seZJAb
 xDo476sxYVJQqD+JQv4pVV+LHWlw/rMIUzBYIgOtYVw==
X-Received: by 2002:aa7:da82:0:b0:502:100c:53a with SMTP id
 q2-20020aa7da82000000b00502100c053amr3077952eds.41.1679658898277; 
 Fri, 24 Mar 2023 04:54:58 -0700 (PDT)
X-Google-Smtp-Source: AKy350a2BftDLdHSiXK8s1hrtYYBfNg5thmCdq/Nta4rzlvwQHmMyC+RKWswAjDMk6HYVn/7+xcAeA==
X-Received: by 2002:aa7:da82:0:b0:502:100c:53a with SMTP id
 q2-20020aa7da82000000b00502100c053amr3077932eds.41.1679658897990; 
 Fri, 24 Mar 2023 04:54:57 -0700 (PDT)
Received: from localhost.localdomain
 (host-82-53-134-98.retail.telecomitalia.it. [82.53.134.98])
 by smtp.gmail.com with ESMTPSA id
 v30-20020a50a45e000000b005021d17d896sm1153485edb.21.2023.03.24.04.54.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Mar 2023 04:54:57 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Subject: [PATCH net] vsock/loopback: use only sk_buff_head.lock to protect the
 packet queue
Date: Fri, 24 Mar 2023 12:54:50 +0100
Message-Id: <20230324115450.11268-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: avkrasnov@sberdevices.ru, Bobby Eshleman <bobby.eshleman@bytedance.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 syzbot+befff0a9536049e7902e@syzkaller.appspotmail.com,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

pkt_list_lock was used before commit 71dc9ec9ac7d ("virtio/vsock:
replace virtio_vsock_pkt with sk_buff") to protect the packet queue.
After that commit we switched to sk_buff and we are using
sk_buff_head.lock in almost every place to protect the packet queue
except in vsock_loopback_work() when we call skb_queue_splice_init().

As reported by syzbot, this caused unlocked concurrent access to the
packet queue between vsock_loopback_work() and
vsock_loopback_cancel_pkt() since it is not holding pkt_list_lock.

With the introduction of sk_buff_head, pkt_list_lock is redundant and
can cause confusion, so let's remove it and use sk_buff_head.lock
everywhere to protect the packet queue access.

Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
Cc: bobby.eshleman@bytedance.com
Reported-and-tested-by: syzbot+befff0a9536049e7902e@syzkaller.appspotmail.com
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/vsock_loopback.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
index 671e03240fc5..89905c092645 100644
--- a/net/vmw_vsock/vsock_loopback.c
+++ b/net/vmw_vsock/vsock_loopback.c
@@ -15,7 +15,6 @@
 struct vsock_loopback {
 	struct workqueue_struct *workqueue;
 
-	spinlock_t pkt_list_lock; /* protects pkt_list */
 	struct sk_buff_head pkt_queue;
 	struct work_struct pkt_work;
 };
@@ -32,9 +31,7 @@ static int vsock_loopback_send_pkt(struct sk_buff *skb)
 	struct vsock_loopback *vsock = &the_vsock_loopback;
 	int len = skb->len;
 
-	spin_lock_bh(&vsock->pkt_list_lock);
 	skb_queue_tail(&vsock->pkt_queue, skb);
-	spin_unlock_bh(&vsock->pkt_list_lock);
 
 	queue_work(vsock->workqueue, &vsock->pkt_work);
 
@@ -113,9 +110,9 @@ static void vsock_loopback_work(struct work_struct *work)
 
 	skb_queue_head_init(&pkts);
 
-	spin_lock_bh(&vsock->pkt_list_lock);
+	spin_lock_bh(&vsock->pkt_queue.lock);
 	skb_queue_splice_init(&vsock->pkt_queue, &pkts);
-	spin_unlock_bh(&vsock->pkt_list_lock);
+	spin_unlock_bh(&vsock->pkt_queue.lock);
 
 	while ((skb = __skb_dequeue(&pkts))) {
 		virtio_transport_deliver_tap_pkt(skb);
@@ -132,7 +129,6 @@ static int __init vsock_loopback_init(void)
 	if (!vsock->workqueue)
 		return -ENOMEM;
 
-	spin_lock_init(&vsock->pkt_list_lock);
 	skb_queue_head_init(&vsock->pkt_queue);
 	INIT_WORK(&vsock->pkt_work, vsock_loopback_work);
 
@@ -156,9 +152,7 @@ static void __exit vsock_loopback_exit(void)
 
 	flush_work(&vsock->pkt_work);
 
-	spin_lock_bh(&vsock->pkt_list_lock);
 	virtio_vsock_skb_queue_purge(&vsock->pkt_queue);
-	spin_unlock_bh(&vsock->pkt_list_lock);
 
 	destroy_workqueue(vsock->workqueue);
 }
-- 
2.39.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
