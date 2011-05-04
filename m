From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 00/18] virtio and vhost-net performance enhancements
Date: Wed, 4 May 2011 23:50:18 +0300
Message-ID: <cover.1304541918.git.mst__16147.4918634214$1304542292$gmane$org@redhat.com>
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
Cc: Krishna Kumar <krkumar2@in.ibm.com>, Carsten Otte <cotte@de.ibm.com>, lguest@lists.ozlabs.org, Shirley Ma <xma@us.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, habanero@linux.vnet.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, steved@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, Tom Lendacky <tahm@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

OK, here's a large patchset that implements the virtio spec update that I
sent earlier. It supercedes the PUBLISH_USED_IDX patches
I sent out earlier.

I know it's a lot to ask but please test, and please consider for 2.6.40 :)

I see nice performance improvements: one run showed going from 12
to 18 Gbit/s host to guest with netperf, but I did not spend a lot
of time testing performance, so no guarantees it's not a fluke,
I hope others will try this out and report.
Pls note I will be away from keyboard for the next week.

Essentially we change virtio ring notification
hand-off to work like the one in Xen -
each side publishes an event index, the other one
notifies when it reaches that value -
With the one difference that event index starts at 0,
same as request index (in xen event index starts at 1).

Each side of the handoff has a feature bit independent
of the other one, so we can have e.g. interrupts
handled in the new way and exits in the old one.

This is actually what made the patchset larger:
we run out of feature bits so I had to add some more.
I tested various combinations of hosts and guests and
this code seems to be solid.

With the indexes in place it becomes possbile to request an event after
many requests (and not just on the next one as done now). This shall fix
the TX queue overrun which currently triggers a storm of interrupts.

The patches are mostly independent and can also be cherry-picked,
hopefully there won't be much need of that.

One dependency I'd like to note is on two cleanup patches:
the patch removing batching of available index updates
and the patch fixing ring capability checks in virtio-net.
This simplified code a bit and made the following patch simpler.

I could unwrap the dependency but prefer as is.

The patchset is on top of net-next which at the time
I last rebased was 15ecd03 - so roughly 2.6.39-rc2.

qemu patch will follow shortly.

Rusty, I think (in the hope it will come to that) it will be easier to
merge vhost and virtio bits in one go. Can all go in through your tree
(Dave in the past acked a very similar patch so should not be a problem)
or from me to Dave Miller.

I see nice performance improvements: e.g. from 12 to 18 Gbit/s host
to guest with netperf, but did not spend a lot of time testing
performance, and I will be away from keyboard for the next week.
I hope others will try this out and report.

Michael S. Tsirkin (17):
  virtio: 64 bit features
  virtio_test: update for 64 bit features
  vhost: fix 64 bit features
  virtio: don't delay avail index update
  virtio: used event index interface
  virtio_ring: avail event index interface
  virtio ring: inline function to check for events
  virtio_ring: support for used_event idx feature
  virtio: use avail_event index
  vhost: utilize used_event index
  vhost: support avail_event idx
  virtio_test: support used_event index
  virtio_test: avail_event index support
  virtio: add api for delayed callbacks
  virtio_net: delay TX callbacks
  virtio_net: fix TX capacity checks using new API
  virtio_net: limit xmit polling

Shirley Ma (1):
  virtio_ring: Add capacity check API

 drivers/lguest/lguest_device.c |    8 +-
 drivers/net/virtio_net.c       |   25 ++++---
 drivers/s390/kvm/kvm_virtio.c  |    8 +-
 drivers/vhost/net.c            |   12 ++--
 drivers/vhost/test.c           |    6 +-
 drivers/vhost/vhost.c          |  139 ++++++++++++++++++++++++++++++----------
 drivers/vhost/vhost.h          |   30 ++++++---
 drivers/virtio/virtio.c        |    8 +-
 drivers/virtio/virtio_pci.c    |   34 ++++++++--
 drivers/virtio/virtio_ring.c   |  105 +++++++++++++++++++++++++++---
 include/linux/virtio.h         |   16 ++++-
 include/linux/virtio_config.h  |   15 +++--
 include/linux/virtio_pci.h     |    9 ++-
 include/linux/virtio_ring.h    |   30 ++++++++-
 tools/virtio/virtio_test.c     |   39 ++++++++++-
 15 files changed, 377 insertions(+), 107 deletions(-)

-- 
1.7.5.53.gc233e
