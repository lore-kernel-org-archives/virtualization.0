From: Jason Wang <jasowang@redhat.com>
Subject: [RFC V3 0/5] Multiqueue support for tap and virtio-net/vhost
Date: Fri,  6 Jul 2012 17:31:05 +0800
Message-ID: <1341567070-14136-1-git-send-email-jasowang@redhat.com>
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
To: krkumar2@in.ibm.com, habanero@linux.vnet.ibm.com, aliguori@us.ibm.com, rusty@rustcorp.com.au, mst@redhat.com, mashirle@us.ibm.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, tahm@linux.vnet.ibm.com, jwhan@filewood.snu.ac.kr, akong@redhat.com
Cc: kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Hello all:

This seires is an update of last version of multiqueue support to add multiqueue
capability to both tap and virtio-net.

Some kinds of tap backends has (macvatp in linux) or would (tap) support
multiqueue. In such kind of tap backend, each file descriptor of a tap is a
qeueu and ioctls were prodived to attach an exist tap file descriptor to the
tun/tap device. So the patch let qemu to use this kind of backend, and let it
can transmit and receving packets through multiple file descriptors.

Patch 1 introduce a new help to get all matched options, after this patch, we
could pass multiple file descriptors to a signle netdev by:

      qemu -netdev tap,id=h0,queues=2,fd=10,fd=11 ...

Patch 2 introduce generic helpers in tap to attach or detach a file descriptor
from a tap device, emulated nics could use this helper to enable/disable queues.

Patch 3 modifies the NICState to allow multiple VLANClientState to be stored in
it, with this patch, qemu has basic support of multiple capable tap backend.

Patch 4 implement 1:1 mapping of tx/rx virtqueue pairs with vhost_net backend.

Patch 5 converts virtio-net to multiqueue device, after this patch, multiqueue
virtio-net device could be specified by:

      qemu -netdev tap,id=h0,queues=2 -device virtio-net-pci,netdev=h0,queues=2

Performace numbers:

I post them in the threads of RFC of multiqueue virtio-net driver:
http://www.spinics.net/lists/kvm/msg75386.html

Multiqueue with vhost shows improvemnt in TCP_RR, and degradate for small packet
transmission.

Changes from V2:
- split vhost patch from virtio-net
- add the support of queue number negotiation through control virtqueue
- hotplug, set_link and migration support
- bug fixes

Changes from V1:

- rebase to the latest
- fix memory leak in parse_netdev
- fix guest notifiers assignment/de-assignment
- changes the command lines to:
   qemu -netdev tap,queues=2 -device virtio-net-pci,queues=2

References:
- V2 http://www.spinics.net/lists/kvm/msg74588.html
- V1 http://comments.gmane.org/gmane.comp.emulators.qemu/100481

Jason Wang (5):
  option: introduce qemu_get_opt_all()
  tap: multiqueue support
  net: multiqueue support
  vhost: multiqueue support
  virtio-net: add multiqueue support

 hw/dp8393x.c         |    2 +-
 hw/mcf_fec.c         |    2 +-
 hw/qdev-properties.c |   34 +++-
 hw/qdev.h            |    3 +-
 hw/vhost.c           |   53 ++++--
 hw/vhost.h           |    2 +
 hw/vhost_net.c       |    7 +-
 hw/vhost_net.h       |    2 +-
 hw/virtio-net.c      |  505 ++++++++++++++++++++++++++++++++++----------------
 hw/virtio-net.h      |   12 ++
 net.c                |   83 +++++++--
 net.h                |   16 ++-
 net/tap-aix.c        |   13 ++-
 net/tap-bsd.c        |   13 ++-
 net/tap-haiku.c      |   13 ++-
 net/tap-linux.c      |   56 ++++++-
 net/tap-linux.h      |    4 +
 net/tap-solaris.c    |   13 ++-
 net/tap-win32.c      |   11 +
 net/tap.c            |  199 +++++++++++++-------
 net/tap.h            |    7 +-
 qemu-option.c        |   19 ++
 qemu-option.h        |    2 +
 23 files changed, 787 insertions(+), 284 deletions(-)
