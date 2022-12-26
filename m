Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A041FC4332F
	for <virtualization@archiver.kernel.org>; Mon, 26 Dec 2022 07:49:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 14653403C8;
	Mon, 26 Dec 2022 07:49:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 14653403C8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NV7897wT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dgJihr-hD-5T; Mon, 26 Dec 2022 07:49:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 67CA64035C;
	Mon, 26 Dec 2022 07:49:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 67CA64035C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39B69C0035;
	Mon, 26 Dec 2022 07:49:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B08EC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 07:49:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E2534607C0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 07:49:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E2534607C0
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NV7897wT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pzU0vVW8Azfu
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 07:49:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 09BAD6059D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 09BAD6059D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 07:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672040957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=r0SQFSZXD8Vb1EKKItz+UfkpNXT80NYrf2iD+mDfQXM=;
 b=NV7897wTh371jK9lmdZWa6FZTnOomZkGpzSenaLf38tna2k4AP+rOKtiyaFCwlD2/yqenD
 2W3Xgz7L/Lf2CVuCu8aLj4CNXc1JEIGIOwtmccimAvydpI67/oHWEkUd+N3O241G6UbCqZ
 8rDBkuA9H7Q1vn/IIK6mXlTbul5nFbI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-349-Bwd-GaOKMOud6zZNOUbn6Q-1; Mon, 26 Dec 2022 02:49:15 -0500
X-MC-Unique: Bwd-GaOKMOud6zZNOUbn6Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20A448533DF;
 Mon, 26 Dec 2022 07:49:15 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-100.pek2.redhat.com
 [10.72.13.100])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 83DFB492B00;
 Mon, 26 Dec 2022 07:49:10 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 0/4] virtio-net: don't busy poll for cvq command
Date: Mon, 26 Dec 2022 15:49:04 +0800
Message-Id: <20221226074908.8154-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 edumazet@google.com, maxime.coquelin@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
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

So this series tries to use sleep + timeout instead of busy polling.

Please review.

Thanks

Changes since RFC:

- switch to use BAD_RING in virtio_break_device()
- check virtqueue_is_broken() after being woken up
- use more_used() instead of virtqueue_get_buf() to allow caller to
  get buffers afterwards
- break the virtio-net device when timeout
- get buffer manually since the virtio core check more_used() instead

Jason Wang (4):
  virtio-net: convert rx mode setting to use workqueue
  virtio_ring: switch to use BAD_RING()
  virtio_ring: introduce a per virtqueue waitqueue
  virtio-net: sleep instead of busy waiting for cvq command

 drivers/net/virtio_net.c     | 90 +++++++++++++++++++++++++++++++-----
 drivers/virtio/virtio_ring.c | 37 +++++++++++++--
 include/linux/virtio.h       |  3 ++
 3 files changed, 115 insertions(+), 15 deletions(-)

-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
