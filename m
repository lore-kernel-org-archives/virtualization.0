Return-Path: <SRS0=G0EF=CU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B795C433E2
	for <virtualization@archiver.kernel.org>; Fri, 11 Sep 2020 10:35:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20749204EC
	for <virtualization@archiver.kernel.org>; Fri, 11 Sep 2020 10:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GtwJqSsa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20749204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BC7778781E;
	Fri, 11 Sep 2020 10:35:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6+OWmSuEo4Do; Fri, 11 Sep 2020 10:35:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 089D387803;
	Fri, 11 Sep 2020 10:35:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DEA0BC0052;
	Fri, 11 Sep 2020 10:35:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69346C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 10:35:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 55663876F8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 10:35:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fUaH6hfdsGr3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 10:35:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2625A87637
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 10:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599820529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1KuXxBJDT9q7FMGTTmPve0j4GWux8SlD+IUyrucmwlw=;
 b=GtwJqSsajUx7DE+lq7cRijZyPE2r5nfRqG5MZJvyBR9cnq48KqceYRagMhvzJCCGKipPVe
 rYkpSt84nej8T3GwaQSppK1Msn9JW9CRiEdpkHcnU9bCOBd9imFJjHlw4sg0vgaHK8cvah
 78Tz+z2EPxTuj44sXZ0+apkGPB14/eQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-oFPkKPz2OhqR_nzBBqVMxA-1; Fri, 11 Sep 2020 06:35:25 -0400
X-MC-Unique: oFPkKPz2OhqR_nzBBqVMxA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA7358064AF;
 Fri, 11 Sep 2020 10:35:19 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-186.ams2.redhat.com [10.36.113.186])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7A83881C49;
 Fri, 11 Sep 2020 10:35:00 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/8] selective merging of system ram resources
Date: Fri, 11 Sep 2020 12:34:51 +0200
Message-Id: <20200911103459.10306-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: linux-hyperv@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Pingfan Liu <kernelfans@gmail.com>, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, Oliver O'Halloran <oohall@gmail.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-s390@vger.kernel.org,
 Wei Liu <wei.liu@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Baoquan He <bhe@redhat.com>,
 linux-nvdimm@lists.01.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Michael Ellerman <mpe@ellerman.id.au>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ard Biesheuvel <ardb@kernel.org>, linux-acpi@vger.kernel.org,
 Wei Yang <richardw.yang@linux.intel.com>, xen-devel@lists.xenproject.org,
 Anton Blanchard <anton@ozlabs.org>, Heiko Carstens <hca@linux.ibm.com>,
 Len Brown <lenb@kernel.org>, Nathan Lynch <nathanl@linux.ibm.com>,
 Julien Grall <julien@xen.org>, Kees Cook <keescook@chromium.org>,
 Vasily Gorbik <gor@linux.ibm.com>, Leonardo Bras <leobras.c@gmail.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Juergen Gross <jgross@suse.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Libor Pechacek <lpechacek@suse.cz>, Thomas Gleixner <tglx@linutronix.de>,
 Eric Biederman <ebiederm@xmission.com>,
 Andrew Morton <akpmt@linux-foundation.org>, Paul Mackerras <paulus@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
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

Some add_memory*() users add memory in small, contiguous memory blocks.
Examples include virtio-mem, hyper-v balloon, and the XEN balloon.

This can quickly result in a lot of memory resources, whereby the actual
resource boundaries are not of interest (e.g., it might be relevant for
DIMMs, exposed via /proc/iomem to user space). We really want to merge
added resources in this scenario where possible.

Resources are effectively stored in a list-based tree. Having a lot of
resources not only wastes memory, it also makes traversing that tree more
expensive, and makes /proc/iomem explode in size (e.g., requiring
kexec-tools to manually merge resources when creating a kdump header. The
current kexec-tools resource count limit does not allow for more than
~100GB of memory with a memory block size of 128MB on x86-64).

Let's allow to selectively merge system ram resources by specifying a
new flag for add_memory*(). Patch #5 contains a /proc/iomem example. Only
tested with virtio-mem.

v3 -> v4:
- "mm/memory_hotplug: guard more declarations by CONFIG_MEMORY_HOTPLUG"
-- Fix configs without CONFIG_MEMORY_HOTPLUG with the new mhp_t type
-- Did a buch of cross-compiles with different configs, hope there isn't
   anything I missed.

v2 -> v3:
- "mm/memory_hotplug: prepare passing flags to add_memory() and friends"
-- Use proper __bitwise type for flags
-- Use "MHP_NONE" for empty flags
- Rebased to latest -next, added rb's

v1 -> v2:
- I had another look at v1 after vacation and didn't like it - it felt like
  a hack. So I want forward and added a proper flag to add_memory*(), and
  introduce a clean (non-racy) way to mark System RAM resources mergeable.
- "kernel/resource: move and rename IORESOURCE_MEM_DRIVER_MANAGED"
-- Clean that flag up, felt wrong in the PnP section
- "mm/memory_hotplug: prepare passing flags to add_memory() and friends"
-- Previously sent in other context - decided to keep Wei's ack
- "mm/memory_hotplug: MEMHP_MERGE_RESOURCE to specify merging of System
   RAM resources"
-- Cleaner approach to get the job done by using proper flags and only
   merging the single, specified resource
- "virtio-mem: try to merge system ram resources"
  "xen/balloon: try to merge system ram resources"
  "hv_balloon: try to merge system ram resources"
-- Use the new flag MEMHP_MERGE_RESOURCE, much cleaner

RFC -> v1:
- Switch from rather generic "merge_child_mem_resources()" where a resource
  name has to be specified to "merge_system_ram_resources().
- Smaller comment/documentation/patch description changes/fixes

David Hildenbrand (8):
  kernel/resource: make release_mem_region_adjustable() never fail
  kernel/resource: move and rename IORESOURCE_MEM_DRIVER_MANAGED
  mm/memory_hotplug: guard more declarations by CONFIG_MEMORY_HOTPLUG
  mm/memory_hotplug: prepare passing flags to add_memory() and friends
  mm/memory_hotplug: MEMHP_MERGE_RESOURCE to specify merging of System
    RAM resources
  virtio-mem: try to merge system ram resources
  xen/balloon: try to merge system ram resources
  hv_balloon: try to merge system ram resources

 arch/powerpc/platforms/powernv/memtrace.c     |   2 +-
 .../platforms/pseries/hotplug-memory.c        |   2 +-
 drivers/acpi/acpi_memhotplug.c                |   3 +-
 drivers/base/memory.c                         |   3 +-
 drivers/dax/kmem.c                            |   2 +-
 drivers/hv/hv_balloon.c                       |   2 +-
 drivers/s390/char/sclp_cmd.c                  |   2 +-
 drivers/virtio/virtio_mem.c                   |   3 +-
 drivers/xen/balloon.c                         |   2 +-
 include/linux/ioport.h                        |  12 +-
 include/linux/memory_hotplug.h                |  35 +++---
 kernel/kexec_file.c                           |   2 +-
 kernel/resource.c                             | 109 ++++++++++++++----
 mm/memory_hotplug.c                           |  47 +++-----
 mm/sparse.c                                   |   2 +
 15 files changed, 151 insertions(+), 77 deletions(-)

-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
