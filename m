From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 0/1] mm: virtio-balloon fix to go through the -mm tree
Date: Wed, 11 Mar 2020 14:55:22 +0100
Message-ID: <20200311135523.18512-1-david@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtualization@lists.linux-foundation.org, Jason Wang <jasowang@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>, David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Michal Hocko <mhocko@kernel.org>, Nadav Amit <namit@vmware.com>, Tyler Sanderson <tysand@google.com>, Wei Wang <wei.w.wang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

@Andrew, as this fix is based on free page reporting, can this go through
your tree?

Patch #1 contains a proper description.

v3 -> v4:
- Add Ack from David Rientjes
- Minor tweaks to test details in the patch description

v2 -> v3:
- Use vb->vdev instead of vdev in all feature checks. We'll clean the
  other ones up later.
- Add one empty line virtballoon_probe() to make it look consistent.
- Drop one unrelated added line in virtballoon_remove()

v1 -> v2:
- Rebase on top of linux-next (free page reporting)
- Clarified some parts in the patch description and added testing
  instructions/results
- Added Fixes: and Tested-by:

David Hildenbrand (1):
  virtio-balloon: Switch back to OOM handler for
    VIRTIO_BALLOON_F_DEFLATE_ON_OOM

 drivers/virtio/virtio_balloon.c | 103 +++++++++++++++-----------------
 1 file changed, 47 insertions(+), 56 deletions(-)

--=20
2.24.1
