Return-Path: <SRS0=qgkY=OM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5469FC433FE
	for <virtualization@archiver.kernel.org>; Wed, 22 Sep 2021 17:09:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F061460F23
	for <virtualization@archiver.kernel.org>; Wed, 22 Sep 2021 17:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F061460F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B1AE44059C;
	Wed, 22 Sep 2021 17:09:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KSjEr_5fkN7j; Wed, 22 Sep 2021 17:09:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1AAEE400CE;
	Wed, 22 Sep 2021 17:09:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5EB3C0011;
	Wed, 22 Sep 2021 17:09:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED419C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 17:09:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CF84B80EF9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 17:09:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZRYg7Z_-Gi8Z
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 17:09:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 953AF80B8E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 17:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632330552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SHrxHOUJFC7SXjO6oPt56HM9d80tm/abAg5EY0FI59M=;
 b=KyYpcJPPp1JKHv2c2zILDB0+njD/pCkOd5kFSgtfIG8Y1H1yGuEWTiElyaxqvWiwbw7oAi
 1AIjAzao7QWJkD0ew1/Nhb9/XgY+fMsx7yFuVvhGrlFI/rG4zeBsAH3NjwxAiQLzICfUAg
 tFRrHA2p5NJ46XPcrf3PvzDpnS/dw7M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-bqVte1b5PcW-zOzon214Pw-1; Wed, 22 Sep 2021 13:09:11 -0400
X-MC-Unique: bqVte1b5PcW-zOzon214Pw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93E261023F4D;
 Wed, 22 Sep 2021 17:09:08 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.39.192.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F001E970E0;
 Wed, 22 Sep 2021 17:09:04 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] hwrng: virtio - add an internal buffer
Date: Wed, 22 Sep 2021 19:08:59 +0200
Message-Id: <20210922170903.577801-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Laurent Vivier <lvivier@redhat.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, amit@kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, rusty@rustcorp.com.au,
 virtualization@lists.linux-foundation.org,
 Alexander Potapenko <glider@google.com>, linux-crypto@vger.kernel.org,
 Matt Mackall <mpm@selenic.com>, akong@redhat.com,
 Dmitriy Vyukov <dvyukov@google.com>
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

hwrng core uses two buffers that can be mixed in the virtio-rng queue.

This series fixes the problem by adding an internal buffer in virtio-rng.

Once the internal buffer is added, we can fix two other problems:

- to be able to release the driver without waiting the device releases the
  buffer

- actually returns some data when wait=0 as we can have some already
  available data

It also tries to improve the performance by always having a buffer in
the queue of the device.

Laurent Vivier (4):
  hwrng: virtio - add an internal buffer
  hwrng: virtio - don't wait on cleanup
  hwrng: virtio - don't waste entropy
  hwrng: virtio - always add a pending request

 drivers/char/hw_random/virtio-rng.c | 84 +++++++++++++++++++++--------
 1 file changed, 63 insertions(+), 21 deletions(-)

-- 
2.31.1


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
