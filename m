From: Nadav Amit via Virtualization <virtualization@lists.linux-foundation.org>
Subject: [PATCH v4 0/4] vmw_balloon: Compaction and shrinker support
Date: Thu, 25 Apr 2019 04:54:41 -0700
Message-ID: <20190425115445.20815-1-namit__34439.0494910598$1556219738$gmane$org@vmware.com>
Reply-To: Nadav Amit <namit@vmware.com>
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
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "VMware, Inc." <pv-drivers@vmware.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Julien Freche <jfreche@vmware.com>, Nadav Amit <namit@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

VMware balloon enhancements: adding support for memory compaction,
memory shrinker (to prevent OOM) and splitting of refused pages to
prevent recurring inflations.

Patches 1-2: Support for compaction
Patch 3: Support for memory shrinker - disabled by default
Patch 4: Split refused pages to improve performance

v3->v4:
* "get around to" comment [Michael]
* Put list_add under page lock [Michael]

v2->v3:
* Fixing wrong argument type (int->size_t) [Michael]
* Fixing a comment (it) [Michael]
* Reinstating the BUG_ON() when page is locked [Michael] 

v1->v2:
* Return number of pages in list enqueue/dequeue interfaces [Michael]
* Removed first two patches which were already merged

Nadav Amit (4):
  mm/balloon_compaction: List interfaces
  vmw_balloon: Compaction support
  vmw_balloon: Add memory shrinker
  vmw_balloon: Split refused pages

 drivers/misc/Kconfig               |   1 +
 drivers/misc/vmw_balloon.c         | 489 ++++++++++++++++++++++++++---
 include/linux/balloon_compaction.h |   4 +
 mm/balloon_compaction.c            | 144 ++++++---
 4 files changed, 553 insertions(+), 85 deletions(-)

-- 
2.19.1
