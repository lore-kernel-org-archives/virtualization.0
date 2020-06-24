From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [GIT PULL] virtio: fixes, tests
Date: Wed, 24 Jun 2020 05:08:01 -0400
Message-ID: <20200624050801-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dan.carpenter@oracle.com, david@redhat.com, eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com, pankaj.gupta.linux@gmail.com, teawaterz@linux.alibaba.com
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

  Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to cb91909e48a4809261ef4e967464e2009b214f06:

  tools/virtio: Use tools/include/list.h instead of stubs (2020-06-22 12:34:22 -0400)

----------------------------------------------------------------
virtio: fixes, tests

Fixes all over the place.

This includes a couple of tests that I would normally defer,
but since they have already been helpful in catching some bugs,
don't build for any users at all, and having them
upstream makes life easier for everyone, I think it's
ok even at this late stage.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Dan Carpenter (2):
      vhost_vdpa: Fix potential underflow in vhost_vdpa_mmap()
      virtio-mem: silence a static checker warning

David Hildenbrand (1):
      virtio-mem: add memory via add_memory_driver_managed()

Eugenio Pérez (7):
      tools/virtio: Add --batch option
      tools/virtio: Add --batch=random option
      tools/virtio: Add --reset
      tools/virtio: Use __vring_new_virtqueue in virtio_test.c
      tools/virtio: Extract virtqueue initialization in vq_reset
      tools/virtio: Reset index in virtio_test --reset.
      tools/virtio: Use tools/include/list.h instead of stubs

Jason Wang (1):
      vdpa: fix typos in the comments for __vdpa_alloc_device()

 drivers/vdpa/vdpa.c         |   2 +-
 drivers/vhost/test.c        |  57 ++++++++++++++++++
 drivers/vhost/test.h        |   1 +
 drivers/vhost/vdpa.c        |   2 +-
 drivers/virtio/virtio_mem.c |  27 +++++++--
 tools/virtio/linux/kernel.h |   7 +--
 tools/virtio/linux/virtio.h |   5 +-
 tools/virtio/virtio_test.c  | 139 +++++++++++++++++++++++++++++++++++++-------
 tools/virtio/vringh_test.c  |   2 +
 9 files changed, 207 insertions(+), 35 deletions(-)
