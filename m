From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv2 0/2] virtio-net: 64 bit features, event index
Date: Fri, 20 May 2011 02:24:00 +0300
Message-ID: <cover.1305846929.git.mst__47266.6056863547$1305848212$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: qemu-devel@nongnu.org
Cc: Krishna Kumar <krkumar2@in.ibm.com>, Carsten Otte <cotte@de.ibm.com>, lguest@lists.ozlabs.org, Shirley Ma <xma@us.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, habanero@linux.vnet.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, steved@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, Tom Lendacky <tahm@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

OK, here's a patch that implements the virtio spec update that I
sent earlier. It supercedes the PUBLISH_USED_IDX patches
I sent out earlier.

Support is added in both userspace and vhost-net.

If you see issues or are just curious, you can
turn the new feature off. For example:

-global virtio-net-pci.event_idx=on
-global virtio-blk-pci.event_idx=off

Also, it's possible to try both vhost-net and virtio-net.

Another part is adding support for 64 bit features in
place. The high bits are actually unused, to test
hack qemu to set some high bit.

linux code is here:
git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git vhost-net-next-event-idx-v3
git://git.kernel.org/pub/scm/linux/kernel/git/mst/qemu-kvm.git virtio-net-event-idx-v3


Changes from v1:
- unify used and avail ring handling in a single feature bit
- copy avail event idx fix from vhost-net

Michael S. Tsirkin (2):
  virtio/vhost: support 64 bit features
  virtio+vhost: event idx feature

 hw/qdev-properties.c   |   39 +++++++++++++---
 hw/qdev.h              |   10 ++++
 hw/s390-virtio-bus.c   |    5 +-
 hw/s390-virtio-bus.h   |    2 +-
 hw/syborg_virtio.c     |    7 ++-
 hw/vhost_net.c         |   14 ++++--
 hw/vhost_net.h         |    4 +-
 hw/virtio-9p.c         |    2 +-
 hw/virtio-balloon.c    |    2 +-
 hw/virtio-blk.c        |    2 +-
 hw/virtio-blk.h        |    2 +-
 hw/virtio-net.c        |   11 +++--
 hw/virtio-net.h        |   34 +++++++-------
 hw/virtio-pci.c        |   91 +++++++++++++++++++++++++++----------
 hw/virtio-serial-bus.c |    2 +-
 hw/virtio.c            |  116 ++++++++++++++++++++++++++++++++++++++++++------
 hw/virtio.h            |   24 +++++++---
 17 files changed, 275 insertions(+), 92 deletions(-)

-- 
1.7.5.53.gc233e
