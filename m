Return-Path: <SRS0=+sHN=K4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC85DC47092
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 18:57:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63492613E6
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 18:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63492613E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 24DE24044E;
	Wed,  2 Jun 2021 18:57:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oRymZQboxa6p; Wed,  2 Jun 2021 18:57:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 578CB401EC;
	Wed,  2 Jun 2021 18:57:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31CD1C000E;
	Wed,  2 Jun 2021 18:57:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 528D2C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 18:57:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4EA756074C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 18:57:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 45H4cp5ylQxx
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 18:57:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F418760701
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 18:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622660257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=y6MOJkXDqthwxgoOtIfGa8m4Pzox6wAw262/GSt7ITY=;
 b=I1iONsuRz5ZEt9rKNhCk91i7EDWGwiiILlCm2oyj/4MeJkz5MTVCoLKIsKHTtj7RDahfA/
 QYrJ0edm+wM/sILNxEs1hsA+b+s/4QztoUsdUoEz9S4BIsKTuufJuR3LnKi+D8CJaP0g+S
 Wed3bzc3jzHrFUkiXRStmnnjNLkZi34=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-anCrELXmM4icLUzhQDGNjg-1; Wed, 02 Jun 2021 14:57:33 -0400
X-MC-Unique: anCrELXmM4icLUzhQDGNjg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A579107ACC7;
 Wed,  2 Jun 2021 18:57:32 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-159.ams2.redhat.com [10.36.114.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A7BC0100238C;
 Wed,  2 Jun 2021 18:57:21 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/7] virtio-mem: prioritize unplug from ZONE_MOVABLE
Date: Wed,  2 Jun 2021 20:57:13 +0200
Message-Id: <20210602185720.31821-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Wei Yang <richard.weiyang@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michal Hocko <mhocko@kernel.org>,
 linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
 Marek Kedzierski <mkedzier@redhat.com>, Hui Zhu <teawater@gmail.com>,
 Oscar Salvador <osalvador@suse.de>
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

Until now, memory provided by a single virtio-mem device was usually
either onlined completely to ZONE_MOVABLE (online_movable) or to
ZONE_NORMAL (online_kernel), so we didn't actually care about "what"
we are unplugging; however, that will change in the future when we will
have memory blocks in different zones within a single virtio-mem device.

There are two reasons why we want to track to which zone a memory block
belongs to and prioritize ZONE_MOVABLE blocks:

1) Memory managed by ZONE_MOVABLE can more likely get unplugged, therefore,
   resulting in a faster memory hotunplug process. Further, we can more
   reliably unplug and remove complete memory blocks, removing metadata
   allocated for the whole memory block.

2) We want to avoid corner cases where unplugging with the current scheme
   (highest to lowest address) could result in accidential zone imbalances,
   whereby we remove too much ZONE_NORMAL memory for ZONE_MOVABLE memory
   of the same device.

This series unplugs ZONE_MOVABLE memory blocks first, before falling back
to ZONE_NORMAL ones.

Patch #1 is an unrelated fix, previously sent in other context that didn't
get picked up yet. Patch #2-#4 and #6 are cleanups. Patch #5 and #7
implement ZONE_MOVABLE aware handling in Sub Block Mode and Big Block Mode
respectively.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Marek Kedzierski <mkedzier@redhat.com>
Cc: Hui Zhu <teawater@gmail.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: virtualization@lists.linux-foundation.org
Cc: linux-mm@kvack.org

David Hildenbrand (7):
  virtio-mem: don't read big block size in Sub Block Mode
  virtio-mem: use page_zonenum() in virtio_mem_fake_offline()
  virtio-mem: simplify high-level plug handling in Sub Block Mode
  virtio-mem: simplify high-level unplug handling in Sub Block Mode
  virtio-mem: prioritize unplug from ZONE_MOVABLE in Sub Block Mode
  virtio-mem: simplify high-level unplug handling in Big Block Mode
  virtio-mem: prioritize unplug from ZONE_MOVABLE in Big Block Mode

 drivers/virtio/virtio_mem.c | 338 +++++++++++++++++++-----------------
 1 file changed, 174 insertions(+), 164 deletions(-)


base-commit: 8124c8a6b35386f73523d27eacb71b5364a68c4c
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
