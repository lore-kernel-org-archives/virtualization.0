From: Rafael Aquini <aquini@redhat.com>
Subject: [PATCH v3 0/4] make balloon pages movable by compaction
Date: Tue,  3 Jul 2012 20:48:48 -0300
Message-ID: <cover.1341353014.git.aquini__14544.1223904074$1341359403$gmane$org@redhat.com>
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
To: linux-mm@kvack.org
Cc: Rik van Riel <riel@redhat.com>, Rafael Aquini <aquini@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Minchan Kim <minchan@kernel.org>, Andi Kleen <andi@firstfloor.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Memory fragmentation introduced by ballooning might reduce significantly
the number of 2MB contiguous memory blocks that can be used within a guest,
thus imposing performance penalties associated with the reduced number of
transparent huge pages that could be used by the guest workload.

This patchset follows the main idea discussed at 2012 LSFMMS section:
"Ballooning for transparent huge pages" -- http://lwn.net/Articles/490114/

to introduce the required changes to the virtio_balloon driver, as well as
changes to the core compaction & migration bits, in order to make those
subsystems aware of ballooned pages and allow memory balloon pages become
movable within a guest, thus avoiding the aforementioned fragmentation issue.


Rafael Aquini (4):
  mm: introduce compaction and migration for virtio ballooned pages
  virtio_balloon: handle concurrent accesses to virtio_balloon struct
    elements
  virtio_balloon: introduce migration primitives to balloon pages
  mm: add vm event counters for balloon pages compaction

 drivers/virtio/virtio_balloon.c |  142 +++++++++++++++++++++++++++++++++++----
 include/linux/mm.h              |   15 +++++
 include/linux/virtio_balloon.h  |    4 ++
 include/linux/vm_event_item.h   |    2 +
 mm/compaction.c                 |  127 ++++++++++++++++++++++++++++------
 mm/migrate.c                    |   32 ++++++++-
 mm/vmstat.c                     |    4 ++
 7 files changed, 293 insertions(+), 33 deletions(-)


Changelog:
V3: address reviwers nitpick suggestions (Mel, Minchan) 
V2: address Mel Gorman's review comments


Preliminary test results:
(2 VCPU 1024mB RAM KVM guest running 3.5.0_rc5+)

* 64mB balloon:
[root@localhost ~]# awk '/compact/ {print}' /proc/vmstat
compact_blocks_moved 0
compact_pages_moved 0
compact_pagemigrate_failed 0
compact_stall 0
compact_fail 0
compact_success 0
compact_balloon_migrated 0
compact_balloon_failed 0
compact_balloon_isolated 0
compact_balloon_freed 0
[root@localhost ~]#
[root@localhost ~]# for i in $(seq 1 4); do echo 1 > /proc/sys/vm/compact_memory & done &>/dev/null
[1]   Done                    echo 1 > /proc/sys/vm/compact_memory
[2]   Done                    echo 1 > /proc/sys/vm/compact_memory
[3]-  Done                    echo 1 > /proc/sys/vm/compact_memory
[4]+  Done                    echo 1 > /proc/sys/vm/compact_memory
[root@localhost ~]#
[root@localhost ~]# awk '/compact/ {print}' /proc/vmstat
compact_blocks_moved 2717
compact_pages_moved 46697
compact_pagemigrate_failed 75
compact_stall 0
compact_fail 0
compact_success 0
compact_balloon_migrated 16384
compact_balloon_failed 0
compact_balloon_isolated 16384
compact_balloon_freed 16384


* 128mB balloon:
[root@localhost ~]# awk '/compact/ {print}' /proc/vmstat
compact_blocks_moved 0
compact_pages_moved 0
compact_pagemigrate_failed 0
compact_stall 0
compact_fail 0
compact_success 0
compact_balloon_migrated 0
compact_balloon_failed 0
compact_balloon_isolated 0
compact_balloon_freed 0
[root@localhost ~]#
[root@localhost ~]# for i in $(seq 1 4); do echo 1 > /proc/sys/vm/compact_memory & done &>/dev/null
[1]   Done                    echo 1 > /proc/sys/vm/compact_memory
[2]   Done                    echo 1 > /proc/sys/vm/compact_memory
[3]-  Done                    echo 1 > /proc/sys/vm/compact_memory
[4]+  Done                    echo 1 > /proc/sys/vm/compact_memory
[root@localhost ~]#
[root@localhost ~]# awk '/compact/ {print}' /proc/vmstat
compact_blocks_moved 2598
compact_pages_moved 47660
compact_pagemigrate_failed 103
compact_stall 0
compact_fail 0
compact_success 0
compact_balloon_migrated 26652
compact_balloon_failed 76
compact_balloon_isolated 26728
compact_balloon_freed 26652
-- 
1.7.10.2
