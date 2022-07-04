Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7789CC433EF
	for <virtualization@archiver.kernel.org>; Mon,  4 Jul 2022 17:17:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D58E44035A;
	Mon,  4 Jul 2022 17:17:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D58E44035A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EkjryOXo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M9kyGTuqlUXE; Mon,  4 Jul 2022 17:17:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CD53440337;
	Mon,  4 Jul 2022 17:17:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CD53440337
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3B04C0032;
	Mon,  4 Jul 2022 17:17:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C7D3C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 17:17:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E8D4081263
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 17:17:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E8D4081263
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=EkjryOXo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bQluUCR3zwHx
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 17:17:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4361F81251
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4361F81251
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 17:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656955027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dJl8ux0EZ7Jia3kKagn8kSTy589GQC3E4FjhJXlWoqY=;
 b=EkjryOXoEdBIlQ6EeCeQDnmOHdsqcnIuthHxAV+YxpPKkvrlgT9Vrux2E4gv4QUKWwtsgj
 8QD8EowdYWX6QVL2v3+2J6+upJyO1sTbQDtZPaJSmgnlhePUX+B6KT0TmC3dQqTYvx0iV3
 AbVWrppD4JRS/pgI97nfPwCZzimmPns=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-467-LrBcvVO7M0GKak3VNJ3tEA-1; Mon, 04 Jul 2022 13:17:06 -0400
X-MC-Unique: LrBcvVO7M0GKak3VNJ3tEA-1
Received: by mail-qk1-f198.google.com with SMTP id
 186-20020a3708c3000000b006af306eb272so9159516qki.18
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Jul 2022 10:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dJl8ux0EZ7Jia3kKagn8kSTy589GQC3E4FjhJXlWoqY=;
 b=IVyfbqMMxb7jkGtRcRDlskFYs0HigSwHg8R5k90ndcNeLpUsZwnKnDdDkcaUAZ/Ebe
 +hvyHD220TDFiCy09zwVhV8Q8HQGl1+0aneLjVX4zyHGw2h+4lMoaGCbaQR3IJVycyzs
 A6mNcTOedgnwhWijXjbp82IWxGo/4cAO+3L5yDU7G12InXP8ePOc5i0MsGl4rdywKFFl
 IqTpkiqzILIc6VMOGqJUCSDdms3RPdt5EXDZp0ITO2ke4HYK2Jkrlgag9MRVCsoM4pds
 vByQSZFDLYkbU4lx6064S1xv21OElu7jUbOrUoiuvlM95L6/4jYqk4ve3rFnkIawouYG
 K3Nw==
X-Gm-Message-State: AJIora+uVNYEvpM5dOjoOy7g0cT5L6dpHrz5Gr3gMWxe1vlPKgk5t+J7
 5YFObypBRzBR0Qv1lCOPrWwceWOxDdSYgB0MJBu5p4An+JMothXRqhnEpA8zkb1pZ0QeDr/Kh7N
 c1GMJ1+gN8Hmkt6HYBojzgPwTX+wyXw1EJB75TSRK1jeJHkgMWyg2n+NYUpK31/gol5HIXNCMm2
 BxBn/uG6rqTSISZPqaFQ==
X-Received: by 2002:a05:622a:1387:b0:31d:40ca:e0d3 with SMTP id
 o7-20020a05622a138700b0031d40cae0d3mr9228554qtk.121.1656955025879; 
 Mon, 04 Jul 2022 10:17:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tdqvbbkgywL0gMPuv2TluFvxiJijTYr7j5CCBab+M/VZT3kqBA0aJume41Clg+XZJh/b2cbQ==
X-Received: by 2002:a05:622a:1387:b0:31d:40ca:e0d3 with SMTP id
 o7-20020a05622a138700b0031d40cae0d3mr9228526qtk.121.1656955025578; 
 Mon, 04 Jul 2022 10:17:05 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-206.retail.telecomitalia.it.
 [79.46.200.206]) by smtp.gmail.com with ESMTPSA id
 o16-20020a05620a2a1000b006a68fdc2d18sm21656078qkp.130.2022.07.04.10.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Jul 2022 10:17:04 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 0/6] virtio_test: add support for vhost-vdpa
Date: Mon,  4 Jul 2022 19:16:55 +0200
Message-Id: <20220704171701.127665-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
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

The first 3 patches fix various problems I have encountered with
virtio_test (they may go without this series, but I included to allow you
to test the series).

Patch 4 is in preparation of patch 5, moving the feature negotiation when
we initialize the device.

Patch 5 add the support of vhost-vdpa in virtio_test

Patch 6 add vdpa_test.ko based on vdpa_sim_test.c, so we can reuse most of
the code coming from the vdpa_sim framework.

I tested in this way:

  $ modprobe vdpa_sim
  $ modprobe vhost-vdpa

  # load the vdpasim_test device
  $ insmod vdpa_test.ko

  # create a new vdpasim_test device
  $ vdpa dev add mgmtdev vdpasim_test name dev0

  # run the test using the /dev/vhost-vdpa-0 device
  $ ./virtio_test --vdpa /dev/vhost-vdpa-0
  spurious wakeups: 0x0 started=0x100000 completed=0x100000

Comments and suggestions are welcome :-)

Thanks,
Stefano

Stefano Garzarella (6):
  tools/virtio: fix build
  vhost_test: add $(srctree) on the included path
  virtio_test: call __virtio_unbreak_device
  tools/virtio: move feature negotiation in vdev_info_init()
  virtio_test: support vhost-vdpa device
  vdpasim: add vdpa_sim_test module

 tools/virtio/linux/kernel.h           |   2 +-
 tools/virtio/linux/virtio.h           |   2 +
 tools/virtio/linux/vringh.h           |   1 +
 drivers/vdpa/vdpa_sim/vdpa_sim_test.c | 203 ++++++++++++++++++++++++++
 tools/virtio/vdpa_test/vdpa_test.c    |   1 +
 tools/virtio/virtio_test.c            | 131 ++++++++++++++---
 tools/virtio/Makefile                 |  32 +++-
 tools/virtio/vdpa_test/Makefile       |   3 +
 tools/virtio/vhost_test/Makefile      |   2 +-
 9 files changed, 350 insertions(+), 27 deletions(-)
 create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim_test.c
 create mode 100644 tools/virtio/vdpa_test/vdpa_test.c
 create mode 100644 tools/virtio/vdpa_test/Makefile

-- 
2.36.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
