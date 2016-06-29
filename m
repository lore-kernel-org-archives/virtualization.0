From: Liang Li <liang.z.li@intel.com>
Subject: [PATCH v2 kernel 0/7] Extend virtio-balloon for fast (de)inflating &
	fast live migration
Date: Wed, 29 Jun 2016 18:32:13 +0800
Message-ID: <1467196340-22079-1-git-send-email-liang.z.li@intel.com>
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
To: mst@redhat.com
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Liang Li <liang.z.li@intel.com>, qemu-devel@nongnu.org, dgilbert@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This patch set contains two parts of changes to the virtio-balloon. 

One is the change for speeding up the inflating & deflating process,
the main idea of this optimization is to use bitmap to send the page
information to host instead of the PFNs, to reduce the overhead of
virtio data transmission, address translation and madvise(). This can
help to improve the performance by about 85%.

Another change is for speeding up live migration. By skipping process
guest's free pages in the first round of data copy, to reduce needless
data processing, this can help to save quite a lot of CPU cycles and
network bandwidth. We put guest's free page information in bitmap and
send it to host with the virt queue of virtio-balloon. For an idle 8GB
guest, this can help to shorten the total live migration time from 2Sec
to about 500ms in the 10Gbps network environment.  


Changes from v1 to v2:
    * Abandon the patch for dropping page cache.
    * Put some structures to uapi head file.
    * Use a new way to determine the page bitmap size.
    * Use a unified way to send the free page information with the bitmap 
    * Address the issues referred in MST's comments

Liang Li (7):
  virtio-balloon: rework deflate to add page to a list
  virtio-balloon: define new feature bit and page bitmap head
  mm: add a function to get the max pfn
  virtio-balloon: speed up inflate/deflate process
  virtio-balloon: define feature bit and head for misc virt queue
  mm: add the related functions to get free page info
  virtio-balloon: tell host vm's free page info

 drivers/virtio/virtio_balloon.c     | 306 +++++++++++++++++++++++++++++++-----
 include/uapi/linux/virtio_balloon.h |  41 +++++
 mm/page_alloc.c                     |  52 ++++++
 3 files changed, 359 insertions(+), 40 deletions(-)

-- 
1.8.3.1
