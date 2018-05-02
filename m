From: Vladislav Yasevich <vyasevich@gmail.com>
Subject: [PATCH V2 net-next 0/6] virtio-net: Add SCTP checksum offload support
Date: Tue,  1 May 2018 22:07:33 -0400
Message-ID: <20180502020739.19239-1-vyasevic__28413.7842864313$1525226747$gmane$org@redhat.com>
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
To: netdev@vger.kernel.org
Cc: virtio-dev@lists.oasis-open.org, marcelo.leitner@gmail.com, nhorman@tuxdriver.com, mst@redhat.com, virtualization@lists.linux-foundation.org, linux-sctp@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Now that we have SCTP offload capabilities in the kernel, we can add
them to virtio as well.  First step is SCTP checksum.

We need a new freature in virtio to negotiate this support since
SCTP is excluded with the stardard checksum and requires a little
bit extra.  This series proposes VIRTIO_NET_F_SCTP_CSUM feature bit.

As the "little bit extra",  the kernel uses a new bit in the skb
(skb->csum_not_inet) to determine whether to use standard inet checksum
or the SCTP CRC32c checksum.  This bit has to be communicated between
the host and the guest.  This bit is carried in the vnet header.

Tap and macvtap support is added through an extra feature for the
TUNSETOFFLOAD ioctl.  Additionally macvtap will no correctly
do sctp checksumming if the receive doesn't support SCTP offload.
This also turns on sctp offloading for macvlan devices.

As for the perf numbers, I am seeing about a 5% increase in vm-to-vm
and vm-to-hos throughput which is the same as manually disabling
sctp checksumming,since this is exactly what we are emulatting.
Sending outside the host,  the increase about 2.5-3%.

Since v1:
  - Fixed some old patch bugs that snuck in.
  - virtio feature bits moved to high bits
  - distinguish between GUEST and HOST features
  - Fixed offload control command to control sctp checksum offload
  - added ipvlan support

Vladislav Yasevich (6):
  virtio: Add support for SCTP checksum offloading
  sctp: Handle sctp packets with CHECKSUM_PARTIAL
  sctp: Build sctp offload support into the base kernel
  tun: Add support for SCTP checksum offload
  macvlan/macvtap: Add support for SCTP checksum offload.
  ipvlan: Add support for SCTP checksum offload

 drivers/net/ipvlan/ipvlan_main.c |  3 ++-
 drivers/net/macvlan.c            |  5 +++--
 drivers/net/tap.c                |  8 +++++---
 drivers/net/tun.c                |  7 ++++++-
 drivers/net/virtio_net.c         | 14 +++++++++++++-
 include/linux/virtio_net.h       |  6 ++++++
 include/net/sctp/sctp.h          |  5 -----
 include/uapi/linux/if_tun.h      |  1 +
 include/uapi/linux/virtio_net.h  |  5 +++++
 net/Kconfig                      |  1 +
 net/sctp/Kconfig                 |  1 -
 net/sctp/Makefile                |  3 ++-
 net/sctp/input.c                 | 11 ++++++++++-
 net/sctp/offload.c               |  4 +++-
 net/sctp/protocol.c              |  3 ---
 15 files changed, 57 insertions(+), 20 deletions(-)

-- 
2.9.5
