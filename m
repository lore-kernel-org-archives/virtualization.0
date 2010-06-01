From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv3 0/2] virtio: put last seen used index into ring itself
Date: Tue, 1 Jun 2010 17:47:08 +0300
Message-ID: <cover.1275403477.git.mst@redhat.com>
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
To: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

Changes from v2: added padding between avail idx and flags,
and changed virtio to only publish used index when callbacks
are enabled.

Here's a rewrite of the original patch with a new layout.
I haven't tested it yet so no idea how this performs, but
I think this addresses the cache bounce issue raised by Avi.
Posting for early flames/comments.

Generally, the Host end of the virtio ring doesn't need to see where
Guest is up to in consuming the ring.  However, to completely understand
what's going on from the outside, this information must be exposed.
For example, host can reduce the number of interrupts by detecting
that the guest is currently handling previous buffers.

We add a feature bit so the guest can tell the host that it's writing
out the current value there, if it wants to use that.

This differs from original approach in that the used index
is put after avail index (they are typically written out together).
To avoid cache bounces on descriptor access,
and make future extensions easier, we put the ring itself at start of
page, and move the control after it.


Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


Michael S. Tsirkin (2):
  virtio: support layout with avail ring before idx
  virtio: publish used idx

 drivers/net/virtio_net.c     |    2 +
 drivers/virtio/virtio_ring.c |   25 +++++++++++++++------
 include/linux/virtio_ring.h  |   50 ++++++++++++++++++++++++++++++++++++-----
 3 files changed, 64 insertions(+), 13 deletions(-)
