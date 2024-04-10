Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C0210A09
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Apr 2024 04:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712723725; cv=none; b=Ro+wyZEFFKDrUCuD+2YCaBpYWNWKzXZLuX2l+woNbOG3btZitqfvyX8qHstkNn8tmcKz2ihuzzLvfqZ0ueYy36D4sfIgIZZKHpXoGJtn2CdIllvQ0VknLGkUtO2Yr6T/F8y6qfHfHnEHQrRGmtafI69iubUMX041nuAvYRFnStU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712723725; c=relaxed/simple;
	bh=GTPYWUExqaKJ1ffWv/5oel5WsLqZgzXUVtWMpIIX7Mw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RH0Gwh5xlNgJO+7q2g59qRNcy5Y1i1sjH4N5P+Ysuz2P6f/CUYvVVbGv8V19eHMMUo8V91gXFZs47OII21extbZnL4fbrjg+FDjg8eZ79eY0azkmjLG76jQ5pdlzL06JNzQVx6leSa4FCs5pI4ahtGyW1slfUIE9GFsct/pPG4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LDS4XKCD; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDS4XKCD"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 81B7140142
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Apr 2024 04:35:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NsvqYevZCa3N for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Apr 2024 04:35:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 55BF640138
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 55BF640138
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LDS4XKCD
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 55BF640138
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Apr 2024 04:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712723718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lUyt2lP+iaweP7GGIQcQN2/vMQc1UDRPtDmxt5CULrM=;
	b=LDS4XKCD22VBFMr6IyXyGGyPp25Pjr1sNgcEbsX954CDWQ2EvK80gCJ/lF/j2QICy79/H0
	pb0/vAmkLyZGpgmj3w0+LG8v3ZQK0qPMjgD6psWxNf/7mKaeWdNagI+4qO5e6KpXw3DPLv
	TkCWw/DdlBsut+HiVgAiUrwbj62O7So=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-xXVMCXk2OW2YAcuTvXrPhQ-1; Wed,
 10 Apr 2024 00:35:16 -0400
X-MC-Unique: xXVMCXk2OW2YAcuTvXrPhQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C1F21C0C644;
	Wed, 10 Apr 2024 04:35:16 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.217])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CC93C47B;
	Wed, 10 Apr 2024 04:35:12 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] virtio-pci: Fix the crash that the vector was used after released
Date: Wed, 10 Apr 2024 12:33:14 +0800
Message-ID: <20240410043450.416752-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

During the booting process of the Vyatta image, the behavior of the
called function in qemu is as follows:

1. vhost_net_stop() was triggered by guest image . This will call the function
virtio_pci_set_guest_notifiers() with assgin= false, and
virtio_pci_set_guest_notifiers(） will release the irqfd for vector 0

2. virtio_reset() was called -->set configure vector to VIRTIO_NO_VECTOR

3.vhost_net_start() was called (at this time, the configure vector is
still VIRTIO_NO_VECTOR) and call virtio_pci_set_guest_notifiers() with
assgin= true, so the irqfd for vector 0 is still not "init" during this process

4. The system continues to boot,set the vector back to 0, and msix_fire_vector_notifier() was triggered
 unmask the vector 0 and then met the crash
[msix_fire_vector_notifier] 112 called vector 0 is_masked 1
[msix_fire_vector_notifier] 112 called vector 0 is_masked 0

To fix this, we need to call the function "kvm_virtio_pci_vector_use_one()"
when the vector changes back from VIRTIO_NO_VECTOR.

The reason that we don't need to call kvm_virtio_pci_vector_release_one while the vector changes to
VIRTIO_NO_VECTOR is this function will called in vhost_net_stop(),
So this step will not lost during this process.

Change from V1
1.add the check for if using irqfd
2.remove the check for bool recovery, irqfd's user is enough to check status

Cindy Lu (1):
  virtio-pci: Fix the crash that the vector was used after released.

 hw/virtio/virtio-pci.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

-- 
2.43.0

