From: Rafael Aquini <aquini@redhat.com>
Subject: Re: [RFCv3 0/5] enable migration of driver pages
Date: Wed, 8 Jul 2015 21:00:29 -0400
Message-ID: <20150709010028.GA25264__16136.0152801082$1436403654$gmane$org@t510.redhat.com>
References: <1436243785-24105-1-git-send-email-gioh.kim@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1436243785-24105-1-git-send-email-gioh.kim@lge.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gioh Kim <gioh.kim@lge.com>
Cc: akpm@linux-foundation.org, mst@redhat.com, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, bfields@fieldses.org, minchan@kernel.org, Gioh Kim <gurugio@hanmail.net>, linux-mm@kvack.org, viro@zeniv.linux.org.uk, gunho.lee@lge.com, linux-fsdevel@vger.kernel.org, jlayton@poochiereds.net, koct9i@gmail.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 07, 2015 at 01:36:20PM +0900, Gioh Kim wrote:
> From: Gioh Kim <gurugio@hanmail.net>
> 
> Hello,
> 
> This series try to enable migration of non-LRU pages, such as driver's page.
> 
> My ARM-based platform occured severe fragmentation problem after long-term
> (several days) test. Sometimes even order-3 page allocation failed. It has
> memory size 512MB ~ 1024MB. 30% ~ 40% memory is consumed for graphic processing
> and 20~30 memory is reserved for zram.
> 
> I found that many pages of GPU driver and zram are non-movable pages. So I
> reported Minchan Kim, the maintainer of zram, and he made the internal 
> compaction logic of zram. And I made the internal compaction of GPU driver.
> 
> They reduced some fragmentation but they are not enough effective.
> They are activated by its own interface, /sys, so they are not cooperative
> with kernel compaction. If there is too much fragmentation and kernel starts
> to compaction, zram and GPU driver cannot work with the kernel compaction.
> 
> This patch set combines 5 patches.
> 
> 1. patch 1/5: get inode from anon_inodes
> This patch adds new interface to create inode from anon_inodes.
> 
> 2. patch 2/5: framework to isolate/migrate/putback page
> Add isolatepage, putbackpage into address_space_operations
> and wrapper function to call them
> 
> 3. patch 3/5: apply the framework into balloon driver
> The balloon driver is applied into the framework. It gets a inode
> from anon_inodes and register operations in the inode.
> Any other drivers can register operations via inode like this
> to migrate it's pages.
> 
> 4. patch 4/5: compaction/migration call the generic interfaces
> Compaction and migration pages call the generic interfaces of the framework,
> instead of calling balloon migration directly.
> 
> 5. patch 5/5: remove direct calling of migration of driver pages
> Non-lru pages are migrated with lru pages by move_to_new_page().
> 
> This patch set is tested:
> - turn on Ubuntu 14.04 with 1G memory on qemu.
> - do kernel building
> - after several seconds check more than 512MB is used with free command
> - command "balloon 512" in qemu monitor
> - check hundreds MB of pages are migrated
> 
> My thanks to Konstantin Khlebnikov for his reviews of the v2 patch set.
> Most of the changes were based on his feedback.
> 
> Changes since v2:
> - change the name of page type from migratable page into mobile page
> - get and lock page to isolate page
> - add wrapper interfaces for page->mapping->a_ops->isolate/putback
> - leave balloon pages marked as balloon
> 
> This patch-set is based on v4.1
> 
> Gioh Kim (5):
>   fs/anon_inodes: new interface to create new inode
>   mm/compaction: enable mobile-page migration
>   mm/balloon: apply mobile page migratable into balloon
>   mm/compaction: call generic migration callbacks
>   mm: remove direct calling of migration
> 
>  drivers/virtio/virtio_balloon.c        |  3 ++
>  fs/anon_inodes.c                       |  6 +++
>  fs/proc/page.c                         |  3 ++
>  include/linux/anon_inodes.h            |  1 +
>  include/linux/balloon_compaction.h     | 15 +++++--
>  include/linux/compaction.h             | 76 ++++++++++++++++++++++++++++++++++
>  include/linux/fs.h                     |  2 +
>  include/linux/page-flags.h             | 19 +++++++++
>  include/uapi/linux/kernel-page-flags.h |  1 +
>  mm/balloon_compaction.c                | 71 ++++++++++---------------------
>  mm/compaction.c                        |  8 ++--
>  mm/migrate.c                           | 24 +++--------
>  12 files changed, 154 insertions(+), 75 deletions(-)
> 
> -- 
> 2.1.4
> 
Acked-by: Rafael Aquini <aquini@redhat.com>
