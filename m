Return-Path: <SRS0=81yh=LM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB501C48BDF
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 10:04:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8220C613EB
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 10:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8220C613EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40CAD83C78;
	Fri, 18 Jun 2021 10:04:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eTv6V4yfFl5j; Fri, 18 Jun 2021 10:04:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E46A283C51;
	Fri, 18 Jun 2021 10:04:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE982C000D;
	Fri, 18 Jun 2021 10:04:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5CF6C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 10:04:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9665440210
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 10:04:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ixRG4VHxHXC3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 10:04:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D35AB40208
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 10:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624010673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C+6Ax3LentWYghpfcXmHx6GVq/FWipz1+qsS7V10Qvs=;
 b=NzsnWCd44JTcUbb1+lGcbNQvfbn09Q9I8x+bb0UFdawtB+Oez8W4JdJ1czPhHWWbD/fO5f
 QVKA2BX5YIrc+MYc71KzmjIk8WtQu+f28w4tT7IakZkfklNvwVfErUsM/2rjkpyv3nveKk
 0GUdWn6LIkTaLHJxjbzd9hO8ZLkNIzk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-lDHkWD57POSYvw25HYlFwA-1; Fri, 18 Jun 2021 06:04:30 -0400
X-MC-Unique: lDHkWD57POSYvw25HYlFwA-1
Received: by mail-ej1-f71.google.com with SMTP id
 l6-20020a1709062a86b029046ec0ceaf5cso1257224eje.8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 03:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=C+6Ax3LentWYghpfcXmHx6GVq/FWipz1+qsS7V10Qvs=;
 b=sm8n+/ET/f5TlPFLVYLgHw5W5iK9o/NdyduxrZzoF/cF0kTcSAtQWw8/JMIeQFGWOg
 +Q/ghQi5GDX2DyHa85MdpWt5R7B8E/UH3vtsBAdsVhu71cZip0g0aTB5+kfkUNn3sch6
 iHj+gg2YlntaayLQDagBm0vkx1BuRk2mX4vxBxWa8JrxRor2ZrZVrios/+TAhb8hHTtV
 Lvvkk4gkUmzCVFKMOE6N5+5M6SxxFZLUfPYyJwHXwJjJf7feanL4nNnENgdtGaujR2Oh
 00cd4kniHeRxepP/B+ryflrom7ID2FbCe8Z4J+pdsHXhFmyu41qWPlhTlc/vNRENnWYw
 kDvw==
X-Gm-Message-State: AOAM530IBr6F8YShZc7TMz5Ih7YNwVGshojhdZjeU0f3/iTwsUacfHPs
 +3SqlhSwKbXs3QdcdXwXasRvNBAVyV6aKhX/BaPb/kIOc2hDu6i7K587gcOLMdnhVOiMhmgjOa/
 tRCFSx8pK31GcKxtXrXC/onbx701+5P7RjFOYAR/XpA==
X-Received: by 2002:a05:6402:5cc:: with SMTP id
 n12mr2338899edx.354.1624010669214; 
 Fri, 18 Jun 2021 03:04:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXnhV9u3UPtDPZ5wiT7NcGjAUcA+9ONBjHs3vBezHXdfaY/16q9aXbQXwio5ukcq0ncVkkew==
X-Received: by 2002:a05:6402:5cc:: with SMTP id
 n12mr2338862edx.354.1624010669049; 
 Fri, 18 Jun 2021 03:04:29 -0700 (PDT)
Received: from steredhat.lan ([5.170.128.252])
 by smtp.gmail.com with ESMTPSA id df20sm5585787edb.76.2021.06.18.03.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jun 2021 03:04:28 -0700 (PDT)
Date: Fri, 18 Jun 2021 12:04:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jiang Wang <jiang.wang@bytedance.com>
Subject: Re: [RFC v1 6/6] virtio/vsock: add sysfs for rx buf len for dgram
Message-ID: <20210618100424.wfljrnycxxguwt3d@steredhat.lan>
References: <20210609232501.171257-1-jiang.wang@bytedance.com>
 <20210609232501.171257-7-jiang.wang@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210609232501.171257-7-jiang.wang@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Jun 09, 2021 at 11:24:58PM +0000, Jiang Wang wrote:
>Make rx buf len configurable via sysfs
>
>Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
>---
> net/vmw_vsock/virtio_transport.c | 37 +++++++++++++++++++++++++++++++++++--
> 1 file changed, 35 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index cf47aadb0c34..2e4dd9c48472 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -29,6 +29,14 @@ static struct virtio_vsock __rcu *the_virtio_vsock;
> static struct virtio_vsock *the_virtio_vsock_dgram;
> static DEFINE_MUTEX(the_virtio_vsock_mutex); /* protects the_virtio_vsock */
>
>+static int rx_buf_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE;
>+static struct kobject *kobj_ref;
>+static ssize_t  sysfs_show(struct kobject *kobj,
>+			struct kobj_attribute *attr, char *buf);
>+static ssize_t  sysfs_store(struct kobject *kobj,
>+			struct kobj_attribute *attr, const char *buf, size_t count);
>+static struct kobj_attribute rxbuf_attr = __ATTR(rx_buf_value, 0660, sysfs_show, sysfs_store);

Maybe better to use a 'dgram' prefix.

>+
> struct virtio_vsock {
> 	struct virtio_device *vdev;
> 	struct virtqueue **vqs;
>@@ -360,7 +368,7 @@ virtio_transport_cancel_pkt(struct vsock_sock *vsk)
>
> static void virtio_vsock_rx_fill(struct virtio_vsock *vsock, bool is_dgram)
> {
>-	int buf_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE;
>+	int buf_len = rx_buf_len;
> 	struct virtio_vsock_pkt *pkt;
> 	struct scatterlist hdr, buf, *sgs[2];
> 	struct virtqueue *vq;
>@@ -1003,6 +1011,22 @@ static struct virtio_driver virtio_vsock_driver = {
> 	.remove = virtio_vsock_remove,
> };
>
>+static ssize_t sysfs_show(struct kobject *kobj,
>+		struct kobj_attribute *attr, char *buf)
>+{
>+	return sprintf(buf, "%d", rx_buf_len);
>+}
>+
>+static ssize_t sysfs_store(struct kobject *kobj,
>+		struct kobj_attribute *attr, const char *buf, size_t count)
>+{
>+	if (kstrtou32(buf, 0, &rx_buf_len) < 0)
>+		return -EINVAL;
>+	if (rx_buf_len < 1024)
>+		rx_buf_len = 1024;
>+	return count;
>+}
>+
> static int __init virtio_vsock_init(void)
> {
> 	int ret;
>@@ -1020,8 +1044,17 @@ static int __init virtio_vsock_init(void)
> 	if (ret)
> 		goto out_vci;
>
>-	return 0;
>+	kobj_ref = kobject_create_and_add("vsock", kernel_kobj);

So, IIUC, the path will be /sys/vsock/rx_buf_value?

I'm not sure if we need to add a `virtio` subdir (e.g.
/sys/vsock/virtio/dgram_rx_buf_size)

Thanks,
Stefano

>
>+	/*Creating sysfs file for etx_value*/
>+	ret = sysfs_create_file(kobj_ref, &rxbuf_attr.attr);
>+	if (ret)
>+		goto out_sysfs;
>+
>+	return 0;
>+out_sysfs:
>+	kobject_put(kobj_ref);
>+	sysfs_remove_file(kernel_kobj, &rxbuf_attr.attr);
> out_vci:
> 	vsock_core_unregister(&virtio_transport.transport);
> out_wq:
>-- 
>2.11.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
