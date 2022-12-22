Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD22EC4332F
	for <virtualization@archiver.kernel.org>; Thu, 22 Dec 2022 06:04:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4CF2140272;
	Thu, 22 Dec 2022 06:04:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4CF2140272
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DNJijC/k
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QXEiigheoglE; Thu, 22 Dec 2022 06:04:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D0A2C40153;
	Thu, 22 Dec 2022 06:04:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D0A2C40153
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90699C0071;
	Thu, 22 Dec 2022 06:04:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6919CC0070
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 06:04:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 47034402EF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 06:04:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 47034402EF
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DNJijC/k
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TYEyY3f_7koj
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 06:04:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CB4CE40245
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CB4CE40245
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 06:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671689078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xrsqGz7chPZ2KmKpMG8QR1W3lTlHGgi0D+G+V4JZPLQ=;
 b=DNJijC/ks8icTCxEuSG9ttuvXqWCLY2Vx7tEMd86R7qNIxLNjdUjw5LF3HXtR+NZnngkrN
 Rx/7qTdijLvINoAGFaQUlIdbXpLsdht3aRV71o6RlSe8Oyk760Se0JH/Zi9H57IsUiPYqB
 e668BGN1ixI1vH8+gKDdseB1eY/hDzA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-WY9h8Mx9PDWA6rvdtnC63g-1; Thu, 22 Dec 2022 01:04:37 -0500
X-MC-Unique: WY9h8Mx9PDWA6rvdtnC63g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F8C91C0514F;
 Thu, 22 Dec 2022 06:04:36 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-179.pek2.redhat.com
 [10.72.13.179])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 89948112132C;
 Thu, 22 Dec 2022 06:04:29 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [RFC PATCH 0/4] virtio-net: don't busy poll for cvq command
Date: Thu, 22 Dec 2022 14:04:23 +0800
Message-Id: <20221222060427.21626-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

Jason Wang (4):
  virtio-net: convert rx mode setting to use workqueue
  virtio_ring: switch to use BAD_RING()
  virtio_ring: introduce a per virtqueue waitqueue
  virtio-net: sleep instead of busy waiting for cvq command

 drivers/net/virtio_net.c     | 79 +++++++++++++++++++++++++++++++-----
 drivers/virtio/virtio_ring.c | 33 ++++++++++++++-
 include/linux/virtio.h       |  4 ++
 3 files changed, 105 insertions(+), 11 deletions(-)

-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
