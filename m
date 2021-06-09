Return-Path: <SRS0=l8rc=LD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09086C48BCF
	for <virtualization@archiver.kernel.org>; Wed,  9 Jun 2021 23:27:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC460613EF
	for <virtualization@archiver.kernel.org>; Wed,  9 Jun 2021 23:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC460613EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 97BD740215;
	Wed,  9 Jun 2021 23:27:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZfzsCzhbG50d; Wed,  9 Jun 2021 23:27:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 33AC4401F8;
	Wed,  9 Jun 2021 23:27:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BA99C000E;
	Wed,  9 Jun 2021 23:27:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 204FBC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 23:27:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0E9BF60881
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 23:27:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J8IuYcqUtAVz
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 23:27:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7497560871
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 23:27:49 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 m13-20020a17090b068db02901656cc93a75so2596232pjz.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Jun 2021 16:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ryjTh+mD4YySh21tlg0ARtI0y9ZaLutIYM7xzEboUMM=;
 b=PGAajtMkuQ3LaeTRZIG07olMjiCPi1sq3ITEedmcyp4kGig8kV2hTPoI3NKR1B1a+E
 8MeDJ3E5rcRaw7ehm8sgbCOJZsSlU3wxL1I1kkWGJHw8GfGA2VVggWGRCQl85yUFLIaF
 b6VAkSQrOHIuq/euJ1bRx9Jl62SkXI8en5mJuL64oPOMb0VY6wCZYa4i/UeyG0Wvyvj5
 mDL8xJiHUkGbyJxM0c/SCIaJOiUow9O3q6HgxLoYfJ8rdGG0AVCj30CRyBNcgfEPyuW2
 w3KYyJg2uij3Y7S1OWR87xbEYWkKXCZrsl/v+7BehEMo1x3WTj1Yfp1LetwJ32a0eONp
 18tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ryjTh+mD4YySh21tlg0ARtI0y9ZaLutIYM7xzEboUMM=;
 b=a6GRlmmY3SW84eEE8wPBE4WHmZx0iEoHrmwblp3wwMOI9HfUjmur5wGmJrmlOdpMuh
 wrBfi7gHUvU3k+Kw+EraFG7rtUNeaOe1C6ZkWxr24TturPDa+531lc82TDONqIsLEVNl
 /EqFU1DIIZarpqkZhXnkGoSpHugwuTnFnajiu6PxjB/BpocyEYL77NWctcc8AVul9ees
 XNVsgx6fsowjfGvRqx8PL7mLi2eIGQzBYGZarpK5Ktd32qG8OUA2BnnzRUiMJZr4/yIh
 5TUoHazCDwUQo7AnSmuhwQpnUhr67lGrIrkcPKDsmQMPjE7wEZZrU3GtJtICwzd46ysY
 V3Wg==
X-Gm-Message-State: AOAM532C6V9tpaPZrDkeK9ub09cbYy6TSWV98c+e1tHL+5YoyycLfmAT
 09KzRXgn7uwr6LcouDQ9wFgV/w==
X-Google-Smtp-Source: ABdhPJxV7dXx9oYLLYKaZWYQUOlR4GVI03/GJ5W/+RMY3mRb75ZKPONwNUoGp6uEe7gqZSngjxUlYg==
X-Received: by 2002:a17:90a:398f:: with SMTP id
 z15mr125059pjb.183.1623281268943; 
 Wed, 09 Jun 2021 16:27:48 -0700 (PDT)
Received: from n124-121-013.byted.org
 (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
 by smtp.gmail.com with ESMTPSA id k1sm526783pfa.30.2021.06.09.16.27.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Jun 2021 16:27:48 -0700 (PDT)
From: Jiang Wang <jiang.wang@bytedance.com>
To: sgarzare@redhat.com
Subject: [RFC v1 5/6] vhost/vsock: add kconfig for vhost dgram support
Date: Wed,  9 Jun 2021 23:24:57 +0000
Message-Id: <20210609232501.171257-6-jiang.wang@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210609232501.171257-1-jiang.wang@bytedance.com>
References: <20210609232501.171257-1-jiang.wang@bytedance.com>
Cc: cong.wang@bytedance.com, Andra Paraschiv <andraprs@amazon.com>,
 kvm@vger.kernel.org, mst@redhat.com, virtualization@lists.linux-foundation.org,
 Norbert Slusarek <nslusarek@gmx.net>, jhansen@vmware.comments,
 duanxiongchun@bytedance.com, xieyongji@bytedance.com,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Alexander Popov <alex.popov@linux.com>, Steven Rostedt <rostedt@goodmis.org>,
 chaiwen.cc@bytedance.com, stefanha@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lu Wei <luwei32@huawei.com>,
 Colin Ian King <colin.king@canonical.com>, arseny.krasnov@kaspersky.com,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Also change number of vqs according to the config

Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
---
 drivers/vhost/Kconfig |  8 ++++++++
 drivers/vhost/vsock.c | 11 ++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
index 587fbae06182..d63fffee6007 100644
--- a/drivers/vhost/Kconfig
+++ b/drivers/vhost/Kconfig
@@ -61,6 +61,14 @@ config VHOST_VSOCK
 	To compile this driver as a module, choose M here: the module will be called
 	vhost_vsock.
 
+config VHOST_VSOCK_DGRAM
+	bool "vhost vsock datagram sockets support"
+	depends on VHOST_VSOCK
+	default n
+	help
+	Enable vhost-vsock to support datagram types vsock.  The QEMU
+	and the guest must support datagram types too to use it.
+
 config VHOST_VDPA
 	tristate "Vhost driver for vDPA-based backend"
 	depends on EVENTFD
diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index d366463be6d4..12ca1dc0268f 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -48,7 +48,11 @@ static DEFINE_READ_MOSTLY_HASHTABLE(vhost_vsock_hash, 8);
 
 struct vhost_vsock {
 	struct vhost_dev dev;
+#ifdef CONFIG_VHOST_VSOCK_DGRAM
 	struct vhost_virtqueue vqs[4];
+#else
+	struct vhost_virtqueue vqs[2];
+#endif
 
 	/* Link to global vhost_vsock_hash, writes use vhost_vsock_mutex */
 	struct hlist_node hash;
@@ -763,15 +767,16 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 
 	vqs[VSOCK_VQ_TX] = &vsock->vqs[VSOCK_VQ_TX];
 	vqs[VSOCK_VQ_RX] = &vsock->vqs[VSOCK_VQ_RX];
-	vqs[VSOCK_VQ_DGRAM_TX] = &vsock->vqs[VSOCK_VQ_DGRAM_TX];
-	vqs[VSOCK_VQ_DGRAM_RX] = &vsock->vqs[VSOCK_VQ_DGRAM_RX];
 	vsock->vqs[VSOCK_VQ_TX].handle_kick = vhost_vsock_handle_tx_kick;
 	vsock->vqs[VSOCK_VQ_RX].handle_kick = vhost_vsock_handle_rx_kick;
+#ifdef CONFIG_VHOST_VSOCK_DGRAM
+	vqs[VSOCK_VQ_DGRAM_TX] = &vsock->vqs[VSOCK_VQ_DGRAM_TX];
+	vqs[VSOCK_VQ_DGRAM_RX] = &vsock->vqs[VSOCK_VQ_DGRAM_RX];
 	vsock->vqs[VSOCK_VQ_DGRAM_TX].handle_kick =
 						vhost_vsock_handle_tx_kick;
 	vsock->vqs[VSOCK_VQ_DGRAM_RX].handle_kick =
 						vhost_vsock_handle_rx_kick;
-
+#endif
 	vhost_dev_init(&vsock->dev, vqs, ARRAY_SIZE(vsock->vqs),
 		       UIO_MAXIOV, VHOST_VSOCK_PKT_WEIGHT,
 		       VHOST_VSOCK_WEIGHT, true, NULL);
-- 
2.11.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
