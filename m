From: Gioh Kim <gioh.kim@lge.com>
Subject: [RFCv2 0/5] enable migration of driver pages
Date: Fri, 26 Jun 2015 18:58:25 +0900
Message-ID: <1435312710-15108-1-git-send-email-gioh.kim__4521.38439654863$1435312640$gmane$org@lge.com>
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
To: jlayton@poochiereds.net, bfields@fieldses.org, vbabka@suse.cz, iamjoonsoo.kim@lge.com, viro@zeniv.linux.org.uk, mst@redhat.com, koct9i@gmail.com, minchan@kernel.org, aquini@redhat.com, linux-fsdevel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, Gioh Kim <gioh.kim@lge.com>
List-Id: virtualization@lists.linuxfoundation.org

Hello,

This series try to enable migration of non-LRU pages, such as driver's page.

My ARM-based platform occured severe fragmentation problem after long-term
(several days) test. Sometimes even order-3 page allocation failed. It has
memory size 512MB ~ 1024MB. 30% ~ 40% memory is consumed for graphic processing
and 20~30 memory is reserved for zram.

I found that many pages of GPU driver and zram are non-movable pages. So I
reported Minchan Kim, the maintainer of zram, and he made the internal 
compaction logic of zram. And I made the internal compaction of GPU driver.

They reduced some fragmentation but they are not enough effective.
They are activated by its own interface, /sys, so they are not cooperative
with kernel compaction. If there is too much fragmentation and kernel starts
to compaction, zram and GPU driver cannot work with the kernel compaction.

The first this patch adds a generic isolate/migrate/putback callbacks for page
address-space. The zram and GPU, and any other modules can register
its own migration method. The kernel compaction can call the registered
migration when it works. Therefore all page in the system can be migrated
at once.

The 2nd the generic migration callbacks are applied into balloon driver.
My gpu driver code is not open so I apply generic migration into balloon
to show how it works. I've tested it with qemu enabled by kvm like followings:
- turn on Ubuntu 14.04 with 1G memory on qemu.
- do kernel building
- after several seconds check more than 512MB is used with free command
- command "balloon 512" in qemu monitor
- check hundreds MB of pages are migrated

Next kernel compaction code can call generic migration callbacks instead of
balloon driver interface.
Finally calling migration of balloon driver is removed.

This patch-set is based on v4.1

Gioh Kim (5):
  mm/compaction: enable driver page migration
  fs/anon_inode: get a new inode
  mm/balloon: apply driver page migratable into balloon driver
  mm/compaction: compaction calls generic migration
  mm: remove direct calling of migration

 drivers/virtio/virtio_balloon.c        |  4 ++++
 fs/anon_inodes.c                       |  6 ++++++
 fs/proc/page.c                         |  3 +++
 include/linux/anon_inodes.h            |  1 +
 include/linux/balloon_compaction.h     | 33 +++++++++++++++++++++------------
 include/linux/compaction.h             | 11 +++++++++++
 include/linux/fs.h                     |  2 ++
 include/linux/page-flags.h             | 19 +++++++++++++++++++
 include/linux/pagemap.h                | 27 +++++++++++++++++++++++++++
 include/uapi/linux/kernel-page-flags.h |  2 +-
 mm/balloon_compaction.c                | 25 ++++++++++++++++---------
 mm/compaction.c                        |  9 +++++----
 mm/migrate.c                           | 24 ++++++------------------
 13 files changed, 122 insertions(+), 44 deletions(-)

-- 
1.9.1
