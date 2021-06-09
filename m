Return-Path: <SRS0=l8rc=LD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99608C48BCD
	for <virtualization@archiver.kernel.org>; Wed,  9 Jun 2021 23:27:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 550A1613EA
	for <virtualization@archiver.kernel.org>; Wed,  9 Jun 2021 23:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 550A1613EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 263F74059C;
	Wed,  9 Jun 2021 23:27:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F5PTYC1Vh3VZ; Wed,  9 Jun 2021 23:27:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 787B440552;
	Wed,  9 Jun 2021 23:27:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 521F2C000E;
	Wed,  9 Jun 2021 23:27:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8BD5C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 23:27:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C44B3401BD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 23:27:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fTYvOO6enWV0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 23:27:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 35C77402CC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 23:27:54 +0000 (UTC)
Received: by mail-pf1-x435.google.com with SMTP id m7so29242pfa.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Jun 2021 16:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=XAzb3VkfUYxU1teKArHCgpj6NOb9ejMO6tAx0JjUIoQ=;
 b=O88kABLyJToxtXQQFFjKPeMLrJ6YesZtMujpSNeGlQr4FiygAaEUmju5bI0djjtyMO
 fmcAoWXx+PQjavZKTMLpBmCljJ1id5ISpmeoUMvTwVllZ38QED5U5oIuNgaW/8FJouyL
 OiLP0c9ZxGG9OOuD6Jj5yFH8xh1WJo4xhhiJnI4Ewx6elUoDWibQFNeKjkHo6Q41BgVZ
 6OhFZ6U33EpgC9MKiUFgd9OVoT0548QMf4OzuoRrZcGp5QgdYh/+iS6Pzfu0KaDlqjjv
 FBKDBtgmajPmIt/ZcOzKSapooa1CDhL0tp2kafx6jHLIeKGMC1KlffQdYwljAhBcx5Rl
 UFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=XAzb3VkfUYxU1teKArHCgpj6NOb9ejMO6tAx0JjUIoQ=;
 b=Ehwdz2L7DXFAmqV6z0akQfUWSzyg2sUrg5R6NkmV2cjqoIqyUIG4XO/JaMfaBifmUW
 K6fISNkCDxUq+8SLc2ITiw1AVe8ekhdmsIidO5AybauGfD/UeDqHYRalmqdMnD1tZU7h
 WcPNDL73I7jx3sLw5iTNOfH1JZpEIs37sXw6wmmY9sxpCrV7n7AyPNhfieHYqP0vLLNI
 zPxd7F9unVgw62/+jnWMUxP12UszdaUYToUqMoWNoJw4aTk2PPPcdylpuSwAHkrY5ilp
 Z3yJbadw17yDW5gWbPCW4kM3zmy0FfJJ+FuTxGAb5k3lYIfJFl+CPhLlqdVVw3G1eth+
 DScA==
X-Gm-Message-State: AOAM530aOKyCJNxWexrd+BbuXh/84D1XoUGAGZymNQRfcZufdMSBglRm
 5nyktGd5aSiLzYQc6rTsHHlbnQ==
X-Google-Smtp-Source: ABdhPJxf83Qcv5sMhiGgL1PwI1FYFWMLIxV5hrXF/xSHNmKBquW4gmSwSNNe2aOfHo5UenCXytSasw==
X-Received: by 2002:a63:de02:: with SMTP id f2mr2100758pgg.32.1623281273711;
 Wed, 09 Jun 2021 16:27:53 -0700 (PDT)
Received: from n124-121-013.byted.org
 (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
 by smtp.gmail.com with ESMTPSA id k1sm526783pfa.30.2021.06.09.16.27.52
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Jun 2021 16:27:53 -0700 (PDT)
From: Jiang Wang <jiang.wang@bytedance.com>
To: sgarzare@redhat.com
Subject: [RFC v1 6/6] virtio/vsock: add sysfs for rx buf len for dgram
Date: Wed,  9 Jun 2021 23:24:58 +0000
Message-Id: <20210609232501.171257-7-jiang.wang@bytedance.com>
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

Make rx buf len configurable via sysfs

Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
---
 net/vmw_vsock/virtio_transport.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index cf47aadb0c34..2e4dd9c48472 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -29,6 +29,14 @@ static struct virtio_vsock __rcu *the_virtio_vsock;
 static struct virtio_vsock *the_virtio_vsock_dgram;
 static DEFINE_MUTEX(the_virtio_vsock_mutex); /* protects the_virtio_vsock */
 
+static int rx_buf_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE;
+static struct kobject *kobj_ref;
+static ssize_t  sysfs_show(struct kobject *kobj,
+			struct kobj_attribute *attr, char *buf);
+static ssize_t  sysfs_store(struct kobject *kobj,
+			struct kobj_attribute *attr, const char *buf, size_t count);
+static struct kobj_attribute rxbuf_attr = __ATTR(rx_buf_value, 0660, sysfs_show, sysfs_store);
+
 struct virtio_vsock {
 	struct virtio_device *vdev;
 	struct virtqueue **vqs;
@@ -360,7 +368,7 @@ virtio_transport_cancel_pkt(struct vsock_sock *vsk)
 
 static void virtio_vsock_rx_fill(struct virtio_vsock *vsock, bool is_dgram)
 {
-	int buf_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE;
+	int buf_len = rx_buf_len;
 	struct virtio_vsock_pkt *pkt;
 	struct scatterlist hdr, buf, *sgs[2];
 	struct virtqueue *vq;
@@ -1003,6 +1011,22 @@ static struct virtio_driver virtio_vsock_driver = {
 	.remove = virtio_vsock_remove,
 };
 
+static ssize_t sysfs_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d", rx_buf_len);
+}
+
+static ssize_t sysfs_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	if (kstrtou32(buf, 0, &rx_buf_len) < 0)
+		return -EINVAL;
+	if (rx_buf_len < 1024)
+		rx_buf_len = 1024;
+	return count;
+}
+
 static int __init virtio_vsock_init(void)
 {
 	int ret;
@@ -1020,8 +1044,17 @@ static int __init virtio_vsock_init(void)
 	if (ret)
 		goto out_vci;
 
-	return 0;
+	kobj_ref = kobject_create_and_add("vsock", kernel_kobj);
 
+	/*Creating sysfs file for etx_value*/
+	ret = sysfs_create_file(kobj_ref, &rxbuf_attr.attr);
+	if (ret)
+		goto out_sysfs;
+
+	return 0;
+out_sysfs:
+	kobject_put(kobj_ref);
+	sysfs_remove_file(kernel_kobj, &rxbuf_attr.attr);
 out_vci:
 	vsock_core_unregister(&virtio_transport.transport);
 out_wq:
-- 
2.11.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
