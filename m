Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C98E3C6FD1D
	for <virtualization@archiver.kernel.org>; Tue, 21 Mar 2023 15:42:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5200540140;
	Tue, 21 Mar 2023 15:42:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5200540140
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bXiGjYLb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z8olJje7ZnWT; Tue, 21 Mar 2023 15:42:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CBDBF40BE3;
	Tue, 21 Mar 2023 15:42:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CBDBF40BE3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E402C0071;
	Tue, 21 Mar 2023 15:42:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E69BEC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 15:42:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BFB4081FF0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 15:42:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BFB4081FF0
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bXiGjYLb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3J15suiANAsl
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 15:42:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A24A781FE9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A24A781FE9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 15:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679413354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+21M6FOpDI3Nr+X7KYn7VxKMZfev1okJOfwsG6shoDo=;
 b=bXiGjYLbBMmOgGoop59Hjhq5ZTb20jPicq34b551UCSodinuWMyxaEDAWd5q3os6QB5phW
 9cEBdBINNxD+74SxzihlpsORUOrGnrRinJsJCdHJCpW0hFAhr67o9pjWQ1jjuTPY9J4dG/
 sdo2ZJw7aQNXWG7MBQ7lXmHbkrMRvkA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-zRUV0gHkN2eMEYMXMTtB2g-1; Tue, 21 Mar 2023 11:42:33 -0400
X-MC-Unique: zRUV0gHkN2eMEYMXMTtB2g-1
Received: by mail-wm1-f72.google.com with SMTP id
 ay12-20020a05600c1e0c00b003ed201dcf71so7282630wmb.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 08:42:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679413351;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+21M6FOpDI3Nr+X7KYn7VxKMZfev1okJOfwsG6shoDo=;
 b=TOKgsugtv+i9suLWLr+evVsEnPaFoc4LH0ZlDYofU5h9UqPuiLB26pGrvPHiF8DJm3
 5CN6q3RUoAOpwIxd4rdp6WhqW6Sj7WqxT0HVUyCJvM4X8eNrpyblNUkd5TkU04BKWT4A
 baaVxOHa12ZavvgLUemRsjMTb4R4Vio8Ng0zG/x8/6msFqP5SyQSHSsE8zfklnce/z9Q
 BcEr9DypMWGnbcb89fTrvtmUlUCbD8C4ZxnxLqk0NOBgVWUIjTZbtCQCZRNQdTU/8Olu
 XUQ85q/x4hmEzRxqKDf12XXNDnmHXQnK920SFGWo+0YUz9evwTWyUNIbUVQmFa6wnKW8
 PjuA==
X-Gm-Message-State: AO0yUKWUgaV8cqkCgdVtoKxZQNJpJKdYMB4WN7mi1Lm1oOYQigHJrt4J
 vhppT/5zjN4eXq8lKQOt5nx0DfxCUjJInuURHQaY9GKePJaapGNs5LVsbf9yZpV+M2xYX5w4vya
 pb63Yds768Ak0c3RiNvVRUlY+IWlM+GNp+MlyWoFMlEMM151Obcsu/u/oJjajOd07u18xClYEFC
 sbJ8xJJ3Ql5N/kxeFCK43g95+BGQ==
X-Received: by 2002:a5d:6b50:0:b0:2cf:ee6b:36aa with SMTP id
 x16-20020a5d6b50000000b002cfee6b36aamr2562232wrw.64.1679413351428; 
 Tue, 21 Mar 2023 08:42:31 -0700 (PDT)
X-Google-Smtp-Source: AK7set+jl15tAxH9/4PthYuff9mKcJ9PlapXD8hbv/rRlufjrczN3T38t3QWIyMzX15FRRs1sZibOQ==
X-Received: by 2002:a5d:6b50:0:b0:2cf:ee6b:36aa with SMTP id
 x16-20020a5d6b50000000b002cfee6b36aamr2562203wrw.64.1679413351047; 
 Tue, 21 Mar 2023 08:42:31 -0700 (PDT)
Received: from step1.redhat.com (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 n2-20020adffe02000000b002cfeffb442bsm11582490wrr.57.2023.03.21.08.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Mar 2023 08:42:30 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v3 0/8] vdpa_sim: add support for user VA
Date: Tue, 21 Mar 2023 16:42:20 +0100
Message-Id: <20230321154228.182769-1-sgarzare@redhat.com>
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
v2: https://lore.kernel.org/lkml/20230302113421.174582-1-sgarzare@redhat.com/
RFC v1: https://lore.kernel.org/lkml/20221214163025.103075-1-sgarzare@redhat.com/

Stefano Garzarella (8):
  vdpa: add bind_mm/unbind_mm callbacks
  vhost-vdpa: use bind_mm/unbind_mm device callbacks
  vringh: replace kmap_atomic() with kmap_local_page()
  vringh: support VA with iotlb
  vdpa_sim: make devices agnostic for work management
  vdpa_sim: use kthread worker
  vdpa_sim: replace the spinlock with a mutex to protect the state
  vdpa_sim: add support for user VA

 drivers/vdpa/vdpa_sim/vdpa_sim.h     |  11 +-
 include/linux/vdpa.h                 |  10 ++
 include/linux/vringh.h               |   5 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c    |   2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c     | 144 ++++++++++++++++++++-----
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  10 +-
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  10 +-
 drivers/vhost/vdpa.c                 |  31 ++++++
 drivers/vhost/vringh.c               | 153 +++++++++++++++++++++------
 9 files changed, 301 insertions(+), 75 deletions(-)

-- 
2.39.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
