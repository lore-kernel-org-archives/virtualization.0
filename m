From: Wendy Liang <wendy.liang@xilinx.com>
Subject: [RFC LINUX PATCH 0/2] Virtio ring works with DMA coherent memory
Date: Tue, 6 Dec 2016 10:21:28 -0800
Message-ID: <1481048488-1026-1-git-send-email-jliang@xilinx.com>
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
To: ohad@wizery.com, bjorn.andersson@linaro.org, linux-remoteproc@vger.kernel.org, mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org
Cc: Wendy Liang <jliang@xilinx.com>
List-Id: virtualization@lists.linuxfoundation.org

RPMsg uses dma_alloc_coherent() to allocate memory to shared with the remote.
In this case, as there is no pages setup in the dma_alloc_coherent(),
we cannot get the physical address back from the virtual address, and thus,
we can set the sg_dma_addr to store the DMA address and mark it already DMA
mapped.

When virtio vring sees the sg_dma_addr is ready set, do not call dma_map_page().

The issue was once discussed here:
http://virtualization.linux-foundation.narkive.com/CfVP32Vy/rfc-0-4-rpmsg-fix-init-of-dma-able-virtqueues

Edgar E. Iglesias (1):
  rpmsg: DMA map sgs passed to virtio

Wendy Liang (1):
  virtio_ring: Do not call dma_map_page if sg is already mapped.

 drivers/rpmsg/virtio_rpmsg_bus.c | 22 +++++++++++++++++++---
 drivers/virtio/virtio_ring.c     |  6 ++++++
 2 files changed, 25 insertions(+), 3 deletions(-)

-- 
1.9.1
