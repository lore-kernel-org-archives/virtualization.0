Return-Path: <SRS0=RKVt=P5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3732C433FE
	for <virtualization@archiver.kernel.org>; Wed, 10 Nov 2021 16:38:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7590761058
	for <virtualization@archiver.kernel.org>; Wed, 10 Nov 2021 16:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7590761058
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 47A48400E9;
	Wed, 10 Nov 2021 16:38:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lj72dX_KwMEY; Wed, 10 Nov 2021 16:38:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E0316400F0;
	Wed, 10 Nov 2021 16:38:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6279C0019;
	Wed, 10 Nov 2021 16:38:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2BFE1C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 16:38:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1B914400EC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 16:38:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6Hj3bjpZKTJu
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 16:38:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 41290400E9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 16:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636562281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=sB6q49chsG0NMnxu3Y8HrrLYL021I88C8UmRV20N4pE=;
 b=bFa6UuSh5WU0E0MKqLop+IHsRVCLKVtTr2eT09tOvN4UKxRl4F+F3nOKICH/yVPYCtg+iZ
 UiIECZakUDghJv6DXIPnElopA05au1f2XzFe4mWCOHgbVZJNuxLVeMi1KloSHQ6iVvAhpT
 2ObEjkdkuxgHKdrDnMlD+OsmS/BUaxg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-mHE8pSQ6OBefUI5Jeseveg-1; Wed, 10 Nov 2021 11:37:57 -0500
X-MC-Unique: mHE8pSQ6OBefUI5Jeseveg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8BC61006AAA;
 Wed, 10 Nov 2021 16:37:56 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D1A367840;
 Wed, 10 Nov 2021 16:37:55 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [GIT PULL] virtio-mem changes for v5.16
Date: Wed, 10 Nov 2021 17:37:54 +0100
Message-Id: <20211110163754.27528-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
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

Hi Linus,

usually this would have went via the vhost tree, but as this patch depends
on some patches that just went in via Andrews tree and MST doesn't have
any other patches for this merge window, I'm sending it myself
and base it on current mainline that contains the relevant commits
already. Thanks!

The following changes since commit cb690f5238d71f543f4ce874aa59237cf53a877c:

  Merge tag 'for-5.16/drivers-2021-11-09' of git://git.kernel.dk/linux-block (2021-11-09 11:24:08 -0800)

are available in the Git repository at:

  https://github.com/davidhildenbrand/linux.git tags/virtio-mem-for-5.16

for you to fetch changes up to 61082ad6a6e1f999eef7e7e90046486c87933b1e:

  virtio-mem: support VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE (2021-11-10 15:32:38 +0100)

----------------------------------------------------------------
virtio-mem: support VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE

Support the VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE feature in virtio-mem, now
that "accidential" access to logically unplugged memory inside added
Linux memory blocks is no longer possible, because we:

1. Removed /dev/kmem in commit bbcd53c96071 ("drivers/char: remove
   /dev/kmem for good")
2. Disallowed access to virtio-mem device memory via /dev/mem in commit
   2128f4e21aa ("virtio-mem: disallow mapping virtio-mem memory via
   /dev/mem")
3. Sanitized access to virtio-mem device memory via /proc/kcore in
   commit 0daa322b8ff9 ("fs/proc/kcore: don't read offline sections,
   logically offline pages and hwpoisoned pages")
4. Sanitized access to virtio-mem device memory via /proc/vmcore in
   commit ce2814622e84 ("virtio-mem: kdump mode to sanitize /proc/vmcore
   access")

The new VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE feature that will be required
by some hypervisors implementing virtio-mem in the near future, so let's
support it now that we safely can.

Signed-off-by: David Hildenbrand <david@redhat.com>

----------------------------------------------------------------
David Hildenbrand (1):
      virtio-mem: support VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE

 drivers/virtio/virtio_mem.c     | 1 +
 include/uapi/linux/virtio_mem.h | 9 ++++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
