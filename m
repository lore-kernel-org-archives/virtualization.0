Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A99CC6FD20
	for <virtualization@archiver.kernel.org>; Fri, 24 Mar 2023 15:36:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9614C41E01;
	Fri, 24 Mar 2023 15:36:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9614C41E01
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eW4Ah/mr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eO8QMrviscEp; Fri, 24 Mar 2023 15:36:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1AACB400B8;
	Fri, 24 Mar 2023 15:36:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1AACB400B8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE949C0035;
	Fri, 24 Mar 2023 15:36:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A36F0C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 15:36:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8C14C8422D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 15:36:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8C14C8422D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=eW4Ah/mr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sYzUDQ-sYWUa
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 15:36:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9C5198420B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9C5198420B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 15:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679672180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Z/Kz7kV+UiInmN3q36fZWIJQ0sjJV/FHyS/DppuKTvQ=;
 b=eW4Ah/mrfC7pv7ma80zN3R370PX2euPb2qm2LBIa7wvv6x5uO3pmBg3NkMxdDTKGZE3Nnp
 JvDzCj8v452/k3jZBECeQ9pEXoDMUW3zE4VfnjASEakS83drUi1oVvldt5xr1K4MbsVRVC
 xlyuTkZeGLqAEDVQAL9Cr0f+GGsFsBA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-cdt_iLUMM5m9ppBu7BtE7Q-1; Fri, 24 Mar 2023 11:36:19 -0400
X-MC-Unique: cdt_iLUMM5m9ppBu7BtE7Q-1
Received: by mail-ed1-f70.google.com with SMTP id
 es16-20020a056402381000b004fa3e04c882so3734884edb.10
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 08:36:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679672178;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z/Kz7kV+UiInmN3q36fZWIJQ0sjJV/FHyS/DppuKTvQ=;
 b=41A2JgXMAOzqEuerZV2t0BbgOIDW4QYL9yJS2CruPMoRQnaQB1IOBg8A0zLykKXi0R
 fTxym1N/7sq3gdI/z46kVZ8XX+EQt693qadavYpgU+1Xnktz0xD0LN1+v/6nCb5dwoI5
 XlK1ahLScuXp4Ij7bU3bIhxyibEt4mohUs7379Bd/YlzLs2+Z1/hyFKo4FIpdprjbVv5
 3MUV7s83lJPf6NMxihgJ3YplWY4UEOU/S1V9Jhu1Qv+yy0F3zwrGc+3qfFaz5FK2lOUH
 qHkEM+6uZTga6Hssy9JySNVLpHve7ocYsSrCrS8BHwqL5QQ0d11oz9EIwJ+dv2E/6hO9
 RO4Q==
X-Gm-Message-State: AAQBX9e5VbynKyM4395i2Zsn01ssLrxBrAM/BFNpMbLonBR+v3CvAtxw
 A3WyGLkFDRw0Qjq3S3Zi1nBcyuskDrYM+xpMhZoPkhtIBkddobs3SqkJguK6RJH53fDz1Btx2cI
 WHzxSoqGUzbsZ/XBfmV7j6f+j1Fkro+ND+KZooyfZPJoO9HubLWheiP3YMTjOT6JLrKsc0iroWK
 XpZLnrFa48zDcM0qARvT3+uhoxvQ==
X-Received: by 2002:aa7:c6c8:0:b0:4f9:deb4:b986 with SMTP id
 b8-20020aa7c6c8000000b004f9deb4b986mr2885743eds.7.1679672177861; 
 Fri, 24 Mar 2023 08:36:17 -0700 (PDT)
X-Google-Smtp-Source: AKy350ay1iv3SvkhVkCpZgFjlrGDYTHaf4l+WBI3Lkacaxfq08vNdhGScQ/rdLUDCOdmvue3dyREYA==
X-Received: by 2002:aa7:c6c8:0:b0:4f9:deb4:b986 with SMTP id
 b8-20020aa7c6c8000000b004f9deb4b986mr2885714eds.7.1679672177492; 
 Fri, 24 Mar 2023 08:36:17 -0700 (PDT)
Received: from localhost.localdomain
 (host-82-53-134-98.retail.telecomitalia.it. [82.53.134.98])
 by smtp.gmail.com with ESMTPSA id
 a27-20020a509b5b000000b00501dd53dbfbsm5468613edj.75.2023.03.24.08.36.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Mar 2023 08:36:16 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v4 0/9] vdpa_sim: add support for user VA
Date: Fri, 24 Mar 2023 16:35:58 +0100
Message-Id: <20230324153607.46836-1-sgarzare@redhat.com>
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
