From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PULL] virtio
Date: Fri, 05 Oct 2012 11:09:51 +0930
Message-ID: <87bogh1yu0.fsf@rustcorp.com.au>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Kent Overstreet <koverstreet@google.com>, Peter Senna Tschudin <peter.senna@gmail.com>, virtualization@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Christoph Hellwig <hch@lst.de>, Alexey Khoroshilov <khoroshilov@ispras.ru>, Brian Foley <brian.foley@arm.com>, Shaohua Li <shli@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>, Pawel Moll <pawel.moll@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Amit Shah <amit.shah@redhat.com>, Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit 925a6f0bf8bd122d5d2429af7f0ca0fecf4ae71f:

  Merge tag 'hwspinlock-3.6-fix' of git://git.kernel.org/pub/scm/linux/kernel/git/ohad/hwspinlock (2012-09-18 11:58:54 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rusty/linux.git virtio-next

for you to fetch changes up to ca16f580a5db7e60bfafe59a50bb133bd3347491:

  lguest: fix occasional crash in example launcher. (2012-10-04 12:12:59 +0930)

----------------------------------------------------------------
New workflow: same git trees pulled by linux-next get sent straight to Linus.
Git is awkward at shuffling patches compared with quilt or mq, but that doesn't
happen often once things get into my -next branch.

----------------------------------------------------------------
Alexey Khoroshilov (1):
      virtio: console: fix error handling in init() function

Asias He (3):
      virtio-blk: Add bio-based IO path for virtio-blk
      virtio-blk: Add REQ_FLUSH and REQ_FUA support to bio path
      virtio-blk: Disable callback in virtblk_done()

Brian Foley (2):
      virtio_mmio: fix off by one error allocating queue
      virtio_mmio: Don't attempt to create empty virtqueues

Dan Carpenter (1):
      virtio-blk: fix NULL checking in virtblk_alloc_req()

Jason Wang (2):
      virtio-ring: move queue_index to vring_virtqueue
      virtio: introduce an API to set affinity for a virtqueue

Masami Hiramatsu (5):
      virtio/console: Add splice_write support
      virtio/console: Add a failback for unstealable pipe buffer
      virtio/console: Wait until the port is ready on splice
      ftrace: Allow stealing pages from pipe buffer
      virtio/console: Allocate scatterlist according to the current pipe size

Michael S. Tsirkin (3):
      virtio-balloon: dependency fix
      virtio: support reserved vqs
      virtio: don't crash when device is buggy

Peter Senna Tschudin (1):
      drivers/virtio/virtio_pci.c: fix error return code

Rusty Russell (4):
      virtio_balloon: not EXPERIMENTAL any more.
      virtio: add help to CONFIG_VIRTIO option.
      virtio: remove CONFIG_VIRTIO_RING
      lguest: fix occasional crash in example launcher.

Yoshihiro YUNOMAE (2):
      tools: Add guest trace agent as a user tool
      tools: Fix pthread flag for Makefile of trace-agent used by virtio-trace

 arch/s390/Kconfig                           |    1 -
 arch/x86/lguest/Kconfig                     |    1 -
 drivers/block/virtio_blk.c                  |  306 +++++++++++++++++++++++----
 drivers/char/virtio_console.c               |  210 ++++++++++++++++--
 drivers/lguest/lguest_device.c              |    5 +-
 drivers/remoteproc/remoteproc_virtio.c      |    5 +-
 drivers/rpmsg/Kconfig                       |    1 -
 drivers/s390/kvm/kvm_virtio.c               |    5 +-
 drivers/virtio/Kconfig                      |   17 +-
 drivers/virtio/Makefile                     |    3 +-
 drivers/virtio/virtio.c                     |    2 +-
 drivers/virtio/virtio_mmio.c                |   29 ++-
 drivers/virtio/virtio_pci.c                 |   68 +++++-
 drivers/virtio/virtio_ring.c                |   14 +-
 include/linux/virtio.h                      |    2 +
 include/linux/virtio_config.h               |   23 ++
 include/linux/virtio_ring.h                 |    3 +-
 kernel/trace/trace.c                        |    8 +-
 tools/lguest/lguest.c                       |    1 +
 tools/virtio/virtio-trace/Makefile          |   13 ++
 tools/virtio/virtio-trace/README            |  118 +++++++++++
 tools/virtio/virtio-trace/trace-agent-ctl.c |  137 ++++++++++++
 tools/virtio/virtio-trace/trace-agent-rw.c  |  192 +++++++++++++++++
 tools/virtio/virtio-trace/trace-agent.c     |  270 +++++++++++++++++++++++
 tools/virtio/virtio-trace/trace-agent.h     |   75 +++++++
 25 files changed, 1402 insertions(+), 107 deletions(-)
 create mode 100644 tools/virtio/virtio-trace/Makefile
 create mode 100644 tools/virtio/virtio-trace/README
 create mode 100644 tools/virtio/virtio-trace/trace-agent-ctl.c
 create mode 100644 tools/virtio/virtio-trace/trace-agent-rw.c
 create mode 100644 tools/virtio/virtio-trace/trace-agent.c
 create mode 100644 tools/virtio/virtio-trace/trace-agent.h
