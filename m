Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BE3C433F5
	for <virtualization@archiver.kernel.org>; Fri, 26 Nov 2021 13:42:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 84F9B405DD;
	Fri, 26 Nov 2021 13:42:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZhGLoeSijbes; Fri, 26 Nov 2021 13:42:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2609540408;
	Fri, 26 Nov 2021 13:42:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC4E6C001C;
	Fri, 26 Nov 2021 13:42:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D813FC000A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 13:42:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BFF246078C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 13:42:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D8DgpIX4Mclp
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 13:42:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7A20F6078B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 13:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637934158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qv4Kw9RIW39ZiswcLW6UjMfgb9X0DOPxTe7NmLh2c2M=;
 b=UW/OdTRjdn+hLeLUlpzrs6O4eBHOOkBx/85dHea3aPKRwG7kIxJN4J2crtR+1TNzRixnGM
 EKOXiwqMIWbRRAJpEohN9LIh29CKTrfUHdlL1ginuwSrgd9wgZW5uXw1b9tLpFsqDsyfCM
 lxcwrx9Nl1gh71thP9NUtTR9o6P9++c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-E_29GzgtP2-OYAERnJ26nA-1; Fri, 26 Nov 2021 08:42:37 -0500
X-MC-Unique: E_29GzgtP2-OYAERnJ26nA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 898228015BA;
 Fri, 26 Nov 2021 13:42:35 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A0C8D72FA6;
 Fri, 26 Nov 2021 13:42:10 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] virtio-mem: prepare for granularity smaller than
 MAX_ORDER - 1
Date: Fri, 26 Nov 2021 14:42:07 +0100
Message-Id: <20211126134209.17332-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Gavin Shan <gshan@redhat.com>,
 Eric Ren <renzhengeek@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Sebastien Boeuf <sebastien.boeuf@intel.com>, Zi Yan <ziy@nvidia.com>,
 Hui Zhu <teawater@gmail.com>, Wei Yang <richard.weiyang@linux.alibaba.com>
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

The virtio-mem driver currently supports logical hot(un)plug in
MAX_ORDER - 1 granularity (4MiB on x86-64) or bigger. We want to support
pageblock granularity (2MiB on x86-64), to make hot(un)plug even more
flexible, and to improve hotunplug when using ZONE_NORMAL.

With pageblock granularity, we then have a granularity comparable to
hugepage ballooning. Further, there are ideas to increase MAX_ORDER, so
we really want to decouple it from MAX_ORDER.

While ZONE_MOVABLE should mostly work already, alloc_contig_range() still
needs work to be able to properly handle pageblock granularity on
ZONE_NORMAL. This support is in the works [1], so let's prepare
virtio-mem for supporting smaller granularity than MAX_ORDER - 1.

Tested with ZONE_MOVABLE after removing the MAX_ORDER - 1 granularity
limitation in virtio-mem, and using different device block sizes (2MiB,
4MiB, 8MiB).

[1] https://lkml.kernel.org/r/20211115193725.737539-1-zi.yan@sent.com

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Gavin Shan <gshan@redhat.com>
Cc: Hui Zhu <teawater@gmail.com>
Cc: Eric Ren <renzhengeek@gmail.com>
Cc: Sebastien Boeuf <sebastien.boeuf@intel.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org
Cc: linux-mm@kvack.org

David Hildenbrand (2):
  virtio-mem: prepare page onlining code for granularity smaller than
    MAX_ORDER - 1
  virtio-mem: prepare fake page onlining code for granularity smaller
    than MAX_ORDER - 1

 drivers/virtio/virtio_mem.c | 110 ++++++++++++++++++++++++------------
 1 file changed, 74 insertions(+), 36 deletions(-)

-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
