Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B43EC83F01
	for <virtualization@archiver.kernel.org>; Thu, 31 Aug 2023 01:10:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1E15E82281;
	Thu, 31 Aug 2023 01:10:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1E15E82281
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GQQibcyL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vcFDnwuGxacR; Thu, 31 Aug 2023 01:10:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9B0538225A;
	Thu, 31 Aug 2023 01:10:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9B0538225A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73261C0071;
	Thu, 31 Aug 2023 01:10:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6012C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Aug 2023 01:10:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9A66B81F36
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Aug 2023 01:10:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9A66B81F36
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R9Ns8jg1-hl2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Aug 2023 01:10:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8B8AB81DE3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Aug 2023 01:10:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8B8AB81DE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693444226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pe6GxItvkz9KwopaEUdmHmKZINpEI+HDrt1ySOet+Wk=;
 b=GQQibcyLeD5KC/ntO55et9hoNvi8/85H2bZdjQrmubTLqEgXnYHJ2NV7oR+a2lFLCWB+8U
 lUTXaykajw2RS8Wx4BQ6jDqcAQ7RFA0mvMi/s+LDBJcYBtneyUWivXXosG4HwaDbafU7cT
 DixdTrcQsKNXZWAJE3+CbuipM8UnKG8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-374-S28I4rjROVWLUv7sKMV1YA-1; Wed, 30 Aug 2023 21:10:21 -0400
X-MC-Unique: S28I4rjROVWLUv7sKMV1YA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D7158030A9;
 Thu, 31 Aug 2023 01:10:20 +0000 (UTC)
Received: from gshan.redhat.com (unknown [10.64.136.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C5EDE9A;
 Thu, 31 Aug 2023 01:10:17 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v2] virtio_balloon: Fix endless deflation and inflation on
 arm64
Date: Thu, 31 Aug 2023 11:10:07 +1000
Message-ID: <20230831011007.1032822-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 zhenyzha@redhat.com, shan.gavin@gmail.com
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

The deflation request to the target, which isn't unaligned to the
guest page size causes endless deflation and inflation actions. For
example, we receive the flooding QMP events for the changes on memory
balloon's size after a deflation request to the unaligned target is
sent for the ARM64 guest, where we have 64KB base page size.

  /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64      \
  -accel kvm -machine virt,gic-version=host -cpu host          \
  -smp maxcpus=8,cpus=8,sockets=2,clusters=2,cores=2,threads=1 \
  -m 1024M,slots=16,maxmem=64G                                 \
  -object memory-backend-ram,id=mem0,size=512M                 \
  -object memory-backend-ram,id=mem1,size=512M                 \
  -numa node,nodeid=0,memdev=mem0,cpus=0-3                     \
  -numa node,nodeid=1,memdev=mem1,cpus=4-7                     \
    :                                                          \
  -device virtio-balloon-pci,id=balloon0,bus=pcie.10

  { "execute" : "balloon", "arguments": { "value" : 1073672192 } }
  {"return": {}}
  {"timestamp": {"seconds": 1693272173, "microseconds": 88667},   \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
  {"timestamp": {"seconds": 1693272174, "microseconds": 89704},   \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
  {"timestamp": {"seconds": 1693272175, "microseconds": 90819},   \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
  {"timestamp": {"seconds": 1693272176, "microseconds": 91961},   \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
  {"timestamp": {"seconds": 1693272177, "microseconds": 93040},   \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
  {"timestamp": {"seconds": 1693272178, "microseconds": 94117},   \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
  {"timestamp": {"seconds": 1693272179, "microseconds": 95337},   \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
  {"timestamp": {"seconds": 1693272180, "microseconds": 96615},   \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
  {"timestamp": {"seconds": 1693272181, "microseconds": 97626},   \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
  {"timestamp": {"seconds": 1693272182, "microseconds": 98693},   \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
  {"timestamp": {"seconds": 1693272183, "microseconds": 99698},   \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
  {"timestamp": {"seconds": 1693272184, "microseconds": 100727},  \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
  {"timestamp": {"seconds": 1693272185, "microseconds": 90430},   \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
  {"timestamp": {"seconds": 1693272186, "microseconds": 102999},  \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
     :
  <The similar QMP events repeat>

Fix it by aligning the target up to the guest page size, 64KB in this
specific case. With this applied, no flooding QMP events are observed
and the memory balloon's size can be stablizied to 0x3ffe0000 soon
after the deflation request is sent.

  { "execute" : "balloon", "arguments": { "value" : 1073672192 } }
  {"return": {}}
  {"timestamp": {"seconds": 1693273328, "microseconds": 793075},  \
   "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
  { "execute" : "query-balloon" }
  {"return": {"actual": 1073610752}}

Signed-off-by: Gavin Shan <gshan@redhat.com>
Tested-by: Zhenyu Zhang <zhenyzha@redhat.com>
---
v2: Align @num_pages up to the guest page size in towards_target()
    directly as David suggested.
---
 drivers/virtio/virtio_balloon.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 5b15936a5214..2d5d252ef419 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -395,7 +395,11 @@ static inline s64 towards_target(struct virtio_balloon *vb)
 	virtio_cread_le(vb->vdev, struct virtio_balloon_config, num_pages,
 			&num_pages);
 
-	target = num_pages;
+	/*
+	 * Aligned up to guest page size to avoid inflating and deflating
+	 * balloon endlessly.
+	 */
+	target = ALIGN(num_pages, VIRTIO_BALLOON_PAGES_PER_PAGE);
 	return target - vb->num_pages;
 }
 
-- 
2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
