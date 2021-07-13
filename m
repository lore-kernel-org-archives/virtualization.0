Return-Path: <SRS0=VeF6=MF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925DDC11F69
	for <virtualization@archiver.kernel.org>; Tue, 13 Jul 2021 16:19:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 457D661288
	for <virtualization@archiver.kernel.org>; Tue, 13 Jul 2021 16:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 457D661288
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A22F83264;
	Tue, 13 Jul 2021 16:19:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q2xv2KD-OrvB; Tue, 13 Jul 2021 16:19:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A03BB82F87;
	Tue, 13 Jul 2021 16:19:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70DBEC0010;
	Tue, 13 Jul 2021 16:19:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B35DC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 16:19:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D64BF608A4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 16:19:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GJIWWHS_Uy1R
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 16:19:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E93A560ABC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 16:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626193157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=awbwz8Mi1G1+f2fwGt3ZEpkOa0ZEsi8ROYjzYe/Okus=;
 b=PoxG3ZFQEIknPgusP3jAlPopWFK8MOplxhvPlQ2MYBymohwpwqs7RRESBlrr/PIQ7r1MgN
 yILgJUWeVdPoaJ6k3pgEBvY9JfrFKROZeJ3IzsQJxrGxSoWecbADwrshRumoIVF7xWhlPn
 brxHJX0zBCcu+boIfCx7zS3+gHE2gD0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-JG1pSGTjO-m9PADZ5-L7Wg-1; Tue, 13 Jul 2021 12:19:16 -0400
X-MC-Unique: JG1pSGTjO-m9PADZ5-L7Wg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 258DB1B2C983;
 Tue, 13 Jul 2021 16:19:15 +0000 (UTC)
Received: from localhost (ovpn-112-172.ams2.redhat.com [10.36.112.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C1F819C44;
 Tue, 13 Jul 2021 16:19:14 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC 0/3] cpuidle: add poll_source API and virtio vq polling
Date: Tue, 13 Jul 2021 17:19:03 +0100
Message-Id: <20210713161906.457857-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-pm@vger.kernel.org, virtualization@lists.linux-foundation.org
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

These patches are not polished yet but I would like request feedback on this
approach and share performance results with you.

Idle CPUs tentatively enter a busy wait loop before halting when the cpuidle
haltpoll driver is enabled inside a virtual machine. This reduces wakeup
latency for events that occur soon after the vCPU becomes idle.

This patch series extends the cpuidle busy wait loop with the new poll_source
API so drivers can participate in polling. Such polling-aware drivers disable
their device's irq during the busy wait loop to avoid the cost of interrupts.
This reduces latency further than regular cpuidle haltpoll, which still relies
on irqs.

Virtio drivers are modified to use the poll_source API so all virtio device
types get this feature. The following virtio-blk fio benchmark results show the
improvement:

             IOPS (numjobs=4, iodepth=1, 4 virtqueues)
               before   poll_source      io_poll
4k randread    167102  186049 (+11%)  186654 (+11%)
4k randwrite   162204  181214 (+11%)  181850 (+12%)
4k randrw      159520  177071 (+11%)  177928 (+11%)

The comparison against io_poll shows that cpuidle poll_source achieves
equivalent performance to the block layer's io_poll feature (which I
implemented in a separate patch series [1]).

The advantage of poll_source is that applications do not need to explicitly set
the RWF_HIPRI I/O request flag. The poll_source approach is attractive because
few applications actually use RWF_HIPRI and it takes advantage of CPU cycles we
would have spent in cpuidle haltpoll anyway.

The current series does not improve virtio-net. I haven't investigated deeply,
but it is possible that NAPI and poll_source do not combine. See the final
patch for a starting point on making the two work together.

I have not tried this on bare metal but it might help there too. The cost of
disabling a device's irq must be less than the savings from avoiding irq
handling for this optimization to make sense.

[1] https://lore.kernel.org/linux-block/20210520141305.355961-1-stefanha@redhat.com/

Stefan Hajnoczi (3):
  cpuidle: add poll_source API
  virtio: add poll_source virtqueue polling
  softirq: participate in cpuidle polling

 drivers/cpuidle/Makefile           |   1 +
 drivers/virtio/virtio_pci_common.h |   7 ++
 include/linux/interrupt.h          |   2 +
 include/linux/poll_source.h        |  53 +++++++++++++++
 include/linux/virtio.h             |   2 +
 include/linux/virtio_config.h      |   2 +
 drivers/cpuidle/poll_source.c      | 102 +++++++++++++++++++++++++++++
 drivers/cpuidle/poll_state.c       |   6 ++
 drivers/virtio/virtio.c            |  34 ++++++++++
 drivers/virtio/virtio_pci_common.c |  86 ++++++++++++++++++++++++
 drivers/virtio/virtio_pci_modern.c |   2 +
 kernel/softirq.c                   |  14 ++++
 12 files changed, 311 insertions(+)
 create mode 100644 include/linux/poll_source.h
 create mode 100644 drivers/cpuidle/poll_source.c

-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
