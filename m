Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3222C77B73
	for <virtualization@archiver.kernel.org>; Wed, 24 May 2023 08:19:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2945F81758;
	Wed, 24 May 2023 08:19:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2945F81758
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IDz0qYI3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mw_DROy-uUSj; Wed, 24 May 2023 08:18:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7B3A283C55;
	Wed, 24 May 2023 08:18:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7B3A283C55
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F875C0037;
	Wed, 24 May 2023 08:18:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4673DC0036
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 May 2023 08:18:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1D48C42052
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 May 2023 08:18:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1D48C42052
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IDz0qYI3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ej2yz8DUCYGs
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 May 2023 08:18:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1F73342051
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1F73342051
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 May 2023 08:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684916334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tr17fslrkCiphsGkEGKeZVhavScCHFO7w1RXhH4sGc0=;
 b=IDz0qYI3pXYG8hWurv0HgyC82O+uwDdvEUXIV1++Dkry7eNXVIvqy9sWqErhYL7bmPQwgo
 RMJrbu5hCBCKCP7P7wD52kMwoQViRs5fsRGk7iXcfQfG0o42Gfm27nuE7Gs+AeF16VpLjs
 7h0F2QbAUnKZ2nrZ0S1KbaGM0ztkz4w=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-193-2JRr0exkNyGTgTbJbqvnjw-1; Wed, 24 May 2023 04:18:50 -0400
X-MC-Unique: 2JRr0exkNyGTgTbJbqvnjw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD9EC3C02B62;
 Wed, 24 May 2023 08:18:49 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-76.pek2.redhat.com [10.72.13.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 356C6140EBD7;
 Wed, 24 May 2023 08:18:44 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Subject: [PATCH V3 net-next 0/2] virtio-net: don't busy poll for cvq command
Date: Wed, 24 May 2023 16:18:40 +0800
Message-Id: <20230524081842.3060-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

Hi all:

The code used to busy poll for cvq command which turns out to have
several side effects:

1) infinite poll for buggy devices
2) bad interaction with scheduler

So this series tries to use cond_resched() in the waiting loop. Before
doing this we need first make sure the cvq command is not executed in
atomic environment, so we need first convert rx mode handling to a
workqueue.

Please review.

Thanks

Changes since V2:

- Don't use interrupt but cond_resched()

Changes since V1:

- use RTNL to synchronize rx mode worker
- use completion for simplicity
- don't try to harden CVQ command

Changes since RFC:

- switch to use BAD_RING in virtio_break_device()
- check virtqueue_is_broken() after being woken up
- use more_used() instead of virtqueue_get_buf() to allow caller to
  get buffers afterwards
  - break the virtio-net device when timeout
  - get buffer manually since the virtio core check more_used() instead

Jason Wang (2):
  virtio-net: convert rx mode setting to use workqueue
  virtio-net: add cond_resched() to the command waiting loop

 drivers/net/virtio_net.c | 59 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 4 deletions(-)

-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
