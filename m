Return-Path: <SRS0=8i8N=ES=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3342C56201
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 13:38:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30EA122249
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 13:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cpUW/ktr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30EA122249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8FCAA870C5;
	Thu, 12 Nov 2020 13:38:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nn5VVY4Ico50; Thu, 12 Nov 2020 13:38:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6F253870AD;
	Thu, 12 Nov 2020 13:38:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 518C2C088B;
	Thu, 12 Nov 2020 13:38:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE376C016F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:38:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id AC72387797
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:38:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4EnIOf+mqOzS
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:38:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id F28B587791
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 13:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605188311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ul1CruwCYx90w7ShMaERvkQrn5bStSp6/chNAktrnL0=;
 b=cpUW/ktrtRY+jJhjwmdXccWgeZkVvAtfhDlXrYYjZgsDTBBBy/6LMcZTZAG132POBtljrh
 SnFvpJVcSfiQ2ctU0z7+Ce5RnaSmMshbFYQVWq0L6fEVmTdLw4SSdciAyre3cj9SE1jQek
 TizDxIwd3XAARyhqkPmDi5/OjfE0srU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-81Uqt09dOKqVsUdrzESfCg-1; Thu, 12 Nov 2020 08:38:27 -0500
X-MC-Unique: 81Uqt09dOKqVsUdrzESfCg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF2361030986;
 Thu, 12 Nov 2020 13:38:25 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-61.ams2.redhat.com [10.36.115.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7133655766;
 Thu, 12 Nov 2020 13:38:16 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/29] virtio-mem: Big Block Mode (BBM)
Date: Thu, 12 Nov 2020 14:37:46 +0100
Message-Id: <20201112133815.13332-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Wei Yang <richard.weiyang@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>,
 Oscar Salvador <osalvador@suse.de>
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

@Andrew, can we have an ack for patch #27, so that one can go via
the vhost tree for 5.11?

---

virtio-mem currently only supports device block sizes that span at most
a single Linux memory block. For example, gigantic pages in the hypervisor
result on x86-64 in a device block size of 1 GiB - when the Linux memory
block size is 128 MiB, we cannot support such devices (we fail loading the
driver). Of course, we want to support any device block size in any Linux
VM.

Bigger device block sizes will become especially important once supporting
VFIO in QEMU - each device block has to be mapped separately, and the
maximum number of mappings for VFIO is 64k. So we usually want blocks in
the gigabyte range when wanting to grow the VM big.

Patch #1 - #10 are cleanups and optimizations
Patch #11 - #24 are refactorings to prepare for BBM
Patch #25 - #29 implement BBM, including one mm/memory_hotplug extension

This series is based on latest linus/master and can be found at:
 git@github.com:davidhildenbrand/linux.git virtio-mem-bbm-v2

v1 -> v2:
- Code wise, the only bigger change is using an union for sbm/bbm state
- Reworked some subjects/patch descriptions
- Reshuffled patches to make reviweing easier, and to have
  cleanups+optimizations before all refactorings
- "virtio-mem: more precise calculation in
   virtio_mem_mb_state_prepare_next_mb()"
-- Changed subject
-- Avoid two local variables

David Hildenbrand (29):
  virtio-mem: determine nid only once using memory_add_physaddr_to_nid()
  virtio-mem: more precise calculation in
    virtio_mem_mb_state_prepare_next_mb()
  virtio-mem: simplify MAX_ORDER - 1 / pageblock_order handling
  virtio-mem: drop rc2 in virtio_mem_mb_plug_and_add()
  virtio-mem: use "unsigned long" for nr_pages when fake
    onlining/offlining
  virtio-mem: factor out calculation of the bit number within the
    subblock bitmap
  virtio-mem: print debug messages from virtio_mem_send_*_request()
  virtio-mem: factor out fake-offlining into virtio_mem_fake_offline()
  virtio-mem: factor out handling of fake-offline pages in memory
    notifier
  virtio-mem: retry fake-offlining via alloc_contig_range() on
    ZONE_MOVABLE
  virtio-mem: generalize check for added memory
  virtio-mem: generalize virtio_mem_owned_mb()
  virtio-mem: generalize virtio_mem_overlaps_range()
  virtio-mem: drop last_mb_id
  virtio-mem: don't always trigger the workqueue when offlining memory
  virtio-mem: generalize handling when memory is getting onlined
    deferred
  virito-mem: document Sub Block Mode (SBM)
  virtio-mem: memory block states are specific to Sub Block Mode (SBM)
  virito-mem: subblock states are specific to Sub Block Mode (SBM)
  virtio-mem: nb_sb_per_mb and subblock_size are specific to Sub Block
    Mode (SBM)
  virtio-mem: memory block ids are specific to Sub Block Mode (SBM)
  virito-mem: existing (un)plug functions are specific to Sub Block Mode
    (SBM)
  virtio-mem: memory notifier callbacks are specific to Sub Block Mode
    (SBM)
  virtio-mem: factor out adding/removing memory from Linux
  virtio-mem: Big Block Mode (BBM) memory hotplug
  virtio-mem: allow to force Big Block Mode (BBM) and set the big block
    size
  mm/memory_hotplug: extend offline_and_remove_memory() to handle more
    than one memory block
  virtio-mem: Big Block Mode (BBM) - basic memory hotunplug
  virtio-mem: Big Block Mode (BBM) - safe memory hotunplug

 drivers/virtio/virtio_mem.c | 1789 +++++++++++++++++++++++++----------
 mm/memory_hotplug.c         |  105 +-
 2 files changed, 1376 insertions(+), 518 deletions(-)

-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
