Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB24C433FE
	for <virtualization@archiver.kernel.org>; Wed,  9 Nov 2022 15:42:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EA42A4049A;
	Wed,  9 Nov 2022 15:42:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EA42A4049A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qk1YM57x
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id exE-8Byge55Y; Wed,  9 Nov 2022 15:42:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ED096404F4;
	Wed,  9 Nov 2022 15:42:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ED096404F4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0EE5C0032;
	Wed,  9 Nov 2022 15:42:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41D41C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 15:42:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 29A99403A9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 15:42:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 29A99403A9
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qk1YM57x
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3vDeEsB9VJNI
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 15:42:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E2A4C40298
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E2A4C40298
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 15:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668008539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uBVk1nqDlUO1v7VnKX9niZ4LQDEatQ7W082F8JoznKQ=;
 b=Qk1YM57xTbs9SXSHfW0xPEtOtcVF9iIebLHMmxMoFi18tsdqjScq6JeBvIu+0bUdWmYAzA
 bDl6C0YJ2K59ZyzC2IK0PD6wXwh+l/lRx5tC3IX6vGdAxPqNoV2qDBXXcwi/sLWzQywjrR
 VwnuvAuHj50NfabMWeZ47GKThi604kg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-597-0EH_2Un4No6KwcHJjTlzdw-1; Wed, 09 Nov 2022 10:42:18 -0500
X-MC-Unique: 0EH_2Un4No6KwcHJjTlzdw-1
Received: by mail-wm1-f72.google.com with SMTP id
 c10-20020a7bc84a000000b003cf81c2d3efso734912wml.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Nov 2022 07:42:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uBVk1nqDlUO1v7VnKX9niZ4LQDEatQ7W082F8JoznKQ=;
 b=CPcRJdfaS30TJ0Sp3OzsxpAATHqhPF0BRe5DXoDiDbxPmO99IFQbWWcJaiauTus3FD
 r2jpnlq+0MplxhWQt6cdMGmDiyPiEtosEezFU/jJnCkDU6cKuXKxIBYKCLFhkEAKhUFw
 somkstluOZOnJ1vtjxHrHI64dq47C+4527BJdQqq6Poisl7/I+dZzlItgahOOB4okFUU
 vS9K/uHqcU4FFnoWSY8bDtQWHrdiCK/Aa1PLci+ec0iH4LG+GrkuEGNn0zyzBeVxgdaW
 aSfPxOlcYi877GZnZBDHKF8bgWeliM5sfKmZFx4HFfLPqUejgnyNTOnuZsD0IQlX58Lt
 vTFA==
X-Gm-Message-State: ACrzQf3r/n/Y1/Y9YtmA7w2cvVoZR0IUqV3rfcLom7aNteiJqhb3jJs1
 yTeO/EfQFl4dnn9F9tVMkEeirQQQfkILfygdTvSDNE1ObCK2uqw/RuU4Y87FrbE5xwP4SAabWtL
 hPx5NAqnQn3UFA4oTMyzUYpKxTuIKuf91FcpNOFVNnYS/Mp13QoaUMf+kJPk8ujKU5JbGjmCaSz
 5PDVLbleLYbnS66VagqA==
X-Received: by 2002:a5d:4acc:0:b0:236:6665:b471 with SMTP id
 y12-20020a5d4acc000000b002366665b471mr40056313wrs.633.1668008535911; 
 Wed, 09 Nov 2022 07:42:15 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6Nup3xHjcr5VxzgJQLxU3Z8kDbx4kIJ2rHrJiE2B1Op4/F3Uk6ha1/jqX1LnJByU9gSr8umQ==
X-Received: by 2002:a5d:4acc:0:b0:236:6665:b471 with SMTP id
 y12-20020a5d4acc000000b002366665b471mr40056289wrs.633.1668008535575; 
 Wed, 09 Nov 2022 07:42:15 -0800 (PST)
Received: from step1.redhat.com (host-82-53-134-234.retail.telecomitalia.it.
 [82.53.134.234]) by smtp.gmail.com with ESMTPSA id
 i18-20020adfe492000000b002345cb2723esm13696712wrm.17.2022.11.09.07.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Nov 2022 07:42:14 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH] vhost-vdpa: fix potential memory leak during the release
Date: Wed,  9 Nov 2022 16:42:13 +0100
Message-Id: <20221109154213.146789-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, eperezma@redhat.com,
 Gautam Dawar <gautam.dawar@xilinx.com>
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

Before commit 3d5698793897 ("vhost-vdpa: introduce asid based IOTLB")
we call vhost_vdpa_iotlb_unmap(v, iotlb, 0ULL, 0ULL - 1) during the
release to free all the resources allocated when processing user IOTLB
messages through vhost_vdpa_process_iotlb_update().
That commit changed the handling of IOTLB a bit, and we accidentally
removed some code called during the release.

We partially fixed with commit 037d4305569a ("vhost-vdpa: call
vhost_vdpa_cleanup during the release") but a potential memory leak is
still there as showed by kmemleak if the application does not send
VHOST_IOTLB_INVALIDATE or crashes:

  unreferenced object 0xffff888007fbaa30 (size 16):
    comm "blkio-bench", pid 914, jiffies 4294993521 (age 885.500s)
    hex dump (first 16 bytes):
      40 73 41 07 80 88 ff ff 00 00 00 00 00 00 00 00  @sA.............
    backtrace:
      [<0000000087736d2a>] kmem_cache_alloc_trace+0x142/0x1c0
      [<0000000060740f50>] vhost_vdpa_process_iotlb_msg+0x68c/0x901 [vhost_vdpa]
      [<0000000083e8e205>] vhost_chr_write_iter+0xc0/0x4a0 [vhost]
      [<000000008f2f414a>] vhost_vdpa_chr_write_iter+0x18/0x20 [vhost_vdpa]
      [<00000000de1cd4a0>] vfs_write+0x216/0x4b0
      [<00000000a2850200>] ksys_write+0x71/0xf0
      [<00000000de8e720b>] __x64_sys_write+0x19/0x20
      [<0000000018b12cbb>] do_syscall_64+0x3f/0x90
      [<00000000986ec465>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

Let's fix calling vhost_vdpa_iotlb_unmap() on the whole range in
vhost_vdpa_remove_as(). We move that call before vhost_dev_cleanup()
since we need a valid v->vdev.mm in vhost_vdpa_pa_unmap().
vhost_iotlb_reset() call can be removed, since vhost_vdpa_iotlb_unmap()
on the whole range removes all the entries.

The kmemleak log reported was observed with a vDPA device that has `use_va`
set to true (e.g. VDUSE). This patch has been tested with both types of
devices.

Fixes: 037d4305569a ("vhost-vdpa: call vhost_vdpa_cleanup during the release")
Fixes: 3d5698793897 ("vhost-vdpa: introduce asid based IOTLB")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vdpa.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 166044642fd5..b08e07fc7d1f 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -65,6 +65,10 @@ static DEFINE_IDA(vhost_vdpa_ida);
 
 static dev_t vhost_vdpa_major;
 
+static void vhost_vdpa_iotlb_unmap(struct vhost_vdpa *v,
+				   struct vhost_iotlb *iotlb,
+				   u64 start, u64 last);
+
 static inline u32 iotlb_to_asid(struct vhost_iotlb *iotlb)
 {
 	struct vhost_vdpa_as *as = container_of(iotlb, struct
@@ -135,7 +139,7 @@ static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 asid)
 		return -EINVAL;
 
 	hlist_del(&as->hash_link);
-	vhost_iotlb_reset(&as->iotlb);
+	vhost_vdpa_iotlb_unmap(v, &as->iotlb, 0ULL, 0ULL - 1);
 	kfree(as);
 
 	return 0;
@@ -1162,14 +1166,14 @@ static void vhost_vdpa_cleanup(struct vhost_vdpa *v)
 	struct vhost_vdpa_as *as;
 	u32 asid;
 
-	vhost_dev_cleanup(&v->vdev);
-	kfree(v->vdev.vqs);
-
 	for (asid = 0; asid < v->vdpa->nas; asid++) {
 		as = asid_to_as(v, asid);
 		if (as)
 			vhost_vdpa_remove_as(v, asid);
 	}
+
+	vhost_dev_cleanup(&v->vdev);
+	kfree(v->vdev.vqs);
 }
 
 static int vhost_vdpa_open(struct inode *inode, struct file *filep)
-- 
2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
