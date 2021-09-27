Return-Path: <SRS0=Jws+=OR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA375C433F5
	for <virtualization@archiver.kernel.org>; Mon, 27 Sep 2021 22:30:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94D4061157
	for <virtualization@archiver.kernel.org>; Mon, 27 Sep 2021 22:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 94D4061157
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E17D404BC;
	Mon, 27 Sep 2021 22:30:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MueaottLijZU; Mon, 27 Sep 2021 22:30:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 07BE9404B9;
	Mon, 27 Sep 2021 22:30:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4993C001D;
	Mon, 27 Sep 2021 22:30:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9D0BC000F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 22:30:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CBC9B404B9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 22:30:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2HFUvax2767q
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 22:30:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D4E10404BC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 22:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632781811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=eCL0AZojEkxKxjkt+7Wlncn1gJOK+2tgTrPIC34EBbc=;
 b=F7NLL47YIt4QFYMyfG9mA6LIRK8MDfmkWNDV/4Hrm88+O2xvbbS8et8Wem34J7WJk+HRwT
 cUKqhczRQ4e8E2HllC40rphSb0Dqg3gXav8jG0PY3mvz39yKln+VQVrce8HHrpXTRCCH8a
 1+e50a3vBAGFVgrAqSqtpXvzS4VcUQY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-A68UdmvCMdaX-MfFl37kgw-1; Mon, 27 Sep 2021 18:30:10 -0400
X-MC-Unique: A68UdmvCMdaX-MfFl37kgw-1
Received: by mail-wm1-f72.google.com with SMTP id
 j21-20020a05600c1c1500b0030ccce95837so480405wms.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 15:30:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=eCL0AZojEkxKxjkt+7Wlncn1gJOK+2tgTrPIC34EBbc=;
 b=3ALZtRbkEyk8kstG8y4Irg3xus2YvGe5ko/y72EOUb+dW1bDuVuzOut0pIiroHCNPK
 CQpKm66lF7La2EhA6dQn60eXVWGdl6gRWGdXJ3XSqwRRU3RJqyyw5aGzTrxGvgsrGjZd
 PLYBrGdj+InHU2i812Gx/6rcCKYUhSiknbDKr8DenYQ3hXFVIAU5F9VS6i6lq0OY01ho
 xmSWBwcLXx2QFQRfmZuOv/b5B9ukoqLdeAYys1uLvUyYwyB3F+1tnyqZ4cVbL4X/cLiG
 EQlRqwDyMGOlh1pFT8u3sbsQB6twwypkJLKfMBhSXmP3F0yvD7PsvIaOgg1NaUnD2nS3
 BxLQ==
X-Gm-Message-State: AOAM532U6hIWQiigp9EFINwePyB3puTaB1JQFems5LCcqgokhuBUPs1p
 tX3ToR/hM2UvIE5MrekIJ1clndSbF+bSZGG+jyPhc08kRgTrJVOwn+TcwXEALbEv0u9tcpoMylM
 09/aA01h2p3yKlXSA7EZwOvzMyaxINkI35HvZGnUq4g==
X-Received: by 2002:a05:6000:d2:: with SMTP id q18mr2722604wrx.4.1632781808991; 
 Mon, 27 Sep 2021 15:30:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrsPsib+hEYb8pFtjMLnI7CifdC97NAniAu5m3nBLmbR4U5TSkin30Vu44yOu2ox2ibxz4Yg==
X-Received: by 2002:a05:6000:d2:: with SMTP id q18mr2722587wrx.4.1632781808842; 
 Mon, 27 Sep 2021 15:30:08 -0700 (PDT)
Received: from redhat.com ([2.55.4.59])
 by smtp.gmail.com with ESMTPSA id w18sm2490799wrt.79.2021.09.27.15.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Sep 2021 15:30:08 -0700 (PDT)
Date: Mon, 27 Sep 2021 18:30:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] virtio,vdpa: fixes
Message-ID: <20210927183003-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, arnd@arndb.de, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 xieyongji@bytedance.com, linux@roeck-us.net, viresh.kumar@linaro.org,
 elic@nvidia.com, dan.carpenter@oracle.com
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

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to be9c6bad9b46451ba5bb8d366c51e2475f374981:

  vdpa: potential uninitialized return in vhost_vdpa_va_map() (2021-09-14 18:10:43 -0400)

----------------------------------------------------------------
virtio,vdpa: fixes

Fixes up some issues in rc1.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Dan Carpenter (2):
      vduse: missing error code in vduse_init()
      vdpa: potential uninitialized return in vhost_vdpa_va_map()

Eli Cohen (2):
      vdpa/mlx5: Clear ready indication for control VQ
      vdpa/mlx5: Avoid executing set_vq_ready() if device is reset

Michael S. Tsirkin (1):
      virtio: don't fail on !of_device_is_compatible

Xie Yongji (1):
      vduse: Cleanup the old kernel states after reset failure

 drivers/vdpa/mlx5/net/mlx5_vnet.c  |  5 +++++
 drivers/vdpa/vdpa_user/vduse_dev.c | 10 +++++-----
 drivers/vhost/vdpa.c               |  2 +-
 drivers/virtio/virtio.c            |  7 ++++++-
 4 files changed, 17 insertions(+), 7 deletions(-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
