From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH v3 0/8] tools/vhost: Reset virtqueue on tests
Date: Sat, 18 Apr 2020 12:22:09 +0200
Message-ID: <20200418102217.32327-1-eperezma@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kvm list <kvm@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>
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

The first patch of this patchset ("vhost: Not cleaning batched descs in
VHOST_SET_VRING_BASE ioctl") should be squashed with ("vhost: batching
fetches") (currenlty, commit e7539c20a4a60b3a1bda3e7218c0d2a20669f357
in mst repository vhost branch).

Thanks!

Changes from v2:
* Squashed commits with fixes.
* Back to plain vring_*

Changes from v1:
* Different base, since branch was force-pushed.
* Using new vring_legacy_*, as base uses them now.

This serie is meant to be applied on top of
801f9bae9cf35b3192c3959d81a717e7985c64ed in
git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git.

Eugenio P=C3=A9rez (8):
  vhost: Not cleaning batched descs in VHOST_SET_VRING_BASE ioctl
  tools/virtio: Add --batch option
  tools/virtio: Add --batch=3Drandom option
  tools/virtio: Add --reset
  tools/virtio: Use __vring_new_virtqueue in virtio_test.c
  tools/virtio: Extract virtqueue initialization in vq_reset
  tools/virtio: Reset index in virtio_test --reset.
  tools/virtio: Use tools/include/list.h instead of stubs

 drivers/vhost/test.c        |  57 +++++++++++++++
 drivers/vhost/test.h        |   1 +
 drivers/vhost/vhost.c       |   1 -
 tools/virtio/linux/kernel.h |   7 +-
 tools/virtio/linux/virtio.h |   5 +-
 tools/virtio/virtio_test.c  | 139 ++++++++++++++++++++++++++++++------
 tools/virtio/vringh_test.c  |   2 +
 7 files changed, 182 insertions(+), 30 deletions(-)

--=20
2.18.1
