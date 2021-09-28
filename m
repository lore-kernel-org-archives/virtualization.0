Return-Path: <SRS0=Y9jr=OS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB76C433EF
	for <virtualization@archiver.kernel.org>; Tue, 28 Sep 2021 18:23:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20CA561371
	for <virtualization@archiver.kernel.org>; Tue, 28 Sep 2021 18:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 20CA561371
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2EFC60B38;
	Tue, 28 Sep 2021 18:23:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RPnqC85c--VB; Tue, 28 Sep 2021 18:23:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 51D0A60B24;
	Tue, 28 Sep 2021 18:23:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06EA4C0011;
	Tue, 28 Sep 2021 18:23:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0CB15C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 18:23:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E77C241485
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 18:23:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oyzR2vG3QG0a
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 18:23:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D2CFA41482
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 18:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632853400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8/a5gkIL9yAofs88ckFRESPQGSjIdBv52g14ib29Qfw=;
 b=fSH7GZ1PtF8GFEluGZIH5MaHzfZmrJ0fCrzXSiBry14JbWeXeaLeHDjwI3SeP8eg4r3kwj
 BfKmdxL2T6eZ3KZ4kd5P45j/Ggg0I/y7dCDGsEUBun/Fw18Wiyx0Txn8ONFh3itKTxdEgg
 i9JFgvNmB6zvROnf0Y5t2mMXK+yFigQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-iyZcQTaONDm3MWfcKShKpA-1; Tue, 28 Sep 2021 14:23:19 -0400
X-MC-Unique: iyZcQTaONDm3MWfcKShKpA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 810A51023F50;
 Tue, 28 Sep 2021 18:23:16 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.120])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0433660877;
 Tue, 28 Sep 2021 18:22:59 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/8] proc/vmcore: sanitize access to virtio-mem memory
Date: Tue, 28 Sep 2021 20:22:50 +0200
Message-Id: <20210928182258.12451-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Michal Hocko <mhocko@suse.com>, x86@kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 Stefano Stabellini <sstabellini@kernel.org>, Baoquan He <bhe@redhat.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org,
 Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Oscar Salvador <osalvador@suse.de>, Juergen Gross <jgross@suse.com>,
 kexec@lists.infradead.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>
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

As so often with virtio-mem changes that mess with common MM
infrastructure, this might be a good candiate to go via Andrew's tree.

--

After removing /dev/kmem, sanitizing /proc/kcore and handling /dev/mem,
this series tackles the last sane way how a VM could accidentially access
logically unplugged memory managed by a virtio-mem device: /proc/vmcore

When dumping memory via "makedumpfile", PG_offline pages, used by
virtio-mem to flag logically unplugged memory, are already properly
excluded; however, especially when accessing/copying /proc/vmcore "the
usual way", we can still end up reading logically unplugged memory part of
a virtio-mem device.

Patch #1-#3 are cleanups. Patch #4 extends the existing oldmem_pfn_is_ram
mechanism. Patch #5-#7 are virtio-mem refactorings for patch #8, which
implements the virtio-mem logic to query the state of device blocks.

Patch #8:

"
Although virtio-mem currently supports reading unplugged memory in the
hypervisor, this will change in the future, indicated to the device via
a new feature flag. We similarly sanitized /proc/kcore access recently.
[...]
Distributions that support virtio-mem+kdump have to make sure that the
virtio_mem module will be part of the kdump kernel or the kdump initrd;
dracut was recently [2] extended to include virtio-mem in the generated
initrd. As long as no special kdump kernels are used, this will
automatically make sure that virtio-mem will be around in the kdump initrd
and sanitize /proc/vmcore access -- with dracut.
"

This is the last remaining bit to support
VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE [3] in the Linux implementation of
virtio-mem.

Note: this is best-effort. We'll never be able to control what runs inside
the second kernel, really, but we also don't have to care: we only care
about sane setups where we don't want our VM getting zapped once we
touch the wrong memory location while dumping. While we usually expect sane
setups to use "makedumfile", nothing really speaks against just copying
/proc/vmcore, especially in environments where HWpoisioning isn't typically
expected. Also, we really don't want to put all our trust completely on the
memmap, so sanitizing also makes sense when just using "makedumpfile".

[1] https://lkml.kernel.org/r/20210526093041.8800-1-david@redhat.com
[2] https://github.com/dracutdevs/dracut/pull/1157
[3] https://lists.oasis-open.org/archives/virtio-comment/202109/msg00021.html

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: x86@kernel.org
Cc: xen-devel@lists.xenproject.org
Cc: virtualization@lists.linux-foundation.org
Cc: kexec@lists.infradead.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org

David Hildenbrand (8):
  x86/xen: update xen_oldmem_pfn_is_ram() documentation
  x86/xen: simplify xen_oldmem_pfn_is_ram()
  proc/vmcore: let pfn_is_ram() return a bool
  proc/vmcore: convert oldmem_pfn_is_ram callback to more generic vmcore
    callbacks
  virtio-mem: factor out hotplug specifics from virtio_mem_init() into
    virtio_mem_init_hotplug()
  virtio-mem: factor out hotplug specifics from virtio_mem_probe() into
    virtio_mem_init_hotplug()
  virtio-mem: factor out hotplug specifics from virtio_mem_remove() into
    virtio_mem_deinit_hotplug()
  virtio-mem: kdump mode to sanitize /proc/vmcore access

 arch/x86/kernel/aperture_64.c |  13 +-
 arch/x86/xen/mmu_hvm.c        |  31 ++--
 drivers/virtio/virtio_mem.c   | 297 ++++++++++++++++++++++++----------
 fs/proc/vmcore.c              | 105 ++++++++----
 include/linux/crash_dump.h    |  26 ++-
 5 files changed, 332 insertions(+), 140 deletions(-)


base-commit: 5816b3e6577eaa676ceb00a848f0fd65fe2adc29
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
