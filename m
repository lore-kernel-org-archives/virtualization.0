From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH 0/6] vhost: Reset batched descriptors on SET_VRING_BASE call
Date: Sun, 29 Mar 2020 13:33:53 +0200
Message-ID: <20200329113359.30960-1-eperezma@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Halil Pasic <pasic@linux.ibm.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Vhost did not reset properly the batched descriptors on SET_VRING_BASE ev=
ent. Because of that, is possible to return an invalid descriptor to the =
guest.

This series ammend this, and creates a test to assert correct behavior. T=
o do that, they need to expose a new function in virtio_ring, virtqueue_r=
eset_free_head. Not sure if this can be avoided.

Also, change from https://lkml.org/lkml/2020/3/27/108 is not included, th=
at avoids to update a variable in a loop where it can be updated once.

This is meant to be applied on top of eccb852f1fe6bede630e2e4f1a121a81e34=
354ab in git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git, and some =
commits should be squashed with that series.

Eugenio P=C3=A9rez (6):
  tools/virtio: Add --batch option
  tools/virtio: Add --batch=3Drandom option
  tools/virtio: Add --reset=3Drandom
  tools/virtio: Make --reset reset ring idx
  vhost: Delete virtqueue batch_descs member
  fixup! vhost: batching fetches

 drivers/vhost/test.c         |  57 ++++++++++++++++
 drivers/vhost/test.h         |   1 +
 drivers/vhost/vhost.c        |  12 +++-
 drivers/vhost/vhost.h        |   1 -
 drivers/virtio/virtio_ring.c |  18 +++++
 include/linux/virtio.h       |   2 +
 tools/virtio/linux/virtio.h  |   2 +
 tools/virtio/virtio_test.c   | 123 +++++++++++++++++++++++++++++++----
 8 files changed, 201 insertions(+), 15 deletions(-)

--=20
2.18.1
