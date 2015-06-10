From: Minchan Kim <minchan@kernel.org>
Subject: Re: [RFC 0/4] enable migration of non-LRU pages
Date: Wed, 10 Jun 2015 09:08:51 +0900
Message-ID: <20150610000850.GC13376@bgram>
References: <1433230065-3573-1-git-send-email-gioh.kim@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1433230065-3573-1-git-send-email-gioh.kim@lge.com>
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
Cc: akpm@linux-foundation.org, mst@redhat.com, gunho.lee@lge.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, bfields@fieldses.org, linux-mm@kvack.org, kirill@shutemov.name, iamjoonsoo.kim@lge.com, jlayton@poochiereds.net, vbabka@suse.cz
List-Id: virtualization@lists.linuxfoundation.org

Hello Gioh,

On Tue, Jun 02, 2015 at 04:27:40PM +0900, Gioh Kim wrote:
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
> The first this patch adds a generic isolate/migrate/putback callbacks for page
> address-space. The zram and GPU, and any other modules can register
> its own migration method. The kernel compaction can call the registered
> migration when it works. Therefore all page in the system can be migrated
> at once.
> 
> The 2nd the generic migration callbacks are applied into balloon driver.
> My gpu driver code is not open so I apply generic migration into balloon
> to show how it works. I've tested it with qemu enabled by kvm like followings:
> - turn on Ubuntu 14.04 with 1G memory on qemu.
> - do kernel building
> - after several seconds check more than 512MB is used with free command
> - command "balloon 512" in qemu monitor
> - check hundreds MB of pages are migrated
> 
> Next kernel compaction code can call generic migration callbacks instead of
> balloon driver interface.
> Finally calling migration of balloon driver is removed.

I didn't hava a time to review but it surely will help using zram with
CMA as well as fragmentation of the system memory via making zram objects
movable.

If it lands on mainline, I will work for zram object migration.

Thanks!
