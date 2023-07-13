Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB9BC001DE
	for <virtualization@archiver.kernel.org>; Thu, 13 Jul 2023 14:56:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EFB6641765;
	Thu, 13 Jul 2023 14:56:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EFB6641765
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bxWKmXXM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iqTtAuNpeIiC; Thu, 13 Jul 2023 14:56:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8A2A04175E;
	Thu, 13 Jul 2023 14:56:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8A2A04175E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5385EC0071;
	Thu, 13 Jul 2023 14:56:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39971C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:56:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0526D4208C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:56:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0526D4208C
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bxWKmXXM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DbQmrZysf9HU
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:56:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 25A2C4208D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 25A2C4208D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689260160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LptuTpvFDZBRRZm7T2FbpKgVlUR80XdDNd96fLSIzt8=;
 b=bxWKmXXMZskCQVzOK3s2LVTIJXiDoalDgwR4jNFVQzx39iz9cL6yxEWPKkC38D6ELDHINl
 Uem5ejeCyiTXT8RwYSb9oK05eEgoEPp5MhQqpYSpgMb4gaWJDCtWCfo9Zw31bdcyLzmAZW
 8s5Hw8Oyzx3Q/aj74qO6vcCc3xejcuw=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-327-UuHX7QVrOaKiCwlKvKf5PA-1; Thu, 13 Jul 2023 10:55:55 -0400
X-MC-Unique: UuHX7QVrOaKiCwlKvKf5PA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 45E9E3C0F67B;
 Thu, 13 Jul 2023 14:55:55 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.245])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 20A28F66CB;
 Thu, 13 Jul 2023 14:55:53 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/4] virtio-mem: memory unplug/offlining related cleanups
Date: Thu, 13 Jul 2023 16:55:47 +0200
Message-ID: <20230713145551.2824980-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org
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

Some cleanups+optimizations primarily around offline_and_remove_memory().

Patch #1 drops the "unsafe unplug" feature where we might get stuck in
offline_and_remove_memory() forever.

Patch #2 handles unexpected errors from offline_and_remove_memory() a bit
nicer.

Patch #3 handles the case where offline_and_remove_memory() failed and
we want to retry later to remove a completely unplugged Linux memory
block, to not have them waste memory forever.

Patch #4 something I had lying around for longer, which reacts faster
on config changes when unplugging memory.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

David Hildenbrand (4):
  virtio-mem: remove unsafe unplug in Big Block Mode (BBM)
  virtio-mem: convert most offline_and_remove_memory() errors to -EBUSY
  virtio-mem: keep retrying on offline_and_remove_memory() errors in Sub
    Block Mode (SBM)
  virtio-mem: check if the config changed before fake offlining memory

 drivers/virtio/virtio_mem.c | 168 ++++++++++++++++++++++++------------
 1 file changed, 112 insertions(+), 56 deletions(-)


base-commit: 3f01e9fed8454dcd89727016c3e5b2fbb8f8e50c
-- 
2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
