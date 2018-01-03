From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Subject: [PATCH net-next 0/2] Enable virtio to act as a master for a passthru
	device
Date: Tue,  2 Jan 2018 16:35:36 -0800
Message-ID: <1514939738-22423-1-git-send-email-sridhar.samudrala__26294.23591211$1515606626$gmane$org@intel.com>
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
To: mst@redhat.com, stephen@networkplumber.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, sridhar.samudrala@intel.com
List-Id: virtualization@lists.linuxfoundation.org

This patch series enables virtio to switch over to a VF datapath when a VF
netdev is present with the same MAC address. It allows live migration of a VM
with a direct attached VF without the need to setup a bond/team between a
VF and virtio net device in the guest.

The hypervisor needs to unplug the VF device from the guest on the source
host and reset the MAC filter of the VF to initiate failover of datapath to
virtio before starting the migration. After the migration is completed, the
destination hypervisor sets the MAC filter on the VF and plugs it back to
the guest to switch over to VF datapath.

It is based on netvsc implementation and it may be possible to make this code 
generic and move it to a common location that can be shared by netvsc and virtio.

This patch series is based on the discussion initiated by Jesse on this thread.
https://marc.info/?l=linux-virtualization&m=151189725224231&w=2

Sridhar Samudrala (2):
  virtio_net: Introduce VIRTIO_NET_F_MASTER feature bit
  virtio_net: Extend virtio to use VF datapath when available

 drivers/net/virtio_net.c        | 308 +++++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/virtio_net.h |   1 +
 2 files changed, 306 insertions(+), 3 deletions(-)

-- 
2.14.3
