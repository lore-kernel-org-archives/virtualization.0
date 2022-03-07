Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6306C433EF
	for <virtualization@archiver.kernel.org>; Mon,  7 Mar 2022 11:03:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6EB0B402D1;
	Mon,  7 Mar 2022 11:03:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rvfB_Tf2uRUJ; Mon,  7 Mar 2022 11:03:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1BFFA402B3;
	Mon,  7 Mar 2022 11:03:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00E81C0012;
	Mon,  7 Mar 2022 11:03:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AEBACC000B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 11:03:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ABBBD402BD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 11:03:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x4sm0JxMtTfW
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 11:03:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8A6B0402B3
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 11:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646651020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=gNPPt7IcCgazViAJnPdJB9z9Owb+g+PUdYAZ9hinRqk=;
 b=BT6iS7p7c8NUw1GWi/4nxeUlh9hexfADkv4TQTvIbEnCuZcEG7KjXbHJOdE2ZlePDjdWlZ
 IJHylW+ml0xaSQKGdnzdgYvkA7Lv9dQkimnyumYry+5zYpTi7CwOt/53FE3qbkYCb+jQgD
 zzRFsMgBOHhRq587V0LwCGOBs3qIdkQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-O-2U_O1yN9qF3WIVpruzTw-1; Mon, 07 Mar 2022 06:03:39 -0500
X-MC-Unique: O-2U_O1yN9qF3WIVpruzTw-1
Received: by mail-ej1-f69.google.com with SMTP id
 hr26-20020a1709073f9a00b006d6d1ee8cf8so6751847ejc.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Mar 2022 03:03:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=gNPPt7IcCgazViAJnPdJB9z9Owb+g+PUdYAZ9hinRqk=;
 b=wWeK/iGVLS5lxfI5qXb2G6ACJivqCZQbzLkRLFwstOX6oKkrw9dqoWKxwfJVbzgXXf
 7ZVQ2Hm9xmsjxk6AnaBqf3Se7VaDQyVFv032yUJZDM0nc6qIlqaYfRWSr+TgK6vQuM5J
 53lX95UCeaLiqXCQt35GKaJSFdG5O/7TWhOWoOV9D+eVBCFV+GDAR00DN8fHML8hw0Fn
 wQYdqUqbmYMh+3oPcG1oVNTqMUnHHE2fzS0u9yruAJnpwlMfXefkS2L5KHDg0MI0ANPj
 uhHRWP8jSIZ9tGchtuSRX67NYALxgLIZ9fHYNWa9Alkn8BJm0nJb0g18/3yZ2jHcRjbV
 dYig==
X-Gm-Message-State: AOAM533e57UQ/7ydmBveVHvE9LB8mZmSeF38jNGraELI+SrHQxllHyuM
 6blWZTZaUQ73P49fkcce6Ek4UZY2zxqLgJmlNzxR+SiDfHz9n730U+2K+kt7MjTbz0IgjKbck3o
 VcZmlI/NQmLGW/4oAmkwp3dXbGsfcShRkD2MHoNyX5w==
X-Received: by 2002:a05:6402:1e91:b0:415:ecdb:bb42 with SMTP id
 f17-20020a0564021e9100b00415ecdbbb42mr10485781edf.367.1646651017440; 
 Mon, 07 Mar 2022 03:03:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzm045HAXHomDdQ4eh2BMpTcblB2cVV+JVDBoNGC3+rpUKylFjFOJZk78RZ+xJFhn3Hw+5UaQ==
X-Received: by 2002:a05:6402:1e91:b0:415:ecdb:bb42 with SMTP id
 f17-20020a0564021e9100b00415ecdbbb42mr10485752edf.367.1646651017235; 
 Mon, 07 Mar 2022 03:03:37 -0800 (PST)
Received: from redhat.com ([2.55.138.228]) by smtp.gmail.com with ESMTPSA id
 er12-20020a056402448c00b00413d03ac4a2sm5718316edb.69.2022.03.07.03.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Mar 2022 03:03:36 -0800 (PST)
Date: Mon, 7 Mar 2022 06:03:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] virtio: last minute fixes
Message-ID: <20220307060332-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: wang.yi59@zte.com.cn, zhang.min9@zte.com.cn, lkp@intel.com,
 kvm@vger.kernel.org, netdev@vger.kernel.org, mst@redhat.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, pasic@linux.ibm.com,
 xieyongji@bytedance.com, mail@anirudhrb.com, si-wei.liu@oracle.com,
 syzbot+0abd373e2e50d704db87@syzkaller.appspotmail.com,
 dan.carpenter@oracle.com
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

The following changes since commit 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3:

  Linux 5.17-rc6 (2022-02-27 14:36:33 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 3dd7d135e75cb37c8501ba02977332a2a487dd39:

  tools/virtio: handle fallout from folio work (2022-03-06 06:06:50 -0500)

----------------------------------------------------------------
virtio: last minute fixes

Some fixes that took a while to get ready. Not regressions,
but they look safe and seem to be worth to have.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Anirudh Rayabharam (1):
      vhost: fix hung thread due to erroneous iotlb entries

Michael S. Tsirkin (6):
      virtio: unexport virtio_finalize_features
      virtio: acknowledge all features before access
      virtio: document virtio_reset_device
      virtio_console: break out of buf poll on remove
      virtio: drop default for virtio-mem
      tools/virtio: handle fallout from folio work

Si-Wei Liu (3):
      vdpa: factor out vdpa_set_features_unlocked for vdpa internal use
      vdpa/mlx5: should verify CTRL_VQ feature exists for MQ
      vdpa/mlx5: add validation for VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command

Stefano Garzarella (2):
      vhost: remove avail_event arg from vhost_update_avail_event()
      tools/virtio: fix virtio_test execution

Xie Yongji (3):
      vduse: Fix returning wrong type in vduse_domain_alloc_iova()
      virtio-blk: Don't use MAX_DISCARD_SEGMENTS if max_discard_seg is zero
      virtio-blk: Remove BUG_ON() in virtio_queue_rq()

Zhang Min (1):
      vdpa: fix use-after-free on vp_vdpa_remove

 drivers/block/virtio_blk.c           | 20 ++++++-------
 drivers/char/virtio_console.c        |  7 +++++
 drivers/vdpa/mlx5/net/mlx5_vnet.c    | 34 ++++++++++++++++++++--
 drivers/vdpa/vdpa.c                  |  2 +-
 drivers/vdpa/vdpa_user/iova_domain.c |  2 +-
 drivers/vdpa/virtio_pci/vp_vdpa.c    |  2 +-
 drivers/vhost/iotlb.c                | 11 +++++++
 drivers/vhost/vdpa.c                 |  2 +-
 drivers/vhost/vhost.c                |  9 ++++--
 drivers/virtio/Kconfig               |  1 -
 drivers/virtio/virtio.c              | 56 ++++++++++++++++++++++++------------
 drivers/virtio/virtio_vdpa.c         |  2 +-
 include/linux/vdpa.h                 | 18 ++++++++----
 include/linux/virtio.h               |  1 -
 include/linux/virtio_config.h        |  3 +-
 tools/virtio/linux/mm_types.h        |  3 ++
 tools/virtio/virtio_test.c           |  1 +
 17 files changed, 127 insertions(+), 47 deletions(-)
 create mode 100644 tools/virtio/linux/mm_types.h

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
