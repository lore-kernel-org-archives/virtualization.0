From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH v2 0/8] tools/vhost: Reset virtqueue on tests
Date: Thu, 16 Apr 2020 09:56:35 +0200
Message-ID: <20200416075643.27330-1-eperezma@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>, Linux Next Mailing List <linux-next@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

This series add tests used to validate the "vhost: Reset batched
descriptors on SET_VRING_BASE call" series, with a few minor updates of
them.

They are based on the tests sent back them, the ones that were not
included (reasons in that thread). This series changes:

* Delete need to export the ugly function in virtio_ring, now all the
code is added in tools/virtio (except the one line fix).
* Add forgotten uses of vhost_vq_set_backend. Fix bad usage order in
vhost_test_set_backend.
* Drop random reset, not really needed.
* Minor changes.

This patchset commit messages contains references to commits under
"for_linus" tag and references to commits in for_linus..mst/vhost.
They are fixes, so probably it is better just to squash if possible:

("7c48601a3d4d tools/virtio: Add --reset=3Drandom"): Already in for_linus
("af3756cfed9a vhost: batching fetches"): Only in vhost branch, not in
for_linus.

Thanks!

Changes from v1:
* Different base, since branch was force-pushed.
* Using new vring_legacy_*, as base uses them now.

This serie is meant to be applied on top of
503b1b3efb47e267001beba8e0759c15fa3e9be7 in
git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git.

Eugenio P=C3=A9rez (8):
  tools/virtio: fix virtio_test.c indentation
  vhost: Not cleaning batched descs in VHOST_SET_VRING_BASE ioctl
  vhost: Replace vq->private_data access by backend accesors
  vhost: Fix bad order in vhost_test_set_backend at enable
  tools/virtio: Use __vring_new_virtqueue in virtio_test.c
  tools/virtio: Extract virtqueue initialization in vq_reset
  tools/virtio: Reset index in virtio_test --reset.
  tools/virtio: Use tools/include/list.h instead of stubs

 drivers/vhost/test.c        |  8 ++---
 drivers/vhost/vhost.c       |  1 -
 tools/virtio/linux/kernel.h |  7 +----
 tools/virtio/linux/virtio.h |  5 ++--
 tools/virtio/virtio_test.c  | 58 +++++++++++++++++++++++++++----------
 tools/virtio/vringh_test.c  |  2 ++
 6 files changed, 51 insertions(+), 30 deletions(-)

--=20
2.18.1
