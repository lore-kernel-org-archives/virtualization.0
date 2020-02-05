From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 0/3] virtio-balloon: Fixes + switch back to OOM handler
Date: Wed,  5 Feb 2020 17:33:59 +0100
Message-ID: <20200205163402.42627-1-david@redhat.com>
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
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: linux-kernel@vger.kernel.org
Cc: Liang Li <liang.z.li@intel.com>, virtualization@lists.linux-foundation.org, Tyler Sanderson <tysand@google.com>, linux-mm@kvack.org, "Michael S. Tsirkin" <mst@redhat.com>, David Rientjes <rientjes@google.com>, Nadav Amit <namit@vmware.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Michal Hocko <mhocko@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Two fixes for issues I stumbled over while working on patch #3.

Switch back to the good ol' OOM handler for VIRTIO_BALLOON_F_DEFLATE_ON_OOM
as the switch to the shrinker introduce some undesired side effects. Keep
the shrinker in place to handle VIRTIO_BALLOON_F_FREE_PAGE_HINT.
Lengthy discussion under [1].

I tested with QEMU and "deflate-on-oom=on". Works as expected. Did not
test the shrinker for VIRTIO_BALLOON_F_FREE_PAGE_HINT, as it is
hard to trigger (only when migrating a VM, and even then, it might not
trigger).

[1] https://www.spinics.net/lists/linux-virtualization/msg40863.html

David Hildenbrand (3):
  virtio-balloon: Fix memory leak when unloading while hinting is in
    progress
  virtio_balloon: Fix memory leaks on errors in virtballoon_probe()
  virtio-balloon: Switch back to OOM handler for
    VIRTIO_BALLOON_F_DEFLATE_ON_OOM

 drivers/virtio/virtio_balloon.c | 124 +++++++++++++++-----------------
 1 file changed, 57 insertions(+), 67 deletions(-)

-- 
2.24.1
