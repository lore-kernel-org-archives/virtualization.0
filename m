From: Mike Waychison <mikew@google.com>
Subject: [RFC PATCH v1 0/2] virtio_net: Better low memory handling.
Date: Wed, 04 Jan 2012 14:52:26 -0800
Message-ID: <20120104225223.18184.1537.stgit__5202.11493499136$1325719052$gmane$org@mike2.sea.corp.google.com>
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
To: Rusty Russell <rusty@rustcorp.com.au>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The following series applies to net-next.

The following series changes the low memory paths in virtio_net to allow
the driver to contribute to reclaim when memory is tight.

It attempts to rectify some performance problems we've seen where the
network performance drops significantly when memory is low.  The working
theory is that while the driver contributes to memory pressure when
throughput is high, it does not contribute to reclaim when memory is
low.

The observed situation on an unmodified kernel is that a system with low
memory will in turn quickly stop being being able to refill the rx queue
with buffers, in turn causing packets to be dropped by the host OS while
the driver waits for somebody else to free up memory.  The way the
process-context refill loop works, the memory subsystem is effectively
polled every half second when things look bleak, leading to significant
packet loss and congestion window collapse.

The first patch rectifies the "not contributing to reclaim" by letting
the driver try to allocate as GFP_KERNEL when run from process context.

The second patch is a bit more complicated.  It essentially removes the
serialization that is currently in place built around enabling and
disabling napi polling, and replaces it by protecting the underlying
virtqueue accesses with a bottom-half spinlock.  As well, in order to
continue allocating as GFP_KERNEL in the slow path allocation of buffers
and adding them to the virtqueue for device use is split apart.  To try
and amortize the locking, batching is used.

This patchset seems to help the test setups that I'm playing with.
Example tests include using several bit-torrent clients within a VM and
watching the network throughputs on the host.  Other similar workloads
(high network traffic, reasonably high disk IO causing memory pressure)
also appear to have throughput problems alleviated by these changes.


As a warning, I've only really tested this using the "small buffers"
paths.  The devices I'm using do not yet support "mergeable" or "big"
receive buffers.
---

Mike Waychison (2):
      virtio_net: Pass gfp flags when allocating rx buffers.
      virtio_net: Don't disable napi on low memory.


 drivers/net/virtio_net.c |  213 +++++++++++++++++++++++++++++++++++-----------
 1 files changed, 162 insertions(+), 51 deletions(-)
