Return-Path: <SRS0=Cd1r=BK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332F9C433E0
	for <virtualization@archiver.kernel.org>; Fri, 31 Jul 2020 09:18:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F299A22CA1
	for <virtualization@archiver.kernel.org>; Fri, 31 Jul 2020 09:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FiVCuRWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F299A22CA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 68C54886FB;
	Fri, 31 Jul 2020 09:18:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Iq-8RA1iKYD; Fri, 31 Jul 2020 09:18:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9133587BB8;
	Fri, 31 Jul 2020 09:18:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5808CC0050;
	Fri, 31 Jul 2020 09:18:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3731AC004D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Jul 2020 09:18:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 23EF584539
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Jul 2020 09:18:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3iIPMfTftKIu
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Jul 2020 09:18:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4DD898452F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Jul 2020 09:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596187132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7KJjJxh3LrCrOmiVZX7zoQLv4kMydPtkCS0ZPjF2DUk=;
 b=FiVCuRWJSMGZ4b9rF+wVB+oQueeP82nv2MDSJXC97CSYubtzlZHiU4XN51U+MCOWqScXy8
 mOJ5H3TdGy9NiTd9bNPGBy6/T2Pi1zPyT9nihh7T1WgqSXEDzxIznsR0G+aUURlfjq5x2+
 Z2D/MUYHNS4JWwHc9/lynTjt6YU/6eY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-SolxhgZkNXO5E6nSxUQ3oA-1; Fri, 31 Jul 2020 05:18:49 -0400
X-MC-Unique: SolxhgZkNXO5E6nSxUQ3oA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07FF759;
 Fri, 31 Jul 2020 09:18:47 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-22.ams2.redhat.com [10.36.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC0631A835;
 Fri, 31 Jul 2020 09:18:39 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFCv1 0/5] mm/memory_hotplug: selective merging of memory
 resources
Date: Fri, 31 Jul 2020 11:18:33 +0200
Message-Id: <20200731091838.7490-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: linux-hyperv@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Dan Williams <dan.j.williams@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Ard Biesheuvel <ardb@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, xen-devel@lists.xenproject.org,
 Julien Grall <julien@xen.org>, Kees Cook <keescook@chromium.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>,
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
current kexec-tools resource count limit does not allow more than ~100GB
of memory with a memory block size of 128MB on x86-64).

Let's allow to selectively merge resources, speciyfing a parent node and
a resource idendifier string. The memory unplug path will properly split
up merged resources again.

Patch #3 contains a /proc/iomem example. Only tested with virtio-mem.

Note: This gets the job done and is comparably simple. More complicated
approaches would require introducing IORESOURCE_MERGEABLE and extending our
add_memory*() interfaces with a flag, specifying that merging after adding
succeeded is acceptable. I'd like to avoid that complexity and code churn
for now.

David Hildenbrand (5):
  kernel/resource: make release_mem_region_adjustable() never fail
  kernel/resource: merge_child_mem_resources() to merge memory resources
    after adding succeeded
  virtio-mem: try to merge "System RAM (virtio_mem)" resources
  xen/balloon: try to merge "System RAM" resources
  hv_balloon:: try to merge "System RAM" resources

 drivers/hv/hv_balloon.c     |   3 ++
 drivers/virtio/virtio_mem.c |  14 ++++-
 drivers/xen/balloon.c       |   4 ++
 include/linux/ioport.h      |   7 ++-
 kernel/resource.c           | 105 ++++++++++++++++++++++++++++--------
 mm/memory_hotplug.c         |  22 +-------
 6 files changed, 109 insertions(+), 46 deletions(-)

-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
