From: "john.liuli" <john.liuli@huawei.com>
Subject: [RFC PATCH 0/2] virtio-mmio: add irqfd support for vhost-net based on
	virtio-mmio
Date: Sat, 25 Oct 2014 16:24:52 +0800
Message-ID: <1414225494-2208-1-git-send-email-john.liuli__28111.8890074596$1414417116$gmane$org@huawei.com>
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
To: linux-kernel@vger.kernel.org
Cc: joel.schopp@amd.com, yingshiuan.pan@gmail.com, mst@redhat.com, Li Liu <john.liuli@huawei.com>, remy.gauguey@cea.fr, qemu-devel@nongnu.org, n.nikolaev@virtualopensystems.com, virtualization@lists.linux-foundation.org, peter.huangpeng@huawei.com
List-Id: virtualization@lists.linuxfoundation.org

From: Li Liu <john.liuli@huawei.com>

This set of patches try to implemet irqfd support of vhost-net 
based on virtio-mmio.

I had posted a mail to talking about the status of vhost-net 
on kvm-arm refer to http://www.spinics.net/lists/kvm-arm/msg10804.html.
Some dependent patches are listed in the mail too. Basically the 
vhost-net brings great performance improvements, almost 50%+.

It's easy to implement irqfd support with PCI MSI-X. But till 
now arm32 do not provide equivalent mechanism to let a device 
allocate multiple interrupts. And even the aarch64 provid LPI
but also not available in a short time.

As Gauguey Remy said "Vhost does not emulate a complete virtio 
adapter but only manage virtqueue operations". Vhost module
don't update the ISR register, so if with only one irq then it's 
no way to get the interrupt reason even we can inject the 
irq correctly.  

To get the interrupt reason to support such VIRTIO_NET_F_STATUS 
features I add a new register offset VIRTIO_MMIO_ISRMEM which 
will help to establish a shared memory region between qemu and 
virtio-mmio device. Then the interrupt reason can be accessed by
guest driver through this region. At the same time, the virtio-mmio 
dirver check this region to see irqfd is supported or not during 
the irq handler registration, and different handler will be assigned.

I want to know it's the right direction? Does it comply with the 
virtio-mmio spec.? Or anyone have more good ideas to emulate mis-x 
based on virtio-mmio? I hope to get feedback and guidance.
Thx for any help.

Li Liu (2):
  Add a new register offset let interrupt reason available
  Assign a new irq handler while irqfd enabled

 drivers/virtio/virtio_mmio.c |   55 +++++++++++++++++++++++++++++++++++++++---
 include/linux/virtio_mmio.h  |    3 +++
 2 files changed, 55 insertions(+), 3 deletions(-)

-- 
1.7.9.5
