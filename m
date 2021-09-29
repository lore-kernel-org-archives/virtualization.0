Return-Path: <SRS0=D/KU=OT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45FFC433F5
	for <virtualization@archiver.kernel.org>; Wed, 29 Sep 2021 15:11:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D9A0613D3
	for <virtualization@archiver.kernel.org>; Wed, 29 Sep 2021 15:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5D9A0613D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2DF5E83753;
	Wed, 29 Sep 2021 15:11:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kvgZfU7tlpE9; Wed, 29 Sep 2021 15:11:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C1D4D8364B;
	Wed, 29 Sep 2021 15:11:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96C69C0011;
	Wed, 29 Sep 2021 15:11:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 915D5C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 15:11:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7901B60E93
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 15:11:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=axis.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EJcnrOAFo_V8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 15:11:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2993260C25
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 15:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; q=dns/txt; s=axis-central1; t=1632928284;
 x=1664464284;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=chXe7LowbepFp9WcjiVKhwfFPB4CO+NsYBHetH4uz4g=;
 b=dJY9A3hZVMJsSQakuuGHoCw6UtJsRy/UMxKtIjYxm7HBdY/rwrb2JfrO
 KhDCng2pfKcYOKFA/tnoyIhg3jJ4dpu3aaO1Y2T/9JZr417ChWz8mAopu
 CLGXK/46hepia2oAW6tg9cr0j+hdDO9gM2DDNAxQ98Oxo58JTUtqWBjQY
 WT4Ac8jb6+tn+L3yIO3LyRbgWOds+ZXT/rYVQCBAnlj/guSMjb8D3TzaX
 HyPv3LJfCk/fnzFVvkdAUu1hPSbs3p1hS9IqPBqDG2IsI7h+edxTKKei+
 FsvRR1ao2PGUPS7c1kpZJamWRnvN33YFDnFw9znDv9J/23GRLIR/PFvfl g==;
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
To: <mst@redhat.com>, <jasowang@redhat.com>
Subject: [RFC PATCH 00/10] Support kernel buffers in vhost
Date: Wed, 29 Sep 2021 17:11:09 +0200
Message-ID: <20210929151119.14778-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, kernel@axis.com,
 stefanha@redhat.com, pbonzini@redhat.com
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

vhost currently expects that the virtqueues and the queued buffers are
accessible from a userspace process' address space.  However, when using vhost
to communicate between two Linux systems running on two physical CPUs in an AMP
configuration (on a single SoC or via something like PCIe), it is undesirable
from a security perspective to make the entire kernel memory of the other Linux
system accessible from userspace.

To remedy this, this series adds support to vhost for placing the virtqueues
and queued buffers in kernel memory.  Since userspace should not be allowed to
control the placement and attributes of these virtqueues, a mechanism to do
this from kernel space is added.  A vDPA-based test driver is added which uses
this support to allow virtio-net and vhost-net to communicate with each other
on the same system without exposing kernel memory to userspace via /dev/mem or
similar.

This vDPA-based test driver is intended to be used as the basis for the
implementation of driver which will allow Linux-Linux communication between
physical CPUs on SoCs using virtio and vhost, for instance by using information
from the device tree to indicate the location of shared memory, and the mailbox
API to trigger interrupts between the CPUs.

This patchset is also available at:

 https://github.com/vwax/linux/tree/vhost/rfc

Vincent Whitchurch (10):
  vhost: scsi: use copy_to_iter()
  vhost: push virtqueue area pointers into a user struct
  vhost: add iov wrapper
  vhost: add support for kernel buffers
  vhost: extract common code for file_operations handling
  vhost: extract ioctl locking to common code
  vhost: add support for kernel control
  vhost: net: add support for kernel control
  vdpa: add test driver for kernel buffers in vhost
  selftests: add vhost_kernel tests

 drivers/vdpa/Kconfig                          |   8 +
 drivers/vdpa/Makefile                         |   1 +
 drivers/vdpa/vhost_kernel_test/Makefile       |   2 +
 .../vhost_kernel_test/vhost_kernel_test.c     | 575 ++++++++++++++++++
 drivers/vhost/Kconfig                         |   6 +
 drivers/vhost/Makefile                        |   3 +
 drivers/vhost/common.c                        | 340 +++++++++++
 drivers/vhost/net.c                           | 212 ++++---
 drivers/vhost/scsi.c                          |  50 +-
 drivers/vhost/test.c                          |   2 +-
 drivers/vhost/vdpa.c                          |   6 +-
 drivers/vhost/vhost.c                         | 437 ++++++++++---
 drivers/vhost/vhost.h                         | 109 +++-
 drivers/vhost/vsock.c                         |  95 +--
 include/linux/vhost.h                         |  23 +
 tools/testing/selftests/Makefile              |   1 +
 .../vhost_kernel/vhost_kernel_test.c          | 287 +++++++++
 .../vhost_kernel/vhost_kernel_test.sh         | 125 ++++
 18 files changed, 2020 insertions(+), 262 deletions(-)
 create mode 100644 drivers/vdpa/vhost_kernel_test/Makefile
 create mode 100644 drivers/vdpa/vhost_kernel_test/vhost_kernel_test.c
 create mode 100644 drivers/vhost/common.c
 create mode 100644 include/linux/vhost.h
 create mode 100644 tools/testing/selftests/vhost_kernel/vhost_kernel_test.c
 create mode 100755 tools/testing/selftests/vhost_kernel/vhost_kernel_test.sh

-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
