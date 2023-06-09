Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8F4C7EE2E
	for <virtualization@archiver.kernel.org>; Fri,  9 Jun 2023 16:17:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 28D068412F;
	Fri,  9 Jun 2023 16:17:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 28D068412F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HV8dNv+j
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZnpMRf52Dtgc; Fri,  9 Jun 2023 16:17:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7D83684238;
	Fri,  9 Jun 2023 16:17:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7D83684238
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E40FC0095;
	Fri,  9 Jun 2023 16:17:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC9FEC007A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 16:17:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C119242046
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 16:17:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C119242046
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HV8dNv+j
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8HBj0EB8waJm
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 16:17:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9C44E42439
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9C44E42439
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 16:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686327462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=4M45gRnQ1u7hqy31r1Lf6wTaxv13BKes8mPSZrcPv2Y=;
 b=HV8dNv+jPAed3700iHy5eSGN4NcvCEDkrJVDpdFW2/Ff+kGFknl9FIaIF1DacB9XKSvy52
 XAvnW4ov4YL/EgJdnvnXOk2hm4jZULWIynXSzWUW4turBi+f9A8fqeFJFRGEXYLj2Os0kr
 iCYils6zuF4ZvL8Qef2pBaSl2JldrYg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-KgE1TpkJPv2t1oAG-Qmndw-1; Fri, 09 Jun 2023 12:17:41 -0400
X-MC-Unique: KgE1TpkJPv2t1oAG-Qmndw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30c6060eb32so2554347f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 09 Jun 2023 09:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686327460; x=1688919460;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4M45gRnQ1u7hqy31r1Lf6wTaxv13BKes8mPSZrcPv2Y=;
 b=E1YOxbjGVIxGQTfgKaopHdyAIkQyeZu0vREtkJLGFnY6k9oy/E0HKUiYBA6Jt6cMjk
 aAPOaqA1dJsGr9I7M93s2D3Ls798sDbONCzArNgp4RT5sGi0uOI6dShShdxCJfLZeJHI
 yp5m8ddDuvefaAjAmG0+rLfrhUuNU++45T9J1RM73om5n+7FiiTGby+8JcBwZUal21HM
 TU0C/YXbvAjYllC+KMl9Mx1C36NCDA+HgykgwsPC86OsFSb03J/jcWBA5P5tbfzhY20B
 guqgzJekRpub1cEquKctD0qCroveHBHDqHFJkH6E/qobunhMxlKRLGkSUWmZICf0hZ8q
 DbRg==
X-Gm-Message-State: AC+VfDxreYSrEnJrFFctKyYULulKFcYCAqH/OQ5epd94Dz9sEapiYPqH
 m7rtQLO8A5oH6ZWedBIibCFg5KgeoW0+FOHvQ/x47ZAcWPRNoTWFxcayNiUim6TbwyPaUBS4RsS
 RXAMYdnYsMlhhNMf6yZBG2e93i67gFeGcqq7a03wbOg==
X-Received: by 2002:adf:e110:0:b0:307:2d0c:4036 with SMTP id
 t16-20020adfe110000000b003072d0c4036mr1422042wrz.66.1686327460472; 
 Fri, 09 Jun 2023 09:17:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5MwccKZqMZmmQAMpaztP78KxQ/TadfL/ac1dUpnVsjT6zjT2OgsfcKy47axrXbgo+oojXt4w==
X-Received: by 2002:adf:e110:0:b0:307:2d0c:4036 with SMTP id
 t16-20020adfe110000000b003072d0c4036mr1422026wrz.66.1686327460126; 
 Fri, 09 Jun 2023 09:17:40 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7403:2800:22a6:7656:500:4dab])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a5d6acc000000b003062b6a522bsm4864763wrw.96.2023.06.09.09.17.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jun 2023 09:17:39 -0700 (PDT)
Date: Fri, 9 Jun 2023 12:17:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] virtio,vhost,vdpa: bugfixes
Message-ID: <20230609121737-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: sheng.zhao@bytedance.com, zwisler@chromium.org, kvm@vger.kernel.org,
 mst@redhat.com, syzbot+d0d442c22fa8db45ff0e@syzkaller.appspotmail.com,
 netdev@vger.kernel.org, zwisler@google.com, linux-kernel@vger.kernel.org,
 xieyongji@bytedance.com, asmetanin@yandex-team.ru, prathubaronia2011@gmail.com,
 zengxianjun@bytedance.com, virtualization@lists.linux-foundation.org,
 rongtao@cestc.cn
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

The following changes since commit 9561de3a55bed6bdd44a12820ba81ec416e705a7:

  Linux 6.4-rc5 (2023-06-04 14:04:27 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 07496eeab577eef1d4912b3e1b502a2b52002ac3:

  tools/virtio: use canonical ftrace path (2023-06-09 12:08:08 -0400)

----------------------------------------------------------------
virtio,vhost,vdpa: bugfixes

A bunch of fixes all over the place

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Andrey Smetanin (1):
      vhost_net: revert upend_idx only on retriable error

Dragos Tatulea (1):
      vdpa/mlx5: Fix hang when cvq commands are triggered during device unregister

Mike Christie (2):
      vhost: Fix crash during early vhost_transport_send_pkt calls
      vhost: Fix worker hangs due to missed wake up calls

Prathu Baronia (1):
      vhost: use kzalloc() instead of kmalloc() followed by memset()

Rong Tao (2):
      tools/virtio: Fix arm64 ringtest compilation error
      tools/virtio: Add .gitignore for ringtest

Ross Zwisler (1):
      tools/virtio: use canonical ftrace path

Shannon Nelson (3):
      vhost_vdpa: tell vqs about the negotiated
      vhost: support PACKED when setting-getting vring_base
      vhost_vdpa: support PACKED when setting-getting vring_base

Sheng Zhao (1):
      vduse: avoid empty string for dev name

 drivers/vdpa/mlx5/net/mlx5_vnet.c       |  2 +-
 drivers/vdpa/vdpa_user/vduse_dev.c      |  3 ++
 drivers/vhost/net.c                     | 11 +++--
 drivers/vhost/vdpa.c                    | 34 +++++++++++++--
 drivers/vhost/vhost.c                   | 75 +++++++++++++++------------------
 drivers/vhost/vhost.h                   | 10 +++--
 kernel/vhost_task.c                     | 18 ++++----
 tools/virtio/ringtest/.gitignore        |  7 +++
 tools/virtio/ringtest/main.h            | 11 +++++
 tools/virtio/virtio-trace/README        |  2 +-
 tools/virtio/virtio-trace/trace-agent.c | 12 ++++--
 11 files changed, 120 insertions(+), 65 deletions(-)
 create mode 100644 tools/virtio/ringtest/.gitignore

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
