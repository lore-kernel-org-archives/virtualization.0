From: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Subject: [RFC/PATCH 0/1] virtio_mmio: hypervisor specific interfaces for MMIO
Date: Thu, 30 Apr 2020 15:32:55 +0530
Message-ID: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: konrad.wilk@oracle.com, mst@redhat.com, jasowang@redhat.com, jan.kiszka@siemens.com, will@kernel.org, stefano.stabellini@xilinx.com
Cc: iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org, pratikp@codeaurora.org, vatsa@codeaurora.org, christoffer.dall@arm.com, alex.bennee@linaro.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

The Type-1 hypervisor we are dealing with does not allow for MMIO transport. 
[1] summarizes some of the problems we have in making virtio work on such
hypervisors. This patch proposes a solution for transport problem viz how we can
do config space IO on such a hypervisor. Hypervisor specific methods
introduced allows for seamless IO of config space.

This patch is meant to seek comments. If its considered to be in right
direction, will work on making it more complete and send the next version!

1. https://lkml.org/lkml/2020/4/28/427

Srivatsa Vaddagiri (1):
  virtio: Introduce MMIO ops

 drivers/virtio/virtio_mmio.c | 131 ++++++++++++++++++++++++++-----------------
 include/linux/virtio.h       |  14 +++++
 2 files changed, 94 insertions(+), 51 deletions(-)

-- 
2.7.4

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
