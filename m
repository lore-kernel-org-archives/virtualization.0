From: Cong Meng <mc@linux.vnet.ibm.com>
Subject: [PATCH 0/2] Hotplug support for virtio-scsi
Date: Wed, 20 Jun 2012 14:47:09 +0800
Message-ID: <cover.1340022196.git.mc__11613.9367608868$1340300234$gmane$org@linux.vnet.ibm.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: stefanha@linux.vnet.ibm.com, qemu-devel@nongnu.org, zwanp@cn.ibm.com, linuxram@us.ibm.com, senwang@linux.vnet.ibm.com, virtualization@lists.linux-foundation.org, Cong Meng <mc@linux.vnet.ibm.com>, Anthony Liguori <anthony@codemonkey.ws>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

These patches implement the hotplug support for virtio-scsi.
When a new device attaches/detaches to virtio-scsi bus via device_add/device_del
commands, the HBA driver in guest kernel will be signaled to add/remove the scsi
device.

Cong Meng (2):
  scsi bus: introduce hotplug() and hot_unplug() interfaces for SCSI bus
  virtio-scsi: Implement hotplug support for virtio-scsi

 hw/scsi-bus.c    |   16 +++++++++++-
 hw/scsi.h        |    2 +
 hw/virtio-scsi.c |   72 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 86 insertions(+), 4 deletions(-)

-- 
1.7.7
