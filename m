Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0ED4C433F5
	for <virtualization@archiver.kernel.org>; Fri, 28 Jan 2022 09:41:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 81C17832EA;
	Fri, 28 Jan 2022 09:41:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oSoMGq2qfkLy; Fri, 28 Jan 2022 09:41:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 07CD9832E6;
	Fri, 28 Jan 2022 09:41:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB773C0011;
	Fri, 28 Jan 2022 09:41:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF784C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 09:41:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DCD9C60879
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 09:41:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wUeLx7AmRL4A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 09:41:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 418EB6080B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 09:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643362894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gm/zIaqxAUJ7weu5vueVLpk6KOEoe9UgJ0ELP0kscoU=;
 b=Lcr6ugdfO4DAufqmS42K+GCt7xOhdwloFhNeQYr/EwDD45hwwkHICR0lhZUUOlUvfPohXK
 0IRwamBqZWN/AatlhoJAFqHnJi4K3Zv4U4G76dfvlhDW0BOhQ4mLn6J5efb3EE6ZEgo+Y/
 NJm7xL8hxycbMxZyayWQ43VvoZepO4Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-195-L0FtYRHMPT-YziLMRXLoRw-1; Fri, 28 Jan 2022 04:41:32 -0500
X-MC-Unique: L0FtYRHMPT-YziLMRXLoRw-1
Received: by mail-wr1-f69.google.com with SMTP id
 v28-20020adfa1dc000000b001dd1cb24081so2038915wrv.10
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 01:41:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gm/zIaqxAUJ7weu5vueVLpk6KOEoe9UgJ0ELP0kscoU=;
 b=aO0taZrVQfml3YVXBwWmj4N64wuYJ6Bp7/omhO4iDms18I6D/stvbKUmWFJ+ysT3gW
 TIOTobbt5jyN40tTMQbUEApGWFA9u7x3zstTSf/REoQOk1sedSZegzRtR88Cwj/uBA2D
 TP+WF6hm30WOkW7fM6pFyHcmp1l4oE5T80W/s6jpyWOxiIEzM8IMRsNIii3Ks5uVi43b
 jwTOYTS8iVSHf9SNBNbtdAG1aZFM0Xwto88S5DPdcjAGRVSl4qL81ETxiKgKQnU2NZqm
 5JIsHQseP50yQZhOx+bnLSCWbqmvrTrYRJ7CSMpM4+TjMEbzkbtAWswp3w5DVY6x5i9f
 Y5cw==
X-Gm-Message-State: AOAM532tN7c0cQDkaxeuVsMPTMbQTHKXc14ywRl4JR3oIc1IG029ofhw
 F+0zzhO0ANI7OvdcFkbcnCKeuIDYvn+tdxZf/mfKlyAo9FTvWikyzNqWjkpwEgvRdWaN+f5LDoR
 EXZ3SERVzttJqi2w0rP0Q+dLq7v7IJ9yQ/3aQP3kM3avrmLH68absBJZ/jLI6keTmljKZMZWqP2
 ETd3X04V3YIgtYOGPMeQ==
X-Received: by 2002:a5d:554b:: with SMTP id g11mr6278091wrw.168.1643362891454; 
 Fri, 28 Jan 2022 01:41:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyhT/5ouoGIlyIxVyr+Q5hXpBEiMOVIvHbdPHh42746reFTj6j3DnyqBWI059BBKWi7Vf/56w==
X-Received: by 2002:a5d:554b:: with SMTP id g11mr6278075wrw.168.1643362891224; 
 Fri, 28 Jan 2022 01:41:31 -0800 (PST)
Received: from steredhat.redhat.com
 (host-95-238-125-214.retail.telecomitalia.it. [95.238.125.214])
 by smtp.gmail.com with ESMTPSA id o1sm683206wri.108.2022.01.28.01.41.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jan 2022 01:41:30 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v3] vhost: cache avail index in vhost_enable_notify()
Date: Fri, 28 Jan 2022 10:41:29 +0100
Message-Id: <20220128094129.40809-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stefanha@redhat.com
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

In vhost_enable_notify() we enable the notifications and we read
the avail index to check if new buffers have become available in
the meantime.

We do not update the cached avail index value, so when the device
will call vhost_get_vq_desc(), it will find the old value in the
cache and it will read the avail index again.

It would be better to refresh the cache every time we read avail
index, so let's change vhost_enable_notify() caching the value in
`avail_idx` and compare it with `last_avail_idx` to check if there
are new buffers available.

We don't expect a significant performance boost because
the above path is not very common, indeed vhost_enable_notify()
is often called with unlikely(), expecting that avail index has
not been updated.

We ran virtio-test/vhost-test and noticed minimal improvement as
expected. To stress the patch more, we modified vhost_test.ko to
call vhost_enable_notify()/vhost_disable_notify() on every cycle
when calling vhost_get_vq_desc(); in this case we observed a more
evident improvement, with a reduction of the test execution time
of about 3.7%.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v3
- reworded commit description [Stefan]
---
 drivers/vhost/vhost.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 59edb5a1ffe2..07363dff559e 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2543,8 +2543,9 @@ bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 		       &vq->avail->idx, r);
 		return false;
 	}
+	vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
 
-	return vhost16_to_cpu(vq, avail_idx) != vq->avail_idx;
+	return vq->avail_idx != vq->last_avail_idx;
 }
 EXPORT_SYMBOL_GPL(vhost_enable_notify);
 
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
