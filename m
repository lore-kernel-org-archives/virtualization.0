From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v3 0/1] s390: virtio: let arch choose to accept devices without IOMMU feature
Date: Wed, 17 Jun 2020 12:43:56 +0200
Message-ID: <1592390637-17441-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

An architecture protecting the guest memory against unauthorized host
access may want to enforce VIRTIO I/O device protection through the
use of VIRTIO_F_IOMMU_PLATFORM.

Let's give a chance to the architecture to accept or not devices
without VIRTIO_F_IOMMU_PLATFORM.

Pierre Morel (1):
  s390: virtio: let arch accept devices without IOMMU feature

 arch/s390/mm/init.c     |  6 ++++++
 drivers/virtio/virtio.c | 22 ++++++++++++++++++++++
 include/linux/virtio.h  |  2 ++
 3 files changed, 30 insertions(+)

-- 
2.25.1

Changelog

to v3:

- add warning
  (Connie, Christian)

- add comment
  (Connie)

- change hook name
  (Halil, Connie)

to v2:

- put the test in virtio_finalize_features()
  (Connie)

- put the test inside VIRTIO core
  (Jason)

- pass a virtio device as parameter
  (Halil)
