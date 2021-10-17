Return-Path: <SRS0=jOBa=PF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2136DC433F5
	for <virtualization@archiver.kernel.org>; Sun, 17 Oct 2021 14:49:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB8D960F8F
	for <virtualization@archiver.kernel.org>; Sun, 17 Oct 2021 14:49:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BB8D960F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 81DDC6071D;
	Sun, 17 Oct 2021 14:49:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G_qxfZGsJIh8; Sun, 17 Oct 2021 14:49:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 33F926077D;
	Sun, 17 Oct 2021 14:49:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E80E6C000F;
	Sun, 17 Oct 2021 14:49:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BECF3C000D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 17 Oct 2021 14:49:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A5550400F6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 17 Oct 2021 14:49:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h8mnIN8d9AcL
 for <virtualization@lists.linux-foundation.org>;
 Sun, 17 Oct 2021 14:49:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6BF9F402EB
 for <virtualization@lists.linux-foundation.org>;
 Sun, 17 Oct 2021 14:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634482147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=Ip6ZgePH8xwpK2sHmkpaBxfB7ZKPtwdcnXkOJDJISgI=;
 b=cZqmA6S03o5aJ1IrMdXkH/h3X0VugOHyRZohjOsRo+0AtjzV5KR6+F5H3Xu12Hbxpniw1h
 oYgQpDn9Pmhj6/ofQaQ6i52P8UZWh5eMJZSpJte5KMQq+a5Cjh39HdP2/UMor2pKaKIzeI
 6seZU+jyZUdLciwVSRfIhgFIqIbzn8o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-36si67NQMre7Q-nLF9KOqA-1; Sun, 17 Oct 2021 10:49:05 -0400
X-MC-Unique: 36si67NQMre7Q-nLF9KOqA-1
Received: by mail-wm1-f71.google.com with SMTP id
 c69-20020a1c9a48000000b0030d95485d90so2311608wme.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 17 Oct 2021 07:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=Ip6ZgePH8xwpK2sHmkpaBxfB7ZKPtwdcnXkOJDJISgI=;
 b=Bbk2WMwwgjmnU8LHMZ/Z7bVSuCA06kwBkoWBw6N+HNzipPdzQF6VQY6/HjrSHw8bNr
 YNSAYsaVrcwyiCkudLVOLDUjxgqLHHcOK5/QFwadh2lJMUjOgLdfOIfSE1I0VbbUPp3M
 yhHyefqyBelzquXHjP0v1vW9DSs3vJZcfn8iG1pRQ60ttkPBrTLaxGdRjBmtQvl92m/E
 KnNpl7TTeOOL7DJxOGqtnlI4wNIew78JTALSlto0YlzOGKlwXvOYsTOuxNC5q14DhC/s
 T55ibyzAe0RVx403RoNSPkcmayzMTsvPSwNZS+K9z2zYBQGbOrwyNj2JGlwayhlEdL5+
 TV3Q==
X-Gm-Message-State: AOAM532pqDTq8w1hVvLSNvCVoHRZ2Y7npcWvwQ+8/mveQCxikM9karY3
 sjgw3Na+CkgHhW6jhHVpLTXsa83in8keFRL7NVkxdts1RL97F6qxzinD4OvdLD1DXGfWS+Qw42L
 BRg4v+WmHYycCx5vWTLCuVdk9Jj2iZ4PNOr1xAC+lEg==
X-Received: by 2002:a05:6000:1683:: with SMTP id
 y3mr15124356wrd.314.1634482144584; 
 Sun, 17 Oct 2021 07:49:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFBg10YCOIJdS2cG0k9v/rSms6MDVN0cXyAC9SocqmtQ9OZq/KfKELZOAfWYN7H7AEZxW3lg==
X-Received: by 2002:a05:6000:1683:: with SMTP id
 y3mr15124332wrd.314.1634482144347; 
 Sun, 17 Oct 2021 07:49:04 -0700 (PDT)
Received: from redhat.com ([2.55.147.75])
 by smtp.gmail.com with ESMTPSA id a2sm11630293wrq.9.2021.10.17.07.49.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Oct 2021 07:49:03 -0700 (PDT)
Date: Sun, 17 Oct 2021 10:49:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] virtio,vdpa: fixes
Message-ID: <20211017104900-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: rdunlap@infradead.org, lulu@redhat.com, kvm@vger.kernel.org, corbet@lwn.net,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, pasic@linux.ibm.com,
 xieyongji@bytedance.com, mst@redhat.com, wuzongyong@linux.alibaba.com,
 markver@us.ibm.com
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

The following changes since commit be9c6bad9b46451ba5bb8d366c51e2475f374981:

  vdpa: potential uninitialized return in vhost_vdpa_va_map() (2021-09-14 18:10:43 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to bcef9356fc2e1302daf373c83c826aa27954d128:

  vhost-vdpa: Fix the wrong input in config_cb (2021-10-13 08:42:07 -0400)

----------------------------------------------------------------
virtio,vdpa: fixes

Fixes up some issues in rc5.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Cindy Lu (1):
      vhost-vdpa: Fix the wrong input in config_cb

Halil Pasic (1):
      virtio: write back F_VERSION_1 before validate

Michael S. Tsirkin (1):
      Revert "virtio-blk: Add validation for block size in config space"

Randy Dunlap (1):
      VDUSE: fix documentation underline warning

Wu Zongyong (1):
      vhost_vdpa: unset vq irq before freeing irq

 Documentation/userspace-api/vduse.rst |  2 +-
 drivers/block/virtio_blk.c            | 37 ++++++-----------------------------
 drivers/vhost/vdpa.c                  | 10 +++++-----
 drivers/virtio/virtio.c               | 11 +++++++++++
 4 files changed, 23 insertions(+), 37 deletions(-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
