Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE002D77FD
	for <virtualization@lists.linux.dev>; Thu,  3 Jul 2025 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751534795; cv=none; b=V11e6drUfFDi6tF5I9iIxXl5GU+RguZBA/zqYao/LwaBaG0Q3rd8lPRmvhlmJhlYmiScaahn8lQbfqvRZ8jpd4yS/lhLpBCYsLhB9JQj+h8amK5MN8QF0Fqyx3QqTZJLtDUiwwmdcvEFAwj9c3OUie99KhnEsGB5ZB7yeMA+O50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751534795; c=relaxed/simple;
	bh=dXJfFfr2BawRbdZt7uXC560IiY/RJpXASjLPjwl9fsA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Iil6WwhXeD9qRSgVAVnDFDJlk4EkRIZ7bghhKhBBCcUGLkpzNM0vNarxsJVYXTS7188qP1aPcwRlGJaXpBQnDvsErR53mikw8sidTJ2TbB2zSp3Z09NyL+fXMK8WyvV5/q8geROGpjAwj0/nT2SEZWn75yQu1YUGlKQ1jBX6aQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B383P8HX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B383P8HX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751534790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=BglLQcJl/SBLMmxhnpBc8HIRNbUjD0EW8Qi8lNaR8ik=;
	b=B383P8HX03JnnJA5zhmaLKTfGx8lG6/FNuVMCjoXQJY8QlWuthY7LZW4O0aKznLPaIYWbR
	zfKx5U6P4Q7oTCOTNuhHArJF+tudWQeF0ayKb7fOi3nV7qjMlkj24l3HXP0dpozyFvEFaR
	NdEV0nxWoxViqm6WxAZOxau6vHr36IA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-AcwbT1XrNjynXCa30_xdxQ-1; Thu, 03 Jul 2025 05:26:28 -0400
X-MC-Unique: AcwbT1XrNjynXCa30_xdxQ-1
X-Mimecast-MFC-AGG-ID: AcwbT1XrNjynXCa30_xdxQ_1751534787
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4fac7fa27so1963883f8f.0
        for <virtualization@lists.linux.dev>; Thu, 03 Jul 2025 02:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751534787; x=1752139587;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BglLQcJl/SBLMmxhnpBc8HIRNbUjD0EW8Qi8lNaR8ik=;
        b=sSTh0xDtMOdns0YGRkKMnP/J4aM3n9imQflADu3WkmALLVCKaRvc9xEjwpcrYrwQgN
         RxJ636l1qLN7uoOBiOemnfYd/MacxCfirA1Vt6jlqOyWUm3EAAB8OjIrutbhwzjLfHmT
         TzpLekUUk5DvRLSpSVlomg18Jok3I9iTR6wmufp4XzR1Rb0C/SWsjebkjxZyID+3A/79
         nU4xE0vcHRUAh32JqrTh6QbCXIqtgj7E6XytO704NRIklU8kl8kC/HF+oyqrXismqT2D
         eXol0FmXcFz3C+KzJ8ADrzsLUAa2+7Gw/SjSG5HaRkks1KzJPZfhXluV8yRokNIjt6Cg
         jmBw==
X-Forwarded-Encrypted: i=1; AJvYcCXme9f6eS0A8O9Fj3cPZ7XAyYex+scC/hFcxwvyohlVYgXtazPXhOtRgaSK5ob+cpQSVvPz77GeZtWSWEuVKw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxRynzaDE0gNCwTgXUejvgw8y+yNWhaH+Ip6ajb6Nrc4/3CSTjj
	x9NeqYNYOobp8Vqkg9QOt1BlGNrxWoaNyAxDBO28Q/AtsCEml5e2tTQ+HBxRsBfSG+S54kee3MT
	ix6QUCIqT4PVOv1G/j9PDgHYav3CrEC8Y6joN4plyj/C8nyfSh5I04V6W9C3OO6V86a5S
X-Gm-Gg: ASbGnctxTEfovQDoX3OJLuExpFu1tEXXVKsumY+HQAnBKIQ6nEmj9+g4vV9b6FXXA9N
	5LSGgT5zFGldLxYL+ZWH3ujlhB6J7OFO7CLMD62EGiAKl7Z3UiL8NiBX1IYZ3+18Nd79Xf/qDBt
	smLVo3fcwJzaSryJoRNPHDHT5O7nNyo2A3ky7wAHJCTETQGQhkOvmVg+tYaF3CHArmfD7siuswm
	Vf/XGqr8Qt7bQhSW6p3D/7/684nTRc2Y/006+wG6LeWWTzcDnsfxayHlSWKa2WUa5JFaMHWDP92
	FCye6k7TZxgICKkY
X-Received: by 2002:a05:6000:1786:b0:3a4:d0fe:42b2 with SMTP id ffacd0b85a97d-3b1fee672aamr4990742f8f.19.1751534787052;
        Thu, 03 Jul 2025 02:26:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVLKRMCm2HThh8pLYhO6+Aw29bJdAnwwp+9OCfLw05ZMXTQBKiqPcwpfOlyAzu0jASdPc6gw==
X-Received: by 2002:a05:6000:1786:b0:3a4:d0fe:42b2 with SMTP id ffacd0b85a97d-3b1fee672aamr4990704f8f.19.1751534786551;
        Thu, 03 Jul 2025 02:26:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:1400:856d:9957:3ec3:1ddc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c8013b3sm18166555f8f.39.2025.07.03.02.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 02:26:26 -0700 (PDT)
Date: Thu, 3 Jul 2025 05:26:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com
Subject: [PATCH RFC v4 0/5] pci,virtio: report surprise removal event
Message-ID: <cover.1751534711.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8Bs4ZaE3lAtklpOxIujKDCpaiXyU-63emoEFEnL8mEg_1751534787
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Lukas, Keith, Bjorn, others, would very much appreciate your comments
on whether the pci core changes are acceptable.


Parav, I expect this to be integrated into your work on fixing surprise
removal. As such, I am not queueing these patches yet - please include with your
other patches fixing these issues.

==========

This is an attempt to fix the following race in virtio:

when device removal is initiated by a user
action, such as driver unbind, it in turn initiates driver cleanup and
is then waiting for an interrupt from the device. If the device is now
surprise-removed, that interrupt never arrives and the remove callback hangs
forever.

For example, this was reported for virtio-blk:

        1. the graceful removal is ongoing in the remove() callback, where disk
           deletion del_gendisk() is ongoing, which waits for the requests +to
           complete,

        2. Now few requests are yet to complete, and surprise removal started.

        At this point, virtio block driver will not get notified by the driver
        core layer, because it is likely serializing remove() happening by
        +user/driver unload and PCI hotplug driver-initiated device removal.  So
        vblk driver doesn't know that device is removed, block layer is waiting
        for requests completions to arrive which it never gets.  So
        del_gendisk() gets stuck.

We could add timeouts to handle that, but given virtio blk devices are
implemented in userspace, this makes the device flaky.

Instead, this adds pci core infrastructure, and virtio core
infrastructure, for drivers to be notified of device disconnect.

Actual cleanup in virtio-blk is still TBD.
Compile-tested only.

==========

Notes on the design:

Care was taken to avoid re-introducing the bug fixed by

commit 74ff8864cc84 ("PCI: hotplug: Allow marking devices as disconnected during bind/unbind")

To avoid taking locks on removal path, and to avoid invoking callback
with unpredictable latency, the event is reported through a WQ.

Adding APIs to enable/disable the reporting on probe/remove, helps make
sure the driver won't go away in the middle of the handling, all
without taking any locks.

The benefit is that the resulting API is harder than a callback to
misuse, adding unpredictable latencies to unplug. The WQ can simply do
the cleanup directly, taking any locks it needs for that.  The cost is
several extra bytes per device, which seems modest.


Previous discussion:
https://lore.kernel.org/all/11cfcb55b5302999b0e58b94018f92a379196698.1751136072.git.mst@redhat.com

Changes from v3:
	added documentation to address comments by Parav
	support in virtio core
Changes from v2:
        v2 was corrupted, fat fingers :(
Changes from v1:
         switched to a WQ, with APIs to enable/disable
         added motivation

==========


Michael S. Tsirkin (5):
  pci: report surprise removal event
  virtio: fix comments, readability
  virtio: pack config changed flags
  virtio: allow transports to suppress config change
  virtio: support device disconnect

 drivers/pci/pci.h                  |  6 ++++
 drivers/virtio/virtio.c            | 23 +++++++++++++--
 drivers/virtio/virtio_pci_common.c | 45 ++++++++++++++++++++++++++++++
 drivers/virtio/virtio_pci_common.h |  3 ++
 drivers/virtio/virtio_pci_legacy.c |  2 ++
 drivers/virtio/virtio_pci_modern.c |  2 ++
 include/linux/pci.h                | 45 ++++++++++++++++++++++++++++++
 include/linux/virtio.h             | 11 ++++++--
 include/linux/virtio_config.h      | 32 +++++++++++++++++++++
 9 files changed, 163 insertions(+), 6 deletions(-)

-- 
MST

