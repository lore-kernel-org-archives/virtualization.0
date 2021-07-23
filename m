Return-Path: <SRS0=XE2Y=MP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E920C4320A
	for <virtualization@archiver.kernel.org>; Fri, 23 Jul 2021 12:52:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C696B60F22
	for <virtualization@archiver.kernel.org>; Fri, 23 Jul 2021 12:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C696B60F22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8A3DD401C7;
	Fri, 23 Jul 2021 12:52:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QY0ImhqFPPVF; Fri, 23 Jul 2021 12:52:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9EADF400A4;
	Fri, 23 Jul 2021 12:52:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7DDA8C001A;
	Fri, 23 Jul 2021 12:52:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F78FC000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 12:52:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 47F26400EF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 12:52:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p4kjQn5BnPZM
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 12:52:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 66022400A4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 12:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627044748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=SCvfdunl4to+8ZULNlc0LHFlCRzqtnsK/Iz2B6x2OAE=;
 b=TYLycOWWa0F6+U+r5EG3HtLSWWW3R7e+O8vNbm+kFCYje34gK1FKI2RaLVAcVbIPsHPLAb
 LQLCCtwx3dL/hVKHiRNps0XpmDONxmMeYaBxt/e10d7XgafV4cPdIzGr61YfrsdEXJ4MpN
 DVMtJ8LelRM/ONFhNg7jVmgGIeTTdeo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-vTmsuFE8MFSlfAOacGLgWA-1; Fri, 23 Jul 2021 08:52:26 -0400
X-MC-Unique: vTmsuFE8MFSlfAOacGLgWA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 029EF8799E0;
 Fri, 23 Jul 2021 12:52:24 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-253.ams2.redhat.com [10.36.112.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 90C3D6A8E4;
 Fri, 23 Jul 2021 12:52:11 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/9] mm/memory_hotplug: "auto-movable" online policy and
 memory groups
Date: Fri, 23 Jul 2021 14:52:01 +0200
Message-Id: <20210723125210.29987-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
 Pavel Tatashin <pasha.tatashin@soleen.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Dan Williams <dan.j.williams@intel.com>, Michal Hocko <mhocko@kernel.org>,
 Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hui Zhu <teawater@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Marek Kedzierski <mkedzier@redhat.com>, Mike Rapoport <rppt@kernel.org>
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

Hi,

this series is based on v5.14-rc2, with [2] on top. It applies cleanly
on top of linux-next of yesterday.


I. Goal

The goal of this series is improving in-kernel auto-online support. It
tackles the fundamental problems that:

 1) We can create zone imbalances when onlining all memory blindly to
    ZONE_MOVABLE, in the worst case crashing the system. We have to know
    upfront how much memory we are going to hotplug such that we can
    safely enable auto-onlining of all hotplugged memory to ZONE_MOVABLE
    via "online_movable". This is far from practical and only applicable in
    limited setups -- like inside VMs under the RHV/oVirt hypervisor which
    will never hotplug more than 3 times the boot memory (and the
    limitation is only in place due to the Linux limitation).

 2) We see more setups that implement dynamic VM resizing, hot(un)plugging
    memory to resize VM memory. In these setups, we might hotplug a lot of
    memory, but it might happen in various small steps in both directions
    (e.g., 2 GiB -> 8 GiB -> 4 GiB -> 16 GiB ...). virtio-mem is the
    primary driver of this upstream right now, performing such dynamic
    resizing NUMA-aware via multiple virtio-mem devices.

    Onlining all hotplugged memory to ZONE_NORMAL means we basically have
    no hotunplug guarantees. Onlining all to ZONE_MOVABLE means we can
    easily run into zone imbalances when growing a VM. We want a mixture,
    and we want as much memory as reasonable/configured in ZONE_MOVABLE.
    Details regarding zone imbalances can be found at [1].

 3) Memory devices consist of 1..X memory block devices, however, the
    kernel doesn't really track the relationship. Consequently, also user
    space has no idea. We want to make per-device decisions.

    As one example, for memory hotunplug it doesn't make sense to use a
    mixture of zones within a single DIMM: we want all MOVABLE if
    possible, otherwise all !MOVABLE, because any !MOVABLE part will easily
    block the whole DIMM from getting hotunplugged.

    As another example, virtio-mem operates on individual units that span
    1..X memory blocks. Similar to a DIMM, we want a unit to either be all
    MOVABLE or !MOVABLE. A "unit" can be thought of like a DIMM, however,
    all units of a virtio-mem device logically belong together and are
    managed (added/removed) by a single driver. We want as much memory of
    a virtio-mem device to be MOVABLE as possible.

 4) We want memory onlining to be done right from the kernel while adding
    memory, not triggered by user space via udev rules; for example, this
    is reqired for fast memory hotplug for drivers that add individual
    memory blocks, like virito-mem. We want a way to configure a policy in
    the kernel and avoid implementing advanced policies in user space.

The auto-onlining support we have in the kernel is not sufficient. All we
have is a) online everything MOVABLE (online_movable) b) online everything
!MOVABLE (online_kernel) c) keep zones contiguous (online). This series
allows configuring c) to mean instead "online movable if possible according
to the coniguration, driven by a maximum MOVABLE:KERNEL ratio" -- a new
onlining policy.


II. Approach

This series does 3 things:

 1) Introduces the "auto-movable" online policy that initially operates on
    individual memory blocks only. It uses a maximum MOVABLE:KERNEL ratio
    to make a decision whether a memory block will be onlined to
    ZONE_MOVABLE or not. However, in the basic form, hotplugged KERNEL
    memory does not allow for more MOVABLE memory (details in the
    patches). CMA memory is treated like MOVABLE memory.

 2) Introduces static (e.g., DIMM) and dynamic (e.g., virtio-mem) memory
    groups and uses group information to make decisions in the
    "auto-movable" online policy accross memory blocks of a single memory
    device (modeled as memory group). More details can be found in patch
    #3 or in the DIMM example below.

 3) Maximizes ZONE_MOVABLE memory within dynamic memory groups, by
    allowing ZONE_NORMAL memory within a dynamic memory group to allow for
    more ZONE_MOVABLE memory within the same memory group. The target use
    case is dynamic VM resizing using virtio-mem. See the virtio-mem
    example below.

I remember that the basic idea of using a ratio to implement a policy in
the kernel was once mentioned by Vitaly Kuznetsov, but I might be wrong
(I lost the pointer to that discussion).

For me, the main use case is using it along with virtio-mem (and
DIMMs / ppc64 dlpar where necessary) for dynamic resizing of VMs,
increasing the amount of memory we can hotunplug reliably again if we
might eventually hotplug a lot of memory to a VM.


III. Target Usage

The target usage will be:

 1) Linux boots with "mhp_default_online_type=offline"

 2) User space (e.g., systemd unit) configures memory onlining (according
    to a config file and system properties), for example:
    * Setting memory_hotplug.online_policy=auto-movable
    * Setting memory_hotplug.auto_movable_ratio=301
    * Setting memory_hotplug.auto_movable_numa_aware=true

 3) User space enabled auto onlining via "echo online >
    /sys/devices/system/memory/auto_online_blocks"

 4) User space triggers manual onlining of all already-offline memory
    blocks (go over offline memory blocks and set them to "online")


IV. Example

For DIMMs, hotplugging 4 GiB DIMMs to a 4 GiB VM with a configured ratio of
301% results in the following layout:
	Memory block 0-15:    DMA32   (early)
	Memory block 32-47:   Normal  (early)
	Memory block 48-79:   Movable (DIMM 0)
	Memory block 80-111:  Movable (DIMM 1)
	Memory block 112-143: Movable (DIMM 2)
	Memory block 144-275: Normal  (DIMM 3)
	Memory block 176-207: Normal  (DIMM 4)
	... all Normal
	(-> hotplugged Normal memory does not allow for more Movable memory)

For virtio-mem, using a simple, single virtio-mem device with a 4 GiB VM
will result in the following layout:
	Memory block 0-15:    DMA32   (early)
	Memory block 32-47:   Normal  (early)
	Memory block 48-143:  Movable (virtio-mem, first 12 GiB)
	Memory block 144:     Normal  (virtio-mem, next 128 MiB)
	Memory block 145-147: Movable (virtio-mem, next 384 MiB)
	Memory block 148:     Normal  (virtio-mem, next 128 MiB)
	Memory block 149-151: Movable (virtio-mem, next 384 MiB)
	... Normal/Movable mixture as above
	(-> hotplugged Normal memory allows for more Movable memory within
	    the same device)

Which gives us maximum flexibility when dynamically growing/shrinking a
VM in smaller steps.


V. Doc Update

I'll update the memory-hotplug.rst documentation, once the overhaul [1] is
usptream. Until then, details can be found in patch #2.


VI. Future Work

 1) Use memory groups for ppc64 dlpar
 2) Being able to specify a portion of (early) kernel memory that will be
    excluded from the ratio. Like "128 MiB globally/per node" are excluded.

    This might be helpful when starting VMs with extremely small memory
    footprint (e.g., 128 MiB) and hotplugging memory later -- not wanting
    the first hotplugged units getting onlined to ZONE_MOVABLE. One
    alternative would be a trigger to not consider ZONE_DMA memory
    in the ratio. We'll have to see if this is really rrequired.
 3) Indicate to user space that MOVABLE might be a bad idea -- especially
    relevant when memory ballooning without support for balloon compaction
    is active.


v1 -> v2:
- Split out all cleanup patches into [2]
- Minor patch description updates
- "dax/kmem: use a single static memory group for a single probed unit"
-- Added

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Marek Kedzierski <mkedzier@redhat.com>
Cc: Hui Zhu <teawater@gmail.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: virtualization@lists.linux-foundation.org
Cc: linux-mm@kvack.org
Cc: linux-acpi@vger.kernel.org

[1] https://lkml.kernel.org/r/20210707073205.3835-1-david@redhat.com
[2] https://lkml.kernel.org/r/20210712124052.26491-1-david@redhat.com

David Hildenbrand (9):
  mm: track present early pages per zone
  mm/memory_hotplug: introduce "auto-movable" online policy
  drivers/base/memory: introduce "memory groups" to logically group
    memory blocks
  mm/memory_hotplug: track present pages in memory groups
  ACPI: memhotplug: use a single static memory group for a single memory
    device
  dax/kmem: use a single static memory group for a single probed unit
  virtio-mem: use a single dynamic memory group for a single virtio-mem
    device
  mm/memory_hotplug: memory group aware "auto-movable" online policy
  mm/memory_hotplug: improved dynamic memory group aware "auto-movable"
    online policy

 drivers/acpi/acpi_memhotplug.c |  35 +++-
 drivers/base/memory.c          | 163 ++++++++++++++---
 drivers/dax/kmem.c             |  40 +++-
 drivers/virtio/virtio_mem.c    |  22 ++-
 include/linux/memory.h         |  53 +++++-
 include/linux/memory_hotplug.h |  22 ++-
 include/linux/mmzone.h         |   7 +
 mm/memory_hotplug.c            | 323 ++++++++++++++++++++++++++++++++-
 mm/page_alloc.c                |   3 +
 9 files changed, 617 insertions(+), 51 deletions(-)

-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
