Return-Path: <SRS0=LSNt=OE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B41BC433EF
	for <virtualization@archiver.kernel.org>; Tue, 14 Sep 2021 05:55:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 041B961151
	for <virtualization@archiver.kernel.org>; Tue, 14 Sep 2021 05:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 041B961151
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C0B92402FE;
	Tue, 14 Sep 2021 05:55:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nzjo0oR-6VVB; Tue, 14 Sep 2021 05:55:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2A737400C7;
	Tue, 14 Sep 2021 05:55:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5C9EC0011;
	Tue, 14 Sep 2021 05:55:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75D98C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 05:55:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 57E90607EB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 05:55:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TZBonlPs1z-8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 05:55:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C1723607E6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 05:55:39 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 f3-20020a17090a638300b00199097ddf1aso1313311pjj.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 22:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=G1r+PKn4GPi7tXv7G1Zx8y7Ad3TbADcUlxOtCJuMJ9E=;
 b=WFmQK5DvQiFqAYV8O83mKh1GmJeqLA1x0B9Xlco8l0r1opONGkdT5QuyB8bpIOp3Fi
 zKYVFf26FHs4soKGT03AZ/G9Uw6uABy33oR9dEhYkjkWLkhYXhZPtYCC+Eq48BSfp87l
 HuKXfjlhOEMy7qJhf59bxA6zimuQJkyVdQYIJK008JW8mv6ULCI7DnU8VRYh2mDZdH7C
 vjpNYsUNbD0vxnQhU+efAGEB8w969RI6U4nzw1tWg+fq3DxdcxXkZXkucXfarLeJxrvQ
 0o0fV7lYit9bRfM0qPeNWrSwymxqVMxw8ufxsQDj8Xla+g/MbAqtOB/G0AtxQdDsC+Be
 ylBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=G1r+PKn4GPi7tXv7G1Zx8y7Ad3TbADcUlxOtCJuMJ9E=;
 b=XT7X9DQ8fL5+u/4cF9G6Ts2yZoUNoS7UCNYWZlZ1uAadbVDrFu5ySyyUX0ErpzYzbw
 ToWxk5UdqhCbXADYz/14FXVujxMYs+IIQlHdrYoZ7bWoJJcDjKfmGO9DCMk5Tz3iZ2Zd
 d8ruNWWmy4Y5cRGKi9HcM+ZxaCps2EmLAm73IZ5qcuAhNJjJIo3SRbuvG7+GbWwXQdOt
 UVEXMCQpjq0G6Mg64CgCL4qc7jUUPs5lI9bntWSsKevG5ZljiPb89q4kF/P5N6lppDky
 +NHEYDRN33YOXvOD3EdMTG3C7BcmUvorz2dsblg0F9aEBbJiOJwYQQCpYMi2m9iQlKoQ
 vp9w==
X-Gm-Message-State: AOAM5331UY+t2L7RWVr4SOAU6nzlnvHWR2FM2/5xQbRKoWMPubbfZN8R
 KJLr123ajMyHCEWwf5OoYFS0rw==
X-Google-Smtp-Source: ABdhPJwHnmiE2l2SLtit++3MdPSftvz6R+3O0lu+TqRRVfEaMWXOAZMibzor2ZI3swNE5GqNONApug==
X-Received: by 2002:a17:90a:b794:: with SMTP id
 m20mr163206pjr.178.1631598939320; 
 Mon, 13 Sep 2021 22:55:39 -0700 (PDT)
Received: from ip-10-124-121-13.byted.org
 (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
 by smtp.gmail.com with ESMTPSA id v14sm719432pfi.111.2021.09.13.22.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 22:55:38 -0700 (PDT)
From: Jiang Wang <jiang.wang@bytedance.com>
To: jiangleetcode@gmail.com
Subject: [RFC v2 5/5] virtio/vsock: add sysfs for rx buf len for dgram
Date: Tue, 14 Sep 2021 05:54:38 +0000
Message-Id: <20210914055440.3121004-6-jiang.wang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210914055440.3121004-1-jiang.wang@bytedance.com>
References: <20210914055440.3121004-1-jiang.wang@bytedance.com>
MIME-Version: 1.0
Cc: cong.wang@bytedance.com, duanxiongchun@bytedance.com, kvm@vger.kernel.org,
 mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 chaiwen.cc@bytedance.com, stefanha@redhat.com,
 Jakub Kicinski <kuba@kernel.org>, arseny.krasnov@kaspersky.com,
 Ingo Molnar <mingo@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 jhansen@vmware.com
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

Make rx buf len configurable via sysfs

Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
---
 net/vmw_vsock/virtio_transport.c | 46 ++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 8d5bfcd79555..55216d979080 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -29,6 +29,16 @@ static struct virtio_vsock __rcu *the_virtio_vsock;
 static struct virtio_vsock *the_virtio_vsock_dgram;
 static DEFINE_MUTEX(the_virtio_vsock_mutex); /* protects the_virtio_vsock */
 
+static int rx_buf_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE;
+static struct kobject *kobj_ref, *kobj_ref2;
+static ssize_t  dgram_sysfs_show(struct kobject *kobj,
+				 struct kobj_attribute *attr, char *buf);
+static ssize_t  dgram_sysfs_store(struct kobject *kobj,
+				  struct kobj_attribute *attr, const char *buf,
+				  size_t count);
+static struct kobj_attribute rxbuf_attr = __ATTR(dgram_rx_buf_size, 0660, dgram_sysfs_show,
+						 dgram_sysfs_store);
+
 struct virtio_vsock {
 	struct virtio_device *vdev;
 	struct virtqueue **vqs;
@@ -362,7 +372,7 @@ virtio_transport_cancel_pkt(struct vsock_sock *vsk)
 
 static void virtio_vsock_rx_fill(struct virtio_vsock *vsock, bool is_dgram)
 {
-	int buf_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE;
+	int buf_len = rx_buf_len;
 	struct virtio_vsock_pkt *pkt;
 	struct scatterlist hdr, buf, *sgs[2];
 	struct virtqueue *vq;
@@ -1027,6 +1037,23 @@ static struct virtio_driver virtio_vsock_driver = {
 	.remove = virtio_vsock_remove,
 };
 
+static ssize_t dgram_sysfs_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d", rx_buf_len);
+}
+
+static ssize_t dgram_sysfs_store(struct kobject *kobj,
+				 struct kobj_attribute *attr, const char *buf,
+				 size_t count)
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
@@ -1044,8 +1071,19 @@ static int __init virtio_vsock_init(void)
 	if (ret)
 		goto out_vci;
 
-	return 0;
+	kobj_ref = kobject_create_and_add("vsock", kernel_kobj);
+	kobj_ref2 = kobject_create_and_add("virtio", kobj_ref);
+
+	/*Creating sysfs file for etx_value*/
+	ret = sysfs_create_file(kobj_ref2, &rxbuf_attr.attr);
+	if (ret)
+		goto out_sysfs;
 
+	return 0;
+out_sysfs:
+	kobject_put(kobj_ref);
+	kobject_put(kobj_ref2);
+	sysfs_remove_file(kobj_ref2, &rxbuf_attr.attr);
 out_vci:
 	vsock_core_unregister(&virtio_transport.transport);
 out_wq:
@@ -1058,6 +1096,10 @@ static void __exit virtio_vsock_exit(void)
 	unregister_virtio_driver(&virtio_vsock_driver);
 	vsock_core_unregister(&virtio_transport.transport);
 	destroy_workqueue(virtio_vsock_workqueue);
+	kobject_put(kobj_ref);
+	kobject_put(kobj_ref2);
+	sysfs_remove_file(kobj_ref2, &rxbuf_attr.attr);
+
 }
 
 module_init(virtio_vsock_init);
-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
