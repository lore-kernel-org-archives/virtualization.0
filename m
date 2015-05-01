From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [RFC 0/4] rpmsg: Fix init of DMA:able virtqueues
Date: Fri,  1 May 2015 15:01:43 +1000
Message-ID: <1430456507-26862-1-git-send-email-edgar.iglesias@gmail.com>
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
To: virtualization@lists.linux-foundation.org
Cc: edgar.iglesias@xilinx.com, linux@arm.linux.org.uk, mst@redhat.com, michal.simek@xilinx.com, j.wu@xilinx.com
List-Id: virtualization@lists.linuxfoundation.org

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

I'm trying to run rpmsg and remoteproc on the ZynqMP (arm64) but I'm hitting
a DMA/mm error. The issue was discussed here:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/333050.html

Russel King pointed out that the arm64 is not doing anything wrong by
returning vmapped memory (which is incompatible with sg_phys()). Hence this
RFC series that tries to illustrate/fix the problem in rpmsg/virtio.

Is this going in the right direction?
Any ideas or suggestions on how to better fix this?

Something that worries me a little is that it would be nice if the DMA
capability for virtio protocols was not hardcoded like this but rather
somehow selectable by the framework. I was hoping that it would be possible
to use _any_ virtio based protocol to communicate with remote-proc/DMA and
not just rpmsg.

Thanks,
Edgar


Edgar E. Iglesias (4):
  virtio_ring: Break out vring descriptor setup code
  virtio_ring: Add option for DMA mapped sgs in virtqueue_add
  virtio: Add dma variants of virtqueue_add_in and outbuf
  rpmsg: DMA map sgs passed to virtio

 drivers/rpmsg/virtio_rpmsg_bus.c | 28 ++++++++++++++++-----
 drivers/virtio/virtio_ring.c     | 53 +++++++++++++++++++++++++++++++---------
 include/linux/virtio.h           | 10 ++++++++
 3 files changed, 74 insertions(+), 17 deletions(-)

-- 
1.9.1
