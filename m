Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7170CC433EF
	for <virtualization@archiver.kernel.org>; Sun, 28 Nov 2021 17:58:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E863E40255;
	Sun, 28 Nov 2021 17:58:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7oD5e1-XPzlm; Sun, 28 Nov 2021 17:58:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3F85B40017;
	Sun, 28 Nov 2021 17:58:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15BD9C001C;
	Sun, 28 Nov 2021 17:58:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D7B2C000A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Nov 2021 17:58:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8725E405B9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Nov 2021 17:58:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id egJ1XJ59ttsi
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Nov 2021 17:58:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0A146403BF
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Nov 2021 17:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638122291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=aw8bghuFT1gVRspF1SIwJ9nxGGoDXPynCf2IvVb5wz8=;
 b=VU6zYd1Zm0uNnlP8aK2oBhKy13kekURFCPNzJPM4vWgJRLWOpNZRvglM/0CMhBL5qkZZCL
 robaFoIwZAE+5LyaA1Z1sAqdLe1BJhxBEwbdyNo6BzIrDeOtHzQjs90+DwxXCzZjERyAi+
 PS8dyk1yXhtwAvDzeksLBWHTVJrm3MI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-ua3mvqFHOaGE7ywqYH_xsQ-1; Sun, 28 Nov 2021 12:58:10 -0500
X-MC-Unique: ua3mvqFHOaGE7ywqYH_xsQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 l15-20020a056402124f00b003e57269ab87so11716951edw.6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Nov 2021 09:58:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=aw8bghuFT1gVRspF1SIwJ9nxGGoDXPynCf2IvVb5wz8=;
 b=MqDE8sXwtUSQh/ZaahslpLmftFV0RSBA6F6Rs+ZJOtuXRW2Qnd2NH40MEUh/Dazkaw
 di+KJ0a4TpjrktWWOqwWBjHN2XA1Ffc08FaRoJ+yINrN7qwhFXwzu62no+Ijc2EuGkmI
 WLh/zDcm+kGVUNsdVoLAjXdZNW1hlaqdxcB9nexc1eHPHNo9cHDE780GQ331zpSWAz8/
 nh5m/V7miehf7U+3YHAuTetOd0Rnu76EvTvwwaweNPHOJEeJRXHj/G5wwEUdv3aIE2Md
 LLDFT1AcPOOLM1Ar7hq44ZD5VrMuLd1fCeZBJ/i1/ixEri4XN1NYeVu7oR5S2eP9zWK3
 IK0Q==
X-Gm-Message-State: AOAM533QA3H+llG8DG7uTTgcRLUwqb/b66JEIzL0rz6m6BmyJcr4z3ya
 Fo5V6OCWrSXkyXguae9fgAr6xaZTD/51HqwxMwFvB9nDOFjubVrVRkMKtHYY52Zh/gwSc/SRMC0
 SuBmlxSSXE5QCdhklIOgbCjwYBWKdYrAysEfctLLBzQ==
X-Received: by 2002:a05:6402:35c2:: with SMTP id
 z2mr67408181edc.92.1638122289275; 
 Sun, 28 Nov 2021 09:58:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwmcTF6gn5TCzS+/rpoMf1mqbfbhiRbIxVsZL7CgEHFdEJ4mkHhQm2BnrUXrbOR/h6u/h/cxQ==
X-Received: by 2002:a05:6402:35c2:: with SMTP id
 z2mr67408154edc.92.1638122289105; 
 Sun, 28 Nov 2021 09:58:09 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:107d:bc0b:b6a8:e3e8:8431:4d58])
 by smtp.gmail.com with ESMTPSA id oz31sm6090037ejc.35.2021.11.28.09.58.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Nov 2021 09:58:08 -0800 (PST)
Date: Sun, 28 Nov 2021 12:58:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] vhost,virtio,vdpa: bugfixes
Message-ID: <20211128125803-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, pasic@linux.ibm.com,
 wuzongyong@linux.alibaba.com, ye.guojin@zte.com.cn, longpeng2@huawei.com,
 zealci@zte.com.cn
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

The following changes since commit 136057256686de39cc3a07c2e39ef6bc43003ff6:

  Linux 5.16-rc2 (2021-11-21 13:47:39 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to bb93ce4b150dde79f58e34103cbd1fe829796649:

  vdpa_sim: avoid putting an uninitialized iova_domain (2021-11-24 19:00:29 -0500)

----------------------------------------------------------------
vhost,virtio,vdpa: bugfixes

Misc fixes all over the place.

Revert of virtio used length validation series: the approach taken does
not seem to work, breaking too many guests in the process. We'll need to
do length validation using some other approach.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Longpeng (1):
      vdpa_sim: avoid putting an uninitialized iova_domain

Michael S. Tsirkin (4):
      Revert "virtio-scsi: don't let virtio core to validate used buffer length"
      Revert "virtio-blk: don't let virtio core to validate used length"
      Revert "virtio-net: don't let virtio core to validate used length"
      Revert "virtio_ring: validate used buffer length"

Stefano Garzarella (2):
      vhost/vsock: fix incorrect used length reported to the guest
      vhost/vsock: cleanup removing `len` variable

Wu Zongyong (1):
      vhost-vdpa: clean irqs before reseting vdpa device

Ye Guojin (1):
      virtio-blk: modify the value type of num in virtio_queue_rq()

 drivers/block/virtio_blk.c       |  3 +-
 drivers/net/virtio_net.c         |  1 -
 drivers/scsi/virtio_scsi.c       |  1 -
 drivers/vdpa/vdpa_sim/vdpa_sim.c |  7 +++--
 drivers/vhost/vdpa.c             |  2 +-
 drivers/vhost/vsock.c            |  8 ++----
 drivers/virtio/virtio_ring.c     | 60 ----------------------------------------
 include/linux/virtio.h           |  2 --
 8 files changed, 9 insertions(+), 75 deletions(-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
