Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1880BC0015E
	for <virtualization@archiver.kernel.org>; Tue, 27 Jun 2023 11:22:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8032C40547;
	Tue, 27 Jun 2023 11:22:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8032C40547
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f5yW+z4B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VnhRhuuVApBo; Tue, 27 Jun 2023 11:22:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EFDF040176;
	Tue, 27 Jun 2023 11:22:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EFDF040176
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC443C007C;
	Tue, 27 Jun 2023 11:22:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D08AC0037
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 11:22:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 53BBA60E27
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 11:22:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 53BBA60E27
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=f5yW+z4B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9lHfe10yD7HF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 11:22:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D8C0660BB3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D8C0660BB3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 11:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687864951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=AXpX6+bIX3VG+BFlIbD8IyCdNffvSiQAQaFthXvYXYA=;
 b=f5yW+z4BA9GZ4IMpu1WFTtfqvZRPySQPSst5tXvmaQd60QIiXmb9+JEw290gToA1XjnLGJ
 vOcSEftQHhmv0RNvFJDsrJv5nKUHHwlBBBfbSQm091akxJiPPOWDFqcPC8Skz/b3IhLQ1V
 DHeHfFCABYxOlNNgfzMuMXKDfPwBEus=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-458-KoLIc-NHPDWNdw4_zSVBwg-1; Tue, 27 Jun 2023 07:22:28 -0400
X-MC-Unique: KoLIc-NHPDWNdw4_zSVBwg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 638D11C07588;
 Tue, 27 Jun 2023 11:22:27 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 69FFF200A3AD;
 Tue, 27 Jun 2023 11:22:21 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/5] mm/memory_hotplug: make offline_and_remove_memory()
 timeout instead of failing on fatal signals
Date: Tue, 27 Jun 2023 13:22:15 +0200
Message-Id: <20230627112220.229240-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Michal Hocko <mhocko@suse.com>,
 John Hubbard <jhubbard@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>
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

As raised by John Hubbard [1], offline_and_remove_memory() failing on
fatal signals can be sub-optimal for out-of-tree drivers: dying user space
might be the last one holding a device node open.

As that device node gets closed, the driver might unplug the device
and trigger offline_and_remove_memory() to unplug previously
hotplugged device memory. This, however, will fail reliably when fatal
signals are pending on the dying process, turning the device unusable until
the machine gets rebooted.

That can be optizied easily by ignoring fatal signals. In fact, checking
for fatal signals in the case of offline_and_remove_memory() doesn't
make too much sense; the check makes sense when offlining is triggered
directly via sysfs.  However, we actually do want a way to not end up
stuck in offline_and_remove_memory() forever.

What offline_and_remove_memory() users actually want is fail after some
given timeout and not care about fatal signals.

So let's implement that, optimizing virtio-mem along the way.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

[1] https://lkml.kernel.org/r/20230620011719.155379-1-jhubbard@nvidia.com

David Hildenbrand (5):
  mm/memory_hotplug: check for fatal signals only in offline_pages()
  virtio-mem: convert most offline_and_remove_memory() errors to -EBUSY
  mm/memory_hotplug: make offline_and_remove_memory() timeout instead of
    failing on fatal signals
  virtio-mem: set the timeout for offline_and_remove_memory() to 10
    seconds
  virtio-mem: check if the config changed before (fake) offlining memory

 drivers/virtio/virtio_mem.c    | 22 +++++++++++++--
 include/linux/memory_hotplug.h |  2 +-
 mm/memory_hotplug.c            | 50 ++++++++++++++++++++++++++++++++--
 3 files changed, 68 insertions(+), 6 deletions(-)


base-commit: 6995e2de6891c724bfeb2db33d7b87775f913ad1
-- 
2.40.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
