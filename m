Return-Path: <SRS0=hbIa=B7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB79C433E3
	for <virtualization@archiver.kernel.org>; Fri, 21 Aug 2020 10:35:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E51F20FC3
	for <virtualization@archiver.kernel.org>; Fri, 21 Aug 2020 10:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="domLTO7T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E51F20FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 111F6885D0;
	Fri, 21 Aug 2020 10:35:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RWToWePNfxuN; Fri, 21 Aug 2020 10:35:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8B26E885B5;
	Fri, 21 Aug 2020 10:35:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A56CC07FF;
	Fri, 21 Aug 2020 10:35:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90990C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 10:35:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6CD52203B4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 10:35:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HN1RD5jvNqgf
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 10:34:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id AA839204C4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 10:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598006091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Lz1Dlp3n64jbr0nqc1nHMGKoG4tO/ALxoWb8NdfDDro=;
 b=domLTO7T0SoEgJNLvoTf5fxtxm7/j/b/PjYBNPAWSQvtncee6HUCUlFZiq/u5kkhamEbac
 hXYfmaM2s+D3E9gWdjUSca2fFOSRcOMJKpfp0lA7CiujOzAwGk35sEdcrc1IS6A0zGc5CJ
 QUTv78gqQ2+geCdDAvOO2pM/vpFIog0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-tNVl4_PKOqOy6s0hWbWRxQ-1; Fri, 21 Aug 2020 06:34:47 -0400
X-MC-Unique: tNVl4_PKOqOy6s0hWbWRxQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C4AA100CF73;
 Fri, 21 Aug 2020 10:34:44 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-87.ams2.redhat.com [10.36.114.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D2F07756D7;
 Fri, 21 Aug 2020 10:34:32 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/5] mm/memory_hotplug: selective merging of system ram
 resources
Date: Fri, 21 Aug 2020 12:34:26 +0200
Message-Id: <20200821103431.13481-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: linux-hyperv@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Dan Williams <dan.j.williams@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Baoquan He <bhe@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, xen-devel@lists.xenproject.org,
 Julien Grall <julien@xen.org>, Kees Cook <keescook@chromium.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Wei Yang <richardw.yang@linux.intel.com>,
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

This is the follow-up of "[PATCH RFCv1 0/5] mm/memory_hotplug: selective
merging of memory resources" [1]

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

Let's allow to selectively merge system ram resources directly below a
specific parent resource. Patch #3 contains a /proc/iomem example. Only
tested with virtio-mem.

Note: This gets the job done and is comparably simple. More complicated
approaches would require introducing IORESOURCE_MERGEABLE and extending our
add_memory*() interfaces with a flag, specifying that merging after adding
succeeded is acceptable. I'd like to avoid that complexity and code churn
for now.

[1] https://lkml.kernel.org/r/20200731091838.7490-1-david@redhat.com

RFC -> v1:
- Switch from rather generic "merge_child_mem_resources()" where a resource
  name has to be specified to "merge_system_ram_resources().
- Smaller comment/documentation/patch description changes/fixes

David Hildenbrand (5):
  kernel/resource: make release_mem_region_adjustable() never fail
  kernel/resource: merge_system_ram_resources() to merge resources after
    hotplug
  virtio-mem: try to merge system ram resources
  xen/balloon: try to merge system ram resources
  hv_balloon: try to merge system ram resources

 drivers/hv/hv_balloon.c     |   3 ++
 drivers/virtio/virtio_mem.c |  14 ++++-
 drivers/xen/balloon.c       |   4 ++
 include/linux/ioport.h      |   7 ++-
 kernel/resource.c           | 101 ++++++++++++++++++++++++++++--------
 mm/memory_hotplug.c         |  22 +-------
 6 files changed, 105 insertions(+), 46 deletions(-)

-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
