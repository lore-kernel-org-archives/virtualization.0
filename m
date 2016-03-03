From: Liang Li <liang.z.li@intel.com>
Subject: [RFC kernel 0/2]A PV solution for KVM live migration optimization
Date: Thu,  3 Mar 2016 18:46:57 +0800
Message-ID: <1457002019-15998-1-git-send-email-liang.z.li__32286.5469301634$1457019676$gmane$org@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, linux-kernel@vger.kernel.org
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, Liang Li <liang.z.li@intel.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, amit.shah@redhat.com, pbonzini@redhat.com, akpm@linux-foundation.org, dgilbert@redhat.com, rth@twiddle.net
List-Id: virtualization@lists.linuxfoundation.org

The current QEMU live migration implementation mark the all the
guest's RAM pages as dirtied in the ram bulk stage, all these pages
will be processed and that takes quit a lot of CPU cycles.

From guest's point of view, it doesn't care about the content in free
pages. We can make use of this fact and skip processing the free
pages in the ram bulk stage, it can save a lot CPU cycles and reduce
the network traffic significantly while speed up the live migration
process obviously.

This patch set is the kernel side implementation.

It get the free pages information by traversing
zone->free_area[order].free_list, and construct a free pages bitmap.
The virtio-balloon driver is extended so as to send the free pages
bitmap to QEMU for live migration optimization.

Performance data
================

Test environment:

CPU: Intel (R) Xeon(R) CPU ES-2699 v3 @ 2.30GHz
Host RAM: 64GB
Host Linux Kernel:  4.2.0             Host OS: CentOS 7.1
Guest Linux Kernel:  4.5.rc6        Guest OS: CentOS 6.6
Network:  X540-AT2 with 10 Gigabit connection
Guest RAM: 8GB

Case 1: Idle guest just boots:
============================================
                    | original  |    pv    
-------------------------------------------
total time(ms)      |    1894   |   421
--------------------------------------------
transferred ram(KB) |   398017  |  353242
============================================


Case 2: The guest has ever run some memory consuming workload, the
workload is terminated just before live migration.
============================================
                    | original  |    pv    
-------------------------------------------
total time(ms)      |   7436    |   552
--------------------------------------------
transferred ram(KB) |  8146291  |  361375
============================================

Liang Li (2):
  mm: Add the functions used to get free pages information
  virtio-balloon: extend balloon driver to support a new feature

 drivers/virtio/virtio_balloon.c     | 108 ++++++++++++++++++++++++++++++++++--
 include/uapi/linux/virtio_balloon.h |   1 +
 mm/page_alloc.c                     |  58 +++++++++++++++++++
 3 files changed, 162 insertions(+), 5 deletions(-)

-- 
1.8.3.1
