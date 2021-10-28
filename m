Return-Path: <SRS0=hVMj=PQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8307CC433FE
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 10:11:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25EE1610CA
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 10:11:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 25EE1610CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D3F1540337;
	Thu, 28 Oct 2021 10:11:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eIsiPLn7jNlh; Thu, 28 Oct 2021 10:11:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 20B6D40233;
	Thu, 28 Oct 2021 10:11:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA0DCC0012;
	Thu, 28 Oct 2021 10:11:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 298A3C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 10:11:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0974181B8A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 10:11:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KMcep19QJ89h
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 10:11:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4907F81AD1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 10:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635415895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Lf5038czWxD5TVdb3xzJS31yq5LDU7rgKUOZR2ujX9Y=;
 b=TIrvUCc+39UjiMfzxmDEObkDplGONTWu9Mm7HR87hj2un1a3PlmErz1aZDzbbaRFf+x31a
 L1xY1X+c/c7lvhRlhJVyS+ShowcujuH7xMlrobSgYy6WpztJ57CazmnHF+j+P1QkQ38gvK
 WHqS04Hi86L4NVc9nklO/XuwjcPnqc8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-CeVCjHmJNmOCLy6xJIUSjw-1; Thu, 28 Oct 2021 06:11:33 -0400
X-MC-Unique: CeVCjHmJNmOCLy6xJIUSjw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67BAD10A8E02;
 Thu, 28 Oct 2021 10:11:31 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.39.194.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E635D60C04;
 Thu, 28 Oct 2021 10:11:12 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] hwrng: virtio - add an internal buffer
Date: Thu, 28 Oct 2021 12:11:07 +0200
Message-Id: <20211028101111.128049-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

v2:
fixes issue reported by syzbot+b86736b5935e0d25b446@syzkaller.appspotmail.com
by reseting data_idx to 0 when the buffer is submitted not when it is
received as the consumer checks for data_avail, not only for the completion.

Laurent Vivier (4):
  hwrng: virtio - add an internal buffer
  hwrng: virtio - don't wait on cleanup
  hwrng: virtio - don't waste entropy
  hwrng: virtio - always add a pending request

 drivers/char/hw_random/virtio-rng.c | 86 ++++++++++++++++++++++-------
 1 file changed, 65 insertions(+), 21 deletions(-)

-- 
2.31.1


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
