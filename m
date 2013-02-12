From: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/9] virtio: new API for addition of buffers,
	scatterlist changes
Date: Tue, 12 Feb 2013 13:23:26 +0100
Message-ID: <1360671815-2135-1-git-send-email-pbonzini@redhat.com>
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
Cc: kvm@vger.kernel.org, mst@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Most device drivers do not need to perform any postprocessing on the
scatterlists they receive from higher-level drivers (e.g. the block
or SCSI layer), because they translate the request metadata directly
from the various C structs into the data that is required by the device.

virtio devices however do this translation in two steps: a device-specific
step in the device driver, and generic preparation of virtio direct or
indirect buffers in virtqueue_add_buf.  Now, virtqueue_add_buf also
accepts the outcome of the first step as a struct scatterlist, hence
the drivers may need to put additional items at the front or back of
the data scatterlists.

On top of this, virtqueue_add_buf also has the limitation of not
supporting chained scatterlists: the buffers must be provided as an
array of struct scatterlist.  Chained scatterlist would at least help
in the case where you have to add additional items at the front.

Because of this, virtio-scsi has to copy each request into a scatterlist
internal to the driver.  It cannot just use the one that was prepared
by the upper SCSI layers.  (virtio-blk has a little more flexibility in
that it handles itself the preparation of the scatterlist).

This series adds a different set of APIs for adding a buffer to a
virtqueue.  The new API lets you pass the buffers piecewise, wrapping
multiple calls to virtqueue_add_sg between virtqueue_start_buf and
virtqueue_end_buf.  Letting drivers call virtqueue_add_sg multiple times
if they already have a scatterlist provided by someone else simplifies the
code and, for virtio-scsi, it saves the copying and related locking.

One major difference between virtqueue_add_buf and virtqueue_add_sg
is that the latter uses scatterlist iterators, which follow chained
scatterlist structs and stop at ending markers.  In order to avoid code
duplication, and use the new API from virtqueue_add_buf (patch 8), we need
to change all existing callers of virtqueue_add_buf to provide well-formed
scatterlists.  This is what patches 2-7 do.  For virtio-blk it is easiest
to just switch to the new API, just like for virtio-scsi.  For virtio-net
the ending marker must be reset after calling virtqueue_add_buf, in
preparation for the next usage of the scatterlist.  Other drivers are
safe already, but many can be converted to the "fast-path" function
virtqueue_add_buf_single suggested by mst; this is done in patch 8.

Compared to the RFC, I have moved the state of virtqueue_add_sg into
struct vring_desc, and I replaced virtqueue_add_sg_single with
virtqueue_add_buf_single.  I renamed the "count" and "count_sg"
to "nents" and "nsg" following a suggestion of Stefan Hajnoczi.
And of course the patch is now well tested (including virtio-serial,
all three virtio-net receive paths, and virtio-blk SG_IO which I hadn't
checked for the RFC); anyway this did not bring in new code changes.

Ok for 3.9?

Paolo

Paolo Bonzini (9):
  virtio: add functions for piecewise addition of buffers
  virtio-blk: reorganize virtblk_add_req
  virtio-blk: use virtqueue_start_buf on bio path
  virtio-blk: use virtqueue_start_buf on req path
  scatterlist: introduce sg_unmark_end
  virtio-net: unmark scatterlist ending after virtqueue_add_buf
  virtio-scsi: use virtqueue_start_buf
  virtio: introduce and use virtqueue_add_buf_single
  virtio: reimplement virtqueue_add_buf using new functions

 block/blk-integrity.c               |    2 +-
 block/blk-merge.c                   |    2 +-
 drivers/block/virtio_blk.c          |  165 ++++++++-------
 drivers/char/hw_random/virtio-rng.c |    2 +-
 drivers/char/virtio_console.c       |    4 +-
 drivers/net/virtio_net.c            |   21 ++-
 drivers/rpmsg/virtio_rpmsg_bus.c    |    8 +-
 drivers/scsi/virtio_scsi.c          |  106 ++++------
 drivers/virtio/virtio_balloon.c     |    6 +-
 drivers/virtio/virtio_ring.c        |  396 ++++++++++++++++++++++-------------
 include/linux/scatterlist.h         |   16 ++
 include/linux/virtio.h              |   19 ++
 tools/virtio/virtio_test.c          |    6 +-
 13 files changed, 450 insertions(+), 303 deletions(-)
