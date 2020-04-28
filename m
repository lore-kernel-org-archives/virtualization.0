From: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Subject: [PATCH 0/5] virtio on Type-1 hypervisor
Date: Tue, 28 Apr 2020 17:09:13 +0530
Message-ID: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: konrad.wilk@oracle.com, mst@redhat.com, jasowang@redhat.com, jan.kiszka@siemens.com, will@kernel.org, stefano.stabellini@xilinx.com
Cc: iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org, pratikp@codeaurora.org, vatsa@codeaurora.org, christoffer.dall@arm.com, alex.bennee@linaro.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

We ran into several problems in using virtio for IO paravirtualization on a
Type-1 hypervisor with these characteristics:

* By default, all of a guests's memory is private to it (no other guest can
  access its memory).

* One of the VM is considered as primary and has access to most IO devices. This
  is similar to dom0 VM in case of Xen. All other VMs are considered as
  secondary VMs

* virtio-backend drivers for all secondary VMs need to be hosted in primary VM

* Since secondary VM's memory is not accessible to primary VM, to make virtio
  backend driver work, instead an additional piece of memory is provisioned 
  by the hypervisor that is shared between primary and secondary VMs. This
  shared memory can be used, for example, to host virtio-ring structures
  and also to bounce IO buffers of secondary VM.

* Message-queue and doorbell interfaces available in hypervisor to support
  inter-VM communication. Messge-queue API (send/recv) allows one VM to send
  short messages to another VM. Doorbell interface allows a VM to inject
  an interrupt into another VM.

* No support for MMIO transport i.e hypervisor does not support trapping MMIO
  config space access by front-end driver and having it handled in backend
  drivers.

Few problem statements arising out of this:

1) How can we make use of the shared memory region effectively to make virtio
work in this scenario?

What is proposed in the patch series for this problem is a virtio bounce driver
that recognizes a shared memory region (shared between VMs) and makes use of
swiotlb driver interfaces to bounce IO buffers between private and shared space.
Some changes are proposed to swiotlb driver in this regard, that can let us
reuse swiotlb functions to work with the shared memory pool. swiotlb driver can
now recognize more than one pool of memory and extend its functions
(allocate/free/bounce memory chunks) for each pool.

2) What transport mechanism works best in this case? 

I realize that ivshmem2-virtio proposal has discussed the possibility of using
shared memory + doorbell as a virtio transport option. We can consider using
that as a transport in case it will be acceptable upstream. Other option we had
considered was to modify virtio_mmio.c itself to use message_queue send/recv
hypercall interface (in place of readl/writel). That could be abstracted via
'mmio_ops' structure providing suitable implementation of readl/writel. Another
option suggested by Christopher Dall is to unmap the config space from kernel
address space and as part of the fault handler, use hypervisor specific APIs to
achieve config space IO.

3) Which virtio backend drivers to leverage?

We realized there are multiple implementations of virtio backend drivers,
bundled as part of separate projects (Qemu, lkvm etc). We think it would be nice
if we had some consolidation in that regard so that we can make use of the
backend drivers that are not tightly coupled with a VMM. In our case, we need to
be able to run virtio backend drivers as standalone programs (and not coupled
with any VMM).


Srivatsa Vaddagiri (5):
  swiotlb: Introduce concept of swiotlb_pool
  swiotlb: Allow for non-linear mapping between paddr and vaddr
  swiotlb: Add alloc and free APIs
  swiotlb: Add API to register new pool
  virtio: Add bounce DMA ops

 drivers/virtio/Makefile        |   2 +-
 drivers/virtio/virtio.c        |   2 +
 drivers/virtio/virtio_bounce.c | 150 +++++++++++
 drivers/xen/swiotlb-xen.c      |   4 +-
 include/linux/swiotlb.h        | 157 +++++++++++-
 include/linux/virtio.h         |   4 +
 kernel/dma/swiotlb.c           | 556 ++++++++++++++++++++++++-----------------
 7 files changed, 638 insertions(+), 237 deletions(-)
 create mode 100644 drivers/virtio/virtio_bounce.c

-- 
2.7.4

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
