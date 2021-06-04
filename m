Return-Path: <SRS0=Cwtm=K6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F017DC4708F
	for <virtualization@archiver.kernel.org>; Fri,  4 Jun 2021 05:54:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BB9A61414
	for <virtualization@archiver.kernel.org>; Fri,  4 Jun 2021 05:54:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB9A61414
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5253260AF1;
	Fri,  4 Jun 2021 05:54:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vRcvOJEYujXY; Fri,  4 Jun 2021 05:54:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE7B1605B7;
	Fri,  4 Jun 2021 05:54:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AEF49C000E;
	Fri,  4 Jun 2021 05:54:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 007C4C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 05:54:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C69F260AF1
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 05:54:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eZt-ys-CTcvw
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 05:54:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 16DB0605B7
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 05:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622786046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=JcMYDN5e5/VcbzKkSMYluKgdtznxbeNg+SJYhFB6TPM=;
 b=BiZLy6VOqAVsMJdUyPfJR+Etkb3csZvRebrmd5+6sGEi5bIJliLOMsSGPpYLqlz9JhORO9
 pizt4IjWK0SYT0DajfMM3rbV/3TMhEjMPF3zafjrD/tnTMut3f80Gum00ZlUvt1qH3VhNQ
 Gfc6hT68/XgI1ZsGjW7o1FDZnjp/PHg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-FfAhthQVOtiRULiLeh5enA-1; Fri, 04 Jun 2021 01:54:05 -0400
X-MC-Unique: FfAhthQVOtiRULiLeh5enA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F41F107ACE3;
 Fri,  4 Jun 2021 05:54:03 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-212.pek2.redhat.com
 [10.72.12.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A98BE5DEAD;
 Fri,  4 Jun 2021 05:53:52 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com
Subject: [PATCH 0/7] Do not read from descriptor ring
Date: Fri,  4 Jun 2021 13:53:43 +0800
Message-Id: <20210604055350.58753-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: ashish.kalra@amd.com, ak@linux.intel.com, file@sect.tu-berlin.de,
 luto@kernel.org, kvm@vger.kernel.org, konrad.wilk@oracle.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 hch@infradead.org, xieyongji@bytedance.com, stefanha@redhat.com
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

Hi:

The virtio driver should not trust the device. This beame more urgent
for the case of encrtpyed VM or VDUSE[1]. In both cases, technology
like swiotlb/IOMMU is used to prevent the poking/mangling of memory
from the device. But this is not sufficient since current virtio
driver may trust what is stored in the descriptor table (coherent
mapping) for performing the DMA operations like unmap and bounce so
the device may choose to utilize the behaviour of swiotlb to perform
attacks[2].

To protect from a malicous device, this series store and use the
descriptor metadata in an auxiliay structure which can not be accessed
via swiotlb/device instead of the ones in the descriptor table. This
means the descriptor table is write-only from the view of the driver.

Actually, we've almost achieved that through packed virtqueue and we
just need to fix a corner case of handling mapping errors. For split
virtqueue we just follow what's done in the packed.

Note that we don't duplicate descriptor medata for indirect
descriptors since it uses stream mapping which is read only so it's
safe if the metadata of non-indirect descriptors are correct.

For split virtqueue, the change increase the footprint due the the
auxiliary metadata but it's almost neglectlable in simple test like
pktgen and netperf TCP stream (slightly noticed in a 40GBE environment
with more CPU usage).

Slightly tested with packed on/off, iommu on/of, swiotlb force/off in
the guest.

Note that this series tries to fix the attack via descriptor
ring. The other cases (used ring and config space) will be fixed by
other series or patches.

Please review.

Changes from RFC V2:
- no code change
- twaeak the commit log a little bit

Changes from RFC V1:
- Always use auxiliary metadata for split virtqueue
- Don't read from descripto when detaching indirect descriptor

Jason Wang (7):
  virtio-ring: maintain next in extra state for packed virtqueue
  virtio_ring: rename vring_desc_extra_packed
  virtio-ring: factor out desc_extra allocation
  virtio_ring: secure handling of mapping errors
  virtio_ring: introduce virtqueue_desc_add_split()
  virtio: use err label in __vring_new_virtqueue()
  virtio-ring: store DMA metadata in desc_extra for split virtqueue

 drivers/virtio/virtio_ring.c | 201 +++++++++++++++++++++++++----------
 1 file changed, 144 insertions(+), 57 deletions(-)

-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
