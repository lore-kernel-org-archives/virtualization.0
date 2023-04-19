Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2C4C77B73
	for <virtualization@archiver.kernel.org>; Wed, 19 Apr 2023 13:43:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C8DA040439;
	Wed, 19 Apr 2023 13:43:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C8DA040439
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E/Z1giyb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fx0ikD79bpi4; Wed, 19 Apr 2023 13:43:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 52F6242A4B;
	Wed, 19 Apr 2023 13:43:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 52F6242A4B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C2ADC0037;
	Wed, 19 Apr 2023 13:43:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD533C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 13:43:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8B6F342A4B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 13:43:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8B6F342A4B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GYGhck3rShO3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 13:43:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8123D40439
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8123D40439
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 13:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681911833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=MK0UGxGV6JsBO8AYL7soTcS9wXMNV0whUDQXJnSnGMA=;
 b=E/Z1giyboWmWIUuHyi0+9SARPUavcONUdUx+9/04iV80Lr9ZQg2TLCdUxFhBagYRvReJcB
 BuQv+ppZQTKgNLT3UivSK+iX9hS8jRE2xiopMEWS+tyTw3jm5FaPMVFdf2kAZp+aLnEKS/
 +XEUC5z7GfETTB32Rr/VfCacp3SRJo4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-4rw8mCRpPNme_IUbRr3wmA-1; Wed, 19 Apr 2023 09:43:50 -0400
X-MC-Unique: 4rw8mCRpPNme_IUbRr3wmA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC1B2101A554;
 Wed, 19 Apr 2023 13:43:49 +0000 (UTC)
Received: from max-t490s.redhat.com (unknown [10.39.208.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BDAB6492B04;
 Wed, 19 Apr 2023 13:43:47 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: xieyongji@bytedance.com, jasowang@redhat.com, mst@redhat.com,
 david.marchand@redhat.com
Subject: [RFC 0/2] vduse: add support for networking devices
Date: Wed, 19 Apr 2023 15:43:27 +0200
Message-Id: <20230419134329.346825-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Cc: xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, Maxime Coquelin <maxime.coquelin@redhat.com>
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

This small series enables virtio-net device type in VDUSE.
With it, basic operation have been tested, both with
virtio-vdpa and vhost-vdpa using DPDK Vhost library series
adding VDUSE support [0] using split rings layout.

Control queue support (and so multiqueue) has also been
tested, but require a Kernel series from Jason Wang
relaxing control queue polling [1] to function reliably.

Other than that, we have identified a few gaps:

1. Reconnection:
 a. VDUSE_VQ_GET_INFO ioctl() returns always 0 for avail
    index, even after the virtqueue has already been
    processed. Is that expected? I have tried instead to
    get the driver's avail index directly from the avail
    ring, but it does not seem reliable as I sometimes get
    "id %u is not a head!\n" warnings. Also such solution
    would not be possible with packed ring, as we need to
    know the wrap counters values.

 b. Missing IOCTLs: it would be handy to have new IOCTLs to
    query Virtio device status, and retrieve the config
    space set at VDUSE_CREATE_DEV time.

2. VDUSE application as non-root:
  We need to run the VDUSE application as non-root. There
  is some race between the time the UDEV rule is applied
  and the time the device starts being used. Discussing
  with Jason, he suggested we may have a VDUSE daemon run
  as root that would create the VDUSE device, manages its
  rights and then pass its file descriptor to the VDUSE
  app. However, with current IOCTLs, it means the VDUSE
  daemon would need to know several information that
  belongs to the VDUSE app implementing the device such
  as supported Virtio features, config space, etc...
  If we go that route, maybe we should have a control
  IOCTL to create the device which would just pass the
  device type. Then another device IOCTL to perform the
  initialization. Would that make sense?

3. Coredump:
  In order to be able to perform post-mortem analysis, DPDK
  Vhost library marks pages used for vrings and descriptors
  buffers as MADV_DODUMP using madvise(). However with
  VDUSE it fails with -EINVAL. My understanding is that we
  set VM_DONTEXPAND flag to the VMAs and madvise's
  MADV_DODUMP fails if it is present. I'm not sure to
  understand why madvise would prevent MADV_DODUMP if
  VM_DONTEXPAND is set. Any thoughts?

[0]: https://patchwork.dpdk.org/project/dpdk/list/?series=27594&state=%2A&archive=both
[1]: https://lore.kernel.org/lkml/CACGkMEtgrxN3PPwsDo4oOsnsSLJfEmBEZ0WvjGRr3whU+QasUg@mail.gmail.com/T/

Maxime Coquelin (2):
  vduse: validate block features only with block devices
  vduse: enable Virtio-net device type

 drivers/vdpa/vdpa_user/vduse_dev.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
2.39.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
