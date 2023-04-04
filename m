Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B322C6FD1D
	for <virtualization@archiver.kernel.org>; Tue,  4 Apr 2023 13:13:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C36EC404E9;
	Tue,  4 Apr 2023 13:13:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C36EC404E9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iWZc8ME4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WZDYYGu9XVO5; Tue,  4 Apr 2023 13:13:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F0F91404E1;
	Tue,  4 Apr 2023 13:13:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F0F91404E1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4273C0036;
	Tue,  4 Apr 2023 13:13:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B977C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 13:13:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 138B760ADE
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 13:13:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 138B760ADE
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iWZc8ME4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zQR8xTL13pOj
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 13:13:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 00DA760AA7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 00DA760AA7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 13:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680614013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=30ZisPh4IfYxBa26xRUyTniBO/vlBTDmjsdwsbCPJho=;
 b=iWZc8ME4xzjGEup1SgpBOTWQB+tVtTiwqVoq1qtZ6ie6Y4x/3cupBbZGXkgAoNzDY1TrX1
 80NYbjMqVJ8RenmbseYQ61rSFffGhSHP3PdgxmAlkzgXV+ibGW6qdz95odyjiBT/hZd6ro
 GZWYj18oYe6Z9HFhZkIi4mYctUoiGvA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-cC6XIszSNni8b_jOYc5Fag-1; Tue, 04 Apr 2023 09:13:32 -0400
X-MC-Unique: cC6XIszSNni8b_jOYc5Fag-1
Received: by mail-qv1-f72.google.com with SMTP id
 g6-20020ad45426000000b005a33510e95aso14629531qvt.16
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Apr 2023 06:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680614011;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=30ZisPh4IfYxBa26xRUyTniBO/vlBTDmjsdwsbCPJho=;
 b=x8clUlQhpLMU+RXFDs0e8Fdaj1xfx3lYA2r9o54z2HTrIiaqNkmLNdsEuQ4A/IMGhk
 APr+9KL+0nzM1883ZLmfys3TwvOkm88oHuDDgF7jxuFwHAQbRtQUGhcvH07YA6j/qoay
 NkZ/J4NmWF3pEA8IguxGXflB7W3kXpkRz/oZpK6GtvsTy/ARdI6hu5uxCjMY6NvJ9NmH
 aYdHv7JPpTbJJC5DTceQfqu4u8t3QyduV4MLbhZEgCVEgmLnoQqLLWKjGOyd0PyMbkAk
 g6+PzmmEFEmpewhON/PgWOBot34PzxRSyrxR42atVuTMGn1YzQ7+4R3n/Zo57awaXrFV
 zCFQ==
X-Gm-Message-State: AAQBX9fRos6SNsvfiMlwN69PrJK6kQODeiyQJs6gSgI61WrFbn9CfJ7f
 KjrjCJXa7CPZHGBQwrne1TZvaS5EDtnJMAYmVgCmn0G4Xz29nfsxVJb85U+ju8JeqbdGvrNIh6p
 avQwsjE8vsSU0dhKu3/8ppCqgMQMmXJoU99uQ+XGKb/akVFd7rGy3LMK1k00thmrpRl7ljZXr0I
 kmobmPnKUpQp/QPSBU+nSIjGxHCw==
X-Received: by 2002:a05:6214:761:b0:5b7:f1cb:74b6 with SMTP id
 f1-20020a056214076100b005b7f1cb74b6mr2937074qvz.39.1680614011004; 
 Tue, 04 Apr 2023 06:13:31 -0700 (PDT)
X-Google-Smtp-Source: AKy350YZ2zTnbb4FJI/gZ6P1fNW7ktKk0SsSIVk8yGebzeOt4qcSLlZcWaLED4QcoPTHMx/dn8nf2g==
X-Received: by 2002:a05:6214:761:b0:5b7:f1cb:74b6 with SMTP id
 f1-20020a056214076100b005b7f1cb74b6mr2937024qvz.39.1680614010596; 
 Tue, 04 Apr 2023 06:13:30 -0700 (PDT)
Received: from step1.redhat.com (host-82-53-134-157.retail.telecomitalia.it.
 [82.53.134.157]) by smtp.gmail.com with ESMTPSA id
 mk14-20020a056214580e00b005dd8b9345e8sm3367788qvb.128.2023.04.04.06.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Apr 2023 06:13:29 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v5 0/9] vdpa_sim: add support for user VA
Date: Tue,  4 Apr 2023 15:13:17 +0200
Message-Id: <20230404131326.44403-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, eperezma@redhat.com, stefanha@redhat.com
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

This series adds support for the use of user virtual addresses in the
vDPA simulator devices.

The main reason for this change is to lift the pinning of all guest memory.
Especially with virtio devices implemented in software.

The next step would be to generalize the code in vdpa-sim to allow the
implementation of in-kernel software devices. Similar to vhost, but using vDPA
so we can reuse the same software stack (e.g. in QEMU) for both HW and SW
devices.

For example, we have never merged vhost-blk, and lately there has been interest.
So it would be nice to do it directly with vDPA to reuse the same code in the
VMM for both HW and SW vDPA block devices.

The main problem (addressed by this series) was due to the pinning of all
guest memory, which thus prevented the overcommit of guest memory.

Thanks,
Stefano

Changelog listed in each patch.
v4: https://lore.kernel.org/lkml/20230324153607.46836-1-sgarzare@redhat.com/
v3: https://lore.kernel.org/lkml/20230321154228.182769-1-sgarzare@redhat.com/
v2: https://lore.kernel.org/lkml/20230302113421.174582-1-sgarzare@redhat.com/
RFC v1: https://lore.kernel.org/lkml/20221214163025.103075-1-sgarzare@redhat.com/

Stefano Garzarella (9):
  vdpa: add bind_mm/unbind_mm callbacks
  vhost-vdpa: use bind_mm/unbind_mm device callbacks
  vringh: replace kmap_atomic() with kmap_local_page()
  vringh: define the stride used for translation
  vringh: support VA with iotlb
  vdpa_sim: make devices agnostic for work management
  vdpa_sim: use kthread worker
  vdpa_sim: replace the spinlock with a mutex to protect the state
  vdpa_sim: add support for user VA

 drivers/vdpa/vdpa_sim/vdpa_sim.h     |  11 +-
 include/linux/vdpa.h                 |  10 ++
 include/linux/vringh.h               |   9 ++
 drivers/vdpa/vdpa_sim/vdpa_sim.c     | 161 ++++++++++++++++++++-----
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  10 +-
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  10 +-
 drivers/vhost/vdpa.c                 |  34 ++++++
 drivers/vhost/vringh.c               | 173 ++++++++++++++++++++++-----
 8 files changed, 340 insertions(+), 78 deletions(-)

-- 
2.39.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
