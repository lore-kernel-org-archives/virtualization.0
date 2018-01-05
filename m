From: Jason Baron via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: [PATCH v4 0/3] virtio_net: allow hypervisor to indicate linkspeed and
	duplex setting
Date: Fri,  5 Jan 2018 17:44:52 -0500
Message-ID: <cover.1515190238.git.jbaron__41760.784170083$1515606830$gmane$org@akamai.com>
Reply-To: Jason Baron <jbaron@akamai.com>
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
Cc: virtio-dev@lists.oasis-open.org, netdev@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

We have found it useful to be able to set the linkspeed and duplex
settings from the host-side for virtio_net. This obviates the need
for guest changes and settings for these fields, and does not require
custom ethtool commands for virtio_net.

The ability to set linkspeed and duplex is useful in various cases
as described here:

16032be virtio_net: add ethtool support for set and get of settings

Using 'ethtool -s' continues to over-write the linkspeed/duplex
settings with this patch.

The 1/3 patch is against net-next, while the 2-3/3 patch are the associated
qemu changes that would go in after as update-linux-headers.sh should
be run first. So the qemu patches are a demonstration of how I intend this
to work.

Thanks,

-Jason

linux changes:

changes from v3:
* break the speed/duplex read into a function and also call from virtnet_probe
  when status bit is not negotiated
* only do speed/duplex read in virtnet_config_changed_work() on LINK_UP

changes from v2:
* move speed/duplex read into virtnet_config_changed_work() so link up changes
  are detected

Jason Baron (1):
  virtio_net: propagate linkspeed/duplex settings from the hypervisor

 drivers/net/virtio_net.c        | 23 ++++++++++++++++++++++-
 include/uapi/linux/virtio_net.h | 13 +++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)


qemu changes:

Jason Baron (2):
  qemu: virtio-net: use 64-bit values for feature flags
  qemu: add linkspeed and duplex settings to virtio-net

 hw/net/virtio-net.c                         | 87 ++++++++++++++++++++---------
 include/hw/virtio/virtio-net.h              |  5 +-
 include/standard-headers/linux/virtio_net.h | 13 +++++
 3 files changed, 77 insertions(+), 28 deletions(-)

-- 
2.6.1
